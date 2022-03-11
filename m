Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012A54D64AC
	for <lists+linux-pci@lfdr.de>; Fri, 11 Mar 2022 16:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349326AbiCKPcZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Mar 2022 10:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349365AbiCKPcV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Mar 2022 10:32:21 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3C51C1EE7
        for <linux-pci@vger.kernel.org>; Fri, 11 Mar 2022 07:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647012677; x=1678548677;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=HRGrT0Rqop8NREy0mbHmxph4Q2pl36Uw1WQBOogRj5Q=;
  b=Bf+njz2g7l5ttRygs9h1whjF02ygsDUaxDq6qVMdu7KGCoL6x+mrlty8
   Z3AfBUbBw/vXj9lqBlVEy68uQhYdTu0weF+IAS/T/BG3H6rfamail16hq
   hVA/ThoZZalTiDO2BDaupfGEkhOFg+6sVNhFhzGwkBP93lUV+O4k+g7Pm
   XzkSxc3TclE5GyqUEfBrhwOnGLU9BmRJdWWQtlm6NjTOFfk0t4gNg1HH3
   82sUXK/uPaIabZd1BTn3JGHs5tX4ZZWVmyeRzKB+Ibp+Kmu/straZ9JpD
   +GkvwTWVsilmURanasY+zEWJmaFu9L2hJ7zLYhjf/WGQHDHqsobUcXdyL
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="235543688"
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="235543688"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 07:31:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="597141640"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 11 Mar 2022 07:31:16 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nShEZ-0006cm-Pc; Fri, 11 Mar 2022 15:31:15 +0000
Date:   Fri, 11 Mar 2022 23:31:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/host/dwc] BUILD SUCCESS
 815953dc2011ad7a34de355dfa703dcef1085219
Message-ID: <622b6b38.J0on82dhK5o2UzL/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/host/dwc
branch HEAD: 815953dc2011ad7a34de355dfa703dcef1085219  PCI: dwc: Restore MSI Receiver mask during resume

elapsed time: 742m

configs tested: 121
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
nios2                         3c120_defconfig
sparc                            allyesconfig
arm                            lart_defconfig
sh                            titan_defconfig
sh                            shmin_defconfig
m68k                          multi_defconfig
arm                         cm_x300_defconfig
arm                     eseries_pxa_defconfig
sh                   sh7770_generic_defconfig
powerpc                     tqm8548_defconfig
mips                  maltasmvp_eva_defconfig
sh                             sh03_defconfig
powerpc                     ep8248e_defconfig
xtensa                          iss_defconfig
openrisc                  or1klitex_defconfig
sh                          sdk7780_defconfig
arm                             rpc_defconfig
arm                      jornada720_defconfig
powerpc                 mpc8540_ads_defconfig
xtensa                       common_defconfig
sh                           se7750_defconfig
arm                        shmobile_defconfig
arc                    vdk_hs38_smp_defconfig
arm                          badge4_defconfig
sh                           se7206_defconfig
arc                          axs103_defconfig
sh                               allmodconfig
arm                          pxa3xx_defconfig
openrisc                         alldefconfig
powerpc                       holly_defconfig
powerpc                 mpc837x_mds_defconfig
arm                         s3c6400_defconfig
arm                        keystone_defconfig
h8300                    h8300h-sim_defconfig
arm                  randconfig-c002-20220310
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
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
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
arm                  randconfig-c002-20220310
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220310
riscv                randconfig-c006-20220310
mips                 randconfig-c004-20220310
i386                          randconfig-c001
powerpc                     tqm8540_defconfig
mips                       lemote2f_defconfig
mips                     cu1830-neo_defconfig
arm                          ixp4xx_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                    vt8500_v6_v7_defconfig
hexagon                          alldefconfig
arm                         orion5x_defconfig
powerpc                     ppa8548_defconfig
arm                     davinci_all_defconfig
mips                           mtx1_defconfig
arm                          collie_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220310
hexagon              randconfig-r041-20220310
riscv                randconfig-r042-20220310

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
