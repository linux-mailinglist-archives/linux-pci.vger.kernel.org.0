Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EEE5A0719
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 04:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbiHYCGL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Aug 2022 22:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbiHYCGK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Aug 2022 22:06:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B2930F64
        for <linux-pci@vger.kernel.org>; Wed, 24 Aug 2022 19:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661393168; x=1692929168;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=TDqmBq++VTjOpBVtWHUifLlR23VWpbA7vX+YnyOtafA=;
  b=aIItmUZRCPXcMFDsv8v8pDQDRjyURxt2zhF4dc6sB0ueUTLQf+6CDeDJ
   tKKIdqDktynnXplB0OVIwcHalCdZKpu/XfFFB8GQ3BcTDvBQGNsu9H6J/
   5/tchJGK8tp3ELr3T5D7lNhiAYVVHOeLRBQcgaRIfC4sSUD6BKJJBAVJQ
   36AnIt+/rl2H3/vTxhKfN6rNM0/YOXqZ+8Y6zIVC6Jh3PDAxmUfXzNJYJ
   Dmh9qbXENuz4dkchJh+El7LsNTCs19kgNUsfsvKALz4Gn1fdqGPiVTVtf
   DY5gsyBbMStLd1Y6bHKVZeY/DfF8RPInQe2pGOzA96uYOaMKvJ9JN8CHI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="273875873"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="273875873"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 19:06:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="639382894"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 24 Aug 2022 19:06:05 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oR2Fx-0001bY-0d;
        Thu, 25 Aug 2022 02:06:05 +0000
Date:   Thu, 25 Aug 2022 10:05:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/mediatek] BUILD SUCCESS
 034fdac01fe5184e63d8af901ddb9c9a329f6902
Message-ID: <6306d8fa.qbte/zYLZWqk3hI7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/mediatek
branch HEAD: 034fdac01fe5184e63d8af901ddb9c9a329f6902  PCI: mediatek-gen3: Change driver name to mtk-pcie-gen3

elapsed time: 2188m

configs tested: 189
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
sh                               allmodconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
powerpc                          allmodconfig
mips                             allyesconfig
loongarch                           defconfig
loongarch                         allnoconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
i386                             allyesconfig
i386                                defconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
ia64                         bigsur_defconfig
m68k                        m5272c3_defconfig
parisc                           alldefconfig
powerpc                     tqm8555_defconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                       omap2plus_defconfig
arc                          axs101_defconfig
arc                         haps_hs_defconfig
i386                          randconfig-c001
sh                           se7724_defconfig
arm                         lubbock_defconfig
powerpc                   currituck_defconfig
arc                        nsim_700_defconfig
sh                   sh7770_generic_defconfig
arm                          gemini_defconfig
m68k                          atari_defconfig
sh                          sdk7786_defconfig
powerpc                    klondike_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
sparc                             allnoconfig
microblaze                          defconfig
m68k                        mvme16x_defconfig
m68k                            mac_defconfig
sh                        sh7763rdp_defconfig
m68k                          multi_defconfig
arc                      axs103_smp_defconfig
arm                            hisi_defconfig
um                                  defconfig
sh                     sh7710voipgw_defconfig
parisc64                         alldefconfig
sh                          kfr2r09_defconfig
xtensa                          iss_defconfig
arm                           h5000_defconfig
ia64                                defconfig
arm64                               defconfig
arm                              allmodconfig
m68k                                defconfig
mips                             allmodconfig
ia64                             allmodconfig
m68k                            q40_defconfig
ia64                        generic_defconfig
sh                             shx3_defconfig
arc                     nsimosci_hs_defconfig
powerpc                      tqm8xx_defconfig
m68k                        stmark2_defconfig
m68k                         apollo_defconfig
arm                        shmobile_defconfig
ia64                          tiger_defconfig
mips                      loongson3_defconfig
arm                             rpc_defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
arm                            lart_defconfig
m68k                       m5249evb_defconfig
sh                             espt_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220824
microblaze                      mmu_defconfig
arm                        realview_defconfig
sh                          r7780mp_defconfig
sh                        edosk7760_defconfig
sh                           se7751_defconfig
powerpc                      arches_defconfig
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
sh                            titan_defconfig
mips                         cobalt_defconfig

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
mips                     cu1000-neo_defconfig
powerpc                    gamecube_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
hexagon              randconfig-r045-20220823
riscv                randconfig-r042-20220823
hexagon              randconfig-r041-20220823
s390                 randconfig-r044-20220823
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-k001
mips                     loongson1c_defconfig
powerpc                     ppa8548_defconfig
powerpc                  mpc866_ads_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
arm                            mmp2_defconfig
powerpc                     powernv_defconfig
hexagon              randconfig-r045-20220824
hexagon              randconfig-r041-20220824
mips                        omega2p_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                        neponset_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                          g5_defconfig
mips                     decstation_defconfig
mips                           ci20_defconfig
riscv                            alldefconfig
powerpc                      ppc64e_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                     tqm8540_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
