Return-Path: <linux-pci+bounces-19230-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C83A00AC1
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 15:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55A36188431C
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 14:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCF11FA170;
	Fri,  3 Jan 2025 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jAXs+LVG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F48B1FA160
	for <linux-pci@vger.kernel.org>; Fri,  3 Jan 2025 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735915462; cv=none; b=f4qn4QzoPBtPW124IZpr1J7KB203I2JenpeaA0EiwdaVb8ec/jF7O54JCt+MzBo9eP2hp9ytpj3DMI0K1JoFBeDA5ISCKzF29imncjnrXri1tOmvc5ghq74EvHwvDB41XY+KPshY/zilD0X8eOKXhGcqF96ykdqGr8V11+haZwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735915462; c=relaxed/simple;
	bh=luyLL5wYdCXO55PcXQdRIG4tMHVxS7gu/xA7jZ9Lz+k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DhTqF7FTUe6c/5WU1k/LZC6A2tme8c07yyVGbY86lbI8IJ7ernfv5TSl7JP22Uxng8bij23hTwHAARNJBBPJeyFRrSd+cVoAKUeHyK68tsGq5Kt+OQ9cThZ1MaAsregz2jXVMF1c07MsZvUB1fLLCtZ0WLbvDxaA4fybRVZDK3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jAXs+LVG; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735915461; x=1767451461;
  h=date:from:to:cc:subject:message-id;
  bh=luyLL5wYdCXO55PcXQdRIG4tMHVxS7gu/xA7jZ9Lz+k=;
  b=jAXs+LVGDRwGxjyPjQVEE2PglaZzu1fCE1ruWCfWmI8JH/mwYYUPkxxl
   Vk4E3s9MA8hcbEmLkZOBDXDExClCUjuIXebpm77Kh/L5HdoLP5MTf7bI2
   MS7nc/A+y5ytjqGbCuExK8zZsaNfeG2rcs31Dk7PUSbbPLrkyifBQM8aD
   A0P7p9OtpTOMa9wKLm5s79M2fPeBLC0eX7Xhelr2kJ+U7oNQqMDjk/6KY
   APkU8RxDC5BueMrASLkYHYPX+y/leJvm6FzZXZUpZnSHX81ZoQDDLJKt6
   7PJWm3GqTX5cvNO7u4SX5+yTlqUPij2GOmIilaeIiicqQUiRevlYNHaEU
   Q==;
X-CSE-ConnectionGUID: /fFL4pFpQteoZceVeJJkpQ==
X-CSE-MsgGUID: 3ff4VFjDQYKdeAPhjMd+zQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11304"; a="47521259"
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="47521259"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 06:44:19 -0800
X-CSE-ConnectionGUID: hDoTniM+TU2fij8N9PzoOg==
X-CSE-MsgGUID: FYsBLRVhQySZKrNzHX9kEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="132727459"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 03 Jan 2025 06:44:18 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tTiuN-0009qh-1B;
	Fri, 03 Jan 2025 14:44:15 +0000
Date: Fri, 03 Jan 2025 22:43:28 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dt] BUILD SUCCESS
 5c3143465ce9ece5bd7a23a45a942a040b3f8f50
Message-ID: <202501032220.VSnAJaZh-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dt
branch HEAD: 5c3143465ce9ece5bd7a23a45a942a040b3f8f50  dt-bindings: PCI: mobiveil: Convert mobiveil-pcie.txt to yaml format

elapsed time: 901m

configs tested: 233
configs skipped: 8

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
arc                               allnoconfig    gcc-14.2.0
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
arm                               allnoconfig    gcc-14.2.0
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
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250103    clang-20
hexagon               randconfig-001-20250103    gcc-14.2.0
hexagon               randconfig-002-20250103    clang-20
hexagon               randconfig-002-20250103    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
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

