Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741A7789FE0
	for <lists+linux-pci@lfdr.de>; Sun, 27 Aug 2023 17:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjH0PNO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Aug 2023 11:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjH0PMl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Aug 2023 11:12:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47865C1
        for <linux-pci@vger.kernel.org>; Sun, 27 Aug 2023 08:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693149159; x=1724685159;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=byxoAyJF1NftFI021lv+G7LrCQ8DXLqzS7nqqRwpkWQ=;
  b=SquJuhpCw2k1xcWgxCMEa3aTvpPcSvJ4nTB4oHjPy0EBXFMCX5/nM2sZ
   IuomLgaQcQxDhG6JqXDyE3I1hf6E3SCfYdMzdwyjQN7aYwruxYwtTsmzH
   sT8wSxG/1uyAaora9BJdYRUVj7quQ6Vx/D0NM4MzstzRsFOIvbVR/fFRa
   JKU//G/ti8hTnQdLyNilhs6qRO/Anr5TtCvY8gAUxyYNlPWPWweDCcR/u
   P0D5/erWqJkR9oyCYSOQfrhD3BQ4CSpQmeEvT1IaA/aZUByQPxFfr77eg
   UtBjrRp6vIOOhklLurQ8ifGf77AOqOO1i4QvhCK5mO4FgFS000h9y+rZY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="365155018"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="365155018"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 08:12:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="984622553"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="984622553"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 27 Aug 2023 08:12:37 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qaHRM-0005uv-0c;
        Sun, 27 Aug 2023 15:12:36 +0000
Date:   Sun, 27 Aug 2023 23:11:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Krzysztof =?utf-8?Q?Wilczy=C5=84ski" ?= <kwilczynski@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:controller/qcom] BUILD SUCCESS
 d60379d65d2b908818d99541753d74f99645da51
Message-ID: <202308272346.XIopFB40-lkp@intel.com>
User-Agent: s-nail v14.9.24
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/qcom
branch HEAD: d60379d65d2b908818d99541753d74f99645da51  PCI: qcom: Add support for sa8775p SoC

elapsed time: 2629m

configs tested: 145
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r016-20230826   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230826   gcc  
arc                  randconfig-r006-20230826   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230826   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230826   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r002-20230826   gcc  
csky                 randconfig-r032-20230826   gcc  
hexagon               randconfig-001-20230826   clang
hexagon               randconfig-002-20230826   clang
i386         buildonly-randconfig-001-20230826   gcc  
i386         buildonly-randconfig-002-20230826   gcc  
i386         buildonly-randconfig-003-20230826   gcc  
i386         buildonly-randconfig-004-20230826   gcc  
i386         buildonly-randconfig-005-20230826   gcc  
i386         buildonly-randconfig-006-20230826   gcc  
i386                                defconfig   gcc  
i386                  randconfig-011-20230826   clang
i386                  randconfig-012-20230826   clang
i386                  randconfig-013-20230826   clang
i386                  randconfig-014-20230826   clang
i386                  randconfig-015-20230826   clang
i386                  randconfig-016-20230826   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230826   gcc  
loongarch            randconfig-r005-20230826   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r014-20230826   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r034-20230826   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r025-20230826   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r012-20230826   gcc  
openrisc             randconfig-r023-20230826   gcc  
openrisc             randconfig-r031-20230826   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc              randconfig-r011-20230826   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230826   gcc  
riscv                randconfig-r003-20230826   gcc  
riscv                randconfig-r013-20230826   clang
riscv                randconfig-r035-20230826   gcc  
riscv                randconfig-r036-20230826   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230826   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                   randconfig-r021-20230826   gcc  
sh                   randconfig-r026-20230826   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r024-20230826   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r015-20230826   gcc  
um                   randconfig-r033-20230826   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230826   clang
x86_64                randconfig-002-20230826   clang
x86_64                randconfig-003-20230826   clang
x86_64                randconfig-004-20230826   clang
x86_64                randconfig-005-20230826   clang
x86_64                randconfig-006-20230826   clang
x86_64                randconfig-011-20230826   gcc  
x86_64                randconfig-012-20230826   gcc  
x86_64                randconfig-013-20230826   gcc  
x86_64                randconfig-014-20230826   gcc  
x86_64                randconfig-015-20230826   gcc  
x86_64                randconfig-016-20230826   gcc  
x86_64                randconfig-071-20230826   gcc  
x86_64                randconfig-072-20230826   gcc  
x86_64                randconfig-073-20230826   gcc  
x86_64                randconfig-074-20230826   gcc  
x86_64                randconfig-075-20230826   gcc  
x86_64                randconfig-076-20230826   gcc  
x86_64               randconfig-r022-20230826   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa               randconfig-r001-20230826   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
