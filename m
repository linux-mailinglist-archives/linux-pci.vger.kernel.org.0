Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A436265C6
	for <lists+linux-pci@lfdr.de>; Sat, 12 Nov 2022 01:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbiKLAFh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 19:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbiKLAF2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 19:05:28 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C672275DB
        for <linux-pci@vger.kernel.org>; Fri, 11 Nov 2022 16:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668211527; x=1699747527;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=o/8LiAepEgD33BIUCgKZAcsW8DNy8CC3Mmd0kRsfMD0=;
  b=XGPKNQ/7PFGoTUco2A/slF2UObM6qcFgvW7+9c7gxJyFmz3R4S7SqP8s
   Zba+PGHwFCyyo9FkLLiKjI0pDEs5gDVRtkEeb2F30Mn8UPYS7/m8mS7Mj
   O6ggnzuGIXTtW5wgpurB8TtUw0LyojoY/lGxL1cOorQJ6NKKZr666uhH3
   YthIsz75r00nKpF5us0EZpkdljl9nqBozNWkgaUnj9XAzlrk+eUOVlfWJ
   8tcQ692qMFrMS1I7OwKnpzWMuVbDWBPl/4sVND5kB3kQG7MDueFSCa0PN
   yzXkdnNXtmXfPBfmFGcIqh1QEJEAWvbK2D3FU1k84UwshmJwSbTEqtdya
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="311686696"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="311686696"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 16:05:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="637722015"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="637722015"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 11 Nov 2022 16:05:25 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ote1V-0004NZ-0A;
        Sat, 12 Nov 2022 00:05:25 +0000
Date:   Sat, 12 Nov 2022 08:04:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/vmd] BUILD SUCCESS
 d899aa668498c07ff217b666ae9712990306e682
Message-ID: <636ee309.jCUeZYLzMTcWo7Vy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/vmd
branch HEAD: d899aa668498c07ff217b666ae9712990306e682  PCI: vmd: Disable MSI remapping after suspend

elapsed time: 720m

configs tested: 106
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
powerpc                           allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
arc                              allyesconfig
x86_64                           rhel-8.3-syz
alpha                            allyesconfig
sh                               allmodconfig
s390                             allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
arc                  randconfig-r043-20221111
riscv                randconfig-r042-20221111
i386                          randconfig-a012
s390                 randconfig-r044-20221111
m68k                             allyesconfig
i386                          randconfig-a016
m68k                             allmodconfig
i386                          randconfig-a014
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
arc                          axs103_defconfig
powerpc                 mpc834x_mds_defconfig
openrisc                         alldefconfig
ia64                             allmodconfig
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
mips                 randconfig-c004-20221111
m68k                          hp300_defconfig
arm                         at91_dt_defconfig
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

clang tested configs:
hexagon              randconfig-r041-20221111
i386                          randconfig-a011
hexagon              randconfig-r045-20221111
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-k001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
arm                           sama7_defconfig
arm                          pcm027_defconfig
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
