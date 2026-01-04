Return-Path: <linux-pci+bounces-43963-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7F1CF0757
	for <lists+linux-pci@lfdr.de>; Sun, 04 Jan 2026 01:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0772300888F
	for <lists+linux-pci@lfdr.de>; Sun,  4 Jan 2026 00:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F936FBF;
	Sun,  4 Jan 2026 00:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dB7N4XeY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AE03A1E9D
	for <linux-pci@vger.kernel.org>; Sun,  4 Jan 2026 00:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767487679; cv=none; b=eiz1A1OgpwWCU06VsolxcNcVUSYqDIEIC015/4sFAgwPQ5SpkQz96gk7BfbM6T6oKgn4OUmpAg4lBZPLyPy3F/9zWP7Bs98frtPpjZVNGotx23wEF8WFREH1y/WinMFbnG9WSwx8TQhNWuPgBMmMLxR6pYEpiKPeCbHeXKPkGVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767487679; c=relaxed/simple;
	bh=bzhmIUEEJBJNtNgxF0kOLfyql4yi+7BSr7SUv4NLsYY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hUpaorZk3nA/L4QWvEjBX6rfZmXBEqQpOKSQURhyyhgax1YjvSAQ6pn9g1yspbdlwt6FJisqyoHObsK9u1OWiRJoyNDPhhsgGd1xMNrXNXs4fwKnjSzXOODkuxUkyw5IW2QDPYd/7C+oWCaHtn6KYWscJG+y9LNMdpP2FFIhu/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dB7N4XeY; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767487677; x=1799023677;
  h=date:from:to:cc:subject:message-id;
  bh=bzhmIUEEJBJNtNgxF0kOLfyql4yi+7BSr7SUv4NLsYY=;
  b=dB7N4XeYHAex1NqVbp6j+gFHmNCx/1UOALfiewSymGQWRIpau/OcYuJ8
   uPoL41JsjWw74pJAcdn4d6eTfjPqgmSJTHOdh5kO/xjtq+lukgmoZUwJY
   ueWObjpmj4Q/Gz947cfGg6Gmfn7nAm779kQng+XfJAinv9kV1kJXPmB78
   5rE8PEwWWtVfMF3x02UgDyyeomdVnQ1J0kJJVh4mUd+/a+7rIOu+CO43e
   AtInpz4P6Vb5n3tpbIpgdKN27iDwW0ByodO99m+Fh+LGR2P34p3/jz0zJ
   9ETvTETWG388SdA2/RiRMmh/vA0p1uqqxRdm2C6nk4nagAs85qTzTxWq9
   Q==;
X-CSE-ConnectionGUID: RKCrWg4ESJmUxz5ZAX8jpg==
X-CSE-MsgGUID: kbvYXT6aRyyallham4e6mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11659"; a="56473410"
X-IronPort-AV: E=Sophos;i="6.21,200,1763452800"; 
   d="scan'208";a="56473410"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2026 16:47:56 -0800
X-CSE-ConnectionGUID: Cadj8yYHR+CtF8yUY5PWDw==
X-CSE-MsgGUID: 8LRbPkvUQK2TzOxtFeoP1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,200,1763452800"; 
   d="scan'208";a="202548651"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 03 Jan 2026 16:47:56 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vcCHh-000000000JB-25AZ;
	Sun, 04 Jan 2026 00:47:53 +0000
Date: Sun, 04 Jan 2026 08:47:02 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 29a77b4897f1a0f40209bee929129d4c3f9c7a4b
Message-ID: <202601040855.uKNeqrcX-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 29a77b4897f1a0f40209bee929129d4c3f9c7a4b  Merge branch 'pci/misc'

elapsed time: 1491m

configs tested: 107
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                               defconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20260104    gcc-14.3.0
arc                   randconfig-002-20260104    gcc-15.1.0
arm                                 defconfig    clang-22
arm                          exynos_defconfig    clang-22
arm                       imx_v6_v7_defconfig    clang-16
arm                   randconfig-001-20260104    gcc-13.4.0
arm                   randconfig-002-20260104    clang-22
arm                   randconfig-003-20260104    clang-22
arm                   randconfig-004-20260104    gcc-15.1.0
arm                           tegra_defconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20260104    gcc-11.5.0
arm64                 randconfig-002-20260104    clang-22
arm64                 randconfig-003-20260104    clang-22
arm64                 randconfig-004-20260104    clang-22
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20260104    gcc-11.5.0
csky                  randconfig-002-20260104    gcc-10.5.0
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20260103    clang-22
hexagon               randconfig-002-20260103    clang-22
i386        buildonly-randconfig-001-20260104    clang-20
i386        buildonly-randconfig-002-20260104    gcc-14
i386        buildonly-randconfig-003-20260104    gcc-14
i386        buildonly-randconfig-004-20260104    clang-20
i386        buildonly-randconfig-005-20260104    clang-20
i386        buildonly-randconfig-006-20260104    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260104    clang-20
i386                  randconfig-002-20260104    clang-20
i386                  randconfig-003-20260104    clang-20
i386                  randconfig-004-20260104    clang-20
i386                  randconfig-005-20260104    gcc-14
i386                  randconfig-006-20260104    clang-20
i386                  randconfig-007-20260104    gcc-14
i386                  randconfig-012-20260104    clang-20
i386                  randconfig-013-20260104    gcc-14
i386                  randconfig-014-20260104    gcc-14
i386                  randconfig-015-20260104    gcc-14
i386                  randconfig-016-20260104    clang-20
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260103    gcc-15.1.0
loongarch             randconfig-002-20260103    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                           virt_defconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                           mtx1_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260103    gcc-8.5.0
nios2                 randconfig-002-20260103    gcc-10.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20260104    gcc-13.4.0
parisc                randconfig-002-20260104    gcc-9.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-002-20260104    gcc-10.5.0
powerpc                     tqm8540_defconfig    gcc-15.1.0
powerpc64                        alldefconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20260104    gcc-8.5.0
riscv                 randconfig-002-20260104    clang-22
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
s390                  randconfig-001-20260104    gcc-9.5.0
s390                  randconfig-002-20260104    gcc-12.5.0
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                        edosk7760_defconfig    gcc-15.1.0
sh                    randconfig-001-20260104    gcc-10.5.0
sh                    randconfig-002-20260104    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20260104    gcc-8.5.0
sparc                 randconfig-002-20260104    gcc-12.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260104    clang-22
sparc64               randconfig-002-20260104    gcc-12.5.0
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260104    clang-22
um                    randconfig-002-20260104    clang-16
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20260104    clang-20
x86_64      buildonly-randconfig-002-20260104    clang-20
x86_64      buildonly-randconfig-003-20260104    clang-20
x86_64      buildonly-randconfig-004-20260104    gcc-13
x86_64      buildonly-randconfig-005-20260104    gcc-14
x86_64      buildonly-randconfig-006-20260104    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260104    gcc-14
x86_64                randconfig-002-20260104    clang-20
x86_64                randconfig-003-20260104    clang-20
x86_64                randconfig-004-20260104    clang-20
x86_64                randconfig-005-20260104    gcc-14
x86_64                randconfig-006-20260104    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20260104    gcc-15.1.0
xtensa                randconfig-002-20260104    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

