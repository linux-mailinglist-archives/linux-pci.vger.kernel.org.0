Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8CE4D73EB
	for <lists+linux-pci@lfdr.de>; Sun, 13 Mar 2022 10:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbiCMJRF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Mar 2022 05:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbiCMJRE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Mar 2022 05:17:04 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616886005B
        for <linux-pci@vger.kernel.org>; Sun, 13 Mar 2022 01:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647162956; x=1678698956;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=TxHCRookVYy5NtdCdmvvZjPXrdpMyVB1FG34d2DOg0I=;
  b=BurkYdI47nD6M+/bwVgn4N51h7roLIcgT/wHnNaFE+vpHu4smEPTmmeQ
   Np+orEHwxz8SEBPiDFdwMZlNacAUouZ7IFvOb4SWhxDEyRnAjd+zt/1Jq
   4whOZgUSqcYtoVAyumVuy7umgxPosFiaZ77vpCwdde18QB4BLHASAPqPQ
   kazcENf1rYKiD+8i1nxR91dN4Dxy6DP/axQYo1MNeTUEsZ8mb69Xh1s9z
   7Ty74H6THBa94WgqGuKUSesaUrXwchkyCt+nchLa3CPQuDswkhhHQYdEB
   W6fVMbEIn3h853TU2swO9WX+TX4qnrHHPCk22ITDPgCcQb9OEPoyuJwWy
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="256040341"
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="256040341"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 01:15:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="515056110"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 13 Mar 2022 01:15:54 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTKKP-0008nV-LB; Sun, 13 Mar 2022 09:15:53 +0000
Date:   Sun, 13 Mar 2022 17:15:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/misc] BUILD SUCCESS
 721af1346bbdc5b35ea73bbb12ba46c821f95155
Message-ID: <622db647.18rB7KkfALcI2k+D%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/misc
branch HEAD: 721af1346bbdc5b35ea73bbb12ba46c821f95155  PCI: Declare pci_filp_private only when HAVE_PCI_MMAP

elapsed time: 722m

configs tested: 123
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                 randconfig-c004-20220313
i386                          randconfig-c001
nios2                               defconfig
sh                          polaris_defconfig
sh                         microdev_defconfig
powerpc                     tqm8555_defconfig
powerpc                         wii_defconfig
parisc                generic-32bit_defconfig
sh                           sh2007_defconfig
openrisc                 simple_smp_defconfig
mips                        vocore2_defconfig
arc                        vdk_hs38_defconfig
m68k                          atari_defconfig
arc                            hsdk_defconfig
sh                        sh7785lcr_defconfig
xtensa                  cadence_csp_defconfig
sh                   sh7724_generic_defconfig
m68k                       bvme6000_defconfig
s390                             allmodconfig
powerpc                 mpc837x_rdb_defconfig
mips                       capcella_defconfig
ia64                            zx1_defconfig
arm                            mps2_defconfig
mips                  maltasmvp_eva_defconfig
sh                          sdk7780_defconfig
arm                        oxnas_v6_defconfig
mips                             allyesconfig
powerpc                     taishan_defconfig
arm                       multi_v4t_defconfig
ia64                             allmodconfig
arm                           corgi_defconfig
mips                     loongson1b_defconfig
m68k                           sun3_defconfig
s390                                defconfig
h8300                     edosk2674_defconfig
arm                      footbridge_defconfig
parisc64                            defconfig
arm                          lpd270_defconfig
m68k                          hp300_defconfig
nios2                            alldefconfig
sh                          rsk7269_defconfig
sh                          r7785rp_defconfig
mips                         tb0226_defconfig
powerpc                        cell_defconfig
arm                  randconfig-c002-20220313
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arc                  randconfig-r043-20220313
riscv                randconfig-r042-20220313
s390                 randconfig-r044-20220313
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
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220313
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220313
riscv                randconfig-c006-20220313
mips                 randconfig-c004-20220313
i386                          randconfig-c001
arm                        mvebu_v5_defconfig
mips                       rbtx49xx_defconfig
powerpc                     kmeter1_defconfig
arm                        spear3xx_defconfig
arm                       aspeed_g4_defconfig
riscv                             allnoconfig
powerpc               mpc834x_itxgp_defconfig
arm                          pcm027_defconfig
arm                           spitz_defconfig
powerpc                      pmac32_defconfig
mips                           ip28_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
