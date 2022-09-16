Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4246B5BB3D5
	for <lists+linux-pci@lfdr.de>; Fri, 16 Sep 2022 23:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiIPVJw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Sep 2022 17:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiIPVJu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Sep 2022 17:09:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297E217ABE
        for <linux-pci@vger.kernel.org>; Fri, 16 Sep 2022 14:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663362581; x=1694898581;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=qyLgmDweVZBlZ/Qz65wv8WpL+oC2D+6Smz0HBh7X024=;
  b=iEfz25AfwXxBJqsGQFbBao3xXvBn4y3Jl89H1Lo7tyAusbXH2VEwDTMS
   1meD+A2hQ2mC7jTHR8E3+cGlaoYv7ckpP+mFm9VBk4PI8ObH+P97B5L9h
   RrifroT/uJtDUVGRyk26PZ3GZEbhN3qaJ303TTUUTosAN5lEOKaUTZjtz
   578ku8aWKfZLuHwcm3iqlqVN4lrgDGvBCRBTfGJWTke1x09RB5EYLySkR
   E+2dseiO0+5QpXjSF++APy/q8Lm+QIEqtvht2KrVzawLaKzbcLOJ3tkny
   m4wYWbSZVRx5GaAiR2VKyTde9IL7rrrgsDD5jMHIUjLCwxzsJD2Gy5Khk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="325357398"
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="325357398"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 14:09:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="595385811"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Sep 2022 14:09:39 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZIag-00028s-1v;
        Fri, 16 Sep 2022 21:09:38 +0000
Date:   Sat, 17 Sep 2022 05:08:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/dwc] BUILD SUCCESS
 81f66385ea1eb9cdd22ade4b39e27828046d57dc
Message-ID: <6324e5eb.LenxBb+vck1AtpOa%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/dwc
branch HEAD: 81f66385ea1eb9cdd22ade4b39e27828046d57dc  PCI: imx6: Add i.MX8MP PCIe support

elapsed time: 721m

configs tested: 134
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                                defconfig
arc                  randconfig-r043-20220916
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
i386                          randconfig-a001
s390                             allmodconfig
powerpc                           allnoconfig
alpha                               defconfig
i386                          randconfig-a003
powerpc                          allmodconfig
mips                             allyesconfig
i386                          randconfig-a005
s390                                defconfig
m68k                             allmodconfig
x86_64                              defconfig
i386                             allyesconfig
m68k                             allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
s390                             allyesconfig
sh                               allmodconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
arm                                 defconfig
x86_64                          rhel-8.3-func
i386                          randconfig-a014
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                          randconfig-a012
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a016
x86_64                           rhel-8.3-syz
arm64                            allyesconfig
arm                              allyesconfig
ia64                             allmodconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
arc                 nsimosci_hs_smp_defconfig
mips                  decstation_64_defconfig
s390                          debug_defconfig
powerpc                     rainier_defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-c001
i386                          randconfig-c001
arm                  randconfig-c002-20220916
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
xtensa                    xip_kc705_defconfig
mips                    maltaup_xpa_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
arc                              alldefconfig
powerpc                     stx_gp3_defconfig
m68k                       m5475evb_defconfig
powerpc                      bamboo_defconfig
sh                        edosk7760_defconfig
sh                          polaris_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
powerpc                    amigaone_defconfig
arm                        oxnas_v6_defconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
mips                        bcm47xx_defconfig
arc                           tb10x_defconfig
arc                          axs101_defconfig
openrisc                       virt_defconfig
mips                      maltasmvp_defconfig
x86_64                        randconfig-a015
loongarch                           defconfig
sh                         ecovec24_defconfig
arm64                               defconfig
ia64                             allyesconfig
arm                              allmodconfig
m68k                                defconfig
ia64                                defconfig
mips                             allmodconfig
x86_64                        randconfig-a011
arc                        nsimosci_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                            hp6xx_defconfig
powerpc                   currituck_defconfig
mips                     loongson1b_defconfig
powerpc                      pcm030_defconfig
powerpc                      pasemi_defconfig
arm                       omap2plus_defconfig
powerpc                      chrp32_defconfig
openrisc                 simple_smp_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sh                           se7724_defconfig
m68k                          atari_defconfig
sh                          rsk7269_defconfig
powerpc                       maple_defconfig

clang tested configs:
hexagon              randconfig-r041-20220916
riscv                randconfig-r042-20220916
hexagon              randconfig-r045-20220916
s390                 randconfig-r044-20220916
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-k001
arm                          sp7021_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                     mpc512x_defconfig
hexagon              randconfig-r045-20220917
hexagon              randconfig-r041-20220917

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
