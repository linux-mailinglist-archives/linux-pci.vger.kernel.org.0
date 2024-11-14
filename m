Return-Path: <linux-pci+bounces-16743-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 336469C86A3
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 10:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E754E28323C
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 09:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922EE1F6669;
	Thu, 14 Nov 2024 09:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c1wBvKuP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566621F7552
	for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 09:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578122; cv=none; b=tmU92P5E2dRCyRMG64mhhlBmWIgX7C2XbTo0lQ1nl8Vxfm3HKNbsO/tgza7oNmyL9LZx6VOJhDSb9KeUwdG1yF4zqXsuqwmNAPOjf0K4oncaAyxlgQ/cSjr2/gwREVzXNPHIEztVYt7eGZVdiruVjG12rbQYacCbNOns47I1qno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578122; c=relaxed/simple;
	bh=Qm4Vr68/5U9JkGq7f31EdtXpD6EV/Q46VPQGQkSfy5Y=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MWm8vgCbZXfJDK9Kgu8oMjbmIW94t/8TNw9De0SPMlOPPDmeVZp/UH6qsQ0DnqyQsMQQ32KoVeh0ivaGWiODJegTikV35sp+yAjOnb/DgB2zipbOLJd4qtfU+m5tusxdc1k8GSgOnHmyOxo+KMXjWOt4fUCq3UFAVxVl11tTNvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c1wBvKuP; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731578120; x=1763114120;
  h=date:from:to:cc:subject:message-id;
  bh=Qm4Vr68/5U9JkGq7f31EdtXpD6EV/Q46VPQGQkSfy5Y=;
  b=c1wBvKuPSVetT9gom7I3DC2MbYcqaFXULGsUr+YeMngEbQIC4NIq4Qlg
   abP3zFGd1tZd7Knu9dxfKldCYk3ioGLJbKO7Wyyo1AUjSUNhZy1fi6QYE
   REo2Hzp9eZiIBvNJFrK88eStmW6Q7fGRxrEb142FsvLmnYrh3Bnipz9CX
   1YNr0qRxwmKddS3Mice7Uh7m1d0keSzKABEw5KH0NSDZXzj0fWVu7/e6o
   9cGkmhYbCqU+CHZKu6c5g/VLrMP4szzWtk8IhaLbDqbbFgVZqYMA2n5sa
   aYU/hiXYTSuINVUE4xXIpJ2AbvHTSbklkyqJgbp3r9eIy8lbd2wRftrx7
   Q==;
X-CSE-ConnectionGUID: BB/fUiDYQ/GT41OJaYRIBA==
X-CSE-MsgGUID: ZN9rIxK/R96iEHE3OtNeig==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="42065818"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="42065818"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 01:55:20 -0800
X-CSE-ConnectionGUID: 84i45H2CTtmBl3+mXrqelA==
X-CSE-MsgGUID: mwcb4ouYTOyWaYOAo6vu5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="88262761"
Received: from lkp-server01.sh.intel.com (HELO cf353f978a24) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 14 Nov 2024 01:55:19 -0800
Received: from kbuild by cf353f978a24 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBWZI-00002X-1z;
	Thu, 14 Nov 2024 09:55:16 +0000
Date: Thu, 14 Nov 2024 17:54:45 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:pm] BUILD SUCCESS
 dc421bb3c0db2aac926b548d259d3b550394908e
Message-ID: <202411141737.cue6FgHg-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pm
branch HEAD: dc421bb3c0db2aac926b548d259d3b550394908e  PCI: Enable runtime PM of the host bridge

elapsed time: 735m

configs tested: 115
configs skipped: 20

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20241114    gcc-13.2.0
arc                   randconfig-002-20241114    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                         axm55xx_defconfig    clang-20
arm                          collie_defconfig    gcc-14.2.0
arm                          ep93xx_defconfig    clang-14
arm                          ixp4xx_defconfig    gcc-14.2.0
arm                          pxa910_defconfig    gcc-14.2.0
arm                   randconfig-001-20241114    gcc-14.2.0
arm                   randconfig-002-20241114    gcc-14.2.0
arm                   randconfig-003-20241114    gcc-14.2.0
arm                   randconfig-004-20241114    clang-14
arm                          sp7021_defconfig    gcc-14.2.0
arm                           u8500_defconfig    gcc-14.2.0
arm                         vf610m4_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241114    clang-20
arm64                 randconfig-002-20241114    gcc-14.2.0
arm64                 randconfig-003-20241114    gcc-14.2.0
arm64                 randconfig-004-20241114    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241114    gcc-14.2.0
csky                  randconfig-002-20241114    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20241114    clang-20
hexagon               randconfig-002-20241114    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241114    clang-19
i386        buildonly-randconfig-002-20241114    gcc-11
i386        buildonly-randconfig-003-20241114    gcc-12
i386        buildonly-randconfig-004-20241114    gcc-12
i386        buildonly-randconfig-005-20241114    gcc-12
i386        buildonly-randconfig-006-20241114    clang-19
i386                                defconfig    clang-19
loongarch                        alldefconfig    gcc-14.2.0
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241114    gcc-14.2.0
loongarch             randconfig-002-20241114    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ip22_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241114    gcc-14.2.0
nios2                 randconfig-002-20241114    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241114    gcc-14.2.0
parisc                randconfig-002-20241114    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-20
powerpc               randconfig-001-20241114    gcc-14.2.0
powerpc               randconfig-002-20241114    clang-14
powerpc               randconfig-003-20241114    gcc-14.2.0
powerpc64             randconfig-001-20241114    gcc-14.2.0
powerpc64             randconfig-002-20241114    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-20
riscv                 randconfig-001-20241114    gcc-14.2.0
riscv                 randconfig-002-20241114    clang-14
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-20
s390                  randconfig-001-20241114    gcc-14.2.0
s390                  randconfig-002-20241114    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20241114    gcc-14.2.0
sh                    randconfig-002-20241114    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

