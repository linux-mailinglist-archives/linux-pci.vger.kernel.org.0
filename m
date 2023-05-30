Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81218715D7F
	for <lists+linux-pci@lfdr.de>; Tue, 30 May 2023 13:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjE3LlH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 May 2023 07:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjE3Lkz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 May 2023 07:40:55 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E943115
        for <linux-pci@vger.kernel.org>; Tue, 30 May 2023 04:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685446851; x=1716982851;
  h=date:from:to:cc:subject:message-id;
  bh=HRoBIBsEzRaTZw/eB4zFaSF1daWYamBHk0Bzb8LHrwU=;
  b=GPdl3YwdnhWCM20ZUZRgWSk2k1ruLB+L4EacXvLDxzwGtLAkYdSsZamm
   KPOn8XXYo33kjH2O6t2LXVXUTKfF7QLww5/0y3E9pjeyARaZdD6jH7sl8
   qTDL1EnaclnvWA6zzF+De3OIFVgstCsVrRA8gYPbVR3+ud2dk0uRXRDJH
   vnNk4oM/6ir1xH0m1s5sA/oty1Vv2q3WHwqaRN8QTAHa8l4sEMzce50Qh
   Kmupe4nIOFW2r6a9Qta7ZKI3LOsCl8XFLLqwtozMDHt2qvb3izl7a1JCa
   OO4MC9NMyQFK7WjqVq2I+C6hYN7notRmK2QOwQ6go6C3SVMpJBz3Bx+OT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="420649021"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="420649021"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 04:40:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="776298658"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="776298658"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 30 May 2023 04:40:50 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q3xib-00005l-28;
        Tue, 30 May 2023 11:40:49 +0000
Date:   Tue, 30 May 2023 19:40:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/ftpci100] BUILD SUCCESS
 c60738de85f40b0b9f5cb23c21f9246e5a47908c
Message-ID: <20230530114045.tyslS%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pci/ftpci100
branch HEAD: c60738de85f40b0b9f5cb23c21f9246e5a47908c  PCI: ftpci100: Release the clock resources

elapsed time: 1633m

