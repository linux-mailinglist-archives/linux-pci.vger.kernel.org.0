Return-Path: <linux-pci+bounces-22275-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A2BA4327E
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 02:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98557189AF52
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 01:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0DF11712;
	Tue, 25 Feb 2025 01:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Ce40YqQG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m155104.qiye.163.com (mail-m155104.qiye.163.com [101.71.155.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0816A33F
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 01:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740447337; cv=none; b=Bq62CI+uQjjV2i9KsIM695T4e7OJC7LFyvEexs47Fm9zcP2NXFe86wnwhCnSQV/hY+n0BT8SF+LPjGMl+rCjDINoF7fFlYwLWjAE1GkUYJ7NXd6rLkXEANRtZ8K8i3k0EvpBFOFqZvqiLsq3OgPMW3ZnK6lk5vhGF/EdwqyYiXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740447337; c=relaxed/simple;
	bh=H9Rstyx6ysiguREUndmXv6ap9Mz8u9IfLW0kiwjEVU0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PjLsM2EyfhX0j/nONpGucbrZUovB5ZSj5fH4QrcbBbB9uEoXX1MBHF4r2BK3c5jQ0g6x96vm6dwpdUj+fodS49OjTgrT1mfzHwCyB2JgIHO5EfCvbNE0Sjq86tQkaQ8cR0Cbi8QrAveoEgGjULkMMs4gGJJ1TItzrB5lNLHqlS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Ce40YqQG; arc=none smtp.client-ip=101.71.155.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.45] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id c1077187;
	Tue, 25 Feb 2025 09:35:22 +0800 (GMT+08:00)
Message-ID: <93cdce39-1ae6-4939-a3fc-db10be7564e5@rock-chips.com>
Date: Tue, 25 Feb 2025 09:35:22 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Damien Le Moal <dlemoal@kernel.org>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 2/2] PCI: dw-rockchip: hide broken ATS capability
To: Niklas Cassel <cassel@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>
References: <20250221202646.395252-3-cassel@kernel.org>
 <20250221202646.395252-4-cassel@kernel.org>
Content-Language: en-GB
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20250221202646.395252-4-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRgfSlZNQ0oaGU0aTh9LGRlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a953abe91f409cckunmc1077187
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mwg6Thw5DTIIKxEeQxEWOiEv
	P0wwCh5VSlVKTE9LT09MSElPSU1KVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQU9LS0k3Bg++
DKIM-Signature:a=rsa-sha256;
	b=Ce40YqQGRf1rwHhVMFysWNkvy7+RMtWiqnjH8k4P/B4ce9F917tbhazdTdT4/6nYEB5TmqyQO+AjmTVKG6x5xPH3Vi0QYI7M7Tgl8McRTGxqepYnRcvZPEKtXJLzHxquzTNcI05ahbWvmnNDZNPA7bnMn6266N+SwE3HxTPWXZA=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=1lhfqNwmlYPEmtkhry3f4Q6skAru1oITFPhiAonca38=;
	h=date:mime-version:subject:message-id:from;

On 2025/2/22 4:26, Niklas Cassel wrote:
> When running the rk3588 in endpoint mode, with an Intel host with IOMMU
> enabled, the host side prints:
> DMAR: VT-d detected Invalidation Time-out Error: SID 0
> 
> When running the rk3588 in endpoint mode, with an AMD host with IOMMU
> enabled, the host side prints:
> iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT device=63:00.0 address=0x42b5b01a0]
> 
> Usually, to handle these issues, we add a quirk for the PCI vendor and
> device ID in drivers/pci/quirks.c with quirk_no_ats(). That is because
> we cannot usually modify the capabilities on the EP side.
> 
> In this case, we can modify the capabilties on the EP side. Thus, hide the
> broken ATS capability on rk3588 when running in EP mode. That way,

Niklas, Thanks for reporting this issue. It's been a while before
getting confirmation from the design team. Now I can confirm the ATS 
support for RK3588 is only available running as RC but I'm still
requesting erratum about this issue if possible.

Acked-by: Shawn Lin <shawn.lin@rock-chips.com>

> we don't need any quirk on the host side, and we see no errors on the host
> side, and we can run pci_endpoint_test successfully, with the IOMMU
> enabled on the host side.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 46 +++++++++++++++++++
>   1 file changed, 46 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 836ea10eafbb..2be005c1a161 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -242,6 +242,51 @@ static const struct dw_pcie_host_ops rockchip_pcie_host_ops = {
>   	.init = rockchip_pcie_host_init,
>   };
>   
> +/*
> + * ATS does not work on rk3588 when running in EP mode.
> + * After a host has enabled ATS on the EP side, it will send an IOTLB
> + * invalidation request to the EP side. The rk3588 will never send a completion
> + * back and eventually the host will print an IOTLB_INV_TIMEOUT error, and the
> + * EP will not be operational. If we hide the ATS cap, things work as expected.
> + */
> +static void rockchip_pcie_ep_hide_broken_ats_cap_rk3588(struct dw_pcie_ep *ep)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	struct device *dev = pci->dev;
> +	unsigned int spcie_cap_offset, next_cap_offset;
> +	u32 spcie_cap_header, next_cap_header;
> +
> +	/* only hide the ATS cap for rk3588 running in EP mode */
> +	if (!of_device_is_compatible(dev->of_node, "rockchip,rk3588-pcie-ep"))
> +		return;
> +
> +	spcie_cap_offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_SECPCI);
> +	if (!spcie_cap_offset)
> +		return;
> +
> +	spcie_cap_header = dw_pcie_readl_dbi(pci, spcie_cap_offset);
> +	next_cap_offset = PCI_EXT_CAP_NEXT(spcie_cap_header);
> +
> +	next_cap_header = dw_pcie_readl_dbi(pci, next_cap_offset);
> +	if (PCI_EXT_CAP_ID(next_cap_header) != PCI_EXT_CAP_ID_ATS)
> +		return;
> +
> +	/* clear next ptr */
> +	spcie_cap_header &= ~GENMASK(31, 20);
> +
> +	/* set next ptr to next ptr of ATS_CAP */
> +	spcie_cap_header |= next_cap_header & GENMASK(31, 20);
> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +	dw_pcie_writel_dbi(pci, spcie_cap_offset, spcie_cap_header);
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +}
> +
> +static void rockchip_pcie_ep_pre_init(struct dw_pcie_ep *ep)
> +{
> +	rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);
> +}
> +
>   static void rockchip_pcie_ep_init(struct dw_pcie_ep *ep)
>   {
>   	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> @@ -314,6 +359,7 @@ rockchip_pcie_get_features(struct dw_pcie_ep *ep)
>   
>   static const struct dw_pcie_ep_ops rockchip_pcie_ep_ops = {
>   	.init = rockchip_pcie_ep_init,
> +	.pre_init = rockchip_pcie_ep_pre_init,
>   	.raise_irq = rockchip_pcie_raise_irq,
>   	.get_features = rockchip_pcie_get_features,
>   };


