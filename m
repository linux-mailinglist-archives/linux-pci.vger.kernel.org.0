Return-Path: <linux-pci+bounces-33888-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FFDB23A97
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 23:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC153AE0F1
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 21:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF9A270EBA;
	Tue, 12 Aug 2025 21:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T1QK/k5f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351F927450
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 21:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755033874; cv=none; b=rZZ+44h5UJS0+GdS8vSUoQKTDLj1Ezr1evMSRuk1Jm8jR49qB8lACz8geUi0g7as+oDFSNOUAM5e+77+HH35AXwLKx/u4etJ1UmL1jP5uanBgi2FqJKC+kUSN2VG0kA6Sxs/EMhltHEIopov3bdVD7WsFhJq+ryes5u12j8LN/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755033874; c=relaxed/simple;
	bh=5iq/f6PgglDGilEEu9EWcqM6BxmORTqjpTyDcl1csd8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fSKhh8F/93rdeBTTo7NGE0lquGUjq7k6OxEYve+h8uGbA+wL3en1g5chW9nZ/bGWFYdpgYrNsQFFn5o8kRYRXc+gQOsJpbTwXv1GbfcaljsS50mmKBzT1gJZtp5OUb0NUW1ee1rtrNiy6kfpwJ8ZS7g6CsoQrn2WdBDoF6Wbn0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T1QK/k5f; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755033873; x=1786569873;
  h=date:from:to:cc:subject:message-id;
  bh=5iq/f6PgglDGilEEu9EWcqM6BxmORTqjpTyDcl1csd8=;
  b=T1QK/k5f3KsxwUjS//wjTFtqX8B2hbIDTgOwtYHnJFrTNGqSOjmnuarf
   XMwUavRLaP86Q2aLyBoPQMJhEnmUHQnQsyfZXE0f1LtcUuRnZxQdV3o5T
   Na890r5hgQciQQhEHYGpiKEW2OyszCbuh37/UQnZ+t7MHuxntGwjJRWFC
   PT3znrNSP9GMbQV83aDFE3flEnaLl5k1wOuIPRh9ej2MMqDHZ6p6PS4kt
   gDsM63DEaLfV4AGU+lLN3SDtZPUEvcwfKC6ixtMNj3vW82sfCpPzuhXFk
   MBkSQIFEx+nmk2d8A63UaWNQwAI8GjfuH6TDyM6ICGSM/tBsC5UQ0EMUh
   w==;
X-CSE-ConnectionGUID: R4tCjEtAT/20Wnu7KMYBcQ==
X-CSE-MsgGUID: x6P82DzzT0WYyf5x6DTIeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57383333"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="57383333"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 14:24:33 -0700
X-CSE-ConnectionGUID: gm9D1r1rRECeUaGITbryYA==
X-CSE-MsgGUID: wZQD+9/5RT6KUgZwrGa8JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="189998622"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 12 Aug 2025 14:24:30 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ulwTf-0009JI-2D;
	Tue, 12 Aug 2025 21:24:18 +0000
Date: Wed, 13 Aug 2025 05:23:05 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:enumeration] BUILD SUCCESS
 a22250fe933dbd1da9a9683506ae3f489ccc579d
Message-ID: <202508130559.4MzfR5IY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git enumeration
branch HEAD: a22250fe933dbd1da9a9683506ae3f489ccc579d  PCI: Add Extended Tag + MRRS quirk for Xeon 6

elapsed time: 1451m

configs tested: 104
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250812    gcc-8.5.0
arc                   randconfig-002-20250812    gcc-12.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250812    clang-22
arm                   randconfig-002-20250812    clang-22
arm                   randconfig-003-20250812    gcc-14.3.0
arm                   randconfig-004-20250812    gcc-10.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250812    gcc-8.5.0
arm64                 randconfig-002-20250812    gcc-8.5.0
arm64                 randconfig-003-20250812    gcc-14.3.0
arm64                 randconfig-004-20250812    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250812    gcc-13.4.0
csky                  randconfig-002-20250812    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250812    clang-22
hexagon               randconfig-002-20250812    clang-22
i386                              allnoconfig    gcc-12
i386        buildonly-randconfig-001-20250812    gcc-12
i386        buildonly-randconfig-002-20250812    gcc-12
i386        buildonly-randconfig-003-20250812    gcc-12
i386        buildonly-randconfig-004-20250812    clang-20
i386        buildonly-randconfig-005-20250812    clang-20
i386        buildonly-randconfig-006-20250812    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250812    gcc-15.1.0
loongarch             randconfig-002-20250812    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250812    gcc-10.5.0
nios2                 randconfig-002-20250812    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250812    gcc-10.5.0
parisc                randconfig-002-20250812    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20250812    clang-19
powerpc               randconfig-002-20250812    clang-22
powerpc               randconfig-003-20250812    gcc-12.5.0
powerpc64             randconfig-001-20250812    clang-22
powerpc64             randconfig-002-20250812    clang-16
powerpc64             randconfig-003-20250812    clang-18
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250812    gcc-9.5.0
riscv                 randconfig-002-20250812    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250812    clang-18
s390                  randconfig-002-20250812    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250812    gcc-15.1.0
sh                    randconfig-002-20250812    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250812    gcc-8.5.0
sparc                 randconfig-002-20250812    gcc-8.5.0
sparc64               randconfig-001-20250812    clang-22
sparc64               randconfig-002-20250812    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                    randconfig-001-20250812    gcc-11
um                    randconfig-002-20250812    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250812    clang-20
x86_64      buildonly-randconfig-002-20250812    gcc-12
x86_64      buildonly-randconfig-003-20250812    gcc-12
x86_64      buildonly-randconfig-004-20250812    gcc-12
x86_64      buildonly-randconfig-005-20250812    clang-20
x86_64      buildonly-randconfig-006-20250812    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250812    gcc-10.5.0
xtensa                randconfig-002-20250812    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

