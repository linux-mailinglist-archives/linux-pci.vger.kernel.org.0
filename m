Return-Path: <linux-pci+bounces-14799-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D249A25AC
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 16:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1789DB25F32
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 14:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85AA1DE8B1;
	Thu, 17 Oct 2024 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RI2kpVj6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAD01DE8A7
	for <linux-pci@vger.kernel.org>; Thu, 17 Oct 2024 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729176991; cv=none; b=csHkEQuHF0w1qQvolNSvj6J/NJXBwjH6fYzWOHYBavbPWMnQazbuwzwHDfB3l+XuFGU0ZrSonX0NcoY3+Y+atf8uoK0/2uj3W+61Wic2ZbOfzHdT3Fbpy17BXlgcc+YQmJLFO5K6T4oHAuyEJia+65yYeP5iHDU0QUilWMaHTGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729176991; c=relaxed/simple;
	bh=z9hAq4LQZayxRxwRbNn0pkd2BPUZqTPZx5hSVnBvNhw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bvOXUiO6AcQBO1f9uS76uwpfIJRokVmXGjat5kWAgbq+dmwmddSkJ9laZyfxBl8o8c5NdTSAV6ShsMoyXlqNG8VHwuQSV8ocDC1NWBWsLkwzLf8S8bb4PR7Dx3jfrlna+QMrPJawAJOQbckcnok3gumlNstfu4Ha1n2U5vkBxeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RI2kpVj6; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729176990; x=1760712990;
  h=date:from:to:cc:subject:message-id;
  bh=z9hAq4LQZayxRxwRbNn0pkd2BPUZqTPZx5hSVnBvNhw=;
  b=RI2kpVj6adyavA1U69ovY7NN19uL892BEiCZ78BnuL4HK5P50zYAuJXY
   0c2pdKcPTy3AI56FJBxeb+XindS+w5Z/j4D8mtaMcb8CgytMtxDgo2EaI
   YFqvKmsXqHTat9RbSWBgw5P2v72jESvaX0nEvSECynwv4c3gJMOUFn1Cx
   FvVSHVEiXGA9TFxkbRWR7+0cjRW5UjUXmOJjiAQwcaTBso/8ribLTI0Nk
   tCvoA2gbe/EgmbBMZXUUkELHzBZ8A2sJeh11z2NxPOEVBGl9zzajEEUG5
   JzEgmLgQQ2/hqo+MDfz5vvAzm6oJG1qWYvuCZeegumfrcVwo2l6MGxJSw
   Q==;
X-CSE-ConnectionGUID: EeBh0cKgSiefrdT5w+zcwQ==
X-CSE-MsgGUID: YRy3WdK4SkCLU28wcxQkQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39790061"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39790061"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 07:56:29 -0700
X-CSE-ConnectionGUID: tklsxbggSBKgnfkG/Q0crA==
X-CSE-MsgGUID: Ljb49ERUR8iA8SRjf0XykA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="109374191"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 17 Oct 2024 07:56:28 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1RvN-000MUL-2a;
	Thu, 17 Oct 2024 14:56:25 +0000
Date: Thu, 17 Oct 2024 22:55:53 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:hotplug] BUILD SUCCESS
 ffce5b49f26c375ee42235f175f3b004446ed383
Message-ID: <202410172245.Uz6zShdT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git hotplug
branch HEAD: ffce5b49f26c375ee42235f175f3b004446ed383  PCI: cpcihp: Remove unused struct cpci_hp_controller_ops.hardware_test

elapsed time: 1093m

configs tested: 97
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                           tb10x_defconfig    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                         bcm2835_defconfig    clang-20
arm                      integrator_defconfig    clang-20
arm                   milbeaut_m10v_defconfig    clang-20
arm                        mvebu_v5_defconfig    clang-20
arm                        spear3xx_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241017    clang-18
i386        buildonly-randconfig-002-20241017    clang-18
i386        buildonly-randconfig-003-20241017    clang-18
i386        buildonly-randconfig-004-20241017    clang-18
i386        buildonly-randconfig-005-20241017    clang-18
i386        buildonly-randconfig-006-20241017    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20241017    clang-18
i386                  randconfig-002-20241017    clang-18
i386                  randconfig-003-20241017    clang-18
i386                  randconfig-004-20241017    clang-18
i386                  randconfig-005-20241017    clang-18
i386                  randconfig-006-20241017    clang-18
i386                  randconfig-011-20241017    clang-18
i386                  randconfig-012-20241017    clang-18
i386                  randconfig-013-20241017    clang-18
i386                  randconfig-014-20241017    clang-18
i386                  randconfig-015-20241017    clang-18
i386                  randconfig-016-20241017    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                           mtx1_defconfig    clang-20
nios2                             allnoconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                       maple_defconfig    clang-20
powerpc                      mgcoge_defconfig    clang-20
powerpc                     taishan_defconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                          debug_defconfig    clang-20
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                             espt_defconfig    clang-20
sh                            migor_defconfig    clang-20
sh                   sh7770_generic_defconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc                       sparc32_defconfig    clang-20
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

