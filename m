Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D9B66A760
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jan 2023 01:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjANAJZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 19:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjANAJX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 19:09:23 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A558CD38
        for <linux-pci@vger.kernel.org>; Fri, 13 Jan 2023 16:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673654962; x=1705190962;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=PYZecqlu7I5hpP3A2pB+uvYEA/k2tjvHozrrMbVJqGs=;
  b=XvKZmvDElWGw9KHsZYMNbFA+sy5Z6yjyAMOo+Sppl+3OrVA9TNQ4aKd3
   vEoNHRynP6Fa0UK8g0StFYvNnHnfjzuq9gCNP0DtibNcrZfKejGtmBbcI
   jxlv8IJAz1v/wtBrQ3UjTQSaAfeerKSo5EPZDMiLtIv/o4SmjH6e6UkUu
   YDVXMNBm8TiMi2jc9LPf2wUg6ImylfD4Az7iL2WP/SYdfWVwSkeGWbdyv
   Og/5wFi4IASGGnZttfpfcVw+DdktRDf2gneh6DVmt+1idXW9isqKxj1M/
   ksjbRZcohmvMK3JqeEHNoPztz/b7h27m/k9vISot3ISY9DAcRb2O7UNJc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="304514364"
X-IronPort-AV: E=Sophos;i="5.97,215,1669104000"; 
   d="scan'208";a="304514364"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 16:09:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="660371981"
X-IronPort-AV: E=Sophos;i="5.97,215,1669104000"; 
   d="scan'208";a="660371981"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jan 2023 16:09:21 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pGU6q-000BYC-1X;
        Sat, 14 Jan 2023 00:09:20 +0000
Date:   Sat, 14 Jan 2023 08:08:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/iov] BUILD SUCCESS
 58d4c63d0a27aceff27de0eb4c8db65ae0674d95
Message-ID: <63c1f297.DGmnBwlp4OnmqTzl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/iov
branch HEAD: 58d4c63d0a27aceff27de0eb4c8db65ae0674d95  PCI/IOV: Enlarge virtfn sysfs name buffer

elapsed time: 1451m

configs tested: 138
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                            allnoconfig
arc                  randconfig-r043-20230112
riscv                randconfig-r042-20230112
s390                 randconfig-r044-20230112
ia64                             allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a016
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a006
x86_64                        randconfig-a015
arm                      integrator_defconfig
sh                           se7721_defconfig
m68k                          atari_defconfig
arc                          axs103_defconfig
m68k                       bvme6000_defconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
powerpc                           allnoconfig
x86_64                              defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                             allyesconfig
i386                                defconfig
s390                             allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                           allyesconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          randconfig-c001
mips                     decstation_defconfig
powerpc                        cell_defconfig
sh                           se7705_defconfig
arm                           viper_defconfig
arm                        realview_defconfig
mips                            ar7_defconfig
arm                            zeus_defconfig
arc                            hsdk_defconfig
arm                          pxa3xx_defconfig
sh                         ap325rxa_defconfig
sh                     magicpanelr2_defconfig
sh                         microdev_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
ia64                          tiger_defconfig
arm                        shmobile_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                     tqm8555_defconfig
powerpc                 mpc834x_mds_defconfig
sparc                             allnoconfig
powerpc                    amigaone_defconfig
mips                           xway_defconfig
arm                         vf610m4_defconfig
arm                       omap2plus_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                mpc7448_hpc2_defconfig
m68k                        m5307c3_defconfig
ia64                            zx1_defconfig

clang tested configs:
arm                  randconfig-r046-20230112
hexagon              randconfig-r041-20230112
hexagon              randconfig-r045-20230112
i386                          randconfig-a013
i386                          randconfig-a002
i386                          randconfig-a011
x86_64                        randconfig-a001
i386                          randconfig-a004
x86_64                        randconfig-a003
x86_64                        randconfig-a014
i386                          randconfig-a015
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-k001
x86_64                          rhel-8.3-rust
powerpc                          g5_defconfig
mips                          malta_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                      maltaaprp_defconfig
mips                           mtx1_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                     tqm8540_defconfig
mips                           ip28_defconfig
arm                      tct_hammer_defconfig
mips                        omega2p_defconfig
x86_64                        randconfig-c007
arm                  randconfig-c002-20230112
s390                 randconfig-c005-20230112
i386                          randconfig-c001
riscv                randconfig-c006-20230112
powerpc              randconfig-c003-20230112
mips                 randconfig-c004-20230112
riscv                randconfig-r042-20230113
s390                 randconfig-r044-20230113
hexagon              randconfig-r041-20230113
hexagon              randconfig-r045-20230113

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
