Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680CB5F0ABA
	for <lists+linux-pci@lfdr.de>; Fri, 30 Sep 2022 13:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiI3LjC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Sep 2022 07:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbiI3Lii (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Sep 2022 07:38:38 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE733102A71
        for <linux-pci@vger.kernel.org>; Fri, 30 Sep 2022 04:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664537433; x=1696073433;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dZb9ndZU3fTaILV45EGwD5u2NfkbWd7oX9QG2Eh1quA=;
  b=WTyZHN4zoz7LVdKI3SbD/TVHwCeICkc8zBOyhhTIfs+AQEr0+ORR3JQh
   26Hh4klr6rt8Hl7fP8EYvAm2Rji2eVWz6dtFKtxo7i2usmX2YuiKiS8AB
   zJfVEIDSsiK7lLmRwdNx8N2Bh+lbynI4TDAI0cjulI35rIhnHtUct+bhe
   +REJzTYVN4TlbhWER6nldsWqwDAzlnHwZYfzrpyKx1PKVCaridV45sZOu
   TD3d/uK8ETXLyOSOrsovhjNGVYObNDB6umb7s8FlUAcBIbZFKIIgFdXnr
   NQlbQjcBQfhS4E+h16yq8wNNtsm6aTcOg4rkjrHgr6xliWWUUXPXLoTWC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="303655515"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="303655515"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 04:30:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="691218582"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="691218582"
Received: from lkp-server01.sh.intel.com (HELO 14cc182da2d0) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 30 Sep 2022 04:30:29 -0700
Received: from kbuild by 14cc182da2d0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oeEDt-0000yH-01;
        Fri, 30 Sep 2022 11:30:29 +0000
Date:   Fri, 30 Sep 2022 19:29:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/dwc] BUILD SUCCESS
 2810b99c95b11d8b8357e5fa8baf0f2d2e4f7a0c
Message-ID: <6336d331.KWkh3Z21fIQZ5GKZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/dwc
branch HEAD: 2810b99c95b11d8b8357e5fa8baf0f2d2e4f7a0c  phy: freescale: imx8m-pcie: Fix the wrong order of phy_init() and phy_power_on()

elapsed time: 1460m

configs tested: 150
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
powerpc                           allnoconfig
s390                             allyesconfig
i386                                defconfig
x86_64                              defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arc                  randconfig-r043-20220928
m68k                             allmodconfig
x86_64                               rhel-8.3
arc                              allyesconfig
alpha                            allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
m68k                             allyesconfig
x86_64                           allyesconfig
sh                               allmodconfig
i386                             allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
arm                                 defconfig
arm                              allyesconfig
x86_64                        randconfig-a004
arm64                            allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a006
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
i386                 randconfig-a003-20220926
i386                 randconfig-a001-20220926
i386                 randconfig-a006-20220926
i386                 randconfig-a004-20220926
i386                 randconfig-a005-20220926
i386                 randconfig-a002-20220926
arm                       omap2plus_defconfig
powerpc                     ep8248e_defconfig
arm                             ezx_defconfig
powerpc                       maple_defconfig
mips                       bmips_be_defconfig
arm                         s3c6400_defconfig
sh                 kfr2r09-romimage_defconfig
m68k                        m5307c3_defconfig
i386                          randconfig-c001
sh                           se7722_defconfig
powerpc                 mpc837x_mds_defconfig
sh                            migor_defconfig
xtensa                          iss_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220925
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
sh                   secureedge5410_defconfig
mips                      loongson3_defconfig
arc                            hsdk_defconfig
sh                     sh7710voipgw_defconfig
sh                             sh03_defconfig
sh                               j2_defconfig
m68k                       m5249evb_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                     decstation_defconfig
sh                         apsh4a3a_defconfig
m68k                        mvme147_defconfig
sh                             shx3_defconfig
sh                     magicpanelr2_defconfig
mips                      fuloong2e_defconfig
arm                          pxa3xx_defconfig
sh                          landisk_defconfig
nios2                            allyesconfig
sh                            hp6xx_defconfig
powerpc                      cm5200_defconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
sh                        edosk7760_defconfig
mips                         rt305x_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arm                         assabet_defconfig
sparc                             allnoconfig
powerpc                    sam440ep_defconfig
arm                         at91_dt_defconfig
x86_64                           alldefconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
x86_64               randconfig-a002-20220926
x86_64               randconfig-a001-20220926
x86_64               randconfig-a004-20220926
x86_64               randconfig-a006-20220926
x86_64               randconfig-a005-20220926
x86_64               randconfig-a003-20220926
powerpc                        cell_defconfig
m68k                                defconfig
arm                          gemini_defconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20220928
hexagon              randconfig-r045-20220928
riscv                randconfig-r042-20220928
s390                 randconfig-r044-20220928
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                 randconfig-a011-20220926
x86_64                        randconfig-a001
i386                 randconfig-a015-20220926
x86_64               randconfig-a014-20220926
x86_64                        randconfig-a003
i386                 randconfig-a014-20220926
x86_64               randconfig-a013-20220926
i386                 randconfig-a013-20220926
i386                 randconfig-a012-20220926
x86_64               randconfig-a011-20220926
i386                 randconfig-a016-20220926
x86_64                        randconfig-a005
x86_64               randconfig-a016-20220926
x86_64               randconfig-a012-20220926
x86_64               randconfig-a015-20220926
x86_64                        randconfig-k001
arm                         hackkit_defconfig
powerpc                      walnut_defconfig
mips                        maltaup_defconfig
powerpc                   microwatt_defconfig
mips                      malta_kvm_defconfig
powerpc                  mpc885_ads_defconfig
hexagon              randconfig-r041-20220925
hexagon              randconfig-r041-20220926
hexagon              randconfig-r045-20220925
hexagon              randconfig-r045-20220926
riscv                randconfig-r042-20220926
s390                 randconfig-r044-20220926

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
