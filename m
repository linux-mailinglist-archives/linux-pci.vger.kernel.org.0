Return-Path: <linux-pci+bounces-20258-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C05A19BFF
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 01:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE43B3ABADE
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 00:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BDD8BF8;
	Thu, 23 Jan 2025 00:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bXwWw2G7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1A5849C
	for <linux-pci@vger.kernel.org>; Thu, 23 Jan 2025 00:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737593828; cv=none; b=gJOCprj/h7mDxP1KcCoA4xx3pOVLmstcD3i2QFrQFYaQdhxraIxIpUspKjBdiltRqJOSoUAlJn1WP5FbkbckDW/2oZcUtR2ZNjBWKWcFWNObe/GwJj9hpLgiAWWGhx/jgcVy9/vvxGfFVqhrXpfc+XUMsiAbnzezSWuosDk85lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737593828; c=relaxed/simple;
	bh=XKpwmKf2Q55uxi4tGN/2nqLkaJ4uRTkk6OJEnQJsnA0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=irKtnH3PXEmdV47ke2H0KUy/Lk56hnM8ythT5J2pxsIIbIujxXj/iLJEGBvmF4COQ3hLoJog9FvXD0RY32PGi+lYyVlqAz528OQaaMSIf2KhowV3RBY0Vbk13+mSNuww62JEQkZwaYSYTMpJgmCCpn07ppXDCteameNS+7KfFWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bXwWw2G7; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737593827; x=1769129827;
  h=date:from:to:cc:subject:message-id;
  bh=XKpwmKf2Q55uxi4tGN/2nqLkaJ4uRTkk6OJEnQJsnA0=;
  b=bXwWw2G7JPTNkNHvX1C7QC0E3m3lYewo2IXeCUvSGiWTUxvMgfLTKdrD
   L43JJ/FWy/xIUaaqSGlLZawZk3I6YoGw0AoVuhTcQoosfTt/x7F6GFVbd
   KWTstIq++zaF2rehOxcNpj8x7rxg+iECxYBHHxfTsJQeH//NiZM9uNCvE
   C5KcsBWjLBKCU0Zc10pEltd00AqrYP7Vh0Ob5kOEPnVs5pA367OOxjtui
   bZhL5FnE0i1CossLh7PrEBkM6x3YbZwYplKA+jnKiUCdu9CnAVX41aydo
   X4A2qV/IB5aguCz6+QrRec0TmanHkDb1cE8xJ+rGXXQRCAvK7tUXngNgb
   A==;
X-CSE-ConnectionGUID: 67TWPoUBR4iNk1NHkw5vGA==
X-CSE-MsgGUID: ACqysqdsQTehJJaPBG54IA==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="37958619"
X-IronPort-AV: E=Sophos;i="6.13,226,1732608000"; 
   d="scan'208";a="37958619"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 16:57:06 -0800
X-CSE-ConnectionGUID: FeHtyzFCTAW1u9nMC4ig5w==
X-CSE-MsgGUID: ugUm4DF4SxWSHHonhhEBUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,226,1732608000"; 
   d="scan'208";a="138159280"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 22 Jan 2025 16:57:05 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1talWo-000aUW-2M;
	Thu, 23 Jan 2025 00:57:02 +0000
Date: Thu, 23 Jan 2025 08:56:16 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 595383380cbda6697aa08debe8be7c75d78684f3
Message-ID: <202501230809.QM5Dfoav-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 595383380cbda6697aa08debe8be7c75d78684f3  Merge branch 'pci/misc'

elapsed time: 1444m

configs tested: 105
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                               allnoconfig    gcc-13.2.0
arc                   randconfig-001-20250122    gcc-13.2.0
arc                   randconfig-002-20250122    gcc-13.2.0
arm                               allnoconfig    clang-17
arm                   randconfig-001-20250122    clang-19
arm                   randconfig-002-20250122    clang-20
arm                   randconfig-003-20250122    gcc-14.2.0
arm                   randconfig-004-20250122    gcc-14.2.0
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250122    clang-20
arm64                 randconfig-002-20250122    clang-15
arm64                 randconfig-003-20250122    clang-20
arm64                 randconfig-004-20250122    clang-19
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250122    gcc-14.2.0
csky                  randconfig-002-20250122    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20250122    clang-20
hexagon               randconfig-002-20250122    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250122    clang-19
i386        buildonly-randconfig-002-20250122    gcc-12
i386        buildonly-randconfig-003-20250122    gcc-12
i386        buildonly-randconfig-004-20250122    clang-19
i386        buildonly-randconfig-005-20250122    clang-19
i386        buildonly-randconfig-006-20250122    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250122    gcc-14.2.0
loongarch             randconfig-002-20250122    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                        stmark2_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250122    gcc-14.2.0
nios2                 randconfig-002-20250122    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                  or1klitex_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250122    gcc-14.2.0
parisc                randconfig-002-20250122    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                     mpc512x_defconfig    clang-20
powerpc               randconfig-001-20250122    gcc-14.2.0
powerpc               randconfig-002-20250122    clang-17
powerpc               randconfig-003-20250122    clang-15
powerpc64             randconfig-001-20250122    clang-20
powerpc64             randconfig-002-20250122    clang-19
powerpc64             randconfig-003-20250122    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                 randconfig-001-20250122    clang-20
riscv                 randconfig-002-20250122    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250122    clang-18
s390                  randconfig-002-20250122    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                          lboxre2_defconfig    gcc-14.2.0
sh                    randconfig-001-20250122    gcc-14.2.0
sh                    randconfig-002-20250122    gcc-14.2.0
sh                        sh7763rdp_defconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250122    gcc-14.2.0
sparc                 randconfig-002-20250122    gcc-14.2.0
sparc64               randconfig-001-20250122    gcc-14.2.0
sparc64               randconfig-002-20250122    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250122    gcc-12
um                    randconfig-002-20250122    clang-20
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250122    gcc-12
x86_64      buildonly-randconfig-002-20250122    clang-19
x86_64      buildonly-randconfig-003-20250122    gcc-12
x86_64      buildonly-randconfig-004-20250122    gcc-12
x86_64      buildonly-randconfig-005-20250122    gcc-12
x86_64      buildonly-randconfig-006-20250122    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250122    gcc-14.2.0
xtensa                randconfig-002-20250122    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

