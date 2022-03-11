Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D0E4D5C10
	for <lists+linux-pci@lfdr.de>; Fri, 11 Mar 2022 08:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbiCKHOk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Mar 2022 02:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343834AbiCKHOj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Mar 2022 02:14:39 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E564E114FF1
        for <linux-pci@vger.kernel.org>; Thu, 10 Mar 2022 23:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646982815; x=1678518815;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=a4s3TRiQEVTKweymue/FyWu27/VFomsgRNc5KO6QaF8=;
  b=loD3su4atI1FW0V/nnCwmeiH2gM6KOfp/+s7ipcqUavXjssoWvOGVHEE
   +Mcxz+TBMwi7gH7ZeNHrxFD7ZI1mFWc2Q5+ma7vqI8JAv8UwK77YrffWA
   XX47VttDME2WiWRzhAxLnrF+TlrFl0TBDJTheElqFQ/ViLwMfaZmEZBhN
   2JTY1IUfYRQu7GqCAezYxY+ruCUBYipiWTr2hd3ciCqBdgMisaKd6/IWC
   qYISKftDs7HFp10J8oxBDVAigeMdDiskuJbIVV03gqVP2Pq8a4wKRvmwu
   vF8Li+uItPf8buEtN2ahq0cZnpx+r6+IA/d4U6T/q1vFAospdCIFViPFg
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="242965499"
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="242965499"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 23:13:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="496678078"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 10 Mar 2022 23:13:34 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSZSv-00061G-LP; Fri, 11 Mar 2022 07:13:33 +0000
Date:   Fri, 11 Mar 2022 15:12:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/host/rcar] BUILD SUCCESS
 e14f0af749b9e786ad39af1470036b0a515cd8a5
Message-ID: <622af672.oYMxslm+XuJXYn67%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/host/rcar
branch HEAD: e14f0af749b9e786ad39af1470036b0a515cd8a5  PCI: rcar: Finish transition to L1 state in rcar_pcie_config_access()

elapsed time: 724m

configs tested: 135
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
arm                         cm_x300_defconfig
arm                     eseries_pxa_defconfig
sh                   sh7770_generic_defconfig
powerpc                     tqm8548_defconfig
mips                  maltasmvp_eva_defconfig
sh                             sh03_defconfig
powerpc                     ep8248e_defconfig
xtensa                          iss_defconfig
xtensa                         virt_defconfig
sh                          rsk7203_defconfig
m68k                       m5208evb_defconfig
sh                            shmin_defconfig
arc                    vdk_hs38_smp_defconfig
openrisc                 simple_smp_defconfig
arm                            mps2_defconfig
h8300                     edosk2674_defconfig
sh                           se7722_defconfig
arc                     haps_hs_smp_defconfig
sparc                       sparc64_defconfig
sh                           se7750_defconfig
arm                        shmobile_defconfig
arm                          badge4_defconfig
sh                               j2_defconfig
arm                           tegra_defconfig
arc                        nsim_700_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                 canyonlands_defconfig
sh                        edosk7705_defconfig
sh                           se7206_defconfig
arm                            lart_defconfig
sh                               allmodconfig
arc                          axs103_defconfig
mips                       capcella_defconfig
arm                         vf610m4_defconfig
arm                          lpd270_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                         db1xxx_defconfig
arm                          pxa3xx_defconfig
openrisc                         alldefconfig
powerpc                       holly_defconfig
powerpc                 mpc837x_mds_defconfig
arm                         s3c6400_defconfig
arm                        keystone_defconfig
h8300                    h8300h-sim_defconfig
ia64                                defconfig
arm                  randconfig-c002-20220310
ia64                             allmodconfig
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
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arc                  randconfig-r043-20220310
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
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220310
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220310
riscv                randconfig-c006-20220310
mips                 randconfig-c004-20220310
i386                          randconfig-c001
arm                      tct_hammer_defconfig
arm                             mxs_defconfig
powerpc                          g5_defconfig
powerpc                     tqm8540_defconfig
mips                       lemote2f_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                  mpc866_ads_defconfig
arm                       cns3420vb_defconfig
x86_64                           allyesconfig
arm                    vt8500_v6_v7_defconfig
hexagon                          alldefconfig
arm                         orion5x_defconfig
powerpc                     ppa8548_defconfig
powerpc                 mpc8313_rdb_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220310
hexagon              randconfig-r041-20220310
riscv                randconfig-r042-20220310
s390                 randconfig-r044-20220310

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
