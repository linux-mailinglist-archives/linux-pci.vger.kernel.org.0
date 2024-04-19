Return-Path: <linux-pci+bounces-6489-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 989BE8AB58A
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 21:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50C07281E87
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 19:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163CB13B284;
	Fri, 19 Apr 2024 19:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ntmVVdSL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E82528374
	for <linux-pci@vger.kernel.org>; Fri, 19 Apr 2024 19:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713554593; cv=none; b=OZjsk+Eye9hcHZsSR6YuQ2WpNDv8m8YFtecidyNom0aXbub4iMSz2t7Z0TypctuR08Kh/esLZeatRb2EmlJesdKdIr89vjL/LdanyaKQmMZNG91Dr1ORE74o8l98rXFnf6PfYMG7+rkVBH/RaeifxSw5pYbNpyUmapkihkbQ5cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713554593; c=relaxed/simple;
	bh=IBBt3pntIwPWgqwJa8wrzmmegYo69EiFIq/Dc81ICMQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Itc+kKLWUDwZ7JiSvgk+AJ7zW1gbq2Ob5+0pJ7HnvSPEKEmzVwlPP/9Yg7bNR78jmi10kVaAsAcOL1twpbEVKyQIG0Mr65GWeGuohk4hH7murXnom+k67AJhuQWnCjr4FwsjD3gpbpkOto/wUOqdHN9+eZ5jpPc3GZ0Pnawj7Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ntmVVdSL; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713554592; x=1745090592;
  h=date:from:to:cc:subject:message-id;
  bh=IBBt3pntIwPWgqwJa8wrzmmegYo69EiFIq/Dc81ICMQ=;
  b=ntmVVdSLfeT+yJH6ciJlBj2dbTrh6pbC64t4pROXeiDt5mD5u6IgcL41
   +gjWHRF4PHhjKVc4k5dTdqqLNt30upZn49kCaIlGGR6kUxgOhTMdDxSqZ
   PWGkkrcgSiA+FDZh/RV7HY9saMWbPMDeFi00vs4thcdiL0nqYBei2MIOb
   ZJ0OXfMAR/hFOIlW2xg9Ar/SlZ665sfYDTIfFtQMbtGEXn3Vp4vP0h5WF
   bBcLzYTonzeqfu9hYrZBu1i/ehM0daz+pT4+TVa6/T4XDyqmYNXWuNpEk
   B2AMaqp7OfGYG0KymIw8TLOTbqE0kUF8bbVYdFlhCQ7eZerlcm7DdmiAE
   w==;
X-CSE-ConnectionGUID: eAanReWzRpOu9SWmT8I42A==
X-CSE-MsgGUID: cZxndbmlTjCQ0NVaVCICdg==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="26689054"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="26689054"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 12:23:11 -0700
X-CSE-ConnectionGUID: Ek9f0ZswQP2RocI36My6kw==
X-CSE-MsgGUID: bqhXwNZQS0Sdb5/uJFhqjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="27957321"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 19 Apr 2024 12:23:09 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rxtpD-000APU-1U;
	Fri, 19 Apr 2024 19:23:07 +0000
Date: Sat, 20 Apr 2024 03:22:33 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 c7ae396ec597b2f3644f90f5c7278674b0527aa9
Message-ID: <202404200331.btyU0Eqq-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc
branch HEAD: c7ae396ec597b2f3644f90f5c7278674b0527aa9  PCI: Annotate pci_cache_line_size variables as __ro_after_init

elapsed time: 1448m

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
arc                     haps_hs_smp_defconfig   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                       omap2plus_defconfig   gcc  
arm                   randconfig-002-20240419   clang
arm                   randconfig-004-20240419   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240419   clang
arm64                 randconfig-002-20240419   clang
arm64                 randconfig-003-20240419   clang
arm64                 randconfig-004-20240419   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240419   clang
hexagon               randconfig-002-20240419   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240419   clang
i386                                defconfig   clang
i386                  randconfig-001-20240419   clang
i386                  randconfig-002-20240419   clang
i386                  randconfig-003-20240419   clang
i386                  randconfig-005-20240419   clang
i386                  randconfig-006-20240419   clang
i386                  randconfig-012-20240419   clang
i386                  randconfig-014-20240419   clang
i386                  randconfig-016-20240419   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
m68k                           virt_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips                       lemote2f_defconfig   gcc  
mips                     loongson1c_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc                    mvme5100_defconfig   gcc  
powerpc64             randconfig-003-20240419   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240419   clang
riscv                 randconfig-002-20240419   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240419   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          alldefconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-002-20240419   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240419   clang
x86_64       buildonly-randconfig-002-20240419   gcc  
x86_64       buildonly-randconfig-003-20240419   clang
x86_64       buildonly-randconfig-004-20240419   clang
x86_64       buildonly-randconfig-005-20240419   clang
x86_64       buildonly-randconfig-006-20240419   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   clang
x86_64                randconfig-001-20240419   gcc  
x86_64                randconfig-002-20240419   clang
x86_64                randconfig-003-20240419   gcc  
x86_64                randconfig-004-20240419   gcc  
x86_64                randconfig-005-20240419   clang
x86_64                randconfig-006-20240419   gcc  
x86_64                randconfig-011-20240419   clang
x86_64                randconfig-012-20240419   clang
x86_64                randconfig-013-20240419   clang
x86_64                randconfig-014-20240419   clang
x86_64                randconfig-015-20240419   gcc  
x86_64                randconfig-016-20240419   gcc  
x86_64                randconfig-071-20240419   clang
x86_64                randconfig-072-20240419   gcc  
x86_64                randconfig-073-20240419   clang
x86_64                randconfig-074-20240419   clang
x86_64                randconfig-075-20240419   gcc  
x86_64                randconfig-076-20240419   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

