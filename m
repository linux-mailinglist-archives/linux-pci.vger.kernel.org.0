Return-Path: <linux-pci+bounces-41792-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E393C747D8
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 15:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BE3E4F9C6B
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 14:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6248D346FA4;
	Thu, 20 Nov 2025 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="gmfJbkph"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49244.qiye.163.com (mail-m49244.qiye.163.com [45.254.49.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F65372ABC;
	Thu, 20 Nov 2025 14:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763647578; cv=none; b=ojSy/Z+5L7gXjqdhZhOepkLup4cmVh+7p2E6x/58+cYJObXh5xe8R0d0agONC0uV8kTfTOPycyymrKplhoHnfxDaW9O3eUpwnLXeEBZcNSeuH6s51L9GIV6O4K+xKUqt2Hs9Ny3rrnhGGToW07TuS1bQfoWlfMP1CWI5obHqxmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763647578; c=relaxed/simple;
	bh=OtqwL38os+XoI56FsTuwAkVeqQV4n6LkohjXXjWn47o=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ACWJP7As+5HAc9DraXXcWxfl6jUEpQrf2MOip9ch+bx7aDIQZdscGcTvL7brAmwOI806HiQ3DLxdq1ITneOZUEubEuXy79HiaqU3WncxzwNilpaoJ+k2o57yz5ttjyOc4XqLf65Dtpqe6YO6r0m3kcowBKAu/MxqLrL0DXe3lkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=gmfJbkph; arc=none smtp.client-ip=45.254.49.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2a4df038d;
	Thu, 20 Nov 2025 22:06:04 +0800 (GMT+08:00)
Message-ID: <dc8fb64e-fcb1-4070-9565-9b4c014a548f@rock-chips.com>
Date: Thu, 20 Nov 2025 22:06:03 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/5] PCI: dwc: Remove MSI/MSIX capability if iMSI-RX is
 used as MSI controller
To: Qiang Yu <qiang.yu@oss.qualcomm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
References: <20251109-remove_cap-v1-0-2208f46f4dc2@oss.qualcomm.com>
 <20251109-remove_cap-v1-3-2208f46f4dc2@oss.qualcomm.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20251109-remove_cap-v1-3-2208f46f4dc2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9aa1962c5a09cckunm2175d35518a447
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh0dTVZKTRkaHk5CTB9PTUpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=gmfJbkphhqrNNIomc2nRNNQpbwBqOecm14hbFaR9owhVo7pgBuuyQNhPR9bAe8kLUXyhS96bjUNgKJqBSOdIH0ijxNGs/txD4rmxCJEWI3OJiU5vdOPpvVb8XMzGb4l7/6kiIZyMjt/M8gST+crCzsZIGVBouE9GABIwZhbJXQ8=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=qgrWN+6oStccBz+gH14yX+AceYA2GbKqeLRXtbDzuU8=;
	h=date:mime-version:subject:message-id:from;

在 2025/11/10 星期一 14:59, Qiang Yu 写道:
> Some platforms may not support ITS (Interrupt Translation Service) and
> MBI (Message Based Interrupt), or there are not enough available empty SPI
> lines for MBI, in which case the msi-map and msi-parent property will not
> be provided in device tree node. For those cases, the DWC PCIe driver
> defaults to using the iMSI-RX module as MSI controller. However, due to
> DWC IP design, iMSI-RX cannot generate MSI interrupts for Root Ports even
> when MSI is properly configured and supported as iMSI-RX will only monitor
> and intercept incoming MSI TLPs from PCIe link, but the memory write
> generated by Root Port are internal system bus transactions instead of
> PCIe TLPs, so they are ignored.
> 
> This leads to interrupts such as PME, AER from the Root Port not received

This's true which also stops Rockchip's dwc IP from working with AER
service. But my platform can't work with AER service even with ITS support.

> on the host and the users have to resort to workarounds such as passing
> "pcie_pme=nomsi" cmdline parameter.

ack.

> 
> To ensure reliable interrupt handling, remove MSI and MSI-X capabilities
> from Root Ports when using iMSI-RX as MSI controller, which is indicated
> by has_msi_ctrl == true. This forces a fallback to INTx interrupts,
> eliminating the need for manual kernel command line workarounds.
> 
> With this behavior:
> - Platforms with ITS/MBI support use ITS/MBI MSI for interrupts from all
>    components.
> - Platforms without ITS/MBI support fall back to INTx for Root Ports and
>    use iMSI-RX for other PCI devices.
> 
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> ---
>   drivers/pci/controller/dwc/pcie-designware-host.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 20c9333bcb1c4812e2fd96047a49944574df1e6f..3724aa7f9b356bfba33a6515e2c62a3170aef1e9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1083,6 +1083,16 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>   
>   	dw_pcie_dbi_ro_wr_dis(pci);
>   
> +	/*
> +	 * If iMSI-RX module is used as the MSI controller, remove MSI and
> +	 * MSI-X capabilities from PCIe Root Ports to ensure fallback to INTx
> +	 * interrupt handling.
> +	 */
> +	if (pp->has_msi_ctrl) {

Isn't has_msi_ctrl means you have something like GIC-ITS
support instead of iMSI module? Am I missing anything?

> +		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSI);
> +		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSIX);

Will it make all devices connected to use INTx only?

> +	}
> +
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
> 


