Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00C94D5C0F
	for <lists+linux-pci@lfdr.de>; Fri, 11 Mar 2022 08:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344316AbiCKHOj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Mar 2022 02:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbiCKHOj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Mar 2022 02:14:39 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C23113DA2
        for <linux-pci@vger.kernel.org>; Thu, 10 Mar 2022 23:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646982815; x=1678518815;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=h3jsbdK933DvKwiUmiqwoc59xG9nVz0i0jqwI23NqDk=;
  b=Y2mcLX/Kdz+hPE5boglElaboVpRJ3RUfPFH7BlAma9gqRboZ8arZQitH
   hO4YGalw59vMb3ofIJCFthpb1Gggdjxgu/82vRtBKujVVkkgI0gp9baXp
   FbcBBLpKIpJT1wDK54BiHZaw+35j42Q/KVGjNo7k+a1XZ7cJnFoWc+Xra
   R+iWZUXOb+G24dT0K45axXIyw7eozBivFJMUl+gQo6qaI7p6SyMnbHzvX
   Njk9PIcuzGH8TRx2zGHqVvKqmcuXuPsPEeHkIHo5b6FX6mw2k5cUP27oI
   bdT+RNYlbicb0tp0HXyh7JpB18ATWZW4Uw3aUfPk4sAu9BoTGy+LNR0ec
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="318740972"
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="318740972"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 23:13:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="514410115"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 10 Mar 2022 23:13:34 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSZSv-000617-H6; Fri, 11 Mar 2022 07:13:33 +0000
Date:   Fri, 11 Mar 2022 15:12:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/host/fu740] BUILD SUCCESS
 cf18fce4ed5c87def7d95554bfc864951b793e4c
Message-ID: <622af67b.Pw9f5I52GPkeRgfa%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/host/fu740
branch HEAD: cf18fce4ed5c87def7d95554bfc864951b793e4c  PCI: fu740: Drop redundant '-gpios' from DT GPIO lookup

elapsed time: 725m

configs tested: 135
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
arm                         cm_x300_defconfig
arm                     eseries_pxa_defconfig
sh                   sh7770_generic_defconfig
powerpc                     tqm8548_defconfig
mips                  maltasmvp_eva_defconfig
sh                             sh03_defconfig
powerpc                     ep8248e_defconfig
xtensa                          iss_defconfig
xtensa                         virt_defconfig
sh                          rsk7203_defconfig
m68k                       m5208evb_defconfig
sh                            shmin_defconfig
arc                    vdk_hs38_smp_defconfig
openrisc                 simple_smp_defconfig
arm                            mps2_defconfig
h8300                     edosk2674_defconfig
sh                           se7722_defconfig
arc                     haps_hs_smp_defconfig
sparc                       sparc64_defconfig
sh                           se7750_defconfig
arm                        shmobile_defconfig
arm                          badge4_defconfig
sh                               j2_defconfig
arm                           tegra_defconfig
arc                        nsim_700_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                 canyonlands_defconfig
sh                        edosk7705_defconfig
sh                           se7206_defconfig
arm                            lart_defconfig
sh                               allmodconfig
arc                          axs103_defconfig
mips                       capcella_defconfig
arm                         vf610m4_defconfig
arm                          lpd270_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                         db1xxx_defconfig
arm                          pxa3xx_defconfig
openrisc                         alldefconfig
powerpc                       holly_defconfig
powerpc                 mpc837x_mds_defconfig
arm                         s3c6400_defconfig
arm                        keystone_defconfig
h8300                    h8300h-sim_defconfig
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
arc                  randconfig-r043-20220310
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
arm                      tct_hammer_defconfig
arm                             mxs_defconfig
powerpc                          g5_defconfig
powerpc                     tqm8540_defconfig
mips                       lemote2f_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                  mpc866_ads_defconfig
arm                       cns3420vb_defconfig
x86_64                           allyesconfig
arm                    vt8500_v6_v7_defconfig
hexagon                          alldefconfig
arm                         orion5x_defconfig
powerpc                     ppa8548_defconfig
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
s390                 randconfig-r044-20220310

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
