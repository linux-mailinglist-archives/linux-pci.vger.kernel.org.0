Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC4E4D7E56
	for <lists+linux-pci@lfdr.de>; Mon, 14 Mar 2022 10:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbiCNJTr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Mar 2022 05:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237783AbiCNJTq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Mar 2022 05:19:46 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0FC427F1
        for <linux-pci@vger.kernel.org>; Mon, 14 Mar 2022 02:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647249515; x=1678785515;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=mgH1cnq4Vr7dnCvR21fXWThVx4izi/NwcZ6mhSgABB8=;
  b=Gku8eFHjJFGqMv4sNkeu6U4yLHdgNEwQzHkSRXPa3iVLdHw8c4PG1t7W
   SN8wAuPyW92vEpkxGiBub3fITC9nt5Sc4blrAFA1RYWhnZ++QWJkuGoKI
   YETzDSD34MSQ4nbqqXZnr7aCL4vxrQiQyYbAIL71QQwKpGmW+ftOKcEpS
   iZAzPqFGF/a4rG0FZSYnqblJTqCpDIajhv8e7GQ9ymBGRF6aUDdYKnLD/
   DMaCrDcnNixhdqgBipNRjofwuDQe+IPU6hHj6YEBzFZOB5g2/WMn6laUc
   lwpVy6RUeFGFwiVy3V//Om0xtbzFQJQhZtZ0KEyvoKcY4/6yvNGxWDlgA
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="316699842"
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="316699842"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 02:18:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="580048604"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 14 Mar 2022 02:18:33 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTgqX-0009lC-3R; Mon, 14 Mar 2022 09:18:33 +0000
Date:   Mon, 14 Mar 2022 17:18:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/misc] BUILD SUCCESS
 d6ef10c59bbdbbe653bd072910e323c2c239e3e8
Message-ID: <622f085a.3eqYyim2yxxahn6D%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/misc
branch HEAD: d6ef10c59bbdbbe653bd072910e323c2c239e3e8  PCI: ibmphp: Remove unused assignments

elapsed time: 761m

configs tested: 159
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
powerpc              randconfig-c003-20220313
arm                            zeus_defconfig
sh                                  defconfig
mips                           xway_defconfig
arm                          pxa910_defconfig
m68k                          multi_defconfig
arm                       omap2plus_defconfig
powerpc                     ep8248e_defconfig
powerpc                     tqm8555_defconfig
powerpc                 linkstation_defconfig
powerpc                      bamboo_defconfig
arm                           u8500_defconfig
m68k                                defconfig
um                           x86_64_defconfig
alpha                            allyesconfig
ia64                         bigsur_defconfig
arm                           corgi_defconfig
mips                     decstation_defconfig
um                               alldefconfig
powerpc                 mpc834x_mds_defconfig
nios2                               defconfig
sh                            migor_defconfig
xtensa                  nommu_kc705_defconfig
arc                           tb10x_defconfig
powerpc                       maple_defconfig
sh                      rts7751r2d1_defconfig
nds32                               defconfig
powerpc                    amigaone_defconfig
arm                        cerfcube_defconfig
sh                           se7721_defconfig
h8300                       h8s-sim_defconfig
sh                            hp6xx_defconfig
powerpc                 mpc837x_mds_defconfig
s390                          debug_defconfig
m68k                         amcore_defconfig
powerpc                     tqm8548_defconfig
s390                             allyesconfig
powerpc                         ps3_defconfig
parisc                              defconfig
arm                            hisi_defconfig
ia64                            zx1_defconfig
sh                     sh7710voipgw_defconfig
ia64                             allmodconfig
powerpc                 mpc8540_ads_defconfig
sh                          sdk7780_defconfig
x86_64                              defconfig
arm                           h3600_defconfig
arm                            lart_defconfig
mips                 decstation_r4k_defconfig
arm                  randconfig-c002-20220313
arm                  randconfig-c002-20220314
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                               defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20220314
x86_64               randconfig-a005-20220314
x86_64               randconfig-a003-20220314
x86_64               randconfig-a002-20220314
x86_64               randconfig-a006-20220314
x86_64               randconfig-a001-20220314
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                 randconfig-a003-20220314
i386                 randconfig-a004-20220314
i386                 randconfig-a001-20220314
i386                 randconfig-a006-20220314
i386                 randconfig-a002-20220314
i386                 randconfig-a005-20220314
arc                  randconfig-r043-20220313
riscv                randconfig-r042-20220313
s390                 randconfig-r044-20220313
arc                  randconfig-r043-20220314
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                    nommu_virt_defconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220313
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220313
riscv                randconfig-c006-20220313
mips                 randconfig-c004-20220313
i386                          randconfig-c001
s390                 randconfig-c005-20220313
mips                     loongson2k_defconfig
mips                     cu1000-neo_defconfig
arm                        multi_v5_defconfig
powerpc                      obs600_defconfig
powerpc                      ppc64e_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                      ppc44x_defconfig
arm                         shannon_defconfig
powerpc                     mpc512x_defconfig
powerpc                     kilauea_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a014-20220314
x86_64               randconfig-a015-20220314
x86_64               randconfig-a016-20220314
x86_64               randconfig-a012-20220314
x86_64               randconfig-a013-20220314
x86_64               randconfig-a011-20220314
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
i386                 randconfig-a013-20220314
i386                 randconfig-a015-20220314
i386                 randconfig-a014-20220314
i386                 randconfig-a011-20220314
i386                 randconfig-a016-20220314
i386                 randconfig-a012-20220314
hexagon              randconfig-r045-20220314
hexagon              randconfig-r045-20220313
riscv                randconfig-r042-20220314
hexagon              randconfig-r041-20220313
hexagon              randconfig-r041-20220314
s390                 randconfig-r044-20220314

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
