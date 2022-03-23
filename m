Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725594E4C5F
	for <lists+linux-pci@lfdr.de>; Wed, 23 Mar 2022 06:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240217AbiCWFmu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Mar 2022 01:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiCWFmt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Mar 2022 01:42:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0AF70F74
        for <linux-pci@vger.kernel.org>; Tue, 22 Mar 2022 22:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648014081; x=1679550081;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=LzaizxuUa+yjd5DuyimFWi/6QzFW0LbMeK9SZpfwVio=;
  b=BYrfqm/u5HjoUim03h/2Fe6dXG+PYtTSHIGenuZAGMOY8IVuEKVJQ8LQ
   ou7F2u7CBi926u49xvs1wBs2hGjctwnYiayXC01DIBO2Zf/5UgPemExcv
   3OEUExlabUUFPdiMS1QpPoHq54YZNs+SjKpn8hsjBF571NOSD0lLfSbnI
   BKNj6HWHQ1xcbu1fl0nPTi7641+JFn7kGuNm9tRwEr8mGZapu9PYD5kj9
   deGzyJf+nHzBbsLZBdAwip0qcCue7K8NfJPAsYr+ZeYaKpuqIqfvTDi4Q
   vguMHZXxD6QaUVDQ3kYFu8of+f5+NjD+9Kh6lEdklkGBH35axNT5TZKeB
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="237969068"
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="237969068"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 22:41:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="519223676"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 22 Mar 2022 22:41:19 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWtkE-000Jhg-GI; Wed, 23 Mar 2022 05:41:18 +0000
Date:   Wed, 23 Mar 2022 13:41:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/misc] BUILD SUCCESS
 b9fae6a47b8bcb397e6a482095431f6ba9648211
Message-ID: <623ab2f2.ac2kKtoeweL3UioO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/misc
branch HEAD: b9fae6a47b8bcb397e6a482095431f6ba9648211  x86/PCI: Add #includes to asm/pci_x86.h

elapsed time: 723m

configs tested: 204
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
i386                 randconfig-c001-20220321
mips                 randconfig-c004-20220323
mips                 randconfig-c004-20220320
arm                        shmobile_defconfig
ia64                          tiger_defconfig
ia64                         bigsur_defconfig
m68k                            mac_defconfig
ia64                            zx1_defconfig
arm                      integrator_defconfig
arm                            mps2_defconfig
sh                          polaris_defconfig
i386                                defconfig
sh                          rsk7201_defconfig
sh                           se7750_defconfig
mips                      fuloong2e_defconfig
powerpc                     stx_gp3_defconfig
sh                 kfr2r09-romimage_defconfig
arm                        keystone_defconfig
mips                      loongson3_defconfig
powerpc                      makalu_defconfig
arm                         at91_dt_defconfig
arm                       omap2plus_defconfig
alpha                               defconfig
powerpc                     tqm8548_defconfig
ia64                             alldefconfig
m68k                          sun3x_defconfig
powerpc                     taishan_defconfig
h8300                            allyesconfig
arc                          axs101_defconfig
mips                     decstation_defconfig
mips                         tb0226_defconfig
powerpc                 canyonlands_defconfig
sh                            hp6xx_defconfig
mips                      maltasmvp_defconfig
arc                              allyesconfig
powerpc64                           defconfig
powerpc                     asp8347_defconfig
arc                     nsimosci_hs_defconfig
powerpc                   motionpro_defconfig
sh                        sh7763rdp_defconfig
mips                       capcella_defconfig
sh                          rsk7264_defconfig
m68k                         apollo_defconfig
powerpc                 linkstation_defconfig
arm                        realview_defconfig
powerpc                  iss476-smp_defconfig
powerpc                       maple_defconfig
arm                        clps711x_defconfig
arm                            qcom_defconfig
arc                      axs103_smp_defconfig
xtensa                          iss_defconfig
powerpc                      ppc40x_defconfig
openrisc                  or1klitex_defconfig
mips                     loongson1b_defconfig
arm                            hisi_defconfig
arm                          iop32x_defconfig
openrisc                         alldefconfig
arm                     eseries_pxa_defconfig
powerpc                    klondike_defconfig
arm                           u8500_defconfig
nios2                         3c120_defconfig
arm                         lpc18xx_defconfig
sparc                            alldefconfig
h8300                               defconfig
arm                         nhk8815_defconfig
arm                         s3c6400_defconfig
powerpc                  storcenter_defconfig
um                                  defconfig
sh                        sh7785lcr_defconfig
sh                             espt_defconfig
mips                             allmodconfig
arc                        nsimosci_defconfig
m68k                        mvme147_defconfig
sh                          rsk7203_defconfig
mips                         db1xxx_defconfig
parisc                generic-32bit_defconfig
mips                           xway_defconfig
parisc                generic-64bit_defconfig
arm                           viper_defconfig
powerpc                    sam440ep_defconfig
sh                                  defconfig
xtensa                       common_defconfig
sh                           se7619_defconfig
arm                             rpc_defconfig
powerpc                        warp_defconfig
sh                  sh7785lcr_32bit_defconfig
riscv                               defconfig
arm                  randconfig-c002-20220321
arm                  randconfig-c002-20220320
arm                  randconfig-c002-20220322
arm                  randconfig-c002-20220323
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64               randconfig-a016-20220321
x86_64               randconfig-a011-20220321
x86_64               randconfig-a012-20220321
x86_64               randconfig-a013-20220321
x86_64               randconfig-a014-20220321
x86_64               randconfig-a015-20220321
i386                 randconfig-a015-20220321
i386                 randconfig-a016-20220321
i386                 randconfig-a013-20220321
i386                 randconfig-a012-20220321
i386                 randconfig-a014-20220321
i386                 randconfig-a011-20220321
riscv                randconfig-r042-20220323
s390                 randconfig-r044-20220323
arc                  randconfig-r043-20220323
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
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
mips                 randconfig-c004-20220320
arm                  randconfig-c002-20220320
powerpc              randconfig-c003-20220320
riscv                randconfig-c006-20220320
i386                          randconfig-c001
mips                 randconfig-c004-20220323
arm                  randconfig-c002-20220323
powerpc              randconfig-c003-20220323
riscv                randconfig-c006-20220323
powerpc                     mpc5200_defconfig
arm                         orion5x_defconfig
mips                           ip27_defconfig
powerpc                    gamecube_defconfig
arm                         bcm2835_defconfig
arm                   milbeaut_m10v_defconfig
mips                        omega2p_defconfig
arm                        vexpress_defconfig
arm                         palmz72_defconfig
mips                       rbtx49xx_defconfig
x86_64               randconfig-a001-20220321
x86_64               randconfig-a003-20220321
x86_64               randconfig-a005-20220321
x86_64               randconfig-a004-20220321
x86_64               randconfig-a002-20220321
x86_64               randconfig-a006-20220321
i386                 randconfig-a001-20220321
i386                 randconfig-a006-20220321
i386                 randconfig-a003-20220321
i386                 randconfig-a005-20220321
i386                 randconfig-a004-20220321
i386                 randconfig-a002-20220321
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
riscv                randconfig-r042-20220320
hexagon              randconfig-r045-20220321
hexagon              randconfig-r045-20220320
hexagon              randconfig-r041-20220321
hexagon              randconfig-r041-20220320
riscv                randconfig-r042-20220322
hexagon              randconfig-r045-20220322
hexagon              randconfig-r041-20220322

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
