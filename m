Return-Path: <linux-pci+bounces-15638-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E527A9B6889
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 16:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B987285E07
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 15:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FB7213ED7;
	Wed, 30 Oct 2024 15:55:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF04C1F4711;
	Wed, 30 Oct 2024 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730303754; cv=none; b=iPBkGptL7J88ElakmXciQHcA3BSKe+EcpLChJ9gLppaESlHlq8LnO+w9QBqh9aNMrWuwQAIf+aSoAfzDjM5tgO9XqpEiEHzsFzDH40pVHXWiCnhzUOultrlqlqdEP68wo6+xmOwJPUkLzJ2T5rJQr1ZJiLciUHQTexWoMrEjhz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730303754; c=relaxed/simple;
	bh=maB6ZWiHIOmuX5pTEMBGTeAhT8UyG24m9ddpkq+e+7s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hrYBZxdHQgLp0fym4+L/FzDmu3Yna8s2mrLpaWuNIu2MRRwAOIa2RO9bFqWoextWUyf7HNNwuY6e2EcxHRjI4d2lWsWBHjGqAQY97g5cnKK/T5mWkBKreRjKm7YY9y1SU4NPG2Yya+2n84Siw/uoq816Bjp9AwdkbRvtiBx64ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xds6S6x6Hz6GDrs;
	Wed, 30 Oct 2024 23:50:56 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 765A5140CB1;
	Wed, 30 Oct 2024 23:55:48 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Oct
 2024 16:55:47 +0100
Date: Wed, 30 Oct 2024 15:55:46 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v2 09/14] cxl/pci: Map CXL PCIe root port and downstream
 switch port RAS registers
Message-ID: <20241030155546.0000701f@Huawei.com>
In-Reply-To: <20241025210305.27499-10-terry.bowman@amd.com>
References: <20241025210305.27499-1-terry.bowman@amd.com>
	<20241025210305.27499-10-terry.bowman@amd.com>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 25 Oct 2024 16:03:00 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> Map RAS registers for CXL PCIe root port and downstream RAS registers.
> 
> Refactor and rename cxl_setup_parent_dport() to be cxl_init_ep_ports_aer().
> Update the function to iterate an endpoint's parent downstream switch
> ports and parent root ports. It maps the RAS registers for each
> CXL downstream switch port and CXL root port iterated.
> 
> Move the RAS register map logic from cxl_dport_map_regs() into
> cxl_dport_init_ras_reporting(). This eliminates an unnecessary helper.
> cxl_dport_map_regs() can be removed.

looks to be called cxl_dport_map_ras()


> 
> cxl_dport_init_ras_reporting() must check for previously mapped registers
> within the topology, particularly with CXL switches. Endpoints under a
> CXL switch may share parent ports or downstream ports, ensure the ports'
> registers are only mapped once.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/pci.c | 38 +++++++++++++++++---------------------
>  drivers/cxl/cxl.h      |  6 ++----
>  drivers/cxl/mem.c      | 26 ++++++++++++++++++++++++--
>  3 files changed, 43 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 5b46bc46aaa9..0bb61e39cf8f 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -749,18 +749,6 @@ static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
>  	}
>  }
>  
> -static void cxl_dport_map_ras(struct cxl_dport *dport)
> -{
> -	struct cxl_register_map *map = &dport->reg_map;
> -	struct device *dev = dport->dport_dev;
> -
> -	if (!map->component_map.ras.valid)
> -		dev_dbg(dev, "RAS registers not found\n");
> -	else if (cxl_map_component_regs(map, &dport->regs.component,
> -					BIT(CXL_CM_CAP_CAP_ID_RAS)))
> -		dev_dbg(dev, "Failed to map RAS capability.\n");
> -}
> -
>  static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>  {
>  	void __iomem *aer_base = dport->regs.dport_aer;
> @@ -790,20 +778,28 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>   * @dport: the cxl_dport that needs to be initialized
>   * @host: host device for devm operations
>   */
> -void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
> +void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>  {
> -	dport->reg_map.host = host;
> -	cxl_dport_map_ras(dport);
> -
> -	if (dport->rch) {
> -		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
> -
> -		if (!host_bridge->native_aer)
> -			return;
> +	struct device *dport_dev = dport->dport_dev;
> +	struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport_dev);
>  
> +	if (dport->rch && host_bridge->native_aer) {
>  		cxl_dport_map_rch_aer(dport);
>  		cxl_disable_rch_root_ints(dport);
>  	}
> +
> +	/* dport may have more than 1 downstream EP. Check if already mapped. */
> +	if (dport->regs.ras) {
> +		dev_warn(dport_dev, "RAS is already mapped\n");
The comment suggests this is normal? If so why the dev_warn?

> +		return;
> +	}
> +
> +	dport->reg_map.host = dport_dev;
> +	if (cxl_map_component_regs(&dport->reg_map, &dport->regs.component,
> +				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
> +		dev_err(dport_dev, "Failed to map RAS capability.\n");
> +		return;
> +	}
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, CXL);

>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index a9fd5cd5a0d2..240d54b22a8c 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -45,6 +45,29 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
>  	return 0;
>  }
>  
> +static bool dev_is_cxl_pci(struct device *dev, u32 pcie_type)

Seems to only match ports, so that name is a little misleading.

> +{
> +	struct pci_dev *pdev;
> +
> +	if (!dev_is_pci(dev))
> +		return false;
> +
> +	pdev = to_pci_dev(dev);
> +	if (!pcie_is_cxl_port(pdev))
> +		return false;
> +
> +	return (pci_pcie_type(pdev) == pcie_type);
> +}
> +

>  static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>  				 struct cxl_dport *parent_dport)
>  {
> @@ -62,6 +85,7 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>  
>  		ep = cxl_ep_load(iter, cxlmd);
>  		ep->next = down;
> +		cxl_init_ep_ports_aer(ep);
The comment above this is talking about various stuff, not including that it now
maps the aer registers. Probably need to add something if this is the appropriate
place to do it.
>  	}
>  
>  	/* Note: endpoint port component registers are derived from @cxlds */
> @@ -166,8 +190,6 @@ static int cxl_mem_probe(struct device *dev)
>  	else
>  		endpoint_parent = &parent_port->dev;
>  
> -	cxl_dport_init_ras_reporting(dport, dev);
> -
>  	scoped_guard(device, endpoint_parent) {
>  		if (!endpoint_parent->driver) {
>  			dev_err(dev, "CXL port topology %s not enabled\n",


