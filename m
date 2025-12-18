Return-Path: <linux-pci+bounces-43292-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6620BCCBD4B
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 13:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DA0D302650B
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 12:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C1E223DC0;
	Thu, 18 Dec 2025 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="kiQNtBMv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m32101.qiye.163.com (mail-m32101.qiye.163.com [220.197.32.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2466623A9B0;
	Thu, 18 Dec 2025 12:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766061931; cv=none; b=QjEtccEvTErcX6aw6EiVoIMH/7Usywvy8dIyQDu4W3S/0t1eHUuCYcHPWHAkEDJ7N0KdZB7cdPhXyGNyKE4mbQ6uXeI056bQaIPHviS7K38ICAWNYomnARIq6iiPaeTRThst7I9TTrJfRcL+0fOHdpQ1YO/rvnaoPV6HfqDx7Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766061931; c=relaxed/simple;
	bh=05d3MkiqV0ug/CAdNc6GwqEAzSUcunrPprR3VH0lwRc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i4PjZCo3kgB4MKz7n5uxgGqnsFACTO8Zaolx9+of6agbHARsaJkzbQkMAXSQKMRtTJDmso5ZWfE4kRnOOwdds1YBBKdwEnsZ5hztLK+x7oBkhrGRBIz0bCF8K+bOtV+T195As0U/O9jCRxsHWQAPcDS3rBQB1wKH9dMpX4Uw1Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=kiQNtBMv; arc=none smtp.client-ip=220.197.32.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2dc247fa7;
	Thu, 18 Dec 2025 20:45:17 +0800 (GMT+08:00)
Message-ID: <0871c353-91b8-404a-9ca2-e2f662c6d98d@rock-chips.com>
Date: Thu, 18 Dec 2025 20:45:15 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, vincent.guittot@linaro.org,
 zhangsenchuan@eswincomputing.com
Subject: Re: [PATCH v2 2/2] PCI: dwc: Do not return failure if link is in
 Detect.Quiet/Active states
To: manivannan.sadhasivam@oss.qualcomm.com, Jingoo Han
 <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
References: <20251218-pci-dwc-suspend-rework-v2-0-5a7778c6094a@oss.qualcomm.com>
 <20251218-pci-dwc-suspend-rework-v2-2-5a7778c6094a@oss.qualcomm.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20251218-pci-dwc-suspend-rework-v2-2-5a7778c6094a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b317e431209cckunma505557efef
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhgfSVZIHkxJS0pJSEJNGR5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=kiQNtBMvzcerGNoXVpxJ9DUyHvkyUmY/qAjV2rxA/7RaKQ3EDGdomi/hP1U/RuNQwbysdrXR1UCbmTP/ynKax4XteX9UjbJmN2M3rsx8WdETqsQu4FrWK/iHT/8V1oix+2MLbNSJ9Ai00Oxyucw/BAEH3f/+oRe6p86aOzlfmlc=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=X3plait/HMLRJzGuMV4lzFhS4lkzINok7tJu0WtFxFA=;
	h=date:mime-version:subject:message-id:from;

在 2025/12/18 星期四 20:04, Manivannan Sadhasivam via B4 Relay 写道:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> dw_pcie_wait_for_link() API waits for the link to be up and returns failure
> if the link is not up within the 1 second interval. But if there was no
> device connected to the bus, then the link up failure would be expected.
> In that case, the callers might want to skip the failure in a hope that the
> link will be up later when a device gets connected.
> 
> One of the callers, dw_pcie_host_init() is currently skipping the failure
> irrespective of the link state, in an assumption that the link may come up
> later. But this assumption is wrong, since LTSSM states other than
> Detect.Quiet and Detect.Active during link training phase are considered to
> be fatal and the link needs to be retrained.
> 
> So to avoid callers making wrong assumptions, skip returning failure from
> dw_pcie_wait_for_link() only if the link is in Detect.Quiet or
> Detect.Active states after timeout and also check the return value of the
> API in dw_pcie_host_init().
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>   drivers/pci/controller/dwc/pcie-designware-host.c |  8 +++++---
>   drivers/pci/controller/dwc/pcie-designware.c      | 12 +++++++++++-
>   2 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 43d091128ef7..ef6d9ae6eddb 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -670,9 +670,11 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>   	 * If there is no Link Up IRQ, we should not bypass the delay
>   	 * because that would require users to manually rescan for devices.
>   	 */
> -	if (!pp->use_linkup_irq)
> -		/* Ignore errors, the link may come up later */
> -		dw_pcie_wait_for_link(pci);
> +	if (!pp->use_linkup_irq) {
> +		ret = dw_pcie_wait_for_link(pci);
> +		if (ret)
> +			goto err_stop_link;
> +	}
>   
>   	ret = pci_host_probe(bridge);
>   	if (ret)
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 75fc8b767fcc..b58baf26ce58 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -641,7 +641,7 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index)
>   
>   int dw_pcie_wait_for_link(struct dw_pcie *pci)
>   {
> -	u32 offset, val;
> +	u32 offset, val, ltssm;
>   	int retries;
>   
>   	/* Check if the link is up or not */
> @@ -653,6 +653,16 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>   	}
>   
>   	if (retries >= PCIE_LINK_WAIT_MAX_RETRIES) {
> +		/*
> +		 * If the link is in Detect.Quiet or Detect.Active state, it
> +		 * indicates that no device is detected. So return success to
> +		 * allow the device to show up later.
> +		 */
> +		ltssm = dw_pcie_get_ltssm(pci);
> +		if (ltssm == DW_PCIE_LTSSM_DETECT_QUIET ||
> +		    ltssm == DW_PCIE_LTSSM_DETECT_ACT)
> +			return 0;

By looking more closely, this changes the behaviour of pcie-tegra194.c
which relies on it in tegra_pcie_dw_start_link() to do some retries.

pcie-intel-gw.c/pci-imx6.c also continue to do some setups in this case,
not sure if it's safe.

> +
>   		dev_info(pci->dev, "Phy link never came up\n");
>   		return -ETIMEDOUT;
>   	}
> 


