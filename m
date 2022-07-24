Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DFE57F769
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jul 2022 00:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiGXWsg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Jul 2022 18:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGXWsf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 Jul 2022 18:48:35 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC37CCE30
        for <linux-pci@vger.kernel.org>; Sun, 24 Jul 2022 15:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658702914; x=1690238914;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=TZwe8VklvVKYNdhxQotjEMHMq+MYUHTYiYU0XJvr8uU=;
  b=E/DY7Uj33ZRDw4jbOs9l46WNrHlHyBNanI2F063oJs1APgUhiKTKlGOD
   hAuzkYm4MVl7v5KayhB8i06KJApxE3b/HuZXeEYWGQPBRRp18uTnjVoCR
   ZJzRzYFBKZvF/ZE13YebtKq9g8lz67f9KVT00lVXh72LCrq9cgrm+ykkd
   Sweh2/VAS4vzPrN5P9IXR8kWTXXWhBDeo81J6WsJyn2eF/kUmhvozt4Ez
   24HeXFDoRyQnnd+2ck9mjdH1eJa7oCINmYmwahi809JfRqGxPQx49Qxuo
   LcE3QRDY0jtvbmO5YOmD9NSE/VTB0gOVSYK6p53JTtN0KYe3WSE127fM1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="286335462"
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="286335462"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 15:48:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="549769635"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 Jul 2022 15:48:32 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFkOm-0004NS-0r;
        Sun, 24 Jul 2022 22:48:32 +0000
Date:   Mon, 25 Jul 2022 06:48:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/ctrl/loongson] BUILD SUCCESS
 930c6074d7dd579f3d4e8b04548dd8cb0341de1d
Message-ID: <62ddcc20.022IEkjnfm0fe8R+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ctrl/loongson
branch HEAD: 930c6074d7dd579f3d4e8b04548dd8cb0341de1d  PCI: loongson: Work around LS7A incorrect Interrupt Pin registers

elapsed time: 4559m

configs tested: 104
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                          randconfig-c001
arc                        nsim_700_defconfig
sparc                       sparc64_defconfig
s390                             allmodconfig
m68k                       bvme6000_defconfig
m68k                          atari_defconfig
sh                          r7785rp_defconfig
m68k                                defconfig
powerpc                 mpc834x_itx_defconfig
m68k                        m5407c3_defconfig
mips                           jazz_defconfig
powerpc                 mpc8540_ads_defconfig
openrisc                 simple_smp_defconfig
nios2                         3c120_defconfig
sh                        apsh4ad0a_defconfig
powerpc                     pq2fads_defconfig
alpha                            alldefconfig
openrisc                            defconfig
arm                           corgi_defconfig
arc                    vdk_hs38_smp_defconfig
arm                         at91_dt_defconfig
powerpc                      mgcoge_defconfig
sh                           se7751_defconfig
alpha                               defconfig
parisc64                         alldefconfig
sh                           se7724_defconfig
sparc64                             defconfig
powerpc                       ppc64_defconfig
mips                           ci20_defconfig
loongarch                         allnoconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
s390                                defconfig
arc                                 defconfig
s390                             allyesconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
loongarch                           defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
x86_64                        randconfig-c001
arm                  randconfig-c002-20220721
arm                  randconfig-c002-20220722
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220721
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc                     akebono_defconfig
arm                  colibri_pxa300_defconfig
hexagon                             defconfig
arm                        multi_v5_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220721
hexagon              randconfig-r045-20220721
riscv                randconfig-r042-20220721
s390                 randconfig-r044-20220721

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
