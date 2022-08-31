Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239A85A787A
	for <lists+linux-pci@lfdr.de>; Wed, 31 Aug 2022 10:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiHaIFa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Aug 2022 04:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiHaIF3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Aug 2022 04:05:29 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A3A25598
        for <linux-pci@vger.kernel.org>; Wed, 31 Aug 2022 01:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661933101; x=1693469101;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=XFTBjpX6kTXNcV+9xcCtjXg5a9XkQ9tFh/l4uJaWSfg=;
  b=TgfuC3tGO9ZQ4FBvANqQ+VoekST7x9xgsK6IPw4BRzV3RL4UEe4IiZ9S
   g+D+Kh3pLQVQzrmTE719UnpLp2qRKEwOJUqjpHKD10ZffnIZnB5uRCt6J
   +18R339yS9J1H0nIfxmZg24b8VSgCPctHF2t/JqDYRa90Rzffc0gM4eHG
   olnG3FimYW1mAUn/+joLDVuw2q+GQ8cTqLIAhm7v4LFnhFmuMp/jzezAn
   2H75gGXPrTFgYKO5nBm7Ri3/dLMAp6q5OxScqWFTfPPSexiH0JgkpdlXe
   D/srakz0aMLrp3RMAkciMStO8iOhhl37qiS6nANINGygf3lpoHluzbr3E
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="278415271"
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="278415271"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 01:05:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="857392470"
Received: from lkp-server02.sh.intel.com (HELO 811e2ceaf0e5) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 31 Aug 2022 01:04:59 -0700
Received: from kbuild by 811e2ceaf0e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTIiZ-00006Z-1A;
        Wed, 31 Aug 2022 08:04:59 +0000
Date:   Wed, 31 Aug 2022 16:04:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/pm] BUILD SUCCESS
 22b07d9ddd02e04dc1724cc2db69b843ab216065
Message-ID: <630f1606.4y5C21FIO+KuvMwq%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/pm
branch HEAD: 22b07d9ddd02e04dc1724cc2db69b843ab216065  PCI/PTM: Update pdev->ptm_enabled to track hardware state

elapsed time: 723m

configs tested: 53
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20220830
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
x86_64                        randconfig-a004
i386                          randconfig-a001
x86_64                        randconfig-a002
x86_64                              defconfig
x86_64                           allyesconfig
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a006
x86_64                               rhel-8.3
i386                          randconfig-a014
i386                                defconfig
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
i386                             allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
arm                                 defconfig
arm64                            allyesconfig
ia64                             allmodconfig
arm                              allyesconfig

clang tested configs:
hexagon              randconfig-r045-20220830
riscv                randconfig-r042-20220830
hexagon              randconfig-r041-20220830
s390                 randconfig-r044-20220830
x86_64                        randconfig-a005
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a003
i386                          randconfig-a006
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
