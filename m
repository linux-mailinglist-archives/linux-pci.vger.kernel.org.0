Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F956EB6EF
	for <lists+linux-pci@lfdr.de>; Sat, 22 Apr 2023 05:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjDVDEi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Apr 2023 23:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVDEg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Apr 2023 23:04:36 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63A51FF7
        for <linux-pci@vger.kernel.org>; Fri, 21 Apr 2023 20:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682132674; x=1713668674;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=IOKfYwFP4GZKAgTO/EUeIVMjN+ydi5IghTMfqqQhlHM=;
  b=gmeTtFrX9ECC7PXK2hlzMnpQIeKh9LrWad7VlEGoooOYPD3E5ck8as2x
   6n74QD6KnLwMzR8sSYIoD2Pq2OTlef2BsLoYadF7SQFK6j8oauxKGjF4f
   aUHghi61IA+WbwZI4J6g1YREIUlpmHPwFkmkZj5OfsHUKq6O9Dr8UxSIc
   /Xj236WNktcPZ+A38QjVTBjFuSburBtiQPSUrIqeGlDZPmRuKi8vtZsFI
   q46w+xBY0Z3c6L1Qq3QZORdMeh672UwW59jKKxwkt3IYbC9SeZdxo0WkY
   foKu0/P6Z5Qt2NPX6trFU+5JJnoJn+UIPNkwZwbmJn5TjtQtTjh82lzK+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="344872096"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="344872096"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 20:04:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="695135139"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="695135139"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 21 Apr 2023 20:04:33 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pq3Y8-000h1e-1Y;
        Sat, 22 Apr 2023 03:04:32 +0000
Date:   Sat, 22 Apr 2023 11:03:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:controller/endpoint] BUILD SUCCESS
 604de32d55a2f12c90c7e66923984c28147bb5d0
Message-ID: <64434e87.bjQaztvM7II9Yal6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/endpoint
branch HEAD: 604de32d55a2f12c90c7e66923984c28147bb5d0  PCI: endpoint: functions/pci-epf-test: Fix dma_chan direction

elapsed time: 728m

