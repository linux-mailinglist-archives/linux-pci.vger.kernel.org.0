Return-Path: <linux-pci+bounces-30234-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D157DAE1410
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 08:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38157160CD6
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 06:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1C4220696;
	Fri, 20 Jun 2025 06:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YzQkeC82"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09C91862BB
	for <linux-pci@vger.kernel.org>; Fri, 20 Jun 2025 06:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750401464; cv=none; b=hE+cOLiY2EFz3sZQ1yy8i3wgIDUcpBKZ5n5e224VUY4ih1iSiz3nejz1QIfqilmRBtW+mnYpZIaDjkjy1USstFYsNe6IHAuLP/N7IhbfurNrRhL4944op3QcY+/ebdeHVwarx0epPD8KjQFYnJpDLFlV2/DQAD1/NjkFopvt0r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750401464; c=relaxed/simple;
	bh=D4Cv8CEDHOuYbwbN3o5EhJ6CtiIaj1fzq9iVxoJKlcE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=lYmqFu/XqsAJYm8t3AZhqp7fzP/yiqtX7dlEdyF2ovrRKSfY/FdrTl/+ue6hTpUuBRIhe72sZ8U8fKU0h64Y7aSLEHm8LYaiPeT6mF7UMXg3Mm9AX+RIObnHozHlYNsvNdzKqFuBV3PBjKqhNtyg/j0rNZTakNrMncDQJ6wHGBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YzQkeC82; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750401463; x=1781937463;
  h=date:from:to:cc:subject:message-id;
  bh=D4Cv8CEDHOuYbwbN3o5EhJ6CtiIaj1fzq9iVxoJKlcE=;
  b=YzQkeC82hIW4a3xjsVWbTY1saLxMym2USLPmewHQQYm4rRcabTpOGL9E
   NUk+bWUe54kKBhYlmz8djZCvHidbp6UirRkAf3je012HLl+GCn4cGnJIg
   0dUHwPKtAW+dLzA4XAUfrSXLOHOrnFIk6sMkjwQiy5EtZYXq/g9GDW6EM
   WKijclu63IeSKCZ95mWSbpfX++p1USmQb7sTjI++eTdlOZ/NVZ7sxZiwN
   i2H8qGhKFPxkPwj9+C+ZXOnOiDyEegVh0hIp0+HwrOJJckH5zFvFmjFho
   JHnj9PbyWWJjqNPZR4NOtybbslrYbXaBgtuGW10SltrGoS/z48cb/zU8c
   Q==;
X-CSE-ConnectionGUID: e51bGuuOT4yBqgviXCdtkQ==
X-CSE-MsgGUID: rMlsuDlnQLWrvUSjgIAKqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="63258322"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="63258322"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 23:37:42 -0700
X-CSE-ConnectionGUID: K8Ps7CBMQ4WdffW1MxcwYw==
X-CSE-MsgGUID: i7W+2gFmRAmJmFYewxItkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="181852983"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 19 Jun 2025 23:37:39 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uSVNY-000LRW-16;
	Fri, 20 Jun 2025 06:37:36 +0000
Date: Fri, 20 Jun 2025 14:37:02 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/cadence] BUILD SUCCESS
 f28413fe0899591492d8ca3cdf5fd35558d9c05d
Message-ID: <202506201453.QZXewKuD-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/cadence
branch HEAD: f28413fe0899591492d8ca3cdf5fd35558d9c05d  PCI: cadence: Replace private message routing enums with PCI core definitions

elapsed time: 1008m

