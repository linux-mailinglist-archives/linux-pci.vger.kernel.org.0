Return-Path: <linux-pci+bounces-42592-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE24CA1A61
	for <lists+linux-pci@lfdr.de>; Wed, 03 Dec 2025 22:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C03830021E0
	for <lists+linux-pci@lfdr.de>; Wed,  3 Dec 2025 21:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E772F2D6E59;
	Wed,  3 Dec 2025 21:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fLaUYBT1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2AD3002B6
	for <linux-pci@vger.kernel.org>; Wed,  3 Dec 2025 21:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764796541; cv=none; b=ZKshhLplZm4LEG1dAHgjubAWGmPXan1At0YQxeYjxVORIH5WwBSdmdDjhAGP68K3CiK/UrztohH6zynMrNG7aKqtks6+khPyag2GYEzM1PLZ9cOfD4mYC3iwYDbAPICy2x/I2CUA2sPHQKMmIB30hilPJ7fEkIgUMSpdUeXbWkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764796541; c=relaxed/simple;
	bh=z8GIEenkOZBUbb1fFiHuFDlsm2DVbJrs6FPFoaOd8wM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=K9R0R3Pr5pT82xEqUE0snEubhUEONlaNTEK6gfWcYfng463yu4j72/R0MHGcUwq+DF31nhObNZe4DROpCteAeWVIU9amhtQ5TH+ooork6sHbZKCz80qMadVAeQ1ygTkP98xuuO6womPd+8Xt0VhI62Q4We2T7PWpyOTuc6bDSYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fLaUYBT1; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764796537; x=1796332537;
  h=date:from:to:cc:subject:message-id;
  bh=z8GIEenkOZBUbb1fFiHuFDlsm2DVbJrs6FPFoaOd8wM=;
  b=fLaUYBT1/yIuRV687EvDrLPM6OGGSQ4r2rsX3bwAo1Y4UVFlDfXUcVIV
   weQMXU25A2ofF8I4/zTMUJcnPdoMWCSBGWvrxo8vC0H92s+PXFgUrTuor
   KBEb1i9TMOL220TGgpYbCNHwKvuNl8adE4eRe9dvIkTdeKjycyDieTpuQ
   YyRBTwkn3R1S9PhjgnDcPfLoXhxEW7QNUoSfwBkvUv7gjUqRsQp/45AW4
   PB7jdaDf/BcZmROn1qm5VQLtBSsYRxiH5fNX3cK1RmgAIjbsTkA1R1FXs
   /jxVYcyECOjtbBdncx5gjRQQJrbT/YFPTRuyOK2fQ0toB6x19N1Q3ZSRh
   Q==;
X-CSE-ConnectionGUID: okykK8i9SLyLmLKxXxtwDw==
X-CSE-MsgGUID: 3m+5esiHQ3ib2Gx1fNEYpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="89455816"
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="scan'208";a="89455816"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 13:15:34 -0800
X-CSE-ConnectionGUID: kniB/PBYRVSHavYDATNjBA==
X-CSE-MsgGUID: MwFwF0IMSO+jANbgI2Xjhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="scan'208";a="232126215"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 03 Dec 2025 13:15:33 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vQuCA-00000000D9J-3HWv;
	Wed, 03 Dec 2025 21:15:30 +0000
Date: Thu, 04 Dec 2025 05:15:16 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 7eba05e79ca20b7169bf25da1e6cac1d31269f90
Message-ID: <202512040510.5rhUWnII-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc
branch HEAD: 7eba05e79ca20b7169bf25da1e6cac1d31269f90  MAINTAINERS: Add Manivannan Sadhasivam as PCI/pwrctrl maintainer

elapsed time: 1447m

