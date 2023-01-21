Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFCE67639F
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jan 2023 05:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjAUEFv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Jan 2023 23:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjAUEFu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jan 2023 23:05:50 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FD94EC4
        for <linux-pci@vger.kernel.org>; Fri, 20 Jan 2023 20:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674273949; x=1705809949;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=M2FABw33GfKNRnSVfP4XlVaEGcU7adGOPz6sVhE4ZhQ=;
  b=EqUvlJwfoW3RZ5JcDlx4ZbHhNypHEkhhlp/sq/6N1Fw3I9rV72YYyqHf
   jTob+jh12pTOM0l9PE285NswFJQ+RRQtrxuZ5AUU6gBMP2q4pSCYKEzAu
   61dmWzXauadiNiC839qA4KuC0pQp2kk3j/HIzNoaaIH/EU/D+4BCiR4ef
   dzZNUHng1R+/gMCi575Y3odJeoZ2Ielcsf/vtdcxa1382eNo18KVlT+NJ
   z2kJfx/HiUuvFie5VINg0elPkTlWE37hpEkxXZ3C6kYOX0iAzRuXB1b0D
   VA0UihcUmT24fayhWAANAVn84Uu+fD/D2toKFsFu1sBqd7CBTRqpgQ5dn
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="309330773"
X-IronPort-AV: E=Sophos;i="5.97,234,1669104000"; 
   d="scan'208";a="309330773"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 20:05:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="691289990"
X-IronPort-AV: E=Sophos;i="5.97,234,1669104000"; 
   d="scan'208";a="691289990"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 20 Jan 2023 20:05:47 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJ58U-0003Ok-23;
        Sat, 21 Jan 2023 04:05:46 +0000
Date:   Sat, 21 Jan 2023 12:05:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/dwc] BUILD SUCCESS
 95624672bb3e6e9ea73fd89554b1836e1398741c
Message-ID: <63cb646c.YxdJcwcsJLxlGV32%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/dwc
branch HEAD: 95624672bb3e6e9ea73fd89554b1836e1398741c  PCI: dwc: Add DW eDMA engine support

elapsed time: 728m

configs tested: 69
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                            allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
powerpc                           allnoconfig
s390                             allyesconfig
arm                  randconfig-r046-20230119
arc                  randconfig-r043-20230119
m68k                             allyesconfig
x86_64                    rhel-8.3-kselftests
m68k                             allmodconfig
x86_64                          rhel-8.3-func
arc                              allyesconfig
alpha                            allyesconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                          randconfig-a001
x86_64                           rhel-8.3-bpf
i386                          randconfig-a003
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a005
x86_64                        randconfig-a006
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                              defconfig
x86_64                        randconfig-a015
arm                                 defconfig
x86_64                               rhel-8.3
arm64                            allyesconfig
i386                                defconfig
arm                              allyesconfig
x86_64                           allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
i386                             allyesconfig
i386                          randconfig-c001
ia64                             allmodconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
x86_64                          rhel-8.3-rust
hexagon              randconfig-r041-20230119
s390                 randconfig-r044-20230119
hexagon              randconfig-r045-20230119
riscv                randconfig-r042-20230119
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a006
x86_64                        randconfig-a005
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
mips                       lemote2f_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                     ksi8560_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