configs tested: 221
configs skipped: 20

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230421   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230421   gcc  
arc                  randconfig-r006-20230421   gcc  
arc                  randconfig-r014-20230421   gcc  
arc                  randconfig-r022-20230421   gcc  
arc                  randconfig-r031-20230421   gcc  
arc                  randconfig-r043-20230421   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r001-20230421   gcc  
arm          buildonly-randconfig-r002-20230421   gcc  
arm                                 defconfig   gcc  
arm                      footbridge_defconfig   gcc  
arm                        mvebu_v7_defconfig   gcc  
arm                  randconfig-r005-20230421   clang
arm                  randconfig-r026-20230421   gcc  
arm                  randconfig-r046-20230421   gcc  
arm                        shmobile_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r003-20230421   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r002-20230421   gcc  
arm64                randconfig-r005-20230421   gcc  
arm64                randconfig-r031-20230421   gcc  
arm64                randconfig-r033-20230421   gcc  
csky         buildonly-randconfig-r004-20230421   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r005-20230421   gcc  
csky                 randconfig-r012-20230421   gcc  
csky                 randconfig-r015-20230421   gcc  
csky                 randconfig-r022-20230421   gcc  
csky                 randconfig-r023-20230421   gcc  
csky                 randconfig-r024-20230421   gcc  
csky                 randconfig-r032-20230421   gcc  
csky                 randconfig-r036-20230421   gcc  
hexagon              randconfig-r033-20230421   clang
hexagon              randconfig-r041-20230421   clang
hexagon              randconfig-r045-20230421   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r003-20230421   gcc  
ia64         buildonly-randconfig-r004-20230421   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r005-20230421   gcc  
ia64                 randconfig-r011-20230421   gcc  
ia64                 randconfig-r014-20230421   gcc  
ia64                 randconfig-r023-20230421   gcc  
ia64                 randconfig-r024-20230421   gcc  
ia64                 randconfig-r026-20230421   gcc  
ia64                 randconfig-r034-20230421   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r003-20230421   gcc  
loongarch    buildonly-randconfig-r006-20230421   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230421   gcc  
loongarch            randconfig-r003-20230421   gcc  
loongarch            randconfig-r011-20230421   gcc  
loongarch            randconfig-r015-20230421   gcc  
loongarch            randconfig-r024-20230421   gcc  
loongarch            randconfig-r032-20230421   gcc  
loongarch            randconfig-r035-20230421   gcc  
loongarch            randconfig-r036-20230421   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230421   gcc  
m68k         buildonly-randconfig-r002-20230421   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r001-20230421   gcc  
m68k                 randconfig-r003-20230421   gcc  
m68k                 randconfig-r014-20230421   gcc  
m68k                 randconfig-r016-20230421   gcc  
m68k                 randconfig-r021-20230421   gcc  
m68k                 randconfig-r023-20230421   gcc  
m68k                 randconfig-r024-20230421   gcc  
m68k                 randconfig-r034-20230421   gcc  
m68k                 randconfig-r036-20230421   gcc  
microblaze           randconfig-r006-20230421   gcc  
microblaze           randconfig-r012-20230421   gcc  
microblaze           randconfig-r013-20230421   gcc  
microblaze           randconfig-r021-20230421   gcc  
microblaze           randconfig-r022-20230421   gcc  
microblaze           randconfig-r023-20230421   gcc  
microblaze           randconfig-r024-20230421   gcc  
microblaze           randconfig-r026-20230421   gcc  
microblaze           randconfig-r034-20230421   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1000-neo_defconfig   clang
mips                     loongson1b_defconfig   gcc  
mips                 randconfig-r013-20230421   gcc  
mips                 randconfig-r015-20230421   gcc  
mips                 randconfig-r022-20230421   gcc  
mips                 randconfig-r032-20230421   clang
mips                          rm200_defconfig   clang
nios2        buildonly-randconfig-r004-20230421   gcc  
nios2        buildonly-randconfig-r006-20230421   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r014-20230421   gcc  
nios2                randconfig-r026-20230421   gcc  
nios2                randconfig-r035-20230421   gcc  
openrisc     buildonly-randconfig-r003-20230421   gcc  
openrisc     buildonly-randconfig-r006-20230421   gcc  
openrisc             randconfig-r032-20230421   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc       buildonly-randconfig-r001-20230421   gcc  
parisc       buildonly-randconfig-r002-20230421   gcc  
parisc       buildonly-randconfig-r005-20230421   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230421   gcc  
parisc               randconfig-r011-20230421   gcc  
parisc               randconfig-r014-20230421   gcc  
parisc               randconfig-r016-20230421   gcc  
parisc               randconfig-r031-20230421   gcc  
parisc               randconfig-r036-20230421   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                 mpc832x_rdb_defconfig   clang
powerpc              randconfig-r001-20230421   gcc  
powerpc              randconfig-r006-20230421   gcc  
powerpc              randconfig-r014-20230421   clang
powerpc              randconfig-r023-20230421   clang
powerpc              randconfig-r032-20230421   gcc  
powerpc              randconfig-r033-20230421   gcc  
powerpc              randconfig-r034-20230421   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r004-20230421   gcc  
riscv                randconfig-r005-20230421   gcc  
riscv                randconfig-r006-20230421   gcc  
riscv                randconfig-r025-20230421   clang
riscv                randconfig-r035-20230421   gcc  
riscv                randconfig-r042-20230421   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r001-20230421   clang
s390         buildonly-randconfig-r002-20230421   clang
s390         buildonly-randconfig-r004-20230421   clang
s390         buildonly-randconfig-r005-20230421   clang
s390                                defconfig   gcc  
s390                 randconfig-r004-20230421   gcc  
s390                 randconfig-r005-20230421   gcc  
s390                 randconfig-r006-20230421   gcc  
s390                 randconfig-r011-20230421   clang
s390                 randconfig-r012-20230421   clang
s390                 randconfig-r015-20230421   clang
s390                 randconfig-r016-20230421   clang
s390                 randconfig-r044-20230421   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r005-20230421   gcc  
sh                   randconfig-r003-20230421   gcc  
sh                   randconfig-r011-20230421   gcc  
sh                   randconfig-r016-20230421   gcc  
sh                   randconfig-r032-20230421   gcc  
sh                          sdk7786_defconfig   gcc  
sparc        buildonly-randconfig-r002-20230421   gcc  
sparc        buildonly-randconfig-r005-20230421   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230421   gcc  
sparc                randconfig-r004-20230421   gcc  
sparc                randconfig-r005-20230421   gcc  
sparc                randconfig-r016-20230421   gcc  
sparc                randconfig-r021-20230421   gcc  
sparc                randconfig-r023-20230421   gcc  
sparc                randconfig-r032-20230421   gcc  
sparc64      buildonly-randconfig-r006-20230421   gcc  
sparc64              randconfig-r002-20230421   gcc  
sparc64              randconfig-r004-20230421   gcc  
sparc64              randconfig-r013-20230421   gcc  
sparc64              randconfig-r025-20230421   gcc  
sparc64              randconfig-r031-20230421   gcc  
sparc64              randconfig-r034-20230421   gcc  
sparc64              randconfig-r035-20230421   gcc  
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
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r002-20230421   gcc  
xtensa               randconfig-r001-20230421   gcc  
xtensa               randconfig-r002-20230421   gcc  
xtensa               randconfig-r012-20230421   gcc  
xtensa               randconfig-r021-20230421   gcc  
xtensa               randconfig-r034-20230421   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
