Return-Path: <linux-pci+bounces-13819-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C88990350
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 14:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8BB81C21282
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 12:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348B2148FF6;
	Fri,  4 Oct 2024 12:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SLXblnnR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1F029422
	for <linux-pci@vger.kernel.org>; Fri,  4 Oct 2024 12:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728046342; cv=none; b=iqZ9cGMOe4SlFE9ImYSQI5ueNS2yRrHD9nlac1Hm7g/LK6vqZb0o2B+h0/IJSZSnDuPQj0tuCU6nPcDbnBVgAft3cl13Xy3uxDZUhJQ0sA0AzSo6K5rKz7fJzPU6jjFvgv/YQJmqgtb36iwNGumcO9VymSkO/yNjfkg7OUIfyAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728046342; c=relaxed/simple;
	bh=tXn7cgV5PLplDXu28RDs+afeydt3uFCPje1HwTbv2Rc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=edNYPWaO3JJ3AgfjQ+2FHAoJp1GoAMCkQc7liBhoECcpOeVhsb6KdfjWsEpYwWFrNjuuAul/hk+ZIV+h319ZQYb/48SepWWgVEESjnyZmIMoBlzHEosFqTX724zrdLsjMZtGo4tNI4SIzAUq6GhOUAO+BX4/W6iBXB72qn+JkQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SLXblnnR; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728046340; x=1759582340;
  h=date:from:to:cc:subject:message-id;
  bh=tXn7cgV5PLplDXu28RDs+afeydt3uFCPje1HwTbv2Rc=;
  b=SLXblnnRJz+5nsAPVoAOh5TDu/z27n6mW+9VZ+tPFFrZ1ZaWBQjcbY+E
   4TjNtWmNCx8RSiccZY8Kq64uomy0AiTrwQZD6sCvmOD3pX4RMhlfn9DCs
   HZ8YuzFj8c/N430A0NFMU2hN6fkW0pNML+BuWXmZ7mTu6Z1xa+u4h1MPE
   H9xy6Xg7OQdnK4Q71JurC83stRVwemxjXjf1MAiDsqZJhwEW6dg6JEyut
   FVnMckMGRLLeD8gcJSjkIpPfun+avvPjexziGnTgnPcHxtgsOjAjjTA70
   /ZveGy3lMJXalQpFaiyoNu+Hg9Pi1tSwteKcfdQKu9yujHR4zmGPG4RJ1
   g==;
X-CSE-ConnectionGUID: YTNmpBI5QYGpz4RT5MY+nA==
X-CSE-MsgGUID: 5OY6/vbJSIm37ME5kiV6Lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="26773983"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="26773983"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 05:52:18 -0700
X-CSE-ConnectionGUID: q78K93pRTEOoopSF79+q+g==
X-CSE-MsgGUID: O+sd8qwTSmqx0MewOnerMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="79531559"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 04 Oct 2024 05:52:17 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swhn4-0001dA-2p;
	Fri, 04 Oct 2024 12:52:14 +0000
Date: Fri, 04 Oct 2024 20:51:27 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:pm] BUILD SUCCESS
 02787a3b4d102eda121ae66f8f05b4e41e082f16
Message-ID: <202410042016.82FWfhr7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pm
branch HEAD: 02787a3b4d102eda121ae66f8f05b4e41e082f16  PCI/PM: Enable runtime power management for host bridges

elapsed time: 816m

configs tested: 81
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha            allnoconfig    gcc-14.1.0
alpha           allyesconfig    clang-20
alpha              defconfig    gcc-14.1.0
arc             allmodconfig    clang-20
arc              allnoconfig    gcc-14.1.0
arc             allyesconfig    clang-20
arc                defconfig    gcc-14.1.0
arm             allmodconfig    clang-20
arm              allnoconfig    gcc-14.1.0
arm             allyesconfig    clang-20
arm                defconfig    gcc-14.1.0
arm64           allmodconfig    clang-20
arm64            allnoconfig    gcc-14.1.0
arm64              defconfig    gcc-14.1.0
csky             allnoconfig    gcc-14.1.0
csky               defconfig    gcc-14.1.0
hexagon         allmodconfig    clang-20
hexagon          allnoconfig    gcc-14.1.0
hexagon         allyesconfig    clang-20
hexagon            defconfig    gcc-14.1.0
i386            allmodconfig    clang-18
i386             allnoconfig    clang-18
i386            allyesconfig    clang-18
i386               defconfig    clang-18
loongarch       allmodconfig    gcc-14.1.0
loongarch        allnoconfig    gcc-14.1.0
loongarch          defconfig    gcc-14.1.0
m68k            allmodconfig    gcc-14.1.0
m68k             allnoconfig    gcc-14.1.0
m68k            allyesconfig    gcc-14.1.0
m68k               defconfig    gcc-14.1.0
microblaze      allmodconfig    gcc-14.1.0
microblaze       allnoconfig    gcc-14.1.0
microblaze      allyesconfig    gcc-14.1.0
microblaze         defconfig    gcc-14.1.0
mips             allnoconfig    gcc-14.1.0
nios2            allnoconfig    gcc-14.1.0
nios2              defconfig    gcc-14.1.0
openrisc         allnoconfig    clang-20
openrisc         allnoconfig    gcc-14.1.0
openrisc        allyesconfig    gcc-14.1.0
openrisc           defconfig    gcc-12
parisc          allmodconfig    gcc-14.1.0
parisc           allnoconfig    clang-20
parisc           allnoconfig    gcc-14.1.0
parisc          allyesconfig    gcc-14.1.0
parisc             defconfig    gcc-12
parisc64           defconfig    gcc-14.1.0
powerpc         allmodconfig    gcc-14.1.0
powerpc          allnoconfig    clang-20
powerpc          allnoconfig    gcc-14.1.0
powerpc         allyesconfig    gcc-14.1.0
riscv           allmodconfig    gcc-14.1.0
riscv            allnoconfig    clang-20
riscv            allnoconfig    gcc-14.1.0
riscv           allyesconfig    gcc-14.1.0
riscv              defconfig    gcc-12
s390            allmodconfig    gcc-14.1.0
s390             allnoconfig    clang-20
s390            allyesconfig    gcc-14.1.0
s390               defconfig    gcc-12
sh              allmodconfig    gcc-14.1.0
sh               allnoconfig    gcc-14.1.0
sh              allyesconfig    gcc-14.1.0
sh                 defconfig    gcc-12
sparc           allmodconfig    gcc-14.1.0
sparc64            defconfig    gcc-12
um              allmodconfig    clang-20
um               allnoconfig    clang-17
um               allnoconfig    clang-20
um              allyesconfig    clang-20
um                 defconfig    gcc-12
um            i386_defconfig    gcc-12
um          x86_64_defconfig    gcc-12
x86_64           allnoconfig    clang-18
x86_64          allyesconfig    clang-18
x86_64             defconfig    clang-18
x86_64                 kexec    gcc-12
x86_64              rhel-8.3    gcc-12
x86_64         rhel-8.3-rust    clang-18
xtensa           allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

