Return-Path: <linux-pci+bounces-3064-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0558489D5
	for <lists+linux-pci@lfdr.de>; Sun,  4 Feb 2024 01:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AE301F238E0
	for <lists+linux-pci@lfdr.de>; Sun,  4 Feb 2024 00:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F2D17E;
	Sun,  4 Feb 2024 00:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P8pyP68y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5365B17585
	for <linux-pci@vger.kernel.org>; Sun,  4 Feb 2024 00:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707005057; cv=none; b=JwNcwTzFOGfGilVM9EFrbmyDWJSwe6X9PKZrjpJZogbM1PdNFUI9XNaHfWsVQBNWX8h+V6zFyVd2l6Re4eBE0rLD5wrP7CqcJD7KCb5k/X+ib3FIf+06GfP7UljpgxVHHaCs7xqS9FvlS/J47q5rf00/0Ne5fnnhmY0rkSaLSAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707005057; c=relaxed/simple;
	bh=+6CtH2DxglGEdvUzMknIm/nrALJL33TUox+Ig0ZMK78=;
	h=Date:From:To:Cc:Subject:Message-ID; b=igMbLXfnbS+ybRsvj1GEefX5i4+0QsL7EUEM/ZxVg1z9lFX2jFQYCIe5HlcnXxkivZFlVoEZPMzCopGEta65zgyi95wm/jm9Ry48mq3BeS40iLAFOPytEk3H8ZLOGfjyqwRRuRBulsrT/fN+1808J9fzB83ozslGugjbrJ6SvTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P8pyP68y; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707005055; x=1738541055;
  h=date:from:to:cc:subject:message-id;
  bh=+6CtH2DxglGEdvUzMknIm/nrALJL33TUox+Ig0ZMK78=;
  b=P8pyP68yQQm2SEq4ZtYv4h98+bk52GdjAnPA/Nz67t4kN6fLIknDXeOS
   yIUFci2+r5YALIpt0iaR+HqbGJvhbjP09U7gPYeHUtH4D7jIhcDjOzz6L
   t8VZpnEeUpL/747Ew/1dBCXqZJdF3N246OL4eFaVOAyVvITkoDdkryfdc
   uN2H9amZ50tT4G5xf7LJ0SwxI7FS/uy+lpai6yAgTkGLJUbfhFT6wEzL/
   L6Y1BpleOrPWiYFli/hJBvW2GcbpOPHASHwRBymnxbabySoKktU/Z+j7u
   /iVZbn83bkheJzHc8gdD2YEPoGBw10FK2GKoZKGT/UeApqVMni0lVGELp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="3314360"
X-IronPort-AV: E=Sophos;i="6.05,241,1701158400"; 
   d="scan'208";a="3314360"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 16:04:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,241,1701158400"; 
   d="scan'208";a="392380"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 03 Feb 2024 16:04:13 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWPzW-0005lI-14;
	Sun, 04 Feb 2024 00:04:10 +0000
Date: Sun, 04 Feb 2024 08:03:25 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 1281aa073d3701b03cc6e716dc128df5ba47509d
Message-ID: <202402040822.mBySBlAL-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 1281aa073d3701b03cc6e716dc128df5ba47509d  Merge branch 'pci/enumeration'

elapsed time: 1444m

configs tested: 204
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                   randconfig-001-20240203   gcc  
arc                   randconfig-001-20240204   gcc  
arc                   randconfig-002-20240203   gcc  
arc                   randconfig-002-20240204   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                                 defconfig   clang
arm                       netwinder_defconfig   gcc  
arm                   randconfig-001-20240204   gcc  
arm                   randconfig-003-20240203   gcc  
arm                   randconfig-004-20240204   gcc  
arm                         s5pv210_defconfig   gcc  
arm                        shmobile_defconfig   gcc  
arm                         socfpga_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240204   gcc  
arm64                 randconfig-003-20240203   gcc  
arm64                 randconfig-003-20240204   gcc  
arm64                 randconfig-004-20240203   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240203   gcc  
csky                  randconfig-001-20240204   gcc  
csky                  randconfig-002-20240203   gcc  
csky                  randconfig-002-20240204   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             alldefconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240204   gcc  
i386         buildonly-randconfig-002-20240203   gcc  
i386         buildonly-randconfig-002-20240204   gcc  
i386         buildonly-randconfig-003-20240204   gcc  
i386         buildonly-randconfig-004-20240204   gcc  
i386         buildonly-randconfig-005-20240204   gcc  
i386         buildonly-randconfig-006-20240203   gcc  
i386         buildonly-randconfig-006-20240204   gcc  
i386                                defconfig   clang
i386                  randconfig-002-20240203   gcc  
i386                  randconfig-004-20240203   gcc  
i386                  randconfig-004-20240204   gcc  
i386                  randconfig-006-20240203   gcc  
i386                  randconfig-006-20240204   gcc  
i386                  randconfig-012-20240203   gcc  
i386                  randconfig-012-20240204   gcc  
i386                  randconfig-013-20240203   gcc  
i386                  randconfig-014-20240203   gcc  
i386                  randconfig-015-20240203   gcc  
i386                  randconfig-016-20240203   gcc  
i386                  randconfig-016-20240204   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240203   gcc  
loongarch             randconfig-001-20240204   gcc  
loongarch             randconfig-002-20240203   gcc  
loongarch             randconfig-002-20240204   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240203   gcc  
nios2                 randconfig-001-20240204   gcc  
nios2                 randconfig-002-20240203   gcc  
nios2                 randconfig-002-20240204   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240203   gcc  
parisc                randconfig-001-20240204   gcc  
parisc                randconfig-002-20240203   gcc  
parisc                randconfig-002-20240204   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    mvme5100_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20240204   gcc  
powerpc               randconfig-002-20240204   gcc  
powerpc               randconfig-003-20240204   gcc  
powerpc64             randconfig-001-20240204   gcc  
powerpc64             randconfig-002-20240203   gcc  
powerpc64             randconfig-003-20240204   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-002-20240204   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240203   gcc  
s390                  randconfig-002-20240204   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                    randconfig-001-20240203   gcc  
sh                    randconfig-001-20240204   gcc  
sh                    randconfig-002-20240203   gcc  
sh                    randconfig-002-20240204   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          rsk7203_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240203   gcc  
sparc64               randconfig-001-20240204   gcc  
sparc64               randconfig-002-20240203   gcc  
sparc64               randconfig-002-20240204   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240204   gcc  
um                    randconfig-002-20240204   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240204   clang
x86_64       buildonly-randconfig-002-20240204   clang
x86_64       buildonly-randconfig-005-20240204   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-003-20240203   clang
x86_64                randconfig-003-20240204   clang
x86_64                randconfig-004-20240204   clang
x86_64                randconfig-013-20240203   clang
x86_64                randconfig-014-20240203   clang
x86_64                randconfig-015-20240203   clang
x86_64                randconfig-015-20240204   clang
x86_64                randconfig-016-20240203   clang
x86_64                randconfig-016-20240204   clang
x86_64                randconfig-071-20240203   clang
x86_64                randconfig-073-20240203   clang
x86_64                randconfig-074-20240203   clang
x86_64                randconfig-074-20240204   clang
x86_64                randconfig-075-20240203   clang
x86_64                randconfig-075-20240204   clang
x86_64                randconfig-076-20240203   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20240203   gcc  
xtensa                randconfig-001-20240204   gcc  
xtensa                randconfig-002-20240203   gcc  
xtensa                randconfig-002-20240204   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

