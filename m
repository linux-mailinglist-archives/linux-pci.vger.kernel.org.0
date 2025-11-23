Return-Path: <linux-pci+bounces-41918-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D5DC7DA30
	for <lists+linux-pci@lfdr.de>; Sun, 23 Nov 2025 01:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A83323A9411
	for <lists+linux-pci@lfdr.de>; Sun, 23 Nov 2025 00:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8618F72627;
	Sun, 23 Nov 2025 00:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FXnogIay"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E8D14A91
	for <linux-pci@vger.kernel.org>; Sun, 23 Nov 2025 00:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763857942; cv=none; b=FKxQLO0t4wnAN5giibP8OseCu8ubB6hxZbcSm9ee00h5faek7GnrvEkqAnqX5TNA4WWjay3qpisJ2mUCpELKXP/KXGEurnf/TjkUPZ6xczVJh+75RLjpFGs2P8OLrBr00uO8eOzYvEl2qJlkpyfu4mVBPHM5NEm0oY+N4Z0HB/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763857942; c=relaxed/simple;
	bh=2UBy4mnXQAhPsgD2N0rf+T9xXw03cN8NJ7fLVijoR8M=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KFiAnCO1vUp8AU7a8VJ2Ruf8LbA9RvDvrW4mYoG+mvkw8NZk5jozmfqp6gWQ8Ot4fVE4WxxD4ijcx6RILJ508ACJK8hMl7JXHnfCqkjs7cj/ulpkYAjUZkrzcfls6U1VwK4gNyuF4u2wEbWP0HCtLLkK9R07lHazXCJQdDK1o/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FXnogIay; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763857941; x=1795393941;
  h=date:from:to:cc:subject:message-id;
  bh=2UBy4mnXQAhPsgD2N0rf+T9xXw03cN8NJ7fLVijoR8M=;
  b=FXnogIayf6TBKbkC56e//VKw4e5J7ketk7AO3wqx61DveR/ut70JiTxs
   11vBwY5SrHBnLRyDN2GeJZzvx45smOseZt0OtSq9hRrSs3+CpRuuVQ29A
   HVsjK4Uu3vlo91B+xBfMu25QRKxEXQyNwkRUHd306+wBr19OB0rG7dpA4
   VFEQDW5ZhdIEIbqps0kQQ9Ipyb7l5W110iCwO+RFbkTLO20W2EcCpOubY
   d1Pi/dfKhlEkGk00BqmSDdtIgFMz2Oj/JfkhqKYLfYuJALMwmlNFXteae
   F+a47d73i/LvzeIh02L3HuNaxhxCoYOD/5lNaMyl0/XelAtzYHRgdtSA+
   w==;
X-CSE-ConnectionGUID: CUz0/9bLQemQFqec+9do3g==
X-CSE-MsgGUID: ZfJRy3IGS9m1NDM9fbzf7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11621"; a="69772889"
X-IronPort-AV: E=Sophos;i="6.20,219,1758610800"; 
   d="scan'208";a="69772889"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2025 16:32:20 -0800
X-CSE-ConnectionGUID: 4ssARJjIRhagIfMLR5bJlg==
X-CSE-MsgGUID: qvVwvPkDSH+TzT7IXcZ5nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,219,1758610800"; 
   d="scan'208";a="196473761"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 22 Nov 2025 16:32:17 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vMy1W-0007w5-07;
	Sun, 23 Nov 2025 00:32:14 +0000
Date: Sun, 23 Nov 2025 08:31:34 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/stm32] BUILD SUCCESS
 cfa3c76e059a2ed134f8da4ab8d2f46e3582b94e
Message-ID: <202511230828.ZV9Colys-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/stm32
branch HEAD: cfa3c76e059a2ed134f8da4ab8d2f46e3582b94e  PCI: stm32: Don't use 'proxy' headers

elapsed time: 7429m

configs tested: 60
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.1.0
alpha                  allyesconfig    gcc-15.1.0
arc                     allnoconfig    gcc-15.1.0
arc         randconfig-001-20251118    gcc-14.3.0
arc         randconfig-002-20251118    gcc-15.1.0
arm                     allnoconfig    clang-22
arm         randconfig-001-20251118    gcc-8.5.0
arm         randconfig-002-20251118    gcc-10.5.0
arm         randconfig-003-20251118    clang-22
arm         randconfig-004-20251118    clang-22
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
nios2                   allnoconfig    gcc-11.5.0
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

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

