Return-Path: <linux-pci+bounces-33619-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAABB1E547
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 11:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429B6188DC22
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 09:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC461E520B;
	Fri,  8 Aug 2025 09:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mcc/D4UJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D7723B62C
	for <linux-pci@vger.kernel.org>; Fri,  8 Aug 2025 09:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643882; cv=none; b=QIXwEDD5ILls12m8vXN5YS1BSORsPpn100Zy2lmmbKoKAQaIgyDvuvUIV3KtG3/87nfh3Xly6vtPvUCqmuwpZa4J3lzYXFdZPvn8ucBhBXEY5uAPnsoxuBs18wgTyvyBjp3tgjdhOh/h1yWoumuZBJB8lbsiOXAE6eMA1wCbqhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643882; c=relaxed/simple;
	bh=tabeFhipwA/EaEs6bpyOmycVMZcbtb+4CUcYx/xcOic=;
	h=Date:From:To:Cc:Subject:Message-ID; b=lB7Kq0T8quwdvILDlc3hukC+guaSgNM+ncJE7xJKKwgdJv43p2LWhfFKo/gNmPBXVhEYpP1KSxOa9itIcLosdoYp3+w5Xc1eyZconvXhnAv5iKA8zQyDsk+q1iIlstEbqsgnpc1PfNDaj7olUTmDfSBtcERkSxUIldhMKkTz6cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mcc/D4UJ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754643880; x=1786179880;
  h=date:from:to:cc:subject:message-id;
  bh=tabeFhipwA/EaEs6bpyOmycVMZcbtb+4CUcYx/xcOic=;
  b=mcc/D4UJxGFyhe1x0WTAGxq2bgx7TTcYGhJYUmNviqGrY7+n0p8M0BBA
   DkiPzWR5HP/HPYZl8N3t0CLs0RXAf1uqSt8mLXeRui2+umhN0gXxWv/3J
   cKIrSOnsyfVzboKpyiZA+vUz7b1NlRMKBg1aPqPhhVMt8EOCXnVQSKQLv
   qCiPTU8p5Q5ofmR34FsqaX3JMua6kFk+v5Ux1tcPvB0fa68i9Hw2b1RM0
   Rhru3Fn4LIxcTEgcjrRnWrvq9ktAK4c/yK6qvczzUj5My7zav6YT48N/8
   Fq+s8A2d74JVeY7ANVLFxbECXKz7e0MPJdNH6A6PByas93vUNJyo1RAoB
   w==;
X-CSE-ConnectionGUID: 3HS62UBSSRm3XTQoiI50Ow==
X-CSE-MsgGUID: Ptnt2dbEQcOrM4VDGA9Xtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="60615374"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="60615374"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 02:04:39 -0700
X-CSE-ConnectionGUID: IBAcUawQTDqiLahLDSALug==
X-CSE-MsgGUID: csR5aEb7SDStLp2Qs8pPew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="169417492"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 08 Aug 2025 02:04:38 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ukJ1g-0003i7-0B;
	Fri, 08 Aug 2025 09:04:36 +0000
Date: Fri, 08 Aug 2025 17:01:56 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 d5c647b08ee02cb7fa50d89414ed0f5dc7c1ca0e
Message-ID: <202508081749.vnQRSx4L-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: d5c647b08ee02cb7fa50d89414ed0f5dc7c1ca0e  PCI: vmd: Fix wrong kfree() in vmd_msi_free()

elapsed time: 959m

