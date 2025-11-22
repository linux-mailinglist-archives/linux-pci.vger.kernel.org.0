Return-Path: <linux-pci+bounces-41910-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 633E7C7D14B
	for <lists+linux-pci@lfdr.de>; Sat, 22 Nov 2025 14:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA163A8081
	for <lists+linux-pci@lfdr.de>; Sat, 22 Nov 2025 13:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1F21D2F42;
	Sat, 22 Nov 2025 13:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gDFw99ae"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545928488
	for <linux-pci@vger.kernel.org>; Sat, 22 Nov 2025 13:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763817112; cv=none; b=dlihQKuhQz/JON3tZ+MN4ky+I+WPK8QWJci2MYt2+Ln2RAtHKwc73Ini9IBs5JbZT6YTe2ihrg2j76BIrhG9sEnj1nJ8ZtF4ivFcbe3RFrEOTlGqJNgQSWeBHKJHwuMu8ynY+tTzwqiebK1t7IxExLKh2zv3JmkEuTezd31gpjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763817112; c=relaxed/simple;
	bh=NqqTBKem3/VhDs1vYgpGiXdYqoIl6/v24gfVX4ed8Uo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HKETsnWLAVHKikjSItXF3ZekFxe9A90Yq2oGz3sgWF+zQIUTnUky3O4I6zq526meaHxoqQGYL7MYr+3zzWmYdlvvFq7azGerWEaKOMQAcLyfBm2K8vLH0AKQCNkzhb8bfVE59Pu5J48mJ5q1GWV8WsiE5Xag9EvVsyu5JxileBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gDFw99ae; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763817110; x=1795353110;
  h=date:from:to:cc:subject:message-id;
  bh=NqqTBKem3/VhDs1vYgpGiXdYqoIl6/v24gfVX4ed8Uo=;
  b=gDFw99aeWGAv9Mc1m0G6vvwxpBjJoAbzZRGeA+iPi8jLpsOlSbHyI8bD
   wLnwDL21fOIEwTPm6pbT+W1RBFboBLkmeHusJQqgz1nl375eqMSfcQfUA
   31psaidwTmsBJj5TCezX93Fmy6XD3ve6iaR/URZF/RDAGCpYl3REvKk1u
   qKCVKGQilp2tcV8EqEoZZCRMJmy+5ORs5JCReqNP0kN+MhNIP/hX6V6ll
   TycxoGRO5P5OPgC1ME4qwTutnyQhz9Hgh5JtQAcm0K9gcmIXspWUiPnKu
   Inm8uNdCw3yFqT0TiJp1Nbc1w1P55mxOtAHmDqoPn/izKo3FAyYLfVp9s
   w==;
X-CSE-ConnectionGUID: BcAcvOEwRtOwHfmxhcPbgQ==
X-CSE-MsgGUID: e+WR7llfT8CVfy7rTrwuFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11621"; a="76576736"
X-IronPort-AV: E=Sophos;i="6.20,218,1758610800"; 
   d="scan'208";a="76576736"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2025 05:11:42 -0800
X-CSE-ConnectionGUID: flmvChhPTjOCPbCSG2RFZg==
X-CSE-MsgGUID: sF5AROf0SK2KJHd7qrzOWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,218,1758610800"; 
   d="scan'208";a="197050644"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 22 Nov 2025 05:11:41 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vMnOs-0007Wd-23;
	Sat, 22 Nov 2025 13:11:38 +0000
Date: Sat, 22 Nov 2025 21:11:29 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:dt-binding] BUILD SUCCESS
 3b83eea6334acd07ae5fa043442a6ade732d7a39
Message-ID: <202511222123.98mtLP9R-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git dt-binding
branch HEAD: 3b83eea6334acd07ae5fa043442a6ade732d7a39  dt-bindings: PCI: qcom,pcie-x1e80100: Add missing required power-domains and resets

elapsed time: 7187m

configs tested: 64
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.1.0
arc                     allnoconfig    gcc-15.1.0
arc         randconfig-001-20251118    gcc-14.3.0
arc         randconfig-002-20251118    gcc-15.1.0
arm                     allnoconfig    clang-22
arm         randconfig-001-20251118    gcc-8.5.0
arm         randconfig-002-20251118    gcc-10.5.0
arm         randconfig-003-20251118    clang-22
arm         randconfig-004-20251118    clang-22
arm64                   allnoconfig    gcc-15.1.0
arm64       randconfig-001-20251118    clang-20
arm64       randconfig-002-20251118    clang-22
arm64       randconfig-003-20251118    clang-19
arm64       randconfig-004-20251118    clang-17
csky                   allmodconfig    gcc-15.1.0
csky                    allnoconfig    gcc-15.1.0
csky        randconfig-001-20251118    gcc-10.5.0
csky        randconfig-002-20251118    gcc-15.1.0
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
parisc                  allnoconfig    gcc-15.1.0
powerpc                 allnoconfig    gcc-15.1.0
riscv                   allnoconfig    gcc-15.1.0
riscv                  allyesconfig    clang-16
riscv       randconfig-001-20251117    gcc-12.5.0
riscv       randconfig-002-20251117    gcc-15.1.0
s390                   allmodconfig    clang-18
s390                    allnoconfig    clang-22
s390                   allyesconfig    gcc-15.1.0
s390        randconfig-001-20251117    gcc-14.3.0
s390        randconfig-002-20251117    clang-22
sh                     allmodconfig    gcc-15.1.0
sh                      allnoconfig    gcc-15.1.0
sh                     allyesconfig    gcc-15.1.0
sh          randconfig-001-20251117    gcc-15.1.0
sh          randconfig-002-20251117    gcc-15.1.0
sparc                   allnoconfig    gcc-15.1.0
um                      allnoconfig    clang-22
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

