Return-Path: <linux-pci+bounces-44197-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0C7CFE610
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 15:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D90F300B9A4
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 14:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7038C34EEFA;
	Wed,  7 Jan 2026 14:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="McG9VQaS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846C034EEFB
	for <linux-pci@vger.kernel.org>; Wed,  7 Jan 2026 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796974; cv=none; b=gx1Gt77zD7qBJsvTQnO4fYa2GH5vnH/v8bQE5Bsrn4SqHHpFjNdO/mn6JzGhcKrWULwG9l5Olr/8IH8VSa7yxt4/f9CGNJ9FvLLby9rfxRnUgZAQxrdrbpIxyKh7BCUvst5DLxgZspjfJmqQwcLHOiB0tmrcFosvIC87jNCVGmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796974; c=relaxed/simple;
	bh=C3WAS3wAHhMmwle4xKaNg7CWNeuVhykAO4PnIFV45VQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sQg2fImrfVDOp1WuPAZ6IBUP/Q1PUK7sYe+uDMr35zz88DQ90LfaIva1EIEc+HnFkwioMEHuWhkTdw/eumadnZy5ovsL4UZ0N4EfVDp1yyQ4lz2S7vnGwVOfviZzNSDAnm+o4u69BTSOvgWCzhokctUgfR8U+gl6ZnmgeHBwJ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=McG9VQaS; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767796972; x=1799332972;
  h=date:from:to:cc:subject:message-id;
  bh=C3WAS3wAHhMmwle4xKaNg7CWNeuVhykAO4PnIFV45VQ=;
  b=McG9VQaSQvhGBRG/PWanbePWX0P0CTqcBv/UhcYwZd0Jcg9fyxYuj0Gc
   +KPL73KQy5fAzHzTo2DAcTldxg3QuJLrRKEaQ4LL85Qip83Tp+UEqN5Fm
   R1PqnX0SHoYXOLaG++OvrVvi5EYR1aBduQoXq05PGuoPtzHZhFHsvLq7Y
   RCIih9RbANUtLvHWTlhOoYYQaCBiB31wwk+P6en/iinYfnbOoVGgdllzl
   oWEamXEJlFNXoG7gVtBezRNoiL5uBx1XTuhL0XwsywISHtxbBOpXRSPPq
   3vnC65oGl3v46FmhfcTtclrdWaIQQCVfbRhAhUYpGXXmXpk+ILblolnb9
   A==;
X-CSE-ConnectionGUID: Ow4jnrykTZef35mzFN7wFQ==
X-CSE-MsgGUID: 0xphM0y2QoiSJ+qYlLUDlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="69216261"
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="69216261"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 06:42:52 -0800
X-CSE-ConnectionGUID: u23ByqRRQfa8DkAaLtYZVw==
X-CSE-MsgGUID: 5aCgf6yxRiyxCks2A9dfcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="202146121"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 07 Jan 2026 06:42:51 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vdUkK-000000003tR-16ef;
	Wed, 07 Jan 2026 14:42:48 +0000
Date: Wed, 07 Jan 2026 22:42:23 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-imx6] BUILD SUCCESS
 d5fb0afbf635d7539c34447ea3e8c0473710c92d
Message-ID: <202601072215.RVRKqq70-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-imx6
branch HEAD: d5fb0afbf635d7539c34447ea3e8c0473710c92d  PCI: imx6: Clear CLKREQ# override if 'supports-clkreq' DT property is available

elapsed time: 1542m

