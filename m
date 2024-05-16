Return-Path: <linux-pci+bounces-7578-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA0D8C77F0
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 15:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309922818D0
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 13:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F1C145A1D;
	Thu, 16 May 2024 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mIQxEeak"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56851147C62
	for <linux-pci@vger.kernel.org>; Thu, 16 May 2024 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715867405; cv=none; b=JcD+Y+4rOLoBLhzVcfM5hVXW6xzjQoDfIoYTdwJ+6hpt4FCdZv9iPOhhy/79/joUXmFA4YwEpDz19wyYSb9S044g4kuFb2nnNmUFXGIU+LcNXsjW0d844pL40BzkKeUg+IxVtXri5irHuOG1LOYcqexd7IeX+QwdIG0X1Fj65fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715867405; c=relaxed/simple;
	bh=6ifUodwvNIsfHfV9iMLGnBeAmMm+Szd1VMHCPCb2XEs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pPSjlzoQnQRzeG7AzznBjFLqNriz0zeElgSGtCY+3U5eiL/O0FVUz1AOAFbfb8171kSSfVMBMfNX+BVJseuBTw9BEzAnJqysGAOoVjB6hqrAts7wPnCgfLhQyspWRUd0pyakbevnj8xpxHCkQAATiStBFetBNHcu9pAFfjEYecw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mIQxEeak; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715867404; x=1747403404;
  h=date:from:to:cc:subject:message-id;
  bh=6ifUodwvNIsfHfV9iMLGnBeAmMm+Szd1VMHCPCb2XEs=;
  b=mIQxEeakv1jn3R8QrLmGgPal9Mcr7TttIP+05ibV9b9CRZdcwOHZ8afg
   bCf3qBTt1HJNFiWsrKiAKCYgcmjWooaDNOcl96TXrIxIQ9WQgj4kfg2on
   ShVRgoStDI49bnX29XI0LZntHosl1l3564s0Bo0j8NjfJTWKhde6uVgM5
   vbpDKqmpZKFgfqtbklO9zvQVo4ENj+wt1ZDkgZcrgkCtWWs1WLVWLh8QR
   VB6y8rBoQLzGzhKJ7kd7fQGK9TWYcDW80fkxDbxJU5XiZVuxNFdUIILpN
   wWiJGGMy15mQTCPDy0G+vpdUFrnx1soUc1Iosym0oOe1+Ss0bF6VR/q18
   Q==;
X-CSE-ConnectionGUID: AUTkYIuGRhWPRLNDta5TUg==
X-CSE-MsgGUID: zNysMaqHSHmqcGwWpgoPJQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="14928597"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="14928597"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 06:50:03 -0700
X-CSE-ConnectionGUID: kZNnpGS4S8600pmayZOk3Q==
X-CSE-MsgGUID: kxdNAsjgSAq6b/UG6JoFnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="31984621"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 16 May 2024 06:50:02 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7bUd-000EIh-06;
	Thu, 16 May 2024 13:49:59 +0000
Date: Thu, 16 May 2024 21:49:01 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc] BUILD SUCCESS
 5066c0b87d865d1fafc3e6c761df2f433237b1e2
Message-ID: <202405162159.413OLGCU-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
branch HEAD: 5066c0b87d865d1fafc3e6c761df2f433237b1e2  PCI: qcom-ep: Drop 'Link is enabled' from the debug message for BME event

elapsed time: 1045m

configs tested: 153
configs skipped: 5

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
arc                   randconfig-001-20240516   gcc  
arc                   randconfig-002-20240516   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                            qcom_defconfig   clang
arm                   randconfig-001-20240516   gcc  
arm                   randconfig-002-20240516   clang
arm                   randconfig-003-20240516   gcc  
arm                   randconfig-004-20240516   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240516   gcc  
arm64                 randconfig-002-20240516   clang
arm64                 randconfig-003-20240516   clang
arm64                 randconfig-004-20240516   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240516   gcc  
csky                  randconfig-002-20240516   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240516   clang
hexagon               randconfig-002-20240516   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240516   clang
i386         buildonly-randconfig-002-20240516   clang
i386         buildonly-randconfig-003-20240516   clang
i386         buildonly-randconfig-004-20240516   gcc  
i386         buildonly-randconfig-005-20240516   gcc  
i386         buildonly-randconfig-006-20240516   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240516   gcc  
i386                  randconfig-002-20240516   gcc  
i386                  randconfig-003-20240516   clang
i386                  randconfig-004-20240516   clang
i386                  randconfig-005-20240516   clang
i386                  randconfig-006-20240516   clang
i386                  randconfig-011-20240516   gcc  
i386                  randconfig-012-20240516   gcc  
i386                  randconfig-013-20240516   clang
i386                  randconfig-014-20240516   gcc  
i386                  randconfig-015-20240516   gcc  
i386                  randconfig-016-20240516   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240516   gcc  
loongarch             randconfig-002-20240516   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           mtx1_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240516   gcc  
nios2                 randconfig-002-20240516   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240516   gcc  
parisc                randconfig-002-20240516   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                   microwatt_defconfig   gcc  
powerpc                 mpc836x_rdk_defconfig   clang
powerpc                    mvme5100_defconfig   gcc  
powerpc                      ppc40x_defconfig   clang
powerpc               randconfig-001-20240516   gcc  
powerpc               randconfig-002-20240516   clang
powerpc               randconfig-003-20240516   clang
powerpc                 xes_mpc85xx_defconfig   gcc  
powerpc64             randconfig-001-20240516   gcc  
powerpc64             randconfig-002-20240516   clang
powerpc64             randconfig-003-20240516   gcc  
riscv                            alldefconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240516   gcc  
riscv                 randconfig-002-20240516   clang
s390                              allnoconfig   clang
s390                                defconfig   clang
s390                  randconfig-001-20240516   gcc  
s390                  randconfig-002-20240516   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                    randconfig-001-20240516   gcc  
sh                    randconfig-002-20240516   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                          sdk7780_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240516   gcc  
sparc64               randconfig-002-20240516   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240516   clang
um                    randconfig-002-20240516   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                randconfig-001-20240516   gcc  
xtensa                randconfig-002-20240516   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

