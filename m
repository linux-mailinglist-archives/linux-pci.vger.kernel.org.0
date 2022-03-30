Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650ED4EC54E
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 15:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345365AbiC3NPP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 09:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344768AbiC3NPP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 09:15:15 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329862DC8
        for <linux-pci@vger.kernel.org>; Wed, 30 Mar 2022 06:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648646009; x=1680182009;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=yZ7bdZ+v34aPUlBedTDsLLVFj0JXHFsbI6XMkC5PcsI=;
  b=kh9D9DSDh29uDAWZw9TyvrZd/rimqT7q81xOGbpnSkzSupV+vcQM/hcv
   9ZJZwboykKEwh8BAzQSKMIkprvzINm7I9o9vq4VHBoEn1X0qrT/WOfr27
   jLdEF1qYQfFh6Q/8i9amnZ6ZIoM1VJEFiOIQNgENWfypFHxpgbVtmVnUO
   dau1FNqcm++G9eo6KrNL9OsxPXwj2Kbh2GrQqHMwa4KI56SaGdCWtRoZT
   vvnEa9pMO1lwztaMS9KYt/93J17M3Z2W3kqqcT6THYxrY0efnZfmEH52n
   14rlgcc3vttEiZNPLAwkXchoRuK9JMJhYZQdR/RIjbAt1BrlBbCeWg5up
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="258369601"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="258369601"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 06:13:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="503310903"
Received: from lkp-server02.sh.intel.com (HELO 1905232cd9fb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 30 Mar 2022 06:13:26 -0700
Received: from kbuild by 1905232cd9fb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZY8c-00003L-4w;
        Wed, 30 Mar 2022 13:13:26 +0000
Date:   Wed, 30 Mar 2022 21:12:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:for-linus] BUILD SUCCESS
 18146f25ac6695ce2ed09503de46dafd2b1f36a6
Message-ID: <62445758.7K42sXr8gzKmly22%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
branch HEAD: 18146f25ac6695ce2ed09503de46dafd2b1f36a6  PCI: hv: Remove unused hv_set_msi_entry_from_desc()

elapsed time: 726m

