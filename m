Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C724456A18F
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 13:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiGGLvp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 07:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbiGGLvo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 07:51:44 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682404507D
        for <linux-pci@vger.kernel.org>; Thu,  7 Jul 2022 04:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657194703; x=1688730703;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=d5nBe1M/tyJ7pOezjn2ZxeKMLBWKidb6hhY4cYx2+Bk=;
  b=Eqb73k12BLtbNWaMBFdBytM1deXLaeSEffJpXLmnozOqUYzzaXFi08/F
   jPvyjMWzZ2x8ANd3egLaCCbrAFuc6e7OCkVgmlQ9uNWp3v+YnB6xKxeGw
   Oq6GxT5VxkpDUcfDkPNxdj87+rF+tLX20RzGKgSuisbtbxKd6zT6PlCMJ
   f7+h5qFxVMf6AmdFBtFDBAFLHPRoi8m4YZUr0dXzN2TKVNegktiB/zY1x
   KZH3/Y0Spxv7so97wlIAR6ik2lqdZ2PO4LqtSpkZNX6+Dxm4KMv6kP4cd
   hPe/TKpOca+WqoSmKFyZoPF2t/5m60ohkE3pSsvL3uUISVagutQrk1Xou
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="285130557"
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="285130557"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 04:51:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="568488917"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 07 Jul 2022 04:51:41 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9Q2n-000LyF-6p;
        Thu, 07 Jul 2022 11:51:41 +0000
Date:   Thu, 07 Jul 2022 19:51:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/endpoint] BUILD SUCCESS
 1bc2b7bfba6e2f64edf5e246f3af2967261f6c3d
Message-ID: <62c6c8b3.cNUgqO/fwFA8jwlz%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/endpoint
branch HEAD: 1bc2b7bfba6e2f64edf5e246f3af2967261f6c3d  PCI: endpoint: Don't stop controller when unbinding endpoint function

elapsed time: 872m

configs tested: 99
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
m68k                        mvme147_defconfig
m68k                             alldefconfig
xtensa                       common_defconfig
powerpc                         wii_defconfig
m68k                       m5249evb_defconfig
sh                        apsh4ad0a_defconfig
arm                          lpd270_defconfig
arm                           viper_defconfig
arc                     nsimosci_hs_defconfig
sh                                  defconfig
sh                          rsk7269_defconfig
alpha                            alldefconfig
openrisc                            defconfig
arm                          badge4_defconfig
m68k                         amcore_defconfig
sh                           se7721_defconfig
powerpc                  storcenter_defconfig
xtensa                  audio_kc705_defconfig
sh                            titan_defconfig
mips                  decstation_64_defconfig
powerpc                     mpc83xx_defconfig
sh                          sdk7786_defconfig
arm                       aspeed_g5_defconfig
m68k                        m5307c3_defconfig
mips                 decstation_r4k_defconfig
sh                           se7712_defconfig
sh                        edosk7705_defconfig
arm                        mini2440_defconfig
arm                             rpc_defconfig
sh                           se7705_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                  randconfig-c002-20220707
ia64                             allmodconfig
arc                              allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
alpha                            allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220706
riscv                randconfig-r042-20220707
arc                  randconfig-r043-20220707
s390                 randconfig-r044-20220707
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                      pxa255-idp_defconfig
powerpc                     tqm8540_defconfig
arm                      tct_hammer_defconfig
mips                        qi_lb60_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
riscv                randconfig-r042-20220706
hexagon              randconfig-r041-20220706
hexagon              randconfig-r045-20220706
s390                 randconfig-r044-20220706
hexagon              randconfig-r045-20220707
hexagon              randconfig-r041-20220707

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
