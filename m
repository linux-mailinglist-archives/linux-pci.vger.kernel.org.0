Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F464CA968
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 16:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbiCBPr7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 10:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237482AbiCBPr5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 10:47:57 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14A6C3C26
        for <linux-pci@vger.kernel.org>; Wed,  2 Mar 2022 07:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646236033; x=1677772033;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=bL6CyHyoaphBg+Mz7dCnZA4kWSMUHU5NE7J3IwUInxE=;
  b=OdCTiJa+qp65TJgy2YMyAj3SWDKtga6ppxxTsy8Die3zcqsJk58PAt5x
   wvgTVH6K39fvhdE4gb9U13kovT874bqbrlS6lS1FsiZWckC11Hb+2B/KI
   i1aBQNWVzV3Pa3WICPjVNJm1VEkGYqPVwcbU+8ZTZ6I9kOZDYK+/DfS3x
   HjrmNWkXQutaB3Jzuw98ZjkJtQ6VtGecb8DuYF8qZ7LAnrWQ0nExpLDq7
   JLOKUHhV5sG6Zh+MEyGbWQrahqX77NdfXmdfggsG23mcdcj9d4s+w9z76
   3gfhju5tEkjbSyqslyC3/B4ZWVU6kfFieuMIbubmXl8283E48B9G+tQXw
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="236940674"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="236940674"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 07:47:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="545536565"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 02 Mar 2022 07:47:11 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPRC3-0001Wh-2Y; Wed, 02 Mar 2022 15:47:11 +0000
Date:   Wed, 02 Mar 2022 23:46:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 b3c57902bef6a4da58cb0465e858f797a5885c1a
Message-ID: <621f9151.+XtQXnCLGPzJus1+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: b3c57902bef6a4da58cb0465e858f797a5885c1a  Merge branch 'remotes/lorenzo/pci/uniphier'

elapsed time: 720m

configs tested: 119
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
mips                 randconfig-c004-20220302
arm                           corgi_defconfig
parisc                generic-64bit_defconfig
powerpc64                        alldefconfig
arm                        multi_v7_defconfig
sh                           se7705_defconfig
sh                          r7780mp_defconfig
sh                           sh2007_defconfig
m68k                        mvme16x_defconfig
sh                              ul2_defconfig
sh                            migor_defconfig
microblaze                          defconfig
mips                         bigsur_defconfig
arm                         vf610m4_defconfig
h8300                               defconfig
m68k                          atari_defconfig
sh                   secureedge5410_defconfig
arm                          iop32x_defconfig
arc                     nsimosci_hs_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                      mgcoge_defconfig
powerpc                     taishan_defconfig
sparc64                          alldefconfig
arm                        shmobile_defconfig
sh                               j2_defconfig
powerpc                   currituck_defconfig
ia64                            zx1_defconfig
mips                      maltasmvp_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                     pq2fads_defconfig
sh                          sdk7786_defconfig
parisc64                         alldefconfig
powerpc                   motionpro_defconfig
arm                            qcom_defconfig
ia64                             alldefconfig
arm                        oxnas_v6_defconfig
m68k                        stmark2_defconfig
m68k                        m5307c3_defconfig
arc                      axs103_smp_defconfig
mips                     loongson1b_defconfig
arm                  randconfig-c002-20220302
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
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
arm                     davinci_all_defconfig
arm                       netwinder_defconfig
arm                        neponset_defconfig
arm                      pxa255-idp_defconfig
arm                        mvebu_v5_defconfig
arm                         lpc32xx_defconfig
mips                     cu1830-neo_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220302
hexagon              randconfig-r041-20220302

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
