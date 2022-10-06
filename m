Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575135F64FD
	for <lists+linux-pci@lfdr.de>; Thu,  6 Oct 2022 13:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiJFLMb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 07:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiJFLM3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 07:12:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1AD11C06
        for <linux-pci@vger.kernel.org>; Thu,  6 Oct 2022 04:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665054743; x=1696590743;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=zPIL/lEMP4iW4B5XaQ0E10Fd07wq8a4CkaAPO8nDbbo=;
  b=KYBahLPGpKEFRqo2Ky8k/76cWywrgR2HVunj6wk/eAAV3HyH4WP2bIHH
   2lH3AZGa1FH9e6eniRzokMjTyfWSn60v7ttl8GuvlHlbmfABq1ZoqWec/
   YJW+Nc1vuuQd3GImueTNkF29qitGsV2vGcfq3/Su8epC2Dad5SnLtVsOI
   D8lmfax+C/+3angvROQSKjwKk54K62qEEPg4oHBJcvtn2TZjm3y9mz2vW
   jmdT6nFAD1JIzJx320nyJyIJ8F0fzYsxYYUiGwc/k1e751CgKlj4vzUYn
   ncFTys8TZbX+CfEZ/8llcOdDRc5eSqMLVSWnDAuHn3zAEUFgh8sENwtM4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="304995338"
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="304995338"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 04:12:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="657872255"
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="657872255"
Received: from lkp-server01.sh.intel.com (HELO 3c15167049b7) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 06 Oct 2022 04:12:20 -0700
Received: from kbuild by 3c15167049b7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ogOnb-00007D-1o;
        Thu, 06 Oct 2022 11:12:19 +0000
Date:   Thu, 06 Oct 2022 19:12:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 17fc2a3f41b37596bbcf1e6b765f0620a8f34c9a
Message-ID: <633eb80a.MSVPIWcYcctfsLNZ%lkp@intel.com>
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
branch HEAD: 17fc2a3f41b37596bbcf1e6b765f0620a8f34c9a  Merge branch 'pci/misc'

elapsed time: 721m

configs tested: 92
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
x86_64                          rhel-8.3-func
alpha                               defconfig
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
x86_64                              defconfig
x86_64                         rhel-8.3-kunit
powerpc                          allmodconfig
m68k                             allmodconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
sh                               allmodconfig
arc                              allyesconfig
mips                             allyesconfig
i386                 randconfig-a011-20221003
alpha                            allyesconfig
i386                 randconfig-a012-20221003
powerpc                           allnoconfig
i386                 randconfig-a013-20221003
m68k                             allyesconfig
i386                 randconfig-a015-20221003
i386                 randconfig-a016-20221003
i386                 randconfig-a014-20221003
arm                                 defconfig
x86_64                           allyesconfig
s390                                defconfig
x86_64               randconfig-a011-20221003
arm64                            allyesconfig
arm                              allyesconfig
s390                             allmodconfig
x86_64               randconfig-a015-20221003
i386                                defconfig
x86_64               randconfig-a014-20221003
x86_64               randconfig-a012-20221003
x86_64               randconfig-a013-20221003
x86_64               randconfig-a016-20221003
s390                             allyesconfig
ia64                             allmodconfig
riscv                randconfig-r042-20221003
arc                  randconfig-r043-20221003
arc                  randconfig-r043-20221002
s390                 randconfig-r044-20221003
i386                             allyesconfig
arm                     eseries_pxa_defconfig
mips                         cobalt_defconfig
openrisc                            defconfig
nios2                            alldefconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
powerpc                     taishan_defconfig
powerpc                       eiger_defconfig
loongarch                        alldefconfig
powerpc                 mpc85xx_cds_defconfig
parisc                generic-64bit_defconfig
i386                          randconfig-c001
mips                 randconfig-c004-20221002
arc                           tb10x_defconfig
um                               alldefconfig
mips                         bigsur_defconfig
mips                        bcm47xx_defconfig
arm                          simpad_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
i386                 randconfig-a003-20221003
i386                 randconfig-a002-20221003
x86_64               randconfig-a003-20221003
x86_64               randconfig-a005-20221003
i386                 randconfig-a001-20221003
x86_64               randconfig-a002-20221003
x86_64               randconfig-a001-20221003
x86_64               randconfig-a004-20221003
x86_64               randconfig-a006-20221003
i386                 randconfig-a006-20221003
i386                 randconfig-a004-20221003
i386                 randconfig-a005-20221003
hexagon              randconfig-r041-20221003
riscv                randconfig-r042-20221002
hexagon              randconfig-r041-20221002
s390                 randconfig-r044-20221002
hexagon              randconfig-r045-20221002
hexagon              randconfig-r045-20221003
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
