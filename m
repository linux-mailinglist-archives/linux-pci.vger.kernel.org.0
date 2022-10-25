Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3076960C609
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 10:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiJYIES (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 04:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiJYIEG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 04:04:06 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E144B15B302
        for <linux-pci@vger.kernel.org>; Tue, 25 Oct 2022 01:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666685046; x=1698221046;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=els80Iu3HKCGw5Gxb2s+cJ3sBHL08NN8LK5uLfyBUUM=;
  b=JAdBorRwrcnwfjdEjdqAkGlyVsrdnO6URiCOjc586Jw8gF6vcFKFO/yt
   +i5IzFrW8d+qyUUZaGXvzITWr4ToV5/CQ4Z57efr0+QfyO0h5Arx8qs9D
   uF8TlP56WJuKIxWehnzBiw83pL9wCpu1VbH3Dh2kmcgvSnA1xtLr5hKDF
   P9O3s94Vxu6rk6no7EbMw/y7+lpbaG81oLe4qJoVIQxB4PMO4Jo7RreFk
   a1tfu+JsubAtaucXBS3XxWTedONbtGdaj3dwTcv6zXNzBQmlFDlLfRt4/
   o39aHsAXe14IoevlPSMm87foJPC+3jYMrMDxzgSyPKycRBemwZggtCoRY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="371831984"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="371831984"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 01:04:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="662721021"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="662721021"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 25 Oct 2022 01:04:03 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1onEup-000642-0i;
        Tue, 25 Oct 2022 08:04:03 +0000
Date:   Tue, 25 Oct 2022 16:03:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/portdrv] BUILD SUCCESS
 461a65d7d1a4f56b97c9115eda3e8619516f40fb
Message-ID: <63579845.J5Hc3THfYmt4EjeA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/portdrv
branch HEAD: 461a65d7d1a4f56b97c9115eda3e8619516f40fb  PCI/portdrv: Unexport pcie_port_service_register(), pcie_port_service_unregister()

elapsed time: 722m

configs tested: 99
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
powerpc                          allmodconfig
mips                             allyesconfig
i386                                defconfig
powerpc                           allnoconfig
i386                 randconfig-a011-20221024
i386                 randconfig-a014-20221024
s390                             allyesconfig
i386                 randconfig-a013-20221024
i386                 randconfig-a012-20221024
i386                 randconfig-a015-20221024
i386                 randconfig-a016-20221024
sh                               allmodconfig
m68k                             allmodconfig
arc                              allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
alpha                            allyesconfig
i386                             allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
m68k                             allyesconfig
arc                  randconfig-r043-20221024
s390                 randconfig-r044-20221024
riscv                randconfig-r042-20221024
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
arc                              alldefconfig
sh                        dreamcast_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                          polaris_defconfig
riscv                    nommu_k210_defconfig
xtensa                    xip_kc705_defconfig
ia64                             allmodconfig
powerpc                   motionpro_defconfig
csky                             alldefconfig
powerpc                 mpc837x_rdb_defconfig
openrisc                            defconfig
x86_64               randconfig-k001-20221024
x86_64               randconfig-a014-20221024
x86_64               randconfig-a015-20221024
x86_64               randconfig-a016-20221024
x86_64               randconfig-a013-20221024
x86_64               randconfig-a012-20221024
x86_64               randconfig-a011-20221024
arm                        mini2440_defconfig
powerpc                      chrp32_defconfig
sh                          lboxre2_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
m68k                       m5249evb_defconfig
arm                       aspeed_g5_defconfig
powerpc                  storcenter_defconfig
powerpc                 canyonlands_defconfig
powerpc                     tqm8555_defconfig
sh                           se7712_defconfig
mips                     decstation_defconfig
arm                           h5000_defconfig
arm                       multi_v4t_defconfig
m68k                           sun3_defconfig
sh                          urquell_defconfig
arm                       omap2plus_defconfig
arm                        spear6xx_defconfig
powerpc                      tqm8xx_defconfig
powerpc                 mpc834x_mds_defconfig
mips                            gpr_defconfig
arc                  randconfig-r043-20221025

clang tested configs:
i386                 randconfig-a004-20221024
i386                 randconfig-a006-20221024
i386                 randconfig-a002-20221024
i386                 randconfig-a003-20221024
i386                 randconfig-a001-20221024
i386                 randconfig-a005-20221024
x86_64               randconfig-a005-20221024
x86_64               randconfig-a002-20221024
x86_64               randconfig-a006-20221024
x86_64               randconfig-a001-20221024
x86_64               randconfig-a004-20221024
x86_64               randconfig-a003-20221024
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
s390                 randconfig-r044-20221023
hexagon              randconfig-r041-20221023
riscv                randconfig-r042-20221023
hexagon              randconfig-r045-20221023
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
