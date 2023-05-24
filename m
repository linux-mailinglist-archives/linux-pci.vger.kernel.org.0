Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C165D70F68B
	for <lists+linux-pci@lfdr.de>; Wed, 24 May 2023 14:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjEXMeq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 May 2023 08:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjEXMep (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 May 2023 08:34:45 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33DBE55
        for <linux-pci@vger.kernel.org>; Wed, 24 May 2023 05:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684931670; x=1716467670;
  h=date:from:to:cc:subject:message-id;
  bh=8m2SF7cnFI34djpnbZrNLl+bb4TZey/OtpsaLsfKjGM=;
  b=hjZWn2JgW1drQDET/gj1gFY2Vm8ojB4b0m7W3JyX0eY3GPQKu+cPG3GH
   JbYgbdZCR3ORpXKgZ0PHPswG/O1qf82D2Aen4qilu0SqXmrKC86W/u2hs
   /PIoz6g7kCWZhXx1wXfhxVQOugbSLeZoRNxkw4W9ktyQTiKyOQvxU1Rcv
   jjta8dmPSGxOOsQ0V/pr8nWMFgtcTTTBetvt+YZidq3hDcqDJKR+MU1di
   KSNSpPaHMl1nTuGGI0cY5Dlo6dV2dDl8oerNFYqVgVMP0coNWyIqY7nMu
   lxOKxJ5c8k4HWehaXrsJErBDIVN9+sZxdPDedXZg04VDhgFlYefR+RCIP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="353571281"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="353571281"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 05:31:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="654781166"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="654781166"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 May 2023 05:31:05 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q1ndw-000Enj-0u;
        Wed, 24 May 2023 12:31:04 +0000
Date:   Wed, 24 May 2023 20:30:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 a40140c9f009c5f9ebe48082d6a6cdc09de97ee1
Message-ID: <20230524123033.PFLDp%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: INFO setup_repo_specs: /db/releases/20230524154417/lkp-src/repo/*/pci
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: a40140c9f009c5f9ebe48082d6a6cdc09de97ee1  Merge branch 'pci/controller/vmd'

elapsed time: 911m

configs tested: 195
configs skipped: 15

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230523   gcc  
alpha        buildonly-randconfig-r002-20230522   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r013-20230521   gcc  
alpha                randconfig-r013-20230523   gcc  
alpha                randconfig-r014-20230523   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc          buildonly-randconfig-r002-20230521   gcc  
arc          buildonly-randconfig-r004-20230521   gcc  
arc          buildonly-randconfig-r005-20230521   gcc  
arc                                 defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                  randconfig-r011-20230522   gcc  
arc                  randconfig-r015-20230521   gcc  
arc                  randconfig-r033-20230522   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r001-20230521   clang
arm                                 defconfig   gcc  
arm                       imx_v6_v7_defconfig   gcc  
arm                  randconfig-r015-20230521   clang
arm                  randconfig-r016-20230522   gcc  
arm                  randconfig-r034-20230522   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r002-20230522   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r011-20230523   gcc  
arm64                randconfig-r031-20230521   clang
arm64                randconfig-r035-20230521   clang
csky                                defconfig   gcc  
csky                 randconfig-r012-20230521   gcc  
csky                 randconfig-r022-20230522   gcc  
csky                 randconfig-r026-20230521   gcc  
hexagon              randconfig-r021-20230522   clang
hexagon              randconfig-r026-20230522   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230522   gcc  
i386                 randconfig-a002-20230522   gcc  
i386                 randconfig-a003-20230522   gcc  
i386                 randconfig-a004-20230522   gcc  
i386                 randconfig-a005-20230522   gcc  
i386                 randconfig-a006-20230522   gcc  
i386                 randconfig-a011-20230522   clang
i386                 randconfig-a012-20230522   clang
i386                 randconfig-a013-20230522   clang
i386                 randconfig-a014-20230522   clang
i386                 randconfig-a015-20230522   clang
i386                 randconfig-a016-20230522   clang
i386                 randconfig-i051-20230524   gcc  
i386                 randconfig-i052-20230524   gcc  
i386                 randconfig-i053-20230524   gcc  
i386                 randconfig-i054-20230524   gcc  
i386                 randconfig-i055-20230524   gcc  
i386                 randconfig-i056-20230524   gcc  
i386                 randconfig-i061-20230523   clang
i386                 randconfig-i062-20230523   clang
i386                 randconfig-i063-20230523   clang
i386                 randconfig-i064-20230523   clang
i386                 randconfig-i065-20230523   clang
i386                 randconfig-i066-20230523   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r015-20230523   gcc  
ia64                 randconfig-r016-20230521   gcc  
ia64                 randconfig-r023-20230521   gcc  
ia64                 randconfig-r032-20230521   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r003-20230521   gcc  
loongarch    buildonly-randconfig-r004-20230521   gcc  
loongarch    buildonly-randconfig-r006-20230523   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r012-20230522   gcc  
loongarch            randconfig-r012-20230523   gcc  
loongarch            randconfig-r022-20230521   gcc  
loongarch            randconfig-r024-20230522   gcc  
loongarch            randconfig-r032-20230522   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r003-20230522   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r024-20230522   gcc  
microblaze   buildonly-randconfig-r003-20230522   gcc  
microblaze           randconfig-r011-20230521   gcc  
microblaze           randconfig-r015-20230522   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r004-20230523   gcc  
mips         buildonly-randconfig-r006-20230521   gcc  
mips                malta_qemu_32r6_defconfig   clang
mips                 randconfig-r016-20230521   clang
mips                 randconfig-r022-20230522   gcc  
nios2        buildonly-randconfig-r006-20230522   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r025-20230521   gcc  
nios2                randconfig-r035-20230522   gcc  
openrisc     buildonly-randconfig-r001-20230522   gcc  
openrisc             randconfig-r012-20230521   gcc  
openrisc             randconfig-r015-20230522   gcc  
openrisc             randconfig-r033-20230521   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r022-20230521   gcc  
parisc               randconfig-r023-20230521   gcc  
parisc               randconfig-r023-20230522   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r004-20230522   clang
powerpc      buildonly-randconfig-r005-20230523   gcc  
powerpc                      chrp32_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r013-20230522   clang
riscv                randconfig-r024-20230521   gcc  
riscv                randconfig-r034-20230521   clang
riscv                randconfig-r035-20230521   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r003-20230521   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r014-20230521   gcc  
s390                 randconfig-r025-20230521   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r002-20230523   gcc  
sh                           se7705_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sparc        buildonly-randconfig-r005-20230522   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r012-20230522   gcc  
sparc                randconfig-r023-20230522   gcc  
sparc                randconfig-r025-20230522   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230522   gcc  
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
x86_64               randconfig-k001-20230524   clang
x86_64               randconfig-x051-20230522   clang
x86_64               randconfig-x052-20230522   clang
x86_64                        randconfig-x052   clang
x86_64               randconfig-x053-20230522   clang
x86_64               randconfig-x054-20230522   clang
x86_64                        randconfig-x054   clang
x86_64               randconfig-x055-20230522   clang
x86_64               randconfig-x056-20230522   clang
x86_64                        randconfig-x056   clang
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
x86_64               randconfig-x091-20230524   clang
x86_64               randconfig-x092-20230524   clang
x86_64               randconfig-x093-20230524   clang
x86_64               randconfig-x094-20230524   clang
x86_64               randconfig-x095-20230524   clang
x86_64               randconfig-x096-20230524   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r005-20230522   gcc  
xtensa               randconfig-r021-20230521   gcc  
xtensa               randconfig-r026-20230521   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
