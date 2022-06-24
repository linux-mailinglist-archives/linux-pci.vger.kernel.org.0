Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EAD5593AF
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 08:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiFXGnu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 02:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiFXGnt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 02:43:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2EE609D9
        for <linux-pci@vger.kernel.org>; Thu, 23 Jun 2022 23:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656053028; x=1687589028;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=5hLWEBaDhiWpGW5Fdu75//Dxy3M7aBUnCQbUlG0wLHo=;
  b=LRKndGAGDm7dqzDzhX1oWYyr+EZzCRiCE5VTGcgqhwtyZEEhIVciqWe2
   QJ9v0IbXLYjo2riDVL/zt1C167ZfTIPRryX5fTUhFP3LwTlWW1MIpr4B2
   2uDko4gPjiGDmeehx9ri45ae3CoQIb3azqjxVcb7WEcL1dzuo3GOXuWMb
   iJFt73rQVQek+zrSJda0AktrepTu7vQzez0K5v3y621wy+r19HW6qnSPZ
   kFL9KcATV125jSgdHzipA2i//3DCpYTaB3nIko6Tpnao/ah/ljnKKudb2
   DzUJLMKvnzpn/SE5Im5YPDC1oqUepYdhvG4TApmDYaJ2tpGpvy1x2Ep0n
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="260753169"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="260753169"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 23:43:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="563752965"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 23 Jun 2022 23:43:46 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4d2f-0003n2-W4;
        Fri, 24 Jun 2022 06:43:45 +0000
Date:   Fri, 24 Jun 2022 14:42:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/endpoint] BUILD SUCCESS
 8821cd7c4ba644fe3c7d4a99aa8e75fc7cfff413
Message-ID: <62b55ce6.mFgSNjZdrBNzXJht%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/endpoint
branch HEAD: 8821cd7c4ba644fe3c7d4a99aa8e75fc7cfff413  PCI: endpoint: Don't stop EP controller by EP function

elapsed time: 1945m

configs tested: 145
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220622
m68k                          atari_defconfig
sh                             espt_defconfig
arc                    vdk_hs38_smp_defconfig
arm                         lubbock_defconfig
arm                      jornada720_defconfig
m68k                        m5407c3_defconfig
sh                             shx3_defconfig
arm                           sama5_defconfig
arm                         vf610m4_defconfig
mips                  decstation_64_defconfig
arm                          gemini_defconfig
m68k                        stmark2_defconfig
sh                  sh7785lcr_32bit_defconfig
ia64                      gensparse_defconfig
arm                           corgi_defconfig
nios2                         3c120_defconfig
sh                        sh7757lcr_defconfig
sh                           se7750_defconfig
nios2                               defconfig
arc                      axs103_smp_defconfig
arm                          pxa3xx_defconfig
powerpc                   currituck_defconfig
sh                                  defconfig
mips                 decstation_r4k_defconfig
arm                             pxa_defconfig
arm                         s3c6400_defconfig
m68k                        m5272c3_defconfig
um                               alldefconfig
s390                          debug_defconfig
sh                          urquell_defconfig
sparc                               defconfig
sh                         microdev_defconfig
powerpc                      pasemi_defconfig
powerpc                         wii_defconfig
riscv             nommu_k210_sdcard_defconfig
parisc64                         alldefconfig
mips                      maltasmvp_defconfig
sh                   rts7751r2dplus_defconfig
m68k                          multi_defconfig
sh                             sh03_defconfig
openrisc                         alldefconfig
openrisc                  or1klitex_defconfig
sh                           se7206_defconfig
m68k                          sun3x_defconfig
arc                           tb10x_defconfig
sh                         ap325rxa_defconfig
arm                          lpd270_defconfig
powerpc                      mgcoge_defconfig
parisc64                            defconfig
ia64                                defconfig
s390                             allmodconfig
arc                          axs103_defconfig
xtensa                          iss_defconfig
arm                          simpad_defconfig
arm                      footbridge_defconfig
sparc                       sparc64_defconfig
sh                          rsk7269_defconfig
openrisc                 simple_smp_defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
s390                                defconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
nios2                            allyesconfig
parisc                              defconfig
parisc                           allyesconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220622
ia64                             allmodconfig
riscv                             allnoconfig
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
i386                   debian-10.3-kselftests
i386                              debian-10.3
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
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
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc                 mpc8315_rdb_defconfig
arm                          ixp4xx_defconfig
riscv                             allnoconfig
powerpc                 mpc8560_ads_defconfig
arm                           omap1_defconfig
powerpc                     mpc5200_defconfig
arm                         s5pv210_defconfig
hexagon                             defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                           ip28_defconfig
i386                             allyesconfig
mips                        qi_lb60_defconfig
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
