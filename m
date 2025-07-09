Return-Path: <linux-pci+bounces-31754-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEE9AFE1A9
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 09:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A962542FC7
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 07:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D114194A44;
	Wed,  9 Jul 2025 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EjUqxAwa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B69A5383
	for <linux-pci@vger.kernel.org>; Wed,  9 Jul 2025 07:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752047763; cv=none; b=k72X/dotKs4OrX6lOdDSa2SNmYdmq3fu+cFlO1ung9wwxW+o46kKmdiCXu1ISKTJKr2ZpwgfzKWAo0QqhKJIvqogs5EbjNieI/xPoyVrYQnx/ikY38ERdnIrgwbguvpoj1wvvp242air/lNvK6i4/z1djRVOa0PmBMU5bkBc/40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752047763; c=relaxed/simple;
	bh=m8MxCgbam/EI25XiuWQ1TpL6r8AzxI4O1UYXgobxilc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SSPP3hZUW5tzDwNOZ5iDL4MzpN7MNgpDbZpQTxjJnxfjlKzhabxyJP0JYVepLoFd4N/yvI4+4g/1lPF3xKLRyAIzH+GBqplyczR05kFcxBxhbUhuIZ33r8klDodUoNdcyKcvfTqts1LK4KRb/XAqhbrS7dwlZFyUvAb8A6Lmuyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EjUqxAwa; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752047761; x=1783583761;
  h=date:from:to:cc:subject:message-id;
  bh=m8MxCgbam/EI25XiuWQ1TpL6r8AzxI4O1UYXgobxilc=;
  b=EjUqxAwaE4dvJzp/frhpArsLjglS4261pgFSSuxLbNIY1r4KK/pv9ZPO
   +hCEVEHZPZLfcprVVxPOIX+VNYtzyst09CRJrLVRnLkFDmLbJzGdSGdxr
   u2hXDFkW6gpSs80VFcGybE02sHwm9hQLiRLSZjMSBl/zBnS8rqtT28tFM
   WG7pfbSkWRBR2qp8uhKGhFYRS6PBkKFbsR5l6UYj2KcHnPc9F6uMazdag
   iKRH8BAdfIL+qMj++raIni6SBjThjebmwaOd3/rfPPeJeU6ROtIs1mq67
   NibTx3CkDs7pzB5lJmJnP6CMoFhNXxAPxhnnktjVGqwYnAY2aGb2mlbVC
   A==;
X-CSE-ConnectionGUID: 81+kTxW2SPGf5CGT3Y/ZJQ==
X-CSE-MsgGUID: HMqvbm1CRymRdT1wGJ2clw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="71882951"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="71882951"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 00:56:00 -0700
X-CSE-ConnectionGUID: 5iTqsAlJQwWKgkIgq6N8qQ==
X-CSE-MsgGUID: sqLPp8NfSZSTy9UqCuwh6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155341110"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 09 Jul 2025 00:56:00 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZPeo-0003Gp-03;
	Wed, 09 Jul 2025 07:55:58 +0000
Date: Wed, 09 Jul 2025 15:55:18 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/msi-parent] BUILD SUCCESS
 2b96beffa42760513567919aa27eb72035f2db58
Message-ID: <202507091505.k2MLvagl-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/msi-parent
branch HEAD: 2b96beffa42760513567919aa27eb72035f2db58  PCI: vmd: Switch to msi_create_parent_irq_domain()

elapsed time: 1449m

configs tested: 120
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250708    gcc-13.4.0
arc                   randconfig-002-20250708    gcc-8.5.0
arc                        vdk_hs38_defconfig    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                           imxrt_defconfig    clang-21
arm                          ixp4xx_defconfig    gcc-15.1.0
arm                   randconfig-001-20250708    clang-21
arm                   randconfig-002-20250708    clang-17
arm                   randconfig-003-20250708    gcc-10.5.0
arm                   randconfig-004-20250708    clang-21
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250708    gcc-9.5.0
arm64                 randconfig-002-20250708    clang-19
arm64                 randconfig-003-20250708    clang-21
arm64                 randconfig-004-20250708    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250708    gcc-13.4.0
csky                  randconfig-002-20250708    gcc-15.1.0
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250708    clang-21
hexagon               randconfig-002-20250708    clang-21
i386        buildonly-randconfig-001-20250708    clang-20
i386        buildonly-randconfig-002-20250708    clang-20
i386        buildonly-randconfig-003-20250708    clang-20
i386        buildonly-randconfig-004-20250708    gcc-12
i386        buildonly-randconfig-005-20250708    clang-20
i386        buildonly-randconfig-006-20250708    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250708    clang-21
loongarch             randconfig-002-20250708    clang-21
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                         10m50_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250708    gcc-8.5.0
nios2                 randconfig-002-20250708    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250708    gcc-9.3.0
parisc                randconfig-002-20250708    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc               randconfig-001-20250708    gcc-8.5.0
powerpc               randconfig-002-20250708    clang-19
powerpc               randconfig-003-20250708    clang-21
powerpc64             randconfig-001-20250708    clang-21
powerpc64             randconfig-002-20250708    clang-21
powerpc64             randconfig-003-20250708    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250708    clang-16
riscv                 randconfig-002-20250708    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250708    gcc-14.3.0
s390                  randconfig-002-20250708    gcc-9.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                         ecovec24_defconfig    gcc-15.1.0
sh                 kfr2r09-romimage_defconfig    gcc-15.1.0
sh                    randconfig-001-20250708    gcc-11.5.0
sh                    randconfig-002-20250708    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250708    gcc-13.4.0
sparc                 randconfig-002-20250708    gcc-13.4.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250708    clang-21
sparc64               randconfig-002-20250708    gcc-15.1.0
um                               alldefconfig    clang-21
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250708    clang-21
um                    randconfig-002-20250708    clang-17
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20250708    gcc-12
x86_64      buildonly-randconfig-002-20250708    gcc-12
x86_64      buildonly-randconfig-003-20250708    clang-20
x86_64      buildonly-randconfig-004-20250708    gcc-12
x86_64      buildonly-randconfig-005-20250708    clang-20
x86_64      buildonly-randconfig-006-20250708    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250708    gcc-8.5.0
xtensa                randconfig-002-20250708    gcc-9.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

