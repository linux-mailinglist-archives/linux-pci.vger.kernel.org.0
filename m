Return-Path: <linux-pci+bounces-24532-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB7EA6DCA7
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 15:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31741188FAB4
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 14:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4229C2505C5;
	Mon, 24 Mar 2025 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dV2e+4z2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D9525F7B7
	for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825601; cv=none; b=pP4UiPBPJvuo9fQVyOT2an1sTqmNpDbs9GN4motTV+oe+kC4s4NUpLoVhafwF5NonEy1LomIbCl8wa6AF5VUo522rJyXj8W1ey5vPeyu+EyyrIcy9AJt6l8WXq1jBHEC5gSdFVm7IAl0gpPoILqELpGfdufMA/TFO+mHrsNLmFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825601; c=relaxed/simple;
	bh=g2Lx+H4OYH5qppgxS/VQc7zylc0CQBZAdhgYKhYZWb0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=rodNuXT1+obP8Bs9AsAGGa++qr9yyRT/y3JD76CQI4QoSvInYUFGmrRM/ecFE3vanAzppsXUFiofH2rbvJlzithH8dxIGjeaaKmDg249YAu6yrYPOaDzCIAY80VEh0cCTjEGS1QkPhZDK4cfrOx1VAMOaU5SyO7zl6jSDotvbrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dV2e+4z2; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742825599; x=1774361599;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=g2Lx+H4OYH5qppgxS/VQc7zylc0CQBZAdhgYKhYZWb0=;
  b=dV2e+4z2dQoJ4CFOhxEgGSRNfWSqhki9ZOFDO8K9RGyVsmg16YJ9Wv+M
   /EF0g5enqj8JhG2AS+DSWbEXzelc/MH3BvdoOv/Dqa/On28uAjiSSgMnF
   /TOp0TKBxIo4ghnRu8mItGGKDC4VffEv+WK1y7eBqAunpsT2PG9GRsjbf
   w5kac06RFnZ3LzPm0p1q5jDwB2bdOKsTO87uAeDytoKDHqUIxNSocClcN
   dwndUsf/qIfpO/rnpadXhUNtOM6dGtYEBXrjdEcn7x5fc5y2Rdv03Lk+t
   9fWMleFc4lm3Rb9TuLZPYoYFK2k0bogDm4ByUO85d8kUGxZwifND8Ad80
   Q==;
X-CSE-ConnectionGUID: mOHJini1Sde+I1WFHLe/7A==
X-CSE-MsgGUID: 3NOzTG4rRZKStOgoH47L2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="46776468"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="46776468"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 07:13:16 -0700
X-CSE-ConnectionGUID: PM6dWrJNSOmnC6I74XWZBA==
X-CSE-MsgGUID: 1Nb8HgDoTVmDEiBfuMPxOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="128751292"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 24 Mar 2025 07:13:15 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1twiYD-0003el-02;
	Mon, 24 Mar 2025 14:13:13 +0000
Date: Mon, 24 Mar 2025 22:13:12 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/xilinx-cpm] BUILD SUCCESS
 9e141923cf86b2e1c83d21b87fb4de3d14a20c99
Message-ID: <202503242206.4b7TXOjO-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/xilinx-cpm
branch HEAD: 9e141923cf86b2e1c83d21b87fb4de3d14a20c99  PCI: xilinx-cpm: Add cpm_csr register mapping for CPM5_HOST1 variant

elapsed time: 1441m

