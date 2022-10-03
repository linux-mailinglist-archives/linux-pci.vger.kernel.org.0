Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492E35F3933
	for <lists+linux-pci@lfdr.de>; Tue,  4 Oct 2022 00:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiJCWiP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Oct 2022 18:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiJCWiG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Oct 2022 18:38:06 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1F0459B6
        for <linux-pci@vger.kernel.org>; Mon,  3 Oct 2022 15:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664836686; x=1696372686;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=7L4v6LJwBWavk3IRZI5Y0siQsTj2zN1zieALloKuwMA=;
  b=OQKdtbAh+uIK42obFBbK7Jod/1pB+APke5Au2jjzIFFjtuJjjZbZ/PhI
   Dto3S8UihU93iDF+8hB3Byy1D3X+QIPjXZvJapk4u9hyMxNm/Dd0vqXns
   0QH11lxKUocflOpshIH44KunWBRVjzPjbgtMV6J3D6NDOwU7ae8Om/q1G
   t/2vQZwT1Xo/Q509+nq2Pshnv1qGypZVBCMvKXTlhlMlHoiqt5frSy9oo
   JQ6ZB/LZsv7PoISE295od1IQuaCcatjmfY8dAJkklE2Ib510hp+EV5Uo9
   /C/8dia2LuZXPDpCAJHC18Rm5sHNsljQG8Wm5a7kUpEGFkiKVZEaFAzRU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="283141809"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="283141809"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 15:38:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="625968799"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="625968799"
Received: from lkp-server01.sh.intel.com (HELO 14cc182da2d0) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 03 Oct 2022 15:38:04 -0700
Received: from kbuild by 14cc182da2d0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ofU4a-00050N-0Z;
        Mon, 03 Oct 2022 22:38:04 +0000
Date:   Tue, 04 Oct 2022 06:37:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/dwc] BUILD SUCCESS
 cbcf8722b523dcf0970ab67dc3d5ced1ea7b334e
Message-ID: <633b6443.mjrR9nr+OZRDttKw%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/dwc
branch HEAD: cbcf8722b523dcf0970ab67dc3d5ced1ea7b334e  phy: freescale: imx8m-pcie: Fix the wrong order of phy_init() and phy_power_on()

elapsed time: 726m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                                defconfig
x86_64                              defconfig
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
powerpc                           allnoconfig
x86_64                    rhel-8.3-kselftests
s390                             allyesconfig
i386                 randconfig-a014-20221003
i386                 randconfig-a011-20221003
i386                 randconfig-a012-20221003
i386                 randconfig-a013-20221003
i386                 randconfig-a015-20221003
i386                 randconfig-a016-20221003
x86_64                               rhel-8.3
i386                                defconfig
x86_64                           allyesconfig
x86_64               randconfig-a011-20221003
x86_64               randconfig-a012-20221003
x86_64               randconfig-a013-20221003
arc                              allyesconfig
x86_64               randconfig-a014-20221003
alpha                            allyesconfig
arm                                 defconfig
x86_64               randconfig-a016-20221003
x86_64               randconfig-a015-20221003
m68k                             allmodconfig
m68k                             allyesconfig
riscv                randconfig-r042-20221003
arc                  randconfig-r043-20221003
arc                  randconfig-r043-20221002
ia64                             allmodconfig
i386                             allyesconfig
s390                 randconfig-r044-20221003
arm                              allyesconfig
arm64                            allyesconfig
sh                               allmodconfig
powerpc                          allmodconfig
mips                             allyesconfig

clang tested configs:
i386                 randconfig-a003-20221003
hexagon              randconfig-r041-20221003
i386                 randconfig-a002-20221003
i386                 randconfig-a001-20221003
riscv                randconfig-r042-20221002
x86_64               randconfig-a002-20221003
x86_64               randconfig-a001-20221003
hexagon              randconfig-r041-20221002
s390                 randconfig-r044-20221002
x86_64               randconfig-a004-20221003
x86_64               randconfig-a006-20221003
x86_64               randconfig-a003-20221003
hexagon              randconfig-r045-20221002
x86_64               randconfig-a005-20221003
hexagon              randconfig-r045-20221003
i386                 randconfig-a004-20221003
i386                 randconfig-a005-20221003
i386                 randconfig-a006-20221003

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
