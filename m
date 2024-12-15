Return-Path: <linux-pci+bounces-18466-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECE29F2778
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 00:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD34D164EEB
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 23:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B560F1BC9FE;
	Sun, 15 Dec 2024 23:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YeamSANJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7E9335C7
	for <linux-pci@vger.kernel.org>; Sun, 15 Dec 2024 23:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734307065; cv=none; b=tu4M6earS1pd1XZAAD9H+U5wmsQyGATFqIK8U/4E41VCPdJBaZmm60qtDaUGEEhyNJuQpuAqASprPzVXD6+tadKFoqNku6k9ZPqjr/6etlq3m/04xPsq0ikO8lFdcLo3JOi6wGx19PJtQvtafkGTdqxnHcuicMho6rqOk/gTTzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734307065; c=relaxed/simple;
	bh=bVR1kbPiQd0pydIU3Wssyolo9PAyLa1NemRJbQctS+c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tmoaVP8wAr+ybivLyv5PI44/UjidgLSWqfTix4jfB5F4bGFKahOsvvff0db5C0odscxZD7dVjLaaNNrk9GpEvsou432EydCZoCHrFnoq+uTCsyEU+aBTZ4+sYpcbe1kYxIbeohOfVA6r/sLT3StRW1fvqz+Fk9nssJRvCo4nj/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YeamSANJ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734307064; x=1765843064;
  h=date:from:to:cc:subject:message-id;
  bh=bVR1kbPiQd0pydIU3Wssyolo9PAyLa1NemRJbQctS+c=;
  b=YeamSANJ0wfkbl1YPmbmnFLff8zw4tGXyhrMndaC5ZBwOlfUIYQ1gU/X
   IKbyvbiqdM06/+FiYe5+DzjZKXSnLwHMrkONvXSKeVG9V5uKS6AVhwItX
   bA/rS7gxauXNArogxNRWC+9U6dCxtj4OyxbwMEGfJwgvbSG8IX97aaFOG
   SjRKa0m8gbA1koorW8aSO3bu5KSWpyoGhN6Y1iWykHz45egLFaZXBzrIN
   T/+F52erlGbfVtNvJPs8qvtX7GJSovqrnTOTbeeizCcw3vYZdjEfVpdTt
   GicHPuuYOr9/TU+MxEXn+NKFaDEapm/UeKSjV9VS0JgjZ6ANlDkWbJqQL
   A==;
X-CSE-ConnectionGUID: 4XBWDUeaRn+/2+g1LfhPRg==
X-CSE-MsgGUID: oOVZwzkLT6yWQAwMze8SGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34721828"
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="34721828"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 15:57:42 -0800
X-CSE-ConnectionGUID: 33EZANe3SdyhUA51nxQ3pA==
X-CSE-MsgGUID: 93AKUbeMTb2zil8gP+sJUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="96914957"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 15 Dec 2024 15:57:40 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMyUU-000DuQ-12;
	Sun, 15 Dec 2024 23:57:38 +0000
Date: Mon, 16 Dec 2024 07:57:13 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:devres] BUILD SUCCESS
 1cd105fd1a6d1f489ad8c6ed4af177b953ca5ad0
Message-ID: <202412160707.j9Z5dhAG-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git devres
branch HEAD: 1cd105fd1a6d1f489ad8c6ed4af177b953ca5ad0  HID: amd_sfh: Use always-managed version of pcim_intx()

elapsed time: 1388m

configs tested: 129
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20241215    gcc-13.2.0
arc                   randconfig-002-20241215    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20241215    clang-20
arm                   randconfig-002-20241215    clang-16
arm                   randconfig-003-20241215    gcc-14.2.0
arm                   randconfig-004-20241215    clang-20
arm                        realview_defconfig    clang-19
arm                       versatile_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241215    gcc-14.2.0
arm64                 randconfig-002-20241215    gcc-14.2.0
arm64                 randconfig-003-20241215    clang-20
arm64                 randconfig-004-20241215    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241215    gcc-14.2.0
csky                  randconfig-002-20241215    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                             defconfig    clang-20
hexagon               randconfig-001-20241215    clang-20
hexagon               randconfig-002-20241215    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241215    gcc-12
i386        buildonly-randconfig-002-20241215    gcc-12
i386        buildonly-randconfig-003-20241215    gcc-12
i386        buildonly-randconfig-004-20241215    gcc-12
i386        buildonly-randconfig-005-20241215    gcc-12
i386        buildonly-randconfig-006-20241215    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241215    gcc-14.2.0
loongarch             randconfig-002-20241215    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       alldefconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          eyeq6_defconfig    clang-20
mips                            gpr_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241215    gcc-14.2.0
nios2                 randconfig-002-20241215    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
openrisc                    or1ksim_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                generic-64bit_defconfig    gcc-14.2.0
parisc                randconfig-001-20241215    gcc-14.2.0
parisc                randconfig-002-20241215    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                          g5_defconfig    gcc-14.2.0
powerpc                       ppc64_defconfig    clang-19
powerpc               randconfig-001-20241215    gcc-14.2.0
powerpc               randconfig-002-20241215    clang-20
powerpc               randconfig-003-20241215    gcc-14.2.0
powerpc64             randconfig-001-20241215    gcc-14.2.0
powerpc64             randconfig-002-20241215    gcc-14.2.0
powerpc64             randconfig-003-20241215    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                 randconfig-001-20241215    clang-16
riscv                 randconfig-002-20241215    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20241215    gcc-14.2.0
s390                  randconfig-002-20241215    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                            migor_defconfig    gcc-14.2.0
sh                    randconfig-001-20241215    gcc-14.2.0
sh                    randconfig-002-20241215    gcc-14.2.0
sh                   sh7724_generic_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241215    gcc-14.2.0
sparc                 randconfig-002-20241215    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241215    gcc-14.2.0
sparc64               randconfig-002-20241215    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241215    gcc-12
um                    randconfig-002-20241215    clang-18
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241215    gcc-12
x86_64      buildonly-randconfig-002-20241215    clang-19
x86_64      buildonly-randconfig-003-20241215    clang-19
x86_64      buildonly-randconfig-004-20241215    gcc-12
x86_64      buildonly-randconfig-005-20241215    clang-19
x86_64      buildonly-randconfig-006-20241215    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                randconfig-001-20241215    gcc-14.2.0
xtensa                randconfig-002-20241215    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

