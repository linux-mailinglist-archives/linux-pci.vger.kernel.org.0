Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B656EB304
	for <lists+linux-pci@lfdr.de>; Fri, 21 Apr 2023 22:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjDUUq1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Apr 2023 16:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDUUq0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Apr 2023 16:46:26 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD53E1FD8
        for <linux-pci@vger.kernel.org>; Fri, 21 Apr 2023 13:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682109984; x=1713645984;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=SEa3KDSsW5b+cZg81Wrxq7GCdiKwpVc0GGgwT0Ds5gk=;
  b=JVOKqkwHMbB5a1dsX2PKXrGYiSJAcFqSTwLGkyEXdfWS+t1UP5QHswJ/
   ETl9u/FdO/g4E+FA6lQINYoy4buGnj7rqImbFQnaZxH/NDRkBrTpdT1H8
   Iqkm4BCW9EMzeXnVOWLraRJ+Q1S36jBWpOvBZJZoRR5yn5fpCc8Ui5FZe
   A2xdopoeghppITnblNaDVbkC1Sb+o7vwxfu1ScS5yfzxHjz/+9Z4nvl/k
   t12wAmFfmT39y3P8CszZOzh2MXJ/KN6Be68hPuhiV8aWnzXd2RMMDul4d
   Lsr0SRYdljRg0B649oWIY7TuBdIiLyzpVNOJ6ZTVoYEoYQFXwJcNR68Z0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="409017082"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="409017082"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 13:46:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="803862393"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="803862393"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 21 Apr 2023 13:46:22 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppxe9-000gmx-37;
        Fri, 21 Apr 2023 20:46:21 +0000
Date:   Sat, 22 Apr 2023 04:45:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:controller/vmd] BUILD SUCCESS
 e06720c1d9e1b5f02de64b67c3f2779497978917
Message-ID: <6442f601.FsT2kbuJPauGcoOD%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/vmd
branch HEAD: e06720c1d9e1b5f02de64b67c3f2779497978917  PCI: vmd: Reset VMD config register between soft reboots

elapsed time: 723m

