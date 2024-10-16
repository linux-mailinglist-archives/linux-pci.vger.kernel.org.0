Return-Path: <linux-pci+bounces-14673-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B679A106C
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 19:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B471C21030
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 17:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F2520E027;
	Wed, 16 Oct 2024 17:15:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C395820FAAB;
	Wed, 16 Oct 2024 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729098909; cv=none; b=QaeAF1TJ9k4SNOLlGwuS/HS+2lZJVSIG7Jgp6nWOXmpZEA1g/K/2jZHjYjpewD91FUnZSp23VbfBuXh1phpFvcw3DkYz706C29sxnwIsuuI5LTPPWJ/Jz0jlhTDyUK+qLcYCcElI5S1m6YG/TjPxHBK3/N1Jri1DM3544WDnzVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729098909; c=relaxed/simple;
	bh=mvysEIx3kKKtCVA9J7u3T8Wc7Mr5NH3+qMChI6Zy3zw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kCq7lqA1nWl75Hvbc5135/TAqsygfbLkjoaPZqd+AClDRgQ+bxaqSLdGoVZ3EH2Y9OqPZisB5DewLOjFNYR12hbPxqYorXIG5owtfO7XY32Lw6LqwWrs1Erhtypb8FywVlwjFgPBuLdUAz8Plk0K4ClTiZ3iLodeNvGLqXuRiOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTHc01PVMz6J789;
	Thu, 17 Oct 2024 01:13:20 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A78B140A46;
	Thu, 17 Oct 2024 01:15:01 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 16 Oct
 2024 19:15:00 +0200
Date: Wed, 16 Oct 2024 18:14:59 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <oohall@gmail.com>,
	<Benjamin.Cheatham@amd.com>, <rrichter@amd.com>, <nathan.fontenot@amd.com>,
	<smita.koralahallichannabasappa@amd.com>
Subject: Re: [PATCH 09/15] cxl/pci: Map CXL PCIe downstream port RAS
 registers
Message-ID: <20241016181459.00000b71@Huawei.com>
In-Reply-To: <20241008221657.1130181-10-terry.bowman@amd.com>
References: <20241008221657.1130181-1-terry.bowman@amd.com>
	<20241008221657.1130181-10-terry.bowman@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 8 Oct 2024 17:16:51 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> RAS registers are not mapped for CXL root ports, CXL downstream switch
> ports, or CXL upstream switch ports. To prepare for future RAS logging
> and handling, the driver needs updating to map PCIe port RAS registers.

Give the upstream port is in next patch, I'd just mention that you
are adding mapping of RP and DSP here (This confused me before I noticed
the next patch).
> 
> Refactor and rename cxl_setup_parent_dport() to be cxl_init_ep_ports_aer().
> Update the function such that it will iterate an endpoint's dports to map
> the RAS registers.
> 
> Rename cxl_dport_map_regs() to be cxl_dport_init_aer(). The new
> function name is a more accurate description of the function's work.
> 
> This update should also include checking for previously mapped registers
> within the topology, particularly with CXL switches. Endpoints under a
> CXL switch may share a common downstream and upstream port, ensure that
> the registers are only mapped once.

I don't understand why we need to do this for the ras registers but
it doesn't apply for HDM decoders for instance?  Why can't
we map these registers in cxl_port_probe()?

End of day here, so maybe I'm completely misunderstanding this.
Will take another look tomorrow morning.

> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/pci.c | 37 ++++++++++++++++---------------------
>  drivers/cxl/cxl.h      |  7 ++++---
>  drivers/cxl/mem.c      | 27 +++++++++++++++++++++++++--
>  3 files changed, 45 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 51132a575b27..6f7bcdb389bf 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -787,21 +787,6 @@ static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
>  	dport->regs.dport_aer = dport_aer;
>  }
>  
> -static void cxl_dport_map_regs(struct cxl_dport *dport)
> -{
> -	struct cxl_register_map *map = &dport->reg_map;
> -	struct device *dev = dport->dport_dev;
> -
> -	if (!map->component_map.ras.valid)
> -		dev_dbg(dev, "RAS registers not found\n");
> -	else if (cxl_map_component_regs(map, &dport->regs.component,
> -					BIT(CXL_CM_CAP_CAP_ID_RAS)))
> -		dev_dbg(dev, "Failed to map RAS capability.\n");
> -
> -	if (dport->rch)
> -		cxl_dport_map_rch_aer(dport);
> -}
> -
>  static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>  {
>  	void __iomem *aer_base = dport->regs.dport_aer;
> @@ -831,7 +816,7 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>  	}
>  }
>  
> -void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
> +void cxl_dport_init_aer(struct cxl_dport *dport)
>  {
>  	struct device *dport_dev = dport->dport_dev;
>  
> @@ -840,15 +825,25 @@ void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
>  
>  		if (host_bridge->native_aer)
>  			dport->rcrb.aer_cap = cxl_rcrb_to_aer(dport_dev, dport->rcrb.base);
> +
> +		cxl_dport_map_rch_aer(dport);
> +		cxl_disable_rch_root_ints(dport);
>  	}
>  
> -	dport->reg_map.host = host;
> -	cxl_dport_map_regs(dport);
> +	/* dport may have more than 1 downstream EP. Check if already mapped. */
> +	if (dport->regs.ras) {
> +		dev_warn(dport_dev, "RAS is already mapped\n");

This is valid. Why are we warning?
However why do we need this dance here but not for other
root port registers etc.


> +		return;
> +	}
>  
> -	if (dport->rch)
> -		cxl_disable_rch_root_ints(dport);
> +	dport->reg_map.host = dport_dev;
> +	if (cxl_map_component_regs(&dport->reg_map, &dport->regs.component,
> +				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
> +		dev_err(dport_dev, "Failed to map RAS capability.\n");
> +		return;
> +	}
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_setup_parent_dport, CXL);
> +EXPORT_SYMBOL_NS_GPL(cxl_dport_init_aer, CXL);
>  
>  static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
>  					  struct cxl_dport *dport)
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 9afb407d438f..cb9e05e2912b 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -592,6 +592,7 @@ struct cxl_dax_region {
>   * @parent_dport: dport that points to this port in the parent
>   * @decoder_ida: allocator for decoder ids
>   * @reg_map: component and ras register mapping parameters
> + * @uport_regs: mapped component registers
>   * @nr_dports: number of entries in @dports
>   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>   * @commit_end: cursor to track highest committed decoder for commit ordering
> @@ -612,6 +613,7 @@ struct cxl_port {
>  	struct cxl_dport *parent_dport;
>  	struct ida decoder_ida;
>  	struct cxl_register_map reg_map;
> +	struct cxl_component_regs uport_regs;
>  	int nr_dports;
>  	int hdm_end;
>  	int commit_end;
> @@ -761,10 +763,9 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>  					 resource_size_t rcrb);
>  
>  #ifdef CONFIG_PCIEAER_CXL
> -void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
> +void cxl_dport_init_aer(struct cxl_dport *dport);
>  #else
> -static inline void cxl_setup_parent_dport(struct device *host,
> -					  struct cxl_dport *dport) { }
> +static inline void cxl_dport_init_aer(struct cxl_dport *dport) { }
>  #endif
>  
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 7de232eaeb17..b7204f010785 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -45,6 +45,30 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
>  	return 0;
>  }
>  
> +static bool dev_is_cxl_pci(struct device *dev, u32 pcie_type)
> +{
> +	struct pci_dev *pdev;
> +
> +	if (!dev_is_pci(dev))
> +		return false;
> +
> +	pdev = to_pci_dev(dev);
> +	if (pci_pcie_type(pdev) != pcie_type)
> +		return false;
> +
> +	return pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					 CXL_DVSEC_REG_LOCATOR);
> +}
> +
> +static void cxl_init_ep_ports_aer(struct cxl_ep *ep)
> +{
> +	struct cxl_dport *dport = ep->dport;
> +
> +	if (dev_is_cxl_pci(dport->dport_dev, PCI_EXP_TYPE_DOWNSTREAM) ||
> +	    dev_is_cxl_pci(dport->dport_dev, PCI_EXP_TYPE_ROOT_PORT))
> +		cxl_dport_init_aer(dport);
> +}
> +
>  static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>  				 struct cxl_dport *parent_dport)
>  {
> @@ -62,6 +86,7 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>  
>  		ep = cxl_ep_load(iter, cxlmd);
>  		ep->next = down;
> +		cxl_init_ep_ports_aer(ep);
>  	}
>  
>  	/* Note: endpoint port component registers are derived from @cxlds */
> @@ -166,8 +191,6 @@ static int cxl_mem_probe(struct device *dev)
>  	else
>  		endpoint_parent = &parent_port->dev;
>  
> -	cxl_setup_parent_dport(dev, dport);
> -
>  	device_lock(endpoint_parent);
>  	if (!endpoint_parent->driver) {
>  		dev_err(dev, "CXL port topology %s not enabled\n",


