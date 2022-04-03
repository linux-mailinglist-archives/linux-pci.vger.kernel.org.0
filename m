Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D374F0849
	for <lists+linux-pci@lfdr.de>; Sun,  3 Apr 2022 09:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355408AbiDCH1V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 3 Apr 2022 03:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355404AbiDCH1T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 3 Apr 2022 03:27:19 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4D431DD3
        for <linux-pci@vger.kernel.org>; Sun,  3 Apr 2022 00:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648970726; x=1680506726;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=MXKpd1te8TXbJW6B/QgWX0AOJ/9PYjMF/fybLTAMLgs=;
  b=lYolhe87Z8+v2yXqCHM/Ayyhu7z8xqEuox4Es20FgeWKfCZiJ/stux06
   ul4xgoHdjpBEiasbxf/i9q1zpfFllYiIYF6oOo6pK8jkeerAtiQi6T8SG
   JM1K+Syu3uei2DIZAKQWJdBMRXGJQJ08cUN/4wOMdUjOhLZlODs3+AxpO
   Qu50FsmOjwwDV4lHWj33Za0Gl/0Nt9FKCnEgDXKyg+tb++haInPLzyMK8
   TqKCiocs4nLWxKlp9wbkhqsAAOeLIcUDqzAEXXfTqspVFzpexIIgCPW+w
   lLbVgwJxGWwolQ+G3Dme2gvUypkOv2fv+hrbBwwlw5wpT9gkhmuRNxtbb
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10305"; a="242503771"
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="242503771"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 00:25:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="656948940"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 03 Apr 2022 00:25:24 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1naubz-0000ne-Dw;
        Sun, 03 Apr 2022 07:25:23 +0000
Date:   Sun, 03 Apr 2022 15:25:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/hotplug] BUILD SUCCESS
 7e3bd4a02c9dc9eecd6cb8d41750268bccff4a77
Message-ID: <62494bdf.D0tZkty55510eBgB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/hotplug
branch HEAD: 7e3bd4a02c9dc9eecd6cb8d41750268bccff4a77  PCI/ACPI: Allow D3 only if Root Port can signal and wake from D3

elapsed time: 721m

configs tested: 111
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
sh                           se7343_defconfig
powerpc                     ep8248e_defconfig
h8300                     edosk2674_defconfig
powerpc                      ppc6xx_defconfig
m68k                       m5275evb_defconfig
arc                            hsdk_defconfig
m68k                       m5208evb_defconfig
arm                        cerfcube_defconfig
mips                 decstation_r4k_defconfig
sh                           se7619_defconfig
arm                        spear6xx_defconfig
xtensa                  nommu_kc705_defconfig
sh                           se7712_defconfig
arm                        oxnas_v6_defconfig
m68k                        m5307c3_defconfig
sh                            shmin_defconfig
arm                        clps711x_defconfig
arc                        vdk_hs38_defconfig
sh                   sh7724_generic_defconfig
sh                   rts7751r2dplus_defconfig
mips                           xway_defconfig
m68k                            mac_defconfig
mips                            gpr_defconfig
sh                               j2_defconfig
i386                                defconfig
sh                           se7705_defconfig
sparc64                          alldefconfig
alpha                               defconfig
arm                          badge4_defconfig
arm                  randconfig-c002-20220403
x86_64                        randconfig-c001
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220403
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220403
riscv                randconfig-c006-20220403
mips                 randconfig-c004-20220403
arm                  randconfig-c002-20220403
mips                          rm200_defconfig
mips                         tb0219_defconfig
x86_64                           allyesconfig
powerpc                      pmac32_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220403
riscv                randconfig-r042-20220403
hexagon              randconfig-r041-20220403
s390                 randconfig-r044-20220403

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
