Return-Path: <linux-pci+bounces-26305-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FEBA94815
	for <lists+linux-pci@lfdr.de>; Sun, 20 Apr 2025 16:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9211709E0
	for <lists+linux-pci@lfdr.de>; Sun, 20 Apr 2025 14:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8B51E9B1D;
	Sun, 20 Apr 2025 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bJizCUoC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6E81547F5
	for <linux-pci@vger.kernel.org>; Sun, 20 Apr 2025 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745161154; cv=none; b=FT8jRu24lXLXo3rWmt1AzDdimN0M2RXar22t/81mWVupGtW41tWcMECqLJTC/0t6hfwLgV9Fq3VhPmzPmW+idU7oXLZwNJRZ5feE8PS0T9/rxlVsC6hxcfbb934zTmJfWRvJNfz6dRVlyWERHHeudxqxuA4bXXp181qoF2ZvAS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745161154; c=relaxed/simple;
	bh=eXs/I2jCA0IWJI8nh1jJkXofMMCI9NXoO9oHGs0zglU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mQxGwvt67oynOvMc/vmEgcAcvW7QEyqan+j5ne5qaSR3eYhIlweQi1J6UsMXfLDJl5Wzd5L3QaK8JMEivwydUbGDHHFS2RpQxfF3Sptf6/QTyDABHuRmc205LA1Tv+d44ExILlTwlXT0eUngDRGQ7bmlBY9qT1CowQaWdjYoWKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bJizCUoC; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745161152; x=1776697152;
  h=date:from:to:cc:subject:message-id;
  bh=eXs/I2jCA0IWJI8nh1jJkXofMMCI9NXoO9oHGs0zglU=;
  b=bJizCUoCDQPn8TSfh9V9gNd0npt8qPFzyQqSGSyZB/bCeMP0tDtzoQzG
   54JHhKEhcfhk9R5vU9qClXPmm0T5gNXM8H2hKVXhZrAgvK03KoYzmJLW4
   d0WymHwo76QLxM51Pg7hTYIre0naSdJOnrsIjLrZX5GxLQD3X56L3Ymik
   YWwlHFrPfHxH5gHgWx/c/BT8/AXnXlo7bb+7seZhJZHlx0y9Z8m25AxOd
   lwrztRtCeduI3YEwM9mKktcmkP0Q1gpMlvYsTA/BSzEBm6JvpllCc0F3N
   emaCbRDySnyl9mE4e94AMwmSjqsqArbmJQxBQAGJslRJLjpqCgO0WD2hx
   w==;
X-CSE-ConnectionGUID: d6LfJbPWSQu9qiNxWgVOLw==
X-CSE-MsgGUID: lVRVek72R/mZ/JJ3C7R1BQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11409"; a="46604189"
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="46604189"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 07:59:10 -0700
X-CSE-ConnectionGUID: thikqtD3R3mQT5TnhCWL1Q==
X-CSE-MsgGUID: 4S2Ms3w6SM6c2ncVbT/qRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="131531884"
Received: from lkp-server01.sh.intel.com (HELO 61e10e65ea0f) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 20 Apr 2025 07:59:09 -0700
Received: from kbuild by 61e10e65ea0f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u6W8Q-0004iL-27;
	Sun, 20 Apr 2025 14:59:06 +0000
Date: Sun, 20 Apr 2025 22:59:04 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/rcar-gen4] BUILD SUCCESS
 b584ab12d59f646b9254b2b16ff197d612fd4935
Message-ID: <202504202254.oloDYRTE-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rcar-gen4
branch HEAD: b584ab12d59f646b9254b2b16ff197d612fd4935  PCI: rcar-gen4: set ep BAR4 fixed size

elapsed time: 1447m

