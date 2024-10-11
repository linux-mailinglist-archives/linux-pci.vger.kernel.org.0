Return-Path: <linux-pci+bounces-14343-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB17A99A9FC
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 19:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390342849DF
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 17:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A673196DB1;
	Fri, 11 Oct 2024 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ACegof9+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9E034CDE
	for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2024 17:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728667773; cv=none; b=K3uL5P//2qx2KHZFFpxgHMY4I5L7/PS9XOzHwkr5WiwAhyPW0z96CxS6BmvvljqWEjdK3/WnL1S5mDO693O8GDFufLuVvVO5JxRuF26Ale1dv2Hug0uOs3LTx5cTvLk/bGqG8GFKyv014tkQFfsUxwIT/9mDZBB/U0y3m94TWVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728667773; c=relaxed/simple;
	bh=n3JcZytXkZvhOegZ5FmzfYCUMbNa8jCpAYMeFyrPIp0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KqCdBU5Hryx163hMxXSro/8Jb8asf3c2yeqQbpLYS6jbpmyjdg7eB20yjDEe1ZfnJgyBMvVamnLfkfB6zqkThR8uYDgIPp0jP3AH8RgdEyXtpE6w2lilnAIonrJyah2tTsHvf9LpBg+MfSq1r083t5J1dwELNsRvd27/1sNOw9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ACegof9+; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728667771; x=1760203771;
  h=date:from:to:cc:subject:message-id;
  bh=n3JcZytXkZvhOegZ5FmzfYCUMbNa8jCpAYMeFyrPIp0=;
  b=ACegof9+cjxTLNifSKlHmEQfzbP3ox2RN0p7rllTpEJqnjZtXoby+t1Z
   9sI7j6LYyJqvj1pooN0lwUTQEtGQo7oRqzQ1gfdx6khW4xDd4dobaNbQ8
   qpFUSsD2n9acxrZB92gXKIRsmh/LgjyEpw457lLJIU3Sj1f78jQ0LNTAc
   90HYQfo/etVyCqUsWrVPDrl3TyTcJWn4VE3/QQhy+ciw/HeauYJrJPYlL
   qcvy8Q2IbArNfJ687O9fRRPSGAyz7YFg+yfjKLnp2/mQqwvh+6BMJcCmm
   3SeaQwY8E/w8pHm5VpQtNcQw5kA5yv+Jgjdz7f7YO9UU4PUHea0lEBzAI
   g==;
X-CSE-ConnectionGUID: HrOOHHiwQtaDSW5kbLcxiQ==
X-CSE-MsgGUID: 6QxwNlFQT/eFnEUedd+r5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="38653998"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="38653998"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 10:29:30 -0700
X-CSE-ConnectionGUID: uMilxgZVQzSkAKOBbpV2ZA==
X-CSE-MsgGUID: Wgk3u7jXTfKE+oy749Zb6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="81968719"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 11 Oct 2024 10:29:29 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szJSB-000CZa-1E;
	Fri, 11 Oct 2024 17:29:27 +0000
Date: Sat, 12 Oct 2024 01:29:26 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:doe] BUILD SUCCESS
 3fe75568727ca23b4025f0c09d59caeae8ec64c7
Message-ID: <202410120112.16ijNqYC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git doe
branch HEAD: 3fe75568727ca23b4025f0c09d59caeae8ec64c7  PCI/DOE: Poll DOE Busy bit for up to 1 second in pci_doe_send_req()

elapsed time: 1088m

configs tested: 83
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241011    gcc-12
i386        buildonly-randconfig-002-20241011    gcc-12
i386        buildonly-randconfig-003-20241011    gcc-12
i386        buildonly-randconfig-004-20241011    gcc-12
i386        buildonly-randconfig-005-20241011    gcc-12
i386        buildonly-randconfig-006-20241011    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20241011    gcc-12
i386                  randconfig-002-20241011    gcc-12
i386                  randconfig-003-20241011    gcc-12
i386                  randconfig-004-20241011    gcc-12
i386                  randconfig-005-20241011    gcc-12
i386                  randconfig-006-20241011    gcc-12
i386                  randconfig-011-20241011    gcc-12
i386                  randconfig-012-20241011    gcc-12
i386                  randconfig-013-20241011    gcc-12
i386                  randconfig-014-20241011    gcc-12
i386                  randconfig-015-20241011    gcc-12
i386                  randconfig-016-20241011    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

