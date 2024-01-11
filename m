Return-Path: <linux-pci+bounces-2016-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3370B82A597
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 02:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C1451F23F34
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 01:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2275839C;
	Thu, 11 Jan 2024 01:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UaZcZUAY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E2D642
	for <linux-pci@vger.kernel.org>; Thu, 11 Jan 2024 01:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704937038; x=1736473038;
  h=date:from:to:cc:subject:message-id;
  bh=+K+edL2wrTtffAzZ70DID2nz4jNmwKGwdQgJVcORet4=;
  b=UaZcZUAYiGeMgYPI+5gTga2v3TyeU08ldClgeGPEbbVW4930g1AXEg4l
   9crL8S/0Y72Qf5oebocYDgpYq98dcTCyR7RUO3eHoEAvp99f1EAEn56oU
   sg1XxHDurEY+De2gjiUyMh++nV2MWAe7NoRUwLbiRLJ3XQbKEjgtY9B6B
   zajAZHL50ZDFe9Iv36LL30+tAjW8z4tMxqT+XxcGojJDfjBLeUwAvMEae
   HwXTBGql9Vqs4o+AP6Q5AqyKtut56hqcOFlJ1K4s/T80R1Heixiicf9Zj
   NIagmw18oX3FXp8GGGZUWG/hxPWT6KnJPW2Z0qqPdFdmzdkuqVjCrhv9s
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="5451310"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="5451310"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 17:37:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="785810053"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="785810053"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jan 2024 17:37:14 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNk0O-0007fm-1u;
	Thu, 11 Jan 2024 01:37:12 +0000
Date: Thu, 11 Jan 2024 09:36:45 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 fbfdb71c8c79a0309ba97db4022ee1d29951f8fb
Message-ID: <202401110943.diyfXl8e-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: fbfdb71c8c79a0309ba97db4022ee1d29951f8fb  Merge branch 'pci/misc'

elapsed time: 1462m

configs tested: 162
configs skipped: 2

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
arc                   randconfig-001-20240111   gcc  
arc                   randconfig-002-20240111   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240111   gcc  
arm                   randconfig-002-20240111   gcc  
arm                   randconfig-003-20240111   gcc  
arm                   randconfig-004-20240111   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240111   gcc  
arm64                 randconfig-002-20240111   gcc  
arm64                 randconfig-003-20240111   gcc  
arm64                 randconfig-004-20240111   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240111   gcc  
csky                  randconfig-002-20240111   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240111   clang
hexagon               randconfig-002-20240111   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240110   clang
i386         buildonly-randconfig-002-20240110   clang
i386         buildonly-randconfig-003-20240110   clang
i386         buildonly-randconfig-004-20240110   clang
i386         buildonly-randconfig-005-20240110   clang
i386         buildonly-randconfig-006-20240110   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20240110   clang
i386                  randconfig-002-20240110   clang
i386                  randconfig-003-20240110   clang
i386                  randconfig-004-20240110   clang
i386                  randconfig-005-20240110   clang
i386                  randconfig-006-20240110   clang
i386                  randconfig-011-20240110   gcc  
i386                  randconfig-012-20240110   gcc  
i386                  randconfig-013-20240110   gcc  
i386                  randconfig-014-20240110   gcc  
i386                  randconfig-015-20240110   gcc  
i386                  randconfig-016-20240110   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240111   gcc  
loongarch             randconfig-002-20240111   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240111   gcc  
nios2                 randconfig-002-20240111   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240111   gcc  
parisc                randconfig-002-20240111   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240111   gcc  
powerpc               randconfig-002-20240111   gcc  
powerpc               randconfig-003-20240111   gcc  
powerpc64             randconfig-001-20240111   gcc  
powerpc64             randconfig-002-20240111   gcc  
powerpc64             randconfig-003-20240111   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240111   gcc  
riscv                 randconfig-002-20240111   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240111   clang
s390                  randconfig-002-20240111   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240111   gcc  
sh                    randconfig-002-20240111   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240111   gcc  
sparc64               randconfig-002-20240111   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240111   gcc  
um                    randconfig-002-20240111   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240111   gcc  
x86_64       buildonly-randconfig-002-20240111   gcc  
x86_64       buildonly-randconfig-003-20240111   gcc  
x86_64       buildonly-randconfig-004-20240111   gcc  
x86_64       buildonly-randconfig-005-20240111   gcc  
x86_64       buildonly-randconfig-006-20240111   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240111   clang
x86_64                randconfig-002-20240111   clang
x86_64                randconfig-003-20240111   clang
x86_64                randconfig-004-20240111   clang
x86_64                randconfig-005-20240111   clang
x86_64                randconfig-006-20240111   clang
x86_64                randconfig-011-20240111   gcc  
x86_64                randconfig-012-20240111   gcc  
x86_64                randconfig-013-20240111   gcc  
x86_64                randconfig-014-20240111   gcc  
x86_64                randconfig-015-20240111   gcc  
x86_64                randconfig-016-20240111   gcc  
x86_64                randconfig-071-20240111   gcc  
x86_64                randconfig-072-20240111   gcc  
x86_64                randconfig-073-20240111   gcc  
x86_64                randconfig-074-20240111   gcc  
x86_64                randconfig-075-20240111   gcc  
x86_64                randconfig-076-20240111   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240111   gcc  
xtensa                randconfig-002-20240111   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

