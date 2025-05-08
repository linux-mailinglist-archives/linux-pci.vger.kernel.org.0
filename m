Return-Path: <linux-pci+bounces-27420-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EB9AAF380
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 08:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758FC3BD7DB
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 06:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4559328E17;
	Thu,  8 May 2025 06:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Opa1YEeX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2B38C1E
	for <linux-pci@vger.kernel.org>; Thu,  8 May 2025 06:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746684801; cv=none; b=ftZZOSDhpFSmBPIq67lS5uR2wF7M2fbrkV2ccK+Gvcq8JjhKG+wu2p8iHQYrzpU5+hpRcpdBcTZMYwJVaiSlsneyBRxPjqHuB7rlHWt/DdrhyYUB897l1nlPce+KKq7Z2DfH6Cbc3bxC34Bk8jUCAM8LBLu0LqSPeZwJCHHefkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746684801; c=relaxed/simple;
	bh=/NXC/pY624h7FCTcZ0vAF2fvW2IFvP8v2lJR3rdRvYE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=E3/j8ZwcTw+gltcKCetg8ldzeMkAUoN61m2tBFIUhjXajwgFrlib54nU7HWCBfWiFIUhdOMq4FtiSKJP/OoYcYWutYbO+kqvRC486UxnojPG3+wvHbKZie7JGCdlMb/hJo6inlN572HLwM+yko1o0xfE0TnTDUZc3RAdc+NjBcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Opa1YEeX; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746684799; x=1778220799;
  h=date:from:to:cc:subject:message-id;
  bh=/NXC/pY624h7FCTcZ0vAF2fvW2IFvP8v2lJR3rdRvYE=;
  b=Opa1YEeXC8YALAjQyGjA9eQQ+Y2apIDGMfeaxUYO48nnoZKkEYwzAav1
   dzxaM4CyhSjMyly7DyxOXG9dejagIe5SrAKmFzTZrnwgGRhUh6E/OSLlV
   JTQyEOewjR3/2xwTaBNYEBjMZrp/cOhfe73XSwq8oTbRy/h9VpMxXg0sO
   f20tkvxroMqbrMKHcskFtFxtazj+FOD+w6MrjBr6GQ088H9jVNv/N6Ogp
   o5ptraTz5XzSSu6Tncbehz5r2049E+zL+N8cRWqY8XigA3vX+5JXIykp4
   JMpEpu+c0noQNCvdkcdHoW7lza+7S2F5UJpZF40neSYN7ME01bcdEDi20
   Q==;
X-CSE-ConnectionGUID: jzGUq29gTsOygEQGgAiOAQ==
X-CSE-MsgGUID: DOuac/M0TYirkWrxl7GDYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="52102467"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="52102467"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 23:13:19 -0700
X-CSE-ConnectionGUID: TsvoI9oWTpiJsLd9JoLXZg==
X-CSE-MsgGUID: sQk+dwo8QrWxy8iPecUcCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="140954843"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 07 May 2025 23:13:18 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCuVP-000Aad-3A;
	Thu, 08 May 2025 06:13:15 +0000
Date: Thu, 08 May 2025 14:12:33 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:reset] BUILD SUCCESS
 f3efb9569b4a21354ef2caf7ab0608a3e14cc6e4
Message-ID: <202505081427.p2Hye1Pl-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git reset
branch HEAD: f3efb9569b4a21354ef2caf7ab0608a3e14cc6e4  PCI: Fix lock symmetry in pci_slot_unlock()

elapsed time: 3501m

configs tested: 44
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha        allnoconfig    gcc-14.2.0
alpha       allyesconfig    gcc-14.2.0
arc          allnoconfig    gcc-14.2.0
arm          allnoconfig    clang-21
arm64        allnoconfig    gcc-14.2.0
csky         allnoconfig    gcc-14.2.0
hexagon     allmodconfig    clang-17
hexagon      allnoconfig    clang-21
hexagon     allyesconfig    clang-21
i386        allmodconfig    gcc-12
i386         allnoconfig    gcc-12
i386        allyesconfig    gcc-12
i386           defconfig    clang-20
loongarch   allmodconfig    gcc-14.2.0
loongarch    allnoconfig    gcc-14.2.0
m68k        allmodconfig    gcc-14.2.0
m68k         allnoconfig    gcc-14.2.0
m68k        allyesconfig    gcc-14.2.0
microblaze  allmodconfig    gcc-14.2.0
microblaze   allnoconfig    gcc-14.2.0
mips         allnoconfig    gcc-14.2.0
nios2        allnoconfig    gcc-14.2.0
openrisc     allnoconfig    gcc-14.2.0
openrisc    allyesconfig    gcc-14.2.0
parisc      allmodconfig    gcc-14.2.0
parisc       allnoconfig    gcc-14.2.0
parisc      allyesconfig    gcc-14.2.0
powerpc      allnoconfig    gcc-14.2.0
riscv        allnoconfig    gcc-14.2.0
s390        allmodconfig    clang-18
s390         allnoconfig    clang-21
s390        allyesconfig    gcc-14.2.0
sh          allmodconfig    gcc-14.2.0
sh           allnoconfig    gcc-14.2.0
sh          allyesconfig    gcc-14.2.0
sparc       allmodconfig    gcc-14.2.0
sparc        allnoconfig    gcc-14.2.0
um          allmodconfig    clang-19
um           allnoconfig    clang-21
um          allyesconfig    gcc-12
x86_64       allnoconfig    clang-20
x86_64      allyesconfig    clang-20
x86_64         defconfig    gcc-11
xtensa       allnoconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

