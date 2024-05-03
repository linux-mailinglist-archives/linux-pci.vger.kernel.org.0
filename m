Return-Path: <linux-pci+bounces-7068-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8FC8BB823
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 01:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57C2282C47
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 23:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4217583A10;
	Fri,  3 May 2024 23:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ONC7ptl2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C88F83A0A
	for <linux-pci@vger.kernel.org>; Fri,  3 May 2024 23:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714778406; cv=none; b=EN3CiqiYOjLc6BrOnailwU2lVEjCmRtOE18zkM9JjeyyoOPz1w2QbczQHLxsx3smqhknEpwDbZwlSanJvC8jxNLeVFyDQ0mpV+tc9h4E0nfIsfuBZ+fpYfcPv94rgEiSva0Rc4wmiuRDbPH5YHyi76faxXtYNHsIMS/3SQDUATY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714778406; c=relaxed/simple;
	bh=gWB/fX54Ppnhl0MC92jaRDwrCtNAkNjY2BRSV7wrGJo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=m0RaWeC8WXGLJfiwHYyBR6R2vAVbmgZ9BWBLaNkbS0eT/+OluT0TKr6dgWoC1zYkVcVHAWo5APbhFXJ5fibdxpcvbJIx53eccjiiyxHCnuLtNbj0B1fs5eulX4bAyaV/QH6ftRvtE/NJfaJ8cGlwDDz/PvBXaabcOa9BYGdnYQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ONC7ptl2; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714778405; x=1746314405;
  h=date:from:to:cc:subject:message-id;
  bh=gWB/fX54Ppnhl0MC92jaRDwrCtNAkNjY2BRSV7wrGJo=;
  b=ONC7ptl2OVd9aYI6SacTwMnkTVKcTS9GvmLE2Biqdc9/dPkuB1wiJc3H
   M4KNcZiSXNepOOmER6+JjRbnTmLRO6qHuWSDiyIVFxsmadBePBgC2ypDb
   T5JB3ALQ3RnQXF974+Zv8uXIVkWGVgPmRCWZAX/jNR633y63YFcje6afY
   SglPpTctk9Rd60OKQkYaJcE0M8R//9WRBIGEwE3ptOinZmQASO6BKIPKl
   jwr8eVym1LBhRaOjWIVZMwvr72+bLr1yx9vm8OureeR0NBWdd4SJkYMqE
   v3YrpzIGpvkmBAIdH9ObieocrDR841EhloYVVw+B04Mr4EipsH72SNWYE
   g==;
X-CSE-ConnectionGUID: dqAaEWa1QGKW6whUju1pHA==
X-CSE-MsgGUID: OncqJaLuScCL1yQTDiP3RA==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="10726204"
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="10726204"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 16:20:04 -0700
X-CSE-ConnectionGUID: Raq1uLaTRhyoDeew8g3GOQ==
X-CSE-MsgGUID: mB8V5c41TL2U+IQvBeVflg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="27647243"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 03 May 2024 16:20:03 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s32C8-000CBM-0i;
	Fri, 03 May 2024 23:20:00 +0000
Date: Sat, 04 May 2024 07:19:30 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:of] BUILD SUCCESS
 e6f7d27df5d208b50cae817a91d128fb434bb12c
Message-ID: <202405040728.BXfNGdBi-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git of
branch HEAD: e6f7d27df5d208b50cae817a91d128fb434bb12c  PCI: of_property: Return error for int_map allocation failure

elapsed time: 1460m

configs tested: 179
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240503   gcc  
arc                   randconfig-001-20240504   gcc  
arc                   randconfig-002-20240503   gcc  
arc                   randconfig-002-20240504   gcc  
arc                           tb10x_defconfig   gcc  
arm                               allnoconfig   clang
arm                                 defconfig   clang
arm                        multi_v5_defconfig   gcc  
arm                   randconfig-004-20240503   gcc  
arm                         s3c6400_defconfig   gcc  
arm                           sama5_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240504   gcc  
arm64                 randconfig-002-20240503   gcc  
arm64                 randconfig-002-20240504   gcc  
arm64                 randconfig-003-20240504   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240503   gcc  
csky                  randconfig-001-20240504   gcc  
csky                  randconfig-002-20240503   gcc  
csky                  randconfig-002-20240504   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240503   clang
i386         buildonly-randconfig-001-20240504   clang
i386         buildonly-randconfig-002-20240503   clang
i386         buildonly-randconfig-004-20240504   clang
i386         buildonly-randconfig-005-20240504   clang
i386         buildonly-randconfig-006-20240503   clang
i386         buildonly-randconfig-006-20240504   clang
i386                                defconfig   clang
i386                  randconfig-002-20240503   clang
i386                  randconfig-002-20240504   clang
i386                  randconfig-003-20240503   clang
i386                  randconfig-004-20240504   clang
i386                  randconfig-005-20240503   clang
i386                  randconfig-005-20240504   clang
i386                  randconfig-006-20240503   clang
i386                  randconfig-011-20240503   clang
i386                  randconfig-012-20240504   clang
i386                  randconfig-013-20240504   clang
i386                  randconfig-016-20240503   clang
i386                  randconfig-016-20240504   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240503   gcc  
loongarch             randconfig-001-20240504   gcc  
loongarch             randconfig-002-20240503   gcc  
loongarch             randconfig-002-20240504   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240503   gcc  
nios2                 randconfig-001-20240504   gcc  
nios2                 randconfig-002-20240503   gcc  
nios2                 randconfig-002-20240504   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240503   gcc  
parisc                randconfig-001-20240504   gcc  
parisc                randconfig-002-20240503   gcc  
parisc                randconfig-002-20240504   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    ge_imp3a_defconfig   gcc  
powerpc                 mpc8313_rdb_defconfig   gcc  
powerpc               randconfig-001-20240504   gcc  
powerpc               randconfig-002-20240504   gcc  
powerpc               randconfig-003-20240503   gcc  
powerpc               randconfig-003-20240504   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240503   gcc  
riscv                 randconfig-001-20240504   gcc  
riscv                 randconfig-002-20240503   gcc  
riscv                 randconfig-002-20240504   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240503   gcc  
s390                  randconfig-002-20240503   gcc  
s390                  randconfig-002-20240504   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                    randconfig-001-20240503   gcc  
sh                    randconfig-001-20240504   gcc  
sh                    randconfig-002-20240503   gcc  
sh                    randconfig-002-20240504   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240503   gcc  
sparc64               randconfig-001-20240504   gcc  
sparc64               randconfig-002-20240503   gcc  
sparc64               randconfig-002-20240504   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240504   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-004-20240503   clang
x86_64       buildonly-randconfig-006-20240503   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240503   clang
x86_64                randconfig-002-20240503   clang
x86_64                randconfig-003-20240503   clang
x86_64                randconfig-006-20240503   clang
x86_64                randconfig-011-20240503   clang
x86_64                randconfig-012-20240503   clang
x86_64                randconfig-013-20240503   clang
x86_64                randconfig-014-20240503   clang
x86_64                randconfig-015-20240503   clang
x86_64                randconfig-016-20240503   clang
x86_64                randconfig-071-20240503   clang
x86_64                randconfig-072-20240503   clang
x86_64                randconfig-073-20240503   clang
x86_64                randconfig-074-20240503   clang
x86_64                randconfig-075-20240503   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20240503   gcc  
xtensa                randconfig-001-20240504   gcc  
xtensa                randconfig-002-20240503   gcc  
xtensa                randconfig-002-20240504   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

