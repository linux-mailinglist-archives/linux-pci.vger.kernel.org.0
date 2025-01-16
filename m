Return-Path: <linux-pci+bounces-20007-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B56F0A14193
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 19:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 357333A8DA4
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 18:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3F01DE4E7;
	Thu, 16 Jan 2025 18:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YCw8R5F5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68557190685
	for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 18:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737051775; cv=none; b=GAfn5JcCkPMu8Y1xUJ2Eyfub4AcWnlVnCAgyqnMAeSCglYzdN+Ht2T+u/1yxdfjoT2Ow8xG4s1sOBrtqGaH8yk/eZsjhM/mdROLvZfnijOXl1AFb4cV/1h6cJyZYckOEiP68KosFLkzqfsPZC/Z0656OVYCiCrUzho/8TPdJCaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737051775; c=relaxed/simple;
	bh=4qWVncSe7AUwFq61w/HH4ZRPptE8LKEyC4f46RkD1YA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=n3iSm5k0kUv05hl2LFnUjhGF+hw2kcN+MimM7Sz7O7a8lKZGC3Ctl6rBW4KP1zG1uEP6vOdXllUkmpTL7Y6De9twnl+yu5OS+ktgE+p/7klZ23lFiqBzmGTTKSJL+avCibqqorQn2CDuSVrTUzfoLSUo4AqISsy9JLLPhYIzJo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YCw8R5F5; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737051773; x=1768587773;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4qWVncSe7AUwFq61w/HH4ZRPptE8LKEyC4f46RkD1YA=;
  b=YCw8R5F54VGzuBYNnZnDhBdibOktjJj7flMDrWInH0zYcWgEDr/YyWfO
   lceu6C0+dS1djgNdXKvjasV33YTfMmAd6tOtS1w/CD6jjtm+Rb7W9LmQn
   kr740VXu5Tx1SvFFJCBg4kQDEU1BXwYl2eJT1qZn+KiOLRxQl316g/LiY
   hrMAKRphzPiQgfYNALmizBcNasY0sfJbUGUDneL2EvyhF7Wd+1V0uMqfo
   o73bNcbQth+sV2FacKbS/60AGyUi8CZcPqF5e0+Bo0WXH+4jPyACMRyzc
   My20+x9N9yX9+Igg9s/uSB1OLv6QBSSmhdl1rK4aDJSII1OhZDnmPs2ol
   Q==;
X-CSE-ConnectionGUID: 942X0sweTU+KCVGwDJVMsQ==
X-CSE-MsgGUID: t84WWfqOTOm7tIeylCASag==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="55003177"
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="55003177"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 10:22:40 -0800
X-CSE-ConnectionGUID: wuY77o/fSse2CHtIobP6mg==
X-CSE-MsgGUID: QUvPk5+rQsGB7tm6ovk18g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="142850479"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 16 Jan 2025 10:22:39 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYUVo-000SFn-2q;
	Thu, 16 Jan 2025 18:22:36 +0000
Date: Fri, 17 Jan 2025 02:21:38 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/imx6] BUILD SUCCESS
 3a0390cd8d680cfd3050017878540f5e5a41b416
Message-ID: <202501170231.fIl0PM4p-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/imx6
branch HEAD: 3a0390cd8d680cfd3050017878540f5e5a41b416  PCI: imx6: Add IOMMU and ITS MSI support for i.MX95

Warning ids grouped by kconfigs:

recent_errors
|-- i386-buildonly-randconfig-001-20250116
|   `-- drivers-pci-controller-dwc-pci-imx6.c:warning:variable-sid-is-used-uninitialized-whenever-if-condition-is-false
|-- powerpc-randconfig-001-20250116
|   `-- drivers-pci-controller-dwc-pci-imx6.c:warning:variable-sid-is-used-uninitialized-whenever-if-condition-is-false
|-- powerpc64-randconfig-002-20250116
|   `-- drivers-pci-controller-dwc-pci-imx6.c:warning:variable-sid-is-used-uninitialized-whenever-if-condition-is-false
`-- s390-allmodconfig
    `-- drivers-pci-controller-dwc-pci-imx6.c:warning:variable-sid-is-used-uninitialized-whenever-if-condition-is-false

elapsed time: 1445m

configs tested: 58
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                  randconfig-001-20250116    gcc-13.2.0
arc                  randconfig-002-20250116    gcc-13.2.0
arm                  randconfig-001-20250116    gcc-14.2.0
arm                  randconfig-002-20250116    clang-15
arm                  randconfig-003-20250116    gcc-14.2.0
arm                  randconfig-004-20250116    gcc-14.2.0
arm64                randconfig-001-20250116    gcc-14.2.0
arm64                randconfig-002-20250116    gcc-14.2.0
arm64                randconfig-003-20250116    clang-15
arm64                randconfig-004-20250116    clang-20
csky                 randconfig-001-20250116    gcc-14.2.0
csky                 randconfig-002-20250116    gcc-14.2.0
hexagon              randconfig-001-20250116    clang-20
hexagon              randconfig-002-20250116    clang-20
i386       buildonly-randconfig-001-20250116    clang-19
i386       buildonly-randconfig-002-20250116    clang-19
i386       buildonly-randconfig-003-20250116    clang-19
i386       buildonly-randconfig-004-20250116    clang-19
i386       buildonly-randconfig-005-20250116    clang-19
i386       buildonly-randconfig-006-20250116    clang-19
loongarch            randconfig-001-20250116    gcc-14.2.0
loongarch            randconfig-002-20250116    gcc-14.2.0
nios2                randconfig-001-20250116    gcc-14.2.0
nios2                randconfig-002-20250116    gcc-14.2.0
parisc               randconfig-001-20250116    gcc-14.2.0
parisc               randconfig-002-20250116    gcc-14.2.0
powerpc              randconfig-001-20250116    clang-20
powerpc              randconfig-002-20250116    gcc-14.2.0
powerpc              randconfig-003-20250116    clang-20
powerpc64            randconfig-001-20250116    clang-19
powerpc64            randconfig-002-20250116    clang-20
powerpc64            randconfig-003-20250116    clang-15
riscv                randconfig-001-20250116    gcc-14.2.0
riscv                randconfig-002-20250116    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250116    gcc-14.2.0
s390                 randconfig-002-20250116    clang-18
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250116    gcc-14.2.0
sh                   randconfig-002-20250116    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250116    gcc-14.2.0
sparc                randconfig-002-20250116    gcc-14.2.0
sparc64              randconfig-001-20250116    gcc-14.2.0
sparc64              randconfig-002-20250116    gcc-14.2.0
um                   randconfig-001-20250116    clang-19
um                   randconfig-002-20250116    gcc-12
x86_64                           allnoconfig    clang-19
x86_64     buildonly-randconfig-001-20250116    gcc-12
x86_64     buildonly-randconfig-002-20250116    gcc-12
x86_64     buildonly-randconfig-003-20250116    gcc-12
x86_64     buildonly-randconfig-004-20250116    clang-19
x86_64     buildonly-randconfig-005-20250116    clang-19
x86_64     buildonly-randconfig-006-20250116    clang-19
xtensa               randconfig-001-20250116    gcc-14.2.0
xtensa               randconfig-002-20250116    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

