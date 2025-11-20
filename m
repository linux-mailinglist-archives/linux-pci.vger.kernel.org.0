Return-Path: <linux-pci+bounces-41710-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5C6C71AEE
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 02:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id E984B29761
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 01:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B18188CC9;
	Thu, 20 Nov 2025 01:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="PgQ/gjik"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49243.qiye.163.com (mail-m49243.qiye.163.com [45.254.49.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1558E433AD;
	Thu, 20 Nov 2025 01:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763602138; cv=none; b=DZdAwwlBROem6MOoEAsu3MD0pjtahrE3i/+7B+cdnp+/IAqsj7uDDLiBUo+OzrgS25bLQY++WQ3KLPZkCP0cjY5zgFKMtPKKGsWXiLszNpLLloXVH9GnJwolnE3z4BnYsHPFIAlQWwsRIBGwndxacL38UJPIKVOYQl+s/otP8+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763602138; c=relaxed/simple;
	bh=dSUJtz1OZi1Mgk4IrAfhIGS9zd/5sNXoDDMFvMcDNw8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NtXd1ROb2KAsGL+Zk8Q1y6sdwpvO6oQNI1+SBi5qC/hzdw09Fl5SDN3JP949y/OGpo8KqKpscKtvk4Aj4/1YmQKOnECvlbwUaHz0jjIkM9f74Qpch7eCblCi+5UhhTuMwAwCb8bXoQ7jj2Njjp2zBRcpC4f2cwsjQmY8EsjVbmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=PgQ/gjik; arc=none smtp.client-ip=45.254.49.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2a33f8a33;
	Thu, 20 Nov 2025 09:13:27 +0800 (GMT+08:00)
Message-ID: <40e3197b-1670-4b63-a973-98012bcc623a@rock-chips.com>
Date: Thu, 20 Nov 2025 09:13:24 +0800
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
Subject: Re: [PATCH 2/2] PCI: dwc: Do not return failure from
 dw_pcie_wait_for_link() if link is in Detect/Poll state
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
References: <20251119-pci-dwc-suspend-rework-v1-0-aad104828562@oss.qualcomm.com>
 <20251119-pci-dwc-suspend-rework-v1-2-aad104828562@oss.qualcomm.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20251119-pci-dwc-suspend-rework-v1-2-aad104828562@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a9ed2d08409cckunmad847a56105d11
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUNITlZMT0MdSB5OQxlKTx1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=PgQ/gjikTr3E9tJZa4Tws2sindIZNH7gCczGMElS93ZNBQ9l+imFana8+Iqdy1/gyGfSWB5hDFDc1aQMAeiuuhIiZehl/KFnKxanXB5Zy/Ldm2Og3QNQj+xA00KrJO2eUEYsvdGw8rBWrREaDPZ+yy9Q26TRh8D9KahOfw7b6/c=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=hBFy4CqxyNxqmQ7R7LnoEUquw+6MU9ghjMWCYtgpl3s=;
	h=date:mime-version:subject:message-id:from;

在 2025/11/20 星期四 2:10, Manivannan Sadhasivam 写道:
> dw_pcie_wait_for_link() API waits for the link to be up and returns failure
> if the link is not up within the 1 second interval. But if there was no
> device connected to the bus, then the link up failure would be expected.
> In that case, the callers might want to skip the failure in a hope that the
> link will be up later when a device gets connected.
> 
> One of the callers, dw_pcie_host_init() is currently skipping the failure
> irrespective of the link state, in an assumption that the link may come up
> later. But this assumption is wrong, since LTSSM states other than Detect
> and Poll during link training phase are considered to be fatal and the link
> needs to be retrained.
> 
> So to avoid callers making wrong assumptions, skip returning failure from
> dw_pcie_wait_for_link() if the link is in Detect or Poll state after
> timeout and also check the return value of the API in dw_pcie_host_init().
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>   drivers/pci/controller/dwc/pcie-designware-host.c | 8 +++++---
>   drivers/pci/controller/dwc/pcie-designware.c      | 8 ++++++++
>   2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 8fe3454f3b13..8c4845fd24aa 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -671,9 +671,11 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
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
> index c644216995f6..fe13c6b10ccb 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -651,6 +651,14 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>   	}
>   
>   	if (retries >= PCIE_LINK_WAIT_MAX_RETRIES) {
> +		/*
> +		 * If the link is in Detect or Poll state, it indicates that no
> +		 * device is connected. So return success to allow the device to
> +		 * show up later.
> +		 */
> +		if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_WAIT)
> +			return 0;

I'm afraid this might not be true. If there is no devices connected or
the device connected without power supplied, it means there is no
far-end pull-up termination resistor from TX view of RC. TX pulse 
detection signal from the RC side will not undergo voltage division, and
its LTSSM state machine will only toggle between
DW_PCIE_LTSSM_DETECT_QUIET and DW_PCIE_LTSSM_DETECT_ACT.


> +
>   		dev_info(pci->dev, "Phy link never came up\n");
>   		return -ETIMEDOUT;
>   	}
> 


