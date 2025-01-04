Return-Path: <linux-pci+bounces-19296-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C94AA01352
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 09:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9A03A3B76
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 08:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D09F185B62;
	Sat,  4 Jan 2025 08:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UxUPzxND"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646FC178395;
	Sat,  4 Jan 2025 08:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735979970; cv=none; b=WRgIUbMRHbeb9J+Vl2+E3ihk9gj2OwQqCd1YlZDX6/W2a9S/Vp8LekD/sbjt9nMV4Z/1MLpTFcr9lAGVBuElCnkyihqw1RNY2kS48Ex9qhYFxs1soxuHH+x3dYMiQj+RdJsUkD5+LBY3xlbwcGd1K2Mja22b+DMcKgC9dmA/eFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735979970; c=relaxed/simple;
	bh=KFiKINE36jaH0nS+AwFQTTrmBUsbOfqChk+/Y6EK+4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4JVCOBWTOEci0y/fUqKqIJ3BNED/AAsG15C6eg8v5MW1L9L8fEIb8I37ivbLW4DaE6BPlpEpmGouerwWJ3HyxTN+fn4mpmcPmKqID5XUrete9IZW7r7VZ9CNRCUQ9MPD3RcYZWLsagmxfL7UV/C0l2UBZLIZm06G1jotivPRIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UxUPzxND; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735979969; x=1767515969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KFiKINE36jaH0nS+AwFQTTrmBUsbOfqChk+/Y6EK+4Q=;
  b=UxUPzxNDOXANERJlPxQ60Pnanlpd39/oft4eP1GVDQy3qkEROKt7tVTO
   ONYLHmWX1L1CvO/l332ZNiuxohzu5DWN3TfLpa3uqfsqk3fGAMVf+KfvC
   5nV+z3IlKEfrcULoRQCxA+Kf6Xvzp5ff7/AbVJDsmQdqSiVRYC1c16MNS
   IpMKbvm8CahIVFolZybXAoutL/s+q1QR8ewlCUfueR+OaTkRiVSvCZxy2
   bXNu20Ovbxuy6CUSTsFCf/8+fwEUHpbniFRV1M0qXlQi4MjVwpJ0Yp+GF
   V2UQkxO7Ob2f4GCWZewpThukS0sMRasH2GX6aF6uPi0fONFwh6a98KHvy
   w==;
X-CSE-ConnectionGUID: 3HDmsdR1THCv15nu3l/pDw==
X-CSE-MsgGUID: 4OqwcJmCTk+Uwf/FXfQPVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11304"; a="47622214"
X-IronPort-AV: E=Sophos;i="6.12,288,1728975600"; 
   d="scan'208";a="47622214"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2025 00:39:20 -0800
X-CSE-ConnectionGUID: 3DfRyqxySrm1H+h8VrGFOg==
X-CSE-MsgGUID: aczqzdmBSsC5MSiQ2BNrXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,288,1728975600"; 
   d="scan'208";a="102452128"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 04 Jan 2025 00:39:18 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tTzgi-000Alv-0g;
	Sat, 04 Jan 2025 08:39:16 +0000
Date: Sat, 4 Jan 2025 16:39:11 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, "David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 2/3] PCI: of: Simplify bus range parsing
Message-ID: <202501041649.cjMwvH2B-lkp@intel.com>
References: <20250103213129.5182-3-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103213129.5182-3-helgaas@kernel.org>

