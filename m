Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864F75ED03B
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 00:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiI0WXG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 18:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiI0WXE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 18:23:04 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4561EC1D7
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 15:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664317378; x=1695853378;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=gg5ZVthfHWnW+N90wlqTzvFzecL2qcc5+hHaKrAkgcE=;
  b=SpDYXm+th+HWMHrm/PPxpeUhFcD+9Wa9rzt9r2hSA7MOHRGJpt+gNE6t
   HCKDNbYblRGS3FKDJDWNd6A0nHmV85l8vb7asFLl2+cYwC6GqWXhahG6q
   ooq/hL0JlmNO6U9XePr8/lpqUfY9QSGW8Y6kUHk8bOEZSkQ1xY0YIebpk
   VroRKmr89UMYlqduSi3sSz1AZ+o2OUrOtP+XLPkt+ji0ucSqDwH50kZSy
   XlpdR8dgvL6LCc3/nQ5x6XvFBYTX2tStj03BD0b18+cxb6qmgthLVUy+J
   j5TbTVl18jp+HnZEFXLQE9vWz9OXizCg30wCswmtjMGPUxcr0jebPd6U4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="302926441"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="302926441"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 15:22:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="621683417"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="621683417"
Received: from lkp-server02.sh.intel.com (HELO dfa2c9fcd321) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 27 Sep 2022 15:22:56 -0700
Received: from kbuild by dfa2c9fcd321 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1odIyd-0001eI-1U;
        Tue, 27 Sep 2022 22:22:55 +0000
Date:   Wed, 28 Sep 2022 06:22:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/misc] BUILD SUCCESS
 2301a3e1a5664cf8380d2b8ef051005dc90bc881
Message-ID: <633377aa.9ntW561ZmCYVjkCw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/misc
branch HEAD: 2301a3e1a5664cf8380d2b8ef051005dc90bc881  PCI: mt7621: Use PCI_CONF1_EXT_ADDRESS() macro

elapsed time: 726m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
sh                               allmodconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
x86_64                           allyesconfig
i386                 randconfig-a001-20220926
x86_64               randconfig-a002-20220926
i386                 randconfig-a004-20220926
x86_64               randconfig-a001-20220926
arc                  randconfig-r043-20220926
i386                 randconfig-a005-20220926
x86_64               randconfig-a003-20220926
i386                 randconfig-a006-20220926
i386                 randconfig-a002-20220926
x86_64               randconfig-a004-20220926
i386                 randconfig-a003-20220926
x86_64               randconfig-a006-20220926
x86_64               randconfig-a005-20220926
arm                                 defconfig
i386                                defconfig
arm                              allyesconfig
arm64                            allyesconfig
i386                             allyesconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r045-20220926
riscv                randconfig-r042-20220926
i386                 randconfig-a011-20220926
s390                 randconfig-r044-20220926
hexagon              randconfig-r041-20220926
i386                 randconfig-a014-20220926
i386                 randconfig-a013-20220926
i386                 randconfig-a012-20220926
i386                 randconfig-a016-20220926
i386                 randconfig-a015-20220926
x86_64               randconfig-a012-20220926
x86_64               randconfig-a013-20220926
x86_64               randconfig-a011-20220926
x86_64               randconfig-a016-20220926
x86_64               randconfig-a015-20220926
x86_64               randconfig-a014-20220926

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
