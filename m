Return-Path: <linux-pci+bounces-379-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B3B801FB9
	for <lists+linux-pci@lfdr.de>; Sun,  3 Dec 2023 00:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70DB41F20F76
	for <lists+linux-pci@lfdr.de>; Sat,  2 Dec 2023 23:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C1722336;
	Sat,  2 Dec 2023 23:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X+e350B+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776CBDF
	for <linux-pci@vger.kernel.org>; Sat,  2 Dec 2023 15:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701559819; x=1733095819;
  h=date:from:to:cc:subject:message-id;
  bh=QqTtZThqG/LrV7FO1Wg/Fme1W7r6VNvCUTh3rPAcRHM=;
  b=X+e350B+Cq4Y3TyJq2dh73ucC1cfPrF9mdi/LMX6//stJShglw5cL9El
   50ebjzJnyoA3dpLsTIaQfQQ6e1ND58ZZitnDp+n6n7Q7fA5bnYxQDlqbF
   DscDYbs+76knw6YpuxEvRz2mxr+jGWli23cRGLEiLuhW/ZjKu/OK7zqPV
   xl1+/FIK3PwdwsSLDFLNtWm4Dhy7oJ85K2hlNPlIBXta67mIuKxf9nTz2
   u2ONjDdC8K8IXnYrmrCcO0o74O0mLNLw7GESgo1pvW/yX9M6hok/3n2Sz
   rrJIMSU6vGSZb9fN19/L55btWHzY6Y7LA7BEWJI5hK/5DDoT6W+gYvbG2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="373037303"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="373037303"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 15:30:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="763552437"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="763552437"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 02 Dec 2023 15:30:17 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r9ZR9-0005wX-0C;
	Sat, 02 Dec 2023 23:30:15 +0000
Date: Sun, 03 Dec 2023 07:29:39 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:enumeration] BUILD SUCCESS
 0d481ff35c9a85d775e5544bb2e331e7d5eb6c3c
Message-ID: <202312030736.0VPWormW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git enumeration
branch HEAD: 0d481ff35c9a85d775e5544bb2e331e7d5eb6c3c  x86/pci: Clean up open-coded PCIBIOS return code mangling

elapsed time: 1459m

configs tested: 234
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              alldefconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                   randconfig-001-20231202   gcc  
arc                   randconfig-002-20231202   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   clang
arm                          gemini_defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                          pxa3xx_defconfig   gcc  
arm                   randconfig-001-20231202   clang
arm                   randconfig-002-20231202   clang
arm                   randconfig-003-20231202   clang
arm                   randconfig-004-20231202   clang
arm                        realview_defconfig   gcc  
arm                           sunxi_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231202   clang
arm64                 randconfig-002-20231202   clang
arm64                 randconfig-003-20231202   clang
arm64                 randconfig-004-20231202   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231202   gcc  
csky                  randconfig-002-20231202   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231202   clang
hexagon               randconfig-002-20231202   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231202   clang
i386         buildonly-randconfig-002-20231202   clang
i386         buildonly-randconfig-003-20231202   clang
i386         buildonly-randconfig-004-20231202   clang
i386         buildonly-randconfig-005-20231202   clang
i386         buildonly-randconfig-006-20231202   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231202   clang
i386                  randconfig-002-20231202   clang
i386                  randconfig-003-20231202   clang
i386                  randconfig-004-20231202   clang
i386                  randconfig-005-20231202   clang
i386                  randconfig-006-20231202   clang
i386                  randconfig-011-20231202   gcc  
i386                  randconfig-011-20231203   clang
i386                  randconfig-012-20231202   gcc  
i386                  randconfig-012-20231203   clang
i386                  randconfig-013-20231202   gcc  
i386                  randconfig-013-20231203   clang
i386                  randconfig-014-20231202   gcc  
i386                  randconfig-014-20231203   clang
i386                  randconfig-015-20231202   gcc  
i386                  randconfig-015-20231203   clang
i386                  randconfig-016-20231202   gcc  
i386                  randconfig-016-20231203   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231202   gcc  
loongarch             randconfig-002-20231202   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                          rb532_defconfig   gcc  
nios2                         10m50_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231202   gcc  
nios2                 randconfig-002-20231202   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231202   gcc  
parisc                randconfig-002-20231202   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc                     asp8347_defconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                      mgcoge_defconfig   gcc  
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc                       ppc64_defconfig   gcc  
powerpc               randconfig-001-20231202   clang
powerpc               randconfig-003-20231202   clang
powerpc                     sequoia_defconfig   gcc  
powerpc64             randconfig-001-20231202   clang
powerpc64             randconfig-002-20231202   clang
powerpc64             randconfig-003-20231202   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20231202   clang
riscv                 randconfig-002-20231202   clang
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231202   gcc  
s390                  randconfig-002-20231202   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                    randconfig-001-20231202   gcc  
sh                    randconfig-002-20231202   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sh                           se7721_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          alldefconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231202   gcc  
sparc64               randconfig-002-20231202   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231202   clang
um                    randconfig-002-20231202   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231202   clang
x86_64       buildonly-randconfig-001-20231203   gcc  
x86_64       buildonly-randconfig-002-20231202   clang
x86_64       buildonly-randconfig-002-20231203   gcc  
x86_64       buildonly-randconfig-003-20231202   clang
x86_64       buildonly-randconfig-003-20231203   gcc  
x86_64       buildonly-randconfig-004-20231202   clang
x86_64       buildonly-randconfig-004-20231203   gcc  
x86_64       buildonly-randconfig-005-20231202   clang
x86_64       buildonly-randconfig-005-20231203   gcc  
x86_64       buildonly-randconfig-006-20231202   clang
x86_64       buildonly-randconfig-006-20231203   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231202   clang
x86_64                randconfig-011-20231203   gcc  
x86_64                randconfig-012-20231202   clang
x86_64                randconfig-012-20231203   gcc  
x86_64                randconfig-013-20231202   clang
x86_64                randconfig-013-20231203   gcc  
x86_64                randconfig-014-20231202   clang
x86_64                randconfig-014-20231203   gcc  
x86_64                randconfig-015-20231202   clang
x86_64                randconfig-015-20231203   gcc  
x86_64                randconfig-016-20231202   clang
x86_64                randconfig-016-20231203   gcc  
x86_64                randconfig-071-20231202   clang
x86_64                randconfig-071-20231203   gcc  
x86_64                randconfig-072-20231202   clang
x86_64                randconfig-072-20231203   gcc  
x86_64                randconfig-073-20231202   clang
x86_64                randconfig-073-20231203   gcc  
x86_64                randconfig-074-20231202   clang
x86_64                randconfig-074-20231203   gcc  
x86_64                randconfig-075-20231202   clang
x86_64                randconfig-075-20231203   gcc  
x86_64                randconfig-076-20231202   clang
x86_64                randconfig-076-20231203   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                randconfig-001-20231202   gcc  
xtensa                randconfig-002-20231202   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

