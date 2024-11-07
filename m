Return-Path: <linux-pci+bounces-16199-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 804D19BFF46
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 08:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB001B21C56
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 07:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6A619596F;
	Thu,  7 Nov 2024 07:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ewNlyls8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A27194C7A
	for <linux-pci@vger.kernel.org>; Thu,  7 Nov 2024 07:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730965386; cv=none; b=KHexk90dtWxOyXwnwWIjnPFm77jSWH7Om91SQj6NXzbw5mz+CacxsqLclRtFqcwoB0FAVL22WpcnAeTiA/HFtXTQxwmpZv3njOpo6AvPab/slrqqrl7MMMATOQ7TRLtbF/TCESx3nyISvEDTGNxj7+SmJ8g6NTcrVGB6yUfqRzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730965386; c=relaxed/simple;
	bh=gD5uzS/h3XRhEWd6BuBVzL3N1lBnYZfmK80ZtG5+ra0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=rY/jBFQelMEj9Fnd5y0kmZD0D25pFZI2sZaxb2bt/aJ4zIoy+KoicHRYcvqtkh1wX4lIEdrfwTb+wy1v3y3DuZsyUuiq4RiSqljo/ycfvhsY+Gtx1LbEab32X3WQIo+xbe/tF4m3wCBqF8EFx4k9hvy/Ckl/n0/zQ9/Pl6Fw/ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ewNlyls8; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730965384; x=1762501384;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gD5uzS/h3XRhEWd6BuBVzL3N1lBnYZfmK80ZtG5+ra0=;
  b=ewNlyls8KTGvD4TZCaQERTfl+JvqH2i41UM2YA62wjHttRl5Q+4+o/94
   HPkEb4gLbV4nfnPk1f5Bay/pXk9wtpmwkNSkLW2RZyplSSEEwnQLdK35R
   cQkmqXF6g5a+Q99pmMjYnmpMl0mXJtTlrZklPsyqHh+OWCUG4EtmGZ9t9
   iB3eDJz1lcmZtO5Mt3W0HEd1M0nmNtYiiFp6wdB8suT/KnjjUEP7ws0he
   CWqSH4r58ptSqB0phCYAhIw/GQP/XhsAcxILsonU6/uOBIyY0fWML5wqv
   A7MVz0HWDTgOvWpS14MEomX1I6rikY4l9u/ftNyXFJnA8tWueQcZ0ypmS
   A==;
X-CSE-ConnectionGUID: flz58r0jTW6Qh4cgvcSfZg==
X-CSE-MsgGUID: QaxppxoATPOEnbu95RLHSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34491265"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34491265"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 23:43:04 -0800
X-CSE-ConnectionGUID: DUvR9SabRzmGTuqSb6ibgg==
X-CSE-MsgGUID: VQGaHl3aTkeDdqpNXeIUWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,265,1725346800"; 
   d="scan'208";a="84939007"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 06 Nov 2024 23:43:02 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8xAR-000pxw-24;
	Thu, 07 Nov 2024 07:42:59 +0000
Date: Thu, 07 Nov 2024 15:42:22 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/keystone] BUILD SUCCESS
 eff50062270d2af5ad79b0baf35c1bb027c1de0f
Message-ID: <202411071514.MyH5nS45-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/keystone
branch HEAD: eff50062270d2af5ad79b0baf35c1bb027c1de0f  PCI: keystone: Add link up check to ks_pcie_other_map_bus()

elapsed time: 899m

