Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434BB6265C3
	for <lists+linux-pci@lfdr.de>; Sat, 12 Nov 2022 01:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbiKLAE3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 19:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiKLAE2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 19:04:28 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC990252B0
        for <linux-pci@vger.kernel.org>; Fri, 11 Nov 2022 16:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668211467; x=1699747467;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=nGqHA8c7rm2pphsTgGLkOtvyaozmy1TYWh2DEc1xehs=;
  b=S3tneIsJ8mpXIyYbFLZ98axv1vmkE3yAap7PjOLyCuBt9rzaJFrWxTv1
   UKx59mnAcDJfo8FoayJmCNZz8vy1eKj79pByeDI/IjkFTgCGFKBf5YVI/
   XHcPNwb2Pwgt6n3U4YL8M/6Lz70VBRg2n9rWUX7GFSwPyw4TdBAY4Inc6
   VJ/sGEvR4n8l/QKNVRL+kRXE6iAsr4UykqwoqaWy3UYYIeXeatCg+aeK4
   z2ealxXsQS+Vbx76+Vgtgb++iKwW6r43SSnC5T3K7ZISD31NuLagk64aN
   lfLV97DuSfvK03Q8aBW9HQ/97RkfUf/+Wh1rfLTmeivEW+c1FgckjYRnw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="312828686"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="312828686"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 16:04:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="637721919"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="637721919"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 11 Nov 2022 16:04:25 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ote0X-0004NV-05;
        Sat, 12 Nov 2022 00:04:25 +0000
Date:   Sat, 12 Nov 2022 08:04:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/brcmstb] BUILD SUCCESS
 602fb860945fd6dce7989fcd3727d5fe4282f785
Message-ID: <636ee307.Q6QDaLxj9/mzdpMb%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/brcmstb
branch HEAD: 602fb860945fd6dce7989fcd3727d5fe4282f785  PCI: brcmstb: Set RCB_{MPS,64B}_MODE bits

elapsed time: 720m

configs tested: 100
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
um                           x86_64_defconfig
um                             i386_defconfig
s390                                defconfig
s390                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
arc                  randconfig-r043-20221111
riscv                randconfig-r042-20221111
s390                 randconfig-r044-20221111
s390                             allyesconfig
alpha                            allyesconfig
sh                               allmodconfig
arc                              allyesconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
arc                          axs103_defconfig
powerpc                 mpc834x_mds_defconfig
openrisc                         alldefconfig
m68k                             allmodconfig
m68k                             allyesconfig
ia64                             allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                            allnoconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm                      integrator_defconfig
sh                           se7724_defconfig
arc                          axs101_defconfig
loongarch                 loongson3_defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                             allyesconfig
i386                                defconfig
sh                         apsh4a3a_defconfig
loongarch                        alldefconfig
nios2                               defconfig
arm                            pleb_defconfig
i386                          randconfig-c001
arm                       imx_v6_v7_defconfig
mips                 decstation_r4k_defconfig
arm                        oxnas_v6_defconfig
m68k                          hp300_defconfig
arm                         at91_dt_defconfig
mips                 randconfig-c004-20221111
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
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

clang tested configs:
hexagon              randconfig-r045-20221111
hexagon              randconfig-r041-20221111
x86_64                        randconfig-k001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
arm                           sama7_defconfig
arm                          pcm027_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
arm                           omap1_defconfig
arm                       netwinder_defconfig
mips                        qi_lb60_defconfig
mips                  cavium_octeon_defconfig
powerpc                     skiroot_defconfig
powerpc                  mpc866_ads_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
powerpc                     ppa8548_defconfig
riscv                            alldefconfig
powerpc                      ppc44x_defconfig
mips                           rs90_defconfig
arm                          sp7021_defconfig
powerpc                 mpc8560_ads_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
