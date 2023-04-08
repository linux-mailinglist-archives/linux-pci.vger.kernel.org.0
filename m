Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7AD6DBA5C
	for <lists+linux-pci@lfdr.de>; Sat,  8 Apr 2023 13:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjDHLNt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 8 Apr 2023 07:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjDHLNs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 8 Apr 2023 07:13:48 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686A96A47
        for <linux-pci@vger.kernel.org>; Sat,  8 Apr 2023 04:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680952427; x=1712488427;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=x9MfywC+JsCmWenZ6Gaou5QSMRu5wJiGO+IAFxyrPXY=;
  b=jCNNogZ1mAxtDrIXr0bGKxoTqO+LyuUBqm86/nOsiJiQ4KnkjNsB7Enm
   0h1vBCP6JwEI1Qwj4DvImlYEM9IV2j5f9SqQD6DNRe04AZoP5RLJrvYQS
   o3j95Lxi3ap66o0MJffapTXKyH3N1wzSabsqAkdwZ//xlkfLHCmcmD1CV
   FgcCoRoIaK4ZKQBbpDCMjoHT02o5V1efJ3C857eLWL+Oxec025SS7LJtC
   AuPeCxpXmAKvIu+dxHu+rbM5yXPOx01OnmOt3VUbnYHRwqIgaeb68FkjV
   /YSBeDzITgDhW9EL/V9fFMvkwjikqtPRp70JqqAviqPYXrF7hSFwrcykK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="340619296"
X-IronPort-AV: E=Sophos;i="5.98,329,1673942400"; 
   d="scan'208";a="340619296"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2023 04:13:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="1017500376"
X-IronPort-AV: E=Sophos;i="5.98,329,1673942400"; 
   d="scan'208";a="1017500376"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 08 Apr 2023 04:13:45 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pl6Vt-000TfD-16;
        Sat, 08 Apr 2023 11:13:45 +0000
Date:   Sat, 08 Apr 2023 19:13:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:aer] BUILD SUCCESS 774820b362b07b903354470f9372d528b327a3e5
Message-ID: <64314c49.2DZKXi4d7MumL1K1%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git aer
branch HEAD: 774820b362b07b903354470f9372d528b327a3e5  PCI/EDR: Add edr_handle_event() comments

elapsed time: 722m

configs tested: 125
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r021-20230406   gcc  
alpha                randconfig-r034-20230407   gcc  
alpha                randconfig-r036-20230403   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r033-20230403   gcc  
arc                  randconfig-r043-20230408   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r006-20230403   gcc  
arm                  randconfig-r011-20230403   clang
arm                  randconfig-r034-20230403   gcc  
arm                  randconfig-r036-20230407   gcc  
arm                  randconfig-r046-20230408   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r003-20230403   clang
arm64                               defconfig   gcc  
arm64                randconfig-r024-20230403   gcc  
csky         buildonly-randconfig-r002-20230403   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r004-20230403   gcc  
csky                 randconfig-r015-20230403   gcc  
csky                 randconfig-r031-20230403   gcc  
hexagon      buildonly-randconfig-r004-20230403   clang
hexagon              randconfig-r005-20230403   clang
hexagon              randconfig-r016-20230403   clang
hexagon              randconfig-r022-20230407   clang
hexagon              randconfig-r035-20230407   clang
hexagon              randconfig-r041-20230408   clang
hexagon              randconfig-r045-20230408   clang
i386                             allyesconfig   gcc  
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
i386                 randconfig-r026-20230403   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r006-20230403   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r002-20230403   gcc  
ia64                 randconfig-r014-20230403   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230403   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r005-20230403   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r024-20230406   gcc  
m68k                 randconfig-r032-20230403   gcc  
m68k                 randconfig-r032-20230407   gcc  
microblaze           randconfig-r023-20230406   gcc  
microblaze           randconfig-r026-20230406   gcc  
microblaze           randconfig-r026-20230407   gcc  
microblaze           randconfig-r031-20230403   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r013-20230403   clang
mips                 randconfig-r023-20230407   clang
mips                 randconfig-r034-20230403   gcc  
mips                 randconfig-r035-20230403   gcc  
mips                 randconfig-r036-20230403   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r021-20230407   gcc  
nios2                randconfig-r033-20230403   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r022-20230406   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r025-20230406   clang
powerpc              randconfig-r031-20230407   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r025-20230407   gcc  
riscv                randconfig-r042-20230408   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r004-20230403   clang
s390                 randconfig-r044-20230408   clang
sh                               allmodconfig   gcc  
sparc        buildonly-randconfig-r001-20230403   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r025-20230403   gcc  
sparc                randconfig-r032-20230403   gcc  
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
x86_64               randconfig-a012-20230403   gcc  
x86_64               randconfig-a013-20230403   gcc  
x86_64               randconfig-a014-20230403   gcc  
x86_64               randconfig-a015-20230403   gcc  
x86_64               randconfig-a016-20230403   gcc  
x86_64               randconfig-k001-20230403   gcc  
x86_64               randconfig-r023-20230403   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r021-20230403   gcc  
xtensa               randconfig-r022-20230403   gcc  
xtensa               randconfig-r024-20230407   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
