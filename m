Return-Path: <linux-pci+bounces-41745-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEB1C72C1E
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 09:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id B3BB32A0CF
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 08:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF13A309DDD;
	Thu, 20 Nov 2025 08:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dgkhgMAf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59232E8DF5
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 08:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763626789; cv=none; b=kkjdD6MF9OO2F23aMn8QlAUgIFQeSC5zEEXs8kRpxnh+eytrFQjzWFGNBqIf3l/5Uh3CWzNRGDLvsEtoGGFaw78lpFm/tk3Z7T2tiFum8ca7GL0iQ/ugVKvzQ06kFikhdma7rJ8LxbT26X3X7cojQohejncaWETWDYjhs2L/YZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763626789; c=relaxed/simple;
	bh=r8efe2TLV24O/+EZZnr0+7kirTKROjII57XL1RaOfNw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EfsLe8/RWAUBtVdNAod34FbiJEJoUaDLvY33WZN2fRwizYFcIs5LhkyXsfaztgR9J3laOrU8ngGHlweFLg3Lnosr02VPYFOg12qf6zDR1kyOqzk0tVHBQBrCC5xdm9H+p6vIuA94uDEhWT6Nw3KlMlhRU+DLwwt8OwfUteC6vYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dgkhgMAf; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763626788; x=1795162788;
  h=date:from:to:cc:subject:message-id;
  bh=r8efe2TLV24O/+EZZnr0+7kirTKROjII57XL1RaOfNw=;
  b=dgkhgMAfroRcdLzLPt2zpjGDg7bGJ88zf221MSThjB8JTBuHlFHItEOX
   3XftiQEPtXiqHXrVB1eux5zp1O8afGvEwr5J5ZRqqGG/Q/Ccu16AwjtYs
   XHIZd05REVv1qeqvVrBm9Aupd/DojiEsxxtLbxeEfkfnxU55uK8WETPtw
   regJhgnqkhbQxnzuYrOsnolzzG2VbvdiXarmXchhhCw01ENlS5HzlX5ta
   u5fsFf1gtgEdBZfySf6IRwdkdTHnvN4syJAl1AQ4YDlUFTk9aNNTmrPU5
   kedGoj3Nj4Hniw4czWydgaNeNTC50RbybirkGNtEDzOgwtShRvFBIZ6Pn
   Q==;
X-CSE-ConnectionGUID: 29xbIFvCSzWrgb0DgiamCw==
X-CSE-MsgGUID: IorDo9jERaiRMNs9VDYBfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="91167587"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="91167587"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 00:18:44 -0800
X-CSE-ConnectionGUID: rOuc7fWHTvaXpFPqjSd9NQ==
X-CSE-MsgGUID: gwQtNRgrSBiU1dgDk/drLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="190549758"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 20 Nov 2025 00:18:43 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLzsG-0003ld-2L;
	Thu, 20 Nov 2025 08:18:40 +0000
Date: Thu, 20 Nov 2025 16:17:57 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:err] BUILD SUCCESS
 73f1f9b0a2c9fc054597a6c35e0add09afec9d8c
Message-ID: <202511201651.5Jk2qwUH-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git err
branch HEAD: 73f1f9b0a2c9fc054597a6c35e0add09afec9d8c  treewide: Drop pci_save_state() after pci_restore_state()

elapsed time: 7598m

configs tested: 68
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.1.0
alpha                  allyesconfig    gcc-15.1.0
arc                    allmodconfig    gcc-15.1.0
arc                     allnoconfig    gcc-15.1.0
arc                    allyesconfig    gcc-15.1.0
arc         randconfig-001-20251115    gcc-13.4.0
arc         randconfig-002-20251115    gcc-11.5.0
arm                     allnoconfig    clang-22
arm                    allyesconfig    gcc-15.1.0
arm         randconfig-001-20251115    clang-22
arm         randconfig-002-20251115    gcc-8.5.0
arm         randconfig-003-20251115    gcc-10.5.0
arm         randconfig-004-20251115    clang-22
arm64                  allmodconfig    clang-19
arm64                   allnoconfig    gcc-15.1.0
csky                   allmodconfig    gcc-15.1.0
csky                    allnoconfig    gcc-15.1.0
hexagon                allmodconfig    clang-17
hexagon                 allnoconfig    clang-22
i386                   allmodconfig    gcc-14
i386                    allnoconfig    gcc-14
i386                   allyesconfig    gcc-14
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-22
m68k                   allmodconfig    gcc-15.1.0
m68k                    allnoconfig    gcc-15.1.0
m68k                   allyesconfig    gcc-15.1.0
microblaze              allnoconfig    gcc-15.1.0
microblaze             allyesconfig    gcc-15.1.0
mips                   allmodconfig    gcc-15.1.0
mips                    allnoconfig    gcc-15.1.0
mips                   allyesconfig    gcc-15.1.0
nios2                  allmodconfig    gcc-11.5.0
nios2                   allnoconfig    gcc-11.5.0
openrisc               allmodconfig    gcc-15.1.0
openrisc                allnoconfig    gcc-15.1.0
parisc                 allmodconfig    gcc-15.1.0
parisc                  allnoconfig    gcc-15.1.0
parisc                 allyesconfig    gcc-15.1.0
powerpc                allmodconfig    gcc-15.1.0
powerpc                 allnoconfig    gcc-15.1.0
riscv                  allmodconfig    clang-22
riscv                   allnoconfig    gcc-15.1.0
riscv                  allyesconfig    clang-16
s390                   allmodconfig    clang-18
s390                    allnoconfig    clang-22
s390                   allyesconfig    gcc-15.1.0
sh                     allmodconfig    gcc-15.1.0
sh                      allnoconfig    gcc-15.1.0
sh                     allyesconfig    gcc-15.1.0
sparc                   allnoconfig    gcc-15.1.0
sparc64                allmodconfig    clang-22
um                     allmodconfig    clang-19
um                      allnoconfig    clang-22
um                     allyesconfig    gcc-14
x86_64                 allmodconfig    clang-20
x86_64                  allnoconfig    clang-20
x86_64                 allyesconfig    clang-20
x86_64                        kexec    clang-20
x86_64                     rhel-9.4    clang-20
x86_64                 rhel-9.4-bpf    gcc-14
x86_64                rhel-9.4-func    clang-20
x86_64          rhel-9.4-kselftests    clang-20
x86_64               rhel-9.4-kunit    gcc-14
x86_64                 rhel-9.4-ltp    gcc-14
x86_64                rhel-9.4-rust    clang-20
xtensa                  allnoconfig    gcc-15.1.0
xtensa                 allyesconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

