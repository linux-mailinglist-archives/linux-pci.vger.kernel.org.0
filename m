Return-Path: <linux-pci+bounces-15788-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A67719B8C82
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 09:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E101F2102C
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 08:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B7314A0BC;
	Fri,  1 Nov 2024 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SO77KawE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DE117C91
	for <linux-pci@vger.kernel.org>; Fri,  1 Nov 2024 08:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730448021; cv=none; b=XSFi3L4hUScGKp18hOccXj/hPJVRGVpjlhOTlAIkMYei7mB+Ir4e7KO6skPgd7LbbzPxWPJRpKfnia5nwCNZdpOs6+GOXmGgXlWuFgRwQDSrUQWP8OBn1glFCayyg1b1BRCeJprtcX52UrMKlnudxur86zE1PBEd3c0Rfwd2siE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730448021; c=relaxed/simple;
	bh=02bIlxxuN15TFQ7abCdzoIqoCgVzJPkdVgwcUDC1iLI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hIIk6sB1Aj5+1qa4q+7qs+xeggCO9OKqF0W047gUIszChR7hnm/1NsxYJAqWV65znQ/t726yWoF85KWd6aScouGvyjAeAbE4SWdCWzK6X9QRWhZpx6L/vSHn3cvU51vLrWGYenDPeejTIPQ5W7xtnEqdA7yIyZGTrM08Kj7ER9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SO77KawE; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730448019; x=1761984019;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=02bIlxxuN15TFQ7abCdzoIqoCgVzJPkdVgwcUDC1iLI=;
  b=SO77KawE0/WI2hDBYOehlCBc/hXMgXIvBSf69lOnpBFCRZK5XEQSLOLi
   0A5Qd0ygOKilYd2pFAXAe73Q3vHmdfIehBeMz4JQ7kMS729P//0ExtXa9
   ghqWBNDg9lKcJ1auxEg1Y280weg49wd8zBRhwf7PsEcmMTwf8zLDzoiZU
   4i4Ullq3GRDiKO7FExKWx0056dRcQ5nN3nxfMRDSm9KW+bqSWddPjcbPI
   hGUwxO1+ilNdRqdRyKmuM0rIi9x+G7h7QCcZORNf431lDfROj98Rmufsq
   fN0PW8OUXXEYYKJ5b59q6w5MifGeXGegYjixfgGnTt2wmI59e0BeKQ7C+
   Q==;
X-CSE-ConnectionGUID: r/tpiIOBRh6al0lBR8Xj/Q==
X-CSE-MsgGUID: ZNdw8hJkR7uzKf/1v+ooxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="55613314"
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="55613314"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 01:00:18 -0700
X-CSE-ConnectionGUID: Q83mksbiRZSbBlIACKkUVg==
X-CSE-MsgGUID: GQeE/Wa0QwKXmMBaWpnTww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="106227995"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 01 Nov 2024 01:00:17 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6mZp-000hIH-33;
	Fri, 01 Nov 2024 08:00:13 +0000
Date: Fri, 01 Nov 2024 15:59:17 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/imx6] BUILD SUCCESS
 49a8f8a8419417b95386c43402d2e8f24ec84b50
Message-ID: <202411011503.VHVl7DwC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/imx6
branch HEAD: 49a8f8a8419417b95386c43402d2e8f24ec84b50  PCI: imx6: Fix suspend/resume support on i.MX6QDL

elapsed time: 867m

