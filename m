Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167886E90C3
	for <lists+linux-pci@lfdr.de>; Thu, 20 Apr 2023 12:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbjDTKqz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Apr 2023 06:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbjDTKqa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2023 06:46:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B3B170A
        for <linux-pci@vger.kernel.org>; Thu, 20 Apr 2023 03:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681987540; x=1713523540;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=y4t/eEEB7+8cnxOddLGdZW88KmplthOBDUp3N6r56og=;
  b=MyVe1sk420iC51hZafA7TOY4zx254TBRqHqII7yLcOKARmJUcpAVWqO2
   xR+ZyYxzKHg9xlhst+7xt7dDTY53YMQ5MRblPTADx0e1hjLPrhGANMHk/
   dRumjdjtlp3VgITQevFLFtuptpmqqF7XZ+fYeSsQMzBHEUTJMyZshQo7D
   qUlS+eTn5M855MXW6dUnkbmsKVoHw2mA78tG8gMFHv8i7HQhg4xl1vpQS
   OGuRvPCbveslr4uUfuuAkmpSeoolqLMdNIyLUHUVZI6gtEmDejmOT/VVK
   v07fzbsGNBKNfBVv3TOzABVL9X7IegXvxjHNbTQ/+jRAGOTC/preAUo6G
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="344452138"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="344452138"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 03:45:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="781201517"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="781201517"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Apr 2023 03:45:38 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppRnF-000fl8-2y;
        Thu, 20 Apr 2023 10:45:37 +0000
Date:   Thu, 20 Apr 2023 18:44:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:controller/kconfig] BUILD SUCCESS
 72cd9a84517d168c531fa25f3c700bb029050fc8
Message-ID: <644117a1.Ry0aH/ZuGynJup/D%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/kconfig
branch HEAD: 72cd9a84517d168c531fa25f3c700bb029050fc8  PCI: mobiveil: Sort Kconfig entries by vendor

elapsed time: 727m

