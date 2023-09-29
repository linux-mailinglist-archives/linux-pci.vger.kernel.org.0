Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9AA7B3B4A
	for <lists+linux-pci@lfdr.de>; Fri, 29 Sep 2023 22:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjI2Ujr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Sep 2023 16:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2Ujq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Sep 2023 16:39:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20601A7
        for <linux-pci@vger.kernel.org>; Fri, 29 Sep 2023 13:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696019984; x=1727555984;
  h=date:from:to:cc:subject:message-id;
  bh=kUiFPW96IURunPf0xAVUmeysDoMIqOdi5h2EkrFoRE0=;
  b=QEb4cwLQXkChdaBvHQEn6cXgZVGNLg9y5+U7dOTSYXlLnmVemPW7UcLZ
   jOqeA8+mayWu+JQnuZPk1u3RdH8dTFS2MrPxjQrUazRTWsdRq8CKetSRK
   /L1+CTAI+SSzwP1Bq26JLEKhLFJwaEiHGmrsjO0rZJrW6pwLkt98le9Ii
   oEmfHdM3BByDKm1lXxjG1wF/e2cfJSJ62GztX001sR34JFTgX6wr+C7RA
   PCpAMCES4OyU3eHeQKLr+KaUkR8VUijJMi8J4Jph8y0MvwQZ3uCiSe8KP
   8wqb2YJUUh5LuhKdkpfJW4kRHD6McXSy9mxkf2CZX2I1tIkyqtvrUTm1c
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="448862585"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="448862585"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 13:13:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="743523953"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="743523953"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 29 Sep 2023 13:13:31 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qmJrc-0003DS-39;
        Fri, 29 Sep 2023 20:13:28 +0000
Date:   Sat, 30 Sep 2023 04:13:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:reset] BUILD SUCCESS
 c9260693aa0c1e029ed23693cfd4d7814eee6624
Message-ID: <202309300425.c8x6e6da-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git reset
branch HEAD: c9260693aa0c1e029ed23693cfd4d7814eee6624  PCI: Lengthen reset delay for VideoPropulsion Torrent QN16e card

elapsed time: 1443m

configs tested: 159
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
arc                   randconfig-001-20230929   gcc  
arc                   randconfig-001-20230930   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230929   gcc  
arm                   randconfig-001-20230930   gcc  
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
i386         buildonly-randconfig-001-20230929   gcc  
i386         buildonly-randconfig-002-20230929   gcc  
i386         buildonly-randconfig-003-20230929   gcc  
i386         buildonly-randconfig-004-20230929   gcc  
i386         buildonly-randconfig-005-20230929   gcc  
i386         buildonly-randconfig-006-20230929   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230929   gcc  
i386                  randconfig-002-20230929   gcc  
i386                  randconfig-003-20230929   gcc  
i386                  randconfig-004-20230929   gcc  
i386                  randconfig-005-20230929   gcc  
i386                  randconfig-006-20230929   gcc  
i386                  randconfig-011-20230929   gcc  
i386                  randconfig-012-20230929   gcc  
i386                  randconfig-013-20230929   gcc  
i386                  randconfig-014-20230929   gcc  
i386                  randconfig-015-20230929   gcc  
i386                  randconfig-016-20230929   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230929   gcc  
loongarch             randconfig-001-20230930   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   clang
mips                        qi_lb60_defconfig   clang
mips                          rb532_defconfig   gcc  
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
powerpc                   currituck_defconfig   gcc  
powerpc                   microwatt_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230929   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230929   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20230929   gcc  
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
x86_64       buildonly-randconfig-001-20230929   gcc  
x86_64       buildonly-randconfig-002-20230929   gcc  
x86_64       buildonly-randconfig-003-20230929   gcc  
x86_64       buildonly-randconfig-004-20230929   gcc  
x86_64       buildonly-randconfig-005-20230929   gcc  
x86_64       buildonly-randconfig-006-20230929   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20230929   gcc  
x86_64                randconfig-002-20230929   gcc  
x86_64                randconfig-003-20230929   gcc  
x86_64                randconfig-004-20230929   gcc  
x86_64                randconfig-005-20230929   gcc  
x86_64                randconfig-006-20230929   gcc  
x86_64                randconfig-011-20230929   gcc  
x86_64                randconfig-011-20230930   gcc  
x86_64                randconfig-012-20230929   gcc  
x86_64                randconfig-012-20230930   gcc  
x86_64                randconfig-013-20230929   gcc  
x86_64                randconfig-013-20230930   gcc  
x86_64                randconfig-014-20230929   gcc  
x86_64                randconfig-014-20230930   gcc  
x86_64                randconfig-015-20230929   gcc  
x86_64                randconfig-015-20230930   gcc  
x86_64                randconfig-016-20230929   gcc  
x86_64                randconfig-016-20230930   gcc  
x86_64                randconfig-071-20230929   gcc  
x86_64                randconfig-072-20230929   gcc  
x86_64                randconfig-073-20230929   gcc  
x86_64                randconfig-074-20230929   gcc  
x86_64                randconfig-075-20230929   gcc  
x86_64                randconfig-076-20230929   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
