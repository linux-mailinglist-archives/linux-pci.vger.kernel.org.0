Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80FD5F0679
	for <lists+linux-pci@lfdr.de>; Fri, 30 Sep 2022 10:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiI3Icb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Sep 2022 04:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiI3Ica (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Sep 2022 04:32:30 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B09C1499
        for <linux-pci@vger.kernel.org>; Fri, 30 Sep 2022 01:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664526749; x=1696062749;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=uEnpJ8NC9dFeIdlHIw2KF4fwDt30lX8SP0h8ePl1YJs=;
  b=AsoIECH+uIC0q5XtUDBdBjJ/T139PQVoj42ramOwouKJXHv/Wd5QPUpk
   vVGeTu27g1wxNWqnPPdTsDj/VD9yawr+QYGT6AqnmK90pX2glwasAntEG
   A1fqvJBse+QPL8ZSH53tAgEKLGPxmtDnhGyLPqLp9zCasna1mlKsqOW0N
   ZFL0UP/Q1EEOcKEpqWjh89Bt4wZrsLIgGth4zLCwD0qXuFlj9fbNS6i/D
   fONdpNUvFds7i8TX8URSM183zGLPv3wuzrdZkOsdpL26Aw+WnaPk89tIO
   oCNmzhO05E+UN8GNMttRE4rOmDFQO6juRxCIzByNRlRpQ6wcE5774kkrv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="282503225"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="282503225"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 01:32:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="711723360"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="711723360"
Received: from lkp-server01.sh.intel.com (HELO 14cc182da2d0) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Sep 2022 01:32:20 -0700
Received: from kbuild by 14cc182da2d0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oeBRT-0000lp-1R;
        Fri, 30 Sep 2022 08:32:19 +0000
Date:   Fri, 30 Sep 2022 16:31:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/misc] BUILD SUCCESS
 8bb7ff12a91429eb76e093b517ae810b146448fe
Message-ID: <6336a959.Cshe4v2o9V08a4qS%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/misc
branch HEAD: 8bb7ff12a91429eb76e093b517ae810b146448fe  PCI: tegra: Use PCI_CONF1_EXT_ADDRESS() macro

elapsed time: 1357m

configs tested: 153
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arc                                 defconfig
powerpc                          allmodconfig
mips                             allyesconfig
i386                                defconfig
alpha                               defconfig
x86_64                           rhel-8.3-kvm
powerpc                           allnoconfig
sh                               allmodconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
arc                  randconfig-r043-20220925
riscv                randconfig-r042-20220925
arc                  randconfig-r043-20220926
s390                 randconfig-r044-20220925
s390                             allmodconfig
x86_64                               rhel-8.3
i386                             allyesconfig
s390                                defconfig
s390                             allyesconfig
x86_64                           allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
arm                                 defconfig
i386                 randconfig-a001-20220926
arc                              allyesconfig
i386                 randconfig-a004-20220926
x86_64                        randconfig-a004
m68k                             allyesconfig
x86_64                        randconfig-a002
i386                 randconfig-a002-20220926
i386                 randconfig-a003-20220926
i386                 randconfig-a005-20220926
x86_64                        randconfig-a006
i386                 randconfig-a006-20220926
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
arm                              allyesconfig
i386                          randconfig-a014
arm64                            allyesconfig
i386                          randconfig-a012
i386                          randconfig-a016
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arm                       omap2plus_defconfig
powerpc                     ep8248e_defconfig
arm                             ezx_defconfig
powerpc                       maple_defconfig
mips                       bmips_be_defconfig
arm                         s3c6400_defconfig
sh                 kfr2r09-romimage_defconfig
m68k                        m5307c3_defconfig
sh                           se7722_defconfig
powerpc                 mpc837x_mds_defconfig
sh                            migor_defconfig
xtensa                          iss_defconfig
i386                          randconfig-c001
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
x86_64               randconfig-a002-20220926
x86_64               randconfig-a001-20220926
x86_64               randconfig-a004-20220926
x86_64               randconfig-a006-20220926
x86_64               randconfig-a005-20220926
x86_64               randconfig-a003-20220926
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
sh                        edosk7760_defconfig
mips                         rt305x_defconfig
arm                         assabet_defconfig
sparc                             allnoconfig
powerpc                    sam440ep_defconfig
arm                         at91_dt_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
x86_64                           alldefconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r045-20220925
hexagon              randconfig-r041-20220926
hexagon              randconfig-r045-20220926
hexagon              randconfig-r041-20220925
riscv                randconfig-r042-20220926
s390                 randconfig-r044-20220926
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                 randconfig-a011-20220926
i386                 randconfig-a015-20220926
i386                 randconfig-a014-20220926
i386                 randconfig-a012-20220926
i386                 randconfig-a013-20220926
i386                 randconfig-a016-20220926
hexagon              randconfig-r041-20220928
hexagon              randconfig-r045-20220928
riscv                randconfig-r042-20220928
s390                 randconfig-r044-20220928
x86_64                        randconfig-k001
x86_64               randconfig-a016-20220926
x86_64               randconfig-a012-20220926
x86_64               randconfig-a014-20220926
x86_64               randconfig-a013-20220926
x86_64               randconfig-a011-20220926
x86_64               randconfig-a015-20220926
arm                         hackkit_defconfig
powerpc                      walnut_defconfig
mips                        maltaup_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
