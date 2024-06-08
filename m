Return-Path: <linux-pci+bounces-8493-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8759901373
	for <lists+linux-pci@lfdr.de>; Sat,  8 Jun 2024 22:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D964B210CE
	for <lists+linux-pci@lfdr.de>; Sat,  8 Jun 2024 20:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F2A1C2A3;
	Sat,  8 Jun 2024 20:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OV3d4xw2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4138BE57D
	for <linux-pci@vger.kernel.org>; Sat,  8 Jun 2024 20:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717878565; cv=none; b=ImnjzNUjLDAxcev59N0A6Exbsn0McBSMOJhNeZIhGyox5KVuwOEKCU2Dv2yjJ6wOQpTXtTVl2Y6c3pan8VKaRNFCc58FrV3MM/O+xvietQ/eGWtnbDHgEX7d/74QJywtUOVNALO9UzDj8q7SEfF9bEeQb0QtGJQDVIqhieCIGpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717878565; c=relaxed/simple;
	bh=c5zsuN9nDGpwY9Oth2RTaDfffk2ooo3p/9DCZNyKEuI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=g9X5MuIKJwhqzfmASUi3hkJDfF/4agtxeM+Syw3JyICKpEYpk3UVrxEkD+qT+9wHJtYLE+ez3NUGAYvr/Ev6v/W89uyXmGBdZkpW6qqQiEDbYRSz6OL9dQM17JvIDCkYne30mGykFQnQVFTZ9e+esXY7S640mS335pn66L+5yw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OV3d4xw2; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717878564; x=1749414564;
  h=date:from:to:cc:subject:message-id;
  bh=c5zsuN9nDGpwY9Oth2RTaDfffk2ooo3p/9DCZNyKEuI=;
  b=OV3d4xw2ENPIBz+zO2rYdInb68kXkh1i96C+mbFuQLmICCiSuoi54Mgk
   vsNA++fbJn6KFt3ePBrZc4Yr42kxwZVISe+X+RkH0fNQmc0Dk9jJ6+Sho
   l1q57P45vO5f/p1RJCeHjmtq8AcIJE640r71TkFZzyb5cIfwoCU7nPDSo
   sfdEMTcYIHaSmJjyFBN4i5gSRc3meCZ1MYcanDkeaOuQKlXPcv8zK/LrF
   Cseejbbu/PlqcmAePawNKhvIuhyg9YUnKnMKHFMzjkZi2LSxCnLQIJ2s4
   t91gzI+Q2mFrYWmkpLW03M9V/ubmK/sKQYWOkyxuGPo4OfRSoIiG5UcQO
   w==;
X-CSE-ConnectionGUID: LypfEuRlTKWslKqD4C9dCw==
X-CSE-MsgGUID: MX/129SmQ6OgD7ZqZh3jzQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11097"; a="25997691"
X-IronPort-AV: E=Sophos;i="6.08,224,1712646000"; 
   d="scan'208";a="25997691"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2024 13:29:23 -0700
X-CSE-ConnectionGUID: xqVgkwTlTqy6hzo0rTbyEg==
X-CSE-MsgGUID: D7706a3CQnGziB51GV1QtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,224,1712646000"; 
   d="scan'208";a="61844336"
Received: from lkp-server01.sh.intel.com (HELO 8967fbab76b3) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 08 Jun 2024 13:29:21 -0700
Received: from kbuild by 8967fbab76b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sG2gh-0000Qu-2U;
	Sat, 08 Jun 2024 20:29:19 +0000
Date: Sun, 09 Jun 2024 04:28:48 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:devres] BUILD SUCCESS
 1199e585f1e8955a141f4eb9452923f12ed5c699
Message-ID: <202406090446.zX3mgPcC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git devres
branch HEAD: 1199e585f1e8955a141f4eb9452923f12ed5c699  PCI: Warn users about complicated devres nature

elapsed time: 1456m

configs tested: 131
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240608   gcc  
arc                   randconfig-002-20240608   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                             mxs_defconfig   clang
arm                         nhk8815_defconfig   clang
arm                   randconfig-001-20240608   gcc  
arm                        shmobile_defconfig   gcc  
arm                         vf610m4_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240608   gcc  
arm64                 randconfig-002-20240608   gcc  
arm64                 randconfig-003-20240608   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240608   gcc  
csky                  randconfig-002-20240608   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-002-20240608   clang
i386         buildonly-randconfig-005-20240608   clang
i386                  randconfig-001-20240608   clang
i386                  randconfig-004-20240608   clang
i386                  randconfig-011-20240608   clang
i386                  randconfig-012-20240608   clang
i386                  randconfig-013-20240608   clang
i386                  randconfig-015-20240608   clang
i386                  randconfig-016-20240608   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240608   gcc  
loongarch             randconfig-002-20240608   gcc  
m68k                             alldefconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           jazz_defconfig   clang
mips                      maltaaprp_defconfig   clang
mips                         rt305x_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240608   gcc  
nios2                 randconfig-002-20240608   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240608   gcc  
parisc                randconfig-002-20240608   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                 linkstation_defconfig   clang
powerpc                 mpc834x_itx_defconfig   clang
powerpc               randconfig-003-20240608   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20240608   gcc  
riscv                 randconfig-002-20240608   gcc  
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240608   gcc  
sh                    randconfig-002-20240608   gcc  
sh                           se7619_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240608   gcc  
sparc64               randconfig-002-20240608   gcc  
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64       buildonly-randconfig-002-20240608   gcc  
x86_64       buildonly-randconfig-004-20240608   gcc  
x86_64       buildonly-randconfig-005-20240608   gcc  
x86_64       buildonly-randconfig-006-20240608   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-002-20240608   gcc  
x86_64                randconfig-003-20240608   gcc  
x86_64                randconfig-004-20240608   gcc  
x86_64                randconfig-006-20240608   gcc  
x86_64                randconfig-011-20240608   gcc  
x86_64                randconfig-013-20240608   gcc  
x86_64                randconfig-014-20240608   gcc  
x86_64                randconfig-016-20240608   gcc  
x86_64                randconfig-071-20240608   gcc  
x86_64                randconfig-072-20240608   gcc  
x86_64                randconfig-074-20240608   gcc  
x86_64                randconfig-076-20240608   gcc  
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240608   gcc  
xtensa                randconfig-002-20240608   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

