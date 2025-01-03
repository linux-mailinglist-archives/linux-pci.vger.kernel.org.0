Return-Path: <linux-pci+bounces-19225-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7E3A009EF
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 14:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AEAF7A175E
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 13:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE981E4AD;
	Fri,  3 Jan 2025 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NZWugBQD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9BC847B
	for <linux-pci@vger.kernel.org>; Fri,  3 Jan 2025 13:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735910893; cv=none; b=hhstYKZ6xOkXzXrZ8xao+0wyUhmcFaIzLY2zI7oQOI40K9WlT+VnLIWOBJKVV2RGUp+kgT7AmV+aaSrFVovBtVv1w3bYYT7Grx6XMDVWYg1sZ7cs8bwWb31QGvVZ+WRAhpXuNb7AqxxHCDen/fMyE9m5vSIrznrwaAAZiHzLa2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735910893; c=relaxed/simple;
	bh=uIrfXAJz5c+jLEgybdCYWfzwM/5jPtqC0tR/BWL02O4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nc7I8JC4VPp9MTjV4XdY7wOCLDgx0TjUBL6zvbuRkNiJEIWi5ELPB0K+9P05iMQkDrsj8bGzQJHHx5etw0yZn+O1X2zZskUYn5qe6vpJZdDCn5Km/D8fpyQpC5rJelBKeClp5+16i74gnj4NXkZlUu50fgzFHaY2V/kGMtkS0L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NZWugBQD; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735910891; x=1767446891;
  h=date:from:to:cc:subject:message-id;
  bh=uIrfXAJz5c+jLEgybdCYWfzwM/5jPtqC0tR/BWL02O4=;
  b=NZWugBQDPZACC7m1ylS+JlKLiC4zMOGx8I589IX71qe17qPjfZ8QvYRF
   v9NDyGtscGAoK+AGIzLmen+9tSp/58FT/Kuwyd00daxj1eMgPdnHSUt16
   laL2JZ0UQbFm0WlEWOZnevRd0x/jugCthjXnjW9caPFFIrjgKXHqbhKh2
   +A23N/pPswvw7F4YECPmL3AV7T3O6EZUsfzNiy6GJbqHrcr/mxAijcAbi
   EpUeKv0pTKaMl1nEVGxrWhwPdSVriTtokaP8OtcGzJdQh7RNnLq/dOw4k
   9xF4TNPpbjuLuQVlbsy6S1qTfZIVKLUEsky+Fcm6q8XLHJENU+fEfofkm
   A==;
X-CSE-ConnectionGUID: /lDqeuqhSCKG3i9u5tw4BA==
X-CSE-MsgGUID: Vgov9pqAS8CmdWqjWNgoJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11304"; a="47572530"
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="47572530"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 05:28:10 -0800
X-CSE-ConnectionGUID: vdjqu7IFSY+JwqCAwd2mlg==
X-CSE-MsgGUID: n/EYJjHmQAafp4WX+jKwYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="139125717"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 03 Jan 2025 05:28:09 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tThig-0009ln-35;
	Fri, 03 Jan 2025 13:28:06 +0000
Date: Fri, 03 Jan 2025 21:27:29 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 95227799c87fe31ea31e736c3cec035c9a7cdd61
Message-ID: <202501032116.VGP19SNW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 95227799c87fe31ea31e736c3cec035c9a7cdd61  Merge branch 'pci/misc'

elapsed time: 825m

