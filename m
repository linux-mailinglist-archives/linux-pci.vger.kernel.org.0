Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51F9692500
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 19:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbjBJSFS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 13:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjBJSFR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 13:05:17 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993505FE7F
        for <linux-pci@vger.kernel.org>; Fri, 10 Feb 2023 10:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676052316; x=1707588316;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=GwMsfO5iyvJNvc5T7Xy/AAqaBXZH0RyAk2XAHQulhx0=;
  b=khf/AlP6P0Uwn54qZ3ZTHEi9BTUFPEtJv4zsrmiEdikAT/LJTm9z8JhV
   Woi0ybTJXHBvp61AL3ii7YofG/cAGsGYox0f3Q2AeWZvhTvg8wU4cjT2z
   BEsjIQGAnBSSrx3qa/z3FoFfnB/4HrhscIiFqXNDA3qXnvx+FIheJr53g
   QULQDrjQTOrCoSlcXuBa+VbvpYlfQVcCQ7euTWTWcMIYLIG6lLPnLkAbi
   0w2Lr9vElwOM1KfBkrHYGFsD1PCMhLDQc1UM+g3Ocomv1sQfwxeEpnIOD
   dz4yQAzpzexQ3ps5GHcsVTiiLTBTIq35Z2YPk/CRPNP07rPGTWS31IHnO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="392891253"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="392891253"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 10:04:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="792066501"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="792066501"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 10 Feb 2023 10:04:43 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQXlK-0005xi-1d;
        Fri, 10 Feb 2023 18:04:42 +0000
Date:   Sat, 11 Feb 2023 02:04:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:for-linus] BUILD SUCCESS
 9c7addf8dd7411aab3e75fb914d0ee9fbcfc2381
Message-ID: <63e68726.c3xYEtKb6iRurdgf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LONGWORDS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
branch HEAD: 9c7addf8dd7411aab3e75fb914d0ee9fbcfc2381  Revert "PCI/ASPM: Refactor L1 PM Substates Control Register programming"

elapsed time: 5569m

configs tested: 87
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                            allyesconfig
alpha                               defconfig
arc                              allyesconfig
arc                                 defconfig
arc                  randconfig-r043-20230205
arc                  randconfig-r043-20230206
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm                  randconfig-r046-20230205
arm64                            allyesconfig
arm64                               defconfig
csky                                defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                                defconfig
i386                 randconfig-a011-20230206
i386                 randconfig-a012-20230206
i386                 randconfig-a013-20230206
i386                 randconfig-a014-20230206
i386                 randconfig-a015-20230206
i386                 randconfig-a016-20230206
ia64                             allmodconfig
ia64                                defconfig
loongarch                        allmodconfig
loongarch                         allnoconfig
loongarch                           defconfig
m68k                             allmodconfig
m68k                             allyesconfig
m68k                                defconfig
mips                             allmodconfig
mips                             allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                randconfig-r042-20230206
riscv                          rv32_defconfig
s390                             allmodconfig
s390                             allyesconfig
s390                                defconfig
s390                 randconfig-r044-20230206
sh                               allmodconfig
sparc                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                            allnoconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64               randconfig-a011-20230206
x86_64               randconfig-a012-20230206
x86_64               randconfig-a013-20230206
x86_64               randconfig-a014-20230206
x86_64               randconfig-a015-20230206
x86_64               randconfig-a016-20230206
x86_64                               rhel-8.3
x86_64                           rhel-8.3-bpf
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz

clang tested configs:
arm                  randconfig-r046-20230206
hexagon              randconfig-r041-20230205
hexagon              randconfig-r041-20230206
hexagon              randconfig-r045-20230205
hexagon              randconfig-r045-20230206
i386                 randconfig-a001-20230206
i386                 randconfig-a002-20230206
i386                 randconfig-a003-20230206
i386                 randconfig-a004-20230206
i386                 randconfig-a005-20230206
i386                 randconfig-a006-20230206
riscv                randconfig-r042-20230205
s390                 randconfig-r044-20230205
x86_64               randconfig-a001-20230206
x86_64               randconfig-a002-20230206
x86_64               randconfig-a003-20230206
x86_64               randconfig-a004-20230206
x86_64               randconfig-a005-20230206
x86_64               randconfig-a006-20230206
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
