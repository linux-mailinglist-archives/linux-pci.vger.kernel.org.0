Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D414C449F
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 13:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240590AbiBYMam (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Feb 2022 07:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236770AbiBYMal (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Feb 2022 07:30:41 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6148B1C3D19
        for <linux-pci@vger.kernel.org>; Fri, 25 Feb 2022 04:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645792209; x=1677328209;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=i2m1TRy0RcDtgZROXZhe1QYBeb54AdEblG75tGnILy8=;
  b=OGAXdFJjNUvI4GkQYsph+KfOrsuRKK2DmVexQghF2Keh16Urg5nTMlJQ
   N6yqnVtWLMR27qWKDxOfKLI6+WtjOuWnRd5Xkdtv4yvBPDG2VUdtO0WE5
   SQxXdFHxEzGGIpkQc8UX6I3AAKvrqByueOrsmzl+q4QLgrVkgGU9dZjGI
   CSdaa02whjH4Xv+WEuI3s580NzAQ2JYXm+UxGIvr8AkB5SkEY6bfF4ona
   +vIgnQIyeDa1d9cI7LX5fF4iK2mZqIN6KQnGSnfAUkI50Sy54/S/oP7MB
   qBUOnwpf8/HXssHvTgAoUghgF8kZP8JY5lKOyEmPmi68W3KY/6qkWdHSA
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="233111111"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="233111111"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 04:30:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="628829856"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Feb 2022 04:30:07 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNZja-0004IV-Tr; Fri, 25 Feb 2022 12:30:06 +0000
Date:   Fri, 25 Feb 2022 20:29:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/bridge-class-codes] BUILD SUCCESS
 fe665816e0d4ff4945c8ca720278023a4d05a6b3
Message-ID: <6218cb90.xHuiftgY8w0M09Sa%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/bridge-class-codes
branch HEAD: fe665816e0d4ff4945c8ca720278023a4d05a6b3  PCI: iproc: Set all 24 bits of PCI class code

elapsed time: 720m

configs tested: 148
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
powerpc              randconfig-c003-20220225
mips                 randconfig-c004-20220225
m68k                        mvme16x_defconfig
sh                ecovec24-romimage_defconfig
sh                         microdev_defconfig
ia64                        generic_defconfig
h8300                    h8300h-sim_defconfig
openrisc                            defconfig
sh                        apsh4ad0a_defconfig
sh                  sh7785lcr_32bit_defconfig
h8300                     edosk2674_defconfig
sh                           se7751_defconfig
arm                         s3c6400_defconfig
arm                         assabet_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                         wii_defconfig
powerpc64                        alldefconfig
arc                      axs103_smp_defconfig
m68k                          atari_defconfig
x86_64                           alldefconfig
sh                           se7750_defconfig
xtensa                generic_kc705_defconfig
powerpc                 mpc834x_mds_defconfig
sh                     magicpanelr2_defconfig
mips                         rt305x_defconfig
arm                           sama5_defconfig
arm64                            alldefconfig
sh                            shmin_defconfig
sh                   sh7724_generic_defconfig
arc                           tb10x_defconfig
sh                           se7780_defconfig
arc                          axs103_defconfig
mips                         db1xxx_defconfig
powerpc                      bamboo_defconfig
m68k                         amcore_defconfig
arm                        keystone_defconfig
openrisc                         alldefconfig
powerpc                     redwood_defconfig
powerpc                        warp_defconfig
xtensa                    xip_kc705_defconfig
arc                    vdk_hs38_smp_defconfig
h8300                               defconfig
microblaze                      mmu_defconfig
powerpc                      tqm8xx_defconfig
arm                     eseries_pxa_defconfig
sh                           se7712_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                      pasemi_defconfig
m68k                          multi_defconfig
arm                            zeus_defconfig
arc                            hsdk_defconfig
arm                          gemini_defconfig
powerpc                     stx_gp3_defconfig
arc                     nsimosci_hs_defconfig
powerpc                     tqm8555_defconfig
arm                  randconfig-c002-20220224
arm                  randconfig-c002-20220223
arm                  randconfig-c002-20220225
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
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
s390                 randconfig-r044-20220224
arc                  randconfig-r043-20220224
arc                  randconfig-r043-20220223
riscv                randconfig-r042-20220224
riscv                    nommu_k210_defconfig
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
powerpc              randconfig-c003-20220225
x86_64                        randconfig-c007
arm                  randconfig-c002-20220225
mips                 randconfig-c004-20220225
i386                          randconfig-c001
riscv                randconfig-c006-20220225
powerpc              randconfig-c003-20220224
arm                  randconfig-c002-20220224
mips                 randconfig-c004-20220224
riscv                randconfig-c006-20220224
arm                           sama7_defconfig
riscv                    nommu_virt_defconfig
i386                             allyesconfig
arm                         orion5x_defconfig
arm                                 defconfig
arm                         hackkit_defconfig
powerpc                    mvme5100_defconfig
powerpc                     tqm8560_defconfig
arm                        magician_defconfig
powerpc                          allyesconfig
arm                         palmz72_defconfig
mips                     loongson2k_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220225
hexagon              randconfig-r041-20220225
riscv                randconfig-r042-20220225
hexagon              randconfig-r045-20220224
hexagon              randconfig-r041-20220224

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
