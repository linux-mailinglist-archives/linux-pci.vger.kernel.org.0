Return-Path: <linux-pci+bounces-16735-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 654DC9C840C
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 08:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D769E283B3E
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 07:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6471F26EA;
	Thu, 14 Nov 2024 07:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EhsChSv3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344901F4268
	for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 07:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731569764; cv=none; b=mXMb9fRAKcf0bkQIGXKKdCS85EWYPGnCWa2Ld6ARZB+s0SFGoIx5TC7pHY9LVYXdBIpkWLenb5VGh7/VNFxccU1yBIBDBThtASmkVN2h4K+DloTyvXWtd5ZMu5gCKk+hcAbYcuqNLmslgRHtSiWV1mFDL/bCgMWrAvVrSAKtwpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731569764; c=relaxed/simple;
	bh=MD/A5zGoXGHiWeU6bfNjfRtdq4yjBItb79qAE8u/87A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=HpAemxqjWTYImLutY1VC2uPdbSIzU12QM2I6/kaWqqgC6vvpC5a60Rek2k/UfANcliIAw/v78NtjOEkfTGIJFPkMX5U3mpnw3SfyEY+Pa80QTKOBS+ytG2zd6sFFGQ8jgnfnztDvset7isdftnBsU4LU0oL13JbmIgV8H1oi75Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EhsChSv3; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731569763; x=1763105763;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MD/A5zGoXGHiWeU6bfNjfRtdq4yjBItb79qAE8u/87A=;
  b=EhsChSv3aMLOuiadEsOy98MOQ7X238r7z/2Ziqo/NzgLSfwcLVwdwB5L
   NB4EV1Mkr84YpzkbPcFtZcr/dsgkA/w0ZbSyK2TVp9jrAukXT8raBFKYY
   LCUejJU5XPTidS5pePB+BeVa15sTZQE6lrvrpuj7DnpCi4Lj9cKul6pCh
   +d2pVpnF1ey76nUsueACVnqvpzdV/RqIPStP9lCtYq19zu2A2yp5nJG2Q
   2Q5a31lc/ZXdW8TNb2sFmOvj53w00DM0f1zSFQB6lIlSTDBcuBGISyw0V
   GKX9i/gVkxg3J4+9cFWgJD12oqynJpabn7++FUKf4FQMSphDqgtAKtUJD
   w==;
X-CSE-ConnectionGUID: TZHE9hgrSa+oeqSSs7hZHw==
X-CSE-MsgGUID: ZwUuNmmGRc2LmVoH2eNQGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="35203769"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="35203769"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 23:36:02 -0800
X-CSE-ConnectionGUID: K8C537MHQvyG9XqAR805/w==
X-CSE-MsgGUID: /FYIZ+d6QO2gG0ukrbIUHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="88001921"
Received: from lkp-server01.sh.intel.com (HELO 8eed2ac03994) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 13 Nov 2024 23:36:01 -0800
Received: from kbuild by 8eed2ac03994 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBUOU-00004E-2I;
	Thu, 14 Nov 2024 07:35:58 +0000
Date: Thu, 14 Nov 2024 14:13:08 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/cadence] BUILD SUCCESS
 e3e309b2bea8d2c37ed6f52c837848b601d3245e
Message-ID: <202411141459.WTXxkHnq-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/cadence
branch HEAD: e3e309b2bea8d2c37ed6f52c837848b601d3245e  PCI: cadence: Lower severity of message when phy-names property is absent in DTS

elapsed time: 733m

