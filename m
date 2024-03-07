Return-Path: <linux-pci+bounces-4611-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF03387563E
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 19:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44FF7B24279
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 18:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709E512FB3F;
	Thu,  7 Mar 2024 18:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aR7P/n8p"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73C4182BB
	for <linux-pci@vger.kernel.org>; Thu,  7 Mar 2024 18:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709836997; cv=none; b=EzQYjU7VuR1sGygCIPN/1dS8btKp+JUQUzRTejbVLmGHLOAbqGFMH28vh0IjXa+a03AViH8PSqm/yYaL92KN37IGZniF55zRupfQJ3PAv8hgzK1DovG4vOLjqY0BnSPop0V1ljbhKSq78PUIwMioB1Qlt9hy808kfA1xrqtiYLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709836997; c=relaxed/simple;
	bh=migoCmCw2klpGHMwMEvnXXxj5nXKZ0YzjH187RwPnBo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=grHE4d2sl4HmNrpwhkQz75l/JmLf/8/OkAr9mogwBV7m2RnMKy3DYvasxq6FSh/Brg7hsYyeb8zT3sutmHxm2jCjnkpQojY9eMeYb/JlSnzztr9I1JryzNS+4pM0UMI1GEjhC3nhR71B/rbacxZNNMH3Jly1quBQBscD9InrsGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aR7P/n8p; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709836995; x=1741372995;
  h=date:from:to:cc:subject:message-id;
  bh=migoCmCw2klpGHMwMEvnXXxj5nXKZ0YzjH187RwPnBo=;
  b=aR7P/n8pUQh48bvKY0p0+5M3uzRkd8HBcn1HQbN1s3R8qddip6rFNsLX
   zznFcu+umh1pJtJ/nX3Eobf1zJmSQpoYD9+lsAggTd45aCR3TIs+UwphN
   Drx6IxElqSt9/DXejT835jtjSzF9NlqaqYCWbQAZHoz6vl3C6gei9epih
   jdCHwqKICOC+qk1gLIj1K1Gdq9oLNJA/GDrLl0x+w//1jrtgdWDCiUdV6
   ewiChdHnCAcBkR+kzONc8pjtFFGWzAYx2MeRVN85ApKc2KjMl0+TIEmAn
   3MDjxfbun/O5tqAQ5331sBDfqsZsZ/cHxkHVRGV9U22KmUAyjFOMNljrZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="21979574"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="21979574"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 10:43:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="10304402"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 07 Mar 2024 10:43:13 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1riIhy-0005VF-2L;
	Thu, 07 Mar 2024 18:43:10 +0000
Date: Fri, 08 Mar 2024 02:42:17 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 b3eeed7fdc6f8dd94a49a9b5542c3c5a017fcf77
Message-ID: <202403080214.fZMTPYDB-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: b3eeed7fdc6f8dd94a49a9b5542c3c5a017fcf77  Merge branch 'pci/qcom'

elapsed time: 1128m

configs tested: 125
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
arm                                 defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
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
i386         buildonly-randconfig-001-20240307   clang
i386         buildonly-randconfig-002-20240307   gcc  
i386         buildonly-randconfig-003-20240307   clang
i386         buildonly-randconfig-004-20240307   gcc  
i386         buildonly-randconfig-005-20240307   gcc  
i386         buildonly-randconfig-006-20240307   clang
i386                                defconfig   clang
i386                  randconfig-001-20240307   gcc  
i386                  randconfig-002-20240307   gcc  
i386                  randconfig-003-20240307   clang
i386                  randconfig-004-20240307   gcc  
i386                  randconfig-005-20240307   gcc  
i386                  randconfig-006-20240307   clang
i386                  randconfig-011-20240307   clang
i386                  randconfig-012-20240307   gcc  
i386                  randconfig-013-20240307   clang
i386                  randconfig-014-20240307   clang
i386                  randconfig-015-20240307   clang
i386                  randconfig-016-20240307   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
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
x86_64       buildonly-randconfig-001-20240307   gcc  
x86_64       buildonly-randconfig-002-20240307   gcc  
x86_64       buildonly-randconfig-003-20240307   gcc  
x86_64       buildonly-randconfig-004-20240307   clang
x86_64       buildonly-randconfig-005-20240307   gcc  
x86_64       buildonly-randconfig-006-20240307   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240307   gcc  
x86_64                randconfig-002-20240307   gcc  
x86_64                randconfig-003-20240307   clang
x86_64                randconfig-004-20240307   gcc  
x86_64                randconfig-005-20240307   gcc  
x86_64                randconfig-006-20240307   clang
x86_64                randconfig-011-20240307   gcc  
x86_64                randconfig-012-20240307   gcc  
x86_64                randconfig-013-20240307   gcc  
x86_64                randconfig-014-20240307   clang
x86_64                randconfig-015-20240307   clang
x86_64                randconfig-016-20240307   clang
x86_64                randconfig-071-20240307   gcc  
x86_64                randconfig-072-20240307   gcc  
x86_64                randconfig-073-20240307   clang
x86_64                randconfig-074-20240307   gcc  
x86_64                randconfig-075-20240307   clang
x86_64                randconfig-076-20240307   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

