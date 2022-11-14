Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24DB628D70
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 00:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236123AbiKNX3z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 18:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236642AbiKNX3y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 18:29:54 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCE6647B
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2022 15:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668468590; x=1700004590;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=sg8BtROonS2xwsc8F5KpKxVIk4540IEdpIct/TmzLZU=;
  b=bUS4606TnHcBGAv6TAMMPoMKyNYHZQLynmGNQsMnH+Tr4cRvVrJh4wP1
   fUy66p7sKJUXwyyDGD0hWzLOlEnvDRT8z/Hf9nmC4iskb9dIv/SMqcdpc
   4bB6jt5NEvDHuOmuBwNkPGcfuDFUPeXbcQgp7ycEaoqp3eAUlaTUFc7Wt
   Vx4EiX3yak4/LDrBLGCIYEgGEyiGzBBhzsEms9kUqpwXm3nOVMdNUy/hM
   mSfxyVrBllalRZ/Ky3DesOyaOEgR2Ff565MfmdSGln4iN5KctSIogj+9g
   vUDNV+XuKJP+L0xufU0elBCGwCNR97Fu+NxLncVTUsFKZwlrFwvByLXGH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="310818936"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="310818936"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 15:29:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="616518087"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="616518087"
Received: from lkp-server01.sh.intel.com (HELO ebd99836cbe0) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 Nov 2022 15:29:48 -0800
Received: from kbuild by ebd99836cbe0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ouitf-0000q0-1d;
        Mon, 14 Nov 2022 23:29:47 +0000
Date:   Tue, 15 Nov 2022 07:29:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/dwc] BUILD SUCCESS
 1d26a55fbeb9c24bb24fa84595c56efee8783f35
Message-ID: <6372cf49.nSGOUc5AFIFWR2dG%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/dwc
branch HEAD: 1d26a55fbeb9c24bb24fa84595c56efee8783f35  PCI: histb: Switch to using gpiod API

elapsed time: 723m

configs tested: 101
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
powerpc                           allnoconfig
s390                             allyesconfig
mips                             allyesconfig
x86_64                           rhel-8.3-kvm
m68k                             allmodconfig
powerpc                          allmodconfig
alpha                            allyesconfig
i386                                defconfig
x86_64                           rhel-8.3-syz
arc                              allyesconfig
x86_64                         rhel-8.3-kunit
sh                               allmodconfig
m68k                             allyesconfig
ia64                             allmodconfig
arc                  randconfig-r043-20221114
i386                 randconfig-a001-20221114
i386                 randconfig-a004-20221114
i386                 randconfig-a002-20221114
i386                 randconfig-a003-20221114
i386                             allyesconfig
i386                 randconfig-a006-20221114
i386                 randconfig-a005-20221114
x86_64                            allnoconfig
x86_64               randconfig-a003-20221114
x86_64               randconfig-a005-20221114
x86_64               randconfig-a004-20221114
x86_64               randconfig-a002-20221114
x86_64               randconfig-a001-20221114
x86_64               randconfig-a006-20221114
powerpc                    adder875_defconfig
ia64                          tiger_defconfig
powerpc                     sequoia_defconfig
sh                          rsk7201_defconfig
mips                      loongson3_defconfig
sh                        edosk7760_defconfig
csky                                defconfig
powerpc                      ppc6xx_defconfig
sh                           se7343_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
xtensa                         virt_defconfig
sh                            shmin_defconfig
xtensa                              defconfig
mips                        vocore2_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                 randconfig-c001-20221114
arm                           sunxi_defconfig
arm                               allnoconfig
loongarch                 loongson3_defconfig
arc                         haps_hs_defconfig
mips                  decstation_64_defconfig
powerpc                    sam440ep_defconfig
sparc64                          alldefconfig
powerpc                     stx_gp3_defconfig
sh                           sh2007_defconfig
loongarch                        allmodconfig
sh                           se7722_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
sh                            hp6xx_defconfig

clang tested configs:
x86_64               randconfig-a012-20221114
x86_64               randconfig-a013-20221114
x86_64               randconfig-a011-20221114
x86_64               randconfig-a014-20221114
x86_64               randconfig-a015-20221114
x86_64               randconfig-a016-20221114
hexagon              randconfig-r045-20221114
hexagon              randconfig-r041-20221114
riscv                randconfig-r042-20221114
s390                 randconfig-r044-20221114
i386                 randconfig-a015-20221114
i386                 randconfig-a013-20221114
i386                 randconfig-a011-20221114
i386                 randconfig-a016-20221114
i386                 randconfig-a012-20221114
i386                 randconfig-a014-20221114
mips                           mtx1_defconfig
powerpc                 mpc8560_ads_defconfig
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64               randconfig-k001-20221114
powerpc                     mpc512x_defconfig
arm                        magician_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