configs tested: 91
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                allnoconfig    gcc-14.2.0
alpha               allyesconfig    clang-20
alpha                  defconfig    gcc-14.2.0
arc                 allmodconfig    clang-20
arc                  allnoconfig    gcc-14.2.0
arc                 allyesconfig    clang-20
arc                    defconfig    gcc-14.2.0
arc           vdk_hs38_defconfig    gcc-14.2.0
arm                 alldefconfig    gcc-14.2.0
arm                 allmodconfig    clang-20
arm                  allnoconfig    gcc-14.2.0
arm                 allyesconfig    clang-20
arm                    defconfig    gcc-14.2.0
arm               dove_defconfig    gcc-14.2.0
arm            socfpga_defconfig    gcc-14.2.0
arm64               allmodconfig    clang-20
arm64                allnoconfig    gcc-14.2.0
arm64                  defconfig    gcc-14.2.0
csky                 allnoconfig    gcc-14.2.0
csky                   defconfig    gcc-14.2.0
hexagon             allmodconfig    clang-20
hexagon              allnoconfig    gcc-14.2.0
hexagon             allyesconfig    clang-20
hexagon                defconfig    gcc-14.2.0
i386                allmodconfig    clang-19
i386                 allnoconfig    clang-19
i386                allyesconfig    clang-19
i386                   defconfig    clang-19
loongarch           allmodconfig    gcc-14.2.0
loongarch            allnoconfig    gcc-14.2.0
loongarch              defconfig    gcc-14.2.0
m68k                allmodconfig    gcc-14.2.0
m68k                 allnoconfig    gcc-14.2.0
m68k                allyesconfig    gcc-14.2.0
m68k                   defconfig    gcc-14.2.0
m68k           m5272c3_defconfig    gcc-14.2.0
m68k           m5307c3_defconfig    gcc-14.2.0
m68k               q40_defconfig    gcc-14.2.0
microblaze          allmodconfig    gcc-14.2.0
microblaze           allnoconfig    gcc-14.2.0
microblaze          allyesconfig    gcc-14.2.0
microblaze             defconfig    gcc-14.2.0
mips                 allnoconfig    gcc-14.2.0
mips         bmips_stb_defconfig    gcc-14.2.0
mips        loongson1b_defconfig    gcc-14.2.0
nios2                allnoconfig    gcc-14.2.0
nios2                  defconfig    gcc-14.2.0
openrisc             allnoconfig    clang-20
openrisc            allyesconfig    gcc-14.2.0
openrisc               defconfig    gcc-12
openrisc     or1klitex_defconfig    gcc-14.2.0
parisc              allmodconfig    gcc-14.2.0
parisc               allnoconfig    clang-20
parisc              allyesconfig    gcc-14.2.0
parisc                 defconfig    gcc-12
parisc64               defconfig    gcc-14.2.0
powerpc             allmodconfig    gcc-14.2.0
powerpc              allnoconfig    clang-20
powerpc             allyesconfig    gcc-14.2.0
powerpc           cell_defconfig    gcc-14.2.0
powerpc          ebony_defconfig    gcc-14.2.0
powerpc        mpc83xx_defconfig    gcc-14.2.0
powerpc       socrates_defconfig    gcc-14.2.0
riscv               allmodconfig    gcc-14.2.0
riscv                allnoconfig    clang-20
riscv               allyesconfig    gcc-14.2.0
riscv                  defconfig    gcc-12
s390                allmodconfig    gcc-14.2.0
s390                 allnoconfig    clang-20
s390                allyesconfig    gcc-14.2.0
s390                   defconfig    gcc-12
sh                  allmodconfig    gcc-14.2.0
sh                   allnoconfig    gcc-14.2.0
sh                  allyesconfig    gcc-14.2.0
sh                     defconfig    gcc-12
sh              se7721_defconfig    gcc-14.2.0
sparc               allmodconfig    gcc-14.2.0
sparc64                defconfig    gcc-12
um                  allmodconfig    clang-20
um                   allnoconfig    clang-20
um                  allyesconfig    clang-20
um                     defconfig    gcc-12
um                i386_defconfig    gcc-12
um              x86_64_defconfig    gcc-12
x86_64               allnoconfig    clang-19
x86_64              allyesconfig    clang-19
x86_64                 defconfig    clang-19
x86_64                     kexec    gcc-12
x86_64                  rhel-8.3    gcc-12
xtensa               allnoconfig    gcc-14.2.0
xtensa             iss_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

