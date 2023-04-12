Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1FD6DEAE7
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 07:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjDLFT6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Apr 2023 01:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDLFT5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2023 01:19:57 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160C14225
        for <linux-pci@vger.kernel.org>; Tue, 11 Apr 2023 22:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681276796; x=1712812796;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=qVV4hcskjvZgOmYQMNEB4fiikNRX3ZZqFSmR0kfk1og=;
  b=D+9RO4zfMdfkaR9EaPw4OpvJoa7+vDu4zfmE6L2pKaJWAavHlHvvaQd6
   hXUkjJ4ffS2urJuaxpF9mCrb2DsB/PyQ9TP4QYo/tlsOr5Tmmwi6wH3kx
   cdtVoHlxvzee87lndx+P9b4UELvliE1iXdRjMAk5Us4D7HV3xCOVSfVHR
   tbMzMzgrq5HrvN4gBW9gWk5NptPeJAgfkn0pZl48MUH5LFDPvDMTAiKWn
   eFfM9K7c7h2rBJiHiAUwlzbz3vA4sfTnF3NpMNC5YQQ1XSnse0gJYV2cK
   b3YULHXxkgDdba9KLZg/zj09AujpT9OX4ACeT8HO3Ij1AkOqAB3YvfLQp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="371654188"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="371654188"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 22:19:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="639075345"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="639075345"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 Apr 2023 22:19:55 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmStf-000XJN-05;
        Wed, 12 Apr 2023 05:19:55 +0000
Date:   Wed, 12 Apr 2023 13:19:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:controller/qcom] BUILD REGRESSION
 dc8d33452b3643f4b4c33fd4492aa7ae4e8e00d6
Message-ID: <64363f44.2Uw19CtXoGJ6EqpF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/qcom
branch HEAD: dc8d33452b3643f4b4c33fd4492aa7ae4e8e00d6  Revert "dt-bindings: PCI: qcom: Add iommu-map properties"

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202304120557.LijMReu1-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/pci/controller/dwc/pcie-qcom.c:1574:9: error: no member named 'suspended' in 'struct qcom_pcie'
drivers/pci/controller/dwc/pcie-qcom.c:246:25: error: expected ';' at end of declaration list
drivers/pci/controller/dwc/pcie-qcom.c:247:1: error: expected member name or ';' after declaration specifiers
drivers/pci/controller/dwc/pcie-qcom.c:247:1: error: type name requires a specifier or qualifier

Error/Warning ids grouped by kconfigs:

clang_recent_errors
`-- riscv-randconfig-r036-20230409
    |-- drivers-pci-controller-dwc-pcie-qcom.c:error:expected-at-end-of-declaration-list
    |-- drivers-pci-controller-dwc-pcie-qcom.c:error:expected-member-name-or-after-declaration-specifiers
    |-- drivers-pci-controller-dwc-pcie-qcom.c:error:no-member-named-suspended-in-struct-qcom_pcie
    `-- drivers-pci-controller-dwc-pcie-qcom.c:error:type-name-requires-a-specifier-or-qualifier

elapsed time: 727m

configs tested: 56
configs skipped: 3

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a011-20230410   gcc  
i386                 randconfig-a012-20230410   gcc  
i386                 randconfig-a013-20230410   gcc  
i386                 randconfig-a014-20230410   gcc  
i386                 randconfig-a015-20230410   gcc  
i386                 randconfig-a016-20230410   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sparc                               defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a011-20230410   gcc  
x86_64               randconfig-a012-20230410   gcc  
x86_64               randconfig-a013-20230410   gcc  
x86_64               randconfig-a014-20230410   gcc  
x86_64               randconfig-a015-20230410   gcc  
x86_64               randconfig-a016-20230410   gcc  
x86_64                        randconfig-k001   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
