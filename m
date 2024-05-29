Return-Path: <linux-pci+bounces-8040-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 426AC8D3BFB
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 18:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64CEA1C21743
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 16:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E18156C61;
	Wed, 29 May 2024 16:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HL7m8xwz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E509139588
	for <linux-pci@vger.kernel.org>; Wed, 29 May 2024 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716999136; cv=none; b=flGfr9HBfVV3Xi2zturL1DcP/bydYSjm6KW12K66rxdw8yfqImho+bXgvI/xIjIUMprdNTDaw4Ist7BmAi/57f99Dwbm+Gd9rHqaJZ3ReIEAjfU7QsZkPBOgrrwmonVF7ZmY60ksl3kfbmFyjToIMlEFaaJR5O2NCRcWiGjFwKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716999136; c=relaxed/simple;
	bh=BzX9+qJbuuyyY8RCaVPvtsmNM4o0eGcWKHVQ7eqfJkE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NF4+F2XAgIvGpquJPaLH2IZtjWkCYO7VWWsBg3K6Il7irCE/HoA6qpDUJ01KgLAgbEC2uUr1MVdxV1Eyd4UkAr6KsXnS5L16ba/Be1R+b3w8X1yGDRVS/DbS4KeSOrtJorWBiHsiumcfBhAHTqSoXyi5gzUWwJvKSksh+/Bdens=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HL7m8xwz; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716999135; x=1748535135;
  h=date:from:to:cc:subject:message-id;
  bh=BzX9+qJbuuyyY8RCaVPvtsmNM4o0eGcWKHVQ7eqfJkE=;
  b=HL7m8xwz8LKa0EBS1KrYyXwW2dTKjyhJWegFBPsidpy7KCsUnHwMN/tC
   7VAfHlTI71d9WOP958hcSqZXpnGRokWys6xdrHPLJsGE73U8UBTxpNgWo
   8duggiVl3QuGD1o1iE/ABzjFI+VKcH8SEkfns0ppjH8FQupTMyLnBS15/
   MCjkrraLRuKMYj4S57aYOPPEXo2hbSDV4zKTuNRyoyCXDE0Xf4wOfXObV
   GG2qrNrnicvN+HlTh3+ex6cKpn76XaumVVChrP/MMR3REpv00D4a9ZUgh
   dDLbtWCB2gbLpBdy8hO4UEEK5sNo5/Ahe0xLGpwrrxKWChwRNO9BWg0ph
   A==;
X-CSE-ConnectionGUID: ZmByUbNTTTuttRbv5wZLLA==
X-CSE-MsgGUID: /mL3iN+aTri15NtST8KnUw==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13264459"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="13264459"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 09:12:14 -0700
X-CSE-ConnectionGUID: b8aXxIasQfSMplWIZSRlEA==
X-CSE-MsgGUID: ZRIuAymLSvOY1snS6QIHqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="40384324"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 29 May 2024 09:12:13 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sCLuJ-000Dv9-35;
	Wed, 29 May 2024 16:12:08 +0000
Date: Thu, 30 May 2024 00:11:29 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 e3fca37312892122d73f8c5293c0d1cc8c34500b
Message-ID: <202405300027.ImQDfyBz-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: e3fca37312892122d73f8c5293c0d1cc8c34500b  Merge branch 'pci/controller/tegra194'

elapsed time: 1317m

configs tested: 149
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
arc                   randconfig-001-20240529   gcc  
arc                   randconfig-002-20240529   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                        clps711x_defconfig   clang
arm                                 defconfig   clang
arm                            hisi_defconfig   gcc  
arm                             mxs_defconfig   clang
arm                   randconfig-001-20240529   gcc  
arm                   randconfig-002-20240529   gcc  
arm                   randconfig-003-20240529   gcc  
arm                   randconfig-004-20240529   gcc  
arm                           sama7_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-003-20240529   gcc  
arm64                 randconfig-004-20240529   gcc  
csky                             alldefconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240529   gcc  
csky                  randconfig-002-20240529   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-002-20240529   gcc  
i386         buildonly-randconfig-003-20240529   gcc  
i386         buildonly-randconfig-005-20240529   gcc  
i386                                defconfig   clang
i386                  randconfig-002-20240529   gcc  
i386                  randconfig-003-20240529   gcc  
i386                  randconfig-004-20240529   gcc  
i386                  randconfig-014-20240529   gcc  
i386                  randconfig-016-20240529   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240529   gcc  
loongarch             randconfig-002-20240529   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          malta_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240529   gcc  
nios2                 randconfig-002-20240529   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240529   gcc  
parisc                randconfig-002-20240529   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      ep88xc_defconfig   gcc  
powerpc                      katmai_defconfig   clang
powerpc                     kmeter1_defconfig   gcc  
powerpc                 linkstation_defconfig   clang
powerpc                       ppc64_defconfig   clang
powerpc64             randconfig-001-20240529   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                    nommu_k210_defconfig   clang
riscv                 randconfig-001-20240529   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-002-20240529   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                    randconfig-001-20240529   gcc  
sh                    randconfig-002-20240529   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240529   gcc  
sparc64               randconfig-002-20240529   gcc  
um                               alldefconfig   clang
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-002-20240529   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-002-20240529   clang
x86_64       buildonly-randconfig-003-20240529   clang
x86_64       buildonly-randconfig-005-20240529   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-002-20240529   clang
x86_64                randconfig-003-20240529   clang
x86_64                randconfig-004-20240529   clang
x86_64                randconfig-013-20240529   clang
x86_64                randconfig-016-20240529   clang
x86_64                randconfig-071-20240529   clang
x86_64                randconfig-074-20240529   clang
x86_64                randconfig-075-20240529   clang
x86_64                randconfig-076-20240529   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240529   gcc  
xtensa                randconfig-002-20240529   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