configs tested: 209
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                          axs103_defconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                        nsimosci_defconfig    clang-20
arc                   randconfig-001-20241107    gcc-14.2.0
arc                   randconfig-002-20241107    gcc-14.2.0
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                          gemini_defconfig    gcc-14.2.0
arm                           h3600_defconfig    gcc-14.2.0
arm                            hisi_defconfig    clang-20
arm                           imxrt_defconfig    gcc-14.2.0
arm                        multi_v7_defconfig    clang-20
arm                             mxs_defconfig    clang-20
arm                         orion5x_defconfig    clang-20
arm                            qcom_defconfig    clang-20
arm                   randconfig-001-20241107    gcc-14.2.0
arm                   randconfig-002-20241107    gcc-14.2.0
arm                   randconfig-003-20241107    gcc-14.2.0
arm                   randconfig-004-20241107    gcc-14.2.0
arm                             rpc_defconfig    clang-20
arm                             rpc_defconfig    gcc-14.2.0
arm                       spear13xx_defconfig    clang-20
arm                       versatile_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241107    gcc-14.2.0
arm64                 randconfig-002-20241107    gcc-14.2.0
arm64                 randconfig-003-20241107    gcc-14.2.0
arm64                 randconfig-004-20241107    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241107    gcc-14.2.0
csky                  randconfig-002-20241107    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241107    gcc-14.2.0
hexagon               randconfig-002-20241107    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241107    clang-19
i386        buildonly-randconfig-002-20241107    clang-19
i386        buildonly-randconfig-003-20241107    clang-19
i386        buildonly-randconfig-004-20241107    clang-19
i386        buildonly-randconfig-005-20241107    clang-19
i386        buildonly-randconfig-006-20241107    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241107    clang-19
i386                  randconfig-002-20241107    clang-19
i386                  randconfig-003-20241107    clang-19
i386                  randconfig-004-20241107    clang-19
i386                  randconfig-005-20241107    clang-19
i386                  randconfig-006-20241107    clang-19
i386                  randconfig-011-20241107    clang-19
i386                  randconfig-012-20241107    clang-19
i386                  randconfig-013-20241107    clang-19
i386                  randconfig-014-20241107    clang-19
i386                  randconfig-015-20241107    clang-19
i386                  randconfig-016-20241107    clang-19
loongarch                        alldefconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241107    gcc-14.2.0
loongarch             randconfig-002-20241107    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                         amcore_defconfig    clang-20
m68k                          amiga_defconfig    clang-20
m68k                          atari_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        m5307c3_defconfig    clang-20
m68k                          multi_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm47xx_defconfig    clang-20
mips                         bigsur_defconfig    clang-20
mips                         db1xxx_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241107    gcc-14.2.0
nios2                 randconfig-002-20241107    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                generic-32bit_defconfig    clang-20
parisc                randconfig-001-20241107    gcc-14.2.0
parisc                randconfig-002-20241107    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      chrp32_defconfig    clang-20
powerpc                        icon_defconfig    clang-20
powerpc                  mpc885_ads_defconfig    clang-20
powerpc                      pcm030_defconfig    clang-20
powerpc                      pcm030_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241107    gcc-14.2.0
powerpc               randconfig-002-20241107    gcc-14.2.0
powerpc               randconfig-003-20241107    gcc-14.2.0
powerpc                     sequoia_defconfig    gcc-14.2.0
powerpc                     tqm8541_defconfig    gcc-14.2.0
powerpc64             randconfig-003-20241107    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    clang-20
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241107    gcc-14.2.0
riscv                 randconfig-002-20241107    gcc-14.2.0
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241107    gcc-14.2.0
s390                  randconfig-002-20241107    gcc-14.2.0
s390                       zfcpdump_defconfig    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         apsh4a3a_defconfig    clang-20
sh                                  defconfig    gcc-12
sh                         ecovec24_defconfig    clang-20
sh                          lboxre2_defconfig    gcc-14.2.0
sh                     magicpanelr2_defconfig    clang-20
sh                            migor_defconfig    gcc-14.2.0
sh                    randconfig-001-20241107    gcc-14.2.0
sh                    randconfig-002-20241107    gcc-14.2.0
sh                           se7721_defconfig    clang-20
sparc                            allmodconfig    gcc-14.2.0
sparc                       sparc32_defconfig    gcc-14.2.0
sparc                       sparc64_defconfig    clang-20
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241107    gcc-14.2.0
sparc64               randconfig-002-20241107    gcc-14.2.0
um                               alldefconfig    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241107    gcc-14.2.0
um                    randconfig-002-20241107    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241107    clang-19
x86_64      buildonly-randconfig-002-20241107    clang-19
x86_64      buildonly-randconfig-003-20241107    clang-19
x86_64      buildonly-randconfig-004-20241107    clang-19
x86_64      buildonly-randconfig-005-20241107    clang-19
x86_64      buildonly-randconfig-006-20241107    clang-19
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241107    clang-19
x86_64                randconfig-002-20241107    clang-19
x86_64                randconfig-003-20241107    clang-19
x86_64                randconfig-004-20241107    clang-19
x86_64                randconfig-005-20241107    clang-19
x86_64                randconfig-006-20241107    clang-19
x86_64                randconfig-011-20241107    clang-19
x86_64                randconfig-012-20241107    clang-19
x86_64                randconfig-013-20241107    clang-19
x86_64                randconfig-014-20241107    clang-19
x86_64                randconfig-015-20241107    clang-19
x86_64                randconfig-016-20241107    clang-19
x86_64                randconfig-071-20241107    clang-19
x86_64                randconfig-072-20241107    clang-19
x86_64                randconfig-073-20241107    clang-19
x86_64                randconfig-074-20241107    clang-19
x86_64                randconfig-075-20241107    clang-19
x86_64                randconfig-076-20241107    clang-19
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241107    gcc-14.2.0
xtensa                randconfig-002-20241107    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

