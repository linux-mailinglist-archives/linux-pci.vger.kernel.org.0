Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51594D0EE6
	for <lists+linux-pci@lfdr.de>; Tue,  8 Mar 2022 06:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiCHFCL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Mar 2022 00:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiCHFCL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Mar 2022 00:02:11 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B13824BC3
        for <linux-pci@vger.kernel.org>; Mon,  7 Mar 2022 21:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646715675; x=1678251675;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=OKdphNrh4cI1akFSMcCKCtJCkQtvdtVNP59N4GXisCM=;
  b=c7zRuGShSUZTUjphPFn/nGyNRMeLW0OEo5zXwr/LY5XRv9dup9rPfCkG
   utQLzuXM+eLIytF2u/RQR7z6BmTJbYiP8lfnDO0s7fgP+9bbQsdjZP06k
   9sUXxY7ad6Bb62fA5ankgwJQMpHNztNo4BByMsUzoITT+6HXFiPhqGpia
   7iPv8JJal+SoxscFCYXScCRvvoOqmP2TzrWLNDtluArpQhM4qwEppyLaO
   ggTwZgXhEMW9jXffnPGLJGJumyqioYOdEhBGlOwjnuMmgiNrtOP356yAE
   EpAX/8MJ0AOPAYIvQOYkFU6xhUjrGk5bwovp0/p6HmYUHnS2ad53DhY42
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="242028985"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="242028985"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 21:01:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="509974665"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 07 Mar 2022 21:01:13 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRRyC-0000xP-FD; Tue, 08 Mar 2022 05:01:12 +0000
Date:   Tue, 08 Mar 2022 13:00:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/enumeration] BUILD SUCCESS
 92c45b63ce22c8898aa41806e8d6692bcd577510
Message-ID: <6226e2e3.7idH7E/TBNQhf5cQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/enumeration
branch HEAD: 92c45b63ce22c8898aa41806e8d6692bcd577510  PCI: Reduce warnings on possible RW1C corruption

elapsed time: 1310m

configs tested: 65
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
h8300                            alldefconfig
powerpc                 mpc834x_mds_defconfig
arm                  randconfig-c002-20220307
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
alpha                            allyesconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                               defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
arc                  randconfig-r043-20220307
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
powerpc                     kilauea_defconfig
hexagon              randconfig-r041-20220307
hexagon              randconfig-r045-20220307
s390                 randconfig-r044-20220307
riscv                randconfig-r042-20220307

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
