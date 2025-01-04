Return-Path: <linux-pci+bounces-19295-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A39DA012E8
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 08:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3448B1884A7F
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 07:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664B1146D76;
	Sat,  4 Jan 2025 07:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QroF9Y96"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C11025757;
	Sat,  4 Jan 2025 07:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735975459; cv=none; b=EwttfOfonWqMXrXkjjnYBzgY3+H6RqtqDTSpmIN0USARGvPrEQpxo3cEpba3WGO9FKuj5xSTlL3DCne21h5epF8s1S7LtjaOgAxxv55iZVlnDD81CP9abFfYGnoqiB9zgR2bDb9K8yHWP+LrXrmnOnWlDe3dB7IROzYyvSC6WW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735975459; c=relaxed/simple;
	bh=1UjT/iRKOzXq0r0UbmTO4uorivqpm4Sr7r+1Xk+4lEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V406HHaraQHsnPsLwvOQjULutSHRgdP2gaRHerCsrN4kIReIEIfmjGTia/Ahwxp5eY4tBPrLjHBxpZ5m1k3HGp1y+5V9/UrArPQLCVcKjKoVVvGC9YOZBMyyrZUILXVCQYa4zdSzCxgq8AafVtCLdkQknXNT5Iz8odX3kYmKAg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QroF9Y96; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735975457; x=1767511457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1UjT/iRKOzXq0r0UbmTO4uorivqpm4Sr7r+1Xk+4lEY=;
  b=QroF9Y969Vtu/fDwVu/P8+p21C528+Du2W25dy7FsOVHePUorWt4Ikel
   T93T8C30kRqV1cDQ3hir5QWBkoBLe01y8IajLhg3psleE/occDmMkGbwP
   y5raPZ+jkCdoN/J5H8TAz/drvxJx4wyC+hHc/XdLj0+oPg3oIuORk3X8p
   qgi171c0RCrCDqiNul8aJ18Zp7i3YVEGnxE0Kwbdc7WrNOAep3cCYABep
   j/96PdyaB4222NJwNkLMFjRyRIeqzMbijielFYq3HfNBa5AiH04YZGQyu
   fxxke8NOnKcLaWR3gIY8acmUh/dujSdg6nXyaSbCaLQhcs2FoqB0E5pD8
   w==;
X-CSE-ConnectionGUID: Fi/SC7K7Shuf7URewiFlhA==
X-CSE-MsgGUID: X4BP4l2uRIKq2r0/pNbTsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11304"; a="39030211"
X-IronPort-AV: E=Sophos;i="6.12,288,1728975600"; 
   d="scan'208";a="39030211"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 23:24:14 -0800
X-CSE-ConnectionGUID: haX6Fa4WRHmxCE6l0dJ51w==
X-CSE-MsgGUID: m85yKfO3TMK5fXLTfQK52w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102466775"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 03 Jan 2025 23:24:12 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tTyW1-000Ajb-2o;
	Sat, 04 Jan 2025 07:24:09 +0000
Date: Sat, 4 Jan 2025 15:23:14 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 2/3] PCI: of: Simplify bus range parsing
Message-ID: <202501041529.CV5Doc8D-lkp@intel.com>
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
config: i386-buildonly-randconfig-001-20250104 (https://download.01.org/0day-ci/archive/20250104/202501041529.CV5Doc8D-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250104/202501041529.CV5Doc8D-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501041529.CV5Doc8D-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pci/of.c:12:
   In file included from include/linux/pci.h:1645:
   In file included from include/linux/dmapool.h:14:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/pci/of.c:349:43: error: use of undeclared identifier 'bus_max'; did you mean 'pid_max'?
     349 |                 if (bus_range->end > bus_range->start + bus_max)
         |                                                         ^~~~~~~
         |                                                         pid_max
   include/linux/pid.h:109:12: note: 'pid_max' declared here
     109 | extern int pid_max;
         |            ^
   drivers/pci/of.c:350:40: error: use of undeclared identifier 'bus_max'; did you mean 'pid_max'?
     350 |                         bus_range->end = bus_range->start + bus_max;
         |                                                             ^~~~~~~
         |                                                             pid_max
   include/linux/pid.h:109:12: note: 'pid_max' declared here
     109 | extern int pid_max;
         |            ^
   1 warning and 2 errors generated.


vim +349 drivers/pci/of.c

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

