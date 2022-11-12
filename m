Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418366265C7
	for <lists+linux-pci@lfdr.de>; Sat, 12 Nov 2022 01:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbiKLAFi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 19:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbiKLAF3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 19:05:29 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8662B1BA
        for <linux-pci@vger.kernel.org>; Fri, 11 Nov 2022 16:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668211528; x=1699747528;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=8llSxST3aJ2TewiqKYN2Zr+kww+xLvaN/VEh1h71d+o=;
  b=LX5jOX8foMCW3F0SNxYnTWz3RgJE8+MfrRALXHumihPWPI0Q7bxn0QrN
   y5WiMj+w/yMFMw1NpN4IkKmGB+rOeojkvQUDErDqba/rvJCZ0A+HsfUVu
   u75fegQd5kV6BbhTafXS2WsadeB3a08iwqdYuJkS4ityv3TqGo3EtG1cC
   w9ydnm0Pd/5mB2UUHAHeMi4iKC7BpjvpeCwtj8lFMp4rhm5ksb07ayiF1
   qKXIf5GtJYVFQKYlZXUdbplErHR/o/C4hhlZnIjuqkMYFf5w33VIPj8ds
   BFSPRwFRXcZL/KKKhGxAbJ1qs06LZfFSgJFICaUgj/PVxyZi/YE8ClCjv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="292083363"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="292083363"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 16:05:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="668939215"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="668939215"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 11 Nov 2022 16:05:25 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ote1V-0004Nq-0W;
        Sat, 12 Nov 2022 00:05:25 +0000
Date:   Sat, 12 Nov 2022 08:04:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/qcom] BUILD SUCCESS
 c4860af88d0cb1bb006df12615c5515ae509f73b
Message-ID: <636ee311.pLCUqkZ0hgFWkUSK%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/qcom
branch HEAD: c4860af88d0cb1bb006df12615c5515ae509f73b  PCI: qcom: Add basic interconnect support

elapsed time: 720m

configs tested: 109
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                             allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
m68k                             allmodconfig
x86_64                        randconfig-a015
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
i386                          randconfig-a014
i386                          randconfig-a012
mips                             allyesconfig
i386                          randconfig-a016
i386                          randconfig-a001
m68k                             allyesconfig
powerpc                          allmodconfig
arc                  randconfig-r043-20221111
i386                          randconfig-a003
riscv                randconfig-r042-20221111
i386                          randconfig-a005
s390                 randconfig-r044-20221111
i386                                defconfig
sh                               allmodconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
arc                          axs103_defconfig
powerpc                 mpc834x_mds_defconfig
openrisc                         alldefconfig
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
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a011
hexagon              randconfig-r041-20221111
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a004
hexagon              randconfig-r045-20221111
i386                          randconfig-a006
x86_64                        randconfig-k001
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
