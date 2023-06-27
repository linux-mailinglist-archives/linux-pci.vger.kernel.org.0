Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB6873F08A
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jun 2023 03:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjF0B35 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Jun 2023 21:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjF0B3u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jun 2023 21:29:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4971993
        for <linux-pci@vger.kernel.org>; Mon, 26 Jun 2023 18:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687829389; x=1719365389;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iKdHolvnvEgxR9Bt29aiJMwyghD5MBN2NAg0+gzcXIc=;
  b=Ouy93hD0C/tlIGKqXfyGCSz+2teLWv2fpTsRRYfWgQQlVwBv3d4Pvaqr
   jzQf7K5jMZm1D8TSvIWdisygMxB45lGYijyx1GSLhrNQELT/CQIspwarM
   w+50EJwJTj7g+yNyQ6dAFRuLM5Qxcxs5oXyR7N4/M3Rrr/T46R6BRtgMs
   vzT1axAKD6PtG7o//IPGezlBNfihmFgXM4cPt/NHcuGQB4m24/9WvFbqI
   0FeglZrsB41kGfH6G5mYIzXnGtmdmAFgiQ7Q9/Y5dqdzxy3P3GraewBhz
   isG15rHdBjrxb1KtoujsYJD8I3mKjtVB07A0QNG9D922JGAKOTpHjTZ6W
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="391881526"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="391881526"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 18:29:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="719594062"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="719594062"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 26 Jun 2023 18:29:46 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qDxWc-000BY3-0U;
        Tue, 27 Jun 2023 01:29:46 +0000
Date:   Tue, 27 Jun 2023 09:28:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Krzysztof =?utf-8?Q?Wilczy=C5=84ski" ?= <kwilczynski@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:controller/apple] BUILD SUCCESS
 328a16477027b48bffa3bbee895328c4db798eb9
Message-ID: <202306270946.IcWwODJq-lkp@intel.com>
User-Agent: s-nail v14.9.24
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/apple
branch HEAD: 328a16477027b48bffa3bbee895328c4db798eb9  PCI: apple: Initialize pcie->nvecs before use

elapsed time: 3317m

configs tested: 165
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r013-20230625   gcc  
alpha                randconfig-r016-20230625   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                  randconfig-r015-20230625   gcc  
arc                  randconfig-r021-20230625   gcc  
arc                  randconfig-r026-20230625   gcc  
arc                  randconfig-r043-20230625   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                       imx_v4_v5_defconfig   clang
arm                        keystone_defconfig   gcc  
arm                       netwinder_defconfig   clang
arm                          pxa910_defconfig   gcc  
arm                  randconfig-r031-20230625   clang
arm                  randconfig-r046-20230625   gcc  
arm                         s5pv210_defconfig   clang
arm                        shmobile_defconfig   gcc  
arm                        spear6xx_defconfig   gcc  
arm                           spitz_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r024-20230625   clang
csky                             alldefconfig   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r041-20230625   clang
hexagon              randconfig-r045-20230625   clang
i386                             alldefconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230625   gcc  
i386         buildonly-randconfig-r005-20230625   gcc  
i386         buildonly-randconfig-r006-20230625   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230625   gcc  
i386                 randconfig-i002-20230625   gcc  
i386                 randconfig-i003-20230625   gcc  
i386                 randconfig-i004-20230625   gcc  
i386                 randconfig-i005-20230625   gcc  
i386                 randconfig-i006-20230625   gcc  
i386                 randconfig-i011-20230625   clang
i386                 randconfig-i012-20230625   clang
i386                 randconfig-i013-20230625   clang
i386                 randconfig-i014-20230625   clang
i386                 randconfig-i015-20230625   clang
i386                 randconfig-i016-20230625   clang
i386                 randconfig-r002-20230625   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230625   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r001-20230625   gcc  
microblaze           randconfig-r036-20230625   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                     loongson1b_defconfig   gcc  
mips                     loongson2k_defconfig   clang
mips                      maltaaprp_defconfig   clang
nios2                         10m50_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r006-20230625   gcc  
openrisc             randconfig-r025-20230625   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc               randconfig-r003-20230625   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                 canyonlands_defconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc                 mpc85xx_cds_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc                       ppc64_defconfig   gcc  
powerpc              randconfig-r005-20230625   gcc  
powerpc              randconfig-r034-20230625   gcc  
powerpc              randconfig-r035-20230625   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r033-20230625   gcc  
riscv                randconfig-r042-20230625   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230625   clang
sh                               allmodconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                   randconfig-r011-20230625   gcc  
sh                   randconfig-r014-20230625   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          rsk7264_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r023-20230625   gcc  
sparc                       sparc64_defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r032-20230625   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230625   gcc  
x86_64       buildonly-randconfig-r002-20230625   gcc  
x86_64       buildonly-randconfig-r003-20230625   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa               randconfig-r022-20230625   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
