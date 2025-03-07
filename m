Return-Path: <linux-pci+bounces-23097-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3626BA5648B
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 11:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C663B4704
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 10:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B351E1DE3;
	Fri,  7 Mar 2025 10:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="miRLqEj/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D061C84B5
	for <linux-pci@vger.kernel.org>; Fri,  7 Mar 2025 10:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741341782; cv=none; b=GTWtHyqdz0Veb+rOWFkXYFMwWClIdkFcVr6hbeO0C48K7NpMATWRZExJSR56p1iT3YTWuRG0WG7JBEmGiaqSG7n6BNF+3Clev8/duKbXutUyFB51lQETrC+BWRSPK2C06ujg05We+WJVlqMGa+bNkTRIUEd4Uf0uzdzmjfEeuHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741341782; c=relaxed/simple;
	bh=Tc4VKvSUshLjDsgCC9xPDLNOPfo0rQWxrydx2X9C7b4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=udfWz6yzrPagKQjKE0OFwvZP1rs8JejC42jNmlQMJFqSuI0cN+tmlwckI0ltLCy8VRYrL+u5CFez1VkYi/uZ+irgRfX+vc7w5yfg6N7TO2PUYy3JAJ7aj49fGcuR9Gjulg5N+zza75gsm5QhC1nGqNZkg4cTlPOeiQEf10AYHVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=miRLqEj/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741341781; x=1772877781;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Tc4VKvSUshLjDsgCC9xPDLNOPfo0rQWxrydx2X9C7b4=;
  b=miRLqEj/U8JichSU9sgY9j18S7oBjfSZnUmZGL7Mb5b9aMEqCl9rgBKw
   V9d2svoGPm1/lHvuWQXQsxS12vRIcf0H/E4eJghhg0gjJPnsAgdmdcpwh
   vR3xnCn2YsKmeVVwi7yd1Uu1itnf5qazttyMlnWxyvFk4TP3sTxRJLU+p
   QpM6ko5F1cp+5agU/Tp5PnFpQO/zqmeCsV7JBUpDi86njQIfAq4QRUiAZ
   zPoQ3hTn19pSrDmxUoZJAx99IgUbJ6s650R8xIf6t2ws3YxJfg9rOd+XU
   9VqtYotulVikMvGYXxIlfaYDTlI4WSneOrw5a+WsaxIT7Zk17XuxYPZ51
   w==;
X-CSE-ConnectionGUID: zaofPjF0TXGCw7uKcwYEKw==
X-CSE-MsgGUID: 6jB0fSXBR7CtNFsMPzmwnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42418171"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="42418171"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 02:03:00 -0800
X-CSE-ConnectionGUID: 9qF/34sVQiumnsekpmaHZw==
X-CSE-MsgGUID: DuvlnediR/SJalSVZjSDrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="119287019"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 07 Mar 2025 02:02:59 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqUXh-0000H3-19;
	Fri, 07 Mar 2025 10:02:57 +0000
Date: Fri, 07 Mar 2025 18:02:15 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:scoped-cleanup] BUILD SUCCESS
 bffc72387aefc4545af04200be8affb51c3726cf
Message-ID: <202503071809.C0hdACQv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git scoped-cleanup
branch HEAD: bffc72387aefc4545af04200be8affb51c3726cf  PCI: tegra: Use helper function for_each_child_of_node_scoped()

elapsed time: 1455m

configs tested: 73
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-14.2.0
alpha                           allyesconfig    gcc-14.2.0
arc                              allnoconfig    gcc-13.2.0
arc                  randconfig-001-20250306    gcc-13.2.0
arc                  randconfig-002-20250306    gcc-13.2.0
arm                              allnoconfig    clang-17
arm                  randconfig-001-20250306    gcc-14.2.0
arm                  randconfig-002-20250306    gcc-14.2.0
arm                  randconfig-003-20250306    gcc-14.2.0
arm                  randconfig-004-20250306    clang-18
arm64                            allnoconfig    gcc-14.2.0
arm64                randconfig-001-20250306    gcc-14.2.0
arm64                randconfig-002-20250306    gcc-14.2.0
arm64                randconfig-003-20250306    gcc-14.2.0
arm64                randconfig-004-20250306    gcc-14.2.0
csky                             allnoconfig    gcc-14.2.0
csky                 randconfig-001-20250307    gcc-14.2.0
csky                 randconfig-002-20250307    gcc-14.2.0
hexagon                          allnoconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250307    clang-21
hexagon              randconfig-002-20250307    clang-21
i386                            allmodconfig    gcc-12
i386                             allnoconfig    gcc-12
i386                            allyesconfig    gcc-12
i386       buildonly-randconfig-001-20250306    clang-19
i386       buildonly-randconfig-002-20250306    clang-19
i386       buildonly-randconfig-003-20250306    clang-19
i386       buildonly-randconfig-004-20250306    gcc-12
i386       buildonly-randconfig-005-20250306    gcc-12
i386       buildonly-randconfig-006-20250306    clang-19
i386                               defconfig    clang-19
loongarch                        allnoconfig    gcc-14.2.0
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
riscv                randconfig-001-20250306    clang-18
riscv                randconfig-002-20250306    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250306    gcc-14.2.0
s390                 randconfig-002-20250306    clang-19
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250306    gcc-14.2.0
sh                   randconfig-002-20250306    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250306    gcc-14.2.0
sparc                randconfig-002-20250306    gcc-14.2.0
sparc64              randconfig-001-20250306    gcc-14.2.0
sparc64              randconfig-002-20250306    gcc-14.2.0
um                   randconfig-001-20250306    gcc-12
um                   randconfig-002-20250306    clang-16
x86_64                           allnoconfig    clang-19
x86_64                          allyesconfig    clang-19
x86_64     buildonly-randconfig-001-20250306    gcc-11
x86_64     buildonly-randconfig-002-20250306    clang-19
x86_64     buildonly-randconfig-003-20250306    clang-19
x86_64     buildonly-randconfig-004-20250306    clang-19
x86_64     buildonly-randconfig-005-20250306    clang-19
x86_64     buildonly-randconfig-006-20250306    gcc-12
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250306    gcc-14.2.0
xtensa               randconfig-002-20250306    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

