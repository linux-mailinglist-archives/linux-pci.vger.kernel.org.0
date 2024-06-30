Return-Path: <linux-pci+bounces-9489-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC56591D4AD
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 00:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35D11C20510
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 22:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FD1433DC;
	Sun, 30 Jun 2024 22:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KF7GLMRZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FA68F72
	for <linux-pci@vger.kernel.org>; Sun, 30 Jun 2024 22:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719787955; cv=none; b=Axk2TXSVPrqi9Ilfju8Bf91GgmiIJGhBpi3FWaSxlNT9y3W6nxgx2o8xlK1UcYQak7JZLiQa8hf7GU+c0LiDC8ohDOHxqrrjhIV+OiDClaStSSQDNlApZQ2PR+PGanEaOI/4lnvteLSaUoVc1piu44y8t/ggIF/t8v9PVXDVYD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719787955; c=relaxed/simple;
	bh=fSv5yvBKRiRUF2YYxQnNPD3zSgwXLOoNsoKOQxzXQGw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jLdXc6VfeQQbMR6iXM+Qp6CuzAnPtfFrgaj4Mf+P+UlUPr6QWcd/vqWjwzYNGQthgUZVoA71aupuVdbZSmfzSzVxZStkbs5pJIEKs1AK/YFG9g3GWkKQ+IYC2YZeKUnWrD7GxzUi0GVPhllfuSByB3ndtjxTTkWn9m5FYmPvkMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KF7GLMRZ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719787954; x=1751323954;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fSv5yvBKRiRUF2YYxQnNPD3zSgwXLOoNsoKOQxzXQGw=;
  b=KF7GLMRZYVwCVTLS0ywXHQsBziG7x0kriUQDiFWTPeKGyNrNnJMv3QRc
   qD/b0J9RTo5t5RkK5uMFiKxU5j1JAux/m7+X6oSP+qyOdYJ+bshx1dVea
   z+re675jv7j/lS1vpKgvhpQF83qX0mqGjGg11n7znvv9AOPXhzktAtynb
   g00nZqIOqLcsEpRGKeZgEq5gPpsu1OYnnhgXaeqptglMy99HxRYA+STCt
   5couYyqSj7X2su/u33he/lATlhL7DxprevCgqGDB+0Inf7l1937NQJvTK
   8/GbzZanrF27cLfAPGpA2dXgpx2dNQsqZMs/vEHr1Vs/JofcHgCgl38DF
   A==;
X-CSE-ConnectionGUID: DWadC3VJREC+HNOuvE2ELQ==
X-CSE-MsgGUID: XfYFGql+SfSHhdK9xzlaNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="19793265"
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="19793265"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2024 15:52:33 -0700
X-CSE-ConnectionGUID: xyjiCVj7TZSzHhfflpYg2w==
X-CSE-MsgGUID: G05MJpPbTh++U+yN5bjR8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="50207087"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 30 Jun 2024 15:52:32 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sO3PK-000M6q-0O;
	Sun, 30 Jun 2024 22:52:30 +0000
Date: Mon, 01 Jul 2024 06:51:57 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:dt-bindings] BUILD SUCCESS
 1b029ce3b0b5643b3303cf4d4a3328c7c3b3bef6
Message-ID: <202407010655.BVzQrjZC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git dt-bindings
branch HEAD: 1b029ce3b0b5643b3303cf4d4a3328c7c3b3bef6  dt-bindings: pci: qcom: Add OPP table

elapsed time: 2967m

configs tested: 65
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                   randconfig-001-20240701   gcc-13.2.0
arc                   randconfig-002-20240701   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                   randconfig-001-20240701   gcc-13.2.0
arm                   randconfig-002-20240701   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
hexagon                           allnoconfig   clang-19
i386         buildonly-randconfig-001-20240629   gcc-7
i386         buildonly-randconfig-001-20240630   clang-18
i386         buildonly-randconfig-002-20240629   gcc-7
i386         buildonly-randconfig-002-20240630   clang-18
i386         buildonly-randconfig-003-20240629   gcc-7
i386         buildonly-randconfig-003-20240630   clang-18
i386         buildonly-randconfig-004-20240629   gcc-7
i386         buildonly-randconfig-004-20240630   clang-18
i386         buildonly-randconfig-005-20240629   gcc-7
i386         buildonly-randconfig-005-20240630   clang-18
i386         buildonly-randconfig-006-20240629   gcc-7
i386         buildonly-randconfig-006-20240630   clang-18
i386                  randconfig-001-20240629   gcc-7
i386                  randconfig-001-20240630   clang-18
i386                  randconfig-002-20240629   gcc-7
i386                  randconfig-002-20240630   clang-18
i386                  randconfig-003-20240629   gcc-7
i386                  randconfig-003-20240630   clang-18
i386                  randconfig-004-20240629   gcc-7
i386                  randconfig-004-20240630   clang-18
i386                  randconfig-005-20240629   gcc-7
i386                  randconfig-005-20240630   clang-18
i386                  randconfig-006-20240629   gcc-7
i386                  randconfig-006-20240630   clang-18
i386                  randconfig-011-20240629   gcc-7
i386                  randconfig-011-20240630   clang-18
i386                  randconfig-012-20240629   gcc-7
i386                  randconfig-012-20240630   clang-18
i386                  randconfig-013-20240629   gcc-7
i386                  randconfig-013-20240630   clang-18
i386                  randconfig-014-20240629   gcc-7
i386                  randconfig-014-20240630   clang-18
i386                  randconfig-015-20240629   gcc-7
i386                  randconfig-015-20240630   clang-18
i386                  randconfig-016-20240629   gcc-7
i386                  randconfig-016-20240630   clang-18
loongarch                         allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
s390                              allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
um                                allnoconfig   gcc-13.2.0
x86_64       buildonly-randconfig-001-20240701   gcc-11
x86_64       buildonly-randconfig-002-20240701   gcc-13
x86_64       buildonly-randconfig-003-20240701   clang-18
x86_64       buildonly-randconfig-004-20240701   clang-18
x86_64                                  kexec   clang-18
x86_64                               rhel-8.3   clang-18
xtensa                            allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

