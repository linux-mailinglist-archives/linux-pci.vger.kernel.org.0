Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5562455A7A6
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jun 2022 09:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbiFYHF7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Jun 2022 03:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbiFYHF7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Jun 2022 03:05:59 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FA433E12
        for <linux-pci@vger.kernel.org>; Sat, 25 Jun 2022 00:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656140758; x=1687676758;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=3XZNKwwdn313bzDJYf4AYS98hRmeGn621aODKBT4W+Q=;
  b=h81HpogoXDaWpFjVFoCkMFTdhxrzwYemBipE7a9ckutBe9mW/lirbBy3
   iDcbYpnQrMtY7VJyRRCZVU1Vexw0QqXLFWT+S6OZmKb/fDFRlBJpaZegr
   geGPW6P/gL8I2Lm6usrqcZHvjrOx+lEJdzuaVOyA84WCXNnz9FGCP4Z+C
   Kcr0dFBoXKnL1WXGsiNOrbHAlEsAVzsG1wgQNUXhBHvVdjibprcvUT1n4
   s1KYud8Wmmqjums0VdtRcub6lkN1jIuYmhHzjscRQ8NPYLl0KsdeqwYBY
   bk3O8/uriwIzMXvJjnsaFlAE02RffM2Iodm9nlJzZqiSgYw9qc4mF0OmC
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="260967819"
X-IronPort-AV: E=Sophos;i="5.92,221,1650956400"; 
   d="scan'208";a="260967819"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 00:05:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,221,1650956400"; 
   d="scan'208";a="593542104"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 25 Jun 2022 00:05:56 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4zrg-0005Uh-AN;
        Sat, 25 Jun 2022 07:05:56 +0000
Date:   Sat, 25 Jun 2022 15:05:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/ctrl/rcar-gen2] BUILD SUCCESS
 aefffba672881f7fdb29ec15fcbcab55f3c0592d
Message-ID: <62b6b3bc.QTv2S71MhJMPsDtj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ctrl/rcar-gen2
branch HEAD: aefffba672881f7fdb29ec15fcbcab55f3c0592d  PCI: rcar-gen2: Add RZ/N1 SOC family compatible string

elapsed time: 1908m

configs tested: 146
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220622
arm                         lubbock_defconfig
arm                      jornada720_defconfig
sh                           se7206_defconfig
arm                            lart_defconfig
arc                              alldefconfig
powerpc                      arches_defconfig
m68k                          multi_defconfig
powerpc                     mpc83xx_defconfig
sh                 kfr2r09-romimage_defconfig
um                           x86_64_defconfig
sh                                  defconfig
openrisc                  or1klitex_defconfig
arm                             pxa_defconfig
m68k                         amcore_defconfig
arm                        realview_defconfig
xtensa                           alldefconfig
mips                  decstation_64_defconfig
sh                   sh7770_generic_defconfig
arm                           imxrt_defconfig
sparc                       sparc64_defconfig
sh                   rts7751r2dplus_defconfig
sh                             sh03_defconfig
s390                                defconfig
sh                          sdk7786_defconfig
sh                             shx3_defconfig
arm                           h3600_defconfig
arm                        keystone_defconfig
microblaze                          defconfig
arm                          iop32x_defconfig
xtensa                         virt_defconfig
mips                             allmodconfig
sh                          urquell_defconfig
powerpc                      ppc40x_defconfig
powerpc                         ps3_defconfig
arm64                            alldefconfig
sh                     sh7710voipgw_defconfig
m68k                            q40_defconfig
powerpc                      chrp32_defconfig
alpha                               defconfig
sh                         ecovec24_defconfig
arm                           viper_defconfig
arm                       aspeed_g5_defconfig
parisc64                            defconfig
powerpc                 mpc834x_mds_defconfig
i386                             alldefconfig
powerpc                      ppc6xx_defconfig
mips                            ar7_defconfig
mips                           xway_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
s390                             allmodconfig
arc                                 defconfig
s390                             allyesconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc                           allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
x86_64                        randconfig-c001
arm                  randconfig-c002-20220624
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
x86_64                        randconfig-a006
x86_64                        randconfig-a002
x86_64                        randconfig-a004
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220622
arc                  randconfig-r043-20220623
s390                 randconfig-r044-20220623
riscv                randconfig-r042-20220623
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                               rhel-8.3
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                                 defconfig
powerpc                     kmeter1_defconfig
powerpc                     kilauea_defconfig
x86_64                           allyesconfig
powerpc                 mpc8560_ads_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                   milbeaut_m10v_defconfig
mips                     cu1000-neo_defconfig
hexagon                             defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                      ppc64e_defconfig
powerpc                    gamecube_defconfig
powerpc                  mpc866_ads_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r041-20220622
hexagon              randconfig-r041-20220623
s390                 randconfig-r044-20220622
hexagon              randconfig-r045-20220622
hexagon              randconfig-r045-20220623
riscv                randconfig-r042-20220622
hexagon              randconfig-r041-20220624
s390                 randconfig-r044-20220624
hexagon              randconfig-r045-20220624
riscv                randconfig-r042-20220624

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
