Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD6D763AD4
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jul 2023 17:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjGZPVm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jul 2023 11:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjGZPVl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jul 2023 11:21:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D6794
        for <linux-pci@vger.kernel.org>; Wed, 26 Jul 2023 08:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690384900; x=1721920900;
  h=date:from:to:cc:subject:message-id;
  bh=g6d+/8E0GJFrFxyDaGzdUCFhQ2YheAVoa1tcLVtIbWU=;
  b=HcXmtBfO5wb1ddHaKSxKYUt/hon0kqdCoRShCABPICre2GK6TPPAZoC+
   ceQSt5yJ1xQearLX2aEMjc5EHvx/PYB1VCi2ETAf9qbZfIQwkwFthihJC
   ESRCt4m9Xdq5ywCAUu33LoUgGCE4Dam67tFvKwN8Em7Pf02WcjsLVtLPG
   1hcGDvq9ZyvtWo7KFp/k+IjbRJip7x79XYwSe3/0Op3iZOUFQ5VJSPywF
   zlX61CzU/r+qBf7lfzEU1QyPSuOJl0Rpyh7ac8oRZNQq5M58u6oPD/j2+
   0lmKPzxTe8op3o3q7RvEhP4Rh9+OZTolmj2rEnc2Fz+a1ancdRtbERCxt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="347657602"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="347657602"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 08:21:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="726589065"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="726589065"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 26 Jul 2023 08:21:36 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOgKW-000149-0F;
        Wed, 26 Jul 2023 15:21:36 +0000
Date:   Wed, 26 Jul 2023 23:20:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 f3b827a92f7d54b9cafe55a7a831ca706d3292b5
Message-ID: <202307262345.692AfPsE-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: f3b827a92f7d54b9cafe55a7a831ca706d3292b5  Revert "PCI: acpiphp: Reassign resources on bridge if necessary"

elapsed time: 1114m

configs tested: 106
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r012-20230725   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r013-20230725   gcc  
arc                  randconfig-r033-20230725   gcc  
arc                  randconfig-r035-20230725   gcc  
arc                  randconfig-r043-20230725   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r003-20230725   gcc  
arm                  randconfig-r046-20230725   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r032-20230725   clang
csky                                defconfig   gcc  
csky                 randconfig-r016-20230725   gcc  
hexagon              randconfig-r011-20230725   clang
hexagon              randconfig-r041-20230725   clang
hexagon              randconfig-r045-20230725   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230725   clang
i386         buildonly-randconfig-r005-20230725   clang
i386         buildonly-randconfig-r006-20230725   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230725   clang
i386                 randconfig-i002-20230725   clang
i386                 randconfig-i003-20230725   clang
i386                 randconfig-i004-20230725   clang
i386                 randconfig-i005-20230725   clang
i386                 randconfig-i006-20230725   clang
i386                 randconfig-i011-20230725   gcc  
i386                 randconfig-i012-20230725   gcc  
i386                 randconfig-i013-20230725   gcc  
i386                 randconfig-i014-20230725   gcc  
i386                 randconfig-i015-20230725   gcc  
i386                 randconfig-i016-20230725   gcc  
i386                 randconfig-r022-20230725   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230725   gcc  
loongarch            randconfig-r015-20230725   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r025-20230725   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r001-20230725   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r024-20230725   gcc  
riscv                randconfig-r042-20230725   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r005-20230725   clang
s390                 randconfig-r034-20230725   clang
s390                 randconfig-r044-20230725   gcc  
sh                               allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r031-20230725   gcc  
sparc64              randconfig-r006-20230725   gcc  
sparc64              randconfig-r014-20230725   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r023-20230725   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230725   clang
x86_64       buildonly-randconfig-r002-20230725   clang
x86_64       buildonly-randconfig-r003-20230725   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230725   gcc  
x86_64               randconfig-x002-20230725   gcc  
x86_64               randconfig-x003-20230725   gcc  
x86_64               randconfig-x004-20230725   gcc  
x86_64               randconfig-x005-20230725   gcc  
x86_64               randconfig-x006-20230725   gcc  
x86_64               randconfig-x011-20230725   clang
x86_64               randconfig-x012-20230725   clang
x86_64               randconfig-x013-20230725   clang
x86_64               randconfig-x014-20230725   clang
x86_64               randconfig-x015-20230725   clang
x86_64               randconfig-x016-20230725   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r002-20230725   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