configs tested: 184
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                      axs103_smp_defconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250323    gcc-11.5.0
arc                   randconfig-002-20250323    gcc-13.3.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                   randconfig-001-20250323    gcc-7.5.0
arm                   randconfig-002-20250323    gcc-9.3.0
arm                   randconfig-003-20250323    clang-15
arm                   randconfig-004-20250323    gcc-5.5.0
arm                        realview_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250323    clang-21
arm64                 randconfig-002-20250323    gcc-5.5.0
arm64                 randconfig-003-20250323    gcc-9.5.0
arm64                 randconfig-004-20250323    gcc-7.5.0
csky                             alldefconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250323    gcc-13.3.0
csky                  randconfig-002-20250323    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250323    clang-21
hexagon               randconfig-002-20250323    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250323    clang-20
i386        buildonly-randconfig-002-20250323    gcc-12
i386        buildonly-randconfig-003-20250323    clang-20
i386        buildonly-randconfig-004-20250323    clang-20
i386        buildonly-randconfig-005-20250323    gcc-12
i386        buildonly-randconfig-006-20250323    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250324    gcc-12
i386                  randconfig-002-20250324    gcc-12
i386                  randconfig-003-20250324    gcc-12
i386                  randconfig-004-20250324    gcc-12
i386                  randconfig-005-20250324    gcc-12
i386                  randconfig-006-20250324    gcc-12
i386                  randconfig-007-20250324    gcc-12
i386                  randconfig-011-20250324    clang-20
i386                  randconfig-012-20250324    clang-20
i386                  randconfig-013-20250324    clang-20
i386                  randconfig-014-20250324    clang-20
i386                  randconfig-015-20250324    clang-20
i386                  randconfig-016-20250324    clang-20
i386                  randconfig-017-20250324    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250323    gcc-14.2.0
loongarch             randconfig-002-20250323    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       bvme6000_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        m5307c3_defconfig    gcc-14.2.0
m68k                       m5475evb_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
microblaze                      mmu_defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250323    gcc-13.3.0
nios2                 randconfig-002-20250323    gcc-9.3.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250323    gcc-10.5.0
parisc                randconfig-002-20250323    gcc-6.5.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                        cell_defconfig    gcc-14.2.0
powerpc                      mgcoge_defconfig    gcc-14.2.0
powerpc                  mpc885_ads_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250323    gcc-9.3.0
powerpc               randconfig-002-20250323    gcc-7.5.0
powerpc               randconfig-003-20250323    gcc-9.3.0
powerpc                    sam440ep_defconfig    gcc-14.2.0
powerpc                     taishan_defconfig    gcc-14.2.0
powerpc                     tqm8555_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250323    clang-16
powerpc64             randconfig-002-20250323    gcc-9.3.0
powerpc64             randconfig-003-20250323    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250323    gcc-9.3.0
riscv                 randconfig-002-20250323    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                                defconfig    gcc-12
s390                  randconfig-001-20250323    gcc-8.5.0
s390                  randconfig-002-20250323    clang-15
s390                       zfcpdump_defconfig    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                        edosk7760_defconfig    gcc-14.2.0
sh                            hp6xx_defconfig    gcc-14.2.0
sh                          polaris_defconfig    gcc-14.2.0
sh                    randconfig-001-20250323    gcc-5.5.0
sh                    randconfig-002-20250323    gcc-5.5.0
sh                          rsk7203_defconfig    gcc-14.2.0
sh                        sh7763rdp_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250323    gcc-14.2.0
sparc                 randconfig-002-20250323    gcc-10.3.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250323    gcc-14.2.0
sparc64               randconfig-002-20250323    gcc-6.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250323    gcc-12
um                    randconfig-002-20250323    clang-17
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250323    clang-20
x86_64      buildonly-randconfig-002-20250323    clang-20
x86_64      buildonly-randconfig-003-20250323    gcc-12
x86_64      buildonly-randconfig-004-20250323    clang-20
x86_64      buildonly-randconfig-005-20250323    clang-20
x86_64      buildonly-randconfig-006-20250323    clang-20
x86_64                              defconfig    gcc-11
x86_64                randconfig-001-20250324    gcc-12
x86_64                randconfig-002-20250324    gcc-12
x86_64                randconfig-003-20250324    gcc-12
x86_64                randconfig-004-20250324    gcc-12
x86_64                randconfig-005-20250324    gcc-12
x86_64                randconfig-006-20250324    gcc-12
x86_64                randconfig-007-20250324    gcc-12
x86_64                randconfig-008-20250324    gcc-12
x86_64                randconfig-071-20250324    clang-20
x86_64                randconfig-072-20250324    clang-20
x86_64                randconfig-073-20250324    clang-20
x86_64                randconfig-074-20250324    clang-20
x86_64                randconfig-075-20250324    clang-20
x86_64                randconfig-076-20250324    clang-20
x86_64                randconfig-077-20250324    clang-20
x86_64                randconfig-078-20250324    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                  nommu_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250323    gcc-14.2.0
xtensa                randconfig-002-20250323    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

