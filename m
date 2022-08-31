Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632115A752A
	for <lists+linux-pci@lfdr.de>; Wed, 31 Aug 2022 06:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiHaEa5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Aug 2022 00:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiHaEa4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Aug 2022 00:30:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA8658507
        for <linux-pci@vger.kernel.org>; Tue, 30 Aug 2022 21:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661920254; x=1693456254;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=3dcbtFriN7DT//om1onoYgP8Z6FGQ79qlejuOzF5J3g=;
  b=PWcdHt0uHQjm3oKGBv6CDFY/QLZmPgaMOZ67TyHodPnlUDBeQ8logrIa
   CzkVna0X63GAvS3jyMT6CuYcUUDpHutK2F6bcwFOlOAE0JNGWUE1U+xRl
   1DTVQIZFngTzt0Ouq6JdblpQvwzHn4Fgbux6LE61dLpZ936b80sYG9met
   Pc0yWN06gZ9aavAUBmmFO2NrUYgm/Urmifc/MURYdb8hw8fBrtX3XFlcv
   bWI1hQx8Hq8IB2ggHFtWmvMHYn1YkklvF3Xo8aCbxMJ6r7s9XORZJRAKY
   R1Cly7hBLhE/VtpzEwktQTGxt93sexBl1q8jhyGuCjmj+D3Fd+1ItSvo8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="278386486"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="278386486"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 21:30:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="562911139"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 30 Aug 2022 21:30:53 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTFNM-0000zm-14;
        Wed, 31 Aug 2022 04:30:52 +0000
Date:   Wed, 31 Aug 2022 12:30:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 68fca83a3783b9a6316616bf753febd1fb366d22
Message-ID: <630ee3dc.M4ZQb2Rljs+ylkJH%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 68fca83a3783b9a6316616bf753febd1fb366d22  Merge branch 'remotes/lorenzo/pci/qcom'

elapsed time: 731m

configs tested: 115
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
arc                  randconfig-r043-20220830
um                           x86_64_defconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a004
x86_64                          rhel-8.3-func
x86_64                        randconfig-a002
m68k                             allmodconfig
x86_64                              defconfig
arc                              allyesconfig
x86_64                        randconfig-a006
x86_64                           allyesconfig
x86_64                               rhel-8.3
alpha                            allyesconfig
powerpc                           allnoconfig
x86_64                         rhel-8.3-kunit
powerpc                          allmodconfig
x86_64                        randconfig-a013
mips                             allyesconfig
x86_64                        randconfig-a011
x86_64                           rhel-8.3-kvm
i386                                defconfig
x86_64                           rhel-8.3-syz
m68k                             allyesconfig
x86_64                        randconfig-a015
sh                               allmodconfig
arm                                 defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arm64                            allyesconfig
i386                             allyesconfig
arm                              allyesconfig
sparc                             allnoconfig
sh                           se7721_defconfig
sh                        edosk7760_defconfig
m68k                            mac_defconfig
arm                     eseries_pxa_defconfig
powerpc                 mpc8540_ads_defconfig
xtensa                    smp_lx200_defconfig
arm                          lpd270_defconfig
openrisc                         alldefconfig
loongarch                           defconfig
loongarch                         allnoconfig
ia64                             allmodconfig
xtensa                  cadence_csp_defconfig
x86_64                           alldefconfig
arm                         nhk8815_defconfig
arm                      integrator_defconfig
sh                          kfr2r09_defconfig
arm                         cm_x300_defconfig
nios2                            alldefconfig
openrisc                  or1klitex_defconfig
i386                          randconfig-c001
sparc                               defconfig
mips                      loongson3_defconfig
m68k                       m5475evb_defconfig
xtensa                  nommu_kc705_defconfig
mips                       bmips_be_defconfig
arc                        nsim_700_defconfig
microblaze                      mmu_defconfig
arm                        realview_defconfig
ia64                      gensparse_defconfig
arm                       imx_v6_v7_defconfig
mips                           jazz_defconfig
powerpc                     stx_gp3_defconfig
powerpc                     asp8347_defconfig
sh                           se7619_defconfig
sh                             sh03_defconfig
sh                              ul2_defconfig
xtensa                           alldefconfig
m68k                          sun3x_defconfig
sh                             espt_defconfig
sh                         apsh4a3a_defconfig
arm64                            alldefconfig
mips                        bcm47xx_defconfig
powerpc                       eiger_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                         s3c6400_defconfig
powerpc                     sequoia_defconfig
sh                          rsk7203_defconfig
arc                        vdk_hs38_defconfig
arm                           u8500_defconfig
arm                           tegra_defconfig
arm                          badge4_defconfig

clang tested configs:
hexagon              randconfig-r045-20220830
hexagon              randconfig-r041-20220830
riscv                randconfig-r042-20220830
s390                 randconfig-r044-20220830
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a013
x86_64                        randconfig-a014
i386                          randconfig-a015
i386                          randconfig-a011
x86_64                        randconfig-k001
arm                         s5pv210_defconfig
powerpc                     tqm8560_defconfig
mips                     loongson2k_defconfig
arm                      tct_hammer_defconfig
powerpc                      ppc64e_defconfig
arm                             mxs_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
