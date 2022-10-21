Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93EDE606F26
	for <lists+linux-pci@lfdr.de>; Fri, 21 Oct 2022 07:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJUFJe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Oct 2022 01:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiJUFJc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Oct 2022 01:09:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4582C55A3
        for <linux-pci@vger.kernel.org>; Thu, 20 Oct 2022 22:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666328970; x=1697864970;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=TZ9uviJc3w5WFMjRobTqd6UxlIePEo3/vCtTf3Ogt34=;
  b=XbyqAM7fFcAhSfGDYOLcDHL+n91055NwJzY9OYLuiIgrTe6MjOVX22uo
   rZpEF+X6/a85l8F7xDJvHIaY1LJ4YIGBhIrZilbgGP4b84EsI900wDjOo
   aS58Si7i7zp31QDJNRIEbzuNhVCVeaKlPbxBPoxEzfJrg8yYmIcCG3MzK
   b6uTXGr1LnXBU+qZEFgc/YJWD1n2O/hKDHl4c4iTvMHTr2uEDhuikeifi
   P6D5fXGaCVAQmg/84CBoY0r4G22ybtptqFUwuKd/KQzKOW71kvpuKQ22e
   sKwS6BCx0H6tYXvYWF12PmE7DSZ9y5Ubc6QaFgmKTRTsPkWAGNtqkeI2q
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="306903747"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="306903747"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 22:09:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="630281124"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="630281124"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 20 Oct 2022 22:09:22 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1olkHZ-0002AR-2i;
        Fri, 21 Oct 2022 05:09:21 +0000
Date:   Fri, 21 Oct 2022 13:08:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:for-linus] BUILD SUCCESS
 e6aa4edd2f5b07fdc41de287876dd98c6e44322b
Message-ID: <6352294f.rzwWecRB3FD4m6l1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
branch HEAD: e6aa4edd2f5b07fdc41de287876dd98c6e44322b  MAINTAINERS: Update Kishon's email address in PCI endpoint subsystem

elapsed time: 1854m

configs tested: 205
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arc                                 defconfig
s390                             allmodconfig
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
alpha                               defconfig
x86_64                           rhel-8.3-kvm
s390                                defconfig
x86_64                           rhel-8.3-syz
s390                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
powerpc                           allnoconfig
m68k                             allmodconfig
powerpc                          allmodconfig
arc                              allyesconfig
i386                                defconfig
x86_64                        randconfig-a013
sh                               allmodconfig
alpha                            allyesconfig
i386                          randconfig-a014
mips                             allyesconfig
m68k                             allyesconfig
x86_64                        randconfig-a011
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a015
i386                             allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arc                  randconfig-r043-20221018
s390                 randconfig-r044-20221018
riscv                randconfig-r042-20221018
ia64                          tiger_defconfig
m68k                       m5475evb_defconfig
xtensa                              defconfig
powerpc                       maple_defconfig
sh                          rsk7269_defconfig
s390                          debug_defconfig
m68k                           virt_defconfig
sh                     sh7710voipgw_defconfig
sh                            titan_defconfig
arm                       aspeed_g5_defconfig
m68k                          amiga_defconfig
arc                               allnoconfig
i386                          randconfig-c001
arm                        keystone_defconfig
ia64                                defconfig
sh                        sh7763rdp_defconfig
mips                           gcw0_defconfig
openrisc                            defconfig
xtensa                         virt_defconfig
powerpc                     sequoia_defconfig
arm                           h3600_defconfig
arm                         cm_x300_defconfig
arm                          pxa3xx_defconfig
sparc64                          alldefconfig
m68k                       bvme6000_defconfig
arc                  randconfig-r043-20221020
s390                 randconfig-r044-20221020
riscv                randconfig-r042-20221020
arm                        clps711x_defconfig
xtensa                           alldefconfig
csky                              allnoconfig
arm                          exynos_defconfig
nios2                               defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
powerpc                      ppc6xx_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                   currituck_defconfig
sh                        dreamcast_defconfig
sh                          kfr2r09_defconfig
mips                           ip32_defconfig
powerpc                     mpc83xx_defconfig
arm                           stm32_defconfig
powerpc                 mpc834x_itx_defconfig
openrisc                  or1klitex_defconfig
csky                                defconfig
sh                             shx3_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arc                        vdk_hs38_defconfig
arm                         assabet_defconfig
nios2                            alldefconfig
m68k                          sun3x_defconfig
openrisc                       virt_defconfig
xtensa                          iss_defconfig
arc                          axs101_defconfig
powerpc                   motionpro_defconfig
m68k                                defconfig
sparc                       sparc32_defconfig
arc                        nsimosci_defconfig
sh                           se7619_defconfig
arm                         s3c6400_defconfig
powerpc                     tqm8555_defconfig
nios2                            allyesconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
mips                 randconfig-c004-20221020
x86_64                        randconfig-c001
arm                  randconfig-c002-20221019
ia64                         bigsur_defconfig
m68k                        stmark2_defconfig
powerpc                      cm5200_defconfig
sh                ecovec24-romimage_defconfig
arm                      footbridge_defconfig
sh                     magicpanelr2_defconfig
arm                          gemini_defconfig
mips                  maltasmvp_eva_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
um                               alldefconfig
powerpc                  iss476-smp_defconfig
sh                         apsh4a3a_defconfig
openrisc                         alldefconfig
powerpc                       holly_defconfig
m68k                         apollo_defconfig
sh                           se7712_defconfig
sparc                               defconfig
xtensa                           allyesconfig
sparc                            allyesconfig
x86_64                                  kexec
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
arm                        oxnas_v6_defconfig
sparc                            alldefconfig
arm                          badge4_defconfig
m68k                            q40_defconfig
powerpc                     tqm8541_defconfig
powerpc                      chrp32_defconfig
sh                           se7750_defconfig
sh                           se7343_defconfig
nios2                         10m50_defconfig
mips                           ci20_defconfig
m68k                        mvme147_defconfig
mips                       bmips_be_defconfig

clang tested configs:
s390                 randconfig-r044-20221019
hexagon              randconfig-r045-20221019
riscv                randconfig-r042-20221019
hexagon              randconfig-r041-20221019
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a015
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
powerpc                      pmac32_defconfig
powerpc                     tqm8540_defconfig
hexagon              randconfig-r041-20221020
hexagon              randconfig-r045-20221020
x86_64                        randconfig-c007
mips                 randconfig-c004-20221019
i386                          randconfig-c001
s390                 randconfig-c005-20221019
arm                  randconfig-c002-20221019
riscv                randconfig-c006-20221019
powerpc              randconfig-c003-20221019
x86_64                        randconfig-k001
arm                       mainstone_defconfig
powerpc                      obs600_defconfig
i386                 randconfig-a013-20221017
i386                 randconfig-a015-20221017
i386                 randconfig-a016-20221017
i386                 randconfig-a011-20221017
i386                 randconfig-a014-20221017
i386                 randconfig-a012-20221017
hexagon              randconfig-r045-20221018
hexagon              randconfig-r041-20221018
powerpc                     ksi8560_defconfig
powerpc                    gamecube_defconfig
mips                          ath79_defconfig
arm                         shannon_defconfig
mips                     cu1830-neo_defconfig
arm                          ep93xx_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                       lemote2f_defconfig
powerpc                    socrates_defconfig
arm                         orion5x_defconfig
powerpc                     tqm8560_defconfig
powerpc                     kmeter1_defconfig
arm                           omap1_defconfig
mips                      malta_kvm_defconfig
arm                                 defconfig
arm                        magician_defconfig
arm                  colibri_pxa300_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
