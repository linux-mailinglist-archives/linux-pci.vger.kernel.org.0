Return-Path: <linux-pci+bounces-15564-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C80FE9B5D05
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 08:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BC77283E3D
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 07:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F16E1E0B82;
	Wed, 30 Oct 2024 07:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fIgjGzOW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02441DF723
	for <linux-pci@vger.kernel.org>; Wed, 30 Oct 2024 07:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730273766; cv=none; b=FB9aAyuU7e7by2AsP9k3LAADQe9KdMtONJxcznDdoU6Iq6LS/I8eiR0dGuNZ+PTCVCTxnTRSd92uogO4pgZoWPNxYlizX45p33IazzHcOq3319pLyeUggqhfmhdCSjdFSKPzVz1i0Sy0a3IvRVxuieMg2VcB+t+iOdU1k5ik+s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730273766; c=relaxed/simple;
	bh=EEbInr2FopBCal5W/ZWNc4HM+Fm3bdPSC3TyQwKR3nk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kAMHwQJ/p1+zbd+IAb/tbE6ra7N6xUS8DEI61+Zte97MxxeNRYXOF8P9G4TsnzS/pm52svJE6wB0YCBmS2XYI+uGSUOwBVC3UtbDCvh79nyCu/yfIRA5tIKy/QhDWaBDw7yODm7DeB9bnCcA+hkSf4OFNmh4ZPFD5YyPNlrP7d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fIgjGzOW; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730273763; x=1761809763;
  h=date:from:to:cc:subject:message-id;
  bh=EEbInr2FopBCal5W/ZWNc4HM+Fm3bdPSC3TyQwKR3nk=;
  b=fIgjGzOWsWzM3k+3guihxlSDi7kSxST1DeRvoeDVWGkHeflasySPMlon
   TafVc3VskZbmmOc/xHqRxLFh5cSWcZvboDBEXLBym4R6s2DlF1slT9Eeo
   gULT0S7WtwtmgrYCq+7lt7xO2c1mdmAjFGCffj/UPBzS1Yy5ZrP8+luQn
   nty0ez20qg44EVCdklzuX2B9XNaUfu4VhujMwM8zhgUUslw1tJKemc4K3
   BZpeFe5qaHGJjV2mWFSo2J35jPFT3NF/fynrmJq7D+DCKLEF7tIVBw1gc
   69Czyzba8dFoJeXcroEF9xt/CMl3DcnbahupTDO1aJ+l0V+TxBedt/9aa
   Q==;
X-CSE-ConnectionGUID: H+/ApfAUTZ+xsmxBhRPIOQ==
X-CSE-MsgGUID: XpWguIrMQBidwMUTDNUvlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="47421317"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="47421317"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 00:36:03 -0700
X-CSE-ConnectionGUID: 1yjHFYpoSyWXrO1DCTL+1w==
X-CSE-MsgGUID: reOHVahzRVCQH3F7RqbAzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="87361612"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 30 Oct 2024 00:36:01 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t63FG-000edI-0B;
	Wed, 30 Oct 2024 07:35:58 +0000
Date: Wed, 30 Oct 2024 15:35:53 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 f3c3ccc4fe49dbc560b01d16bebd1b116c46c2b4
Message-ID: <202410301539.1KGySHwP-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: f3c3ccc4fe49dbc560b01d16bebd1b116c46c2b4  PCI: Fix pci_enable_acs() support for the ACS quirks

elapsed time: 838m

configs tested: 85
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                 allnoconfig    gcc-14.1.0
alpha                allyesconfig    clang-20
alpha                   defconfig    gcc-14.1.0
arc                  allmodconfig    clang-20
arc                   allnoconfig    gcc-14.1.0
arc                  allyesconfig    clang-20
arc              axs101_defconfig    clang-20
arc                     defconfig    gcc-14.1.0
arm                  allmodconfig    clang-20
arm                   allnoconfig    gcc-14.1.0
arm                  allyesconfig    clang-20
arm             axm55xx_defconfig    clang-20
arm                     defconfig    gcc-14.1.0
arm             lpc32xx_defconfig    clang-20
arm            realview_defconfig    clang-20
arm           spear13xx_defconfig    clang-20
arm64                allmodconfig    clang-20
arm64                 allnoconfig    gcc-14.1.0
arm64                   defconfig    gcc-14.1.0
csky                  allnoconfig    gcc-14.1.0
csky                    defconfig    gcc-14.1.0
hexagon              allmodconfig    clang-20
hexagon               allnoconfig    gcc-14.1.0
hexagon              allyesconfig    clang-20
hexagon                 defconfig    gcc-14.1.0
i386                 allmodconfig    clang-19
i386                  allnoconfig    clang-19
i386                 allyesconfig    clang-19
i386                    defconfig    clang-19
loongarch            allmodconfig    gcc-14.1.0
loongarch             allnoconfig    gcc-14.1.0
loongarch               defconfig    gcc-14.1.0
m68k                 allmodconfig    gcc-14.1.0
m68k                  allnoconfig    gcc-14.1.0
m68k                 allyesconfig    gcc-14.1.0
m68k                    defconfig    gcc-14.1.0
microblaze           allmodconfig    gcc-14.1.0
microblaze            allnoconfig    gcc-14.1.0
microblaze           allyesconfig    gcc-14.1.0
microblaze              defconfig    gcc-14.1.0
mips                  allnoconfig    gcc-14.1.0
mips               ip30_defconfig    clang-20
mips              rb532_defconfig    clang-20
nios2             3c120_defconfig    clang-20
nios2                 allnoconfig    gcc-14.1.0
nios2                   defconfig    gcc-14.1.0
openrisc              allnoconfig    clang-20
openrisc             allyesconfig    gcc-14.1.0
parisc               allmodconfig    gcc-14.1.0
parisc                allnoconfig    clang-20
parisc               allyesconfig    gcc-14.1.0
parisc64                defconfig    gcc-14.1.0
powerpc              allmodconfig    gcc-14.1.0
powerpc               allnoconfig    clang-20
powerpc              allyesconfig    gcc-14.1.0
powerpc          arches_defconfig    clang-20
powerpc       bluestone_defconfig    clang-20
powerpc     canyonlands_defconfig    clang-20
powerpc           holly_defconfig    clang-20
powerpc         mpc83xx_defconfig    clang-20
powerpc         rainier_defconfig    clang-20
riscv                allmodconfig    gcc-14.1.0
riscv                 allnoconfig    clang-20
riscv                allyesconfig    gcc-14.1.0
s390                 allmodconfig    clang-20
s390                 allmodconfig    gcc-14.1.0
s390                  allnoconfig    clang-20
s390                 allyesconfig    gcc-14.1.0
sh                   allmodconfig    gcc-14.1.0
sh                    allnoconfig    gcc-14.1.0
sh                   allyesconfig    gcc-14.1.0
sh                migor_defconfig    clang-20
sh               se7343_defconfig    clang-20
sh               sh2007_defconfig    clang-20
sparc                allmodconfig    gcc-14.1.0
um                   allmodconfig    clang-20
um                    allnoconfig    clang-20
um                   allyesconfig    clang-20
x86_64                allnoconfig    clang-19
x86_64               allyesconfig    clang-19
x86_64                  defconfig    clang-19
x86_64                      kexec    clang-19
x86_64                      kexec    gcc-12
x86_64                   rhel-8.3    gcc-12
xtensa                allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

