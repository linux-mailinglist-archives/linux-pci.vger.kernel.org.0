Return-Path: <linux-pci+bounces-17202-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E967F9D5BD5
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 10:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C6D0B256C8
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 09:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698901D3576;
	Fri, 22 Nov 2024 09:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V/3+DhHv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A552F1DB55C
	for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2024 09:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732267270; cv=none; b=OnFnWjzPOdfU/J1WOu2UyoZ5rzCwzFtfTayIV0X9/mhhmiMJtfbPJ5kCuqRlY9cyeyLHVSj04Txmwf3SjYoHkqGziUPUhREhIvQLAmavJfLntTq+21ob+jGVpy+jCOr/uMJhklj8r7BxbGUDk9ZpT4Y+eXBNsWUgvlHZSofcEYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732267270; c=relaxed/simple;
	bh=cofUx19QGSWKbMTgEkhoeQMYXwW6gculaWJn/jIioCU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IuCTHHi+FYCPFbLcu6lUXk5uRMpTKLJCZL3x3Pxx+JOZEiHTOJ8bhFnH8Lufr1JsIZSOVsWPG1LyIMwNcQIiT28d4CzmuJtueJGjk0qvHR0E96Ds3svSkfcygI4oHE7hFLzI+6iCelhm0194fLEY2+OWMCq0fwEhSnVC3FRp52k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V/3+DhHv; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732267269; x=1763803269;
  h=date:from:to:cc:subject:message-id;
  bh=cofUx19QGSWKbMTgEkhoeQMYXwW6gculaWJn/jIioCU=;
  b=V/3+DhHvb3eVlR0OqheS/5ZKx7YgDHD0QKd/tNCXGHIuxih7chKMjlIw
   wEHmhy46sVqpvdg9EJB7MiNyXAI+atbV+vfmaXrfF3nibFMdyKT8+thOw
   4SwklPtWfjIrj5jzs7Rmx21x16yeE7J463HCJCIT3grAM/ndFCMNdBBOk
   x7BBd8nL6D/TQvE2+2TJbkUcxrbMM5XKyCh7UpkZBWnB0SU0LxzoIPgPW
   XrayqDgJDJGqhq27hF5eXPZdvHQYRb6x8DyvY/KrxnTvketsJnOGXBcCT
   NdOegSQpUFssxxIwROkijm3taE4MOIj6s/+ps5Vy4TIWCcCtb3IF9hpJZ
   w==;
X-CSE-ConnectionGUID: RbQVzyCiTO+Ub53CflX3DQ==
X-CSE-MsgGUID: TOXg8z++QeC+Q4DwlqlM9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="35275191"
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="35275191"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 01:21:09 -0800
X-CSE-ConnectionGUID: r+8TeTqwQBKzClogh2M3pg==
X-CSE-MsgGUID: nZNr/XhvTLKJ1GzC6OHc3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="121390501"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 22 Nov 2024 01:21:07 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEPqa-0003nv-2u;
	Fri, 22 Nov 2024 09:21:04 +0000
Date: Fri, 22 Nov 2024 17:20:28 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 0f3d0b32cf72a0de47f15cf22ba2738cd51170c3
Message-ID: <202411221721.l3shOlxk-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 0f3d0b32cf72a0de47f15cf22ba2738cd51170c3  Merge branch 'pci/typos'

elapsed time: 998m

configs tested: 135
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20241122    gcc-13.2.0
arc                   randconfig-002-20241122    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20241122    clang-17
arm                   randconfig-002-20241122    gcc-14.2.0
arm                   randconfig-003-20241122    clang-20
arm                   randconfig-004-20241122    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241122    gcc-14.2.0
arm64                 randconfig-002-20241122    gcc-14.2.0
arm64                 randconfig-003-20241122    gcc-14.2.0
arm64                 randconfig-004-20241122    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20241122    gcc-14.2.0
csky                  randconfig-002-20241122    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20241122    clang-20
hexagon               randconfig-002-20241122    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241122    clang-19
i386        buildonly-randconfig-002-20241122    clang-19
i386        buildonly-randconfig-003-20241122    clang-19
i386        buildonly-randconfig-004-20241122    clang-19
i386        buildonly-randconfig-005-20241122    gcc-12
i386        buildonly-randconfig-006-20241122    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241122    gcc-12
i386                  randconfig-002-20241122    clang-19
i386                  randconfig-003-20241122    gcc-12
i386                  randconfig-004-20241122    clang-19
i386                  randconfig-005-20241122    gcc-12
i386                  randconfig-006-20241122    gcc-12
i386                  randconfig-011-20241122    gcc-12
i386                  randconfig-012-20241122    gcc-12
i386                  randconfig-013-20241122    gcc-12
i386                  randconfig-014-20241122    gcc-12
i386                  randconfig-015-20241122    gcc-12
i386                  randconfig-016-20241122    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241122    gcc-14.2.0
loongarch             randconfig-002-20241122    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241122    gcc-14.2.0
nios2                 randconfig-002-20241122    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241122    gcc-14.2.0
parisc                randconfig-002-20241122    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-20
powerpc               randconfig-002-20241122    clang-20
powerpc64             randconfig-001-20241122    gcc-14.2.0
powerpc64             randconfig-002-20241122    gcc-14.2.0
powerpc64             randconfig-003-20241122    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-20
riscv                 randconfig-001-20241122    gcc-14.2.0
riscv                 randconfig-002-20241122    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-20
s390                  randconfig-001-20241122    clang-20
s390                  randconfig-002-20241122    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20241122    gcc-14.2.0
sh                    randconfig-002-20241122    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241122    gcc-14.2.0
sparc64               randconfig-002-20241122    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241122    clang-17
um                    randconfig-002-20241122    gcc-11
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241122    gcc-12
x86_64      buildonly-randconfig-002-20241122    clang-19
x86_64      buildonly-randconfig-003-20241122    gcc-12
x86_64      buildonly-randconfig-004-20241122    gcc-12
x86_64      buildonly-randconfig-005-20241122    clang-19
x86_64      buildonly-randconfig-006-20241122    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241122    gcc-12
x86_64                randconfig-002-20241122    clang-19
x86_64                randconfig-003-20241122    gcc-12
x86_64                randconfig-004-20241122    clang-19
x86_64                randconfig-005-20241122    gcc-12
x86_64                randconfig-006-20241122    clang-19
x86_64                randconfig-012-20241122    gcc-12
x86_64                randconfig-013-20241122    gcc-12
x86_64                randconfig-014-20241122    gcc-12
x86_64                randconfig-015-20241122    gcc-12
x86_64                randconfig-016-20241122    gcc-12
x86_64                               rhel-9.4    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241122    gcc-14.2.0
xtensa                randconfig-002-20241122    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

