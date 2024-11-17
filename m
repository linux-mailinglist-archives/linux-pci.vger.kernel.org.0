Return-Path: <linux-pci+bounces-17008-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651F79D06AC
	for <lists+linux-pci@lfdr.de>; Sun, 17 Nov 2024 23:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75F11B21B79
	for <lists+linux-pci@lfdr.de>; Sun, 17 Nov 2024 22:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B05E1DD9AB;
	Sun, 17 Nov 2024 22:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LscnpwsP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808931DA2F1
	for <linux-pci@vger.kernel.org>; Sun, 17 Nov 2024 22:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731882522; cv=none; b=avgxzOzeA+kWQRTf7uGSAaABZmkN/XQytwvL94vMTp2H0H2lELtzWyHOc6xisv+NPHdfwb/VV3QdGy2SiEZe7X5rLwKPchtGVd89CeU9IcAi94NFJoXYuI550tNpdS5Kgnk63bnzgRgxhxPVJW4lA1A93oZ7c+nlAS3vDmFRSJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731882522; c=relaxed/simple;
	bh=tiN/IuqVF9gZE6QGcpuHXILG68nxltEgrS6thasveZk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=s4lcuJilccUHxM1/qdmFsu5t2MffdMfhFbgMgCKmBt0n6/ppg/B/fyk/Vn6zvmzJbSAP7apknrAXvRnv6TTaCtLNQt6c3MX5wn31kEVziu+pfMs9bxrUgDTQPct8cG4tmIWbyzY+JKAU+250yqsnS74MXtuWyyY+bdobq91fTOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LscnpwsP; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731882521; x=1763418521;
  h=date:from:to:cc:subject:message-id;
  bh=tiN/IuqVF9gZE6QGcpuHXILG68nxltEgrS6thasveZk=;
  b=LscnpwsPd9qHXnuWxTof8z9NHRB2DPEZRf5Tz/sAGaphiSSceoFobp9g
   W6CrzodL24zcoh+HzL+9W8XkxiSfI7hNHo9MEZA48G1Z9EtAcUk16wWrt
   UB6Gur+jmKn8kRKzF0xNyeVoQHAqNry2HJzMFC7O92r0+2yN3WS1Iaesh
   eyfK29r5FGdcxMfcFdD1z9vkfaXVJCoo3CXbRffGhRP+zvBKyir0CSofu
   E3sBOxnavV2u6ewQd8lHCGEO7jW531+pTh+3DP0Wb6CpMrePrWHUVBt/P
   7995w5+CunBrdulZYiEilluTgv6PA3E0HlNMExQo5RTpHeVFFpa0NR3SS
   g==;
X-CSE-ConnectionGUID: Q/ONw5aBRC+ClXX4+PqPdg==
X-CSE-MsgGUID: P6O03P+iSC2Q2KngdFRQuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="42347724"
X-IronPort-AV: E=Sophos;i="6.12,162,1728975600"; 
   d="scan'208";a="42347724"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2024 14:28:41 -0800
X-CSE-ConnectionGUID: IyG0f1UHSna52w2lZBWQng==
X-CSE-MsgGUID: yWSd97QiQxew52M60C314Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,162,1728975600"; 
   d="scan'208";a="93983985"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 17 Nov 2024 14:28:39 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCnky-00023x-2v;
	Sun, 17 Nov 2024 22:28:36 +0000
Date: Mon, 18 Nov 2024 06:27:55 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:pwrctrl] BUILD SUCCESS
 3b10a542d9144e560ba17949e71a4ec3217ef327
Message-ID: <202411180649.6tzH2Amc-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pwrctrl
branch HEAD: 3b10a542d9144e560ba17949e71a4ec3217ef327  PCI/pwrctrl: Rename pwrctrl functions and structures

elapsed time: 1844m

configs tested: 101
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20241118    gcc-13.2.0
arc                   randconfig-002-20241118    gcc-13.2.0
arm                               allnoconfig    clang-20
arm                            mmp2_defconfig    gcc-14.2.0
arm                       omap2plus_defconfig    gcc-14.2.0
arm                   randconfig-001-20241118    gcc-14.2.0
arm                   randconfig-002-20241118    gcc-14.2.0
arm                   randconfig-003-20241118    gcc-14.2.0
arm                   randconfig-004-20241118    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241118    clang-14
arm64                 randconfig-002-20241118    gcc-14.2.0
arm64                 randconfig-003-20241118    gcc-14.2.0
arm64                 randconfig-004-20241118    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241118    gcc-14.2.0
csky                  randconfig-002-20241118    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20241118    clang-20
hexagon               randconfig-002-20241118    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241118    gcc-12
i386        buildonly-randconfig-002-20241118    gcc-12
i386        buildonly-randconfig-003-20241118    clang-19
i386        buildonly-randconfig-004-20241118    clang-19
i386        buildonly-randconfig-005-20241118    gcc-12
i386        buildonly-randconfig-006-20241118    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241118    gcc-12
i386                  randconfig-002-20241118    gcc-12
i386                  randconfig-003-20241118    gcc-12
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241118    gcc-14.2.0
loongarch             randconfig-002-20241118    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          multi_defconfig    gcc-14.2.0
m68k                            q40_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241118    gcc-14.2.0
nios2                 randconfig-002-20241118    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241118    gcc-14.2.0
parisc                randconfig-002-20241118    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                   bluestone_defconfig    clang-20
powerpc                     rainier_defconfig    gcc-14.2.0
powerpc               randconfig-002-20241118    gcc-14.2.0
powerpc               randconfig-003-20241118    gcc-14.2.0
powerpc64             randconfig-001-20241118    clang-14
powerpc64             randconfig-002-20241118    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                               defconfig    clang-20
riscv                 randconfig-001-20241118    clang-14
riscv                 randconfig-002-20241118    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-20
s390                  randconfig-001-20241118    gcc-14.2.0
s390                  randconfig-002-20241118    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                        dreamcast_defconfig    gcc-14.2.0
sh                             espt_defconfig    gcc-14.2.0
sh                          kfr2r09_defconfig    gcc-14.2.0
sh                    randconfig-001-20241118    gcc-14.2.0
sh                    randconfig-002-20241118    gcc-14.2.0
sh                             shx3_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-002-20241118    gcc-14.2.0
um                                allnoconfig    clang-17
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

