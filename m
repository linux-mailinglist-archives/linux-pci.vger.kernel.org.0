Return-Path: <linux-pci+bounces-22575-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C72A7A48408
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 17:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F9B63A4DFD
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 16:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2A01A8F63;
	Thu, 27 Feb 2025 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I6n1LlNu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D601AB52F
	for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2025 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671841; cv=none; b=iy0ZWULtvL2SN+iw/xTzAgqJsoedlt/qyKR8cgqVaZdZwXVxqVxUsPigaQ0F5TrEwIevQLaJepqr3luSMwoAqU/sU857fKoz6i0JWO74LG0Ceur6V8Msrc/l9ejmwMtM/I4H16g2SSzfqqxihlj7xwDIdVWCM9+Kb7kByegGob0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671841; c=relaxed/simple;
	bh=hsBPoapFvAcXPn6TEO/bVrqSvDv+BLiwPMRwCeLJ4sU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZfFsMofGWRY6dJWb8jKS8FdqE2VDc8GCcVXz+UDb2Ph430hOuYs6Kx1xgzYXf1nn5OYijMPhfnW9Mwt6UKE/TsJgXvaijW0MwnVR4Bo+SCFSzdh4Zhfe1ez9RFGvCKTIiSC438Ja+FdAStk/ql790cLweCuW0f8I3q+NkXEQcFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I6n1LlNu; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740671840; x=1772207840;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hsBPoapFvAcXPn6TEO/bVrqSvDv+BLiwPMRwCeLJ4sU=;
  b=I6n1LlNu5wmuMsA2yzzMeNIaL9K5+Yxtcme40bchpYliLbBCz8m//+YQ
   CiEAS/FvLHiaDvOKq3IOBldjg6kLOXPIwbPoVJaNaK74kAmvfsOIPgFa/
   AW/By4+bK3/Je9BLG5Vy/kWeVe612uqQOwTi/3q5P2rMYMhDy3bM9aY+n
   KX2cQvp7S8BPXEAFAQvUHwEaoQ0YoO6n++bOrHUL/S5JJZ7zCoPUTjU2e
   /z0Zdttoe6QtfUnI6kpmjoxobhfF+ymAohWwIspfHFsusS/6gfcex5zDD
   Xnk8QWmUpOKpFkIVtTWKjLfYsGuWxVZLK3OyfD/6oz9+TSrHLEdHBeAJW
   A==;
X-CSE-ConnectionGUID: 9nkwGIvpRO2IKaQeLhjG/Q==
X-CSE-MsgGUID: AwikED+cRAaqf59V1T5OPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="51775748"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="51775748"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 07:57:19 -0800
X-CSE-ConnectionGUID: dBemvQpXTBm7uP92LkjHkQ==
X-CSE-MsgGUID: xIydAkdATRqVNSv48SKzaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="122192324"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 27 Feb 2025 07:57:18 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tngGB-000Dd0-2z;
	Thu, 27 Feb 2025 15:57:15 +0000
Date: Thu, 27 Feb 2025 23:56:33 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 bdd741ecc76b6b2902f27743025808bddfce71a3
Message-ID: <202502272328.V98VASbH-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: bdd741ecc76b6b2902f27743025808bddfce71a3  PCI: dwc: ep: Remove superfluous function dw_pcie_ep_find_ext_capability()

elapsed time: 1457m

configs tested: 77
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250227    gcc-13.2.0
arc                   randconfig-002-20250227    gcc-13.2.0
arm                          ixp4xx_defconfig    gcc-14.2.0
arm                   randconfig-001-20250227    gcc-14.2.0
arm                   randconfig-002-20250227    clang-17
arm                   randconfig-003-20250227    gcc-14.2.0
arm                   randconfig-004-20250227    clang-21
arm64                 randconfig-001-20250227    gcc-14.2.0
arm64                 randconfig-002-20250227    clang-19
arm64                 randconfig-003-20250227    gcc-14.2.0
arm64                 randconfig-004-20250227    gcc-14.2.0
csky                  randconfig-001-20250227    gcc-14.2.0
csky                  randconfig-002-20250227    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250227    clang-14
hexagon               randconfig-002-20250227    clang-16
i386        buildonly-randconfig-001-20250227    gcc-12
i386        buildonly-randconfig-002-20250227    gcc-11
i386        buildonly-randconfig-003-20250227    clang-19
i386        buildonly-randconfig-004-20250227    gcc-12
i386        buildonly-randconfig-005-20250227    gcc-11
i386        buildonly-randconfig-006-20250227    clang-19
loongarch             randconfig-001-20250227    gcc-14.2.0
loongarch             randconfig-002-20250227    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                        mvme147_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250227    gcc-14.2.0
nios2                 randconfig-002-20250227    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250227    gcc-14.2.0
parisc                randconfig-002-20250227    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250227    clang-19
powerpc               randconfig-002-20250227    gcc-14.2.0
powerpc               randconfig-003-20250227    clang-19
powerpc64             randconfig-001-20250227    clang-17
powerpc64             randconfig-002-20250227    clang-21
powerpc64             randconfig-003-20250227    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250227    gcc-14.2.0
riscv                 randconfig-002-20250227    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250227    clang-18
s390                  randconfig-002-20250227    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250227    gcc-14.2.0
sh                    randconfig-002-20250227    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250227    gcc-14.2.0
sparc                 randconfig-002-20250227    gcc-14.2.0
sparc64               randconfig-001-20250227    gcc-14.2.0
sparc64               randconfig-002-20250227    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250227    clang-17
um                    randconfig-002-20250227    gcc-12
x86_64      buildonly-randconfig-001-20250227    clang-19
x86_64      buildonly-randconfig-002-20250227    clang-19
x86_64      buildonly-randconfig-003-20250227    gcc-12
x86_64      buildonly-randconfig-004-20250227    gcc-12
x86_64      buildonly-randconfig-005-20250227    clang-19
x86_64      buildonly-randconfig-006-20250227    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250227    gcc-14.2.0
xtensa                randconfig-002-20250227    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

