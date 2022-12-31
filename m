Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CD665A107
	for <lists+linux-pci@lfdr.de>; Sat, 31 Dec 2022 02:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbiLaBzu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Dec 2022 20:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbiLaBzt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Dec 2022 20:55:49 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB01C5F76
        for <linux-pci@vger.kernel.org>; Fri, 30 Dec 2022 17:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672451747; x=1703987747;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=tJVV3aehw0ITKu+wpd2DLcoyVNxcMKhjl3ukMt7d9f4=;
  b=YviEtK3vF6UHYjIZecNaFKqttcWqZ+dUaVVsldeKtohWxLsRYE3fnwZP
   /0EMPdDflANL4k5sQCVAlPQlXAsUfQA/XgLbjDKWaig1XPxqkw2/rWgCw
   3sZG4XYfx7zdq6gPKCNvFaEmy1tbF2amWUjAmbhIjez8LLHbRvEhANGof
   pZHg3LQKrxkFZmURrCdQ3zvL7oAc31chZ+tu6t2X2ohgHrH8iSmv+i5b8
   V9WE2LG1jFEp/Nh304DbYZH3XJWO2+2fpqDPWT6hKC7/3h2tLEm2b8eHx
   jyDZnLz9zKMOlIXwDbVhS7eySQAD20NKyVxJio51d0XGhV5i2Zs5IY20P
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10576"; a="383574667"
X-IronPort-AV: E=Sophos;i="5.96,288,1665471600"; 
   d="scan'208";a="383574667"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2022 17:55:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10576"; a="655985028"
X-IronPort-AV: E=Sophos;i="5.96,288,1665471600"; 
   d="scan'208";a="655985028"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 30 Dec 2022 17:55:45 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pBR68-000Mq1-32;
        Sat, 31 Dec 2022 01:55:44 +0000
Date:   Sat, 31 Dec 2022 09:55:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/switchtec] BUILD SUCCESS
 fbc855bce49eda88408c329d6b2bc1176ab08dcd
Message-ID: <63af9684.OCkgUl5zxhC6DBfa%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/switchtec
branch HEAD: fbc855bce49eda88408c329d6b2bc1176ab08dcd  PCI: switchtec: Return -EFAULT for copy_to_user() errors

Unverified Warning (likely false positive, please contact us if interested):

drivers/pci/switch/switchtec.c:623:1: sparse: sparse: unused label 'out'

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-randconfig-s041-20221225
|   `-- drivers-pci-switch-switchtec.c:sparse:sparse:unused-label-out
|-- i386-randconfig-s001
|   `-- drivers-pci-switch-switchtec.c:sparse:sparse:unused-label-out
|-- loongarch-randconfig-s043-20221225
|   `-- drivers-pci-switch-switchtec.c:sparse:sparse:unused-label-out
|-- parisc-randconfig-s031-20221225
|   `-- drivers-pci-switch-switchtec.c:sparse:sparse:unused-label-out
|-- powerpc-randconfig-s042-20221225
|   `-- drivers-pci-switch-switchtec.c:sparse:sparse:unused-label-out
`-- sparc-randconfig-s053-20221225
    `-- drivers-pci-switch-switchtec.c:sparse:sparse:unused-label-out

elapsed time: 724m

configs tested: 75
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
powerpc                           allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
um                             i386_defconfig
s390                             allyesconfig
um                           x86_64_defconfig
sh                               allmodconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
mips                             allyesconfig
powerpc                          allmodconfig
i386                                defconfig
ia64                             allmodconfig
x86_64                              defconfig
x86_64               randconfig-a014-20221226
x86_64                               rhel-8.3
x86_64               randconfig-a013-20221226
x86_64               randconfig-a011-20221226
x86_64                    rhel-8.3-kselftests
x86_64               randconfig-a012-20221226
x86_64                          rhel-8.3-func
arm                                 defconfig
i386                             allyesconfig
x86_64                           allyesconfig
x86_64               randconfig-a016-20221226
x86_64               randconfig-a015-20221226
arm64                            allyesconfig
arm                              allyesconfig
arm                  randconfig-r046-20221225
arc                  randconfig-r043-20221225
arc                  randconfig-r043-20221227
arm                  randconfig-r046-20221227
arc                  randconfig-r043-20221226
riscv                randconfig-r042-20221226
s390                 randconfig-r044-20221226
x86_64                            allnoconfig
i386                          randconfig-c001

clang tested configs:
x86_64               randconfig-a002-20221226
x86_64               randconfig-a003-20221226
x86_64               randconfig-a001-20221226
x86_64               randconfig-a004-20221226
i386                          randconfig-a013
i386                          randconfig-a011
x86_64               randconfig-a005-20221226
x86_64               randconfig-a006-20221226
i386                          randconfig-a015
x86_64                          rhel-8.3-rust
i386                 randconfig-a004-20221226
i386                 randconfig-a001-20221226
i386                 randconfig-a003-20221226
i386                 randconfig-a002-20221226
i386                 randconfig-a005-20221226
i386                 randconfig-a006-20221226
hexagon              randconfig-r045-20221225
riscv                randconfig-r042-20221227
hexagon              randconfig-r041-20221225
s390                 randconfig-r044-20221227
hexagon              randconfig-r041-20221227
hexagon              randconfig-r041-20221226
arm                  randconfig-r046-20221226
s390                 randconfig-r044-20221225
hexagon              randconfig-r045-20221226
riscv                randconfig-r042-20221225
hexagon              randconfig-r045-20221227

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
