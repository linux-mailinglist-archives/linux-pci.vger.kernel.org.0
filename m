Return-Path: <linux-pci+bounces-19723-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D271A1058C
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 12:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFB2A1887C21
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 11:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3926234CFC;
	Tue, 14 Jan 2025 11:35:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B562234CE3;
	Tue, 14 Jan 2025 11:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736854547; cv=none; b=dE53y6SKEcZo+3maX8xL7cmnvIiwaGhdgBGZx9eDsh2dmlRlSMUHPCQPMYU6WXWTThE+KeaNhM/+hfOB3S9OmIQiWVXizHSl8ORiEsOjvb5QEmja03HA4ZLfw88m85QdAcbpojMwbmFHeOf4Ue6AE7JXoBoTFBrPslOIlnkSMLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736854547; c=relaxed/simple;
	bh=7qsN2czOspw0M/1UYWJyHOzjbJ84qKVXSViX4JpMefA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J56agnjYE4kOZ9gfJoau+GvCXnq/l6lk0tagirq5nmoeCyhlBocBrLp3qKlkiajsZ/rV9GZaWEnRXVXGRrlZpR0x7o6PkC26AIQDGlO7kJIXQB7a849a6xscP1a0wxyoDvxNfv58ub60KFrJje0cCH/eTmzpHaqq1FLHZ6Cv6KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YXRpv2J1zz6M4Mc;
	Tue, 14 Jan 2025 19:33:59 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D8F3F140C72;
	Tue, 14 Jan 2025 19:35:42 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 14 Jan
 2025 12:35:42 +0100
Date: Tue, 14 Jan 2025 11:35:40 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>, <alucerop@amd.com>
Subject: Re: [PATCH v5 09/16] cxl/pci: Map CXL PCIe Upstream Switch Port RAS
 registers
Message-ID: <20250114113540.00006247@huawei.com>
In-Reply-To: <20250107143852.3692571-10-terry.bowman@amd.com>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
	<20250107143852.3692571-10-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
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

On Tue, 7 Jan 2025 08:38:45 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> Add logic to map CXL PCIe Upstream Switch Port (USP) RAS registers.
> 
> Introduce 'struct cxl_regs' member into 'struct cxl_port' to cache a
> pointer to the CXL Upstream Port's mapped RAS registers.
> 
> Also, introduce cxl_uport_init_ras_reporting() to perform the USP RAS
> register mapping. This is similar to the existing
> cxl_dport_init_ras_reporting() but for USP devices.
> 
> The USP may have multiple downstream endpoints. Before mapping AER
> registers check if the registers are already mapped.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/pci.c | 15 +++++++++++++++
>  drivers/cxl/cxl.h      |  4 ++++
>  drivers/cxl/mem.c      |  8 ++++++++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 1af2d0a14f5d..97e6a15bea88 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -773,6 +773,21 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>  	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>  }
>  
> +void cxl_uport_init_ras_reporting(struct cxl_port *port)
> +{
> +	/* uport may have more than 1 downstream EP. Check if already mapped. */

Is it worth a lockdep check in here on whatever lock is stoping this racing?

> +	if (port->uport_regs.ras)
> +		return;
> +
> +	port->reg_map.host = &port->dev;
> +	if (cxl_map_component_regs(&port->reg_map, &port->uport_regs,
> +				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
> +		dev_err(&port->dev, "Failed to map RAS capability.\n");
> +		return;
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, "CXL");
> +
>  /**
>   * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
>   * @dport: the cxl_dport that needs to be initialized
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 727429dfdaed..c51735fe75d6 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -601,6 +601,7 @@ struct cxl_dax_region {
>   * @parent_dport: dport that points to this port in the parent
>   * @decoder_ida: allocator for decoder ids
>   * @reg_map: component and ras register mapping parameters
> + * @uport_regs: mapped component registers
>   * @nr_dports: number of entries in @dports
>   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>   * @commit_end: cursor to track highest committed decoder for commit ordering
> @@ -621,6 +622,7 @@ struct cxl_port {
>  	struct cxl_dport *parent_dport;
>  	struct ida decoder_ida;
>  	struct cxl_register_map reg_map;
> +	struct cxl_component_regs uport_regs;
>  	int nr_dports;
>  	int hdm_end;
>  	int commit_end;
> @@ -773,8 +775,10 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
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
> index dd39f4565be2..97dbca765f4d 100644
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


