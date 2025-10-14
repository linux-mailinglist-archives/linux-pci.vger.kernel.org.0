Return-Path: <linux-pci+bounces-38080-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E659BDAFF3
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 21:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5527E19A3C05
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 19:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F07A25A353;
	Tue, 14 Oct 2025 19:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MstY6zhy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39850235072
	for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 19:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760468806; cv=none; b=BBAa5J1X1/uf+Ix/l/O26d2E9SYp/8CcGwywdUMOgikfMe+w12oEMzYGaZUBoJTucQIW/JVcG77hedHSb4PHNIEPO/QpZeZ6bQhD+Kp8b7q4wfnbYm82upCsGVZ0ju3gjgS3JXt/yOfeYwaJ6zaUq5mVHExrpKHV619fRHh4JBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760468806; c=relaxed/simple;
	bh=Lw7RwJak5gHyFHRK9W1RSyBPDAHy1jaqB4G0MlE7UlE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GiDat7l4iybBC568VnbYsydpbRYfPWIxYOcNmiu7BwvDmB28PZsFIokg2GCafNFB+2OsVhWh19+HGjg7oIce04ivQuf+bCJhQNezrGp0CB5OOx4MEGcqvWFriKL9AUh1/RAvOkyMiabbLJbLAljD74hIh7wox/+sa9QC3c7IMb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MstY6zhy; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760468804; x=1792004804;
  h=date:from:to:cc:subject:message-id;
  bh=Lw7RwJak5gHyFHRK9W1RSyBPDAHy1jaqB4G0MlE7UlE=;
  b=MstY6zhyWS5E2ih9n9l8+9eDsOoPmafNgKC58DwcxwmCaTbbw+RR2+Xw
   ZQOtoddLU49uql1ByfJZTzRxMXkLa1qh+SqmpBc1UoKNeYT+la2+SLJmh
   hYzql+Asr7NOFCxZQjRfqBOIN2gqv6QUCpBP7GAkB/+sEcF1jrcJwA2zY
   FqCNUQdwXMsswI8S/qul4d1UuAJXddSKuKLE4I9ApLwQI1EqQpBL0y/Em
   b5QwlUSXDMEfmrTuaf0OlWOLzSpztdL1Dt3W/KLoF0ZlUd3/g0sVGjwu0
   X4nr0ll7gkSyUJI4hAhyTqaSGcdCCxX5YC3FtCAJAizUCsIvI9JqHJB0H
   w==;
X-CSE-ConnectionGUID: gJMBQnEFS5WV8aaVw2rnyw==
X-CSE-MsgGUID: CxwFCdrATCaEBJzIOJ8KUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="50200012"
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="50200012"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 12:06:43 -0700
X-CSE-ConnectionGUID: H+34NOYNQPOJSyP05l5V6A==
X-CSE-MsgGUID: FQNq60WPR/2Kd8L1DmcS+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="182440627"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 14 Oct 2025 12:06:42 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v8kM4-00036t-1O;
	Tue, 14 Oct 2025 19:06:40 +0000
Date: Wed, 15 Oct 2025 03:06:10 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD REGRESSION
 17643231e97742d29227e3ed065f9a16208d3740
