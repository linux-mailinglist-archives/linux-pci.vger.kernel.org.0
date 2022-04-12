Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459084FDE2D
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 13:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiDLLd2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 07:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352781AbiDLLb5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 07:31:57 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848AC70F5A
        for <linux-pci@vger.kernel.org>; Tue, 12 Apr 2022 03:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649758257; x=1681294257;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=zsYW65zf+Eitw6VDBcBmLYB1lDRxyP/MYX4nnL7hwDw=;
  b=BHlwPDaAsu84TjWCzHIGEFaTKv0adIPI1V4+BdUjyn4mJhCIzIyBaxMp
   Ncso9jHr20bzUedPaZTg9Lp+L+jNr4o/sLQOqNyKy182MHmo4yLDmxATv
   pGsKXetplP6lQB0ZvpGhbJKqFy5GszELuqaM+bAraKsrd5upwoMYyXq4Y
   eBgPmuazVaPhWeHsvEDG0DgKM99WRc51THw4Zwb1y4Dpst4WAOKwuv/Jx
   MBcRobb+dYHFpjpBGLqVSIxUlA2FQMIzdpkqhEv+DdB2NyanTPxJU7TLT
   T9zH0+YjBoxtZznaEYQdBB7WHFF0U17N6UIrA2CnUxi2F5x8k7lR6u7Xf
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="259933219"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="259933219"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 03:10:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="590268576"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 12 Apr 2022 03:10:55 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neDU7-0002jy-3m;
        Tue, 12 Apr 2022 10:10:55 +0000
Date:   Tue, 12 Apr 2022 18:10:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/pm] BUILD SUCCESS
 78b7022a5a178c9aa712ff91f142cd44455ff462
Message-ID: <62555000.X8ECHw5ZPN0YYVxu%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/pm
branch HEAD: 78b7022a5a178c9aa712ff91f142cd44455ff462  PCI/PM: Power up all devices during runtime resume

elapsed time: 735m

configs tested: 128
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                 randconfig-c001-20220411
arc                           tb10x_defconfig
sh                               alldefconfig
arm                          gemini_defconfig
arm                            lart_defconfig
i386                                defconfig
arm                     eseries_pxa_defconfig
powerpc                      mgcoge_defconfig
mips                  decstation_64_defconfig
arm                       imx_v6_v7_defconfig
arm                          pxa3xx_defconfig
m68k                       m5475evb_defconfig
sh                 kfr2r09-romimage_defconfig
xtensa                          iss_defconfig
powerpc                     ep8248e_defconfig
arm                        realview_defconfig
sh                          sdk7780_defconfig
parisc64                         alldefconfig
powerpc                      ppc40x_defconfig
ia64                      gensparse_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                               j2_defconfig
m68k                       m5249evb_defconfig
powerpc                     stx_gp3_defconfig
openrisc                         alldefconfig
arm                      jornada720_defconfig
arm                  randconfig-c002-20220411
x86_64               randconfig-c001-20220411
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                            allyesconfig
i386                              debian-10.3
i386                             allyesconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64               randconfig-a016-20220411
x86_64               randconfig-a012-20220411
x86_64               randconfig-a013-20220411
x86_64               randconfig-a014-20220411
x86_64               randconfig-a015-20220411
x86_64               randconfig-a011-20220411
i386                 randconfig-a015-20220411
i386                 randconfig-a011-20220411
i386                 randconfig-a016-20220411
i386                 randconfig-a012-20220411
i386                 randconfig-a013-20220411
i386                 randconfig-a014-20220411
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220411
s390                 randconfig-r044-20220411
riscv                randconfig-r042-20220411
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
x86_64                              defconfig

clang tested configs:
powerpc              randconfig-c003-20220411
arm                  randconfig-c002-20220411
riscv                randconfig-c006-20220411
x86_64               randconfig-c007-20220411
mips                 randconfig-c004-20220411
i386                 randconfig-c001-20220411
powerpc                 xes_mpc85xx_defconfig
arm                        multi_v5_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                     mpc512x_defconfig
hexagon                             defconfig
powerpc                     ppa8548_defconfig
x86_64                           allyesconfig
powerpc                 mpc837x_rdb_defconfig
arm                           sama7_defconfig
arm                          pxa168_defconfig
x86_64               randconfig-a003-20220411
x86_64               randconfig-a004-20220411
x86_64               randconfig-a006-20220411
x86_64               randconfig-a001-20220411
x86_64               randconfig-a002-20220411
x86_64               randconfig-a005-20220411
i386                 randconfig-a003-20220411
i386                 randconfig-a005-20220411
i386                 randconfig-a001-20220411
i386                 randconfig-a006-20220411
i386                 randconfig-a004-20220411
i386                 randconfig-a002-20220411
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220411
hexagon              randconfig-r045-20220411

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