configs tested: 133
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251203    gcc-9.5.0
arc                   randconfig-002-20251203    gcc-11.5.0
arm                        clps711x_defconfig    clang-22
arm                                 defconfig    clang-22
arm                   randconfig-001-20251203    gcc-8.5.0
arm                   randconfig-002-20251203    clang-22
arm                   randconfig-003-20251203    clang-22
arm                   randconfig-004-20251203    clang-22
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251203    gcc-8.5.0
arm64                 randconfig-002-20251203    clang-17
arm64                 randconfig-003-20251203    gcc-8.5.0
arm64                 randconfig-004-20251203    gcc-8.5.0
csky                             allmodconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251203    gcc-15.1.0
csky                  randconfig-002-20251203    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251203    clang-22
hexagon               randconfig-002-20251203    clang-20
i386                             allmodconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251203    gcc-14
i386        buildonly-randconfig-002-20251203    gcc-14
i386        buildonly-randconfig-003-20251203    gcc-14
i386        buildonly-randconfig-004-20251203    clang-20
i386        buildonly-randconfig-005-20251203    clang-20
i386        buildonly-randconfig-006-20251203    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251203    clang-20
i386                  randconfig-002-20251203    gcc-14
i386                  randconfig-003-20251203    clang-20
i386                  randconfig-004-20251203    clang-20
i386                  randconfig-005-20251203    gcc-14
i386                  randconfig-006-20251203    gcc-14
i386                  randconfig-007-20251203    gcc-14
i386                  randconfig-011-20251203    clang-20
i386                  randconfig-012-20251203    gcc-14
i386                  randconfig-013-20251203    clang-20
i386                  randconfig-014-20251203    gcc-14
i386                  randconfig-015-20251203    gcc-13
i386                  randconfig-016-20251203    clang-20
i386                  randconfig-017-20251203    clang-20
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251203    gcc-15.1.0
loongarch             randconfig-002-20251203    gcc-14.3.0
m68k                             allmodconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251203    gcc-9.5.0
nios2                 randconfig-002-20251203    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                generic-32bit_defconfig    gcc-15.1.0
parisc                generic-64bit_defconfig    gcc-15.1.0
parisc                randconfig-001-20251203    gcc-12.5.0
parisc                randconfig-002-20251203    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                      arches_defconfig    gcc-15.1.0
powerpc                  mpc866_ads_defconfig    clang-22
powerpc               randconfig-001-20251203    gcc-8.5.0
powerpc               randconfig-002-20251203    clang-22
powerpc64             randconfig-002-20251203    clang-22
riscv                            alldefconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251203    gcc-14.3.0
riscv                 randconfig-002-20251203    clang-22
s390                             allmodconfig    clang-18
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251203    clang-22
s390                  randconfig-002-20251203    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251203    gcc-15.1.0
sh                    randconfig-002-20251203    gcc-13.4.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251203    gcc-13.4.0
sparc                 randconfig-002-20251203    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251203    clang-20
sparc64               randconfig-002-20251203    clang-20
um                               allmodconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251203    gcc-14
um                    randconfig-002-20251203    clang-20
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251203    clang-20
x86_64      buildonly-randconfig-002-20251203    clang-20
x86_64      buildonly-randconfig-003-20251203    clang-20
x86_64      buildonly-randconfig-004-20251203    gcc-14
x86_64      buildonly-randconfig-005-20251203    clang-20
x86_64      buildonly-randconfig-006-20251203    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251203    gcc-14
x86_64                randconfig-002-20251203    gcc-14
x86_64                randconfig-003-20251203    clang-20
x86_64                randconfig-004-20251203    clang-20
x86_64                randconfig-005-20251203    gcc-14
x86_64                randconfig-006-20251203    gcc-14
x86_64                randconfig-011-20251203    gcc-14
x86_64                randconfig-012-20251203    clang-20
x86_64                randconfig-013-20251203    gcc-14
x86_64                randconfig-014-20251203    clang-20
x86_64                randconfig-015-20251203    gcc-14
x86_64                randconfig-016-20251203    clang-20
x86_64                randconfig-071-20251203    clang-20
x86_64                randconfig-072-20251203    gcc-14
x86_64                randconfig-073-20251203    clang-20
x86_64                randconfig-074-20251203    gcc-14
x86_64                randconfig-075-20251203    clang-20
x86_64                randconfig-076-20251203    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                           allyesconfig    gcc-15.1.0
xtensa                randconfig-001-20251203    gcc-14.3.0
xtensa                randconfig-002-20251203    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

