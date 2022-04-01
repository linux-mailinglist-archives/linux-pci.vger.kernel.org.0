Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DA84EE77C
	for <lists+linux-pci@lfdr.de>; Fri,  1 Apr 2022 07:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244933AbiDAFDL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Apr 2022 01:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243320AbiDAFDK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Apr 2022 01:03:10 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D03358E79
        for <linux-pci@vger.kernel.org>; Thu, 31 Mar 2022 22:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648789278; x=1680325278;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Qu46XfQc5xp21lfAiGstdU6TLDDBizkDD13U3xChAxU=;
  b=SgKFJ9s1z4/XuuFLF2nQ1oYKHj8kc7FCC3SFbaZdAiFAIklwA01y/jJY
   CC4NnlY6Y1pOV86bU3E7Xuwu+WUxFWZ1GD7nJ3V0xzmOXYSOM/SBI/iNn
   +sni20KvbKw8UIkYGLWGbpDJ3jTFMCuEH5UvxHfoAOVJVpq+9dQ5de/NC
   +IONPYoZcHoXXtPcnThSPZ0r+3Cyo23B5oKAJnupouTAJojrJmtnvKC3F
   3P7mIB/RbObwgyU2QAgFw8VGT3XGQ7KSHT4G27ImbF1FBN1F82TE+Fbd+
   8chSIuZfGqI+24/9ZEE11Sz7G7CRpz4Q3Dssbj4/h5VucVwmBkvX05Ch1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="240633599"
X-IronPort-AV: E=Sophos;i="5.90,226,1643702400"; 
   d="scan'208";a="240633599"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 22:01:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,226,1643702400"; 
   d="scan'208";a="586717631"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 31 Mar 2022 22:01:16 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1na9PQ-0000xU-2Z;
        Fri, 01 Apr 2022 05:01:16 +0000
Date:   Fri, 01 Apr 2022 13:01:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:for-linus] BUILD SUCCESS
 1c6cec4ab487eda9063355cf7dfe125966032bb7
Message-ID: <62468718.YgpEXNKDla79K9ao%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
branch HEAD: 1c6cec4ab487eda9063355cf7dfe125966032bb7  x86/PCI: Log host bridge window clipping for E820 regions

elapsed time: 765m

configs tested: 143
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20220331
sparc                            allyesconfig
parisc                           allyesconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
nios2                            allyesconfig
arm                           h5000_defconfig
mips                             allyesconfig
mips                           xway_defconfig
powerpc                       holly_defconfig
sh                          lboxre2_defconfig
ia64                            zx1_defconfig
sh                          landisk_defconfig
h8300                     edosk2674_defconfig
mips                           ip32_defconfig
arm                          badge4_defconfig
powerpc                      ppc40x_defconfig
sh                         ap325rxa_defconfig
openrisc                  or1klitex_defconfig
sh                          urquell_defconfig
sh                           se7721_defconfig
arm                        realview_defconfig
arm                         lpc18xx_defconfig
sh                           se7343_defconfig
m68k                         amcore_defconfig
riscv                               defconfig
sparc                       sparc32_defconfig
mips                    maltaup_xpa_defconfig
arm                        oxnas_v6_defconfig
sh                            titan_defconfig
sparc                       sparc64_defconfig
m68k                       m5275evb_defconfig
arm                            zeus_defconfig
mips                         mpc30x_defconfig
m68k                         apollo_defconfig
arm                        keystone_defconfig
sh                          polaris_defconfig
sh                          rsk7269_defconfig
m68k                        m5272c3_defconfig
arm                           tegra_defconfig
parisc                generic-32bit_defconfig
xtensa                       common_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                          iop32x_defconfig
sh                     magicpanelr2_defconfig
powerpc                     mpc83xx_defconfig
alpha                               defconfig
arc                        nsimosci_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220331
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
csky                                defconfig
arc                                 defconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220331
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
powerpc              randconfig-c003-20220331
x86_64                        randconfig-c007
s390                 randconfig-c005-20220331
arm                  randconfig-c002-20220331
riscv                randconfig-c006-20220331
mips                 randconfig-c004-20220331
i386                          randconfig-c001
riscv                             allnoconfig
powerpc                 mpc8560_ads_defconfig
powerpc                     pseries_defconfig
mips                      maltaaprp_defconfig
powerpc                     ppa8548_defconfig
arm                     am200epdkit_defconfig
mips                  cavium_octeon_defconfig
i386                             allyesconfig
powerpc                   lite5200b_defconfig
arm                          pxa168_defconfig
arm                  colibri_pxa300_defconfig
powerpc                      ppc64e_defconfig
powerpc                   microwatt_defconfig
arm                             mxs_defconfig
mips                      malta_kvm_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220331
riscv                randconfig-r042-20220331
s390                 randconfig-r044-20220331
hexagon              randconfig-r041-20220331

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
