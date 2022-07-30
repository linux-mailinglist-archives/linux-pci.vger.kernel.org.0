Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E43D585BA0
	for <lists+linux-pci@lfdr.de>; Sat, 30 Jul 2022 20:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbiG3S3V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 30 Jul 2022 14:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbiG3S3U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 Jul 2022 14:29:20 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A304B165BE
        for <linux-pci@vger.kernel.org>; Sat, 30 Jul 2022 11:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659205759; x=1690741759;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=la8DANfvRVoP5cy3/F8GxrdG+0nPqlf20TnaQn26OWI=;
  b=FVGkySZDpYCpKjIn7IDaLEFEHJofTNEpAp655Lrp+Ikojh9o0oyPrgJI
   W5BCtMHP62EgfHualzdKUFSBOKTLktTXiFT3OUEIGIMr5zldfxVQycEib
   XrOzKr4WqsqOQZ8IYDknCNpowjZF6LFSkOATL+cc/Nff3vjpdxebH2dzI
   1cMq1+1e1zE74XkLHLK1CdRuY4+UF6BnAc8RuVlOYTVnOSmSW/U48YIpG
   Mu9mvO+5eiGsvY06ZqVm7ASJmUSdOKGcCyjs8gmaclU2/lPuSHiBwScpC
   +5TR7d/UzwTVODMJ6g9AwL6YOR8ul8kqegJ4IZyWaPS3/8ebnQMxRv0Ue
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="287693937"
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="287693937"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 11:29:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="629744988"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 30 Jul 2022 11:29:17 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHrDB-000D47-0t;
        Sat, 30 Jul 2022 18:29:17 +0000
Date:   Sun, 31 Jul 2022 02:28:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/ctrl/qcom] BUILD SUCCESS
 5147ba8af2d707d9bbd65e84286c42b11d612c83
Message-ID: <62e57842.Z4l0gutPfPP0/MUb%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ctrl/qcom
branch HEAD: 5147ba8af2d707d9bbd65e84286c42b11d612c83  PCI: qcom: Allow ASPM L1 and substates for 2.7.0

elapsed time: 1434m

configs tested: 148
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
arc                  randconfig-r043-20220729
i386                                defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                           allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
i386                          randconfig-a001
i386                          randconfig-a005
arm                                 defconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a006
powerpc                           allnoconfig
arm                              allyesconfig
arm64                            allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
x86_64                        randconfig-a004
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
powerpc                      bamboo_defconfig
m68k                          hp300_defconfig
sh                              ul2_defconfig
nios2                               defconfig
sh                         ecovec24_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arm                         lpc18xx_defconfig
powerpc                 mpc8540_ads_defconfig
xtensa                    xip_kc705_defconfig
i386                          randconfig-c001
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
powerpc                      pcm030_defconfig
m68k                                defconfig
mips                         tb0226_defconfig
sh                     sh7710voipgw_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
powerpc                     pq2fads_defconfig
ia64                            zx1_defconfig
xtensa                  audio_kc705_defconfig
sh                          r7785rp_defconfig
sh                            hp6xx_defconfig
mips                       bmips_be_defconfig
sh                           se7206_defconfig
powerpc                       eiger_defconfig
arm                           h3600_defconfig
x86_64                           alldefconfig
arm                             ezx_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                           jazz_defconfig
powerpc                      makalu_defconfig
powerpc                     tqm8541_defconfig
powerpc                     tqm8555_defconfig
arm                          badge4_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
sh                           se7724_defconfig
sh                          rsk7201_defconfig
sh                           se7619_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220729
sh                          r7780mp_defconfig
sh                         apsh4a3a_defconfig
powerpc                      mgcoge_defconfig
arm                        shmobile_defconfig
powerpc                        cell_defconfig
sh                          kfr2r09_defconfig
mips                          rb532_defconfig
m68k                        mvme147_defconfig
xtensa                    smp_lx200_defconfig
sh                            migor_defconfig
sh                        sh7757lcr_defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
mips                     decstation_defconfig
m68k                         amcore_defconfig
arm                       aspeed_g5_defconfig
arm                            qcom_defconfig
mips                        vocore2_defconfig
nios2                            allyesconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
arm                        clps711x_defconfig
powerpc                  iss476-smp_defconfig
ia64                             alldefconfig
parisc                generic-64bit_defconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig

clang tested configs:
hexagon              randconfig-r041-20220729
riscv                randconfig-r042-20220729
hexagon              randconfig-r045-20220729
s390                 randconfig-r044-20220729
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-k001
mips                     loongson1c_defconfig
arm                         palmz72_defconfig
arm                       imx_v4_v5_defconfig
powerpc                      katmai_defconfig
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
arm                      tct_hammer_defconfig
mips                        maltaup_defconfig
powerpc                 mpc832x_mds_defconfig
mips                      maltaaprp_defconfig
mips                          ath25_defconfig
powerpc                    socrates_defconfig
powerpc                          g5_defconfig
mips                           mtx1_defconfig
mips                           ip28_defconfig
powerpc                  mpc866_ads_defconfig
x86_64                           allyesconfig
arm                       spear13xx_defconfig
riscv                             allnoconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
