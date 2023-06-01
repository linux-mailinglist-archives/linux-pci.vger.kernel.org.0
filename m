Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2ED7195E7
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jun 2023 10:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjFAIp2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jun 2023 04:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjFAIoz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jun 2023 04:44:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1CC133
        for <linux-pci@vger.kernel.org>; Thu,  1 Jun 2023 01:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685609094; x=1717145094;
  h=date:from:to:cc:subject:message-id;
  bh=fKHEg/boybof1amyFmjdupx+pY0wZ62pNDSsiAQhMDo=;
  b=fnZ1sLVWBBznsj+n9ozkBpVfmd84oApS8QJ6rDBXVddZJhtlB5nE8hxc
   w51fO7Ly857xU66dYt4iSFwJezjDHWMgTHoHjllfEwQ8Z0e1u6bmiQr8K
   VE5kVdMg7Dqs7ux/wgHl7HGPP7EpDDoS+IIFWujkX6R0RTCy7I0eh+zlP
   vdItRYhpL5/w04jSonQUVD3NnbQBXHrb7aT3B+NyODWzICL07zxOAu1r+
   Rtjm24KKtj233rqDxqYvvgBtirLsB1kAHq0h6FJA1vitm02gP3puKwzol
   08cs+oeobAeCtDNyJcgvdvqijAfOdv3bT0Mhl0/Ok17ZYYDdN5ik3vtND
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="358773204"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; 
   d="scan'208";a="358773204"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 01:44:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="684768182"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; 
   d="scan'208";a="684768182"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 01 Jun 2023 01:44:53 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4dvQ-00026A-1G;
        Thu, 01 Jun 2023 08:44:52 +0000
Date:   Thu, 01 Jun 2023 16:44:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 40994ce0ea010b1843e620bacc26d29ddebfc08d
Message-ID: <20230601084419.8uraG%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: 40994ce0ea010b1843e620bacc26d29ddebfc08d  MAINTAINERS: Add Chuanhua Lei as Intel LGM GW PCIe maintainer

elapsed time: 886m

configs tested: 126
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r012-20230531   gcc  
alpha                randconfig-r036-20230531   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230531   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r021-20230531   gcc  
arm                  randconfig-r046-20230531   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r022-20230531   clang
csky                             alldefconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r015-20230531   gcc  
csky                 randconfig-r025-20230531   gcc  
csky                 randconfig-r031-20230531   gcc  
hexagon              randconfig-r041-20230531   clang
hexagon              randconfig-r045-20230531   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230531   gcc  
i386                 randconfig-i002-20230531   gcc  
i386                 randconfig-i003-20230531   gcc  
i386                 randconfig-i004-20230531   gcc  
i386                 randconfig-i005-20230531   gcc  
i386                 randconfig-i006-20230531   gcc  
i386                 randconfig-i011-20230531   clang
i386                 randconfig-i012-20230531   clang
i386                 randconfig-i013-20230531   clang
i386                 randconfig-i014-20230531   clang
i386                 randconfig-i015-20230531   clang
i386                 randconfig-i016-20230531   clang
i386                 randconfig-i051-20230531   gcc  
i386                 randconfig-i052-20230531   gcc  
i386                 randconfig-i053-20230531   gcc  
i386                 randconfig-i054-20230531   gcc  
i386                 randconfig-i055-20230531   gcc  
i386                 randconfig-i056-20230531   gcc  
i386                 randconfig-i061-20230531   gcc  
i386                 randconfig-i062-20230531   gcc  
i386                 randconfig-i063-20230531   gcc  
i386                 randconfig-i064-20230531   gcc  
i386                 randconfig-i065-20230531   gcc  
i386                 randconfig-i066-20230531   gcc  
i386                 randconfig-r034-20230531   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r004-20230531   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r003-20230531   gcc  
microblaze           randconfig-r016-20230531   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r002-20230531   clang
mips                 randconfig-r005-20230531   clang
nios2                               defconfig   gcc  
nios2                randconfig-r026-20230531   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r001-20230531   clang
powerpc                   currituck_defconfig   gcc  
powerpc                    gamecube_defconfig   clang
powerpc              randconfig-r035-20230531   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r003-20230531   clang
riscv        buildonly-randconfig-r005-20230531   clang
riscv                               defconfig   gcc  
riscv                randconfig-r032-20230531   gcc  
riscv                randconfig-r042-20230531   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230531   clang
sh                               allmodconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                   randconfig-r014-20230531   gcc  
sh                             shx3_defconfig   gcc  
sparc        buildonly-randconfig-r002-20230531   gcc  
sparc        buildonly-randconfig-r006-20230531   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230531   gcc  
sparc64              randconfig-r006-20230531   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230531   gcc  
x86_64               randconfig-a002-20230531   gcc  
x86_64               randconfig-a003-20230531   gcc  
x86_64               randconfig-a004-20230531   gcc  
x86_64               randconfig-a005-20230531   gcc  
x86_64               randconfig-a006-20230531   gcc  
x86_64               randconfig-a011-20230531   clang
x86_64               randconfig-a012-20230531   clang
x86_64               randconfig-a013-20230531   clang
x86_64               randconfig-a014-20230531   clang
x86_64               randconfig-a015-20230531   clang
x86_64               randconfig-a016-20230531   clang
x86_64               randconfig-x051-20230531   clang
x86_64               randconfig-x052-20230531   clang
x86_64               randconfig-x053-20230531   clang
x86_64               randconfig-x054-20230531   clang
x86_64               randconfig-x055-20230531   clang
x86_64               randconfig-x056-20230531   clang
x86_64               randconfig-x061-20230531   clang
x86_64               randconfig-x062-20230531   clang
x86_64               randconfig-x063-20230531   clang
x86_64               randconfig-x064-20230531   clang
x86_64               randconfig-x065-20230531   clang
x86_64               randconfig-x066-20230531   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r004-20230531   gcc  
xtensa               randconfig-r013-20230531   gcc  
xtensa               randconfig-r023-20230531   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
