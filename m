Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C77568650
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 13:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiGFLDB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jul 2022 07:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiGFLDA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2022 07:03:00 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE80A14092
        for <linux-pci@vger.kernel.org>; Wed,  6 Jul 2022 04:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657105379; x=1688641379;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=YKZZ7eiQriYVKowcbhHDDlYHNmgZxopUD19vsrapCpw=;
  b=cEIHOqNUtxqskdaxL9a3+diZaKJdPlW3zAXcFmXoaSOqp6OzFWZySgIX
   xIge0nhlyDV7t2MZL2pnh4TjIOs57UMlx0xBMzIFPxf8DiHAwlhXU55ZP
   HEsLqFFMmrFaAuORa/k3uxdx2F4VFSLVeMqhPkzWsElATBP46CQe2CDwW
   6VrgHF2zi4V0thULTAnDVkAtenpmLULOnCgzt3iM3/ZIQkZCkKotZZwsC
   J6mefG/kdgH3DiUKKRv+VN0WU+By1++7XF2e1pC0A/53cTCRyvAR/3jhO
   eHg79H3XN8QF9UzE/ZD/kx3JHEFn9+SoM8u5l+YXgCzCyKFUxvvkdBcBR
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="282468122"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="282468122"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 04:02:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="650616386"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jul 2022 04:02:58 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o92o5-000KUN-VZ;
        Wed, 06 Jul 2022 11:02:57 +0000
Date:   Wed, 06 Jul 2022 19:02:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/ctrl/iproc] BUILD SUCCESS
 52664090101a881ee67eb23e24859d45fce34dc8
Message-ID: <62c56bac.ESkQYY63pPb2/+CW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ctrl/iproc
branch HEAD: 52664090101a881ee67eb23e24859d45fce34dc8  PCI: iproc: Use bitmap API to allocate bitmaps

elapsed time: 818m

configs tested: 122
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
xtensa                  audio_kc705_defconfig
sh                            shmin_defconfig
sh                            migor_defconfig
arc                         haps_hs_defconfig
sh                               j2_defconfig
arm                         lubbock_defconfig
m68k                          multi_defconfig
arc                     haps_hs_smp_defconfig
powerpc                        warp_defconfig
mips                         bigsur_defconfig
sh                            titan_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                     pq2fads_defconfig
sh                         ecovec24_defconfig
sh                           se7206_defconfig
x86_64                           alldefconfig
openrisc                            defconfig
sh                        sh7785lcr_defconfig
arm                           h3600_defconfig
alpha                            allyesconfig
m68k                        stmark2_defconfig
mips                       bmips_be_defconfig
m68k                        m5407c3_defconfig
sparc                       sparc64_defconfig
m68k                        mvme147_defconfig
sh                          polaris_defconfig
arm                         assabet_defconfig
arm                       multi_v4t_defconfig
arm                           sunxi_defconfig
parisc                              defconfig
m68k                        mvme16x_defconfig
xtensa                    xip_kc705_defconfig
xtensa                         virt_defconfig
sh                              ul2_defconfig
sh                          r7785rp_defconfig
m68k                       m5475evb_defconfig
m68k                          amiga_defconfig
sh                        sh7757lcr_defconfig
mips                        bcm47xx_defconfig
arc                 nsimosci_hs_smp_defconfig
i386                                defconfig
riscv                               defconfig
arc                          axs101_defconfig
arm                          gemini_defconfig
openrisc                    or1ksim_defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
x86_64                        randconfig-c001
arm                  randconfig-c002-20220703
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220703
riscv                randconfig-r042-20220703
s390                 randconfig-r044-20220703
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                          ath79_defconfig
powerpc                     ksi8560_defconfig
powerpc                     kilauea_defconfig
arm                           sama7_defconfig
arm                         orion5x_defconfig
mips                          ath25_defconfig
powerpc                     powernv_defconfig
mips                     cu1000-neo_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64               randconfig-a013-20220704
x86_64               randconfig-a015-20220704
x86_64               randconfig-a011-20220704
x86_64               randconfig-a014-20220704
x86_64               randconfig-a016-20220704
x86_64               randconfig-a012-20220704
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220703
hexagon              randconfig-r045-20220703

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
