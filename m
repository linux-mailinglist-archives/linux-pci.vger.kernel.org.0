Return-Path: <linux-pci+bounces-44872-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A57D2175A
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 22:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A17A73019B48
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 21:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C7F3A8FED;
	Wed, 14 Jan 2026 21:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FOgViKac"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1F43A89CC;
	Wed, 14 Jan 2026 21:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768427611; cv=none; b=QmH9VY9fjWhSCY9el8TA1PvcHkfXzOrD9bctZVp8HW+dl666E0dQ6RlwgjwkWVCzKbUx+GTqp240mHnbSuXQafe0w17cA+1eB7Y3ASmeeu7CoL0MEfWYxB1f2UJkqRNjCpBDdc19Aq5mdejgo7PpFYR6n0mAxsrtrM7uQvXYPwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768427611; c=relaxed/simple;
	bh=0817zu49Eb3LrsDpqLRdDPTwyaKWj68qhWxUs2vxw4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OLVOM4GjhCmfN2eMcgBWvgluKgrvixudVniiZrkIRqupCwpYu64X6n7OMCx4uRhJEQktFHLM0YB0M36NbwwNIxBAyPKznBtR2eJGNs/RfUjtbHVCL8C55srp6vO4TVmOwhSes+E7mn4JvPtN3B58coaH6T+kjgXeR74c1alEOYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FOgViKac; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768427590; x=1799963590;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0817zu49Eb3LrsDpqLRdDPTwyaKWj68qhWxUs2vxw4I=;
  b=FOgViKacd3Qq8bAjNplvZBG6WYjICTKfq/Sn9Mz2XfDrkmM3VPFN5nps
   eSkvDmuOECefqM22KJH0IF3Wb6h24fjtX4gwJ+5UKDog2U1FE6EF9o204
   pnuDWlp0aNahKi9YctwFJmMtsLmaXS3+fISCKreThOZc6MPlO4DGAkaD1
   +JztpbXSkWB96Sk66e1NSroGTwmevI41Pb8lSHEOA8QQbAu/9cKH2vR/U
   RXeG4U4E+vS4qmC4BQX/+Xd57p/78ZDQE/KVFBqrK4wtP3oDRqQNpOY70
   Btldl4y6WfZ52YympWnqH2GrWMW5ez8wzgxjmyYPmDU3+H6E1LnrvuFQ7
   w==;
X-CSE-ConnectionGUID: 7cLl3C77RKKzXOr2pcv6yA==
X-CSE-MsgGUID: IDFcbm80RhCgtaGIjZMGbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="73368382"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="73368382"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 13:53:04 -0800
X-CSE-ConnectionGUID: DAK93CxLRwyfxTv2ItM7Tw==
X-CSE-MsgGUID: xYw9h9HySZexILI78W+Avw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="204407320"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.111.5]) ([10.125.111.5])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 13:53:02 -0800
Message-ID: <4dfe78ca-6bdf-4ddd-81b2-e82613a7e64f@intel.com>
Date: Wed, 14 Jan 2026 14:53:01 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 23/34] cxl: Map CXL Endpoint Port and CXL Switch Port
 RAS registers
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, vishal.l.verma@intel.com, alucerop@amd.com,
 ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-24-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260114182055.46029-24-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/14/26 11:20 AM, Terry Bowman wrote:
> In preparation for CXL VH (Virtual Host) topology protocol error handling,
> add RAS capability registered mapping for all ports in a CXL VH topology.
> This includes the RAS capabilities of Switch Upstream Ports, Switch
> Downstream Ports, Host Bridge Ports ("upstream"), and Root Ports
> ("downstream")
> 
> Update cxl_port_add_dport() to map the upstream RAS capability on first
> 'dport' attach, and downstream RAS capability on each 'dport' attach.
> Arrange for dport mappings to be released at del_dport() time.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> [djbw: reword changelog, fix devm handling]

drop the line above

DJ

> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> ---
> 
> Changes in v13->v14:
> - Correct message spelling (Terry)
> ---
>  drivers/cxl/core/port.c       |  2 +-
>  drivers/cxl/core/ras.c        | 11 +++++++++++
>  drivers/cxl/cxl.h             |  2 ++
>  drivers/cxl/cxlpci.h          |  4 ++++
>  drivers/cxl/port.c            | 37 +++++++++++++++++++++++++++++++++++
>  tools/testing/cxl/Kbuild      |  1 +
>  tools/testing/cxl/test/mock.c | 12 ++++++++++++
>  7 files changed, 68 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 2184c20af011..2c4e28e7975c 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1451,7 +1451,7 @@ static void del_dport(struct cxl_dport *dport)
>  {
>  	struct cxl_port *port = dport->port;
>  
> -	devm_release_action(&port->dev, unlink_dport, dport);
> +	devres_release_group(&port->dev, dport);
>  }
>  
>  static void del_dports(struct cxl_port *port)
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 84abcf90fa99..76ac567724e3 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -162,6 +162,17 @@ void devm_cxl_dport_ras_setup(struct cxl_dport *dport)
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_dport_ras_setup, "CXL");
>  
> +void devm_cxl_port_ras_setup(struct cxl_port *port)
> +{
> +	struct cxl_register_map *map = &port->reg_map;
> +
> +	map->host = &port->dev;
> +	if (cxl_map_component_regs(map, &port->regs,
> +				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
> +		dev_dbg(&port->dev, "Failed to map RAS capability\n");
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
> +
>  void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  {
>  	void __iomem *addr;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 46491046f101..805923693707 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -607,6 +607,7 @@ struct cxl_dax_region {
>   * @parent_dport: dport that points to this port in the parent
>   * @decoder_ida: allocator for decoder ids
>   * @reg_map: component and ras register mapping parameters
> + * @regs: mapped component registers
>   * @nr_dports: number of entries in @dports
>   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>   * @commit_end: cursor to track highest committed decoder for commit ordering
> @@ -628,6 +629,7 @@ struct cxl_port {
>  	struct cxl_dport *parent_dport;
>  	struct ida decoder_ida;
>  	struct cxl_register_map reg_map;
> +	struct cxl_component_regs regs;
>  	int nr_dports;
>  	int hdm_end;
>  	int commit_end;
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index e41bb93d583a..ef4496b4e55e 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -82,6 +82,7 @@ void cxl_cor_error_detected(struct pci_dev *pdev);
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state);
>  void devm_cxl_dport_ras_setup(struct cxl_dport *dport);
> +void devm_cxl_port_ras_setup(struct cxl_port *port);
>  #else
>  static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
>  
> @@ -93,6 +94,9 @@ static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport)
>  {
>  }
> +static inline void devm_cxl_port_ras_setup(struct cxl_port *port)
> +{
> +}
>  #endif
>  
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 8f8fc98c1428..0d6e010e21ca 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -176,11 +176,29 @@ static struct cxl_port *cxl_port_devres_group(struct cxl_port *port)
>  DEFINE_FREE(cxl_port_group_free, struct cxl_port *,
>  	    if (!IS_ERR_OR_NULL(_T)) devres_release_group(&(_T)->dev, _T))
>  
> +static struct cxl_dport *cxl_dport_devres_group(struct cxl_dport *dport)
> +{
> +	if (!devres_open_group(&dport->port->dev, dport, GFP_KERNEL))
> +		return ERR_PTR(-ENOMEM);
> +	return dport;
> +}
> +DEFINE_FREE(cxl_dport_group_free, struct cxl_dport *,
> +	if (!IS_ERR_OR_NULL(_T)) devres_release_group(&(_T)->port->dev, _T))
> +
>  static void cxl_port_group_close(struct cxl_port *port)
>  {
>  	devres_remove_group(&port->dev, port);
>  }
>  
> +/*
> + * Unlike the port group, that just facilitates unwind of setup failures, the
> + * dport group needs to stay live for del_dport() to reference.
> + */
> +static void cxl_dport_group_close(struct cxl_dport *dport)
> +{
> +	devres_close_group(&dport->port->dev, dport);
> +}
> +
>  static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
>  					    struct device *dport_dev)
>  {
> @@ -209,6 +227,13 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
>  		rc = devm_cxl_switch_port_decoders_setup(port);
>  		if (rc)
>  			return ERR_PTR(rc);
> +
> +		/*
> +		 * RAS setup is optional, either driver operation can continue
> +		 * on failure, or the device does not implement RAS registers.
> +		 */
> +		devm_cxl_port_ras_setup(port);
> +
>  		/*
>  		 * Note, when nr_dports returns to zero the port is unregistered
>  		 * and triggers cleanup. I.e. no need for open-coded release
> @@ -220,12 +245,24 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
>  	if (IS_ERR(new_dport))
>  		return new_dport;
>  
> +	/*
> +	 * Establish a group for all dport resources that need to be released
> +	 * when the dport is deleted.
> +	 */
> +	struct cxl_dport *dport_group __free(cxl_dport_group_free) =
> +		cxl_dport_devres_group(new_dport);
> +	if (IS_ERR(dport_group))
> +		return ERR_CAST(dport_group);
> +
>  	rc = cxl_dport_autoremove(new_dport);
>  	if (rc)
>  		return ERR_PTR(rc);
>  
> +	devm_cxl_dport_ras_setup(new_dport);
> +
>  	cxl_switch_parse_cdat(new_dport);
>  
> +	cxl_dport_group_close(no_free_ptr(dport_group));
>  	cxl_port_group_close(no_free_ptr(port_group));
>  
>  	dev_dbg(&port->dev, "dport[%d] id:%d dport_dev: %s added\n",
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 7250bedf0448..6c516019600e 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -13,6 +13,7 @@ ldflags-y += --wrap=devm_cxl_endpoint_decoders_setup
>  ldflags-y += --wrap=hmat_get_extended_linear_cache_size
>  ldflags-y += --wrap=cxl_add_dport_by_dev
>  ldflags-y += --wrap=devm_cxl_switch_port_decoders_setup
> +ldflags-y += --wrap=devm_cxl_port_ras_setup
>  
>  DRIVERS := ../../../drivers
>  CXL_SRC := $(DRIVERS)/cxl
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> index 8883357ee50d..a0b87bbb2f75 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -246,6 +246,18 @@ void __wrap_devm_cxl_dport_ras_setup(struct cxl_dport *dport)
>  }
>  EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_dport_ras_setup, "CXL");
>  
> +void __wrap_devm_cxl_port_ras_setup(struct cxl_port *port)
> +{
> +	int index;
> +	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
> +
> +	if (!ops || !ops->is_mock_port(port->uport_dev))
> +		devm_cxl_port_ras_setup(port);
> +
> +	put_cxl_mock_ops(index);
> +}
> +EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_port_ras_setup, "CXL");
> +
>  struct cxl_dport *__wrap_cxl_add_dport_by_dev(struct cxl_port *port,
>  					      struct device *dport_dev)
>  {


