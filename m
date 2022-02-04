Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782D74A95D9
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 10:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244908AbiBDJRP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 04:17:15 -0500
Received: from mga03.intel.com ([134.134.136.65]:60641 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233117AbiBDJRO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Feb 2022 04:17:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643966234; x=1675502234;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=kFGUI65I/0sy2Tt5YPathA15xhYyEu7LOoVV1m7Sm9Q=;
  b=WLwfKGaeEfvpgvXfl/km/ugE/wiFwj3onJWlF1Xo2iTcW8KamYCcvbgA
   1DEsJDQAwQHu3E/as1h0AvtVphU/meuAQHQjv+897fXWk6f+Z86+3PS1+
   yk6F5nipDxg6EU7+uPRdjQiLO1anLojG0kD2wR2qt3Ph2XFO02F6eMUGt
   3NgbNx1sQAV7wV9ctYuoNT58pH0GWONX18drIaNbCaiU2ntJEy/33209E
   +llyik9L9qb84EarXHiJrWwTfvPtFY02PGePHS59+8v2FU9kSkRT2MMn4
   etNj5dOgrLCepniuSE8r/Ug475EpdHFXmeesmF+lDTTVXAZQ2kCeOy5Iz
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="248287160"
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="248287160"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 01:17:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="566693963"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 Feb 2022 01:17:13 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFuiO-000XPP-Kp; Fri, 04 Feb 2022 09:17:12 +0000
Date:   Fri, 04 Feb 2022 17:16:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/hotplug] BUILD SUCCESS
 92912b175178c7e895f5e5e9f1e30ac30319162b
Message-ID: <61fceeff.sDX52kmlqiGX1g2Z%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/hotplug
branch HEAD: 92912b175178c7e895f5e5e9f1e30ac30319162b  PCI: pciehp: Clear cmd_busy bit in polling mode

elapsed time: 720m

configs tested: 158
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220131
i386                          randconfig-c001
m68k                          hp300_defconfig
sh                   sh7724_generic_defconfig
arc                    vdk_hs38_smp_defconfig
arm                        clps711x_defconfig
powerpc                 linkstation_defconfig
mips                            ar7_defconfig
powerpc                     rainier_defconfig
arm                           h5000_defconfig
powerpc                       maple_defconfig
m68k                        stmark2_defconfig
arc                        nsimosci_defconfig
ia64                         bigsur_defconfig
sh                           se7750_defconfig
sh                         microdev_defconfig
arc                            hsdk_defconfig
arm                         vf610m4_defconfig
sparc                            allyesconfig
powerpc                     mpc83xx_defconfig
powerpc                     stx_gp3_defconfig
mips                         bigsur_defconfig
powerpc                   currituck_defconfig
powerpc                     tqm8548_defconfig
powerpc                 canyonlands_defconfig
powerpc                      ep88xc_defconfig
arm                         lubbock_defconfig
mips                          rb532_defconfig
powerpc                      ppc40x_defconfig
parisc                           allyesconfig
sh                   rts7751r2dplus_defconfig
sh                           se7206_defconfig
nds32                               defconfig
arm                            qcom_defconfig
powerpc                     pq2fads_defconfig
m68k                            q40_defconfig
sh                              ul2_defconfig
s390                       zfcpdump_defconfig
sh                          lboxre2_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                ecovec24-romimage_defconfig
m68k                       m5249evb_defconfig
arm                             rpc_defconfig
xtensa                           allyesconfig
nios2                         10m50_defconfig
arm                  randconfig-c002-20220130
arm                  randconfig-c002-20220131
arm                  randconfig-c002-20220202
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
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
x86_64               randconfig-a004-20220131
x86_64               randconfig-a003-20220131
x86_64               randconfig-a001-20220131
x86_64               randconfig-a006-20220131
x86_64               randconfig-a005-20220131
x86_64               randconfig-a002-20220131
i386                 randconfig-a006-20220131
i386                 randconfig-a005-20220131
i386                 randconfig-a003-20220131
i386                 randconfig-a002-20220131
i386                 randconfig-a001-20220131
i386                 randconfig-a004-20220131
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220130
arc                  randconfig-r043-20220130
s390                 randconfig-r044-20220130
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
riscv                randconfig-c006-20220201
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220201
mips                 randconfig-c004-20220201
i386                          randconfig-c001
arm                  randconfig-c002-20220201
riscv                randconfig-c006-20220130
arm                  randconfig-c002-20220130
powerpc              randconfig-c003-20220130
mips                 randconfig-c004-20220130
arm                       imx_v4_v5_defconfig
powerpc                     ppa8548_defconfig
arm                         socfpga_defconfig
mips                          rm200_defconfig
arm                             mxs_defconfig
powerpc                   lite5200b_defconfig
arm                         shannon_defconfig
powerpc                     tqm5200_defconfig
arm                           sama7_defconfig
arm                       spear13xx_defconfig
mips                          ath79_defconfig
mips                        workpad_defconfig
powerpc                        icon_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a013-20220131
x86_64               randconfig-a015-20220131
x86_64               randconfig-a014-20220131
x86_64               randconfig-a016-20220131
x86_64               randconfig-a011-20220131
x86_64               randconfig-a012-20220131
i386                 randconfig-a011-20220131
i386                 randconfig-a013-20220131
i386                 randconfig-a014-20220131
i386                 randconfig-a012-20220131
i386                 randconfig-a015-20220131
i386                 randconfig-a016-20220131
riscv                randconfig-r042-20220131
hexagon              randconfig-r045-20220130
hexagon              randconfig-r045-20220131
hexagon              randconfig-r041-20220130
hexagon              randconfig-r041-20220131
s390                 randconfig-r044-20220131

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
