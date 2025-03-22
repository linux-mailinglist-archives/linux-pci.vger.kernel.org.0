Return-Path: <linux-pci+bounces-24449-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D69A6CD05
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 23:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686E21708AF
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 22:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3DB14386D;
	Sat, 22 Mar 2025 22:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WW/ePnr5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3CC1BD9C6
	for <linux-pci@vger.kernel.org>; Sat, 22 Mar 2025 22:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742683868; cv=none; b=GRqsyFRP6UBTDC+XHnBzCcatei4uJiQpeNZTcTxFS1E1dgarod+1kLd7/9woCpzvymaDMfMeC4DsM/q6yyjnEemm86ZvZLaEK3cZEIGfC2+/6V9waqXqKm5EYrwUqvrwQNlSD8r4hm6qgW7ng433tzLYvqxkAIAwdZPKK6IHxcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742683868; c=relaxed/simple;
	bh=R51zKcaZsiV+PfWWQRNwZWZZga0Rimcl+BKc2ZyB6TM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=c7ajo7efqJgTA2lxMyMAWqX/gOqRns75LBufQf2PiQVMNeiddyafXo6GjTtMtcvG2PvNLf+qqvlgmatzhLvGYWh2Jx6sHmgKMYaX9q7liFLT4pRTAPZI14oQ/bmWdHHyxMZBj50o3QSO4zRz13mrhQiFmOTa7AnFd9mLLURK5SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WW/ePnr5; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742683867; x=1774219867;
  h=date:from:to:cc:subject:message-id;
  bh=R51zKcaZsiV+PfWWQRNwZWZZga0Rimcl+BKc2ZyB6TM=;
  b=WW/ePnr5EmsdEF7O/1QnnlsAKUaBbE2Av01w4o/3SDl6cvSqz5xbindh
   cdG1T1usRqHCaajDUn/pd02ojihJPFVX8UDD06j/3xJ40FX4jRA4RiFAh
   JDsIZwca8ecMhdJh0Tob13yqdtZ5d3pvzP0Y3nj3HMTmO5SogIwA137zU
   3pvEeRgfxRsE+m9dAgDQOSYiom7uhozlC5W/YOdSfvkUS2Z8CmrBXDm4e
   alqaXtmwGFYbR82dw+hHPQm6YwqrpcZpyjKnajWvVgD0OiGWTqJjsznBI
   29Xm8B+/Tj62D5POnwsuvoZbL0KehhPUGoYqW3GNaDqYX54xALyloJXSr
   w==;
X-CSE-ConnectionGUID: AuiLW4sfQyegFCrG2mMsWw==
X-CSE-MsgGUID: BomQc36hQA+ihpoW1NCmOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11381"; a="44044363"
X-IronPort-AV: E=Sophos;i="6.14,268,1736841600"; 
   d="scan'208";a="44044363"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2025 15:51:04 -0700
X-CSE-ConnectionGUID: C7AAFAtVT8ys9mEiBbp8oQ==
X-CSE-MsgGUID: InlWiyO+RhOcYaX9WyYUSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,268,1736841600"; 
   d="scan'208";a="128760462"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 22 Mar 2025 15:51:03 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tw7gD-0002RN-0M;
	Sat, 22 Mar 2025 22:51:01 +0000
Date: Sun, 23 Mar 2025 06:50:20 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 99b6885f951e3d3ab87e2268b2cd99ed5baeb34f
Message-ID: <202503230614.XZcfuxnx-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 99b6885f951e3d3ab87e2268b2cd99ed5baeb34f  Merge branch 'pci/misc'

elapsed time: 1442m

