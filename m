Return-Path: <linux-pci+bounces-30285-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28107AE27A7
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 08:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8759D5A219A
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 06:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407DF136988;
	Sat, 21 Jun 2025 06:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZBDVHN6v"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0763BC2F2
	for <linux-pci@vger.kernel.org>; Sat, 21 Jun 2025 06:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750488503; cv=none; b=LmfOUGgeLt9Gg135c6AIjTeOYeYjEku7te7zCXMRE/hIP67TqGjXZdplvc9ZDGUXo0GdwDjjnbD5qoAMnXTELV8D2JgZ5NRetXATmX1LTBSGIpf+jNlzYAWeLGvHbRJqNclGfcETdYMCGytQU5PigGeaQz56NlIKRZyHw3RSbl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750488503; c=relaxed/simple;
	bh=4StGqdOicD/yKnPGjxE9R/9qSEbzZejC0x7RzXian3Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MerDvkiiIkU3oCzwJWGOr3mSyu3JxkSWFzTLGkPwCzX5Fv+OQgvKvqZKqlcjQeRHCQ7XPGtU690K2Iv7LFJosltIvOaMybE+huRaVAnPZ64kSazuykRQOiCiFug4aWvIISIkUkISTJlVj0uDbm5YaX3bpIOd3MTCnUWMfOpF9pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZBDVHN6v; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750488501; x=1782024501;
  h=date:from:to:cc:subject:message-id;
  bh=4StGqdOicD/yKnPGjxE9R/9qSEbzZejC0x7RzXian3Q=;
  b=ZBDVHN6vlZzx3XbFIyGebC4vIpF67LvS8cHMCXykHr9lK0qSSNtzY9zW
   MpQyehKVE5MUVrqSCFbSyGnKjGxbCvStk6HMxiHmv+buFfHSn2qwv6Lm7
   sS4yxnf5LiBWV+OPXHQV0B5170rY6lwo0tnXRGaxUKimFvVrjzK5JBaMg
   dv0nYHMEiRM66vPIboPDl1PtNS1LWd9wZ/OK1UEsJWJXg9BrO9w20SkRk
   lFWHGd9f+T5yvg/lzsVYfBJixwpjU20eBgQsxI9bEr6gA8Nuw6lbnPwRs
   SZn8IFDWUp/MONkIZrFTmChqEzUFljqdGhF3mDofRVPIIXV3A5AaPu/Z7
   g==;
X-CSE-ConnectionGUID: hVafjudrQ5qDgHp4RHd/Kg==
X-CSE-MsgGUID: cduz/p6EQcmdy6E1/tt2/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="55389376"
X-IronPort-AV: E=Sophos;i="6.16,253,1744095600"; 
   d="scan'208";a="55389376"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 23:48:20 -0700
X-CSE-ConnectionGUID: ukiUL2vNR0qgI8unU0Zo8A==
X-CSE-MsgGUID: WxXykut3QO20BFveZPbSDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,253,1744095600"; 
   d="scan'208";a="151315450"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 20 Jun 2025 23:48:19 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uSs1Q-000MR0-37;
	Sat, 21 Jun 2025 06:48:16 +0000
Date: Sat, 21 Jun 2025 14:48:02 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dw-rockchip] BUILD SUCCESS
 c0b93754547dde16c8370b8fdad5f396e7786647
Message-ID: <202506211452.3BHYnBJb-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dw-rockchip
branch HEAD: c0b93754547dde16c8370b8fdad5f396e7786647  PCI: dw-rockchip: Delay link training after hot reset in EP mode

elapsed time: 913m

configs tested: 129
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allyesconfig    clang-19
arc                   randconfig-001-20250621    gcc-8.5.0
arc                   randconfig-002-20250621    gcc-10.5.0
arm                              allmodconfig    clang-19
arm                              allyesconfig    clang-19
arm                   randconfig-001-20250621    clang-21
arm                   randconfig-002-20250621    gcc-15.1.0
arm                   randconfig-003-20250621    clang-20
arm                   randconfig-004-20250621    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                 randconfig-001-20250621    clang-21
arm64                 randconfig-002-20250621    gcc-15.1.0
arm64                 randconfig-003-20250621    clang-17
arm64                 randconfig-004-20250621    gcc-10.5.0
csky                  randconfig-001-20250621    gcc-15.1.0
csky                  randconfig-002-20250621    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250621    clang-21
hexagon               randconfig-002-20250621    clang-16
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250621    clang-20
i386        buildonly-randconfig-002-20250621    gcc-12
i386        buildonly-randconfig-003-20250621    clang-20
i386        buildonly-randconfig-004-20250621    clang-20
i386        buildonly-randconfig-005-20250621    clang-20
i386        buildonly-randconfig-006-20250621    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch             randconfig-001-20250621    gcc-12.4.0
loongarch             randconfig-002-20250621    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250621    gcc-9.3.0
nios2                 randconfig-002-20250621    gcc-12.4.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                randconfig-001-20250621    gcc-10.5.0
parisc                randconfig-002-20250621    gcc-12.4.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20250621    clang-17
powerpc               randconfig-002-20250621    clang-19
powerpc               randconfig-003-20250621    gcc-8.5.0
powerpc64             randconfig-001-20250621    gcc-11.5.0
powerpc64             randconfig-002-20250621    gcc-13.3.0
powerpc64             randconfig-003-20250621    gcc-11.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                 randconfig-001-20250621    clang-21
riscv                 randconfig-002-20250621    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250621    clang-21
s390                  randconfig-002-20250621    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250621    gcc-15.1.0
sh                    randconfig-002-20250621    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250621    gcc-15.1.0
sparc                 randconfig-002-20250621    gcc-15.1.0
sparc64               randconfig-001-20250621    gcc-8.5.0
sparc64               randconfig-002-20250621    gcc-13.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                    randconfig-001-20250621    clang-21
um                    randconfig-002-20250621    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250620    gcc-12
x86_64      buildonly-randconfig-001-20250621    gcc-12
x86_64      buildonly-randconfig-002-20250620    gcc-12
x86_64      buildonly-randconfig-002-20250621    gcc-12
x86_64      buildonly-randconfig-003-20250620    clang-20
x86_64      buildonly-randconfig-003-20250621    gcc-12
x86_64      buildonly-randconfig-004-20250620    gcc-12
x86_64      buildonly-randconfig-004-20250621    gcc-12
x86_64      buildonly-randconfig-005-20250620    gcc-12
x86_64      buildonly-randconfig-005-20250621    gcc-12
x86_64      buildonly-randconfig-006-20250620    clang-20
x86_64      buildonly-randconfig-006-20250621    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-071-20250621    gcc-12
x86_64                randconfig-072-20250621    gcc-12
x86_64                randconfig-073-20250621    gcc-12
x86_64                randconfig-074-20250621    gcc-12
x86_64                randconfig-075-20250621    gcc-12
x86_64                randconfig-076-20250621    gcc-12
x86_64                randconfig-077-20250621    gcc-12
x86_64                randconfig-078-20250621    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250621    gcc-12.4.0
xtensa                randconfig-002-20250621    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

