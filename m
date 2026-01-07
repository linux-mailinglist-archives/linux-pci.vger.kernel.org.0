Return-Path: <linux-pci+bounces-44147-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C9BCFCA3C
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 09:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1ABEC304DE1B
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 08:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5E62BE7CD;
	Wed,  7 Jan 2026 08:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="jh1/fxxQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49248.qiye.163.com (mail-m49248.qiye.163.com [45.254.49.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BD823EAAF;
	Wed,  7 Jan 2026 08:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767774875; cv=none; b=ZIGFexMH5EYTipjkGe2+XueGJh9xt/E9YCtnJvESpq9pzJlHBmEUxuZQlOsSg6IGJR3KVPQe+JqSy4AThZwVKFJprBhBUHGD/K6qHbrYxFRRrop6UxUYndlytUoYLY6naZc4xokxPmIH4VNRTpnxQDVGV2tM4MAwIf2nC6pE7sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767774875; c=relaxed/simple;
	bh=Ib7Vo+1snLme0QubrAAtzZ2MmlP33mK/ThchODqGQAM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Dfd2xy+QrmGs6PcHnB0uccpisI3THpQGM6MBL+Roc/UDTQgTsaR24YhvuZ9dZYIEbzPc6LwkVNg4x81TnP5BZmF7vH5KUvXGgM/PDnGbBXhAJ+WfVJesNkLbbn+AQoZJ2hPjDJ4bQQgp2AGAhPwVj+lZs+jCTt/hC3G5ZxsrXFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=jh1/fxxQ; arc=none smtp.client-ip=45.254.49.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2fcc4d31e;
	Wed, 7 Jan 2026 16:34:21 +0800 (GMT+08:00)
Message-ID: <f9ccb38b-0471-4fe4-9492-2d8abd816a50@rock-chips.com>
Date: Wed, 7 Jan 2026 16:34:19 +0800
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
Subject: Re: [PATCH v4 1/6] PCI: dwc: Return -ENODEV from
 dw_pcie_wait_for_link() if device is not found
To: manivannan.sadhasivam@oss.qualcomm.com, Jingoo Han
 <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
References: <20260107-pci-dwc-suspend-rework-v4-0-9b5f3c72df0a@oss.qualcomm.com>
 <20260107-pci-dwc-suspend-rework-v4-1-9b5f3c72df0a@oss.qualcomm.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260107-pci-dwc-suspend-rework-v4-1-9b5f3c72df0a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b9797b72509cckunmd093752f8d79fd
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk5CHlYaTk4eGh4dGhhMShhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=jh1/fxxQXXE9lXqYFdIx5fAsKagGhH1g69vfLvWm3oBA3MetcwFNs/Ik28+ewVcfUefgFpEgmAE28yf3RuPlbhVcONKwF9hsoW416I2NK9Sx0+vvb9U5A1QCPCmde0L137Wctf479x7tcV6wzaLoh9jGvBbytlDPxyQkwzal70c=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=toK1h7MDOMWAG66eQYLU10yxE8AdwBl5P0A0dD2o5eg=;
	h=date:mime-version:subject:message-id:from;

在 2026/01/07 星期三 16:11, Manivannan Sadhasivam via B4 Relay 写道:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> The dw_pcie_wait_for_link() function waits up to 1 second for the PCIe link
> to come up and returns -ETIMEDOUT for all failures without distinguishing
> cases where no device is present on the bus. But the callers may want to
> just skip the failure if the device is not found on the bus and handle
> failure for other reasons.
> 
> So after timeout, if the LTSSM is in Detect.Quiet or Detect.Active state,
> return -ENODEV to indicate the callers that the device is not found on the
> bus and return -ETIMEDOUT otherwise.
> 
> Also add kernel doc to document the parameter and return values.
> 

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>   drivers/pci/controller/dwc/pcie-designware.c | 20 +++++++++++++++++++-
>   1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 345365ea97c7..55c1c60f7f8f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -692,9 +692,16 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index)
>   	dw_pcie_writel_atu(pci, dir, index, PCIE_ATU_REGION_CTRL2, 0);
>   }
>   
> +/**
> + * dw_pcie_wait_for_link - Wait for the PCIe link to be up
> + * @pci: DWC instance
> + *
> + * Returns: 0 if link is up, -ENODEV if device is not found, -ETIMEDOUT if the
> + * link fails to come up for other reasons.
> + */
>   int dw_pcie_wait_for_link(struct dw_pcie *pci)
>   {
> -	u32 offset, val;
> +	u32 offset, val, ltssm;
>   	int retries;
>   
>   	/* Check if the link is up or not */
> @@ -706,6 +713,17 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>   	}
>   
>   	if (retries >= PCIE_LINK_WAIT_MAX_RETRIES) {
> +		/*
> +		 * If the link is in Detect.Quiet or Detect.Active state, it
> +		 * indicates that no device is detected.
> +		 */
> +		ltssm = dw_pcie_get_ltssm(pci);
> +		if (ltssm == DW_PCIE_LTSSM_DETECT_QUIET ||
> +		    ltssm == DW_PCIE_LTSSM_DETECT_ACT) {
> +			dev_info(pci->dev, "Device not found\n");
> +			return -ENODEV;
> +		}
> +
>   		dev_info(pci->dev, "Phy link never came up\n");
>   		return -ETIMEDOUT;
>   	}
> 