configs tested: 219
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250808    clang-22
arc                   randconfig-001-20250808    gcc-14.3.0
arc                   randconfig-002-20250808    clang-22
arc                   randconfig-002-20250808    gcc-12.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250808    clang-22
arm                   randconfig-001-20250808    gcc-14.3.0
arm                   randconfig-002-20250808    clang-22
arm                   randconfig-002-20250808    gcc-10.5.0
arm                   randconfig-003-20250808    clang-22
arm                   randconfig-004-20250808    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250808    clang-20
arm64                 randconfig-001-20250808    clang-22
arm64                 randconfig-002-20250808    clang-22
arm64                 randconfig-002-20250808    gcc-10.5.0
arm64                 randconfig-003-20250808    clang-22
arm64                 randconfig-004-20250808    clang-22
arm64                 randconfig-004-20250808    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250808    gcc-12.5.0
csky                  randconfig-001-20250808    gcc-15.1.0
csky                  randconfig-002-20250808    gcc-12.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250808    clang-20
hexagon               randconfig-001-20250808    gcc-12.5.0
hexagon               randconfig-002-20250808    clang-22
hexagon               randconfig-002-20250808    gcc-12.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250808    clang-20
i386        buildonly-randconfig-001-20250808    gcc-12
i386        buildonly-randconfig-002-20250808    clang-20
i386        buildonly-randconfig-002-20250808    gcc-12
i386        buildonly-randconfig-003-20250808    gcc-12
i386        buildonly-randconfig-004-20250808    clang-20
i386        buildonly-randconfig-004-20250808    gcc-12
i386        buildonly-randconfig-005-20250808    gcc-12
i386        buildonly-randconfig-006-20250808    clang-20
i386        buildonly-randconfig-006-20250808    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250808    clang-20
i386                  randconfig-002-20250808    clang-20
i386                  randconfig-003-20250808    clang-20
i386                  randconfig-004-20250808    clang-20
i386                  randconfig-005-20250808    clang-20
i386                  randconfig-006-20250808    clang-20
i386                  randconfig-007-20250808    clang-20
i386                  randconfig-011-20250808    clang-20
i386                  randconfig-012-20250808    clang-20
i386                  randconfig-013-20250808    clang-20
i386                  randconfig-014-20250808    clang-20
i386                  randconfig-015-20250808    clang-20
i386                  randconfig-016-20250808    clang-20
i386                  randconfig-017-20250808    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250808    clang-22
loongarch             randconfig-001-20250808    gcc-12.5.0
loongarch             randconfig-002-20250808    gcc-12.5.0
loongarch             randconfig-002-20250808    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250808    gcc-12.5.0
nios2                 randconfig-001-20250808    gcc-9.5.0
nios2                 randconfig-002-20250808    gcc-12.5.0
nios2                 randconfig-002-20250808    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250808    gcc-12.5.0
parisc                randconfig-001-20250808    gcc-8.5.0
parisc                randconfig-002-20250808    gcc-12.5.0
parisc                randconfig-002-20250808    gcc-13.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20250808    clang-22
powerpc               randconfig-001-20250808    gcc-12.5.0
powerpc               randconfig-002-20250808    clang-18
powerpc               randconfig-002-20250808    gcc-12.5.0
powerpc               randconfig-003-20250808    clang-22
powerpc               randconfig-003-20250808    gcc-12.5.0
powerpc64             randconfig-001-20250808    clang-18
powerpc64             randconfig-001-20250808    gcc-12.5.0
powerpc64             randconfig-002-20250808    clang-22
powerpc64             randconfig-002-20250808    gcc-12.5.0
powerpc64             randconfig-003-20250808    clang-16
powerpc64             randconfig-003-20250808    gcc-12.5.0
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250808    clang-22
riscv                 randconfig-002-20250808    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250808    clang-22
s390                  randconfig-001-20250808    gcc-10.5.0
s390                  randconfig-002-20250808    clang-22
s390                  randconfig-002-20250808    gcc-10.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250808    clang-22
sh                    randconfig-001-20250808    gcc-13.4.0
sh                    randconfig-002-20250808    clang-22
sh                    randconfig-002-20250808    gcc-10.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250808    clang-22
sparc                 randconfig-001-20250808    gcc-12.5.0
sparc                 randconfig-002-20250808    clang-22
sparc                 randconfig-002-20250808    gcc-8.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250808    clang-22
sparc64               randconfig-002-20250808    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250808    clang-22
um                    randconfig-001-20250808    gcc-12
um                    randconfig-002-20250808    clang-22
um                    randconfig-002-20250808    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250808    clang-20
x86_64      buildonly-randconfig-001-20250808    gcc-12
x86_64      buildonly-randconfig-002-20250808    gcc-12
x86_64      buildonly-randconfig-003-20250808    clang-20
x86_64      buildonly-randconfig-003-20250808    gcc-12
x86_64      buildonly-randconfig-004-20250808    clang-20
x86_64      buildonly-randconfig-004-20250808    gcc-12
x86_64      buildonly-randconfig-005-20250808    gcc-12
x86_64      buildonly-randconfig-006-20250808    clang-20
x86_64      buildonly-randconfig-006-20250808    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250808    gcc-12
x86_64                randconfig-002-20250808    gcc-12
x86_64                randconfig-003-20250808    gcc-12
x86_64                randconfig-004-20250808    gcc-12
x86_64                randconfig-005-20250808    gcc-12
x86_64                randconfig-006-20250808    gcc-12
x86_64                randconfig-007-20250808    gcc-12
x86_64                randconfig-008-20250808    gcc-12
x86_64                randconfig-071-20250808    clang-20
x86_64                randconfig-072-20250808    clang-20
x86_64                randconfig-073-20250808    clang-20
x86_64                randconfig-074-20250808    clang-20
x86_64                randconfig-075-20250808    clang-20
x86_64                randconfig-076-20250808    clang-20
x86_64                randconfig-077-20250808    clang-20
x86_64                randconfig-078-20250808    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250808    clang-22
xtensa                randconfig-001-20250808    gcc-9.5.0
xtensa                randconfig-002-20250808    clang-22
xtensa                randconfig-002-20250808    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

