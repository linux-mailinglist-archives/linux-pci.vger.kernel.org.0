Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B444D571B
	for <lists+linux-pci@lfdr.de>; Fri, 11 Mar 2022 02:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242409AbiCKBFG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 20:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237426AbiCKBFG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 20:05:06 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F4FCF3A2
        for <linux-pci@vger.kernel.org>; Thu, 10 Mar 2022 17:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646960644; x=1678496644;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=KC6VvDOYUnveIP8GpoxQkAbnBqAYJ3EawHWbOw7E5m4=;
  b=G30lQet8Z+BnSjT5XQoFfHd2DooBtpcUk67cU4l+rGFXHpDv2AZ741Tl
   uqqehwcEpw2ibDlK1IvtCAEBgNX3Vnth6z3Do+0croGLy8vibNaZx8Vat
   c083+KKDtXSNLFiPX2ik/BTqsLBbk4LVEdvVtL+YW42COUPwdPIHY4YdK
   xZE27hEkJsXzEdmhpKzkrvbuhBQgobOZ62z3MJmVjChLtWtaVmEPMJqPE
   d61LvIzYXVpAUbsp2IEzIGCboahkZ/LelxGtRKh+iPSIZWobuM+EBdYs+
   aSuVMDERsABZJQPX4qUMBZqaODwuxXFNiUk4EuzBZUNGoaNMIj8uwDPpR
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="253023931"
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="253023931"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 17:02:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="511165283"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 10 Mar 2022 17:02:10 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSTfW-0005b0-0z; Fri, 11 Mar 2022 01:02:10 +0000
Date:   Fri, 11 Mar 2022 09:01:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:for-linus] BUILD SUCCESS
 f8b4c73e2c4d602c1310356095cf1b406149dbc8
Message-ID: <622a9f7c.XU2o60mNwoMM1rqO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
branch HEAD: f8b4c73e2c4d602c1310356095cf1b406149dbc8  x86/PCI: Preserve host bridge windows completely covered by E820

elapsed time: 724m

configs tested: 141
configs skipped: 71

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
x86_64                              defconfig
nios2                         3c120_defconfig
sparc                            allyesconfig
arm                            lart_defconfig
sh                            shmin_defconfig
m68k                          multi_defconfig
sh                            titan_defconfig
mips                  maltasmvp_eva_defconfig
sh                             sh03_defconfig
powerpc                     ep8248e_defconfig
xtensa                          iss_defconfig
powerpc                           allnoconfig
xtensa                         virt_defconfig
sh                          rsk7203_defconfig
m68k                       m5208evb_defconfig
sh                          r7785rp_defconfig
ia64                         bigsur_defconfig
arm                          iop32x_defconfig
m68k                        mvme147_defconfig
um                               alldefconfig
openrisc                  or1klitex_defconfig
sh                          sdk7780_defconfig
arm                             rpc_defconfig
arm                      jornada720_defconfig
arm                         lpc18xx_defconfig
arc                         haps_hs_defconfig
sh                           se7750_defconfig
arm                        shmobile_defconfig
arc                    vdk_hs38_smp_defconfig
arm                          badge4_defconfig
sh                               j2_defconfig
arm                           tegra_defconfig
arc                        nsim_700_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                 canyonlands_defconfig
sh                        edosk7705_defconfig
powerpc                     redwood_defconfig
alpha                            alldefconfig
arm                        spear6xx_defconfig
mips                            gpr_defconfig
mips                         db1xxx_defconfig
sh                               allmodconfig
arm                          pxa3xx_defconfig
openrisc                         alldefconfig
powerpc                       holly_defconfig
powerpc                 mpc837x_mds_defconfig
arm                         s3c6400_defconfig
arm                        keystone_defconfig
h8300                    h8300h-sim_defconfig
powerpc                     tqm8548_defconfig
ia64                                defconfig
arm                  randconfig-c002-20220310
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
arm                      tct_hammer_defconfig
arm                             mxs_defconfig
powerpc                          g5_defconfig
powerpc                     tqm8540_defconfig
mips                       lemote2f_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                  mpc866_ads_defconfig
arm                       cns3420vb_defconfig
arm                    vt8500_v6_v7_defconfig
hexagon                          alldefconfig
arm                       aspeed_g4_defconfig
powerpc                 mpc832x_mds_defconfig
arm                         orion5x_defconfig
powerpc                     ppa8548_defconfig
arm                     davinci_all_defconfig
mips                           mtx1_defconfig
arm                          collie_defconfig
powerpc                 mpc8313_rdb_defconfig
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
