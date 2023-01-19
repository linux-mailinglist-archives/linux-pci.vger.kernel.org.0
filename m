Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3906733CE
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 09:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjASIgv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 03:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjASIgu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 03:36:50 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C094B4A6
        for <linux-pci@vger.kernel.org>; Thu, 19 Jan 2023 00:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674117410; x=1705653410;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/7aTMeppxEwvlOJUkFDKRvvKSlUX3f1zbO6WbojG830=;
  b=ap1Mft2hAV/spZnJ7X7itmP9dAWUI0HE8vStkoTFYJT/WCxi2Wh6q3Yy
   4z5XFT9vrWHsRcN/TImv/kWrMJ0U2QxTkvmYF0q6455skAt+ejMLCEoPd
   5SJ3lF4jd0PfEHfrNQkAVltlqnPDlMZZLIFdIEU7gbNLyfNJtCsgZjQ7B
   AERgQFGoPvZ9Zvql5fLhaymUe3BwsetJjiv4fNl/eYShSkkDacaMgljhQ
   gCYrA9ic+1J9Xmk1hmSADkkTABqNcm8Fa596dI8fBKaH0rZnQ3VRpgiK9
   C7tOWyZwDqXVgQd33/WCowY0uqdTO/L3J4Ef5hwos6l/is3lUiRGQV/OF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="327304797"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="327304797"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 00:36:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="768128905"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="768128905"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jan 2023 00:36:48 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIQPa-0001JV-2g;
        Thu, 19 Jan 2023 08:36:42 +0000
Date:   Thu, 19 Jan 2023 16:36:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 bb7da376b4fd6c8296312ac2784d0e21a509d0b6
Message-ID: <63c9010a.ZYYJJBT4Ztd4eOAj%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: bb7da376b4fd6c8296312ac2784d0e21a509d0b6  Merge branch 'remotes/lorenzo/pci/imx6'

elapsed time: 723m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
x86_64                            allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
ia64                             allmodconfig
arc                  randconfig-r043-20230118
s390                 randconfig-r044-20230118
x86_64                              defconfig
riscv                randconfig-r042-20230118
i386                                defconfig
sh                               allmodconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                             allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a014
x86_64                          rhel-8.3-func
x86_64                        randconfig-a015
i386                          randconfig-a012
x86_64                        randconfig-a004
x86_64                        randconfig-a013
i386                          randconfig-a016
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a006

clang tested configs:
hexagon              randconfig-r045-20230118
hexagon              randconfig-r041-20230118
arm                  randconfig-r046-20230118
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                          rhel-8.3-rust
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                        randconfig-a012
x86_64                        randconfig-a005
x86_64                        randconfig-a014
x86_64                        randconfig-a001
i386                          randconfig-a015
x86_64                        randconfig-a016
x86_64                        randconfig-a003

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
