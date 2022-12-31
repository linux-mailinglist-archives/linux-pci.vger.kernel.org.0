Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EFF65A108
	for <lists+linux-pci@lfdr.de>; Sat, 31 Dec 2022 02:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235911AbiLaBzu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Dec 2022 20:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236030AbiLaBzt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Dec 2022 20:55:49 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2442FA19D
        for <linux-pci@vger.kernel.org>; Fri, 30 Dec 2022 17:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672451749; x=1703987749;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=gZGWBf/OISzsjF8Ebr9Bgk2ZHHKakcwz1chFyAF6pnA=;
  b=S/o4KGBUQA2Tu2gtwENTul3lEzAilQ8RAbYewyTdt6kD/zObtqlZpak9
   2G3VJxU3lxzOUb6CR8D16JdlZAkekaA6TbkD0Xb6TyPuPIM1RJhOY7QNl
   4HWDs4Kq73DygGEq5hNLpQlexDYfLPlujzqczfwCqaTqa6ukdcgJs2nHJ
   03ZFyybdrQgFlhGJpjNTlfAXOghEZx1hHJhQ7ShcHA/ftsYgnXCWNP4DG
   lj/LeC9C6Xc36WE/OVeLxWUODJNSCNu8bU7YK/lFvRGR075xstzTttXfo
   cQFtrdzTByWsl4uwFoWsQzd3i/D+lhiOuGgk36ZDC17er7ZSa5NfYvPmn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10576"; a="383574669"
X-IronPort-AV: E=Sophos;i="5.96,288,1665471600"; 
   d="scan'208";a="383574669"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2022 17:55:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10576"; a="655985031"
X-IronPort-AV: E=Sophos;i="5.96,288,1665471600"; 
   d="scan'208";a="655985031"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 30 Dec 2022 17:55:45 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pBR68-000Mq3-39;
        Sat, 31 Dec 2022 01:55:44 +0000
Date:   Sat, 31 Dec 2022 09:55:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/dwc] BUILD SUCCESS
 3c968617322063d7160edcf0ac1144ac774af634
Message-ID: <63af9687.IkKjn065en3UeQiv%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/dwc
branch HEAD: 3c968617322063d7160edcf0ac1144ac774af634  PCI: dwc: Adjust to recent removal of PCI_MSI_IRQ_DOMAIN

elapsed time: 724m

configs tested: 75
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
powerpc                           allnoconfig
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
m68k                             allyesconfig
s390                                defconfig
m68k                             allmodconfig
s390                             allmodconfig
i386                 randconfig-a012-20221226
arc                              allyesconfig
i386                 randconfig-a011-20221226
x86_64                          rhel-8.3-func
i386                 randconfig-a013-20221226
i386                 randconfig-a014-20221226
alpha                            allyesconfig
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a016-20221226
i386                 randconfig-a015-20221226
x86_64                               rhel-8.3
s390                             allyesconfig
x86_64                           allyesconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
ia64                             allmodconfig
i386                                defconfig
x86_64               randconfig-a014-20221226
x86_64               randconfig-a013-20221226
x86_64               randconfig-a011-20221226
x86_64               randconfig-a012-20221226
x86_64               randconfig-a016-20221226
x86_64               randconfig-a015-20221226
arm                                 defconfig
i386                             allyesconfig
arm                              allyesconfig
arm                  randconfig-r046-20221225
arc                  randconfig-r043-20221225
arm64                            allyesconfig
arc                  randconfig-r043-20221227
arm                  randconfig-r046-20221227
arc                  randconfig-r043-20221226
riscv                randconfig-r042-20221226
s390                 randconfig-r044-20221226
x86_64                            allnoconfig
i386                          randconfig-c001

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64               randconfig-a002-20221226
x86_64               randconfig-a003-20221226
x86_64               randconfig-a001-20221226
x86_64               randconfig-a004-20221226
x86_64               randconfig-a006-20221226
x86_64               randconfig-a005-20221226
i386                 randconfig-a004-20221226
i386                 randconfig-a001-20221226
i386                 randconfig-a003-20221226
i386                 randconfig-a002-20221226
i386                 randconfig-a005-20221226
i386                 randconfig-a006-20221226
hexagon              randconfig-r045-20221225
riscv                randconfig-r042-20221227
hexagon              randconfig-r041-20221225
hexagon              randconfig-r041-20221227
hexagon              randconfig-r041-20221226
arm                  randconfig-r046-20221226
s390                 randconfig-r044-20221225
hexagon              randconfig-r045-20221226
riscv                randconfig-r042-20221225
hexagon              randconfig-r045-20221227
s390                 randconfig-r044-20221227

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
