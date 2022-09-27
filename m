Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850DF5ED03C
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 00:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiI0WXO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 18:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiI0WXN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 18:23:13 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08A31EC9A6
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 15:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664317383; x=1695853383;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=x48+KzhZ87NFGKlI5/KDe2rOtZieUXoH8eK3hEwEP+Q=;
  b=Hl6AoG0mLQA5JxnqpSgY7NRRaXcDbeJGh8v+KbtvD+yaBhao0nXn6aB4
   bbEVrqR23s1ucTmdbynf9Kn2+UFOVI8P6JBNKBeXBxeDUOJ5oM/wuklyY
   hhv+9BSZQV7o3lxG4kOuWZZn5hAeWdgQJtIt/32nIG8tZadIJK7f/AELw
   TKQ2EjwCsINiFbVIun+fnDTRHSacFdnoFm9paSZeQ5QlZIcCAhvQvx4Lh
   hqnPNs710PCr97BlV81BO7Dj033HKryexSVN/odpl8cE7OGLQhq2UVAu/
   cI01alATa11pivun2039Ji7Wxa2AQiZB8dFk2bKUtYL3Lh+adQGbE3BIG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="302926443"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="302926443"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 15:22:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="796927205"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="796927205"
Received: from lkp-server02.sh.intel.com (HELO dfa2c9fcd321) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 27 Sep 2022 15:22:56 -0700
Received: from kbuild by dfa2c9fcd321 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1odIyd-0001eL-1W;
        Tue, 27 Sep 2022 22:22:55 +0000
Date:   Wed, 28 Sep 2022 06:22:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/dt] BUILD SUCCESS
 1abbe04a1b55200d0e3e93b2c15058c15126a225
Message-ID: <633377af.CeIsNCP9NrWJgsMy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/dt
branch HEAD: 1abbe04a1b55200d0e3e93b2c15058c15126a225  dt-bindings: pci: QCOM Add missing sc7280 aggre0, aggre1 clocks

elapsed time: 727m

configs tested: 93
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
s390                             allyesconfig
i386                 randconfig-a001-20220926
i386                 randconfig-a004-20220926
i386                 randconfig-a002-20220926
i386                 randconfig-a003-20220926
x86_64               randconfig-a002-20220926
i386                 randconfig-a005-20220926
x86_64               randconfig-a001-20220926
i386                 randconfig-a006-20220926
x86_64               randconfig-a003-20220926
x86_64                              defconfig
x86_64               randconfig-a004-20220926
x86_64               randconfig-a006-20220926
x86_64               randconfig-a005-20220926
i386                                defconfig
arm                                 defconfig
x86_64                               rhel-8.3
arc                  randconfig-r043-20220925
i386                             allyesconfig
arc                  randconfig-r043-20220926
m68k                             allmodconfig
riscv                randconfig-r042-20220925
alpha                            allyesconfig
arm64                            allyesconfig
s390                 randconfig-r044-20220925
arc                              allyesconfig
arm                              allyesconfig
x86_64                           allyesconfig
m68k                             allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
sh                        sh7763rdp_defconfig
csky                                defconfig
ia64                             alldefconfig
powerpc                     asp8347_defconfig
s390                       zfcpdump_defconfig
powerpc                      tqm8xx_defconfig
i386                             alldefconfig
mips                        bcm47xx_defconfig
sh                          urquell_defconfig
arc                      axs103_smp_defconfig
i386                          randconfig-c001
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
ia64                             allmodconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002

clang tested configs:
i386                 randconfig-a011-20220926
i386                 randconfig-a014-20220926
i386                 randconfig-a013-20220926
i386                 randconfig-a012-20220926
i386                 randconfig-a016-20220926
i386                 randconfig-a015-20220926
hexagon              randconfig-r045-20220925
hexagon              randconfig-r041-20220926
hexagon              randconfig-r045-20220926
hexagon              randconfig-r041-20220925
riscv                randconfig-r042-20220926
s390                 randconfig-r044-20220926
x86_64               randconfig-a012-20220926
x86_64               randconfig-a014-20220926
x86_64               randconfig-a013-20220926
x86_64               randconfig-a011-20220926
x86_64               randconfig-a015-20220926
x86_64               randconfig-a016-20220926
x86_64                        randconfig-k001
arm                       imx_v4_v5_defconfig
riscv                    nommu_virt_defconfig
arm                  colibri_pxa270_defconfig
arm                       versatile_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
