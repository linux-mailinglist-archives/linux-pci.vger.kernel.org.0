Return-Path: <linux-pci+bounces-42593-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B7307CA1A9B
	for <lists+linux-pci@lfdr.de>; Wed, 03 Dec 2025 22:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 141B43004465
	for <lists+linux-pci@lfdr.de>; Wed,  3 Dec 2025 21:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682872BEC32;
	Wed,  3 Dec 2025 21:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vzsz/7Q+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D8E2D0601
	for <linux-pci@vger.kernel.org>; Wed,  3 Dec 2025 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764796897; cv=none; b=dBz1bhxTMQcfzO2rhyoaVAgM8t0ebzjxfbw9oxgmJ1QniOeexFeuQHI0ntEOulVLQzyyrQesO4Nr/RJwIwlOW+DSgrjpLHmUKzJIZ3y7Lo4TGTxkt0DaOmz7ipKlc+POLegY7TgvA0mXhJ14We9PAPZ5Oww6Ee7DVUWdUJ0+ewc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764796897; c=relaxed/simple;
	bh=vHRL0g5DLtuTYwz9lSoYI2B/bz7ZtAeI1z2vbfHLqsI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=l2AbKTKHPFuQdhEOvTRw9JyL4LInRq6nqc9Y4MVpeQ0zAKeAVYHUsmjjxnGbLcoIbJ/RjshhcpyPAC5E3JuJq58LEbSV8z+pAISFW/YA66Bh5H+EYoEb4E4OCCTfn1XZCMZ4Cm6HdxI9x0Otobcw2Lqiy08HgzN8if+573SUnkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vzsz/7Q+; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764796895; x=1796332895;
  h=date:from:to:cc:subject:message-id;
  bh=vHRL0g5DLtuTYwz9lSoYI2B/bz7ZtAeI1z2vbfHLqsI=;
  b=Vzsz/7Q+yNh/tGFT2iOEfHWwPSZigUSzu/NhoVUFDZH/jsX1JcjkUuVG
   Y7JIXTA9htGu9GwGH3M0yKZnbjKjzpcbMOKoWKaWxdZrZWvARkroNUw5x
   PVo3yACWh8nwc/3Nwv5n0whuf7opPZkiVdILx+3e/37vx7IV+UJKGWf28
   yNF/spn07zq5s9aVTC7lpk04oXXGKjG5HHk7T25KrYGDaan+ID+Y3kiWN
   yglnJim6nfFEyAYnNSS1PlKjY1AvNjDsEx+rekn+fmv5ujtFr+qelNadt
   cTo9GzS3jOF/0drUwFY5NrwRrWYrAk5jXcZtalJd8yfjWXjx5psand6F/
   w==;
X-CSE-ConnectionGUID: BnL9uLe/SVSYgTw2SA3aYQ==
X-CSE-MsgGUID: rbAwz0m2Rs23F/xvaCwkHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66847734"
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="scan'208";a="66847734"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 13:21:34 -0800
X-CSE-ConnectionGUID: RJtCaSUVSiqJtMdvw0a6ew==
X-CSE-MsgGUID: /lstRN7ST2ud/C138RfjvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="scan'208";a="199746266"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 03 Dec 2025 13:21:33 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vQuHz-00000000DA8-1Amj;
	Wed, 03 Dec 2025 21:21:31 +0000
Date: Thu, 04 Dec 2025 05:21:23 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/sky1] BUILD SUCCESS
 51f38bef0485f71c09755455df5bcf6f64320468
Message-ID: <202512040517.nEBy8Foa-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/sky1
branch HEAD: 51f38bef0485f71c09755455df5bcf6f64320468  MAINTAINERS: Add CIX Sky1 PCIe controller driver maintainer

elapsed time: 1453m

