Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A4A6733CF
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 09:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjASIg7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 03:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjASIg5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 03:36:57 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE124B4A6
        for <linux-pci@vger.kernel.org>; Thu, 19 Jan 2023 00:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674117417; x=1705653417;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=EtsrRVDeNO8xegkrr/5PmawtaICU0ULVB0Vj/Hr2kDc=;
  b=iwCHO/xtVdfuwfpkufXcg+BYDdHwmvYhCVjvCdOmAvv5y9XjGkrLMRqv
   GF2KjtmDA/cmuCAeAu/kkvqHcuhJMktCa6kLv2PyX/20gGVf32pzk0EQq
   KA2bh72gBeANiFSFCsDGnR+JXRwb2CBMfksD/sLsCl70lbiajBJgvYbeC
   VEL9T84uIMIy2FeQKRvkmN7brD8qCXdPjGMKFrR4WQlQ2fh7mvoqxY4PK
   K+VUbjYNVdLbLgXRTotEE/LG8JogekXxikVzr5j+9q+eMpnh2FQI6SBaN
   9nmyxge7zn9dwuB9T8ouhgedA8ngK00Wt/Y0soZHgZyK6A+qybYV9DetZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="313103698"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="313103698"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 00:36:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="783977783"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="783977783"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 19 Jan 2023 00:36:48 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIQPa-0001JX-2m;
        Thu, 19 Jan 2023 08:36:42 +0000
Date:   Thu, 19 Jan 2023 16:36:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/misc] BUILD SUCCESS
 fd858402c6d0a80e0b543886b9f7865c6d76d5d6
Message-ID: <63c90114.gICUrwJ1O3jmnJ3e%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/misc
branch HEAD: fd858402c6d0a80e0b543886b9f7865c6d76d5d6  PCI: endpoint: pci-epf-vntb: Add epf_ntb_mw_bar_clear() num_mws kernel-doc

elapsed time: 723m

configs tested: 86
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
x86_64                            allnoconfig
arc                              allyesconfig
s390                             allmodconfig
alpha                            allyesconfig
s390                                defconfig
s390                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
um                             i386_defconfig
x86_64                         rhel-8.3-kunit
um                           x86_64_defconfig
x86_64                           rhel-8.3-syz
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
ia64                             allmodconfig
arc                  randconfig-r043-20230118
sh                               allmodconfig
s390                 randconfig-r044-20230118
riscv                randconfig-r042-20230118
i386                             allyesconfig
i386                                defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
powerpc                      mgcoge_defconfig
sh                        dreamcast_defconfig
sh                           se7722_defconfig
i386                          randconfig-c001
arm                       imx_v6_v7_defconfig
sh                              ul2_defconfig
sh                           se7750_defconfig
arc                     nsimosci_hs_defconfig
m68k                            q40_defconfig
mips                     loongson1b_defconfig
arm                       omap2plus_defconfig
sparc                             allnoconfig
arm                           tegra_defconfig
arm                         assabet_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec

clang tested configs:
hexagon              randconfig-r045-20230118
hexagon              randconfig-r041-20230118
arm                  randconfig-r046-20230118
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
arm                        spear3xx_defconfig
arm                        neponset_defconfig
x86_64                        randconfig-k001
mips                       lemote2f_defconfig
arm                         socfpga_defconfig
arm                         orion5x_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
