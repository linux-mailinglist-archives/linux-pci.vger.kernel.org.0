Return-Path: <linux-pci+bounces-1577-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F05AE82139B
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jan 2024 12:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9F91B21946
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jan 2024 11:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CCB1C2D;
	Mon,  1 Jan 2024 11:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E2m4RONE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9676C20FD
	for <linux-pci@vger.kernel.org>; Mon,  1 Jan 2024 11:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704108747; x=1735644747;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TB21EnWcGaKLG4fothVQKKntNNkB3tGqjHzufOl5PR0=;
  b=E2m4RONEi+AzmT3yGj6A2B6J8+ozvxzl6XBxnx7MvwV780iTuh+gKBQB
   0AzMiJdbbiyg7ouSks90fUwXz1WRB32Z4FqYipzSg3YGtV/D4UzhCPVn3
   CEIMUqETNjbMVZljFMjyu1Bj2dMz16oqoC7upnmF/Fzt2tBHKlcF60ZZ7
   gy3rBFRROKq5XFIRLTu4U/Ksl6fRfCbOOpfnbIe1FHmIqZL9RBTyNqy4V
   wmsRbOLJoEj+tq4EBke2iRnaHchj8+dcygrnrMWfbG/NV5XmYBPAAtEsR
   Q0DcbzTTVe4osWq9hqpWN/OAI/igpG6kENTmEteD01FEibvGDRD8w8bXD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="399561704"
X-IronPort-AV: E=Sophos;i="6.04,321,1695711600"; 
   d="scan'208";a="399561704"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 03:32:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="779411300"
X-IronPort-AV: E=Sophos;i="6.04,321,1695711600"; 
   d="scan'208";a="779411300"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 01 Jan 2024 03:32:25 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rKGWt-000KDD-18;
	Mon, 01 Jan 2024 11:32:23 +0000
Date: Mon, 01 Jan 2024 19:32:03 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:remove-old-api] BUILD SUCCESS
 0171e067d7daf06374c3e9c6ddf1a99fca10469c
Message-ID: <202401011959.lbV1Squ0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git remove-old-api
branch HEAD: 0171e067d7daf06374c3e9c6ddf1a99fca10469c  dw-xdata: Remove usage of the deprecated ida_simple_*() API

elapsed time: 1447m

configs tested: 194
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
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20231231   gcc  
arc                   randconfig-002-20231231   gcc  
arc                           tb10x_defconfig   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                                 defconfig   clang
arm                      jornada720_defconfig   gcc  
arm                            qcom_defconfig   gcc  
arm                   randconfig-001-20231231   gcc  
arm                   randconfig-002-20231231   gcc  
arm                   randconfig-003-20231231   gcc  
arm                   randconfig-004-20231231   gcc  
arm                             rpc_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231231   gcc  
arm64                 randconfig-002-20231231   gcc  
arm64                 randconfig-003-20231231   gcc  
arm64                 randconfig-004-20231231   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231231   gcc  
csky                  randconfig-002-20231231   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231231   clang
hexagon               randconfig-002-20231231   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231231   gcc  
i386         buildonly-randconfig-002-20231231   gcc  
i386         buildonly-randconfig-003-20231231   gcc  
i386         buildonly-randconfig-004-20231231   gcc  
i386         buildonly-randconfig-005-20231231   gcc  
i386         buildonly-randconfig-006-20231231   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231231   gcc  
i386                  randconfig-002-20231231   gcc  
i386                  randconfig-003-20231231   gcc  
i386                  randconfig-004-20231231   gcc  
i386                  randconfig-005-20231231   gcc  
i386                  randconfig-006-20231231   gcc  
i386                  randconfig-011-20231231   clang
i386                  randconfig-012-20231231   clang
i386                  randconfig-013-20231231   clang
i386                  randconfig-014-20231231   clang
i386                  randconfig-015-20231231   clang
i386                  randconfig-016-20231231   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231231   gcc  
loongarch             randconfig-002-20231231   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231231   gcc  
nios2                 randconfig-002-20231231   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231231   gcc  
parisc                randconfig-002-20231231   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                     asp8347_defconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                    ge_imp3a_defconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                 mpc836x_rdk_defconfig   clang
powerpc               randconfig-001-20231231   gcc  
powerpc               randconfig-002-20231231   gcc  
powerpc               randconfig-003-20231231   gcc  
powerpc64             randconfig-001-20231231   gcc  
powerpc64             randconfig-002-20231231   gcc  
powerpc64             randconfig-003-20231231   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231231   gcc  
riscv                 randconfig-002-20231231   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231231   clang
s390                  randconfig-002-20231231   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20231231   gcc  
sh                    randconfig-002-20231231   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231231   gcc  
sparc64               randconfig-002-20231231   gcc  
um                               alldefconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231231   gcc  
um                    randconfig-002-20231231   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231231   gcc  
x86_64       buildonly-randconfig-002-20231231   gcc  
x86_64       buildonly-randconfig-003-20231231   gcc  
x86_64       buildonly-randconfig-004-20231231   gcc  
x86_64       buildonly-randconfig-005-20231231   gcc  
x86_64       buildonly-randconfig-006-20231231   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231231   clang
x86_64                randconfig-002-20231231   clang
x86_64                randconfig-003-20231231   clang
x86_64                randconfig-004-20231231   clang
x86_64                randconfig-005-20231231   clang
x86_64                randconfig-006-20231231   clang
x86_64                randconfig-011-20231231   gcc  
x86_64                randconfig-012-20231231   gcc  
x86_64                randconfig-013-20231231   gcc  
x86_64                randconfig-014-20231231   gcc  
x86_64                randconfig-015-20231231   gcc  
x86_64                randconfig-016-20231231   gcc  
x86_64                randconfig-071-20231231   gcc  
x86_64                randconfig-072-20231231   gcc  
x86_64                randconfig-073-20231231   gcc  
x86_64                randconfig-074-20231231   gcc  
x86_64                randconfig-075-20231231   gcc  
x86_64                randconfig-076-20231231   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                randconfig-001-20231231   gcc  
xtensa                randconfig-002-20231231   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

