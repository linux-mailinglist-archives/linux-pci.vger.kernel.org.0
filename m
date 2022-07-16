Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E848576C46
	for <lists+linux-pci@lfdr.de>; Sat, 16 Jul 2022 08:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiGPGyF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Jul 2022 02:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGPGyE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jul 2022 02:54:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE2319C1D
        for <linux-pci@vger.kernel.org>; Fri, 15 Jul 2022 23:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657954443; x=1689490443;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ecyCQdjimfk87Z5cT9E2QvZy+Wl6fLzOs3mNzXcNakM=;
  b=gB4olANxWZsPeWW4T7vct2R8RufWgAWl4lHFAH4yVInmiX7d7mLfvjK/
   RM1cxF3RbIs0QKF07WA19D3mtXOFZUuHA614rDVm0pt5xy/GrQux8uNHu
   et5/0wOG3u5ekrvBkztMJg6fdIqpdIEEyv+6B+E0Dv1hnBSQuhdHxlhMr
   //EIR7QGXgVt0cYEN9fAwNzGHgKEjgevjJmynGUs3liparUU4QJax06oF
   mJo+jQ0JQFU0EwkfLI7j8Sax0Z9kYll/EwLGTjp1PbINZmtn8xgbAyfag
   TH6zOZyP1mEzOhIi2F0zbq8siUo/ayShcmlevmgg5FZPcL4K5QPLhC5tM
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="265742809"
X-IronPort-AV: E=Sophos;i="5.92,276,1650956400"; 
   d="scan'208";a="265742809"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 23:54:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,276,1650956400"; 
   d="scan'208";a="571811698"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Jul 2022 23:54:01 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCbgf-0001FL-4N;
        Sat, 16 Jul 2022 06:54:01 +0000
Date:   Sat, 16 Jul 2022 14:53:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/err] BUILD SUCCESS
 5e6ae050955b566484f3cc6a66e3925eae87a0ed
Message-ID: <62d2606b.nV7HXufbTiYveROG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/err
branch HEAD: 5e6ae050955b566484f3cc6a66e3925eae87a0ed  PCI/AER: Iterate over error counters instead of error strings

elapsed time: 3541m

configs tested: 149
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
sparc                             allnoconfig
arm                           h3600_defconfig
mips                         cobalt_defconfig
sh                        sh7785lcr_defconfig
arm                        mvebu_v7_defconfig
powerpc                 mpc85xx_cds_defconfig
parisc                generic-32bit_defconfig
m68k                       m5275evb_defconfig
arm                        oxnas_v6_defconfig
arm                     eseries_pxa_defconfig
sh                         ap325rxa_defconfig
arm                          gemini_defconfig
arm                           sama5_defconfig
xtensa                generic_kc705_defconfig
arm                        clps711x_defconfig
powerpc                      pcm030_defconfig
m68k                          atari_defconfig
arc                          axs103_defconfig
powerpc                     pq2fads_defconfig
arm                             ezx_defconfig
mips                           jazz_defconfig
arm                          simpad_defconfig
arm                       multi_v4t_defconfig
sh                             sh03_defconfig
m68k                        m5272c3_defconfig
arc                                 defconfig
arm                         at91_dt_defconfig
nios2                            allyesconfig
alpha                             allnoconfig
sh                           se7343_defconfig
sh                             espt_defconfig
powerpc                 mpc8540_ads_defconfig
arm                           viper_defconfig
sh                        edosk7705_defconfig
powerpc                     redwood_defconfig
arm                       aspeed_g5_defconfig
sh                               alldefconfig
openrisc                            defconfig
x86_64                                  kexec
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
s390                                defconfig
s390                             allmodconfig
alpha                               defconfig
s390                             allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220715
csky                              allnoconfig
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
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
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
mips                          ath79_defconfig
arm                            dove_defconfig
arm                           spitz_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                     tqm8560_defconfig
arm                      pxa255-idp_defconfig
mips                        workpad_defconfig
powerpc                          g5_defconfig
powerpc                    gamecube_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                    mvme5100_defconfig
arm                        vexpress_defconfig
arm                   milbeaut_m10v_defconfig
s390                             alldefconfig
powerpc                   lite5200b_defconfig
arm                          pcm027_defconfig
arm                       cns3420vb_defconfig
mips                      malta_kvm_defconfig
powerpc                        fsp2_defconfig
hexagon                             defconfig
powerpc                      ppc44x_defconfig
mips                           ip28_defconfig
powerpc                     ppa8548_defconfig
powerpc                     kilauea_defconfig
powerpc                          allyesconfig
mips                       rbtx49xx_defconfig
mips                        omega2p_defconfig
arm                          moxart_defconfig
powerpc                     mpc512x_defconfig
mips                     cu1000-neo_defconfig
arm                         orion5x_defconfig
powerpc                      pmac32_defconfig
arm                         socfpga_defconfig
riscv                            alldefconfig
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
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220714
hexagon              randconfig-r041-20220714
hexagon              randconfig-r045-20220715
s390                 randconfig-r044-20220715
hexagon              randconfig-r041-20220715
riscv                randconfig-r042-20220715

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
