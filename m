Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469726FDD4E
	for <lists+linux-pci@lfdr.de>; Wed, 10 May 2023 13:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236661AbjEJL7d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 May 2023 07:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjEJL7d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 May 2023 07:59:33 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453C461B0
        for <linux-pci@vger.kernel.org>; Wed, 10 May 2023 04:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683719971; x=1715255971;
  h=date:from:to:cc:subject:message-id;
  bh=VEGumnE9Udg0JkwDkG8yqSjRfGVkaAZgpNjzrAS94S4=;
  b=Kt4r11PWyOcvW2rKwDJFlltZ+7OP+hDedcI5x8OYG3FYFlDtUwYPrplZ
   bqc3JhAorE3VT4L47viSG2Z9Fm5Ybn2Ei3aQWhtkaISRNotsbG/fIpqKN
   NzrFC3UXiO08xmQZv7tIeR+k8YYfwnYHH3ESOVw29SKtQ27kqaBKXMkDg
   JO2tSsgQl8UrQg0ZJie9ZqrqYMga1gihWaV2rIRhvakb57shP20gfyWva
   pfETGpPxZob1B63H60ziK4rcc2MmBq0buAEVMEC8SqKGJ0PPKYBztCI3v
   mb61JplXE8/LzTCZisiY/bV5p3ccEBpgv+GtiKaUADHYSea1621NRg8Hc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="436517587"
X-IronPort-AV: E=Sophos;i="5.99,264,1677571200"; 
   d="scan'208";a="436517587"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 04:59:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="732122820"
X-IronPort-AV: E=Sophos;i="5.99,264,1677571200"; 
   d="scan'208";a="732122820"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 10 May 2023 04:59:29 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwiTh-0003FE-0u;
        Wed, 10 May 2023 11:59:29 +0000
Date:   Wed, 10 May 2023 19:58:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:virtualization] BUILD SUCCESS
 0ac448e0d29d6ba978684b3fa2e3ac7294ec2475
Message-ID: <20230510115837.wXH8B%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git virtualization
branch HEAD: 0ac448e0d29d6ba978684b3fa2e3ac7294ec2475  PCI: Delay after FLR of Solidigm P44 Pro NVMe

elapsed time: 847m

configs tested: 157
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r005-20230509   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r004-20230509   gcc  
arc          buildonly-randconfig-r005-20230509   gcc  
arc          buildonly-randconfig-r006-20230509   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r011-20230509   gcc  
arc                  randconfig-r014-20230509   gcc  
arc                  randconfig-r036-20230509   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          exynos_defconfig   gcc  
arm                         lpc32xx_defconfig   clang
arm                          moxart_defconfig   clang
arm                        neponset_defconfig   clang
arm                  randconfig-r024-20230509   gcc  
arm                         s5pv210_defconfig   clang
arm                          sp7021_defconfig   clang
arm                    vt8500_v6_v7_defconfig   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r006-20230509   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230509   gcc  
arm64                randconfig-r004-20230509   gcc  
arm64                randconfig-r021-20230509   clang
csky                                defconfig   gcc  
csky                 randconfig-r001-20230509   gcc  
csky                 randconfig-r006-20230509   gcc  
csky                 randconfig-r014-20230509   gcc  
hexagon              randconfig-r031-20230509   clang
hexagon              randconfig-r041-20230509   clang
hexagon              randconfig-r041-20230510   clang
hexagon              randconfig-r045-20230509   clang
hexagon              randconfig-r045-20230510   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a004   clang
i386                          randconfig-a006   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a014   gcc  
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r012-20230509   gcc  
ia64                 randconfig-r013-20230509   gcc  
ia64                 randconfig-r015-20230509   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r005-20230509   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r013-20230509   gcc  
loongarch            randconfig-r021-20230509   gcc  
m68k                             allmodconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
m68k                 randconfig-r004-20230509   gcc  
m68k                 randconfig-r023-20230509   gcc  
m68k                 randconfig-r034-20230509   gcc  
microblaze   buildonly-randconfig-r002-20230509   gcc  
microblaze   buildonly-randconfig-r003-20230509   gcc  
microblaze           randconfig-r001-20230509   gcc  
microblaze           randconfig-r005-20230509   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r001-20230509   clang
nios2        buildonly-randconfig-r001-20230509   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r021-20230509   gcc  
nios2                randconfig-r026-20230509   gcc  
nios2                randconfig-r033-20230509   gcc  
openrisc             randconfig-r006-20230509   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r015-20230509   gcc  
parisc               randconfig-r035-20230509   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc                 mpc8560_ads_defconfig   clang
powerpc              randconfig-r004-20230509   gcc  
powerpc              randconfig-r005-20230509   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230509   clang
riscv        buildonly-randconfig-r004-20230509   clang
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                randconfig-r042-20230509   clang
riscv                randconfig-r042-20230510   clang
riscv                          rv32_defconfig   gcc  
s390                             alldefconfig   clang
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r002-20230509   gcc  
s390                 randconfig-r026-20230509   clang
s390                 randconfig-r044-20230509   clang
s390                 randconfig-r044-20230510   clang
sh                               allmodconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                   randconfig-r002-20230509   gcc  
sh                   randconfig-r003-20230509   gcc  
sh                   randconfig-r014-20230509   gcc  
sh                   randconfig-r032-20230509   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sh                            titan_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc        buildonly-randconfig-r004-20230509   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230509   gcc  
sparc                randconfig-r012-20230509   gcc  
sparc                randconfig-r015-20230509   gcc  
sparc                randconfig-r016-20230509   gcc  
sparc                randconfig-r024-20230509   gcc  
sparc                randconfig-r026-20230509   gcc  
sparc64      buildonly-randconfig-r003-20230509   gcc  
sparc64              randconfig-r005-20230509   gcc  
sparc64              randconfig-r006-20230509   gcc  
sparc64              randconfig-r016-20230509   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                        randconfig-k001   clang
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r001-20230509   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa               randconfig-r001-20230509   gcc  
xtensa               randconfig-r002-20230509   gcc  
xtensa               randconfig-r022-20230509   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