configs tested: 170
configs skipped: 15

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230417   gcc  
alpha                randconfig-r002-20230418   gcc  
alpha                randconfig-r004-20230417   gcc  
alpha                randconfig-r005-20230420   gcc  
alpha                randconfig-r023-20230421   gcc  
alpha                randconfig-r036-20230420   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r031-20230421   gcc  
arc                  randconfig-r033-20230421   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r001-20230420   gcc  
arm                  randconfig-r002-20230420   gcc  
arm                  randconfig-r005-20230421   clang
arm                  randconfig-r013-20230417   gcc  
arm                  randconfig-r023-20230416   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r005-20230418   clang
arm64                randconfig-r016-20230416   gcc  
arm64                randconfig-r022-20230416   gcc  
arm64                randconfig-r034-20230419   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r006-20230417   gcc  
csky                 randconfig-r012-20230421   gcc  
csky                 randconfig-r013-20230420   gcc  
csky                 randconfig-r024-20230416   gcc  
csky                 randconfig-r025-20230421   gcc  
csky                 randconfig-r036-20230417   gcc  
csky                 randconfig-r036-20230421   gcc  
hexagon              randconfig-r003-20230417   clang
hexagon              randconfig-r012-20230420   clang
hexagon              randconfig-r032-20230417   clang
hexagon              randconfig-r033-20230417   clang
hexagon              randconfig-r035-20230417   clang
hexagon              randconfig-r041-20230421   clang
hexagon              randconfig-r045-20230421   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230417   gcc  
i386                 randconfig-a002-20230417   gcc  
i386                          randconfig-a002   clang
i386                 randconfig-a003-20230417   gcc  
i386                 randconfig-a004-20230417   gcc  
i386                          randconfig-a004   clang
i386                 randconfig-a005-20230417   gcc  
i386                 randconfig-a006-20230417   gcc  
i386                          randconfig-a006   clang
i386                 randconfig-a011-20230417   clang
i386                 randconfig-a012-20230417   clang
i386                          randconfig-a012   gcc  
i386                 randconfig-a013-20230417   clang
i386                 randconfig-a014-20230417   clang
i386                          randconfig-a014   gcc  
i386                 randconfig-a015-20230417   clang
i386                 randconfig-a016-20230417   clang
i386                          randconfig-a016   gcc  
i386                 randconfig-r022-20230417   clang
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r005-20230421   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r012-20230416   gcc  
ia64                 randconfig-r022-20230421   gcc  
ia64                 randconfig-r031-20230419   gcc  
ia64                 randconfig-r036-20230416   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r011-20230420   gcc  
loongarch            randconfig-r011-20230421   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r003-20230416   gcc  
m68k                 randconfig-r004-20230416   gcc  
m68k                 randconfig-r004-20230420   gcc  
m68k                 randconfig-r011-20230417   gcc  
m68k                 randconfig-r013-20230416   gcc  
m68k                 randconfig-r014-20230421   gcc  
m68k                 randconfig-r024-20230417   gcc  
m68k                 randconfig-r026-20230417   gcc  
microblaze           randconfig-r013-20230421   gcc  
microblaze           randconfig-r014-20230417   gcc  
microblaze           randconfig-r016-20230417   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r001-20230416   gcc  
mips                 randconfig-r025-20230417   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230418   gcc  
nios2                randconfig-r014-20230420   gcc  
openrisc     buildonly-randconfig-r003-20230421   gcc  
openrisc             randconfig-r006-20230416   gcc  
openrisc             randconfig-r033-20230419   gcc  
openrisc             randconfig-r033-20230420   gcc  
parisc       buildonly-randconfig-r002-20230421   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r024-20230421   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r002-20230417   gcc  
powerpc              randconfig-r006-20230418   clang
powerpc              randconfig-r015-20230420   gcc  
powerpc              randconfig-r026-20230416   gcc  
powerpc              randconfig-r032-20230421   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r015-20230417   clang
riscv                randconfig-r035-20230421   gcc  
riscv                randconfig-r042-20230421   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r005-20230416   clang
s390                 randconfig-r035-20230416   clang
s390                 randconfig-r044-20230421   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r005-20230417   gcc  
sh                   randconfig-r006-20230420   gcc  
sh                   randconfig-r016-20230420   gcc  
sparc        buildonly-randconfig-r004-20230421   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230418   gcc  
sparc                randconfig-r023-20230417   gcc  
sparc                randconfig-r031-20230416   gcc  
sparc                randconfig-r034-20230420   gcc  
sparc                randconfig-r034-20230421   gcc  
sparc64      buildonly-randconfig-r001-20230421   gcc  
sparc64              randconfig-r003-20230420   gcc  
sparc64              randconfig-r011-20230416   gcc  
sparc64              randconfig-r021-20230416   gcc  
sparc64              randconfig-r031-20230420   gcc  
sparc64              randconfig-r034-20230417   gcc  
sparc64              randconfig-r035-20230419   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230417   gcc  
x86_64                        randconfig-a001   clang
x86_64               randconfig-a002-20230417   gcc  
x86_64               randconfig-a003-20230417   gcc  
x86_64                        randconfig-a003   clang
x86_64               randconfig-a004-20230417   gcc  
x86_64               randconfig-a005-20230417   gcc  
x86_64                        randconfig-a005   clang
x86_64               randconfig-a006-20230417   gcc  
x86_64               randconfig-a011-20230417   clang
x86_64               randconfig-a012-20230417   clang
x86_64               randconfig-a013-20230417   clang
x86_64               randconfig-a014-20230417   clang
x86_64               randconfig-a015-20230417   clang
x86_64               randconfig-a016-20230417   clang
x86_64                        randconfig-k001   clang
x86_64               randconfig-r031-20230417   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r014-20230416   gcc  
xtensa               randconfig-r021-20230421   gcc  
xtensa               randconfig-r032-20230416   gcc  
xtensa               randconfig-r034-20230416   gcc  
xtensa               randconfig-r036-20230419   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
