Return-Path: <linux-pci+bounces-39713-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 777A8C1CC6A
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 19:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDA8F18908C1
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 18:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC7A2FBDF3;
	Wed, 29 Oct 2025 18:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CN39V0tF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5502C08BA
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 18:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761762439; cv=none; b=kzSGyA6xEf7rxqjklKLJE6940QNbAgy0emIoqVKpbD3WI4LQIIwkKIuUuDxXAZHyk0lRXV6+0p0FXAze+U0h4rv7nn7aCnRHqf3M1ySm6S0NHH+UU2ZMogQwSbGJ5aLIFDmsqM6qY5r1hX69OwokmW4uCgpSvLt/WSNAMRz7GJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761762439; c=relaxed/simple;
	bh=5XLVwkPx3YdDzfhAHwQxWePeLm5KTvs1MVgh7bCcf8c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WBxAuaiqYZvm01vYQqfkwGsTYLKThvwCyjiYoAspnN91xGLtu0/nvlj8V/uvKJBKMF0Niqct+tlq9HYCPhaZo/fxk0ghA0tOVhS7p0l7S0cvLaubJ7CPMZsHWSq6NMrbdcqljl38NEG8qEyU4cHmRbv+E/asp65mODhFkzHgrQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CN39V0tF; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761762437; x=1793298437;
  h=date:from:to:cc:subject:message-id;
  bh=5XLVwkPx3YdDzfhAHwQxWePeLm5KTvs1MVgh7bCcf8c=;
  b=CN39V0tFkkffFf0aPEXPjTA4qXxdNX1H782obmHU73/61QgMOp1lmCNX
   bwW98ltG9Q9bdXKy9HWYalM6C+zHx0CVcaamiRakShQRrGqibvxS3l88A
   nRy73EWrO2jgwaTUXEAUtQEXBGOU18aWTe384zJMWdEiiGZujrvq3QGhn
   wjvjLcBqd+M6ujSPyxKnkB9vYk9cMRga3/iuipl9EU9Ci90PBqq4JrBul
   fR+6gIq5zly2FruM3NzDcDLVm8BfNBZurEPoBfU3/D9hczkFLzSmz2lmK
   LXvLk4v2BGDRa9bnI2TdQKXDnCJev7eVp6KO5Eldwwx0GZ7jAj8xKUHSW
   Q==;
X-CSE-ConnectionGUID: XoFan2rlQQyyllfCmPbI5g==
X-CSE-MsgGUID: EK+phwS1TIu3UMnvXMou+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="62918318"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="62918318"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 11:27:16 -0700
X-CSE-ConnectionGUID: e7VZJ5TyTUeiUXZDPiAozA==
X-CSE-MsgGUID: 2/8nnOMsS6OfxxUhDUL8sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="185621781"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 29 Oct 2025 11:27:15 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEAt7-000KzY-0v;
	Wed, 29 Oct 2025 18:27:13 +0000
Date: Thu, 30 Oct 2025 02:19:39 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/brcmstb] BUILD SUCCESS
 9583f9d22991d2cfb5cc59a2552040c4ae98d998
Message-ID: <202510300233.QHqaYNVP-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/brcmstb
branch HEAD: 9583f9d22991d2cfb5cc59a2552040c4ae98d998  PCI: brcmstb: Fix disabling L0s capability

elapsed time: 1450m

configs tested: 133
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20251029    gcc-15.1.0
arc                   randconfig-002-20251029    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                     am200epdkit_defconfig    gcc-15.1.0
arm                        clps711x_defconfig    clang-22
arm                   randconfig-001-20251029    gcc-8.5.0
arm                   randconfig-002-20251029    clang-22
arm                   randconfig-003-20251029    clang-22
arm                   randconfig-004-20251029    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251029    gcc-12.5.0
arm64                 randconfig-002-20251029    clang-22
arm64                 randconfig-003-20251029    gcc-13.4.0
arm64                 randconfig-004-20251029    gcc-11.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                  randconfig-001-20251029    gcc-9.5.0
csky                  randconfig-002-20251029    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20251029    clang-20
hexagon               randconfig-002-20251029    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251029    gcc-14
i386        buildonly-randconfig-002-20251029    gcc-14
i386        buildonly-randconfig-003-20251029    clang-20
i386        buildonly-randconfig-004-20251029    gcc-14
i386        buildonly-randconfig-005-20251029    gcc-14
i386        buildonly-randconfig-006-20251029    gcc-14
i386                  randconfig-001-20251029    gcc-14
i386                  randconfig-002-20251029    gcc-14
i386                  randconfig-003-20251029    clang-20
i386                  randconfig-004-20251029    gcc-14
i386                  randconfig-005-20251029    clang-20
i386                  randconfig-006-20251029    gcc-14
i386                  randconfig-007-20251029    clang-20
i386                  randconfig-011-20251029    gcc-14
i386                  randconfig-012-20251029    clang-20
i386                  randconfig-013-20251029    gcc-14
i386                  randconfig-014-20251029    gcc-14
i386                  randconfig-015-20251029    gcc-14
i386                  randconfig-016-20251029    gcc-14
i386                  randconfig-017-20251029    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251029    clang-22
loongarch             randconfig-002-20251029    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                          hp300_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251029    gcc-11.5.0
nios2                 randconfig-002-20251029    gcc-9.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                randconfig-001-20251029    gcc-12.5.0
parisc                randconfig-002-20251029    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      katmai_defconfig    clang-22
powerpc                     mpc83xx_defconfig    clang-22
powerpc               randconfig-001-20251029    clang-22
powerpc               randconfig-002-20251029    gcc-12.5.0
powerpc64             randconfig-001-20251029    clang-22
powerpc64             randconfig-002-20251029    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20251029    clang-20
riscv                 randconfig-002-20251029    clang-19
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20251029    gcc-11.5.0
s390                  randconfig-002-20251029    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                          landisk_defconfig    gcc-15.1.0
sh                    randconfig-001-20251029    gcc-11.5.0
sh                    randconfig-002-20251029    gcc-15.1.0
sh                     sh7710voipgw_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20251029    gcc-8.5.0
sparc                 randconfig-002-20251029    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251029    clang-20
sparc64               randconfig-002-20251029    clang-22
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251029    clang-22
um                    randconfig-002-20251029    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251029    gcc-14
x86_64      buildonly-randconfig-002-20251029    clang-20
x86_64      buildonly-randconfig-003-20251029    clang-20
x86_64      buildonly-randconfig-004-20251029    clang-20
x86_64      buildonly-randconfig-005-20251029    clang-20
x86_64      buildonly-randconfig-006-20251029    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-011-20251029    clang-20
x86_64                randconfig-012-20251029    clang-20
x86_64                randconfig-013-20251029    gcc-14
x86_64                randconfig-014-20251029    clang-20
x86_64                randconfig-015-20251029    gcc-13
x86_64                randconfig-016-20251029    gcc-13
x86_64                randconfig-071-20251029    clang-20
x86_64                randconfig-072-20251029    clang-20
x86_64                randconfig-073-20251029    gcc-14
x86_64                randconfig-074-20251029    gcc-14
x86_64                randconfig-075-20251029    gcc-14
x86_64                randconfig-076-20251029    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251029    gcc-8.5.0
xtensa                randconfig-002-20251029    gcc-8.5.0
xtensa                    smp_lx200_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

