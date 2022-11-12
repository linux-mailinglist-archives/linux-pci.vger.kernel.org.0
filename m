Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9853C62697F
	for <lists+linux-pci@lfdr.de>; Sat, 12 Nov 2022 13:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbiKLMrs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Nov 2022 07:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiKLMrr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Nov 2022 07:47:47 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79EB19C07
        for <linux-pci@vger.kernel.org>; Sat, 12 Nov 2022 04:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668257266; x=1699793266;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=pyf4CRRnFiALDs/dGFVnyM4WvVidL/3EhejFG5IEQVM=;
  b=hUMeO6sNZWZudyBHKPhoU3WRaXzxKH43q9UFOsKeu1OKNx2+qACs3G5X
   pwF7DF8hxdfpBM3xtk6h2+MqUa47zU3XRMtxblDmxo4kUg6Qk70atpP8F
   vGyeTKsfTHrXT3hvY0CI/bGU8GdtMY44zkFv0UgyxH0oBcWgcvCJvA509
   aZaOWn6563X0/B/wwlsYs7Isn5eiKqY4RWrshRC0rw7QSaWqiv1/g1yr2
   GFt3/pc1Zr6fLk5ECoZz0ZrnH4/MzmmNrn7vVRgztvnPkPJ8y7QP8Ogxt
   +FsfbvYkfz/qNE0knCx0Ud9yN93mbJ72uwqSX5K2fVvdM+Fj9mFpTCQEt
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="398020213"
X-IronPort-AV: E=Sophos;i="5.96,159,1665471600"; 
   d="scan'208";a="398020213"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2022 04:47:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="727028701"
X-IronPort-AV: E=Sophos;i="5.96,159,1665471600"; 
   d="scan'208";a="727028701"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Nov 2022 04:47:45 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1otpvE-0004vF-36;
        Sat, 12 Nov 2022 12:47:44 +0000
Date:   Sat, 12 Nov 2022 20:47:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/enumeration] BUILD SUCCESS
 98b04dd0b4577894520493d96bc4623387767445
Message-ID: <636f95e6.eQOnnI7SD956HU5s%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/enumeration
branch HEAD: 98b04dd0b4577894520493d96bc4623387767445  PCI: Fix pci_device_is_present() for VFs by checking PF

elapsed time: 721m

configs tested: 88
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                        randconfig-a004
arc                                 defconfig
x86_64                        randconfig-a002
arm                                 defconfig
powerpc                           allnoconfig
alpha                               defconfig
x86_64                        randconfig-a006
i386                                defconfig
powerpc                          allmodconfig
arc                  randconfig-r043-20221111
x86_64                              defconfig
mips                             allyesconfig
riscv                randconfig-r042-20221111
sh                               allmodconfig
s390                 randconfig-r044-20221111
m68k                             allyesconfig
arm                              allyesconfig
x86_64                          rhel-8.3-func
alpha                            allyesconfig
x86_64                    rhel-8.3-kselftests
arm64                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
ia64                             allmodconfig
x86_64                               rhel-8.3
s390                                defconfig
s390                             allmodconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                             allyesconfig
i386                          randconfig-a016
x86_64                           allyesconfig
s390                             allyesconfig
x86_64                            allnoconfig
arm                         axm55xx_defconfig
parisc                           alldefconfig
parisc64                            defconfig
openrisc                            defconfig
openrisc                  or1klitex_defconfig
m68k                          hp300_defconfig
arm                         at91_dt_defconfig
m68k                       m5275evb_defconfig
powerpc                 linkstation_defconfig
i386                          randconfig-c001
arm                      footbridge_defconfig
sh                        apsh4ad0a_defconfig
sh                   rts7751r2dplus_defconfig
sh                        sh7757lcr_defconfig
mips                      fuloong2e_defconfig
mips                            gpr_defconfig
arm                       imx_v6_v7_defconfig
mips                 decstation_r4k_defconfig
arm                        oxnas_v6_defconfig
m68k                       m5208evb_defconfig
mips                           jazz_defconfig
mips                      loongson3_defconfig
powerpc                      cm5200_defconfig

clang tested configs:
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a005
i386                          randconfig-a006
x86_64                        randconfig-a001
hexagon              randconfig-r041-20221111
x86_64                        randconfig-a003
hexagon              randconfig-r045-20221111
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-k001
mips                        qi_lb60_defconfig
mips                  cavium_octeon_defconfig
powerpc                     skiroot_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                  mpc885_ads_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
