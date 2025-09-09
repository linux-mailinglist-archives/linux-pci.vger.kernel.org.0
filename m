Return-Path: <linux-pci+bounces-35770-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C256FB507C0
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 23:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A131B21A11
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 21:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428F224C077;
	Tue,  9 Sep 2025 21:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EkLrvAYH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B21244665
	for <linux-pci@vger.kernel.org>; Tue,  9 Sep 2025 21:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757452123; cv=none; b=s4zlAE2RfWY9LnIJm2mIrEraCplBVaeuvoKK/n3PnwdALyYUA6hkz0/CkmJCo3iETCnvRhXscogHDCUS/zer2stDGOpDbjHuk8y2Nh7osw1KoqcGtlQYthotyMctxontiU61M9C41+Iurztdi4cZpG6U8H05cySouE3WZbvCzME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757452123; c=relaxed/simple;
	bh=cDZaWb9HOezE8naQ78WzJ8LUy9s/6RYOJK4d1i5mcGQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dWP3alxZA1EDjYJebzKBVzK/WgUKRXr6ogXSVcjrmtBEoXBkV3oiCAkwqYlTrtuwZYPDnea1PwZCpDOiafRfrq+SRbQ/xECXUr2pIBF++PoWQ2qwicvPuXmhH05t8R4elFc8UGzFF1Pw9IKYyxX9P7rg0S4OaVT5fDRETOae+4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EkLrvAYH; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757452121; x=1788988121;
  h=date:from:to:cc:subject:message-id;
  bh=cDZaWb9HOezE8naQ78WzJ8LUy9s/6RYOJK4d1i5mcGQ=;
  b=EkLrvAYHZWh2FQ4kirgp2Ta7k5tTFHXMlr9vVN8U9dxqrxwtw7SJbZ93
   QOpuAv490AuhX/Viye7r1jcpm0vzF/Vj7lnTCbjr6ZeVcs98ufy4a5LN5
   JBxi7CsaLqxjyZ1yqh3kmRoQBnRu3KUjwqpGa0mayCaHc+0EEifFEliQL
   NiCOGhoMVMaE9cZPFF+z6F7sDZpJgtt8ZXKHuEJFShONvxag14Zi23HXg
   ZFzLBg4rUYzpPPznnee52iEP+aSNhmpcP09WUJMqDnnfEXBRieUeY94Wv
   /63t6wxSjvehxcZvNEm8V/jv4u+TPenuls4rt7UMmwWaa5fLOCcKnAgdM
   Q==;
X-CSE-ConnectionGUID: V5HwG1OyRXmP/GzFArz/hQ==
X-CSE-MsgGUID: tYCROi6eTd+r2ZhwhNPmLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="77359792"
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="scan'208";a="77359792"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 14:08:40 -0700
X-CSE-ConnectionGUID: EfMnjb0mS0u/rHl8kVWGrw==
X-CSE-MsgGUID: 8XPiXLWiTU2oX6M6/u8tMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="scan'208";a="204187595"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 09 Sep 2025 14:08:39 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uw5Zt-0005Hk-1t;
	Tue, 09 Sep 2025 21:08:37 +0000
Date: Wed, 10 Sep 2025 05:08:20 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 d5f6bd3ee3f5048f272182dc91675c082773999e
Message-ID: <202509100509.4YTav7NX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: d5f6bd3ee3f5048f272182dc91675c082773999e  PCI: endpoint: pci-epf-test: Limit PCIe BAR size for fixed BARs

elapsed time: 1464m

configs tested: 108
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250909    gcc-8.5.0
arc                   randconfig-002-20250909    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                          pxa910_defconfig    gcc-15.1.0
arm                   randconfig-001-20250909    clang-18
arm                   randconfig-002-20250909    clang-17
arm                   randconfig-003-20250909    clang-22
arm                   randconfig-004-20250909    clang-19
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250909    clang-16
arm64                 randconfig-002-20250909    gcc-11.5.0
arm64                 randconfig-003-20250909    gcc-11.5.0
arm64                 randconfig-004-20250909    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250909    gcc-15.1.0
csky                  randconfig-002-20250909    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20250909    clang-22
hexagon               randconfig-002-20250909    clang-22
i386        buildonly-randconfig-001-20250909    gcc-13
i386        buildonly-randconfig-002-20250909    clang-20
i386        buildonly-randconfig-003-20250909    clang-20
i386        buildonly-randconfig-004-20250909    clang-20
i386        buildonly-randconfig-005-20250909    clang-20
i386        buildonly-randconfig-006-20250909    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250909    gcc-15.1.0
loongarch             randconfig-002-20250909    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                     loongson1b_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250909    gcc-11.5.0
nios2                 randconfig-002-20250909    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250909    gcc-8.5.0
parisc                randconfig-002-20250909    gcc-12.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                 mpc834x_itx_defconfig    clang-16
powerpc               randconfig-001-20250909    clang-22
powerpc               randconfig-002-20250909    clang-17
powerpc               randconfig-003-20250909    gcc-8.5.0
powerpc                     redwood_defconfig    clang-22
powerpc64             randconfig-001-20250909    clang-20
powerpc64             randconfig-002-20250909    gcc-10.5.0
powerpc64             randconfig-003-20250909    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250909    clang-22
riscv                 randconfig-002-20250909    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250909    gcc-11.5.0
s390                  randconfig-002-20250909    clang-18
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                               j2_defconfig    gcc-15.1.0
sh                    randconfig-001-20250909    gcc-15.1.0
sh                    randconfig-002-20250909    gcc-9.5.0
sh                           se7619_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250909    gcc-8.5.0
sparc                 randconfig-002-20250909    gcc-15.1.0
sparc64               randconfig-001-20250909    clang-22
sparc64               randconfig-002-20250909    gcc-8.5.0
um                                allnoconfig    clang-22
um                    randconfig-001-20250909    gcc-14
um                    randconfig-002-20250909    gcc-14
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20250909    clang-20
x86_64      buildonly-randconfig-002-20250909    clang-20
x86_64      buildonly-randconfig-003-20250909    gcc-14
x86_64      buildonly-randconfig-004-20250909    clang-20
x86_64      buildonly-randconfig-005-20250909    gcc-14
x86_64      buildonly-randconfig-006-20250909    clang-20
x86_64                              defconfig    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  audio_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250909    gcc-8.5.0
xtensa                randconfig-002-20250909    gcc-15.1.0
xtensa                    xip_kc705_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

