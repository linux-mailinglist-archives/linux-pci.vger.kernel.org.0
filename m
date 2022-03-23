Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970BF4E5499
	for <lists+linux-pci@lfdr.de>; Wed, 23 Mar 2022 15:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbiCWOyK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Mar 2022 10:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244898AbiCWOyJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Mar 2022 10:54:09 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FA482317
        for <linux-pci@vger.kernel.org>; Wed, 23 Mar 2022 07:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648047159; x=1679583159;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=eToq/4IyivfASk0w1yFvHyOKQjseEZtH6cNmQ0fsrzw=;
  b=gra6xzl3mavlzvz4m1fdNnhM1dIzdCiGpoSBuFhL75/M4GU3xe/EurMp
   BRisHg426yfI5zQiUIV6F9Xk9n8Ht9w11roEv7XeqHeC1X+UcIOicBVku
   WNAGFaQfAIVervodV0lvmpZSUf1HefWhY91aNaqSVVxzQDcsebng5zroE
   0oG5Q3gfOKwsvU9azLTtUadYj0bVzSiyHKx65l5Ffnc50dgZZBvsg5ynF
   Ql75o758kHHJLw1CVhUbVWduGTPCgH85EfFV8bG033Q7uQEttJdIczosd
   OT18P+Ekn+8bFmhJIK146EqDXxWlezX3KjcflBo9CAyoq1zz4DPfbAjrT
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="321323946"
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="321323946"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 07:52:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="519385484"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 23 Mar 2022 07:52:36 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nX2Lf-000K9L-S5; Wed, 23 Mar 2022 14:52:31 +0000
Date:   Wed, 23 Mar 2022 22:51:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 611f841830aa5723ea67682628bd214cbc18df41
Message-ID: <623b33f3.V4S4G3VttsRk5NFQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 611f841830aa5723ea67682628bd214cbc18df41  Merge branch 'remotes/lorenzo/pci/xgene'

elapsed time: 729m

configs tested: 158
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
mips                 randconfig-c004-20220323
m68k                            mac_defconfig
ia64                            zx1_defconfig
arm                      integrator_defconfig
arm                            mps2_defconfig
sh                           se7750_defconfig
mips                      fuloong2e_defconfig
powerpc                     stx_gp3_defconfig
powerpc                      pasemi_defconfig
arm                           h3600_defconfig
sh                   sh7770_generic_defconfig
sh                            hp6xx_defconfig
xtensa                         virt_defconfig
h8300                            alldefconfig
arm                       omap2plus_defconfig
alpha                               defconfig
powerpc                     tqm8548_defconfig
ia64                             alldefconfig
powerpc                     pq2fads_defconfig
arc                     haps_hs_smp_defconfig
m68k                       m5475evb_defconfig
arm                            xcep_defconfig
sparc64                          alldefconfig
powerpc                        warp_defconfig
xtensa                              defconfig
mips                      loongson3_defconfig
arm                        oxnas_v6_defconfig
s390                       zfcpdump_defconfig
powerpc                      tqm8xx_defconfig
s390                          debug_defconfig
sh                           se7751_defconfig
sh                      rts7751r2d1_defconfig
sh                             sh03_defconfig
m68k                        mvme16x_defconfig
s390                             allmodconfig
sh                   sh7724_generic_defconfig
sh                               allmodconfig
arm                            pleb_defconfig
sparc                       sparc32_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                     redwood_defconfig
mips                            ar7_defconfig
mips                       capcella_defconfig
powerpc                   currituck_defconfig
sh                          rsk7264_defconfig
sh                          sdk7780_defconfig
arm                           u8500_defconfig
sh                   rts7751r2dplus_defconfig
arc                          axs101_defconfig
m68k                         apollo_defconfig
powerpc                 linkstation_defconfig
arm                        realview_defconfig
powerpc                  iss476-smp_defconfig
powerpc                     tqm8555_defconfig
arm                          pxa910_defconfig
sh                         ecovec24_defconfig
arm                         axm55xx_defconfig
arm                          badge4_defconfig
sh                         apsh4a3a_defconfig
xtensa                    smp_lx200_defconfig
mips                       bmips_be_defconfig
arm                      jornada720_defconfig
csky                                defconfig
sh                             espt_defconfig
mips                             allmodconfig
arm                       aspeed_g5_defconfig
m68k                       m5249evb_defconfig
arm                         assabet_defconfig
um                               alldefconfig
mips                           jazz_defconfig
powerpc                     rainier_defconfig
sh                           se7780_defconfig
sh                          landisk_defconfig
arm                        spear6xx_defconfig
sh                   secureedge5410_defconfig
alpha                            alldefconfig
m68k                        mvme147_defconfig
arm                             rpc_defconfig
riscv                               defconfig
sh                          urquell_defconfig
sh                        dreamcast_defconfig
h8300                               defconfig
arm                  randconfig-c002-20220323
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
alpha                            allyesconfig
nds32                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allyesconfig
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
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
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
mips                 randconfig-c004-20220323
arm                  randconfig-c002-20220323
powerpc              randconfig-c003-20220323
riscv                randconfig-c006-20220323
i386                          randconfig-c001
arm                     davinci_all_defconfig
arm                       imx_v4_v5_defconfig
powerpc                   lite5200b_defconfig
arm                   milbeaut_m10v_defconfig
mips                            e55_defconfig
arm                              alldefconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
