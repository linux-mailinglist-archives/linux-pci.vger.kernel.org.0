Return-Path: <linux-pci+bounces-190-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 354747FAAA0
	for <lists+linux-pci@lfdr.de>; Mon, 27 Nov 2023 20:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE7FC281902
	for <lists+linux-pci@lfdr.de>; Mon, 27 Nov 2023 19:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F133FE32;
	Mon, 27 Nov 2023 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hM4SjB/H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9317C1B6
	for <linux-pci@vger.kernel.org>; Mon, 27 Nov 2023 11:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701114707; x=1732650707;
  h=date:from:to:cc:subject:message-id;
  bh=40VeGJNV6i5Eb2cTtZJiT2P7ecJR4fLH40ACTCNsAXA=;
  b=hM4SjB/HMeb1S5diPVNCs9/n8x+ajSLfOMtId2KWPJhykO7Cb7R1TY71
   4t4oqv+ycSTCzDAhe609ziY804uyplcPYStxN4Rpv6qYk7bdX1mgVvKeu
   Q7crfRm5LP4AyzE0C2dty16K7zBJEIy5LjoCEzJL8gwJzlg5yuYjiMLIs
   hlMJjCSXY5Ch3PCjcMCe87dykoMfpHukr9iQHaDax7qAZC4+lcC7IDK0L
   SAZN8Gc0k1XBi73VKm7MYs2pm0VALSNwnoY+F7Y2QWxaPXAdC6yvys5ng
   iiuscRp3K3c3noOcijWABRTC4tb5bYVjo0jf+OpLkP+kuTCewV3MLN3R/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="383163184"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="383163184"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 11:51:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="16703546"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 27 Nov 2023 11:51:46 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r7hdv-0006bs-1q;
	Mon, 27 Nov 2023 19:51:43 +0000
Date: Tue, 28 Nov 2023 03:51:29 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:resource] BUILD SUCCESS
 3171e46d677a668eed3086da78671f1e4f5b8405
Message-ID: <202311280326.Mos3I2qh-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git resource
branch HEAD: 3171e46d677a668eed3086da78671f1e4f5b8405  PCI: Avoid potential out-of-bounds read in pci_dev_for_each_resource()

elapsed time: 9835m

