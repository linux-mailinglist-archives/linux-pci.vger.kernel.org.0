Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A877BB60F
	for <lists+linux-pci@lfdr.de>; Fri,  6 Oct 2023 13:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjJFLMj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Oct 2023 07:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjJFLMg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Oct 2023 07:12:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86DDEB
        for <linux-pci@vger.kernel.org>; Fri,  6 Oct 2023 04:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696590754; x=1728126754;
  h=date:from:to:cc:subject:message-id;
  bh=AvjWjlFJfCRs7RCnm8xnQP+3nN7OaeIhBfA+QLWx1/Y=;
  b=SPiJDvo3zGmSpRbyeDx7M6gcBc1eby73qLGf8syjvrfUVlterTzGigWf
   u5CplxMBSenUz3cL1eXiwjKja+AqRx7FcS8CXnrzHzT3ZjmcJcSJsSQJv
   NHTRLsc6VvXo4xCGnB8+kUvTThprzBtMAAblPzVpCyKD5s+xZ3azi2miU
   xMx4L+rn6h82EXie3KtnZjP+Sfb8vn7WjvXHiL8Je5ytidCe5MMnxvqsH
   JvR1o2xLYq7qmN1tJgl+s46sc6OYrimbghdHY4hvU2j/yuhZ8QJtiGC4G
   z4Wg3aDpcE1v0MrMrD+V0Cj98xCSKbZ0NzNwwh0HQtaxWIhmJzd/qt+sV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="383620200"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="383620200"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 04:12:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="781625082"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="781625082"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 06 Oct 2023 04:12:23 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qoikn-000MXK-0g;
        Fri, 06 Oct 2023 11:12:21 +0000
Date:   Fri, 06 Oct 2023 19:11:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pm] BUILD REGRESSION
 624306d2c241c274e498619cabc2ae1dc7112ad1
