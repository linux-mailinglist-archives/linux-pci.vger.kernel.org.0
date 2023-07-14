Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331FC753113
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 07:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbjGNFUh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 01:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbjGNFUb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 01:20:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CC830DF
        for <linux-pci@vger.kernel.org>; Thu, 13 Jul 2023 22:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689312024; x=1720848024;
  h=date:from:to:cc:subject:message-id;
  bh=4ZlszdINOTDn/8Ts0MJPmE5ES6ahNeXXd0nOMFMhwFs=;
  b=KnmSxa5C5u8JMQ/ob+5HyGodM+QO4nBAiKnkeVe61dPBXLrCgMpAa6u8
   ibguVyPJSiYQMRdosYnRCcK2J3cHGN5ETWE8v7xP1u5jyDOKLx/CBPmp/
   jmdHtOy+TGrbswQow+VWgw34cAuN8wl9B7E8hn6E2pLJZCpCoRs8986Mf
   /O8xsjxtkwQygfpwwjIaeySip0uDI/zfxlkKWzReR7nLBUiz3GUj3XRbS
   6E8rc+/vl0OwZDVGFXEtGSUFUBZQJeEKNsopbMehlNzG2pqroCaq5xUN7
   SFdvCOUT48rOp7886IWDC/AIfVJS/K72bmw5oSYFYcWaHOdG4oGiaceyc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="362858641"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="362858641"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 22:20:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="757446382"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="757446382"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 Jul 2023 22:20:23 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qKBE6-0007Ce-1K;
        Fri, 14 Jul 2023 05:20:22 +0000
Date:   Fri, 14 Jul 2023 13:19:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 091f9f7f3b819434eed5c1c3acad6c7b32bf13f6
Message-ID: <202307141350.tRzsVKvM-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc
branch HEAD: 091f9f7f3b819434eed5c1c3acad6c7b32bf13f6  PCI: Change pdev->rom_attr_enabled to single bit

elapsed time: 724m

configs tested: 122
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230713   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                  randconfig-r043-20230713   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                     davinci_all_defconfig   clang
arm                                 defconfig   gcc  
arm                            qcom_defconfig   gcc  
arm                  randconfig-r046-20230713   clang
arm                           sunxi_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r011-20230713   gcc  
arm64                randconfig-r013-20230713   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230713   gcc  
hexagon              randconfig-r014-20230713   clang
hexagon              randconfig-r026-20230713   clang
hexagon              randconfig-r041-20230713   clang
hexagon              randconfig-r045-20230713   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230713   clang
i386         buildonly-randconfig-r005-20230713   clang
i386         buildonly-randconfig-r006-20230713   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230713   clang
i386                 randconfig-i002-20230713   clang
i386                 randconfig-i003-20230713   clang
i386                 randconfig-i004-20230713   clang
i386                 randconfig-i005-20230713   clang
i386                 randconfig-i006-20230713   clang
i386                 randconfig-i011-20230714   clang
i386                 randconfig-i012-20230714   clang
i386                 randconfig-i013-20230714   clang
i386                 randconfig-i014-20230714   clang
i386                 randconfig-i015-20230714   clang
i386                 randconfig-i016-20230714   clang
i386                 randconfig-r003-20230713   clang
i386                 randconfig-r024-20230713   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r005-20230713   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
mips                 randconfig-r022-20230713   clang
mips                           rs90_defconfig   clang
nios2                               defconfig   gcc  
nios2                randconfig-r006-20230713   gcc  
nios2                randconfig-r025-20230713   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r012-20230713   gcc  
parisc               randconfig-r034-20230713   gcc  
parisc               randconfig-r036-20230713   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          g5_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                randconfig-r042-20230713   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230713   gcc  
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                  defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r016-20230713   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r023-20230713   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230713   clang
x86_64       buildonly-randconfig-r002-20230713   clang
x86_64       buildonly-randconfig-r003-20230713   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r015-20230713   gcc  
x86_64               randconfig-r031-20230713   clang
x86_64               randconfig-x001-20230713   gcc  
x86_64               randconfig-x002-20230713   gcc  
x86_64               randconfig-x003-20230713   gcc  
x86_64               randconfig-x004-20230713   gcc  
x86_64               randconfig-x005-20230713   gcc  
x86_64               randconfig-x006-20230713   gcc  
x86_64               randconfig-x011-20230713   clang
x86_64               randconfig-x012-20230713   clang
x86_64               randconfig-x013-20230713   clang
x86_64               randconfig-x014-20230713   clang
x86_64               randconfig-x015-20230713   clang
x86_64               randconfig-x016-20230713   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