configs tested: 310
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
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20231121   gcc  
arc                   randconfig-001-20231122   gcc  
arc                   randconfig-001-20231123   gcc  
arc                   randconfig-002-20231121   gcc  
arc                   randconfig-002-20231122   gcc  
arc                   randconfig-002-20231123   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   clang
arm                         lpc18xx_defconfig   gcc  
arm                            mps2_defconfig   gcc  
arm                        multi_v5_defconfig   clang
arm                        multi_v7_defconfig   gcc  
arm                        mvebu_v7_defconfig   gcc  
arm                         nhk8815_defconfig   gcc  
arm                   randconfig-001-20231121   gcc  
arm                   randconfig-001-20231123   gcc  
arm                   randconfig-002-20231121   gcc  
arm                   randconfig-002-20231123   gcc  
arm                   randconfig-003-20231121   gcc  
arm                   randconfig-003-20231123   gcc  
arm                   randconfig-004-20231121   gcc  
arm                   randconfig-004-20231123   gcc  
arm                             rpc_defconfig   gcc  
arm                           sama5_defconfig   gcc  
arm                           sunxi_defconfig   gcc  
arm                        vexpress_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231121   gcc  
arm64                 randconfig-001-20231123   gcc  
arm64                 randconfig-002-20231121   gcc  
arm64                 randconfig-002-20231123   gcc  
arm64                 randconfig-003-20231121   gcc  
arm64                 randconfig-003-20231123   gcc  
arm64                 randconfig-004-20231121   gcc  
arm64                 randconfig-004-20231123   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231121   gcc  
csky                  randconfig-001-20231122   gcc  
csky                  randconfig-001-20231123   gcc  
csky                  randconfig-002-20231121   gcc  
csky                  randconfig-002-20231122   gcc  
csky                  randconfig-002-20231123   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                                defconfig   gcc  
i386                  randconfig-011-20231121   clang
i386                  randconfig-011-20231122   gcc  
i386                  randconfig-011-20231123   clang
i386                  randconfig-012-20231121   clang
i386                  randconfig-012-20231122   gcc  
i386                  randconfig-012-20231123   clang
i386                  randconfig-013-20231121   clang
i386                  randconfig-013-20231122   gcc  
i386                  randconfig-013-20231123   clang
i386                  randconfig-014-20231121   clang
i386                  randconfig-014-20231122   gcc  
i386                  randconfig-014-20231123   clang
i386                  randconfig-015-20231121   clang
i386                  randconfig-015-20231122   gcc  
i386                  randconfig-015-20231123   clang
i386                  randconfig-016-20231121   clang
i386                  randconfig-016-20231122   gcc  
i386                  randconfig-016-20231123   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20231121   gcc  
loongarch             randconfig-001-20231122   gcc  
loongarch             randconfig-001-20231123   gcc  
loongarch             randconfig-002-20231121   gcc  
loongarch             randconfig-002-20231122   gcc  
loongarch             randconfig-002-20231123   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                           ip32_defconfig   gcc  
mips                           jazz_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
mips                          rb532_defconfig   gcc  
mips                         rt305x_defconfig   gcc  
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231121   gcc  
nios2                 randconfig-001-20231122   gcc  
nios2                 randconfig-001-20231123   gcc  
nios2                 randconfig-002-20231121   gcc  
nios2                 randconfig-002-20231122   gcc  
nios2                 randconfig-002-20231123   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231121   gcc  
parisc                randconfig-001-20231122   gcc  
parisc                randconfig-001-20231123   gcc  
parisc                randconfig-002-20231121   gcc  
parisc                randconfig-002-20231122   gcc  
parisc                randconfig-002-20231123   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                      bamboo_defconfig   gcc  
powerpc                 canyonlands_defconfig   gcc  
powerpc                      chrp32_defconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                       holly_defconfig   gcc  
powerpc                   motionpro_defconfig   gcc  
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc                      pmac32_defconfig   clang
powerpc                      ppc40x_defconfig   gcc  
powerpc               randconfig-001-20231121   gcc  
powerpc               randconfig-001-20231123   gcc  
powerpc               randconfig-002-20231121   gcc  
powerpc               randconfig-002-20231123   gcc  
powerpc               randconfig-003-20231121   gcc  
powerpc               randconfig-003-20231123   gcc  
powerpc64                           defconfig   gcc  
powerpc64             randconfig-001-20231121   gcc  
powerpc64             randconfig-001-20231123   gcc  
powerpc64             randconfig-002-20231121   gcc  
powerpc64             randconfig-002-20231123   gcc  
powerpc64             randconfig-003-20231121   gcc  
powerpc64             randconfig-003-20231123   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231121   gcc  
riscv                 randconfig-001-20231123   gcc  
riscv                 randconfig-002-20231121   gcc  
riscv                 randconfig-002-20231123   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231122   gcc  
s390                  randconfig-002-20231122   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                    randconfig-001-20231121   gcc  
sh                    randconfig-001-20231122   gcc  
sh                    randconfig-001-20231123   gcc  
sh                    randconfig-002-20231121   gcc  
sh                    randconfig-002-20231122   gcc  
sh                    randconfig-002-20231123   gcc  
sh                           se7724_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231121   gcc  
sparc64               randconfig-001-20231122   gcc  
sparc64               randconfig-001-20231123   gcc  
sparc64               randconfig-002-20231121   gcc  
sparc64               randconfig-002-20231122   gcc  
sparc64               randconfig-002-20231123   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231121   gcc  
um                    randconfig-001-20231123   gcc  
um                    randconfig-002-20231121   gcc  
um                    randconfig-002-20231123   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231121   gcc  
x86_64       buildonly-randconfig-001-20231122   clang
x86_64       buildonly-randconfig-001-20231123   gcc  
x86_64       buildonly-randconfig-002-20231121   gcc  
x86_64       buildonly-randconfig-002-20231122   clang
x86_64       buildonly-randconfig-002-20231123   gcc  
x86_64       buildonly-randconfig-003-20231121   gcc  
x86_64       buildonly-randconfig-003-20231122   clang
x86_64       buildonly-randconfig-003-20231123   gcc  
x86_64       buildonly-randconfig-004-20231121   gcc  
x86_64       buildonly-randconfig-004-20231122   clang
x86_64       buildonly-randconfig-004-20231123   gcc  
x86_64       buildonly-randconfig-005-20231121   gcc  
x86_64       buildonly-randconfig-005-20231122   clang
x86_64       buildonly-randconfig-005-20231123   gcc  
x86_64       buildonly-randconfig-006-20231121   gcc  
x86_64       buildonly-randconfig-006-20231122   clang
x86_64       buildonly-randconfig-006-20231123   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231121   gcc  
x86_64                randconfig-011-20231122   clang
x86_64                randconfig-011-20231123   gcc  
x86_64                randconfig-012-20231121   gcc  
x86_64                randconfig-012-20231122   clang
x86_64                randconfig-012-20231123   gcc  
x86_64                randconfig-013-20231121   gcc  
x86_64                randconfig-013-20231122   clang
x86_64                randconfig-013-20231123   gcc  
x86_64                randconfig-014-20231121   gcc  
x86_64                randconfig-014-20231122   clang
x86_64                randconfig-014-20231123   gcc  
x86_64                randconfig-015-20231121   gcc  
x86_64                randconfig-015-20231122   clang
x86_64                randconfig-015-20231123   gcc  
x86_64                randconfig-016-20231121   gcc  
x86_64                randconfig-016-20231122   clang
x86_64                randconfig-016-20231123   gcc  
x86_64                randconfig-071-20231121   gcc  
x86_64                randconfig-071-20231122   clang
x86_64                randconfig-071-20231123   gcc  
x86_64                randconfig-072-20231121   gcc  
x86_64                randconfig-072-20231122   clang
x86_64                randconfig-072-20231123   gcc  
x86_64                randconfig-073-20231121   gcc  
x86_64                randconfig-073-20231122   clang
x86_64                randconfig-073-20231123   gcc  
x86_64                randconfig-074-20231121   gcc  
x86_64                randconfig-074-20231122   clang
x86_64                randconfig-074-20231123   gcc  
x86_64                randconfig-075-20231121   gcc  
x86_64                randconfig-075-20231122   clang
x86_64                randconfig-075-20231123   gcc  
x86_64                randconfig-076-20231121   gcc  
x86_64                randconfig-076-20231122   clang
x86_64                randconfig-076-20231123   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                randconfig-001-20231121   gcc  
xtensa                randconfig-001-20231122   gcc  
xtensa                randconfig-001-20231123   gcc  
xtensa                randconfig-002-20231121   gcc  
xtensa                randconfig-002-20231122   gcc  
xtensa                randconfig-002-20231123   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

