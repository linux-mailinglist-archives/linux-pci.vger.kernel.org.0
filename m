Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90F2715E47
	for <lists+linux-pci@lfdr.de>; Tue, 30 May 2023 14:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjE3MAn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 May 2023 08:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjE3MAm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 May 2023 08:00:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A4C100
        for <linux-pci@vger.kernel.org>; Tue, 30 May 2023 05:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685448028; x=1716984028;
  h=date:from:to:cc:subject:message-id;
  bh=P5XZm61U59PCpoYWfnpFDrQhtTgX5JY7leXUXH6b8ZM=;
  b=diZuUybgYIxo+0GjU+r6z3RKdXab2xq6DUZGb/d9f0a4IQF159YLYd7Q
   LXhJFETo9Uyo+3EzEfPkmR4Lhhisq8iiwffdS+dKCx/xV7bKkBJXRZ5ii
   WEQdT8YNFyoWb+BUC2/SYEuPeBoL7tE3HNqWr73FMFofWBtJUQhyqcPOU
   HlVLTVake9I8iSQoZBz8j9qIqZLsyjBd8+Cth33aL9299xtIqV2MJdXKt
   Y289y65CUcfP2897ysmYuY0YE4A+RRpDkqcZHwqnuXqi+wSpGa9hp5onR
   Rx4I8NINAwCDZx6C9tNOJ2YTrVzqxu8ASPNMIrTPz3Y97DbRSnnnFZsDl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="357267646"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="357267646"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 05:00:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="683936922"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="683936922"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 30 May 2023 05:00:16 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q3y1P-0000RD-0D;
        Tue, 30 May 2023 12:00:15 +0000
Date:   Tue, 30 May 2023 19:59:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:controller/dwc] BUILD SUCCESS
 da56a1bfbab55189595e588f1d984bdfb5cf5924
Message-ID: <20230530115916.fx-Zl%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
branch HEAD: da56a1bfbab55189595e588f1d984bdfb5cf5924  PCI: dwc: Wait for link up only if link is started

elapsed time: 5891m

