Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A826B57CCCA
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 16:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiGUOBf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 10:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiGUOBe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 10:01:34 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9CA3D5B3
        for <linux-pci@vger.kernel.org>; Thu, 21 Jul 2022 07:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658412093; x=1689948093;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+k1rwtGxJbPsnW7bAgdcnI+jwBwnI+hAMOd2jTGmiBA=;
  b=FsweIh0J8sUdYEPGiBPlBkNLke1IUX6/cncar+ViW93lyJ6ZSqTEyDdt
   uvMyfVMvZyWbY9u7+1P8MRYUrx276w7L7GEIxnz5x+JStS4ebGBFJttNo
   XRg43e7qaDKdFOkVQwLFMYv5E4IgDu1b7bENC90nqxhd3+9sOnDLeGTso
   KqABjdYL6qEKOoF/P1XH2+5w/0JFsFdSvXVHMS/DFvbP8eSIz28YGSeEt
   yT+oVp3yWiuVWPEMDTvftYOSPNz2CFL0mxEsmcalWnt/eLZ8r++r9pirt
   gap/bfdxXasNkRC62vAAMa/XX7O3vufBms/xt406ONQpzRHnrqEg2I2Jx
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="266827241"
X-IronPort-AV: E=Sophos;i="5.93,289,1654585200"; 
   d="scan'208";a="266827241"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 07:01:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,289,1654585200"; 
   d="scan'208";a="656755140"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jul 2022 07:01:32 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oEWk7-0000Bo-2S;
        Thu, 21 Jul 2022 14:01:31 +0000
Date:   Thu, 21 Jul 2022 22:01:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/ctrl/pm-ops] BUILD SUCCESS
 eae9b2dae6ce00b1fef77ca09f25e912fb556763
Message-ID: <62d95c27.Vw/CiR89qO3eDk5E%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ctrl/pm-ops
branch HEAD: eae9b2dae6ce00b1fef77ca09f25e912fb556763  PCI: Convert to new *_PM_OPS macros

elapsed time: 980m

configs tested: 123
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm                        spear6xx_defconfig
arm                          pxa910_defconfig
mips                        vocore2_defconfig
arm                      integrator_defconfig
arm                        keystone_defconfig
arc                          axs101_defconfig
xtensa                  audio_kc705_defconfig
powerpc                    adder875_defconfig
mips                         bigsur_defconfig
csky                              allnoconfig
um                             i386_defconfig
mips                           ci20_defconfig
arm                          lpd270_defconfig
arm                        mvebu_v7_defconfig
m68k                           virt_defconfig
sh                           se7206_defconfig
sh                             shx3_defconfig
sh                                  defconfig
powerpc                     rainier_defconfig
powerpc                        cell_defconfig
nios2                               defconfig
openrisc                 simple_smp_defconfig
xtensa                    smp_lx200_defconfig
sh                         microdev_defconfig
mips                          rb532_defconfig
parisc                           allyesconfig
arm                            hisi_defconfig
sh                           se7724_defconfig
arm                       aspeed_g5_defconfig
arm                            zeus_defconfig
powerpc                     tqm8548_defconfig
sparc                             allnoconfig
arm                        mini2440_defconfig
arc                        nsimosci_defconfig
mips                  maltasmvp_eva_defconfig
sh                   secureedge5410_defconfig
m68k                        mvme147_defconfig
nios2                         10m50_defconfig
xtensa                              defconfig
m68k                            mac_defconfig
arm                           viper_defconfig
powerpc                      ep88xc_defconfig
powerpc                      pcm030_defconfig
ia64                         bigsur_defconfig
arm                          exynos_defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
nios2                            allyesconfig
parisc                              defconfig
parisc64                            defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
loongarch                           defconfig
loongarch                         allnoconfig
arm                  randconfig-c002-20220718
i386                 randconfig-c001-20220718
x86_64               randconfig-c001-20220718
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
x86_64               randconfig-a012-20220718
x86_64               randconfig-a011-20220718
x86_64               randconfig-a014-20220718
x86_64               randconfig-a016-20220718
x86_64               randconfig-a013-20220718
x86_64               randconfig-a015-20220718
i386                 randconfig-a015-20220718
i386                 randconfig-a011-20220718
i386                 randconfig-a012-20220718
i386                 randconfig-a014-20220718
i386                 randconfig-a016-20220718
i386                 randconfig-a013-20220718
i386                          randconfig-a012
i386                          randconfig-a016
s390                 randconfig-r044-20220718
riscv                randconfig-r042-20220718
arc                  randconfig-r043-20220718
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                      tct_hammer_defconfig
mips                           ip28_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                 mpc832x_mds_defconfig
x86_64                        randconfig-k001
i386                 randconfig-a001-20220718
i386                 randconfig-a006-20220718
i386                 randconfig-a002-20220718
i386                          randconfig-a004
i386                 randconfig-a004-20220718
i386                 randconfig-a005-20220718
i386                 randconfig-a003-20220718
x86_64               randconfig-a005-20220718
x86_64               randconfig-a003-20220718
x86_64               randconfig-a006-20220718
hexagon              randconfig-r041-20220721
s390                 randconfig-r044-20220721
hexagon              randconfig-r045-20220721
riscv                randconfig-r042-20220721
hexagon              randconfig-r041-20220718
hexagon              randconfig-r045-20220718

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
