Return-Path: <linux-pci+bounces-30977-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31268AEC1FF
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 23:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1696C7AE60D
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 21:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C1D272E5C;
	Fri, 27 Jun 2025 21:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KV2MP1as"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2981DFE09
	for <linux-pci@vger.kernel.org>; Fri, 27 Jun 2025 21:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751059429; cv=none; b=QQOGFR/ZSOUeTCR/uBtCavVsVfWcooYXDco2AyDKFA20Z3lyfopDalQc6043K9guXfGlpCh7S9KmXShDERREdcb4xbvEcvOp0fn9w0xmP/9aEqL8fI7OmPI8fgiKR9Y2vUO92c7HUQWYrBdQdHW9yTR9MDnWeDHaVkB3YYQZGQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751059429; c=relaxed/simple;
	bh=BYsY53zQNLvPRQN3zkzxLUTSq9e6GHneRt+CtkgfOrc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=B5cDwaNihAGLk5euEBLBEtvT0FkAWSbiMjxcE5WNhVCSlllbvpI3ovAtxKQMgBqCJk2qX/xzqapvjOhxqQ8fn1W81yQBbp9u2L+++K6eiZlNKaxFoZgWe/Al/cvzu7XBI/sZhEkJIpbtCKYE2KmwUeyrUtNdGe3C4cVBMHzyqN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KV2MP1as; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751059427; x=1782595427;
  h=date:from:to:cc:subject:message-id;
  bh=BYsY53zQNLvPRQN3zkzxLUTSq9e6GHneRt+CtkgfOrc=;
  b=KV2MP1asmwv/SJBqHKgfKnL4SYguLUBo5BIKftGZr7PXQgp7EJASuZov
   xB3pzQBXkOWuyl0rlXTr+75XUwQ0NqTSf6GzaGRFuOU8vxdwYWD71FWEl
   FfNolpYwJa/wAao0qCKMgFFxH1WPz4l5SJHY1GZOLHCUc3flEvVqqg2F3
   A7h8lx4vJWuYBztWS/B87qP3LzK0BE8lxAZ58/XfLzjPeXaqAZGd4Bb3I
   LttlAjDX3h0uc9X0ii69ymIxPXT35MDA5Xb5lU91rbaDidkrO/f6Btxyf
   nlgV1y8JerHJfwgK7longWRUqRKbyEwoaiS6rts+twaq0vJstRLQBO24Z
   g==;
X-CSE-ConnectionGUID: ZNpSDF/YTSaQGnzHLrd+Fg==
X-CSE-MsgGUID: ex29W5F6S0uF2vj+VnoxNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="64825454"
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="64825454"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 14:23:47 -0700
X-CSE-ConnectionGUID: 4ok3M4i9TuqrOfgRjXSawg==
X-CSE-MsgGUID: QfjmkKi4Rfas8bF+JzNDjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="152522940"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 27 Jun 2025 14:23:46 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uVGXv-000WYG-2o;
	Fri, 27 Jun 2025 21:23:43 +0000
Date: Sat, 28 Jun 2025 05:23:13 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:aer] BUILD SUCCESS
 a6f494becf09c9ebba72ed67d3728f6811daa634
Message-ID: <202506280503.KiJwL3tH-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git aer
branch HEAD: a6f494becf09c9ebba72ed67d3728f6811daa634  PCI/AER: Add message when AER_MAX_MULTI_ERR_DEVICES limit is hit

elapsed time: 1451m

