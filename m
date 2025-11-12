Return-Path: <linux-pci+bounces-40966-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3BAC51242
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 09:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0F173A6660
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 08:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5022F9980;
	Wed, 12 Nov 2025 08:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="OQrlNibC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m15573.qiye.163.com (mail-m15573.qiye.163.com [101.71.155.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664AA2F12CA;
	Wed, 12 Nov 2025 08:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762936614; cv=none; b=eNYU5M2nrPwl91ITd+PQF8VvKK1lKq8mYNBiO7e0vtFLJdFvTRZJ45Dc+YNADEr9uXgN6iMLln2aaHx7Uo9p4aDEXwj4WlQJkt4G0/mlVLG0qVDWhHk1G8NZ4jKYArAuza4qm3RnaT/IEntzXrFZI9rcZef+a3eouBdvgYC+iwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762936614; c=relaxed/simple;
	bh=Sipvm/6HeiwNQ0RENEV6ehQdZ0dLq6Ls92vfVOazIAs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZdeAMlp8ZGUeoG1NlkEfesqxyoUMuo0e4gYljOk3eq4qpr0TrwmrP5ee5k5llhVysNxiCMmwx1F/REgg4N0GYem9hbXDV4P+VTuEhaZIgccGFN4rnfWZW2WkJ8YO/FfCDo9g6poH4PmLrXbdsnqCuh66HNrhFCUrOc9hog5jzQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=OQrlNibC; arc=none smtp.client-ip=101.71.155.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 29503293b;
	Wed, 12 Nov 2025 16:31:32 +0800 (GMT+08:00)
Message-ID: <ef433574-3e81-4636-82c8-9bc3552addca@rock-chips.com>
Date: Wed, 12 Nov 2025 16:31:30 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, pali@kernel.org, neil.armstrong@linaro.org,
 robh@kernel.org, jingoohan1@gmail.com, khilman@baylibre.com,
 jbrunet@baylibre.com, martin.blumenstingl@googlemail.com, cassel@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v6 1/2] PCI: Configure Root Port MPS during host probing
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org,
 kwilczynski@kernel.org, bhelgaas@google.com, helgaas@kernel.org,
 heiko@sntech.de, mani@kernel.org, yue.wang@Amlogic.com
References: <20251104165125.174168-1-18255117159@163.com>
 <20251104165125.174168-2-18255117159@163.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20251104165125.174168-2-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a7731027109cckunm3695c205155bc1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQklNSVZKGBkfHhlCQklCSRhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=OQrlNibCvuZayM7wDbAagcEJdfH7X7Q3cM6x97+7LQYx7k4r/CgTIBxxCMJ3Y3fvGNo5K6I52NbBbMcdb5R2ELbdSxTmrl+IoMlKzkcVNDrZPs9R8U4AlvAAIOr+HA4C22Kud5mpViQKRjgDZtrex+JDHEueUhSBWnW/n+bRq3E=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=qaMbRURJhLkvG/AVZ92aTWNCGETrMCxlf9HvH6rX52w=;
	h=date:mime-version:subject:message-id:from;

在 2025/11/05 星期三 0:51, Hans Zhang 写道:
> Current PCIe initialization logic may leave Root Ports (root bridges)
> operating with non-optimal Maximum Payload Size (MPS) settings. Existing
> code in pci_configure_mps() returns early for devices without an upstream
> bridge (!bridge) which includes Root Ports, so their MPS values remain
> at firmware/hardware defaults. This fails to utilize the controller's full
> capabilities, leading to suboptimal data transfer efficiency across the
> PCIe hierarchy.
> 
> With this patch, during the host controller probing phase:
> - When PCIe bus tuning is enabled (not PCIE_BUS_TUNE_OFF), and
> - The device is a Root Port without an upstream bridge (!bridge),
> The Root Port's MPS is set to its hardware-supported maximum value
> (128 << dev->pcie_mpss).
> 
> Note that this initial maximum MPS setting may be reduced later, during
> downstream device enumeration, if any downstream device does not suppor
> the Root Port's maximum MPS.
> 
> This change ensures Root Ports are properly initialized before downstream
> devices negotiate MPS, while maintaining backward compatibility via the
> PCIE_BUS_TUNE_OFF check.
> 

Tested-by: Shawn Lin <shawn.lin@rock-chips.com>

> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>   drivers/pci/probe.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 0ce98e18b5a8..2459def3af9b 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2196,6 +2196,18 @@ static void pci_configure_mps(struct pci_dev *dev)
>   		return;
>   	}
>   
> +	/*
> +	 * Unless MPS strategy is PCIE_BUS_TUNE_OFF (don't touch MPS at all),
> +	 * start off by setting Root Ports' MPS to MPSS. This only applies to
> +	 * Root Ports without an upstream bridge (root bridges), as other Root
> +	 * Ports will have downstream bridges. Depending on the MPS strategy
> +	 * and MPSS of downstream devices, the Root Port's MPS may be
> +	 * overridden later.
> +	 */
> +	if (!bridge && pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
> +	    pcie_bus_config != PCIE_BUS_TUNE_OFF)
> +		pcie_set_mps(dev, 128 << dev->pcie_mpss);
> +
>   	if (!bridge || !pci_is_pcie(bridge))
>   		return;
>   


