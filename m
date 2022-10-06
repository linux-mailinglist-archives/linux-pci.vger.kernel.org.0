Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5468B5F60EE
	for <lists+linux-pci@lfdr.de>; Thu,  6 Oct 2022 08:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiJFGR5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 02:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiJFGR4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 02:17:56 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C748B2CA
        for <linux-pci@vger.kernel.org>; Wed,  5 Oct 2022 23:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665037075; x=1696573075;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dfY7unrsvg0GFSHfxcysR3gphwxGKij01e3mkBEgDzE=;
  b=QuJh2EyjkHnZBmOG22WuQ3fIz5ad6nI93DdBPzTlZt6XDFJK8I+aoliz
   UL72PzgQzV4USB69Qqp4y4BHEUtp+4+luEPVdD35T+YjCSmLaAFyxV+DP
   PR4Zplza5yw6IWnaZa9HigqGlVDjidOthCDxGTkg+IQIZ9xvD/nyx4EL0
   +iXmsn4EjfS+NcQS3t93ZPZnS8uTiA9RrNpqFy0YX8IQTq/MgBWlBVkUQ
   w1b3MNCX+9RgtWNOnDZUtDY+pE+KzYAB4jKjqvV2yvLYdSZcaCcpW+w5r
   HRslmHzfGqaPeLXi+4R4y+4mN//OPrf3O/9/eh7OOymtXg4x70TNv/uLf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="304350711"
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="304350711"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 23:17:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="693220246"
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="693220246"
Received: from lkp-server01.sh.intel.com (HELO d4f44333118a) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 05 Oct 2022 23:17:53 -0700
Received: from kbuild by d4f44333118a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ogKCe-00021d-2C;
        Thu, 06 Oct 2022 06:17:52 +0000
Date:   Thu, 06 Oct 2022 14:16:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/aspm] BUILD SUCCESS
 7afeb84d14eaaebb71f5c558ed57ca858e4304e7
Message-ID: <633e72d3.3o+jaOCTlOInDLqt%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/aspm
branch HEAD: 7afeb84d14eaaebb71f5c558ed57ca858e4304e7  PCI/ASPM: Correct LTR_L1.2_THRESHOLD computation

elapsed time: 726m

configs tested: 104
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
m68k                             allmodconfig
x86_64                              defconfig
arc                              allyesconfig
arc                                 defconfig
alpha                            allyesconfig
s390                             allmodconfig
m68k                             allyesconfig
alpha                               defconfig
s390                                defconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                           rhel-8.3-kvm
mips                             allyesconfig
x86_64                         rhel-8.3-kunit
i386                                defconfig
s390                             allyesconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
x86_64                           allyesconfig
sh                               allmodconfig
arm                                 defconfig
i386                             allyesconfig
i386                 randconfig-a014-20221003
i386                 randconfig-a011-20221003
i386                 randconfig-a012-20221003
i386                 randconfig-a013-20221003
x86_64               randconfig-a011-20221003
i386                 randconfig-a015-20221003
i386                 randconfig-a016-20221003
x86_64               randconfig-a014-20221003
x86_64               randconfig-a012-20221003
x86_64               randconfig-a013-20221003
x86_64               randconfig-a015-20221003
x86_64               randconfig-a016-20221003
riscv                randconfig-r042-20221003
arc                  randconfig-r043-20221003
arm64                            allyesconfig
s390                 randconfig-r044-20221003
arm                              allyesconfig
arc                  randconfig-r043-20221002
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
i386                          randconfig-c001
arc                        nsim_700_defconfig
sh                          r7780mp_defconfig
xtensa                              defconfig
powerpc                     taishan_defconfig
powerpc                       eiger_defconfig
loongarch                        alldefconfig
powerpc                 mpc85xx_cds_defconfig
parisc                generic-64bit_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arc                           tb10x_defconfig
um                               alldefconfig
mips                         bigsur_defconfig
arm                  randconfig-c002-20221002
x86_64                        randconfig-c001
m68k                          atari_defconfig
sh                      rts7751r2d1_defconfig
mips                           xway_defconfig
powerpc                    klondike_defconfig
powerpc                         wii_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                       omap2plus_defconfig
arm                     eseries_pxa_defconfig
mips                         cobalt_defconfig
openrisc                            defconfig
nios2                            alldefconfig

clang tested configs:
i386                 randconfig-a004-20221003
i386                 randconfig-a003-20221003
i386                 randconfig-a002-20221003
i386                 randconfig-a001-20221003
i386                 randconfig-a006-20221003
i386                 randconfig-a005-20221003
hexagon              randconfig-r041-20221003
riscv                randconfig-r042-20221002
x86_64               randconfig-a003-20221003
hexagon              randconfig-r041-20221002
x86_64               randconfig-a005-20221003
s390                 randconfig-r044-20221002
x86_64               randconfig-a002-20221003
x86_64               randconfig-a001-20221003
x86_64               randconfig-a004-20221003
hexagon              randconfig-r045-20221002
x86_64               randconfig-a006-20221003
hexagon              randconfig-r045-20221003
powerpc                    mvme5100_defconfig
powerpc                     ppa8548_defconfig
arm                          sp7021_defconfig
arm                        magician_defconfig
x86_64                        randconfig-k001
i386                             allyesconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
