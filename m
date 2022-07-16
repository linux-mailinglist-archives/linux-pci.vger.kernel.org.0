Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA36E576CAC
	for <lists+linux-pci@lfdr.de>; Sat, 16 Jul 2022 11:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiGPJBK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Jul 2022 05:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiGPJBJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jul 2022 05:01:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74ACD20F6E
        for <linux-pci@vger.kernel.org>; Sat, 16 Jul 2022 02:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657962066; x=1689498066;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=L9mehp/hSVQkiJrYRMNEonxUniyC9iBvKlRarh2qMYA=;
  b=Gc42APeql1OfZF8qsKUULtZJ5m3waZf2mZ44v1suRfkp+w0Rh1q61IoC
   majAYgh/2UJWR8ksJ3tLPsyN/nvUCAAr5SE4CDo5tohM2xnb8dPdoUDnT
   7+ZfBf8E+LtKpcI5ZPZS7/dpz8/br5CD2Rrjb1kVXJEIXRTa0hCOg0hsS
   ioO59VFA+8PL1edJCMiqMRLsghzaX2Cu1UJHDz25CeCZ545u7rqzpbRLE
   f/wrq70yPVvJKiG8yuGqirE7E3RoQeFHVOa0kVUQi+yseh8Yi2WpqIPeB
   DimkcxwrfWz1SU+ZnBV/q7NJVN3qeGTT7StZFwWkoOnYUEp0Ne8tfYOoC
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="347648294"
X-IronPort-AV: E=Sophos;i="5.92,276,1650956400"; 
   d="scan'208";a="347648294"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 02:01:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,276,1650956400"; 
   d="scan'208";a="773238174"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 16 Jul 2022 02:01:04 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCdfc-0001Jt-8R;
        Sat, 16 Jul 2022 09:01:04 +0000
Date:   Sat, 16 Jul 2022 17:00:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/ctrl/qcom] BUILD SUCCESS
 839fbdee4c080eb95567cbcf6366072a56d3a3cc
Message-ID: <62d27e47.Nizq6B+8sEX+PpGW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ctrl/qcom
branch HEAD: 839fbdee4c080eb95567cbcf6366072a56d3a3cc  dt-bindings: PCI: qcom: Fix reset conditional

elapsed time: 722m

configs tested: 105
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arm                      footbridge_defconfig
xtensa                              defconfig
openrisc                    or1ksim_defconfig
arm                        mvebu_v7_defconfig
powerpc                 mpc85xx_cds_defconfig
parisc                generic-32bit_defconfig
s390                       zfcpdump_defconfig
m68k                             alldefconfig
arm                     eseries_pxa_defconfig
sh                         ap325rxa_defconfig
arm                          gemini_defconfig
arm                           sama5_defconfig
xtensa                generic_kc705_defconfig
mips                           jazz_defconfig
arm                          simpad_defconfig
arm                       multi_v4t_defconfig
powerpc                     ep8248e_defconfig
sh                        sh7763rdp_defconfig
mips                    maltaup_xpa_defconfig
xtensa                    xip_kc705_defconfig
powerpc                     tqm8555_defconfig
sh                        sh7785lcr_defconfig
ia64                             alldefconfig
openrisc                 simple_smp_defconfig
sh                           se7721_defconfig
m68k                        mvme147_defconfig
sh                          polaris_defconfig
powerpc                  storcenter_defconfig
arc                            hsdk_defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
i386                             allyesconfig
arm                    vt8500_v6_v7_defconfig
mips                      pic32mzda_defconfig
mips                           mtx1_defconfig
powerpc                      ppc64e_defconfig
arm                       aspeed_g4_defconfig
arm                          moxart_defconfig
powerpc                     ppa8548_defconfig
mips                      maltaaprp_defconfig
arm                        mvebu_v5_defconfig
arm                         bcm2835_defconfig
riscv                          rv32_defconfig
mips                  cavium_octeon_defconfig
arm                       netwinder_defconfig
mips                       lemote2f_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                    ge_imp3a_defconfig
arm                          collie_defconfig
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
hexagon              randconfig-r045-20220715
s390                 randconfig-r044-20220715
hexagon              randconfig-r041-20220715
riscv                randconfig-r042-20220715

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
