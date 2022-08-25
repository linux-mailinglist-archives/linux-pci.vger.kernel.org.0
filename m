Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C805A0718
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 04:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiHYCGL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Aug 2022 22:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbiHYCGI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Aug 2022 22:06:08 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133FB3054A
        for <linux-pci@vger.kernel.org>; Wed, 24 Aug 2022 19:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661393168; x=1692929168;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/es6OYbyFYmEI9+45YOGEAjNABtqL3uFz8MXBBeaGEA=;
  b=PpGSLCxtfLwHjhwhG5cr73IdquFNDBHd+b1wOwBgPrr3OYvqCrvlPw/z
   AtrK9weSe40hBX7gk0oXoyB0QIx9gcjOK1q6YnMScNeR0w0UluNl4fMWJ
   VueYegHbRJ9ZMxUZ+WSeo4dWxD9PjdbTT3tYd+mH75JhOJY+38uEB8jjg
   aKzspa16VsKl+7qszDKmlAWDlkzRoWohRRIGuRcPjh1fZHAJLEWOu2SQV
   MvGNqe3tKlflIxl7krEmffQdvT/OAThM7EdaZO9K4UbNpbaXIAl0MEWX4
   FFtR5/5hGiVZM2zsC3W1tpQ5RNv8jqAFaRp8DFlBk05F2CJ56AlhIrlkD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="277144966"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="277144966"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 19:06:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="560834831"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 24 Aug 2022 19:06:05 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oR2Fx-0001bV-0a;
        Thu, 25 Aug 2022 02:06:05 +0000
Date:   Thu, 25 Aug 2022 10:05:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/qcom] BUILD SUCCESS
 d6cbfcd24443e51fb596fdbf25679d61052a3f84
Message-ID: <6306d8ff.ijmeAtVTbRWy9UGo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/qcom
branch HEAD: d6cbfcd24443e51fb596fdbf25679d61052a3f84  PCI: qcom: Sort device-id table

elapsed time: 2539m

configs tested: 194
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                        randconfig-a004
um                             i386_defconfig
x86_64                        randconfig-a002
powerpc                           allnoconfig
um                           x86_64_defconfig
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                        randconfig-a006
sh                               allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
i386                          randconfig-a014
m68k                             allmodconfig
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                                defconfig
ia64                             allmodconfig
i386                             allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
loongarch                           defconfig
loongarch                         allnoconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arm                            hisi_defconfig
um                                  defconfig
sh                     sh7710voipgw_defconfig
parisc64                         alldefconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
arm                       omap2plus_defconfig
arc                          axs101_defconfig
arc                         haps_hs_defconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
ia64                         bigsur_defconfig
m68k                        m5272c3_defconfig
parisc                           alldefconfig
powerpc                     tqm8555_defconfig
sh                        sh7763rdp_defconfig
m68k                          multi_defconfig
arc                      axs103_smp_defconfig
m68k                            mac_defconfig
sh                               j2_defconfig
sh                           se7721_defconfig
m68k                          amiga_defconfig
sh                          kfr2r09_defconfig
xtensa                          iss_defconfig
m68k                         apollo_defconfig
sh                          sdk7786_defconfig
arm                        shmobile_defconfig
sh                             shx3_defconfig
powerpc                      tqm8xx_defconfig
ia64                                defconfig
m68k                        stmark2_defconfig
i386                          randconfig-c001
m68k                            q40_defconfig
ia64                        generic_defconfig
arc                     nsimosci_hs_defconfig
sh                           se7724_defconfig
arm                         lubbock_defconfig
powerpc                   currituck_defconfig
arc                        nsim_700_defconfig
sh                   sh7770_generic_defconfig
arm                          gemini_defconfig
m68k                          atari_defconfig
powerpc                    klondike_defconfig
sparc                             allnoconfig
microblaze                          defconfig
m68k                        mvme16x_defconfig
arm                           h5000_defconfig
arm64                               defconfig
arm                              allmodconfig
m68k                                defconfig
mips                             allmodconfig
sh                        apsh4ad0a_defconfig
powerpc                   motionpro_defconfig
arm                          exynos_defconfig
ia64                          tiger_defconfig
mips                      loongson3_defconfig
arm                             rpc_defconfig
arm                            lart_defconfig
m68k                       m5249evb_defconfig
sh                             espt_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220824
microblaze                      mmu_defconfig
arm                        realview_defconfig
sh                          r7780mp_defconfig
sh                        edosk7760_defconfig
sh                           se7751_defconfig
powerpc                      arches_defconfig
arm                            zeus_defconfig
s390                          debug_defconfig
ia64                            zx1_defconfig
powerpc                      pcm030_defconfig
arc                    vdk_hs38_smp_defconfig
sh                          rsk7269_defconfig
xtensa                         virt_defconfig
sh                   sh7724_generic_defconfig
powerpc                      makalu_defconfig
arm                            pleb_defconfig
mips                        bcm47xx_defconfig
csky                             alldefconfig
ia64                      gensparse_defconfig
arm                      integrator_defconfig
sh                         apsh4a3a_defconfig
sh                           se7722_defconfig
arm                           viper_defconfig
riscv                randconfig-r042-20220824
s390                 randconfig-r044-20220824
arc                  randconfig-r043-20220824
sh                   secureedge5410_defconfig
sh                         ap325rxa_defconfig
xtensa                    smp_lx200_defconfig
sh                      rts7751r2d1_defconfig
sh                            titan_defconfig
mips                         cobalt_defconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220823
riscv                randconfig-r042-20220823
hexagon              randconfig-r041-20220823
s390                 randconfig-r044-20220823
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
mips                     cu1000-neo_defconfig
powerpc                    gamecube_defconfig
arm                            mmp2_defconfig
powerpc                     powernv_defconfig
x86_64                        randconfig-k001
mips                     loongson1c_defconfig
powerpc                     ppa8548_defconfig
powerpc                  mpc866_ads_defconfig
hexagon              randconfig-r045-20220824
hexagon              randconfig-r041-20220824
mips                        omega2p_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                        neponset_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                          g5_defconfig
mips                     decstation_defconfig
mips                           ci20_defconfig
riscv                            alldefconfig
powerpc                      ppc64e_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                     tqm8540_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
