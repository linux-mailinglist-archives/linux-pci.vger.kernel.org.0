Return-Path: <linux-pci+bounces-15859-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E18C89BA357
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 01:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4A71C20A22
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 00:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC42FDDBB;
	Sun,  3 Nov 2024 00:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d/tN5j/w"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41F379F2
	for <linux-pci@vger.kernel.org>; Sun,  3 Nov 2024 00:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730595488; cv=none; b=MvpQsTffqV43o/QTAFXojzI+n9+FgYP1TtTWjZjys/JwePhdO9snsPc25GAYMXch0aR28AkIXeENh8Ay7MwX6DezCAu7WYzf4xz+2rQMRA6m9WsttUrDL2QCW/Lpzpqczf2MFFiiDFqDLz1xPFCdzRUszKVMOt8Lq++HgnUlCPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730595488; c=relaxed/simple;
	bh=Lr/Ux0XxigAHWVTAGwjKSh6x2vlcDxxzf7dn2Hvpwdc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=eTJrvvV0p6glE/GlVR7RSrZgG0ELjSOtMgJfjHi0Jy1BzFkTZyqVGnxijr2YL7dZ+e4sBEo/mF6BYmo1Vsjr7laUXMMwY6Z1wL40ClBOOcflaajXbE/vHzllHZmlPABoQVdsdbCakQux/sO39xWL5T2/DvVaYHG5ADNcsV4kNAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d/tN5j/w; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730595487; x=1762131487;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Lr/Ux0XxigAHWVTAGwjKSh6x2vlcDxxzf7dn2Hvpwdc=;
  b=d/tN5j/wvM+MWiz0LzptrRczfOLEYR/WwxgBMxl7vlKgqx0TVq6oodIy
   7tdQVDSYDFqFnG+TiHOeIJmDGQrJp0tfUznq6qqnVK1kGaLEAWD9PkARV
   u2myr2jmx5rGAKQ57MYn6VULWHkpuxPj12XSHubEPnnq9yHT+WOPKgOh6
   ziq75Z4zbLii+kAReehqqvl6AFvVnNHTR7U5ieUcL9ssrufE3hoko4fi+
   o+z4kzhhkIjaMOSB6PLzIrehEsX5Yx/NiHXNNqR1r3pPE8aomvsyK23nh
   J0qmXKVyMJ+oeECa7sjClcmWsVJaz66AZTgEtOcWtI/GR60N92C99ZbsE
   g==;
X-CSE-ConnectionGUID: eEJxxUuTTOOwffhISIPRmQ==
X-CSE-MsgGUID: caBom9q9Tf6BScaQ65rhlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11244"; a="41690687"
X-IronPort-AV: E=Sophos;i="6.11,254,1725346800"; 
   d="scan'208";a="41690687"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 17:58:06 -0700
X-CSE-ConnectionGUID: 9a0M3k8jQn6Xj8OpLZc51g==
X-CSE-MsgGUID: wyHBlOlIQfKPVvo0LldlyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,254,1725346800"; 
   d="scan'208";a="83186778"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 02 Nov 2024 17:58:04 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7OwM-000jWb-17;
	Sun, 03 Nov 2024 00:58:02 +0000
Date: Sun, 03 Nov 2024 08:57:26 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 f68da9a671739adacc02a6fcb5d0a4806147ecfa
Message-ID: <202411030814.ZdvJepFz-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: f68da9a671739adacc02a6fcb5d0a4806147ecfa  PCI: dwc: ep: Use align addr function for dw_pcie_ep_raise_{msi,msix}_irq()

elapsed time: 735m