configs tested: 216
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-14.2.0
arc                          axs103_defconfig    gcc-14.2.0
arc                      axs103_smp_defconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250420    gcc-12.4.0
arc                   randconfig-002-20250420    gcc-12.4.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-21
arm                                 defconfig    gcc-14.2.0
arm                      footbridge_defconfig    clang-17
arm                        keystone_defconfig    gcc-14.2.0
arm                             pxa_defconfig    gcc-14.2.0
arm                   randconfig-001-20250420    clang-21
arm                   randconfig-002-20250420    gcc-8.5.0
arm                   randconfig-003-20250420    gcc-7.5.0
arm                   randconfig-004-20250420    gcc-8.5.0
arm                          sp7021_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250420    gcc-8.5.0
arm64                 randconfig-002-20250420    gcc-8.5.0
arm64                 randconfig-003-20250420    clang-21
arm64                 randconfig-004-20250420    gcc-6.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250419    gcc-11.5.0
csky                  randconfig-002-20250419    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250419    clang-21
hexagon               randconfig-002-20250419    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250419    gcc-11
i386        buildonly-randconfig-002-20250419    gcc-12
i386        buildonly-randconfig-003-20250419    clang-20
i386        buildonly-randconfig-004-20250419    clang-20
i386        buildonly-randconfig-005-20250419    clang-20
i386        buildonly-randconfig-006-20250419    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250420    gcc-12
i386                  randconfig-002-20250420    gcc-12
i386                  randconfig-003-20250420    gcc-12
i386                  randconfig-004-20250420    gcc-12
i386                  randconfig-005-20250420    gcc-12
i386                  randconfig-006-20250420    gcc-12
i386                  randconfig-007-20250420    gcc-12
i386                  randconfig-011-20250420    gcc-12
i386                  randconfig-012-20250420    gcc-12
i386                  randconfig-013-20250420    gcc-12
i386                  randconfig-014-20250420    gcc-12
i386                  randconfig-015-20250420    gcc-12
i386                  randconfig-016-20250420    gcc-12
i386                  randconfig-017-20250420    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250419    gcc-14.2.0
loongarch             randconfig-002-20250419    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       bvme6000_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        mvme16x_defconfig    gcc-14.2.0
m68k                           virt_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                         bigsur_defconfig    gcc-14.2.0
mips                      maltaaprp_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250419    gcc-7.5.0
nios2                 randconfig-002-20250419    gcc-11.5.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.2.0
openrisc                 simple_smp_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.2.0
parisc                generic-32bit_defconfig    gcc-14.2.0
parisc                randconfig-001-20250419    gcc-10.5.0
parisc                randconfig-002-20250419    gcc-14.2.0
parisc64                         alldefconfig    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                   bluestone_defconfig    gcc-14.2.0
powerpc                      cm5200_defconfig    clang-21
powerpc                       holly_defconfig    gcc-14.2.0
powerpc                      mgcoge_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250419    gcc-5.5.0
powerpc               randconfig-002-20250419    gcc-9.3.0
powerpc               randconfig-003-20250419    gcc-5.5.0
powerpc64             randconfig-001-20250419    gcc-5.5.0
powerpc64             randconfig-002-20250419    gcc-10.5.0
powerpc64             randconfig-003-20250419    clang-21
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    clang-21
riscv                               defconfig    gcc-12
riscv                    nommu_k210_defconfig    gcc-14.2.0
riscv                 randconfig-001-20250419    gcc-14.2.0
riscv                 randconfig-002-20250419    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                                defconfig    gcc-12
s390                  randconfig-001-20250419    clang-21
s390                  randconfig-002-20250419    gcc-7.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                 kfr2r09-romimage_defconfig    gcc-14.2.0
sh                          lboxre2_defconfig    gcc-14.2.0
sh                     magicpanelr2_defconfig    gcc-14.2.0
sh                    randconfig-001-20250419    gcc-5.5.0
sh                    randconfig-002-20250419    gcc-11.5.0
sh                           se7206_defconfig    gcc-14.2.0
sh                            titan_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250419    gcc-12.4.0
sparc                 randconfig-002-20250419    gcc-8.5.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250419    gcc-8.5.0
sparc64               randconfig-002-20250419    gcc-10.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250419    clang-19
um                    randconfig-002-20250419    gcc-12
um                           x86_64_defconfig    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250419    gcc-12
x86_64      buildonly-randconfig-002-20250419    gcc-11
x86_64      buildonly-randconfig-003-20250419    gcc-12
x86_64      buildonly-randconfig-004-20250419    gcc-11
x86_64      buildonly-randconfig-005-20250419    gcc-12
x86_64      buildonly-randconfig-006-20250419    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250420    gcc-12
x86_64                randconfig-002-20250420    gcc-12
x86_64                randconfig-003-20250420    gcc-12
x86_64                randconfig-004-20250420    gcc-12
x86_64                randconfig-005-20250420    gcc-12
x86_64                randconfig-006-20250420    gcc-12
x86_64                randconfig-007-20250420    gcc-12
x86_64                randconfig-008-20250420    gcc-12
x86_64                randconfig-071-20250420    clang-20
x86_64                randconfig-072-20250420    clang-20
x86_64                randconfig-073-20250420    clang-20
x86_64                randconfig-074-20250420    clang-20
x86_64                randconfig-075-20250420    clang-20
x86_64                randconfig-076-20250420    clang-20
x86_64                randconfig-077-20250420    clang-20
x86_64                randconfig-078-20250420    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    clang-18
x86_64                         rhel-9.4-kunit    clang-18
x86_64                           rhel-9.4-ltp    clang-18
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                  nommu_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250419    gcc-10.5.0
xtensa                randconfig-002-20250419    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

