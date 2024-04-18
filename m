Return-Path: <linux-pci+bounces-6411-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66AC8A9642
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 11:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ED45B20D4A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 09:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878E615AD87;
	Thu, 18 Apr 2024 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JssaNVm4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB49158209
	for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432893; cv=none; b=Q5AFhrmpXli0x4yRaOYsGYE9IGIPqIFDaqI1VD5xiTbElr2V3gtmGzLdtr3oTr1Yr+ABb7rnABZsMNP3ZlWNneRl/YrPtkCpObfDve7dPGvCeUTQDHGbNGmBR2uwhScbo6Zx7sIFldDL9eS2dpYH+p0W20bk0p1zQ8h/OhN9BWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432893; c=relaxed/simple;
	bh=Zf5XgpxHawdvCDXLshLtb7cI6CqNp9iYvNYappfzDa8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JZipm3uCXE8HDNhdWrln6it7RB5KW4dw92/X09xwB5Nj132tYPUl6oLOSClF6eeOgyIxrRgUcZyr+gFMm1PrexSN4E9ft09L630+16PtTE+TBq6eryn2tkznpIMNRjlFnDWsqZZh0bBdAU55NFQprTC4FBmvaT0b+NHn4dF36n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JssaNVm4; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713432892; x=1744968892;
  h=date:from:to:cc:subject:message-id;
  bh=Zf5XgpxHawdvCDXLshLtb7cI6CqNp9iYvNYappfzDa8=;
  b=JssaNVm4gbnO5s+6QmO0ty/7fjAJkv/+6Ibop/ueGyIrmUcNqyZTZp4W
   5m1Mc6DF+1nDVn59PtgfCi6uWgFNtmoCLJs4AcrknpEqIPTIVJXvtvQxX
   qUaUUn9OAO3S9+oK1e+tzCYwtCRbASGgYLTKGUBmzgxZogsuYNq0IUsMx
   q02pF7iAo/eR3tYwXrQhLid1hZp7PDT/tReC3yiJgdVFTKFwojj6s2TYC
   nheMQsqCs1ynvGwR9W0GwtmyocbF8cDwGh8LPqShPa+o3LAfIwxVrXm8A
   Tv875BL7sVthUsPY0jdiD3RwUck3uX5yIEVV2YDxBfU/IkK5+mg6RqB5B
   A==;
X-CSE-ConnectionGUID: 7JVLhZXbQi2zXvqnClbl1w==
X-CSE-MsgGUID: 0gtS0JvWTsSM/3zTZ+DIfQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8833102"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="8833102"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 02:34:51 -0700
X-CSE-ConnectionGUID: OH4wDBZAQD+oUU93WCT0yA==
X-CSE-MsgGUID: U0LxHgH9S3a0nOKKJGhMIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="23010244"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 18 Apr 2024 02:34:50 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rxOAK-0007Sc-0B;
	Thu, 18 Apr 2024 09:34:48 +0000
Date: Thu, 18 Apr 2024 17:34:36 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 e30556bf682d36a88cc5aef98d1123ca71adb245
Message-ID: <202404181734.ISTzEbTO-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc
branch HEAD: e30556bf682d36a88cc5aef98d1123ca71adb245  PCI: Constify pcibus_class

elapsed time: 1027m

configs tested: 115
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
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                                 defconfig   clang
arm                            mmp2_defconfig   gcc  
arm                         s3c6400_defconfig   gcc  
arm                    vt8500_v6_v7_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240418   gcc  
i386         buildonly-randconfig-002-20240418   gcc  
i386         buildonly-randconfig-003-20240418   clang
i386         buildonly-randconfig-004-20240418   gcc  
i386         buildonly-randconfig-005-20240418   clang
i386         buildonly-randconfig-006-20240418   clang
i386                                defconfig   clang
i386                  randconfig-001-20240418   gcc  
i386                  randconfig-002-20240418   gcc  
i386                  randconfig-003-20240418   clang
i386                  randconfig-004-20240418   gcc  
i386                  randconfig-005-20240418   gcc  
i386                  randconfig-006-20240418   gcc  
i386                  randconfig-011-20240418   clang
i386                  randconfig-012-20240418   clang
i386                  randconfig-013-20240418   gcc  
i386                  randconfig-014-20240418   gcc  
i386                  randconfig-015-20240418   gcc  
i386                  randconfig-016-20240418   clang
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                      malta_kvm_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
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
powerpc                     ep8248e_defconfig   gcc  
powerpc                     tqm5200_defconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