Message-ID: <202310061917.KevbIwy3-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pm
branch HEAD: 624306d2c241c274e498619cabc2ae1dc7112ad1  x86/PCI: Avoid PME from D3hot/D3cold for AMD Rembrandt and Phoenix USB4

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202310060800.WKT8C7A4-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202310061830.A7jaXxeG-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/x86/pci/fixup.c:929:13: error: 'pm_suspend_target_state' undeclared (first use in this function)
arch/x86/pci/fixup.c:929:33: error: 'PM_SUSPEND_ON' undeclared (first use in this function); did you mean 'RPM_SUSPENDING'?
arch/x86/pci/fixup.c:929:33: error: use of undeclared identifier 'PM_SUSPEND_ON'
arch/x86/pci/fixup.c:929:40: error: 'PM_SUSPEND_ON' undeclared (first use in this function); did you mean 'RPM_SUSPENDING'?
arch/x86/pci/fixup.c:929:6: error: 'pm_suspend_target_state' undeclared (first use in this function); did you mean 'dpm_suspend_late'?
arch/x86/pci/fixup.c:929:6: error: use of undeclared identifier 'pm_suspend_target_state'
arch/x86/pci/fixup.c:951:20: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
arch/x86/pci/fixup.c:951:20: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
arch/x86/pci/fixup.c:951:27: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-allmodconfig
|   |-- arch-x86-pci-fixup.c:error:PM_SUSPEND_ON-undeclared-(first-use-in-this-function)
|   |-- arch-x86-pci-fixup.c:error:implicit-declaration-of-function-FIELD_GET
|   `-- arch-x86-pci-fixup.c:error:pm_suspend_target_state-undeclared-(first-use-in-this-function)
|-- i386-allyesconfig
|   |-- arch-x86-pci-fixup.c:error:PM_SUSPEND_ON-undeclared-(first-use-in-this-function)
|   |-- arch-x86-pci-fixup.c:error:implicit-declaration-of-function-FIELD_GET
|   `-- arch-x86-pci-fixup.c:error:pm_suspend_target_state-undeclared-(first-use-in-this-function)
|-- i386-buildonly-randconfig-004-20231006
|   |-- arch-x86-pci-fixup.c:error:PM_SUSPEND_ON-undeclared-(first-use-in-this-function)
|   |-- arch-x86-pci-fixup.c:error:implicit-declaration-of-function-FIELD_GET
|   `-- arch-x86-pci-fixup.c:error:pm_suspend_target_state-undeclared-(first-use-in-this-function)
|-- i386-debian-10.3
|   |-- arch-x86-pci-fixup.c:error:PM_SUSPEND_ON-undeclared-(first-use-in-this-function)
|   |-- arch-x86-pci-fixup.c:error:implicit-declaration-of-function-FIELD_GET
|   `-- arch-x86-pci-fixup.c:error:pm_suspend_target_state-undeclared-(first-use-in-this-function)
|-- i386-defconfig
|   |-- arch-x86-pci-fixup.c:error:PM_SUSPEND_ON-undeclared-(first-use-in-this-function)
|   |-- arch-x86-pci-fixup.c:error:implicit-declaration-of-function-FIELD_GET
|   `-- arch-x86-pci-fixup.c:error:pm_suspend_target_state-undeclared-(first-use-in-this-function)
|-- x86_64-allyesconfig
|   |-- arch-x86-pci-fixup.c:error:PM_SUSPEND_ON-undeclared-(first-use-in-this-function)
|   |-- arch-x86-pci-fixup.c:error:implicit-declaration-of-function-FIELD_GET
|   `-- arch-x86-pci-fixup.c:error:pm_suspend_target_state-undeclared-(first-use-in-this-function)
|-- x86_64-defconfig
|   |-- arch-x86-pci-fixup.c:error:PM_SUSPEND_ON-undeclared-(first-use-in-this-function)
|   |-- arch-x86-pci-fixup.c:error:implicit-declaration-of-function-FIELD_GET
|   `-- arch-x86-pci-fixup.c:error:pm_suspend_target_state-undeclared-(first-use-in-this-function)
`-- x86_64-rhel-8.3
    |-- arch-x86-pci-fixup.c:error:PM_SUSPEND_ON-undeclared-(first-use-in-this-function)
    |-- arch-x86-pci-fixup.c:error:implicit-declaration-of-function-FIELD_GET
    `-- arch-x86-pci-fixup.c:error:pm_suspend_target_state-undeclared-(first-use-in-this-function)
clang_recent_errors
`-- x86_64-rhel-8.3-rust
    |-- arch-x86-pci-fixup.c:error:call-to-undeclared-function-FIELD_GET-ISO-C99-and-later-do-not-support-implicit-function-declarations
    |-- arch-x86-pci-fixup.c:error:use-of-undeclared-identifier-PM_SUSPEND_ON
    `-- arch-x86-pci-fixup.c:error:use-of-undeclared-identifier-pm_suspend_target_state

elapsed time: 924m

configs tested: 107
configs skipped: 2

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231006   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231006   gcc  
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
i386         buildonly-randconfig-001-20231006   gcc  
i386         buildonly-randconfig-002-20231006   gcc  
i386         buildonly-randconfig-003-20231006   gcc  
i386         buildonly-randconfig-004-20231006   gcc  
i386         buildonly-randconfig-005-20231006   gcc  
i386         buildonly-randconfig-006-20231006   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231006   gcc  
i386                  randconfig-002-20231006   gcc  
i386                  randconfig-003-20231006   gcc  
i386                  randconfig-004-20231006   gcc  
i386                  randconfig-005-20231006   gcc  
i386                  randconfig-006-20231006   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231006   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
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
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
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
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231006   gcc  
x86_64                randconfig-002-20231006   gcc  
x86_64                randconfig-003-20231006   gcc  
x86_64                randconfig-004-20231006   gcc  
x86_64                randconfig-005-20231006   gcc  
x86_64                randconfig-006-20231006   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
