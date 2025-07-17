Return-Path: <linux-pci+bounces-32454-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD51B095E5
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 22:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B40560359
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 20:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD6C1E3DF2;
	Thu, 17 Jul 2025 20:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jstNJfmP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80C9FBF6
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 20:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752785133; cv=none; b=aMAi1CG77xplciZ8Cb8pu442dOHM7AI3mRtVCY16LzaC7ycrYcH/ySIoKoD/ZYKU/lLTHvnmym3b+OrcLPRPAPYwInHkBASZkzJwJGvL2RV6nZjuvNM7AyTWpr91Kl5zso76iI4m9xonD8nMuWeyppuDUYD7oVCMM9ZuK6uLEcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752785133; c=relaxed/simple;
	bh=xtPboCBMkHOywJcVq9WrBSRzXQV5eOxqe/rMRgzH6C8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=i/SRCh4bIpUptnKnWAicj3v8qm6Vbh92yQUXo4xlC3asGK/ISJC2I6kIXd9tijw3JqXjBk7Rc+FsHC2W+Nibc/K+mV53Y8tB/gQK0+nU8FUemk+sUAZ/9oQQwVCzf+Dgtom2d0SHggpcEdZ9I7IYTawvRZQ8XkCT90zuIK70JHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jstNJfmP; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752785131; x=1784321131;
  h=date:from:to:cc:subject:message-id;
  bh=xtPboCBMkHOywJcVq9WrBSRzXQV5eOxqe/rMRgzH6C8=;
  b=jstNJfmPP+5d4uPdOx8r8Dwjzb3Xu8XUx/yde1amUSW07JpE7kOBo57W
   thjKSso/F7jHpzSBB3h/w7sL6/f51Bg08XTFInytrexfohVEqN2bISf+m
   5xLwmgVCLv8OHf4Uf4uGBKMRBz9ZrKw38mgJZeoI2LZn2S1ANQ1cZ+dRm
   XcxjPe8nK6vb+sdOsclsGVbY2/ZJI8pOBnYEBjaK5FkI+ungksYYRjLWb
   U7gYLn4bx3bia0TUWRCdWo3Dvl5TEbnMdmylyHnllzLNLWXYgIIzC8Qoz
   dmuYLewWLCHgc5mxRmqgDvs/oqiITPvRomkXCYeaU9WANUst7sHm7O5QB
   Q==;
X-CSE-ConnectionGUID: LFvFS4WwTvK2mEoHbxY1FA==
X-CSE-MsgGUID: H95VA6MxQpa9eRPp8SWULQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="66143926"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="66143926"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 13:45:31 -0700
X-CSE-ConnectionGUID: jBA9ANpgQMexXzEOuSaaBA==
X-CSE-MsgGUID: 1hnagW3hRWa64tWLFoKSHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="162175322"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 17 Jul 2025 13:45:30 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucVTr-000E0v-2Q;
	Thu, 17 Jul 2025 20:45:27 +0000
Date: Fri, 18 Jul 2025 04:44:57 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/msi-parent] BUILD SUCCESS
 4246b7fccf2698cb116928e278e9fdb7e12e112b
Message-ID: <202507180445.jg7W3pYG-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/msi-parent
branch HEAD: 4246b7fccf2698cb116928e278e9fdb7e12e112b  PCI: vmd: Switch to msi_create_parent_irq_domain()

elapsed time: 1448m

configs tested: 104
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250717    gcc-8.5.0
arc                   randconfig-002-20250717    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                           h3600_defconfig    gcc-15.1.0
arm                          ixp4xx_defconfig    gcc-15.1.0
arm                   randconfig-001-20250717    clang-21
arm                   randconfig-002-20250717    gcc-8.5.0
arm                   randconfig-003-20250717    gcc-8.5.0
arm                   randconfig-004-20250717    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250717    clang-18
arm64                 randconfig-002-20250717    clang-18
arm64                 randconfig-003-20250717    gcc-10.5.0
arm64                 randconfig-004-20250717    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250717    gcc-15.1.0
csky                  randconfig-002-20250717    gcc-12.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250717    clang-20
hexagon               randconfig-002-20250717    clang-19
i386        buildonly-randconfig-001-20250717    gcc-12
i386        buildonly-randconfig-002-20250717    gcc-12
i386        buildonly-randconfig-003-20250717    clang-20
i386        buildonly-randconfig-004-20250717    clang-20
i386        buildonly-randconfig-005-20250717    clang-20
i386        buildonly-randconfig-006-20250717    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250717    gcc-15.1.0
loongarch             randconfig-002-20250717    clang-21
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          eyeq6_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250717    gcc-8.5.0
nios2                 randconfig-002-20250717    gcc-9.3.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250717    gcc-9.3.0
parisc                randconfig-002-20250717    gcc-9.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                 mpc836x_rdk_defconfig    clang-21
powerpc               randconfig-001-20250717    clang-21
powerpc               randconfig-002-20250717    gcc-13.4.0
powerpc               randconfig-003-20250717    clang-21
powerpc64             randconfig-001-20250717    clang-21
powerpc64             randconfig-002-20250717    clang-18
powerpc64             randconfig-003-20250717    clang-21
riscv                             allnoconfig    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250717    gcc-8.5.0
s390                  randconfig-002-20250717    gcc-9.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250717    gcc-14.3.0
sh                    randconfig-002-20250717    gcc-9.3.0
sh                          sdk7786_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250717    gcc-14.3.0
sparc                 randconfig-002-20250717    gcc-8.5.0
sparc                       sparc64_defconfig    gcc-15.1.0
sparc64               randconfig-001-20250717    gcc-12.4.0
sparc64               randconfig-002-20250717    clang-21
um                               alldefconfig    clang-21
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250717    gcc-12
um                    randconfig-002-20250717    gcc-12
x86_64      buildonly-randconfig-001-20250717    clang-20
x86_64      buildonly-randconfig-002-20250717    clang-20
x86_64      buildonly-randconfig-003-20250717    clang-20
x86_64      buildonly-randconfig-004-20250717    gcc-12
x86_64      buildonly-randconfig-005-20250717    gcc-12
x86_64      buildonly-randconfig-006-20250717    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250717    gcc-13.4.0
xtensa                randconfig-002-20250717    gcc-9.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

