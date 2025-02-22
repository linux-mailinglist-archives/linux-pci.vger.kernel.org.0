Return-Path: <linux-pci+bounces-22093-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEF6A408B1
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 14:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E558719C4E2C
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 13:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04BE209695;
	Sat, 22 Feb 2025 13:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DvsS3rbS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E477513BC0E
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 13:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740230953; cv=none; b=VAIVNjRY2I4gsyV8++93sWD+og80oqBNio0Wem57dmqBCV7iAGD7sCSMN2ePG/mhGwL3fBjSffAw1T0nSCs4MWI2XVhnJfXfZAXbcFUKz4Tcsmaq6A/ZQ9EhQcYDp6u8Z+L6EqkElzuUFfgMOB978dFKPJNh/FTciymDJepRT2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740230953; c=relaxed/simple;
	bh=LSfg9W6JdQW3f7E6QbUJNGj+3VQlFtVVlyJNcLmBheA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=QBwM06CRj0eWXRk5+X+gDKYllwOH1anvTwc1AzxqDbfrho9K8smXFBRCXXH2fdNW2BpMVTOfNltCJlaOtKdi6h2TSq9AvUoa86RuKvAQhev0ZotFS1oUwDAtW32gS5NdODGNt3EPJdKOMPi5qxUyYjlcM3usbzbWYIJty12/pak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DvsS3rbS; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740230952; x=1771766952;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LSfg9W6JdQW3f7E6QbUJNGj+3VQlFtVVlyJNcLmBheA=;
  b=DvsS3rbSBR8Pc8ss8iNif8eZaGTwWVYUCFu+v02f4sESP9I9ivAzhLxE
   q3cvHPLUp+kTvIBPSE2hB1RlHvgOfWGNCZYRCiUxTCsepbHyKLfJQ71eN
   nFX8NQjgrLu6huuE2DE3s77RXt8xvzejy36RTQXhfOZYvsNu2r1BO7ksS
   +0r0xT6ZIEF1rDxNfdwlPSsMiQ7oDN6g2OiQ1fYRaz1D4kpu41Vbn71uz
   E7CU04C1ZYXbVLkdsHlb9B5ZZ1hnlTU6/i/fdxDX0bj9/vQZ00yH061ZF
   /oVtcWEAB2TiCZzCYmjsfr+GE5KRDhZXTKedITx1rDKlEWk/dGYiFKvU8
   Q==;
X-CSE-ConnectionGUID: kqU0o1gvShCKF4GP2jHnOA==
X-CSE-MsgGUID: A8TguMNIRG+CRxRqSf+BqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11353"; a="44949337"
X-IronPort-AV: E=Sophos;i="6.13,308,1732608000"; 
   d="scan'208";a="44949337"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2025 05:29:11 -0800
X-CSE-ConnectionGUID: DlA/lKSrSMuQMHmPkHtpWA==
X-CSE-MsgGUID: 9OXpVSEoQcCFrxkqt1OGwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,308,1732608000"; 
   d="scan'208";a="115581385"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 22 Feb 2025 05:29:10 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlpZ5-0006bM-1v;
	Sat, 22 Feb 2025 13:29:07 +0000
Date: Sat, 22 Feb 2025 21:29:01 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 ab42d46fc60486acadb6acd1ccfbace98b25167d
Message-ID: <202502222155.Hsx0dGHA-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: ab42d46fc60486acadb6acd1ccfbace98b25167d  PCI: endpoint: pci-epf-test: Fix double free that causes kernel to oops

elapsed time: 1447m

configs tested: 62
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                  randconfig-001-20250222    gcc-13.2.0
arc                  randconfig-002-20250222    gcc-13.2.0
arm                  randconfig-001-20250222    gcc-14.2.0
arm                  randconfig-002-20250222    gcc-14.2.0
arm                  randconfig-003-20250222    clang-16
arm                  randconfig-004-20250222    gcc-14.2.0
arm64                randconfig-001-20250222    gcc-14.2.0
arm64                randconfig-002-20250222    clang-21
arm64                randconfig-003-20250222    clang-18
arm64                randconfig-004-20250222    clang-21
csky                 randconfig-001-20250222    gcc-14.2.0
csky                 randconfig-002-20250222    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250222    clang-17
hexagon              randconfig-002-20250222    clang-19
i386       buildonly-randconfig-001-20250222    clang-19
i386       buildonly-randconfig-002-20250222    gcc-12
i386       buildonly-randconfig-003-20250222    gcc-12
i386       buildonly-randconfig-004-20250222    clang-19
i386       buildonly-randconfig-005-20250222    gcc-12
i386       buildonly-randconfig-006-20250222    clang-19
loongarch            randconfig-001-20250222    gcc-14.2.0
loongarch            randconfig-002-20250222    gcc-14.2.0
nios2                randconfig-001-20250222    gcc-14.2.0
nios2                randconfig-002-20250222    gcc-14.2.0
parisc               randconfig-001-20250222    gcc-14.2.0
parisc               randconfig-002-20250222    gcc-14.2.0
powerpc              randconfig-001-20250222    gcc-14.2.0
powerpc              randconfig-002-20250222    gcc-14.2.0
powerpc              randconfig-003-20250222    gcc-14.2.0
powerpc64            randconfig-001-20250222    gcc-14.2.0
powerpc64            randconfig-002-20250222    clang-16
powerpc64            randconfig-003-20250222    clang-18
riscv                randconfig-001-20250222    clang-21
riscv                randconfig-002-20250222    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250222    gcc-14.2.0
s390                 randconfig-002-20250222    clang-15
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250222    gcc-14.2.0
sh                   randconfig-002-20250222    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250222    gcc-14.2.0
sparc                randconfig-002-20250222    gcc-14.2.0
sparc64              randconfig-001-20250222    gcc-14.2.0
sparc64              randconfig-002-20250222    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250222    gcc-12
um                   randconfig-002-20250222    gcc-12
x86_64     buildonly-randconfig-001-20250222    clang-19
x86_64     buildonly-randconfig-002-20250222    gcc-12
x86_64     buildonly-randconfig-003-20250222    gcc-12
x86_64     buildonly-randconfig-004-20250222    clang-19
x86_64     buildonly-randconfig-005-20250222    clang-19
x86_64     buildonly-randconfig-006-20250222    gcc-12
xtensa               randconfig-001-20250222    gcc-14.2.0
xtensa               randconfig-002-20250222    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