configs tested: 222
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                          axs101_defconfig    clang-22
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251203    gcc-9.5.0
arc                   randconfig-001-20251204    gcc-10.5.0
arc                   randconfig-002-20251203    gcc-11.5.0
arc                   randconfig-002-20251204    gcc-10.5.0
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                           h3600_defconfig    clang-22
arm                   randconfig-001-20251203    gcc-8.5.0
arm                   randconfig-001-20251204    gcc-10.5.0
arm                   randconfig-002-20251203    clang-22
arm                   randconfig-002-20251204    gcc-10.5.0
arm                   randconfig-003-20251203    clang-22
arm                   randconfig-003-20251204    gcc-10.5.0
arm                   randconfig-004-20251203    clang-22
arm                   randconfig-004-20251204    gcc-10.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251203    gcc-8.5.0
arm64                 randconfig-001-20251204    gcc-14.3.0
arm64                 randconfig-002-20251203    clang-17
arm64                 randconfig-002-20251204    gcc-14.3.0
arm64                 randconfig-003-20251203    gcc-8.5.0
arm64                 randconfig-003-20251204    gcc-14.3.0
arm64                 randconfig-004-20251203    gcc-8.5.0
arm64                 randconfig-004-20251204    gcc-14.3.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251203    gcc-15.1.0
csky                  randconfig-001-20251204    gcc-14.3.0
csky                  randconfig-002-20251203    gcc-15.1.0
csky                  randconfig-002-20251204    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    gcc-15.1.0
hexagon               randconfig-001-20251203    clang-22
hexagon               randconfig-001-20251204    gcc-15.1.0
hexagon               randconfig-002-20251203    clang-20
hexagon               randconfig-002-20251204    gcc-15.1.0
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251203    gcc-14
i386        buildonly-randconfig-001-20251204    clang-20
i386        buildonly-randconfig-002-20251203    gcc-14
i386        buildonly-randconfig-002-20251204    clang-20
i386        buildonly-randconfig-003-20251203    gcc-14
i386        buildonly-randconfig-003-20251204    clang-20
i386        buildonly-randconfig-004-20251203    clang-20
i386        buildonly-randconfig-004-20251204    clang-20
i386        buildonly-randconfig-005-20251203    clang-20
i386        buildonly-randconfig-005-20251204    clang-20
i386        buildonly-randconfig-006-20251203    gcc-14
i386        buildonly-randconfig-006-20251204    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251203    clang-20
i386                  randconfig-002-20251203    gcc-14
i386                  randconfig-003-20251203    clang-20
i386                  randconfig-004-20251203    clang-20
i386                  randconfig-005-20251203    gcc-14
i386                  randconfig-006-20251203    gcc-14
i386                  randconfig-007-20251203    gcc-14
i386                  randconfig-011-20251203    clang-20
i386                  randconfig-012-20251203    gcc-14
i386                  randconfig-013-20251203    clang-20
i386                  randconfig-014-20251203    gcc-14
i386                  randconfig-015-20251203    gcc-13
i386                  randconfig-016-20251203    clang-20
i386                  randconfig-017-20251203    clang-20
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251203    gcc-15.1.0
loongarch             randconfig-001-20251204    gcc-15.1.0
loongarch             randconfig-002-20251203    gcc-14.3.0
loongarch             randconfig-002-20251204    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251203    gcc-9.5.0
nios2                 randconfig-001-20251204    gcc-15.1.0
nios2                 randconfig-002-20251203    gcc-8.5.0
nios2                 randconfig-002-20251204    gcc-15.1.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.1.0
parisc                           alldefconfig    clang-22
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251203    gcc-12.5.0
parisc                randconfig-001-20251204    clang-22
parisc                randconfig-002-20251203    gcc-8.5.0
parisc                randconfig-002-20251204    clang-22
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc               randconfig-001-20251203    gcc-8.5.0
powerpc               randconfig-001-20251204    clang-22
powerpc               randconfig-002-20251203    clang-22
powerpc               randconfig-002-20251204    clang-22
powerpc64             randconfig-001-20251204    clang-22
powerpc64             randconfig-002-20251203    clang-22
powerpc64             randconfig-002-20251204    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                    nommu_k210_defconfig    clang-22
riscv             nommu_k210_sdcard_defconfig    clang-22
riscv                 randconfig-001-20251203    gcc-14.3.0
riscv                 randconfig-001-20251204    clang-22
riscv                 randconfig-002-20251203    clang-22
riscv                 randconfig-002-20251204    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251203    clang-22
s390                  randconfig-001-20251204    clang-22
s390                  randconfig-002-20251203    clang-22
s390                  randconfig-002-20251204    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251203    gcc-15.1.0
sh                    randconfig-001-20251204    clang-22
sh                    randconfig-002-20251203    gcc-13.4.0
sh                    randconfig-002-20251204    clang-22
sh                          rsk7269_defconfig    clang-22
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251203    gcc-13.4.0
sparc                 randconfig-002-20251203    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251203    clang-20
sparc64               randconfig-002-20251203    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251203    gcc-14
um                    randconfig-002-20251203    clang-20
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251203    clang-20
x86_64      buildonly-randconfig-002-20251203    clang-20
x86_64      buildonly-randconfig-003-20251203    clang-20
x86_64      buildonly-randconfig-004-20251203    gcc-14
x86_64      buildonly-randconfig-005-20251203    clang-20
x86_64      buildonly-randconfig-006-20251203    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251203    gcc-14
x86_64                randconfig-001-20251204    clang-20
x86_64                randconfig-002-20251203    gcc-14
x86_64                randconfig-002-20251204    clang-20
x86_64                randconfig-003-20251203    clang-20
x86_64                randconfig-003-20251204    clang-20
x86_64                randconfig-004-20251203    clang-20
x86_64                randconfig-004-20251204    clang-20
x86_64                randconfig-005-20251203    gcc-14
x86_64                randconfig-005-20251204    clang-20
x86_64                randconfig-006-20251203    gcc-14
x86_64                randconfig-006-20251204    clang-20
x86_64                randconfig-011-20251203    gcc-14
x86_64                randconfig-012-20251203    clang-20
x86_64                randconfig-013-20251203    gcc-14
x86_64                randconfig-014-20251203    clang-20
x86_64                randconfig-015-20251203    gcc-14
x86_64                randconfig-016-20251203    clang-20
x86_64                randconfig-071-20251203    clang-20
x86_64                randconfig-072-20251203    gcc-14
x86_64                randconfig-073-20251203    clang-20
x86_64                randconfig-074-20251203    gcc-14
x86_64                randconfig-075-20251203    clang-20
x86_64                randconfig-076-20251203    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                           allyesconfig    gcc-15.1.0
xtensa                  nommu_kc705_defconfig    clang-22
xtensa                randconfig-001-20251203    gcc-14.3.0
xtensa                randconfig-002-20251203    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

