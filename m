Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC1B73F031
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jun 2023 03:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjF0BNo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Jun 2023 21:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjF0BNn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jun 2023 21:13:43 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBB6173E
        for <linux-pci@vger.kernel.org>; Mon, 26 Jun 2023 18:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687828422; x=1719364422;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=r7zS1ZVFx66AceR/I1jHbO7hkt59wEfsJRdFUsvglAE=;
  b=kvJ3H5YMiULWEnXx0Pd6Pg25OTXgYkPfwfRFWQtELUOsAaL5Aq2Wi0Ip
   D6/Sb808pn48UiT7rQBdwMTt+BFjrP2/Us0mQ0EBQTetlEs14W4PPmwnp
   t9VCnhr3zSNVzeaH8L6Y2o9lR8G9YrMieUchPWvBI+ysKPqZcP9zRtYvo
   oDlb0RaYOLkS6OeQ+X+ePsI7LmvPfxhoxFNNQ0gtZ8K7aFe/E8U0YpeMr
   HFVBLaj/n93Eco/w5/qMbF3ZZNJNGT9YxjKGA9h2Sp2gohyFC5IXZGsxB
   n+3RTCPLy2T0I3ft1PiCG+wP16CURG9dc04WqAV82TazwEuNND2ULLSQ4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="360301220"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="360301220"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 18:13:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="890481467"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="890481467"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 26 Jun 2023 18:13:36 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qDxGx-000BEE-2j;
        Tue, 27 Jun 2023 01:13:35 +0000
Date:   Tue, 27 Jun 2023 09:13:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Krzysztof =?utf-8?Q?Wilczy=C5=84ski" ?= <kwilczynski@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:controller/vmd] BUILD SUCCESS
 0c0206dc4f5ba2d18b15e24d2047487d6f73916b
Message-ID: <202306270959.X3dUAr3M-lkp@intel.com>
User-Agent: s-nail v14.9.24
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/vmd
branch HEAD: 0c0206dc4f5ba2d18b15e24d2047487d6f73916b  PCI: vmd: Fix uninitialized variable usage in vmd_enable_domain()

elapsed time: 3377m

configs tested: 144
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                  randconfig-r004-20230625   gcc  
arc                  randconfig-r016-20230625   gcc  
arc                  randconfig-r043-20230625   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                       imx_v4_v5_defconfig   clang
arm                        keystone_defconfig   gcc  
arm                       netwinder_defconfig   clang
arm                          pxa910_defconfig   gcc  
arm                  randconfig-r024-20230625   gcc  
arm                  randconfig-r046-20230625   gcc  
arm                         s5pv210_defconfig   clang
arm                        shmobile_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
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
i386                 randconfig-r003-20230625   gcc  
i386                 randconfig-r011-20230625   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r014-20230625   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                 randconfig-r013-20230625   gcc  
microblaze           randconfig-r015-20230625   gcc  
microblaze           randconfig-r033-20230625   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                     loongson1b_defconfig   gcc  
mips                     loongson2k_defconfig   clang
mips                          malta_defconfig   clang
mips                      maltaaprp_defconfig   clang
mips                 randconfig-r025-20230625   gcc  
nios2                         10m50_defconfig   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r023-20230625   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                 canyonlands_defconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc                     ppa8548_defconfig   clang
powerpc              randconfig-r005-20230625   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                     tqm5200_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r006-20230625   gcc  
riscv                randconfig-r021-20230625   clang
riscv                randconfig-r042-20230625   clang
riscv                          rv32_defconfig   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230625   gcc  
s390                 randconfig-r026-20230625   clang
s390                 randconfig-r036-20230625   gcc  
s390                 randconfig-r044-20230625   clang
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                   randconfig-r034-20230625   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          rsk7264_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230625   gcc  
sparc64              randconfig-r031-20230625   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230625   gcc  
x86_64       buildonly-randconfig-r002-20230625   gcc  
x86_64       buildonly-randconfig-r003-20230625   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa               randconfig-r035-20230625   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
