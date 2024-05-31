Return-Path: <linux-pci+bounces-8135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2498D6871
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 19:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 356FF28BABF
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 17:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F00C1DFCB;
	Fri, 31 May 2024 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QYpqmY8T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9447136B11
	for <linux-pci@vger.kernel.org>; Fri, 31 May 2024 17:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717177690; cv=none; b=RH1o9O1g6XbbbySOzLvkLcaMEf9+pgex30xm/y/sOkjro25SNNjKqKMe5Xqwwb2zzbyo5Ug8vnoqJe5VyS48buT3l4KN7qFxXq7I9OP72CNlX42mh1kDxS5SioKCBSoH6WRZ5gSrOOfp85kyeB2uKqydcesDjFz/pxdIohM7kF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717177690; c=relaxed/simple;
	bh=I8ZeVP8zIj2EAovB8Qo/J7DNFvo0vyPC7IdVynsB6uA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VzNyBN9xfypvMTbQ6K0W4/hBNG9/QAnlKx5R9agf9kvI2icjFknHky4qJkpAeycIQXJ4lT3b21Vn7kq/PfZZTxO2gA+vyrS0zjIn62T5QbKdO1CND6CbTNuOKShAxQmCeWoNDtueHjIQMc+8KL8cZD7laT8cnx0piMpEeUj8/YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QYpqmY8T; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717177689; x=1748713689;
  h=date:from:to:cc:subject:message-id;
  bh=I8ZeVP8zIj2EAovB8Qo/J7DNFvo0vyPC7IdVynsB6uA=;
  b=QYpqmY8T8bJddHJEc52BUAk91zgQ4iD3yPGaa5fSir892KQpRTKlaWzF
   69PdFuo0ks4Zgojf/CdRs9KHDy5Zd5WqzlIWy/zqJEq7+A9bzCtQ8utdF
   C2sLySJTcvrtKAJF16OZ4uOI6/9OG3lTsi89XbV9mH2IZV8WTXe8RGQRI
   3xnOG/ZQNVcgfHKKKeVGOPUsUSuVp4xOb35LMmCfD5QI3fz8ZUMERAp4Y
   xMeBzl1u1Mrb3TF1zaNw4HVmjKht2FWpf/KXBl2cinBIGaFzgDMf/JRss
   UsH3xRQygPnXustiCGi4QJgy4Fp/wzhjERUzn+oD6522VE/gKLowFIWRS
   A==;
X-CSE-ConnectionGUID: eKx8KgJjTj2VPqfcO+Lnxg==
X-CSE-MsgGUID: vSbYLxmsSQCDoAtgstFWZQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13958821"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="13958821"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 10:48:08 -0700
X-CSE-ConnectionGUID: gvMwZgPkQBSIPo/bA1MPkg==
X-CSE-MsgGUID: qn9QUDKFTGqG+hY6fpGARQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="36155620"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 31 May 2024 10:48:07 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sD6MG-000Hbn-0x;
	Fri, 31 May 2024 17:48:04 +0000
Date: Sat, 01 Jun 2024 01:47:18 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:hotplug] BUILD SUCCESS
 9d573d19547b3fae0c1d4e5fce52bdad3fda3664
Message-ID: <202406010115.C4x7DtzS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git hotplug
branch HEAD: 9d573d19547b3fae0c1d4e5fce52bdad3fda3664  PCI: pciehp: Detect device replacement during system sleep

elapsed time: 1463m

configs tested: 187
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
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240531   gcc  
arc                   randconfig-002-20240531   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                            mmp2_defconfig   gcc  
arm                        multi_v5_defconfig   gcc  
arm                           omap1_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                   randconfig-001-20240531   clang
arm                   randconfig-002-20240531   clang
arm                   randconfig-003-20240531   clang
arm                   randconfig-004-20240531   clang
arm                        vexpress_defconfig   gcc  
arm                         wpcm450_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240531   clang
arm64                 randconfig-002-20240531   clang
arm64                 randconfig-003-20240531   gcc  
arm64                 randconfig-004-20240531   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240531   gcc  
csky                  randconfig-002-20240531   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240531   clang
hexagon               randconfig-002-20240531   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240531   clang
i386         buildonly-randconfig-002-20240531   gcc  
i386         buildonly-randconfig-003-20240531   gcc  
i386         buildonly-randconfig-004-20240531   clang
i386         buildonly-randconfig-005-20240531   gcc  
i386         buildonly-randconfig-006-20240531   clang
i386                                defconfig   clang
i386                  randconfig-001-20240531   gcc  
i386                  randconfig-002-20240531   clang
i386                  randconfig-003-20240531   clang
i386                  randconfig-004-20240531   gcc  
i386                  randconfig-005-20240531   clang
i386                  randconfig-006-20240531   clang
i386                  randconfig-011-20240531   clang
i386                  randconfig-012-20240531   gcc  
i386                  randconfig-013-20240531   gcc  
i386                  randconfig-014-20240531   clang
i386                  randconfig-015-20240531   gcc  
i386                  randconfig-016-20240531   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240531   gcc  
loongarch             randconfig-002-20240531   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                          malta_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240531   gcc  
nios2                 randconfig-002-20240531   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240531   gcc  
parisc                randconfig-002-20240531   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      ppc64e_defconfig   gcc  
powerpc               randconfig-001-20240531   clang
powerpc               randconfig-002-20240531   clang
powerpc               randconfig-003-20240531   gcc  
powerpc                  storcenter_defconfig   gcc  
powerpc                     tqm8560_defconfig   gcc  
powerpc64             randconfig-001-20240531   clang
powerpc64             randconfig-002-20240531   clang
powerpc64             randconfig-003-20240531   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240531   clang
riscv                 randconfig-002-20240531   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240531   gcc  
s390                  randconfig-002-20240531   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                    randconfig-001-20240531   gcc  
sh                    randconfig-002-20240531   gcc  
sh                           se7343_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240531   gcc  
sparc64               randconfig-002-20240531   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240531   gcc  
um                    randconfig-002-20240531   clang
um                           x86_64_defconfig   clang
x86_64                           alldefconfig   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240531   clang
x86_64       buildonly-randconfig-002-20240531   gcc  
x86_64       buildonly-randconfig-003-20240531   clang
x86_64       buildonly-randconfig-004-20240531   clang
x86_64       buildonly-randconfig-005-20240531   gcc  
x86_64       buildonly-randconfig-006-20240531   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240531   gcc  
x86_64                randconfig-002-20240531   clang
x86_64                randconfig-003-20240531   gcc  
x86_64                randconfig-004-20240531   gcc  
x86_64                randconfig-005-20240531   gcc  
x86_64                randconfig-006-20240531   gcc  
x86_64                randconfig-011-20240531   clang
x86_64                randconfig-012-20240531   gcc  
x86_64                randconfig-013-20240531   gcc  
x86_64                randconfig-014-20240531   clang
x86_64                randconfig-015-20240531   gcc  
x86_64                randconfig-016-20240531   gcc  
x86_64                randconfig-071-20240531   clang
x86_64                randconfig-072-20240531   gcc  
x86_64                randconfig-073-20240531   gcc  
x86_64                randconfig-074-20240531   gcc  
x86_64                randconfig-075-20240531   clang
x86_64                randconfig-076-20240531   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20240531   gcc  
xtensa                randconfig-002-20240531   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

