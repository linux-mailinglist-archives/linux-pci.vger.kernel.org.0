Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CD7603430
	for <lists+linux-pci@lfdr.de>; Tue, 18 Oct 2022 22:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiJRUrB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Oct 2022 16:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiJRUrA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Oct 2022 16:47:00 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515D374E11
        for <linux-pci@vger.kernel.org>; Tue, 18 Oct 2022 13:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666126019; x=1697662019;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=7GEEYRZsjbcyONvntFdbmM6sXC2G+jbq43//4rJYw5U=;
  b=fwgu1Q9edV3KTcklUkMaRAlakk92OkN9b7LN8iCofRlYNdaJIYOvV5L0
   mKEJLaeaPEBQaBgHQBw9f2ghnKMlLU/suxJyfLQNjLv1TlYXuBo2Qj536
   +BAQWeLIUC8JALy9S6AqH8JI2P0YnfOszmPw3Ew4wMVyvidWqTY557ghy
   TY+TSq/gNMYvirMWw/uctCBYO916eB2ylb0FtFRpNdIXoUzTnrCdfVEU6
   WFtAqNxyvLVklbzXJoB7M0tfKHDLnGPJXb3U7kj8JahVlEFizFZWnOhxS
   rrJJ/jmZ3Gs4aS2oLXHB6HqXjYCdRzD14d18mva6p9Oxsj4HaHuxMcMAv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="303847366"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="303847366"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 13:46:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="631318802"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="631318802"
Received: from lkp-server01.sh.intel.com (HELO 8381f64adc98) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 18 Oct 2022 13:46:57 -0700
Received: from kbuild by 8381f64adc98 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oktUG-00020f-2T;
        Tue, 18 Oct 2022 20:46:56 +0000
Date:   Wed, 19 Oct 2022 04:45:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:for-linus] BUILD SUCCESS
 897a66d281983c4fe2b805f26b315309b35fb028
Message-ID: <634f1084.ugBBS4jqzdWaI86B%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
branch HEAD: 897a66d281983c4fe2b805f26b315309b35fb028  Revert "PCI: tegra: Use PCI_CONF1_EXT_ADDRESS() macro"

elapsed time: 1590m

