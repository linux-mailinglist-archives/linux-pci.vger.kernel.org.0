Return-Path: <linux-pci+bounces-4304-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D3586DEFF
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 11:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7863C28880A
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 10:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A08769D28;
	Fri,  1 Mar 2024 10:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NKwrEaHG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094D569304
	for <linux-pci@vger.kernel.org>; Fri,  1 Mar 2024 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709287800; cv=none; b=b231cCwk64gAmJasyyhSHNBwxZEIp2HEZLp8U9rzxzzdkuFddLrPocdT95vqiFVr0LVoFG1FIsSo+cNst4frnUdF6q3oTQyk5dE0s/i7Q9N9ODn9NBDWSE24aDyEbisDdvp0o3QrVLGjwkF6j5xFFlaPrgYyNmIomURc5mB6684=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709287800; c=relaxed/simple;
	bh=OEKLmIGG7cxKkYWb5SAtmrOUF57GXOW3yR3CajTtDMM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=N/opqasm+OxEL0/hDBBuaambiQC59kx8hMbj1SBH0Oj7oN11WCCrdcuHXOJqwB2I/P/cJya/7wQTUqxR5G0aKrh31lQu3xhnTYlidyib3Jc57fB0/hRSxLjIt8SqCLip3ec5Avlncpw1kxQ4fswrNgf62hG/y/cPyZtnf4/R/4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NKwrEaHG; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709287798; x=1740823798;
  h=date:from:to:cc:subject:message-id;
  bh=OEKLmIGG7cxKkYWb5SAtmrOUF57GXOW3yR3CajTtDMM=;
  b=NKwrEaHGrOM0lHYj+yyP+KdPsv1CaYhRPj1m95yurqw9jell7Lf2PiDK
   3uvnYYzGxvXEQPqw+5MIXD8J8TssFMQ9MQidV++AylivTBDPkrGI8YKEe
   3Nafa3xdX2o5D9bW7HRypejx3e5Mt6azmDAQ7WN1vGj/t1RYTn0BwrFOx
   TiWs4UVv84So1hEQAdmGsp3wNBE2ZXfyu7aS6Wt9toeyq4dSphnR6zUj+
   GCEy5xK/nuw51Rbcq6mMHjUmDahkRqVXCIrlqpRw/PnVWeVkYIAK3s72T
   zM8IL3FhMACQIhYLqJeRC7zXtpUWsVpBMcK+BBeTYUAFC8LERxaFubZs3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3745852"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="3745852"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 02:09:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="12757463"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 01 Mar 2024 02:09:56 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rfzpR-000Dkz-31;
	Fri, 01 Mar 2024 10:09:36 +0000
Date: Fri, 01 Mar 2024 18:07:06 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:pm] BUILD SUCCESS
 fa885b06ec7ee07c2498ad0ce4e0717c3b7dd487
Message-ID: <202403011803.kNqU8Keg-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pm
branch HEAD: fa885b06ec7ee07c2498ad0ce4e0717c3b7dd487  PCI/PM: Allow runtime PM with no PM callbacks at all

elapsed time: 721m

configs tested: 102
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
i386         buildonly-randconfig-001-20240301   clang
i386         buildonly-randconfig-002-20240301   clang
i386         buildonly-randconfig-003-20240301   gcc  
i386         buildonly-randconfig-004-20240301   clang
i386         buildonly-randconfig-005-20240301   clang
i386         buildonly-randconfig-006-20240301   clang
i386                                defconfig   clang
i386                  randconfig-001-20240301   clang
i386                  randconfig-002-20240301   clang
i386                  randconfig-003-20240301   clang
i386                  randconfig-004-20240301   clang
i386                  randconfig-005-20240301   gcc  
i386                  randconfig-006-20240301   gcc  
i386                  randconfig-011-20240301   gcc  
i386                  randconfig-012-20240301   clang
i386                  randconfig-013-20240301   clang
i386                  randconfig-014-20240301   gcc  
i386                  randconfig-015-20240301   gcc  
i386                  randconfig-016-20240301   gcc  
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
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

