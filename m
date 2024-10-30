Return-Path: <linux-pci+bounces-15610-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E639B6713
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 16:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E036B2216D
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 15:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1F42139BF;
	Wed, 30 Oct 2024 15:13:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E44A1FCF40;
	Wed, 30 Oct 2024 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301196; cv=none; b=XiHtlHZ98mgFH26KJ6SolEP55OBHixP9lTdlhDTwjlbpxYsc9SQyFjCol1M4GxTKPkTApNReTDmQsJLFWc3jjeueX+GKgINr6OtMse84w04woa72IBiHiZohHUvg5oJ4wFgkjYtWO+lel0fuFDDudO9IZhH1yzPf6/zpiP3cSjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301196; c=relaxed/simple;
	bh=eGP89k2OWd5d7Pxbyxcn/I7TL7S78zbAyyD/JGiIBFg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2Mska9PEI/A6NN+ATN1nvjrYBS7bbE61SA0iaLnR6WRmbf74Q5o9+066P6kxCidSuEK5i61z6QoMdz5MuEFLRT1+Hc1SjCkyHACBkhfMgBaRp+M06GzpK/CWjpmM6Ax2gsOmdhr5ZxYSN+zndL11LTkB8rhd8InSP7PSVnE7SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XdrFN1Z65z6HJgC;
	Wed, 30 Oct 2024 23:11:52 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9D84F140158;
	Wed, 30 Oct 2024 23:13:10 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Oct
 2024 16:13:09 +0100
Date: Wed, 30 Oct 2024 15:13:08 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v2 05/14] PCI/AER: Add CXL PCIe port correctable error
 support in AER service driver
Message-ID: <20241030151308.000005d5@Huawei.com>
In-Reply-To: <20241025210305.27499-6-terry.bowman@amd.com>
References: <20241025210305.27499-1-terry.bowman@amd.com>
	<20241025210305.27499-6-terry.bowman@amd.com>
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

On Fri, 25 Oct 2024 16:02:56 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> The AER service driver doesn't currently handle CXL protocol errors
> reported by CXL root ports, CXL upstream switch ports, and CXL downstream
> switch ports. Consequently, RAS protocol errors from CXL PCIe port devices
> are not properly logged or handled.
> 
> These errors are reported to the OS via the root port's AER correctable
> and uncorrectable internal error fields. While the AER driver supports
> handling downstream port protocol errors in restricted CXL host (RCH) mode
> also known as CXL1.1, it lacks the same functionality for CXL PCIe ports
> operating in virtual hierarchy (VH) mode.
> 
> To address this gap, update the AER driver to handle CXL PCIe port device
> protocol correctable errors (CE).
> 
> Make this update alongside the existing downstream port RCH error handling
> logic, extending support to CXL PCIe ports in VH mode.
> 
> is_internal_error() is currently limited by CONFIG_PCIEAER_CXL kernel
> config. Update is_internal_error()'s function declaration such that it is
> always available regardless if CONFIG_PCIEAER_CXL kernel config is enabled
> or disabled.
> 
> The uncorrectable error (UCE) handling will be added in a future patch.
> 
> [1] CXL 3.1 Spec, 12.2.2 CXL Root Ports, Downstream Switch Ports, and
> Upstream Switch Ports
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
This is a fiddly patch to read, but that's at least partly diff going crazy
in a few places.

Anyhow, I think it is fine but I would call out that this changes
things so that the PCI error handlers are no longer called for CXL ports
if it's an internal error.

With a sentence on that:

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I'm not 100% convinced the path of separate handlers is the way to go
but we can always change things again if that doesn't work out.

Jonathan

> ---
>  drivers/pci/pcie/aer.c | 59 ++++++++++++++++++++++++++++--------------
>  1 file changed, 39 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 53e9a11f6c0f..1d3e5b929661 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -941,8 +941,15 @@ static bool find_source_device(struct pci_dev *parent,
>  	return true;
>  }
>  
> -#ifdef CONFIG_PCIEAER_CXL
> +static bool is_internal_error(struct aer_err_info *info)
> +{
> +	if (info->severity == AER_CORRECTABLE)
> +		return info->status & PCI_ERR_COR_INTERNAL;
>  
> +	return info->status & PCI_ERR_UNC_INTN;
> +}
> +
> +#ifdef CONFIG_PCIEAER_CXL

Diff was having fun.  Maybe put a blank line here? I think that's
what has tripped it up.

>  /**
>   * pci_aer_unmask_internal_errors - unmask internal errors
>   * @dev: pointer to the pcie_dev data structure
> @@ -994,14 +1001,6 @@ static bool cxl_error_is_native(struct pci_dev *dev)
>  	return (pcie_ports_native || host->native_aer);
>  }

> -

>  /**
> @@ -1115,8 +1131,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  
>  static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>  {
> -	cxl_handle_error(dev, info);
> -	pci_aer_handle_error(dev, info);
> +	if (is_internal_error(info) && handles_cxl_errors(dev))
> +		cxl_handle_error(dev, info);
> +	else
> +		pci_aer_handle_error(dev, info);
Whilst not calling this for the CXL cases probably makes sense and
given new code needs to be the case to avoid a double clear I think,
I would call that change out more explicitly in the patch description.
> +

>  	pci_dev_put(dev);
>  }
>  


