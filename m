Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CC9559759
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 12:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiFXKG5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 06:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiFXKG4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 06:06:56 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B527A6D6
        for <linux-pci@vger.kernel.org>; Fri, 24 Jun 2022 03:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656065215; x=1687601215;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=1kOZ/w+nU/2YRgZoTCJAp2zyzcBo2cUPIO7aPTgSlCg=;
  b=WepqScRkNryFSPzUhK7ioo/IHHsgFjVt4XwMuvMTFZxB56SzlPC8eTwj
   6h6SdAjlAgrtBu6I3K7d/OsxnNMP/QmhrY+nD9eCCddFQIz8Eu3e5dIUl
   mx7DD9IkhCVo6iX6lXyybWZocZjhdulNO+UcFisphvIAe+nMHjMgMaXzC
   DwPM8cTWOdo+b0aT7IJra2b/uazlPkLe8ThAihL/bWctM+DeOtUcAQOum
   EvlOn0wOueDgmQGpNC0sP7zdwcZLDmuxUYhPoFA5Es9TRVAjc1K6vDXQW
   Hy5SPs7hPQkKC9GjjWJWEyL8F1ejeUJuxJXTQjlYwI+He4Bzl8NLp2Bnx
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="342657680"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="342657680"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 03:06:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="539236919"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 Jun 2022 03:06:53 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4gDE-0003yL-Pb;
        Fri, 24 Jun 2022 10:06:52 +0000
Date:   Fri, 24 Jun 2022 18:06:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/ctrl/mediatek] BUILD SUCCESS
 b3b76fc86f0fb4d98918f48c784138bfa950dff6
Message-ID: <62b58cb7.DOx9HOWypFYI/d0W%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ctrl/mediatek
branch HEAD: b3b76fc86f0fb4d98918f48c784138bfa950dff6  PCI: mediatek: Allow building for ARCH_AIROHA

elapsed time: 724m

configs tested: 91
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220622
arm                         lubbock_defconfig
arm                      jornada720_defconfig
sh                  sh7785lcr_32bit_defconfig
ia64                      gensparse_defconfig
arm                           corgi_defconfig
nios2                         3c120_defconfig
sh                        sh7757lcr_defconfig
arm                             pxa_defconfig
arm                         s3c6400_defconfig
m68k                        m5272c3_defconfig
arm                        realview_defconfig
arm                        keystone_defconfig
microblaze                          defconfig
arm                          iop32x_defconfig
m68k                            q40_defconfig
powerpc                      chrp32_defconfig
alpha                               defconfig
sh                         ecovec24_defconfig
arm                           viper_defconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
arc                  randconfig-r043-20220622
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                                 defconfig
powerpc                 mpc8560_ads_defconfig
arm                           omap1_defconfig
powerpc                     mpc5200_defconfig
hexagon                             defconfig
powerpc                 mpc836x_mds_defconfig
mips                     loongson2k_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                       ebony_defconfig
powerpc                     pseries_defconfig
x86_64                        randconfig-k001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
hexagon              randconfig-r041-20220622
hexagon              randconfig-r041-20220623
s390                 randconfig-r044-20220622
hexagon              randconfig-r045-20220622
hexagon              randconfig-r045-20220623
riscv                randconfig-r042-20220622
hexagon              randconfig-r041-20220624
s390                 randconfig-r044-20220624
hexagon              randconfig-r045-20220624
riscv                randconfig-r042-20220624

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
