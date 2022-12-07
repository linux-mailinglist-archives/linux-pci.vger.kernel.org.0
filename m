Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6A364507D
	for <lists+linux-pci@lfdr.de>; Wed,  7 Dec 2022 01:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiLGAh5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Dec 2022 19:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiLGAh3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Dec 2022 19:37:29 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7A34E69F
        for <linux-pci@vger.kernel.org>; Tue,  6 Dec 2022 16:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670373448; x=1701909448;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=xyW1VyLV1Ankh53FAeI4s2Zq5f3h3hnxNqwoN6qDF3Q=;
  b=lXcx+Dyz5Q4MTKJkkxuVhUMfZ9e51NAl0gyIu0hsLGugPrnS6bGgmZHx
   BU0u0LRY4tJYkUMDz+O+B51Nc4ZcglflT6l25rljxJDh2HcgdDFRDtIoC
   EdVif6i67y7V69+HW2/uvRbmqDOaDKPMWpXdiKrsHsCeGo96Vp846Oi2C
   aIY6QhJ5RfdtjpqexyYfwwzBCvQ4PflYES3Z3God6Jw4VF+eKCr3xLLCt
   nxs3RgI0HBwf/Txm5B6flQ3VtooLC589e7v2iZFS0trG5TQT7P/KG9Kbv
   bKHZho1R7Mu8wUnbtblrKxoyYqJ3alEc296QIjbnr9JdudYkkt15mcLNS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="343796679"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="343796679"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 16:37:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="820771649"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="820771649"
Received: from lkp-server01.sh.intel.com (HELO b3c45e08cbc1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 06 Dec 2022 16:37:26 -0800
Received: from kbuild by b3c45e08cbc1 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p2iRB-0001Ni-1e;
        Wed, 07 Dec 2022 00:37:25 +0000
Date:   Wed, 07 Dec 2022 08:36:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/qcom] BUILD SUCCESS
 74eac50391ce42c5d0038d6f0e580576e53aec4e
Message-ID: <638fe00d.9fadjsqMDtXcm1AU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/qcom
branch HEAD: 74eac50391ce42c5d0038d6f0e580576e53aec4e  dt-bindings: PCI: qcom: Allow 'dma-coherent' property

elapsed time: 724m

configs tested: 64
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                        randconfig-a004
um                             i386_defconfig
x86_64                        randconfig-a002
arm                  randconfig-r046-20221206
arc                                 defconfig
sh                               allmodconfig
s390                             allmodconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
mips                             allyesconfig
x86_64                          rhel-8.3-rust
x86_64                         rhel-8.3-kunit
powerpc                          allmodconfig
arc                  randconfig-r043-20221206
x86_64                           allyesconfig
alpha                               defconfig
i386                                defconfig
x86_64                           rhel-8.3-kvm
s390                                defconfig
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a006
s390                             allyesconfig
m68k                             allmodconfig
ia64                             allmodconfig
x86_64                          rhel-8.3-func
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arm                                 defconfig
i386                             allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arm64                            allyesconfig
arm                              allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                            allnoconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
hexagon              randconfig-r041-20221206
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r045-20221206
s390                 randconfig-r044-20221206
riscv                randconfig-r042-20221206
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a013
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
