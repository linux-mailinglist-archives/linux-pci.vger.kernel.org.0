Return-Path: <linux-pci+bounces-37159-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B9BBA6197
	for <lists+linux-pci@lfdr.de>; Sat, 27 Sep 2025 18:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F384A7F78
	for <lists+linux-pci@lfdr.de>; Sat, 27 Sep 2025 16:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0B41B142D;
	Sat, 27 Sep 2025 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MeBTuGZ8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E778E1632C8
	for <linux-pci@vger.kernel.org>; Sat, 27 Sep 2025 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758990971; cv=none; b=WT/q31M+LxVLqzBWbojARS3jsdg5tCEtRbCMITLJLybg0/S5G4cMJZIon5EXyjMPAo7MAzsVoIdE/o0hSi5uJ/bnP+DvWTDPPqklD9TylWg1VQhgCr/CGcKflpQzUg/pa0/AfnjYZnP4kU6GyIl7qjUCMJahrfDNZMxdvhCtJ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758990971; c=relaxed/simple;
	bh=aNEZi+HaTR2oVMeg/SOb8P0zx3Bk/9UUO5MDaaPpe9Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Fs45SY6b1q5jHrO+wZ9Mhl3sCV0D7Vyr0+EWQBymB/q2YbZiG0kBiuPVlmdecw/zX4xGuY5KA7MSs1tccyp91bwZ1EBYi7c8zo194iKRgdsfuGoU6f7On198zAnxb/kSolrTUdfBxJWKwfHPYNWQMQLopDZIf9uVabeNvqOB/zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MeBTuGZ8; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758990969; x=1790526969;
  h=date:from:to:cc:subject:message-id;
  bh=aNEZi+HaTR2oVMeg/SOb8P0zx3Bk/9UUO5MDaaPpe9Q=;
  b=MeBTuGZ8x9Tn3gz9fK9NvDC7NYJhEAChQ0FiVwS92tCu0a1y00pBcJOs
   p44rr4hvlJBOyizE3EBShPBMZY8RFWpJBc4Y9dcdVkWltPBqHilUGmDU0
   29Ltf2q+K8mzRY4QG8pu+REl8uMIGwheIU3yDCXHByp8puCrWsH4fhOpM
   5/U5Ruf9qegCEgZn+iuPIbTuwrwpxABSzwqlfXPBkGxdi+wClKMQ/zUTG
   MKqnwSxbPQhjf2IjMHa0ofiv5jDwGfDh/tT5p+bpQZHewNbzlJVjRSl1p
   BVLiwu5937kZRwbhNyi323Z44fBasmvBsncYePS2Xhvoq6X7cFSKQdkUT
   A==;
X-CSE-ConnectionGUID: fhIT3YMsR9uFSEEgq9UQOw==
X-CSE-MsgGUID: kFalZS9USNyiuFO1m184aQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11566"; a="86741230"
X-IronPort-AV: E=Sophos;i="6.18,298,1751266800"; 
   d="scan'208";a="86741230"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2025 09:36:08 -0700
X-CSE-ConnectionGUID: xOImd339SaWJ3e3sud7LnQ==
X-CSE-MsgGUID: qrTrhsK0TXGvLKOz2LV34Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,298,1751266800"; 
   d="scan'208";a="182154600"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 27 Sep 2025 09:36:07 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v2Xu0-0007CP-1Z;
	Sat, 27 Sep 2025 16:36:04 +0000
Date: Sun, 28 Sep 2025 00:35:23 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:dt-binding] BUILD SUCCESS
 96a17ed17b369109b662b40345df961b412c1cd3
Message-ID: <202509280015.Vo9VcVvE-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git dt-binding
branch HEAD: 96a17ed17b369109b662b40345df961b412c1cd3  dt-bindings: PCI: qcom,pcie-x1e80100: Set clocks minItems for the fifth Glymur PCIe Controller

elapsed time: 1123m

