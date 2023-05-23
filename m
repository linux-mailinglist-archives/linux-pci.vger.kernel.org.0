Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE2D70DC86
	for <lists+linux-pci@lfdr.de>; Tue, 23 May 2023 14:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjEWMZd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 May 2023 08:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236438AbjEWMZc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 May 2023 08:25:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FA3130
        for <linux-pci@vger.kernel.org>; Tue, 23 May 2023 05:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684844702; x=1716380702;
  h=date:from:to:cc:subject:message-id;
  bh=HBRHFZP416b0mgDZqSZEBFj0vzxsdfOqFdk7LPao6Os=;
  b=WMtOFIdkg7YtCkfUpgY3IPF3lBzsKg3q1aTjPc4jRmpR1t6/AN5i8nUq
   HVs29hkWDrPCpZP2eznUJ32XTDXvoOCavqhUPizkH5XTyHQZUntPWAU9A
   5CPSjJE3qlUZEBF9WOuB/q3gAzJbYBev8RlqgiC8+gEhulEK5k4kjLNZo
   arvgySai18UJWAiz43F3p4Ie+QVzRoUPz2ljU//C/OabCEWrSGB8FTKNI
   L5Atq30l3quNRU7SWpEZeKo4iCljU54unsszHtJzuaNzR4ImfTg6HUBj/
   RxMMv25BUFrSxIxt0mmqLkEzrhHNha+vZDkvgyDPSbGdXj5ej8IvTUgVF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="350729636"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="350729636"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 05:24:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="681373415"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="681373415"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 23 May 2023 05:24:14 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q1R3l-000Dl3-1A;
        Tue, 23 May 2023 12:24:13 +0000
Date:   Tue, 23 May 2023 20:23:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:hotplug] BUILD SUCCESS
 aa03620bb7a2644858a0ce7d013b3e16f5afcb50
Message-ID: <20230523122348.176mY%lkp@intel.com>
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