configs tested: 229
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                     haps_hs_smp_defconfig    clang-20
arc                   randconfig-001-20250103    clang-20
arc                   randconfig-001-20250103    gcc-13.2.0
arc                   randconfig-002-20250103    clang-20
arc                   randconfig-002-20250103    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                     davinci_all_defconfig    clang-20
arm                                 defconfig    gcc-14.2.0
arm                   randconfig-001-20250103    clang-20
arm                   randconfig-002-20250103    clang-15
arm                   randconfig-002-20250103    clang-20
arm                   randconfig-003-20250103    clang-20
arm                   randconfig-003-20250103    gcc-14.2.0
arm                   randconfig-004-20250103    clang-20
arm                           stm32_defconfig    clang-20
arm                           u8500_defconfig    clang-20
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                            allyesconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250103    clang-19
arm64                 randconfig-001-20250103    clang-20
arm64                 randconfig-002-20250103    clang-20
arm64                 randconfig-003-20250103    clang-19
arm64                 randconfig-003-20250103    clang-20
arm64                 randconfig-004-20250103    clang-20
csky                             allmodconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                             allyesconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250103    gcc-14.2.0
csky                  randconfig-002-20250103    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250103    clang-20
hexagon               randconfig-001-20250103    gcc-14.2.0
hexagon               randconfig-002-20250103    clang-20
hexagon               randconfig-002-20250103    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250103    clang-19
i386        buildonly-randconfig-002-20250103    clang-19
i386        buildonly-randconfig-003-20250103    gcc-12
i386        buildonly-randconfig-004-20250103    clang-19
i386        buildonly-randconfig-005-20250103    clang-19
i386        buildonly-randconfig-006-20250103    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250103    clang-19
i386                  randconfig-002-20250103    clang-19
i386                  randconfig-003-20250103    clang-19
i386                  randconfig-004-20250103    clang-19
i386                  randconfig-005-20250103    clang-19
i386                  randconfig-006-20250103    clang-19
i386                  randconfig-007-20250103    clang-19
i386                  randconfig-011-20250103    gcc-12
i386                  randconfig-012-20250103    gcc-12
i386                  randconfig-013-20250103    gcc-12
i386                  randconfig-014-20250103    gcc-12
i386                  randconfig-015-20250103    gcc-12
i386                  randconfig-016-20250103    gcc-12
i386                  randconfig-017-20250103    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                        allyesconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250103    gcc-14.2.0
loongarch             randconfig-002-20250103    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                             allmodconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                             allyesconfig    gcc-14.2.0
mips                          ath79_defconfig    clang-20
mips                           ip22_defconfig    clang-20
mips                     loongson1b_defconfig    clang-20
mips                      maltaaprp_defconfig    clang-20
mips                       rbtx49xx_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250103    gcc-14.2.0
nios2                 randconfig-002-20250103    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250103    gcc-14.2.0
parisc                randconfig-002-20250103    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                          allyesconfig    gcc-14.2.0
powerpc                     ksi8560_defconfig    clang-20
powerpc                      ppc6xx_defconfig    clang-20
powerpc               randconfig-001-20250103    clang-17
powerpc               randconfig-001-20250103    gcc-14.2.0
powerpc               randconfig-002-20250103    clang-19
powerpc               randconfig-002-20250103    gcc-14.2.0
powerpc               randconfig-003-20250103    gcc-14.2.0
powerpc                    socrates_defconfig    clang-20
powerpc                     taishan_defconfig    clang-20
powerpc64             randconfig-001-20250103    clang-19
powerpc64             randconfig-001-20250103    gcc-14.2.0
powerpc64             randconfig-002-20250103    gcc-14.2.0
powerpc64             randconfig-003-20250103    clang-19
powerpc64             randconfig-003-20250103    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    clang-19
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250103    clang-20
riscv                 randconfig-002-20250103    clang-20
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                                defconfig    gcc-12
s390                  randconfig-001-20250103    clang-20
s390                  randconfig-001-20250103    gcc-14.2.0
s390                  randconfig-002-20250103    clang-20
s390                  randconfig-002-20250103    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                            hp6xx_defconfig    clang-20
sh                    randconfig-001-20250103    clang-20
sh                    randconfig-001-20250103    gcc-14.2.0
sh                    randconfig-002-20250103    clang-20
sh                    randconfig-002-20250103    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250103    clang-20
sparc                 randconfig-001-20250103    gcc-14.2.0
sparc                 randconfig-002-20250103    clang-20
sparc                 randconfig-002-20250103    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250103    clang-20
sparc64               randconfig-001-20250103    gcc-14.2.0
sparc64               randconfig-002-20250103    clang-20
sparc64               randconfig-002-20250103    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250103    clang-20
um                    randconfig-001-20250103    gcc-11
um                    randconfig-002-20250103    clang-20
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250103    clang-19
x86_64      buildonly-randconfig-001-20250103    gcc-12
x86_64      buildonly-randconfig-002-20250103    clang-19
x86_64      buildonly-randconfig-003-20250103    clang-19
x86_64      buildonly-randconfig-003-20250103    gcc-12
x86_64      buildonly-randconfig-004-20250103    clang-19
x86_64      buildonly-randconfig-005-20250103    clang-19
x86_64      buildonly-randconfig-006-20250103    clang-19
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250103    gcc-12
x86_64                randconfig-002-20250103    gcc-12
x86_64                randconfig-003-20250103    gcc-12
x86_64                randconfig-004-20250103    gcc-12
x86_64                randconfig-005-20250103    gcc-12
x86_64                randconfig-006-20250103    gcc-12
x86_64                randconfig-007-20250103    gcc-12
x86_64                randconfig-008-20250103    gcc-12
x86_64                randconfig-071-20250103    clang-19
x86_64                randconfig-072-20250103    clang-19
x86_64                randconfig-073-20250103    clang-19
x86_64                randconfig-074-20250103    clang-19
x86_64                randconfig-075-20250103    clang-19
x86_64                randconfig-076-20250103    clang-19
x86_64                randconfig-077-20250103    clang-19
x86_64                randconfig-078-20250103    clang-19
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250103    clang-20
xtensa                randconfig-001-20250103    gcc-14.2.0
xtensa                randconfig-002-20250103    clang-20
xtensa                randconfig-002-20250103    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

