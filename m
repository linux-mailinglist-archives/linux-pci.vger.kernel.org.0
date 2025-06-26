Return-Path: <linux-pci+bounces-30817-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E44AEA603
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 21:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906EB1C4333E
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 19:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0821FF1A1;
	Thu, 26 Jun 2025 19:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KspVkgDj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB8C21348
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 19:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750964500; cv=none; b=EXBA5Lj0tEu2H44ehscItHxND/Acyrdtfzsay6iq0h5OzSB6gJvs+ijMdG5ieKLQE9ExYJUnAq6TwgqkelV2UiE/OKVIu89mJFl9bY0JATMDDEtDdN5XBjojw1mpUsVDWkjn0CpHQ1UpkNv5bmi0uLZH/ABQHO/oaThGtT/4pTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750964500; c=relaxed/simple;
	bh=gcYUNitBQKSxSSOKt6JkJftXjdLMFxAt6a8sDXNDIFk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bZLYqiGdS7p7+TVY7sbX9QwZK9sku1UBuNWWIw0xGDRBQYyPKBpDzk3C07AzAxAY2JdZZFzAaTPtWSfoLBeOHTJMkojGcu9BYN3Pshh2RBd44ifKhW6hMgvnMd3QecpOGxnXKPvMgaB5zexhsJpvSqjALIvNeRO3Qmmnb37a/FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KspVkgDj; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750964499; x=1782500499;
  h=date:from:to:cc:subject:message-id;
  bh=gcYUNitBQKSxSSOKt6JkJftXjdLMFxAt6a8sDXNDIFk=;
  b=KspVkgDjtf92hHRdGNq3ZbTiV+Z/EudQoyw7cC80nRP4Lf8/8R12SkZA
   9xStCg6JF4rfY6fr4cW3SImNbF/gBbRVJEp2e2+PTZyDsluoWbsZd69Hq
   VHejkLsZfAkcG0rhatrSZfdQMJ5TLJKf+mgaPI4OGteWECPq3+C31AbRO
   XNQwgefarg48/uFSi6GgAq0fGHlc7c+o8ht0J9p9sh+42vdP18Cacuw1v
   UaGWutR29LQDNk2Cn8r6VUnfYV869LDXSQL237KGasY5+m1sUW3UatE2m
   vdzOx32pjVYhsCcMHPyEhXsD3VRyeIavk7s2R5ESC/XXpfOvaBsSdhYiP
   A==;
X-CSE-ConnectionGUID: J/g0N3DyQrucbiFLE/0GAA==
X-CSE-MsgGUID: YcYgARA1RmOucYvhmmpQcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="63961555"
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="63961555"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 12:01:39 -0700
X-CSE-ConnectionGUID: D2A3uNK7Qjekm/JydCyEcg==
X-CSE-MsgGUID: tIL2tNdnRKmkbWSn/pOwGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="152773943"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 26 Jun 2025 12:01:36 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUrqn-000VR4-1N;
	Thu, 26 Jun 2025 19:01:33 +0000
Date: Fri, 27 Jun 2025 03:01:24 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint/core] BUILD SUCCESS
 910bdb8197f9322790c738bb32feaa11dba26909
Message-ID: <202506270314.02xQtcMW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint/core
branch HEAD: 910bdb8197f9322790c738bb32feaa11dba26909  PCI: endpoint: Fix configfs group removal on driver teardown

elapsed time: 1212m

configs tested: 99
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                   randconfig-001-20250626    clang-20
arc                   randconfig-001-20250626    gcc-12.4.0
arc                   randconfig-002-20250626    clang-20
arc                   randconfig-002-20250626    gcc-13.3.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-19
arm                   randconfig-001-20250626    clang-20
arm                   randconfig-001-20250626    clang-21
arm                   randconfig-002-20250626    clang-20
arm                   randconfig-003-20250626    clang-20
arm                   randconfig-003-20250626    gcc-10.5.0
arm                   randconfig-004-20250626    clang-20
arm                   randconfig-004-20250626    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250626    clang-20
arm64                 randconfig-001-20250626    clang-21
arm64                 randconfig-002-20250626    clang-17
arm64                 randconfig-002-20250626    clang-20
arm64                 randconfig-003-20250626    clang-20
arm64                 randconfig-003-20250626    gcc-8.5.0
arm64                 randconfig-004-20250626    clang-20
arm64                 randconfig-004-20250626    clang-21
csky                              allnoconfig    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250626    clang-20
i386        buildonly-randconfig-002-20250626    clang-20
i386        buildonly-randconfig-003-20250626    clang-20
i386        buildonly-randconfig-004-20250626    clang-20
i386        buildonly-randconfig-005-20250626    clang-20
i386        buildonly-randconfig-006-20250626    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250626    clang-20
x86_64      buildonly-randconfig-002-20250626    clang-20
x86_64      buildonly-randconfig-003-20250626    clang-20
x86_64      buildonly-randconfig-004-20250626    clang-20
x86_64      buildonly-randconfig-005-20250626    clang-20
x86_64      buildonly-randconfig-006-20250626    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

