Return-Path: <linux-pci+bounces-21239-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9E2A31945
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 00:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24A5B1885AD7
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 23:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7D227293A;
	Tue, 11 Feb 2025 23:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MeoARZ3u"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D2027293C;
	Tue, 11 Feb 2025 23:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739314956; cv=none; b=ULRlc/vaw5/4x30YGFuwJyistZNjYdbiYQqaGL+vAQ1POKjargGu6eS3VVJmTGVAnHjsAxRwHDoh9LAYqlGCQm777pgHUV27s4Rd3mbr+sIbkAUD9bVH6Z0gV5A3qMgofo5eWO3aMGaDT6a4AnlMUjHZ38BqUSLHkgProTdk1F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739314956; c=relaxed/simple;
	bh=xQgsE9rA1Dgv6PH+aG++0LXJ52qEJWoMLGNX0KvlTpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L27WQfTW6OcOOVMbL0eh8okeLjftlvVkWI6dkXobHm8IyTyEt66VGnc6320cb0JSJoCOQkb3DLbhTFIh4nyHBGhRCm+Owh8SMvv1rpSPSOlHUeUmkRd957+TVSCJDV2hFG2+H5dcTWYwIb6dOcC/Ps0RveAYz0MYIZIa+xXbFrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MeoARZ3u; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739314955; x=1770850955;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=xQgsE9rA1Dgv6PH+aG++0LXJ52qEJWoMLGNX0KvlTpo=;
  b=MeoARZ3uwtAK9Z1lJT7gUBRLR6h6CwNDunAVTWoVfoSTgxsc2dNx3Txw
   FVb2zMW7dAAdg1d3g+OWCToGN7Q/ORsHOCbqR4P1KMiB7gwFZMx+CZJXH
   UjwiOMWUKAMinY9CBB9pRH8zcYl8756E/f0NIGRFWBxkl+4OzAXmEjKp1
   l4JZ40dMiw3P9FPsUqqIRwLRaAqSapx8ftAdogqIe+gYgkGut/tCgeW4u
   pgjU8/wy+u/Xg2Ag+DL2u41kQuwfhOpccDRhtuWghdY+ekI104cpmBpAe
   xEbKIZBnzr0WzQOIP+CoLYQjsyJAhwIaWAi+4qY6aIm5NdWEau4h06F2F
   g==;
X-CSE-ConnectionGUID: qg5EXiNeQiyuWspkkdr1Zw==
X-CSE-MsgGUID: 6VmcSf6QR/m296pD5pIPVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50179390"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="50179390"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 15:02:34 -0800
X-CSE-ConnectionGUID: dKfOVGqsQX2U6yTo21T2MQ==
X-CSE-MsgGUID: c9ppi4RKTW+GmuPX0y/r8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113127012"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.108.65]) ([10.125.108.65])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 15:02:32 -0800
Message-ID: <4fff3c86-090b-497e-a432-6f591502a84b@intel.com>
Date: Tue, 11 Feb 2025 16:02:24 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/17] cxl/pci: Map CXL PCIe Upstream Switch Port RAS
 registers
To: Terry Bowman <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-9-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250211192444.2292833-9-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/25 12:24 PM, Terry Bowman wrote:
> Add logic to map CXL PCIe Upstream Switch Port (USP) RAS registers.
> 
> Introduce 'struct cxl_regs' member into 'struct cxl_port' to cache a
> pointer to the CXL Upstream Port's mapped RAS registers.
> 
> Also, introduce cxl_uport_init_ras_reporting() to perform the USP RAS
> register mapping. This is similar to the existing
> cxl_dport_init_ras_reporting() but for USP devices.
> 
> The USP may have multiple downstream endpoints. Before mapping RAS
> registers check if the registers are already mapped.
> 
> Introduce a mutex for synchronizing accesses to the cached RAS
> mapping.

s/Introduce a mutex/Use the ras_init_mutex/ since it was introduced in the previous patch.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>

Just a minor comment below
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/pci.c | 19 ++++++++++++++++++-
>  drivers/cxl/cxl.h      |  4 ++++
>  drivers/cxl/mem.c      |  8 ++++++++
>  3 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 143c853a52c4..25513b9a8aff 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -775,6 +775,24 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>  	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>  }
>  
> +void cxl_uport_init_ras_reporting(struct cxl_port *port)
> +{
> +
> +	/* uport may have more than 1 downstream EP. Check if already mapped. */
> +	mutex_lock(&ras_init_mutex);

You can use guard() here. 

> +	if (port->uport_regs.ras) {
> +		mutex_unlock(&ras_init_mutex);
> +		return;
> +	}
> +
> +	port->reg_map.host = &port->dev;
> +	if (cxl_map_component_regs(&port->reg_map, &port->uport_regs,
> +				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
> +		dev_err(&port->dev, "Failed to map RAS capability\n");
> +	mutex_unlock(&ras_init_mutex);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, "CXL");
> +
>  /**
>   * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
>   * @dport: the cxl_dport that needs to be initialized
> @@ -801,7 +819,6 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>  				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
>  		dev_err(dport_dev, "Failed to map RAS capability\n");
>  	mutex_unlock(&ras_init_mutex);
> -
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 82d0a8555a11..49f29a3ef68e 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -581,6 +581,7 @@ struct cxl_dax_region {
>   * @parent_dport: dport that points to this port in the parent
>   * @decoder_ida: allocator for decoder ids
>   * @reg_map: component and ras register mapping parameters
> + * @uport_regs: mapped component registers
>   * @nr_dports: number of entries in @dports
>   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>   * @commit_end: cursor to track highest committed decoder for commit ordering
> @@ -602,6 +603,7 @@ struct cxl_port {
>  	struct cxl_dport *parent_dport;
>  	struct ida decoder_ida;
>  	struct cxl_register_map reg_map;
> +	struct cxl_component_regs uport_regs;
>  	int nr_dports;
>  	int hdm_end;
>  	int commit_end;
> @@ -755,8 +757,10 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>  
>  #ifdef CONFIG_PCIEAER_CXL
>  void cxl_dport_init_ras_reporting(struct cxl_dport *dport);
> +void cxl_uport_init_ras_reporting(struct cxl_port *port);
>  #else
>  static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport) { }
> +static inline void cxl_uport_init_ras_reporting(struct cxl_port *port) { }
>  #endif
>  
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 8c1144bbc058..541cabca434e 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -60,6 +60,7 @@ static bool dev_is_cxl_pci(struct device *dev, u32 pcie_type)
>  static void cxl_init_ep_ports_aer(struct cxl_ep *ep)
>  {
>  	struct cxl_dport *dport = ep->dport;
> +	struct cxl_port *port = ep->next;
>  
>  	if (dport) {
>  		struct device *dport_dev = dport->dport_dev;
> @@ -68,6 +69,13 @@ static void cxl_init_ep_ports_aer(struct cxl_ep *ep)
>  		    dev_is_cxl_pci(dport_dev, PCI_EXP_TYPE_ROOT_PORT))
>  			cxl_dport_init_ras_reporting(dport);
>  	}
> +
> +	if (port) {
> +		struct device *uport_dev = port->uport_dev;
> +
> +		if (dev_is_cxl_pci(uport_dev, PCI_EXP_TYPE_UPSTREAM))
> +			cxl_uport_init_ras_reporting(port);
> +	}
>  }
>  
>  static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,


