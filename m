Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C2F649269
	for <lists+linux-pci@lfdr.de>; Sun, 11 Dec 2022 06:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiLKFJP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Dec 2022 00:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiLKFJO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Dec 2022 00:09:14 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4247113DC9
        for <linux-pci@vger.kernel.org>; Sat, 10 Dec 2022 21:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670735353; x=1702271353;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0R079BdROtYc5lm0OcTtz0/x7CoKqMcKCxBeFGN1UPY=;
  b=NhXYyJkSyl9EtYeCKT3L5qYVvFz6mo85CaHbwlS0AC0EMM6FKqMMlJql
   QttRn/cjd7YuAoiaxHrxSE+RNfwhJCO0+zIuL83vr7vCx5GBzt1Yz3ClO
   OwyMy7QvUMVd/KcB2AB5GsSvq9RT4bD+ghbIFvmxyYjbVk5hm75zkJw3w
   WRFrNb3CF909E/L2Uu37Vhf611jJOos6Am2MYfS7uSrLyGwUA/NCMQ9l2
   ChttaKVPShItVwDv2F20nV5jJvuYH4f7re9h4G2hJzpkjTQdbf1eVNkyl
   hgJbwSc1rY3IU/AVQcTtvRL/5U1/V+1i6XbCzO7z3Y6LAI68Yv0FS8cV7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="316368844"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="316368844"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2022 21:09:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="790125520"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="790125520"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 10 Dec 2022 21:09:10 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p4EaL-0002rL-1W;
        Sun, 11 Dec 2022 05:09:09 +0000
Date:   Sun, 11 Dec 2022 13:08:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 f826afe5eae856b3834cbc65db6178cccd4a3142
Message-ID: <639565cd.Znv2k84RVf1Hc7PX%lkp@intel.com>
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
branch HEAD: f826afe5eae856b3834cbc65db6178cccd4a3142  Merge branch 'pci/kbuild'

elapsed time: 725m

configs tested: 81
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
arc                                 defconfig
alpha                               defconfig
x86_64                            allnoconfig
arc                  randconfig-r043-20221211
um                           x86_64_defconfig
arm                  randconfig-r046-20221211
i386                                defconfig
um                             i386_defconfig
x86_64                              defconfig
s390                             allmodconfig
i386                          randconfig-a001
arm                                 defconfig
i386                          randconfig-a014
s390                                defconfig
i386                          randconfig-a012
x86_64                        randconfig-a004
i386                          randconfig-a003
x86_64                               rhel-8.3
i386                          randconfig-a016
s390                             allyesconfig
x86_64                           rhel-8.3-bpf
x86_64                        randconfig-a002
i386                          randconfig-a005
x86_64                           rhel-8.3-syz
i386                             allyesconfig
x86_64                        randconfig-a006
arc                      axs103_smp_defconfig
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a013
x86_64                           allyesconfig
x86_64                           rhel-8.3-kvm
s390                       zfcpdump_defconfig
x86_64                        randconfig-a011
sh                               allmodconfig
sparc64                             defconfig
x86_64                        randconfig-a015
alpha                            allyesconfig
arm                              allyesconfig
arc                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arm64                            allyesconfig
alpha                            alldefconfig
mips                    maltaup_xpa_defconfig
powerpc                     pq2fads_defconfig
mips                             allyesconfig
powerpc                          allmodconfig
i386                          randconfig-c001
x86_64                          rhel-8.3-rust
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arm                           h3600_defconfig
arm                             rpc_defconfig
sh                        sh7763rdp_defconfig
arc                         haps_hs_defconfig
mips                     decstation_defconfig
xtensa                generic_kc705_defconfig
arm                             pxa_defconfig

clang tested configs:
hexagon              randconfig-r041-20221211
hexagon              randconfig-r045-20221211
s390                 randconfig-r044-20221211
riscv                randconfig-r042-20221211
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a002
i386                          randconfig-a015
x86_64                        randconfig-a014
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a006
x86_64                        randconfig-a005
i386                          randconfig-a004
x86_64                        randconfig-a016
arm                         lpc32xx_defconfig
x86_64                        randconfig-a012
arm                          sp7021_defconfig
mips                   sb1250_swarm_defconfig
arm                     am200epdkit_defconfig
mips                     loongson1c_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
