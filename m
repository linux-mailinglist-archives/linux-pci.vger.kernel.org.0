Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3388C6268D8
	for <lists+linux-pci@lfdr.de>; Sat, 12 Nov 2022 11:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbiKLKXT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Nov 2022 05:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbiKLKXB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Nov 2022 05:23:01 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1EA4FF91
        for <linux-pci@vger.kernel.org>; Sat, 12 Nov 2022 02:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668248562; x=1699784562;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2Ts2eZ8YVojtnvOmvW+KmrLydB++OVDrQk2+opxrzcY=;
  b=nZbD7z8xazLiusx3F+FLsfA6l/e8qEUKqEKk6uQ09r9qX62RohF/eI+W
   3XYrY27+naZLq14GtNHLAhOKlWV3pt04vV4vHtpcgMIGj1sWXe0DgSWHo
   lRBVoa5RkW0uapzZSxq8uQGAddqWGuuaMmdn4QWY0LQ30nW836hAUBTDk
   fHdqhcsKAVDP7ZzsiiPvfRncUMq9d2jpR0tD5P3tKIDhe5LnL1qeUvHId
   YZF7UG+mDzqEhbF88Oy2NELrhUt5unttQp3f022r41ZtMlPn8eZI0aXcp
   6m1gp47w/cFVt6X6Vt7GJpdbbhdqfY6v+JrsVs3yIxjOvC9hPxmcSShbg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="299235632"
X-IronPort-AV: E=Sophos;i="5.96,159,1665471600"; 
   d="scan'208";a="299235632"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2022 02:22:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="743526050"
X-IronPort-AV: E=Sophos;i="5.96,159,1665471600"; 
   d="scan'208";a="743526050"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 12 Nov 2022 02:22:40 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1otneq-0004mZ-0x;
        Sat, 12 Nov 2022 10:22:40 +0000
Date:   Sat, 12 Nov 2022 18:21:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 7ef4a88327bb37d6ee710f4126975a65a60e9ac7
Message-ID: <636f73ba.FDUmOIXYh34ixYAE%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 7ef4a88327bb37d6ee710f4126975a65a60e9ac7  Merge branch 'pci/kbuild'

elapsed time: 723m

configs tested: 89
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
arc                                 defconfig
alpha                               defconfig
arm                                 defconfig
s390                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                             allmodconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a004
i386                                defconfig
x86_64                               rhel-8.3
s390                             allyesconfig
x86_64                        randconfig-a013
x86_64                              defconfig
powerpc                          allmodconfig
arm64                            allyesconfig
x86_64                        randconfig-a011
i386                          randconfig-a014
mips                             allyesconfig
arc                  randconfig-r043-20221111
powerpc                           allnoconfig
arm                              allyesconfig
i386                          randconfig-a001
sh                               allmodconfig
riscv                randconfig-r042-20221111
x86_64                        randconfig-a015
s390                 randconfig-r044-20221111
i386                          randconfig-a012
i386                          randconfig-a003
i386                          randconfig-a016
i386                          randconfig-a005
m68k                             allyesconfig
x86_64                           allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                             allyesconfig
ia64                             allmodconfig
x86_64                            allnoconfig
i386                          randconfig-c001
powerpc                      ppc40x_defconfig
arm                        mvebu_v7_defconfig
powerpc                     tqm8541_defconfig
sh                            hp6xx_defconfig
arc                          axs103_defconfig
powerpc                     asp8347_defconfig
arm                         axm55xx_defconfig
parisc                           alldefconfig
parisc64                            defconfig
openrisc                            defconfig
openrisc                  or1klitex_defconfig
m68k                          hp300_defconfig
arm                         at91_dt_defconfig
m68k                       m5275evb_defconfig
powerpc                 linkstation_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a014
i386                          randconfig-a013
hexagon              randconfig-r041-20221111
x86_64                        randconfig-a016
i386                          randconfig-a011
x86_64                        randconfig-a012
hexagon              randconfig-r045-20221111
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-k001
arm                           omap1_defconfig
arm                     am200epdkit_defconfig
powerpc                 mpc8272_ads_defconfig
mips                           ip27_defconfig
riscv                            alldefconfig
powerpc                      ppc44x_defconfig
mips                           rs90_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
