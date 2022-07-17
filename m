Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B26C577512
	for <lists+linux-pci@lfdr.de>; Sun, 17 Jul 2022 10:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiGQIZa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 17 Jul 2022 04:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGQIZ3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Jul 2022 04:25:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60E7140A4
        for <linux-pci@vger.kernel.org>; Sun, 17 Jul 2022 01:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658046329; x=1689582329;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=k7KqN5CXYIllVfX/ceqjmppi7s21O5abh2RCpyIp9FU=;
  b=Ql/+wfqSOwZXC7mTAzrCmVi7JFuqemml96+hG2kyqNJIIjjeyDIH0YHC
   +wwiIeeBtPU/pJ7zV6zqWtYL9W+cQO1yzJRoYjGJadUf691c4/+L6HOIK
   WtXbzkjEbJQlQPn0sokn+HmrCU6zPypTzp5kjM1qFEjYcCIIB2AISNbYL
   EdRRQNNmo71jc/DuhaG87jMWUjxcQTws261RgWb18DwTth5T/ndF/KeDS
   Bd8Ps0rMOAGUcii2dZOWJkqBqzfhnJ/GknyEAUDdUQSBNiBB2LAVjWjSp
   6bVucc18yEnTNFu0NuhHtPTX8cJSe6gYwrIGjdObVRXEW3VLJDY/fPS3U
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="284796872"
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="284796872"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 01:25:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="572042698"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 17 Jul 2022 01:25:22 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCzab-000313-Tb;
        Sun, 17 Jul 2022 08:25:21 +0000
Date:   Sun, 17 Jul 2022 16:25:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 778aca71a6c0212a91ad22e8389345533e9bbcac
Message-ID: <62d3c76b.09gHC0LYBqrqTAHz%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 778aca71a6c0212a91ad22e8389345533e9bbcac  Merge branch 'pci/misc'

elapsed time: 1977m

configs tested: 171
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20220717
arm                      footbridge_defconfig
xtensa                              defconfig
openrisc                    or1ksim_defconfig
arm                        mvebu_v7_defconfig
powerpc                 mpc85xx_cds_defconfig
parisc                generic-32bit_defconfig
mips                      loongson3_defconfig
powerpc                        cell_defconfig
powerpc                      chrp32_defconfig
loongarch                           defconfig
mips                       bmips_be_defconfig
sh                          landisk_defconfig
powerpc                      pcm030_defconfig
sh                         microdev_defconfig
arm                            lart_defconfig
sh                         ecovec24_defconfig
arm                     eseries_pxa_defconfig
sh                         ap325rxa_defconfig
arm                          gemini_defconfig
arm                           sama5_defconfig
xtensa                generic_kc705_defconfig
xtensa                  nommu_kc705_defconfig
arm                            mps2_defconfig
mips                           jazz_defconfig
arm                          simpad_defconfig
arm                       multi_v4t_defconfig
powerpc                     ep8248e_defconfig
sh                        sh7763rdp_defconfig
mips                    maltaup_xpa_defconfig
arm64                               defconfig
sparc64                          alldefconfig
um                             i386_defconfig
arm                      jornada720_defconfig
arm                        keystone_defconfig
powerpc                      tqm8xx_defconfig
xtensa                    xip_kc705_defconfig
powerpc                     tqm8555_defconfig
sh                        sh7785lcr_defconfig
mips                             allyesconfig
sh                           se7750_defconfig
arm                        spear6xx_defconfig
powerpc                     tqm8548_defconfig
arm                         lpc18xx_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                          urquell_defconfig
ia64                             alldefconfig
openrisc                 simple_smp_defconfig
sh                           se7721_defconfig
m68k                        mvme147_defconfig
sh                          polaris_defconfig
powerpc                  storcenter_defconfig
arc                            hsdk_defconfig
i386                                defconfig
sh                   secureedge5410_defconfig
powerpc                    sam440ep_defconfig
mips                         tb0226_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
arm                              allmodconfig
m68k                                defconfig
ia64                                defconfig
mips                             allmodconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
x86_64                        randconfig-c001
arm                  randconfig-c002-20220715
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
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                        randconfig-a013
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                       rbtx49xx_defconfig
mips                     cu1830-neo_defconfig
powerpc                     tqm5200_defconfig
mips                        qi_lb60_defconfig
powerpc                     kilauea_defconfig
i386                             allyesconfig
arm                    vt8500_v6_v7_defconfig
mips                      pic32mzda_defconfig
mips                           mtx1_defconfig
powerpc                      ppc64e_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                    mvme5100_defconfig
arm                       aspeed_g4_defconfig
arm                          moxart_defconfig
powerpc                     ppa8548_defconfig
mips                      maltaaprp_defconfig
arm                        multi_v5_defconfig
arm                       imx_v4_v5_defconfig
riscv                          rv32_defconfig
mips                        workpad_defconfig
arm                        mvebu_v5_defconfig
arm                         bcm2835_defconfig
powerpc                    socrates_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                      malta_kvm_defconfig
mips                           ip28_defconfig
mips                  cavium_octeon_defconfig
arm                       netwinder_defconfig
mips                       lemote2f_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                    ge_imp3a_defconfig
arm                          collie_defconfig
mips                     loongson1c_defconfig
arm                         orion5x_defconfig
powerpc                      obs600_defconfig
arm                            dove_defconfig
arm                     davinci_all_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220716
hexagon              randconfig-r045-20220715
s390                 randconfig-r044-20220715
hexagon              randconfig-r041-20220716
hexagon              randconfig-r041-20220715
riscv                randconfig-r042-20220715

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
