Return-Path: <linux-pci+bounces-24889-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5309A73F02
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 20:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67CCA164D80
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 19:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3331018DB1D;
	Thu, 27 Mar 2025 19:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lvOx7jta"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667F517A31E;
	Thu, 27 Mar 2025 19:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743104806; cv=none; b=MfA7KTFV2qKF6nB5Qy/w+A+vJj3Syf1HiRS1/t5ElbFRQAxuk0i2X6WV0GtchkRpaa5169UemcWosPtxdC+6M+CvS4QHyA9eAHl8I8Dw8fhije9B+gt5mhNxbs1inM1/Y9Qhs56hHzy51VKTJfY4RDYPkCzH5vrd+/3uHxX5xnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743104806; c=relaxed/simple;
	bh=Y3DAXrhmJS11+/k3WUxtxug3NzcqkCqgUAGcywHAEbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qurE7swgTX5W2U9/jSXp2NzyXOxukAWOS05jLpfdTIfe6Yg/1xM2K3MLdx0HQ2VNn0zn4JtCGo81UwM0c23CbuxsnmPAGR+9jPzz00OsnuPePfgMndPDHsWfBUWJzQtQQynNqxD5PLXVroPLUeuzuBiXx0ZXJG3Pgg+LG0UECrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lvOx7jta; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743104805; x=1774640805;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y3DAXrhmJS11+/k3WUxtxug3NzcqkCqgUAGcywHAEbc=;
  b=lvOx7jtasAKd+kFONeEtsaVqZ8zT0MOOaBs+5PfMVO55C/JvKMtxF/Pa
   mu9zVMt8DnpvPqKH3vHckIc7V8zFmTAXQhMtAP4YD+/PGJsJsgQaG3bYQ
   LOeJfI/Fsg14734Ow1fLIGrSmJ8/N6BmANlENTs0dnVzm6Rev+yZnqUCw
   /gEfYeu+k5cCFTDBMUKL4hcnW0Bw32SY2DjrKyCp4NJicZtmy+zfRtY6t
   cBhfr23DorADNeR6UxpM2SV38O3IOg+wL0iv8eoNN63FyHEhfuPWQchbM
   +LZvzi/hHcd/6ig1f3EuUBfDO11oBdohXm5BJflsLgVyhqz8dxjK7qEcv
   w==;
X-CSE-ConnectionGUID: ZC1UtURyQYyn9VaG59zI0A==
X-CSE-MsgGUID: Xf+zV45GTQOmnhH/ROGRfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="48332303"
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; 
   d="scan'208";a="48332303"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 12:46:44 -0700
X-CSE-ConnectionGUID: iqj17n/BTsiKpIQ0ERJWgg==
X-CSE-MsgGUID: Mun+C5s7R3Wvr023f0NxkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; 
   d="scan'208";a="124998469"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 27 Mar 2025 12:46:38 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1txtBU-0006vT-0p;
	Thu, 27 Mar 2025 19:46:36 +0000
Date: Fri, 28 Mar 2025 03:46:34 +0800
From: kernel test robot <lkp@intel.com>
To: Terry Bowman <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, mahesh@linux.ibm.com, ira.weiny@intel.com,
	oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
	nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com,
	lukas@wunner.de, ming.li@zohomail.com,
	PradeepVineshReddy.Kodamati@amd.com
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v8 13/16] cxl/pci: Assign CXL Endpoint protocol error
 handlers
Message-ID: <202503280346.euKvcovE-lkp@intel.com>
References: <20250327014717.2988633-14-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327014717.2988633-14-terry.bowman@amd.com>

Hi Terry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on aae0594a7053c60b82621136257c8b648c67b512]

url:    https://github.com/intel-lab-lkp/linux/commits/Terry-Bowman/PCI-CXL-Introduce-PCIe-helper-function-pcie_is_cxl/20250327-095738
base:   aae0594a7053c60b82621136257c8b648c67b512
patch link:    https://lore.kernel.org/r/20250327014717.2988633-14-terry.bowman%40amd.com
patch subject: [PATCH v8 13/16] cxl/pci: Assign CXL Endpoint protocol error handlers
config: csky-randconfig-r122-20250327 (https://download.01.org/0day-ci/archive/20250328/202503280346.euKvcovE-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.4.0
reproduce: (https://download.01.org/0day-ci/archive/20250328/202503280346.euKvcovE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503280346.euKvcovE-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/cxl/port.c:68:33: sparse: sparse: symbol 'cxl_ep_error_handlers' was not declared. Should it be static?

vim +/cxl_ep_error_handlers +68 drivers/cxl/port.c

    67	
  > 68	const struct cxl_error_handlers cxl_ep_error_handlers = {
    69		.error_detected = cxl_error_detected,
    70		.cor_error_detected = cxl_cor_error_detected,
    71	};
    72	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

