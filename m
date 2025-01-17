Return-Path: <linux-pci+bounces-20073-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56100A1565D
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 19:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8DAA3AA497
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 18:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D0619DF77;
	Fri, 17 Jan 2025 18:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4edMVrO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EDB194C96
	for <linux-pci@vger.kernel.org>; Fri, 17 Jan 2025 18:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737137841; cv=none; b=dHCpXNbBbXcOCu8Hrs+EbdYxJ+xNbQ2Zf6uNutexgiK1XoAHo+GAbi3yIPPAiHQyxxAXkx6vT9sVe2KdUMFUMX6aEXVdhWoPaALcmq97A1vW6SdZ2y3nXHwfxFbIZRfZEoB4YwOe/3su2LDFr3q3OQ1tzAE6fVsnGmzGgu1QLU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737137841; c=relaxed/simple;
	bh=Gcxhip4oz8zaXIZBq7DBI3JzfZKGebJGMZqH/I3B3e8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=U6eMCHjCx6+gNcV5p293fvEOjD+hQn3KO0f4Mn5FoAnV17UUQylGkxuI3IsnLvKz/j9K/Jxx1OrAfUM472IcLPYt5b82iE2g86oSXGL4i3zDdw/Hdq0P9zbxIevL4z67Gf6dyOe9HiqAijDrtAQ+DxUihNd1uEtJwSf1Oq7FzmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H4edMVrO; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737137839; x=1768673839;
  h=date:from:to:cc:subject:message-id;
  bh=Gcxhip4oz8zaXIZBq7DBI3JzfZKGebJGMZqH/I3B3e8=;
  b=H4edMVrO3WlwfmfFgzY9Na2/ZpqGWHZdVPg8DqEwdkcN5+fIAW1l/kXP
   7vXNhSnc2+ZNlNzfgEeC1nwI/uuSOf9e1x6Uuf/wxlXJnVtPLpcnqOfF7
   13algh7ICeXR7vDgigB3QhSb5zWUiGKCU//O04KiRKNo3+KagBfHn3Q8a
   SotFb/G9Ac+B/zPHp0EfgQtd4EM/xnPv/C50rtaY0+eGsh7+FMKjMPq6k
   6xkcWQS6yGd9zBhVun0s5tnZqNubAHKdmOXWhY3HsLchIOvbwp9FtnhNZ
   9SmUu38rxaSsAu5hkHSyv+F3tvr6ORHsCFkYzl+Qmk9ytdoisWaPpUMP4
   Q==;
X-CSE-ConnectionGUID: QCiWXALTQEKPxlT7AV+0vA==
X-CSE-MsgGUID: zLHcuy7GTSKE92WIUcnDSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="37734266"
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="37734266"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 10:17:18 -0800
X-CSE-ConnectionGUID: clUNDG8cTSWmaKj1Prqkag==
X-CSE-MsgGUID: 8PKXR361Rvek7CYk5Vn+LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="105717094"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 17 Jan 2025 10:17:18 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYquB-000TYj-2j;
	Fri, 17 Jan 2025 18:17:15 +0000
Date: Sat, 18 Jan 2025 02:16:21 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:err] BUILD SUCCESS
 f68ea779d98a01de0c05b618e35ba2090af590cf
Message-ID: <202501180215.8Fy8O6qM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git err
branch HEAD: f68ea779d98a01de0c05b618e35ba2090af590cf  PCI: Add pcie_print_tlp_log() to print TLP Header and Prefix Log

elapsed time: 1445m

configs tested: 80
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                               allnoconfig    gcc-13.2.0
arc                   randconfig-001-20250117    gcc-13.2.0
arc                   randconfig-002-20250117    gcc-13.2.0
arm                               allnoconfig    clang-17
arm                   randconfig-001-20250117    clang-18
arm                   randconfig-002-20250117    gcc-14.2.0
arm                   randconfig-003-20250117    gcc-14.2.0
arm                   randconfig-004-20250117    clang-16
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250117    gcc-14.2.0
arm64                 randconfig-002-20250117    clang-18
arm64                 randconfig-003-20250117    clang-20
arm64                 randconfig-004-20250117    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250117    gcc-14.2.0
csky                  randconfig-002-20250117    gcc-14.2.0
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20250117    clang-20
hexagon               randconfig-002-20250117    clang-20
i386        buildonly-randconfig-001-20250117    clang-19
i386        buildonly-randconfig-002-20250117    clang-19
i386        buildonly-randconfig-003-20250117    gcc-12
i386        buildonly-randconfig-004-20250117    gcc-12
i386        buildonly-randconfig-005-20250117    clang-19
i386        buildonly-randconfig-006-20250117    gcc-11
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250117    gcc-14.2.0
loongarch             randconfig-002-20250117    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250117    gcc-14.2.0
nios2                 randconfig-002-20250117    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250117    gcc-14.2.0
parisc                randconfig-002-20250117    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250117    gcc-14.2.0
powerpc               randconfig-002-20250117    gcc-14.2.0
powerpc               randconfig-003-20250117    gcc-14.2.0
powerpc64             randconfig-001-20250117    clang-16
powerpc64             randconfig-002-20250117    clang-20
powerpc64             randconfig-003-20250117    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250117    gcc-14.2.0
riscv                 randconfig-002-20250117    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250117    gcc-14.2.0
s390                  randconfig-002-20250117    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250117    gcc-14.2.0
sh                    randconfig-002-20250117    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250117    gcc-14.2.0
sparc                 randconfig-002-20250117    gcc-14.2.0
sparc64               randconfig-001-20250117    gcc-14.2.0
sparc64               randconfig-002-20250117    gcc-14.2.0
um                                allnoconfig    clang-18
um                    randconfig-001-20250117    clang-20
um                    randconfig-002-20250117    gcc-12
x86_64                            allnoconfig    clang-19
x86_64      buildonly-randconfig-001-20250117    gcc-12
x86_64      buildonly-randconfig-002-20250117    gcc-12
x86_64      buildonly-randconfig-003-20250117    gcc-12
x86_64      buildonly-randconfig-004-20250117    gcc-12
x86_64      buildonly-randconfig-005-20250117    gcc-12
x86_64      buildonly-randconfig-006-20250117    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250117    gcc-14.2.0
xtensa                randconfig-002-20250117    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

