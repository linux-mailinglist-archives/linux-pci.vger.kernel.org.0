Return-Path: <linux-pci+bounces-7066-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5678BB821
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 01:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3744C1F22531
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 23:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF15883CA6;
	Fri,  3 May 2024 23:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dk5SU/BB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A83183A1E
	for <linux-pci@vger.kernel.org>; Fri,  3 May 2024 23:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714778345; cv=none; b=Bhqp/MMBdoJfvVODBjuSL5EEkhDkptiM2+zzpon4ccggq4rDdXRuKwWL75Q6Df16oefcAJbRc8WtCuAHOoo3hhRJi9n/iePuviOtKPSGGIy7WjLJdkKvJ8CB/xnm1m8+t5d2MbxZHE3wehC8GIe0bdUKOanBqwwtagSbxWjjKvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714778345; c=relaxed/simple;
	bh=X9ck2cnd5l3I0GZoehgfFUW/Ek8zPD0ujgK/Wb9fEhA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HGq8e1YVKGsr68kLE4zbYVusat9nGyqEX3rxxO5fYm1rfGOu2zGaNnKxQSDe/KZYmX7K/kKLAyeEr9W4k0VmwvdSQbwSw4DryU0aZWrDM9X8dGFSd5XdgKVgZ9j2ReDiC0pCThGitJPWt7rc7cSQg7hHw5mzS9buU77PbLMjoGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dk5SU/BB; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714778344; x=1746314344;
  h=date:from:to:cc:subject:message-id;
  bh=X9ck2cnd5l3I0GZoehgfFUW/Ek8zPD0ujgK/Wb9fEhA=;
  b=dk5SU/BBMaxmEvGZOKB7DmPHSt5gtqaae6m9ArPHTZCBnXwUlGtahMoZ
   7falz0+OgrcO5+7lM27uTb115X4FQR5Dyx0GPvIOu0XKD1Ci/veHpEZnl
   VVLaFkYeeU5gZWPK2xgtHFOL4JadSbqcKNY8jrl3mHLiPVi2Uj2GixcLH
   DMLcR5p2IloN3dE1RMAbyOoWEgaY54uSV0Pw5fTITkjERIyYqWTfFxu18
   VCwGEpmvsVBqD9G5FsD5a5XdVHtR+0D27sqdfRdfLYU3Fz4jemA2fdFYZ
   LEoJ6H3Hkaf0wcCXIF6C1ee+7dHzSxn+NY7w2DWrD9SDTpqd9tVMYPouA
   A==;
X-CSE-ConnectionGUID: jtMn1WlNRieUc/pnldcueQ==
X-CSE-MsgGUID: MWXNY2aERhCnsB+WNtVqtw==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="21284763"
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="21284763"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 16:19:03 -0700
X-CSE-ConnectionGUID: z9de1DqoQ1ekStVWItEF2w==
X-CSE-MsgGUID: Dqavoj6tRU+nhZdYQDOmnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="50782688"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 03 May 2024 16:19:03 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s32B9-000CAw-2x;
	Fri, 03 May 2024 23:18:59 +0000
Date: Sat, 04 May 2024 07:18:23 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:wip/2405-ilpo-window-sizing] BUILD SUCCESS
 f5226ebd25139320f6988561a1de7c783c0319fb
Message-ID: <202405040721.Y74qm5t2-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git wip/2405-ilpo-window-sizing
branch HEAD: f5226ebd25139320f6988561a1de7c783c0319fb  PCI: Relax bridge window tail sizing rules

elapsed time: 1458m

configs tested: 178
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240503   gcc  
arc                   randconfig-001-20240504   gcc  
arc                   randconfig-002-20240503   gcc  
arc                   randconfig-002-20240504   gcc  
arc                           tb10x_defconfig   gcc  
arm                               allnoconfig   clang
arm                                 defconfig   clang
arm                        multi_v5_defconfig   gcc  
arm                   randconfig-004-20240503   gcc  
arm                         s3c6400_defconfig   gcc  
arm                           sama5_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240504   gcc  
arm64                 randconfig-002-20240503   gcc  
arm64                 randconfig-002-20240504   gcc  
arm64                 randconfig-003-20240504   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240503   gcc  
csky                  randconfig-001-20240504   gcc  
csky                  randconfig-002-20240503   gcc  
csky                  randconfig-002-20240504   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240503   clang
i386         buildonly-randconfig-001-20240504   clang
i386         buildonly-randconfig-002-20240503   clang
i386         buildonly-randconfig-004-20240504   clang
i386         buildonly-randconfig-005-20240504   clang
i386         buildonly-randconfig-006-20240503   clang
i386         buildonly-randconfig-006-20240504   clang
i386                                defconfig   clang
i386                  randconfig-002-20240503   clang
i386                  randconfig-002-20240504   clang
i386                  randconfig-003-20240503   clang
i386                  randconfig-004-20240504   clang
i386                  randconfig-005-20240503   clang
i386                  randconfig-005-20240504   clang
i386                  randconfig-006-20240503   clang
i386                  randconfig-011-20240503   clang
i386                  randconfig-012-20240504   clang
i386                  randconfig-013-20240504   clang
i386                  randconfig-016-20240503   clang
i386                  randconfig-016-20240504   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240503   gcc  
loongarch             randconfig-001-20240504   gcc  
loongarch             randconfig-002-20240503   gcc  
loongarch             randconfig-002-20240504   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240503   gcc  
nios2                 randconfig-001-20240504   gcc  
nios2                 randconfig-002-20240503   gcc  
nios2                 randconfig-002-20240504   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240503   gcc  
parisc                randconfig-001-20240504   gcc  
parisc                randconfig-002-20240503   gcc  
parisc                randconfig-002-20240504   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    ge_imp3a_defconfig   gcc  
powerpc                 mpc8313_rdb_defconfig   gcc  
powerpc               randconfig-001-20240504   gcc  
powerpc               randconfig-002-20240504   gcc  
powerpc               randconfig-003-20240503   gcc  
powerpc               randconfig-003-20240504   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240503   gcc  
riscv                 randconfig-001-20240504   gcc  
riscv                 randconfig-002-20240503   gcc  
riscv                 randconfig-002-20240504   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240503   gcc  
s390                  randconfig-002-20240503   gcc  
s390                  randconfig-002-20240504   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                    randconfig-001-20240503   gcc  
sh                    randconfig-001-20240504   gcc  
sh                    randconfig-002-20240503   gcc  
sh                    randconfig-002-20240504   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240503   gcc  
sparc64               randconfig-001-20240504   gcc  
sparc64               randconfig-002-20240503   gcc  
sparc64               randconfig-002-20240504   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240504   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-004-20240503   clang
x86_64       buildonly-randconfig-006-20240503   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240503   clang
x86_64                randconfig-002-20240503   clang
x86_64                randconfig-003-20240503   clang
x86_64                randconfig-006-20240503   clang
x86_64                randconfig-011-20240503   clang
x86_64                randconfig-012-20240503   clang
x86_64                randconfig-013-20240503   clang
x86_64                randconfig-014-20240503   clang
x86_64                randconfig-015-20240503   clang
x86_64                randconfig-016-20240503   clang
x86_64                randconfig-071-20240503   clang
x86_64                randconfig-072-20240503   clang
x86_64                randconfig-073-20240503   clang
x86_64                randconfig-074-20240503   clang
x86_64                randconfig-075-20240503   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20240503   gcc  
xtensa                randconfig-001-20240504   gcc  
xtensa                randconfig-002-20240503   gcc  
xtensa                randconfig-002-20240504   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