configs tested: 215
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
mips                             allmodconfig
riscv                            allmodconfig
um                           x86_64_defconfig
mips                             allyesconfig
riscv                            allyesconfig
um                             i386_defconfig
powerpc              randconfig-c003-20220330
mips                 randconfig-c004-20220330
sh                      rts7751r2d1_defconfig
arm                        realview_defconfig
alpha                               defconfig
arm                         assabet_defconfig
h8300                            allyesconfig
sh                         apsh4a3a_defconfig
parisc                generic-32bit_defconfig
arm                       multi_v4t_defconfig
sh                          landisk_defconfig
sh                        edosk7760_defconfig
powerpc                     rainier_defconfig
xtensa                    smp_lx200_defconfig
arm                        mini2440_defconfig
powerpc                     pq2fads_defconfig
arc                     haps_hs_smp_defconfig
riscv             nommu_k210_sdcard_defconfig
um                               alldefconfig
xtensa                           allyesconfig
sh                           se7619_defconfig
sh                          lboxre2_defconfig
powerpc                      pasemi_defconfig
arm                       imx_v6_v7_defconfig
parisc64                         alldefconfig
mips                         tb0226_defconfig
sh                          rsk7264_defconfig
powerpc                    klondike_defconfig
sparc                       sparc64_defconfig
sh                          rsk7201_defconfig
arm                        clps711x_defconfig
arm                            xcep_defconfig
arm                          badge4_defconfig
m68k                       m5208evb_defconfig
arc                 nsimosci_hs_smp_defconfig
xtensa                          iss_defconfig
arm                           tegra_defconfig
powerpc                    sam440ep_defconfig
mips                            ar7_defconfig
arm                            hisi_defconfig
ia64                            zx1_defconfig
sh                         ecovec24_defconfig
arm                             pxa_defconfig
arc                                 defconfig
i386                                defconfig
mips                           xway_defconfig
xtensa                       common_defconfig
sh                            hp6xx_defconfig
h8300                       h8s-sim_defconfig
m68k                            q40_defconfig
parisc                           alldefconfig
sh                     magicpanelr2_defconfig
arm                         cm_x300_defconfig
sh                             espt_defconfig
powerpc                  storcenter_defconfig
sh                        apsh4ad0a_defconfig
mips                        bcm47xx_defconfig
sh                           se7705_defconfig
arm                         s3c6400_defconfig
m68k                         amcore_defconfig
arm                          gemini_defconfig
powerpc                     sequoia_defconfig
arm                        shmobile_defconfig
arm                      integrator_defconfig
sh                          urquell_defconfig
sh                          kfr2r09_defconfig
mips                           ip32_defconfig
sh                            migor_defconfig
ia64                      gensparse_defconfig
sh                   sh7724_generic_defconfig
mips                         bigsur_defconfig
sh                        sh7757lcr_defconfig
arm                            qcom_defconfig
mips                         db1xxx_defconfig
sh                          sdk7786_defconfig
powerpc                         wii_defconfig
powerpc                 mpc85xx_cds_defconfig
m68k                          amiga_defconfig
sh                           se7712_defconfig
csky                             alldefconfig
arm                  randconfig-c002-20220330
arm                  randconfig-c002-20220327
arm                  randconfig-c002-20220329
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64               randconfig-a001-20220328
x86_64               randconfig-a003-20220328
x86_64               randconfig-a004-20220328
x86_64               randconfig-a002-20220328
x86_64               randconfig-a005-20220328
x86_64               randconfig-a006-20220328
i386                 randconfig-a001-20220328
i386                 randconfig-a003-20220328
i386                 randconfig-a006-20220328
i386                 randconfig-a005-20220328
i386                 randconfig-a004-20220328
i386                 randconfig-a002-20220328
riscv                randconfig-r042-20220330
s390                 randconfig-r044-20220330
arc                  randconfig-r043-20220330
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
mips                 randconfig-c004-20220329
x86_64                        randconfig-c007
mips                 randconfig-c004-20220327
arm                  randconfig-c002-20220327
arm                  randconfig-c002-20220329
riscv                randconfig-c006-20220327
powerpc              randconfig-c003-20220327
powerpc              randconfig-c003-20220329
riscv                randconfig-c006-20220329
i386                          randconfig-c001
mips                 randconfig-c004-20220330
powerpc              randconfig-c003-20220330
riscv                randconfig-c006-20220330
arm                  randconfig-c002-20220330
powerpc                 mpc8313_rdb_defconfig
mips                           mtx1_defconfig
arm                         socfpga_defconfig
powerpc                      obs600_defconfig
powerpc                     mpc512x_defconfig
mips                        workpad_defconfig
powerpc                    socrates_defconfig
mips                           rs90_defconfig
hexagon                          alldefconfig
powerpc                 mpc836x_rdk_defconfig
mips                     loongson2k_defconfig
mips                     loongson1c_defconfig
powerpc                     mpc5200_defconfig
arm                     am200epdkit_defconfig
mips                   sb1250_swarm_defconfig
powerpc                   lite5200b_defconfig
powerpc                     kilauea_defconfig
powerpc                     powernv_defconfig
arm                         lpc32xx_defconfig
mips                         tb0287_defconfig
mips                          malta_defconfig
arm                          ep93xx_defconfig
riscv                            alldefconfig
mips                         tb0219_defconfig
mips                      bmips_stb_defconfig
mips                       lemote2f_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a016-20220328
x86_64               randconfig-a012-20220328
x86_64               randconfig-a011-20220328
x86_64               randconfig-a014-20220328
x86_64               randconfig-a013-20220328
x86_64               randconfig-a015-20220328
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
i386                 randconfig-a015-20220328
i386                 randconfig-a016-20220328
i386                 randconfig-a011-20220328
i386                 randconfig-a012-20220328
i386                 randconfig-a014-20220328
i386                 randconfig-a013-20220328
riscv                randconfig-r042-20220328
hexagon              randconfig-r045-20220329
hexagon              randconfig-r045-20220328
hexagon              randconfig-r045-20220327
hexagon              randconfig-r041-20220327
hexagon              randconfig-r045-20220330
hexagon              randconfig-r041-20220329
hexagon              randconfig-r041-20220328
hexagon              randconfig-r041-20220330

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
