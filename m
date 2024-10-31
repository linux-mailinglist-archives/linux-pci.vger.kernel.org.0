Return-Path: <linux-pci+bounces-15759-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89F29B8545
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 22:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66975281E27
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 21:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64061A76D5;
	Thu, 31 Oct 2024 21:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qtc8XRko"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F7016DEBD;
	Thu, 31 Oct 2024 21:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730410063; cv=none; b=F1QzcxK+TtkQ3KM536BPqHnNsPVoPg00Dw7HUZwRDNUrPaHmI5AUdTHIl+UpcGpUrfXIMdeP8tiNL5RJWEgIvRpiRXwQqGNDBHt5kmhbu0j06CsD6oLi4M/MO2Pl4K4DocVk/B8McgIsNiCjdgYRDzPCpayBlj0C8tO8Q8z2vLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730410063; c=relaxed/simple;
	bh=bl44WVmaUULL8B5ir/xE2s0B1QEu/rRZUJxn5ctU5rM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZhhKcZhupTq2rgooBe2kWhTCibM7a7VF0VwLuUlPB2bbHFEDL9qZIPWX/BvuFofuoFqnEVDnZlMd5xmFfg98OuevdrzmZrKvmYeLtd36s3GwHp4YC+p3RuFgeLX8POMEoDFCyW5QOwa1yds0d+pt/Ss+b7dFdjs5Cd2LErHaW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qtc8XRko; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so1925666b3a.1;
        Thu, 31 Oct 2024 14:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730410057; x=1731014857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gP3+/PsY3A1zi3YMA5waIl6JNl6hCrFJv9jzWk+G+kE=;
        b=Qtc8XRkox/SbRUs6q0IckEQD/Ggfy6CF+I1jmOAoO5x2HytyWHI/jGtCcOaf2OS8IX
         2VAurQVUFunrTch48mGaDghF1kFfA/ZrcN391iC1/mBGAqwo2czu1XRlIWxHWyR9grRJ
         eKvtx4qk2MYgywUvzf7dvz/Kbx6ZVljZebCGg3lM7Ob2eqzaGzvr4zQCeWNvyMRh5eBJ
         /G/6hLOxxK/jBw3zC2MuLQR+3O3EqEu6KWWRq6OZuIrU51BHV2NvpXWEBcGt0h+yYlJv
         eMO3l0QRszBLMPFbbxLG+bZrRZFyhrHaKkUCwZhNs8tBQV5FRmbJgB7kqACvy1QwFU8P
         3pDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730410057; x=1731014857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gP3+/PsY3A1zi3YMA5waIl6JNl6hCrFJv9jzWk+G+kE=;
        b=T3C4XfLrOSd94L9bDiJjvN0zY3sgKs5xHRcoOCC9oX3Q+ZKKT71aGaAMH4Bocygj2E
         TE/yZ97zjsZMtmM/OWj8Gu/fqK5a4UwGmvhSqL5GXMqsetPsvt+Ysdew8Gx/GOYYl7wm
         0pLXnyYStVZ47MMrGiUXjCcK/jaJIPl6sGh+2IRl0HHHkyUfDChD+TUy8YaKYI9WBQm1
         MYYAE+1pXMSDUZtgYL0wicU8Nq50ZWScUzNV9q6lCSNZ8sYODkPRH2nW0Q0lMa/xY0Hy
         EqP5i9Rb4Z4Pr1nlVUEDT3+AlyfnJQL9NDkBcFtYQMZOcao8zJpMTpzofb6Ha/zgRIBv
         MS+w==
X-Forwarded-Encrypted: i=1; AJvYcCUYQN2cRQHls1xnFLdmMPQVu+NtFwN4ERpgiBmZ9o9QKVnWc6ux3xZXPpcoDNcpc3Qs3oDVMs1igm13E6P2@vger.kernel.org, AJvYcCUcVBjjaQAKdf8sFPlc9LOLWweebPiotX3nVOz8YKe+AvBFifsb63b+Wu9ayUl/3zaWJgeD8l824BN1@vger.kernel.org, AJvYcCX4ClVjZO75No2KLusv7hdUWKqbmS/EOhsQ3dPiSegBaXmbuyrhjE3apeGzmw/9yhErwLw/UzFOm3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Q5nYBeIe6J0Ue8xvvByWnipGwkU9kmPxkFUy8dcHib/4l6c0
	lXCWHYVi+PSuPbNYr4zvRgOLPHD/dpnjp1jNc0nYmgg6Bry5/5I0kV3LGISs
X-Google-Smtp-Source: AGHT+IEtn2vH5K/i/Z0Zxb70H9baohg/vqBNTSMXA6kbOU6qTZSpjUSinMN8Yx3+Pjj4JKspzImLUg==
X-Received: by 2002:a05:6a20:a8a0:b0:1d9:167a:7890 with SMTP id adf61e73a8af0-1db94fbf902mr5710768637.11.1730410056810;
        Thu, 31 Oct 2024 14:27:36 -0700 (PDT)
Received: from fan ([2601:646:8f03:9fee:1a14:7759:606e:c90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1e572dsm1577741b3a.66.2024.10.31.14.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 14:27:36 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 31 Oct 2024 14:27:33 -0700
To: Terry Bowman <terry.bowman@amd.com>
Cc: ming4.li@intel.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, mahesh@linux.ibm.com, ira.weiny@intel.com,
	oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
	nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 04/14] PCI/AER: Modify AER driver logging to report
 CXL or PCIe bus error type
Message-ID: <ZyP2Rda-92qdfi-N@fan>
References: <20241025210305.27499-1-terry.bowman@amd.com>
 <20241025210305.27499-5-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025210305.27499-5-terry.bowman@amd.com>

On Fri, Oct 25, 2024 at 04:02:55PM -0500, Terry Bowman wrote:
> The AER driver and aer_event tracing currently log 'PCIe Bus Type'
> for all errors.
> 
> Update the driver and aer_event tracing to log 'CXL Bus Type' for CXL devices.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

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
> -- 
> 2.34.1
> 

-- 
Fan Ni

