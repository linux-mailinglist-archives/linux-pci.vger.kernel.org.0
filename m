Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47FB48F669
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jan 2022 11:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbiAOKdx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 Jan 2022 05:33:53 -0500
Received: from mga07.intel.com ([134.134.136.100]:52963 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231596AbiAOKdx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 15 Jan 2022 05:33:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642242833; x=1673778833;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=1bwMGdBESugjLA4qBEV8+9BvpoaG6l0ZBKQNh/zOU1c=;
  b=cTVOocmiRSlfg23czmT4Fs4z0j7sYpcQ7TzQouBY5U0DYA3KN455S+2q
   FhI4gr28pTbOgGx09AyLbK1DapuPJJlFiOZ9siL6f1BSEJNMbcik9f9vX
   ncat0XwWVWK5TmDoTQP3QsJcijdtCmnBzH08d3GlfV3GRYwE3Wo/wanDn
   SZTNShgE3F2fEZmgLgGJoKCOcXxhYgIR+pMcf6J1UkmWxYRuhdU/xeJDE
   QreiEnrJqdujDV/rT2NmFkxjSzgXMiOIFIAhllPIdmpOEgmYMsFLLF+YD
   +kHcUUW7TAhEVvxnsv20Ty7G4VNJ7QWqPNrBBBZeR8lkQ7UrFc/sJbBTw
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="307741842"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="307741842"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2022 02:33:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="624630727"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 Jan 2022 02:33:51 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8gNb-0009eu-7Q; Sat, 15 Jan 2022 10:33:51 +0000
Date:   Sat, 15 Jan 2022 18:33:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:v5.17-merge] BUILD SUCCESS
 868fafd67742e7a2418ce48b44b96f3a6231486d
Message-ID: <61e2a2fd.aaheujDCuSIxf0aR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git v5.17-merge
branch HEAD: 868fafd67742e7a2418ce48b44b96f3a6231486d  Merge branch 'next' into v5.17-merge

elapsed time: 731m

configs tested: 118
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
h8300                            allyesconfig
arc                                 defconfig
mips                           jazz_defconfig
h8300                               defconfig
powerpc                        cell_defconfig
arm                           sama5_defconfig
x86_64                           alldefconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                      pcm030_defconfig
sparc                               defconfig
mips                           ip32_defconfig
arm                           viper_defconfig
arm                        mvebu_v7_defconfig
arm                      integrator_defconfig
xtensa                generic_kc705_defconfig
xtensa                    xip_kc705_defconfig
ia64                                defconfig
sh                   secureedge5410_defconfig
powerpc                 linkstation_defconfig
ia64                         bigsur_defconfig
ia64                            zx1_defconfig
powerpc                     tqm8541_defconfig
mips                            ar7_defconfig
arm                           h3600_defconfig
sh                        sh7785lcr_defconfig
ia64                             allmodconfig
arm                      footbridge_defconfig
sh                     magicpanelr2_defconfig
arm                  randconfig-c002-20220113
arm                  randconfig-c002-20220114
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220113
arc                  randconfig-r043-20220113
s390                 randconfig-r044-20220113
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220113
x86_64                        randconfig-c007
riscv                randconfig-c006-20220113
powerpc              randconfig-c003-20220113
i386                          randconfig-c001
mips                 randconfig-c004-20220113
mips                           ip27_defconfig
mips                      pic32mzda_defconfig
mips                          ath79_defconfig
arm                     davinci_all_defconfig
mips                         tb0219_defconfig
powerpc                    socrates_defconfig
powerpc                        icon_defconfig
powerpc                   lite5200b_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
hexagon              randconfig-r045-20220113
hexagon              randconfig-r045-20220114
riscv                randconfig-r042-20220114
hexagon              randconfig-r041-20220114
hexagon              randconfig-r041-20220113

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
