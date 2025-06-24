Return-Path: <linux-pci+bounces-30537-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF578AE6E8F
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 20:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0F383A6E37
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 18:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152BA14658D;
	Tue, 24 Jun 2025 18:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fL8wCeTg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388374C74
	for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2025 18:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750789555; cv=none; b=iJcjOdqlfUgX+VgxYs8K72DmI8MqoqoZ4/box4FukjzouNu+a4JaUijY+SdWP6PhQ6dY7k2shYW1D5M3FYfeuH9e17JUT2deTBxzcvW0+0sWgx2DeDAK3vFrNr4sArJPfRXBFAnIm2fg0zLCgTN9XrK2jOmxkuWQfTwtZ3Wwq+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750789555; c=relaxed/simple;
	bh=qxDEQFHLV4xVbnT0lANRhMzraIoFpC+jk+cslaKxF90=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VfBHlZdK09XcwQ+ddNPvKzinTeJ/VuTz1o7ax1Ouyc8cgPbZziFDkOTs775Mki6qMbzofY+/iIATVvEX3d9BSY2eWcfAdsDooFL48F4D3aLZF2EB9kqax2/kDpetoEwpQkH9x3ADQEktX1M9Ydq49BsqhuYK4AUsM/LBj6GebJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fL8wCeTg; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750789554; x=1782325554;
  h=date:from:to:cc:subject:message-id;
  bh=qxDEQFHLV4xVbnT0lANRhMzraIoFpC+jk+cslaKxF90=;
  b=fL8wCeTgEseDV7H87aszaR3hBbIsmqf5S3lR8B6HrLYkkwDM+coX8nVv
   0S8yljNwafGlnha8THioihMzb7ldH7/sbed3+M/JKIJJTvQGrsiEaa180
   YYiU5sD07JyIK4ck2/NAGdRNvXzgCXFNLclsmyCcJe5o72CMKRYLrqJqo
   AzmItJ0wYWjASVy+2tsfxw9aV5ncFO6gLFuNNdzHc0qxBHpNhFXkznv/0
   fZ2sAPYk3pIBibOkdlSnMTyRbVdX7NcplLc35kJRwnzQAt8L43bOSoAEf
   boq5IfR5R1Fikn77O4D7EZctafjty2eiKb4BPAG7icstXajOW6Wi6ggt0
   Q==;
X-CSE-ConnectionGUID: 0gBUrVoJR+yI7ewKoQ1biw==
X-CSE-MsgGUID: lQ70VDokTsSHrC+uSluKhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="53140834"
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="53140834"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 11:25:53 -0700
X-CSE-ConnectionGUID: XV5qh8RJSyOG7/+TA6zYaw==
X-CSE-MsgGUID: zQg16MkZRjeRq0pklvJc8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="182877288"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 24 Jun 2025 11:25:52 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uU8L7-000SOq-1F;
	Tue, 24 Jun 2025 18:25:49 +0000
Date: Wed, 25 Jun 2025 02:25:22 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 5aa326a6a2ff0a7e7c6e11777045e66704c2d5e4
Message-ID: <202506250212.1Inrxrvq-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: 5aa326a6a2ff0a7e7c6e11777045e66704c2d5e4  PCI/PTM: Build debugfs code only if CONFIG_DEBUG_FS is enabled

elapsed time: 1449m

configs tested: 52
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20250624    gcc-12.4.0
arc                   randconfig-002-20250624    gcc-8.5.0
arm                               allnoconfig    clang-21
arm                   randconfig-001-20250624    gcc-13.3.0
arm                   randconfig-002-20250624    gcc-8.5.0
arm                   randconfig-003-20250624    gcc-12.4.0
arm                   randconfig-004-20250624    clang-17
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250624    clang-21
arm64                 randconfig-002-20250624    gcc-10.5.0
arm64                 randconfig-003-20250624    clang-21
arm64                 randconfig-004-20250624    clang-21
csky                              allnoconfig    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
i386        buildonly-randconfig-001-20250624    clang-20
i386        buildonly-randconfig-002-20250624    gcc-12
i386        buildonly-randconfig-003-20250624    clang-20
i386        buildonly-randconfig-004-20250624    clang-20
i386        buildonly-randconfig-005-20250624    clang-20
i386        buildonly-randconfig-006-20250624    gcc-12
loongarch                         allnoconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
x86_64      buildonly-randconfig-001-20250624    clang-20
x86_64      buildonly-randconfig-002-20250624    gcc-12
x86_64      buildonly-randconfig-003-20250624    clang-20
x86_64      buildonly-randconfig-004-20250624    clang-20
x86_64      buildonly-randconfig-005-20250624    clang-20
x86_64      buildonly-randconfig-006-20250624    gcc-12
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

