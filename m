Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB405A6F19
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 23:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiH3V0f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 17:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiH3V0e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 17:26:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B8882D32
        for <linux-pci@vger.kernel.org>; Tue, 30 Aug 2022 14:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661894794; x=1693430794;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=hTbW5Z7C/NnHaZs1MTW/pwQsDxPz/QA3wT5Pu24GvLU=;
  b=V4NkkBrEceqNQ0UNonNnkfz+1tLfEaa7NHzbq+1Z2rcR9Nba2DSBkqo8
   KUMGmNoc4iGfzys7KrdcXrcygKrLXaFkgd+Tcw0qJAkTC3dfFERIByLAS
   zZNwJXrCJO91OwmfasRb0akNe1mAWZSK148vWRwLpvAlKcT8ci5uNwHw8
   30l8dUuGopozkEyTucJilEn0hDkXmtRAkda/L/YX3MCfXhq5YT43yPYbn
   z3ZDzBiH/hlf/lqg+px58oNcFn8FrMX3AV+68RBmaRpZM4CC/GEPpR15l
   4/zJABHPSW5rc9Twg+z4Hm59ZqjJ6Vr69CE1Zcb6T4fJpKBGcVzy4/z0x
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="357020343"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="357020343"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 14:26:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="641570536"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 30 Aug 2022 14:26:32 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oT8kh-0000cx-30;
        Tue, 30 Aug 2022 21:26:31 +0000
Date:   Wed, 31 Aug 2022 05:25:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/qcom] BUILD SUCCESS
 2baedb9f93c42d35016c3c2e3015d67fbcb058b0
Message-ID: <630e804f.4jFEfaZp5BI/xYOv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/qcom
branch HEAD: 2baedb9f93c42d35016c3c2e3015d67fbcb058b0  PCI: qcom-ep: Add MODULE_DEVICE_TABLE

elapsed time: 753m

configs tested: 89
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20220830
x86_64                              defconfig
m68k                             allmodconfig
arc                              allyesconfig
powerpc                           allnoconfig
alpha                            allyesconfig
powerpc                          allmodconfig
x86_64                               rhel-8.3
sh                               allmodconfig
m68k                             allyesconfig
mips                             allyesconfig
x86_64                           rhel-8.3-syz
i386                                defconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                             allyesconfig
arc                                 defconfig
sh                            hp6xx_defconfig
arm                            pleb_defconfig
openrisc                       virt_defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                           allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
arm                         lubbock_defconfig
arc                           tb10x_defconfig
arc                          axs101_defconfig
xtensa                          iss_defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arm                       imx_v6_v7_defconfig
mips                           jazz_defconfig
powerpc                     stx_gp3_defconfig
powerpc                     asp8347_defconfig
sh                           se7619_defconfig
i386                          randconfig-c001
loongarch                           defconfig
loongarch                         allnoconfig
mips                        bcm47xx_defconfig
powerpc                       eiger_defconfig
arc                 nsimosci_hs_smp_defconfig
sparc                               defconfig
mips                      loongson3_defconfig
m68k                       m5475evb_defconfig
xtensa                  nommu_kc705_defconfig
mips                       bmips_be_defconfig
arm                      integrator_defconfig
sh                          kfr2r09_defconfig
arm                         cm_x300_defconfig
nios2                            alldefconfig
openrisc                  or1klitex_defconfig
sparc                             allnoconfig
sh                           se7721_defconfig
sh                        edosk7760_defconfig
m68k                            mac_defconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r045-20220830
hexagon              randconfig-r041-20220830
riscv                randconfig-r042-20220830
s390                 randconfig-r044-20220830
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
arm                          pcm027_defconfig
x86_64                        randconfig-k001
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
