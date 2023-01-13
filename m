Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4046694A0
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 11:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241050AbjAMKtX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 05:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240739AbjAMKtV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 05:49:21 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE8C1E2
        for <linux-pci@vger.kernel.org>; Fri, 13 Jan 2023 02:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673606960; x=1705142960;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=47EA7FNPpTh+G9jokpp2R5/Ol84ov9A2Gr0qqHfc6yc=;
  b=LZuFoUlnXHdLRvIhUJ/KFh80H0SyEDA9J3T5ZomnasfAZTBvrBSQ74fa
   lYP/P7aoidtIemec/i6Og0OoOibk47C3yL0f6n913hP/Kp53EayQZ7x/6
   2ArRUQiiAisDMoyiUAfCGSXlG/MS4d3ajLJT1v38UNx+QXtrUZ5DbHOMC
   si9TIUrNbjqvpu7VCf+Pu2dpmobyww7tHv689GsNjXCXqTLpwzHy95uOm
   EoMbXSLA9ZmwvbnG/4ksKZkJY71vhVJg9xmKHxiJxEDL37k9zNdLP4EsF
   MX7wv0APftja+Dukm6/GP4VMOIDhiO9C1Sco3T/VfisghVwy4Fj53NPip
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="307512252"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="307512252"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 02:49:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="800561719"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="800561719"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jan 2023 02:49:18 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pGHcP-000B28-2z;
        Fri, 13 Jan 2023 10:49:09 +0000
Date:   Fri, 13 Jan 2023 18:48:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/pm] BUILD SUCCESS
 d6c931acff1210d80279ebe6dbf7e93ac2b085d0
Message-ID: <63c136f9.Dbr/8YHy3w3MrnYc%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/pm
branch HEAD: d6c931acff1210d80279ebe6dbf7e93ac2b085d0  PCI/ACPI: Account for _S0W of the target bridge in acpi_pci_bridge_d3(()

elapsed time: 725m

configs tested: 82
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
ia64                             allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
arc                  randconfig-r043-20230112
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a006
riscv                randconfig-r042-20230112
s390                 randconfig-r044-20230112
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allyesconfig
arm                      integrator_defconfig
sh                           se7721_defconfig
m68k                          atari_defconfig
arc                          axs103_defconfig
m68k                       bvme6000_defconfig
m68k                             allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
arm                        realview_defconfig
mips                            ar7_defconfig
arm                            zeus_defconfig
arc                            hsdk_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
sh                               allmodconfig
s390                                defconfig
x86_64                              defconfig
powerpc                          allmodconfig
mips                             allyesconfig
s390                             allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                             allyesconfig
i386                                defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                           allyesconfig

clang tested configs:
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
arm                  randconfig-r046-20230112
x86_64                        randconfig-a001
i386                          randconfig-a002
hexagon              randconfig-r041-20230112
x86_64                        randconfig-a003
i386                          randconfig-a004
hexagon              randconfig-r045-20230112
x86_64                        randconfig-a005
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-k001
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