configs tested: 165
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230417   gcc  
alpha                randconfig-r002-20230418   gcc  
alpha                randconfig-r004-20230417   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r002-20230420   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230416   gcc  
arc                  randconfig-r043-20230417   gcc  
arc                  randconfig-r043-20230420   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r004-20230420   clang
arm                                 defconfig   gcc  
arm                  randconfig-r013-20230417   gcc  
arm                  randconfig-r046-20230416   clang
arm                  randconfig-r046-20230417   gcc  
arm                  randconfig-r046-20230420   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r005-20230418   clang
arm64                randconfig-r016-20230416   gcc  
csky         buildonly-randconfig-r003-20230416   gcc  
csky         buildonly-randconfig-r005-20230416   gcc  
csky         buildonly-randconfig-r006-20230416   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r006-20230417   gcc  
csky                 randconfig-r013-20230420   gcc  
csky                 randconfig-r023-20230417   gcc  
csky                 randconfig-r024-20230417   gcc  
hexagon              randconfig-r003-20230417   clang
hexagon              randconfig-r012-20230420   clang
hexagon              randconfig-r022-20230416   clang
hexagon              randconfig-r036-20230417   clang
hexagon              randconfig-r041-20230416   clang
hexagon              randconfig-r041-20230417   clang
hexagon              randconfig-r041-20230420   clang
hexagon              randconfig-r045-20230416   clang
hexagon              randconfig-r045-20230417   clang
hexagon              randconfig-r045-20230420   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r001-20230417   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230417   gcc  
i386                 randconfig-a002-20230417   gcc  
i386                 randconfig-a003-20230417   gcc  
i386                 randconfig-a004-20230417   gcc  
i386                 randconfig-a005-20230417   gcc  
i386                 randconfig-a006-20230417   gcc  
i386                 randconfig-a011-20230417   clang
i386                 randconfig-a012-20230417   clang
i386                 randconfig-a013-20230417   clang
i386                 randconfig-a014-20230417   clang
i386                 randconfig-a015-20230417   clang
i386                 randconfig-a016-20230417   clang
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r004-20230417   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r012-20230416   gcc  
ia64                 randconfig-r033-20230416   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r005-20230417   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r011-20230420   gcc  
loongarch            randconfig-r034-20230416   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r003-20230416   gcc  
m68k                 randconfig-r004-20230416   gcc  
m68k                 randconfig-r011-20230417   gcc  
m68k                 randconfig-r013-20230416   gcc  
m68k                 randconfig-r025-20230417   gcc  
m68k                 randconfig-r034-20230420   gcc  
m68k                 randconfig-r035-20230420   gcc  
microblaze   buildonly-randconfig-r001-20230420   gcc  
microblaze   buildonly-randconfig-r002-20230416   gcc  
microblaze           randconfig-r014-20230417   gcc  
microblaze           randconfig-r016-20230417   gcc  
microblaze           randconfig-r026-20230416   gcc  
microblaze           randconfig-r031-20230416   gcc  
microblaze           randconfig-r032-20230420   gcc  
microblaze           randconfig-r034-20230417   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                         db1xxx_defconfig   gcc  
mips                 randconfig-r001-20230416   gcc  
nios2        buildonly-randconfig-r003-20230417   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230418   gcc  
nios2                randconfig-r014-20230420   gcc  
nios2                randconfig-r033-20230417   gcc  
nios2                randconfig-r035-20230417   gcc  
nios2                randconfig-r036-20230420   gcc  
openrisc             randconfig-r006-20230416   gcc  
openrisc             randconfig-r035-20230416   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     mpc5200_defconfig   clang
powerpc                 mpc8560_ads_defconfig   clang
powerpc              randconfig-r002-20230417   gcc  
powerpc              randconfig-r006-20230418   clang
powerpc              randconfig-r015-20230420   gcc  
powerpc              randconfig-r031-20230417   gcc  
powerpc              randconfig-r031-20230420   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r015-20230417   clang
riscv                randconfig-r021-20230416   gcc  
riscv                randconfig-r024-20230416   gcc  
riscv                randconfig-r042-20230416   gcc  
riscv                randconfig-r042-20230417   clang
riscv                randconfig-r042-20230420   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r005-20230416   clang
s390                 randconfig-r033-20230420   clang
s390                 randconfig-r036-20230416   clang
s390                 randconfig-r044-20230416   gcc  
s390                 randconfig-r044-20230417   clang
s390                 randconfig-r044-20230420   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r002-20230417   gcc  
sh           buildonly-randconfig-r004-20230416   gcc  
sh                   randconfig-r005-20230417   gcc  
sh                   randconfig-r016-20230420   gcc  
sh                   randconfig-r032-20230416   gcc  
sh                           se7721_defconfig   gcc  
sparc        buildonly-randconfig-r005-20230420   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230418   gcc  
sparc64              randconfig-r011-20230416   gcc  
sparc64              randconfig-r032-20230417   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230417   gcc  
x86_64               randconfig-a002-20230417   gcc  
x86_64               randconfig-a003-20230417   gcc  
x86_64               randconfig-a004-20230417   gcc  
x86_64               randconfig-a005-20230417   gcc  
x86_64               randconfig-a006-20230417   gcc  
x86_64               randconfig-a011-20230417   clang
x86_64               randconfig-a012-20230417   clang
x86_64               randconfig-a013-20230417   clang
x86_64               randconfig-a014-20230417   clang
x86_64               randconfig-a015-20230417   clang
x86_64               randconfig-a016-20230417   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r006-20230417   gcc  
xtensa       buildonly-randconfig-r006-20230420   gcc  
xtensa               randconfig-r014-20230416   gcc  
xtensa               randconfig-r021-20230417   gcc  
xtensa               randconfig-r022-20230417   gcc  
xtensa               randconfig-r026-20230417   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
