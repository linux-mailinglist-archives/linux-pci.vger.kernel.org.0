Return-Path: <linux-pci+bounces-23931-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF89A65071
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 14:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5AC18826FC
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 13:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A299123BD1F;
	Mon, 17 Mar 2025 13:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dv5ZW7iP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7398F5E
	for <linux-pci@vger.kernel.org>; Mon, 17 Mar 2025 13:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742217285; cv=none; b=pAJXHWMwDHZUXouj0YTSDlu9VhdlEDHX/arbHa+97cXh4tZhwHuQ9XYWXApzIDHFSvd1r6TXLmnoFco5Rx95wD3LcIRsOeNXvwpEBZZT6ZyFE4K6IBjZZ0kOErXXFHmgxDWx+OScVEW++JPY3+aQowCaKfMxQo6ksoxHvgeMlto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742217285; c=relaxed/simple;
	bh=pFn1ZFhjiiTUaSBiIV/Z/q6fHnB/jzbHJ0Ua6K5QoWY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=C7lEk2HfZBP15oX5xHo6RE4L+LGXV4HL8rqD+UEKhw492PYKFo3AdefusEE1Y6EDIlpA6TdPl/XrjOmMSPtQJ0LNRcXXkG7jw5Pid/dE/9cXxGpkZfdCnjveiOS5tT0PD1613hpRB/NgWRUqbsip1lLVxcj3TiaS9kkVgCt0438=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dv5ZW7iP; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742217284; x=1773753284;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pFn1ZFhjiiTUaSBiIV/Z/q6fHnB/jzbHJ0Ua6K5QoWY=;
  b=dv5ZW7iPi2EstksgedaWWKjHJajAk5rx36tWSMVJl5pzQBpX40g0AzwR
   iCK/ZMCmUOU4C9XwYZYeejIYeHxsL2oBPhy4C5XVdlj9GwLRXOB4E5mxA
   oL4iO1Ai1yReXJApmSBe0Q98cwBJjib9lvd6Wt0kvniYNZAeWoNEfDU+K
   YGbAPG1KNavBOo8UIj8k4uliBUV4IBHt4A7NKnKDpmuEBUr6Z8kEzCE7d
   z0leQabbcS984KwzGBSo1/wogtWCxnJPYGMluSGM2RMUmd7SnQlJhQE6d
   fyw/eV3+Vb/n4UuAlUfN7J33nzGNKUsVcYYgdXh8G40K7tK0NVtcYCfTt
   A==;
X-CSE-ConnectionGUID: W7cyo40sRUCiBvHF9O+4Iw==
X-CSE-MsgGUID: URMstbH4R9+I6hPhrHcYeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43335800"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="43335800"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 06:14:43 -0700
X-CSE-ConnectionGUID: lLyLttcESk6t0Cv65hQeOg==
X-CSE-MsgGUID: eGcp52OfQ+W0DFPEzj8oxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="121663305"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 17 Mar 2025 06:14:43 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuAIi-000ClV-0c;
	Mon, 17 Mar 2025 13:14:40 +0000
Date: Mon, 17 Mar 2025 21:13:41 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/histb] BUILD SUCCESS
 b36fb50701619efca5f5450b355d42575cf532ed
Message-ID: <202503172132.Lq41zbUC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/histb
branch HEAD: b36fb50701619efca5f5450b355d42575cf532ed  PCI: histb: Fix an error handling path in histb_pcie_probe()

elapsed time: 1447m

configs tested: 130
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              alldefconfig    gcc-13.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                          axs101_defconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20250316    gcc-13.2.0
arc                   randconfig-002-20250316    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                      integrator_defconfig    clang-21
arm                            mps2_defconfig    clang-21
arm                         orion5x_defconfig    clang-21
arm                   randconfig-001-20250316    clang-21
arm                   randconfig-002-20250316    gcc-14.2.0
arm                   randconfig-003-20250316    gcc-14.2.0
arm                   randconfig-004-20250316    clang-17
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250316    clang-21
arm64                 randconfig-002-20250316    clang-21
arm64                 randconfig-003-20250316    clang-20
arm64                 randconfig-004-20250316    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250316    gcc-14.2.0
csky                  randconfig-002-20250316    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250316    clang-17
hexagon               randconfig-002-20250316    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250316    clang-20
i386        buildonly-randconfig-002-20250316    clang-20
i386        buildonly-randconfig-003-20250316    gcc-12
i386        buildonly-randconfig-004-20250316    clang-20
i386        buildonly-randconfig-005-20250316    clang-20
i386        buildonly-randconfig-006-20250316    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250316    gcc-14.2.0
loongarch             randconfig-002-20250316    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                        m5272c3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                      mmu_defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          eyeq6_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250316    gcc-14.2.0
nios2                 randconfig-002-20250316    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250316    gcc-14.2.0
parisc                randconfig-002-20250316    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                 canyonlands_defconfig    clang-21
powerpc                        icon_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250316    gcc-14.2.0
powerpc               randconfig-002-20250316    gcc-14.2.0
powerpc               randconfig-003-20250316    clang-21
powerpc64                        alldefconfig    clang-21
powerpc64             randconfig-001-20250316    clang-16
powerpc64             randconfig-002-20250316    clang-21
powerpc64             randconfig-003-20250316    clang-19
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250316    clang-21
riscv                 randconfig-002-20250316    gcc-14.2.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250316    gcc-14.2.0
s390                  randconfig-002-20250316    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                        edosk7705_defconfig    gcc-14.2.0
sh                          r7785rp_defconfig    gcc-14.2.0
sh                    randconfig-001-20250316    gcc-14.2.0
sh                    randconfig-002-20250316    gcc-14.2.0
sh                   rts7751r2dplus_defconfig    gcc-14.2.0
sh                           se7343_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250316    gcc-14.2.0
sparc                 randconfig-002-20250316    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250316    gcc-14.2.0
sparc64               randconfig-002-20250316    gcc-14.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250316    clang-21
um                    randconfig-002-20250316    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250316    gcc-12
x86_64      buildonly-randconfig-002-20250316    gcc-12
x86_64      buildonly-randconfig-003-20250316    clang-20
x86_64      buildonly-randconfig-004-20250316    clang-20
x86_64      buildonly-randconfig-005-20250316    gcc-12
x86_64      buildonly-randconfig-006-20250316    clang-20
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250316    gcc-14.2.0
xtensa                randconfig-002-20250316    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

