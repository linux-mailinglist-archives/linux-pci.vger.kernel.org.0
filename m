Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E774C3E2B
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 07:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237667AbiBYGDU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Feb 2022 01:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237072AbiBYGDT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Feb 2022 01:03:19 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90131180D21
        for <linux-pci@vger.kernel.org>; Thu, 24 Feb 2022 22:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645768968; x=1677304968;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=4GhaxIx1Z5gBVIzWtEDZDyUQB228OKu09d1gG6ayOcA=;
  b=b3XJnOwpx9VwPDIH2ngc081W0S4f6Pru3PLfb7/+k5l+jpBsYKGITVLO
   DGm8M2c9z1bBUVEKS0kLPB+Eq8liviJQ4qZDis/FyFvSUIEUGF69Ov/Bs
   XGYP7SVVOIh913zPcW+yqTVESnpKzJ9nmYEC8AqPRxS+T4t+LlXafnGl+
   BHBLxvQIWxErYAtQTOXQDeM0vfkCspojG0Ig+xl5vmEhjb9ad9tglnxqg
   d+V9NodV+/2g2a4G3q7zV4/P8/9tiQkOSq2jfX2SRJSX63yl6jXIbQG5U
   E7LRTw0r1QbBTtJMmejRS0L0gk6nfy0mGKd9zGj4dxhZCJaHT5YVhXLF0
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="233054497"
X-IronPort-AV: E=Sophos;i="5.90,135,1643702400"; 
   d="scan'208";a="233054497"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 22:02:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,135,1643702400"; 
   d="scan'208";a="707751814"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 24 Feb 2022 22:02:46 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNTgk-0003tt-3H; Fri, 25 Feb 2022 06:02:46 +0000
Date:   Fri, 25 Feb 2022 14:02:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/vga] BUILD SUCCESS
 f3e7b0c5e0e022af3d071c51262920461ba81629
Message-ID: <621870f1.rdGtgAxtD8lSqWZg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/vga
branch HEAD: f3e7b0c5e0e022af3d071c51262920461ba81629  PCI/VGA: Replace full MIT license text with SPDX identifier

elapsed time: 725m

configs tested: 163
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220223
powerpc                    amigaone_defconfig
powerpc                      cm5200_defconfig
powerpc                 mpc837x_mds_defconfig
arm                            zeus_defconfig
powerpc                       maple_defconfig
arm                        spear6xx_defconfig
powerpc                     sequoia_defconfig
microblaze                      mmu_defconfig
powerpc                  iss476-smp_defconfig
h8300                    h8300h-sim_defconfig
ia64                        generic_defconfig
m68k                        mvme16x_defconfig
powerpc                     stx_gp3_defconfig
sh                ecovec24-romimage_defconfig
sh                         microdev_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                 linkstation_defconfig
mips                 decstation_r4k_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                           se7780_defconfig
arm                         nhk8815_defconfig
h8300                     edosk2674_defconfig
sh                           se7751_defconfig
arm                         s3c6400_defconfig
arm                         assabet_defconfig
sh                           se7750_defconfig
xtensa                generic_kc705_defconfig
powerpc                 mpc834x_mds_defconfig
sh                     magicpanelr2_defconfig
m68k                          hp300_defconfig
sh                          rsk7203_defconfig
microblaze                          defconfig
x86_64                              defconfig
parisc64                            defconfig
powerpc                     mpc83xx_defconfig
mips                         db1xxx_defconfig
powerpc                      bamboo_defconfig
m68k                         amcore_defconfig
arm                        keystone_defconfig
m68k                             allyesconfig
openrisc                         alldefconfig
powerpc                     redwood_defconfig
powerpc                        warp_defconfig
arm                           sama5_defconfig
sh                        sh7785lcr_defconfig
powerpc                      tqm8xx_defconfig
arm                     eseries_pxa_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                           se7712_defconfig
sparc64                             defconfig
mips                             allmodconfig
riscv                               defconfig
sh                              ul2_defconfig
arc                            hsdk_defconfig
arm                          gemini_defconfig
arc                     nsimosci_hs_defconfig
arm                  randconfig-c002-20220224
arm                  randconfig-c002-20220223
arm                  randconfig-c002-20220225
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
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
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220223
s390                 randconfig-r044-20220224
arc                  randconfig-r043-20220224
riscv                randconfig-r042-20220224
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func

clang tested configs:
powerpc              randconfig-c003-20220224
x86_64                        randconfig-c007
arm                  randconfig-c002-20220224
mips                 randconfig-c004-20220224
i386                          randconfig-c001
riscv                randconfig-c006-20220224
powerpc                 mpc836x_rdk_defconfig
arm                         s5pv210_defconfig
powerpc                      pmac32_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                                 defconfig
arm                         hackkit_defconfig
powerpc                    mvme5100_defconfig
riscv                    nommu_virt_defconfig
powerpc                     tqm8560_defconfig
mips                           ip22_defconfig
arm                         socfpga_defconfig
arm                      tct_hammer_defconfig
powerpc                   lite5200b_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220223
riscv                randconfig-r042-20220223
hexagon              randconfig-r041-20220223
s390                 randconfig-r044-20220223
hexagon              randconfig-r045-20220224
hexagon              randconfig-r045-20220225
hexagon              randconfig-r041-20220224
hexagon              randconfig-r041-20220225
riscv                randconfig-r042-20220225

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
