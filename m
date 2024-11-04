Return-Path: <linux-pci+bounces-15905-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327CA9BAC51
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 07:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E53BA281E0E
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 06:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8253218BB82;
	Mon,  4 Nov 2024 06:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T7vRxL0x"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA6B6FC5
	for <linux-pci@vger.kernel.org>; Mon,  4 Nov 2024 06:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730700408; cv=none; b=DL8bhP2IW7ZJgDZt1Qg6F0SJH0OHmDrqhPLRfvi9L1Q5s4EYaKxme4Gh5JAei+R4ilgRQIJTIqqIz1JOjSiXyty0pQcdxBD30Y3RrLOqfFLk44Y9E0+PLF6Rnaib/wIsKhGHV8b77bNLBXZ6fIGbxxRWpBulSJ/ri8i8lrzA724=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730700408; c=relaxed/simple;
	bh=cn1Pxm/UDdq45+jKyhojyir0BhxJVvPNCKCW9rbn4Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PhKOfhnBW8g+G0Fv4aU8OzYloLvpCxEBAKCh7W8hSMHD/QkcZnuIgjODo5lVpFaWJ9xwf7CJbWjecWlpGRCQcz6eqrgFEFb425id79kmF4B3LbICS+MWQyG0qEKLVV6KRtWt2w3K+5dsPNSOFjszjSJwzqHXb/geo+WM1OUJm8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T7vRxL0x; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730700406; x=1762236406;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cn1Pxm/UDdq45+jKyhojyir0BhxJVvPNCKCW9rbn4Dg=;
  b=T7vRxL0x4e/SzW114K8WkQ+3Jpm5wPiftZ/RtKcjMPX7Q8HcRmLpaTJY
   CbIyJQq+WoNdhURNT2Ktmd5sS+0LxCIW/oaI5TTSdveSlsWr4MUGpKwVG
   wvgVSPEjDeSsbt+n4S702DLApWzDt2Ld1LbF4ldkeBoRpXofcBlWZcwkc
   feruLr8TokkU+q8uGU5HIV8kMkqaZm1pWOFCsrhCRJ4uX8OqUmOKteC9Y
   Vqq2JXu+3ceUhtvPLmMPnugNo4o9YfVU6NTKSs8HRTuSDsxFDNj6WW1JO
   kPM27+LpQJcrhifZ0liEDzv8xCIVganbUiQE8urjFqFO3/HLFYxNs0Wie
   w==;
X-CSE-ConnectionGUID: x2OGw43wQfikHdlIIqUsfA==
X-CSE-MsgGUID: MoxzFEbKSVyb0wUSx1eHpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="41774380"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="41774380"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 22:06:46 -0800
X-CSE-ConnectionGUID: ahtjgCzERRilbZfqKyaOmg==
X-CSE-MsgGUID: PSyZYQAZTLu6yVL04FWjtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="83660400"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 03 Nov 2024 22:06:44 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7qEc-000kWR-17;
	Mon, 04 Nov 2024 06:06:42 +0000
Date: Mon, 04 Nov 2024 14:05:58 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/tegra194] BUILD SUCCESS
 40e2125381dc11379112485e3eefdd25c6df5375
Message-ID: <202411041452.jD3v7gAS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/tegra194
branch HEAD: 40e2125381dc11379112485e3eefdd25c6df5375  PCI: tegra194: Move controller cleanups to pex_ep_event_pex_rst_deassert()

elapsed time: 1233m