tree/branch: INFO setup_repo_specs: /db/releases/20230523172912/lkp-src/repo/*/pci
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git hotplug
branch HEAD: aa03620bb7a2644858a0ce7d013b3e16f5afcb50  PCI: acpiphp: Reassign resources on bridge if necessary

elapsed time: 742m

configs tested: 183
configs skipped: 16

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230522   gcc  
alpha                randconfig-r011-20230522   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r001-20230521   gcc  
arc          buildonly-randconfig-r001-20230522   gcc  
arc          buildonly-randconfig-r003-20230522   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r003-20230522   gcc  
arc                  randconfig-r014-20230521   gcc  
arc                  randconfig-r033-20230522   gcc  
arc                  randconfig-r043-20230521   gcc  
arc                  randconfig-r043-20230522   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r003-20230521   gcc  
arm                  randconfig-r031-20230521   gcc  
arm                  randconfig-r034-20230522   clang
arm                  randconfig-r046-20230521   clang
arm                  randconfig-r046-20230522   gcc  
arm                       spear13xx_defconfig   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r006-20230522   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r016-20230522   clang
arm64                randconfig-r031-20230521   clang
arm64                randconfig-r035-20230521   clang
csky         buildonly-randconfig-r004-20230521   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r005-20230522   gcc  
csky                 randconfig-r012-20230521   gcc  
hexagon      buildonly-randconfig-r006-20230522   clang
hexagon              randconfig-r024-20230521   clang
hexagon              randconfig-r041-20230521   clang
hexagon              randconfig-r041-20230522   clang
hexagon              randconfig-r045-20230521   clang
hexagon              randconfig-r045-20230522   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230522   gcc  
i386                 randconfig-a002-20230522   gcc  
i386                 randconfig-a003-20230522   gcc  
i386                 randconfig-a004-20230522   gcc  
i386                 randconfig-a005-20230522   gcc  
i386                 randconfig-a006-20230522   gcc  
i386                 randconfig-r026-20230522   clang
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r002-20230521   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r004-20230523   gcc  
ia64                 randconfig-r013-20230522   gcc  
ia64                 randconfig-r032-20230521   gcc  
ia64                          tiger_defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230521   gcc  
loongarch            randconfig-r032-20230522   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                 randconfig-r005-20230521   gcc  
m68k                 randconfig-r014-20230522   gcc  
m68k                 randconfig-r036-20230522   gcc  
microblaze           randconfig-r016-20230521   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r002-20230522   clang
mips                  decstation_64_defconfig   gcc  
nios2                            alldefconfig   gcc  
nios2        buildonly-randconfig-r004-20230521   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r035-20230522   gcc  
openrisc     buildonly-randconfig-r002-20230521   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc             randconfig-r006-20230521   gcc  
openrisc             randconfig-r014-20230522   gcc  
openrisc             randconfig-r033-20230521   gcc  
parisc       buildonly-randconfig-r002-20230522   gcc  
parisc       buildonly-randconfig-r004-20230522   gcc  
parisc       buildonly-randconfig-r006-20230521   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230523   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r005-20230521   gcc  
powerpc                    mvme5100_defconfig   clang
powerpc                      pmac32_defconfig   clang
powerpc              randconfig-r004-20230522   gcc  
powerpc              randconfig-r034-20230522   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                     stx_gp3_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r034-20230521   clang
riscv                randconfig-r042-20230521   gcc  
riscv                randconfig-r042-20230522   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r006-20230522   gcc  
s390                 randconfig-r011-20230521   gcc  
s390                 randconfig-r013-20230521   gcc  
s390                 randconfig-r044-20230521   gcc  
s390                 randconfig-r044-20230522   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r003-20230521   gcc  
sh           buildonly-randconfig-r006-20230521   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                   randconfig-r015-20230521   gcc  
sparc        buildonly-randconfig-r005-20230521   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r012-20230521   gcc  
sparc                randconfig-r015-20230522   gcc  
sparc64      buildonly-randconfig-r003-20230521   gcc  
sparc64              randconfig-r015-20230522   gcc  
sparc64              randconfig-r016-20230521   gcc  
sparc64              randconfig-r032-20230521   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230522   gcc  
x86_64               randconfig-a002-20230522   gcc  
x86_64               randconfig-a003-20230522   gcc  
x86_64               randconfig-a004-20230522   gcc  
x86_64               randconfig-a005-20230522   gcc  
x86_64               randconfig-a006-20230522   gcc  
x86_64               randconfig-a011-20230522   clang
x86_64               randconfig-a012-20230522   clang
x86_64               randconfig-a013-20230522   clang
x86_64               randconfig-a014-20230522   clang
x86_64               randconfig-a015-20230522   clang
x86_64               randconfig-a016-20230522   clang
x86_64                        randconfig-k001   clang
x86_64               randconfig-r013-20230522   clang
x86_64               randconfig-x051-20230522   clang
x86_64               randconfig-x052-20230522   clang
x86_64               randconfig-x053-20230522   clang
x86_64               randconfig-x054-20230522   clang
x86_64               randconfig-x055-20230522   clang
x86_64               randconfig-x056-20230522   clang
x86_64               randconfig-x061-20230522   clang
x86_64               randconfig-x062-20230522   clang
x86_64               randconfig-x063-20230522   clang
x86_64               randconfig-x064-20230522   clang
x86_64               randconfig-x065-20230522   clang
x86_64               randconfig-x066-20230522   clang
x86_64               randconfig-x071-20230522   gcc  
x86_64               randconfig-x072-20230522   gcc  
x86_64               randconfig-x073-20230522   gcc  
x86_64               randconfig-x074-20230522   gcc  
x86_64               randconfig-x075-20230522   gcc  
x86_64               randconfig-x076-20230522   gcc  
x86_64               randconfig-x081-20230522   gcc  
x86_64               randconfig-x082-20230522   gcc  
x86_64               randconfig-x083-20230522   gcc  
x86_64               randconfig-x084-20230522   gcc  
x86_64               randconfig-x085-20230522   gcc  
x86_64               randconfig-x086-20230522   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                           rhel-8.3-syz   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r004-20230522   gcc  
xtensa               randconfig-r013-20230521   gcc  
xtensa               randconfig-r032-20230522   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
