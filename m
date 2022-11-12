Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FC86266D9
	for <lists+linux-pci@lfdr.de>; Sat, 12 Nov 2022 05:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbiKLEIh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 23:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiKLEIg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 23:08:36 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D5B12ACC
        for <linux-pci@vger.kernel.org>; Fri, 11 Nov 2022 20:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668226114; x=1699762114;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2Sn36qfdvHU18fpRcTke96Vqj99Sj6NAU7E0l800s60=;
  b=fQfN8bi80QdOIRqA6xuwpYWd39AQXStRHJRWwdZKdij72+/2DSgxjjpi
   tKEdUiQnSv2rIu2VbPp2TxttIwUnjb/kvoxhuefc2sgHxmhJuqEDeRUzA
   dLDEs+7j38M4uRwQmWBGf2Q0arbuuDKijybssSXUH2kvPx7zEnRgy/9vF
   E4mVzqhL10fw3GEXbO2BtN7LlXjFuhgrGX896/66hW310c6XF+YcqQdXf
   o/v0qIhE9YViJQl4GKeZwyV1B5tCKrWBm+lWeAGuInKiKL99iRSY59rhI
   jiy3PACrFeZsJfD/G/Z1vSL0lDws3U2GNlzlIPN63vnq0SfsvmckhM9Yw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="292099661"
X-IronPort-AV: E=Sophos;i="5.96,158,1665471600"; 
   d="scan'208";a="292099661"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 20:08:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="637761175"
X-IronPort-AV: E=Sophos;i="5.96,158,1665471600"; 
   d="scan'208";a="637761175"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 11 Nov 2022 20:08:31 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1othok-0004Y1-38;
        Sat, 12 Nov 2022 04:08:30 +0000
Date:   Sat, 12 Nov 2022 12:08:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/dwc] BUILD SUCCESS
 ae6b9a65af480144da323436d90e149501ea8937
Message-ID: <636f1c30.KABTtdYVdVvthsGV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/dwc
branch HEAD: ae6b9a65af480144da323436d90e149501ea8937  PCI: imx6: Initialize PHY before deasserting core reset

elapsed time: 721m

configs tested: 99
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
um                             i386_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
arm                                 defconfig
arc                              allyesconfig
arc                  randconfig-r043-20221111
alpha                            allyesconfig
riscv                randconfig-r042-20221111
m68k                             allyesconfig
x86_64                              defconfig
i386                                defconfig
m68k                             allmodconfig
s390                 randconfig-r044-20221111
arc                                 defconfig
alpha                               defconfig
powerpc                           allnoconfig
s390                             allmodconfig
i386                          randconfig-a014
s390                                defconfig
arm64                            allyesconfig
i386                          randconfig-a012
i386                          randconfig-a016
arm                              allyesconfig
s390                             allyesconfig
x86_64                            allnoconfig
i386                             allyesconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a004
x86_64                        randconfig-a002
ia64                             allmodconfig
sh                          r7780mp_defconfig
arm                           u8500_defconfig
mips                           gcw0_defconfig
mips                     loongson1b_defconfig
x86_64                           allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                        randconfig-a006
arm                           sunxi_defconfig
mips                            gpr_defconfig
i386                          randconfig-c001
arm                       imx_v6_v7_defconfig
mips                 decstation_r4k_defconfig
arm                        oxnas_v6_defconfig
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
m68k                       m5208evb_defconfig
mips                           jazz_defconfig
mips                      loongson3_defconfig
powerpc                      cm5200_defconfig
sparc                       sparc32_defconfig
arm                        spear6xx_defconfig
powerpc                     mpc83xx_defconfig
powerpc                      ppc40x_defconfig
arm                        mvebu_v7_defconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20221111
hexagon              randconfig-r045-20221111
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
mips                        qi_lb60_defconfig
mips                  cavium_octeon_defconfig
powerpc                     skiroot_defconfig
powerpc                  mpc866_ads_defconfig
x86_64                        randconfig-k001
riscv                            alldefconfig
powerpc                      ppc44x_defconfig
mips                           rs90_defconfig
arm                          sp7021_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                  mpc885_ads_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
