Return-Path: <linux-pci+bounces-13941-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34FA99275A
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 10:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B9A82839FA
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 08:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E7718BC0E;
	Mon,  7 Oct 2024 08:44:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEE6849C
	for <linux-pci@vger.kernel.org>; Mon,  7 Oct 2024 08:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290657; cv=none; b=EGQWpuq75OgPQOMUALOJjdWgHcdztdj8cE+Rz814Ez5eMwyywi/g2Zb4DjwZ0JbRL+ec7/39WqT2x7VCQAcK06WtkIQSyd8wBdUUD5rTcBx5HxUDeC1xnB4ALwEKB+yVcWo61s6IUxzB/YvWEigyLlmG2McHMdR8fBiSpvfXbnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290657; c=relaxed/simple;
	bh=ny759ZsE+GykhYiOWEKMypSj4JCeUDq1tVV4LUkkils=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U4p+kA4OdR+DR8R9A7eYj+11doibi2hPcUpoT+Iwimdj0X0Wu4K2SijjlMDdMRjxJUd3+lCCuu4cOM2KyReuAQllCP/iVATvCvl+tV669dH/F3J/CgP0+iVbJ+uzntC8Qmee2jFFsptEGUcMFe9bHBMOI3+V33X2H8aqgHJisg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sxjLV-0000hz-NP; Mon, 07 Oct 2024 10:44:01 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sxjLT-0005S8-Hz; Mon, 07 Oct 2024 10:43:59 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sxjLT-000Bl4-1Z;
	Mon, 07 Oct 2024 10:43:59 +0200
Message-ID: <64c560c483f09d90c788eb949890d00f3b94cc87.camel@pengutronix.de>
Subject: Re: [PATCH v6 RESET 2/3] PCI: rockchip: Simplify reset control
 handling by using reset_control_bulk*() function
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Anand Moon <linux.amoon@gmail.com>, Shawn Lin
 <shawn.lin@rock-chips.com>,  Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, "open
 list:PCIE DRIVER FOR ROCKCHIP" <linux-pci@vger.kernel.org>, "open list:PCIE
 DRIVER FOR ROCKCHIP" <linux-rockchip@lists.infradead.org>,  "moderated
 list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, open
 list <linux-kernel@vger.kernel.org>
Date: Mon, 07 Oct 2024 10:43:59 +0200
In-Reply-To: <20241006182445.3713-3-linux.amoon@gmail.com>
References: <20241006182445.3713-1-linux.amoon@gmail.com>
	 <20241006182445.3713-3-linux.amoon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org

On So, 2024-10-06 at 23:54 +0530, Anand Moon wrote:
> Refactor the reset control handling in the Rockchip PCIe driver,
> introducing a more robust and efficient method for assert and
> deassert reset controller using reset_control_bulk*() API. Using the
> reset_control_bulk APIs, the reset handling for the core clocks reset
> unit becomes much simpler.
>=20
> Spilt the reset controller in two groups as pre the RK3399 TRM.
> After power up, the software driver should de-assert the reset of PCIe PH=
Y,
> then wait the PLL locked by polling the status, if PLL
> has locked, then can de-assert the rest reset simultaneously
> driver need to De-assert the reset pins simultionaly.
>=20
>   PIPE_RESET_N/MGMT_STICKY_RESET_N/MGMT_RESET_N/RESET_N.
>=20
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> V6: Add reason for the split of the RESET pins.
> v5: Fix the De-assert reset core as per the TRM
>     De-assert the PIPE_RESET_N/MGMT_STICKY_RESET_N/MGMT_RESET_N/RESET_N
>     simultaneously.
> v4: use dev_err_probe in error path.
> v3: Fix typo in commit message, dropped reported by.
> v2: Fix compilation error reported by Intel test robot
>     fixed checkpatch warning
> ---
>  drivers/pci/controller/pcie-rockchip.c | 151 +++++--------------------
>  drivers/pci/controller/pcie-rockchip.h |  26 +++--
>  2 files changed, 49 insertions(+), 128 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/control=
ler/pcie-rockchip.c
> index 2777ef0cb599..87daa3288a01 100644
> --- a/drivers/pci/controller/pcie-rockchip.c
> +++ b/drivers/pci/controller/pcie-rockchip.c
[...]
> @@ -69,55 +69,23 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rock=
chip)
>  	if (rockchip->link_gen < 0 || rockchip->link_gen > 2)
>  		rockchip->link_gen =3D 2;
> =20
> -	rockchip->core_rst =3D devm_reset_control_get_exclusive(dev, "core");
> -	rockchip->mgmt_rst =3D devm_reset_control_get_exclusive(dev, "mgmt");
> -	rockchip->mgmt_sticky_rst =3D devm_reset_control_get_exclusive(dev,
> -	rockchip->pipe_rst =3D devm_reset_control_get_exclusive(dev, "pipe");
> -	rockchip->pm_rst =3D devm_reset_control_get_exclusive(dev, "pm");
> +	err =3D devm_reset_control_bulk_get_optional_exclusive(dev,
[...]


Why are the reset controls optional now? The commit message doesn't
mention this change.

regards
Philipp

