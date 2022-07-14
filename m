Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85165744E1
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 08:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiGNGLE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 02:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiGNGLD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 02:11:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBE7111C
        for <linux-pci@vger.kernel.org>; Wed, 13 Jul 2022 23:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657779062; x=1689315062;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=JNBVTTRr2wcPHZwojPq6LccpeJ24ir5IEBEco6u3UyE=;
  b=LfAH3akBRwP9vj3ln+s++0OzClZsThG7Kk8WZfzDLfomSSmuFUvJsD2Q
   uZQvcRHN30iYc2ifeFEWh3jjDIEH+09v7DYbTAlbkT4EvJgD8o1/kcSuu
   Btl2DFoBcapx6/kqgWiumisGy5HI7nLW7MvwGr2NqFs7IBN13StrC19y2
   ti+KVthGIrcnzesaInPZUbIZ3AGbyo4HuXz4CRubUoUBjoyUPdVIWHHXA
   IdExe8WerRqeNy1ooC0hF043I8Kn0Tx8ICFrHmnCwdIRH9qKN6//KxAZg
   HE52KDWc9apjpA0aC6z1O4/WtG2xWgJrtw1+fPTzdXvC5c4AmhDPIZ4PO
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="371737801"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="371737801"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 23:11:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="546145509"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 13 Jul 2022 23:11:01 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBs3w-0000H6-O9;
        Thu, 14 Jul 2022 06:11:00 +0000
Date:   Thu, 14 Jul 2022 14:10:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/aspm] BUILD SUCCESS
 ba13d4575da5e656a3cbc18583e0da5c5d865417
Message-ID: <62cfb34d.e2dr7bOEKgK9oorf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/aspm
branch HEAD: ba13d4575da5e656a3cbc18583e0da5c5d865417  PCI/ASPM: Unexport pcie_aspm_support_enabled()

elapsed time: 2003m

configs tested: 73
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
sh                         apsh4a3a_defconfig
sh                           se7751_defconfig
arm                         nhk8815_defconfig
arm                        trizeps4_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                           gcw0_defconfig
arm64                            alldefconfig
nios2                         3c120_defconfig
arc                 nsimosci_hs_smp_defconfig
xtensa                  nommu_kc705_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                    adder875_defconfig
m68k                            q40_defconfig
arm                           imxrt_defconfig
powerpc                   motionpro_defconfig
xtensa                    smp_lx200_defconfig
parisc                generic-32bit_defconfig
ia64                             allmodconfig
m68k                             allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
sh                               allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a004
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220713
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz

clang tested configs:
powerpc                     tqm5200_defconfig
mips                           ip27_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r041-20220710
hexagon              randconfig-r045-20220710
hexagon              randconfig-r041-20220713
hexagon              randconfig-r045-20220713
riscv                randconfig-r042-20220713
s390                 randconfig-r044-20220713

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
