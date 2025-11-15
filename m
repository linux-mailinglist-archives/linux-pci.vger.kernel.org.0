Return-Path: <linux-pci+bounces-41284-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D135BC60150
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 08:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4A84E3567E2
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 07:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9971D8E1A;
	Sat, 15 Nov 2025 07:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MYYeZ30m"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE3E2AE78
	for <linux-pci@vger.kernel.org>; Sat, 15 Nov 2025 07:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763192978; cv=none; b=env5GyphniyFuKHxgb1MNcABFjDZlNm1WDY1nu5DLLwQBdtI3kysQqOCSFwypxXjK+Re9IIBXzQWKcm7hU/hcN8LvqpZ4/JMh+kbzqggvuIx1quZzOKjJroDkIxR5RM9ARqBzCKEU8H5wCRpkwKRqR1bG3Ax26XYVv9Pm08H0ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763192978; c=relaxed/simple;
	bh=dqrO2NW3Q8hVGNeeeOyCbWIH1VOzzKgbTbx49TVKvG0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=e7wt9UYOnLc2wq04wcBJKbBKAQBYB5GK8awKJmc65N9SsBDPKdAV9tcjq6vrlYK0Dpe4kt43A7699IO5r1aK6KQCRKy5aMdlfylv01MoruEWPaOkTCN1Zwk181QPOAQDFub1YIBRKKbWWAgdcUcQx99fcZ+xXGqpEBzW+0VVWJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MYYeZ30m; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763192977; x=1794728977;
  h=date:from:to:cc:subject:message-id;
  bh=dqrO2NW3Q8hVGNeeeOyCbWIH1VOzzKgbTbx49TVKvG0=;
  b=MYYeZ30mcUdaFi26SMeRpY2SZkwVBwliXeSaLkcpUTKmw2vEyvWVgHGt
   PsiuVgqjZt/Sv6jac3Vtkw8aCeC/nYIfL25gTGCNRjBFkvd8v3zld9wYj
   PJZ+z4tM1mbHjZzuSQOvVR/vKZz1HX/cl8AWL87J5Xb7Lva+IEZ9I2/ic
   gKT+5ptwY9OvuZfSTgD7kssCGaFwacqqjVrP3bjhCltuZxPd5zoRUySkz
   AeIoEUyaWZDTsENcSmjC6vTSrtyRcvGXtE3ch2DD4K73Evbu6JtdXLxpF
   Fvx5nQqJOOcZViK86YzvNaMFCI0ardlKDJakF1WzYnLYHc8zQVNvSQGSq
   w==;
X-CSE-ConnectionGUID: s1cx+vCdRWuGA6/qARNSCw==
X-CSE-MsgGUID: JLWC2mXASsmRUpm1fRoA8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65213355"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65213355"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 23:49:36 -0800
X-CSE-ConnectionGUID: IX1GOd3ER1Gc+oo8No2myA==
X-CSE-MsgGUID: dMSLjPjoQyyZrev9UOWtRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,306,1754982000"; 
   d="scan'208";a="220877775"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 14 Nov 2025 23:49:35 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vKB2K-0007nH-1W;
	Sat, 15 Nov 2025 07:49:32 +0000
Date: Sat, 15 Nov 2025 15:49:19 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/meson] BUILD SUCCESS
 eff0306b109f2d611e44f0155b0324f6cfec3ef4
Message-ID: <202511151514.PhRoLJQ5-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/meson
branch HEAD: eff0306b109f2d611e44f0155b0324f6cfec3ef4  PCI: meson: Fix parsing the DBI register region

elapsed time: 7248m

configs tested: 68
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.1.0
alpha                  allyesconfig    gcc-15.1.0
arc                     allnoconfig    gcc-15.1.0
arc         randconfig-001-20251111    gcc-11.5.0
arc         randconfig-002-20251111    gcc-12.5.0
arm                     allnoconfig    clang-22
arm         randconfig-001-20251111    clang-22
arm         randconfig-002-20251111    clang-17
arm         randconfig-003-20251111    clang-22
arm         randconfig-004-20251111    gcc-10.5.0
arm64                   allnoconfig    gcc-15.1.0
csky                    allnoconfig    gcc-15.1.0
hexagon                allmodconfig    clang-17
hexagon                 allnoconfig    clang-22
hexagon                allyesconfig    clang-22
hexagon     randconfig-001-20251110    clang-22
hexagon     randconfig-002-20251110    clang-22
i386                    allnoconfig    gcc-14
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-22
loongarch   randconfig-001-20251110    clang-22
loongarch   randconfig-002-20251110    clang-22
m68k                   allmodconfig    gcc-15.1.0
m68k                    allnoconfig    gcc-15.1.0
m68k                   allyesconfig    gcc-15.1.0
microblaze             allmodconfig    gcc-15.1.0
microblaze              allnoconfig    gcc-15.1.0
microblaze             allyesconfig    gcc-15.1.0
mips                    allnoconfig    gcc-15.1.0
nios2                   allnoconfig    gcc-11.5.0
nios2       randconfig-001-20251110    gcc-11.5.0
nios2       randconfig-002-20251110    gcc-10.5.0
openrisc                allnoconfig    gcc-15.1.0
parisc                  allnoconfig    gcc-15.1.0
parisc      randconfig-001-20251111    gcc-9.5.0
parisc      randconfig-002-20251111    gcc-8.5.0
powerpc                 allnoconfig    gcc-15.1.0
powerpc     randconfig-001-20251111    gcc-8.5.0
powerpc     randconfig-002-20251111    clang-22
powerpc64   randconfig-002-20251111    gcc-12.5.0
riscv                   allnoconfig    gcc-15.1.0
riscv       randconfig-001-20251110    clang-22
riscv       randconfig-002-20251110    gcc-8.5.0
s390                   allmodconfig    clang-18
s390                    allnoconfig    clang-22
s390                   allyesconfig    gcc-15.1.0
s390        randconfig-001-20251110    gcc-8.5.0
s390        randconfig-002-20251110    gcc-8.5.0
sh                     allmodconfig    gcc-15.1.0
sh                      allnoconfig    gcc-15.1.0
sh                     allyesconfig    gcc-15.1.0
sh          randconfig-001-20251110    gcc-15.1.0
sh          randconfig-002-20251110    gcc-15.1.0
sparc                  allmodconfig    gcc-15.1.0
sparc                   allnoconfig    gcc-15.1.0
um                     allmodconfig    clang-19
um                      allnoconfig    clang-22
um                     allyesconfig    gcc-14
x86_64                  allnoconfig    clang-20
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

