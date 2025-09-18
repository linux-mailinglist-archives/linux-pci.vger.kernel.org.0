Return-Path: <linux-pci+bounces-36445-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C46C8B8726B
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 23:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 760AD582F69
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 21:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732922D323E;
	Thu, 18 Sep 2025 21:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lDwhBtfF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29E22D24BA
	for <linux-pci@vger.kernel.org>; Thu, 18 Sep 2025 21:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758231305; cv=none; b=P7Cl0bbByhNMNIRoiIRqIsU1KJVQtBhVzr9i44l7QT6mlo+5LnwxAE5+mFZLmHtb5N9AGGz8Prq5kg0z0RkGSRaWu8Rn73YK3fImCUjcwaBhVwDy6y3K1J9ZPC8doRvbs1+7jDHpb4W4+PRhy6ugpnh0QYJuc6bYwTiR3QkHa4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758231305; c=relaxed/simple;
	bh=5xIC/SxzSUjmaEs5zZW79khdMGTqu+7XaLk3XCyZ3io=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Ij8sP19FPrF5+k4alrYPHtV8B+QkfNgyW9ALTGf/WN+9/ZBheVAKkN5hPFT8z2ivcXd25tIWfr+HBoa5K7P6nR/iiKPgaiUGq5cvf60T6h445WXTkrN4C+Qurw3zjwqmdijvRYbStoSF5Pliy/4ddDUCiC/PPqV9N4q44Fe7ft0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lDwhBtfF; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758231304; x=1789767304;
  h=date:from:to:cc:subject:message-id;
  bh=5xIC/SxzSUjmaEs5zZW79khdMGTqu+7XaLk3XCyZ3io=;
  b=lDwhBtfFWMi5EaFl9tsBWVsqNd/IloTyW75NfolmGLPC8zS6wFxxcBHB
   C3zkDB+WLihpDrlbrHhZyIvfSSSEbHBRlnsccyxDyPD7TY2//RgToCNXi
   qwp7ufH6IciXvt6SEZI18mMuD33m7N5Bl1esWbC+D0qRP9XiyplC0FQmx
   x8DkkXy+nDstpe+qhZ2fd9dNx7HASW00gVtDuEbzr0loDTRl/0PpfNypc
   i/oKjEeHriLHFVq+mNPYuMU+BRqrlHrFTzVhfF8tTCovNVkHHaS2NPh0c
   1k9/HB+/fIrnrvPx+bsg2rd0VpAViK2nS/iNtha5H68Fl2dVeT3rR58Ox
   Q==;
X-CSE-ConnectionGUID: xmIjkJAoS2mMD0syXBRs6g==
X-CSE-MsgGUID: yrn2DB5JTNC0cXDjWdqoOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64380258"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64380258"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 14:35:04 -0700
X-CSE-ConnectionGUID: W9yjrrUyQ1aBKLh4OXC81g==
X-CSE-MsgGUID: ALdOR/uETq2UjVFpCZuISQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="179659662"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 18 Sep 2025 14:35:03 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzMHL-0003jj-37;
	Thu, 18 Sep 2025 21:34:59 +0000
Date: Fri, 19 Sep 2025 05:34:03 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 dc72930fe22e0f752006ae9de919dc3e2f19e77f
Message-ID: <202509190556.FbzFZx7M-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: dc72930fe22e0f752006ae9de919dc3e2f19e77f  Merge branch 'pci/misc'

elapsed time: 1538m

configs tested: 105
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                        nsimosci_defconfig    gcc-15.1.0
arc                   randconfig-001-20250918    gcc-8.5.0
arc                   randconfig-002-20250918    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                         axm55xx_defconfig    clang-22
arm                            mps2_defconfig    clang-22
arm                   randconfig-001-20250918    clang-22
arm                   randconfig-002-20250918    gcc-8.5.0
arm                   randconfig-003-20250918    clang-22
arm                   randconfig-004-20250918    gcc-11.5.0
arm                         vf610m4_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250918    clang-22
arm64                 randconfig-002-20250918    gcc-11.5.0
arm64                 randconfig-003-20250918    clang-22
arm64                 randconfig-004-20250918    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250918    gcc-15.1.0
csky                  randconfig-002-20250918    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250918    clang-22
hexagon               randconfig-002-20250918    clang-22
i386        buildonly-randconfig-001-20250918    clang-20
i386        buildonly-randconfig-002-20250918    gcc-14
i386        buildonly-randconfig-003-20250918    gcc-14
i386        buildonly-randconfig-004-20250918    clang-20
i386        buildonly-randconfig-005-20250918    gcc-14
i386        buildonly-randconfig-006-20250918    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250918    clang-18
loongarch             randconfig-002-20250918    clang-18
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        bcm63xx_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250918    gcc-10.5.0
nios2                 randconfig-002-20250918    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250918    gcc-12.5.0
parisc                randconfig-002-20250918    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                 mpc834x_itx_defconfig    clang-16
powerpc               randconfig-001-20250918    gcc-9.5.0
powerpc               randconfig-002-20250918    clang-17
powerpc               randconfig-003-20250918    clang-19
powerpc64             randconfig-001-20250918    gcc-8.5.0
powerpc64             randconfig-002-20250918    gcc-14.3.0
powerpc64             randconfig-003-20250918    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250918    clang-22
riscv                 randconfig-002-20250918    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250918    gcc-11.5.0
s390                  randconfig-002-20250918    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250918    gcc-15.1.0
sh                    randconfig-002-20250918    gcc-10.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250918    gcc-11.5.0
sparc                 randconfig-002-20250918    gcc-15.1.0
sparc                       sparc32_defconfig    gcc-15.1.0
sparc64               randconfig-001-20250918    clang-20
sparc64               randconfig-002-20250918    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20250918    clang-22
um                    randconfig-002-20250918    clang-18
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20250918    clang-20
x86_64      buildonly-randconfig-002-20250918    clang-20
x86_64      buildonly-randconfig-003-20250918    clang-20
x86_64      buildonly-randconfig-004-20250918    clang-20
x86_64      buildonly-randconfig-005-20250918    clang-20
x86_64      buildonly-randconfig-006-20250918    clang-20
x86_64                              defconfig    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250918    gcc-8.5.0
xtensa                randconfig-002-20250918    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

