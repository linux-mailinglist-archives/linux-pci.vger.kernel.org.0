Return-Path: <linux-pci+bounces-41712-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD20C71CD2
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 03:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1C5C0344972
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 02:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D893A22CBC0;
	Thu, 20 Nov 2025 02:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ZNcpIKGa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49242.qiye.163.com (mail-m49242.qiye.163.com [45.254.49.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5C821D58B;
	Thu, 20 Nov 2025 02:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763604938; cv=none; b=mY8ozG5H63ijtXThPuWL010QO4Ge6pAd/QpFmyhTFeOeVFFU9rHC8ORBCEH2/yq0W7uy+Bmur79YRdsQOMhCmDVg3cLWyp4zXkXvqfY88JFHbZayIu05ofr+hlLnW431d6midOydWb0UUyKxrU8tIIE/U3I2cIHGTN5eEz4TqyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763604938; c=relaxed/simple;
	bh=UL8sTm43NeZAhEYB4lKuH440ib+PbQmutrqcom2cnsc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iUC8o8dyF0KidE2Hf4s+m2xpMa8L1mZK/i2Yu6fRhDOdWamd1c1M0RH2NTNxaGJncw5tmgMH2BvHF+Sjf3fzT1msjT1u0xMNgrIWSu8PTHYqDAOWG1Km7PNqRAZJWsXL31UeZxETQPYKSME1+9MvAuFtWMP/1jsagWpRsVLFjUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ZNcpIKGa; arc=none smtp.client-ip=45.254.49.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2a338ae48;
	Thu, 20 Nov 2025 08:59:50 +0800 (GMT+08:00)
Message-ID: <278991f2-69a1-46a2-83a3-4af212255e2f@rock-chips.com>
Date: Thu, 20 Nov 2025 08:59:46 +0800
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
Subject: Re: [PATCH 1/2] PCI: dwc: Skip PME_Turn_Off broadcast and L2/L3
 transition during suspend if link is not up
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
References: <20251119-pci-dwc-suspend-rework-v1-0-aad104828562@oss.qualcomm.com>
 <20251119-pci-dwc-suspend-rework-v1-1-aad104828562@oss.qualcomm.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20251119-pci-dwc-suspend-rework-v1-1-aad104828562@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a9ec6579209cckunm91b0f514102e20
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0IdHVYaQkkaSxpLSRkfTUpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ZNcpIKGa1n+T6KB9zhoZUvpPzplfzr2g4FO7+ena7u09pt3N7nVxnID0HUiQv0Ot6W7cgjGw7acUENxgyN6SgBF8m7Vog30aKT/VplUMj7xVkKnBibvCVzRnWdLNlH3zKuHKGSmF9PlpHY9Hx3FUTaqhV5Uk/6SPtWyav2TCcCs=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=om+XrfwotQrdKk/BOGxUHzlcB6vGxswl2wuDRmWg9wM=;
	h=date:mime-version:subject:message-id:from;

在 2025/11/20 星期四 2:10, Manivannan Sadhasivam 写道:
> During system suspend, if the PCIe link is not up, then there is no need
> to broadcast PME_Turn_Off message and wait for L2/L3 transition. So skip
> them.
> 

Review-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>   drivers/pci/controller/dwc/pcie-designware-host.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 20c9333bcb1c..8fe3454f3b13 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1129,6 +1129,9 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>   	u32 val;
>   	int ret;
>   
> +	if (!dw_pcie_link_up(pci))
> +		goto stop_link;
> +
>   	/*
>   	 * If L1SS is supported, then do not put the link into L2 as some
>   	 * devices such as NVMe expect low resume latency.
> @@ -1162,6 +1165,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>   	 */
>   	udelay(1);
>   
> +stop_link:
>   	dw_pcie_stop_link(pci);
>   	if (pci->pp.ops->deinit)
>   		pci->pp.ops->deinit(&pci->pp);
> 