configs tested: 172
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                   randconfig-001-20241101    gcc-14.1.0
arc                   randconfig-002-20241101    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                          ixp4xx_defconfig    gcc-14.1.0
arm                          moxart_defconfig    gcc-14.1.0
arm                       netwinder_defconfig    gcc-14.1.0
arm                           omap1_defconfig    gcc-14.1.0
arm                          pxa3xx_defconfig    gcc-14.1.0
arm                   randconfig-001-20241101    gcc-14.1.0
arm                   randconfig-002-20241101    gcc-14.1.0
arm                   randconfig-003-20241101    gcc-14.1.0
arm                   randconfig-004-20241101    gcc-14.1.0
arm                        spear6xx_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241101    gcc-14.1.0
arm64                 randconfig-002-20241101    gcc-14.1.0
arm64                 randconfig-003-20241101    gcc-14.1.0
arm64                 randconfig-004-20241101    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241101    gcc-14.1.0
csky                  randconfig-002-20241101    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241101    gcc-14.1.0
hexagon               randconfig-002-20241101    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241101    gcc-12
i386        buildonly-randconfig-002-20241101    gcc-12
i386        buildonly-randconfig-003-20241101    gcc-12
i386        buildonly-randconfig-004-20241101    gcc-12
i386        buildonly-randconfig-005-20241101    gcc-12
i386        buildonly-randconfig-006-20241101    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241101    gcc-12
i386                  randconfig-002-20241101    gcc-12
i386                  randconfig-003-20241101    gcc-12
i386                  randconfig-004-20241101    gcc-12
i386                  randconfig-005-20241101    gcc-12
i386                  randconfig-006-20241101    gcc-12
i386                  randconfig-011-20241101    gcc-12
i386                  randconfig-012-20241101    gcc-12
i386                  randconfig-013-20241101    gcc-12
i386                  randconfig-014-20241101    gcc-12
i386                  randconfig-015-20241101    gcc-12
i386                  randconfig-016-20241101    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241101    gcc-14.1.0
loongarch             randconfig-002-20241101    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                          sun3x_defconfig    gcc-14.1.0
m68k                           virt_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                           gcw0_defconfig    gcc-14.1.0
mips                           ip28_defconfig    gcc-14.1.0
mips                        maltaup_defconfig    gcc-14.1.0
mips                         rt305x_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241101    gcc-14.1.0
nios2                 randconfig-002-20241101    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241101    gcc-14.1.0
parisc                randconfig-002-20241101    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                   motionpro_defconfig    gcc-14.1.0
powerpc                 mpc8315_rdb_defconfig    gcc-14.1.0
powerpc               randconfig-001-20241101    gcc-14.1.0
powerpc               randconfig-002-20241101    gcc-14.1.0
powerpc               randconfig-003-20241101    gcc-14.1.0
powerpc64             randconfig-001-20241101    gcc-14.1.0
powerpc64             randconfig-002-20241101    gcc-14.1.0
powerpc64             randconfig-003-20241101    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241101    gcc-14.1.0
riscv                 randconfig-002-20241101    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241101    gcc-14.1.0
s390                  randconfig-002-20241101    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20241101    gcc-14.1.0
sh                    randconfig-002-20241101    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                          alldefconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241101    gcc-14.1.0
sparc64               randconfig-002-20241101    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241101    gcc-14.1.0
um                    randconfig-002-20241101    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241101    gcc-12
x86_64      buildonly-randconfig-002-20241101    gcc-12
x86_64      buildonly-randconfig-003-20241101    gcc-12
x86_64      buildonly-randconfig-004-20241101    gcc-12
x86_64      buildonly-randconfig-005-20241101    gcc-12
x86_64      buildonly-randconfig-006-20241101    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241101    gcc-12
x86_64                randconfig-002-20241101    gcc-12
x86_64                randconfig-003-20241101    gcc-12
x86_64                randconfig-004-20241101    gcc-12
x86_64                randconfig-005-20241101    gcc-12
x86_64                randconfig-006-20241101    gcc-12
x86_64                randconfig-011-20241101    gcc-12
x86_64                randconfig-012-20241101    gcc-12
x86_64                randconfig-013-20241101    gcc-12
x86_64                randconfig-014-20241101    gcc-12
x86_64                randconfig-015-20241101    gcc-12
x86_64                randconfig-016-20241101    gcc-12
x86_64                randconfig-071-20241101    gcc-12
x86_64                randconfig-072-20241101    gcc-12
x86_64                randconfig-073-20241101    gcc-12
x86_64                randconfig-074-20241101    gcc-12
x86_64                randconfig-075-20241101    gcc-12
x86_64                randconfig-076-20241101    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  audio_kc705_defconfig    gcc-14.1.0
xtensa                randconfig-001-20241101    gcc-14.1.0
xtensa                randconfig-002-20241101    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

