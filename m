Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51A56D91BC
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 10:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbjDFIe5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 04:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbjDFIey (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 04:34:54 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4278E12F
        for <linux-pci@vger.kernel.org>; Thu,  6 Apr 2023 01:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680770093; x=1712306093;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Yl+kjm7GoDMjyBfOw9L8gbDjk84Ixdi6BsikLnLLS2U=;
  b=LmW/q7B2/bDw2Mm/ewsa/BEbB1UL/CM78zhegK44uEFb6SaPddwf+Z0u
   6yQKtAjR0CPvWGuAzg8ahSL4+fEqG23Iw+O+SnyLrCOiCwQAEhyfBeSWH
   sL5mdxD0p28B5xr6zuIlHf3j4pagdCg47FMNWHoIkIWgpZaYXBIsKBoHa
   yhG7qBz5DxaUVYTkDv69O9Glxv7kCBXdcXKAGtTWO09synS/s6Bw/v5b4
   ChNzTY90R0+QqbcdgLE7BotusGjfRWqmTDjlde5EuK4PZG4Rzuw0VXMug
   oAOS0maQHnxXGROGTUi29Y3Rd1QDCtN6mo7Qf/408l6K4yOguN86eWmsU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="340172609"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="340172609"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 01:34:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="680587011"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="680587011"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 06 Apr 2023 01:34:45 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pkL4u-000RDz-1O;
        Thu, 06 Apr 2023 08:34:44 +0000
Date:   Thu, 06 Apr 2023 16:34:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:resource] BUILD SUCCESS
 e34a6ba53e80d7f6c6eb61d0438842d9ba63504a
Message-ID: <642e8403.4yKFV/HHO3FBriJI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git resource
branch HEAD: e34a6ba53e80d7f6c6eb61d0438842d9ba63504a  EISA: Drop unused pci_bus_for_each_resource() index argument

elapsed time: 726m

