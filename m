Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D523789F9F
	for <lists+linux-pci@lfdr.de>; Sun, 27 Aug 2023 15:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjH0Ntu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Aug 2023 09:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjH0Nte (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Aug 2023 09:49:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6A4114
        for <linux-pci@vger.kernel.org>; Sun, 27 Aug 2023 06:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693144171; x=1724680171;
  h=date:from:to:cc:subject:message-id;
  bh=I+fzNPckOtp9GZa7NMRZscLCoHVXk/w4h2dBkkk/yI4=;
  b=ZEwW55DXugrGrzATsYTUA5kDWoi0N+z29FrHRmZlOHZ2iG96GSyG1nfp
   y62q0FElH0cy82EPXJxr/IT6+6nWGSREPp41UUwym7mtSQVwUaqTZYfa5
   CW+CDLhERalzBG+WC7PkypRrjtLKdXeWwQqLzC9N4IoQ0tI0dmj0lQGh3
   LEWAk6Rma8jHDsRb1Cj7yYUrut4Ri6CnxDKZJRw2SSOuG/CQ7mztqlnRQ
   WwmluTdOv7H+gAVjHR4tFRCC3kfqE0TgJM0xU4nLH033ReBYjejMSYt8r
   hcRs1AtNQ6bHGUSZeLSxdLR529NuYFR1ewydLByAon9p4t29INtazcIR/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="377681641"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="377681641"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 06:49:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="881652565"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 27 Aug 2023 06:49:34 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qaG8u-0005r3-0l;
        Sun, 27 Aug 2023 13:49:28 +0000
Date:   Sun, 27 Aug 2023 21:49:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 1856d1a036dcd1835ce35957ca65c00cf350daf4
Message-ID: <202308272102.3GPrHcCQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc
branch HEAD: 1856d1a036dcd1835ce35957ca65c00cf350daf4  PCI: Tidy config space save/restore messages

elapsed time: 2846m

configs tested: 157
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
arc                   randconfig-001-20230825   gcc  
arc                  randconfig-r004-20230825   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230825   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r012-20230825   gcc  
arm64                randconfig-r014-20230825   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r022-20230825   gcc  
hexagon               randconfig-001-20230825   clang
hexagon               randconfig-002-20230825   clang
hexagon              randconfig-r011-20230825   clang
hexagon              randconfig-r013-20230825   clang
hexagon              randconfig-r016-20230825   clang
hexagon              randconfig-r036-20230825   clang
i386         buildonly-randconfig-001-20230825   clang
i386         buildonly-randconfig-002-20230825   clang
i386         buildonly-randconfig-003-20230825   clang
i386         buildonly-randconfig-004-20230825   clang
i386         buildonly-randconfig-005-20230825   clang
i386         buildonly-randconfig-006-20230825   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20230826   gcc  
i386                  randconfig-002-20230826   gcc  
i386                  randconfig-003-20230826   gcc  
i386                  randconfig-004-20230826   gcc  
i386                  randconfig-005-20230826   gcc  
i386                  randconfig-006-20230826   gcc  
i386                  randconfig-011-20230826   clang
i386                  randconfig-012-20230826   clang
i386                  randconfig-013-20230826   clang
i386                  randconfig-014-20230826   clang
i386                  randconfig-015-20230826   clang
i386                  randconfig-016-20230826   clang
i386                 randconfig-r035-20230825   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230825   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r005-20230825   gcc  
microblaze           randconfig-r026-20230825   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230825   gcc  
nios2                randconfig-r003-20230825   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r031-20230825   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc              randconfig-r002-20230825   clang
powerpc64            randconfig-r034-20230825   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230825   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230825   gcc  
s390                 randconfig-r006-20230825   clang
s390                 randconfig-r015-20230825   gcc  
s390                 randconfig-r023-20230825   gcc  
s390                 randconfig-r025-20230825   gcc  
s390                 randconfig-r032-20230825   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                   randconfig-r033-20230825   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r021-20230825   gcc  
sparc64              randconfig-r024-20230825   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230826   gcc  
x86_64       buildonly-randconfig-002-20230826   gcc  
x86_64       buildonly-randconfig-003-20230826   gcc  
x86_64       buildonly-randconfig-004-20230826   gcc  
x86_64       buildonly-randconfig-005-20230826   gcc  
x86_64       buildonly-randconfig-006-20230826   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230825   gcc  
x86_64                randconfig-002-20230825   gcc  
x86_64                randconfig-003-20230825   gcc  
x86_64                randconfig-004-20230825   gcc  
x86_64                randconfig-005-20230825   gcc  
x86_64                randconfig-006-20230825   gcc  
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
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
