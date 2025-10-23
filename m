Return-Path: <linux-pci+bounces-39130-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F096C00583
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 11:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FFB2189407B
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 09:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E82253B66;
	Thu, 23 Oct 2025 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="A0c9oRih"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDB130AAB7
	for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 09:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761213003; cv=none; b=SJY/LYrCpsahH2L9bt8Kd1/DMSKIHLHWRp7/W97WgGfParcv7UwNIbdtxLV/IdGGip6EPIrfuloACBvlr7v7a920kpDpR5fqjtvK6s6MoX1wvHJxnk3V98U5Gmz8mNz9kHKYifKy/xUuuxgeq/NdHuAwhRXIFhOhuf1WnEp+4pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761213003; c=relaxed/simple;
	bh=Y7NZXWLASLPZh/Rq23ZJYg7Nhip6KItThETbFIJx6QM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NZvh/oKU6PFv1nRmuOCukViDNUs1zZCL97KivmZp0xdMSNoQ3FELjoIxLUBg4FLUOMlMLCMxoMBFuN/m/gP8rNttvOuwpyUz0zEggT20AoTFnZ6w7iVZcxkbqH2/P/FTeWUyRa8CjtJ8qUw6GsclNSPSxH/LqYYeBQ/38sJYFx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=A0c9oRih; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1761212996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1kKSuHqlpd7Q5R9WUMyjrIRemxGdRD0uvle2ohvhWxA=;
	b=A0c9oRihcdJkh1kcn/JuOQiS3YRnSz3mZK6Yx9v7J27r5DQYF19o6Uj3G1C43TPBM0v62k
	RKS8FGFBfWQdXdNuUtyCg7Y3PkGS9CUTHqSyxDLGC6UYSXFocZNvO3qiiimZqUi2tCg6Bg
	zbOnhDCW4Z5VOsqOXrbWv10GDfIxthb/BrmnaktYnSk6FPYjJ7p0G0z9vtwJ9vf8Adm8Tc
	I/t8195hkS10eQ1zB8q8MrZrPGsy4+6d6XLrlJ/9WZOC/0/MJrLOK1f0WIvvnmsdSNgemn
	ZJTUFK2IBUV2nDXVUzMAhmNLfhIlaNE7N7LMtbk4YYDAsXNbg3CarDgyZ4aldg==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Oct 2025 11:49:47 +0200
Message-Id: <DDPLWD21EDEB.25TD1X46N5BDK@cknow-tech.com>
Cc: <linux-rockchip@lists.infradead.org>, "Niklas Cassel"
 <cassel@kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] PCI: dw-rockchip: Configure L1sub support
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Shawn Lin" <shawn.lin@rock-chips.com>, "Heiko Stuebner"
 <heiko@sntech.de>, "Manivannan Sadhasivam" <mani@kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>
References: <1761187883-150120-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1761187883-150120-1-git-send-email-shawn.lin@rock-chips.com>
X-Migadu-Flow: FLOW_OUT

On Thu Oct 23, 2025 at 4:51 AM CEST, Shawn Lin wrote:
> L1 PM Substates for RC mode require support in the dw-rockchip driver
> including proper handling of the CLKREQ# sideband signal. It is mostly
> handled by hardware, but software still needs to set the clkreq fields
> in the PCIE_CLIENT_POWER_CON register to match the hardware implementatio=
n.
>
> For more details, see section '18.6.6.4 L1 Substate' in the RK3658 TRM 1.=
1
> Part 2, or section '11.6.6.4 L1 Substate' in the RK3588 TRM 1.0 Part2.
>
> Meanwhile, for the EP mode, we haven't prepared enough to actually suppor=
t
> L1 PM Substates yet. So disable it now until proper support is added late=
r.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>
> ---
>
> Changes in v3:
> - rephrease the changelog
> - use FIELD_PREP_WM16
> - rename to rockchip_pcie_configure_l1sub
> - disable L1ss for EP mode
>
> Changes in v2:
> - drop of_pci_clkreq_presnt API
> - drop dependency of Niklas's patch
>
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 43 +++++++++++++++++++++=
++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/=
controller/dwc/pcie-dw-rockchip.c
> index 3e2752c..25d2474 100644
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
> @@ -200,6 +207,37 @@ static bool rockchip_pcie_link_up(struct dw_pcie *pc=
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

"For EP mode, more things should be done ..." or
"For EP mode, there are more things that should be done ..."

Q: Is this patch set to fix the problem I and others reported wrt ASPM?

Because there's Niklas' patch which has been accepted, there's another
patch by Bjorn which initially didn't land on the linux-rockchip ML and
there's this patch set.
To me, those *seem* all 3 different solutions to the same issue, but
it's quite possible I'm wrong in that. Apparently to try Bjorn's patch,
one should not have Niklas' patch applied. And I have no idea what, if
any, the relationship is of this patch set with those others.

Some clarification would be helpful for n00bs like me.

Cheers,
  Diederik

> + * L1 substates, so disable L1 substates until there is proper support.
> + */
> +static void rockchip_pcie_configure_l1sub(struct dw_pcie *pci)
> +{
> +	struct rockchip_pcie *rockchip =3D to_rockchip_pcie(pci);
> +	u32 cap, l1subcap;
> +
> +	/* Enable L1 substates if CLKREQ# is properly connected */
> +	if (rockchip->supports_clkreq && rockchip->data->mode =3D=3D DW_PCIE_RC=
_TYPE ) {
> +		rockchip_pcie_writel_apb(rockchip, PCIE_CLKREQ_READY, PCIE_CLIENT_POWE=
R_CON);
> +		return;
> +	}
> +
> +	/* Otherwise, pull down CLKREQ# and disable L1 PM substates */
> +	rockchip_pcie_writel_apb(rockchip, PCIE_CLKREQ_PULL_DOWN | PCIE_CLKREQ_=
NOT_READY,
> +				 PCIE_CLIENT_POWER_CON);
> +	cap =3D dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
> +	if (cap) {
> +		l1subcap =3D dw_pcie_readl_dbi(pci, cap + PCI_L1SS_CAP);
> +		l1subcap &=3D ~(PCI_L1SS_CAP_L1_PM_SS | PCI_L1SS_CAP_ASPM_L1_1 |
> +			      PCI_L1SS_CAP_ASPM_L1_2 | PCI_L1SS_CAP_PCIPM_L1_1 |
> +			      PCI_L1SS_CAP_PCIPM_L1_2);
> +		dw_pcie_writel_dbi(pci, cap + PCI_L1SS_CAP, l1subcap);
> +	}
> +}
> +
>  static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
>  {
>  	u32 cap, lnkcap;
> @@ -264,6 +302,7 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp =
*pp)
>  	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
>  					 rockchip);
> =20
> +	rockchip_pcie_configure_l1sub(pci);
>  	rockchip_pcie_enable_l0s(pci);
> =20
>  	return 0;
> @@ -301,6 +340,7 @@ static void rockchip_pcie_ep_init(struct dw_pcie_ep *=
ep)
>  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>  	enum pci_barno bar;
> =20
> +	rockchip_pcie_configure_l1sub(pci);
>  	rockchip_pcie_enable_l0s(pci);
>  	rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);
> =20
> @@ -412,6 +452,9 @@ static int rockchip_pcie_resource_get(struct platform=
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


