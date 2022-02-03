Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B484A8022
	for <lists+linux-pci@lfdr.de>; Thu,  3 Feb 2022 09:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242436AbiBCILC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 03:11:02 -0500
Received: from mga09.intel.com ([134.134.136.24]:6017 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231836AbiBCIK7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Feb 2022 03:10:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643875859; x=1675411859;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=emm0Ltb7hok8stFdjeq5Tbpo6dro7Lo6sByyptqthuY=;
  b=YHQG6aoQy6TdeLiYZmPOQsNj69Y7AfBi03M7gEu5gZ+Fq7KaOuP9zoCW
   T1T+nMMm0LKMSaVIMkolPI9FRpCu+odIhDZOu4y92G4HBMWEJblBO2wbO
   YOqNpb11Cm+11x1DBrQg0GWvChtsp2RIkYglDpypUZvF7N2uxt/JyYWq/
   1kMqmwO5x6sERGr4ryWSIRDRwlBubqTN81qi49UyVpCbdz2idFW32Cudw
   X0lUv2b8aiDFwTxzYYH636lBcO+kejVuRwzYPlp0yyaNzL6rGq3wqOqKt
   r9jg7brGyAVCDzr/YLWvcGwWEhobSxAdGVSnztpOaGCEVXepfbgQjuH/h
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="247861700"
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="247861700"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 00:10:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="498058719"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 03 Feb 2022 00:10:57 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFXCi-000Vpu-Er; Thu, 03 Feb 2022 08:10:56 +0000
Date:   Thu, 03 Feb 2022 16:10:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:for-linus] BUILD SUCCESS
 71c96af28da5b7f549333ba469cc032fb677fa0e
Message-ID: <61fb8df8.qERcEgUGyMmCf++W%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
branch HEAD: 71c96af28da5b7f549333ba469cc032fb677fa0e  PCI: kirin: Add dev struct for of_device_get_match_data()

elapsed time: 728m

configs tested: 136
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220131
i386                          randconfig-c001
powerpc                     redwood_defconfig
arm                       aspeed_g5_defconfig
sh                          r7780mp_defconfig
m68k                        stmark2_defconfig
arm                        multi_v7_defconfig
openrisc                  or1klitex_defconfig
parisc                generic-32bit_defconfig
arm                           viper_defconfig
mips                        vocore2_defconfig
s390                       zfcpdump_defconfig
h8300                       h8s-sim_defconfig
powerpc                      pcm030_defconfig
parisc                generic-64bit_defconfig
sh                           se7721_defconfig
mips                           gcw0_defconfig
mips                           jazz_defconfig
mips                          rb532_defconfig
xtensa                       common_defconfig
s390                          debug_defconfig
microblaze                          defconfig
mips                           ci20_defconfig
arm                           corgi_defconfig
sh                          r7785rp_defconfig
ia64                          tiger_defconfig
m68k                          sun3x_defconfig
microblaze                      mmu_defconfig
powerpc                    amigaone_defconfig
arm                          pxa910_defconfig
arm                  randconfig-c002-20220130
arm                  randconfig-c002-20220131
arm                  randconfig-c002-20220202
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
alpha                               defconfig
alpha                            allyesconfig
csky                                defconfig
nds32                               defconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20220131
x86_64               randconfig-a003-20220131
x86_64               randconfig-a001-20220131
x86_64               randconfig-a006-20220131
x86_64               randconfig-a005-20220131
x86_64               randconfig-a002-20220131
i386                 randconfig-a006-20220131
i386                 randconfig-a005-20220131
i386                 randconfig-a003-20220131
i386                 randconfig-a002-20220131
i386                 randconfig-a001-20220131
i386                 randconfig-a004-20220131
riscv                randconfig-r042-20220130
arc                  randconfig-r043-20220130
arc                  randconfig-r043-20220131
s390                 randconfig-r044-20220130
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20220130
x86_64                        randconfig-c007
arm                  randconfig-c002-20220130
powerpc              randconfig-c003-20220130
mips                 randconfig-c004-20220130
i386                          randconfig-c001
arm                         hackkit_defconfig
arm                           spitz_defconfig
mips                  cavium_octeon_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                          imote2_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                         shannon_defconfig
powerpc                        icon_defconfig
x86_64               randconfig-a013-20220131
x86_64               randconfig-a015-20220131
x86_64               randconfig-a014-20220131
x86_64               randconfig-a016-20220131
x86_64               randconfig-a011-20220131
x86_64               randconfig-a012-20220131
i386                 randconfig-a011-20220131
i386                 randconfig-a013-20220131
i386                 randconfig-a014-20220131
i386                 randconfig-a012-20220131
i386                 randconfig-a015-20220131
i386                 randconfig-a016-20220131
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
riscv                randconfig-r042-20220131
hexagon              randconfig-r045-20220131
hexagon              randconfig-r045-20220130
hexagon              randconfig-r041-20220130
hexagon              randconfig-r041-20220131
s390                 randconfig-r044-20220131

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
