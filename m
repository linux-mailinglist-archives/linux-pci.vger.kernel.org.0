Return-Path: <linux-pci+bounces-40964-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A6BC51209
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 09:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2B234F27DC
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 08:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E752E6CD5;
	Wed, 12 Nov 2025 08:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="R3lDZxN7"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E582D1F4E
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762936238; cv=none; b=FB9gkax1WX13dR6HyltEJglud2PLEwbg17MB1ISn6azGtPfT7QwIo6kIAvddfBvgz1soTUIYZnqm0O5xSx4/81MiQ9acLOxY0RZOANJJp5Hry8Fm+r4S95G3vsmg/eV7sShilKlz4eUUdFrspRCCya4bE6BsoyJ8petDN4cifaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762936238; c=relaxed/simple;
	bh=lYrPa3tyj/Vqut8+F3y0A8q/Noq96C2wGzWhOXXiydg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ddp1j7EC3fik3Nxe9lFScJOXFzediQr6mWjICnnI6SBbSZoyte8P+9UT0QSTlJAgJ4XnxWOp1F49ka+UeA6f+dkFEQ0Fk5I0BUOxgF6MG0bZfayHCSo8e83EWT/VXPIjH1uqGR17jGn/WHnmM/roRUqH/3SiQkNxminNy/AJLBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=R3lDZxN7; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1762936223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g5x08jGt52UM8WSsG9ya+V4RgsZN+VKoptwBF5ItOqA=;
	b=R3lDZxN7sT6NE/Y5oVWLcfzs0503DA2ed4Jc0iohPyN+1aH3pcIqAC3kJUsjoomKtgi40u
	/CnJ3pRC1UlI9ViRoh5UhzQ1gIcaxQQoY/pDDeB2U56h0Y8hXonrwJQmSw9Xryn48245i2
	EUdyuSWN7FgwmD6HvyL3u/IsnlyxebpTtkRNfIlg7Szj7IflSNLjv3Ohitz0beKBhjp/NE
	QzRwavsPrhuFpy9JkVkBd3Tsyfq22XmGxSVjwlDclG9LPzTiw1BuZAC04sYeKfdp0DVaBC
	L0fG6rnOZfI3Qsl8qwBzBRotjPq03L5bEuiU7vgcNSVQdzXLyHbJ85RXNLFBnQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Nov 2025 09:30:19 +0100
Message-Id: <DE6KQEJ3S9R8.F3LC0FHN4GJ2@cknow-tech.com>
Cc: "Manivannan Sadhasivam" <mani@kernel.org>, "Lorenzo Pieralisi"
 <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Rob Herring" <robh@kernel.org>, "Heiko Stuebner"
 <heiko@sntech.de>, "Kever Yang" <kever.yang@rock-chips.com>, "Simon Xue"
 <xxm@rock-chips.com>, "Damien Le Moal" <dlemoal@kernel.org>, "Dragan Simic"
 <dsimic@manjaro.org>, "FUKAUMI Naoki" <naoki@radxa.com>, "Diederik de Haas"
 <diederik@cknow-tech.com>, "Richard Zhu" <hongxing.zhu@nxp.com>, "Frank Li"
 <Frank.li@nxp.com>, "Lucas Stach" <l.stach@pengutronix.de>, "Shawn Guo"
 <shawnguo@kernel.org>, "Sascha Hauer" <s.hauer@pengutronix.de>, "Fabio
 Estevam" <festevam@gmail.com>, "Conor Dooley" <conor@kernel.org>,
 "Krzysztof Kozlowski" <krzk@kernel.org>, "Thierry Reding"
 <thierry.reding@gmail.com>, "Jonathan Hunter" <jonathanh@nvidia.com>, "Hans
 Zhang" <hans.zhang@cixtech.com>, <linux-tegra@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <kernel@pengutronix.de>, "Bjorn
 Helgaas" <bhelgaas@google.com>
Subject: Re: [PATCH 3/4] PCI: dw-rockchip: Configure L1sub support
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Bjorn Helgaas" <helgaas@kernel.org>, "Niklas Cassel"
 <cassel@kernel.org>, "Shawn Lin" <shawn.lin@rock-chips.com>
References: <20251111221621.2208606-1-helgaas@kernel.org>
 <20251111221621.2208606-4-helgaas@kernel.org>
In-Reply-To: <20251111221621.2208606-4-helgaas@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Tue Nov 11, 2025 at 11:16 PM CET, Bjorn Helgaas wrote:
> From: Shawn Lin <shawn.lin@rock-chips.com>
>
> L1 PM Substates for RC mode require support in the dw-rockchip driver
> including proper handling of the CLKREQ# sideband signal. It is mostly
> handled by hardware, but software still needs to set the clkreq fields
> in the PCIE_CLIENT_POWER_CON register to match the hardware implementatio=
n.
>
> For more details, see section '18.6.6.4 L1 Substate' in the RK3658 TRM 1.=
1

