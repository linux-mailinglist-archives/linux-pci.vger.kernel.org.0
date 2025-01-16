Return-Path: <linux-pci+bounces-19944-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F05A132D8
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 06:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A78211881AF7
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 05:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A64418DF62;
	Thu, 16 Jan 2025 05:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnakeHV6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D980215886C
	for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 05:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737006916; cv=none; b=GYKXb1/UZ5wZoYjh+uST0hhr3MU3rxxO9cEKP3HhJFmx2SyuFrQwrk4QWQzpyD35MSAXTWlyWff1dYx0cRzUXXbyVzGWiLIhfhqffjZEsg3K2q/x8CDaFvVt7j/X+UkHuNYnWSMmbRPRmJzLOp0+kk5VuJf0rzDjorKB1ZLXjmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737006916; c=relaxed/simple;
	bh=dHSCQh2hpv7uTp+4wlZs5fCctZWZTZ1ZqOWdbFjmwCA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=KkwDvncWa3aLlZ0UiHpLYsq7xO/GQeHQg1xqMkuidCUw4Fk0Afp0jszLCrELUZEMNtIVROaN0brTLrjxz2qNLQvu6+8H0+9UwVu6oHhuAxyLv6dcFHlXiR/8ruywc3kAAP3Cx0Sx4ZL0bai8d2DEnLFV1Tfh3KNsBJHd9d11PqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dnakeHV6; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737006915; x=1768542915;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dHSCQh2hpv7uTp+4wlZs5fCctZWZTZ1ZqOWdbFjmwCA=;
  b=dnakeHV6Ok/LiY57BHTJeyrVq4DZ6XedlcnMyQFoiwJZp052u0qb9r9h
   Opn7rL1zVHpQUgjFQuYG/KiQF86Ehj3AbzmG0PlvMi2rMTvlWThW9hOyY
   v0gLukFOCFCXQnuErsPDzGDn47Qa8DLea55g5GfodgJXsakim5h/34QoG
   quDbmhKej0xyYz14QpuKLlglfnMgtJVq45FefSh0N03wVFDGFH/3U/Y1g
   ANaCBzLcGBTVEU0n0UbHkmz+KvgUO9EDaY7XinwaW/jj3db2F1Wdzzf8Z
   62WbYyLbBz1egPLr29CrrQTK7Y1FoV4AsYl9r6lwLcLGl6IgDPTBLNZQY
   g==;
X-CSE-ConnectionGUID: gz0PQhfWTT2tMDlEPHSLRA==
X-CSE-MsgGUID: owd4nZWtREKu4BSdAmxNdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="37256233"
X-IronPort-AV: E=Sophos;i="6.13,208,1732608000"; 
   d="scan'208";a="37256233"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 21:55:14 -0800
X-CSE-ConnectionGUID: s9hP6bYiSsKlnOp2H/TDmA==
X-CSE-MsgGUID: 0/jrmtBNR++0ESCWTlfuCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109409167"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 15 Jan 2025 21:55:12 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYIqU-000RSp-1A;
	Thu, 16 Jan 2025 05:55:10 +0000
Date: Thu, 16 Jan 2025 13:54:30 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:pci-fixup] BUILD SUCCESS
 b1049f2d68693c80a576c4578d96774a68df2bad
Message-ID: <202501161324.INhLkLd1-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pci-fixup
branch HEAD: b1049f2d68693c80a576c4578d96774a68df2bad  PCI: Avoid putting some root ports into D3 on TUXEDO Sirius Gen1

elapsed time: 1451m

configs tested: 26
configs skipped: 222

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386    buildonly-randconfig-001-20250115    clang-19
i386    buildonly-randconfig-001-20250116    clang-19
i386    buildonly-randconfig-002-20250115    gcc-12
i386    buildonly-randconfig-002-20250116    clang-19
i386    buildonly-randconfig-003-20250115    gcc-12
i386    buildonly-randconfig-003-20250116    clang-19
i386    buildonly-randconfig-004-20250115    gcc-12
i386    buildonly-randconfig-004-20250116    clang-19
i386    buildonly-randconfig-005-20250115    gcc-12
i386    buildonly-randconfig-005-20250116    clang-19
i386    buildonly-randconfig-006-20250115    gcc-12
i386    buildonly-randconfig-006-20250116    clang-19
x86_64                        allnoconfig    clang-19
x86_64  buildonly-randconfig-001-20250115    gcc-12
x86_64  buildonly-randconfig-001-20250116    gcc-12
x86_64  buildonly-randconfig-002-20250115    gcc-12
x86_64  buildonly-randconfig-002-20250116    gcc-12
x86_64  buildonly-randconfig-003-20250115    clang-19
x86_64  buildonly-randconfig-003-20250116    gcc-12
x86_64  buildonly-randconfig-004-20250115    clang-19
x86_64  buildonly-randconfig-004-20250116    clang-19
x86_64  buildonly-randconfig-005-20250115    gcc-12
x86_64  buildonly-randconfig-005-20250116    clang-19
x86_64  buildonly-randconfig-006-20250115    clang-19
x86_64  buildonly-randconfig-006-20250116    clang-19
x86_64                          defconfig    gcc-11

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

