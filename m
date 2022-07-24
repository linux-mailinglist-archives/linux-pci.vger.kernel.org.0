Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0E157F3FE
	for <lists+linux-pci@lfdr.de>; Sun, 24 Jul 2022 10:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiGXIY6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Jul 2022 04:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiGXIYz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 Jul 2022 04:24:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9285186F0
        for <linux-pci@vger.kernel.org>; Sun, 24 Jul 2022 01:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658651094; x=1690187094;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=aqJEIaFi3Avjaphrl5tLtiArlIYGmrU69UVaQ/fiODE=;
  b=crp6ILzU2yIfiXbOHUTxJaaJCLagsaDpYglFxFoO+jkkyhbykn7M9poS
   S346/PTNxS2oa7QximRlCVbNPa+6Uk/OT2NdtXTQ87T50N011EiNeW8aK
   A5/AsOllmwo06MBcklAFHwbpPYYDg+RlFPHcAY3gvXslfjY0jah5e38W6
   KF88sGyjoCozGrB3smCBTZCoPgAguy4V4DKhak/DGCpGnxB91qHlrWSGr
   7UGY+hAiEpYLBl4hXUJNhPMLyePojQ3oTdzYKChciPr0qBEIKLuzGhhUZ
   QXo3hY81ioLXbYDDAVaeiuKHH2DzhV2u7PaxVfkJ66XApmSJIDtFWh+h6
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="267918317"
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="267918317"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 01:24:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="627069384"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 24 Jul 2022 01:24:48 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFWuu-0003ir-0y;
        Sun, 24 Jul 2022 08:24:48 +0000
Date:   Sun, 24 Jul 2022 16:24:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/misc] BUILD SUCCESS
 6943f3e3ffe537d2c4683c5c13a04e80798b9496
Message-ID: <62dd01a9.1e6cZh3hjUj6A8FS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/misc
branch HEAD: 6943f3e3ffe537d2c4683c5c13a04e80798b9496  PCI/ACPI: Update link to PCI firmware specification

elapsed time: 2152m

configs tested: 198
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20220724
powerpc              randconfig-c003-20220722
arc                        nsim_700_defconfig
sparc                       sparc64_defconfig
s390                             allmodconfig
m68k                       bvme6000_defconfig
m68k                          atari_defconfig
sh                          r7785rp_defconfig
m68k                                defconfig
powerpc                 mpc834x_itx_defconfig
sh                               alldefconfig
arm                          lpd270_defconfig
m68k                            mac_defconfig
arm                       imx_v6_v7_defconfig
powerpc                      tqm8xx_defconfig
arc                      axs103_smp_defconfig
um                                  defconfig
arm                           u8500_defconfig
sh                             shx3_defconfig
arm                          simpad_defconfig
sparc                       sparc32_defconfig
sh                  sh7785lcr_32bit_defconfig
parisc                generic-64bit_defconfig
m68k                        m5407c3_defconfig
mips                           jazz_defconfig
powerpc                 mpc8540_ads_defconfig
openrisc                 simple_smp_defconfig
nios2                         3c120_defconfig
arm                           h5000_defconfig
mips                  decstation_64_defconfig
mips                         mpc30x_defconfig
powerpc                     pq2fads_defconfig
mips                       bmips_be_defconfig
x86_64                              defconfig
mips                         bigsur_defconfig
sh                          rsk7269_defconfig
sh                     magicpanelr2_defconfig
sh                        apsh4ad0a_defconfig
alpha                            alldefconfig
openrisc                            defconfig
parisc                           alldefconfig
m68k                          amiga_defconfig
mips                 decstation_r4k_defconfig
sh                             sh03_defconfig
xtensa                           alldefconfig
powerpc                     sequoia_defconfig
sh                        sh7763rdp_defconfig
m68k                         amcore_defconfig
arm                            hisi_defconfig
sh                         ap325rxa_defconfig
xtensa                  nommu_kc705_defconfig
arm                           stm32_defconfig
arm                           tegra_defconfig
sh                                  defconfig
arm                       omap2plus_defconfig
xtensa                              defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                     asp8347_defconfig
xtensa                           allyesconfig
m68k                          sun3x_defconfig
xtensa                    smp_lx200_defconfig
arm                         nhk8815_defconfig
arm                           corgi_defconfig
arc                    vdk_hs38_smp_defconfig
arm                         at91_dt_defconfig
riscv                               defconfig
mips                          rb532_defconfig
openrisc                         alldefconfig
powerpc                       ppc64_defconfig
csky                                defconfig
arm                          gemini_defconfig
arm                        mini2440_defconfig
sh                             espt_defconfig
alpha                               defconfig
mips                           ci20_defconfig
sh                          kfr2r09_defconfig
powerpc                     tqm8548_defconfig
powerpc                      mgcoge_defconfig
sh                           se7751_defconfig
parisc64                         alldefconfig
m68k                       m5208evb_defconfig
sh                            titan_defconfig
arm                            pleb_defconfig
sh                           se7724_defconfig
sparc64                             defconfig
loongarch                         allnoconfig
ia64                         bigsur_defconfig
loongarch                           defconfig
sparc                               defconfig
sparc                            allyesconfig
x86_64                                  kexec
s390                                defconfig
arc                                 defconfig
s390                             allyesconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
x86_64                        randconfig-c001
arm                  randconfig-c002-20220721
arm                  randconfig-c002-20220724
arm                  randconfig-c002-20220722
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a005
i386                          randconfig-a001
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220721
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                          malta_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                     akebono_defconfig
arm                  colibri_pxa300_defconfig
hexagon                             defconfig
mips                       rbtx49xx_defconfig
powerpc                      acadia_defconfig
arm                       mainstone_defconfig
mips                        qi_lb60_defconfig
arm                      pxa255-idp_defconfig
mips                      maltaaprp_defconfig
mips                          ath79_defconfig
arm                        multi_v5_defconfig
mips                        bcm63xx_defconfig
powerpc                     ksi8560_defconfig
mips                        maltaup_defconfig
powerpc                      obs600_defconfig
arm                            dove_defconfig
riscv                    nommu_virt_defconfig
arm                  colibri_pxa270_defconfig
powerpc                     ppa8548_defconfig
mips                      malta_kvm_defconfig
mips                           rs90_defconfig
arm                       spear13xx_defconfig
mips                     loongson1c_defconfig
powerpc                   microwatt_defconfig
powerpc                 mpc8272_ads_defconfig
arm                        spear3xx_defconfig
mips                         tb0287_defconfig
arm                         hackkit_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r041-20220721
hexagon              randconfig-r045-20220721
s390                 randconfig-r044-20220721
riscv                randconfig-r042-20220721

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
