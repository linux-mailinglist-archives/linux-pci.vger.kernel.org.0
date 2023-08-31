Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B1B78E5F0
	for <lists+linux-pci@lfdr.de>; Thu, 31 Aug 2023 07:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240388AbjHaFsK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Aug 2023 01:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjHaFsJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Aug 2023 01:48:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4B4D1
        for <linux-pci@vger.kernel.org>; Wed, 30 Aug 2023 22:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693460886; x=1724996886;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EKVxaWrHr/prKtSrA2sy2LuAz1GjUWFh41MdITrlVx0=;
  b=AcVwtrd8xAjuUceEOiBuUYYhtEjy1YSWFlgS/albR52suffEGfAmyxUh
   1dkxiw18VqFbSZBs3XtjDFSmBd5690NErdcQ5O4illvPrf6RpTErJpLZ/
   cl9xSj/kslcV3nkDKxd37orDL5bOoJhfXbvvS9FBUGR3nk3X6ZdUXI2ud
   H8CdTcoBV9gwiA77EIdBNT/w03kujbh5Ze7qlCgxyQvKsRMpuyZCmdCkE
   sH5HFeHPu9O+bBzCkeOkQIuUaLHGrzmdEdUT7FLtvulLdGftN04rxdk4L
   ZtCnhl1GNwYzOehehde7lOeSOdCefVESp7wO9isonBUZsl87FBnoAKs6J
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="374734407"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="374734407"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 22:48:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="883009891"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 30 Aug 2023 22:48:10 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qbaXE-000AkY-29;
        Thu, 31 Aug 2023 05:48:04 +0000
Date:   Thu, 31 Aug 2023 13:47:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Krzysztof =?utf-8?Q?Wilczy=C5=84ski" ?= <kwilczynski@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 6f6a75878e649a78fb4e19bf49e798a8f6e02f26
Message-ID: <202308311314.vqVu5I0j-lkp@intel.com>
User-Agent: s-nail v14.9.24
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: 6f6a75878e649a78fb4e19bf49e798a8f6e02f26  PCI: endpoint: Use IS_ERR_OR_NULL() helper function

elapsed time: 1422m

configs tested: 161
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r011-20230830   gcc  
alpha                randconfig-r015-20230830   gcc  
alpha                randconfig-r026-20230830   gcc  
alpha                randconfig-r035-20230830   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230830   gcc  
arc                  randconfig-r006-20230830   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230830   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r025-20230830   gcc  
arm64                randconfig-r034-20230830   clang
arm64                randconfig-r036-20230830   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r031-20230830   gcc  
hexagon               randconfig-001-20230830   clang
hexagon               randconfig-002-20230830   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230830   clang
i386         buildonly-randconfig-002-20230830   clang
i386         buildonly-randconfig-003-20230830   clang
i386         buildonly-randconfig-004-20230830   clang
i386         buildonly-randconfig-005-20230830   clang
i386         buildonly-randconfig-006-20230830   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230830   clang
i386                  randconfig-002-20230830   clang
i386                  randconfig-003-20230830   clang
i386                  randconfig-004-20230830   clang
i386                  randconfig-005-20230830   clang
i386                  randconfig-006-20230830   clang
i386                  randconfig-011-20230830   gcc  
i386                  randconfig-012-20230830   gcc  
i386                  randconfig-013-20230830   gcc  
i386                  randconfig-014-20230830   gcc  
i386                  randconfig-015-20230830   gcc  
i386                  randconfig-016-20230830   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230830   gcc  
loongarch            randconfig-r005-20230830   gcc  
loongarch            randconfig-r013-20230830   gcc  
loongarch            randconfig-r014-20230830   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r012-20230830   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r016-20230830   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r033-20230830   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r002-20230830   gcc  
openrisc             randconfig-r022-20230830   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r032-20230830   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc              randconfig-r023-20230830   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230830   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230830   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r004-20230830   gcc  
sparc                randconfig-r024-20230830   gcc  
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
x86_64       buildonly-randconfig-001-20230830   clang
x86_64       buildonly-randconfig-002-20230830   clang
x86_64       buildonly-randconfig-003-20230830   clang
x86_64       buildonly-randconfig-004-20230830   clang
x86_64       buildonly-randconfig-005-20230830   clang
x86_64       buildonly-randconfig-006-20230830   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230830   gcc  
x86_64                randconfig-002-20230830   gcc  
x86_64                randconfig-003-20230830   gcc  
x86_64                randconfig-004-20230830   gcc  
x86_64                randconfig-005-20230830   gcc  
x86_64                randconfig-006-20230830   gcc  
x86_64                randconfig-011-20230830   clang
x86_64                randconfig-012-20230830   clang
x86_64                randconfig-013-20230830   clang
x86_64                randconfig-014-20230830   clang
x86_64                randconfig-015-20230830   clang
x86_64                randconfig-016-20230830   clang
x86_64                randconfig-071-20230830   clang
x86_64                randconfig-072-20230830   clang
x86_64                randconfig-073-20230830   clang
x86_64                randconfig-074-20230830   clang
x86_64                randconfig-075-20230830   clang
x86_64                randconfig-076-20230830   clang
x86_64               randconfig-r003-20230830   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa               randconfig-r001-20230830   gcc  
xtensa               randconfig-r021-20230830   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
