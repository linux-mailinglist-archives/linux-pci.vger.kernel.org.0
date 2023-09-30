Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6077B44B7
	for <lists+linux-pci@lfdr.de>; Sun,  1 Oct 2023 01:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjI3XwI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 30 Sep 2023 19:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbjI3XwI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 Sep 2023 19:52:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2221AC
        for <linux-pci@vger.kernel.org>; Sat, 30 Sep 2023 16:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696117926; x=1727653926;
  h=date:from:to:cc:subject:message-id;
  bh=lgcnJhNDme4GNvPXX9AUvZLkbMLv+ULa2UTxExx9aAs=;
  b=GYRv3RHmZEad/VVsXOHHwltA1wsrAAiPTXneuleDYOVyxv2/o1OIRql8
   2q+aLNHvH8aPmbI8ontCWHE+hu5S7BmTZRyMS25r1fY51/8L1QAw//VcF
   kTQc4B67o/9EdUlbHJUIbyxndVJ8vDdxDFGUXqN05xUis7OLgC6v6yAou
   vxDFEIIu5Korug84kzQyZOtvM6qJA1GyKqGfmkiCtV0f7OVc04uVOxbze
   Ayx5OhhwJeEgUmubgglhg91PeOpdR+ND2K7USwRc5UjTCJbO5rXYXOzm8
   YFB9yNxQxEUdgHQor3ngpb+kaRJ+C3+DIOP5091K64LBdqWLx4jPJErUL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="1070651"
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="1070651"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2023 16:52:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="750243135"
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="750243135"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 30 Sep 2023 16:52:01 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qmjkd-0004Zz-0i;
        Sat, 30 Sep 2023 23:51:59 +0000
Date:   Sun, 01 Oct 2023 07:51:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pm] BUILD SUCCESS
 70b70a4307cccebe91388337b1c85735ce4de6ff
Message-ID: <202310010741.TbN8Epix-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pm
branch HEAD: 70b70a4307cccebe91388337b1c85735ce4de6ff  PCI/sysfs: Protect driver's D3cold preference from user space

elapsed time: 1451m

configs tested: 165
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230930   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                                 defconfig   gcc  
arm                   milbeaut_m10v_defconfig   clang
arm                          moxart_defconfig   clang
arm                        neponset_defconfig   clang
arm                             pxa_defconfig   gcc  
arm                   randconfig-001-20230930   gcc  
arm                   randconfig-001-20231001   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230930   gcc  
i386         buildonly-randconfig-001-20231001   gcc  
i386         buildonly-randconfig-002-20230930   gcc  
i386         buildonly-randconfig-002-20231001   gcc  
i386         buildonly-randconfig-003-20230930   gcc  
i386         buildonly-randconfig-003-20231001   gcc  
i386         buildonly-randconfig-004-20230930   gcc  
i386         buildonly-randconfig-004-20231001   gcc  
i386         buildonly-randconfig-005-20230930   gcc  
i386         buildonly-randconfig-005-20231001   gcc  
i386         buildonly-randconfig-006-20230930   gcc  
i386         buildonly-randconfig-006-20231001   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230930   gcc  
i386                  randconfig-001-20231001   gcc  
i386                  randconfig-002-20230930   gcc  
i386                  randconfig-002-20231001   gcc  
i386                  randconfig-003-20230930   gcc  
i386                  randconfig-003-20231001   gcc  
i386                  randconfig-004-20230930   gcc  
i386                  randconfig-004-20231001   gcc  
i386                  randconfig-005-20230930   gcc  
i386                  randconfig-005-20231001   gcc  
i386                  randconfig-006-20230930   gcc  
i386                  randconfig-006-20231001   gcc  
i386                  randconfig-011-20230930   gcc  
i386                  randconfig-012-20230930   gcc  
i386                  randconfig-013-20230930   gcc  
i386                  randconfig-014-20230930   gcc  
i386                  randconfig-015-20230930   gcc  
i386                  randconfig-016-20230930   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230930   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                           ip22_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                 mpc8315_rdb_defconfig   clang
powerpc                  storcenter_defconfig   gcc  
powerpc                     tqm8560_defconfig   clang
powerpc                 xes_mpc85xx_defconfig   clang
powerpc64                           defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230930   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230930   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          rsk7269_defconfig   gcc  
sh                           se7343_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230930   gcc  
x86_64       buildonly-randconfig-002-20230930   gcc  
x86_64       buildonly-randconfig-003-20230930   gcc  
x86_64       buildonly-randconfig-004-20230930   gcc  
x86_64       buildonly-randconfig-005-20230930   gcc  
x86_64       buildonly-randconfig-006-20230930   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230930   gcc  
x86_64                randconfig-001-20231001   gcc  
x86_64                randconfig-002-20230930   gcc  
x86_64                randconfig-002-20231001   gcc  
x86_64                randconfig-003-20230930   gcc  
x86_64                randconfig-003-20231001   gcc  
x86_64                randconfig-004-20230930   gcc  
x86_64                randconfig-004-20231001   gcc  
x86_64                randconfig-005-20231001   gcc  
x86_64                randconfig-006-20230930   gcc  
x86_64                randconfig-006-20231001   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                          iss_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
