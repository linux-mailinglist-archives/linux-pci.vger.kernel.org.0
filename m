Return-Path: <linux-pci+bounces-20182-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3FAA17D71
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 13:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5FE73A51D7
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 12:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D191A1F12E9;
	Tue, 21 Jan 2025 12:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gTGpKtQs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1789C1F03D5
	for <linux-pci@vger.kernel.org>; Tue, 21 Jan 2025 12:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737460930; cv=none; b=ticIj+1ScYRJH2Oragb0fcGfAGHEVeYDhAoGOPOqaSGUf2PpaYURPikkCViNHdNckKN6L/uj3+MBoY34NSwgYCM3eaaO4gTcukT6YJuknl7ai+l5vcHuPp00a/THhcAKd/ds6PQV72sVp+kAFSWgc4jamHnblfOlnGvbbFsqhp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737460930; c=relaxed/simple;
	bh=WqpcBZ/qLb6WNcT2R3bMSsBYI6HE8MkzvtvWQPJQEJM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=aAb1Oppp3LtNsd17ZRhuMOimAMJZ+5jZTJnh4tTFQlrJIj6wLmf6cf/LgAllLYZgkmXA9Q97egILR7gWvXSBS+89GdLDWTsgI3ZkjZk9WDCr15SzUtLlna7apqBOw6TTSPsZsaZDum+DyxZaSgNnANCr68EaalOxoiLaAdbF0oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gTGpKtQs; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737460929; x=1768996929;
  h=date:from:to:cc:subject:message-id;
  bh=WqpcBZ/qLb6WNcT2R3bMSsBYI6HE8MkzvtvWQPJQEJM=;
  b=gTGpKtQsrM4bDeqkQG7RW8KfUifayu2qIJrqUQroK6W+nqUcKy91jzXp
   UMHi38ZsEN/oSp3z1Z6ukHBSxf1livLLh6IGiJiZEgLXdOKgVdPd4EkTC
   KDqlPl+fDhM/NsobcXyT8wwUJ1vO331IUn9XpCa+9TSXLb76vqo/ms7sH
   Ay43al6MltKrokmeOewQWPOVYj7ARoazq/ONXLEjXe4kbqGWcyomDm9Qq
   XqqyzNSDnP7UNcxqve4TaOpOat/h91IARO1F2OaKZVMM2afgXqe7y5jVY
   dLm2+T3TPAwO4QlWnoU+/6+cAl+jMC2xoyvzlV51oPIng+qmrZCbewTI+
   w==;
X-CSE-ConnectionGUID: vvk5Sx0ZRM2pUGEH4Nu/5g==
X-CSE-MsgGUID: E49GXFVtS0uUVLfrAkKT4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="37783752"
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; 
   d="scan'208";a="37783752"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 04:02:08 -0800
X-CSE-ConnectionGUID: hDzzdfEvTZOkZZxNHyBCzw==
X-CSE-MsgGUID: muEdfAt7SBOHHtDduC6ZNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110844211"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 21 Jan 2025 04:02:07 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1taCxJ-000Y0U-0H;
	Tue, 21 Jan 2025 12:02:05 +0000
Date: Tue, 21 Jan 2025 20:02:03 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:enumeration] BUILD SUCCESS
 4e22263b7901cd5bfce86b6d2c44d71aa42a46cd
Message-ID: <202501212057.ozN1m7k5-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git enumeration
branch HEAD: 4e22263b7901cd5bfce86b6d2c44d71aa42a46cd  PCI: Batch BAR sizing operations

elapsed time: 781m

configs tested: 113
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              alldefconfig    gcc-13.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                 nsimosci_hs_smp_defconfig    gcc-13.2.0
arc                   randconfig-001-20250121    gcc-13.2.0
arc                   randconfig-002-20250121    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250121    clang-18
arm                   randconfig-002-20250121    gcc-14.2.0
arm                   randconfig-003-20250121    gcc-14.2.0
arm                   randconfig-004-20250121    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250121    gcc-14.2.0
arm64                 randconfig-002-20250121    gcc-14.2.0
arm64                 randconfig-003-20250121    gcc-14.2.0
arm64                 randconfig-004-20250121    clang-18
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250121    gcc-14.2.0
csky                  randconfig-002-20250121    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20250121    clang-19
hexagon               randconfig-002-20250121    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250121    gcc-12
i386        buildonly-randconfig-002-20250121    clang-19
i386        buildonly-randconfig-003-20250121    gcc-12
i386        buildonly-randconfig-004-20250121    gcc-12
i386        buildonly-randconfig-005-20250121    gcc-12
i386        buildonly-randconfig-006-20250121    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250121    gcc-14.2.0
loongarch             randconfig-002-20250121    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250121    gcc-14.2.0
nios2                 randconfig-002-20250121    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250121    gcc-14.2.0
parisc                randconfig-002-20250121    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                     mpc512x_defconfig    clang-20
powerpc                     ppa8548_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250121    clang-20
powerpc               randconfig-002-20250121    gcc-14.2.0
powerpc               randconfig-003-20250121    gcc-14.2.0
powerpc64             randconfig-001-20250121    gcc-14.2.0
powerpc64             randconfig-002-20250121    clang-20
powerpc64             randconfig-003-20250121    clang-16
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                 randconfig-001-20250121    gcc-14.2.0
riscv                 randconfig-002-20250121    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250121    clang-15
s390                  randconfig-002-20250121    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                             espt_defconfig    gcc-14.2.0
sh                    randconfig-001-20250121    gcc-14.2.0
sh                    randconfig-002-20250121    gcc-14.2.0
sh                          rsk7201_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250121    gcc-14.2.0
sparc                 randconfig-002-20250121    gcc-14.2.0
sparc                       sparc64_defconfig    gcc-14.2.0
sparc64               randconfig-001-20250121    gcc-14.2.0
sparc64               randconfig-002-20250121    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250121    clang-16
um                    randconfig-002-20250121    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250121    gcc-12
x86_64      buildonly-randconfig-002-20250121    clang-19
x86_64      buildonly-randconfig-003-20250121    gcc-12
x86_64      buildonly-randconfig-004-20250121    clang-19
x86_64      buildonly-randconfig-005-20250121    clang-19
x86_64      buildonly-randconfig-006-20250121    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250121    gcc-14.2.0
xtensa                randconfig-002-20250121    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

