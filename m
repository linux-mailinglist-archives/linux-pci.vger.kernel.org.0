Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F76756014A
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 15:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiF2NaF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 09:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiF2NaD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 09:30:03 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C7D1FCD1
        for <linux-pci@vger.kernel.org>; Wed, 29 Jun 2022 06:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656509401; x=1688045401;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=sEq2ZsKGB2LpFGnvSLOzGmFVOvesscZbWxMTPM+lRoo=;
  b=iuG12GJIGWWAOmppT/SuBGof42Ufm/llrFgtfS2heFLQTghPDlma3SvT
   BXLzUKFXR+/EXZKKgxmFt0ebdfERvQSg3JdK+S2INoRCdWVTVb+L97TLt
   pZUWspLETQjzvOveFssZ444v1Fq8ks6SRfo901u0rlhgtk8mhlaIvLvUx
   r4O/f3/cebSibf7DRYtvHYUk5JaitHlhxr+s3aJRIDqznfvy6nBGoBcPV
   +7dMMyivEbtMPCJPYtk/4G8PjEM7opvrd4OiEEbKzKMVuPEUqnhITmk1G
   Yi5EwwWJcqqXAwTckhThNlhsGOKRCoLfF5mVSbdgyROG3ZzWD8+jK1aFA
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="262435950"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="262435950"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 06:30:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="917601079"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jun 2022 06:30:00 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6XlX-000BFG-Gq;
        Wed, 29 Jun 2022 13:29:59 +0000
Date:   Wed, 29 Jun 2022 21:29:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/ctrl/vmd] BUILD SUCCESS
 57a128acaba023048585233e7dada9972c2a6b4c
Message-ID: <62bc53ca.8O5ESgEo7ip1LG3Y%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ctrl/vmd
branch HEAD: 57a128acaba023048585233e7dada9972c2a6b4c  PCI: vmd: Add DID 8086:7D0B and 8086:AD0B for Intel MTL SKUs

elapsed time: 721m

configs tested: 61
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
xtensa                  audio_kc705_defconfig
sh                              ul2_defconfig
i386                             alldefconfig
powerpc                         ps3_defconfig
m68k                        stmark2_defconfig
arm                            mps2_defconfig
arm                        cerfcube_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                 mpc837x_mds_defconfig
sh                           se7712_defconfig
arm                      jornada720_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64               randconfig-a013-20220627
x86_64               randconfig-a012-20220627
x86_64               randconfig-a016-20220627
x86_64               randconfig-a015-20220627
x86_64               randconfig-a011-20220627
x86_64               randconfig-a014-20220627
i386                 randconfig-a014-20220627
i386                 randconfig-a011-20220627
i386                 randconfig-a012-20220627
i386                 randconfig-a015-20220627
i386                 randconfig-a016-20220627
i386                 randconfig-a013-20220627
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-k001
i386                 randconfig-a005-20220627
i386                 randconfig-a001-20220627
i386                 randconfig-a006-20220627
i386                 randconfig-a004-20220627
i386                 randconfig-a003-20220627
i386                 randconfig-a002-20220627
x86_64               randconfig-a004-20220627
x86_64               randconfig-a006-20220627
x86_64               randconfig-a001-20220627
x86_64               randconfig-a005-20220627
x86_64               randconfig-a002-20220627
x86_64               randconfig-a003-20220627
hexagon              randconfig-r041-20220627
hexagon              randconfig-r045-20220627

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
