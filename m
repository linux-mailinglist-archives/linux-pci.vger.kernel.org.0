Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC392648D5D
	for <lists+linux-pci@lfdr.de>; Sat, 10 Dec 2022 07:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiLJGup (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Dec 2022 01:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiLJGuo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Dec 2022 01:50:44 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33463720B
        for <linux-pci@vger.kernel.org>; Fri,  9 Dec 2022 22:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670655043; x=1702191043;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=6TFzHNdFXoA47idZCFKQIl66T5V1Y8bLcaU+Tsr2eL0=;
  b=IVFZgH55BnUE7aF24krOGflWRGrS+CEtGPON3KVcxjF29juAx7VNVFag
   r82LpVEDgWO1aa9GW4AXQu7lqA5u3VXx1Bxi5appQorGaO2kO/IJ2LPf/
   B1LJSmIiBG63FskaiZrgNopEiYgSVnj1fV5j6Rq/q7Ssm2fzda4epB3WO
   Uh34z6O1bxvW3mAvk+/rEylcrZAkq5WL0ZjycAJymT2gh79aJ7bM4taUl
   6YDCGsqjqDJQGTs6Zeu7+KKcHxJ+hYZBhB2aX4A2ag0sUJcwAs+v36Zl5
   xNvdgyhtexWM3Et+hCl442lTYd3hUReQLRv97M1j3C9Fy7Ay283DIqAh7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="301023489"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="301023489"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 22:50:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="647627266"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="647627266"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 09 Dec 2022 22:50:42 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p3th3-0002J9-0h;
        Sat, 10 Dec 2022 06:50:41 +0000
Date:   Sat, 10 Dec 2022 14:49:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 bdf282f19e4d7c4be5679e8117aa1c6679580f5d
Message-ID: <63942c12.BCFHzeram+MDFnvS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: bdf282f19e4d7c4be5679e8117aa1c6679580f5d  Merge branch 'pci/kbuild'

elapsed time: 726m

configs tested: 61
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                                defconfig
x86_64                          rhel-8.3-func
x86_64                          rhel-8.3-rust
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
i386                             allyesconfig
powerpc                           allnoconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a006
arc                  randconfig-r043-20221209
arc                                 defconfig
s390                 randconfig-r044-20221209
m68k                             allyesconfig
x86_64                               rhel-8.3
s390                             allmodconfig
x86_64                        randconfig-a015
x86_64                              defconfig
riscv                randconfig-r042-20221209
alpha                               defconfig
alpha                            allyesconfig
i386                          randconfig-a014
arm                                 defconfig
i386                          randconfig-a012
s390                                defconfig
x86_64                           rhel-8.3-bpf
x86_64                           allyesconfig
x86_64                           rhel-8.3-syz
sh                               allmodconfig
m68k                             allmodconfig
arc                              allyesconfig
x86_64                         rhel-8.3-kunit
s390                             allyesconfig
mips                             allyesconfig
i386                          randconfig-a001
i386                          randconfig-a016
x86_64                           rhel-8.3-kvm
powerpc                          allmodconfig
i386                          randconfig-a003
i386                          randconfig-a005
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig

clang tested configs:
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
arm                  randconfig-r046-20221209
hexagon              randconfig-r041-20221209
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r045-20221209
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
