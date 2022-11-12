Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4EC626684
	for <lists+linux-pci@lfdr.de>; Sat, 12 Nov 2022 03:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiKLC4d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 21:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiKLC4c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 21:56:32 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB845FD4
        for <linux-pci@vger.kernel.org>; Fri, 11 Nov 2022 18:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668221791; x=1699757791;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=EPFc2NhlUdVWncRZ0pn8M4WpXbuNhgH9Mkj0e5J6aXg=;
  b=jZ2Jc0/3vvPKSTwVqLi0tfaVexzzPpD5wgdWf2DqirLh4u5PdkAr+XYI
   SLGoVgrA2LNilpJAFHOue0SylN8K+HYPhuiSvqNTTMgvlloNUpuSvZaN9
   WhmcdG9sTOmFVR8X1yuy4LuWVL56JVL2TOF/Dl5sDHHX+7IvRgG5Xb9dz
   pNWK6SkzIHvKkk1D44nkHIkcIGbEXNgjw9bZ+E/Dc7ZK8AkzntAGo8sbT
   lWM9zVczz5NXnvxZfeyk1GSbgRSqB/SUOIb3VbEQUidqgNns1her2sulp
   P2v03nKzgntFPOyHFMTvQpH6mBKS6VwBZ20kou+YLDrjbQvUccCmN7eAV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="312840935"
X-IronPort-AV: E=Sophos;i="5.96,158,1665471600"; 
   d="scan'208";a="312840935"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 18:56:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="706702141"
X-IronPort-AV: E=Sophos;i="5.96,158,1665471600"; 
   d="scan'208";a="706702141"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 11 Nov 2022 18:56:29 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1otgh3-0004UP-0Q;
        Sat, 12 Nov 2022 02:56:29 +0000
Date:   Sat, 12 Nov 2022 10:55:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/misc] BUILD SUCCESS
 2759ddf7535d63381f9b9b1412e4c46e13ed773a
Message-ID: <636f0b24.DA4TCPBHQygyo1yB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/misc
branch HEAD: 2759ddf7535d63381f9b9b1412e4c46e13ed773a  PCI: endpoint: Fix Kconfig indent style

elapsed time: 722m

configs tested: 127
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                                 defconfig
alpha                               defconfig
x86_64                               rhel-8.3
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                              defconfig
i386                          randconfig-a005
x86_64                            allnoconfig
x86_64                        randconfig-a015
x86_64                        randconfig-a004
x86_64                        randconfig-a013
s390                                defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a002
s390                             allmodconfig
i386                                defconfig
arc                  randconfig-r043-20221111
x86_64                        randconfig-a006
riscv                randconfig-r042-20221111
ia64                             allmodconfig
arm                                 defconfig
s390                 randconfig-r044-20221111
x86_64                           allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
s390                             allyesconfig
i386                          randconfig-a012
sh                               allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a014
i386                             allyesconfig
i386                          randconfig-a016
arm                              allyesconfig
arm64                            allyesconfig
m68k                          hp300_defconfig
arm                         at91_dt_defconfig
arm                       imx_v6_v7_defconfig
mips                 decstation_r4k_defconfig
arm                        oxnas_v6_defconfig
mips                 randconfig-c004-20221111
i386                          randconfig-c001
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
sh                          r7780mp_defconfig
arm                           u8500_defconfig
mips                           gcw0_defconfig
mips                     loongson1b_defconfig
m68k                       m5208evb_defconfig
mips                           jazz_defconfig
mips                      loongson3_defconfig
powerpc                      cm5200_defconfig
arm                           sunxi_defconfig
mips                            gpr_defconfig
sparc                       sparc32_defconfig
arm                        spear6xx_defconfig
powerpc                     mpc83xx_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                      footbridge_defconfig
sh                        apsh4ad0a_defconfig
sh                   rts7751r2dplus_defconfig
sh                        sh7757lcr_defconfig
mips                      fuloong2e_defconfig
arm                         axm55xx_defconfig
parisc                           alldefconfig
parisc64                            defconfig
openrisc                            defconfig
openrisc                  or1klitex_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc                           allyesconfig
powerpc                      ppc40x_defconfig
arm                        mvebu_v7_defconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
hexagon              randconfig-r045-20221111
hexagon              randconfig-r041-20221111
x86_64                        randconfig-a014
arm                           omap1_defconfig
arm                       netwinder_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a003
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
mips                        qi_lb60_defconfig
mips                  cavium_octeon_defconfig
powerpc                     skiroot_defconfig
powerpc                  mpc866_ads_defconfig
x86_64                        randconfig-k001
powerpc                     ppa8548_defconfig
riscv                            alldefconfig
powerpc                      ppc44x_defconfig
mips                           rs90_defconfig
arm                          sp7021_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                  mpc885_ads_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
