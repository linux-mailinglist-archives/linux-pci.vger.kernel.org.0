Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA98A5A227D
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 09:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245714AbiHZH7N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 03:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343492AbiHZH7M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 03:59:12 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C61D475D
        for <linux-pci@vger.kernel.org>; Fri, 26 Aug 2022 00:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661500751; x=1693036751;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ApjWP7dIgDq8Mu3zzfNgFZvVTuX2qCWlLo75JvTlpDM=;
  b=av4NVOfdtaURYwbyC9ztDex/RMiSD6QkUJoSKsN+v2d+mYDuRGwshO6+
   VwCTPRUJAxR7gsqbLvw5TQ04J/W7aZnoZa0S827oEJsY/P2NGwKHO3MRk
   odKXYFL9q3FwXk7Y0nbNRR1WayuWsc2HSYHQfT4zuyJi2O9HheM8evru3
   L0FHUwoujKPkbgbkgwYOZ/ZInwKaG6DLkOZ/uFmoW6/pPv79AWbVIt2vJ
   +d69sl+MgQe0hZYEkUlLoBQ2pOSt4iQwZ5YGjiE4Wfbvahi8CfzoPFawS
   D5NcjLYBasQxsXhizBM2c7Ms/YM7LNNcPoDRwyEBX4ftkEFVp2/gviwhk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="274204007"
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="274204007"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 00:59:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="752795908"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 26 Aug 2022 00:59:08 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRUF9-0003eU-1K;
        Fri, 26 Aug 2022 07:59:07 +0000
Date:   Fri, 26 Aug 2022 15:58:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 c918c1a1408438a482baaa2768233222e820e979
Message-ID: <63087d1f.8iSJ1Rs5P6ZPYnBr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: c918c1a1408438a482baaa2768233222e820e979  Merge branch 'remotes/lorenzo/pci/qcom'

elapsed time: 721m

configs tested: 137
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arm                                 defconfig
i386                                defconfig
x86_64                        randconfig-a004
loongarch                         allnoconfig
x86_64                        randconfig-a002
arm64                            allyesconfig
arm                              allyesconfig
arc                                 defconfig
loongarch                           defconfig
alpha                               defconfig
x86_64                        randconfig-a006
arc                  randconfig-r043-20220824
riscv                randconfig-r042-20220824
s390                             allmodconfig
alpha                            allyesconfig
s390                                defconfig
arc                              allyesconfig
i386                             allyesconfig
x86_64                              defconfig
s390                             allyesconfig
x86_64                        randconfig-a013
powerpc                           allnoconfig
s390                 randconfig-r044-20220824
x86_64                        randconfig-a011
powerpc                          allmodconfig
i386                          randconfig-a014
m68k                             allmodconfig
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a001
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a003
mips                             allyesconfig
x86_64                        randconfig-a015
x86_64                          rhel-8.3-func
arc                  randconfig-r043-20220825
m68k                             allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
sh                               allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
i386                          randconfig-a005
x86_64                           allyesconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
m68k                        m5407c3_defconfig
arm                        mvebu_v7_defconfig
powerpc                     mpc83xx_defconfig
alpha                            alldefconfig
arm                          pxa910_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          randconfig-c001
powerpc                 mpc85xx_cds_defconfig
arm                          iop32x_defconfig
mips                      fuloong2e_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
xtensa                         virt_defconfig
arm                       imx_v6_v7_defconfig
ia64                        generic_defconfig
arm                        spear6xx_defconfig
mips                            gpr_defconfig
sh                            shmin_defconfig
mips                  decstation_64_defconfig
ia64                             alldefconfig
powerpc                 mpc8540_ads_defconfig
mips                           gcw0_defconfig
m68k                       bvme6000_defconfig
m68k                       m5249evb_defconfig
m68k                          multi_defconfig
ia64                             allmodconfig
powerpc                        warp_defconfig
arm                           imxrt_defconfig
mips                         bigsur_defconfig
nios2                         3c120_defconfig
sh                            hp6xx_defconfig
m68k                           virt_defconfig
arm                            qcom_defconfig
sh                ecovec24-romimage_defconfig
powerpc                      mgcoge_defconfig
arm                           tegra_defconfig
arm                           corgi_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                      pcm030_defconfig
arm                        keystone_defconfig
sh                          rsk7201_defconfig
arm64                               defconfig
arm                              allmodconfig
m68k                                defconfig
ia64                                defconfig
mips                             allmodconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r041-20220825
i386                          randconfig-a013
hexagon              randconfig-r045-20220825
i386                          randconfig-a015
x86_64                        randconfig-a014
hexagon              randconfig-r041-20220824
hexagon              randconfig-r045-20220824
i386                          randconfig-a011
x86_64                        randconfig-a016
x86_64                        randconfig-a012
riscv                randconfig-r042-20220825
s390                 randconfig-r044-20220825
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-k001
mips                          rm200_defconfig
arm                        multi_v5_defconfig
mips                           rs90_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
