Return-Path: <linux-pci+bounces-9608-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 992519247DF
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 21:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1ED1C21BC7
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 19:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696DB12E1CA;
	Tue,  2 Jul 2024 19:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NfeViUfG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA28785298
	for <linux-pci@vger.kernel.org>; Tue,  2 Jul 2024 19:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719947603; cv=none; b=DqMIfNnrlmE7quVj74QL+c8NA5+IfGbuQ4V/Lq6mElV6GYBysVX3tws9+ikIfkk/DQggKH4G4FwLGp5CtPjioLWnTLHMNbFaYyimEDey7qaz01n1Om4BYkVFASkK11mRIVvvrNOmCOnpXt5/dqeoRL5azBx7w0eWWJq1M7rsan8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719947603; c=relaxed/simple;
	bh=CxGbB2iSWnihWcYQaczvA0b70njFHknjRTDk0MCwNVE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Sprdug0BoEWOVWwRU9wbOxb1EJqBK3WzMbDqX9IVrBxNFyNiP3wUxkEicxijDZ1dzlwd+wImaFADbkRG/6xKTDMJbXS58tyan4HuYcmoDcFjxHoiTBBcPYKdrcuKP7+lSeR6EIkEcVn77d0Z11KW5+Y1IYeyhYfdGi8KMAGdV/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NfeViUfG; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719947601; x=1751483601;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CxGbB2iSWnihWcYQaczvA0b70njFHknjRTDk0MCwNVE=;
  b=NfeViUfGC26GB/TEeRF7S8YIxJJlxRE4ZrmaSIvTRAwnqPPuz3uR+naB
   /PY+ocyHUORl/+PuoRhVYn9o8YWSbi3u8W6DAn4yWLf/conVI3iVv+Ogr
   zDTHymM/gi04eUusMWeZE52jKs8fsjQIgKGDLOOWENSoeFLW4qBTzy8j0
   m7ryoWZfYjlPc5R0fhqoDkqNLqvnCEQvVFN/npLVutGXmrZ1LIK4l5j2/
   U+/la701fZLRpcmPf2BJTTlAOpW5wTuuSGDAO5Vm5JBu7XsbmMS6V7ic1
   HLwFj9OTsq6gnhnRlJCe5aGR70Gw+xd4hQyyH198EYKJCgsZZVSmU8YZ8
   w==;
X-CSE-ConnectionGUID: XzKkKbLtQ36ER9YjJj7D4A==
X-CSE-MsgGUID: 8Uk5TuiMQTqV3iUcerelyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="16802836"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="16802836"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 12:13:21 -0700
X-CSE-ConnectionGUID: RxGX0QqkR9SmZGD6Wj1udA==
X-CSE-MsgGUID: O6Evw4mCRj+oH7uIruKeqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="50957763"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 02 Jul 2024 12:13:20 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sOiwH-000OZA-2u;
	Tue, 02 Jul 2024 19:13:17 +0000
Date: Wed, 03 Jul 2024 03:12:31 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:kwilczynski/sysfs-static-resource-attributes] BUILD
 SUCCESS 5d8f30d2c62fd53dda82173d10e63557e23d59b7
Message-ID: <202407030329.pFiVmtEd-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git kwilczynski/sysfs-static-resource-attributes
branch HEAD: 5d8f30d2c62fd53dda82173d10e63557e23d59b7  PCI/sysfs: Limit pci_sysfs_init() late initcall compile time scope

elapsed time: 18792m

configs tested: 59
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386                                defconfig   clang-18
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   clang-19
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sparc                             allnoconfig   gcc-13.2.0
sparc                               defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
um                                allnoconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

