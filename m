Return-Path: <linux-pci+bounces-8609-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 060169045D3
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 22:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C6F01C23031
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 20:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07601411ED;
	Tue, 11 Jun 2024 20:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JKgvtp1B"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0113412E61
	for <linux-pci@vger.kernel.org>; Tue, 11 Jun 2024 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718138167; cv=none; b=skFi3MMDUu9dgBMK8achl/g6PY7zmVO3uYYdtuWMAEKIix9VxFdzbAHCQWPMt+Sy+H0ozJoqyAFDqNZKBQ4AybS+AsZ4oor38B7UW2t4hv6qZmn+AIzG7dakMDfm43njMECu1V20mUO2DwSSLFDUpgDdVGdG22T9ne7RnHz55uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718138167; c=relaxed/simple;
	bh=O5R2NEvkxa8ljBcPpDi7qelNjFAc9SSPH+xvps7wZfg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rMvrbtGeQPjkJH8CFZf7kegDowq6LRW6611mA6FvSEixHX8ODMW9EA3FvNUi55znNsmTzvNUr7wBgJ2CAGZ0fJOKyRAVZnJom+19whuBXEixgCmiVbn2ldU+9iCmCUO1+pjUsoACq6V2h+Kz8nxXp7d+pzIA1IVHotgUL/BDA/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JKgvtp1B; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718138166; x=1749674166;
  h=date:from:to:cc:subject:message-id;
  bh=O5R2NEvkxa8ljBcPpDi7qelNjFAc9SSPH+xvps7wZfg=;
  b=JKgvtp1BGxO5H/FWnnVtu+UO4QYGwH489mbrV8cMePrHZ+na+IBtz1KM
   N1GWIOTX56aYjiy8KaDzwtk6Y9MQMPTAnCdOH0rKUT0l9xPUT4KGCjCKo
   XHqPQCk9jmjXFlnQ9ZzMxdipxj9YqMxQDUeclf1Q8tRW1HTL+yU53NsVH
   uDA9vSCbNj4TULyQ0LxjRxCjW9+cutfJp7nMeRsGJz8mMQgtVP49ZDGOL
   cEhsWwshFoWBfJGTPPbcWnnTc8rrDn2zJ7fRHc1x5VlwS6CJLPzJSsS/h
   YWrYYStcxqj1ZoSL/OfePrI1MdViUHqMT2WvwvEhx9ta3d5A/Yt9lEHBt
   Q==;
X-CSE-ConnectionGUID: SA+L1sE4RyayYjE+dAtnPg==
X-CSE-MsgGUID: oXizJToHSDih+4ZwedE5hg==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="12027494"
X-IronPort-AV: E=Sophos;i="6.08,231,1712646000"; 
   d="scan'208";a="12027494"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 13:36:05 -0700
X-CSE-ConnectionGUID: Q+jXeROVR0mwAk+eLuCLxQ==
X-CSE-MsgGUID: kx6dObZ/QfKC2R/8rUF6+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,231,1712646000"; 
   d="scan'208";a="70352419"
Received: from lkp-server01.sh.intel.com (HELO 628d7d8b9fc6) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 11 Jun 2024 13:36:04 -0700
Received: from kbuild by 628d7d8b9fc6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sH8Dp-0000sI-38;
	Tue, 11 Jun 2024 20:36:02 +0000
Date: Wed, 12 Jun 2024 04:35:43 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:switchtec] BUILD SUCCESS
 8a74e4eaa72c14f997df6d820effb6aac400d470
Message-ID: <202406120441.fnFm7l8a-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git switchtec
branch HEAD: 8a74e4eaa72c14f997df6d820effb6aac400d470  PCI: switchtec: Make switchtec_class constant

elapsed time: 1453m

configs tested: 92
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc  
alpha                            allyesconfig   gcc-13.2.0
alpha                               defconfig   gcc  
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc  
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc  
arc                                 defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   clang
arm                              allyesconfig   gcc-13.2.0
arm                                 defconfig   clang
arm64                             allnoconfig   gcc  
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc  
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc  
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc  
csky                                defconfig   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang-19
hexagon                             defconfig   clang
i386         buildonly-randconfig-003-20240611   clang
i386                  randconfig-001-20240611   clang
i386                  randconfig-004-20240611   clang
i386                  randconfig-006-20240611   clang
i386                  randconfig-011-20240611   clang
i386                  randconfig-013-20240611   clang
i386                  randconfig-015-20240611   clang
i386                  randconfig-016-20240611   clang
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc  
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc  
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc-13.2.0
nios2                            allmodconfig   gcc-13.2.0
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc-13.2.0
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc  
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc  
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc  
parisc                              defconfig   gcc-13.2.0
parisc64                            defconfig   gcc  
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc  
powerpc                           allnoconfig   gcc-13.2.0
riscv                             allnoconfig   gcc  
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   clang
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc-13.2.0
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc-13.2.0
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc-13.2.0
sparc64                             defconfig   gcc  
um                               allmodconfig   clang-19
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                               allyesconfig   gcc-13
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang-18
x86_64                              defconfig   gcc-13
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

