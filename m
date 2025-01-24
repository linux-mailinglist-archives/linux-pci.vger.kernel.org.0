Return-Path: <linux-pci+bounces-20334-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8557A1B4EB
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 12:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EFAA16C8B3
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 11:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E461CEAD4;
	Fri, 24 Jan 2025 11:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OMGVeq+r"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8BE1E495
	for <linux-pci@vger.kernel.org>; Fri, 24 Jan 2025 11:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737718956; cv=none; b=K1I50NQ8IwpwU5UeUcSTJTcY0hEHRvpO6STj2qP7zmWRaXlu+ZxjJUC4CbRZALTGUTi6wCCQ9ceh5htv6W/plmUIt7q1NS/iXKQFB89VCAEpKM1cyFg2DWYlxfofLRIIC6urJPEGTicYvRb98sfxrL4F8ie1VLyq42aGRyqUxgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737718956; c=relaxed/simple;
	bh=Oekia56kBTtJyOwgakL1rXUfr/iX2KCAbaICaAfNMLc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fjlMDSBEaSYy4tXrgoJ9MgGAefp5X/YPQYgK6MfRn3eMO2LURaiAMMq823qDPvCZMX3pm8fn1acubX6JcQhtG5Yecgl5wF5Vkj5wsZpZbtdYgqAwnrESSQy+3omECcTZEaqyO5p9653rhoo/B7kDwDaMq36ujLBEZt8mAgsKrZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OMGVeq+r; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737718954; x=1769254954;
  h=date:from:to:cc:subject:message-id;
  bh=Oekia56kBTtJyOwgakL1rXUfr/iX2KCAbaICaAfNMLc=;
  b=OMGVeq+rsJ/jLZRWCycNmIfv+HqlhPNFpYRZEwkrus5KwgeOhKE7zft5
   dIZ1a3vlm4d7msCFiCD5UoFWra5wo1vdzc42OPP2V87fv8EQ1k9YcoEuX
   JK+jz8e2VXM8wADaa+Go3yXl1jt8PDOLmLprqyUIpPwWdroG1HgL7m9Xc
   A/iAs3PxpGaWTCFi1dNlwJrGkG2ubQ7/msLxrcSbIbBsmwK1OegAw6vhs
   Y+6k3ksbr2AGxFkLiGEsbDiHQe+AmI6QfSr1D+DsNsyBhmmm75q8P1Lh3
   gcL+9xHsrHGYxb5aDKJngLqTTBgwgWVo8FZeRIYnMEAxQLT5nCgr74Gl+
   Q==;
X-CSE-ConnectionGUID: XT7UTFkgRv2vT7u2CgAasQ==
X-CSE-MsgGUID: 0LU9R7UoS62btECsSb1idg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="38349677"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="38349677"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 03:42:34 -0800
X-CSE-ConnectionGUID: 5nB039JHTSyrybGztqM87A==
X-CSE-MsgGUID: 6F7o4S5MR2KVXd9mQjehYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108647273"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 24 Jan 2025 03:42:32 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tbI50-000ccT-1U;
	Fri, 24 Jan 2025 11:42:30 +0000
Date: Fri, 24 Jan 2025 19:41:56 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 10ff5bbfd4b020e58fd8863e44ae59f0d4c337bf
Message-ID: <202501241947.dTkmiEkL-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 10ff5bbfd4b020e58fd8863e44ae59f0d4c337bf  Merge branch 'pci/misc'

elapsed time: 988m

configs tested: 113
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250124    gcc-13.2.0
arc                   randconfig-002-20250124    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250124    clang-17
arm                   randconfig-002-20250124    gcc-14.2.0
arm                   randconfig-003-20250124    gcc-14.2.0
arm                   randconfig-004-20250124    clang-19
arm                             rpc_defconfig    clang-17
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250124    clang-20
arm64                 randconfig-002-20250124    clang-20
arm64                 randconfig-003-20250124    clang-19
arm64                 randconfig-004-20250124    clang-20
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250124    gcc-14.2.0
csky                  randconfig-002-20250124    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20250124    clang-20
hexagon               randconfig-002-20250124    clang-14
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250124    clang-19
i386        buildonly-randconfig-002-20250124    clang-19
i386        buildonly-randconfig-003-20250124    gcc-12
i386        buildonly-randconfig-004-20250124    gcc-12
i386        buildonly-randconfig-005-20250124    gcc-12
i386        buildonly-randconfig-006-20250124    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250124    gcc-14.2.0
loongarch             randconfig-002-20250124    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250124    gcc-14.2.0
nios2                 randconfig-002-20250124    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250124    gcc-14.2.0
parisc                randconfig-002-20250124    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                        fsp2_defconfig    gcc-14.2.0
powerpc                          g5_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250124    gcc-14.2.0
powerpc               randconfig-002-20250124    gcc-14.2.0
powerpc               randconfig-003-20250124    clang-20
powerpc                        warp_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250124    gcc-14.2.0
powerpc64             randconfig-002-20250124    clang-20
powerpc64             randconfig-003-20250124    clang-19
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                 randconfig-001-20250124    clang-19
riscv                 randconfig-002-20250124    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250124    gcc-14.2.0
s390                  randconfig-002-20250124    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250124    gcc-14.2.0
sh                    randconfig-002-20250124    gcc-14.2.0
sh                        sh7757lcr_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250124    gcc-14.2.0
sparc                 randconfig-002-20250124    gcc-14.2.0
sparc64                          alldefconfig    gcc-14.2.0
sparc64               randconfig-001-20250124    gcc-14.2.0
sparc64               randconfig-002-20250124    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250124    gcc-12
um                    randconfig-002-20250124    clang-20
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250124    gcc-12
x86_64      buildonly-randconfig-002-20250124    gcc-12
x86_64      buildonly-randconfig-003-20250124    clang-19
x86_64      buildonly-randconfig-004-20250124    clang-19
x86_64      buildonly-randconfig-005-20250124    clang-19
x86_64      buildonly-randconfig-006-20250124    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250124    gcc-14.2.0
xtensa                randconfig-002-20250124    gcc-14.2.0
xtensa                         virt_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

