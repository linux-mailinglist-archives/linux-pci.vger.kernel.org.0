Return-Path: <linux-pci+bounces-16744-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7178F9C86B6
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 11:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A031F2677E
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 10:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F011F80D2;
	Thu, 14 Nov 2024 09:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gm5s3ET5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8541F9A9C
	for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 09:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578306; cv=none; b=pIrDwCMHu6dEh69xRgoI8RrgPCfXwPgdpOs3rI6F2/113zC4ToruhWhwqTlesNLAql5lyrLQZyew1QLYzGA9H4E99yonnYSs915Pw6HT6E30qKzuh4pB7pRHtHr3S+WPWDlLkthEcBGis0v2vLjUII1vlSUzgGIhkZOfCFHi06Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578306; c=relaxed/simple;
	bh=tCVnYsIIZR7l4VFVE+Qz252sKOstPxTiQVpoYs4ryB4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ToKswaZTeF7fwQ5TzUhi2hDpJyuv2lVOMLtXtNhW4oVY4aWZiyMyRqYCXH4OW54rWFstLeBoJwgw3caL99UOHssBAmYGVGL3oIKNlSq+u8j0JB3xaI36igNxbEGnkRcOYPxKKxPfuoZ+Jjjqqya7v4yB67k9+0YEdByb2IigS1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gm5s3ET5; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731578305; x=1763114305;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tCVnYsIIZR7l4VFVE+Qz252sKOstPxTiQVpoYs4ryB4=;
  b=gm5s3ET5JfclySQQrj0xtOOmX7nKYq0HxlihZmak/IkUSRjCQHEEaO85
   KbFF0vjQgKr3zJFtJtrKc5IlaHDruOB1IX0GkKabnfEfsgL3F22b0it0S
   vPdwFwmZ0IjML+QxsMbo20QjB8I7KHvmDP+C+HhcZeUfvIAmesQcCxNs8
   TIJNUbfxkf74mhPkTLLIovdmyryWcmCAix0YRVVouZXq5CLZR2RNbeOVq
   OWkjqBJdiq3CERUDg/RwYt/2LS+Sx6W268JUsi4wNL3txS2I6CXLRAlu9
   rcfa1YUyjoLpZhignVqkJ7a9aBZvWD3Gzg+GqiswTY0xfAF/HWeBS/Xhh
   Q==;
X-CSE-ConnectionGUID: XgbW49ciRMm13GRE2zWApQ==
X-CSE-MsgGUID: D+g4ekqHRAmVty0fRREOjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="42932051"
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="42932051"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 01:58:20 -0800
X-CSE-ConnectionGUID: GKqjp9VWQLa5FX2qbukv8A==
X-CSE-MsgGUID: xOSPV8NfS06xiQo9xGtMsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="88325700"
Received: from lkp-server01.sh.intel.com (HELO cf353f978a24) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 14 Nov 2024 01:58:20 -0800
Received: from kbuild by cf353f978a24 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBWcC-00002f-3D;
	Thu, 14 Nov 2024 09:58:17 +0000
Date: Thu, 14 Nov 2024 17:57:46 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/rockchip] BUILD REGRESSION
 337657a3c24c92befb3ed11d6f15402faa09f7dd
Message-ID: <202411141736.yebi5oLP-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rockchip
branch HEAD: 337657a3c24c92befb3ed11d6f15402faa09f7dd  PCI: rockchip-ep: Handle PERST# signal in endpoint mode

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202411141106.4hI5VqIa-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202411141621.uwFAKZb2-lkp@intel.com

    drivers/pci/controller/pcie-rockchip-ep.c:486:10: error: 'const struct pci_epc_ops' has no member named 'align_addr'
    drivers/pci/controller/pcie-rockchip-ep.c:486:27: error: initialization of 'int (*)(struct pci_epc *, u8,  u8,  phys_addr_t,  u64,  size_t)' {aka 'int (*)(struct pci_epc *, unsigned char,  unsigned char,  long long unsigned int,  long long unsigned int,  long unsigned int)'} from incompatible pointer type 'u64 (*)(struct pci_epc *, u64,  size_t *, size_t *)' {aka 'long long unsigned int (*)(struct pci_epc *, long long unsigned int,  long unsigned int *, long unsigned int *)'} [-Wincompatible-pointer-types]
    drivers/pci/controller/pcie-rockchip-ep.c:486:27: error: initialization of 'int (*)(struct pci_epc *, u8,  u8,  phys_addr_t,  u64,  size_t)' {aka 'int (*)(struct pci_epc *, unsigned char,  unsigned char,  unsigned int,  long long unsigned int,  unsigned int)'} from incompatible pointer type 'u64 (*)(struct pci_epc *, u64,  size_t *, size_t *)' {aka 'long long unsigned int (*)(struct pci_epc *, long long unsigned int,  unsigned int *, unsigned int *)'} [-Wincompatible-pointer-types]
    drivers/pci/controller/pcie-rockchip-ep.c:640:9: error: implicit declaration of function 'irq_set_irq_type'; did you mean 'irq_set_irq_wake'? [-Wimplicit-function-declaration]
    drivers/pci/controller/pcie-rockchip-ep.c:672:45: error: 'IRQ_NOAUTOEN' undeclared (first use in this function); did you mean 'IRQF_NO_AUTOEN'?
    drivers/pci/controller/pcie-rockchip-ep.c:672:9: error: implicit declaration of function 'irq_set_status_flags' [-Wimplicit-function-declaration]

