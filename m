Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40DB4F0846
	for <lists+linux-pci@lfdr.de>; Sun,  3 Apr 2022 09:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355406AbiDCH1U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 3 Apr 2022 03:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiDCH1S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 3 Apr 2022 03:27:18 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7018D3193A
        for <linux-pci@vger.kernel.org>; Sun,  3 Apr 2022 00:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648970725; x=1680506725;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=MKZGHc9OrF2ThQtqRA4wQspRRl1QXFhsyopPw88tWa4=;
  b=biaTJibfQ7KiwRKlNLglXpeT96WTWsIa4bl+ZN+iWtWx4US9pbq0DHvH
   kuQULcV7stAMUhW/6+ShTKx6V2LFyb4A13OaQqVfGSKLALYhxfL2pRxyR
   6waXhbP9dQ4qMtTD7BN/pGNpxIMRweLYideTyLZUPiFNWy4OrETDt19Wg
   g11QbCN8LTsXowgY0/64+a7SzGZzvTG3Ng/5I2dG6kjyYDfg/Echq1Z/P
   2JBcuMJQr45dwciDe9Hx9ieLCDOH4SiMf/f9XjP+ThfzkHPsLFPNaXUmj
   u+1AmSrN2K39AsbJTtU6FZO5utebAVV81IP5auJ/l/PHRPHbX6mbX94Al
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10305"; a="321058863"
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="321058863"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 00:25:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="548302569"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 03 Apr 2022 00:25:23 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1naubz-0000nV-75;
        Sun, 03 Apr 2022 07:25:23 +0000
Date:   Sun, 03 Apr 2022 15:25:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/resource] BUILD SUCCESS
 cdede81acc276fabbfc685a3e80b2ff469ae032a
Message-ID: <62494bdd.FyTUxsRD9uISilYU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/resource
branch HEAD: cdede81acc276fabbfc685a3e80b2ff469ae032a  x86/PCI: Log host bridge window clipping for E820 regions

elapsed time: 720m

configs tested: 99
configs skipped: 68

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
m68k                       m5208evb_defconfig
arm                        cerfcube_defconfig
mips                 decstation_r4k_defconfig
sh                           se7619_defconfig
h8300                     edosk2674_defconfig
arm                        spear6xx_defconfig
xtensa                  nommu_kc705_defconfig
sh                           se7712_defconfig
arm                        clps711x_defconfig
arc                        vdk_hs38_defconfig
sh                   sh7724_generic_defconfig
sh                   rts7751r2dplus_defconfig
mips                           xway_defconfig
m68k                            mac_defconfig
mips                            gpr_defconfig
sh                               j2_defconfig
i386                                defconfig
sh                           se7705_defconfig
sparc64                          alldefconfig
alpha                               defconfig
arm                          badge4_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220403
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
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
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220403
riscv                randconfig-c006-20220403
mips                 randconfig-c004-20220403
arm                  randconfig-c002-20220403
x86_64                           allyesconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220403
riscv                randconfig-r042-20220403
hexagon              randconfig-r041-20220403

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