Message-ID: <202510150359.YIjuvmSj-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: 17643231e97742d29227e3ed065f9a16208d3740  PCI/VGA: Select SCREEN_INFO

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202510140617.pslAecqF-lkp@intel.com

    (.text+0x171c): undefined reference to `screen_info'
    /usr/bin/ld: include/linux/screen_info.h:25:(.text+0x19f): undefined reference to `screen_info'
    /usr/bin/ld: screen_info_pci.c:(.text+0x3ed): undefined reference to `screen_info'
    aarch64-linux-ld: vgaarb.c:(.text+0x22b4): undefined reference to `screen_info'
    alpha-linux-ld: drivers/pci/vgaarb.c:559:(.text+0x1ccc): undefined reference to `screen_info'
    drivers/pci/vgaarb.c:559:(.text+0x1a08): undefined reference to `screen_info'
    drivers/pci/vgaarb.c:559:(.text.unlikely+0x148c): undefined reference to `screen_info'
    drivers/pci/vgaarb.c:815: undefined reference to `screen_info'
    drivers/video/screen_info_pci.c:111: undefined reference to `screen_info'
    hppa-linux-ld: (.text+0x1720): undefined reference to `screen_info'
    hppa-linux-ld: drivers/pci/vgaarb.c:559: undefined reference to `screen_info'
    include/linux/list.h:191:(.text+0x1738): undefined reference to `screen_info'
    include/linux/screen_info.h:128: undefined reference to `screen_info'
    include/linux/screen_info.h:25:(.text+0x134): undefined reference to `screen_info'
    include/linux/screen_info.h:98:(.text+0x141): undefined reference to `screen_info'
    include/linux/screen_info.h:98:(.text+0x170): undefined reference to `screen_info'
    include/linux/screen_info.h:98:(.text.unlikely+0x9): undefined reference to `screen_info'
    microblaze-linux-ld: include/linux/screen_info.h:46:(.text+0x314): undefined reference to `screen_info'
    powerpc-linux-ld: vgaarb.c:(.text+0x16f6): undefined reference to `screen_info'
    powerpc64-linux-ld: drivers/pci/vgaarb.o:(.toc+0x0): undefined reference to `screen_info'
    powerpc64-linux-ld: drivers/video/screen_info_pci.o:(.toc+0x0): undefined reference to `screen_info'
    sparc-linux-ld: vgaarb.c:(.text+0x14f4): undefined reference to `screen_info'
    vgaarb.c:(.text+0x22b0): dangerous relocation: unsupported relocation

Unverified Error/Warning (likely false positive, kindly check if interested):

    (.head.text+0x0): relocation truncated to fit: R_MIPS_26 against `kernel_entry'
    (.ref.text+0xd8): relocation truncated to fit: R_MIPS_26 against `start_secondary'
    mips-linux-ld: vgaarb.c:(.text.vga_arbiter_add_pci_device+0x850): undefined reference to `screen_info'
    screen_info_pci.c:(.text.screen_info_fixup_lfb+0x88): undefined reference to `screen_info'
    vgaarb.c:(.text.vga_arbiter_add_pci_device+0x848): undefined reference to `screen_info'

Error/Warning ids grouped by kconfigs:

recent_errors
|-- alpha-defconfig
|   |-- alpha-linux-ld:drivers-pci-vgaarb.c:(.text):undefined-reference-to-screen_info
|   |-- drivers-pci-vgaarb.c:(.text):undefined-reference-to-screen_info
|   `-- include-linux-screen_info.h:(.text):undefined-reference-to-screen_info
|-- arm-randconfig-004-20251014
|   |-- drivers-pci-vgaarb.c:undefined-reference-to-screen_info
|   |-- drivers-video-screen_info_pci.c:undefined-reference-to-screen_info
|   `-- include-linux-screen_info.h:undefined-reference-to-screen_info
|-- arm64-randconfig-004-20251014
|   |-- aarch64-linux-ld:vgaarb.c:(.text):undefined-reference-to-screen_info
|   `-- vgaarb.c:(.text):dangerous-relocation:unsupported-relocation
|-- microblaze-defconfig
|   |-- include-linux-list.h:(.text):undefined-reference-to-screen_info
|   |-- include-linux-screen_info.h:(.text):undefined-reference-to-screen_info
|   `-- microblaze-linux-ld:include-linux-screen_info.h:(.text):undefined-reference-to-screen_info
|-- mips-allyesconfig
|   |-- (.head.text):relocation-truncated-to-fit:R_MIPS_26-against-kernel_entry
|   |-- (.ref.text):relocation-truncated-to-fit:R_MIPS_26-against-start_secondary
|   |-- mips-linux-ld:vgaarb.c:(.text.vga_arbiter_add_pci_device):undefined-reference-to-screen_info
|   |-- screen_info_pci.c:(.text.screen_info_fixup_lfb):undefined-reference-to-screen_info
|   `-- vgaarb.c:(.text.vga_arbiter_add_pci_device):undefined-reference-to-screen_info
|-- parisc-defconfig
|   |-- (.text):undefined-reference-to-screen_info
|   `-- hppa-linux-ld:(.text):undefined-reference-to-screen_info
|-- parisc-randconfig-002-20251014
|   `-- hppa-linux-ld:drivers-pci-vgaarb.c:undefined-reference-to-screen_info
|-- powerpc-icon_defconfig
|   `-- powerpc-linux-ld:vgaarb.c:(.text):undefined-reference-to-screen_info
|-- powerpc64-randconfig-001-20251014
|   |-- powerpc64-linux-ld:drivers-pci-vgaarb.o:(.toc):undefined-reference-to-screen_info
|   `-- powerpc64-linux-ld:drivers-video-screen_info_pci.o:(.toc):undefined-reference-to-screen_info
|-- sparc-defconfig
|   `-- sparc-linux-ld:vgaarb.c:(.text):undefined-reference-to-screen_info
|-- um-allyesconfig
|   `-- usr-bin-ld:screen_info_pci.c:(.text):undefined-reference-to-screen_info
`-- um-randconfig-002-20251014
    |-- drivers-pci-vgaarb.c:(.text.unlikely):undefined-reference-to-screen_info
    |-- include-linux-screen_info.h:(.text):undefined-reference-to-screen_info
    |-- include-linux-screen_info.h:(.text.unlikely):undefined-reference-to-screen_info
    `-- usr-bin-ld:include-linux-screen_info.h:(.text):undefined-reference-to-screen_info

