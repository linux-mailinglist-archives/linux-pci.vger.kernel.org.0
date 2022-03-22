Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622874E3DE5
	for <lists+linux-pci@lfdr.de>; Tue, 22 Mar 2022 12:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbiCVMAD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Mar 2022 08:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbiCVMAA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Mar 2022 08:00:00 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF4883B15
        for <linux-pci@vger.kernel.org>; Tue, 22 Mar 2022 04:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647950309; x=1679486309;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=p0mvH1pUsNXhmMMjiEqM7w9ryI4bnfMWklt7cXP7wk8=;
  b=kj0J/4fl/3y4HcAsgdqXZs7cTPKyYHu+KczmykNMig4PI/QeLd32BMdB
   ZhuxrUQp6qCkQovFoJUXhJHrjmR0ZIEy+IP386pB7BuI7Q2Z8H1vzxvoA
   vJdlv/np3qrHuXrKHSq3Zgz4v0IsSnQYYtWl5LNZfehWkd8WPcOsscIsA
   uGx3j9vgWculMLmcKJB3QKPAHA1DX68A20/NDVkki4K5kHjy06jq/4xk/
   RzxYCv3/B/GKKYaVk+CSI32SA5o1pTDfzFztGarf1+SBlodPcYk9dzvEW
   wcNxyT6L9EvSjFxHkkkV1D8lfAD7214hfnNdx96f3YknoHhuGYUEMbobm
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="257747791"
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="257747791"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 04:58:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="543663181"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 22 Mar 2022 04:58:27 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWd9f-000IkB-8J; Tue, 22 Mar 2022 11:58:27 +0000
Date:   Tue, 22 Mar 2022 19:58:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 29d0071ad0b46bd51e59be912fba0037116a5660
Message-ID: <6239b9df.XMEydT5vNJloy1FF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 29d0071ad0b46bd51e59be912fba0037116a5660  Merge branch 'remotes/lorenzo/pci/xgene'

elapsed time: 727m

configs tested: 167
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220321
i386                          randconfig-c001
mips                 randconfig-c004-20220320
arm                        keystone_defconfig
sparc                       sparc32_defconfig
h8300                               defconfig
powerpc                 mpc85xx_cds_defconfig
arm                         nhk8815_defconfig
m68k                          hp300_defconfig
powerpc                 canyonlands_defconfig
m68k                        m5272c3_defconfig
sh                           se7721_defconfig
sh                        edosk7705_defconfig
s390                             allyesconfig
arm                          exynos_defconfig
sh                         ecovec24_defconfig
arm                          lpd270_defconfig
m68k                             allyesconfig
sh                            titan_defconfig
powerpc                   currituck_defconfig
ia64                      gensparse_defconfig
sh                        sh7785lcr_defconfig
xtensa                  nommu_kc705_defconfig
mips                         rt305x_defconfig
openrisc                  or1klitex_defconfig
powerpc                 mpc837x_mds_defconfig
sh                      rts7751r2d1_defconfig
sh                        edosk7760_defconfig
arc                        nsimosci_defconfig
sh                          rsk7201_defconfig
nios2                               defconfig
arm                             pxa_defconfig
arc                           tb10x_defconfig
parisc64                            defconfig
arc                 nsimosci_hs_smp_defconfig
sh                               j2_defconfig
sh                          r7780mp_defconfig
mips                     loongson1b_defconfig
parisc                generic-64bit_defconfig
m68k                          sun3x_defconfig
sh                        apsh4ad0a_defconfig
h8300                     edosk2674_defconfig
sh                         microdev_defconfig
sh                              ul2_defconfig
um                                  defconfig
powerpc                 mpc834x_itx_defconfig
sh                             sh03_defconfig
powerpc                     rainier_defconfig
arm                         vf610m4_defconfig
arm                     eseries_pxa_defconfig
sparc                            allyesconfig
arc                            hsdk_defconfig
powerpc                      ppc40x_defconfig
xtensa                    xip_kc705_defconfig
um                               alldefconfig
mips                        vocore2_defconfig
mips                           ci20_defconfig
nds32                               defconfig
arm                            hisi_defconfig
m68k                        mvme147_defconfig
arm                  randconfig-c002-20220321
arm                  randconfig-c002-20220320
arm                  randconfig-c002-20220322
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
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
x86_64               randconfig-a016-20220321
x86_64               randconfig-a011-20220321
x86_64               randconfig-a012-20220321
x86_64               randconfig-a013-20220321
x86_64               randconfig-a014-20220321
x86_64               randconfig-a015-20220321
i386                 randconfig-a015-20220321
i386                 randconfig-a016-20220321
i386                 randconfig-a013-20220321
i386                 randconfig-a012-20220321
i386                 randconfig-a014-20220321
i386                 randconfig-a011-20220321
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
mips                 randconfig-c004-20220320
arm                  randconfig-c002-20220320
powerpc              randconfig-c003-20220320
riscv                randconfig-c006-20220320
i386                          randconfig-c001
arm                  randconfig-c002-20220322
powerpc              randconfig-c003-20220322
riscv                randconfig-c006-20220322
arm                        neponset_defconfig
arm                       spear13xx_defconfig
mips                         tb0287_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                     tqm8540_defconfig
arm64                            allyesconfig
arm                        mvebu_v5_defconfig
powerpc                        fsp2_defconfig
arm                     am200epdkit_defconfig
hexagon                             defconfig
mips                        omega2p_defconfig
mips                       lemote2f_defconfig
x86_64               randconfig-a001-20220321
x86_64               randconfig-a003-20220321
x86_64               randconfig-a005-20220321
x86_64               randconfig-a004-20220321
x86_64               randconfig-a002-20220321
x86_64               randconfig-a006-20220321
i386                 randconfig-a001-20220321
i386                 randconfig-a006-20220321
i386                 randconfig-a003-20220321
i386                 randconfig-a005-20220321
i386                 randconfig-a004-20220321
i386                 randconfig-a002-20220321
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
riscv                randconfig-r042-20220320
hexagon              randconfig-r045-20220321
hexagon              randconfig-r045-20220320
hexagon              randconfig-r041-20220321
hexagon              randconfig-r041-20220320
riscv                randconfig-r042-20220322
hexagon              randconfig-r045-20220322
hexagon              randconfig-r041-20220322

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
