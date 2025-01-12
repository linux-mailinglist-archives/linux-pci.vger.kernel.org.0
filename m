Return-Path: <linux-pci+bounces-19648-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90914A0A705
	for <lists+linux-pci@lfdr.de>; Sun, 12 Jan 2025 03:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE381654F7
	for <lists+linux-pci@lfdr.de>; Sun, 12 Jan 2025 02:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C93CE56A;
	Sun, 12 Jan 2025 02:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nLnj8OoW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1998A2CA6;
	Sun, 12 Jan 2025 02:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736650698; cv=none; b=iO5CnXesJR9AxP142Nrme0V3GFrpjOa/ubr6rhwfTwrgY0E3A7rNa90sZelK7gci5OqBJs+ylKmcVSEnYuPIeHE3gyLpr8/DdLRSYPAiUSjDglPaNj04dt8uwXwtSSjsntMbrygsrGp2TR/NR3nvT4DSH5QYg2n1EieawmlrI9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736650698; c=relaxed/simple;
	bh=P6HmMuEanbN2AbJSaR7/q6oJzdrrcsN9KTJG/tRphkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRvDAYHmacx5FaTq9r9eHl93ijUatHk8h2OK2Pb3IIcAPkXHvLxBBWA7G9QGEyBAnIjanA/71IBWyd8WetU+meZDeU8kZyAjRatu8M7KhP4qwj5Bbbedx2rKm5iiRCUY3sYfHYKzILegq3cSgGbnZxQC3qD8BV4oQp8uBSKPJVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nLnj8OoW; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736650695; x=1768186695;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P6HmMuEanbN2AbJSaR7/q6oJzdrrcsN9KTJG/tRphkg=;
  b=nLnj8OoWYgW/4MCP54N3auTCHhVO+abdCi3uwtzyvkEN/IpmaJBWnr82
   q1MNKI6iWAuO8f6uJ63VeHWusDu3E8zhMa0lYmsVPhh/Q62EzfCFMY3jC
   nF0Q/A+DU3tZb4HfUBOz9u63Px00cvrez9rA1FJHaAdkpm83ioeb1VsG8
   geXg+svRSUxl3eBbEJ62QEDNsKUPrkONao3FC2+rHRsYBxXyz0tOddG6C
   WcjlmSY6bUNwYiucp0GXcWMC8cEdiiKLGmhe9n46UnG15jm5mZQbD+Jj4
   48egnXoq5T7ueroD7OSV6A7qRbM3DN0zpq/XL4PLju0FIeKKl85V/y4+h
   Q==;
X-CSE-ConnectionGUID: 7WWKo9XqTu+pzgP2K19JQw==
X-CSE-MsgGUID: hHJc9r2uSgSn1Qi7c3OMVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11312"; a="47567862"
X-IronPort-AV: E=Sophos;i="6.12,308,1728975600"; 
   d="scan'208";a="47567862"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2025 18:58:14 -0800
X-CSE-ConnectionGUID: /Oq5OKv5Spuy/fOjb2Q2bw==
X-CSE-MsgGUID: 0+LuP4+JQZaN13IodNqk0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="141387405"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 11 Jan 2025 18:58:12 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tWoAy-000LVj-34;
	Sun, 12 Jan 2025 02:58:08 +0000
Date: Sun, 12 Jan 2025 10:57:27 +0800
From: kernel test robot <lkp@intel.com>
To: Roger Pau Monne <roger.pau@citrix.com>, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Roger Pau Monne <roger.pau@citrix.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 2/3] vmd: disable MSI remapping bypass under Xen
Message-ID: <202501121029.dJk0TBPr-lkp@intel.com>
References: <20250110140152.27624-3-roger.pau@citrix.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110140152.27624-3-roger.pau@citrix.com>

Hi Roger,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus tip/irq/core linus/master v6.13-rc6 next-20250110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Roger-Pau-Monne/xen-pci-do-not-register-devices-outside-of-PCI-segment-scope/20250110-220331
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250110140152.27624-3-roger.pau%40citrix.com
patch subject: [PATCH 2/3] vmd: disable MSI remapping bypass under Xen
config: x86_64-buildonly-randconfig-001-20250112 (https://download.01.org/0day-ci/archive/20250112/202501121029.dJk0TBPr-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250112/202501121029.dJk0TBPr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501121029.dJk0TBPr-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/controller/vmd.c: In function 'vmd_probe':
>> drivers/pci/controller/vmd.c:973:13: error: implicit declaration of function 'xen_domain' [-Werror=implicit-function-declaration]
     973 |         if (xen_domain())
         |             ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/xen_domain +973 drivers/pci/controller/vmd.c

   966	
   967	static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
   968	{
   969		unsigned long features = (unsigned long) id->driver_data;
   970		struct vmd_dev *vmd;
   971		int err;
   972	
 > 973		if (xen_domain())
   974			/*
   975			 * Xen doesn't have knowledge about devices in the VMD bus.
   976			 * Bypass of MSI remapping won't work in that case as direct
   977			 * write to the MSI entries won't result in functional
   978			 * interrupts.
   979			 */
   980			features &= ~VMD_FEAT_CAN_BYPASS_MSI_REMAP;
   981	
   982		if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
   983			return -ENOMEM;
   984	
   985		vmd = devm_kzalloc(&dev->dev, sizeof(*vmd), GFP_KERNEL);
   986		if (!vmd)
   987			return -ENOMEM;
   988	
   989		vmd->dev = dev;
   990		vmd->instance = ida_alloc(&vmd_instance_ida, GFP_KERNEL);
   991		if (vmd->instance < 0)
   992			return vmd->instance;
   993	
   994		vmd->name = devm_kasprintf(&dev->dev, GFP_KERNEL, "vmd%d",
   995					   vmd->instance);
   996		if (!vmd->name) {
   997			err = -ENOMEM;
   998			goto out_release_instance;
   999		}
  1000	
  1001		err = pcim_enable_device(dev);
  1002		if (err < 0)
  1003			goto out_release_instance;
  1004	
  1005		vmd->cfgbar = pcim_iomap(dev, VMD_CFGBAR, 0);
  1006		if (!vmd->cfgbar) {
  1007			err = -ENOMEM;
  1008			goto out_release_instance;
  1009		}
  1010	
  1011		pci_set_master(dev);
  1012		if (dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(64)) &&
  1013		    dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32))) {
  1014			err = -ENODEV;
  1015			goto out_release_instance;
  1016		}
  1017	
  1018		if (features & VMD_FEAT_OFFSET_FIRST_VECTOR)
  1019			vmd->first_vec = 1;
  1020	
  1021		spin_lock_init(&vmd->cfg_lock);
  1022		pci_set_drvdata(dev, vmd);
  1023		err = vmd_enable_domain(vmd, features);
  1024		if (err)
  1025			goto out_release_instance;
  1026	
  1027		dev_info(&vmd->dev->dev, "Bound to PCI domain %04x\n",
  1028			 vmd->sysdata.domain);
  1029		return 0;
  1030	
  1031	 out_release_instance:
  1032		ida_free(&vmd_instance_ida, vmd->instance);
  1033		return err;
  1034	}
  1035	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

