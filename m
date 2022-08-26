Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095A65A240B
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 11:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343492AbiHZJSX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 05:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343540AbiHZJSU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 05:18:20 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0E1D7422
        for <linux-pci@vger.kernel.org>; Fri, 26 Aug 2022 02:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661505499; x=1693041499;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=4wUsbGq9x5+MLX9qHBxmdQL/iCUbAolO7jKMPDhwXAU=;
  b=FET/OjlFCiEamEdx4So611SjyJuthFpFkvc1oIeTNsy3F7oItqXQ4Vq6
   gFCGMYlCPY7VL8/VGOXya+BlVU0o/L2fltTsuXqZ6KYzyqKcnfyUW5a42
   NY5mHyyjt6kYQEDjjvLBhPGnNb6d0IrIvG5pQDuHJyyMPbUKeecdUGSBc
   Vz7vSsBbPLS7aoKvMcKBgTZ4XWUtUizGICNRryd0nFMk8CDRG6glFy+HJ
   CK/WjGGa19uR2+w6buK+E0sxZqaqt/0rkN4PSGvthFgbJPr8dPPEyfSXE
   a2aLA5HK7v3MpxfhKJxi/QihCdiNvfdFl+I9tzOTMeQ60J+/d1EGdFow8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="294469210"
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="294469210"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 02:18:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="671389776"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 26 Aug 2022 02:18:18 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRVTl-0003pE-2M;
        Fri, 26 Aug 2022 09:18:17 +0000
Date:   Fri, 26 Aug 2022 17:17:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:for-linus] BUILD SUCCESS
 0e1fa5155a364de7d3de770eb382980933376699
Message-ID: <63088fa0.nZsNbMFURI7gmJGk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
branch HEAD: 0e1fa5155a364de7d3de770eb382980933376699  MAINTAINERS: Add Mahesh J Salgaonkar as EEH maintainer

elapsed time: 724m

configs tested: 144
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
loongarch                         allnoconfig
loongarch                           defconfig
s390                                defconfig
s390                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a002
arm                                 defconfig
x86_64                        randconfig-a004
arc                              allyesconfig
x86_64                        randconfig-a006
powerpc                          allmodconfig
i386                             allyesconfig
alpha                            allyesconfig
mips                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                              defconfig
powerpc                           allnoconfig
sh                               allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
arm                              allyesconfig
x86_64                         rhel-8.3-kunit
arm64                            allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
i386                          randconfig-a014
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a012
x86_64                               rhel-8.3
i386                          randconfig-a016
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
x86_64                           allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arc                  randconfig-r043-20220823
riscv                randconfig-r042-20220824
s390                 randconfig-r044-20220824
arc                  randconfig-r043-20220824
arc                  randconfig-r043-20220825
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
powerpc                        warp_defconfig
arm                           imxrt_defconfig
mips                         bigsur_defconfig
nios2                         3c120_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
sh                            hp6xx_defconfig
m68k                           virt_defconfig
arm                            qcom_defconfig
sh                ecovec24-romimage_defconfig
powerpc                      mgcoge_defconfig
arm                           tegra_defconfig
arm                           corgi_defconfig
powerpc                 mpc837x_mds_defconfig
ia64                             allmodconfig
powerpc                      pcm030_defconfig
arm                        keystone_defconfig
sh                          rsk7201_defconfig
arm64                               defconfig
arm                              allmodconfig
m68k                                defconfig
ia64                                defconfig
mips                             allmodconfig
sparc                       sparc32_defconfig
sh                           se7750_defconfig
sh                         microdev_defconfig
arc                     nsimosci_hs_defconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a002
i386                          randconfig-a015
x86_64                        randconfig-a014
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a006
hexagon              randconfig-r041-20220825
hexagon              randconfig-r041-20220823
hexagon              randconfig-r045-20220825
riscv                randconfig-r042-20220825
riscv                randconfig-r042-20220823
hexagon              randconfig-r045-20220823
s390                 randconfig-r044-20220823
s390                 randconfig-r044-20220825
x86_64                        randconfig-k001
mips                          rm200_defconfig
arm                        multi_v5_defconfig
mips                           rs90_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
