Return-Path: <linux-pci+bounces-35616-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B87ACB477AB
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 23:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01FC1896BCB
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 21:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC23293B73;
	Sat,  6 Sep 2025 21:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fzjKh0bS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91D32773F6;
	Sat,  6 Sep 2025 21:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757194715; cv=none; b=gqqsNsHKZsKQTQOP+KyfRw2TYA/HQUvd1heWjB9hhx635i6i0zzZBHaLnFSkvX2edPtOx4g/xEm+GHZ8q4UX8+ZY6+w237gpeu1+6xf6CljPsPMQjQBFpi300VgSxj++Qo7naSomMf/5Ni4+RyFcWlNpYFzQ/NuGFYuQTlTKlEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757194715; c=relaxed/simple;
	bh=JXEOk2QzWC9682vZw1qqeUMm3THVRhXOl6giQNpWULQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugW42B3j6XiSLs16PXgjUhTvZxtzbnZjgzj0slQqkbjxEekw4LlueUaNZV6XVTf0VxEKlRWmL+5I/CLzKBfvaRzutGwmwn9103QT8wrRlr4xB/6rOvEB+QZEtI5VkU3vUxfvLxPuVW6JIu65U2KziKO7eBE3J5TAyP6GO+BTNnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fzjKh0bS; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757194714; x=1788730714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JXEOk2QzWC9682vZw1qqeUMm3THVRhXOl6giQNpWULQ=;
  b=fzjKh0bSM13orfS6/GIJnNUVKpy92nBVVPsO2ZwPYRNsxjxlctxBQAsF
   aykjUPQRf6KrMp6Mw3o8wCdwWIjVwzc4mt8Ubel0MByaouXoxWwxKGc04
   9DlUmVd/O5gKCEPu1tFLPdALDjK8ZDSHMAxIqcEF7IkyeeYCbKm1FRWh5
   Wn3Brk5etGiUTvoHi7HJTGQySDOzPSqbcRzKMSFJihCJAqK96khk2wE36
   ALaL97jAkroGJLeTm5snI79r+4ZomISZfcBK4R+1PFeMRZ5brDeCB/c5c
   O8bnboewPZf9f7TRUlCCtgO9G/R4rlTXBxZYkZ7x8sLU06TwIWyPeKT7q
   A==;
X-CSE-ConnectionGUID: W5NwU2UtRxK/GbG6tZs7Eg==
X-CSE-MsgGUID: jj78UmwxTP2i2TK6DVmuhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="70932755"
X-IronPort-AV: E=Sophos;i="6.18,245,1751266800"; 
   d="scan'208";a="70932755"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 14:38:34 -0700
X-CSE-ConnectionGUID: 4tTalin+TdCn15mJRkFqKg==
X-CSE-MsgGUID: RkmorfaWR/aVxvOOQ20rTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,245,1751266800"; 
   d="scan'208";a="176792664"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 06 Sep 2025 14:38:28 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uv0c6-0001oR-1W;
	Sat, 06 Sep 2025 21:38:26 +0000
Date: Sun, 7 Sep 2025 05:37:52 +0800
From: kernel test robot <lkp@intel.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com, fan.ni@samsung.com,
	quic_wenbyao@quicinc.com, namcao@linutronix.de,
	mayank.rana@oss.qualcomm.com, thippeswamy.havalige@amd.com,
	quic_schintav@quicinc.com, shradha.t@samsung.com,
	inochiama@gmail.com, cassel@kernel.org, kishon@kernel.org,
	18255117159@163.com, rongqianfeng@vivo.com, jirislaby@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	s-vadapalli@ti.com
Subject: Re: [PATCH 11/11] PCI: keystone: Add support to build as a loadable
 module
Message-ID: <202509070521.fQTJ7ygm-lkp@intel.com>
References: <20250903124505.365913-12-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903124505.365913-12-s-vadapalli@ti.com>

Hi Siddharth,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.17-rc4 next-20250905]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Siddharth-Vadapalli/PCI-Export-pci_get_host_bridge_device-for-use-by-pci-keystone/20250903-204848
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250903124505.365913-12-s-vadapalli%40ti.com
patch subject: [PATCH 11/11] PCI: keystone: Add support to build as a loadable module
config: arm-defconfig (https://download.01.org/0day-ci/archive/20250907/202509070521.fQTJ7ygm-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 7fb1dc08d2f025aad5777bb779dfac1197e9ef87)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250907/202509070521.fQTJ7ygm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509070521.fQTJ7ygm-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux: section mismatch in reference: ks_pcie_host_init+0x594 (section: .text) -> hook_fault_code (section: .init.text)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

