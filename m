Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5404524F2C
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 16:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354891AbiELOBc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 10:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354903AbiELOBa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 10:01:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC2651331
        for <linux-pci@vger.kernel.org>; Thu, 12 May 2022 07:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652364089; x=1683900089;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=NP+Y6nEHLDoBsLksGTg9GC3dDXpnq1m5aK6kFAd8zRQ=;
  b=RXI+uyrF5K56ACEf/KmgKEM9Ad2FlAKhMoEi/jLNoerxOW+RpRIej9yj
   n6FbelUehOrdDok0DEyYub5iUVvqvsvegH0PTuSI1MkfgVJBX7dckKUKt
   9WgTj3WRHE8wSMUdtFJWwZdi0DigmQdJOm8c1u0oWL/xWdid9nKsMS4V/
   FRP+Y3xpRz1g4Wd0p5NHwBMj/2M5bq5fdak5ITtyAH+JCqaXj1hAdxFvg
   CF/m210xLJNY7WAEfvYayeJHQR0jgYYYyShVM8DTzm6z1ZFDQyO8th1ez
   CqqrprBH0g5+yUNiQvnclJEI55Ccn/2QUFEje7ZRrmHgfP1qwDDUhwbvy
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="333045024"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="333045024"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 07:01:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="520958277"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 12 May 2022 07:01:26 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1np9Nd-000KVr-D5;
        Thu, 12 May 2022 14:01:25 +0000
Date:   Thu, 12 May 2022 22:01:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/virtualization] BUILD SUCCESS
 a91ee0e9fca9d7501286cfbced9b30a33e52740a
Message-ID: <627d1322.LSWfleHOS/FkFR4J%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/virtualization
branch HEAD: a91ee0e9fca9d7501286cfbced9b30a33e52740a  PCI: Avoid pci_dev_lock() AB/BA deadlock with sriov_numvfs_store()

elapsed time: 930m

