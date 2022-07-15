Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBD2576515
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 18:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiGOQEy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 12:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiGOQEy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 12:04:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6243443322
        for <linux-pci@vger.kernel.org>; Fri, 15 Jul 2022 09:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657901093; x=1689437093;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ZA9pEQoBtFoYG8q2j1IACdXszy5e0gBbgCJoO7SJIyE=;
  b=n6JAxlFbQarwSPT8NaNDr+SvL9j/S7FagcKJZQIyu7wYNGv76Hf806Lc
   Q2Sx5pnoskvaOHbvG6M8ghmD/q1D0GO5Xx0zJ42Dn9Zd2lCS0LeveV78p
   SGV/NbGtoDhAZrwKa5kZVsqqYQoQB0Hdd3AbNPXavHCChag3PcDfylcEL
   24cr43UUD6YO4RgjKjrbl8Y69fXrsRgeY0NG815gCfPaG3je9u0iJtuuK
   P/2dIDDwNuDV7AonO+WNtVidl0rcGfVAnpJnAWZ773h9WfYtD1F1CiyRs
   jRNg3CZWaX7fLvYVqDpVOCiERnoodOYqunK+ohqfogCGyjVNSqTJxgcKt
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="284588982"
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="284588982"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 09:04:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="571569273"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Jul 2022 09:04:33 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCNnt-0000Ol-9L;
        Fri, 15 Jul 2022 16:04:33 +0000
Date:   Sat, 16 Jul 2022 00:04:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/ctrl/dwc] BUILD SUCCESS
 908903ae8701a0b73cfa71ef203feb6e9261dcf4
Message-ID: <62d1900e.hXUwQ/b6MySZplem%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ctrl/dwc
branch HEAD: 908903ae8701a0b73cfa71ef203feb6e9261dcf4  PCI: dwc: Use the bitmap API to allocate bitmaps

elapsed time: 4036m

configs tested: 153
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
sh                         apsh4a3a_defconfig
sh                           se7751_defconfig
arm                         nhk8815_defconfig
sparc                             allnoconfig
arm                           h3600_defconfig
mips                         cobalt_defconfig
sh                        sh7785lcr_defconfig
arm64                            alldefconfig
nios2                         3c120_defconfig
m68k                       m5275evb_defconfig
arm                        oxnas_v6_defconfig
arm                        clps711x_defconfig
powerpc                      pcm030_defconfig
m68k                          atari_defconfig
arc                          axs103_defconfig
powerpc                     pq2fads_defconfig
arm                             ezx_defconfig
arc                 nsimosci_hs_smp_defconfig
csky                              allnoconfig
xtensa                  nommu_kc705_defconfig
sh                 kfr2r09-romimage_defconfig
sh                             sh03_defconfig
m68k                        m5272c3_defconfig
arc                                 defconfig
arm                         at91_dt_defconfig
nios2                            allyesconfig
alpha                             allnoconfig
sh                           se7343_defconfig
sh                             espt_defconfig
powerpc                 mpc8540_ads_defconfig
arm                           viper_defconfig
sh                        edosk7705_defconfig
arc                              alldefconfig
powerpc                  iss476-smp_defconfig
mips                         bigsur_defconfig
powerpc                         wii_defconfig
mips                      loongson3_defconfig
sparc                       sparc64_defconfig
sparc64                          alldefconfig
powerpc                     redwood_defconfig
arm                       aspeed_g5_defconfig
sh                               alldefconfig
openrisc                            defconfig
x86_64                                  kexec
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220715
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
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                        randconfig-a013
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                          ath79_defconfig
arm                            dove_defconfig
arm                      tct_hammer_defconfig
powerpc                 mpc836x_mds_defconfig
arm                           spitz_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                       versatile_defconfig
arm                        mvebu_v5_defconfig
mips                     cu1830-neo_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                     tqm8560_defconfig
arm                      pxa255-idp_defconfig
mips                        workpad_defconfig
arm                       imx_v4_v5_defconfig
powerpc                          g5_defconfig
powerpc                    gamecube_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                    mvme5100_defconfig
arm                        vexpress_defconfig
arm                   milbeaut_m10v_defconfig
s390                             alldefconfig
powerpc                   lite5200b_defconfig
arm                          pcm027_defconfig
arm                       cns3420vb_defconfig
mips                      malta_kvm_defconfig
powerpc                        fsp2_defconfig
hexagon                             defconfig
powerpc                      ppc44x_defconfig
mips                           ip28_defconfig
powerpc                   bluestone_defconfig
powerpc                     ppa8548_defconfig
powerpc                     kilauea_defconfig
powerpc                          allyesconfig
mips                       rbtx49xx_defconfig
mips                        omega2p_defconfig
arm                          moxart_defconfig
powerpc                     mpc512x_defconfig
mips                     cu1000-neo_defconfig
arm                         orion5x_defconfig
powerpc                      pmac32_defconfig
arm                         socfpga_defconfig
riscv                            alldefconfig
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
hexagon              randconfig-r045-20220714
hexagon              randconfig-r041-20220714
hexagon              randconfig-r045-20220715
s390                 randconfig-r044-20220715
hexagon              randconfig-r041-20220715
riscv                randconfig-r042-20220715

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