s/RK3658/RK3568/

Sorry,
  Diederik

> Part 2, or section '11.6.6.4 L1 Substate' in the RK3588 TRM 1.0 Part2.
>
> Meanwhile, for the EP mode, we haven't prepared enough to actually suppor=
t
> L1 PM Substates yet. So disable it now until proper support is added late=
r.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> [bhelgaas: set pci->l1ss_support so DWC core preserves L1SS Capability bi=
ts;
> drop corresponding code here]
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Link: https://patch.msgid.link/1761187883-150120-1-git-send-email-shawn.l=
in@rock-chips.com
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/=
controller/dwc/pcie-dw-rockchip.c
> index 3e2752c7dd09..62a095752833 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -62,6 +62,12 @@
>  /* Interrupt Mask Register Related to Miscellaneous Operation */
>  #define PCIE_CLIENT_INTR_MASK_MISC	0x24
> =20
> +/* Power Management Control Register */
> +#define PCIE_CLIENT_POWER_CON		0x2c
> +#define  PCIE_CLKREQ_READY		FIELD_PREP_WM16(BIT(0), 1)
> +#define  PCIE_CLKREQ_NOT_READY		FIELD_PREP_WM16(BIT(0), 0)
> +#define  PCIE_CLKREQ_PULL_DOWN		FIELD_PREP_WM16(GENMASK(13, 12), 1)
> +
>  /* Hot Reset Control Register */
>  #define PCIE_CLIENT_HOT_RESET_CTRL	0x180
>  #define  PCIE_LTSSM_APP_DLY2_EN		BIT(1)
> @@ -85,6 +91,7 @@ struct rockchip_pcie {
>  	struct regulator *vpcie3v3;
>  	struct irq_domain *irq_domain;
>  	const struct rockchip_pcie_of_data *data;
> +	bool supports_clkreq;
>  };
> =20
>  struct rockchip_pcie_of_data {
> @@ -200,6 +207,32 @@ static bool rockchip_pcie_link_up(struct dw_pcie *pc=
i)
>  	return FIELD_GET(PCIE_LINKUP_MASK, val) =3D=3D PCIE_LINKUP;
>  }
> =20
> +/*
> + * See e.g. section '11.6.6.4 L1 Substate' in the RK3588 TRM V1.0 for th=
e steps
> + * needed to support L1 substates. Currently, just enable L1 substates f=
or RC
> + * mode if CLKREQ# is properly connected and supports-clkreq is present =
in DT.
> + * For EP mode, there are more things should be done to actually save po=
wer in
> + * L1 substates, so disable L1 substates until there is proper support.
> + */
> +static void rockchip_pcie_configure_l1sub(struct dw_pcie *pci)
> +{
> +	struct rockchip_pcie *rockchip =3D to_rockchip_pcie(pci);
> +
> +	/* Enable L1 substates if CLKREQ# is properly connected */
> +	if (rockchip->supports_clkreq &&
> +	    rockchip->data->mode =3D=3D DW_PCIE_RC_TYPE ) {
> +		rockchip_pcie_writel_apb(rockchip, PCIE_CLKREQ_READY,
> +					 PCIE_CLIENT_POWER_CON);
> +		pci->l1ss_support =3D true;
> +		return;
> +	}
> +
> +	/* Otherwise, pull down CLKREQ# */
> +	rockchip_pcie_writel_apb(rockchip,
> +				 PCIE_CLKREQ_PULL_DOWN | PCIE_CLKREQ_NOT_READY,
> +				 PCIE_CLIENT_POWER_CON);
> +}
> +
>  static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
>  {
>  	u32 cap, lnkcap;
> @@ -264,6 +297,7 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp =
*pp)
>  	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
>  					 rockchip);
> =20
> +	rockchip_pcie_configure_l1sub(pci);
>  	rockchip_pcie_enable_l0s(pci);
> =20
>  	return 0;
> @@ -301,6 +335,7 @@ static void rockchip_pcie_ep_init(struct dw_pcie_ep *=
ep)
>  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>  	enum pci_barno bar;
> =20
> +	rockchip_pcie_configure_l1sub(pci);
>  	rockchip_pcie_enable_l0s(pci);
>  	rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);
> =20
> @@ -412,6 +447,9 @@ static int rockchip_pcie_resource_get(struct platform=
_device *pdev,
>  		return dev_err_probe(&pdev->dev, PTR_ERR(rockchip->rst),
>  				     "failed to get reset lines\n");
> =20
> +	rockchip->supports_clkreq =3D of_property_read_bool(pdev->dev.of_node,
> +							  "supports-clkreq");
> +
>  	return 0;
>  }
> =20


