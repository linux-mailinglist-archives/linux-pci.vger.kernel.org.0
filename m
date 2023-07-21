Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35CD75C27A
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jul 2023 11:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjGUJH3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jul 2023 05:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjGUJH2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jul 2023 05:07:28 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0EA30C1
        for <linux-pci@vger.kernel.org>; Fri, 21 Jul 2023 02:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689930447; x=1721466447;
  h=date:from:to:cc:subject:message-id;
  bh=iPNUHgy9B5M7+gzbjjmv3PuqybTGqr8rf34NjUaw6Z4=;
  b=mGISIdeuj2Q7/SCOKKeHP63lordRIajOavKi4xgWbEQeVXwD5aoufrMr
   +Dehpuiai8+9zZaRhk9L5nwY1B5q7xRSrYbmtYKgGQIntSD2ocvZ7l7T/
   pn/vHyF4J8Hvx5srlpN6p/90CvjPi1pVgDMWGGNClaLUiSTKM+IdHvOky
   12hMLRXmGqxdqaJ3OXUfFpsNiJmqG9Ixm/NDXg9FD/Z5KgvlwbC9IsX6Z
   bTDcAF5lUBHAvzWFZLq6FaGyx14tza69x+D2mqZ5ZCobdKR1WyISmnSa4
   BKm/C+3CAvq8TSERoSTmHCGbc39zNiPpPxIg7rZYDnmtoEMuUkknHFl3z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="433207678"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="433207678"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 02:07:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="754389434"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="754389434"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 21 Jul 2023 02:07:26 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMm6Z-00075m-1l;
        Fri, 21 Jul 2023 09:07:20 +0000
Date:   Fri, 21 Jul 2023 17:03:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 69286072664490a366f3331f9496fe78efaca603
Message-ID: <202307211715.nVBOmYRD-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 69286072664490a366f3331f9496fe78efaca603  Merge branch 'pci/misc'

elapsed time: 721m

configs tested: 120
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r011-20230720   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r016-20230720   gcc  
arc                  randconfig-r043-20230720   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230720   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r013-20230720   clang
hexagon              randconfig-r031-20230720   clang
hexagon              randconfig-r035-20230720   clang
hexagon              randconfig-r041-20230720   clang
hexagon              randconfig-r045-20230720   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230720   gcc  
i386         buildonly-randconfig-r005-20230720   gcc  
i386         buildonly-randconfig-r006-20230720   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230720   gcc  
i386                 randconfig-i002-20230720   gcc  
i386                 randconfig-i003-20230720   gcc  
i386                 randconfig-i004-20230720   gcc  
i386                 randconfig-i005-20230720   gcc  
i386                 randconfig-i006-20230720   gcc  
i386                 randconfig-i011-20230720   clang
i386                 randconfig-i012-20230720   clang
i386                 randconfig-i013-20230720   clang
i386                 randconfig-i014-20230720   clang
i386                 randconfig-i015-20230720   clang
i386                 randconfig-i016-20230720   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r005-20230720   gcc  
microblaze           randconfig-r021-20230720   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r002-20230720   clang
nios2                               defconfig   gcc  
nios2                randconfig-r012-20230720   gcc  
openrisc                  or1klitex_defconfig   gcc  
openrisc             randconfig-r004-20230720   gcc  
openrisc             randconfig-r006-20230720   gcc  
openrisc             randconfig-r025-20230720   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230720   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                      katmai_defconfig   clang
powerpc                     stx_gp3_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r032-20230720   gcc  
riscv                randconfig-r042-20230720   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r015-20230720   clang
s390                 randconfig-r044-20230720   clang
sh                               allmodconfig   gcc  
sh                             espt_defconfig   gcc  
sh                   randconfig-r001-20230720   gcc  
sh                   randconfig-r023-20230720   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r033-20230720   gcc  
sparc                       sparc64_defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r026-20230720   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230720   gcc  
x86_64       buildonly-randconfig-r002-20230720   gcc  
x86_64       buildonly-randconfig-r003-20230720   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r022-20230720   clang
x86_64               randconfig-r036-20230720   gcc  
x86_64               randconfig-x001-20230720   clang
x86_64               randconfig-x001-20230721   gcc  
x86_64               randconfig-x002-20230720   clang
x86_64               randconfig-x002-20230721   gcc  
x86_64               randconfig-x003-20230720   clang
x86_64               randconfig-x003-20230721   gcc  
x86_64               randconfig-x004-20230720   clang
x86_64               randconfig-x004-20230721   gcc  
x86_64               randconfig-x005-20230720   clang
x86_64               randconfig-x005-20230721   gcc  
x86_64               randconfig-x006-20230720   clang
x86_64               randconfig-x006-20230721   gcc  
x86_64               randconfig-x011-20230720   gcc  
x86_64               randconfig-x012-20230720   gcc  
x86_64               randconfig-x013-20230720   gcc  
x86_64               randconfig-x014-20230720   gcc  
x86_64               randconfig-x015-20230720   gcc  
x86_64               randconfig-x016-20230720   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r001-20230720   gcc  
xtensa               randconfig-r005-20230720   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
