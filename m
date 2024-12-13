Return-Path: <linux-pci+bounces-18410-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDDF9F16B6
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 20:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EE62286D6A
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 19:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B6C188A08;
	Fri, 13 Dec 2024 19:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HyBOxVLL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5252191F6A
	for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2024 19:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734119229; cv=none; b=Z0JvCWDPq9PB92h0KHkfIpMdj8a3rSCBXdi+mpp7+ca7UGK4a3jmgLqgUofr3tZX5fqbLLcJhf4iImCq5RazAntYTzkLBqH5w5o3zSHXaOryF6AJ2Yq+jEeFfYldHP7i/WpPnuTRW6KK+21vT0Cp7W6RoFlKJ6rE0ElsrpV6GYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734119229; c=relaxed/simple;
	bh=JmaahF0ahQoOt1Eg+0fSnAzUwABn+yiB0DHotwjSP4o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=s6qhtTCued7U1pv6qbfk3MU8xrN8r8rJRMRbL/w5h8viK7r6X6+omcfA7LuLneNx6iC6ndHzC+ZgfRDbD0QjHwEQPLDYq3DAhX+kOmMsEuaNpgooJmrQmKxSAJwyxjPWfm+ob+/qIh3khgvkggH+wbUSrquT6vNukSqndk2fTuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HyBOxVLL; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734119228; x=1765655228;
  h=date:from:to:cc:subject:message-id;
  bh=JmaahF0ahQoOt1Eg+0fSnAzUwABn+yiB0DHotwjSP4o=;
  b=HyBOxVLL/HY8Oi22OkkZEYa8kDDgW3Kbq7JtnWU0kVilQwppWWby8LLu
   0K/CnUbFe70sQFJXJeM4sUYHQ4f84aSKgwVoUbaf+bnh3LDK5o1+heR2C
   zuk68iaxkCvejWuFfYXCMMa1VjOaQLfMG+G2W/eBPIkHT+Zz/o8qU8C/W
   zvhmpKOoEMlB1GQYRlQmKrdGWFg/0Js+T1huEc09D+3P+tgAidkBrd89h
   +1MOIcLaCG3lpb9YicQFsWdkL19OEG7ZBcwjf3AZCrvjbSoBG/9a+Jp1A
   RpWS2wgCQPRjznpaf5lXwDOVD3SZpQqJz3oks98w3OjHa+UxgRsiv4O/s
   g==;
X-CSE-ConnectionGUID: 03yyLJ9WRMidXKn9DLPg+w==
X-CSE-MsgGUID: 1xEXNkQyTa2jJJapsEGLdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="34720875"
X-IronPort-AV: E=Sophos;i="6.12,232,1728975600"; 
   d="scan'208";a="34720875"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 11:47:07 -0800
X-CSE-ConnectionGUID: KV6T3NRNSu+ViN8xhs57YQ==
X-CSE-MsgGUID: VoEF6nugRnqu0F8XhMK5Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97061691"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 13 Dec 2024 11:47:06 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMBct-000CND-2j;
	Fri, 13 Dec 2024 19:47:03 +0000
Date: Sat, 14 Dec 2024 03:46:23 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 3b9f942eb21c92041905e3943a8d5177c9a9d89d
Message-ID: <202412140316.bLqM0PHA-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: 3b9f942eb21c92041905e3943a8d5177c9a9d89d  PCI: endpoint: Finish virtual EP removal in pci_epf_remove_vepf()

elapsed time: 1449m

configs tested: 59
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                  randconfig-001-20241213    gcc-13.2.0
arc                  randconfig-002-20241213    gcc-13.2.0
arm                  randconfig-001-20241213    clang-16
arm                  randconfig-002-20241213    clang-18
arm                  randconfig-003-20241213    gcc-14.2.0
arm                  randconfig-004-20241213    clang-18
arm64                randconfig-001-20241213    gcc-14.2.0
arm64                randconfig-002-20241213    gcc-14.2.0
arm64                randconfig-003-20241213    clang-18
arm64                randconfig-004-20241213    gcc-14.2.0
csky                 randconfig-001-20241213    gcc-14.2.0
csky                 randconfig-002-20241213    gcc-14.2.0
hexagon              randconfig-001-20241213    clang-20
hexagon              randconfig-002-20241213    clang-20
i386       buildonly-randconfig-001-20241213    clang-19
i386       buildonly-randconfig-002-20241213    gcc-12
i386       buildonly-randconfig-003-20241213    gcc-12
i386       buildonly-randconfig-004-20241213    clang-19
i386       buildonly-randconfig-005-20241213    gcc-12
i386       buildonly-randconfig-006-20241213    gcc-12
loongarch            randconfig-001-20241213    gcc-14.2.0
loongarch            randconfig-002-20241213    gcc-14.2.0
nios2                randconfig-001-20241213    gcc-14.2.0
nios2                randconfig-002-20241213    gcc-14.2.0
parisc               randconfig-001-20241213    gcc-14.2.0
parisc               randconfig-002-20241213    gcc-14.2.0
powerpc              randconfig-001-20241213    gcc-14.2.0
powerpc              randconfig-002-20241213    clang-20
powerpc              randconfig-003-20241213    gcc-14.2.0
powerpc64            randconfig-001-20241213    gcc-14.2.0
powerpc64            randconfig-002-20241213    gcc-14.2.0
powerpc64            randconfig-003-20241213    gcc-14.2.0
riscv                randconfig-001-20241213    gcc-14.2.0
riscv                randconfig-002-20241213    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20241213    gcc-14.2.0
s390                 randconfig-002-20241213    clang-19
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20241213    gcc-14.2.0
sh                   randconfig-002-20241213    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20241213    gcc-14.2.0
sparc                randconfig-002-20241213    gcc-14.2.0
sparc64              randconfig-001-20241213    gcc-14.2.0
sparc64              randconfig-002-20241213    gcc-14.2.0
um                   randconfig-001-20241213    gcc-12
um                   randconfig-002-20241213    clang-16
x86_64                           allnoconfig    clang-19
x86_64     buildonly-randconfig-001-20241213    gcc-12
x86_64     buildonly-randconfig-002-20241213    gcc-12
x86_64     buildonly-randconfig-003-20241213    gcc-12
x86_64     buildonly-randconfig-004-20241213    gcc-12
x86_64     buildonly-randconfig-005-20241213    gcc-12
x86_64     buildonly-randconfig-006-20241213    clang-19
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20241213    gcc-14.2.0
xtensa               randconfig-002-20241213    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