configs tested: 220
configs skipped: 15

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230403   gcc  
alpha        buildonly-randconfig-r005-20230403   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230403   gcc  
alpha                randconfig-r003-20230405   gcc  
alpha                randconfig-r005-20230403   gcc  
alpha                randconfig-r016-20230403   gcc  
alpha                randconfig-r021-20230403   gcc  
alpha                randconfig-r023-20230403   gcc  
alpha                randconfig-r026-20230403   gcc  
alpha                randconfig-r034-20230403   gcc  
alpha                randconfig-r036-20230403   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r004-20230403   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230403   gcc  
arc                  randconfig-r023-20230405   gcc  
arc                  randconfig-r033-20230403   gcc  
arc                  randconfig-r034-20230403   gcc  
arc                  randconfig-r043-20230403   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                            mmp2_defconfig   clang
arm                  randconfig-r021-20230403   clang
arm                  randconfig-r021-20230405   clang
arm                  randconfig-r031-20230403   gcc  
arm                  randconfig-r034-20230403   gcc  
arm                  randconfig-r035-20230403   gcc  
arm                  randconfig-r046-20230403   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230403   clang
arm64                randconfig-r012-20230403   gcc  
arm64                randconfig-r021-20230403   gcc  
arm64                randconfig-r026-20230405   gcc  
csky         buildonly-randconfig-r003-20230403   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r002-20230405   gcc  
csky                 randconfig-r011-20230403   gcc  
csky                 randconfig-r012-20230403   gcc  
csky                 randconfig-r035-20230403   gcc  
hexagon      buildonly-randconfig-r001-20230403   clang
hexagon      buildonly-randconfig-r006-20230404   clang
hexagon              randconfig-r041-20230403   clang
hexagon              randconfig-r041-20230406   clang
hexagon              randconfig-r045-20230403   clang
hexagon              randconfig-r045-20230406   clang
i386                             allyesconfig   gcc  
i386                         debian-10.3-func   gcc  
i386                   debian-10.3-kselftests   gcc  
i386                        debian-10.3-kunit   gcc  
i386                          debian-10.3-kvm   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230403   clang
i386                 randconfig-a002-20230403   clang
i386                 randconfig-a003-20230403   clang
i386                 randconfig-a004-20230403   clang
i386                 randconfig-a005-20230403   clang
i386                 randconfig-a006-20230403   clang
i386                 randconfig-a011-20230403   gcc  
i386                 randconfig-a012-20230403   gcc  
i386                 randconfig-a013-20230403   gcc  
i386                 randconfig-a014-20230403   gcc  
i386                 randconfig-a015-20230403   gcc  
i386                 randconfig-a016-20230403   gcc  
i386                 randconfig-r015-20230403   gcc  
i386                 randconfig-r016-20230403   gcc  
i386                 randconfig-r022-20230403   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r002-20230403   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r006-20230406   gcc  
ia64                 randconfig-r022-20230405   gcc  
ia64                 randconfig-r023-20230403   gcc  
ia64                 randconfig-r024-20230403   gcc  
ia64                 randconfig-r026-20230405   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230405   gcc  
loongarch            randconfig-r013-20230403   gcc  
loongarch            randconfig-r023-20230405   gcc  
loongarch            randconfig-r026-20230403   gcc  
loongarch            randconfig-r031-20230403   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r005-20230403   gcc  
m68k         buildonly-randconfig-r006-20230403   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r003-20230406   gcc  
m68k                 randconfig-r012-20230403   gcc  
m68k                 randconfig-r021-20230405   gcc  
m68k                 randconfig-r024-20230403   gcc  
microblaze   buildonly-randconfig-r005-20230403   gcc  
microblaze           randconfig-r005-20230403   gcc  
microblaze           randconfig-r024-20230403   gcc  
microblaze           randconfig-r031-20230403   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                            ar7_defconfig   gcc  
mips         buildonly-randconfig-r001-20230403   gcc  
mips                 randconfig-r024-20230403   clang
mips                 randconfig-r026-20230403   clang
nios2        buildonly-randconfig-r003-20230403   gcc  
nios2        buildonly-randconfig-r004-20230403   gcc  
nios2        buildonly-randconfig-r006-20230403   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230406   gcc  
nios2                randconfig-r002-20230403   gcc  
openrisc     buildonly-randconfig-r006-20230403   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc             randconfig-r006-20230405   gcc  
openrisc             randconfig-r011-20230403   gcc  
openrisc             randconfig-r022-20230403   gcc  
openrisc             randconfig-r026-20230403   gcc  
openrisc             randconfig-r034-20230403   gcc  
openrisc                 simple_smp_defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc       buildonly-randconfig-r003-20230403   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230403   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r003-20230404   clang
powerpc      buildonly-randconfig-r004-20230403   gcc  
powerpc                      chrp32_defconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                      pasemi_defconfig   gcc  
powerpc              randconfig-r014-20230403   gcc  
powerpc              randconfig-r015-20230403   gcc  
powerpc              randconfig-r025-20230403   gcc  
powerpc              randconfig-r033-20230403   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230403   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r006-20230403   clang
riscv                randconfig-r012-20230403   gcc  
riscv                randconfig-r013-20230403   gcc  
riscv                randconfig-r014-20230403   gcc  
riscv                randconfig-r032-20230403   clang
riscv                randconfig-r042-20230403   gcc  
riscv                randconfig-r042-20230406   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r005-20230406   gcc  
s390                 randconfig-r044-20230403   gcc  
s390                 randconfig-r044-20230406   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r001-20230403   gcc  
sh           buildonly-randconfig-r005-20230403   gcc  
sh                            migor_defconfig   gcc  
sh                   randconfig-r001-20230403   gcc  
sh                   randconfig-r002-20230406   gcc  
sh                   randconfig-r003-20230403   gcc  
sh                   randconfig-r005-20230405   gcc  
sh                   randconfig-r025-20230405   gcc  
sh                   randconfig-r026-20230403   gcc  
sh                   randconfig-r036-20230403   gcc  
sh                          rsk7264_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230403   gcc  
sparc                randconfig-r004-20230403   gcc  
sparc                randconfig-r016-20230403   gcc  
sparc                randconfig-r021-20230403   gcc  
sparc                randconfig-r024-20230403   gcc  
sparc                randconfig-r025-20230403   gcc  
sparc                randconfig-r032-20230403   gcc  
sparc64      buildonly-randconfig-r002-20230403   gcc  
sparc64      buildonly-randconfig-r006-20230403   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r001-20230403   gcc  
sparc64              randconfig-r004-20230405   gcc  
sparc64              randconfig-r004-20230406   gcc  
sparc64              randconfig-r014-20230403   gcc  
sparc64              randconfig-r022-20230403   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230403   clang
x86_64               randconfig-a002-20230403   clang
x86_64               randconfig-a003-20230403   clang
x86_64               randconfig-a004-20230403   clang
x86_64               randconfig-a005-20230403   clang
x86_64               randconfig-a006-20230403   clang
x86_64               randconfig-a011-20230403   gcc  
x86_64                        randconfig-a011   gcc  
x86_64               randconfig-a012-20230403   gcc  
x86_64                        randconfig-a012   clang
x86_64               randconfig-a013-20230403   gcc  
x86_64                        randconfig-a013   gcc  
x86_64               randconfig-a014-20230403   gcc  
x86_64                        randconfig-a014   clang
x86_64               randconfig-a015-20230403   gcc  
x86_64                        randconfig-a015   gcc  
x86_64               randconfig-a016-20230403   gcc  
x86_64                        randconfig-a016   clang
x86_64               randconfig-k001-20230403   gcc  
x86_64               randconfig-r001-20230403   clang
x86_64               randconfig-r005-20230403   clang
x86_64               randconfig-r012-20230403   gcc  
x86_64               randconfig-r022-20230403   gcc  
x86_64               randconfig-r025-20230403   gcc  
x86_64               randconfig-r031-20230403   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r004-20230403   gcc  
xtensa               randconfig-r001-20230403   gcc  
xtensa               randconfig-r033-20230403   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
