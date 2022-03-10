Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354804D4D4D
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 16:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239142AbiCJPib (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 10:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239162AbiCJPia (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 10:38:30 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99474BBA
        for <linux-pci@vger.kernel.org>; Thu, 10 Mar 2022 07:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646926648; x=1678462648;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=80sXWyDCDvGiThmLJ6x0ZV/xOUxTVrQf0duEoaQpub0=;
  b=M5s4aiIc8OVvIXBX/4UTZpYBZGTBv4R8JghTb4IucPI3bJkYWnOVEeUA
   Bx0U9+lkQ1bqD2bs1O+DrVhSwLctjE1qVaeOUMUzkJ2KD9TfBkUeWf2pg
   PzhmFEgJ+VjQpMjEmwK2CWjJhQTZbqPqCHOtoAqDh4461DD7PXDmo4jC9
   YLOzNFMtfIN7yFh7nsLd0yVpSXzlE67TwAQIzMOFniOFaglFaUkIM9DL7
   q1BuA39gKg1stjBBp7Klhw9dMWwpCCJHZickMKEwb6Ol8z0cOrpnXwhbS
   oeL1b2LVD3HNbDcmUumL+yp8rb5HAVHE9IOicDJt3q5PHLJHj28DfPBLg
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="235885079"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="235885079"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 07:37:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="510939403"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 10 Mar 2022 07:37:26 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSKr0-000557-6D; Thu, 10 Mar 2022 15:37:26 +0000
Date:   Thu, 10 Mar 2022 23:36:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/host/rcar] BUILD SUCCESS
 e2502d3a7d35825478e8ced97ccbf34b20c6691f
Message-ID: <622a1af7.UI3C5hQpUGhJBR9P%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/host/rcar
branch HEAD: e2502d3a7d35825478e8ced97ccbf34b20c6691f  PCI: rcar: Finish transition to L1 state in rcar_pcie_config_access()

elapsed time: 731m

configs tested: 128
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220310
sh                               j2_defconfig
m68k                       m5249evb_defconfig
m68k                             allyesconfig
m68k                         apollo_defconfig
arm                            lart_defconfig
sparc                            alldefconfig
sh                        apsh4ad0a_defconfig
h8300                       h8s-sim_defconfig
mips                            gpr_defconfig
mips                 decstation_r4k_defconfig
sh                          rsk7203_defconfig
sh                ecovec24-romimage_defconfig
arm                          lpd270_defconfig
sh                          lboxre2_defconfig
mips                     loongson1b_defconfig
sparc                               defconfig
m68k                        mvme16x_defconfig
arm                           h5000_defconfig
um                               alldefconfig
xtensa                    xip_kc705_defconfig
sh                     magicpanelr2_defconfig
m68k                                defconfig
arm                           corgi_defconfig
powerpc                 linkstation_defconfig
m68k                        m5407c3_defconfig
sh                            titan_defconfig
mips                           ci20_defconfig
sh                           se7780_defconfig
h8300                               defconfig
riscv                            allmodconfig
csky                                defconfig
powerpc                        warp_defconfig
ia64                         bigsur_defconfig
arm                        oxnas_v6_defconfig
sh                         ap325rxa_defconfig
sh                          kfr2r09_defconfig
sh                        edosk7760_defconfig
sh                          r7785rp_defconfig
arm                             ezx_defconfig
arm                  randconfig-c002-20220310
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
alpha                            allyesconfig
alpha                               defconfig
nds32                               defconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                                defconfig
parisc64                            defconfig
s390                             allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a003
x86_64                        randconfig-a015
i386                          randconfig-a016
arc                  randconfig-r043-20220310
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
powerpc              randconfig-c003-20220310
riscv                randconfig-c006-20220310
arm                  randconfig-c002-20220310
x86_64                        randconfig-c007
mips                 randconfig-c004-20220310
i386                          randconfig-c001
arm                         socfpga_defconfig
arm                    vt8500_v6_v7_defconfig
arm                        multi_v5_defconfig
powerpc                      ppc44x_defconfig
mips                     loongson2k_defconfig
powerpc                     akebono_defconfig
mips                      malta_kvm_defconfig
mips                          ath79_defconfig
riscv                    nommu_virt_defconfig
arm                     am200epdkit_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                          rm200_defconfig
powerpc                     ksi8560_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220310
hexagon              randconfig-r041-20220310
riscv                randconfig-r042-20220310
s390                 randconfig-r044-20220310

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
