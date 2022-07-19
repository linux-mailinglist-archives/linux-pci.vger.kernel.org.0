Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A1357A28A
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 17:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbiGSPAg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 11:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238712AbiGSPAV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 11:00:21 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA63B7A
        for <linux-pci@vger.kernel.org>; Tue, 19 Jul 2022 08:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658242819; x=1689778819;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=J139CXPu4rdS5TIcXoOoRijAyBZpljVgsfA+c5yW+uE=;
  b=m+HojOHslLUp4pAMOQNJ2H2VHKpEjLV8BVI0fL0pjVXUIRHceRkg5nU7
   OzMJscrpJYAH3qpsJtQhzzOZTlPvBm98VQRWI6b+OSg/zEFT8TjkNqVzM
   YhC4F75Ql/wDxUQRfmLCGBbOHIN74DLSF+7zjCNo2Wq2QsB6fEjLH0Z0r
   fer5+qCce03PtjWMtROtYCHdjkqI1ffCAOaEEs85NrkoAJA9Cfp+u6sj2
   o9XY7giSgSof1SI26jJEL6CM0z21AkOC7+42UIt4oe60NMdRpDCG4zGVY
   Vgwr/na0/FwINePKBRONI2PQ8k1gcum3waDMlZu1kf+Wh+EV3VhZGv2dm
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="266290045"
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="266290045"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 08:00:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="630357646"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 19 Jul 2022 08:00:17 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDohs-0005le-O3;
        Tue, 19 Jul 2022 15:00:16 +0000
Date:   Tue, 19 Jul 2022 22:59:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/ctrl/loongson] BUILD SUCCESS
 b1c2a2fbe27427ec5764ab7aa32c7ca20561cdb1
Message-ID: <62d6c6c7.1THBM+MqvE4zours%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ctrl/loongson
branch HEAD: b1c2a2fbe27427ec5764ab7aa32c7ca20561cdb1  PCI: loongson: Work around LS7A incorrect Interrupt Pin registers

elapsed time: 1227m

configs tested: 153
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                          randconfig-c001
i386                 randconfig-c001-20220718
powerpc                     tqm8541_defconfig
sh                          landisk_defconfig
sh                          r7785rp_defconfig
sh                            migor_defconfig
powerpc                      tqm8xx_defconfig
powerpc                  iss476-smp_defconfig
m68k                         amcore_defconfig
sh                           se7343_defconfig
sh                         microdev_defconfig
arm                          pxa910_defconfig
arm                        oxnas_v6_defconfig
sh                           se7206_defconfig
sparc                       sparc32_defconfig
sh                          sdk7786_defconfig
arm                         axm55xx_defconfig
arc                               allnoconfig
arm                       omap2plus_defconfig
arc                              alldefconfig
m68k                          multi_defconfig
mips                    maltaup_xpa_defconfig
arm                        mini2440_defconfig
sh                               alldefconfig
arm                          lpd270_defconfig
mips                       bmips_be_defconfig
sh                            titan_defconfig
sh                          rsk7264_defconfig
xtensa                       common_defconfig
sh                        sh7757lcr_defconfig
sparc                             allnoconfig
um                               alldefconfig
arm                        mvebu_v7_defconfig
loongarch                 loongson3_defconfig
sh                        sh7785lcr_defconfig
sh                             sh03_defconfig
arm64                            alldefconfig
m68k                                defconfig
arc                        nsim_700_defconfig
s390                                defconfig
arm                             rpc_defconfig
xtensa                  nommu_kc705_defconfig
m68k                       m5208evb_defconfig
arm                       imx_v6_v7_defconfig
m68k                        mvme16x_defconfig
mips                         db1xxx_defconfig
ia64                          tiger_defconfig
arc                    vdk_hs38_smp_defconfig
sparc                               defconfig
csky                                defconfig
x86_64                                  kexec
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
loongarch                           defconfig
loongarch                         allnoconfig
arm                  randconfig-c002-20220718
x86_64               randconfig-c001-20220718
csky                              allnoconfig
alpha                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
sh                               allmodconfig
mips                             allyesconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64               randconfig-a014-20220718
x86_64               randconfig-a016-20220718
x86_64               randconfig-a012-20220718
x86_64               randconfig-a013-20220718
x86_64               randconfig-a015-20220718
x86_64               randconfig-a011-20220718
i386                 randconfig-a015-20220718
i386                 randconfig-a011-20220718
i386                 randconfig-a012-20220718
i386                 randconfig-a014-20220718
i386                 randconfig-a016-20220718
i386                 randconfig-a013-20220718
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
s390                 randconfig-r044-20220718
riscv                randconfig-r042-20220718
arc                  randconfig-r043-20220718
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                      tct_hammer_defconfig
mips                          rm200_defconfig
arm                        mvebu_v5_defconfig
hexagon                          alldefconfig
mips                      bmips_stb_defconfig
powerpc                        fsp2_defconfig
powerpc                     akebono_defconfig
powerpc                    socrates_defconfig
powerpc                   bluestone_defconfig
arm                        vexpress_defconfig
powerpc                      obs600_defconfig
powerpc                     ppa8548_defconfig
arm                          ixp4xx_defconfig
arm                         hackkit_defconfig
arm                        multi_v5_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                 randconfig-a004-20220718
i386                 randconfig-a001-20220718
i386                 randconfig-a005-20220718
i386                 randconfig-a006-20220718
i386                 randconfig-a002-20220718
i386                 randconfig-a003-20220718
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a001-20220718
x86_64               randconfig-a005-20220718
x86_64               randconfig-a003-20220718
x86_64               randconfig-a002-20220718
x86_64               randconfig-a006-20220718
x86_64               randconfig-a004-20220718
hexagon              randconfig-r041-20220718
hexagon              randconfig-r045-20220718

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
