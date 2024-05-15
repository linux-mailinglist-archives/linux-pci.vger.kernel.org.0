Return-Path: <linux-pci+bounces-7477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A26A78C611A
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 09:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37C661F2330F
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 07:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6596440875;
	Wed, 15 May 2024 07:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UuWXTOCS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E23B44368
	for <linux-pci@vger.kernel.org>; Wed, 15 May 2024 07:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715756613; cv=none; b=k+XjkmYTJuzYGQ6k63eGREh5EfCkWleAToKIeFA/GogNWS9GoiRUvOlsZuekYqHawab82bEcVT/MxotAfHisNzGqa23hRmhK3gKv2HYx++5ri00OvHr3Pfs5mGDFx6K1BevfEyfiKX2SVydc3VJur7Y7UPgeIkWVnCT9AGZuJGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715756613; c=relaxed/simple;
	bh=vJpvKH0esatoBwlHJt+fIpT3MHVrYL9q2KQPBjT6zWk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sw6yqVtXZ6/H9mZtpjV/qB4VyMs7VcCvzeyMaVtJXoy2w1hhFBu/51BLPPT3b8zjyK0hNRYQUsS8ICT9n2bdj+8m2Emk7AmsQRKrIFnjGLB6CiOaYyhf64/LK4OLxA1ZnWrF9PwqwX69R7lK2ZVPVMWg/eLh1VPQLR847bf6oeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UuWXTOCS; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715756611; x=1747292611;
  h=date:from:to:cc:subject:message-id;
  bh=vJpvKH0esatoBwlHJt+fIpT3MHVrYL9q2KQPBjT6zWk=;
  b=UuWXTOCS599w2LA145BCoykgTjPohgckZYKciGCqeI+3vjto5Wc/fdrL
   uFMdY1kyBl2HsK5DWPxZjEoEACCdyopf1FGFZaKrZueNChwNf1cjeofaO
   nogn8wJDBYXBaJs+tdbvDh6HybkDsBGC2GVXT56PRoDNjKFIhrThEtqxS
   xPjxeWA3V5lYKkN4b2ZBYOfFYYZ46mCgpEwGsaR0OBwLQR5Ok/N9H4uXQ
   GBzeAO4wN4GL6b27P2k1PYWVGeDpkV32NEs/MXtNYfWlA45MCOEpL8Gr3
   4TN6+ERKvOrlUlxuWrDT0lvPmliJycHVSCoElTOAn35iTRX+YQ3RDK5nH
   g==;
X-CSE-ConnectionGUID: RdwlBH1IRA6qGPi/XVIFnA==
X-CSE-MsgGUID: 0zpV++p7SUClN4brKwbZzA==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11958077"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="11958077"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 00:03:30 -0700
X-CSE-ConnectionGUID: 49dIkkFEQVOgfyfDAbJ/GA==
X-CSE-MsgGUID: 5rxayS4IRmywP+EHJcPtUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="30894172"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 15 May 2024 00:03:29 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s78ff-000CYN-0p;
	Wed, 15 May 2024 07:03:27 +0000
Date: Wed, 15 May 2024 15:03:03 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 a38bebb2868274a1e9316c9e99500395b08ccb12
Message-ID: <202405151501.SNZ4MmW5-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: a38bebb2868274a1e9316c9e99500395b08ccb12  Merge branch 'pci/misc'

elapsed time: 737m

configs tested: 180
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
arc                   randconfig-001-20240515   gcc  
arc                   randconfig-002-20240515   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                           h3600_defconfig   gcc  
arm                         orion5x_defconfig   clang
arm                   randconfig-001-20240515   clang
arm                   randconfig-002-20240515   gcc  
arm                   randconfig-003-20240515   clang
arm                   randconfig-004-20240515   gcc  
arm                        spear6xx_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240515   gcc  
arm64                 randconfig-002-20240515   clang
arm64                 randconfig-003-20240515   clang
arm64                 randconfig-004-20240515   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240515   gcc  
csky                  randconfig-002-20240515   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240515   clang
hexagon               randconfig-002-20240515   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240515   gcc  
i386         buildonly-randconfig-002-20240515   gcc  
i386         buildonly-randconfig-003-20240515   gcc  
i386         buildonly-randconfig-004-20240515   gcc  
i386         buildonly-randconfig-005-20240515   gcc  
i386         buildonly-randconfig-006-20240515   clang
i386                                defconfig   clang
i386                  randconfig-001-20240515   clang
i386                  randconfig-002-20240515   gcc  
i386                  randconfig-003-20240515   gcc  
i386                  randconfig-004-20240515   gcc  
i386                  randconfig-005-20240515   clang
i386                  randconfig-006-20240515   gcc  
i386                  randconfig-011-20240515   clang
i386                  randconfig-012-20240515   gcc  
i386                  randconfig-013-20240515   clang
i386                  randconfig-014-20240515   gcc  
i386                  randconfig-015-20240515   gcc  
i386                  randconfig-016-20240515   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20240515   gcc  
loongarch             randconfig-002-20240515   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath25_defconfig   clang
mips                          ath79_defconfig   gcc  
mips                         db1xxx_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240515   gcc  
nios2                 randconfig-002-20240515   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20240515   gcc  
parisc                randconfig-002-20240515   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                       holly_defconfig   clang
powerpc                   motionpro_defconfig   clang
powerpc                 mpc8315_rdb_defconfig   clang
powerpc               randconfig-001-20240515   clang
powerpc               randconfig-002-20240515   clang
powerpc               randconfig-003-20240515   gcc  
powerpc64             randconfig-001-20240515   gcc  
powerpc64             randconfig-002-20240515   clang
powerpc64             randconfig-003-20240515   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                    nommu_virt_defconfig   clang
riscv                 randconfig-001-20240515   clang
riscv                 randconfig-002-20240515   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240515   clang
s390                  randconfig-002-20240515   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                    randconfig-001-20240515   gcc  
sh                    randconfig-002-20240515   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240515   gcc  
sparc64               randconfig-002-20240515   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240515   gcc  
um                    randconfig-002-20240515   gcc  
um                           x86_64_defconfig   clang
x86_64                           alldefconfig   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240515   gcc  
x86_64       buildonly-randconfig-002-20240515   gcc  
x86_64       buildonly-randconfig-003-20240515   clang
x86_64       buildonly-randconfig-004-20240515   clang
x86_64       buildonly-randconfig-005-20240515   clang
x86_64       buildonly-randconfig-006-20240515   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240515   gcc  
x86_64                randconfig-002-20240515   clang
x86_64                randconfig-003-20240515   clang
x86_64                randconfig-004-20240515   clang
x86_64                randconfig-005-20240515   clang
x86_64                randconfig-006-20240515   clang
x86_64                randconfig-011-20240515   clang
x86_64                randconfig-012-20240515   clang
x86_64                randconfig-013-20240515   gcc  
x86_64                randconfig-014-20240515   gcc  
x86_64                randconfig-015-20240515   clang
x86_64                randconfig-016-20240515   clang
x86_64                randconfig-071-20240515   gcc  
x86_64                randconfig-072-20240515   gcc  
x86_64                randconfig-073-20240515   gcc  
x86_64                randconfig-074-20240515   clang
x86_64                randconfig-075-20240515   clang
x86_64                randconfig-076-20240515   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                randconfig-001-20240515   gcc  
xtensa                randconfig-002-20240515   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

