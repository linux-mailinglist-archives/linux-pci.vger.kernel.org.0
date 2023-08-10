Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45ED87772DF
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 10:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjHJI1J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 04:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbjHJI1G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 04:27:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F23DC
        for <linux-pci@vger.kernel.org>; Thu, 10 Aug 2023 01:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691656025; x=1723192025;
  h=date:from:to:cc:subject:message-id;
  bh=t16RhGOMosnQI/9Yw7KZF12Of01gNVWRs6V1phI3SV4=;
  b=CXLJWcoauHykj2swQilrJJYdGjU/N/HB6HPDaaXlpgOitk7UsBIsJYQs
   Td8tac3/Pub5IM54JFmVC9dwK8O40SDn5FAPteaAgRJR5cAY5/JzRlOGs
   h7z9W1LVoGmzPmljgwHO77vcWib3Ysun1F6D9ZX/IHORJdPx9dUB/bkRL
   LylnwkbqtS8dSiQWGso7rwnFQeJLgdhoygvbvZ+3qHFhskxCGotjQx+zz
   TbXAZ5usbGrnFKe0BUh/aHCmWcEf59vXaw3maPrZzyXX5f37C22Li72f/
   bFmipiK2WugX+9fhXvHm0ubuo21EbO6VVnM87DfHrMrhhVPNxBcLazKds
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="402296898"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="402296898"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 01:27:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="725702029"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="725702029"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 10 Aug 2023 01:27:04 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qU10Z-0006rB-1H;
        Thu, 10 Aug 2023 08:27:03 +0000
Date:   Thu, 10 Aug 2023 16:26:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:controller/switchtec] BUILD SUCCESS
 0fb53e64705ae0fabd9593102e0f0e6812968802
Message-ID: <202308101641.Uuf6IIEZ-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/switchtec
branch HEAD: 0fb53e64705ae0fabd9593102e0f0e6812968802  PCI: switchtec: Add support for PCIe Gen5 devices

elapsed time: 722m

configs tested: 121
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230809   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230809   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r005-20230809   clang
arm                  randconfig-r011-20230809   gcc  
arm                  randconfig-r035-20230809   clang
arm                  randconfig-r046-20230809   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             alldefconfig   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r023-20230809   clang
hexagon              randconfig-r041-20230809   clang
hexagon              randconfig-r045-20230809   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230809   gcc  
i386         buildonly-randconfig-r005-20230809   gcc  
i386         buildonly-randconfig-r006-20230809   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230809   gcc  
i386                 randconfig-i002-20230809   gcc  
i386                 randconfig-i003-20230809   gcc  
i386                 randconfig-i004-20230809   gcc  
i386                 randconfig-i005-20230809   gcc  
i386                 randconfig-i006-20230809   gcc  
i386                 randconfig-i011-20230809   clang
i386                 randconfig-i012-20230809   clang
i386                 randconfig-i013-20230809   clang
i386                 randconfig-i014-20230809   clang
i386                 randconfig-i015-20230809   clang
i386                 randconfig-i016-20230809   clang
i386                 randconfig-r024-20230809   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r033-20230809   gcc  
m68k                 randconfig-r034-20230809   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r003-20230809   gcc  
microblaze           randconfig-r014-20230809   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                        vocore2_defconfig   gcc  
nios2                         10m50_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r016-20230809   gcc  
nios2                randconfig-r022-20230809   gcc  
nios2                randconfig-r026-20230809   gcc  
nios2                randconfig-r035-20230809   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r023-20230809   clang
powerpc              randconfig-r032-20230809   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                randconfig-r042-20230809   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r002-20230809   gcc  
s390                 randconfig-r004-20230809   gcc  
s390                 randconfig-r044-20230809   clang
sh                               allmodconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                   randconfig-r012-20230809   gcc  
sh                          rsk7264_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r036-20230809   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r021-20230809   gcc  
um                   randconfig-r025-20230809   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230809   gcc  
x86_64       buildonly-randconfig-r002-20230809   gcc  
x86_64       buildonly-randconfig-r003-20230809   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r013-20230809   clang
x86_64               randconfig-r015-20230809   clang
x86_64               randconfig-r036-20230809   gcc  
x86_64               randconfig-x001-20230809   clang
x86_64               randconfig-x002-20230809   clang
x86_64               randconfig-x003-20230809   clang
x86_64               randconfig-x004-20230809   clang
x86_64               randconfig-x005-20230809   clang
x86_64               randconfig-x006-20230809   clang
x86_64               randconfig-x011-20230809   gcc  
x86_64               randconfig-x012-20230809   gcc  
x86_64               randconfig-x013-20230809   gcc  
x86_64               randconfig-x014-20230809   gcc  
x86_64               randconfig-x015-20230809   gcc  
x86_64               randconfig-x016-20230809   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
