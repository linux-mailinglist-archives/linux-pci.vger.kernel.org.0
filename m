Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90F46762B5
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jan 2023 02:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjAUBgm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Jan 2023 20:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjAUBgm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jan 2023 20:36:42 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB956A331
        for <linux-pci@vger.kernel.org>; Fri, 20 Jan 2023 17:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674265001; x=1705801001;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=K72MWWrOdfmw+M53Xg2Rls7WUXX9XXICMxlz0ZEPB9Q=;
  b=UTWefPnSvy5KsVSy4+5kqJ7JCFj717ot1O6BwxeNrzEaqjN8O4O6EV4e
   ChhxlHiiABIIBZLvzcpkZGYumwoax+x0iRZWZ/ym9a6qI3rii8NZKKscP
   wfHVL1DY7D4wZZMndsx8wsHsUH0IYceHFHOfWYNZkL4AjCFnZ90f8tC7S
   mIWX39hCna7FMAt32H/6tzq8ElJrk4NRrtsfhVUSM6oeujPy72m/d5ipc
   0LCKL9Xo/vXBEO05Esbmwr49QE0l3/jFcUBfskxb1CgAox4f7sofWZJQN
   U0z/vshUtBvsfKw2AIL1N0LJqmDyXub2cakauNqohvU/UUsiDsuv/9z1S
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="388104665"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="388104665"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 17:36:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="691264399"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="691264399"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 20 Jan 2023 17:36:39 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJ2oA-0003E3-0p;
        Sat, 21 Jan 2023 01:36:38 +0000
Date:   Sat, 21 Jan 2023 09:35:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/host/uniphier] BUILD SUCCESS
 90ccb044c191a3cf4f4bfef06085747acd988ade
Message-ID: <63cb417d.Rtuv3LJc/IYl4UwC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/host/uniphier
branch HEAD: 90ccb044c191a3cf4f4bfef06085747acd988ade  dt-bindings: PCI: uniphier-ep: Clean up reg, clocks, resets, and their names

elapsed time: 728m

configs tested: 81
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                            allnoconfig
powerpc                           allnoconfig
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
arm                  randconfig-r046-20230119
arc                  randconfig-r043-20230119
i386                          randconfig-a016
sh                               allmodconfig
x86_64                              defconfig
arm                                 defconfig
x86_64                        randconfig-a004
mips                             allyesconfig
x86_64                        randconfig-a002
powerpc                          allmodconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a006
i386                          randconfig-a001
ia64                             allmodconfig
x86_64                         rhel-8.3-kunit
i386                          randconfig-a003
x86_64                           rhel-8.3-kvm
arm64                            allyesconfig
x86_64                           rhel-8.3-bpf
arm                              allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a005
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                        randconfig-a015
alpha                            allyesconfig
arc                              allyesconfig
i386                                defconfig
i386                             allyesconfig
i386                          randconfig-c001
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sh                           se7724_defconfig
powerpc                      ppc6xx_defconfig
loongarch                        alldefconfig
sh                   sh7770_generic_defconfig
nios2                               defconfig
powerpc                   currituck_defconfig

clang tested configs:
i386                          randconfig-a013
x86_64                          rhel-8.3-rust
i386                          randconfig-a011
hexagon              randconfig-r041-20230119
hexagon              randconfig-r045-20230119
riscv                randconfig-r042-20230119
i386                          randconfig-a015
s390                 randconfig-r044-20230119
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
x86_64                        randconfig-a005
x86_64                        randconfig-a014
x86_64                        randconfig-a012
i386                          randconfig-a004
x86_64                        randconfig-a016
i386                          randconfig-a006
mips                       lemote2f_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                     ksi8560_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
