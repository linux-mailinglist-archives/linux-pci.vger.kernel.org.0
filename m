Return-Path: <linux-pci+bounces-18467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EF49F27A4
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 01:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E42D16126D
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 00:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794F64A07;
	Mon, 16 Dec 2024 00:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M/p9C/dI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826A8323D
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 00:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734310312; cv=none; b=N7HpwG+pc2UrNNmx1xWUNj9DzkzC0zmZFBzQM6CpOfiodeAfvXIz9deBYVGSJUlfmkdy7EuBxaw1zqeNAflAHNL6/9bzsNT9wGyBLL4wo59JSPNafPFc9WvgZI+i6cXJBNrAK3mDxxKfMnu1pl3X3nMiUdh8DaYEnGvcsblEukQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734310312; c=relaxed/simple;
	bh=F8uiG0t5cHf52CFGcnH5wQJYGLcuq9wV5gkESAWAUCg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=iXlCYi9wiZ9FG1QW2vCJAyrIevnb6SYuFHd7KzCZGKN1drbrMAHpcnn3C/XAv666iU5EuZfp/hiUA6WeEC4a6d9SCztd4MQ5JajigNVQoRGQrhtbH5AHdOBvlRJ2RYyVgBy/t8EWdDftUsZhTc0q6REwF8mmCbdPBAsh6Y07PVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M/p9C/dI; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734310311; x=1765846311;
  h=date:from:to:cc:subject:message-id;
  bh=F8uiG0t5cHf52CFGcnH5wQJYGLcuq9wV5gkESAWAUCg=;
  b=M/p9C/dILEz8/a5AzApsFCxmCu5LiOWXJydFSq8jOzHlxEy1a54HHl/x
   hrNibEmdVHH2etyMbWMtqABEf78j3Zf2w+1FYxAxavDFJutDYTntq9L08
   AHbCQv3lac8+yrMSXwUQhW5Oh9gcVfFjInHloVL3SQkTHgHwHl1WRik+n
   UmcnwZ1BK+Q8vBMhpKIImmuCJ4ICdIVpnT9rbJwpCdYZns3gWIVN/4qeK
   6FtVrF9CHMn/L7vnrVrLIrktOH2mmnnG4S3/rVh4TeImD/zVSOfYV9c+3
   LcBmIVyANbbZdSIJTDu3Z9xNJJjGMASSo0lQ3rdWQA7vmTKVE4knLGIdT
   Q==;
X-CSE-ConnectionGUID: o/MbQy9ZRlmgevIOd+4FnQ==
X-CSE-MsgGUID: q9Q4kWcGRf2mHfheybZLmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34598748"
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="34598748"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 16:51:50 -0800
X-CSE-ConnectionGUID: wDrHGD9/R8yFc+EIvm0CwA==
X-CSE-MsgGUID: f2s0Ooz8QDqT/l+Sk+JMTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="97105136"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 15 Dec 2024 16:51:49 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMzKs-000DvJ-2W;
	Mon, 16 Dec 2024 00:51:46 +0000
Date: Mon, 16 Dec 2024 08:51:10 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 5c3f0be500eeccac9d952735c4ad8bcbde5b7ec5
Message-ID: <202412160804.0u0l6O6Q-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 5c3f0be500eeccac9d952735c4ad8bcbde5b7ec5  Merge branch 'pci/endpoint'

elapsed time: 1442m

configs tested: 140
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
arc                            hsdk_defconfig    gcc-13.2.0
arc                   randconfig-001-20241215    gcc-13.2.0
arc                   randconfig-002-20241215    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                         assabet_defconfig    clang-20
arm                                 defconfig    clang-20
arm                   randconfig-001-20241215    clang-20
arm                   randconfig-002-20241215    clang-16
arm                   randconfig-003-20241215    gcc-14.2.0
arm                   randconfig-004-20241215    clang-20
arm                       spear13xx_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241215    gcc-14.2.0
arm64                 randconfig-002-20241215    gcc-14.2.0
arm64                 randconfig-003-20241215    clang-20
arm64                 randconfig-004-20241215    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241215    gcc-14.2.0
csky                  randconfig-002-20241215    gcc-14.2.0
hexagon                          alldefconfig    clang-15
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                             defconfig    clang-20
hexagon               randconfig-001-20241215    clang-20
hexagon               randconfig-002-20241215    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241215    gcc-12
i386        buildonly-randconfig-002-20241215    gcc-12
i386        buildonly-randconfig-003-20241215    gcc-12
i386        buildonly-randconfig-004-20241215    gcc-12
i386        buildonly-randconfig-005-20241215    gcc-12
i386        buildonly-randconfig-006-20241215    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241215    gcc-14.2.0
loongarch             randconfig-002-20241215    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          atari_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                       m5475evb_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          eyeq6_defconfig    clang-20
mips                        qi_lb60_defconfig    clang-18
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241215    gcc-14.2.0
nios2                 randconfig-002-20241215    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241215    gcc-14.2.0
parisc                randconfig-002-20241215    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                 mpc837x_rdb_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241215    gcc-14.2.0
powerpc               randconfig-002-20241215    clang-20
powerpc               randconfig-003-20241215    gcc-14.2.0
powerpc                     taishan_defconfig    clang-17
powerpc64             randconfig-001-20241215    gcc-14.2.0
powerpc64             randconfig-002-20241215    gcc-14.2.0
powerpc64             randconfig-003-20241215    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv             nommu_k210_sdcard_defconfig    gcc-14.2.0
riscv                    nommu_virt_defconfig    clang-20
riscv                 randconfig-001-20241215    clang-16
riscv                 randconfig-002-20241215    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20241215    gcc-14.2.0
s390                  randconfig-002-20241215    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         ap325rxa_defconfig    gcc-14.2.0
sh                        apsh4ad0a_defconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20241215    gcc-14.2.0
sh                    randconfig-002-20241215    gcc-14.2.0
sh                           se7721_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241215    gcc-14.2.0
sparc                 randconfig-002-20241215    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241215    gcc-14.2.0
sparc64               randconfig-002-20241215    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241215    gcc-12
um                    randconfig-002-20241215    clang-18
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241215    gcc-12
x86_64      buildonly-randconfig-002-20241215    clang-19
x86_64      buildonly-randconfig-003-20241215    clang-19
x86_64      buildonly-randconfig-004-20241215    gcc-12
x86_64      buildonly-randconfig-005-20241215    clang-19
x86_64      buildonly-randconfig-006-20241215    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241215    gcc-14.2.0
xtensa                randconfig-002-20241215    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

