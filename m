Return-Path: <linux-pci+bounces-20079-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC513A158BE
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 21:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01351168E14
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 20:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3761A8407;
	Fri, 17 Jan 2025 20:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wxu5fH/+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C55E1A2391
	for <linux-pci@vger.kernel.org>; Fri, 17 Jan 2025 20:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737147456; cv=none; b=VxN4X7qD8o5gmnm9nyxHgbg70ixJpqNJE9zOPpkD5IicN5CvwtdddOxkz1kUJMQXsjqqAL5kf/NzJVMX+VJdkxkFSoVWYYJD6G4QpUaFMls5rbqZih07fAToVdgyfmP1Upcgwk6JJVnz4HW5w3sd0R0gRr4mAyZAyO496tlD7+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737147456; c=relaxed/simple;
	bh=kjg7fDJ9Iae2jZM1KsZXmxrdXUO1aujOKV8XI1e9k00=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GIiL6I6cwwrBHyWkpfjDMPNqQyS1lOB4IBLrOoH2bgDHRAsKg/TR1JG+Q58b/niPwALAqG7Kx/0zkRAIm0aX8EnjDzIJ4TdFwFdn+oEcfsn5nOv/RFVOIeZKTxe5Cqv+SDLb56UtSkcphS+G6GBlLRb7DlPby24U3rm2Iwvcbl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wxu5fH/+; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737147455; x=1768683455;
  h=date:from:to:cc:subject:message-id;
  bh=kjg7fDJ9Iae2jZM1KsZXmxrdXUO1aujOKV8XI1e9k00=;
  b=Wxu5fH/+ZQSvPswJywcr/QfhEbqZPnDFcoSCqmkp3s00680FhPQQFr1E
   L8q8IyYuhroHe4/w9ZgOOI7V2ZmRyDd3uvRvNAcbwhfuN0NdG0Jd/32PF
   MzuGAkz2P2hpUSd/Cx0ZV92h+67cBy2EOpfPGlk65uvTTwh9EDx+LBsWv
   pCT3lfsUJ2htYhBP8XlZcXC80zASIHK2Ci/7v7nMU7R1omc1JCCQuz0CW
   ALqq6SCEtvcmMZhQacREgbFHVPX1gRGoKoQd5vrM9vpkgi4iB3ItNc6p+
   1KfkIJzThxZuHluGbyFQgUFCwAbITtEh9q9JwkwAJ7qwNHsBLAX9OZamg
   g==;
X-CSE-ConnectionGUID: LV90a3oUSrCBoQsZ7tDMyQ==
X-CSE-MsgGUID: 3tmSGhMKQHeFJ/zxPJ9R2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="36805475"
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="36805475"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 12:57:34 -0800
X-CSE-ConnectionGUID: mO81veUvSTmUcWw4F+mE8Q==
X-CSE-MsgGUID: HStGJ5t2R7KEh5dm1E21Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="110900288"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 17 Jan 2025 12:57:33 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYtPG-000ThD-2g;
	Fri, 17 Jan 2025 20:57:30 +0000
Date: Sat, 18 Jan 2025 04:56:35 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dra7xx] BUILD SUCCESS
 ad9afd75030174e8f9eabd9d5c1a87a625db430c
Message-ID: <202501180429.v1AFCsRi-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dra7xx
branch HEAD: ad9afd75030174e8f9eabd9d5c1a87a625db430c  PCI: dra7xx: Use syscon_regmap_lookup_by_phandle_args

elapsed time: 1443m

