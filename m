Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9A860E00B
	for <lists+linux-pci@lfdr.de>; Wed, 26 Oct 2022 13:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbiJZLu6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Oct 2022 07:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbiJZLuz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Oct 2022 07:50:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509D39A2BB
        for <linux-pci@vger.kernel.org>; Wed, 26 Oct 2022 04:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666785054; x=1698321054;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Rt61yAleuqHiCLnHJK9yiw00AyxkWwxjtvbTwBwqP2k=;
  b=dgOPhJ0/fPLXaCJPznq+HzFf9hDm1tw1UclsWiVDoyqN/aQB4DLyJdDM
   oLsehjt0O4RhMdEJAP2qoZtBwvzlc3Mo5j7qmysuvnMf9Kx354ELz7bie
   KtckRoMxm7GSmjriL4C01NyQ1F4drr7cIgO74bijO6PLBq9e0vFg8kZAW
   IuIv9K5Xmvy/W6BbJb/Me5AeR9E4D8tNA4OcmF+JIV2nPVKplT2jwDIAU
   ji7SoXdFmeZO1b5w2hnm+b1QhSPU0IaxCWwFrDkisS9rJgrFmTan+u/9z
   LrBAkwcXnE2m1g+MJsW6h+s9K+uOdfdCfplZJEKlTwBjgnGwyzPfivick
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="291229211"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="291229211"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 04:50:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="609923899"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="609923899"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 26 Oct 2022 04:50:50 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1onevp-0007My-1v;
        Wed, 26 Oct 2022 11:50:49 +0000
Date:   Wed, 26 Oct 2022 19:49:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/pm] BUILD SUCCESS
 c946287d8e2fde04c73d6a7bc8a9713a7d84b16b
Message-ID: <63591ee6.6bX+PX61cf10nj10%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/pm
branch HEAD: c946287d8e2fde04c73d6a7bc8a9713a7d84b16b  PCI/PM: Remove unused 'state' parameter to pci_legacy_suspend_late()

elapsed time: 724m

configs tested: 90
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
s390                             allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
ia64                             allmodconfig
x86_64                              defconfig
i386                                defconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64               randconfig-a014-20221024
x86_64               randconfig-a013-20221024
x86_64               randconfig-a012-20221024
x86_64               randconfig-a011-20221024
x86_64               randconfig-a015-20221024
arc                              allyesconfig
x86_64               randconfig-a016-20221024
alpha                            allyesconfig
i386                             allyesconfig
arc                  randconfig-r043-20221023
arc                  randconfig-r043-20221025
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
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
i386                 randconfig-a011-20221024
i386                 randconfig-a014-20221024
i386                 randconfig-a015-20221024
i386                 randconfig-a016-20221024
i386                 randconfig-a012-20221024
i386                 randconfig-a013-20221024
ia64                          tiger_defconfig
powerpc                   motionpro_defconfig
sh                         ecovec24_defconfig
sh                        sh7785lcr_defconfig
mips                     decstation_defconfig
arm                         axm55xx_defconfig
powerpc                       holly_defconfig
arm                           viper_defconfig
i386                          randconfig-c001
arc                  randconfig-r043-20221024
s390                 randconfig-r044-20221024
riscv                randconfig-r042-20221024

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
riscv                randconfig-r042-20221023
hexagon              randconfig-r041-20221023
hexagon              randconfig-r045-20221023
s390                 randconfig-r044-20221023
mips                malta_qemu_32r6_defconfig
arm                        spear3xx_defconfig
x86_64               randconfig-a005-20221024
x86_64               randconfig-a002-20221024
x86_64               randconfig-a006-20221024
x86_64               randconfig-a001-20221024
x86_64               randconfig-a004-20221024
x86_64               randconfig-a003-20221024
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
