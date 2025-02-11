Return-Path: <linux-pci+bounces-21222-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A577A316A4
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 21:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FAF4167347
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD012262D39;
	Tue, 11 Feb 2025 20:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n53VJ4+3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32E2262D37;
	Tue, 11 Feb 2025 20:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739305721; cv=none; b=NMn7uhwDT7aBHQt7lytwUxF3z+Dr6i9Cnl87mSq4IMzQZccrJF6G0RBnwvtpN1GXvZ+MBw8ALKG69luhVIVqcripz16vo67h7GnTrMHe/f2ygHsoz1GqdcSy9uZvXYF738QX2CVcAuyMiMDjbjQES7UpjsyjDcRxbmG8As0H5WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739305721; c=relaxed/simple;
	bh=C/Qeh8Ueaw+4SuamVpmsqX+rqg3HpQ27Q/yl4qsO10w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NzZmDkJpH3sUv0u+NC65M1RG1LqOwVeVKQs8hF/9pWnFAZBZAuZvZykqfKix2rOzr4LRWdl4Tvgjm+w+6ZnF326MhnsGBOO2qZI5bcZd11POImykLWVQijW0TtytGGCR4fie6Ewo+3MPsbPhA1NJaKI2LTIE+M5zKE80bW8rIh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n53VJ4+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F084BC4CEDD;
	Tue, 11 Feb 2025 20:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739305721;
	bh=C/Qeh8Ueaw+4SuamVpmsqX+rqg3HpQ27Q/yl4qsO10w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=n53VJ4+3/m5ZqEyVGukeOk8fHgIihuokdT1g/ZuiiCTrnTScvnjayv8+UueGFvivX
	 ihtuHlXTgpr8+DFl26Sjqmu7kOYkHvufhP2/TnnFSnLy/dQDTATTaHenUy3K+MHqP5
	 s7dDXoRhAN1lvFmvEt0/YYTLfZLv2LBuHP9gt9z03583c/QroL4etY8mSuX2Dqy4Zz
	 XmFmjiuLIoCp9zo+KUFWPKsdYNH988w/Qkb8aVjNHAVon5B2GRMHvRXnX3wtWQImhy
	 I9dSGppnskTLGNMxfSDKVKtfXN2u3BqTmrMnBLzjPH/4GhpJpbz9jQp12c01Ptgixj
	 kD5M7nNR1D/DA==
Date: Tue, 11 Feb 2025 14:28:39 -0600
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
Subject: Re: [PATCH v7 04/17] PCI/AER: Modify AER driver logging to report
 CXL or PCIe bus error type
Message-ID: <20250211202839.GA53936@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211192444.2292833-5-terry.bowman@amd.com>

On Tue, Feb 11, 2025 at 01:24:31PM -0600, Terry Bowman wrote:
> The AER driver and aer_event tracing currently log 'PCIe Bus Type'
> for all errors.
> 
> Update the driver and aer_event tracing to log 'CXL Bus Type' for CXL
> device errors.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pcie/aer.c  | 14 ++++++++------
>  include/ras/ras_event.h |  9 ++++++---
>  2 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 6e8de77d0fc4..f99a1c6fb274 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -694,13 +694,14 @@ static void __aer_print_error(struct pci_dev *dev,
>  
>  void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  {
> +	const char *bus_type = pcie_is_cxl(dev) ? "CXL"  : "PCIe";
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
> +	const char *bus_type = pcie_is_cxl(dev) ? "CXL"  : "PCIe";
>  	int layer, agent, tlp_header_valid = 0;
>  	u32 status, mask;
>  	struct aer_err_info info;
> @@ -793,7 +795,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  	if (tlp_header_valid)
>  		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
>  
> -	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
> +	trace_aer_event(dev_name(&dev->dev), bus_type, (status & ~mask),
>  			aer_severity, tlp_header_valid, &aer->header_log);
>  }
>  EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
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

