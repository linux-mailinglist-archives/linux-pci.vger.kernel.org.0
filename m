Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752CB52D064
	for <lists+linux-pci@lfdr.de>; Thu, 19 May 2022 12:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbiESKZU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 May 2022 06:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiESKZT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 May 2022 06:25:19 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9A2A7E0E
        for <linux-pci@vger.kernel.org>; Thu, 19 May 2022 03:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652955917; x=1684491917;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=4AFKChBmUCdKQ25JFCSH4z7aioj+FxTY8NRUUqW7ShI=;
  b=Ca4CQ12Aa8z4pAHDALEHVxd6NP75R0AsEdlPEstdud/2MT6G/67aweN+
   lQTMZ6NhLCAMQeLKh0HFA8qhIHTgOKzE7FxnCDyhbdAA857783esuAiWK
   RL3munNEUKXZwfAjVlwFEi8LmIyjItktp7MNswR2QH6Ljevd9TYwpIQY4
   Da1vyGVh+UIR8WzmBo6uuoDbcGx7FyNeWea1EO7ba6408DbZOCp0p57Ie
   zadqkbotwMUytANh67jQNBEGdbKC5Rubpeo2Ro1hwP0GaOXSpnG27WT9n
   l1Chwkon54ALClwEoK9mU1pNhMnK4LQ/oBJbPtmrQfi8DU7IA1rxGNA62
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="335183358"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="335183358"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 03:25:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="639722364"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 19 May 2022 03:25:15 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrdLH-0003QF-8K;
        Thu, 19 May 2022 10:25:15 +0000
Date:   Thu, 19 May 2022 18:24:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/error] BUILD SUCCESS
 203926da2bff8e172200a2f11c758987af112d4a
Message-ID: <62861aee.ypPSNKC99TH7gi70%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/error
branch HEAD: 203926da2bff8e172200a2f11c758987af112d4a  PCI/AER: Clear MULTI_ERR_COR/UNCOR_RCV bits

elapsed time: 2126m

configs tested: 60
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
alpha                               defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
parisc64                            defconfig
s390                                defconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
nios2                               defconfig
arc                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
arc                  randconfig-r043-20220518
riscv                randconfig-r042-20220518
s390                 randconfig-r044-20220518
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
hexagon              randconfig-r045-20220518
hexagon              randconfig-r041-20220518

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
