Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA12B4DDC42
	for <lists+linux-pci@lfdr.de>; Fri, 18 Mar 2022 15:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236821AbiCRO4O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Mar 2022 10:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbiCRO4O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Mar 2022 10:56:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DB6A1463
        for <linux-pci@vger.kernel.org>; Fri, 18 Mar 2022 07:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647615295; x=1679151295;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=27x370P+7SOsyFEjptX1adqJo6ovQ4nfiW0rBminpt8=;
  b=Z9HCaWc8iL6LHX4OgmCLgeqi99YRnUD2ZElpelPTcMGiXZVXyEPyfzse
   6p8AUCQ3nsvktropw8/4PxHVGGCdAMVb+OFo4WEvsdxW+5J8FBMhH2tsQ
   Cgcb5Q+6B7Ayid9N1M9aaStFwLoUlca6tKHlIsYYa+C0HILJ16u7uMSZH
   rbnq+Ds/CHPsc4shsn1dc7AP40OQ0mn/IE5+kReSEJv8SElPUITfadJwv
   xCQeYcAfeGUfX14Y3gReTH0Mwj6pQnUW9osU8zDSIAGQGvBAe230Xj/le
   gsQxn05OiiRLDJsjnDUtK78sV7kEhxUG3skb4jvMTUOYa+Zi00FzR1hLu
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="343583620"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="343583620"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 07:54:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="513896262"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 18 Mar 2022 07:54:41 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVE01-000Eq7-8o; Fri, 18 Mar 2022 14:54:41 +0000
Date:   Fri, 18 Mar 2022 22:54:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 d79e394c7ba5149b242467d29c9a539633b4c0ee
Message-ID: <62349d1e.J5oH6nTYNIHZfX/C%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: d79e394c7ba5149b242467d29c9a539633b4c0ee  Merge branch 'remotes/lorenzo/pci/uniphier'

elapsed time: 728m

configs tested: 140
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
mips                           gcw0_defconfig
m68k                          atari_defconfig
sh                        edosk7705_defconfig
arm                             pxa_defconfig
sh                               alldefconfig
nios2                         10m50_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                     tqm8548_defconfig
xtensa                              defconfig
arm                           corgi_defconfig
sh                           se7724_defconfig
s390                             allyesconfig
powerpc                      bamboo_defconfig
sh                              ul2_defconfig
um                             i386_defconfig
arc                              allyesconfig
mips                  decstation_64_defconfig
mips                      loongson3_defconfig
mips                      maltasmvp_defconfig
openrisc                  or1klitex_defconfig
alpha                            alldefconfig
powerpc                     tqm8555_defconfig
powerpc                      pcm030_defconfig
sh                ecovec24-romimage_defconfig
sparc                            alldefconfig
powerpc                       holly_defconfig
mips                       capcella_defconfig
arm                            qcom_defconfig
arc                      axs103_smp_defconfig
powerpc                mpc7448_hpc2_defconfig
m68k                       m5208evb_defconfig
sparc64                             defconfig
powerpc                        warp_defconfig
powerpc64                           defconfig
mips                           jazz_defconfig
x86_64                              defconfig
arm                        clps711x_defconfig
riscv                               defconfig
sh                          rsk7201_defconfig
powerpc                      pasemi_defconfig
powerpc                      mgcoge_defconfig
powerpc                     ep8248e_defconfig
sh                            titan_defconfig
powerpc                     sequoia_defconfig
mips                         tb0226_defconfig
sparc                               defconfig
sh                   sh7770_generic_defconfig
m68k                            q40_defconfig
mips                     decstation_defconfig
mips                           xway_defconfig
sh                            migor_defconfig
arm                  randconfig-c002-20220318
arm                  randconfig-c002-20220317
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220318
s390                 randconfig-c005-20220318
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220318
riscv                randconfig-c006-20220318
mips                 randconfig-c004-20220318
i386                          randconfig-c001
arm                  randconfig-c002-20220317
riscv                randconfig-c006-20220317
powerpc              randconfig-c003-20220317
mips                 randconfig-c004-20220317
s390                 randconfig-c005-20220317
powerpc                      ppc44x_defconfig
powerpc                     mpc512x_defconfig
riscv                            alldefconfig
mips                      maltaaprp_defconfig
mips                     loongson1c_defconfig
powerpc                 mpc836x_mds_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220318
hexagon              randconfig-r045-20220317
hexagon              randconfig-r041-20220318
riscv                randconfig-r042-20220318
hexagon              randconfig-r041-20220317
s390                 randconfig-r044-20220318

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
