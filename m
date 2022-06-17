Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF2B54EEA3
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jun 2022 03:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiFQBJ0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jun 2022 21:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiFQBJZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jun 2022 21:09:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88ADD60AB9
        for <linux-pci@vger.kernel.org>; Thu, 16 Jun 2022 18:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655428164; x=1686964164;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=SPVUNwNXTTkNW/FzOiVRxrCPGvhxKtF48hpn44MiBW4=;
  b=VQmfqTVC1VMJgMks5cfTsOiHW//yrouQApdfht9fnuwA3240y9Y7iO5B
   6ctrBUnq27a3jkvM02333AS8SunPkQsz2hXIRrNmYc2tIPHuikNsbGY2C
   nMz18OhIWFQ5fhWx8xoZwTRJech6CRzoFyNZ5m/PqURKmqgf8SxjwzmOd
   RH81B83gymgnC0GCCtKYvTs3k4j8cX6NAIx5Dw2UA5P5vh0R+R1vycO3w
   nMil9i46bc7aszMShRBfy0qE83RKvFyNAb+J9otcIkYkvFvDE2rwnEyU9
   3g0olwsYqKEfAKSnP8Ztps+40HTuR3B8uI21ffrcLuHw23aQBm0p4LjP6
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="262409805"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="262409805"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 18:09:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="536653571"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 16 Jun 2022 18:09:23 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o20UE-000OxJ-Fs;
        Fri, 17 Jun 2022 01:09:22 +0000
Date:   Fri, 17 Jun 2022 09:09:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/ctrl/mediatek-gen3] BUILD SUCCESS
 28fc842e14729df641326b4deb3aa275ca648fce
Message-ID: <62abd43c.JLKx+Ha20Lncasyp%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ctrl/mediatek-gen3
branch HEAD: 28fc842e14729df641326b4deb3aa275ca648fce  PCI: mediatek-gen3: Print LTSSM state when PCIe link down

elapsed time: 1737m

configs tested: 98
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
um                                  defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                      cm5200_defconfig
arm                          exynos_defconfig
arc                              allyesconfig
powerpc                 canyonlands_defconfig
m68k                        m5307c3_defconfig
sh                          landisk_defconfig
sh                             shx3_defconfig
xtensa                    xip_kc705_defconfig
powerpc                     tqm8548_defconfig
arm                           tegra_defconfig
arm                        shmobile_defconfig
mips                 decstation_r4k_defconfig
mips                             allmodconfig
arm                      integrator_defconfig
s390                                defconfig
powerpc                     pq2fads_defconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                          ath25_defconfig
mips                           mtx1_defconfig
powerpc                   microwatt_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                    socrates_defconfig
x86_64                        randconfig-k001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
riscv                randconfig-r042-20220616
hexagon              randconfig-r041-20220616
hexagon              randconfig-r045-20220616
s390                 randconfig-r044-20220616

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