configs tested: 218
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                   randconfig-001-20250927    gcc-10.5.0
arc                   randconfig-002-20250927    gcc-10.5.0
arc                   randconfig-002-20250927    gcc-13.4.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                          exynos_defconfig    gcc-15.1.0
arm                          gemini_defconfig    gcc-15.1.0
arm                   randconfig-001-20250927    clang-18
arm                   randconfig-001-20250927    gcc-10.5.0
arm                   randconfig-002-20250927    clang-16
arm                   randconfig-002-20250927    gcc-10.5.0
arm                   randconfig-003-20250927    gcc-10.5.0
arm                   randconfig-003-20250927    gcc-8.5.0
arm                   randconfig-004-20250927    gcc-10.5.0
arm                        spear3xx_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250927    gcc-10.5.0
arm64                 randconfig-001-20250927    gcc-8.5.0
arm64                 randconfig-002-20250927    gcc-10.5.0
arm64                 randconfig-002-20250927    gcc-11.5.0
arm64                 randconfig-003-20250927    clang-22
arm64                 randconfig-003-20250927    gcc-10.5.0
arm64                 randconfig-004-20250927    gcc-10.5.0
arm64                 randconfig-004-20250927    gcc-9.5.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250927    clang-22
csky                  randconfig-001-20250927    gcc-15.1.0
csky                  randconfig-002-20250927    clang-22
csky                  randconfig-002-20250927    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250927    clang-22
hexagon               randconfig-002-20250927    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250927    clang-20
i386        buildonly-randconfig-002-20250927    clang-20
i386        buildonly-randconfig-002-20250927    gcc-14
i386        buildonly-randconfig-003-20250927    clang-20
i386        buildonly-randconfig-004-20250927    clang-20
i386        buildonly-randconfig-005-20250927    clang-20
i386        buildonly-randconfig-005-20250927    gcc-12
i386        buildonly-randconfig-006-20250927    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250927    gcc-14
i386                  randconfig-002-20250927    gcc-14
i386                  randconfig-003-20250927    gcc-14
i386                  randconfig-004-20250927    gcc-14
i386                  randconfig-005-20250927    gcc-14
i386                  randconfig-006-20250927    gcc-14
i386                  randconfig-007-20250927    gcc-14
i386                  randconfig-011-20250927    clang-20
i386                  randconfig-012-20250927    clang-20
i386                  randconfig-013-20250927    clang-20
i386                  randconfig-014-20250927    clang-20
i386                  randconfig-015-20250927    clang-20
i386                  randconfig-016-20250927    clang-20
i386                  randconfig-017-20250927    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250927    clang-22
loongarch             randconfig-001-20250927    gcc-15.1.0
loongarch             randconfig-002-20250927    clang-18
loongarch             randconfig-002-20250927    clang-22
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
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250927    clang-22
nios2                 randconfig-001-20250927    gcc-9.5.0
nios2                 randconfig-002-20250927    clang-22
nios2                 randconfig-002-20250927    gcc-11.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250927    clang-22
parisc                randconfig-001-20250927    gcc-9.5.0
parisc                randconfig-002-20250927    clang-22
parisc                randconfig-002-20250927    gcc-11.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                   lite5200b_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250927    clang-22
powerpc               randconfig-001-20250927    gcc-13.4.0
powerpc               randconfig-002-20250927    clang-22
powerpc               randconfig-003-20250927    clang-22
powerpc               randconfig-003-20250927    gcc-8.5.0
powerpc64             randconfig-001-20250927    clang-22
powerpc64             randconfig-002-20250927    clang-22
powerpc64             randconfig-002-20250927    gcc-15.1.0
powerpc64             randconfig-003-20250927    clang-22
powerpc64             randconfig-003-20250927    gcc-12.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250927    clang-22
riscv                 randconfig-001-20250927    gcc-11.5.0
riscv                 randconfig-002-20250927    gcc-11.5.0
riscv                 randconfig-002-20250927    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                          debug_defconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250927    clang-22
s390                  randconfig-001-20250927    gcc-11.5.0
s390                  randconfig-002-20250927    clang-22
s390                  randconfig-002-20250927    gcc-11.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20250927    gcc-11.5.0
sh                    randconfig-001-20250927    gcc-15.1.0
sh                    randconfig-002-20250927    gcc-11.5.0
sh                    randconfig-002-20250927    gcc-15.1.0
sh                          rsk7264_defconfig    gcc-15.1.0
sparc                            alldefconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250927    gcc-11.5.0
sparc                 randconfig-002-20250927    gcc-11.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250927    gcc-11.5.0
sparc64               randconfig-001-20250927    gcc-15.1.0
sparc64               randconfig-002-20250927    gcc-11.5.0
sparc64               randconfig-002-20250927    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250927    gcc-11.5.0
um                    randconfig-001-20250927    gcc-14
um                    randconfig-002-20250927    clang-22
um                    randconfig-002-20250927    gcc-11.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250927    gcc-14
x86_64      buildonly-randconfig-002-20250927    clang-20
x86_64      buildonly-randconfig-002-20250927    gcc-14
x86_64      buildonly-randconfig-003-20250927    clang-20
x86_64      buildonly-randconfig-003-20250927    gcc-14
x86_64      buildonly-randconfig-004-20250927    gcc-14
x86_64      buildonly-randconfig-005-20250927    gcc-14
x86_64      buildonly-randconfig-006-20250927    clang-20
x86_64      buildonly-randconfig-006-20250927    gcc-14
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250927    clang-20
x86_64                randconfig-002-20250927    clang-20
x86_64                randconfig-003-20250927    clang-20
x86_64                randconfig-004-20250927    clang-20
x86_64                randconfig-005-20250927    clang-20
x86_64                randconfig-006-20250927    clang-20
x86_64                randconfig-007-20250927    clang-20
x86_64                randconfig-008-20250927    clang-20
x86_64                randconfig-071-20250927    gcc-14
x86_64                randconfig-072-20250927    gcc-14
x86_64                randconfig-073-20250927    gcc-14
x86_64                randconfig-074-20250927    gcc-14
x86_64                randconfig-075-20250927    gcc-14
x86_64                randconfig-076-20250927    gcc-14
x86_64                randconfig-077-20250927    gcc-14
x86_64                randconfig-078-20250927    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250927    gcc-11.5.0
xtensa                randconfig-001-20250927    gcc-8.5.0
xtensa                randconfig-002-20250927    gcc-10.5.0
xtensa                randconfig-002-20250927    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

