Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120E8533A9B
	for <lists+linux-pci@lfdr.de>; Wed, 25 May 2022 12:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbiEYK04 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 May 2022 06:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiEYK04 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 May 2022 06:26:56 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96FD939B6
        for <linux-pci@vger.kernel.org>; Wed, 25 May 2022 03:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653474414; x=1685010414;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Jwo82rwZNMjfdv+fNQkcpPAl9NZjBQY7EECZGMIkNb8=;
  b=UD/kfF4teRV05IC5ZnzVWTDJtOIgJqddLU+kt2DyAwVudQihChlAYj0M
   5czE+w8Vltr8yN5ytVki8RIE0O30jNnsuc9EHrWLo4nPuN9RueA43dC+c
   Zt8ywZT09oGoxbuPUFUM3vkRWs5BUhzvHDvkHUwBfjuyeHeRZitp7TiVJ
   Idql6TxYVsECJmLnuMZhkAtMbFp+8TWsJkedxfuOYAmjaKaVSr2b/sCLX
   2WogRn2EjPCB0x77ARGvw7B/IadVmItTdGihoOzyhDPpUr3BRbVYTPIpS
   DMV3hn8u/dPW0uxDC46ozIqyecXqXyGZjk94qkELtSKkS32yaKDupqh7P
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="273775400"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="273775400"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 03:26:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="630290874"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 25 May 2022 03:26:51 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntoE6-0002we-Af;
        Wed, 25 May 2022 10:26:50 +0000
Date:   Wed, 25 May 2022 18:26:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/host/qcom] BUILD SUCCESS
 3f467d122f27f3a0be7fa7f2f60c7dd9475c4a81
Message-ID: <628e0448.NNCe5lkBluNlUjqF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/host/qcom
branch HEAD: 3f467d122f27f3a0be7fa7f2f60c7dd9475c4a81  dt-bindings: PCI: qcom: Add schema for sc7280 chipset

elapsed time: 726m

configs tested: 107
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
sh                              ul2_defconfig
arc                 nsimosci_hs_smp_defconfig
m68k                            mac_defconfig
sh                   sh7724_generic_defconfig
arm                           tegra_defconfig
sh                        dreamcast_defconfig
powerpc                 mpc837x_mds_defconfig
m68k                       m5208evb_defconfig
arm                          simpad_defconfig
arc                          axs101_defconfig
mips                         mpc30x_defconfig
arm                       multi_v4t_defconfig
xtensa                          iss_defconfig
um                                  defconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
alpha                               defconfig
csky                                defconfig
alpha                            allyesconfig
nios2                            allyesconfig
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
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220524
s390                 randconfig-r044-20220524
riscv                randconfig-r042-20220524
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz

clang tested configs:
arm                  randconfig-c002-20220524
x86_64                        randconfig-c007
s390                 randconfig-c005-20220524
i386                          randconfig-c001
powerpc              randconfig-c003-20220524
riscv                randconfig-c006-20220524
mips                 randconfig-c004-20220524
powerpc                          allmodconfig
powerpc                          g5_defconfig
powerpc                      katmai_defconfig
mips                            e55_defconfig
powerpc                      obs600_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220524
hexagon              randconfig-r041-20220524

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
