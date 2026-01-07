Return-Path: <linux-pci+bounces-44150-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C95CFCA87
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 09:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5204303F374
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 08:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9073B299950;
	Wed,  7 Jan 2026 08:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="FC9IsJ8c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49248.qiye.163.com (mail-m49248.qiye.163.com [45.254.49.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F712BE7BA;
	Wed,  7 Jan 2026 08:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767775172; cv=none; b=mw5lGs36fh83Jgtw/q09SNywYxx0xg2sasRtiyOYuIABJerkwsKnAWE3xxsviCrlUUe+5Jr4VDInltUw+0UNjKPCVy7kiNYLyrtibLJE5Bz6cou/Hdf8nzT45AKZV4f9IRFTYgB9TSv+XrUNBAW8cNeBINon0hsc5BPhDva30BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767775172; c=relaxed/simple;
	bh=oBM+I4wjGqFYCajE6vtvmNKKGjLGo1LECJiretFluYM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nvznvUQdVsnj4MVhjfGgP4RrUgT78QFhtOR5YU/2pVP2ReZNwd5KEgpDqwBqH1a4bUf7CyuYIDh7dngn5/1uTnFWoA6+XXenHcMSomRW3GYsY11aWbhKbEkZPEl1FZcKRzzSCTQNUJ3hXg9lHmQQuv44sHhSc2sU9uHwvg3um6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=FC9IsJ8c; arc=none smtp.client-ip=45.254.49.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2fcc8707f;
	Wed, 7 Jan 2026 16:39:25 +0800 (GMT+08:00)
Message-ID: <6f2a59ee-8e0c-4dbe-8007-bbe7686d46ac@rock-chips.com>
Date: Wed, 7 Jan 2026 16:39:24 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, vincent.guittot@linaro.org,
 zhangsenchuan@eswincomputing.com, Richard Zhu <hongxing.zhu@nxp.com>,
 Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v4 5/6] PCI: host-common: Add an API to check for any
 device under the Root Ports
To: manivannan.sadhasivam@oss.qualcomm.com, Jingoo Han
 <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
References: <20260107-pci-dwc-suspend-rework-v4-0-9b5f3c72df0a@oss.qualcomm.com>
 <20260107-pci-dwc-suspend-rework-v4-5-9b5f3c72df0a@oss.qualcomm.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260107-pci-dwc-suspend-rework-v4-5-9b5f3c72df0a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b979c5ce809cckunm563584268daa39
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUxLHVZIQx9LT08ZHU9JQxlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=FC9IsJ8cD43eS4C5FS998xES8fWL+kDGYJVhUL30BdHWAu8rFqGNOjvWxlx78uHQ+hHkkTti4tZq5QrPZMqRuMpS+8M7kWVS4Ro+UAkr8OzokBoQcIOiRc5P1UKqq3bztTVxfzrGWvUw2UAqEUZWAGeZf7AvJ1DCMlkiCDYyYsw=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=pgSlk2tOJLRCGRDhosB3XhGaMeRZmE44GyEtP9T5NHA=;
	h=date:mime-version:subject:message-id:from;


在 2026/01/07 星期三 16:11, Manivannan Sadhasivam via B4 Relay 写道:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> Some controller drivers need to check if there is any device available
> under the Root Ports. So add an API that returns 'true' if a device is
> found under any of the Root Ports, 'false' otherwise.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>   drivers/pci/controller/pci-host-common.c | 21 +++++++++++++++++++++
>   drivers/pci/controller/pci-host-common.h |  2 ++
>   2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> index c473e7c03bac..a88622203227 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c
> @@ -17,6 +17,27 @@
>   
>   #include "pci-host-common.h"
>   
> +/**
> + * pci_root_ports_have_device - Check if the Root Ports under the Root bus have
> + *				any device underneath
> + * @root_bus: Root bus to check for
> + *
> + * Return: true if a device is found, false otherwise
> + */
> +bool pci_root_ports_have_device(struct pci_bus *root_bus)
> +{
> +	struct pci_bus *child;
> +
> +	/* Iterate over the Root Port busses and look for any device */
> +	list_for_each_entry(child, &root_bus->children, node) {
> +		if (!list_empty(&child->devices))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(pci_root_ports_have_device);
> +
>   static void gen_pci_unmap_cfg(void *ptr)
>   {
>   	pci_ecam_free((struct pci_config_window *)ptr);
> diff --git a/drivers/pci/controller/pci-host-common.h b/drivers/pci/controller/pci-host-common.h
> index b5075d4bd7eb..8088faf94282 100644
> --- a/drivers/pci/controller/pci-host-common.h
> +++ b/drivers/pci/controller/pci-host-common.h
> @@ -20,4 +20,6 @@ void pci_host_common_remove(struct platform_device *pdev);
>   
>   struct pci_config_window *pci_host_common_ecam_create(struct device *dev,
>   	struct pci_host_bridge *bridge, const struct pci_ecam_ops *ops);
> +
> +bool pci_root_ports_have_device(struct pci_bus *root_bus);
>   #endif
> 


