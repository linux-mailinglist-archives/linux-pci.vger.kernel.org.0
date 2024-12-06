Return-Path: <linux-pci+bounces-17838-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F699E6DAB
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 13:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD407167405
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 12:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833611FF7D9;
	Fri,  6 Dec 2024 12:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GJZVX+UE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929921FF604;
	Fri,  6 Dec 2024 12:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733486587; cv=none; b=Z+fU7Wrd6a4NDQnCgz6u7DkRW25Zb9welD6Ad533OHX8VdaHq6fhJbOY/bdyKmFnYHQKMckMhhkiB3tRyGWl+LVmexSM4+lfl55GX90VH7e+RIAaWBsXhMkPomr4ebkOKUdTmSNKZgqFuq/bNzpVfpVK0GlgNx4VVIg7iwlalm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733486587; c=relaxed/simple;
	bh=XY5MF/T3u8Njgl/kmkEzdTj2y+pfWzit8vqHlWWkb34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=moHQK+ObY0cXysQuQ+AxUneElbxPDKU0LHm7h52OuO7uNTPhi4NksCnXFsshsmLnNdEu1I2wijmJnXiHRHg6AlhPSunXf3RgwvWADvuxiWcGsuCIvu3PMONKsfKsKn+7AKF/KXw0XDvH5O1SSj5IaY7r8oiz/WJ0XxFiyI6b+bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GJZVX+UE; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733486586; x=1765022586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XY5MF/T3u8Njgl/kmkEzdTj2y+pfWzit8vqHlWWkb34=;
  b=GJZVX+UEM6RPcqNZO8rOjfa79G5SoUnn7+ur3hXHfifimRw9C0HeV+w2
   3Op+tP78D7ZUIYDTAisnXYmvg+X85pzxqpYf6/a0nHQZMsqKLqGSkbVju
   KqAn3npAnZ3uVz6mskPeGbTtRVHLIvv4ByY5E5eokJ3tefrugozkgsX5Q
   705Wue1C/8bf7qJOtoJx8+xdK/y3BWgSMgxZNxHlNkJf9u1MaSMXlF7Ny
   EBlVpesPy3xHzLAWDpMnQSR7cxoYF75COWh6RGIEslJj1e/POH5bPMYmP
   RehY5ODy+1Z/SyING/gKEI/AyoXO1Ts7dvELmmpTTOwJJsmb38Fkfg5SF
   A==;
X-CSE-ConnectionGUID: 2X8EBM+MTkaV7fvVd4rNLg==
X-CSE-MsgGUID: bIanWsBsTE+jL5cffzOlQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="44306660"
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="44306660"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 04:03:05 -0800
X-CSE-ConnectionGUID: /yOMjzOTTAS1/UE7SxPaEA==
X-CSE-MsgGUID: bcg0ZZ/kTV+CbItNRwQ4Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="95201509"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 06 Dec 2024 04:03:01 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJX2w-00010j-2D;
	Fri, 06 Dec 2024 12:02:58 +0000
Date: Fri, 6 Dec 2024 20:02:36 +0800
From: kernel test robot <lkp@intel.com>
To: Shradha Todi <shradha.t@samsung.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, manivannan.sadhasivam@linaro.org,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
	a.manzanares@samsung.com, pankaj.dubey@samsung.com,
	quic_nitegupt@quicinc.com, quic_krichai@quicinc.com,
	gost.dev@samsung.com, Shradha Todi <shradha.t@samsung.com>
Subject: Re: [PATCH v4 1/2] PCI: dwc: Add support for vendor specific
 capability search
Message-ID: <202412061940.WSlxZ8i1-lkp@intel.com>
References: <20241206074456.17401-2-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206074456.17401-2-shradha.t@samsung.com>

Hi Shradha,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus mani-mhi/mhi-next linus/master v6.13-rc1 next-20241205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shradha-Todi/PCI-dwc-Add-support-for-vendor-specific-capability-search/20241206-163620
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20241206074456.17401-2-shradha.t%40samsung.com
patch subject: [PATCH v4 1/2] PCI: dwc: Add support for vendor specific capability search
config: i386-buildonly-randconfig-006 (https://download.01.org/0day-ci/archive/20241206/202412061940.WSlxZ8i1-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241206/202412061940.WSlxZ8i1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412061940.WSlxZ8i1-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-designware.c: In function 'dw_pcie_find_vsec_capability':
>> drivers/pci/controller/dwc/pcie-designware.c:285:16: warning: suggest parentheses around assignment used as truth value [-Wparentheses]
     285 |         while (vsec = dw_pcie_find_next_ext_capability(pci, vsec,
         |                ^~~~


vim +285 drivers/pci/controller/dwc/pcie-designware.c

   279	
   280	u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci, u8 vsec_cap)
   281	{
   282		u16 vsec = 0;
   283		u32 header;
   284	
 > 285		while (vsec = dw_pcie_find_next_ext_capability(pci, vsec,
   286						PCI_EXT_CAP_ID_VNDR)) {
   287			header = dw_pcie_readl_dbi(pci, vsec + PCI_VNDR_HEADER);
   288			if (PCI_VNDR_HEADER_ID(header) == vsec_cap)
   289				return vsec;
   290		}
   291	
   292		return 0;
   293	}
   294	EXPORT_SYMBOL_GPL(dw_pcie_find_vsec_capability);
   295	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

