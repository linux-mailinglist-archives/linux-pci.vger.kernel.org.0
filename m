Return-Path: <linux-pci+bounces-13337-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFCA97DCD7
	for <lists+linux-pci@lfdr.de>; Sat, 21 Sep 2024 12:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3194528240A
	for <lists+linux-pci@lfdr.de>; Sat, 21 Sep 2024 10:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5C514B960;
	Sat, 21 Sep 2024 10:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzKS0zWp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF551514C9
	for <linux-pci@vger.kernel.org>; Sat, 21 Sep 2024 10:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726914706; cv=none; b=qHF8uabFsxJdMtLSew04J5JilnoI+PH5ZY6OMS2emkJbhWuwnFw0ccHjhMVi+e0DEc2z2vAsxNzWVzFrCRoaGalnqZkWyrnBljA6dg0/osUQ4BTgvQENvDwVIrXpz9v3t66ZJTRrNq5LPNbBqOpVKPtbaO9u6xotaJxnc/5Opc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726914706; c=relaxed/simple;
	bh=IjrvuOLDNZO2jUesARScGgiwhOmuIAjL3KodJ6dZL6Y=;
	h=Date:From:To:Cc:Subject:Message-ID; b=M9m8x/arTspymWza8nsNZZHQo+GjIh2LzK3AMCNpVcH9gQwo2y/1oomrZptZCTpAXe8Tj7PzN3oOp1ZyeAOLJfyA/2M3WL6YlmsMrjyFqjiIKfVYs8rgZoTTOPtUgkHEOEdB5CYpSoROeAnq+UsrqFIIwiUS61qJAhNW6ilm2eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lzKS0zWp; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726914705; x=1758450705;
  h=date:from:to:cc:subject:message-id;
  bh=IjrvuOLDNZO2jUesARScGgiwhOmuIAjL3KodJ6dZL6Y=;
  b=lzKS0zWpdA9g+gSh/vbAxLIXLlP9FHyNp02bK5TxuCLuU5FaEaSXNVMl
   iS4bq/BZdZfkRfNt5mEwiW9Ura+46FNeg9HeiJoX9bgEiIba9dogJ29Rk
   Fr1EIr66qr5TEdeSV44iE9t6bsImFhG7eWhty9gBQ8Li3rKtXH0NWy2Qr
   ZI6ecSW+WkqY2WLNHxU8ic20VOWLGoywad5KgHBq7JhdEmh7UNBqlrcTP
   l0yZPJv1qS6JpUVvwMial2OHD0QeyqkEpHFH1vhs5wmpUt2Ht3e/VJhIJ
   mxoSTB4Rnu3QchH7tAx2rLMmytmWFDxAT8n9/VceU04bRMpb9yIXHSVFx
   g==;
X-CSE-ConnectionGUID: Yl0Rim/BROm67BWCyS6Y8w==
X-CSE-MsgGUID: LKOi7COCTyqeQ29lnWyZQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11201"; a="37291013"
X-IronPort-AV: E=Sophos;i="6.10,246,1719903600"; 
   d="scan'208";a="37291013"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2024 03:31:44 -0700
X-CSE-ConnectionGUID: C7LzKNVOTqSiu63NABnSag==
X-CSE-MsgGUID: DPLsZvqYTuiTmEcSKBVrXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,246,1719903600"; 
   d="scan'208";a="70159532"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 21 Sep 2024 03:31:44 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1srxOv-000FM1-1T;
	Sat, 21 Sep 2024 10:31:41 +0000
Date: Sat, 21 Sep 2024 18:31:05 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 9706513e56af9c3e35bd766cd5b7edf1c6f9d177
Message-ID: <202409211800.XNlUyAE7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 9706513e56af9c3e35bd766cd5b7edf1c6f9d177  Merge branch 'pci/tools'

elapsed time: 3541m

configs tested: 66
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-13.3.0
alpha                  allyesconfig    gcc-13.3.0
alpha                     defconfig    gcc-13.3.0
arc                    allmodconfig    gcc-13.2.0
arc                     allnoconfig    gcc-13.2.0
arc                    allyesconfig    gcc-13.2.0
arc                       defconfig    gcc-13.2.0
arc         randconfig-001-20240921    gcc-13.2.0
arc         randconfig-002-20240921    gcc-13.2.0
arm                    allmodconfig    gcc-14.1.0
arm                     allnoconfig    clang-20
arm                    allyesconfig    gcc-14.1.0
arm              clps711x_defconfig    clang-20
arm                       defconfig    clang-14
arm             multi_v4t_defconfig    clang-20
arm         randconfig-001-20240921    clang-20
arm         randconfig-002-20240921    gcc-14.1.0
arm         randconfig-003-20240921    gcc-14.1.0
arm         randconfig-004-20240921    clang-20
arm                 sama7_defconfig    clang-20
arm64                  allmodconfig    clang-20
arm64                   allnoconfig    gcc-14.1.0
arm64                     defconfig    gcc-14.1.0
arm64       randconfig-001-20240921    gcc-14.1.0
arm64       randconfig-002-20240921    clang-20
csky                    allnoconfig    gcc-14.1.0
csky                      defconfig    gcc-14.1.0
hexagon                 allnoconfig    clang-20
hexagon                   defconfig    clang-20
i386                   allmodconfig    gcc-12
i386                    allnoconfig    gcc-12
i386                   allyesconfig    gcc-12
i386                      defconfig    clang-18
loongarch               allnoconfig    gcc-14.1.0
m68k                   allmodconfig    gcc-14.1.0
m68k                    allnoconfig    gcc-14.1.0
m68k                   allyesconfig    gcc-14.1.0
microblaze              allnoconfig    gcc-14.1.0
mips                    allnoconfig    gcc-14.1.0
nios2                   allnoconfig    gcc-14.1.0
openrisc                allnoconfig    gcc-14.1.0
openrisc               allyesconfig    gcc-14.1.0
openrisc                  defconfig    gcc-14.1.0
parisc                 allmodconfig    gcc-14.1.0
parisc                  allnoconfig    gcc-14.1.0
parisc                 allyesconfig    gcc-14.1.0
powerpc                 allnoconfig    gcc-14.1.0
powerpc                allyesconfig    clang-20
riscv                  allmodconfig    clang-20
riscv                   allnoconfig    gcc-14.1.0
s390                   allmodconfig    clang-20
s390                    allnoconfig    clang-20
s390                   allyesconfig    gcc-14.1.0
sh                     allmodconfig    gcc-14.1.0
sh                      allnoconfig    gcc-14.1.0
sh                     allyesconfig    gcc-14.1.0
sparc                  allmodconfig    gcc-14.1.0
um                      allnoconfig    clang-17
x86_64                  allnoconfig    clang-18
x86_64                 allyesconfig    clang-18
x86_64                    defconfig    gcc-11
x86_64                 rhel-8.3-bpf    gcc-12
x86_64               rhel-8.3-kunit    gcc-12
x86_64                 rhel-8.3-ltp    gcc-12
x86_64                rhel-8.3-rust    clang-18
xtensa                  allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

