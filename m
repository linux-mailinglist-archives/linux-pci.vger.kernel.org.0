Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE176DF3D7
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 13:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjDLLgD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Apr 2023 07:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjDLLf7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2023 07:35:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB377AAC
        for <linux-pci@vger.kernel.org>; Wed, 12 Apr 2023 04:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681299339; x=1712835339;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ksJLT/9v/nJqMf1pZJ9iLjQq7c4dxyeUC4wfGPb1Hgg=;
  b=NuftliEuD/xQu/F+wDHIE0yvqHsq1FVdxt7gLHEYuhjUP8E8daw+x36G
   jqP3jbaczZvvcYnZNC0f7nKPzLAAbtyLj1SR8ZYoLSdg6RiUoiUX2DzX1
   GcnvMEGspoXx9v1+TN0k2ot/84X4f8QgGHIlYtkhEGcjoibDGYDAJaBkL
   srCE2DP4N0jjb1N3xn8nfhAHPy127rHunek0ioWXbaCBpuHUQn3d9E7We
   doO/a5vFZY8uf6+yWqFho4bj+vWgOpaxZ5cYAACUryl8h1Avgh5jAmDXl
   qPp9FKXoCH7IV77SauzD7AEvYUX4rSyGMS5bRKVHGyZ7Qc0/TAMBqrvWd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="332561438"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332561438"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 04:30:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="812955895"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="812955895"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 12 Apr 2023 04:30:08 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmYfv-000XgD-1w;
        Wed, 12 Apr 2023 11:30:07 +0000
Date:   Wed, 12 Apr 2023 19:29:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:reset] BUILD SUCCESS
 e74b2b58ff715ca17bb49c3ad89f665a7150e14b
Message-ID: <64369605.nN1CR49dWEDqm8cz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git reset
branch HEAD: e74b2b58ff715ca17bb49c3ad89f665a7150e14b  PCI/PM: Drop pci_bridge_wait_for_secondary_bus() timeout parameter

elapsed time: 739m

configs tested: 65
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r012-20230409   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r011-20230409   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230410   clang
i386                 randconfig-a002-20230410   clang
i386                 randconfig-a003-20230410   clang
i386                 randconfig-a004-20230410   clang
i386                 randconfig-a005-20230410   clang
i386                 randconfig-a006-20230410   clang
i386                 randconfig-a011-20230410   gcc  
i386                 randconfig-a012-20230410   gcc  
i386                 randconfig-a013-20230410   gcc  
i386                 randconfig-a014-20230410   gcc  
i386                 randconfig-a015-20230410   gcc  
i386                 randconfig-a016-20230410   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r011-20230410   clang
nios2                               defconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sparc                               defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230410   clang
x86_64               randconfig-a002-20230410   clang
x86_64               randconfig-a003-20230410   clang
x86_64               randconfig-a004-20230410   clang
x86_64               randconfig-a005-20230410   clang
x86_64               randconfig-a006-20230410   clang
x86_64                        randconfig-k001   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
