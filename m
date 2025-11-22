Return-Path: <linux-pci+bounces-41915-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3A3C7D6D8
	for <lists+linux-pci@lfdr.de>; Sat, 22 Nov 2025 20:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0754E4E0347
	for <lists+linux-pci@lfdr.de>; Sat, 22 Nov 2025 19:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C719623BCEE;
	Sat, 22 Nov 2025 19:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A7QzpPsa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7E41B532F
	for <linux-pci@vger.kernel.org>; Sat, 22 Nov 2025 19:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763840842; cv=none; b=MPfGVUtG4OeDfUHn2NOxJ41+eV/No1BbcEX0IL0hxc/yluJcPWxHObNx9Z0Ou+gdWkgB5qONBG3Ey1zlPKCsocy4Iu0k7QwSVyzZC+1yzntvRKfn3oXQYNFCNiWR/cTnk47uys1lSgSGKQaFNktTYhm8E7Sl2gwXsnXq7bKRBiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763840842; c=relaxed/simple;
	bh=vNPwna+8r1G3javeOo0mgCg6jarTgCAG9z4T+Iz81fo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RQYmWKNyX96tG39zu4/FzFC/h6xOk4HGTql6c3+q7gc71sooLaGy6o6dhQglu2BJqH/rwEELGwlUyleIZL6Fglw6svxkDNmBVIVqXc+kW4FjJeYF78BDOcn7XraNNOwd2blHgjguFX9PISb3uZi/sTNZGC6Y8u+TQQdcWc6cCfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A7QzpPsa; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763840841; x=1795376841;
  h=date:from:to:cc:subject:message-id;
  bh=vNPwna+8r1G3javeOo0mgCg6jarTgCAG9z4T+Iz81fo=;
  b=A7QzpPsaTEnoanCK0axK1FK3+Z0ZnYSUgZnALBVFViIfNwF5kUwNyj+R
   /QquIgSD6nRTtHecf+OGIFmOTZMcaIuXdXkBVFr+Tqzc1z0AdziC61P6Q
   Fvd4Li1v8RSE5rOHG1gAPRpYuQo+Q1+pTOo3jSP88cOK5t3+Hqy7hYjii
   wwurkmo+p33+cR1rUu2hm1WSj4PkoOWZsCwP3ruOw7y0gdVy23+5N9X/C
   b0M28BJ/u1vUziZ96o99aAGH57QzCkQVGCzmRVJRtyUTEqYq+futd1ERw
   5D4CCMMPTl/62JjXfKiC9c14p7qK7oRheYqCNP+G7WhHHk3T2oWC85HUP
   Q==;
X-CSE-ConnectionGUID: 7eWc9X5HQfWvfpkWRTQR5w==
X-CSE-MsgGUID: t+bCfuSuTzmJ30sgGgLhwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11621"; a="76589998"
X-IronPort-AV: E=Sophos;i="6.20,219,1758610800"; 
   d="scan'208";a="76589998"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2025 11:47:20 -0800
X-CSE-ConnectionGUID: YkwGTI2iQOWxSoToe6kRwA==
X-CSE-MsgGUID: GEM5jOt/Q06BRUwxrDoy8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,219,1758610800"; 
   d="scan'208";a="197094051"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 22 Nov 2025 11:47:19 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vMtZl-0007nP-0F;
	Sat, 22 Nov 2025 19:47:17 +0000
Date: Sun, 23 Nov 2025 03:46:37 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/sky1] BUILD SUCCESS
 2aeedd614dd166316b2d5f2e7a91c55c1faa968a
Message-ID: <202511230332.VFSuMudi-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/sky1
branch HEAD: 2aeedd614dd166316b2d5f2e7a91c55c1faa968a  MAINTAINERS: Add entry for CIX Sky1 PCIe driver

elapsed time: 7218m

configs tested: 63
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.1.0
alpha                  allyesconfig    gcc-15.1.0
arc                    allmodconfig    gcc-15.1.0
arc                     allnoconfig    gcc-15.1.0
arc                    allyesconfig    gcc-15.1.0
arm                     allnoconfig    clang-22
arm                    allyesconfig    gcc-15.1.0
arm64                   allnoconfig    gcc-15.1.0
arm64       randconfig-001-20251118    clang-20
arm64       randconfig-002-20251118    clang-22
arm64       randconfig-003-20251118    clang-19
arm64       randconfig-004-20251118    clang-17
csky                   allmodconfig    gcc-15.1.0
csky                    allnoconfig    gcc-15.1.0
csky        randconfig-001-20251118    gcc-10.5.0
csky        randconfig-002-20251118    gcc-15.1.0
hexagon                allmodconfig    clang-17
hexagon                 allnoconfig    clang-22
i386                   allmodconfig    gcc-14
i386                    allnoconfig    gcc-14
i386                   allyesconfig    gcc-14
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-22
m68k                   allmodconfig    gcc-15.1.0
m68k                    allnoconfig    gcc-15.1.0
m68k                   allyesconfig    gcc-15.1.0
microblaze              allnoconfig    gcc-15.1.0
microblaze             allyesconfig    gcc-15.1.0
mips                   allmodconfig    gcc-15.1.0
mips                    allnoconfig    gcc-15.1.0
mips                   allyesconfig    gcc-15.1.0
nios2                   allnoconfig    gcc-11.5.0
openrisc                allnoconfig    gcc-15.1.0
parisc                 allmodconfig    gcc-15.1.0
parisc                  allnoconfig    gcc-15.1.0
parisc                 allyesconfig    gcc-15.1.0
powerpc                allmodconfig    gcc-15.1.0
powerpc                 allnoconfig    gcc-15.1.0
riscv                  allmodconfig    clang-22
riscv                   allnoconfig    gcc-15.1.0
riscv                  allyesconfig    clang-16
s390                   allmodconfig    clang-18
s390                    allnoconfig    clang-22
s390                   allyesconfig    gcc-15.1.0
sh                     allmodconfig    gcc-15.1.0
sh                      allnoconfig    gcc-15.1.0
sh                     allyesconfig    gcc-15.1.0
sparc                   allnoconfig    gcc-15.1.0
um                     allmodconfig    clang-19
um                      allnoconfig    clang-22
um                     allyesconfig    gcc-14
x86_64                 allmodconfig    clang-20
x86_64                  allnoconfig    clang-20
x86_64                 allyesconfig    clang-20
x86_64                        kexec    clang-20
x86_64                     rhel-9.4    clang-20
x86_64                 rhel-9.4-bpf    gcc-14
x86_64                rhel-9.4-func    clang-20
x86_64          rhel-9.4-kselftests    clang-20
x86_64               rhel-9.4-kunit    gcc-14
x86_64                 rhel-9.4-ltp    gcc-14
x86_64                rhel-9.4-rust    clang-20
xtensa                  allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

