Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34171634AB5
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 00:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbiKVXJn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Nov 2022 18:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbiKVXJl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2022 18:09:41 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD72B7017
        for <linux-pci@vger.kernel.org>; Tue, 22 Nov 2022 15:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669158580; x=1700694580;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=5P1rZ5TAJO23wI0+bH/hztqZ9R8/r2E27AV5AjvkL+0=;
  b=kHItlsTufW+2RLbw/mPAtMPSDfkUDhBvRlExYtHi+2oDFha1ZRU5QYnr
   XmvHY0nLmNw723TdsP0aiVna8LBJnmF/bSh3HtJCQt9jzyYRPEyc62Hs/
   dOaWi08Yp+2bOoQhQ05zmWSSg6Y2kJ7b47EF+f3pKh0NdZ32zSkRJBySH
   Tiej52i7+bXWOiWNDSAYJjUNRu6kWxE967BihnieKfQ+yKV3YqOqSoOgq
   2OzkV98TNaU4vT/LIYOjo78mjnhbo+vTua7ujEwAyxscLHXa5U5q+5Nv+
   5lXb8jndLjKgcMoln3opifAMtDTfSytPydpULH52SKTb31J488Mpo/bfi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="313966817"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="313966817"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 15:09:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="784010017"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="784010017"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Nov 2022 15:09:38 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oxcOX-0001yR-1D;
        Tue, 22 Nov 2022 23:09:37 +0000
Date:   Wed, 23 Nov 2022 07:09:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/enumeration] BUILD SUCCESS
 2d9cd957d40c3ac491b358e7cff0515bb07a3a9c
Message-ID: <637d56af.hJWqx/Z0WTOEZkCc%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/enumeration
branch HEAD: 2d9cd957d40c3ac491b358e7cff0515bb07a3a9c  PCI: Check for alloc failure in pci_request_irq()

elapsed time: 1445m

configs tested: 143
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
ia64                             allmodconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                            allnoconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                             allyesconfig
i386                                defconfig
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
mips                           jazz_defconfig
powerpc                      ep88xc_defconfig
m68k                       m5249evb_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                           sama5_defconfig
i386                 randconfig-a014-20221121
i386                 randconfig-a011-20221121
i386                 randconfig-a013-20221121
i386                 randconfig-a016-20221121
i386                 randconfig-a012-20221121
i386                 randconfig-a015-20221121
arm                                 defconfig
s390                 randconfig-r044-20221121
riscv                randconfig-r042-20221121
arc                  randconfig-r043-20221120
arc                  randconfig-r043-20221121
x86_64               randconfig-a011-20221121
x86_64               randconfig-a014-20221121
x86_64               randconfig-a012-20221121
x86_64               randconfig-a013-20221121
x86_64               randconfig-a016-20221121
x86_64               randconfig-a015-20221121
sparc                       sparc32_defconfig
powerpc                    sam440ep_defconfig
sparc                            alldefconfig
sh                           se7705_defconfig
m68k                        stmark2_defconfig
i386                          randconfig-c001
powerpc                 mpc8540_ads_defconfig
arm                      jornada720_defconfig
arc                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                      footbridge_defconfig
powerpc                       eiger_defconfig
arm                              allyesconfig
loongarch                           defconfig
loongarch                         allnoconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arc                           tb10x_defconfig
mips                          rb532_defconfig
m68k                        m5272c3_defconfig
arm                         nhk8815_defconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
sparc                               defconfig
csky                                defconfig
x86_64                                  kexec
x86_64                        randconfig-c001
arm                  randconfig-c002-20221120
arm                        trizeps4_defconfig
m68k                       m5275evb_defconfig
arc                          axs103_defconfig
sh                              ul2_defconfig
sh                           se7780_defconfig
sh                          sdk7780_defconfig
arm                          simpad_defconfig
powerpc                  iss476-smp_defconfig
sh                             espt_defconfig
m68k                       m5208evb_defconfig
arm                          gemini_defconfig
arm                            pleb_defconfig
parisc                generic-64bit_defconfig
sh                     sh7710voipgw_defconfig
powerpc                      pcm030_defconfig
powerpc                mpc7448_hpc2_defconfig
arc                         haps_hs_defconfig
arc                      axs103_smp_defconfig

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
powerpc                    mvme5100_defconfig
arm                         bcm2835_defconfig
arm                         lpc32xx_defconfig
i386                 randconfig-a001-20221121
i386                 randconfig-a005-20221121
i386                 randconfig-a006-20221121
i386                 randconfig-a004-20221121
i386                 randconfig-a003-20221121
i386                 randconfig-a002-20221121
x86_64                        randconfig-k001
x86_64               randconfig-a002-20221121
x86_64               randconfig-a001-20221121
x86_64               randconfig-a004-20221121
x86_64               randconfig-a006-20221121
x86_64               randconfig-a005-20221121
x86_64               randconfig-a003-20221121
powerpc                    gamecube_defconfig
powerpc                  mpc866_ads_defconfig
arm                        neponset_defconfig
powerpc                     ksi8560_defconfig
arm                     am200epdkit_defconfig
hexagon                             defconfig
arm                                 defconfig
s390                 randconfig-r044-20221120
hexagon              randconfig-r041-20221120
hexagon              randconfig-r041-20221121
riscv                randconfig-r042-20221120
hexagon              randconfig-r045-20221120
hexagon              randconfig-r045-20221121
powerpc                   bluestone_defconfig
arm                          moxart_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
