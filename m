Return-Path: <linux-pci+bounces-44469-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C9ED10D51
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 08:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6DACD300EDB3
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 07:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7752E31A07C;
	Mon, 12 Jan 2026 07:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tr9KiD9p"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3105C3090CC
	for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2026 07:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768202346; cv=none; b=aPxQSXC6p62K7ZPnSMmc+mcV57fazA4ef7YOfpsH9CxyjwrHDX7Mkl6NizNElUWBQXq0JUtydOAGjHMGE10BD4XBUx0C3UuXYD4lMkEaj3aLKSFSSJo5fBb5ZIKeucsv6VKTBOl+/EUiH4UW7h3Jw0e4ZDN1DklnqCUjsW8RKL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768202346; c=relaxed/simple;
	bh=LVpNbPI6qyCYH+C3P1PKHTLOOqXS/g2DJ9Li8zA0sxQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MYd5pK2mI7NeB+RwaO+k7MVwlDJXAnM8LirJzW8vKEq8g9LOt668ZI0gVrM0TgCCsAsd7Yje3oWR+9Eq5MECcm3lyoh8A3O+Ue577gbaJNy80ZY7JH8c5UjaMy+sMDmoPKc62q0QjClH5J8LiHpUFaZWtTPZfmVJu/3Squ6s/pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tr9KiD9p; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768202344; x=1799738344;
  h=date:from:to:cc:subject:message-id;
  bh=LVpNbPI6qyCYH+C3P1PKHTLOOqXS/g2DJ9Li8zA0sxQ=;
  b=Tr9KiD9pAcIab+drEaoe75aNxgAv5xqz+3M/jASUzO7eKm1/BSj4/CHa
   CY5PgnpHdKh4Yzkhfi9wqb/7sMBuuthYDtvCjf8xR2AIPnvmG97QAbbhC
   58mIrD26SJHcY6BmBdRZrx4SVDJMICB8PLuSa679JTMR4dTFHjpLmszy2
   9OzHWet2hCeAlgskUgStZ/a3FE2YNQzpiRr8eXw+C+yL5CImbrmKpv8+F
   IdbNiKFEb0Zhp/Fcbz2wMJ8BFXIa3SnmhAjHi8/pT2rN/jugQDbHrRhwx
   4+tYkF3+iEIKaZyTwiBmSkxFsev6DLxFsxpbQMXiEsvxCZJKuFQXkmNJz
   A==;
X-CSE-ConnectionGUID: vsfRA/R5ST2xXDyxpUK9IA==
X-CSE-MsgGUID: WvL4dyJdQd+XkJJBwheXog==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69386530"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="69386530"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 23:19:03 -0800
X-CSE-ConnectionGUID: C3lOc2w+Squ8qnjffyTpxQ==
X-CSE-MsgGUID: wTCm7bgWS9S4YXiusZqZpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="204089325"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 11 Jan 2026 23:19:03 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vfCCa-00000000D5w-0QXa;
	Mon, 12 Jan 2026 07:19:00 +0000
Date: Mon, 12 Jan 2026 15:18:41 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 80d9411c00e805488b631c91034e9b6c14a6dbdc
Message-ID: <202601121535.lW7qoZW3-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc
branch HEAD: 80d9411c00e805488b631c91034e9b6c14a6dbdc  PCI/P2PDMA: Add missing struct p2pdma_provider documentation

elapsed time: 7735m

configs tested: 54
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-15.1.0
alpha        allyesconfig    gcc-15.2.0
arc          allmodconfig    gcc-15.2.0
arc           allnoconfig    gcc-15.1.0
arc          allyesconfig    gcc-15.2.0
arm           allnoconfig    clang-22
arm          allyesconfig    gcc-15.2.0
arm64        allmodconfig    clang-19
arm64         allnoconfig    gcc-15.1.0
csky         allmodconfig    gcc-15.2.0
csky          allnoconfig    gcc-15.1.0
hexagon      allmodconfig    clang-17
hexagon       allnoconfig    clang-22
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
i386         allyesconfig    gcc-14
loongarch    allmodconfig    clang-19
loongarch     allnoconfig    clang-22
m68k         allmodconfig    gcc-15.2.0
m68k          allnoconfig    gcc-15.1.0
m68k         allyesconfig    gcc-15.2.0
microblaze    allnoconfig    gcc-15.1.0
microblaze   allyesconfig    gcc-15.2.0
mips         allmodconfig    gcc-15.2.0
mips          allnoconfig    gcc-15.1.0
mips         allyesconfig    gcc-15.2.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-15.2.0
openrisc      allnoconfig    gcc-15.1.0
parisc       allmodconfig    gcc-15.2.0
parisc        allnoconfig    gcc-15.1.0
parisc       allyesconfig    gcc-15.2.0
powerpc      allmodconfig    gcc-15.2.0
powerpc       allnoconfig    gcc-15.1.0
riscv        allmodconfig    clang-22
riscv         allnoconfig    gcc-15.1.0
riscv        allyesconfig    clang-16
s390         allmodconfig    clang-18
s390          allnoconfig    clang-22
s390         allyesconfig    gcc-15.2.0
sh           allmodconfig    gcc-15.2.0
sh            allnoconfig    gcc-15.1.0
sh           allyesconfig    gcc-15.2.0
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

