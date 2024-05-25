Return-Path: <linux-pci+bounces-7822-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2BB8CEE97
	for <lists+linux-pci@lfdr.de>; Sat, 25 May 2024 12:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BF8BB2115D
	for <lists+linux-pci@lfdr.de>; Sat, 25 May 2024 10:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7CDAD5F;
	Sat, 25 May 2024 10:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZhyTTXff"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762D68F66
	for <linux-pci@vger.kernel.org>; Sat, 25 May 2024 10:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716634357; cv=none; b=qDDTIAbTaFoq7Lgqs9Z6+tjOc+D952ou9uTdJQXJ1wdFlKHnjqo4Zh7leuRXJiqYchLvOH2QRVmoQTWznNpoNlFFQDfIeh8LhU1EgLNe3FxrXG9ncbIc6nb3zplRhmCFlasFP6WVTkSmh1gx5mNe7xPDyD7dGLQVE3PtoXOnbwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716634357; c=relaxed/simple;
	bh=UNAV+tBKg4GXmNXdLDXk29XupWneP82HXzYMRb7Kehg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JTlh/u3CSt0MNt6v1OOP2cHLLMv1rsUGb8i2mGT90vT/79dY62Qvq7vhXkleMguZOi+ftM1dR/5zq2gQUQ0Rl/6cz9qYyDD50N1jeLQoXWWVPOKw/dfekPYOqGS+3FKdIwoJQOjOWDxfWm8jK6hdP5jRYME7vg/gFrIFNe01GjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZhyTTXff; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716634356; x=1748170356;
  h=date:from:to:cc:subject:message-id;
  bh=UNAV+tBKg4GXmNXdLDXk29XupWneP82HXzYMRb7Kehg=;
  b=ZhyTTXff+Rwk4q1Bljj+v9FPiny0NLuSQe99s9q18om5DWOvcXnP4JQH
   MEY3cu/xz3zr2iBEx2aUL8eb7E4XEoW3Ze0IRt1DTsl6W/nc+NQ7CUzHX
   t/eS9qI2YoOVOqhAlAmDcEqc79FcpyL5UaQNqL+tdUNdymAfkgE7UGqLE
   0HjGu1xydfr22UQUqEaLXn5HSp6l5aXK0On4awWHvwWa8FuVvnqW9nV/V
   AXISE2BBV6693kN80vUiFRk2OhAM6VWlfnu/MRFvUMw4Hx8U1+fw5QAB+
   2EdFA6bForNzuURdkWULrSFmyN08MuFisRbIumsnefwi1tzcvcDuboHHE
   w==;
X-CSE-ConnectionGUID: NT1YzN4kQ1WcwyV345NgFg==
X-CSE-MsgGUID: H77P4gI/Q4i1CR0dd8K8gw==
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="13125905"
X-IronPort-AV: E=Sophos;i="6.08,188,1712646000"; 
   d="scan'208";a="13125905"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2024 03:52:35 -0700
X-CSE-ConnectionGUID: luWNpbw1R8awObfgo8VM0w==
X-CSE-MsgGUID: 7xtudMUnTmadAmoGmR1+oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,188,1712646000"; 
   d="scan'208";a="65079527"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 25 May 2024 03:52:34 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sAp0W-0006qN-0J;
	Sat, 25 May 2024 10:52:31 +0000
Date: Sat, 25 May 2024 18:52:02 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/al] BUILD SUCCESS
 81dc1a0b274a4006ffaf513511456938b4c809a3
Message-ID: <202405251800.zrWOxs78-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/al
branch HEAD: 81dc1a0b274a4006ffaf513511456938b4c809a3  PCI: al: Check IORESOURCE_BUS existence during probe

elapsed time: 1047m

configs tested: 159
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc  
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240525   gcc  
arc                   randconfig-002-20240525   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                           h3600_defconfig   gcc  
arm                        mvebu_v5_defconfig   gcc  
arm                   randconfig-001-20240525   gcc  
arm                   randconfig-002-20240525   gcc  
arm                           sama5_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240525   gcc  
arm64                 randconfig-003-20240525   gcc  
arm64                 randconfig-004-20240525   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240525   gcc  
csky                  randconfig-002-20240525   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240525   gcc  
i386         buildonly-randconfig-002-20240525   gcc  
i386         buildonly-randconfig-003-20240525   gcc  
i386         buildonly-randconfig-004-20240525   clang
i386         buildonly-randconfig-005-20240525   gcc  
i386         buildonly-randconfig-006-20240525   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240525   clang
i386                  randconfig-002-20240525   gcc  
i386                  randconfig-003-20240525   clang
i386                  randconfig-004-20240525   clang
i386                  randconfig-005-20240525   gcc  
i386                  randconfig-006-20240525   gcc  
i386                  randconfig-011-20240525   clang
i386                  randconfig-012-20240525   clang
i386                  randconfig-013-20240525   clang
i386                  randconfig-014-20240525   gcc  
i386                  randconfig-015-20240525   clang
i386                  randconfig-016-20240525   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240525   gcc  
loongarch             randconfig-002-20240525   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240525   gcc  
nios2                 randconfig-002-20240525   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240525   gcc  
parisc                randconfig-002-20240525   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                 mpc832x_rdb_defconfig   gcc  
powerpc               randconfig-001-20240525   gcc  
powerpc               randconfig-002-20240525   gcc  
powerpc               randconfig-003-20240525   gcc  
powerpc                     tqm8560_defconfig   gcc  
powerpc64             randconfig-002-20240525   gcc  
powerpc64             randconfig-003-20240525   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240525   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                    randconfig-001-20240525   gcc  
sh                    randconfig-002-20240525   gcc  
sh                          rsk7201_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240525   gcc  
sparc64               randconfig-002-20240525   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240525   gcc  
um                    randconfig-002-20240525   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240525   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240525   clang
x86_64                randconfig-002-20240525   clang
x86_64                randconfig-003-20240525   clang
x86_64                randconfig-004-20240525   clang
x86_64                randconfig-005-20240525   clang
x86_64                randconfig-006-20240525   clang
x86_64                randconfig-011-20240525   clang
x86_64                randconfig-012-20240525   clang
x86_64                randconfig-014-20240525   clang
x86_64                randconfig-016-20240525   clang
x86_64                randconfig-072-20240525   clang
x86_64                randconfig-073-20240525   clang
x86_64                randconfig-076-20240525   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240525   gcc  
xtensa                randconfig-002-20240525   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

