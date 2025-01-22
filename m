Return-Path: <linux-pci+bounces-20241-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D046FA1930D
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 14:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2B343AD2C9
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 13:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288111E4AB;
	Wed, 22 Jan 2025 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oJ5aZ6tr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408902135C1
	for <linux-pci@vger.kernel.org>; Wed, 22 Jan 2025 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737553985; cv=none; b=jbkFk4NkrRNZH+QwrPjknzOjaGluXVQzWHesWmLeDf7fGEppI+myrM08FoW1m9jgnrmuFL9+UqtdNWBGiyKuy8dfbj976VNDH4yx8Gx0euLzbCd7HUe1tU9qvxpwH322B6er9wuyt7u5rIacUJlQdSvZ+TusdjdA5vYpwMqQ9Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737553985; c=relaxed/simple;
	bh=+0fZBaQxBo+lARs8voq7yOZKPATw2Q2lHj07tGeaX9A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fFV7X2hYtDWVpOSAFnagWEU11IJxs3gmrprIo0iMVKmfSI5rrz9CTtApwccbH/4ZpV7QTvZn7PvGW2IwWXm+OZUe8tAL0MW8PZ6if+X8KWGo3Y3DgdPCoWYqvQJEymiwy4ryj+YYC4YSD7qWm8bgZlwDj8HIqzUQ5TdVFryTkvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oJ5aZ6tr; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737553983; x=1769089983;
  h=date:from:to:cc:subject:message-id;
  bh=+0fZBaQxBo+lARs8voq7yOZKPATw2Q2lHj07tGeaX9A=;
  b=oJ5aZ6trUxLP+zpTCknCfSUHCpl48JHh0C0w8Nk8cIqOtcl1Y1cOSlot
   C60WvoA3umNVqmJPQnKf7Vx3opAM8u5Ztcm7NpTl6OzYFJ3UGBuQOjput
   9+B9QGnWer4pSquPklHnZQ7fEcgvffYa2RIsCnsdIgKxeWNP130DugpLp
   dWB/tQwFM1Kcijrx9pYYyKXLuIDxhfNX+fSseXc671p1CCgtmlqwP8qmA
   LmnOwqyVHw2rDqPb5OxEUF5HQKcCjlZ8bi1QSTkOr9ZgIkXUPI7j+vTxC
   7hvVVZM19j8sjUrK/zRVGTzGukjds9YmvNGj1//J1G13CIB8Gquw6luPs
   Q==;
X-CSE-ConnectionGUID: LduS+yjNRY2B3iDDubN8Zw==
X-CSE-MsgGUID: IbStsbdIRQ+yILtsX3Za4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="38179017"
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; 
   d="scan'208";a="38179017"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 05:53:03 -0800
X-CSE-ConnectionGUID: RUtIX4/uTu6XILlQ50QIpw==
X-CSE-MsgGUID: 1dPkJIlUQgWQxDeOYD9CJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; 
   d="scan'208";a="106953647"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 22 Jan 2025 05:53:01 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tabAB-000ZvB-0m;
	Wed, 22 Jan 2025 13:52:59 +0000
Date: Wed, 22 Jan 2025 21:52:34 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:switchtec] BUILD SUCCESS
 a3282f84b2151d254dc4abf24d1255c6382be774
Message-ID: <202501222128.mnfzOf1u-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git switchtec
branch HEAD: a3282f84b2151d254dc4abf24d1255c6382be774  PCI: switchtec: Add Microchip PCI100X device IDs

elapsed time: 1217m

