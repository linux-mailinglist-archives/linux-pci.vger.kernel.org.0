Return-Path: <linux-pci+bounces-24448-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CA5A6CD04
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 23:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77F271707BB
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 22:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1261D18A6B8;
	Sat, 22 Mar 2025 22:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FJFxOM8m"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4170D14386D
	for <linux-pci@vger.kernel.org>; Sat, 22 Mar 2025 22:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742683867; cv=none; b=MzyADun7rvurbudEmUHXZCYWQ28id3fQYW6j99JYTHo7f+kPXDlzRDn6qWDbpzt3k1RkHKIMSncO1y+A0k2cAVWoeCMlkzyC+oz9oBliwBcBrGAezNPvnFOqMed13bdkC073biFDtbX56E5gMdvSw3qIw41EUw4ZXHfelA3vC/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742683867; c=relaxed/simple;
	bh=hmNlKpHkjx6OQTgLjD3YOJskM/lQWmLq+Qcciv8XKpM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ei0MDQtT9iwMOFVDyGjKT9beN/4ELw1AnQjEmUs5jc6z3SAjC0j9prMCvwFIHEvzP0s3J2B1QFvi2ozseYBl0L4ZRQy4zZ349jh9aSV1IVi1llL2vrYP5KLlrmjDHh2Y9nQYx1MRY+G+u0A9AFoUxAiXXSCt6Db10dvUdxlota0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FJFxOM8m; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742683865; x=1774219865;
  h=date:from:to:cc:subject:message-id;
  bh=hmNlKpHkjx6OQTgLjD3YOJskM/lQWmLq+Qcciv8XKpM=;
  b=FJFxOM8m1djUs7J6TNDd8dr8WNgclQONHkZPzH3PYIFO5B6giAMMBfBr
   Se7cimQ7NmG60aV+h2Z8gu1oveU99hvlzCXaG4AjulFwDaqlKQXJ7vZeD
   jcb5BDaUNDwM9zxm9pfFU5ZGzE/kg8Y6KRT3K9Lvh41Z6gtsECAeUwzCS
   hAaTD1lTo3CyO0cOypa7Gu6t8kFegv6OnNUmULSHJw97jnkCYRSoKONx7
   p/atv+zEj/qARkPT32SSOH0G6a5mseXlXFzkWGZLHnM3Ibt16JYfye0ZT
   FC8Qdd6zXl12ruAHgMigHcFOAVdFVbsvzD6Elg7kiJkj+jFONbt8cX+cx
   A==;
X-CSE-ConnectionGUID: 5oUZSnvpRaOvv+8lRrWJOA==
X-CSE-MsgGUID: 67kloJKqQoWB55VmF7AQkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11381"; a="44044361"
X-IronPort-AV: E=Sophos;i="6.14,268,1736841600"; 
   d="scan'208";a="44044361"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2025 15:51:04 -0700
X-CSE-ConnectionGUID: Den7l3lGTmmQSI1Y9uOQYw==
X-CSE-MsgGUID: T8J0V9v8TfmUnsEureQDmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,268,1736841600"; 
   d="scan'208";a="128760460"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 22 Mar 2025 15:51:03 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tw7gD-0002RL-0H;
	Sat, 22 Mar 2025 22:51:01 +0000
Date: Sun, 23 Mar 2025 06:50:14 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:doe] BUILD SUCCESS
 6fc6ded50ffc09a5cb3a9ec22dd1976401ea0bbc
Message-ID: <202503230608.c9hhWi9v-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git doe
branch HEAD: 6fc6ded50ffc09a5cb3a9ec22dd1976401ea0bbc  PCI/DOE: Allow enabling DOE without CXL

elapsed time: 1443m

configs tested: 86
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                             allmodconfig    gcc-14.2.0
arc                             allyesconfig    gcc-14.2.0
arc                nsimosci_hs_smp_defconfig    gcc-14.2.0
arc                  randconfig-001-20250322    gcc-10.5.0
arc                  randconfig-002-20250322    gcc-8.5.0
arm                             allmodconfig    gcc-14.2.0
arm                             allyesconfig    gcc-14.2.0
arm                  randconfig-001-20250322    gcc-7.5.0
arm                  randconfig-002-20250322    gcc-7.5.0
arm                  randconfig-003-20250322    clang-21
arm                  randconfig-004-20250322    clang-19
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
loongarch                       allmodconfig    gcc-14.2.0
loongarch            randconfig-001-20250322    gcc-14.2.0
loongarch            randconfig-002-20250322    gcc-14.2.0
m68k                            allmodconfig    gcc-14.2.0
m68k                            allyesconfig    gcc-14.2.0
mips                        bigsur_defconfig    gcc-14.2.0
nios2                randconfig-001-20250322    gcc-6.5.0
nios2                randconfig-002-20250322    gcc-10.5.0
openrisc                         allnoconfig    gcc-14.2.0
openrisc                        allyesconfig    gcc-14.2.0
parisc                          allmodconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc                          allyesconfig    gcc-14.2.0
parisc               randconfig-001-20250322    gcc-5.5.0
parisc               randconfig-002-20250322    gcc-13.3.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc              randconfig-001-20250322    clang-21
powerpc              randconfig-002-20250322    gcc-8.5.0
powerpc              randconfig-003-20250322    clang-21
powerpc64            randconfig-001-20250322    clang-21
powerpc64            randconfig-002-20250322    gcc-8.5.0
powerpc64            randconfig-003-20250322    gcc-8.5.0
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20250322    gcc-8.5.0
riscv                randconfig-002-20250322    clang-21
s390                            allmodconfig    clang-18
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

