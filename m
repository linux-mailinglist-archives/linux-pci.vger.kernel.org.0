Return-Path: <linux-pci+bounces-24819-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE88A72983
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 05:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 134A93A54CE
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 04:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D429F1B0414;
	Thu, 27 Mar 2025 04:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fDqfHARe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E6218EB0;
	Thu, 27 Mar 2025 04:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743050684; cv=none; b=eNCbt+SH14gCZUCpAjt8fZRPcjZg8n5DiW/PZBBO2tHKz0xpwaw98xA4y6mMPY2ljyrOBvNZyieteDpC0qwSls9vlzI4m+1kVFuN5PYyrhrplF0vUJz1ur0kHujhoCimqbgfZm7YvLET/V2Fs7q4h+7Njau/bvAxYStHJ+gQCRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743050684; c=relaxed/simple;
	bh=P0chp4xBDlotGj0tXaHNNVwUIHgI3UJNb25DwM9py+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jck4RgTzl0itnfe6CL9ymYvm251qavkqJr5I1R/u/fVAMU6VBDVgddAomD+ko3Srenc88UvjGCGmX0lfOQz7yDQdtPbSVLjj7ipuE50pPAp+zAwbFvqsNhXUirDd+3K2ZSu2gSieemK3RWqaPUlR+LjfmOzAsw3HGMsJ1yKcpEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fDqfHARe; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743050683; x=1774586683;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P0chp4xBDlotGj0tXaHNNVwUIHgI3UJNb25DwM9py+Q=;
  b=fDqfHAReLfGtVdhOFbMfH3b7AOzGiLVKL2UuyNAbNvxWad2XTogMcUSv
   tpUHafwc2D/t0oONVKz62DjDQuSE3mKuJWDU6SK6ZaUTaWSVXgVpjOSQX
   vJKJSoxoQubqRgydQcW37H8ZvOefc47zeDgaAKeklJq5lmhv2o4Vlz+Il
   Re9/vjQWeKToEWmirpur1XxOJ+0/D3gOrPgvyx6wyBkQ4Bco0p7fM9P1Q
   17I9IaYxHKCfYLqCXM08+6cJhCsRajmUVi3ILQdLCISHiSh5eT8vduCIO
   PkiqtAeTMy/t0Guis2UQEzOshYaLEJzMG9FR4Eg1/VMqIdQpIx/9OVzWe
   A==;
X-CSE-ConnectionGUID: CSIm+sAbT2W2iFwZgfYIeg==
X-CSE-MsgGUID: +bgYYlLoS9CzApYEqbO7Hg==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44089227"
X-IronPort-AV: E=Sophos;i="6.14,279,1736841600"; 
   d="scan'208";a="44089227"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 21:44:42 -0700
X-CSE-ConnectionGUID: HRTvteAlTBuFFUrHSDtvlg==
X-CSE-MsgGUID: X9vNkrnpSXSC3XIiLqHy0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,279,1736841600"; 
   d="scan'208";a="125482753"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 26 Mar 2025 21:44:38 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1txf6Z-0006Mt-27;
	Thu, 27 Mar 2025 04:44:35 +0000
Date: Thu, 27 Mar 2025 12:43:43 +0800
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
Subject: Re: [PATCH v8 05/16] PCI/AER: CXL driver dequeues CXL error
 forwarded from AER service driver
Message-ID: <202503271234.IKMoGynt-lkp@intel.com>
References: <20250327014717.2988633-6-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327014717.2988633-6-terry.bowman@amd.com>

Hi Terry,

kernel test robot noticed the following build errors:

[auto build test ERROR on aae0594a7053c60b82621136257c8b648c67b512]

url:    https://github.com/intel-lab-lkp/linux/commits/Terry-Bowman/PCI-CXL-Introduce-PCIe-helper-function-pcie_is_cxl/20250327-095738
base:   aae0594a7053c60b82621136257c8b648c67b512
patch link:    https://lore.kernel.org/r/20250327014717.2988633-6-terry.bowman%40amd.com
patch subject: [PATCH v8 05/16] PCI/AER: CXL driver dequeues CXL error forwarded from AER service driver
config: loongarch-randconfig-001-20250327 (https://download.01.org/0day-ci/archive/20250327/202503271234.IKMoGynt-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250327/202503271234.IKMoGynt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503271234.IKMoGynt-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/cxl/core/ras.c: In function 'cxl_handle_prot_error':
>> drivers/cxl/core/ras.c:202:33: error: 'struct pci_dev' has no member named 'aer_cap'; did you mean 'ats_cap'?
     202 |                 int aer = pdev->aer_cap;
         |                                 ^~~~~~~
         |                                 ats_cap


vim +202 drivers/cxl/core/ras.c

   185	
   186	static void cxl_handle_prot_error(struct pci_dev *pdev, struct cxl_prot_error_info *err_info)
   187	{
   188		if (!pdev || !err_info)
   189			return;
   190	
   191		/*
   192		 * Internal errors of an RCEC indicate an AER error in an
   193		 * RCH's downstream port. Check and handle them in the CXL.mem
   194		 * device driver.
   195		 */
   196		if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_EC)
   197			return pcie_walk_rcec(pdev, cxl_rch_handle_error_iter, err_info);
   198	
   199		if (err_info->severity == AER_CORRECTABLE) {
   200			struct device *dev __free(put_device) = get_device(err_info->dev);
   201			struct cxl_driver *pdrv;
 > 202			int aer = pdev->aer_cap;
   203	
   204			if (!dev || !dev->driver)
   205				return;
   206	
   207			if (aer) {
   208				int ras_status;
   209	
   210				pci_read_config_dword(pdev, aer + PCI_ERR_COR_STATUS, &ras_status);
   211				pci_write_config_dword(pdev, aer + PCI_ERR_COR_STATUS,
   212						       ras_status);
   213			}
   214	
   215			pdrv = to_cxl_drv(dev->driver);
   216			if (!pdrv || !pdrv->err_handler ||
   217			    !pdrv->err_handler->cor_error_detected)
   218				return;
   219	
   220			pdrv->err_handler->cor_error_detected(dev, err_info);
   221			pcie_clear_device_status(pdev);
   222		} else {
   223			cxl_do_recovery(pdev);
   224		}
   225	}
   226	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

