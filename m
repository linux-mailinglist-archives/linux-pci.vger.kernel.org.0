Return-Path: <linux-pci+bounces-34752-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F26B35F67
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 14:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F5D6864AC
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 12:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F022215A8;
	Tue, 26 Aug 2025 12:46:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A3A4A33
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 12:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212388; cv=none; b=d5GsKkrQKEwDizvhkKVKYpNibZG80cuvrBC/3BH0KHwDV6YFXmWROi8rutPolJ2mZsICtMWCVQWDKpq+aetrsDAjW9xLucEj9cUE6SbpRc+b92TEq4rtQx4RKACHzqN4/Qjz87OTQIjS8caY2uV0Z9eNE9hsMVZPLk1z0VKnZQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212388; c=relaxed/simple;
	bh=Y4O7igidPm3fHb4/rFkFWcPiGUBth71000rxlJ1/b14=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FPVR975kLg2F06/5fUXCT6ixqNaitj+hoM+qtkqSAYbDZiIlEqLwr2CxM6GrGfmTX/5Kxl2um9cnQ8fZ4W7W+x7XSznp0YlduybXIiW4TdeKL+rS+0MzZV4utHsMg7w+pWxzMePdBCwGyQoMlbIRp+eyxFOZsvV/+K/xvx7H+Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uqt3o-0000rD-Pd; Tue, 26 Aug 2025 14:46:00 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uqt3o-002ETT-1m;
	Tue, 26 Aug 2025 14:46:00 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uqt3o-000Gon-1X;
	Tue, 26 Aug 2025 14:46:00 +0200
Message-ID: <b3a9e4aa400cc03bcdc0e8d5dcd4ae82cacada86.camel@pengutronix.de>
Subject: Re: [PATCH v1 2/2] PCI: dwc: histb: Simplify reset control handling
 by using reset_control_bulk*() function
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Anand Moon <linux.amoon@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof
 =?UTF-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,  Manivannan
 Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, "open list:PCIE DRIVER FOR HISILICON STB"
 <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Date: Tue, 26 Aug 2025 14:46:00 +0200
In-Reply-To: <20250826114245.112472-3-linux.amoon@gmail.com>
References: <20250826114245.112472-1-linux.amoon@gmail.com>
	 <20250826114245.112472-3-linux.amoon@gmail.com>
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

On Di, 2025-08-26 at 17:12 +0530, Anand Moon wrote:
> Currently, the driver acquires and asserts/deasserts the resets
> individually thereby making the driver complex to read.
>=20
> This can be simplified by using the reset_control_bulk() APIs.
>=20
> Use devm_reset_control_bulk_get_exclusive() API to acquire all the resets
> and use reset_control_bulk_{assert/deassert}() APIs to assert/deassert th=
em
> in bulk.
>=20
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-histb.c | 57 ++++++++++++-------------
>  1 file changed, 28 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/contro=
ller/dwc/pcie-histb.c
> index 4022349e85d2..4ba5c9af63a0 100644
> --- a/drivers/pci/controller/dwc/pcie-histb.c
> +++ b/drivers/pci/controller/dwc/pcie-histb.c
> @@ -49,14 +49,20 @@
>  #define PCIE_LTSSM_STATE_MASK		GENMASK(5, 0)
>  #define PCIE_LTSSM_STATE_ACTIVE		0x11
> =20
> +#define PCIE_HISTB_NUM_RESETS   ARRAY_SIZE(histb_pci_rsts)
> +
> +static const char * const histb_pci_rsts[] =3D {
> +	"soft",
> +	"sys",
> +	"bus",
> +};
> +
[...]
> @@ -236,14 +241,19 @@ static int histb_pcie_host_enable(struct dw_pcie_rp=
 *pp)
>  		goto reg_dis;
>  	}
> =20
> -	reset_control_assert(hipcie->soft_reset);
> -	reset_control_deassert(hipcie->soft_reset);
> -
> -	reset_control_assert(hipcie->sys_reset);
> -	reset_control_deassert(hipcie->sys_reset);
> +	ret =3D reset_control_bulk_assert(PCIE_HISTB_NUM_RESETS,
> +					hipcie->reset);
> +	if (ret) {
> +		dev_err(dev, "Couldn't assert reset %d\n", ret);
> +		goto reg_dis;
> +	}
> =20
> -	reset_control_assert(hipcie->bus_reset);
> -	reset_control_deassert(hipcie->bus_reset);
> +	ret =3D reset_control_bulk_deassert(PCIE_HISTB_NUM_RESETS,

Note that this changes the order of assertion/deassertion, not only
because resets lines are now switched in bulk, but also because
reset_control_bulk_deassert() deasserts the reset lines in reverse
order. So this does

If the three resets are independent and order doesn't matter,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

