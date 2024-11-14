Return-Path: <linux-pci+bounces-16756-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6429C8A0F
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 13:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE451F22BF9
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 12:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913121F9A8D;
	Thu, 14 Nov 2024 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ErHQA07q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701DA1F9402
	for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 12:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731587694; cv=none; b=n1ac1pSLK7xKHRz/1sMvwSXV0FdlUcUS1jvRc2w1GKGlzemKTMjoXCTlwLKk/Kr9aAl8O6LUhR2b5A5XpZHpMGG5BlFQLJNQCd2TsGxdoJeKsZoEr4nxA0zf4g4SFpJ9kNRw5sUXVxfS6Q5QxsQqFdesdMtipYIyJHTKSTqKMcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731587694; c=relaxed/simple;
	bh=EgNYa0/8gOEPJjVVrS6ZZt9HPKF2It6N5t3o1L79RFo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WZM/xjoja3TFQDtw4yCJqEz7SYJHXFbRD/uiF6PeTa8l2ST0nmf+aWyYTdXtbrTcVaIgtFgb/46ajd4FpKLQmWuEnyU06yyj9YT9lZDZsmsIuVIOO4zN2sAA2jF4FstLlVv4gKi+thrCk3uUn4vOBiBhaQLTHzHj5Nfg1t5ruD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ErHQA07q; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731587693; x=1763123693;
  h=date:from:to:cc:subject:message-id;
  bh=EgNYa0/8gOEPJjVVrS6ZZt9HPKF2It6N5t3o1L79RFo=;
  b=ErHQA07qPwMcDNFJHwMcAuocnTC41LwbuXurl+Um4J7U/9m9HGgsafmF
   YUAdVF4B1xaEFqBYvFLlZMJBYSHpiX6IyQEvBipM/zeZOwMU5n5/iwg3y
   /P9dRcucHGl+sTrALcBpdNoYy2HEYjQ/IQ9R1Bzwux8dsHAliaOsXiWbZ
   UeJk5++GGCE/Zkv5xq+UPRjcKwvKF9agdKv5oFM1pDbly0+U2E3qeaz2S
   xNV8XpiW8DTs0ZPOxrX4Wg/nE+yFvjDXeilVf5GyAC0dJyxsTSHqBqCt9
   gv3hWlarSK6e4sFT9D9jt4YaFJd5wDrHH1MjQvly0RHlO5ZYEI0m0GHn1
   g==;
X-CSE-ConnectionGUID: 8Zlf8kSQRpmvlVHlPB8nbA==
X-CSE-MsgGUID: Q8Mvh40yTxaCGOoBqH/Wmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="42953317"
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="42953317"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 04:34:52 -0800
X-CSE-ConnectionGUID: 34xZlcPJSwyR2eXhRgP2jw==
X-CSE-MsgGUID: ePq6DFGZQ5GqKKwUQb3RQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="125705613"
Received: from lkp-server01.sh.intel.com (HELO c7bc087bbc55) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 14 Nov 2024 04:34:51 -0800
Received: from kbuild by c7bc087bbc55 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBZ3g-00002j-2J;
	Thu, 14 Nov 2024 12:34:48 +0000
Date: Thu, 14 Nov 2024 20:33:48 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:wip/2411-bjorn-pwrctl-rename] BUILD SUCCESS
 c2118aa66ef24e00568b16aeb5dab80ccb76ef06
Message-ID: <202411142041.F32acGJj-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git wip/2411-bjorn-pwrctl-rename
branch HEAD: c2118aa66ef24e00568b16aeb5dab80ccb76ef06  PCI/pwrctrl: Rename pwrctl to pwrctrl

elapsed time: 822m

configs tested: 72
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-14.2.0
alpha                  allyesconfig    gcc-14.2.0
arc                    allmodconfig    gcc-13.2.0
arc                     allnoconfig    gcc-13.2.0
arc                    allyesconfig    gcc-13.2.0
arc         randconfig-001-20241114    gcc-13.2.0
arc         randconfig-002-20241114    gcc-13.2.0
arm                    allmodconfig    gcc-14.2.0
arm                     allnoconfig    clang-20
arm                    allyesconfig    gcc-14.2.0
arm         randconfig-001-20241114    gcc-14.2.0
arm         randconfig-002-20241114    gcc-14.2.0
arm         randconfig-003-20241114    gcc-14.2.0
arm         randconfig-004-20241114    clang-14
arm64                  allmodconfig    clang-20
arm64                   allnoconfig    gcc-14.2.0
arm64       randconfig-001-20241114    clang-20
arm64       randconfig-002-20241114    gcc-14.2.0
arm64       randconfig-003-20241114    gcc-14.2.0
arm64       randconfig-004-20241114    gcc-14.2.0
csky                    allnoconfig    gcc-14.2.0
csky        randconfig-001-20241114    gcc-14.2.0
csky        randconfig-002-20241114    gcc-14.2.0
hexagon                allmodconfig    clang-20
hexagon                 allnoconfig    clang-20
hexagon                allyesconfig    clang-20
hexagon     randconfig-001-20241114    clang-20
hexagon     randconfig-002-20241114    clang-20
i386                   allmodconfig    gcc-12
i386                    allnoconfig    gcc-12
i386                   allyesconfig    gcc-12
i386                      defconfig    clang-19
loongarch              allmodconfig    gcc-14.2.0
loongarch               allnoconfig    gcc-14.2.0
loongarch   randconfig-001-20241114    gcc-14.2.0
loongarch   randconfig-002-20241114    gcc-14.2.0
m68k                   allmodconfig    gcc-14.2.0
m68k                    allnoconfig    gcc-14.2.0
m68k                   allyesconfig    gcc-14.2.0
microblaze             allmodconfig    gcc-14.2.0
microblaze              allnoconfig    gcc-14.2.0
microblaze             allyesconfig    gcc-14.2.0
mips                    allnoconfig    gcc-14.2.0
nios2                   allnoconfig    gcc-14.2.0
nios2       randconfig-001-20241114    gcc-14.2.0
openrisc                allnoconfig    gcc-14.2.0
openrisc               allyesconfig    gcc-14.2.0
parisc                 allmodconfig    gcc-14.2.0
parisc                  allnoconfig    gcc-14.2.0
parisc                 allyesconfig    gcc-14.2.0
powerpc                allmodconfig    gcc-14.2.0
powerpc                 allnoconfig    gcc-14.2.0
powerpc                allyesconfig    clang-20
riscv                  allmodconfig    clang-20
riscv                   allnoconfig    gcc-14.2.0
riscv                  allyesconfig    clang-20
s390                   allmodconfig    clang-20
s390                    allnoconfig    clang-20
s390                   allyesconfig    gcc-14.2.0
sh                     allmodconfig    gcc-14.2.0
sh                      allnoconfig    gcc-14.2.0
sh                     allyesconfig    gcc-14.2.0
sparc                  allmodconfig    gcc-14.2.0
um                     allmodconfig    clang-20
um                      allnoconfig    clang-17
um                     allyesconfig    gcc-12
x86_64                  allnoconfig    clang-19
x86_64                 allyesconfig    clang-19
x86_64                    defconfig    gcc-11
x86_64                        kexec    clang-19
x86_64                     rhel-8.3    gcc-12
xtensa                  allnoconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

