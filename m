Return-Path: <linux-pci+bounces-24865-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12ED1A73752
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 17:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAE40189733A
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 16:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0E81CB51F;
	Thu, 27 Mar 2025 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaXfXoIA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562501E868;
	Thu, 27 Mar 2025 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743094101; cv=none; b=fp0LpdUNspC054Xp+Au2FWd8nHvkvvEgqMDCUaN1THaoyhvyJw30zjPxTU/ijZUgVZvvcQkOJab8vc15QB+XdeZ8ptevoGBVP9Yb8hX86SPizqvzRm5KrKYCF0W7OJ+Bdy9Yzv58yiBG+Ydj5UUWa7qAdg0+KClfQZla7YzVnIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743094101; c=relaxed/simple;
	bh=ozTsWxuVbaBY2ew+js0fYYaWIw6qw/smGBEe33X73DE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aX362oFk3OvhGwQS474r3JXIttK0CqN6dMX3ZJZ+HqjNAHnRl7LgtIng/rToukwfFSlUv6PJO+ZRaLhJR2HCOmEs6oOF89HAgHpLwpjd3oPS3LNsSv0aRiBfVDSpA7hRtCFS05MUejr/d5+zzM96hTDwJitrZOl+uqukc2mr4bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaXfXoIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A12C4CEDD;
	Thu, 27 Mar 2025 16:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743094100;
	bh=ozTsWxuVbaBY2ew+js0fYYaWIw6qw/smGBEe33X73DE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IaXfXoIApCuWdWzqRZE2dlvvk/kx0I9i++cln9b3PLhx6YMpzr0axalcMqbsMqwjX
	 y7Xc1WWKDrE5aKemA2hSRIDaDtVo2CAXHdfHIo/Ni+oNhfr0+GJ4MMEN4QECBynvAa
	 HK2PRgLlPbA+KW6/XPvj+/DmLW9K/GzvSb/sb2+8S1aJD2iCIJrQZ5YRAj2e79A7Kg
	 7VQhx7MClzZlcPzw2a07Js4WE4XKhz/ve0f9Jge813JSTqxr7iF6F+Q4u4jgp3nGlM
	 3LYb57nFNoLvg0/PKjYoj/OJJuywyIS8qs3z2kEEyac5W7o5ncVBYlpZtV/N2DS4HB
	 OhO1zDL1D1/+w==
Date: Thu, 27 Mar 2025 11:48:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
	ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
	rrichter@amd.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
Subject: Re: [PATCH v8 02/16] PCI/AER: Modify AER driver logging to report
 CXL or PCIe bus error type
Message-ID: <20250327164819.GA1435732@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327014717.2988633-3-terry.bowman@amd.com>

On Wed, Mar 26, 2025 at 08:47:03PM -0500, Terry Bowman wrote:
> The AER service driver and aer_event tracing currently log 'PCIe Bus Type'
> for all errors. Update the driver and aer_event tracing to log 'CXL Bus
> Type' for CXL device errors.
> 
> This requires the AER can identify and distinguish between PCIe errors and
> CXL errors.
> 
> Introduce boolean 'is_cxl' to 'struct aer_err_info'. Add assignment in
> aer_get_device_error_info() and pci_print_aer().
> 
> Update the aer_event trace routine to accept a bus type string parameter.

