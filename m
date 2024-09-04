Return-Path: <linux-pci+bounces-12792-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B32296CA16
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 00:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B621F2465A
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 22:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7AE153812;
	Wed,  4 Sep 2024 22:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y80BdXih"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E9582863
	for <linux-pci@vger.kernel.org>; Wed,  4 Sep 2024 22:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725487907; cv=none; b=rZOj0/aMXxU/7MtF33UQGsTcAYT8jEWcPAIidpqZdLv6Ze7Tx8HcDwt8oMQD4AkN9vrxbK+ZRMTX5uEaky3SHFG3QuIQbOHjtJKpce7O7Sd/UWP/8je4+8zH2xRgMNnv5lbG3vxQNiKaRiTwIi6TTRSdBU1yh9tvbXCcqIYW66M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725487907; c=relaxed/simple;
	bh=/pKghzvjwYzVrxzeqKYvcKRSMrRjaLe+26OlDDO1mT4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=S+RB3sBu4B17+oAMagcVOQ5Tgka3ozAwT98guXloN0EmMaBqsDdY/C7Ts8knvHVNrHACvDN1ng1BYz0K1P7eqa7gxG7OMKXN2JP8hD4zzBfQTOFYPV0vuMzgP/l8k+7N3MMwSs6APyzYEvHKB2RVFW5yRHWyav8V/mQAx5JFIDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y80BdXih; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725487905; x=1757023905;
  h=date:from:to:cc:subject:message-id;
  bh=/pKghzvjwYzVrxzeqKYvcKRSMrRjaLe+26OlDDO1mT4=;
  b=Y80BdXihpzF+HoMqVQP67UnrTLEn8h2QTzHcAVCVwEnKh6Xmnz164x/u
   hWetTQ3kSvzi6V6gyw3vGhzUb8IM+vcgCr094TG5aLDiIJda3/nrhtmVn
   vZqyTas2A7EZ4cHqyoP9+MijpQuItJxxv4pG065WuONqDVSL4Zymao9pv
   1cU5dY/zNFwbLSmS5hThy6nAG+t4cX2pCs6AW5MKdfcyyzGqmhT7+wnzP
   pC4mAS+UKl5HNBfjnTCuFYgW0FmeYzTJgcpRiuP4EjW7OC5PQpG/YZ1Su
   viFxGd+9WiQwtqyt63eji+AXExLzgEFh7gAts6HpGjGYsSw3KOHlxHboG
   w==;
X-CSE-ConnectionGUID: 2sYuyQljQyGJIEX3Mz7WVQ==
X-CSE-MsgGUID: hlIf6MeATdWzNHEpK0kx/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="35335764"
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="35335764"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 15:11:45 -0700
X-CSE-ConnectionGUID: bbpn8KUcS7KNYIekqST3lA==
X-CSE-MsgGUID: 0D33PmSGR2eYoHWk0ngQcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="70211121"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 04 Sep 2024 15:11:44 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1slyE1-0008cF-2o;
	Wed, 04 Sep 2024 22:11:41 +0000
Date: Thu, 05 Sep 2024 06:11:01 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/cadence] BUILD SUCCESS
 c3d95aa93fd8549588097b0701b3835920fd8533
Message-ID: <202409050659.1xXfjpgs-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/cadence
branch HEAD: c3d95aa93fd8549588097b0701b3835920fd8533  PCI: cadence: Drop excess cdns_pcie_rc.dev kerneldoc description

elapsed time: 1469m

configs tested: 116
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                                 defconfig   gcc-14.1.0
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                          collie_defconfig   gcc-14.1.0
arm                                 defconfig   gcc-14.1.0
arm                          gemini_defconfig   gcc-14.1.0
arm                   milbeaut_m10v_defconfig   gcc-14.1.0
arm                           omap1_defconfig   gcc-14.1.0
arm                        spear3xx_defconfig   gcc-14.1.0
arm                    vt8500_v6_v7_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
hexagon                           allnoconfig   gcc-14.1.0
hexagon                             defconfig   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386                                defconfig   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                     loongson1c_defconfig   gcc-14.1.0
mips                      loongson3_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
openrisc                    or1ksim_defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      ep88xc_defconfig   gcc-14.1.0
powerpc                 mpc836x_rdk_defconfig   gcc-14.1.0
powerpc                         ps3_defconfig   gcc-14.1.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                          polaris_defconfig   gcc-14.1.0
sh                          r7785rp_defconfig   gcc-14.1.0
sh                           se7750_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
um                                allnoconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240904   clang-18
x86_64       buildonly-randconfig-002-20240904   clang-18
x86_64       buildonly-randconfig-003-20240904   clang-18
x86_64       buildonly-randconfig-004-20240904   clang-18
x86_64       buildonly-randconfig-005-20240904   clang-18
x86_64       buildonly-randconfig-006-20240904   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                                  kexec   gcc-12
x86_64                randconfig-001-20240904   clang-18
x86_64                randconfig-002-20240904   clang-18
x86_64                randconfig-003-20240904   clang-18
x86_64                randconfig-004-20240904   clang-18
x86_64                randconfig-005-20240904   clang-18
x86_64                randconfig-006-20240904   clang-18
x86_64                randconfig-011-20240904   clang-18
x86_64                randconfig-012-20240904   clang-18
x86_64                randconfig-013-20240904   clang-18
x86_64                randconfig-014-20240904   clang-18
x86_64                randconfig-015-20240904   clang-18
x86_64                randconfig-016-20240904   clang-18
x86_64                randconfig-071-20240904   clang-18
x86_64                randconfig-072-20240904   clang-18
x86_64                randconfig-073-20240904   clang-18
x86_64                randconfig-074-20240904   clang-18
x86_64                randconfig-075-20240904   clang-18
x86_64                randconfig-076-20240904   clang-18
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0
xtensa                  audio_kc705_defconfig   gcc-14.1.0
xtensa                         virt_defconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

