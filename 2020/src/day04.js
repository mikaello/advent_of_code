/**
 * JAVASCRIPT ONLY THIS DAY
 */

const { readFileSync, read } = require("fs");

const passports = readFileSync("./day04.txt").toString().split("\n\n");

/*
byr (Birth Year)
iyr (Issue Year)
eyr (Expiration Year)
hgt (Height)
hcl (Hair Color)
ecl (Eye Color)
pid (Passport ID)
cid (Country ID)
*/

const containsAllFields = (passport) => {
  return (
    passport.includes("byr:") &&
    passport.includes("iyr:") &&
    passport.includes("eyr:") &&
    passport.includes("hgt:") &&
    passport.includes("hcl:") &&
    passport.includes("ecl:") &&
    passport.includes("pid:")
  );
};

/**
 * @param {string} passport
 */
const isValidPassport = (passport) => {
  let res = passport.match(/byr:(\d{4})\b/);
  const byr = res != null ? Number(res[1]) : 0;

  res = passport.match(/iyr:(\d{4})\b/);
  const iyr = res != null ? Number(res[1]) : 0;

  res = passport.match(/eyr:(\d{4})\b/);
  const eyr = res != null ? Number(res[1]) : 0;

  res = passport.match(/hgt:(\d{3})cm\b/);
  const hgtcm = res != null ? Number(res[1]) : 0;

  res = passport.match(/hgt:(\d{2})in\b/);
  const hgtin = res != null ? Number(res[1]) : 0;

  res = passport.match(/hcl:#([0-9a-f]{6})\b/);
  const hcl = res != null ? res[1] : null;

  res = passport.match(/ecl:(amb|blu|brn|gry|grn|hzl|oth)\b/);
  const ecl = res != null ? res[1] : null;

  res = passport.match(/pid:(\d{9})\b/);
  const pid = res != null ? res[1] : null;

  return (
    byr >= 1920 &&
    byr <= 2002 &&
    iyr >= 2010 &&
    iyr <= 2020 &&
    eyr >= 2020 &&
    eyr <= 2030 &&
    ((hgtcm != null && hgtcm >= 150 && hgtcm <= 193) ||
      (hgtin != null && hgtin >= 59 && hgtin <= 76)) &&
    hcl != null &&
    ecl != null &&
    pid != null
  );
};

console.log(passports.filter(containsAllFields).filter(isValidPassport).length);