configs tested: 342
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                      axs103_smp_defconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.1.0
arc                   randconfig-001-20241103    gcc-14.1.0
arc                   randconfig-001-20241104    gcc-14.1.0
arc                   randconfig-002-20241103    gcc-14.1.0
arc                   randconfig-002-20241104    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.1.0
arm                     am200epdkit_defconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                       netwinder_defconfig    gcc-14.1.0
arm                         nhk8815_defconfig    clang-20
arm                          pxa168_defconfig    gcc-13.2.0
arm                   randconfig-001-20241103    gcc-14.1.0
arm                   randconfig-001-20241104    gcc-14.1.0
arm                   randconfig-002-20241103    gcc-14.1.0
arm                   randconfig-002-20241104    gcc-14.1.0
arm                   randconfig-003-20241103    gcc-14.1.0
arm                   randconfig-003-20241104    gcc-14.1.0
arm                   randconfig-004-20241103    gcc-14.1.0
arm                   randconfig-004-20241104    gcc-14.1.0
arm                           sama5_defconfig    gcc-13.2.0
arm                           spitz_defconfig    gcc-14.1.0
arm                       versatile_defconfig    clang-20
arm                         wpcm450_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241103    gcc-14.1.0
arm64                 randconfig-001-20241104    gcc-14.1.0
arm64                 randconfig-002-20241103    gcc-14.1.0
arm64                 randconfig-002-20241104    gcc-14.1.0
arm64                 randconfig-003-20241103    gcc-14.1.0
arm64                 randconfig-003-20241104    gcc-14.1.0
arm64                 randconfig-004-20241103    gcc-14.1.0
arm64                 randconfig-004-20241104    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241103    gcc-14.1.0
csky                  randconfig-001-20241104    gcc-14.1.0
csky                  randconfig-002-20241103    gcc-14.1.0
csky                  randconfig-002-20241104    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241103    gcc-14.1.0
hexagon               randconfig-001-20241104    gcc-14.1.0
hexagon               randconfig-002-20241103    gcc-14.1.0
hexagon               randconfig-002-20241104    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241103    clang-19
i386        buildonly-randconfig-001-20241103    gcc-12
i386        buildonly-randconfig-001-20241104    gcc-12
i386        buildonly-randconfig-002-20241103    clang-19
i386        buildonly-randconfig-002-20241104    gcc-12
i386        buildonly-randconfig-003-20241103    clang-19
i386        buildonly-randconfig-003-20241103    gcc-11
i386        buildonly-randconfig-003-20241104    gcc-12
i386        buildonly-randconfig-004-20241103    clang-19
i386        buildonly-randconfig-004-20241103    gcc-12
i386        buildonly-randconfig-004-20241104    gcc-12
i386        buildonly-randconfig-005-20241103    clang-19
i386        buildonly-randconfig-005-20241104    gcc-12
i386        buildonly-randconfig-006-20241103    clang-19
i386        buildonly-randconfig-006-20241103    gcc-12
i386        buildonly-randconfig-006-20241104    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241103    clang-19
i386                  randconfig-001-20241103    gcc-12
i386                  randconfig-001-20241104    gcc-12
i386                  randconfig-002-20241103    clang-19
i386                  randconfig-002-20241103    gcc-12
i386                  randconfig-002-20241104    gcc-12
i386                  randconfig-003-20241103    clang-19
i386                  randconfig-003-20241104    gcc-12
i386                  randconfig-004-20241103    clang-19
i386                  randconfig-004-20241104    gcc-12
i386                  randconfig-005-20241103    clang-19
i386                  randconfig-005-20241103    gcc-12
i386                  randconfig-005-20241104    gcc-12
i386                  randconfig-006-20241103    clang-19
i386                  randconfig-006-20241103    gcc-11
i386                  randconfig-006-20241104    gcc-12
i386                  randconfig-011-20241103    clang-19
i386                  randconfig-011-20241104    gcc-12
i386                  randconfig-012-20241103    clang-19
i386                  randconfig-012-20241104    gcc-12
i386                  randconfig-013-20241103    clang-19
i386                  randconfig-013-20241103    gcc-12
i386                  randconfig-013-20241104    gcc-12
i386                  randconfig-014-20241103    clang-19
i386                  randconfig-014-20241104    gcc-12
i386                  randconfig-015-20241103    clang-19
i386                  randconfig-015-20241103    gcc-12
i386                  randconfig-015-20241104    gcc-12
i386                  randconfig-016-20241103    clang-19
i386                  randconfig-016-20241103    gcc-12
i386                  randconfig-016-20241104    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241103    gcc-14.1.0
loongarch             randconfig-001-20241104    gcc-14.1.0
loongarch             randconfig-002-20241103    gcc-14.1.0
loongarch             randconfig-002-20241104    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                         apollo_defconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                        m5307c3_defconfig    gcc-14.1.0
m68k                            q40_defconfig    gcc-14.1.0
m68k                        stmark2_defconfig    gcc-13.2.0
m68k                           virt_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                        bcm47xx_defconfig    clang-20
mips                        bcm63xx_defconfig    gcc-13.2.0
mips                         bigsur_defconfig    clang-20
mips                          eyeq5_defconfig    gcc-14.1.0
mips                           ip27_defconfig    gcc-13.2.0
mips                           ip28_defconfig    gcc-14.1.0
mips                           ip30_defconfig    clang-20
mips                        maltaup_defconfig    gcc-14.1.0
mips                           mtx1_defconfig    gcc-13.2.0
mips                       rbtx49xx_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241103    gcc-14.1.0
nios2                 randconfig-001-20241104    gcc-14.1.0
nios2                 randconfig-002-20241103    gcc-14.1.0
nios2                 randconfig-002-20241104    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
openrisc                  or1klitex_defconfig    gcc-14.1.0
openrisc                    or1ksim_defconfig    gcc-14.1.0
openrisc                       virt_defconfig    gcc-13.2.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241103    gcc-14.1.0
parisc                randconfig-001-20241104    gcc-14.1.0
parisc                randconfig-002-20241103    gcc-14.1.0
parisc                randconfig-002-20241104    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                    adder875_defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                    amigaone_defconfig    gcc-14.1.0
powerpc                      arches_defconfig    gcc-14.1.0
powerpc                      ep88xc_defconfig    gcc-14.1.0
powerpc                        fsp2_defconfig    gcc-13.2.0
powerpc                        fsp2_defconfig    gcc-14.1.0
powerpc                          g5_defconfig    gcc-14.1.0
powerpc                    ge_imp3a_defconfig    gcc-14.1.0
powerpc                        icon_defconfig    clang-20
powerpc                        icon_defconfig    gcc-14.1.0
powerpc                      katmai_defconfig    clang-20
powerpc                 linkstation_defconfig    gcc-14.1.0
powerpc                 mpc832x_rdb_defconfig    gcc-14.1.0
powerpc                     mpc83xx_defconfig    clang-20
powerpc                  mpc866_ads_defconfig    gcc-14.1.0
powerpc                      ppc64e_defconfig    gcc-14.1.0
powerpc                     rainier_defconfig    gcc-14.1.0
powerpc               randconfig-001-20241103    gcc-14.1.0
powerpc               randconfig-001-20241104    gcc-14.1.0
powerpc               randconfig-002-20241103    gcc-14.1.0
powerpc               randconfig-002-20241104    gcc-14.1.0
powerpc               randconfig-003-20241103    gcc-14.1.0
powerpc               randconfig-003-20241104    gcc-14.1.0
powerpc                     redwood_defconfig    gcc-13.2.0
powerpc                    socrates_defconfig    clang-20
powerpc                  storcenter_defconfig    clang-20
powerpc                     taishan_defconfig    gcc-14.1.0
powerpc                     tqm8541_defconfig    gcc-14.1.0
powerpc                     tqm8555_defconfig    gcc-14.1.0
powerpc                         wii_defconfig    gcc-14.1.0
powerpc64             randconfig-001-20241103    gcc-14.1.0
powerpc64             randconfig-001-20241104    gcc-14.1.0
powerpc64             randconfig-002-20241103    gcc-14.1.0
powerpc64             randconfig-002-20241104    gcc-14.1.0
powerpc64             randconfig-003-20241103    gcc-14.1.0
powerpc64             randconfig-003-20241104    gcc-14.1.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241103    gcc-14.1.0
riscv                 randconfig-001-20241104    gcc-14.1.0
riscv                 randconfig-002-20241103    gcc-14.1.0
riscv                 randconfig-002-20241104    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241103    gcc-14.1.0
s390                  randconfig-001-20241104    gcc-14.1.0
s390                  randconfig-002-20241103    gcc-14.1.0
s390                  randconfig-002-20241104    gcc-14.1.0
sh                               alldefconfig    gcc-13.2.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                ecovec24-romimage_defconfig    gcc-14.1.0
sh                        edosk7760_defconfig    gcc-14.1.0
sh                          landisk_defconfig    gcc-14.1.0
sh                     magicpanelr2_defconfig    gcc-13.2.0
sh                          r7785rp_defconfig    gcc-14.1.0
sh                    randconfig-001-20241103    gcc-14.1.0
sh                    randconfig-001-20241104    gcc-14.1.0
sh                    randconfig-002-20241103    gcc-14.1.0
sh                    randconfig-002-20241104    gcc-14.1.0
sh                          rsk7201_defconfig    gcc-14.1.0
sh                          rsk7269_defconfig    gcc-14.1.0
sh                           se7705_defconfig    gcc-13.2.0
sh                           se7750_defconfig    gcc-14.1.0
sh                     sh7710voipgw_defconfig    clang-20
sh                   sh7724_generic_defconfig    gcc-14.1.0
sh                            shmin_defconfig    gcc-13.2.0
sh                            shmin_defconfig    gcc-14.1.0
sh                              ul2_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                          alldefconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241103    gcc-14.1.0
sparc64               randconfig-001-20241104    gcc-14.1.0
sparc64               randconfig-002-20241103    gcc-14.1.0
sparc64               randconfig-002-20241104    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241103    gcc-14.1.0
um                    randconfig-001-20241104    gcc-14.1.0
um                    randconfig-002-20241103    gcc-14.1.0
um                    randconfig-002-20241104    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
um                           x86_64_defconfig    gcc-14.1.0
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241103    clang-19
x86_64      buildonly-randconfig-001-20241104    gcc-12
x86_64      buildonly-randconfig-002-20241103    clang-19
x86_64      buildonly-randconfig-002-20241104    gcc-12
x86_64      buildonly-randconfig-003-20241103    clang-19
x86_64      buildonly-randconfig-003-20241104    gcc-12
x86_64      buildonly-randconfig-004-20241103    clang-19
x86_64      buildonly-randconfig-004-20241104    gcc-12
x86_64      buildonly-randconfig-005-20241103    clang-19
x86_64      buildonly-randconfig-005-20241104    gcc-12
x86_64      buildonly-randconfig-006-20241103    clang-19
x86_64      buildonly-randconfig-006-20241104    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241103    clang-19
x86_64                randconfig-001-20241104    gcc-12
x86_64                randconfig-002-20241103    clang-19
x86_64                randconfig-002-20241104    gcc-12
x86_64                randconfig-003-20241103    clang-19
x86_64                randconfig-003-20241104    gcc-12
x86_64                randconfig-004-20241103    clang-19
x86_64                randconfig-004-20241104    gcc-12
x86_64                randconfig-005-20241103    clang-19
x86_64                randconfig-005-20241104    gcc-12
x86_64                randconfig-006-20241103    clang-19
x86_64                randconfig-006-20241104    gcc-12
x86_64                randconfig-011-20241103    clang-19
x86_64                randconfig-011-20241104    gcc-12
x86_64                randconfig-012-20241103    clang-19
x86_64                randconfig-012-20241104    gcc-12
x86_64                randconfig-013-20241103    clang-19
x86_64                randconfig-013-20241104    gcc-12
x86_64                randconfig-014-20241103    clang-19
x86_64                randconfig-014-20241104    gcc-12
x86_64                randconfig-015-20241103    clang-19
x86_64                randconfig-015-20241104    gcc-12
x86_64                randconfig-016-20241103    clang-19
x86_64                randconfig-016-20241104    gcc-12
x86_64                randconfig-071-20241103    clang-19
x86_64                randconfig-071-20241104    gcc-12
x86_64                randconfig-072-20241103    clang-19
x86_64                randconfig-072-20241104    gcc-12
x86_64                randconfig-073-20241103    clang-19
x86_64                randconfig-073-20241104    gcc-12
x86_64                randconfig-074-20241103    clang-19
x86_64                randconfig-074-20241104    gcc-12
x86_64                randconfig-075-20241103    clang-19
x86_64                randconfig-075-20241104    gcc-12
x86_64                randconfig-076-20241103    clang-19
x86_64                randconfig-076-20241104    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  cadence_csp_defconfig    gcc-13.2.0
xtensa                generic_kc705_defconfig    gcc-14.1.0
xtensa                randconfig-001-20241103    gcc-14.1.0
xtensa                randconfig-001-20241104    gcc-14.1.0
xtensa                randconfig-002-20241103    gcc-14.1.0
xtensa                randconfig-002-20241104    gcc-14.1.0
xtensa                    smp_lx200_defconfig    gcc-13.2.0
xtensa                         virt_defconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