configs tested: 225
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                          axs103_defconfig    clang-21
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250620    clang-21
arc                   randconfig-001-20250620    gcc-8.5.0
arc                   randconfig-002-20250620    clang-21
arc                   randconfig-002-20250620    gcc-11.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-19
arm                         axm55xx_defconfig    clang-21
arm                                 defconfig    gcc-15.1.0
arm                   randconfig-001-20250620    clang-21
arm                   randconfig-002-20250620    clang-21
arm                   randconfig-003-20250620    clang-21
arm                   randconfig-004-20250620    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250620    clang-21
arm64                 randconfig-001-20250620    gcc-9.5.0
arm64                 randconfig-002-20250620    clang-21
arm64                 randconfig-002-20250620    gcc-8.5.0
arm64                 randconfig-003-20250620    clang-21
arm64                 randconfig-003-20250620    gcc-11.5.0
arm64                 randconfig-004-20250620    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250619    gcc-11.5.0
csky                  randconfig-001-20250620    clang-21
csky                  randconfig-002-20250619    gcc-9.3.0
csky                  randconfig-002-20250620    clang-21
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20250619    clang-21
hexagon               randconfig-001-20250620    clang-21
hexagon               randconfig-002-20250619    clang-21
hexagon               randconfig-002-20250620    clang-21
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250619    gcc-12
i386        buildonly-randconfig-001-20250620    clang-20
i386        buildonly-randconfig-002-20250619    gcc-12
i386        buildonly-randconfig-002-20250620    clang-20
i386        buildonly-randconfig-003-20250619    clang-20
i386        buildonly-randconfig-003-20250620    clang-20
i386        buildonly-randconfig-004-20250619    clang-20
i386        buildonly-randconfig-004-20250620    clang-20
i386        buildonly-randconfig-005-20250619    clang-20
i386        buildonly-randconfig-005-20250620    clang-20
i386        buildonly-randconfig-006-20250619    clang-20
i386        buildonly-randconfig-006-20250620    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250620    gcc-12
i386                  randconfig-002-20250620    gcc-12
i386                  randconfig-003-20250620    gcc-12
i386                  randconfig-004-20250620    gcc-12
i386                  randconfig-005-20250620    gcc-12
i386                  randconfig-006-20250620    gcc-12
i386                  randconfig-007-20250620    gcc-12
i386                  randconfig-011-20250620    gcc-12
i386                  randconfig-012-20250620    gcc-12
i386                  randconfig-013-20250620    gcc-12
i386                  randconfig-014-20250620    gcc-12
i386                  randconfig-015-20250620    gcc-12
i386                  randconfig-016-20250620    gcc-12
i386                  randconfig-017-20250620    gcc-12
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250619    gcc-15.1.0
loongarch             randconfig-001-20250620    clang-21
loongarch             randconfig-002-20250619    gcc-15.1.0
loongarch             randconfig-002-20250620    clang-21
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                           virt_defconfig    clang-21
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250619    gcc-8.5.0
nios2                 randconfig-001-20250620    clang-21
nios2                 randconfig-002-20250619    gcc-8.5.0
nios2                 randconfig-002-20250620    clang-21
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250619    gcc-11.5.0
parisc                randconfig-001-20250620    clang-21
parisc                randconfig-002-20250619    gcc-8.5.0
parisc                randconfig-002-20250620    clang-21
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      cm5200_defconfig    clang-21
powerpc                     mpc5200_defconfig    clang-21
powerpc                     ppa8548_defconfig    clang-21
powerpc               randconfig-001-20250619    gcc-9.3.0
powerpc               randconfig-001-20250620    clang-21
powerpc               randconfig-002-20250619    clang-21
powerpc               randconfig-002-20250620    clang-21
powerpc               randconfig-003-20250619    gcc-10.5.0
powerpc               randconfig-003-20250620    clang-21
powerpc64             randconfig-001-20250619    gcc-11.5.0
powerpc64             randconfig-001-20250620    clang-21
powerpc64             randconfig-002-20250619    clang-21
powerpc64             randconfig-002-20250620    clang-21
powerpc64             randconfig-003-20250619    gcc-10.5.0
powerpc64             randconfig-003-20250620    clang-21
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250619    gcc-11.5.0
riscv                 randconfig-001-20250620    gcc-13.3.0
riscv                 randconfig-002-20250619    clang-16
riscv                 randconfig-002-20250620    gcc-13.3.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250619    clang-19
s390                  randconfig-001-20250620    gcc-13.3.0
s390                  randconfig-002-20250619    gcc-13.2.0
s390                  randconfig-002-20250620    gcc-13.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                            hp6xx_defconfig    clang-21
sh                    randconfig-001-20250619    gcc-9.3.0
sh                    randconfig-001-20250620    gcc-13.3.0
sh                    randconfig-002-20250619    gcc-9.3.0
sh                    randconfig-002-20250620    gcc-13.3.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250619    gcc-14.3.0
sparc                 randconfig-001-20250620    gcc-13.3.0
sparc                 randconfig-002-20250619    gcc-10.3.0
sparc                 randconfig-002-20250620    gcc-13.3.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250619    gcc-13.3.0
sparc64               randconfig-001-20250620    gcc-13.3.0
sparc64               randconfig-002-20250619    gcc-8.5.0
sparc64               randconfig-002-20250620    gcc-13.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250619    clang-19
um                    randconfig-001-20250620    gcc-13.3.0
um                    randconfig-002-20250619    clang-21
um                    randconfig-002-20250620    gcc-13.3.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250619    clang-20
x86_64      buildonly-randconfig-001-20250620    gcc-12
x86_64      buildonly-randconfig-002-20250619    gcc-12
x86_64      buildonly-randconfig-002-20250620    gcc-12
x86_64      buildonly-randconfig-003-20250619    clang-20
x86_64      buildonly-randconfig-003-20250620    gcc-12
x86_64      buildonly-randconfig-004-20250619    gcc-12
x86_64      buildonly-randconfig-004-20250620    gcc-12
x86_64      buildonly-randconfig-005-20250619    clang-20
x86_64      buildonly-randconfig-005-20250620    gcc-12
x86_64      buildonly-randconfig-006-20250619    gcc-12
x86_64      buildonly-randconfig-006-20250620    gcc-12
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250620    clang-20
x86_64                randconfig-002-20250620    clang-20
x86_64                randconfig-003-20250620    clang-20
x86_64                randconfig-004-20250620    clang-20
x86_64                randconfig-005-20250620    clang-20
x86_64                randconfig-006-20250620    clang-20
x86_64                randconfig-007-20250620    clang-20
x86_64                randconfig-008-20250620    clang-20
x86_64                randconfig-071-20250620    clang-20
x86_64                randconfig-072-20250620    clang-20
x86_64                randconfig-073-20250620    clang-20
x86_64                randconfig-074-20250620    clang-20
x86_64                randconfig-075-20250620    clang-20
x86_64                randconfig-076-20250620    clang-20
x86_64                randconfig-077-20250620    clang-20
x86_64                randconfig-078-20250620    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250619    gcc-9.3.0
xtensa                randconfig-001-20250620    gcc-13.3.0
xtensa                randconfig-002-20250619    gcc-8.5.0
xtensa                randconfig-002-20250620    gcc-13.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

