Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B422588331
	for <lists+linux-pci@lfdr.de>; Tue,  2 Aug 2022 22:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbiHBUpr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Aug 2022 16:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiHBUpg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Aug 2022 16:45:36 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6771057E
        for <linux-pci@vger.kernel.org>; Tue,  2 Aug 2022 13:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659473135; x=1691009135;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=pdMTkLBwQhJkYZKZSR+gp8YZ5YdW++3DmOwrmEKncZY=;
  b=fpl9RZYHB3X7yhEsrrJhBtBSrVxbYMaElSGPrA4RubSkv4aAbuwcOtxz
   P4mU1p6RVWj5LAiZCBze96MwhN9KWSXEwyqFt/Xw1QFDvx5BHCLAtdU1K
   fz80B4G/aOj6az/7EJwYT1hsIVCK6UarWP3ndVZDAurJ8e0D9OQpqKTiC
   FCIIoiV+boGQJOoH9bR/7qZJGibJZB4tPttgWxtcE2jzKQwRbHJYR87uj
   tArz8zdwxeLDw15jV94O4EoFbrWO/jZzd9OFNwekgN2VzAK3BzilDLiEy
   AwwzdB6MPfgyNfOePth518NIBcQ0WvQStd9r600VqUxQ81uZYhEY4PafX
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="375817090"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="375817090"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 13:45:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="553059159"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 Aug 2022 13:45:33 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIylg-000GQR-2T;
        Tue, 02 Aug 2022 20:45:32 +0000
Date:   Wed, 03 Aug 2022 04:44:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/ctrl/dwc] BUILD SUCCESS
 91a773f9986b5cb4d6a6610b0326ef7c472dd543
Message-ID: <62e98cb5.BukGMK0XlOTPP/ME%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ctrl/dwc
branch HEAD: 91a773f9986b5cb4d6a6610b0326ef7c472dd543  dt-bindings: PCI: qcom: Support additional MSI vectors

elapsed time: 1438m

configs tested: 117
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
arc                  randconfig-r043-20220801
s390                 randconfig-r044-20220801
riscv                randconfig-r042-20220801
powerpc                           allnoconfig
i386                                defconfig
powerpc                          allmodconfig
arm                                 defconfig
sh                               allmodconfig
x86_64               randconfig-a014-20220801
x86_64               randconfig-a015-20220801
i386                             allyesconfig
x86_64                               rhel-8.3
i386                 randconfig-a012-20220801
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a014-20220801
x86_64               randconfig-a011-20220801
i386                 randconfig-a011-20220801
arm64                            allyesconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
i386                 randconfig-a016-20220801
x86_64               randconfig-a012-20220801
x86_64                           rhel-8.3-kvm
i386                 randconfig-a015-20220801
x86_64               randconfig-a013-20220801
x86_64                           rhel-8.3-syz
x86_64               randconfig-a016-20220801
x86_64                              defconfig
x86_64                           allyesconfig
mips                             allyesconfig
x86_64               randconfig-k001-20220801
powerpc                   motionpro_defconfig
xtensa                  nommu_kc705_defconfig
sparc64                          alldefconfig
mips                           xway_defconfig
powerpc                      ep88xc_defconfig
sh                           se7721_defconfig
powerpc                     tqm8541_defconfig
sh                           sh2007_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
i386                 randconfig-a013-20220801
i386                 randconfig-c001-20220801
arm                              allyesconfig
loongarch                        alldefconfig
loongarch                 loongson3_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                       m5249evb_defconfig
nios2                            allyesconfig
mips                            ar7_defconfig
arm                            mps2_defconfig
powerpc                     taishan_defconfig
sh                        dreamcast_defconfig
arm                         cm_x300_defconfig
mips                    maltaup_xpa_defconfig
um                           x86_64_defconfig
parisc                generic-32bit_defconfig
openrisc                 simple_smp_defconfig
powerpc                 mpc837x_rdb_defconfig
riscv                    nommu_k210_defconfig
sh                           se7722_defconfig
ia64                             allmodconfig
xtensa                           alldefconfig
sh                          rsk7203_defconfig
nios2                         10m50_defconfig
sh                      rts7751r2d1_defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
powerpc                        warp_defconfig
powerpc                       ppc64_defconfig
ia64                             alldefconfig
arm                           tegra_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                        mini2440_defconfig
powerpc                    adder875_defconfig
powerpc                     mpc83xx_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
arc                        vdk_hs38_defconfig

clang tested configs:
hexagon              randconfig-r045-20220801
hexagon              randconfig-r041-20220801
x86_64               randconfig-a002-20220801
x86_64               randconfig-a001-20220801
x86_64               randconfig-a003-20220801
x86_64               randconfig-a004-20220801
i386                 randconfig-a001-20220801
x86_64               randconfig-a005-20220801
x86_64               randconfig-a006-20220801
i386                 randconfig-a002-20220801
i386                 randconfig-a003-20220801
i386                 randconfig-a005-20220801
i386                 randconfig-a004-20220801
i386                 randconfig-a006-20220801
powerpc                      obs600_defconfig
powerpc                     akebono_defconfig
arm                   milbeaut_m10v_defconfig
mips                          ath25_defconfig
arm                       spear13xx_defconfig
hexagon                             defconfig
powerpc                      katmai_defconfig
hexagon              randconfig-r045-20220802
s390                 randconfig-r044-20220802
hexagon              randconfig-r041-20220802
riscv                randconfig-r042-20220802
arm                              alldefconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
