Return-Path: <linux-pci+bounces-26675-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C86A9A6E3
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 10:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 412E43B9F70
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 08:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036BA1B0F2C;
	Thu, 24 Apr 2025 08:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OnFeWcXb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CE91F03EC
	for <linux-pci@vger.kernel.org>; Thu, 24 Apr 2025 08:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745484531; cv=none; b=WtNtH/8DBDEvUCfjVxfZzaMYS8a1TKvM0cMj3CjPlK072GYOyiqYO7AkjaTruj2vr/+y9pcF3gsiQtsY3wkFcQTLE5HwmClMelevvFlTDon5bg3aai1l4/2Cl9Eqc+5LaWzN681KMjwDvThFzVm1X9+25fWgG+kYF2/jZ1l9UDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745484531; c=relaxed/simple;
	bh=TzuvBQbizIXV6hoetk+anlwRI0al/9TtE5xUcYkbvnE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WyK5W2NgJe+cC2ppkDEmErdxTVpmAgcS3Gv9p4eGiynLalyKL86pRQw1Y01wwFW2dfnJP/SdErNhJ+mJNZ645tKc/pBO8w/NQn1A1lnap5McDg5AuSQlEPEOXXGLzdXKAU0LW6C4WXe5HIxXmgQnDagwtNkcI4QPAc2RW7cHxRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OnFeWcXb; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745484531; x=1777020531;
  h=date:from:to:cc:subject:message-id;
  bh=TzuvBQbizIXV6hoetk+anlwRI0al/9TtE5xUcYkbvnE=;
  b=OnFeWcXbitRIsM1ca6fEdeDhaOqCqFegr6/iiAOuEpWE2jrzl2klP7um
   P5N5k8wpnHkTB5Woy5kJYrV02mt5+8JNNhludbRTHxYtbcp/HQnEkEH5+
   Aa1U8YUc5wfHixWsaccoZWXRQY5ggfhxT2AdVEDx51SJGNGIBsjDHb/z1
   1PjFzMaKdNfZJaBcXJ2YeKcqpFEc70ShoFizGALuaSTIx9qzhUwGTMKOp
   dDet1jzsHh8zrLHnoSzYpY6LjBfBLPzu7j1n7hDW+P6yidAmWUzC86OF/
   1sp1A5tQAFBWV8DeZV3j2h1GWzhNCe7ZtKuzP81+I8L+gOl7iEVfsX4OR
   Q==;
X-CSE-ConnectionGUID: MJx3cB5DTli9iXYPoo+Ppg==
X-CSE-MsgGUID: 47GXGQJ5QEOwHTns0WhlFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="64517707"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="64517707"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 01:48:50 -0700
X-CSE-ConnectionGUID: hg5Mord4RhmT4eiVWnQyZg==
X-CSE-MsgGUID: +acmCEihTHO/mkEpswh9HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="137347796"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 24 Apr 2025 01:48:49 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u7sGE-00040D-2E;
	Thu, 24 Apr 2025 08:48:46 +0000
Date: Thu, 24 Apr 2025 16:47:52 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/apple] BUILD SUCCESS
 4e639f11d6e06d9b33d29e0ae2c57b993b44ee48
Message-ID: <202504241642.MoOrLC6Z-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/apple
branch HEAD: 4e639f11d6e06d9b33d29e0ae2c57b993b44ee48  PCI: apple: Add T602x PCIe support

elapsed time: 1453m

configs tested: 130
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                        nsimosci_defconfig    gcc-14.2.0
arc                   randconfig-001-20250423    gcc-14.2.0
arc                   randconfig-002-20250423    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                         at91_dt_defconfig    clang-21
arm                   randconfig-001-20250423    gcc-10.5.0
arm                   randconfig-002-20250423    gcc-10.5.0
arm                   randconfig-003-20250423    gcc-7.5.0
arm                   randconfig-004-20250423    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250423    gcc-5.5.0
arm64                 randconfig-002-20250423    gcc-7.5.0
arm64                 randconfig-003-20250423    clang-17
arm64                 randconfig-004-20250423    gcc-7.5.0
csky                             alldefconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250423    gcc-13.3.0
csky                  randconfig-002-20250423    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250423    clang-21
hexagon               randconfig-002-20250423    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250423    gcc-12
i386        buildonly-randconfig-002-20250423    clang-20
i386        buildonly-randconfig-003-20250423    clang-20
i386        buildonly-randconfig-004-20250423    clang-20
i386        buildonly-randconfig-005-20250423    gcc-12
i386        buildonly-randconfig-006-20250423    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250423    gcc-14.2.0
loongarch             randconfig-002-20250423    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                        stmark2_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ci20_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250423    gcc-11.5.0
nios2                 randconfig-002-20250423    gcc-9.3.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250423    gcc-12.4.0
parisc                randconfig-002-20250423    gcc-12.4.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                       holly_defconfig    clang-21
powerpc                      pasemi_defconfig    clang-21
powerpc                      pmac32_defconfig    clang-21
powerpc               randconfig-001-20250423    gcc-9.3.0
powerpc               randconfig-002-20250423    clang-21
powerpc               randconfig-003-20250423    gcc-9.3.0
powerpc                     taishan_defconfig    clang-17
powerpc64             randconfig-001-20250423    gcc-5.5.0
powerpc64             randconfig-002-20250423    gcc-7.5.0
powerpc64             randconfig-003-20250423    clang-18
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250423    gcc-9.3.0
riscv                 randconfig-002-20250423    gcc-7.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250423    clang-21
s390                  randconfig-002-20250423    gcc-8.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                        edosk7760_defconfig    gcc-14.2.0
sh                             espt_defconfig    gcc-14.2.0
sh                          r7780mp_defconfig    gcc-14.2.0
sh                    randconfig-001-20250423    gcc-7.5.0
sh                    randconfig-002-20250423    gcc-13.3.0
sh                          sdk7780_defconfig    gcc-14.2.0
sh                           se7721_defconfig    gcc-14.2.0
sh                             sh03_defconfig    gcc-14.2.0
sh                   sh7770_generic_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250423    gcc-6.5.0
sparc                 randconfig-002-20250423    gcc-6.5.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250423    gcc-12.4.0
sparc64               randconfig-002-20250423    gcc-12.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250423    clang-21
um                    randconfig-002-20250423    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250423    gcc-12
x86_64      buildonly-randconfig-002-20250423    gcc-12
x86_64      buildonly-randconfig-003-20250423    gcc-12
x86_64      buildonly-randconfig-004-20250423    clang-20
x86_64      buildonly-randconfig-005-20250423    gcc-12
x86_64      buildonly-randconfig-006-20250423    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250423    gcc-8.5.0
xtensa                randconfig-002-20250423    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

