Return-Path: <linux-pci+bounces-23023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BECD6A53EAC
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 00:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E714C3AAD5A
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 23:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC14207A0A;
	Wed,  5 Mar 2025 23:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fqWPxEof"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A004207A09
	for <linux-pci@vger.kernel.org>; Wed,  5 Mar 2025 23:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741218792; cv=none; b=fI6LDq7vx1mwmu9WjbJg0FixzQfIq/Hz3+AzyMyGT7af5re56uu+dkHWb65lCLjX+ZPmhiUs1Y5l+nb7dvPr9yHHZ032T+GV1nmTuNuRYjQwe7/vXeaZizW+Vh6So07ejlQHD2ZB27TzZLFuwNrXlgMqef1KZ2fIfRlxraXR+MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741218792; c=relaxed/simple;
	bh=eBDj/y93NPEq0krcu/NqHU5RYXwinHnOfXsE1DVfhZI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BOI+H5yI5Npw8ACPKhWZQz0FaHCtuUswG5rKKFXIdvnHGHZmCOjXl7qwZ6ZV9HHW/y7VguqoPqL1myIl0K7R6XBHhR3G706xw8VzPsqEAJLfe9zO8qIPKQ63Sg+fu1hoLjEdmZPArg0DfhIhwmgRCzyN34UDHZ3sw2soVzTm1Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fqWPxEof; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741218791; x=1772754791;
  h=date:from:to:cc:subject:message-id;
  bh=eBDj/y93NPEq0krcu/NqHU5RYXwinHnOfXsE1DVfhZI=;
  b=fqWPxEofdoLyMmaBVc/rgLpOP1b7s8tEzZ5QJd+wWWZsPIagTkGmoVwf
   hEEueVZjUlmj65VXgcctktZcPIKBjaLUGnAc6RfMTsIolSrts/yOi5cjS
   vOG96+7DoWLNfsGlMewTra/Q/qlRS3uUjRG3eDqmUcs1VHNStErNJYPsN
   sTiA8bMRjNHBJ+RaZ2DcyrICq4LZ1Y55WRnh+qsP7TgP58mKk4toufs1r
   rLm2p1D1vVirzjG9FWarqC9CWDEGrIGSOsxUkZDZwvrGAfSsIWm6UVp7V
   TUqOkecSGKfNkkn5pBkXYHvwHqjggk+4Vl2bfuwJ7WKOXj5FwnedLLMBr
   A==;
X-CSE-ConnectionGUID: Si+LY8lASqmzCme8ZOXjaQ==
X-CSE-MsgGUID: jk69vMGdRpGGiU+CZNlOOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="67579079"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="67579079"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 15:53:10 -0800
X-CSE-ConnectionGUID: 2/GLbVmGTfa/rqboaqdEMw==
X-CSE-MsgGUID: U/cG7P27RrOaU/jI4oTpIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119345293"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 05 Mar 2025 15:53:09 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpyXz-000MKW-0X;
	Wed, 05 Mar 2025 23:53:07 +0000
Date: Thu, 06 Mar 2025 07:52:15 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:reset] BUILD SUCCESS
 479380efe1625e251008d24b2810283db60d6fcd
Message-ID: <202503060709.ZCgbcVOd-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git reset
branch HEAD: 479380efe1625e251008d24b2810283db60d6fcd  PCI: Avoid reset when disabled via sysfs

elapsed time: 1447m

configs tested: 92
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250305    gcc-13.2.0
arc                   randconfig-002-20250305    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250305    gcc-14.2.0
arm                   randconfig-002-20250305    clang-19
arm                   randconfig-003-20250305    gcc-14.2.0
arm                   randconfig-004-20250305    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250305    clang-15
arm64                 randconfig-002-20250305    gcc-14.2.0
arm64                 randconfig-003-20250305    clang-21
arm64                 randconfig-004-20250305    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250305    gcc-14.2.0
csky                  randconfig-002-20250305    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250305    clang-21
hexagon               randconfig-002-20250305    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386        buildonly-randconfig-001-20250305    clang-19
i386        buildonly-randconfig-002-20250305    clang-19
i386        buildonly-randconfig-003-20250305    clang-19
i386        buildonly-randconfig-004-20250305    clang-19
i386        buildonly-randconfig-005-20250305    clang-19
i386        buildonly-randconfig-006-20250305    gcc-12
i386                                defconfig    clang-19
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250305    gcc-14.2.0
loongarch             randconfig-002-20250305    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250305    gcc-14.2.0
nios2                 randconfig-002-20250305    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250305    gcc-14.2.0
parisc                randconfig-002-20250305    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250305    clang-17
powerpc               randconfig-002-20250305    gcc-14.2.0
powerpc               randconfig-003-20250305    gcc-14.2.0
powerpc64             randconfig-001-20250305    clang-19
powerpc64             randconfig-002-20250305    clang-17
powerpc64             randconfig-003-20250305    clang-19
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250305    clang-19
riscv                 randconfig-002-20250305    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250305    gcc-14.2.0
s390                  randconfig-002-20250305    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250305    gcc-14.2.0
sh                    randconfig-002-20250305    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250305    gcc-14.2.0
sparc                 randconfig-002-20250305    gcc-14.2.0
sparc64               randconfig-001-20250305    gcc-14.2.0
sparc64               randconfig-002-20250305    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250305    clang-19
um                    randconfig-002-20250305    gcc-12
x86_64                            allnoconfig    clang-19
x86_64      buildonly-randconfig-001-20250305    clang-19
x86_64      buildonly-randconfig-002-20250305    gcc-12
x86_64      buildonly-randconfig-003-20250305    clang-19
x86_64      buildonly-randconfig-004-20250305    gcc-12
x86_64      buildonly-randconfig-005-20250305    clang-19
x86_64      buildonly-randconfig-006-20250305    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250305    gcc-14.2.0
xtensa                randconfig-002-20250305    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

