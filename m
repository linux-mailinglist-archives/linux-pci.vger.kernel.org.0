Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B654B2583
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 13:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbiBKMTw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 07:19:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbiBKMTv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 07:19:51 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0D2F26
        for <linux-pci@vger.kernel.org>; Fri, 11 Feb 2022 04:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644581990; x=1676117990;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=d2i2UtTSKjA5UGoWu1QyZhgslNqu5UeNflVevRLpSMs=;
  b=AYd5lTWj725aO2U0pLyNPTCEW+bilr47TFbb1xH6EgW2gPxKAsu9Z11J
   u2nG/95kie2WW/TDdc9jACsjknArqh5aSUPySmOPEw6K1wxPILTLESqus
   RnPb7XHHkG6uGQ2sKqewmfw+UUj4VrUu0dx90sJj3tDR5X8v6/F7yMW/P
   Xe5MlyU1cd+U4yE5AqSwqj37gJxTVrqOdTyu+pnpS2bfqfV0y3OLWKT8e
   4OlNlSX+eG/qa27IVgbZh35Uo4GKOiUvmL70pm2+I1LIHVoxB2b81jt25
   HaXKGmE/IfgHbftcS8eiCll2iQ4tiLMPPBYxTlWSuTGvftbNV8E0N9p+J
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="248553310"
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="248553310"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 04:19:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="634075722"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 11 Feb 2022 04:19:49 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIUtw-0004Z9-OS; Fri, 11 Feb 2022 12:19:48 +0000
Date:   Fri, 11 Feb 2022 20:18:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/hotplug] BUILD SUCCESS
 9f72d4757cbe4d1ed669192f6d23817c9e437c4b
Message-ID: <6206542a.s138WRe/crjournf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/hotplug
branch HEAD: 9f72d4757cbe4d1ed669192f6d23817c9e437c4b  PCI: pciehp: Add Qualcomm quirk for Command Completed erratum

elapsed time: 731m

configs tested: 145
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
arc                           tb10x_defconfig
mips                       bmips_be_defconfig
ia64                         bigsur_defconfig
powerpc                 mpc834x_mds_defconfig
m68k                             allyesconfig
arm                       aspeed_g5_defconfig
mips                        jmr3927_defconfig
mips                  decstation_64_defconfig
openrisc                            defconfig
mips                 decstation_r4k_defconfig
m68k                          multi_defconfig
powerpc                     ep8248e_defconfig
arc                            hsdk_defconfig
m68k                         amcore_defconfig
mips                        vocore2_defconfig
nios2                            alldefconfig
powerpc                      pasemi_defconfig
sh                        sh7785lcr_defconfig
sh                          lboxre2_defconfig
sparc64                          alldefconfig
powerpc                     mpc83xx_defconfig
m68k                           sun3_defconfig
sh                         ecovec24_defconfig
arm                        shmobile_defconfig
arm                        mini2440_defconfig
mips                           ip32_defconfig
arm                          simpad_defconfig
xtensa                          iss_defconfig
openrisc                 simple_smp_defconfig
powerpc                         ps3_defconfig
powerpc                      ep88xc_defconfig
h8300                    h8300h-sim_defconfig
arm                         at91_dt_defconfig
mips                  maltasmvp_eva_defconfig
arm                           stm32_defconfig
sh                           se7343_defconfig
arm                     eseries_pxa_defconfig
alpha                            alldefconfig
mips                            gpr_defconfig
riscv                    nommu_k210_defconfig
h8300                     edosk2674_defconfig
parisc                              defconfig
m68k                          hp300_defconfig
powerpc                     tqm8555_defconfig
arm                       multi_v4t_defconfig
xtensa                              defconfig
arm                      jornada720_defconfig
parisc                           alldefconfig
m68k                          amiga_defconfig
powerpc                      makalu_defconfig
openrisc                         alldefconfig
sh                           se7724_defconfig
mips                     loongson1b_defconfig
m68k                       m5275evb_defconfig
arm                  randconfig-c002-20220211
arm                  randconfig-c002-20220210
arm                  randconfig-c002-20220209
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20220211
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220211
arm                  randconfig-c002-20220211
i386                          randconfig-c001
mips                 randconfig-c004-20220211
powerpc                          allyesconfig
mips                          malta_defconfig
riscv                          rv32_defconfig
arm                        mvebu_v5_defconfig
powerpc                      katmai_defconfig
powerpc                     mpc5200_defconfig
powerpc                     akebono_defconfig
mips                         tb0219_defconfig
arm                         lpc32xx_defconfig
arm                          pxa168_defconfig
powerpc                        icon_defconfig
powerpc                   bluestone_defconfig
mips                      pic32mzda_defconfig
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
hexagon              randconfig-r045-20220211
hexagon              randconfig-r041-20220211
riscv                randconfig-r042-20220211

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
