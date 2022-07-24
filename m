Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B6357F246
	for <lists+linux-pci@lfdr.de>; Sun, 24 Jul 2022 02:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239128AbiGXAyS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Jul 2022 20:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239065AbiGXAyR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Jul 2022 20:54:17 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F1B14D3B
        for <linux-pci@vger.kernel.org>; Sat, 23 Jul 2022 17:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658624057; x=1690160057;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=vG9N0UngUx1hN6OPP7+Pgn+AkWDPdRZF5yNUX1yLm2k=;
  b=l2Fs0kzZ6X5AR9lhRBbHxwO0Lh5eBWlFV+9894FdFmpcz5l1O3uwD2lQ
   7hIb7QKD6SrCTSytFOJWD8BdIwppnkwYf3E/aaa5/zyv8OKrzNAdK4hNS
   M4xHD/v2y3j6kXutfq2FAJzciiRtekUTzgfCIuVMUuwd4lYtZaltfu0SL
   QKgEDLUzzZsD6sq0+li3pk1GkOTnDQKME6D7m/N+OjARpgk1C1VcQs01Q
   hSk/QpHA1uc9KcUgACSiLKKdSNdfDIwxkwLE62BWxU4GOyjTZzU1+Ebo9
   W63HJXQOKXD0+SUTC32sFw4h2tUWm9Zl7SRDvessdH7yurYZG31R+ThNI
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="373808248"
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="373808248"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 17:54:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="574595658"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 23 Jul 2022 17:54:15 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFPss-0003Jb-2U;
        Sun, 24 Jul 2022 00:54:14 +0000
Date:   Sun, 24 Jul 2022 08:53:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/ctrl/tegra194] BUILD SUCCESS
 a54e190737181c12d2a49a8f6456622e8b70f4f1
Message-ID: <62dc9804.9hio4VxEY3ISETY/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ctrl/tegra194
branch HEAD: a54e190737181c12d2a49a8f6456622e8b70f4f1  PCI: tegra194: Add Tegra234 PCIe support

elapsed time: 1554m

configs tested: 107
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
powerpc              randconfig-c003-20220722
i386                          randconfig-c001
sh                               alldefconfig
arm                          lpd270_defconfig
m68k                            mac_defconfig
um                                  defconfig
arm                           h5000_defconfig
mips                  decstation_64_defconfig
mips                         mpc30x_defconfig
powerpc                     pq2fads_defconfig
mips                       bmips_be_defconfig
sh                          r7785rp_defconfig
parisc                           alldefconfig
m68k                          amiga_defconfig
mips                 decstation_r4k_defconfig
sh                             sh03_defconfig
powerpc                     sequoia_defconfig
xtensa                           alldefconfig
sh                        sh7763rdp_defconfig
m68k                         amcore_defconfig
arm                            hisi_defconfig
sh                         ap325rxa_defconfig
xtensa                  nommu_kc705_defconfig
arm                           stm32_defconfig
arm                           tegra_defconfig
sh                                  defconfig
parisc                generic-64bit_defconfig
powerpc                     tqm8548_defconfig
openrisc                         alldefconfig
m68k                       m5208evb_defconfig
sh                            titan_defconfig
ia64                         bigsur_defconfig
loongarch                           defconfig
parisc64                         alldefconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
loongarch                         allnoconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
powerpc                           allnoconfig
mips                             allyesconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                        randconfig-a006
x86_64                        randconfig-a004
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220721
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                       mainstone_defconfig
mips                        qi_lb60_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                     akebono_defconfig
mips                      malta_kvm_defconfig
mips                           rs90_defconfig
x86_64                        randconfig-k001
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
hexagon              randconfig-r041-20220721
hexagon              randconfig-r045-20220721
riscv                randconfig-r042-20220721
s390                 randconfig-r044-20220721

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
