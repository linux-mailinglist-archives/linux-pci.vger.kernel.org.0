Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E2C61049D
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 23:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbiJ0Vky (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 17:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235922AbiJ0Vky (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 17:40:54 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE6C7A531
        for <linux-pci@vger.kernel.org>; Thu, 27 Oct 2022 14:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666906853; x=1698442853;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dRNay84As9yLANjpHsUbwodOV7B5itEmkDHnCCnDRaA=;
  b=L6BKsGcOjXpC2jJyeQjmCBPWpHWpV1h65e5aZjP56WYV1n+PiVW+7S5b
   uBiEsu0in3AMb/tEQiZ+Sq1w5hEfK5N1rqgsfcvN1DndSSQduw8qkhWTB
   FNl6jfVv2lSZbDNTJBNmffXsoBC2QubdHwUkPS7pVQRTDTDuvf/2Af0KX
   B3xdvOLhMmsdnRGYIlzYONprCyLYSygH0rnc8lE93gPAhT4rhYy3Y6kS/
   bHFCtcbAodTGvzq0FN9jq36nsv/3lU6Z+7NHmca8vd3MZO4cE/4Fe50x8
   syNqmZ7aAxlKkMioKl0BG8JgzooQ9A7R8T23LRztxsOJcWcLOltPeMM/V
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="308339669"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="308339669"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 14:40:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="583706967"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="583706967"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 27 Oct 2022 14:40:51 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ooAcN-0009CP-0p;
        Thu, 27 Oct 2022 21:40:51 +0000
Date:   Fri, 28 Oct 2022 05:40:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/dt] BUILD SUCCESS
 598418e6035622c0dc735764f0f1b7293c0c7d48
Message-ID: <635afadb.QFS4L0BYVZBmYy89%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/dt
branch HEAD: 598418e6035622c0dc735764f0f1b7293c0c7d48  dt-bindings: PCI: ti,j721e-pci-*: Add missing interrupt properties

elapsed time: 720m

configs tested: 104
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
powerpc                          allmodconfig
i386                                defconfig
s390                             allmodconfig
alpha                               defconfig
mips                             allyesconfig
s390                                defconfig
um                             i386_defconfig
arc                  randconfig-r043-20221027
powerpc                           allnoconfig
s390                             allyesconfig
sh                               allmodconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arm                                 defconfig
arc                              allyesconfig
x86_64                        randconfig-a002
alpha                            allyesconfig
x86_64                              defconfig
arm64                            allyesconfig
x86_64                        randconfig-a006
m68k                             allmodconfig
arm                              allyesconfig
x86_64                        randconfig-a004
x86_64                           rhel-8.3-kvm
m68k                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                               rhel-8.3
x86_64                        randconfig-a013
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a011
x86_64                           allyesconfig
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a001
i386                          randconfig-a003
i386                             allyesconfig
ia64                             allmodconfig
i386                          randconfig-a005
powerpc                    amigaone_defconfig
sh                           se7724_defconfig
sh                          rsk7201_defconfig
m68k                            q40_defconfig
arm                           imxrt_defconfig
arm                         assabet_defconfig
arm                          gemini_defconfig
sparc                             allnoconfig
m68k                        m5272c3_defconfig
xtensa                    smp_lx200_defconfig
arm                            hisi_defconfig
alpha                            alldefconfig
powerpc                 mpc834x_mds_defconfig
sparc                               defconfig
arc                              alldefconfig
arm                            pleb_defconfig
mips                      maltasmvp_defconfig
m68k                       m5208evb_defconfig
riscv                               defconfig
sh                        dreamcast_defconfig
powerpc                 canyonlands_defconfig
arc                  randconfig-r043-20221026
s390                 randconfig-r044-20221026
riscv                randconfig-r042-20221026
i386                          randconfig-c001
mips                 randconfig-c004-20221026
m68k                         amcore_defconfig
m68k                           sun3_defconfig
microblaze                      mmu_defconfig
mips                         bigsur_defconfig
sh                             shx3_defconfig
openrisc                  or1klitex_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
hexagon              randconfig-r041-20221027
hexagon              randconfig-r045-20221027
s390                 randconfig-r044-20221027
riscv                randconfig-r042-20221027
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r041-20221026
hexagon              randconfig-r045-20221026
powerpc                      pmac32_defconfig
mips                      bmips_stb_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