configs tested: 165
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                        nsimosci_defconfig    gcc-13.2.0
arc                   randconfig-001-20250122    gcc-13.2.0
arc                   randconfig-002-20250122    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                         assabet_defconfig    clang-20
arm                         assabet_defconfig    gcc-14.2.0
arm                         at91_dt_defconfig    clang-20
arm                            hisi_defconfig    clang-20
arm                       imx_v6_v7_defconfig    clang-20
arm                        multi_v7_defconfig    gcc-14.2.0
arm                   randconfig-001-20250122    clang-19
arm                   randconfig-002-20250122    clang-20
arm                   randconfig-003-20250122    gcc-14.2.0
arm                   randconfig-004-20250122    gcc-14.2.0
arm                          sp7021_defconfig    clang-20
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250122    clang-20
arm64                 randconfig-002-20250122    clang-15
arm64                 randconfig-003-20250122    clang-20
arm64                 randconfig-004-20250122    clang-19
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250122    gcc-14.2.0
csky                  randconfig-002-20250122    gcc-14.2.0
hexagon                          alldefconfig    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20250122    clang-20
hexagon               randconfig-001-20250122    gcc-14.2.0
hexagon               randconfig-002-20250122    clang-20
hexagon               randconfig-002-20250122    gcc-14.2.0
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250122    clang-19
i386        buildonly-randconfig-001-20250122    gcc-12
i386        buildonly-randconfig-002-20250122    gcc-12
i386        buildonly-randconfig-003-20250122    gcc-12
i386        buildonly-randconfig-004-20250122    clang-19
i386        buildonly-randconfig-004-20250122    gcc-12
i386        buildonly-randconfig-005-20250122    clang-19
i386        buildonly-randconfig-005-20250122    gcc-12
i386        buildonly-randconfig-006-20250122    clang-19
i386        buildonly-randconfig-006-20250122    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250122    clang-19
i386                  randconfig-002-20250122    clang-19
i386                  randconfig-003-20250122    clang-19
i386                  randconfig-004-20250122    clang-19
i386                  randconfig-005-20250122    clang-19
i386                  randconfig-006-20250122    clang-19
i386                  randconfig-007-20250122    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250122    gcc-14.2.0
loongarch             randconfig-002-20250122    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm63xx_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250122    gcc-14.2.0
nios2                 randconfig-002-20250122    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250122    gcc-14.2.0
parisc                randconfig-002-20250122    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    clang-16
powerpc                     kmeter1_defconfig    gcc-14.2.0
powerpc                   motionpro_defconfig    clang-17
powerpc                       ppc64_defconfig    clang-20
powerpc               randconfig-001-20250122    gcc-14.2.0
powerpc               randconfig-002-20250122    clang-17
powerpc               randconfig-002-20250122    gcc-14.2.0
powerpc               randconfig-003-20250122    clang-15
powerpc               randconfig-003-20250122    gcc-14.2.0
powerpc                    sam440ep_defconfig    clang-20
powerpc                     tqm8560_defconfig    gcc-14.2.0
powerpc                         wii_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250122    clang-20
powerpc64             randconfig-001-20250122    gcc-14.2.0
powerpc64             randconfig-002-20250122    clang-19
powerpc64             randconfig-002-20250122    gcc-14.2.0
powerpc64             randconfig-003-20250122    clang-20
powerpc64             randconfig-003-20250122    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    clang-20
riscv                    nommu_virt_defconfig    clang-20
riscv                 randconfig-001-20250122    clang-20
riscv                 randconfig-002-20250122    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250122    clang-18
s390                  randconfig-002-20250122    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                            hp6xx_defconfig    gcc-14.2.0
sh                    randconfig-001-20250122    gcc-14.2.0
sh                    randconfig-002-20250122    gcc-14.2.0
sh                           se7705_defconfig    clang-20
sh                           se7712_defconfig    gcc-14.2.0
sh                             sh03_defconfig    clang-20
sh                           sh2007_defconfig    clang-20
sh                   sh7724_generic_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250122    gcc-14.2.0
sparc                 randconfig-002-20250122    gcc-14.2.0
sparc64               randconfig-001-20250122    gcc-14.2.0
sparc64               randconfig-002-20250122    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    gcc-12
um                    randconfig-001-20250122    gcc-12
um                    randconfig-002-20250122    clang-20
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250122    gcc-12
x86_64      buildonly-randconfig-002-20250122    clang-19
x86_64      buildonly-randconfig-003-20250122    gcc-12
x86_64      buildonly-randconfig-004-20250122    gcc-12
x86_64      buildonly-randconfig-005-20250122    gcc-12
x86_64      buildonly-randconfig-006-20250122    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250122    gcc-12
x86_64                randconfig-002-20250122    gcc-12
x86_64                randconfig-003-20250122    gcc-12
x86_64                randconfig-004-20250122    gcc-12
x86_64                randconfig-005-20250122    gcc-12
x86_64                randconfig-006-20250122    gcc-12
x86_64                randconfig-007-20250122    gcc-12
x86_64                randconfig-008-20250122    gcc-12
x86_64                randconfig-071-20250122    clang-19
x86_64                randconfig-072-20250122    clang-19
x86_64                randconfig-073-20250122    clang-19
x86_64                randconfig-074-20250122    clang-19
x86_64                randconfig-075-20250122    clang-19
x86_64                randconfig-076-20250122    clang-19
x86_64                randconfig-077-20250122    clang-19
x86_64                randconfig-078-20250122    clang-19
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250122    gcc-14.2.0
xtensa                randconfig-002-20250122    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

