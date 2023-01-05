Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DA565E226
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 02:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjAEBEu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Jan 2023 20:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjAEBEq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2023 20:04:46 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70A513DD1
        for <linux-pci@vger.kernel.org>; Wed,  4 Jan 2023 17:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672880685; x=1704416685;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FIL6Lff7u9WO/AEkJO7pCdBYksIW8QzD82JExgAVOPA=;
  b=c3ai30nBRpw7afhg4g09jutndmGuPRYRLgfiMc140sls8vP0b+9Z9HiZ
   NRPpciHKNuvwV+Fgqa01SE3b2wNEATl5P0gCyw4JBByl7rOU5Q389jIQe
   9cZNRBI44I/UsTKx620+87/+bCrX2RlPMyhOuPYhL1Hx2D8ESCmGGCKb6
   LuecUkco/BQj0N11C1Fhbefo0Upnk1POURYhrFZsTG7CQy2EwEJ8Da/sB
   v96NZ+1J5B8jP6zNVkL02lamTctSlF6/LYraSZ6iTrLIjaY5evksb8tRp
   GnQJADay519r3qILa+sG1x7dEutPcR13El8O/fviNlRS7PN0eaPWi/v74
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="302456301"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="302456301"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 17:04:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="655378426"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="655378426"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 04 Jan 2023 17:04:43 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pDEgP-0000xj-2w;
        Thu, 05 Jan 2023 01:04:37 +0000
Date:   Thu, 05 Jan 2023 09:04:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:for-linus] BUILD SUCCESS
 760d560f71c828a97c77596af5c3f9978aefd9d1
Message-ID: <63b62212.DWJ62hRQNcZZiWKg%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
branch HEAD: 760d560f71c828a97c77596af5c3f9978aefd9d1  PCI: dwc: Adjust to recent removal of PCI_MSI_IRQ_DOMAIN

elapsed time: 727m

configs tested: 75
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
x86_64                            allnoconfig
powerpc                           allnoconfig
mips                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
sh                               allmodconfig
powerpc                          allmodconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-bpf
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
ia64                             allmodconfig
x86_64                           rhel-8.3-kvm
i386                                defconfig
i386                 randconfig-a004-20230102
x86_64                              defconfig
i386                 randconfig-a003-20230102
i386                 randconfig-a001-20230102
i386                 randconfig-a002-20230102
x86_64                               rhel-8.3
i386                 randconfig-a005-20230102
i386                 randconfig-a006-20230102
i386                             allyesconfig
x86_64                           allyesconfig
arm                                 defconfig
x86_64               randconfig-a003-20230102
x86_64               randconfig-a001-20230102
x86_64               randconfig-a004-20230102
x86_64               randconfig-a002-20230102
x86_64               randconfig-a006-20230102
x86_64               randconfig-a005-20230102
arm64                            allyesconfig
arm                              allyesconfig
riscv                randconfig-r042-20230101
s390                 randconfig-r044-20230101
arc                  randconfig-r043-20230102
arm                  randconfig-r046-20230102
arc                  randconfig-r043-20230101
mips                         db1xxx_defconfig
openrisc                            defconfig
arm                         at91_dt_defconfig
s390                 randconfig-r044-20230103
arc                  randconfig-r043-20230103
riscv                randconfig-r042-20230103
i386                          randconfig-c001

clang tested configs:
x86_64                          rhel-8.3-rust
i386                 randconfig-a011-20230102
i386                 randconfig-a014-20230102
i386                 randconfig-a013-20230102
i386                 randconfig-a012-20230102
i386                 randconfig-a015-20230102
i386                 randconfig-a016-20230102
hexagon              randconfig-r041-20230102
hexagon              randconfig-r045-20230101
hexagon              randconfig-r045-20230102
arm                  randconfig-r046-20230101
riscv                randconfig-r042-20230102
hexagon              randconfig-r041-20230101
s390                 randconfig-r044-20230102
x86_64               randconfig-a014-20230102
x86_64               randconfig-a016-20230102
x86_64               randconfig-a012-20230102
x86_64               randconfig-a011-20230102
x86_64               randconfig-a015-20230102
x86_64               randconfig-a013-20230102

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