configs tested: 229
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              alldefconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250627    gcc-10.5.0
arc                   randconfig-001-20250627    gcc-8.5.0
arc                   randconfig-002-20250627    gcc-10.5.0
arc                   randconfig-002-20250627    gcc-12.4.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    gcc-15.1.0
arm                   randconfig-001-20250627    gcc-10.5.0
arm                   randconfig-001-20250627    gcc-15.1.0
arm                   randconfig-002-20250627    gcc-10.5.0
arm                   randconfig-003-20250627    clang-21
arm                   randconfig-003-20250627    gcc-10.5.0
arm                   randconfig-004-20250627    gcc-10.5.0
arm                   randconfig-004-20250627    gcc-8.5.0
arm                           stm32_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250627    clang-17
arm64                 randconfig-001-20250627    gcc-10.5.0
arm64                 randconfig-002-20250627    gcc-10.5.0
arm64                 randconfig-003-20250627    gcc-10.5.0
arm64                 randconfig-003-20250627    gcc-12.3.0
arm64                 randconfig-004-20250627    clang-19
arm64                 randconfig-004-20250627    gcc-10.5.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250627    clang-21
csky                  randconfig-001-20250627    gcc-15.1.0
csky                  randconfig-002-20250627    clang-21
csky                  randconfig-002-20250627    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20250627    clang-21
hexagon               randconfig-002-20250627    clang-21
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250627    gcc-12
i386        buildonly-randconfig-002-20250627    gcc-12
i386        buildonly-randconfig-003-20250627    gcc-12
i386        buildonly-randconfig-004-20250627    gcc-12
i386        buildonly-randconfig-005-20250627    clang-20
i386        buildonly-randconfig-005-20250627    gcc-12
i386        buildonly-randconfig-006-20250627    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250628    clang-20
i386                  randconfig-002-20250628    clang-20
i386                  randconfig-003-20250628    clang-20
i386                  randconfig-004-20250628    clang-20
i386                  randconfig-005-20250628    clang-20
i386                  randconfig-006-20250628    clang-20
i386                  randconfig-007-20250628    clang-20
i386                  randconfig-011-20250627    gcc-12
i386                  randconfig-012-20250627    gcc-12
i386                  randconfig-013-20250627    gcc-12
i386                  randconfig-014-20250627    gcc-12
i386                  randconfig-015-20250627    gcc-12
i386                  randconfig-016-20250627    gcc-12
i386                  randconfig-017-20250627    gcc-12
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250627    clang-21
loongarch             randconfig-001-20250627    gcc-15.1.0
loongarch             randconfig-002-20250627    clang-21
loongarch             randconfig-002-20250627    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                         amcore_defconfig    clang-21
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          eyeq6_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250627    clang-21
nios2                 randconfig-001-20250627    gcc-8.5.0
nios2                 randconfig-002-20250627    clang-21
nios2                 randconfig-002-20250627    gcc-8.5.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
openrisc                  or1klitex_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250627    clang-21
parisc                randconfig-001-20250627    gcc-9.3.0
parisc                randconfig-002-20250627    clang-21
parisc                randconfig-002-20250627    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                    amigaone_defconfig    clang-21
powerpc                        fsp2_defconfig    clang-21
powerpc               mpc834x_itxgp_defconfig    clang-21
powerpc               randconfig-001-20250627    clang-21
powerpc               randconfig-001-20250627    gcc-15.1.0
powerpc               randconfig-002-20250627    clang-21
powerpc               randconfig-003-20250627    clang-21
powerpc               randconfig-003-20250627    gcc-15.1.0
powerpc                     sequoia_defconfig    gcc-15.1.0
powerpc                     taishan_defconfig    clang-21
powerpc                     tqm8541_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250627    clang-21
powerpc64             randconfig-001-20250627    gcc-12.4.0
powerpc64             randconfig-002-20250627    clang-21
powerpc64             randconfig-002-20250627    gcc-10.5.0
powerpc64             randconfig-003-20250627    clang-21
powerpc64             randconfig-003-20250627    gcc-8.5.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250627    gcc-11.5.0
riscv                 randconfig-001-20250627    gcc-8.5.0
riscv                 randconfig-002-20250627    gcc-11.5.0
riscv                 randconfig-002-20250627    gcc-13.3.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250627    clang-21
s390                  randconfig-001-20250627    gcc-11.5.0
s390                  randconfig-002-20250627    clang-21
s390                  randconfig-002-20250627    gcc-11.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                          r7785rp_defconfig    gcc-15.1.0
sh                    randconfig-001-20250627    gcc-11.5.0
sh                    randconfig-001-20250627    gcc-9.3.0
sh                    randconfig-002-20250627    gcc-11.5.0
sh                    randconfig-002-20250627    gcc-15.1.0
sh                          sdk7786_defconfig    clang-21
sh                           se7343_defconfig    clang-21
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250627    gcc-11.5.0
sparc                 randconfig-002-20250627    gcc-11.5.0
sparc                 randconfig-002-20250627    gcc-8.5.0
sparc64                          alldefconfig    clang-21
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250627    gcc-11.5.0
sparc64               randconfig-002-20250627    gcc-11.5.0
sparc64               randconfig-002-20250627    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250627    gcc-11.5.0
um                    randconfig-001-20250627    gcc-12
um                    randconfig-002-20250627    gcc-11.5.0
um                    randconfig-002-20250627    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250627    clang-20
x86_64      buildonly-randconfig-002-20250627    clang-20
x86_64      buildonly-randconfig-003-20250627    clang-20
x86_64      buildonly-randconfig-004-20250627    clang-20
x86_64      buildonly-randconfig-005-20250627    clang-20
x86_64      buildonly-randconfig-005-20250627    gcc-12
x86_64      buildonly-randconfig-006-20250627    clang-20
x86_64      buildonly-randconfig-006-20250627    gcc-12
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250627    clang-20
x86_64                randconfig-002-20250627    clang-20
x86_64                randconfig-003-20250627    clang-20
x86_64                randconfig-004-20250627    clang-20
x86_64                randconfig-005-20250627    clang-20
x86_64                randconfig-006-20250627    clang-20
x86_64                randconfig-007-20250627    clang-20
x86_64                randconfig-008-20250627    clang-20
x86_64                randconfig-071-20250627    gcc-12
x86_64                randconfig-072-20250627    gcc-12
x86_64                randconfig-073-20250627    gcc-12
x86_64                randconfig-074-20250627    gcc-12
x86_64                randconfig-075-20250627    gcc-12
x86_64                randconfig-076-20250627    gcc-12
x86_64                randconfig-077-20250627    gcc-12
x86_64                randconfig-078-20250627    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250627    gcc-11.5.0
xtensa                randconfig-001-20250627    gcc-13.3.0
xtensa                randconfig-002-20250627    gcc-10.5.0
xtensa                randconfig-002-20250627    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

