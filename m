Return-Path: <linux-pci+bounces-18210-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BDF9EDD1F
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 02:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4DB4167F6D
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 01:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189AE71747;
	Thu, 12 Dec 2024 01:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="MEAyikBU"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com [136.143.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F38F61FD7;
	Thu, 12 Dec 2024 01:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733967286; cv=pass; b=O4QPqoomx3ALJbucKc+AU5798wjgbeKpRilUcUtaUMeu8K32rgNz2dOPgISUvIMlvudQueSHi7K1KQ+BGln6+ZAWKREd9fnwBtZlCLdxC2KjMlEBQ0L5GvfIzqrfFIhCNhPHbpyuN1kj28qVLr+bzcoJviUI8dIhJCaRAG9Z+aY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733967286; c=relaxed/simple;
	bh=KLxWFaaDF+cDRTd2G/MCadupPbA8MQ8L6qx4g0pnmIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UwEBkj0wEGOEYV4LwAwEwbzYrNYNHHzYhCoP+b7h5uVWeg1ap8BetY5fY5pJIIIgRu6nnpgi5Y/cRuOkwxj0tnYynQZcMrLSA+OwRxwYmCrZ/XUvHEH85x6JvbAnU60DgHc4lAgJQ3k/Q789LiCufZl3mNqOv6dMBmgj/QTIbHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=MEAyikBU; arc=pass smtp.client-ip=136.143.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1733967266; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UwECDe0BrqCMGT3Tsai/M2obybX9neUccM5d6IX/mqsBDdAzcF1SXkzuQ+9/KrMXP3ytszI4r1SFDSLpQ/JxYLogIZZ+vuPu27aIhCL2sQqHBxob4ePqOkkKvkf8beoX2r88LSaofKbxTYuF18WnKBLZmZ9uoS3ND+Iz1Cgz7Ec=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733967266; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=/zAzYfeI6PSkHjCt6+l45ujLT/1wh28c6GqI9MqVE9k=; 
	b=BlkFqwwT7jwd5+TujYRdRNdprdxUambKwdFfw0GEnr5FOieUiys04byfcjnOJvwa6M/RL9HJUQNhckDGbSw/n/+WjHz6W2lS6nZDUkB55whqqisBOST2VVwwnYRQHuPn3fa2KNgKMSwF2YCPSftxbdezokI72MKMWmkkGw/RhoA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733967266;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To:Cc;
	bh=/zAzYfeI6PSkHjCt6+l45ujLT/1wh28c6GqI9MqVE9k=;
	b=MEAyikBUN4KtkedwY0CPGt7vD/FSkp1WOv0MZpvGlKbudHnY2nWuJAOsiz4Tm9dK
	2U50zlGUt/S3720RNT/bKEAW6zUFagdC8eGqmti3BSre2T/lJTAqWtoy2JsmkgupL4C
	TTuV4SVTgJpR8xDMkO4kvJbqbeJknV6iRoxFoDTo=
Received: by mx.zohomail.com with SMTPS id 1733967264986906.6878328457522;
	Wed, 11 Dec 2024 17:34:24 -0800 (PST)
Message-ID: <ef7d45cc-d5ed-4a76-a9af-52c2a423ead0@zohomail.com>
Date: Thu, 12 Dec 2024 09:34:19 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/15] PCI/AER: Modify AER driver logging to report CXL
 or PCIe bus error type
To: Terry Bowman <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, ming4.li@intel.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 PradeepVineshReddy.Kodamati@amd.com
References: <20241211234002.3728674-1-terry.bowman@amd.com>
 <20241211234002.3728674-5-terry.bowman@amd.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20241211234002.3728674-5-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227c741f4742d9ef0e0fb386338000004c7fb93fd456f8aefcef903ee1aff76f5bed377f8d51fab79:zu080112277a838a0372edc9d97d63627a000051e7e3d61a484978f27332cd6960e73c6fc115bf4911b8a48e:rf0801122b8692146451b7c785712ddf500000a048d575bfeca5188fcb442fe9f6b3587662d52a3a49287768cf49f9c2:ZohoMail
X-ZohoMailClient: External

On 12/12/2024 7:39 AM, Terry Bowman wrote:
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
> ---
>  drivers/pci/pcie/aer.c  | 14 ++++++++------
>  include/ras/ras_event.h |  9 ++++++---
>  2 files changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index fe6edf26279e..53e9a11f6c0f 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -699,13 +699,14 @@ static void __aer_print_error(struct pci_dev *dev,
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
> @@ -714,8 +715,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
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
> @@ -730,7 +731,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  	if (info->id && info->error_dev_num > 1 && info->id == id)
>  		pci_err(dev, "  Error of this Agent is reported first\n");
>  
> -	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
> +	trace_aer_event(dev_name(&dev->dev), bus_type, (info->status & ~info->mask),
>  			info->severity, info->tlp_header_valid, &info->tlp);
>  }
>  
> @@ -764,6 +765,7 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
>  void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  		   struct aer_capability_regs *aer)
>  {
> +	const char *bus_type = pcie_is_cxl(dev) ? "CXL"  : "PCIe";
>  	int layer, agent, tlp_header_valid = 0;
>  	u32 status, mask;
>  	struct aer_err_info info;
> @@ -798,7 +800,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  	if (tlp_header_valid)
>  		__print_tlp_header(dev, &aer->header_log);
>  
> -	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
> +	trace_aer_event(dev_name(&dev->dev), bus_type, (status & ~mask),
>  			aer_severity, tlp_header_valid, &aer->header_log);
>  }
>  EXPORT_SYMBOL_NS_GPL(pci_print_aer, CXL);
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

Hi Terry,


Patch #3 is using flexbus dvsec to identify CXL RP/USP/DSP. But per CXL r3.1 section 9.12.3 "Enumerating CXL RPs and DSPs", there may be a flexbus dvsec if CXL RP/DSP is in disconnect state or connecting to a PCIe device.

If a PCIe device connects to a CXL RP/DSP, and the CXL RP/DSP reports an error, the error log will be also "CXL Bus Type", is it expected? My understanding is that the CXL RP/DSP is working on PCIe mode.

If not, I think that setting "pci_dev->is_cxl" during cxl port enumeration and CXL device probing is another option.


Thanks

Ming


