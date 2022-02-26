Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540D94C5446
	for <lists+linux-pci@lfdr.de>; Sat, 26 Feb 2022 08:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiBZHDU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Feb 2022 02:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiBZHDT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Feb 2022 02:03:19 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EB91408A
        for <linux-pci@vger.kernel.org>; Fri, 25 Feb 2022 23:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645858964; x=1677394964;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ubw+8AjcAtiSYU9UetHDDyQQa0wL+ezHazmbnw4XsNE=;
  b=edotZAh/n/9bL4Xx1mXZpL062OOPiZPHEkx5eJ7spwXQW6XbYMKVATwy
   ol2wPni93ksCUuN6gM1wyNezrXxn5LPXitE8y4cNf8O9KtPZIsEKsPO0Y
   fhsXMY4M7/S9HBABwQ596Arummavrv7cTuLdRK5gIqTb+4AFF8skOwJ7w
   Wy0jRBJzgymFdllnbl1xnqpQ6fMkNTntbWxPsUELq/qOCL2piNdXC8tSU
   Kcz+I7FcBW8/kmVInZ8Bubrl5W1S+Ar5OzzgCdP9ev9lIGdRvQf3wXXoP
   CBJW1G3Jm+y7Gf8Oq5GEBvmzSIwmynyGbnWUxh3YwU3Cmh7R9D5sLuPUG
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="251470878"
X-IronPort-AV: E=Sophos;i="5.90,138,1643702400"; 
   d="scan'208";a="251470878"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 23:02:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,138,1643702400"; 
   d="scan'208";a="509510927"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 25 Feb 2022 23:02:42 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNr6H-0005Bm-ME; Sat, 26 Feb 2022 07:02:41 +0000
Date:   Sat, 26 Feb 2022 15:02:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/p2pdma] BUILD SUCCESS
 feaea1fe8b36b2e5b12b2f9e6e050db28dfee789
Message-ID: <6219d06e.1qCfiAvRi9CT1nP9%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/p2pdma
branch HEAD: feaea1fe8b36b2e5b12b2f9e6e050db28dfee789  PCI/P2PDMA: Add Intel 3rd Gen Intel Xeon Scalable Processors to whitelist

elapsed time: 720m

configs tested: 168
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
mips                 randconfig-c004-20220225
i386                          randconfig-c001
powerpc              randconfig-c003-20220225
s390                          debug_defconfig
arm                        shmobile_defconfig
sh                         microdev_defconfig
arc                                 defconfig
sh                   sh7770_generic_defconfig
arm                            hisi_defconfig
sh                           se7619_defconfig
arm                        oxnas_v6_defconfig
xtensa                  nommu_kc705_defconfig
sh                          kfr2r09_defconfig
sparc                       sparc64_defconfig
ia64                         bigsur_defconfig
mips                      loongson3_defconfig
sh                          sdk7780_defconfig
powerpc                     asp8347_defconfig
arm                          exynos_defconfig
s390                       zfcpdump_defconfig
m68k                         apollo_defconfig
powerpc                 linkstation_defconfig
parisc                           allyesconfig
arm                          lpd270_defconfig
nios2                         3c120_defconfig
arm                           h5000_defconfig
sh                        edosk7705_defconfig
arc                      axs103_smp_defconfig
mips                         tb0226_defconfig
arm                       imx_v6_v7_defconfig
sh                               allmodconfig
arm                         assabet_defconfig
mips                  decstation_64_defconfig
sh                        dreamcast_defconfig
xtensa                         virt_defconfig
s390                             allyesconfig
arm                           tegra_defconfig
sh                   sh7724_generic_defconfig
powerpc                     pq2fads_defconfig
csky                                defconfig
powerpc                        warp_defconfig
m68k                        mvme147_defconfig
microblaze                      mmu_defconfig
nios2                         10m50_defconfig
h8300                               defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                    klondike_defconfig
mips                         db1xxx_defconfig
mips                             allyesconfig
m68k                        m5272c3_defconfig
powerpc                     tqm8548_defconfig
arm                        trizeps4_defconfig
powerpc                      tqm8xx_defconfig
mips                        vocore2_defconfig
i386                             alldefconfig
powerpc                         wii_defconfig
arm                          pxa910_defconfig
arm                           sunxi_defconfig
powerpc                     redwood_defconfig
mips                     loongson1b_defconfig
arm                        mvebu_v7_defconfig
alpha                            allyesconfig
mips                       bmips_be_defconfig
xtensa                           allyesconfig
powerpc                       maple_defconfig
powerpc                     ep8248e_defconfig
sh                          lboxre2_defconfig
sh                          urquell_defconfig
xtensa                    smp_lx200_defconfig
powerpc64                           defconfig
arm                          simpad_defconfig
mips                         rt305x_defconfig
powerpc                   motionpro_defconfig
arm                           viper_defconfig
sh                        sh7757lcr_defconfig
m68k                          multi_defconfig
h8300                       h8s-sim_defconfig
sh                           se7750_defconfig
mips                          rb532_defconfig
mips                     decstation_defconfig
um                               alldefconfig
arm                      integrator_defconfig
arm                  randconfig-c002-20220225
arm                  randconfig-c002-20220226
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
alpha                               defconfig
h8300                            allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc64                            defconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
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
s390                 randconfig-r044-20220226
arc                  randconfig-r043-20220226
riscv                randconfig-r042-20220226
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
powerpc              randconfig-c003-20220225
arm                  randconfig-c002-20220225
x86_64                        randconfig-c007
mips                 randconfig-c004-20220225
i386                          randconfig-c001
riscv                randconfig-c006-20220225
powerpc                    ge_imp3a_defconfig
mips                      bmips_stb_defconfig
powerpc                   microwatt_defconfig
arm                       spear13xx_defconfig
mips                        omega2p_defconfig
powerpc                     ppa8548_defconfig
mips                malta_qemu_32r6_defconfig
mips                         tb0219_defconfig
arm                     am200epdkit_defconfig
i386                          randconfig-a004
i386                          randconfig-a002
i386                          randconfig-a006
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220226
hexagon              randconfig-r045-20220225
hexagon              randconfig-r041-20220225
hexagon              randconfig-r041-20220226
riscv                randconfig-r042-20220225

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
