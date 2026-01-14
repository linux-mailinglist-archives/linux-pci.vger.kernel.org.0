Return-Path: <linux-pci+bounces-44866-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DA2D2149B
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 22:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3A7530076A6
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 21:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BB435E551;
	Wed, 14 Jan 2026 21:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JCfVfmqN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6941531C8
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 21:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768425263; cv=none; b=IUrGC2yLFW1AaDpskzU+laebWdsrWsdObhmgMv9GLT9HF0OXx4I/DENAdGRFFCuoGzbU5TXoPCuwZ+TnPZ0fDyIDbhiaFOqUHce8A7uVbxZFwjELXZ8kVkmBqYEzefUlhJYr/MI0NGK75LzkuM4pRggfptytCa3QTEkgb2V5+ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768425263; c=relaxed/simple;
	bh=BFd+V7S3TjS/OK12LiihByZoD4IWwcWOhHv7SJUz0Yg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=r22VTlMQiqxLBlIaRJO2XwkSqrtRZX6m/X/83iaJG24bCRp+WBKld5ktwX/Guy+FhpegWPLh2+4DX89UqQnZP3B2zTDwu+Rx3LPFVjN5RS6b370O+YrJcUmGky1DjdSYiQKALfS+Ah+N/N235/LkU5jCi44GOtvcW+VaMsfUUc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JCfVfmqN; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768425262; x=1799961262;
  h=date:from:to:cc:subject:message-id;
  bh=BFd+V7S3TjS/OK12LiihByZoD4IWwcWOhHv7SJUz0Yg=;
  b=JCfVfmqNwSvX2GFhl3kAeoOcWFezfe1c1kUQzbPiQUKs8oqSgfjYd30v
   MJtavDPZzAXDAlBxUUrlDO0KIrScOVqCxtCJgmO4QGH3ACcu6WQaXDPCQ
   7q3BTHgZLPi0ORZZzsBTwWvxR/q9GG0snaUbWetyF7JOkUNrWNmCg6j1G
   A1JFDjR7NBeCd0yi17pa6e8tf016rx1oq6YS1H4v9nAdguTlZJGeIeZE7
   ifaeYLsHyrEGBkg01jCcKu6aZPNiFHjrn78foBJSPmLZzAyz4fne2WYAX
   +ICFyuGErLVRUKIZKiNHko3Q/pVg5N3dVqo1AUgCQGbGTGzyKlblE8/lP
   Q==;
X-CSE-ConnectionGUID: MtJHW72vSNWZ3uVwa4VDfw==
X-CSE-MsgGUID: nUR6o29mSDGi9Q5Syi55ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="68941995"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="68941995"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 13:14:22 -0800
X-CSE-ConnectionGUID: WbLBvPqpQKe+X9Te+k+Q0g==
X-CSE-MsgGUID: gKgUKgPVSn6bGJE4TSQJJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="236028609"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 14 Jan 2026 13:14:20 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vg8C2-00000000H1G-0YXr;
	Wed, 14 Jan 2026 21:14:18 +0000
Date: Thu, 15 Jan 2026 05:13:18 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:enumeration] BUILD SUCCESS
 73711730a1128d91ebca1a6994ceeb18f36cb0cd
Message-ID: <202601150513.FeXjDebP-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git enumeration
branch HEAD: 73711730a1128d91ebca1a6994ceeb18f36cb0cd  PCI: Do not attempt to set ExtTag for VFs

elapsed time: 8458m

configs tested: 54
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-15.2.0
alpha        allyesconfig    gcc-15.2.0
arc          allmodconfig    gcc-15.2.0
arc           allnoconfig    gcc-15.2.0
arc          allyesconfig    gcc-15.2.0
arm           allnoconfig    clang-22
arm          allyesconfig    gcc-15.2.0
arm64        allmodconfig    clang-19
arm64         allnoconfig    gcc-15.2.0
csky         allmodconfig    gcc-15.2.0
csky          allnoconfig    gcc-15.2.0
hexagon      allmodconfig    clang-17
hexagon       allnoconfig    clang-22
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
i386         allyesconfig    gcc-14
loongarch    allmodconfig    clang-19
loongarch     allnoconfig    clang-22
m68k         allmodconfig    gcc-15.2.0
m68k          allnoconfig    gcc-15.2.0
m68k         allyesconfig    gcc-15.2.0
microblaze    allnoconfig    gcc-15.2.0
microblaze   allyesconfig    gcc-15.2.0
mips         allmodconfig    gcc-15.2.0
mips          allnoconfig    gcc-15.2.0
mips         allyesconfig    gcc-15.2.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-15.2.0
openrisc      allnoconfig    gcc-15.2.0
parisc       allmodconfig    gcc-15.2.0
parisc        allnoconfig    gcc-15.2.0
parisc       allyesconfig    gcc-15.2.0
powerpc      allmodconfig    gcc-15.2.0
powerpc       allnoconfig    gcc-15.2.0
riscv        allmodconfig    clang-22
riscv         allnoconfig    gcc-15.2.0
riscv        allyesconfig    clang-16
s390         allmodconfig    clang-18
s390          allnoconfig    clang-22
s390         allyesconfig    gcc-15.2.0
sh           allmodconfig    gcc-15.2.0
sh            allnoconfig    gcc-15.2.0
sh           allyesconfig    gcc-15.2.0
sparc         allnoconfig    gcc-15.2.0
sparc64      allmodconfig    clang-22
um           allmodconfig    clang-19
um            allnoconfig    clang-22
um           allyesconfig    gcc-14
x86_64       allmodconfig    clang-20
x86_64        allnoconfig    clang-20
x86_64       allyesconfig    clang-20
x86_64      rhel-9.4-rust    clang-20
xtensa        allnoconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

