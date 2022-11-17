Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A1862D56E
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 09:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbiKQItL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 03:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239651AbiKQIsz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 03:48:55 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5059857B6C
        for <linux-pci@vger.kernel.org>; Thu, 17 Nov 2022 00:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668674927; x=1700210927;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=YzW/uBfltV2mjho5n06PaELyRgYifyU7ZxU6FwkP76k=;
  b=G49CZ+FRc2r74Z0HrYRjrUnZ6JPbpoBWJYJcPywIbpl3T7b96VTdPJyk
   K9Re3pezKCa1JMng5erXsfVIkCzdrPIxmygDu2lpJEo/VOYWc51Wq4aWU
   LRemkaIX52hyQHR6HwViTQ7ZnbihQNefXHcnZWW/6FDQcQa1JVRNL6Kac
   3BtlXPlm9Rdp/F7S7oY55wSI0/yJ6f79I2iYitMz0zaSb/YVaXTQ7JjW8
   ADDYRpossfRPZYCSLhDYzvkiXn5w7djbae4/g52fAdGRpOxwqL2UHe3/8
   XVPIPaKmJ1IrZQpdEcykA7No8IsdxOPIbFVZbUakhbL+pXN2m0VGtgar1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="300330389"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="300330389"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 00:48:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="672738728"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="672738728"
Received: from lkp-server01.sh.intel.com (HELO 55744f5052f8) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 17 Nov 2022 00:48:44 -0800
Received: from kbuild by 55744f5052f8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ovaZf-000058-37;
        Thu, 17 Nov 2022 08:48:43 +0000
Date:   Thu, 17 Nov 2022 16:48:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/doe] BUILD SUCCESS
 a4ff8e7a71601321f7bf7b58ede664dc0d774274
Message-ID: <6375f548.rKhyceA7RBdYu0zM%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/doe
branch HEAD: a4ff8e7a71601321f7bf7b58ede664dc0d774274  PCI/DOE: Fix maximum data object length miscalculation

elapsed time: 726m

configs tested: 77
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                            allyesconfig
arc                              allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
mips                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
m68k                             allyesconfig
powerpc                          allmodconfig
m68k                             allmodconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
ia64                             allmodconfig
s390                                defconfig
s390                             allyesconfig
x86_64                            allnoconfig
i386                             allyesconfig
i386                                defconfig
sh                          r7785rp_defconfig
arm                         lubbock_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                mpc7448_hpc2_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
s390                       zfcpdump_defconfig
sh                      rts7751r2d1_defconfig
microblaze                          defconfig
sh                          rsk7203_defconfig
sparc64                          alldefconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                        nsim_700_defconfig
powerpc                        cell_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sh                          sdk7786_defconfig
arm                            zeus_defconfig
openrisc                            defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
um                               alldefconfig
sh                           se7722_defconfig
sh                         ap325rxa_defconfig
i386                          randconfig-c001

clang tested configs:
hexagon              randconfig-r041-20221117
hexagon              randconfig-r045-20221117
s390                 randconfig-r044-20221116
riscv                randconfig-r042-20221116
hexagon              randconfig-r041-20221116
hexagon              randconfig-r045-20221116
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-k001
powerpc                          g5_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