configs tested: 298
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r026-20230530   gcc  
arc                              alldefconfig   gcc  
arc                              allyesconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r006-20230526   gcc  
arc                  randconfig-r031-20230530   gcc  
arc                  randconfig-r043-20230530   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                                 defconfig   gcc  
arm                           stm32_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r023-20230526   gcc  
csky                 randconfig-r025-20230526   gcc  
csky                 randconfig-r032-20230526   gcc  
csky                 randconfig-r032-20230530   gcc  
hexagon              randconfig-r015-20230528   clang
hexagon              randconfig-r041-20230526   clang
hexagon              randconfig-r045-20230526   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230526   gcc  
i386                 randconfig-i001-20230528   gcc  
i386                 randconfig-i001-20230530   clang
i386                 randconfig-i002-20230526   gcc  
i386                 randconfig-i002-20230528   gcc  
i386                 randconfig-i002-20230530   clang
i386                 randconfig-i003-20230526   gcc  
i386                 randconfig-i003-20230528   gcc  
i386                 randconfig-i003-20230530   clang
i386                 randconfig-i004-20230526   gcc  
i386                 randconfig-i004-20230528   gcc  
i386                 randconfig-i004-20230530   clang
i386                 randconfig-i005-20230526   gcc  
i386                 randconfig-i005-20230528   gcc  
i386                 randconfig-i005-20230530   clang
i386                 randconfig-i006-20230526   gcc  
i386                 randconfig-i006-20230528   gcc  
i386                 randconfig-i006-20230530   clang
i386                 randconfig-i011-20230526   clang
i386                 randconfig-i011-20230530   gcc  
i386                 randconfig-i012-20230526   clang
i386                 randconfig-i012-20230530   gcc  
i386                 randconfig-i013-20230526   clang
i386                 randconfig-i013-20230530   gcc  
i386                 randconfig-i014-20230526   clang
i386                 randconfig-i014-20230530   gcc  
i386                 randconfig-i015-20230526   clang
i386                 randconfig-i016-20230526   clang
i386                 randconfig-i051-20230526   gcc  
i386                 randconfig-i052-20230526   gcc  
i386                 randconfig-i053-20230526   gcc  
i386                 randconfig-i054-20230526   gcc  
i386                 randconfig-i055-20230526   gcc  
i386                 randconfig-i056-20230526   gcc  
i386                 randconfig-i061-20230526   gcc  
i386                 randconfig-i061-20230528   gcc  
i386                 randconfig-i062-20230526   gcc  
i386                 randconfig-i062-20230528   gcc  
i386                 randconfig-i063-20230526   gcc  
i386                 randconfig-i063-20230528   gcc  
i386                 randconfig-i064-20230526   gcc  
i386                 randconfig-i064-20230528   gcc  
i386                 randconfig-i065-20230526   gcc  
i386                 randconfig-i065-20230528   gcc  
i386                 randconfig-i066-20230526   gcc  
i386                 randconfig-i066-20230528   gcc  
i386                 randconfig-i071-20230528   clang
i386                 randconfig-i072-20230528   clang
i386                 randconfig-i072-20230530   gcc  
i386                 randconfig-i073-20230528   clang
i386                 randconfig-i074-20230528   clang
i386                 randconfig-i074-20230530   gcc  
i386                 randconfig-i075-20230528   clang
i386                 randconfig-i075-20230530   gcc  
i386                 randconfig-i076-20230528   clang
i386                 randconfig-i076-20230530   gcc  
i386                 randconfig-i081-20230528   clang
i386                 randconfig-i082-20230528   clang
i386                 randconfig-i082-20230530   gcc  
i386                 randconfig-i083-20230528   clang
i386                 randconfig-i083-20230530   gcc  
i386                 randconfig-i084-20230528   clang
i386                 randconfig-i084-20230530   gcc  
i386                 randconfig-i085-20230528   clang
i386                 randconfig-i085-20230530   gcc  
i386                 randconfig-i086-20230528   clang
i386                 randconfig-i091-20230526   gcc  
i386                 randconfig-i091-20230528   gcc  
i386                 randconfig-i091-20230530   clang
i386                 randconfig-i092-20230526   gcc  
i386                 randconfig-i092-20230528   gcc  
i386                 randconfig-i092-20230530   clang
i386                 randconfig-i093-20230526   gcc  
i386                 randconfig-i093-20230528   gcc  
i386                 randconfig-i093-20230530   clang
i386                 randconfig-i094-20230526   gcc  
i386                 randconfig-i094-20230528   gcc  
i386                 randconfig-i094-20230530   clang
i386                 randconfig-i095-20230526   gcc  
i386                 randconfig-i095-20230528   gcc  
i386                 randconfig-i095-20230530   clang
i386                 randconfig-i096-20230526   gcc  
i386                 randconfig-i096-20230528   gcc  
i386                 randconfig-i096-20230530   clang
i386                 randconfig-r024-20230530   gcc  
ia64                         bigsur_defconfig   gcc  
ia64                            zx1_defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230526   gcc  
loongarch            randconfig-r021-20230526   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r035-20230530   gcc  
m68k                           virt_defconfig   gcc  
microblaze           randconfig-r012-20230530   gcc  
microblaze           randconfig-r023-20230530   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                            gpr_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r011-20230530   gcc  
nios2                randconfig-r022-20230526   gcc  
openrisc             randconfig-r036-20230530   gcc  
openrisc                       virt_defconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230526   gcc  
parisc               randconfig-r036-20230526   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                 mpc8540_ads_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230526   clang
riscv                randconfig-r042-20230530   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r003-20230526   clang
s390                                defconfig   gcc  
s390                 randconfig-r013-20230530   gcc  
s390                 randconfig-r014-20230530   gcc  
s390                 randconfig-r034-20230526   gcc  
s390                 randconfig-r044-20230526   clang
s390                 randconfig-r044-20230530   gcc  
sh                               alldefconfig   gcc  
sh                               allmodconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                   randconfig-r012-20230526   gcc  
sh                   randconfig-r013-20230526   gcc  
sh                   randconfig-r014-20230526   gcc  
sh                   randconfig-r022-20230530   gcc  
sh                   randconfig-r026-20230526   gcc  
sh                          rsk7264_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230526   gcc  
sparc                randconfig-r016-20230530   gcc  
sparc                randconfig-r031-20230526   gcc  
sparc64              randconfig-r033-20230526   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230526   gcc  
x86_64               randconfig-a002-20230526   gcc  
x86_64               randconfig-a003-20230526   gcc  
x86_64               randconfig-a004-20230526   gcc  
x86_64               randconfig-a005-20230526   gcc  
x86_64               randconfig-a006-20230526   gcc  
x86_64               randconfig-a011-20230526   clang
x86_64               randconfig-a011-20230528   clang
x86_64               randconfig-a011-20230530   gcc  
x86_64               randconfig-a012-20230526   clang
x86_64               randconfig-a012-20230528   clang
x86_64               randconfig-a012-20230530   gcc  
x86_64               randconfig-a013-20230526   clang
x86_64               randconfig-a013-20230528   clang
x86_64               randconfig-a013-20230530   gcc  
x86_64               randconfig-a014-20230526   clang
x86_64               randconfig-a014-20230528   clang
x86_64               randconfig-a014-20230530   gcc  
x86_64               randconfig-a015-20230526   clang
x86_64               randconfig-a015-20230528   clang
x86_64               randconfig-a015-20230530   gcc  
x86_64               randconfig-a016-20230526   clang
x86_64               randconfig-a016-20230528   clang
x86_64               randconfig-a016-20230530   gcc  
x86_64               randconfig-x051-20230526   clang
x86_64               randconfig-x051-20230528   clang
x86_64               randconfig-x051-20230530   gcc  
x86_64               randconfig-x052-20230526   clang
x86_64               randconfig-x052-20230528   clang
x86_64               randconfig-x052-20230530   gcc  
x86_64               randconfig-x053-20230526   clang
x86_64               randconfig-x053-20230528   clang
x86_64               randconfig-x053-20230530   gcc  
x86_64               randconfig-x054-20230526   clang
x86_64               randconfig-x054-20230528   clang
x86_64               randconfig-x054-20230530   gcc  
x86_64               randconfig-x055-20230526   clang
x86_64               randconfig-x055-20230528   clang
x86_64               randconfig-x055-20230530   gcc  
x86_64               randconfig-x056-20230526   clang
x86_64               randconfig-x056-20230528   clang
x86_64               randconfig-x056-20230530   gcc  
x86_64               randconfig-x061-20230526   clang
x86_64               randconfig-x061-20230528   clang
x86_64               randconfig-x061-20230530   gcc  
x86_64               randconfig-x062-20230526   clang
x86_64               randconfig-x062-20230528   clang
x86_64               randconfig-x062-20230530   gcc  
x86_64               randconfig-x063-20230526   clang
x86_64               randconfig-x063-20230528   clang
x86_64               randconfig-x063-20230530   gcc  
x86_64               randconfig-x064-20230526   clang
x86_64               randconfig-x064-20230528   clang
x86_64               randconfig-x064-20230530   gcc  
x86_64               randconfig-x065-20230526   clang
x86_64               randconfig-x065-20230528   clang
x86_64               randconfig-x065-20230530   gcc  
x86_64               randconfig-x066-20230526   clang
x86_64               randconfig-x066-20230528   clang
x86_64               randconfig-x066-20230530   gcc  
x86_64               randconfig-x071-20230526   gcc  
x86_64               randconfig-x071-20230528   gcc  
x86_64               randconfig-x071-20230530   clang
x86_64               randconfig-x072-20230526   gcc  
x86_64               randconfig-x072-20230528   gcc  
x86_64               randconfig-x072-20230530   clang
x86_64               randconfig-x073-20230528   gcc  
x86_64               randconfig-x073-20230530   clang
x86_64               randconfig-x074-20230526   gcc  
x86_64               randconfig-x074-20230528   gcc  
x86_64               randconfig-x074-20230530   clang
x86_64               randconfig-x075-20230526   gcc  
x86_64               randconfig-x075-20230528   gcc  
x86_64               randconfig-x075-20230530   clang
x86_64               randconfig-x076-20230526   gcc  
x86_64               randconfig-x076-20230528   gcc  
x86_64               randconfig-x076-20230530   clang
x86_64               randconfig-x081-20230526   gcc  
x86_64               randconfig-x081-20230528   gcc  
x86_64               randconfig-x081-20230530   clang
x86_64               randconfig-x082-20230526   gcc  
x86_64               randconfig-x082-20230528   gcc  
x86_64               randconfig-x082-20230530   clang
x86_64               randconfig-x083-20230526   gcc  
x86_64               randconfig-x083-20230528   gcc  
x86_64               randconfig-x083-20230530   clang
x86_64               randconfig-x084-20230526   gcc  
x86_64               randconfig-x084-20230528   gcc  
x86_64               randconfig-x084-20230530   clang
x86_64               randconfig-x085-20230526   gcc  
x86_64               randconfig-x085-20230528   gcc  
x86_64               randconfig-x085-20230530   clang
x86_64               randconfig-x086-20230526   gcc  
x86_64               randconfig-x086-20230528   gcc  
x86_64               randconfig-x086-20230530   clang
x86_64               randconfig-x091-20230526   clang
x86_64               randconfig-x091-20230528   clang
x86_64               randconfig-x091-20230530   gcc  
x86_64               randconfig-x092-20230526   clang
x86_64               randconfig-x092-20230528   clang
x86_64               randconfig-x092-20230530   gcc  
x86_64               randconfig-x093-20230526   clang
x86_64               randconfig-x093-20230528   clang
x86_64               randconfig-x093-20230530   gcc  
x86_64               randconfig-x094-20230526   clang
x86_64               randconfig-x094-20230528   clang
x86_64               randconfig-x094-20230530   gcc  
x86_64               randconfig-x095-20230526   clang
x86_64               randconfig-x095-20230528   clang
x86_64               randconfig-x095-20230530   gcc  
x86_64               randconfig-x096-20230526   clang
x86_64               randconfig-x096-20230528   clang
x86_64               randconfig-x096-20230530   gcc  
x86_64                               rhel-8.3   gcc  
xtensa                generic_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
