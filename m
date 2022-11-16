Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9752362B342
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 07:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbiKPG0A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 01:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbiKPGZz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 01:25:55 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6997C1DA6F
        for <linux-pci@vger.kernel.org>; Tue, 15 Nov 2022 22:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668579954; x=1700115954;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=8y/z0iB612EAQTFg/db/8M8MnYslTFVmFQEOC1OS7G4=;
  b=NZeo6z1gnTK0xfib8V6r9yh96QYRAN4XXLoT/T0TYHoyh4wX6EoEesMf
   6uVIfruZowWPoM5exRmfquS1OnUuIZwO+ZgkfzqN6fm2QzecUCubhRpap
   0MgHHNZR8hfXm0o5zaguwUQQegGv7tG1Glxl89BjJg73igQ0i6c7HquaI
   727jMgKUYg/TA2sgWX2qrjBO9nx5MD8s9og7uCp+7EYacR5qB4fcvAqbH
   mtGcE124jwg2pVGvNKADMWaIOATGvYVYJ66rw7C5kkqn5FrMXFw/7EnTg
   jnfXwoWlpg9JkEV1PdrNzfzJf5tEfMFWX8E5y5tFgfA1IWKCFRwXl0mGP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="313614301"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="313614301"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 22:25:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="728244038"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="728244038"
Received: from lkp-server01.sh.intel.com (HELO ebd99836cbe0) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Nov 2022 22:25:52 -0800
Received: from kbuild by ebd99836cbe0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ovBrs-00024v-04;
        Wed, 16 Nov 2022 06:25:52 +0000
Date:   Wed, 16 Nov 2022 14:25:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/kbuild] BUILD SUCCESS
 3acd7e68605f0976f2166ed023f6b10b6c57d662
Message-ID: <6374824a.6orWnDiq5PqQ7Bss%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/kbuild
branch HEAD: 3acd7e68605f0976f2166ed023f6b10b6c57d662  PCI: Drop of_match_ptr() to avoid unused variables

elapsed time: 722m

configs tested: 70
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
um                             i386_defconfig
alpha                               defconfig
um                           x86_64_defconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                          rhel-8.3-func
sh                               allmodconfig
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a001-20221114
i386                 randconfig-a002-20221114
i386                 randconfig-a005-20221114
i386                 randconfig-a003-20221114
i386                 randconfig-a004-20221114
i386                 randconfig-a006-20221114
arc                  randconfig-r043-20221115
riscv                randconfig-r042-20221115
s390                 randconfig-r044-20221115
x86_64                        randconfig-a004
m68k                             allmodconfig
x86_64                        randconfig-a002
alpha                            allyesconfig
arc                              allyesconfig
i386                          randconfig-a012
x86_64                        randconfig-a006
i386                          randconfig-a014
i386                          randconfig-a016
m68k                             allyesconfig
x86_64                           rhel-8.3-syz
ia64                             allmodconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                              defconfig
i386                                defconfig
arm                                 defconfig
i386                             allyesconfig
arm                              allyesconfig
x86_64                               rhel-8.3
arm64                            allyesconfig
x86_64                           allyesconfig
arm                            hisi_defconfig
powerpc                   motionpro_defconfig
mips                      maltasmvp_defconfig
arm                      integrator_defconfig
mips                           ci20_defconfig
powerpc                      ppc6xx_defconfig
sh                 kfr2r09-romimage_defconfig
i386                          randconfig-c001

clang tested configs:
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
hexagon              randconfig-r041-20221115
hexagon              randconfig-r045-20221115
i386                          randconfig-a013
x86_64                        randconfig-a005
i386                          randconfig-a011
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
