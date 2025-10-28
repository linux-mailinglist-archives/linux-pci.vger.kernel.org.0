Return-Path: <linux-pci+bounces-39485-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA606C12365
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 01:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB0334F2380
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 00:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C591DF246;
	Tue, 28 Oct 2025 00:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="MVjyAjJL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m15579.qiye.163.com (mail-m15579.qiye.163.com [101.71.155.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617557405A;
	Tue, 28 Oct 2025 00:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761612094; cv=none; b=gqr3AfOUpJ6gpet3uZwYZtOPxSpheJo11243pKHcbVf5Mveb8mKe72qTaJbNhl6uHU478xxhfOdlrmu12DOsPxejU2N/BnxUNn8pF5Ngy0Xuezfn6kY8vi4H+VKuMcJUGz9FmluxsZg5H01wzIq6lsk3+p1QePXSW+xH5GTvOQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761612094; c=relaxed/simple;
	bh=TJ1Up/1bYs8liQ5I6qAwrj0HRSLMn+C0XKElX/dALfk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i/ov5qrdEFDs9uPGkOr+DCNYwnKTYCPREBkjEmxDWWcomaEoPH5hEkh8aOjKEdQAspjIW9ksgJwn/P63WYB25PlpLPXaWPKmewdeZDlaPo1I8+VCnhYI/hfeAN9IjsWIJrsZ80Epk4gElEWROBCiBJesDyMYOVyXnv+sRYEV1FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=MVjyAjJL; arc=none smtp.client-ip=101.71.155.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 27641a992;
	Tue, 28 Oct 2025 08:26:08 +0800 (GMT+08:00)
Message-ID: <4fe0ccf9-8866-443a-8083-4a2af7035ee6@rock-chips.com>
Date: Tue, 28 Oct 2025 08:26:05 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com
Subject: Re: [PATCH v1 1/2] PCI: dw-rockchip: Add remove callback for resource
 cleanup
To: Anand Moon <linux.amoon@gmail.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
 Niklas Cassel <cassel@kernel.org>, Hans Zhang <18255117159@163.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
 <linux-pci@vger.kernel.org>,
 "moderated list:ARM/Rockchip SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20251027145602.199154-1-linux.amoon@gmail.com>
 <20251027145602.199154-2-linux.amoon@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20251027145602.199154-2-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a28353b1709cckunm5714e79495b73
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUtDHlZMT0tJSU9CSEsfGhhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=MVjyAjJLoKqFruf/2T8UTkdFxaaY1HLRIzik5UoO+bPgLPabD6cwVDYphWLLcTcg1zKklhAqtFdqx48TtcbK1a9MXPQuuoR0mM0N1HHZSJmd+0x7IsDhaokWGwjR3VlWLoquao1g1pe6uM8UlxJDqOxLD2g9W84vG9UdDLDdHic=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=/01EZ5lMl59YI++li6XSVu0o5BZOK5sa3DWde3cS9iY=;
	h=date:mime-version:subject:message-id:from;

在 2025/10/27 星期一 22:55, Anand Moon 写道:
> Introduce a .remove() callback to the Rockchip DesignWare PCIe
> controller driver to ensure proper resource deinitialization during
> device removal. This includes disabling clocks and deinitializing the
> PCIe PHY.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 87dd2dd188b4..b878ae8e2b3e 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -717,6 +717,16 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>   	return ret;
>   }
>   
> +static void rockchip_pcie_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
> +
> +	/* Perform other cleanups as necessary */
> +	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
> +	rockchip_pcie_phy_deinit(rockchip);
> +}

Thanks for the patch.

Dou you need to call dw_pcie_host_deinit()?
And I think you should also try to mask PCIE_CLIENT_INTR_MASK_MISC and
remove the irq domain as well.

if (rockchip->irq_domain) {
	int virq, j;
	for (j = 0; j < PCI_NUM_INTX; j++) {
		virq = irq_find_mapping(rockchip->irq_domain, j);
		if (virq > 0)
			irq_dispose_mapping(virq);
         }
	irq_set_chained_handler_and_data(rockchip->irq, NULL, NULL);
	irq_domain_remove(rockchip->irq_domain);
}

Another thin I noticed is should we call pm_runtime_* here for hope that
genpd could be powered donw once removed?


> +
>   static const struct rockchip_pcie_of_data rockchip_pcie_rc_of_data_rk3568 = {
>   	.mode = DW_PCIE_RC_TYPE,
>   };
> @@ -754,5 +764,6 @@ static struct platform_driver rockchip_pcie_driver = {
>   		.suppress_bind_attrs = true,
>   	},
>   	.probe = rockchip_pcie_probe,
> +	.remove = rockchip_pcie_remove,
>   };
>   builtin_platform_driver(rockchip_pcie_driver);


