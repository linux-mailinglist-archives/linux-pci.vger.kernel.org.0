Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF7A57FEB9
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jul 2022 14:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbiGYMD2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jul 2022 08:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbiGYMD1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jul 2022 08:03:27 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C194186C5
        for <linux-pci@vger.kernel.org>; Mon, 25 Jul 2022 05:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658750607; x=1690286607;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=kQyAFVT7yiJXaR0kFlbygX97BaMjBorb/NG/n9VPoxQ=;
  b=bilysahEs6lHvBjfdx24pp0oEsiesEjgb+A/Pf6VILdmVWEjfVD4dIdo
   XyymClmKwbLQ1z+M4yhZkEBbhkJQZjzYF8OKRmKQb4/cSYUnR7WrRFOpR
   gSx8cuYI5jZCxN6o2efBWZ6tT1J6nw8t31pRdRj6HjDiCndCZAHyiXtWv
   u7cJ4JLJgz5s54XrlpD3HWrMoHppu1EbUzRtBmlUy6NPxT2JjmzVsnZtl
   /SlEDVnO+GQeESOIvmBhtPbg+i6Ew5flEel8vQhw6au1jwiAazYPokGuq
   kd/NEEP+nZhxpG/06pVI1z4fBMJfvDs0WVSfcA8DRFvxOutkls2vhOo+2
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="313429831"
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="313429831"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 05:03:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="667464335"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jul 2022 05:03:25 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFwo0-00057B-2j;
        Mon, 25 Jul 2022 12:03:24 +0000
Date:   Mon, 25 Jul 2022 20:02:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 17fc94dd0f52cc3800451c4fac06803499c9a132
Message-ID: <62de865b.tlPqzZ1XdOZr4zhy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 17fc94dd0f52cc3800451c4fac06803499c9a132  Merge branch 'pci/header-cleanup-immutable'

elapsed time: 2510m

configs tested: 194
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
powerpc              randconfig-c003-20220724
i386                          randconfig-c001
sh                               alldefconfig
arm                          lpd270_defconfig
m68k                            mac_defconfig
arm                        clps711x_defconfig
powerpc                 mpc85xx_cds_defconfig
parisc64                         alldefconfig
um                                  defconfig
arm                           tegra_defconfig
sh                          polaris_defconfig
nios2                               defconfig
arm                            qcom_defconfig
m68k                       m5208evb_defconfig
powerpc                        warp_defconfig
arc                               allnoconfig
powerpc                     stx_gp3_defconfig
mips                       capcella_defconfig
nios2                         3c120_defconfig
arm                           u8500_defconfig
nios2                         10m50_defconfig
xtensa                              defconfig
arm                         cm_x300_defconfig
powerpc                 mpc834x_itx_defconfig
sh                          sdk7786_defconfig
arm                         axm55xx_defconfig
sh                               allmodconfig
sh                          lboxre2_defconfig
arm                           h5000_defconfig
mips                  decstation_64_defconfig
mips                         mpc30x_defconfig
powerpc                     pq2fads_defconfig
mips                       bmips_be_defconfig
x86_64                              defconfig
mips                         bigsur_defconfig
sh                          rsk7269_defconfig
sh                     magicpanelr2_defconfig
xtensa                         virt_defconfig
microblaze                      mmu_defconfig
arm                        realview_defconfig
arm                          badge4_defconfig
arm                       imx_v6_v7_defconfig
arm                       aspeed_g5_defconfig
sh                      rts7751r2d1_defconfig
sh                 kfr2r09-romimage_defconfig
sh                          r7785rp_defconfig
parisc                           alldefconfig
m68k                          amiga_defconfig
mips                 decstation_r4k_defconfig
s390                             allmodconfig
sh                           se7780_defconfig
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
parisc                generic-64bit_defconfig
mips                           jazz_defconfig
xtensa                           allyesconfig
m68k                          sun3x_defconfig
xtensa                    smp_lx200_defconfig
arm                         nhk8815_defconfig
arm                        trizeps4_defconfig
powerpc                      ep88xc_defconfig
sparc                       sparc32_defconfig
ia64                          tiger_defconfig
powerpc                         ps3_defconfig
sh                         apsh4a3a_defconfig
mips                           ip32_defconfig
sh                           se7724_defconfig
sh                           se7721_defconfig
xtensa                  cadence_csp_defconfig
arm                          iop32x_defconfig
sh                     sh7710voipgw_defconfig
powerpc                     tqm8548_defconfig
openrisc                         alldefconfig
sh                            titan_defconfig
s390                                defconfig
riscv                            allyesconfig
arc                 nsimosci_hs_smp_defconfig
arm                            pleb_defconfig
arm                            lart_defconfig
xtensa                generic_kc705_defconfig
ia64                         bigsur_defconfig
loongarch                           defconfig
sparc                               defconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
arc                                 defconfig
alpha                               defconfig
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
loongarch                         allnoconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
x86_64                        randconfig-c001
arm                  randconfig-c002-20220724
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
m68k                             allmodconfig
arc                              allyesconfig
m68k                             allyesconfig
alpha                            allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220724
riscv                randconfig-r042-20220724
s390                 randconfig-r044-20220724
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
arm                           sama7_defconfig
mips                           ip22_defconfig
arm                      pxa255-idp_defconfig
arm                          ixp4xx_defconfig
mips                          malta_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                     powernv_defconfig
mips                            e55_defconfig
arm                       mainstone_defconfig
mips                        qi_lb60_defconfig
mips                        bcm63xx_defconfig
mips                           mtx1_defconfig
mips                        omega2p_defconfig
riscv                    nommu_virt_defconfig
arm                  colibri_pxa270_defconfig
powerpc                     ppa8548_defconfig
mips                     loongson2k_defconfig
mips                      maltaaprp_defconfig
mips                      malta_kvm_defconfig
mips                           rs90_defconfig
arm                         hackkit_defconfig
mips                         tb0219_defconfig
powerpc                   microwatt_defconfig
powerpc                 mpc8272_ads_defconfig
arm                        spear3xx_defconfig
arm                        mvebu_v5_defconfig
mips                   sb1250_swarm_defconfig
x86_64                        randconfig-k001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r041-20220724
hexagon              randconfig-r045-20220724

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
