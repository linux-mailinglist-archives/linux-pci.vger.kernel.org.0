Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968D635278C
	for <lists+linux-pci@lfdr.de>; Fri,  2 Apr 2021 10:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhDBIpQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Apr 2021 04:45:16 -0400
Received: from mga04.intel.com ([192.55.52.120]:41524 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhDBIpQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Apr 2021 04:45:16 -0400
IronPort-SDR: iG7CbvN9Lwd4n8cOYCUbm/uJ8LFR3xYRsWNRpMah0Xx+xI/AjDay8uzWGkiM/IzTXH19sEbB19
 3pyd++vvs9sA==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="190194050"
X-IronPort-AV: E=Sophos;i="5.81,299,1610438400"; 
   d="scan'208";a="190194050"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 01:45:15 -0700
IronPort-SDR: gWSxDad2PpXnW/C1QTR7oTUDGen2xiSewCLk+Ms/+mXqi1mEwUVG8dcLGmelZjN9VZe0zQ105P
 5ApED6NfZKhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,299,1610438400"; 
   d="scan'208";a="394885436"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 02 Apr 2021 01:45:13 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lSFQX-00071S-5J; Fri, 02 Apr 2021 08:45:13 +0000
Date:   Fri, 02 Apr 2021 16:44:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS 3a376659a7c175b8ae8b56e79d21e7e305058011
Message-ID: <6066d984.I1AR0fTLDQthHKTY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 3a376659a7c175b8ae8b56e79d21e7e305058011  Merge branch 'remotes/lorenzo/pci/misc'

elapsed time: 733m

configs tested: 152
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
x86_64                           allyesconfig
i386                             allyesconfig
riscv                            allyesconfig
arm                       aspeed_g4_defconfig
riscv                    nommu_k210_defconfig
m68k                          amiga_defconfig
sh                            titan_defconfig
arm                        trizeps4_defconfig
alpha                            alldefconfig
arm                           sama5_defconfig
sh                         apsh4a3a_defconfig
arm                           omap1_defconfig
arm                           h5000_defconfig
mips                     cu1830-neo_defconfig
mips                     cu1000-neo_defconfig
mips                             allmodconfig
mips                      pistachio_defconfig
riscv                          rv32_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                     redwood_defconfig
parisc                generic-32bit_defconfig
mips                            gpr_defconfig
powerpc                     tqm8540_defconfig
sh                     magicpanelr2_defconfig
powerpc                  mpc866_ads_defconfig
powerpc               mpc834x_itxgp_defconfig
m68k                          atari_defconfig
x86_64                           alldefconfig
arm                          exynos_defconfig
mips                        nlm_xlp_defconfig
arm                         shannon_defconfig
arm                       omap2plus_defconfig
xtensa                  audio_kc705_defconfig
powerpc                      acadia_defconfig
powerpc                     mpc512x_defconfig
sh                   rts7751r2dplus_defconfig
arm                             pxa_defconfig
mips                        workpad_defconfig
nios2                         10m50_defconfig
arm                          iop32x_defconfig
ia64                             alldefconfig
powerpc                      tqm8xx_defconfig
mips                           ip27_defconfig
m68k                       bvme6000_defconfig
arm                        cerfcube_defconfig
m68k                           sun3_defconfig
arm                            pleb_defconfig
mips                          malta_defconfig
arm                        magician_defconfig
ia64                      gensparse_defconfig
arm                       spear13xx_defconfig
h8300                       h8s-sim_defconfig
arm                          badge4_defconfig
mips                      loongson3_defconfig
arc                     nsimosci_hs_defconfig
um                                allnoconfig
arm                         cm_x300_defconfig
sh                   sh7724_generic_defconfig
powerpc                   lite5200b_defconfig
arm                           viper_defconfig
arm                          imote2_defconfig
mips                        qi_lb60_defconfig
mips                       rbtx49xx_defconfig
arm                           tegra_defconfig
powerpc                       maple_defconfig
powerpc                     rainier_defconfig
sh                        dreamcast_defconfig
mips                            e55_defconfig
riscv                               defconfig
mips                        vocore2_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                       eiger_defconfig
ia64                         bigsur_defconfig
xtensa                       common_defconfig
arm                          ixp4xx_defconfig
arm                           corgi_defconfig
m68k                       m5208evb_defconfig
mips                       capcella_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                           se7750_defconfig
arm                         lpc18xx_defconfig
arm                          moxart_defconfig
s390                             allyesconfig
ia64                             allmodconfig
ia64                                defconfig
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
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20210401
i386                 randconfig-a003-20210401
i386                 randconfig-a001-20210401
i386                 randconfig-a004-20210401
i386                 randconfig-a002-20210401
i386                 randconfig-a005-20210401
x86_64               randconfig-a014-20210401
x86_64               randconfig-a015-20210401
x86_64               randconfig-a011-20210401
x86_64               randconfig-a013-20210401
x86_64               randconfig-a012-20210401
x86_64               randconfig-a016-20210401
i386                 randconfig-a014-20210401
i386                 randconfig-a011-20210401
i386                 randconfig-a016-20210401
i386                 randconfig-a012-20210401
i386                 randconfig-a013-20210401
i386                 randconfig-a015-20210401
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
um                               allmodconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210401
x86_64               randconfig-a005-20210401
x86_64               randconfig-a003-20210401
x86_64               randconfig-a001-20210401
x86_64               randconfig-a002-20210401
x86_64               randconfig-a006-20210401

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
