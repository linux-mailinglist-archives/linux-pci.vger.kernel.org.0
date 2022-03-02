Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30D54C9C51
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 04:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbiCBDqY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Mar 2022 22:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbiCBDqX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Mar 2022 22:46:23 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3584D628
        for <linux-pci@vger.kernel.org>; Tue,  1 Mar 2022 19:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646192740; x=1677728740;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Q/WVc0EIFWVoyZokhf5h4jcKxrjWtwyAFtOLeeF3CcI=;
  b=QHPMLwXiXlJZXsWJEZSW3bfrwa4NTRFT/oSdK/f9BxBkL3OC4ayCZRh2
   ahuo5HlY4hoeG/zvA6s2746WwaMe0PnzFmeu+hc0BzZcgIvsitlbrGSoI
   S8MQCDXaGFEck9k6ZGfQ+MPunYW2LdIXGDjg2ZsaTXzX8BM7r3QjhIMVS
   8hSv+tjwwg4jQryhAALiZZic/3H4GpQmm6LZoeaPiOWxBLKmcH66KWgzR
   wcEn/nWYKoTbfkaRSKTywSPwObNaHt+5sH6xJNtPm0MEtB+EzoMyfOrZw
   vXo/jy7UVldOkUn57ARj6MSYUuDnqr900wBwuxSMIZZTWHZH1nMx/b0Yo
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="250880128"
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="250880128"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 19:45:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="510841614"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 01 Mar 2022 19:45:39 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPFvm-00010o-6O; Wed, 02 Mar 2022 03:45:38 +0000
Date:   Wed, 02 Mar 2022 11:45:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 404bae20277a47a4f5421417a8cd515b0b2b3444
Message-ID: <621ee850.O5M9XnfCwijxkd74%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 404bae20277a47a4f5421417a8cd515b0b2b3444  Merge branch 'remotes/lorenzo/pci/uniphier'

elapsed time: 728m

configs tested: 146
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
powerpc                         ps3_defconfig
arm                       multi_v4t_defconfig
h8300                            allyesconfig
m68k                          hp300_defconfig
powerpc                 mpc834x_itx_defconfig
arc                                 defconfig
openrisc                  or1klitex_defconfig
ia64                            zx1_defconfig
arm                     eseries_pxa_defconfig
powerpc                      mgcoge_defconfig
arc                    vdk_hs38_smp_defconfig
mips                        vocore2_defconfig
powerpc                      tqm8xx_defconfig
arm                         nhk8815_defconfig
sh                           se7722_defconfig
sh                               alldefconfig
powerpc                     ep8248e_defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                              defconfig
arm                        oxnas_v6_defconfig
arc                           tb10x_defconfig
arm                           h5000_defconfig
xtensa                       common_defconfig
mips                         db1xxx_defconfig
xtensa                  audio_kc705_defconfig
powerpc                        cell_defconfig
arm                        trizeps4_defconfig
sh                          polaris_defconfig
sh                          urquell_defconfig
arm                          gemini_defconfig
sh                        sh7757lcr_defconfig
mips                            ar7_defconfig
powerpc                      arches_defconfig
powerpc                        warp_defconfig
mips                           ip32_defconfig
sh                            hp6xx_defconfig
mips                      maltasmvp_defconfig
arm                            zeus_defconfig
arm                         assabet_defconfig
sh                           se7343_defconfig
mips                  decstation_64_defconfig
sh                            migor_defconfig
m68k                        stmark2_defconfig
i386                                defconfig
powerpc                     taishan_defconfig
mips                     decstation_defconfig
arm                       imx_v6_v7_defconfig
microblaze                          defconfig
m68k                          multi_defconfig
arm                         axm55xx_defconfig
sh                         ecovec24_defconfig
sh                           se7780_defconfig
arm                  randconfig-c002-20220301
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
arc                  randconfig-r043-20220301
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
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220301
riscv                randconfig-c006-20220301
i386                          randconfig-c001
arm                  randconfig-c002-20220301
mips                 randconfig-c004-20220301
powerpc                     mpc5200_defconfig
arm                                 defconfig
powerpc                  mpc866_ads_defconfig
arm                          imote2_defconfig
mips                     cu1830-neo_defconfig
mips                      pic32mzda_defconfig
mips                           rs90_defconfig
powerpc                      walnut_defconfig
riscv                    nommu_virt_defconfig
arm                         bcm2835_defconfig
arm                         palmz72_defconfig
arm                         orion5x_defconfig
arm                        spear3xx_defconfig
powerpc                     mpc512x_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220301
hexagon              randconfig-r041-20220301
riscv                randconfig-r042-20220301
s390                 randconfig-r044-20220301

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
