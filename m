Return-Path: <linux-pci+bounces-41550-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06612C6C025
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 00:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3FB1434ECCF
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 23:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B5630F539;
	Tue, 18 Nov 2025 23:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M9UBGVUa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEF6302CDB
	for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2025 23:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763508571; cv=none; b=nqBKd7Q7JoU8Smb5FAo6MOeih3Mx3HhvwjCptPp3kFS+z6fzyBFbaw3WdnHVESspm9wMsQ5nn/hU4c2uF+S0E1w2P/N47jJzaz/9tOJntn5R7b1orZAaDa+LU6Pj2II/8Pxalkg+qOukDLGBvPeirP3/4EbjMOnfUjHP/yRgK0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763508571; c=relaxed/simple;
	bh=Ml+/JUEl67k9M1xamdqbbO86iPOxjeqIBnk9NE14iNU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ItDKqcANfkE5hTleiA1zqG6kDjybKGsc6PpZdeGVNu1DGMjTplxsq3QeYyvy3DkYVgw7C7Jli0pysFhabm9K2qlu85f6jDLNkRIdoLEkeixb9SB+/NQjnT/Gvm/UmQIoYdi/sWjzNfwWqz357ThORNdT4z7/TjwoT6nqeVq5yxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M9UBGVUa; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763508570; x=1795044570;
  h=date:from:to:cc:subject:message-id;
  bh=Ml+/JUEl67k9M1xamdqbbO86iPOxjeqIBnk9NE14iNU=;
  b=M9UBGVUapk4qTdrBe67RIchigS9M0l/gtY1sj1XDMxiCW30BN+mt6IeY
   kYL+CuSIsiBqEaw1lI2u3WHUIJZe+k4bxNM2MENcsDZEOP1oNzkzxph1D
   hpBgc3bOekTbJxy11hjD0AS0EBYgZoezZKjBodGnxQRtFNT7oQ0WAjW0v
   X+ViqJEUv5PSBLGV97fuTDVCFQ1CS65QBmx5v5PaGSXe+ZrxZmMAEZpkL
   US6yWnB2zZAQ99DNL434PebtbB1VaBrJi8PIhwFHFHV95Akq+4diJkrHs
   Q8kNtdxdNxhzUgQiOzMQ3T162C9VNNljbyESkxlXZb0FSKZ5JLkVzNdG+
   A==;
X-CSE-ConnectionGUID: 0sqwHa/ASdSPQhCcLAYcJg==
X-CSE-MsgGUID: ZkwWdtDsSsiogqfvbH5uXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="69411889"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="69411889"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 15:29:29 -0800
X-CSE-ConnectionGUID: HVuTfhVaRwqmDu+3tG1UDQ==
X-CSE-MsgGUID: tb6ksEZ8QauHe/2XZiZnzg==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 18 Nov 2025 15:29:28 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLV8X-0002Gl-31;
	Tue, 18 Nov 2025 23:29:25 +0000
Date: Wed, 19 Nov 2025 07:28:33 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc] BUILD SUCCESS
 f994ca5a3c812db6896ff04a5cf1fbd286d88799
Message-ID: <202511190728.XfcY9o7h-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
branch HEAD: f994ca5a3c812db6896ff04a5cf1fbd286d88799  PCI: dwc: Fix wrong PORT_LOGIC_LTSSM_STATE_MASK definition

elapsed time: 1753m

