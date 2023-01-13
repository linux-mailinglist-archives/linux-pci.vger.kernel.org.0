Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B7D668C0C
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 07:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240194AbjAMGA3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 01:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240742AbjAMF6z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 00:58:55 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3C96E0E8
        for <linux-pci@vger.kernel.org>; Thu, 12 Jan 2023 21:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673589250; x=1705125250;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=HfL4UAU8MbTLy4wbbtmyRiTUfLkaBU+UJvympxLEXkM=;
  b=DEmnCD90kfmR421Si8aovF1x4pvq1EpTfsdLnynkeDeD7DKiiQh4QBI7
   aTnkmpVpGWpZGCbILaK0cHfB3empGdamPxHh5h2Eh5Y5xvHraU3aMsZ6r
   JPAKlvaIIwFlY0hOkKSeMdkzFxXnMqjZXkVTg5wAskOqrm2neSxpkIVla
   TwlIFQjpqXYOjjGa9Cs0QFOmVgFeiTjIUes74nb4nuiv6o7O6i6v6LUWe
   6oZlS5KmumnyNPvLfR5O2iEIbtzxU1yLF7UG+uNHkSO2nE0lz1fHB1/Pj
   aynYDAXWgAjPvC3+Bl/FhidNWpaN5xw+it7u/ylf8ZUWOBNGoU/79Cill
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="323980755"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="323980755"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 21:54:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="688630260"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="688630260"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 12 Jan 2023 21:54:07 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pGD0x-000AnS-0M;
        Fri, 13 Jan 2023 05:54:07 +0000
Date:   Fri, 13 Jan 2023 13:53:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:for-linus] BUILD SUCCESS
 ac729baefdc3d62076ca67f81f8bc225ba3e0ffa
Message-ID: <63c0f1d2.HIpl/BK1qEkOwCYU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
branch HEAD: ac729baefdc3d62076ca67f81f8bc225ba3e0ffa  x86/pci: Treat EfiMemoryMappedIO as reservation of ECAM space

elapsed time: 727m

configs tested: 93
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
arc                                 defconfig
m68k                             allyesconfig
alpha                               defconfig
powerpc                           allnoconfig
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
x86_64                            allnoconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
ia64                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
riscv                randconfig-r042-20230112
s390                 randconfig-r044-20230112
arc                  randconfig-r043-20230112
i386                             allyesconfig
i386                                defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
arm                          pxa3xx_defconfig
sh                         ap325rxa_defconfig
sh                         microdev_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arm                           h3600_defconfig
arm                               allnoconfig
alpha                            alldefconfig
arc                              alldefconfig
sparc                       sparc64_defconfig
sh                        apsh4ad0a_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                      integrator_defconfig
sh                           se7721_defconfig
m68k                          atari_defconfig
arc                          axs103_defconfig
m68k                       bvme6000_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
arm                        realview_defconfig
mips                            ar7_defconfig
arm                            zeus_defconfig
arc                            hsdk_defconfig
sh                        edosk7760_defconfig
arc                      axs103_smp_defconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-k001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
powerpc                      walnut_defconfig
s390                             alldefconfig
mips                       rbtx49xx_defconfig
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
