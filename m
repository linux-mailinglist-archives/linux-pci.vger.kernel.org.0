Return-Path: <linux-pci+bounces-44151-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3149CFCAA5
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 09:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C87D3002D27
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 08:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23702DE6FC;
	Wed,  7 Jan 2026 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="A1ZIetzC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49211.qiye.163.com (mail-m49211.qiye.163.com [45.254.49.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359D17083C;
	Wed,  7 Jan 2026 08:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767775615; cv=none; b=VwlBcvB0kIxF1Q17RE0yU+0zTecxrBa8g7BgR0Qc1VAJSo+9i2IEvrwEcYcqzczc9E23a31gv/UWlbgNSIiZeC04aZpTLL2rXDRoeDZpdUWS+weKI9IuVzF9e2Cylq5hijHdpARETu2FV0NXKUVpGyb2jxPzLL3ld+ne9CBUwXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767775615; c=relaxed/simple;
	bh=SwhJvgMMuzvHajFL3jZrmdI7aOyPsCKmq3fRKgjq3j4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KN00M1oXd30EBFqI13FBuVZ0/JcSKWYU7yBRCa0uhRFk3ZM82x935baHWIOjcTRksDnDSRk/2ZmDB4W58xSxvG1nMcdmI3QDwe/r4s96LC/OJfizd1kLpoMMYguuvsC8soRhTqwgAtgVL5XNawbKW1pAFCJBMiVx0AfdAOECOX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=A1ZIetzC; arc=none smtp.client-ip=45.254.49.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2fcc8741a;
	Wed, 7 Jan 2026 16:41:34 +0800 (GMT+08:00)
Message-ID: <3bae58cb-cf60-487b-a056-0c0d7a85d05c@rock-chips.com>
Date: Wed, 7 Jan 2026 16:41:33 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, vincent.guittot@linaro.org,
 zhangsenchuan@eswincomputing.com, Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v4 6/6] PCI: dwc: Skip failure during
 dw_pcie_resume_noirq() if no device is available
To: manivannan.sadhasivam@oss.qualcomm.com, Jingoo Han
 <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
References: <20260107-pci-dwc-suspend-rework-v4-0-9b5f3c72df0a@oss.qualcomm.com>
 <20260107-pci-dwc-suspend-rework-v4-6-9b5f3c72df0a@oss.qualcomm.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260107-pci-dwc-suspend-rework-v4-6-9b5f3c72df0a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b979e534009cckunm86cf5ae48db346
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRoeT1ZDT0NMHkJJSE1KHk5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=A1ZIetzCuP2UCHY3Apt0yrCTiVom/95kH3NNJcuNy79dpULt4mmNgbqJcv3GUovKx0jatwi2aeYP7//iFHueMyUI9MRnCLJXh7VLko2zdfapIe1P7p5xAOT6XwMshOrIOFbniRNHUEhgWO8K27lG72M4TMwiZ0ZuHGS5Kzjkpb8=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=hPBAP0siFyQfFygqTu4pRiTMv/W6paLyxD9KvAqRJT8=;
	h=date:mime-version:subject:message-id:from;


在 2026/01/07 星期三 16:11, Manivannan Sadhasivam via B4 Relay 写道:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> If there is no device attached to any of the Root Ports available under the
> Root bus before suspend and during resume, then there is no point in
> returning failure.
> 
> So skip returning failure so that the resume succeeds and allow the device
> to get attached later.
> 
> If there was a device before suspend and not available during resume, then
> propagate the error to indicate that the device got removed during suspend.
> 

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>


> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>   drivers/pci/controller/dwc/pcie-designware-host.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index ccde12b85463..c30a2ed324cd 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -20,6 +20,7 @@
>   #include <linux/platform_device.h>
>   
>   #include "../../pci.h"
> +#include "../pci-host-common.h"
>   #include "pcie-designware.h"
>   
>   static struct pci_ops dw_pcie_ops;
> @@ -1227,6 +1228,7 @@ EXPORT_SYMBOL_GPL(dw_pcie_suspend_noirq);
>   
>   int dw_pcie_resume_noirq(struct dw_pcie *pci)
>   {
> +	struct dw_pcie_rp *pp = &pci->pp;
>   	int ret;
>   
>   	if (!pci->suspended)
> @@ -1234,23 +1236,28 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
>   
>   	pci->suspended = false;
>   
> -	if (pci->pp.ops->init) {
> -		ret = pci->pp.ops->init(&pci->pp);
> +	if (pp->ops->init) {
> +		ret = pp->ops->init(pp);
>   		if (ret) {
>   			dev_err(pci->dev, "Host init failed: %d\n", ret);
>   			return ret;
>   		}
>   	}
>   
> -	dw_pcie_setup_rc(&pci->pp);
> +	dw_pcie_setup_rc(pp);
>   
>   	ret = dw_pcie_start_link(pci);
>   	if (ret)
>   		return ret;
>   
>   	ret = dw_pcie_wait_for_link(pci);
> -	if (ret)
> -		return ret;
> +	/*
> +	 * Skip failure if there is no device attached to the bus now and before
> +	 * suspend. But the error should be returned if a device was attached
> +	 * before suspend and not available now.
> +	 */
> +	if (ret == -ENODEV && !pci_root_ports_have_device(pp->bridge->bus))
> +		return 0;
>   
>   	return ret;
>   }
> 


