Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653075F0638
	for <lists+linux-pci@lfdr.de>; Fri, 30 Sep 2022 10:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiI3IGZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Sep 2022 04:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiI3IGY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Sep 2022 04:06:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA247B6015
        for <linux-pci@vger.kernel.org>; Fri, 30 Sep 2022 01:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664525182; x=1696061182;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=KsiYIf6Z2V40pZHAvqsJcIL8hnDYLqW7WZyJpb3X9Q0=;
  b=cFyIRVEiadx5vR4KiinaIns0kRr4PFXyFbp4zC7onSlsZcMoPDp/Enf5
   Q/IbvG1wUetaJmvPYt3BUGoHxWBIKFmPu5EXB2WgmkHTaNDCQtEKgBk75
   PRqUtGhAuu3OQBWTM7oCQIP7GohIGZiw/vGJk/LzkTLeJnNUplZAj6HZV
   GPgz+kDspCSTtFslVhSi7wT+68usBxvj67cFooLbGB73IK7eTgl3No+TO
   DL4ujgbdhY2//Ib/HHnUcznuqRklGcPYa2K91SDpPjKDsm0o461q30CjM
   Xz4lMYy2IDpagSuu0UQpWxlm2FBae27/OMmV3YuLPd7AyVPP4CuFc4LSs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="303046031"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="303046031"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 01:06:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="573785116"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="573785116"
Received: from lkp-server01.sh.intel.com (HELO 14cc182da2d0) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 30 Sep 2022 01:06:19 -0700
Received: from kbuild by 14cc182da2d0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oeB2I-0000jx-1U;
        Fri, 30 Sep 2022 08:06:18 +0000
Date:   Fri, 30 Sep 2022 16:05:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/qcom] BUILD SUCCESS
 0e4d9a5cc7670d59e73cc372263a7417330aa56f
Message-ID: <6336a354.IgkUlRk/epwJK/Lr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/qcom
branch HEAD: 0e4d9a5cc7670d59e73cc372263a7417330aa56f  PCI: qcom: Rename host-init error label

elapsed time: 1406m

configs tested: 159
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
powerpc                           allnoconfig
arc                                 defconfig
um                           x86_64_defconfig
alpha                               defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
s390                                defconfig
s390                             allmodconfig
sh                               allmodconfig
x86_64                          rhel-8.3-func
i386                                defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
powerpc                          allmodconfig
s390                             allyesconfig
mips                             allyesconfig
x86_64                               rhel-8.3
i386                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
x86_64                           allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
arc                  randconfig-r043-20220928
x86_64               randconfig-a002-20220926
arm                                 defconfig
x86_64               randconfig-a001-20220926
x86_64               randconfig-a003-20220926
x86_64               randconfig-a004-20220926
x86_64               randconfig-a006-20220926
x86_64               randconfig-a005-20220926
i386                 randconfig-a001-20220926
i386                 randconfig-a004-20220926
i386                 randconfig-a002-20220926
i386                 randconfig-a003-20220926
i386                 randconfig-a005-20220926
i386                 randconfig-a006-20220926
arm64                            allyesconfig
arm                              allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
i386                          randconfig-c001
m68k                          hp300_defconfig
arc                        vdk_hs38_defconfig
ia64                         bigsur_defconfig
m68k                             alldefconfig
powerpc                   motionpro_defconfig
m68k                         amcore_defconfig
mips                           xway_defconfig
sh                          lboxre2_defconfig
xtensa                  audio_kc705_defconfig
sh                         ap325rxa_defconfig
xtensa                generic_kc705_defconfig
sh                          urquell_defconfig
arm                         nhk8815_defconfig
loongarch                        alldefconfig
sh                        sh7757lcr_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arm                         s3c6400_defconfig
sh                 kfr2r09-romimage_defconfig
m68k                        m5307c3_defconfig
arm                       omap2plus_defconfig
powerpc                     ep8248e_defconfig
arm                             ezx_defconfig
powerpc                       maple_defconfig
mips                       bmips_be_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sh                           se7722_defconfig
powerpc                 mpc837x_mds_defconfig
sh                            migor_defconfig
xtensa                          iss_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220925
sh                   secureedge5410_defconfig
mips                      loongson3_defconfig
arc                            hsdk_defconfig
sh                     sh7710voipgw_defconfig
sh                             sh03_defconfig
sh                               j2_defconfig
m68k                       m5249evb_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
mips                     decstation_defconfig
sh                         apsh4a3a_defconfig
m68k                        mvme147_defconfig
sh                             shx3_defconfig
sh                     magicpanelr2_defconfig
mips                      fuloong2e_defconfig
arm                          pxa3xx_defconfig
sh                          landisk_defconfig
sh                            hp6xx_defconfig
powerpc                      cm5200_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
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
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r045-20220928
hexagon              randconfig-r041-20220928
riscv                randconfig-r042-20220928
s390                 randconfig-r044-20220928
i386                 randconfig-a011-20220926
i386                 randconfig-a015-20220926
i386                 randconfig-a014-20220926
i386                 randconfig-a012-20220926
i386                 randconfig-a013-20220926
i386                 randconfig-a016-20220926
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220925
hexagon              randconfig-r041-20220926
hexagon              randconfig-r045-20220925
hexagon              randconfig-r045-20220926
riscv                randconfig-r042-20220926
s390                 randconfig-r044-20220926
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
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
