Return-Path: <linux-pci+bounces-38220-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC92BBDEBAF
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 15:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 721524F56D5
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 13:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC97F2A1BB;
	Wed, 15 Oct 2025 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="NsqCYHsQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6E71DB54C
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760534517; cv=none; b=VFh7ZUblss+c0XwFsay+BBsqKqmKKSlq7JEXA8YZlCx7ogiB4pnDjuA9IOTopnACQoqiPnFm/0aHlKFYRqKimi2QMU5rJ/wAe67aHrkHIkHgp01lHzTj4gpWfre0hsxZ1ujvKr3ViR2ZEHqzL6pIQB2+JnWHk1YgyjXeV7/j91c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760534517; c=relaxed/simple;
	bh=lx+4ZZbyP07kLsKxPOWmjCSj6/Il2kQYHYrkOKJHHrs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=p7lF7NvpmClGqUwD0LaVvBzTRePOQ3fqEpB58Fghi9vn2MtewrVpkYaI28CB+/vxGqX9Acr2QEE7IDWKRUugVi/KwYHkJmIovUD+HyL0u8vzcKjDbZAPk7bz/wZkr0qNQVtlY3QX4CszX10dHYi375NSKYnqdxqpWkv2ko+kgWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=NsqCYHsQ; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1760534511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cB7gx/NIINxbCV7LJysGuJALM4X4X2Ed1pRDevEC0Yc=;
	b=NsqCYHsQgak3teZHoiIhORNzuPFVKNtbPadFFR6lSUfeMPWsb6jrc7Xnc0HFZfsTGppI/u
	7akhYOOFH7W3nFHofPVpKT7FnMns6CDmmmyNQFljo93HzwlCpCPTq3kyz8IgdqM4MTMH+k
	rq7wm9dEwJnivZF1H9RSs+SR0xM3RqY5B4IZyDe+0AJQOCFHRZ2UHiDPRcbrOYAj/x1WL/
	1uoR9/JKsJ645jYZjodG9mDXpVa1qcf5EHDNU5B3YuY44dmHZPE+KF9vDCSgbk2ZZWJRNb
	7OQJW0zh+iDl8bXgN81k5zcNeZHh0t6i/aGAVvQDyS3YJim5DbantKb4fnE/yQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Oct 2025 15:21:48 +0200
Message-Id: <DDIXEBYPYJX8.2BPOQ14F816T2@cknow-tech.com>
Cc: "Damien Le Moal" <dlemoal@kernel.org>, "Dragan Simic"
 <dsimic@manjaro.org>, "FUKAUMI Naoki" <naoki@radxa.com>,
 <stable@vger.kernel.org>, "Manivannan Sadhasivam"
 <manivannan.sadhasivam@oss.qualcomm.com>, <linux-pci@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH] PCI: dw-rockchip: Disable L1 substates
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Niklas Cassel" <cassel@kernel.org>, "Lorenzo Pieralisi"
 <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Manivannan Sadhasivam" <mani@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Heiko
 Stuebner" <heiko@sntech.de>, "Simon Xue" <xxm@rock-chips.com>, "Kever Yang"
 <kever.yang@rock-chips.com>, "Shawn Lin" <shawn.lin@rock-chips.com>
References: <20251015123142.392274-2-cassel@kernel.org>
In-Reply-To: <20251015123142.392274-2-cassel@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed Oct 15, 2025 at 2:31 PM CEST, Niklas Cassel wrote:
> The L1 substates support requires additional steps to work, see e.g.
> section '11.6.6.4 L1 Substate' in the RK3588 TRM V1.0.

I visually compared '18.6.6 PCIe Power Management' of Part 2 V1.1
(20210301) of the RK3568 TRM with '11.6.6 PCIe Power Management' of
Part 2 V1.0 (20220309) of the RK3588 TRM.
AFAICT they are word for word the same ... until I got to 'Table 18-14
PCIe Interrupt Table' (RK3568) and 'Table 11-22 ...' (RK3588) where
there are differences. I don't understand enough of this material so I
would appreciate if you could take a look to see if that difference is
or could be relevant.

TIA,
  Diederik

> These steps are currently missing from the driver.
>
> While this has always been a problem when using e.g.
> CONFIG_PCIEASPM_POWER_SUPERSAVE=3Dy, the problem became more apparent aft=
er
> commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for
> devicetree platforms"), which enabled ASPM also for
> CONFIG_PCIEASPM_DEFAULT=3Dy.
>
> Disable L1 substates until proper support is added.
>
> Cc: stable@vger.kernel.org
> Fixes: 0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip RK356X host control=
ler driver")
> Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for de=
vicetree platforms")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/=
controller/dwc/pcie-dw-rockchip.c
> index 3e2752c7dd09..28e0fffe2542 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -200,6 +200,26 @@ static bool rockchip_pcie_link_up(struct dw_pcie *pc=
i)
>  	return FIELD_GET(PCIE_LINKUP_MASK, val) =3D=3D PCIE_LINKUP;
>  }
> =20
> +/*
> + * See e.g. section '11.6.6.4 L1 Substate' in the RK3588 TRM V1.0 for th=
e steps
> + * needed to support L1 substates. Currently, not a single rockchip plat=
form
> + * performs these steps, so disable L1 substates until there is proper s=
upport.
> + */
> +static void rockchip_pcie_disable_l1sub(struct dw_pcie *pci)
> +{
> +	u32 cap, l1subcap;
> +
> +	cap =3D dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
> +	if (cap) {
> +		l1subcap =3D dw_pcie_readl_dbi(pci, cap + PCI_L1SS_CAP);
> +		l1subcap &=3D ~(PCI_L1SS_CAP_L1_PM_SS | PCI_L1SS_CAP_ASPM_L1_1 |
> +			      PCI_L1SS_CAP_ASPM_L1_2 | PCI_L1SS_CAP_PCIPM_L1_1 |
> +			      PCI_L1SS_CAP_PCIPM_L1_2);
> +		dw_pcie_writel_dbi(pci, cap + PCI_L1SS_CAP, l1subcap);
> +		l1subcap =3D dw_pcie_readl_dbi(pci, cap + PCI_L1SS_CAP);
> +	}
> +}
> +
>  static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
>  {
>  	u32 cap, lnkcap;
> @@ -264,6 +284,7 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp =
*pp)
>  	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
>  					 rockchip);
> =20
> +	rockchip_pcie_disable_l1sub(pci);
>  	rockchip_pcie_enable_l0s(pci);
> =20
>  	return 0;
> @@ -301,6 +322,7 @@ static void rockchip_pcie_ep_init(struct dw_pcie_ep *=
ep)
>  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>  	enum pci_barno bar;
> =20
> +	rockchip_pcie_disable_l1sub(pci);
>  	rockchip_pcie_enable_l0s(pci);
>  	rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);
> =20