configs tested: 95
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-14.2.0
alpha                           allyesconfig    gcc-14.2.0
arc                             allmodconfig    gcc-14.2.0
arc                              allnoconfig    gcc-14.2.0
arc                             allyesconfig    gcc-14.2.0
arc                  randconfig-001-20250322    gcc-10.5.0
arc                  randconfig-002-20250322    gcc-8.5.0
arm                             allmodconfig    gcc-14.2.0
arm                             allyesconfig    gcc-14.2.0
arm                  randconfig-001-20250322    gcc-7.5.0
arm                  randconfig-002-20250322    gcc-7.5.0
arm                  randconfig-003-20250322    clang-21
arm                  randconfig-004-20250322    clang-19
arm                      versatile_defconfig    gcc-14.2.0
arm64                           allmodconfig    clang-19
arm64                randconfig-001-20250322    clang-21
arm64                randconfig-002-20250322    clang-21
arm64                randconfig-003-20250322    gcc-8.5.0
arm64                randconfig-004-20250322    clang-21
csky                 randconfig-001-20250322    gcc-14.2.0
csky                 randconfig-002-20250322    gcc-14.2.0
hexagon                         allmodconfig    clang-17
hexagon                         allyesconfig    clang-21
hexagon              randconfig-001-20250322    clang-21
hexagon              randconfig-002-20250322    clang-21
i386                            allmodconfig    gcc-12
i386                             allnoconfig    gcc-12
i386                            allyesconfig    gcc-12
i386       buildonly-randconfig-001-20250322    clang-20
i386       buildonly-randconfig-002-20250322    gcc-12
i386       buildonly-randconfig-003-20250322    gcc-12
i386       buildonly-randconfig-004-20250322    clang-20
i386       buildonly-randconfig-005-20250322    clang-20
i386       buildonly-randconfig-006-20250322    clang-20
i386                               defconfig    clang-20
loongarch            randconfig-001-20250322    gcc-14.2.0
loongarch            randconfig-002-20250322    gcc-14.2.0
m68k                            allmodconfig    gcc-14.2.0
m68k                            allyesconfig    gcc-14.2.0
m68k                       m5407c3_defconfig    gcc-14.2.0
nios2                randconfig-001-20250322    gcc-6.5.0
nios2                randconfig-002-20250322    gcc-10.5.0
openrisc                         allnoconfig    gcc-14.2.0
openrisc                        allyesconfig    gcc-14.2.0
openrisc                           defconfig    gcc-14.2.0
parisc                          allmodconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc                          allyesconfig    gcc-14.2.0
parisc                             defconfig    gcc-14.2.0
parisc               randconfig-001-20250322    gcc-5.5.0
parisc               randconfig-002-20250322    gcc-13.3.0
powerpc                         allmodconfig    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc                         allyesconfig    clang-21
powerpc              randconfig-001-20250322    clang-21
powerpc              randconfig-002-20250322    gcc-8.5.0
powerpc              randconfig-003-20250322    clang-21
powerpc64            randconfig-001-20250322    clang-21
powerpc64            randconfig-002-20250322    gcc-8.5.0
powerpc64            randconfig-003-20250322    gcc-8.5.0
riscv                           allmodconfig    clang-21
riscv                            allnoconfig    gcc-14.2.0
riscv                           allyesconfig    clang-16
riscv                randconfig-001-20250322    gcc-8.5.0
riscv                randconfig-002-20250322    clang-21
s390                            allmodconfig    clang-18
s390                             allnoconfig    clang-15
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250322    gcc-9.3.0
s390                 randconfig-002-20250322    gcc-6.5.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250322    gcc-10.5.0
sh                   randconfig-002-20250322    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250322    gcc-9.3.0
sparc                randconfig-002-20250322    gcc-9.3.0
sparc64              randconfig-001-20250322    gcc-5.5.0
sparc64              randconfig-002-20250322    gcc-5.5.0
um                              allmodconfig    clang-19
um                               allnoconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250322    clang-21
um                   randconfig-002-20250322    gcc-12
x86_64                           allnoconfig    clang-20
x86_64                          allyesconfig    clang-20
x86_64     buildonly-randconfig-001-20250322    clang-20
x86_64     buildonly-randconfig-002-20250322    clang-20
x86_64     buildonly-randconfig-003-20250322    clang-20
x86_64     buildonly-randconfig-004-20250322    gcc-12
x86_64     buildonly-randconfig-005-20250322    clang-20
x86_64     buildonly-randconfig-006-20250322    gcc-12
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250322    gcc-14.2.0
xtensa               randconfig-002-20250322    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

