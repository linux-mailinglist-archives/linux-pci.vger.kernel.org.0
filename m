Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589FA4BCD05
	for <lists+linux-pci@lfdr.de>; Sun, 20 Feb 2022 08:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbiBTHQ6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Feb 2022 02:16:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiBTHQ5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Feb 2022 02:16:57 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101D52BF
        for <linux-pci@vger.kernel.org>; Sat, 19 Feb 2022 23:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645341396; x=1676877396;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Mc5XdqYpxnDBjbuMFuBhLUU1YtAHwgPhIlwRuDFAfI4=;
  b=RNXLLnZ1AUEvdmo83j5oH2WwVCxMfzVA6vgVyLGRDZl2/tQj5HrFejXj
   gD4oLYQW5iwGn7B7Ty5yKKDzSl7mU1yqJBcXW6UVPLj1UB0u/EstksH1j
   LWFbpbzwwYIhSqAd8GyL3mf87zm41BYLmBInCPRfNLyzsSpf8LQY9/rwo
   duPuE9tlGBYztHZyX34OzrLH0zEMycLX1Q/0MLvV4Xe1BsYg9/hunGDIJ
   OOdhhIkUHxKYu19Z23KREkjhO1zgCUJXaIf+km6LNy3w3s5ALQg5u5KEU
   UzfbG4WLR0Z5tGQtsFQskMXRF/WAOxObuW3AR+g63bXgODDghgPq1mOPG
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10263"; a="312091969"
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="312091969"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2022 23:16:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="605934200"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 19 Feb 2022 23:16:34 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLgSP-00003a-JU; Sun, 20 Feb 2022 07:16:33 +0000
Date:   Sun, 20 Feb 2022 15:16:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 f72ca2da14cf8c8b517b70663993add21f11ea70
Message-ID: <6211eabe.GXCqMMZ3Be7mum7M%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: f72ca2da14cf8c8b517b70663993add21f11ea70  Merge branch 'remotes/lorenzo/pci/uniphier'

elapsed time: 3505m

configs tested: 96
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
powerpc                       maple_defconfig
arc                                 defconfig
sh                         microdev_defconfig
mips                  decstation_64_defconfig
parisc                generic-32bit_defconfig
m68k                            mac_defconfig
ia64                         bigsur_defconfig
powerpc                        cell_defconfig
arc                          axs101_defconfig
arc                        vdk_hs38_defconfig
arc                    vdk_hs38_smp_defconfig
xtensa                generic_kc705_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                       eiger_defconfig
h8300                               defconfig
microblaze                      mmu_defconfig
powerpc                      pasemi_defconfig
arm                           h5000_defconfig
arm                  randconfig-c002-20220217
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
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
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
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
arm                      tct_hammer_defconfig
riscv                            alldefconfig
powerpc                     tqm5200_defconfig
arm                        magician_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220217
hexagon              randconfig-r041-20220217
riscv                randconfig-r042-20220217

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
