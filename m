Return-Path: <linux-pci+bounces-33841-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09923B21EB9
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 09:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2C81AA2FE6
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 07:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F562D6E63;
	Tue, 12 Aug 2025 07:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CAAsB0Ih"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DD51E2834
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 07:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754982232; cv=none; b=er90aEi+Ml1lhN2dLeeupN9vrX/duxIadTW24OWzZZ2ojLX9psNP6/hjHKNJ/yMRSa3PbexPEUHvNDORxj17zpHaNofruMRyIFaPmNu0+y0aKLuvKqgr+W0vgsiTkR0Yi3XP1N1egULi53zA4dr9vM9amckWMX72CClpfTJKovo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754982232; c=relaxed/simple;
	bh=D5SJiq+cXHeS3g4OwWorUe8Pv3q/UroFTLzWJgRUv5Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rGjX2SXaskULfD6qoLa+Y0ZqFSqY8fs6hTWZaLAGiiV4ZVQPYp4NevHJfXjqQOzUHvY+7XMgMP23bQKJ4DjV4eqBszzQ5/c3LqNYhzMkHwDkBql65LWHxYBRXQJitF79bliYTJVhpi8MAwyXyxeQx5A2+8GZE/A7FWcq9hIOzjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CAAsB0Ih; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754982231; x=1786518231;
  h=date:from:to:cc:subject:message-id;
  bh=D5SJiq+cXHeS3g4OwWorUe8Pv3q/UroFTLzWJgRUv5Q=;
  b=CAAsB0Ihoxt8Qdnnb1NNKjEEwpvb1C1b8Ntd3Q6ySmKjkj/0QacyiUGC
   pK3BXXg3ur/n9jTabIyYjFIjOO+VOtv2Ovb+NEcjWjDFvHxQdAlCKCPRV
   qOCpuAfaGdosc+7taXC2116WjLDouH9Byx6KVUsHQBIK8Zd3CZ9UG3owm
   BFmWz7MOnOOHfZLjPvqQRoNYQnR7yKGtKBi5+v9qU7eUSYYdZXQrzSXUI
   EkGvis4/V86QNQ44gABalMuKPTH6gWwpl3I18NU7KWHI3F6E876azdiIp
   iDSJyh3+MWmgL9eiN/Obc6Tc/ttPmYmxCbjAC8I2V2Pi0wVqlzJL1st1A
   A==;
X-CSE-ConnectionGUID: T4UZ//OxT6uLyyS8j6LqwQ==
X-CSE-MsgGUID: FCX9GIYCRxCpVl3OQJ+N7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57394231"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="57394231"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 00:03:50 -0700
X-CSE-ConnectionGUID: oe804twyTYu3EaLYa0KL2g==
X-CSE-MsgGUID: gFaL7tgpQt+JVeT/yW6vGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="166917127"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 12 Aug 2025 00:03:48 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ulj2K-0006UK-2v;
	Tue, 12 Aug 2025 07:03:20 +0000
Date: Tue, 12 Aug 2025 15:02:54 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 57a75fa9d56e310e883e4377205690e88c05781b
Message-ID: <202508121548.nRQsznVU-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: 57a75fa9d56e310e883e4377205690e88c05781b  PCI: endpoint: pci-ep-msi: Fix NULL vs IS_ERR() check in pci_epf_write_msi_msg()

elapsed time: 1104m

configs tested: 134
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250812    gcc-8.5.0
arc                   randconfig-002-20250812    gcc-12.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                          ixp4xx_defconfig    gcc-15.1.0
arm                   randconfig-001-20250812    clang-22
arm                   randconfig-002-20250812    clang-22
arm                   randconfig-003-20250812    gcc-14.3.0
arm                   randconfig-004-20250812    gcc-10.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250812    gcc-8.5.0
arm64                 randconfig-002-20250812    gcc-8.5.0
arm64                 randconfig-003-20250812    gcc-14.3.0
arm64                 randconfig-004-20250812    gcc-8.5.0
csky                             alldefconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250812    gcc-13.4.0
csky                  randconfig-002-20250812    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20250812    clang-22
hexagon               randconfig-002-20250812    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250812    gcc-12
i386        buildonly-randconfig-002-20250812    gcc-12
i386        buildonly-randconfig-003-20250812    gcc-12
i386        buildonly-randconfig-004-20250812    clang-20
i386        buildonly-randconfig-005-20250812    clang-20
i386        buildonly-randconfig-006-20250812    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250812    gcc-15.1.0
loongarch             randconfig-002-20250812    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                       m5475evb_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250812    gcc-10.5.0
nios2                 randconfig-002-20250812    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250812    gcc-10.5.0
parisc                randconfig-002-20250812    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                         ps3_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250812    clang-19
powerpc               randconfig-002-20250812    clang-22
powerpc               randconfig-003-20250812    gcc-12.5.0
powerpc                     tqm8541_defconfig    clang-22
powerpc64             randconfig-001-20250812    clang-22
powerpc64             randconfig-002-20250812    clang-16
powerpc64             randconfig-003-20250812    clang-18
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250812    gcc-9.5.0
riscv                 randconfig-002-20250812    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250812    clang-18
s390                  randconfig-002-20250812    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                         ecovec24_defconfig    gcc-15.1.0
sh                    randconfig-001-20250812    gcc-15.1.0
sh                    randconfig-002-20250812    gcc-15.1.0
sh                          rsk7203_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250812    gcc-8.5.0
sparc                 randconfig-002-20250812    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250812    clang-22
sparc64               randconfig-002-20250812    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250812    gcc-11
um                    randconfig-002-20250812    gcc-12
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250812    clang-20
x86_64      buildonly-randconfig-002-20250812    gcc-12
x86_64      buildonly-randconfig-003-20250812    gcc-12
x86_64      buildonly-randconfig-004-20250812    gcc-12
x86_64      buildonly-randconfig-005-20250812    clang-20
x86_64      buildonly-randconfig-006-20250812    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250812    gcc-10.5.0
xtensa                randconfig-002-20250812    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

