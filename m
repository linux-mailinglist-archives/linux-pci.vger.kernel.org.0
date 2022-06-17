Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1431E54F0B1
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jun 2022 07:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379864AbiFQFno (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jun 2022 01:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380224AbiFQFne (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2022 01:43:34 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0472D1F5
        for <linux-pci@vger.kernel.org>; Thu, 16 Jun 2022 22:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655444611; x=1686980611;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=yEBnT5yp+jSZWW7Xmk8oKKnFJclf3GX8f7tdx8OY2vs=;
  b=Yl0yPrNyIHeFCBvqfCRm8Dc0K8qLPVZdfxOcJ70anckl/0KyIxRjznxE
   a2Gc7YFyobB9pvg4yiHeH9A9eeA01IpTOtwVog+WivEyW8Xu9IxF5JLYs
   Mlv40jvJu6p1dL90Izu3Jgq6NBzldXR3L7iFQCZ5nOrVPhrxmlGvRqIXV
   Bo1OqaetkmazJ+NnxiGTho7iLJI6namDSI4Wj5pI/AvrlKS/gCHr165RG
   dRycCFnqm4OT6uMBG0ovKWj23v3/qnBb+I077/Sbcx9Fmm9FoQwFkFWMv
   OAgKNlzcKzCJg2MgXhAjAlbntwIenV0sl16N310+n03htMHNvDxZXLCkC
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="268114497"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="268114497"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 22:43:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="653484738"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 16 Jun 2022 22:43:28 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o24lU-000P7R-BO;
        Fri, 17 Jun 2022 05:43:28 +0000
Date:   Fri, 17 Jun 2022 13:43:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/edma] BUILD SUCCESS
 7871514c9cff8a4356250355c1032e0d94c61511
Message-ID: <62ac146f.2ryMlczvUpYmcMFJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/edma
branch HEAD: 7871514c9cff8a4356250355c1032e0d94c61511  PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities

elapsed time: 720m

configs tested: 133
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc                 mpc85xx_cds_defconfig
s390                          debug_defconfig
m68k                          amiga_defconfig
mips                  maltasmvp_eva_defconfig
microblaze                          defconfig
powerpc                 mpc834x_itx_defconfig
sh                             sh03_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                          pxa910_defconfig
sh                      rts7751r2d1_defconfig
sh                         microdev_defconfig
parisc64                         alldefconfig
ia64                        generic_defconfig
mips                           xway_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                           sama5_defconfig
m68k                        stmark2_defconfig
powerpc                      ppc40x_defconfig
sh                            hp6xx_defconfig
xtensa                  nommu_kc705_defconfig
mips                             allmodconfig
xtensa                  cadence_csp_defconfig
mips                  decstation_64_defconfig
arc                    vdk_hs38_smp_defconfig
parisc                generic-64bit_defconfig
sh                   sh7770_generic_defconfig
mips                         cobalt_defconfig
sh                          urquell_defconfig
s390                                defconfig
m68k                          hp300_defconfig
arc                        vdk_hs38_defconfig
powerpc                      pcm030_defconfig
powerpc                    klondike_defconfig
m68k                        m5407c3_defconfig
arc                           tb10x_defconfig
arm                        realview_defconfig
sh                             espt_defconfig
sh                     sh7710voipgw_defconfig
arm                        mvebu_v7_defconfig
arc                            hsdk_defconfig
sh                   sh7724_generic_defconfig
sh                              ul2_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                      maltasmvp_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220617
arc                  randconfig-r043-20220617
s390                 randconfig-r044-20220617
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                           sama7_defconfig
mips                      malta_kvm_defconfig
arm                      pxa255-idp_defconfig
riscv                             allnoconfig
arm                          collie_defconfig
mips                         tb0287_defconfig
powerpc                     ppa8548_defconfig
arm                        multi_v5_defconfig
arm                          ep93xx_defconfig
arm                        mvebu_v5_defconfig
powerpc                     tqm5200_defconfig
arm                          moxart_defconfig
arm                         s5pv210_defconfig
hexagon                             defconfig
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
riscv                randconfig-r042-20220616
hexagon              randconfig-r041-20220616
hexagon              randconfig-r045-20220616
s390                 randconfig-r044-20220616

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