elapsed time: 1456m

configs tested: 127
configs skipped: 4

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251014    gcc-15.1.0
arc                   randconfig-002-20251014    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                         mv78xx0_defconfig    clang-19
arm                   randconfig-001-20251014    gcc-15.1.0
arm                   randconfig-002-20251014    gcc-13.4.0
arm                   randconfig-003-20251014    clang-16
arm                   randconfig-004-20251014    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251014    gcc-9.5.0
arm64                 randconfig-002-20251014    gcc-10.5.0
arm64                 randconfig-003-20251014    gcc-14.3.0
arm64                 randconfig-004-20251014    gcc-14.3.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251014    gcc-15.1.0
csky                  randconfig-002-20251014    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251014    clang-22
hexagon               randconfig-002-20251014    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251014    gcc-14
i386        buildonly-randconfig-002-20251014    clang-20
i386        buildonly-randconfig-003-20251014    clang-20
i386        buildonly-randconfig-004-20251014    gcc-14
i386        buildonly-randconfig-005-20251014    gcc-14
i386        buildonly-randconfig-006-20251014    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251014    clang-18
loongarch             randconfig-002-20251014    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          ath79_defconfig    gcc-15.1.0
mips                            gpr_defconfig    clang-18
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251014    gcc-11.5.0
nios2                 randconfig-002-20251014    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251014    gcc-11.5.0
parisc                randconfig-002-20251014    gcc-9.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      bamboo_defconfig    clang-22
powerpc                        cell_defconfig    gcc-15.1.0
powerpc                        icon_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251014    gcc-9.5.0
powerpc               randconfig-002-20251014    clang-22
powerpc               randconfig-003-20251014    gcc-14.3.0
powerpc                 xes_mpc85xx_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251014    gcc-8.5.0
powerpc64             randconfig-002-20251014    gcc-8.5.0
powerpc64             randconfig-003-20251014    gcc-8.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251014    gcc-10.5.0
riscv                 randconfig-002-20251014    gcc-10.5.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251014    clang-22
s390                  randconfig-002-20251014    clang-19
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251014    gcc-14.3.0
sh                    randconfig-002-20251014    gcc-11.5.0
sh                           se7705_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251014    gcc-15.1.0
sparc                 randconfig-002-20251014    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251014    clang-20
sparc64               randconfig-002-20251014    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251014    gcc-14
um                    randconfig-002-20251014    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251014    gcc-14
x86_64      buildonly-randconfig-002-20251014    clang-20
x86_64      buildonly-randconfig-003-20251014    gcc-14
x86_64      buildonly-randconfig-004-20251014    clang-20
x86_64      buildonly-randconfig-005-20251014    clang-20
x86_64      buildonly-randconfig-006-20251014    gcc-14
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251014    gcc-8.5.0
xtensa                randconfig-002-20251014    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

