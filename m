Return-Path: <linux-pci+bounces-43858-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C1DCEA2AC
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 17:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEC26301831D
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 16:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9149A320A0A;
	Tue, 30 Dec 2025 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aAXQxogO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B2A320CA9
	for <linux-pci@vger.kernel.org>; Tue, 30 Dec 2025 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767111882; cv=none; b=bJLki4UP8hImf7u5Lb3rB0lpoCGfjLo+dB41xffHrb0/mmIzjCvulbQ5aDkHD+hQEG0BhE/nhacVz/BXQWieF/e69y55GgMf7Pcxc/JN4ogMI8HfhVRb/xGvm/pxwfzUZoVKZ7ZueDnMJYxQAC71PdbdhPmHXsPi4IJY9JxJvdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767111882; c=relaxed/simple;
	bh=fjLHEdxVUkFUcroL0+O89LL1KHDpJqyiqEwyuuHSMw4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ak3TKQkjK+Nk/oY1VgtmPPt2d79fZrSt3x4MCSiPw1lM4UXezJPmIZRO33QgEPIvI7u6Xgq+eEbdyqH32unbrbvjLXL9pQXLWLdo+yfOKtE6c1nL3y9VwMA9Ok3dlozv7WP2MCgo4TKXkR6dYaQHNObswjZqaQabeHBnnW1rspM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aAXQxogO; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767111881; x=1798647881;
  h=date:from:to:cc:subject:message-id;
  bh=fjLHEdxVUkFUcroL0+O89LL1KHDpJqyiqEwyuuHSMw4=;
  b=aAXQxogO8lDP/Ii/ElzU0PD9bBkyTaSrdktf5d19Kdru3zcbFQ3HNFta
   XNy+0oGSAmZU7NxHzWQOvXGAdrnXT02W5j8hilxD6r/BQIxRNg0L9t7Ql
   bKXJWngNKws+BPa8ZWWIjC4iNPGbigM+o7oKP/PlQI4PqfYpoGW5f8O8c
   X3IhaBthHWlgZR/aMunYkGYdOSddjtZZRV+xklkVemCaWhYLrKqGoXu92
   LQMSUxse6DcnphTkpI3d0IinC6Eyk2QsUeEi3pUM0d5b6bGW2UFtplHtK
   3TH9eL/7o6Apjzht/hl9w5ca3ogBPldHfnhtwYWNudZpWDuZijRPm1v0P
   w==;
X-CSE-ConnectionGUID: TgnGvmWyRZCEcnMa87GxTw==
X-CSE-MsgGUID: m70JTbtRQ4O468AgFYbtKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11657"; a="68743887"
X-IronPort-AV: E=Sophos;i="6.21,189,1763452800"; 
   d="scan'208";a="68743887"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2025 08:24:40 -0800
X-CSE-ConnectionGUID: a+ylcLaETE+kuHfDWh9Mfg==
X-CSE-MsgGUID: VLziGrKkS82gyevZrYS/xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,189,1763452800"; 
   d="scan'208";a="206128324"
Received: from lkp-server01.sh.intel.com (HELO c9aa31daaa89) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 30 Dec 2025 08:24:38 -0800
Received: from kbuild by c9aa31daaa89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vacWS-000000000X7-0aqM;
	Tue, 30 Dec 2025 16:24:36 +0000
Date: Wed, 31 Dec 2025 00:24:26 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 560cb3bd9a48115f334c0a127347575ca7c13f6f
Message-ID: <202512310019.h76i4nIs-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc
branch HEAD: 560cb3bd9a48115f334c0a127347575ca7c13f6f  Documentation: PCI: Fix typos in msi-howto.rst

elapsed time: 1361m

configs tested: 53
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-15.1.0
alpha        allyesconfig    gcc-15.1.0
arc          allmodconfig    gcc-15.1.0
arc           allnoconfig    gcc-15.1.0
arc          allyesconfig    gcc-15.1.0
arm           allnoconfig    clang-22
arm          allyesconfig    gcc-15.1.0
arm64        allmodconfig    clang-19
arm64         allnoconfig    gcc-15.1.0
csky         allmodconfig    gcc-15.1.0
csky          allnoconfig    gcc-15.1.0
hexagon      allmodconfig    clang-17
hexagon       allnoconfig    clang-22
i386          allnoconfig    gcc-14
i386         allyesconfig    gcc-14
loongarch    allmodconfig    clang-19
loongarch     allnoconfig    clang-22
m68k         allmodconfig    gcc-15.1.0
m68k          allnoconfig    gcc-15.1.0
m68k         allyesconfig    gcc-15.1.0
microblaze    allnoconfig    gcc-15.1.0
microblaze   allyesconfig    gcc-15.1.0
mips         allmodconfig    gcc-15.1.0
mips          allnoconfig    gcc-15.1.0
mips         allyesconfig    gcc-15.1.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-15.1.0
openrisc      allnoconfig    gcc-15.1.0
parisc       allmodconfig    gcc-15.1.0
parisc        allnoconfig    gcc-15.1.0
parisc       allyesconfig    gcc-15.1.0
powerpc      allmodconfig    gcc-15.1.0
powerpc       allnoconfig    gcc-15.1.0
riscv        allmodconfig    clang-22
riscv         allnoconfig    gcc-15.1.0
riscv        allyesconfig    clang-16
s390         allmodconfig    clang-18
s390          allnoconfig    clang-22
s390         allyesconfig    gcc-15.1.0
sh           allmodconfig    gcc-15.1.0
sh            allnoconfig    gcc-15.1.0
sh           allyesconfig    gcc-15.1.0
sparc         allnoconfig    gcc-15.1.0
sparc64      allmodconfig    clang-22
um           allmodconfig    clang-19
um            allnoconfig    clang-22
um           allyesconfig    gcc-14
x86_64       allmodconfig    clang-20
x86_64        allnoconfig    clang-20
x86_64       allyesconfig    clang-20
x86_64      rhel-9.4-rust    clang-20
xtensa        allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

