Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48CC5F5EB5
	for <lists+linux-pci@lfdr.de>; Thu,  6 Oct 2022 04:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiJFCZp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Oct 2022 22:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJFCZo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Oct 2022 22:25:44 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DB585583
        for <linux-pci@vger.kernel.org>; Wed,  5 Oct 2022 19:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665023143; x=1696559143;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=K+HZkDepPnkuYu87/Bpxfk/brAUPP1uG5FKJVYF0C+8=;
  b=DQvbK4lcV3VWxZ1Fz6+5sPyJvwsuTcnn4ef2dgojHrJqMt/rueF+0kOq
   qv8NWqUyrW5c/UF4I0RiCquZfzERgj51QxVl1OM8IO0gOwe4fYgdV3rHB
   g1Nh6xWZSlhIbTiqIUDsvSIgyKQiDw2rJd8ZCt1GqgXQODAv8mgkJVHgo
   9WFbjfC2QSDWSoAEZBse8VrAylfn3PNYrt0K5DHqGi7Q2gMK+bXFPrWxl
   MC3i0nvGhH0p9tcguam4fsSdHcu9MSwCcIXd35N0hlQS16mIAsaiDUb3W
   d2gpEu9DAetVhPP9RUV6zZRtlQaooi4MQhI/oAa2IPJqvfRZORaRmVgoH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="304319414"
X-IronPort-AV: E=Sophos;i="5.95,162,1661842800"; 
   d="scan'208";a="304319414"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 19:25:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="693161395"
X-IronPort-AV: E=Sophos;i="5.95,162,1661842800"; 
   d="scan'208";a="693161395"
Received: from lkp-server01.sh.intel.com (HELO d4f44333118a) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 05 Oct 2022 19:25:41 -0700
Received: from kbuild by d4f44333118a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ogGZw-0001o9-1Q;
        Thu, 06 Oct 2022 02:25:40 +0000
Date:   Thu, 06 Oct 2022 10:25:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/qcom] BUILD SUCCESS
 7e1086fc815840ac1c3ed283126fd7e027efd242
Message-ID: <633e3c90.8/tj9cLoziLYuTxE%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/qcom
branch HEAD: 7e1086fc815840ac1c3ed283126fd7e027efd242  PCI: qcom-ep: Add support for SM8450 SoC

elapsed time: 721m

configs tested: 100
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-syz
arc                                 defconfig
x86_64                         rhel-8.3-kunit
alpha                               defconfig
x86_64                           rhel-8.3-kvm
x86_64                              defconfig
s390                             allmodconfig
s390                                defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
s390                             allyesconfig
powerpc                           allnoconfig
i386                                defconfig
i386                 randconfig-a015-20221003
i386                 randconfig-a014-20221003
i386                 randconfig-a011-20221003
i386                 randconfig-a012-20221003
arm                                 defconfig
i386                 randconfig-a013-20221003
m68k                             allyesconfig
i386                 randconfig-a016-20221003
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                             allyesconfig
x86_64               randconfig-a011-20221003
x86_64               randconfig-a012-20221003
riscv                randconfig-r042-20221003
arc                  randconfig-r043-20221003
arc                  randconfig-r043-20221002
s390                 randconfig-r044-20221003
sh                               allmodconfig
arm                              allyesconfig
x86_64               randconfig-a013-20221003
arm64                            allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a015-20221003
mips                             allyesconfig
x86_64               randconfig-a014-20221003
x86_64               randconfig-a016-20221003
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arc                        nsim_700_defconfig
sh                          r7780mp_defconfig
xtensa                              defconfig
i386                          randconfig-c001
powerpc                      cm5200_defconfig
arm                           viper_defconfig
m68k                          atari_defconfig
powerpc                       eiger_defconfig
sh                      rts7751r2d1_defconfig
mips                           xway_defconfig
powerpc                    klondike_defconfig
mips                        bcm47xx_defconfig
arm                          simpad_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                  randconfig-c002-20221002
x86_64                        randconfig-c001
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig

clang tested configs:
i386                 randconfig-a004-20221003
x86_64               randconfig-a003-20221003
i386                 randconfig-a005-20221003
i386                 randconfig-a003-20221003
x86_64               randconfig-a002-20221003
hexagon              randconfig-r041-20221003
i386                 randconfig-a002-20221003
x86_64               randconfig-a001-20221003
i386                 randconfig-a001-20221003
hexagon              randconfig-r041-20221002
i386                 randconfig-a006-20221003
s390                 randconfig-r044-20221002
x86_64               randconfig-a005-20221003
x86_64               randconfig-a004-20221003
hexagon              randconfig-r045-20221002
x86_64               randconfig-a006-20221003
hexagon              randconfig-r045-20221003
riscv                randconfig-r042-20221002
powerpc                     powernv_defconfig
arm                           spitz_defconfig
x86_64                        randconfig-k001
powerpc                    mvme5100_defconfig
powerpc                     ppa8548_defconfig
arm                          sp7021_defconfig
arm                        magician_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