configs tested: 217
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.1.0
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20260107    gcc-14.3.0
arc                   randconfig-002-20260107    gcc-14.3.0
arc                   randconfig-002-20260107    gcc-8.5.0
arc                           tb10x_defconfig    gcc-15.1.0
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                     am200epdkit_defconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                                 defconfig    gcc-15.1.0
arm                   randconfig-001-20260107    gcc-10.5.0
arm                   randconfig-001-20260107    gcc-14.3.0
arm                   randconfig-002-20260107    clang-22
arm                   randconfig-002-20260107    gcc-14.3.0
arm                   randconfig-003-20260107    clang-22
arm                   randconfig-003-20260107    gcc-14.3.0
arm                   randconfig-004-20260107    gcc-10.5.0
arm                   randconfig-004-20260107    gcc-14.3.0
arm                        vexpress_defconfig    clang-18
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20260107    clang-22
arm64                 randconfig-002-20260107    clang-22
arm64                 randconfig-003-20260107    clang-22
arm64                 randconfig-003-20260107    gcc-8.5.0
arm64                 randconfig-004-20260107    clang-22
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20260107    clang-22
csky                  randconfig-001-20260107    gcc-15.1.0
csky                  randconfig-002-20260107    clang-22
csky                  randconfig-002-20260107    gcc-9.5.0
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    clang-22
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20260107    clang-22
hexagon               randconfig-001-20260107    gcc-8.5.0
hexagon               randconfig-002-20260107    clang-22
hexagon               randconfig-002-20260107    gcc-8.5.0
i386                              allnoconfig    gcc-15.1.0
i386        buildonly-randconfig-001-20260107    gcc-14
i386        buildonly-randconfig-002-20260107    gcc-14
i386        buildonly-randconfig-003-20260107    clang-20
i386        buildonly-randconfig-003-20260107    gcc-14
i386        buildonly-randconfig-004-20260107    gcc-14
i386        buildonly-randconfig-005-20260107    clang-20
i386        buildonly-randconfig-005-20260107    gcc-14
i386        buildonly-randconfig-006-20260107    clang-20
i386        buildonly-randconfig-006-20260107    gcc-14
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20260107    clang-20
i386                  randconfig-001-20260107    gcc-14
i386                  randconfig-002-20260107    clang-20
i386                  randconfig-002-20260107    gcc-14
i386                  randconfig-003-20260107    clang-20
i386                  randconfig-003-20260107    gcc-14
i386                  randconfig-004-20260107    clang-20
i386                  randconfig-004-20260107    gcc-14
i386                  randconfig-005-20260107    clang-20
i386                  randconfig-005-20260107    gcc-14
i386                  randconfig-006-20260107    clang-20
i386                  randconfig-006-20260107    gcc-14
i386                  randconfig-007-20260107    clang-20
i386                  randconfig-011-20260107    clang-20
i386                  randconfig-011-20260107    gcc-13
i386                  randconfig-012-20260107    clang-20
i386                  randconfig-012-20260107    gcc-14
i386                  randconfig-013-20260107    clang-20
i386                  randconfig-014-20260107    clang-20
i386                  randconfig-014-20260107    gcc-14
i386                  randconfig-015-20260107    clang-20
i386                  randconfig-016-20260107    clang-20
i386                  randconfig-017-20260107    clang-20
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260107    gcc-15.1.0
loongarch             randconfig-001-20260107    gcc-8.5.0
loongarch             randconfig-002-20260107    gcc-15.1.0
loongarch             randconfig-002-20260107    gcc-8.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    gcc-15.1.0
m68k                           sun3_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                          eyeq6_defconfig    clang-18
mips                          rb532_defconfig    clang-18
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260107    gcc-8.5.0
nios2                 randconfig-002-20260107    gcc-8.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20260107    clang-22
parisc                randconfig-001-20260107    gcc-8.5.0
parisc                randconfig-002-20260107    clang-22
parisc                randconfig-002-20260107    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                     akebono_defconfig    clang-22
powerpc                           allnoconfig    clang-22
powerpc                          g5_defconfig    clang-18
powerpc                   lite5200b_defconfig    clang-18
powerpc               randconfig-001-20260107    clang-22
powerpc               randconfig-002-20260107    clang-22
powerpc               randconfig-002-20260107    gcc-8.5.0
powerpc                      tqm8xx_defconfig    clang-19
powerpc64             randconfig-001-20260107    clang-22
powerpc64             randconfig-001-20260107    gcc-14.3.0
powerpc64             randconfig-002-20260107    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20260107    clang-22
riscv                 randconfig-002-20260107    clang-22
riscv                 randconfig-002-20260107    gcc-9.5.0
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20260107    clang-22
s390                  randconfig-002-20260107    clang-22
sh                               alldefconfig    clang-18
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20260107    clang-22
sh                    randconfig-001-20260107    gcc-12.5.0
sh                    randconfig-002-20260107    clang-22
sh                    randconfig-002-20260107    gcc-12.5.0
sh                           se7750_defconfig    gcc-15.1.0
sh                        sh7763rdp_defconfig    gcc-15.1.0
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20260107    gcc-15.1.0
sparc                 randconfig-001-20260107    gcc-8.5.0
sparc                 randconfig-002-20260107    gcc-11.5.0
sparc                 randconfig-002-20260107    gcc-15.1.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260107    clang-22
sparc64               randconfig-001-20260107    gcc-15.1.0
sparc64               randconfig-002-20260107    gcc-10.5.0
sparc64               randconfig-002-20260107    gcc-15.1.0
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    clang-22
um                             i386_defconfig    clang-18
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260107    clang-16
um                    randconfig-001-20260107    gcc-15.1.0
um                    randconfig-002-20260107    clang-22
um                    randconfig-002-20260107    gcc-15.1.0
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64      buildonly-randconfig-001-20260107    gcc-14
x86_64      buildonly-randconfig-002-20260107    gcc-14
x86_64      buildonly-randconfig-003-20260107    gcc-14
x86_64      buildonly-randconfig-004-20260107    clang-20
x86_64      buildonly-randconfig-004-20260107    gcc-14
x86_64      buildonly-randconfig-005-20260107    gcc-14
x86_64      buildonly-randconfig-006-20260107    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260107    clang-20
x86_64                randconfig-002-20260107    clang-20
x86_64                randconfig-003-20260107    clang-20
x86_64                randconfig-004-20260107    clang-20
x86_64                randconfig-004-20260107    gcc-13
x86_64                randconfig-005-20260107    clang-20
x86_64                randconfig-006-20260107    clang-20
x86_64                randconfig-011-20260107    clang-20
x86_64                randconfig-011-20260107    gcc-12
x86_64                randconfig-012-20260107    clang-20
x86_64                randconfig-012-20260107    gcc-14
x86_64                randconfig-013-20260107    clang-20
x86_64                randconfig-014-20260107    clang-20
x86_64                randconfig-015-20260107    clang-20
x86_64                randconfig-016-20260107    clang-20
x86_64                randconfig-071-20260107    clang-20
x86_64                randconfig-071-20260107    gcc-14
x86_64                randconfig-072-20260107    clang-20
x86_64                randconfig-073-20260107    clang-20
x86_64                randconfig-073-20260107    gcc-14
x86_64                randconfig-074-20260107    clang-20
x86_64                randconfig-074-20260107    gcc-14
x86_64                randconfig-075-20260107    clang-20
x86_64                randconfig-076-20260107    clang-20
x86_64                randconfig-076-20260107    gcc-14
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                  nommu_kc705_defconfig    clang-18
xtensa                randconfig-001-20260107    gcc-15.1.0
xtensa                randconfig-001-20260107    gcc-8.5.0
xtensa                randconfig-002-20260107    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

