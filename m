Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5C460E00C
	for <lists+linux-pci@lfdr.de>; Wed, 26 Oct 2022 13:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbiJZLu7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Oct 2022 07:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbiJZLu4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Oct 2022 07:50:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8649A2B5
        for <linux-pci@vger.kernel.org>; Wed, 26 Oct 2022 04:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666785055; x=1698321055;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=PahItc7QSpiilw8eJVwSW+r+AxRv3bBjIEqvn4hCn1E=;
  b=n4ce053Ao4wQ7mN8h9lhJxOQaI4BslNBJZrBHXEtXGxiW4AmJPXVnlQL
   3tsViUULChwZ1g5GmbMWR7YXebVynrUifMzHy1z8mBDI2lFjMBaqDeY+1
   El+sJH8CpkLF1speXgzthTjCssPR6VUIS70X9XLNPZs/IDT8zmsTq5s2I
   aSxU7B7j/sxDlrK3Hw9QJvhcf1JMp5A+otZ2zlKgDCLVp+o22yX/7q5PN
   Puhtj4rcO3E6jtfVv5sJW4Gd9i1o7jcGMsBz5fgnAbzT9SAc5QxRFlnSj
   v3sq+nHwEogGQaSYouEm7wka1guOdKvW66/kwRSONojwi4cT9qzkVrW65
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="394236432"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="394236432"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 04:50:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="757274221"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="757274221"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 26 Oct 2022 04:50:50 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1onevp-0007NC-2M;
        Wed, 26 Oct 2022 11:50:49 +0000
Date:   Wed, 26 Oct 2022 19:50:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/pm-agp] BUILD SUCCESS
 ea1eb09f995b99197b956d844dc30d3ea03bbeb7
Message-ID: <63591eeb.X99KO1eiQUsWxFqZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/pm-agp
branch HEAD: ea1eb09f995b99197b956d844dc30d3ea03bbeb7  agp/via: Update to DEFINE_SIMPLE_DEV_PM_OPS()

elapsed time: 724m

configs tested: 103
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
arc                                 defconfig
um                           x86_64_defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
s390                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
x86_64                           rhel-8.3-syz
alpha                            allyesconfig
x86_64                         rhel-8.3-kunit
powerpc                           allnoconfig
x86_64                           rhel-8.3-kvm
x86_64                              defconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
m68k                             allyesconfig
sh                               allmodconfig
i386                                defconfig
ia64                             allmodconfig
x86_64               randconfig-a014-20221024
i386                 randconfig-a011-20221024
x86_64               randconfig-a013-20221024
i386                 randconfig-a013-20221024
x86_64               randconfig-a011-20221024
i386                 randconfig-a012-20221024
x86_64               randconfig-a015-20221024
i386                 randconfig-a014-20221024
x86_64               randconfig-a012-20221024
x86_64               randconfig-a016-20221024
i386                 randconfig-a015-20221024
i386                 randconfig-a016-20221024
arc                  randconfig-r043-20221024
i386                             allyesconfig
riscv                randconfig-r042-20221024
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
arc                  randconfig-r043-20221025
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
arc                  randconfig-r043-20221026
riscv                randconfig-r042-20221026
s390                 randconfig-r044-20221026
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                       omap2plus_defconfig
arm                              allmodconfig
nios2                         3c120_defconfig
powerpc                    klondike_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
ia64                          tiger_defconfig
powerpc                   motionpro_defconfig
sh                         ecovec24_defconfig
sh                        sh7785lcr_defconfig
mips                     decstation_defconfig
arm                         axm55xx_defconfig
powerpc                       holly_defconfig
arm                           viper_defconfig
s390                 randconfig-r044-20221024
i386                          randconfig-c001

clang tested configs:
hexagon              randconfig-r045-20221023
x86_64               randconfig-a001-20221024
hexagon              randconfig-r041-20221024
x86_64               randconfig-a003-20221024
x86_64               randconfig-a002-20221024
riscv                randconfig-r042-20221023
hexagon              randconfig-r045-20221024
x86_64               randconfig-a005-20221024
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a001
x86_64                        randconfig-a003
mips                malta_qemu_32r6_defconfig
arm                        spear3xx_defconfig
x86_64               randconfig-a006-20221024
x86_64               randconfig-a004-20221024
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20221026
hexagon              randconfig-r045-20221026
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
