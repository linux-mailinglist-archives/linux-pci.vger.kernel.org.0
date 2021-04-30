Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3007336F6C9
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 09:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhD3H7r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 03:59:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:5596 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230335AbhD3H7r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Apr 2021 03:59:47 -0400
IronPort-SDR: KsMbvi+KMKGy/43p4G0Cq+Vx7BsVWpy67/GMBKZZumYb4lhZQb4iOb+GEIWuJjKVARn7R6+AU+
 LDE6i1mYsSdA==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="194035983"
X-IronPort-AV: E=Sophos;i="5.82,262,1613462400"; 
   d="scan'208";a="194035983"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2021 00:58:58 -0700
IronPort-SDR: jMQA4yj1Sb4QTkHW82V/e+eebq0GkT3637wt42QFU4ZsckkzECvVQs1OoPIHwNs1LMdkh69eey
 v5W9JNokpE5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,262,1613462400"; 
   d="scan'208";a="537688786"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 30 Apr 2021 00:58:57 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lcO36-00084x-FU; Fri, 30 Apr 2021 07:58:56 +0000
Date:   Fri, 30 Apr 2021 15:58:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS 2af60045b06952b5d3c218053af92d96d7b8af68
Message-ID: <608bb89c.XIzkyV4E3xsGmmTG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 2af60045b06952b5d3c218053af92d96d7b8af68  Merge branch 'pci/tegra'

elapsed time: 722m

configs tested: 136
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
mips                     cu1830-neo_defconfig
nios2                         3c120_defconfig
sh                               j2_defconfig
arm                            hisi_defconfig
arm                          ixp4xx_defconfig
arm                           omap1_defconfig
arm                        mvebu_v7_defconfig
arm                         mv78xx0_defconfig
arc                        nsimosci_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                      tqm8xx_defconfig
m68k                       m5249evb_defconfig
arm64                            alldefconfig
um                             i386_defconfig
powerpc                 mpc836x_rdk_defconfig
xtensa                    xip_kc705_defconfig
m68k                       m5208evb_defconfig
powerpc                 linkstation_defconfig
arm                       aspeed_g5_defconfig
i386                             alldefconfig
powerpc                   bluestone_defconfig
powerpc                     ksi8560_defconfig
arm                          simpad_defconfig
ia64                                defconfig
arm                             mxs_defconfig
arm                      pxa255-idp_defconfig
sh                        edosk7705_defconfig
arm                  colibri_pxa300_defconfig
arm                      tct_hammer_defconfig
powerpc                     tqm5200_defconfig
arm                           h3600_defconfig
powerpc64                           defconfig
powerpc                     mpc512x_defconfig
s390                          debug_defconfig
sh                          polaris_defconfig
sh                          sdk7786_defconfig
m68k                         amcore_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                 mpc8540_ads_defconfig
sh                        sh7763rdp_defconfig
powerpc                   lite5200b_defconfig
arm                        neponset_defconfig
m68k                            q40_defconfig
arc                              alldefconfig
m68k                        m5272c3_defconfig
openrisc                 simple_smp_defconfig
powerpc                     ppa8548_defconfig
arc                          axs103_defconfig
powerpc                 mpc8272_ads_defconfig
sh                        edosk7760_defconfig
sh                   sh7770_generic_defconfig
sh                            hp6xx_defconfig
arm                          lpd270_defconfig
openrisc                    or1ksim_defconfig
mips                            ar7_defconfig
arc                            hsdk_defconfig
sh                            shmin_defconfig
arm                         s3c2410_defconfig
arm                           sunxi_defconfig
ia64                             allmodconfig
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
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210429
x86_64               randconfig-a002-20210429
x86_64               randconfig-a005-20210429
x86_64               randconfig-a006-20210429
x86_64               randconfig-a001-20210429
x86_64               randconfig-a003-20210429
i386                 randconfig-a005-20210429
i386                 randconfig-a002-20210429
i386                 randconfig-a001-20210429
i386                 randconfig-a006-20210429
i386                 randconfig-a003-20210429
i386                 randconfig-a004-20210429
i386                 randconfig-a012-20210429
i386                 randconfig-a014-20210429
i386                 randconfig-a013-20210429
i386                 randconfig-a011-20210429
i386                 randconfig-a015-20210429
i386                 randconfig-a016-20210429
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210429
x86_64               randconfig-a016-20210429
x86_64               randconfig-a011-20210429
x86_64               randconfig-a014-20210429
x86_64               randconfig-a013-20210429
x86_64               randconfig-a012-20210429

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