configs tested: 100
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.1.0
arc                     allnoconfig    gcc-15.1.0
arc         randconfig-001-20251118    gcc-14.3.0
arc         randconfig-002-20251118    gcc-15.1.0
arm                     allnoconfig    clang-22
arm               lpc18xx_defconfig    clang-22
arm         randconfig-001-20251118    gcc-8.5.0
arm         randconfig-002-20251118    gcc-10.5.0
arm         randconfig-003-20251118    clang-22
arm         randconfig-004-20251118    clang-22
arm              spear6xx_defconfig    clang-22
arm64                   allnoconfig    gcc-15.1.0
arm64       randconfig-001-20251118    clang-20
arm64       randconfig-002-20251118    clang-22
arm64       randconfig-003-20251118    clang-19
arm64       randconfig-004-20251118    clang-17
csky                    allnoconfig    gcc-15.1.0
csky        randconfig-001-20251118    gcc-10.5.0
csky        randconfig-002-20251118    gcc-15.1.0
hexagon                 allnoconfig    clang-22
hexagon     randconfig-001-20251118    clang-16
hexagon     randconfig-002-20251118    clang-22
i386                    allnoconfig    gcc-14
i386        randconfig-001-20251118    clang-20
i386        randconfig-002-20251118    clang-20
i386        randconfig-003-20251118    gcc-14
i386        randconfig-004-20251118    gcc-14
i386        randconfig-005-20251118    clang-20
i386        randconfig-006-20251118    gcc-14
i386        randconfig-007-20251118    gcc-14
i386        randconfig-011-20251118    gcc-14
i386        randconfig-012-20251118    gcc-12
i386        randconfig-013-20251118    clang-20
i386        randconfig-014-20251118    gcc-14
i386        randconfig-015-20251118    gcc-14
i386        randconfig-016-20251118    gcc-14
i386        randconfig-017-20251118    clang-20
loongarch               allnoconfig    clang-22
loongarch                 defconfig    clang-19
loongarch   randconfig-001-20251118    gcc-15.1.0
loongarch   randconfig-002-20251118    gcc-15.1.0
m68k                    allnoconfig    gcc-15.1.0
m68k                      defconfig    gcc-15.1.0
microblaze              allnoconfig    gcc-15.1.0
microblaze                defconfig    gcc-15.1.0
mips                    allnoconfig    gcc-15.1.0
mips               db1xxx_defconfig    clang-22
mips                eyeq6_defconfig    clang-22
mips              maltaup_defconfig    clang-22
nios2                   allnoconfig    gcc-11.5.0
nios2                     defconfig    gcc-11.5.0
nios2       randconfig-001-20251118    gcc-11.5.0
nios2       randconfig-002-20251118    gcc-8.5.0
openrisc                allnoconfig    gcc-15.1.0
openrisc                  defconfig    gcc-15.1.0
parisc                  allnoconfig    gcc-15.1.0
parisc                    defconfig    gcc-15.1.0
parisc      randconfig-001-20251118    gcc-14.3.0
parisc      randconfig-002-20251118    gcc-12.5.0
parisc64                  defconfig    gcc-15.1.0
powerpc                 allnoconfig    gcc-15.1.0
powerpc            ppc44x_defconfig    clang-22
riscv                   allnoconfig    gcc-15.1.0
riscv                     defconfig    clang-22
riscv       randconfig-001-20251118    gcc-10.5.0
riscv       randconfig-002-20251118    clang-22
s390                    allnoconfig    clang-22
s390                      defconfig    clang-22
s390        randconfig-002-20251118    gcc-9.5.0
sh                      allnoconfig    gcc-15.1.0
sh                        defconfig    gcc-15.1.0
sh          randconfig-001-20251118    gcc-11.5.0
sh          randconfig-002-20251118    gcc-15.1.0
sh                rsk7269_defconfig    gcc-15.1.0
sparc                   allnoconfig    gcc-15.1.0
sparc                     defconfig    gcc-15.1.0
sparc       randconfig-001-20251119    gcc-15.1.0
sparc       randconfig-002-20251119    gcc-15.1.0
sparc64                   defconfig    clang-20
sparc64     randconfig-001-20251119    gcc-15.1.0
sparc64     randconfig-002-20251119    clang-22
um                      allnoconfig    clang-22
um                        defconfig    clang-22
um                   i386_defconfig    gcc-14
um          randconfig-001-20251119    clang-16
um          randconfig-002-20251119    gcc-14
um                 x86_64_defconfig    clang-22
x86_64                  allnoconfig    clang-20
x86_64                    defconfig    gcc-14
x86_64                        kexec    clang-20
x86_64                     rhel-9.4    clang-20
x86_64                 rhel-9.4-bpf    gcc-14
x86_64                rhel-9.4-func    clang-20
x86_64          rhel-9.4-kselftests    clang-20
x86_64               rhel-9.4-kunit    gcc-14
x86_64                 rhel-9.4-ltp    gcc-14
xtensa                 alldefconfig    gcc-15.1.0
xtensa                  allnoconfig    gcc-15.1.0
xtensa      randconfig-001-20251119    gcc-8.5.0
xtensa      randconfig-002-20251119    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

