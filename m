Return-Path: <linux-pci+bounces-24896-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DF1A741FF
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 02:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD9533B68F9
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 01:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305A9537F8;
	Fri, 28 Mar 2025 01:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hjvCnl5X"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E39A93D;
	Fri, 28 Mar 2025 01:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743124764; cv=none; b=iLp9vtMJ7zEncgIcskphJ+Brx5VtiG4HdKH4NlNWHFVe34mz6V3tcK9dl1ues3h+MUkPgsDwIuFGQLPh1tGsFhq2p1P0h0omsRThPNPM3ZILsMWUEyaVLxLeZ/LtzIVvnuNrDpvaDi9UAV+aNvFyGALr9/tb/7KCaU1dK7W2heE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743124764; c=relaxed/simple;
	bh=nbe6Pi8tlh6LZT+q5xurltwfuX2F6rU4c5Dmj0Pz8eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lrk47ZVw5k6PWsWi6j2mWiebnyfsha7swKC5y09t6EWiJc7sEX0biHQCbVGXEG1YTagrc2PO13X2qrHF2T15TAaiVMFAMR7SwqFKRDrV8guXCZuIiHYm1iX/jUHD9kl3jR5H4ch+iBeuq6EjUseUrPf+lcuO8713fnnppScGEF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hjvCnl5X; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743124762; x=1774660762;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nbe6Pi8tlh6LZT+q5xurltwfuX2F6rU4c5Dmj0Pz8eg=;
  b=hjvCnl5XNVnTR1dO0SWATArLRekIKKTWEVeb6/T6xAMkHYu8UNW51+KC
   1gTx0SDpfa4Ic+8P30T+HoLgiKkhXfRSQgCDXo+JlvRc3IkHJMI0anQBC
   IRkwrhw9H5M8YgThNceAxD+lKfALTuoGsfmAnwq1gmd5IZiR6EzWqHs3i
   rjM9GunR0tQH8kC/pju8/w6ThDyC+UQ5ycVj7aB34PRL7ZZvqGiJs3WdG
   q3ZCa6LTWrtyxFZB7yuPnm8CI91tkr1SwSBtJrleJjYpSw7oN8K6dNiyL
   njgQXRsTvW0a2c+G0Yi4v3mq2z6g7OOw8pDRkJdgoPckD0bUUseQd+mbF
   w==;
X-CSE-ConnectionGUID: oEyfQUz+She5VJ4oH/BZow==
X-CSE-MsgGUID: 59HUFyZ4TPyxuHBuqRQo9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="47213315"
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; 
   d="scan'208";a="47213315"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 18:19:21 -0700
X-CSE-ConnectionGUID: VF0u9KfwSPyPHHyPFMvJIg==
X-CSE-MsgGUID: npAypc4PTEGOR8C32fBsjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; 
   d="scan'208";a="125525419"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 27 Mar 2025 18:19:16 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1txyNO-00073S-0Z;
	Fri, 28 Mar 2025 01:19:14 +0000
Date: Fri, 28 Mar 2025 09:18:24 +0800
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
Subject: Re: [PATCH v8 16/16] CXL/PCI: Disable CXL protocol errors during CXL
 Port cleanup
Message-ID: <202503280816.M7DZmSDT-lkp@intel.com>
References: <20250327014717.2988633-17-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327014717.2988633-17-terry.bowman@amd.com>

Hi Terry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on aae0594a7053c60b82621136257c8b648c67b512]

url:    https://github.com/intel-lab-lkp/linux/commits/Terry-Bowman/PCI-CXL-Introduce-PCIe-helper-function-pcie_is_cxl/20250327-095738
base:   aae0594a7053c60b82621136257c8b648c67b512
patch link:    https://lore.kernel.org/r/20250327014717.2988633-17-terry.bowman%40amd.com
patch subject: [PATCH v8 16/16] CXL/PCI: Disable CXL protocol errors during CXL Port cleanup
config: csky-randconfig-r122-20250327 (https://download.01.org/0day-ci/archive/20250328/202503280816.M7DZmSDT-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.4.0
reproduce: (https://download.01.org/0day-ci/archive/20250328/202503280816.M7DZmSDT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503280816.M7DZmSDT-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/cxl/port.c:68:33: sparse: sparse: symbol 'cxl_ep_error_handlers' was not declared. Should it be static?
>> drivers/cxl/port.c:104:6: sparse: sparse: symbol 'cxl_disable_prot_errors' was not declared. Should it be static?

vim +/cxl_disable_prot_errors +104 drivers/cxl/port.c

    67	
  > 68	const struct cxl_error_handlers cxl_ep_error_handlers = {
    69		.error_detected = cxl_error_detected,
    70		.cor_error_detected = cxl_cor_error_detected,
    71	};
    72	
    73	static void cxl_assign_error_handlers(struct device *_dev,
    74					      const struct cxl_error_handlers *handlers)
    75	{
    76		struct device *dev __free(put_device) = get_device(_dev);
    77		struct cxl_driver *pdrv;
    78	
    79		if (!dev)
    80			return;
    81	
    82		pdrv = to_cxl_drv(dev->driver);
    83		pdrv->err_handler = handlers;
    84	}
    85	
    86	void cxl_enable_prot_errors(struct device *dev)
    87	{
    88		struct pci_dev *pdev = to_pci_dev(dev);
    89		struct device *pci_dev __free(put_device) = get_device(&pdev->dev);
    90	
    91		if (!pci_dev)
    92			return;
    93	
    94		if (!pdev->aer_cap) {
    95			pdev->aer_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
    96			if (!pdev->aer_cap)
    97				return;
    98		}
    99	
   100		pci_aer_unmask_internal_errors(pdev);
   101	}
   102	EXPORT_SYMBOL_NS_GPL(cxl_enable_prot_errors, "CXL");
   103	
 > 104	void cxl_disable_prot_errors(void *_dev)
   105	{
   106		struct device *dev = _dev;
   107		struct pci_dev *pdev = to_pci_dev(dev);
   108		struct device *pci_dev __free(put_device) = get_device(&pdev->dev);
   109	
   110		if (!pci_dev || !pdev->aer_cap)
   111			return;
   112	
   113		pci_aer_mask_internal_errors(pdev);
   114	}
   115	EXPORT_SYMBOL_NS_GPL(cxl_disable_prot_errors, "CXL");
   116	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

