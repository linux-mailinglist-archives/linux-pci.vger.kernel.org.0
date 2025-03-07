Return-Path: <linux-pci+bounces-23170-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB01BA57612
	for <lists+linux-pci@lfdr.de>; Sat,  8 Mar 2025 00:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C1137A78E8
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 23:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7974125A2BE;
	Fri,  7 Mar 2025 23:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iqVf1Fh2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1FD25B668
	for <linux-pci@vger.kernel.org>; Fri,  7 Mar 2025 23:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390190; cv=none; b=LjxKmZpei6zviTsdnt4OeSJ0mg1LbLmiSTVIOmgVCeOP1pyoEDKRmbtl+ijSiy5BSNwBQT2jTSNzodiReMujKx27usYrZw8RkpSm2Ktw8Xl4LddqTLI3zXnIgpOqJcJuZcpa2Tt569sVCI+pzVCFtHalwIICLVWcpLzwuM6FQKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390190; c=relaxed/simple;
	bh=dsVyP+F9/FOS2chwdQOUBwI44jVk0evAz6KqZR9mD74=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SGL6xjBC/Hjl9aD95eZ2UD2S+Pvgma03WaxijzVdZw0DIzHIGdV+JxX/WVOuqnlZ8pnZynFm6VDuUjRTwqOWfL6BXzYxjYUWbqqOPPwv8TEZKiPBO7xBHD2ImCMHsfojN3+3ejHNxh9DRzRFcB0UAOrSnVKaKADNbyhhki4OhNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iqVf1Fh2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741390189; x=1772926189;
  h=date:from:to:cc:subject:message-id;
  bh=dsVyP+F9/FOS2chwdQOUBwI44jVk0evAz6KqZR9mD74=;
  b=iqVf1Fh2u3T8MiUMHy7BRh9SG9bAPZta/051lEK3rbabTffh4MR1wYhb
   06xTcJL/QkMOMA0PF+tG+xmwziPk5ZSa4pL/c9AmarfyFL6oltk0Ux/t7
   13Jb9a0zzLg6KUZcr2jc7zQkQDWnzFxfla7QTrUeFvcZBMOirDS+XIrin
   a8IC9wo9YmUnbZKMBV08q4NtnIsj7Sh6ntT5xskI5Vk3BqtauLSxbIRZe
   fW52yb2R/6zNIqD3y+7mAl5Dn0OcPKRUQzukqB0Gg9YLb3VcMiZ+sRkEd
   DGVMeEkF7QQZVczm5m0RU5vK+4BeZDT2tLz0RLirb0THLLgGQaLAM0Vby
   A==;
X-CSE-ConnectionGUID: DcQIEHzHRd61hm6tbnKZqA==
X-CSE-MsgGUID: WxN5gq0bRVWDo3nFwcXNTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="67821144"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="67821144"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 15:29:48 -0800
X-CSE-ConnectionGUID: BJwurbKyRdCjO4EqxY2JYg==
X-CSE-MsgGUID: 6kLvTh83QjCI+Lz3vrDNRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="156667047"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 07 Mar 2025 15:29:47 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqh8S-0001Bh-1m;
	Fri, 07 Mar 2025 23:29:44 +0000
Date: Sat, 08 Mar 2025 07:28:49 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:doe] BUILD SUCCESS
 216235b41a0d1aedc7243d7a93bdcdf5f1649d4a
Message-ID: <202503080743.YUyczNA7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git doe
branch HEAD: 216235b41a0d1aedc7243d7a93bdcdf5f1649d4a  PCI/DOE: Allow enabling DOE without CXL

elapsed time: 1448m

configs tested: 57
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                  randconfig-001-20250307    gcc-13.2.0
arc                  randconfig-002-20250307    gcc-13.2.0
arm                  randconfig-001-20250307    clang-21
arm                  randconfig-002-20250307    gcc-14.2.0
arm                  randconfig-003-20250307    clang-19
arm                  randconfig-004-20250307    clang-21
arm64                randconfig-001-20250307    gcc-14.2.0
arm64                randconfig-002-20250307    clang-15
arm64                randconfig-003-20250307    gcc-14.2.0
arm64                randconfig-004-20250307    clang-15
csky                 randconfig-001-20250307    gcc-14.2.0
csky                 randconfig-002-20250307    gcc-14.2.0
hexagon              randconfig-001-20250307    clang-21
hexagon              randconfig-002-20250307    clang-21
i386       buildonly-randconfig-001-20250307    clang-19
i386       buildonly-randconfig-002-20250307    clang-19
i386       buildonly-randconfig-003-20250307    gcc-11
i386       buildonly-randconfig-004-20250307    clang-19
i386       buildonly-randconfig-005-20250307    gcc-12
i386       buildonly-randconfig-006-20250307    clang-19
loongarch            randconfig-001-20250307    gcc-14.2.0
loongarch            randconfig-002-20250307    gcc-14.2.0
nios2                randconfig-001-20250307    gcc-14.2.0
nios2                randconfig-002-20250307    gcc-14.2.0
parisc               randconfig-001-20250307    gcc-14.2.0
parisc               randconfig-002-20250307    gcc-14.2.0
powerpc              randconfig-001-20250307    gcc-14.2.0
powerpc              randconfig-002-20250307    clang-21
powerpc              randconfig-003-20250307    clang-19
powerpc64            randconfig-001-20250307    clang-21
powerpc64            randconfig-002-20250307    gcc-14.2.0
powerpc64            randconfig-003-20250307    gcc-14.2.0
riscv                randconfig-001-20250307    gcc-14.2.0
riscv                randconfig-002-20250307    clang-19
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250307    gcc-14.2.0
s390                 randconfig-002-20250307    gcc-14.2.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250307    gcc-14.2.0
sh                   randconfig-002-20250307    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250307    gcc-14.2.0
sparc                randconfig-002-20250307    gcc-14.2.0
sparc64              randconfig-001-20250307    gcc-14.2.0
sparc64              randconfig-002-20250307    gcc-14.2.0
um                   randconfig-001-20250307    clang-17
um                   randconfig-002-20250307    clang-21
x86_64     buildonly-randconfig-001-20250307    clang-19
x86_64     buildonly-randconfig-002-20250307    gcc-12
x86_64     buildonly-randconfig-003-20250307    clang-19
x86_64     buildonly-randconfig-004-20250307    clang-19
x86_64     buildonly-randconfig-005-20250307    clang-19
x86_64     buildonly-randconfig-006-20250307    gcc-12
xtensa               randconfig-001-20250307    gcc-14.2.0
xtensa               randconfig-002-20250307    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

