Return-Path: <linux-pci+bounces-6220-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE038A3F7C
	for <lists+linux-pci@lfdr.de>; Sun, 14 Apr 2024 00:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67F201F212B4
	for <lists+linux-pci@lfdr.de>; Sat, 13 Apr 2024 22:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADF555E72;
	Sat, 13 Apr 2024 22:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I5/mrLTX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCB45467B
	for <linux-pci@vger.kernel.org>; Sat, 13 Apr 2024 22:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713046746; cv=none; b=NbxILq7u3SNMvk9Hxa1TJrj+eeZTPU2IyD7lL+nrasLafDuoARvQJDD+9JlpmaN3vuFP8UGM7r9LjZ0eNb114P/HFIRji0W41ZpraMcFgnCREgA/K2O6jt4FjorgmmxEd7i6XQpCDkADtHOjPWHDOKd45ep/VgixNjoupRZ0dsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713046746; c=relaxed/simple;
	bh=7cS4/+bwPjcGrkhwYRvy7EGfb6AH4KJWtPfJKjMcsVs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=OMYuHQGCX0we0By5bILTKTallaevABnqwnsBxHIcoumCXux7mRYano+3NWZxlzYoFm/m40mAM4g2tIGoLPzr55mV44Tt1p9fyEigUMJXqtVz7fl9QpPgSfC97KHxGBFuwdFLONMBusJNM/gSOPB62mnPUXBGbGjhwh0nfUtpFnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I5/mrLTX; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713046744; x=1744582744;
  h=date:from:to:cc:subject:message-id;
  bh=7cS4/+bwPjcGrkhwYRvy7EGfb6AH4KJWtPfJKjMcsVs=;
  b=I5/mrLTX7ddG7uZO4rdhjwhZxE/BSygHwhptW3f/4XlfyLmvwY8wF4GR
   siHcIkfrKFy6a9THx6CN8hjg5mLA9VrWTjqn7OaRkcw3UgPUc5haJMtlG
   I/Lod8Fwg8BRh4hpMsi6sPOSb4mq28FEWk3QI31q3A16chiQsQZOm6tF0
   snV+QuL5+kNbdJ3BUkWBLGsWP1pWRVmG8aI8AOFsYrJddw7yPrPE7hV7z
   q49znmVkZ6tn/FGbwelci+hv7aainfm7ffBODjkL4N5tv8db4cHBu+4m/
   myQ6+jpXh3Ei2JALU4vguNT8YYNLnEOuxB+P1Hy9QS6uGjrRYcHrAN5v7
   Q==;
X-CSE-ConnectionGUID: sTsp97OFRhuCnf77nbnzXg==
X-CSE-MsgGUID: YJSY4lL8QGKGcf3MKXrqNQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11043"; a="11426113"
X-IronPort-AV: E=Sophos;i="6.07,199,1708416000"; 
   d="scan'208";a="11426113"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2024 15:19:04 -0700
X-CSE-ConnectionGUID: nLitnSiZS2iTHfhq9D57Bg==
X-CSE-MsgGUID: ykPQ4TT8SjGMRh+Md0Q8gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,199,1708416000"; 
   d="scan'208";a="21636386"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 13 Apr 2024 15:19:03 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rvli8-00034a-1U;
	Sat, 13 Apr 2024 22:19:00 +0000
Date: Sun, 14 Apr 2024 06:18:46 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 6e47dcb2ca223211c43c37497836cd9666c70674
Message-ID: <202404140643.AqD6r0kZ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 6e47dcb2ca223211c43c37497836cd9666c70674  Merge branch 'pci/endpoint'

elapsed time: 1448m

configs tested: 135
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
arc                   randconfig-001-20240414   gcc  
arc                   randconfig-002-20240414   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240414   clang
arm                   randconfig-002-20240414   clang
arm                   randconfig-003-20240414   gcc  
arm                   randconfig-004-20240414   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240414   gcc  
arm64                 randconfig-002-20240414   clang
arm64                 randconfig-003-20240414   gcc  
arm64                 randconfig-004-20240414   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240414   gcc  
csky                  randconfig-002-20240414   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240414   clang
hexagon               randconfig-002-20240414   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240413   gcc  
i386         buildonly-randconfig-002-20240413   gcc  
i386         buildonly-randconfig-003-20240413   clang
i386         buildonly-randconfig-004-20240413   clang
i386         buildonly-randconfig-005-20240413   clang
i386         buildonly-randconfig-006-20240413   clang
i386                                defconfig   clang
i386                  randconfig-001-20240413   clang
i386                  randconfig-002-20240413   gcc  
i386                  randconfig-003-20240413   clang
i386                  randconfig-004-20240413   gcc  
i386                  randconfig-005-20240413   clang
i386                  randconfig-006-20240413   clang
i386                  randconfig-011-20240413   gcc  
i386                  randconfig-012-20240413   clang
i386                  randconfig-013-20240413   gcc  
i386                  randconfig-014-20240413   gcc  
i386                  randconfig-015-20240413   clang
i386                  randconfig-016-20240413   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240414   gcc  
loongarch             randconfig-002-20240414   gcc  
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
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240414   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
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
x86_64       buildonly-randconfig-001-20240414   clang
x86_64       buildonly-randconfig-002-20240414   clang
x86_64       buildonly-randconfig-003-20240414   clang
x86_64       buildonly-randconfig-004-20240414   clang
x86_64       buildonly-randconfig-005-20240414   gcc  
x86_64       buildonly-randconfig-006-20240414   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240414   gcc  
x86_64                randconfig-002-20240414   clang
x86_64                randconfig-003-20240414   gcc  
x86_64                randconfig-004-20240414   gcc  
x86_64                randconfig-005-20240414   clang
x86_64                randconfig-006-20240414   clang
x86_64                randconfig-011-20240414   clang
x86_64                randconfig-012-20240414   gcc  
x86_64                randconfig-013-20240414   gcc  
x86_64                randconfig-014-20240414   gcc  
x86_64                randconfig-015-20240414   gcc  
x86_64                randconfig-016-20240414   gcc  
x86_64                randconfig-071-20240414   gcc  
x86_64                randconfig-072-20240414   clang
x86_64                randconfig-073-20240414   clang
x86_64                randconfig-074-20240414   gcc  
x86_64                randconfig-075-20240414   clang
x86_64                randconfig-076-20240414   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

