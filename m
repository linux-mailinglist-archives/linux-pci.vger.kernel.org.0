Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59E7576DE8
	for <lists+linux-pci@lfdr.de>; Sat, 16 Jul 2022 14:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiGPM0N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Jul 2022 08:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGPM0M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jul 2022 08:26:12 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301EC193E7
        for <linux-pci@vger.kernel.org>; Sat, 16 Jul 2022 05:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657974371; x=1689510371;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FCNW7lqJ/OHLISg52n1LIg1TTvXCeEJdvmh+vnXAA2Q=;
  b=Mq7bXRxQhtKkUiWwKoLc26QDJfoDTvbLLGo/6Tt83Gg8hw5owwukEJRD
   ryQU4gpUmvnRW5mTYx6bND40b7LRgB4qKPOZiRZ0diW9od9v4k1PtP4QW
   trddALYFz8+7bTM0v3NOo3WAaAvqwlCwIvep1cAmbScAznTgRXAOVWCEd
   wcZjg3UHRNxAZ1YL7RPVzllPIXqLwKko9V/65D6aV9MyggUlvXEpciU62
   SncwZpo5+8sTNoxeDcYSPa31iDOWEUCNs0dIGQ1z2j/I8u9/3FeYIlEZb
   KDjQVqupi8brgsdjHfvMXBpJh6gOi7PsZhxoHVnv+tEYihB3yXeqSiZAA
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="266382127"
X-IronPort-AV: E=Sophos;i="5.92,276,1650956400"; 
   d="scan'208";a="266382127"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 05:26:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,276,1650956400"; 
   d="scan'208";a="629409444"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 16 Jul 2022 05:26:08 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCgs4-0001RW-6m;
        Sat, 16 Jul 2022 12:26:08 +0000
Date:   Sat, 16 Jul 2022 20:26:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/ctrl/exynos] BUILD SUCCESS
 1357da5bfff7321490010d21b3e06ec1721b3513
Message-ID: <62d2ae5e.N+N93vr0ttPbmyCf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ctrl/exynos
branch HEAD: 1357da5bfff7321490010d21b3e06ec1721b3513  PCI: exynos: Correct generic PHY usage

elapsed time: 777m

configs tested: 113
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arm                      footbridge_defconfig
xtensa                              defconfig
openrisc                    or1ksim_defconfig
arm                        mvebu_v7_defconfig
powerpc                 mpc85xx_cds_defconfig
parisc                generic-32bit_defconfig
arm                            lart_defconfig
sh                         ecovec24_defconfig
arm                     eseries_pxa_defconfig
sh                         ap325rxa_defconfig
arm                          gemini_defconfig
arm                           sama5_defconfig
xtensa                generic_kc705_defconfig
mips                           jazz_defconfig
arm                          simpad_defconfig
arm                       multi_v4t_defconfig
powerpc                     ep8248e_defconfig
sh                        sh7763rdp_defconfig
mips                    maltaup_xpa_defconfig
xtensa                    xip_kc705_defconfig
powerpc                     tqm8555_defconfig
sh                        sh7785lcr_defconfig
mips                             allyesconfig
sh                           se7721_defconfig
m68k                        mvme147_defconfig
sh                          polaris_defconfig
powerpc                  storcenter_defconfig
arc                            hsdk_defconfig
i386                                defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220715
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
i386                             allyesconfig
arm                    vt8500_v6_v7_defconfig
mips                      pic32mzda_defconfig
mips                           mtx1_defconfig
powerpc                      ppc64e_defconfig
arm                       aspeed_g4_defconfig
arm                          moxart_defconfig
powerpc                     ppa8548_defconfig
mips                      maltaaprp_defconfig
arm                        mvebu_v5_defconfig
arm                         bcm2835_defconfig
powerpc                    socrates_defconfig
powerpc               mpc834x_itxgp_defconfig
riscv                          rv32_defconfig
mips                  cavium_octeon_defconfig
arm                       netwinder_defconfig
mips                       lemote2f_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                    ge_imp3a_defconfig
arm                          collie_defconfig
mips                     loongson1c_defconfig
arm                         orion5x_defconfig
mips                     cu1830-neo_defconfig
powerpc                      obs600_defconfig
arm                            dove_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220715
s390                 randconfig-r044-20220715
hexagon              randconfig-r041-20220715
riscv                randconfig-r042-20220715

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