configs tested: 193
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                      axs103_smp_defconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.1.0
arc                   randconfig-001-20241103    gcc-14.1.0
arc                   randconfig-002-20241103    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                     davinci_all_defconfig    gcc-14.1.0
arm                                 defconfig    gcc-14.1.0
arm                         lpc32xx_defconfig    gcc-14.1.0
arm                          pxa168_defconfig    gcc-13.2.0
arm                   randconfig-001-20241103    gcc-14.1.0
arm                   randconfig-002-20241103    gcc-14.1.0
arm                   randconfig-003-20241103    gcc-14.1.0
arm                   randconfig-004-20241103    gcc-14.1.0
arm                           sama5_defconfig    gcc-13.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241103    gcc-14.1.0
arm64                 randconfig-002-20241103    gcc-14.1.0
arm64                 randconfig-003-20241103    gcc-14.1.0
arm64                 randconfig-004-20241103    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241103    gcc-14.1.0
csky                  randconfig-002-20241103    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241103    gcc-14.1.0
hexagon               randconfig-002-20241103    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241103    clang-19
i386        buildonly-randconfig-002-20241103    clang-19
i386        buildonly-randconfig-003-20241103    clang-19
i386        buildonly-randconfig-004-20241103    clang-19
i386        buildonly-randconfig-005-20241103    clang-19
i386        buildonly-randconfig-006-20241103    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241103    clang-19
i386                  randconfig-002-20241103    clang-19
i386                  randconfig-003-20241103    clang-19
i386                  randconfig-004-20241103    clang-19
i386                  randconfig-005-20241103    clang-19
i386                  randconfig-006-20241103    clang-19
i386                  randconfig-011-20241103    clang-19
i386                  randconfig-012-20241103    clang-19
i386                  randconfig-013-20241103    clang-19
i386                  randconfig-014-20241103    clang-19
i386                  randconfig-015-20241103    clang-19
i386                  randconfig-016-20241103    clang-19
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241103    gcc-14.1.0
loongarch             randconfig-002-20241103    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                          hp300_defconfig    gcc-14.1.0
m68k                            mac_defconfig    gcc-14.1.0
m68k                        stmark2_defconfig    gcc-13.2.0
m68k                           virt_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                        bcm63xx_defconfig    gcc-13.2.0
mips                          eyeq5_defconfig    gcc-14.1.0
mips                           ip27_defconfig    gcc-13.2.0
mips                           mtx1_defconfig    gcc-13.2.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241103    gcc-14.1.0
nios2                 randconfig-002-20241103    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
openrisc                 simple_smp_defconfig    gcc-14.1.0
openrisc                       virt_defconfig    gcc-13.2.0
openrisc                       virt_defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241103    gcc-14.1.0
parisc                randconfig-002-20241103    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                        fsp2_defconfig    gcc-13.2.0
powerpc                    gamecube_defconfig    gcc-14.1.0
powerpc                      pasemi_defconfig    gcc-14.1.0
powerpc                      pmac32_defconfig    gcc-14.1.0
powerpc                      ppc6xx_defconfig    gcc-14.1.0
powerpc               randconfig-001-20241103    gcc-14.1.0
powerpc               randconfig-002-20241103    gcc-14.1.0
powerpc               randconfig-003-20241103    gcc-14.1.0
powerpc                     redwood_defconfig    gcc-13.2.0
powerpc                     redwood_defconfig    gcc-14.1.0
powerpc64                        alldefconfig    gcc-14.1.0
powerpc64             randconfig-001-20241103    gcc-14.1.0
powerpc64             randconfig-002-20241103    gcc-14.1.0
powerpc64             randconfig-003-20241103    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv             nommu_k210_sdcard_defconfig    gcc-14.1.0
riscv                 randconfig-001-20241103    gcc-14.1.0
riscv                 randconfig-002-20241103    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241103    gcc-14.1.0
s390                  randconfig-002-20241103    gcc-14.1.0
sh                               alldefconfig    gcc-13.2.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                     magicpanelr2_defconfig    gcc-13.2.0
sh                    randconfig-001-20241103    gcc-14.1.0
sh                    randconfig-002-20241103    gcc-14.1.0
sh                           se7705_defconfig    gcc-13.2.0
sh                            shmin_defconfig    gcc-13.2.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241103    gcc-14.1.0
sparc64               randconfig-002-20241103    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                             i386_defconfig    gcc-14.1.0
um                    randconfig-001-20241103    gcc-14.1.0
um                    randconfig-002-20241103    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241103    clang-19
x86_64      buildonly-randconfig-002-20241103    clang-19
x86_64      buildonly-randconfig-003-20241103    clang-19
x86_64      buildonly-randconfig-004-20241103    clang-19
x86_64      buildonly-randconfig-005-20241103    clang-19
x86_64      buildonly-randconfig-006-20241103    clang-19
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241103    clang-19
x86_64                randconfig-002-20241103    clang-19
x86_64                randconfig-003-20241103    clang-19
x86_64                randconfig-004-20241103    clang-19
x86_64                randconfig-005-20241103    clang-19
x86_64                randconfig-006-20241103    clang-19
x86_64                randconfig-011-20241103    clang-19
x86_64                randconfig-012-20241103    clang-19
x86_64                randconfig-013-20241103    clang-19
x86_64                randconfig-014-20241103    clang-19
x86_64                randconfig-015-20241103    clang-19
x86_64                randconfig-016-20241103    clang-19
x86_64                randconfig-071-20241103    clang-19
x86_64                randconfig-072-20241103    clang-19
x86_64                randconfig-073-20241103    clang-19
x86_64                randconfig-074-20241103    clang-19
x86_64                randconfig-075-20241103    clang-19
x86_64                randconfig-076-20241103    clang-19
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  cadence_csp_defconfig    gcc-13.2.0
xtensa                randconfig-001-20241103    gcc-14.1.0
xtensa                randconfig-002-20241103    gcc-14.1.0
xtensa                    smp_lx200_defconfig    gcc-13.2.0
xtensa                    xip_kc705_defconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

