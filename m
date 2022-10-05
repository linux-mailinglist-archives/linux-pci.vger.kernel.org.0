Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240FC5F566C
	for <lists+linux-pci@lfdr.de>; Wed,  5 Oct 2022 16:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJEOaV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Oct 2022 10:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiJEOaU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Oct 2022 10:30:20 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003092B255
        for <linux-pci@vger.kernel.org>; Wed,  5 Oct 2022 07:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664980220; x=1696516220;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ch0GPkVDHff8LL/oKQipz2H/eU/YJjRV+VLpu4+sCV0=;
  b=nKOyT3TWAPQPMlZ59F5zFkViDM8nevjfxokSzkE7ONyg60nKVdjE+gc+
   fKUfSjtTi1V9zoJbkbzmKq8to6/dypVv43ATYT70fnkUlBUhkyGfh5SVT
   t7y4xFPgdmCDcckOdEH7QugDqb//tPa7a5E2XpA2mEegCQMsEpDlILtbz
   6c5YFsmSHdF98psA667gxmzXGCcGzQjs2N2SoNaoKa+geNTmXj8G5Mnge
   AhEApmy2lmz0VdO3jaCGtkgAbRsfKzZfyM+zDkQHFSZxm/qldmMU+tPP9
   OtT3aah3LQvR2tfn/NkTB6ubLQHn66Q393eS/DwdAjVXyWjuT5lgyeEMg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="304155642"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="304155642"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 07:28:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="766741333"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="766741333"
Received: from lkp-server01.sh.intel.com (HELO d4f44333118a) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 05 Oct 2022 07:28:13 -0700
Received: from kbuild by d4f44333118a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1og5Nd-0001Jt-0I;
        Wed, 05 Oct 2022 14:28:13 +0000
Date:   Wed, 05 Oct 2022 22:27:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/aspm] BUILD SUCCESS
 d3a9d35300341349af62d77372b85c1ffbd5c071
Message-ID: <633d946b.edhts4aebHvGqwnD%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/aspm
branch HEAD: d3a9d35300341349af62d77372b85c1ffbd5c071  PCI/ASPM: Correct LTR_L1.2_THRESHOLD computation

elapsed time: 725m

configs tested: 102
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
arc                                 defconfig
m68k                             allyesconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
x86_64                              defconfig
riscv                randconfig-r042-20221003
arc                  randconfig-r043-20221003
i386                 randconfig-a011-20221003
x86_64                           rhel-8.3-kvm
arc                  randconfig-r043-20221002
x86_64                           rhel-8.3-syz
i386                                defconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
i386                 randconfig-a012-20221003
s390                 randconfig-r044-20221003
x86_64                               rhel-8.3
i386                 randconfig-a013-20221003
s390                             allyesconfig
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a015-20221003
arm                                 defconfig
i386                 randconfig-a016-20221003
x86_64                           allyesconfig
i386                 randconfig-a014-20221003
arm64                            allyesconfig
arm                              allyesconfig
i386                             allyesconfig
powerpc                           allnoconfig
x86_64               randconfig-a011-20221003
x86_64               randconfig-a014-20221003
x86_64               randconfig-a012-20221003
x86_64               randconfig-a013-20221003
x86_64               randconfig-a015-20221003
x86_64               randconfig-a016-20221003
ia64                             allmodconfig
arc                               allnoconfig
alpha                             allnoconfig
riscv                             allnoconfig
csky                              allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
mips                           xway_defconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
arm                         nhk8815_defconfig
sparc64                             defconfig
arc                          axs101_defconfig
sh                   sh7770_generic_defconfig
powerpc                 linkstation_defconfig
arm                            pleb_defconfig
arm                       imx_v6_v7_defconfig
sh                             shx3_defconfig
mips                            ar7_defconfig
m68k                                defconfig
sparc                               defconfig
arc                        nsim_700_defconfig
sh                            titan_defconfig
powerpc                 mpc834x_itx_defconfig
mips                     decstation_defconfig
powerpc                     stx_gp3_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
m68k                        m5407c3_defconfig
sh                  sh7785lcr_32bit_defconfig
xtensa                    xip_kc705_defconfig
arm                  randconfig-c002-20221002
x86_64                        randconfig-c001
i386                          randconfig-c001
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
i386                 randconfig-a004-20221003
i386                 randconfig-a005-20221003
i386                 randconfig-a003-20221003
i386                 randconfig-a002-20221003
i386                 randconfig-a001-20221003
i386                 randconfig-a006-20221003
hexagon              randconfig-r041-20221003
riscv                randconfig-r042-20221002
hexagon              randconfig-r041-20221002
s390                 randconfig-r044-20221002
hexagon              randconfig-r045-20221002
hexagon              randconfig-r045-20221003
x86_64               randconfig-a003-20221003
x86_64               randconfig-a002-20221003
x86_64               randconfig-a001-20221003
x86_64               randconfig-a005-20221003
x86_64               randconfig-a004-20221003
x86_64               randconfig-a006-20221003
powerpc                 mpc8313_rdb_defconfig
powerpc                     ppa8548_defconfig
powerpc                     powernv_defconfig
riscv                             allnoconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