configs tested: 178
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250117    clang-20
arc                   randconfig-001-20250117    gcc-13.2.0
arc                   randconfig-002-20250117    clang-20
arc                   randconfig-002-20250117    gcc-13.2.0
arm                              alldefconfig    clang-20
arm                              allmodconfig    clang-18
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                                 defconfig    gcc-14.2.0
arm                        multi_v5_defconfig    clang-20
arm                          pxa3xx_defconfig    gcc-14.2.0
arm                   randconfig-001-20250117    clang-18
arm                   randconfig-001-20250117    clang-20
arm                   randconfig-002-20250117    clang-20
arm                   randconfig-002-20250117    gcc-14.2.0
arm                   randconfig-003-20250117    clang-20
arm                   randconfig-003-20250117    gcc-14.2.0
arm                   randconfig-004-20250117    clang-16
arm                   randconfig-004-20250117    clang-20
arm64                            alldefconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250117    clang-20
arm64                 randconfig-001-20250117    gcc-14.2.0
arm64                 randconfig-002-20250117    clang-18
arm64                 randconfig-002-20250117    clang-20
arm64                 randconfig-003-20250117    clang-20
arm64                 randconfig-004-20250117    clang-20
arm64                 randconfig-004-20250117    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250117    gcc-14.2.0
csky                  randconfig-002-20250117    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250117    clang-20
hexagon               randconfig-001-20250117    gcc-14.2.0
hexagon               randconfig-002-20250117    clang-20
hexagon               randconfig-002-20250117    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20250117    clang-19
i386        buildonly-randconfig-002-20250117    clang-19
i386        buildonly-randconfig-003-20250117    gcc-12
i386        buildonly-randconfig-004-20250117    gcc-12
i386        buildonly-randconfig-005-20250117    clang-19
i386        buildonly-randconfig-006-20250117    gcc-11
i386                                defconfig    clang-19
i386                  randconfig-001-20250117    clang-19
i386                  randconfig-002-20250117    clang-19
i386                  randconfig-003-20250117    clang-19
i386                  randconfig-004-20250117    clang-19
i386                  randconfig-005-20250117    clang-19
i386                  randconfig-006-20250117    clang-19
i386                  randconfig-007-20250117    clang-19
i386                  randconfig-011-20250117    gcc-12
i386                  randconfig-012-20250117    gcc-12
i386                  randconfig-013-20250117    gcc-12
i386                  randconfig-014-20250117    gcc-12
i386                  randconfig-015-20250117    gcc-12
i386                  randconfig-016-20250117    gcc-12
i386                  randconfig-017-20250117    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250117    gcc-14.2.0
loongarch             randconfig-002-20250117    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                     loongson1b_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250117    gcc-14.2.0
nios2                 randconfig-002-20250117    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    clang-20
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250117    gcc-14.2.0
parisc                randconfig-002-20250117    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                  mpc885_ads_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250117    gcc-14.2.0
powerpc               randconfig-002-20250117    gcc-14.2.0
powerpc               randconfig-003-20250117    gcc-14.2.0
powerpc                     tqm8555_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250117    clang-16
powerpc64             randconfig-001-20250117    gcc-14.2.0
powerpc64             randconfig-002-20250117    clang-20
powerpc64             randconfig-002-20250117    gcc-14.2.0
powerpc64             randconfig-003-20250117    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250117    gcc-14.2.0
riscv                 randconfig-002-20250117    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250117    gcc-14.2.0
s390                  randconfig-002-20250117    clang-20
s390                  randconfig-002-20250117    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                            migor_defconfig    gcc-14.2.0
sh                    randconfig-001-20250117    gcc-14.2.0
sh                    randconfig-002-20250117    gcc-14.2.0
sh                          sdk7786_defconfig    clang-20
sh                              ul2_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250117    gcc-14.2.0
sparc                 randconfig-002-20250117    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250117    gcc-14.2.0
sparc64               randconfig-002-20250117    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250117    clang-20
um                    randconfig-001-20250117    gcc-14.2.0
um                    randconfig-002-20250117    gcc-12
um                    randconfig-002-20250117    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250117    gcc-12
x86_64      buildonly-randconfig-002-20250117    gcc-12
x86_64      buildonly-randconfig-003-20250117    gcc-12
x86_64      buildonly-randconfig-004-20250117    gcc-12
x86_64      buildonly-randconfig-005-20250117    gcc-12
x86_64      buildonly-randconfig-006-20250117    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250117    clang-19
x86_64                randconfig-002-20250117    clang-19
x86_64                randconfig-003-20250117    clang-19
x86_64                randconfig-004-20250117    clang-19
x86_64                randconfig-005-20250117    clang-19
x86_64                randconfig-006-20250117    clang-19
x86_64                randconfig-007-20250117    clang-19
x86_64                randconfig-008-20250117    clang-19
x86_64                randconfig-071-20250117    clang-19
x86_64                randconfig-072-20250117    clang-19
x86_64                randconfig-073-20250117    clang-19
x86_64                randconfig-074-20250117    clang-19
x86_64                randconfig-075-20250117    clang-19
x86_64                randconfig-076-20250117    clang-19
x86_64                randconfig-077-20250117    clang-19
x86_64                randconfig-078-20250117    clang-19
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250117    gcc-14.2.0
xtensa                randconfig-002-20250117    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