configs tested: 274
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230529   gcc  
alpha        buildonly-randconfig-r005-20230529   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r026-20230530   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230529   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r003-20230529   gcc  
arc                  randconfig-r004-20230529   gcc  
arc                  randconfig-r005-20230529   gcc  
arc                  randconfig-r006-20230529   gcc  
arc                  randconfig-r024-20230529   gcc  
arc                  randconfig-r026-20230529   gcc  
arc                  randconfig-r031-20230530   gcc  
arc                  randconfig-r043-20230529   gcc  
arc                  randconfig-r043-20230530   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                  randconfig-r023-20230529   clang
arm                  randconfig-r024-20230529   clang
arm                  randconfig-r032-20230529   gcc  
arm                  randconfig-r046-20230529   clang
arm                        spear6xx_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r005-20230529   clang
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r032-20230530   gcc  
hexagon      buildonly-randconfig-r006-20230530   clang
hexagon              randconfig-r041-20230529   clang
hexagon              randconfig-r045-20230529   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230529   clang
i386                 randconfig-i001-20230530   clang
i386                 randconfig-i002-20230529   clang
i386                 randconfig-i002-20230530   clang
i386                 randconfig-i003-20230529   clang
i386                 randconfig-i003-20230530   clang
i386                 randconfig-i004-20230529   clang
i386                 randconfig-i004-20230530   clang
i386                 randconfig-i005-20230529   clang
i386                 randconfig-i005-20230530   clang
i386                 randconfig-i006-20230529   clang
i386                 randconfig-i006-20230530   clang
i386                 randconfig-i011-20230529   gcc  
i386                 randconfig-i011-20230530   gcc  
i386                 randconfig-i012-20230529   gcc  
i386                 randconfig-i012-20230530   gcc  
i386                 randconfig-i013-20230529   gcc  
i386                 randconfig-i013-20230530   gcc  
i386                 randconfig-i014-20230529   gcc  
i386                 randconfig-i014-20230530   gcc  
i386                 randconfig-i015-20230529   gcc  
i386                 randconfig-i016-20230529   gcc  
i386                 randconfig-i051-20230529   clang
i386                 randconfig-i051-20230530   clang
i386                 randconfig-i052-20230529   clang
i386                 randconfig-i052-20230530   clang
i386                 randconfig-i053-20230529   clang
i386                 randconfig-i053-20230530   clang
i386                 randconfig-i054-20230529   clang
i386                 randconfig-i054-20230530   clang
i386                 randconfig-i055-20230529   clang
i386                 randconfig-i055-20230530   clang
i386                 randconfig-i056-20230529   clang
i386                 randconfig-i056-20230530   clang
i386                 randconfig-i061-20230529   clang
i386                 randconfig-i061-20230530   clang
i386                 randconfig-i062-20230529   clang
i386                 randconfig-i062-20230530   clang
i386                 randconfig-i063-20230529   clang
i386                 randconfig-i063-20230530   clang
i386                 randconfig-i064-20230529   clang
i386                 randconfig-i064-20230530   clang
i386                 randconfig-i065-20230529   clang
i386                 randconfig-i065-20230530   clang
i386                 randconfig-i066-20230529   clang
i386                 randconfig-i066-20230530   clang
i386                 randconfig-i071-20230529   gcc  
i386                 randconfig-i072-20230529   gcc  
i386                 randconfig-i072-20230530   gcc  
i386                 randconfig-i073-20230529   gcc  
i386                 randconfig-i074-20230529   gcc  
i386                 randconfig-i074-20230530   gcc  
i386                 randconfig-i075-20230529   gcc  
i386                 randconfig-i075-20230530   gcc  
i386                 randconfig-i076-20230529   gcc  
i386                 randconfig-i076-20230530   gcc  
i386                 randconfig-i081-20230529   gcc  
i386                 randconfig-i082-20230529   gcc  
i386                 randconfig-i082-20230530   gcc  
i386                 randconfig-i083-20230529   gcc  
i386                 randconfig-i083-20230530   gcc  
i386                 randconfig-i084-20230529   gcc  
i386                 randconfig-i084-20230530   gcc  
i386                 randconfig-i085-20230529   gcc  
i386                 randconfig-i085-20230530   gcc  
i386                 randconfig-i086-20230529   gcc  
i386                 randconfig-i091-20230529   clang
i386                 randconfig-i091-20230530   clang
i386                 randconfig-i092-20230529   clang
i386                 randconfig-i092-20230530   clang
i386                 randconfig-i093-20230529   clang
i386                 randconfig-i093-20230530   clang
i386                 randconfig-i094-20230529   clang
i386                 randconfig-i094-20230530   clang
i386                 randconfig-i095-20230529   clang
i386                 randconfig-i095-20230530   clang
i386                 randconfig-i096-20230529   clang
i386                 randconfig-i096-20230530   clang
i386                 randconfig-r024-20230530   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230529   gcc  
m68k                 randconfig-r013-20230529   gcc  
m68k                 randconfig-r022-20230529   gcc  
m68k                 randconfig-r035-20230530   gcc  
microblaze   buildonly-randconfig-r004-20230529   gcc  
microblaze           randconfig-r012-20230530   gcc  
microblaze           randconfig-r023-20230530   gcc  
microblaze           randconfig-r033-20230530   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r001-20230529   gcc  
mips                 randconfig-r031-20230529   gcc  
mips                          rb532_defconfig   gcc  
nios2        buildonly-randconfig-r001-20230529   gcc  
nios2        buildonly-randconfig-r003-20230529   gcc  
nios2        buildonly-randconfig-r004-20230529   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r011-20230530   gcc  
nios2                randconfig-r012-20230529   gcc  
nios2                randconfig-r016-20230529   gcc  
openrisc             randconfig-r021-20230529   gcc  
openrisc             randconfig-r036-20230530   gcc  
parisc       buildonly-randconfig-r002-20230529   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc               randconfig-r002-20230529   gcc  
parisc               randconfig-r004-20230529   gcc  
parisc               randconfig-r015-20230529   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc              randconfig-r001-20230529   clang
powerpc              randconfig-r022-20230529   gcc  
powerpc                  storcenter_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r034-20230529   clang
riscv                randconfig-r035-20230529   clang
riscv                randconfig-r042-20230529   gcc  
riscv                randconfig-r042-20230530   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r013-20230530   gcc  
s390                 randconfig-r014-20230530   gcc  
s390                 randconfig-r023-20230529   gcc  
s390                 randconfig-r033-20230529   clang
s390                 randconfig-r044-20230529   gcc  
s390                 randconfig-r044-20230530   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r003-20230529   gcc  
sh                   randconfig-r022-20230530   gcc  
sh                   randconfig-r035-20230530   gcc  
sh                           se7722_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r016-20230530   gcc  
sparc                randconfig-r025-20230529   gcc  
sparc                randconfig-r026-20230529   gcc  
sparc64              randconfig-r006-20230529   gcc  
sparc64              randconfig-r014-20230529   gcc  
sparc64              randconfig-r032-20230530   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230530   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230529   clang
x86_64               randconfig-a002-20230529   clang
x86_64               randconfig-a003-20230529   clang
x86_64               randconfig-a004-20230529   clang
x86_64               randconfig-a005-20230529   clang
x86_64               randconfig-a006-20230529   clang
x86_64               randconfig-a011-20230529   gcc  
x86_64               randconfig-a011-20230530   gcc  
x86_64               randconfig-a012-20230529   gcc  
x86_64               randconfig-a012-20230530   gcc  
x86_64               randconfig-a013-20230529   gcc  
x86_64               randconfig-a013-20230530   gcc  
x86_64               randconfig-a014-20230529   gcc  
x86_64               randconfig-a014-20230530   gcc  
x86_64               randconfig-a015-20230529   gcc  
x86_64               randconfig-a015-20230530   gcc  
x86_64               randconfig-a016-20230529   gcc  
x86_64               randconfig-a016-20230530   gcc  
x86_64               randconfig-r021-20230529   gcc  
x86_64               randconfig-x051-20230529   gcc  
x86_64               randconfig-x051-20230530   gcc  
x86_64               randconfig-x052-20230529   gcc  
x86_64               randconfig-x052-20230530   gcc  
x86_64               randconfig-x053-20230529   gcc  
x86_64               randconfig-x053-20230530   gcc  
x86_64               randconfig-x054-20230529   gcc  
x86_64               randconfig-x054-20230530   gcc  
x86_64               randconfig-x055-20230529   gcc  
x86_64               randconfig-x055-20230530   gcc  
x86_64               randconfig-x056-20230529   gcc  
x86_64               randconfig-x056-20230530   gcc  
x86_64               randconfig-x061-20230529   gcc  
x86_64               randconfig-x061-20230530   gcc  
x86_64               randconfig-x062-20230529   gcc  
x86_64               randconfig-x062-20230530   gcc  
x86_64               randconfig-x063-20230529   gcc  
x86_64               randconfig-x063-20230530   gcc  
x86_64               randconfig-x064-20230529   gcc  
x86_64               randconfig-x064-20230530   gcc  
x86_64               randconfig-x065-20230529   gcc  
x86_64               randconfig-x065-20230530   gcc  
x86_64               randconfig-x066-20230529   gcc  
x86_64               randconfig-x066-20230530   gcc  
x86_64               randconfig-x071-20230529   clang
x86_64               randconfig-x071-20230530   clang
x86_64               randconfig-x072-20230529   clang
x86_64               randconfig-x072-20230530   clang
x86_64               randconfig-x073-20230529   clang
x86_64               randconfig-x073-20230530   clang
x86_64               randconfig-x074-20230529   clang
x86_64               randconfig-x074-20230530   clang
x86_64               randconfig-x075-20230529   clang
x86_64               randconfig-x075-20230530   clang
x86_64               randconfig-x076-20230529   clang
x86_64               randconfig-x076-20230530   clang
x86_64               randconfig-x081-20230529   clang
x86_64               randconfig-x081-20230530   clang
x86_64               randconfig-x082-20230529   clang
x86_64               randconfig-x082-20230530   clang
x86_64               randconfig-x083-20230529   clang
x86_64               randconfig-x083-20230530   clang
x86_64               randconfig-x084-20230529   clang
x86_64               randconfig-x084-20230530   clang
x86_64               randconfig-x085-20230529   clang
x86_64               randconfig-x085-20230530   clang
x86_64               randconfig-x086-20230529   clang
x86_64               randconfig-x086-20230530   clang
x86_64               randconfig-x091-20230529   gcc  
x86_64               randconfig-x091-20230530   gcc  
x86_64               randconfig-x092-20230529   gcc  
x86_64               randconfig-x092-20230530   gcc  
x86_64               randconfig-x093-20230529   gcc  
x86_64               randconfig-x093-20230530   gcc  
x86_64               randconfig-x094-20230529   gcc  
x86_64               randconfig-x094-20230530   gcc  
x86_64               randconfig-x095-20230529   gcc  
x86_64               randconfig-x095-20230530   gcc  
x86_64               randconfig-x096-20230529   gcc  
x86_64               randconfig-x096-20230530   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r006-20230529   gcc  
xtensa               randconfig-r011-20230529   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