configs tested: 239
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20221018
riscv                randconfig-r042-20221018
s390                 randconfig-r044-20221018
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
x86_64               randconfig-a002-20221017
i386                 randconfig-a004-20221017
i386                 randconfig-a001-20221017
x86_64               randconfig-a003-20221017
i386                 randconfig-a002-20221017
x86_64               randconfig-a005-20221017
arc                  randconfig-r043-20221017
i386                 randconfig-a003-20221017
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
x86_64               randconfig-a004-20221017
i386                 randconfig-a005-20221017
x86_64               randconfig-a001-20221017
x86_64               randconfig-a006-20221017
i386                 randconfig-a006-20221017
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
m68k                         amcore_defconfig
mips                           ci20_defconfig
powerpc                      makalu_defconfig
m68k                             alldefconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                             allyesconfig
i386                                defconfig
m68k                          hp300_defconfig
sh                           se7751_defconfig
sh                          rsk7203_defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                    adder875_defconfig
parisc                           alldefconfig
nios2                               defconfig
mips                        vocore2_defconfig
i386                 randconfig-c001-20221017
powerpc                 mpc8540_ads_defconfig
sh                          kfr2r09_defconfig
powerpc                 linkstation_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
m68k                       m5208evb_defconfig
mips                     decstation_defconfig
mips                        bcm47xx_defconfig
m68k                            q40_defconfig
arc                     haps_hs_smp_defconfig
sh                           se7705_defconfig
arm                        keystone_defconfig
powerpc                        cell_defconfig
parisc                generic-32bit_defconfig
riscv             nommu_k210_sdcard_defconfig
arc                        vdk_hs38_defconfig
arm                           h3600_defconfig
riscv                               defconfig
arm                             ezx_defconfig
powerpc                     mpc83xx_defconfig
arm                            lart_defconfig
sh                        edosk7760_defconfig
sh                             shx3_defconfig
parisc                generic-64bit_defconfig
powerpc                     taishan_defconfig
arc                           tb10x_defconfig
m68k                       bvme6000_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                          iop32x_defconfig
openrisc                  or1klitex_defconfig
sh                              ul2_defconfig
powerpc                  storcenter_defconfig
mips                             allmodconfig
sparc                       sparc32_defconfig
sparc                       sparc64_defconfig
arm                       aspeed_g5_defconfig
arm64                            alldefconfig
sh                           se7724_defconfig
powerpc                      ppc6xx_defconfig
csky                              allnoconfig
loongarch                         allnoconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
powerpc                  iss476-smp_defconfig
sh                            hp6xx_defconfig
powerpc                      chrp32_defconfig
arm                       imx_v6_v7_defconfig
m68k                          amiga_defconfig
m68k                        m5307c3_defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
arm                         lpc18xx_defconfig
powerpc                 mpc85xx_cds_defconfig
ia64                                defconfig
ia64                          tiger_defconfig
alpha                            alldefconfig
mips                     loongson1b_defconfig
i386                          randconfig-c001
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
powerpc                      pcm030_defconfig
arm                        shmobile_defconfig
arc                            hsdk_defconfig
powerpc                 mpc837x_mds_defconfig
xtensa                    xip_kc705_defconfig
m68k                           sun3_defconfig
mips                           gcw0_defconfig
mips                      fuloong2e_defconfig
xtensa                  audio_kc705_defconfig
m68k                          atari_defconfig
openrisc                       virt_defconfig
sh                         ap325rxa_defconfig
xtensa                           allyesconfig
arm                          pxa3xx_defconfig
sh                          sdk7786_defconfig
powerpc                      arches_defconfig
sh                        dreamcast_defconfig
sh                                  defconfig
csky                                defconfig
m68k                                defconfig
powerpc                      ppc40x_defconfig
sparc64                             defconfig
sh                        sh7757lcr_defconfig
powerpc                         wii_defconfig
sh                   sh7770_generic_defconfig
arc                    vdk_hs38_smp_defconfig
arc                     nsimosci_hs_defconfig
arm                         at91_dt_defconfig
microblaze                      mmu_defconfig
sh                           se7343_defconfig
parisc                              defconfig
ia64                            zx1_defconfig
arm                        cerfcube_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                           jazz_defconfig
powerpc                     asp8347_defconfig
mips                  maltasmvp_eva_defconfig
m68k                       m5275evb_defconfig
powerpc                     pq2fads_defconfig
arm                         cm_x300_defconfig
loongarch                           defconfig
loongarch                        allmodconfig
sh                   sh7724_generic_defconfig
openrisc                 simple_smp_defconfig
arm                          gemini_defconfig
mips                            gpr_defconfig
sparc                             allnoconfig
powerpc                     tqm8541_defconfig
powerpc                     stx_gp3_defconfig
powerpc                   currituck_defconfig
powerpc                 mpc834x_mds_defconfig
arm                        trizeps4_defconfig
m68k                        mvme16x_defconfig
arm                        mvebu_v7_defconfig
openrisc                         alldefconfig
arm                      jornada720_defconfig
ia64                             allmodconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20221018

clang tested configs:
hexagon              randconfig-r041-20221018
hexagon              randconfig-r045-20221018
i386                 randconfig-a011-20221017
i386                 randconfig-a013-20221017
i386                 randconfig-a012-20221017
i386                 randconfig-a015-20221017
i386                 randconfig-a016-20221017
i386                 randconfig-a014-20221017
x86_64               randconfig-a014-20221017
x86_64               randconfig-a015-20221017
x86_64               randconfig-a012-20221017
x86_64               randconfig-a011-20221017
x86_64               randconfig-a013-20221017
x86_64               randconfig-a016-20221017
s390                 randconfig-r044-20221017
hexagon              randconfig-r045-20221017
riscv                randconfig-r042-20221017
hexagon              randconfig-r041-20221017
x86_64               randconfig-k001-20221017
arm                          collie_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
mips                 randconfig-c004-20221017
i386                 randconfig-c001-20221017
s390                 randconfig-c005-20221017
arm                  randconfig-c002-20221017
riscv                randconfig-c006-20221017
x86_64               randconfig-c007-20221017
powerpc              randconfig-c003-20221017
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
mips                        maltaup_defconfig
arm                         s3c2410_defconfig
x86_64                        randconfig-c007
mips                 randconfig-c004-20221018
i386                          randconfig-c001
s390                 randconfig-c005-20221018
arm                  randconfig-c002-20221018
riscv                randconfig-c006-20221018
powerpc              randconfig-c003-20221018
powerpc                 mpc832x_mds_defconfig
mips                           rs90_defconfig
mips                          rm200_defconfig
powerpc                      ppc44x_defconfig
riscv                             allnoconfig
powerpc                  mpc866_ads_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
arm                         socfpga_defconfig
arm                       mainstone_defconfig
arm                          sp7021_defconfig
powerpc                    mvme5100_defconfig
x86_64                        randconfig-k001
arm                      pxa255-idp_defconfig
mips                       lemote2f_defconfig
arm                      tct_hammer_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
