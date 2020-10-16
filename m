Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E5F290564
	for <lists+linux-pci@lfdr.de>; Fri, 16 Oct 2020 14:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404497AbgJPMkN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Oct 2020 08:40:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:42582 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391235AbgJPMkN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Oct 2020 08:40:13 -0400
IronPort-SDR: TpjDrgEbQdq3xZzHNTly6Stit7NCXsjHfxzTMQWBEqZDHOS7xbG8nvZcI/F+7foQTiMMZ3Q8ZK
 1dJWjTJOYw2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="153512757"
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="153512757"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 05:40:12 -0700
IronPort-SDR: 4xD12ELhwDM+MIm0wyZg4/+caOv+fvCXXsQU72u4sykFaqCFWeR8fcvc4m4297X0/9OTxZjqXy
 x2Jtqseg+i5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="300598811"
Received: from lkp-server02.sh.intel.com (HELO 262a2cdd3070) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 16 Oct 2020 05:40:11 -0700
Received: from kbuild by 262a2cdd3070 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kTP1m-00000k-FJ; Fri, 16 Oct 2020 12:40:10 +0000
Date:   Fri, 16 Oct 2020 20:39:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/aspm] BUILD SUCCESS
 98dfa938c32bacd5b02328a734caf4cc188f8239
Message-ID: <5f89947b.xcY/k/cuX5UAF+Z9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/aspm
branch HEAD: 98dfa938c32bacd5b02328a734caf4cc188f8239  PCI/ASPM: Remove struct pcie_link_state.l1ss

elapsed time: 725m

configs tested: 150
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                   bluestone_defconfig
arm                       mainstone_defconfig
powerpc                      acadia_defconfig
xtensa                       common_defconfig
sh                        dreamcast_defconfig
powerpc                     mpc512x_defconfig
arm                           h3600_defconfig
sh                        apsh4ad0a_defconfig
s390                             alldefconfig
arm                       multi_v4t_defconfig
powerpc                      ppc44x_defconfig
xtensa                  audio_kc705_defconfig
m68k                        mvme147_defconfig
powerpc                        cell_defconfig
arm                          collie_defconfig
mips                      maltaaprp_defconfig
arm                          moxart_defconfig
sh                               alldefconfig
powerpc                     tqm5200_defconfig
mips                      pic32mzda_defconfig
m68k                          multi_defconfig
sh                   sh7724_generic_defconfig
powerpc                 linkstation_defconfig
powerpc                      katmai_defconfig
arm                        vexpress_defconfig
arm                         at91_dt_defconfig
arm                            lart_defconfig
parisc                generic-64bit_defconfig
x86_64                           alldefconfig
riscv                               defconfig
powerpc                 mpc8272_ads_defconfig
xtensa                              defconfig
arm                        neponset_defconfig
microblaze                      mmu_defconfig
sh                         ecovec24_defconfig
sh                         ap325rxa_defconfig
powerpc                      ppc64e_defconfig
arm                          ep93xx_defconfig
mips                          ath79_defconfig
arm                      jornada720_defconfig
sh                           se7206_defconfig
sh                          r7780mp_defconfig
ia64                         bigsur_defconfig
arm                       aspeed_g5_defconfig
arm                        mvebu_v5_defconfig
ia64                             allyesconfig
powerpc                     stx_gp3_defconfig
powerpc                           allnoconfig
powerpc                         ps3_defconfig
h8300                       h8s-sim_defconfig
arm                           stm32_defconfig
arm                           spitz_defconfig
sh                  sh7785lcr_32bit_defconfig
arc                        nsimosci_defconfig
arm                       omap2plus_defconfig
arm                            xcep_defconfig
arm                        mini2440_defconfig
powerpc                     mpc5200_defconfig
arm                             pxa_defconfig
nios2                            allyesconfig
m68k                          sun3x_defconfig
sh                            shmin_defconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a005-20201015
i386                 randconfig-a006-20201015
i386                 randconfig-a001-20201015
i386                 randconfig-a003-20201015
i386                 randconfig-a004-20201015
i386                 randconfig-a002-20201015
i386                 randconfig-a005-20201014
i386                 randconfig-a006-20201014
i386                 randconfig-a001-20201014
i386                 randconfig-a003-20201014
i386                 randconfig-a004-20201014
i386                 randconfig-a002-20201014
i386                 randconfig-a005-20201016
i386                 randconfig-a006-20201016
i386                 randconfig-a001-20201016
i386                 randconfig-a003-20201016
i386                 randconfig-a004-20201016
i386                 randconfig-a002-20201016
x86_64               randconfig-a016-20201014
x86_64               randconfig-a012-20201014
x86_64               randconfig-a015-20201014
x86_64               randconfig-a013-20201014
x86_64               randconfig-a014-20201014
x86_64               randconfig-a011-20201014
i386                 randconfig-a016-20201014
i386                 randconfig-a013-20201014
i386                 randconfig-a015-20201014
i386                 randconfig-a011-20201014
i386                 randconfig-a012-20201014
i386                 randconfig-a014-20201014
i386                 randconfig-a016-20201015
i386                 randconfig-a013-20201015
i386                 randconfig-a015-20201015
i386                 randconfig-a011-20201015
i386                 randconfig-a012-20201015
i386                 randconfig-a014-20201015
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201014
x86_64               randconfig-a002-20201014
x86_64               randconfig-a006-20201014
x86_64               randconfig-a001-20201014
x86_64               randconfig-a005-20201014
x86_64               randconfig-a003-20201014

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