Error/Warning ids grouped by kconfigs:

recent_errors
|-- openrisc-allyesconfig
|   |-- drivers-pci-controller-pcie-rockchip-ep.c:error:const-struct-pci_epc_ops-has-no-member-named-align_addr
|   `-- drivers-pci-controller-pcie-rockchip-ep.c:error:initialization-of-int-(-)(struct-pci_epc-u8-u8-phys_addr_t-u64-size_t)-aka-int-(-)(struct-pci_epc-unsigned-char-unsigned-char-unsigned-int-long-long-uns
|-- parisc-allmodconfig
|   `-- drivers-pci-controller-pcie-rockchip-ep.c:error:const-struct-pci_epc_ops-has-no-member-named-align_addr
|-- parisc-allyesconfig
|   `-- drivers-pci-controller-pcie-rockchip-ep.c:error:const-struct-pci_epc_ops-has-no-member-named-align_addr
`-- sparc-allmodconfig
    |-- drivers-pci-controller-pcie-rockchip-ep.c:error:IRQ_NOAUTOEN-undeclared-(first-use-in-this-function)
    |-- drivers-pci-controller-pcie-rockchip-ep.c:error:const-struct-pci_epc_ops-has-no-member-named-align_addr
    |-- drivers-pci-controller-pcie-rockchip-ep.c:error:implicit-declaration-of-function-irq_set_irq_type
    |-- drivers-pci-controller-pcie-rockchip-ep.c:error:implicit-declaration-of-function-irq_set_status_flags
    `-- drivers-pci-controller-pcie-rockchip-ep.c:error:initialization-of-int-(-)(struct-pci_epc-u8-u8-phys_addr_t-u64-size_t)-aka-int-(-)(struct-pci_epc-unsigned-char-unsigned-char-long-long-unsigned-int-lon

elapsed time: 738m

configs tested: 65
configs skipped: 1

tested configs:
alpha                   allnoconfig    gcc-14.2.0
alpha                  allyesconfig    gcc-14.2.0
arc                    allmodconfig    gcc-13.2.0
arc                     allnoconfig    gcc-13.2.0
arc                    allyesconfig    gcc-13.2.0
arc         randconfig-001-20241114    gcc-13.2.0
arc         randconfig-002-20241114    gcc-13.2.0
arm                    allmodconfig    gcc-14.2.0
arm                     allnoconfig    clang-20
arm                    allyesconfig    gcc-14.2.0
arm         randconfig-001-20241114    gcc-14.2.0
arm         randconfig-002-20241114    gcc-14.2.0
arm         randconfig-003-20241114    gcc-14.2.0
arm         randconfig-004-20241114    clang-14
arm64                  allmodconfig    clang-20
arm64                   allnoconfig    gcc-14.2.0
arm64       randconfig-001-20241114    clang-20
arm64       randconfig-002-20241114    gcc-14.2.0
arm64       randconfig-003-20241114    gcc-14.2.0
arm64       randconfig-004-20241114    gcc-14.2.0
csky                    allnoconfig    gcc-14.2.0
hexagon                allmodconfig    clang-20
hexagon                 allnoconfig    clang-20
hexagon                allyesconfig    clang-20
i386                   allmodconfig    gcc-12
i386                    allnoconfig    gcc-12
i386                   allyesconfig    gcc-12
i386                      defconfig    clang-19
loongarch              allmodconfig    gcc-14.2.0
loongarch               allnoconfig    gcc-14.2.0
m68k                   allmodconfig    gcc-14.2.0
m68k                    allnoconfig    gcc-14.2.0
m68k                   allyesconfig    gcc-14.2.0
microblaze             allmodconfig    gcc-14.2.0
microblaze              allnoconfig    gcc-14.2.0
microblaze             allyesconfig    gcc-14.2.0
mips                    allnoconfig    gcc-14.2.0
nios2                   allnoconfig    gcc-14.2.0
openrisc                allnoconfig    gcc-14.2.0
openrisc               allyesconfig    gcc-14.2.0
parisc                 allmodconfig    gcc-14.2.0
parisc                  allnoconfig    gcc-14.2.0
parisc                 allyesconfig    gcc-14.2.0
powerpc                allmodconfig    gcc-14.2.0
powerpc                 allnoconfig    gcc-14.2.0
powerpc                allyesconfig    clang-20
riscv                  allmodconfig    clang-20
riscv                   allnoconfig    gcc-14.2.0
riscv                  allyesconfig    clang-20
s390                   allmodconfig    clang-20
s390                    allnoconfig    clang-20
s390                   allyesconfig    gcc-14.2.0
sh                     allmodconfig    gcc-14.2.0
sh                      allnoconfig    gcc-14.2.0
sh                     allyesconfig    gcc-14.2.0
sparc                  allmodconfig    gcc-14.2.0
um                     allmodconfig    clang-20
um                      allnoconfig    clang-17
um                     allyesconfig    gcc-12
x86_64                  allnoconfig    clang-19
x86_64                 allyesconfig    clang-19
x86_64                    defconfig    gcc-11
x86_64                        kexec    clang-19
x86_64                     rhel-8.3    gcc-12
xtensa                  allnoconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