> +++ b/drivers/pci/pci.h
> @@ -533,6 +533,7 @@ static inline bool pci_dev_test_and_set_removed(struct pci_dev *dev)
>  struct aer_err_info {
>  	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
>  	int error_dev_num;
> +	bool is_cxl;
>  
>  	unsigned int id:16;
>  
> @@ -549,6 +550,11 @@ struct aer_err_info {
>  	struct pcie_tlp_log tlp;	/* TLP Header */
>  };
>  
> +static inline const char *aer_err_bus(struct aer_err_info *info)
> +{
> +	return info->is_cxl ? "CXL" : "PCIe";

I don't really see the point in adding struct aer_err_info.is_cxl.
Every place where we call aer_err_bus() to look at it, we also have
the struct pci_dev pointer, so we could just as easily use
pcie_is_cxl() here.

> +}
> +
>  int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
>  void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
>  
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 508474e17183..83f2069f111e 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -694,13 +694,14 @@ static void __aer_print_error(struct pci_dev *dev,
>  
>  void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  {
> +	const char *bus_type = aer_err_bus(info);
>  	int layer, agent;
>  	int id = pci_dev_id(dev);
>  	const char *level;
>  
>  	if (!info->status) {
> -		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
> -			aer_error_severity_string[info->severity]);
> +		pci_err(dev, "%s Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
> +			bus_type, aer_error_severity_string[info->severity]);
>  		goto out;
>  	}
>  
> @@ -709,8 +710,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  
>  	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
>  
> -	pci_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
> -		   aer_error_severity_string[info->severity],
> +	pci_printk(level, dev, "%s Bus Error: severity=%s, type=%s, (%s)\n",
> +		   bus_type, aer_error_severity_string[info->severity],
>  		   aer_error_layer[layer], aer_agent_string[agent]);
>  
>  	pci_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
> @@ -725,7 +726,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  	if (info->id && info->error_dev_num > 1 && info->id == id)
>  		pci_err(dev, "  Error of this Agent is reported first\n");
>  
> -	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
> +	trace_aer_event(dev_name(&dev->dev), bus_type, (info->status & ~info->mask),
>  			info->severity, info->tlp_header_valid, &info->tlp);
>  }
>  
> @@ -759,6 +760,7 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
>  void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  		   struct aer_capability_regs *aer)
>  {
> +	const char *bus_type;
>  	int layer, agent, tlp_header_valid = 0;
>  	u32 status, mask;
>  	struct aer_err_info info;
> @@ -780,6 +782,9 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  	info.status = status;
>  	info.mask = mask;
>  	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
> +	info.is_cxl = pcie_is_cxl(dev);
> +
> +	bus_type = aer_err_bus(&info);
>  
>  	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
>  	__aer_print_error(dev, &info);
> @@ -793,7 +798,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  	if (tlp_header_valid)
>  		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
>  
> -	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
> +	trace_aer_event(dev_name(&dev->dev), bus_type, (status & ~mask),
>  			aer_severity, tlp_header_valid, &aer->header_log);
>  }
>  EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
> @@ -1211,6 +1216,7 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>  	/* Must reset in this function */
>  	info->status = 0;
>  	info->tlp_header_valid = 0;
> +	info->is_cxl = pcie_is_cxl(dev);
>  
>  	/* The device might not support AER */
>  	if (!aer)
> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index e5f7ee0864e7..1bf8e7050ba8 100644
> --- a/include/ras/ras_event.h
> +++ b/include/ras/ras_event.h
> @@ -297,15 +297,17 @@ TRACE_EVENT(non_standard_event,
>  
>  TRACE_EVENT(aer_event,
>  	TP_PROTO(const char *dev_name,
> +		 const char *bus_type,
>  		 const u32 status,
>  		 const u8 severity,
>  		 const u8 tlp_header_valid,
>  		 struct pcie_tlp_log *tlp),
>  
> -	TP_ARGS(dev_name, status, severity, tlp_header_valid, tlp),
> +	TP_ARGS(dev_name, bus_type, status, severity, tlp_header_valid, tlp),
>  
>  	TP_STRUCT__entry(
>  		__string(	dev_name,	dev_name	)
> +		__string(	bus_type,	bus_type	)
>  		__field(	u32,		status		)
>  		__field(	u8,		severity	)
>  		__field(	u8, 		tlp_header_valid)
> @@ -314,6 +316,7 @@ TRACE_EVENT(aer_event,
>  
>  	TP_fast_assign(
>  		__assign_str(dev_name);
> +		__assign_str(bus_type);
>  		__entry->status		= status;
>  		__entry->severity	= severity;
>  		__entry->tlp_header_valid = tlp_header_valid;
> @@ -325,8 +328,8 @@ TRACE_EVENT(aer_event,
>  		}
>  	),
>  
> -	TP_printk("%s PCIe Bus Error: severity=%s, %s, TLP Header=%s\n",
> -		__get_str(dev_name),
> +	TP_printk("%s %s Bus Error: severity=%s, %s, TLP Header=%s\n",
> +		__get_str(dev_name), __get_str(bus_type),
>  		__entry->severity == AER_CORRECTABLE ? "Corrected" :
>  			__entry->severity == AER_FATAL ?
>  			"Fatal" : "Uncorrected, non-fatal",
> -- 
> 2.34.1
> 

