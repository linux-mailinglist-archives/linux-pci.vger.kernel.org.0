Return-Path: <linux-pci+bounces-16734-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 714A89C8409
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 08:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9988D283B3E
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 07:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F451F26DF;
	Thu, 14 Nov 2024 07:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OTVHxVrw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAE61F26EA
	for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 07:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731569764; cv=none; b=Tn+VhvU5Di+b0JGKppLInP/hFwBj33GIjz661LbVhqrdPExvFiKoe2T3TwOZxNpY86SKnQfZmJHVV7Bu5soU3Mqflj/C0CL6H9jqJ8AV8yOoPSORTL9RER+SWPalhDT4/50FN2BGMVsDuhzt/2p9gE2uEwgGo0YwBIcnGNsj/H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731569764; c=relaxed/simple;
	bh=ZH9UckY4h0mWVsOoUQUOhmPToqeM2E/yB28+/fFj3HM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=vCNNG7665rc9a3tuBqLSL/INQLSqJLk3cGyoU2vSf8loWLxPPww7FA9U2e0FO27jSDqvNnpPrT67qyDXHqdySZ1A/FVkTZAW6wYJq+F5srLtTNQNhdBtvL36+HCM0YBfeuFileTy/IgWD7mLnDlzoN0or+k7ZSw8j1cLenKe4H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OTVHxVrw; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731569763; x=1763105763;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZH9UckY4h0mWVsOoUQUOhmPToqeM2E/yB28+/fFj3HM=;
  b=OTVHxVrwx4clThbIoQBf63G16J7uY3MdXgDQCCUJM/5o+vBwpoMMk046
   gQvHH1NQ7ZpRSWxGbcTVAGfs5LjdhSOtQfF5lf+2vKSFUzQjtbvQSAute
   LyiDDf0Q7F7CE7YPI0YkPuOrTQxZl1huIocnFb6ePk9WbQSeQmNYqIu8b
   k+icL762SUuoLzsrZPRVUih6ZMd1upEqqEqKO+xiEmbx2q1AM2F88cHms
   9NUS0M+3LN5gKnq6JbzcqXUBrfYV8SalpWZ4MpWN3yTnaNXhUeE01rHlW
   RiQ6aDroqpB2dWfJmV7IbOX/ojxzjm22eUnKOpFU3PEgbQctRk3ASChAR
   Q==;
X-CSE-ConnectionGUID: 9C3FDPD6TAuxk0ozxj7tDA==
X-CSE-MsgGUID: sN+znImiQEaRHNa3MfWM6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="42113177"
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="42113177"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 23:36:02 -0800
X-CSE-ConnectionGUID: ysvnZCIxSPGYfBy4m1bj7g==
X-CSE-MsgGUID: DVi2TNFEQimzPBsY44jfzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="88098095"
Received: from lkp-server01.sh.intel.com (HELO 8eed2ac03994) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 13 Nov 2024 23:36:01 -0800
Received: from kbuild by 8eed2ac03994 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBUOU-00004H-2M;
	Thu, 14 Nov 2024 07:35:58 +0000
Date: Thu, 14 Nov 2024 14:14:30 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/mediatek] BUILD SUCCESS
 d19ea320d3029a12993c671f4815bf6c02ae0727
Message-ID: <202411141422.L8sjYZbJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/mediatek
branch HEAD: d19ea320d3029a12993c671f4815bf6c02ae0727  PCI: mediatek-gen3: Remove unneeded semicolon

elapsed time: 734m

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

