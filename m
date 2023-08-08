Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E60774B38
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 22:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjHHUnS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 16:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjHHUmq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 16:42:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBC32FA06
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 09:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691512257; x=1723048257;
  h=date:from:to:cc:subject:message-id;
  bh=3FVZ7HaEE/N0kV8G+Ahwih3I5CkpaJqWM34iAzfSJLA=;
  b=ONAfNIMotY/Tg1BH+7XpzHHSfPMU57ahuUDpdUXau0W4UD19IWgOK22s
   Gk1c1kufrq3wRFDnHfQM/1BevMuv0+MQL68uA9crcd3omyGP6PnQbT6cL
   zJMnb0w79lQmBmXCKJHfW6Uws/xyel5CyNShJRs0cZbk+hrZwaHJ0rGuL
   9EwWiJ5KFKjXW/rNKTKN+ScGdeJIeuUbopS8s1KsPOLLyuceAN19Gx4yP
   9ZTlRJLXT7T8YVeNGNWS8aToodIjnsU+WTo7c+wUX214rpDsHXbLs5Fr6
   juG3Obydfxc/Z4imLdy2Lk7zSHtnTmg50RVqfRup01eDxZ3BsDn6AJthD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="401733514"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="401733514"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 02:30:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="724845278"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="724845278"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 08 Aug 2023 02:30:55 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qTJ3G-0005GI-0S;
        Tue, 08 Aug 2023 09:30:54 +0000
Date:   Tue, 08 Aug 2023 17:30:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 6f7dc3076717d48980d8214eee083ee401fbe66d
Message-ID: <202308081745.zkp4RFGK-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc
branch HEAD: 6f7dc3076717d48980d8214eee083ee401fbe66d  PCI/IOV: Use pci_dev_id() to simplify the code

elapsed time: 724m

configs tested: 107
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230807   gcc  
alpha                randconfig-r025-20230807   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230807   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r032-20230807   clang
arm                  randconfig-r033-20230807   clang
arm                  randconfig-r046-20230807   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230807   gcc  
arm64                randconfig-r004-20230807   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r012-20230807   gcc  
csky                 randconfig-r016-20230807   gcc  
hexagon              randconfig-r031-20230807   clang
hexagon              randconfig-r041-20230807   clang
hexagon              randconfig-r045-20230807   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230807   gcc  
i386         buildonly-randconfig-r005-20230807   gcc  
i386         buildonly-randconfig-r006-20230807   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230807   gcc  
i386                 randconfig-i002-20230807   gcc  
i386                 randconfig-i003-20230807   gcc  
i386                 randconfig-i004-20230807   gcc  
i386                 randconfig-i005-20230807   gcc  
i386                 randconfig-i006-20230807   gcc  
i386                 randconfig-i011-20230807   clang
i386                 randconfig-i012-20230807   clang
i386                 randconfig-i013-20230807   clang
i386                 randconfig-i014-20230807   clang
i386                 randconfig-i015-20230807   clang
i386                 randconfig-i016-20230807   clang
i386                 randconfig-r002-20230807   gcc  
i386                 randconfig-r034-20230807   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r005-20230807   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r021-20230807   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r014-20230807   gcc  
mips                 randconfig-r023-20230807   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r036-20230807   gcc  
openrisc             randconfig-r024-20230807   gcc  
openrisc             randconfig-r026-20230807   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r006-20230807   gcc  
riscv                randconfig-r042-20230807   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230807   clang
sh                               allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r015-20230807   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r011-20230807   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230807   gcc  
x86_64       buildonly-randconfig-r002-20230807   gcc  
x86_64       buildonly-randconfig-r003-20230807   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230807   clang
x86_64               randconfig-x002-20230807   clang
x86_64               randconfig-x003-20230807   clang
x86_64               randconfig-x004-20230807   clang
x86_64               randconfig-x005-20230807   clang
x86_64               randconfig-x006-20230807   clang
x86_64               randconfig-x011-20230807   gcc  
x86_64               randconfig-x012-20230807   gcc  
x86_64               randconfig-x013-20230807   gcc  
x86_64               randconfig-x014-20230807   gcc  
x86_64               randconfig-x015-20230807   gcc  
x86_64               randconfig-x016-20230807   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r013-20230807   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
