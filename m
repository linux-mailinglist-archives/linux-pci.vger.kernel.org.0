Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064B657F6A9
	for <lists+linux-pci@lfdr.de>; Sun, 24 Jul 2022 21:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiGXTIV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Jul 2022 15:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGXTIU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 Jul 2022 15:08:20 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1C7DFFC
        for <linux-pci@vger.kernel.org>; Sun, 24 Jul 2022 12:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658689699; x=1690225699;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=uRRpZKw0je++tuTaaHOqkY4ZRg8Cv4KEKEhk2NRIoh8=;
  b=CSKai4Png90Grb83PgJWr2ag7aWXkiIdBtsgxpDxBe67pxOCsGRw2PcQ
   lIuAiVkYQv2otURjJKVNHkMXhDam/Iof/1KxARpn0CgRwZJuBEJwZFAtz
   4y2bQ3gCjVVM/hsrQfXtWKOxS3PpuVIGOQns0fmC3L1NiZLDjPl1bTKBz
   AHDYnav+4Y5ehgzLgjaMgy8jMhCIOOnAu1tDKxdP17ueQpnHWIEoWStGT
   /FVZqfw2lwfMs4A0jUv0Cnpn4T51CDiK+Q77iKD3bq9fky0vD/n9Ph0Bd
   oQK5yN9JJ4ENARkIrrmV4jRi+NYfJKjh0wAZhEJAN3UNBX921HWdfpO5D
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="287577604"
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="287577604"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 12:08:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="632126719"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 24 Jul 2022 12:08:17 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFgxc-00049V-2O;
        Sun, 24 Jul 2022 19:08:16 +0000
Date:   Mon, 25 Jul 2022 03:07:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/ctrl/dwc] BUILD SUCCESS
 e92d4cc4be340a448ea25680838f9307e6f53878
Message-ID: <62dd986f.cl5kJiZq5fnGI3qO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ctrl/dwc
branch HEAD: e92d4cc4be340a448ea25680838f9307e6f53878  dt-bindings: PCI: qcom: Support additional MSI interrupts

elapsed time: 2943m

configs tested: 223
configs skipped: 8

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
arm                        clps711x_defconfig
powerpc                 mpc85xx_cds_defconfig
parisc64                         alldefconfig
arm                       imx_v6_v7_defconfig
powerpc                      tqm8xx_defconfig
arc                      axs103_smp_defconfig
um                                  defconfig
arm                           tegra_defconfig
sh                          polaris_defconfig
nios2                               defconfig
arm                            qcom_defconfig
arm                           u8500_defconfig
sh                             shx3_defconfig
nios2                         10m50_defconfig
xtensa                              defconfig
arm                         cm_x300_defconfig
arm                          simpad_defconfig
sparc                       sparc32_defconfig
sh                  sh7785lcr_32bit_defconfig
parisc                generic-64bit_defconfig
arm                           h5000_defconfig
arm                        realview_defconfig
arm                           sama5_defconfig
m68k                        m5407c3_defconfig
mips                           jazz_defconfig
powerpc                 mpc8540_ads_defconfig
openrisc                 simple_smp_defconfig
nios2                         3c120_defconfig
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
powerpc                    amigaone_defconfig
arm                        cerfcube_defconfig
arc                          axs101_defconfig
arm                        shmobile_defconfig
m68k                           virt_defconfig
arm                           stm32_defconfig
sh                                  defconfig
arm                       omap2plus_defconfig
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
ia64                          tiger_defconfig
powerpc                         ps3_defconfig
sh                         apsh4a3a_defconfig
sh                          sdk7786_defconfig
mips                           ip32_defconfig
powerpc                       ppc64_defconfig
csky                                defconfig
arm                          gemini_defconfig
sh                     sh7710voipgw_defconfig
arm                        mini2440_defconfig
sh                             espt_defconfig
alpha                               defconfig
mips                           ci20_defconfig
sh                          kfr2r09_defconfig
powerpc                     tqm8548_defconfig
powerpc                      mgcoge_defconfig
sh                           se7751_defconfig
m68k                       m5208evb_defconfig
sh                            titan_defconfig
arm                            pleb_defconfig
arc                 nsimosci_hs_smp_defconfig
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
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a004
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220721
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm

clang tested configs:
arm                           sama7_defconfig
mips                           ip22_defconfig
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
mips                           mtx1_defconfig
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
arm                         hackkit_defconfig
mips                         tb0219_defconfig
powerpc                   microwatt_defconfig
powerpc                 mpc8272_ads_defconfig
arm                        spear3xx_defconfig
mips                         tb0287_defconfig
arm                        mvebu_v5_defconfig
mips                   sb1250_swarm_defconfig
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
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220721
s390                 randconfig-r044-20220721
hexagon              randconfig-r045-20220721
riscv                randconfig-r042-20220721

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
