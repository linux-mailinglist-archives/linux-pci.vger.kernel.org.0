Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9928365CF0F
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jan 2023 10:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbjADJHh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Jan 2023 04:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234552AbjADJHV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2023 04:07:21 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757C117048
        for <linux-pci@vger.kernel.org>; Wed,  4 Jan 2023 01:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672823240; x=1704359240;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=kJxCEuTGpPmU7NHS0GoWCXtJ3nn1wF2GX5tPFn6LF4U=;
  b=R3ThdwnnavKLCcNhyuQNlPE37t5hG4dNr/qvWTTC4GQr399bCLZ9FWg0
   tUYcIdTUOEU1aIijEvvHcgfm5YS3OlQjNUoBC2BYsJFOWrYUAmGkCO0Hu
   jCejekUQ/l7rFr3yMWGHkOZ83ylPUBmHgUIpTlJPDFpldaqanNWZp57Lb
   hwF4KGbJ9PnugqJvJWhc9vSENegPUfurDvgK3ocPizYqI49MD0RZEVgpM
   j9cArJkACkFSGVa734tdubxwz83dj93obmNNXhkII90ppmlLX2pYbveKR
   cTbDDDvESuestHAzzuiIdJT0wP1aQsAkeCvrlOqDQngw4pMkqslpeM5TX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="309656847"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="309656847"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 01:07:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="983858497"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="983858497"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jan 2023 01:07:17 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pCzjn-0000AC-0x;
        Wed, 04 Jan 2023 09:07:10 +0000
Date:   Wed, 04 Jan 2023 17:06:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:for-linus] BUILD SUCCESS
 b3243d7d121d0675ab9a04c5f11956f56b55cd38
Message-ID: <63b5419c.xTxQFzHBtHuROqSr%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
branch HEAD: b3243d7d121d0675ab9a04c5f11956f56b55cd38  PCI: dwc: Adjust to recent removal of PCI_MSI_IRQ_DOMAIN

elapsed time: 723m

configs tested: 72
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
i386                 randconfig-a003-20230102
i386                 randconfig-a001-20230102
i386                 randconfig-a002-20230102
arc                                 defconfig
i386                 randconfig-a005-20230102
i386                                defconfig
alpha                               defconfig
x86_64                           rhel-8.3-bpf
ia64                             allmodconfig
i386                 randconfig-a004-20230102
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                 randconfig-a006-20230102
um                             i386_defconfig
um                           x86_64_defconfig
m68k                             allmodconfig
alpha                            allyesconfig
x86_64                              defconfig
m68k                             allyesconfig
arc                              allyesconfig
s390                                defconfig
s390                             allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
arm                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
x86_64               randconfig-a003-20230102
mips                             allyesconfig
x86_64               randconfig-a005-20230102
i386                             allyesconfig
x86_64                           allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a006-20230102
x86_64               randconfig-a001-20230102
x86_64               randconfig-a004-20230102
x86_64               randconfig-a002-20230102
riscv                randconfig-r042-20230101
arm64                            allyesconfig
arc                  randconfig-r043-20230102
arm                              allyesconfig
arm                  randconfig-r046-20230102
arc                  randconfig-r043-20230101
s390                 randconfig-r044-20230101
x86_64                            allnoconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
i386                 randconfig-a013-20230102
i386                 randconfig-a012-20230102
i386                 randconfig-a011-20230102
i386                 randconfig-a014-20230102
i386                 randconfig-a016-20230102
i386                 randconfig-a015-20230102
x86_64                          rhel-8.3-rust
x86_64               randconfig-a014-20230102
x86_64               randconfig-a012-20230102
x86_64               randconfig-a013-20230102
x86_64               randconfig-a011-20230102
x86_64               randconfig-a015-20230102
x86_64               randconfig-a016-20230102
hexagon              randconfig-r041-20230102
s390                 randconfig-r044-20230102
hexagon              randconfig-r045-20230101
hexagon              randconfig-r045-20230102
arm                  randconfig-r046-20230101
riscv                randconfig-r042-20230102
hexagon              randconfig-r041-20230101
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
