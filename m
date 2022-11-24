Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155F16371D6
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 06:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiKXFlG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 00:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKXFlD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 00:41:03 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EF0C4B7B
        for <linux-pci@vger.kernel.org>; Wed, 23 Nov 2022 21:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669268459; x=1700804459;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=uGaRV/G4JdSK9hQBIN1Ko2ttWECH79c895/FM3uLY1g=;
  b=jOjwCXKVe42YyrguhdCphuMNZrLd+O5ZAlov8VHQ1diq3ZWSjP0xKb0c
   iA0LCI9uOZ313+Lpiq+O5rGXnJ8doHEAZuoR3C3LTOYKc0v0xK4v1Znk8
   1hl7ANjYVG8ljbq8lTwkZXMTqZf+96dZwFeCznE0JRl5/5uokoWHtx3Zl
   vGnKqkQKjb5U6wCiIvtTMOFdWTgll/lZqXgVz/nWt/afi2RxABKuixCwO
   GISpqXCWwY84QZOxQLXuM9znbu/owWcyL4q4w2nDhOrqDvzQ1wzJRb9m9
   ZWSbCB7dJhIyJAUeUBPScAxJXbaWU6L9bCkhO5fo73tVrLfXDvEta8Ekx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="301783214"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="301783214"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 21:40:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="748091389"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="748091389"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 23 Nov 2022 21:40:57 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oy4ym-0003Xx-0o;
        Thu, 24 Nov 2022 05:40:56 +0000
Date:   Thu, 24 Nov 2022 13:40:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/endpoint] BUILD SUCCESS
 5f697b25009ccfebede5e42c6693c4b18de11b37
Message-ID: <637f03c7.FU8DLeR/TqbzFpm8%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/endpoint
branch HEAD: 5f697b25009ccfebede5e42c6693c4b18de11b37  PCI: endpoint: pci-epf-vntb: Fix sparse ntb->reg build warning

elapsed time: 725m

configs tested: 91
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
um                             i386_defconfig
alpha                               defconfig
um                           x86_64_defconfig
s390                             allmodconfig
s390                                defconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
sh                               allmodconfig
s390                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                            allnoconfig
i386                             allyesconfig
i386                                defconfig
x86_64               randconfig-a011-20221121
x86_64               randconfig-a014-20221121
x86_64               randconfig-a012-20221121
x86_64               randconfig-a013-20221121
x86_64               randconfig-a016-20221121
x86_64               randconfig-a015-20221121
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
ia64                             allmodconfig
sparc                             allnoconfig
sh                            hp6xx_defconfig
sh                         ecovec24_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arm                            hisi_defconfig
csky                                defconfig
mips                     loongson1b_defconfig
arm                        clps711x_defconfig
xtensa                  audio_kc705_defconfig
mips                           gcw0_defconfig
xtensa                generic_kc705_defconfig
arm                      jornada720_defconfig
s390                 randconfig-r044-20221121
riscv                randconfig-r042-20221121
arc                  randconfig-r043-20221120
arc                  randconfig-r043-20221121
m68k                          hp300_defconfig
riscv                               defconfig
microblaze                          defconfig
sh                           se7780_defconfig
arc                        nsim_700_defconfig
sh                           se7722_defconfig
arc                     haps_hs_smp_defconfig
openrisc                       virt_defconfig
powerpc                    klondike_defconfig
arm                           viper_defconfig
i386                 randconfig-a014-20221121
i386                 randconfig-a011-20221121
i386                 randconfig-a013-20221121
i386                 randconfig-a016-20221121
i386                 randconfig-a012-20221121
i386                 randconfig-a015-20221121
i386                          randconfig-c001
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                         lpc18xx_defconfig
mips                         db1xxx_defconfig
arm                         assabet_defconfig

clang tested configs:
x86_64               randconfig-a002-20221121
x86_64               randconfig-a001-20221121
x86_64               randconfig-a004-20221121
x86_64               randconfig-a006-20221121
x86_64               randconfig-a005-20221121
x86_64               randconfig-a003-20221121
x86_64                        randconfig-k001
i386                 randconfig-a001-20221121
i386                 randconfig-a005-20221121
i386                 randconfig-a006-20221121
i386                 randconfig-a004-20221121
i386                 randconfig-a003-20221121
i386                 randconfig-a002-20221121
mips                      malta_kvm_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
