Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C13C5A0946
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 08:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiHYG5c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 02:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbiHYG5b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 02:57:31 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8B6A1A69
        for <linux-pci@vger.kernel.org>; Wed, 24 Aug 2022 23:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661410650; x=1692946650;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=sxiV11erVrFNFqYdczaK+U5uRkODaLYeZCzsNKlB1sQ=;
  b=GcpUiMAvPdW5MzfQ7jVbsZMJFa2z1MtG+sWInOx5nfua+Pt891f7vC0Q
   a9EXNd7ItL8POAIfXJ+vJ/3uUeGNuio33Jo6UwhrAJqkJghowRigMXRU9
   Ogu+lojHOvgpAL+XtX8PgLQlBduNLN2x6o2z4I+0FSZBYeWaiA5N6/HBn
   1jCpoT13/kxyTu2wGujB4QCQzJWYrLI/UPv9ZjHih2l2dXUpcEql81+2Z
   nkMGole7f7KnxLgQqIlSNVPWPYJjg6Bs4PqLxdKsvqJHEYHHWTTzjSwGs
   6Wur2gq0gPyRI+ViSQ1H9BN+l0YSAM8SxJ5fx2rL0EaydL8pba+0baMgg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="355888792"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="355888792"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 23:57:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="586750043"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 24 Aug 2022 23:57:28 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oR6nv-0001pF-2x;
        Thu, 25 Aug 2022 06:57:27 +0000
Date:   Thu, 25 Aug 2022 14:57:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/dt] BUILD SUCCESS
 1a7966b33b5bbefd950cffef1ea8ee3f5f1bf076
Message-ID: <63071d45.ds86QXoilZgV/qgx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/dt
branch HEAD: 1a7966b33b5bbefd950cffef1ea8ee3f5f1bf076  dt-bindings: PCI: microchip,pcie-host: fix missing dma-ranges

elapsed time: 1150m

configs tested: 164
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
sh                               allmodconfig
mips                             allyesconfig
i386                                defconfig
arc                  randconfig-r043-20220823
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
i386                             allyesconfig
loongarch                           defconfig
loongarch                         allnoconfig
x86_64                           allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arm                       omap2plus_defconfig
arc                          axs101_defconfig
arc                         haps_hs_defconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
sh                          kfr2r09_defconfig
xtensa                          iss_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                             allnoconfig
microblaze                          defconfig
m68k                        mvme16x_defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
sh                        sh7763rdp_defconfig
m68k                          multi_defconfig
arc                      axs103_smp_defconfig
m68k                            mac_defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
arc                        nsim_700_defconfig
sh                   sh7770_generic_defconfig
arm                          gemini_defconfig
arm                            lart_defconfig
m68k                       m5249evb_defconfig
sh                             espt_defconfig
arm64                               defconfig
arm                              allmodconfig
m68k                                defconfig
ia64                                defconfig
mips                             allmodconfig
i386                          randconfig-c001
m68k                            q40_defconfig
ia64                        generic_defconfig
sh                             shx3_defconfig
arc                     nsimosci_hs_defconfig
um                                  defconfig
microblaze                      mmu_defconfig
arm                        realview_defconfig
sh                          r7780mp_defconfig
sh                        edosk7760_defconfig
sh                           se7751_defconfig
powerpc                      arches_defconfig
m68k                        stmark2_defconfig
ia64                          tiger_defconfig
sh                           se7721_defconfig
powerpc                      pcm030_defconfig
arc                    vdk_hs38_smp_defconfig
arm                            zeus_defconfig
s390                          debug_defconfig
ia64                            zx1_defconfig
sh                          rsk7269_defconfig
xtensa                         virt_defconfig
sh                   sh7724_generic_defconfig
powerpc                      makalu_defconfig
arm                            pleb_defconfig
mips                        bcm47xx_defconfig
csky                             alldefconfig
ia64                      gensparse_defconfig
arm                      integrator_defconfig
sh                         apsh4a3a_defconfig
sh                           se7722_defconfig
arm                           viper_defconfig
riscv                randconfig-r042-20220824
s390                 randconfig-r044-20220824
arc                  randconfig-r043-20220824
sh                   secureedge5410_defconfig
sh                         ap325rxa_defconfig
xtensa                    smp_lx200_defconfig
sh                      rts7751r2d1_defconfig
ia64                             allmodconfig
sh                            titan_defconfig
mips                         cobalt_defconfig
powerpc                      tqm8xx_defconfig
mips                    maltaup_xpa_defconfig
sh                         ecovec24_defconfig

clang tested configs:
hexagon              randconfig-r041-20220823
hexagon              randconfig-r045-20220823
riscv                randconfig-r042-20220823
s390                 randconfig-r044-20220823
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
mips                     cu1000-neo_defconfig
powerpc                    gamecube_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220824
hexagon              randconfig-r041-20220824
mips                     decstation_defconfig
mips                           ci20_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-k001
riscv                            alldefconfig
powerpc                      ppc64e_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                     tqm8540_defconfig
arm                      pxa255-idp_defconfig
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