configs tested: 218
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
i386                 randconfig-c001-20220509
arm                         lpc18xx_defconfig
sh                          rsk7269_defconfig
mips                          rb532_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc64                           defconfig
sh                        edosk7760_defconfig
arc                          axs101_defconfig
h8300                       h8s-sim_defconfig
xtensa                generic_kc705_defconfig
xtensa                         virt_defconfig
um                                  defconfig
m68k                       m5249evb_defconfig
sh                          urquell_defconfig
ia64                         bigsur_defconfig
arm                            pleb_defconfig
xtensa                          iss_defconfig
arc                        nsim_700_defconfig
powerpc                 linkstation_defconfig
powerpc                       eiger_defconfig
arm                           h3600_defconfig
arm                          iop32x_defconfig
arm                         cm_x300_defconfig
um                               alldefconfig
xtensa                  cadence_csp_defconfig
arm                         at91_dt_defconfig
sh                          r7785rp_defconfig
sh                                  defconfig
powerpc                  storcenter_defconfig
sparc                       sparc64_defconfig
arm                       aspeed_g5_defconfig
ia64                        generic_defconfig
xtensa                  nommu_kc705_defconfig
sh                           se7721_defconfig
m68k                             allmodconfig
sh                           sh2007_defconfig
i386                                defconfig
sh                          polaris_defconfig
sh                            hp6xx_defconfig
sparc                            alldefconfig
arc                         haps_hs_defconfig
m68k                          multi_defconfig
sh                          sdk7780_defconfig
s390                             allyesconfig
nios2                         10m50_defconfig
openrisc                 simple_smp_defconfig
sh                         ecovec24_defconfig
mips                  maltasmvp_eva_defconfig
sparc                       sparc32_defconfig
sh                           se7750_defconfig
arm                          exynos_defconfig
s390                       zfcpdump_defconfig
arc                          axs103_defconfig
m68k                       m5208evb_defconfig
powerpc                      pcm030_defconfig
mips                       capcella_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                     taishan_defconfig
mips                            ar7_defconfig
xtensa                    smp_lx200_defconfig
sh                         microdev_defconfig
arm                          simpad_defconfig
xtensa                       common_defconfig
m68k                        m5272c3_defconfig
powerpc                 mpc837x_mds_defconfig
parisc                generic-32bit_defconfig
alpha                            allyesconfig
m68k                        mvme147_defconfig
powerpc                        cell_defconfig
ia64                                defconfig
openrisc                            defconfig
sh                          lboxre2_defconfig
sh                           se7722_defconfig
openrisc                  or1klitex_defconfig
m68k                        m5407c3_defconfig
riscv                               defconfig
xtensa                           alldefconfig
powerpc                   currituck_defconfig
sh                     sh7710voipgw_defconfig
ia64                          tiger_defconfig
sh                        apsh4ad0a_defconfig
powerpc                      ep88xc_defconfig
powerpc                         ps3_defconfig
arm                             rpc_defconfig
arm                        spear6xx_defconfig
sh                           se7724_defconfig
sh                          rsk7203_defconfig
sh                      rts7751r2d1_defconfig
powerpc                     tqm8548_defconfig
openrisc                         alldefconfig
powerpc                 mpc834x_itx_defconfig
powerpc                      cm5200_defconfig
x86_64               randconfig-c001-20220509
arm                  randconfig-c002-20220509
x86_64                        randconfig-c001
arm                  randconfig-c002-20220512
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
arc                                 defconfig
h8300                            allyesconfig
xtensa                           allyesconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64               randconfig-a015-20220509
x86_64               randconfig-a012-20220509
x86_64               randconfig-a016-20220509
x86_64               randconfig-a014-20220509
x86_64               randconfig-a013-20220509
x86_64               randconfig-a011-20220509
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                 randconfig-a011-20220509
i386                 randconfig-a013-20220509
i386                 randconfig-a016-20220509
i386                 randconfig-a015-20220509
i386                 randconfig-a014-20220509
i386                 randconfig-a012-20220509
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220509
s390                 randconfig-r044-20220509
riscv                randconfig-r042-20220509
s390                 randconfig-r044-20220512
riscv                randconfig-r042-20220512
arc                  randconfig-r043-20220512
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
s390                 randconfig-c005-20220512
powerpc              randconfig-c003-20220512
x86_64                        randconfig-c007
riscv                randconfig-c006-20220512
mips                 randconfig-c004-20220512
i386                          randconfig-c001
arm                  randconfig-c002-20220512
x86_64               randconfig-c007-20220509
s390                 randconfig-c005-20220509
i386                 randconfig-c001-20220509
powerpc              randconfig-c003-20220509
riscv                randconfig-c006-20220509
mips                 randconfig-c004-20220509
arm                  randconfig-c002-20220509
powerpc                      acadia_defconfig
mips                       rbtx49xx_defconfig
mips                        maltaup_defconfig
mips                      maltaaprp_defconfig
mips                        omega2p_defconfig
arm                  colibri_pxa300_defconfig
arm                       versatile_defconfig
powerpc                     ppa8548_defconfig
arm                         shannon_defconfig
powerpc                    mvme5100_defconfig
x86_64               randconfig-a006-20220509
x86_64               randconfig-a002-20220509
x86_64               randconfig-a001-20220509
x86_64               randconfig-a004-20220509
x86_64               randconfig-a005-20220509
x86_64               randconfig-a003-20220509
i386                 randconfig-a004-20220509
i386                 randconfig-a006-20220509
i386                 randconfig-a002-20220509
i386                 randconfig-a003-20220509
i386                 randconfig-a001-20220509
i386                 randconfig-a005-20220509
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
hexagon              randconfig-r045-20220509
hexagon              randconfig-r041-20220509
hexagon              randconfig-r045-20220512
hexagon              randconfig-r041-20220512

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