Hi Bjorn,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus robh/for-next linus/master v6.13-rc5 next-20241220]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bjorn-Helgaas/PCI-Unexport-of_pci_parse_bus_range/20250104-053408
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250103213129.5182-3-helgaas%40kernel.org
patch subject: [PATCH 2/3] PCI: of: Simplify bus range parsing
config: i386-buildonly-randconfig-006-20250104 (https://download.01.org/0day-ci/archive/20250104/202501041649.cjMwvH2B-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250104/202501041649.cjMwvH2B-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501041649.cjMwvH2B-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/of.c: In function 'devm_of_pci_get_host_bridge_resources':
>> drivers/pci/of.c:349:57: error: 'bus_max' undeclared (first use in this function)
     349 |                 if (bus_range->end > bus_range->start + bus_max)
         |                                                         ^~~~~~~
   drivers/pci/of.c:349:57: note: each undeclared identifier is reported only once for each function it appears in


vim +/bus_max +349 drivers/pci/of.c

4670d610d59233 Rob Herring         2018-01-17  300  
4670d610d59233 Rob Herring         2018-01-17  301  /**
5bd51b35c7cbbc Jan Kiszka          2018-05-15  302   * devm_of_pci_get_host_bridge_resources() - Resource-managed parsing of PCI
5bd51b35c7cbbc Jan Kiszka          2018-05-15  303   *                                           host bridge resources from DT
055f87a2a33640 Jan Kiszka          2018-05-15  304   * @dev: host bridge device
4670d610d59233 Rob Herring         2018-01-17  305   * @resources: list where the range of resources will be added after DT parsing
9b41d19aff4090 Krzysztof Kozlowski 2020-07-29  306   * @ib_resources: list where the range of inbound resources (with addresses
9b41d19aff4090 Krzysztof Kozlowski 2020-07-29  307   *                from 'dma-ranges') will be added after DT parsing
4670d610d59233 Rob Herring         2018-01-17  308   * @io_base: pointer to a variable that will contain on return the physical
4670d610d59233 Rob Herring         2018-01-17  309   * address for the start of the I/O range. Can be NULL if the caller doesn't
4670d610d59233 Rob Herring         2018-01-17  310   * expect I/O ranges to be present in the device tree.
4670d610d59233 Rob Herring         2018-01-17  311   *
4670d610d59233 Rob Herring         2018-01-17  312   * This function will parse the "ranges" property of a PCI host bridge device
4670d610d59233 Rob Herring         2018-01-17  313   * node and setup the resource mapping based on its content. It is expected
4670d610d59233 Rob Herring         2018-01-17  314   * that the property conforms with the Power ePAPR document.
4670d610d59233 Rob Herring         2018-01-17  315   *
4670d610d59233 Rob Herring         2018-01-17  316   * It returns zero if the range parsing has been successful or a standard error
4670d610d59233 Rob Herring         2018-01-17  317   * value if it failed.
4670d610d59233 Rob Herring         2018-01-17  318   */
3b55809cf91f54 Rob Herring         2019-10-28  319  static int devm_of_pci_get_host_bridge_resources(struct device *dev,
331f63457165a3 Rob Herring         2019-10-30  320  			struct list_head *resources,
331f63457165a3 Rob Herring         2019-10-30  321  			struct list_head *ib_resources,
331f63457165a3 Rob Herring         2019-10-30  322  			resource_size_t *io_base)
4670d610d59233 Rob Herring         2018-01-17  323  {
055f87a2a33640 Jan Kiszka          2018-05-15  324  	struct device_node *dev_node = dev->of_node;
93c9a7f8793175 Jan Kiszka          2018-06-19  325  	struct resource *res, tmp_res;
4670d610d59233 Rob Herring         2018-01-17  326  	struct resource *bus_range;
4670d610d59233 Rob Herring         2018-01-17  327  	struct of_pci_range range;
4670d610d59233 Rob Herring         2018-01-17  328  	struct of_pci_range_parser parser;
331f63457165a3 Rob Herring         2019-10-30  329  	const char *range_type;
4670d610d59233 Rob Herring         2018-01-17  330  	int err;
4670d610d59233 Rob Herring         2018-01-17  331  
4670d610d59233 Rob Herring         2018-01-17  332  	if (io_base)
4670d610d59233 Rob Herring         2018-01-17  333  		*io_base = (resource_size_t)OF_BAD_ADDR;
4670d610d59233 Rob Herring         2018-01-17  334  
5bd51b35c7cbbc Jan Kiszka          2018-05-15  335  	bus_range = devm_kzalloc(dev, sizeof(*bus_range), GFP_KERNEL);
4670d610d59233 Rob Herring         2018-01-17  336  	if (!bus_range)
4670d610d59233 Rob Herring         2018-01-17  337  		return -ENOMEM;
4670d610d59233 Rob Herring         2018-01-17  338  
d9c5d5ac287caa Jan Kiszka          2018-05-15  339  	dev_info(dev, "host bridge %pOF ranges:\n", dev_node);
4670d610d59233 Rob Herring         2018-01-17  340  
126b7de6bfd84b Jan Kiszka          2018-05-15  341  	err = of_pci_parse_bus_range(dev_node, bus_range);
4670d610d59233 Rob Herring         2018-01-17  342  	if (err) {
5ad20c289cd7a4 Bjorn Helgaas       2025-01-03  343  		bus_range->start = 0;
5ad20c289cd7a4 Bjorn Helgaas       2025-01-03  344  		bus_range->end = 0xff;
4670d610d59233 Rob Herring         2018-01-17  345  		bus_range->flags = IORESOURCE_BUS;
d9c5d5ac287caa Jan Kiszka          2018-05-15  346  		dev_info(dev, "  No bus range found for %pOF, using %pR\n",
126b7de6bfd84b Jan Kiszka          2018-05-15  347  			 dev_node, bus_range);
4670d610d59233 Rob Herring         2018-01-17  348  	} else {
4670d610d59233 Rob Herring         2018-01-17 @349  		if (bus_range->end > bus_range->start + bus_max)
4670d610d59233 Rob Herring         2018-01-17  350  			bus_range->end = bus_range->start + bus_max;
4670d610d59233 Rob Herring         2018-01-17  351  	}
4670d610d59233 Rob Herring         2018-01-17  352  	pci_add_resource(resources, bus_range);
4670d610d59233 Rob Herring         2018-01-17  353  
4670d610d59233 Rob Herring         2018-01-17  354  	/* Check for ranges property */
126b7de6bfd84b Jan Kiszka          2018-05-15  355  	err = of_pci_range_parser_init(&parser, dev_node);
4670d610d59233 Rob Herring         2018-01-17  356  	if (err)
d277f6e88c8872 Rob Herring         2021-08-03  357  		return 0;
4670d610d59233 Rob Herring         2018-01-17  358  
d9c5d5ac287caa Jan Kiszka          2018-05-15  359  	dev_dbg(dev, "Parsing ranges property...\n");
4670d610d59233 Rob Herring         2018-01-17  360  	for_each_of_pci_range(&parser, &range) {
4670d610d59233 Rob Herring         2018-01-17  361  		/* Read next ranges element */
4670d610d59233 Rob Herring         2018-01-17  362  		if ((range.flags & IORESOURCE_TYPE_BITS) == IORESOURCE_IO)
331f63457165a3 Rob Herring         2019-10-30  363  			range_type = "IO";
4670d610d59233 Rob Herring         2018-01-17  364  		else if ((range.flags & IORESOURCE_TYPE_BITS) == IORESOURCE_MEM)
331f63457165a3 Rob Herring         2019-10-30  365  			range_type = "MEM";
4670d610d59233 Rob Herring         2018-01-17  366  		else
331f63457165a3 Rob Herring         2019-10-30  367  			range_type = "err";
331f63457165a3 Rob Herring         2019-10-30  368  		dev_info(dev, "  %6s %#012llx..%#012llx -> %#012llx\n",
d9c5d5ac287caa Jan Kiszka          2018-05-15  369  			 range_type, range.cpu_addr,
d9c5d5ac287caa Jan Kiszka          2018-05-15  370  			 range.cpu_addr + range.size - 1, range.pci_addr);
4670d610d59233 Rob Herring         2018-01-17  371  
4670d610d59233 Rob Herring         2018-01-17  372  		/*
4670d610d59233 Rob Herring         2018-01-17  373  		 * If we failed translation or got a zero-sized region
4670d610d59233 Rob Herring         2018-01-17  374  		 * then skip this range
4670d610d59233 Rob Herring         2018-01-17  375  		 */
4670d610d59233 Rob Herring         2018-01-17  376  		if (range.cpu_addr == OF_BAD_ADDR || range.size == 0)
4670d610d59233 Rob Herring         2018-01-17  377  			continue;
4670d610d59233 Rob Herring         2018-01-17  378  
93c9a7f8793175 Jan Kiszka          2018-06-19  379  		err = of_pci_range_to_resource(&range, dev_node, &tmp_res);
93c9a7f8793175 Jan Kiszka          2018-06-19  380  		if (err)
93c9a7f8793175 Jan Kiszka          2018-06-19  381  			continue;
93c9a7f8793175 Jan Kiszka          2018-06-19  382  
93c9a7f8793175 Jan Kiszka          2018-06-19  383  		res = devm_kmemdup(dev, &tmp_res, sizeof(tmp_res), GFP_KERNEL);
4670d610d59233 Rob Herring         2018-01-17  384  		if (!res) {
4670d610d59233 Rob Herring         2018-01-17  385  			err = -ENOMEM;
5bd51b35c7cbbc Jan Kiszka          2018-05-15  386  			goto failed;
4670d610d59233 Rob Herring         2018-01-17  387  		}
4670d610d59233 Rob Herring         2018-01-17  388  
4670d610d59233 Rob Herring         2018-01-17  389  		if (resource_type(res) == IORESOURCE_IO) {
4670d610d59233 Rob Herring         2018-01-17  390  			if (!io_base) {
d9c5d5ac287caa Jan Kiszka          2018-05-15  391  				dev_err(dev, "I/O range found for %pOF. Please provide an io_base pointer to save CPU base address\n",
126b7de6bfd84b Jan Kiszka          2018-05-15  392  					dev_node);
4670d610d59233 Rob Herring         2018-01-17  393  				err = -EINVAL;
5bd51b35c7cbbc Jan Kiszka          2018-05-15  394  				goto failed;
4670d610d59233 Rob Herring         2018-01-17  395  			}
4670d610d59233 Rob Herring         2018-01-17  396  			if (*io_base != (resource_size_t)OF_BAD_ADDR)
d9c5d5ac287caa Jan Kiszka          2018-05-15  397  				dev_warn(dev, "More than one I/O resource converted for %pOF. CPU base address for old range lost!\n",
126b7de6bfd84b Jan Kiszka          2018-05-15  398  					 dev_node);
4670d610d59233 Rob Herring         2018-01-17  399  			*io_base = range.cpu_addr;
3bd6b8271ee660 Punit Agrawal       2021-06-15  400  		} else if (resource_type(res) == IORESOURCE_MEM) {
3bd6b8271ee660 Punit Agrawal       2021-06-15  401  			res->flags &= ~IORESOURCE_MEM_64;
4670d610d59233 Rob Herring         2018-01-17  402  		}
4670d610d59233 Rob Herring         2018-01-17  403  
4670d610d59233 Rob Herring         2018-01-17  404  		pci_add_resource_offset(resources, res,	res->start - range.pci_addr);
4670d610d59233 Rob Herring         2018-01-17  405  	}
4670d610d59233 Rob Herring         2018-01-17  406  
331f63457165a3 Rob Herring         2019-10-30  407  	/* Check for dma-ranges property */
331f63457165a3 Rob Herring         2019-10-30  408  	if (!ib_resources)
331f63457165a3 Rob Herring         2019-10-30  409  		return 0;
331f63457165a3 Rob Herring         2019-10-30  410  	err = of_pci_dma_range_parser_init(&parser, dev_node);
331f63457165a3 Rob Herring         2019-10-30  411  	if (err)
331f63457165a3 Rob Herring         2019-10-30  412  		return 0;
331f63457165a3 Rob Herring         2019-10-30  413  
331f63457165a3 Rob Herring         2019-10-30  414  	dev_dbg(dev, "Parsing dma-ranges property...\n");
331f63457165a3 Rob Herring         2019-10-30  415  	for_each_of_pci_range(&parser, &range) {
331f63457165a3 Rob Herring         2019-10-30  416  		/*
331f63457165a3 Rob Herring         2019-10-30  417  		 * If we failed translation or got a zero-sized region
331f63457165a3 Rob Herring         2019-10-30  418  		 * then skip this range
331f63457165a3 Rob Herring         2019-10-30  419  		 */
331f63457165a3 Rob Herring         2019-10-30  420  		if (((range.flags & IORESOURCE_TYPE_BITS) != IORESOURCE_MEM) ||
331f63457165a3 Rob Herring         2019-10-30  421  		    range.cpu_addr == OF_BAD_ADDR || range.size == 0)
331f63457165a3 Rob Herring         2019-10-30  422  			continue;
331f63457165a3 Rob Herring         2019-10-30  423  
331f63457165a3 Rob Herring         2019-10-30  424  		dev_info(dev, "  %6s %#012llx..%#012llx -> %#012llx\n",
331f63457165a3 Rob Herring         2019-10-30  425  			 "IB MEM", range.cpu_addr,
331f63457165a3 Rob Herring         2019-10-30  426  			 range.cpu_addr + range.size - 1, range.pci_addr);
331f63457165a3 Rob Herring         2019-10-30  427  
331f63457165a3 Rob Herring         2019-10-30  428  
331f63457165a3 Rob Herring         2019-10-30  429  		err = of_pci_range_to_resource(&range, dev_node, &tmp_res);
331f63457165a3 Rob Herring         2019-10-30  430  		if (err)
331f63457165a3 Rob Herring         2019-10-30  431  			continue;
331f63457165a3 Rob Herring         2019-10-30  432  
331f63457165a3 Rob Herring         2019-10-30  433  		res = devm_kmemdup(dev, &tmp_res, sizeof(tmp_res), GFP_KERNEL);
331f63457165a3 Rob Herring         2019-10-30  434  		if (!res) {
331f63457165a3 Rob Herring         2019-10-30  435  			err = -ENOMEM;
331f63457165a3 Rob Herring         2019-10-30  436  			goto failed;
331f63457165a3 Rob Herring         2019-10-30  437  		}
331f63457165a3 Rob Herring         2019-10-30  438  
b8397a8f4ebc0b Robin Murphy        2022-05-09  439  		pci_add_resource_offset(ib_resources, res,
331f63457165a3 Rob Herring         2019-10-30  440  					res->start - range.pci_addr);
331f63457165a3 Rob Herring         2019-10-30  441  	}
331f63457165a3 Rob Herring         2019-10-30  442  
4670d610d59233 Rob Herring         2018-01-17  443  	return 0;
4670d610d59233 Rob Herring         2018-01-17  444  
5bd51b35c7cbbc Jan Kiszka          2018-05-15  445  failed:
4670d610d59233 Rob Herring         2018-01-17  446  	pci_free_resource_list(resources);
4670d610d59233 Rob Herring         2018-01-17  447  	return err;
4670d610d59233 Rob Herring         2018-01-17  448  }
4670d610d59233 Rob Herring         2018-01-17  449  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

