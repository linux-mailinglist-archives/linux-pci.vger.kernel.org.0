Return-Path: <linux-pci+bounces-27501-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABC7AB11C6
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 13:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 075183B4873
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 11:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4132928F942;
	Fri,  9 May 2025 11:10:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBED274FE5
	for <linux-pci@vger.kernel.org>; Fri,  9 May 2025 11:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746789025; cv=none; b=kQqqEdChxevxB7GJPJmUuFAkHVffnoNcqeMhySNxkZNuCuG5h3zerXtHF1lYMZmPZr9An8xu85F5VyE0HwzfnTGBfHENoIyOF3/jom9sTqbh3rc3wHisYhq+XwcAOBM50Jqg2RhnKxZguSfm7LMz2rspUFqURUazv7ZKOq9xXqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746789025; c=relaxed/simple;
	bh=g0KgczyW2X2V0q0zRlKqpqDPt/VrfeQIylxugulKuP0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E+3VFd0m5P7F9TdmpeBJaPWNnGZcOJqq1NGSvGcZRIzUW+pCKPnG5qHoJyguNjV1Yujf06jEBRIJZpyt0pqxFYYatw7fPwdZAmJQBA5EvCmDKVJnXnWAC3eV/K7SY9mOuqEpZLzXuZes8xLCiIz42p8xYQ6jvYRCrfoawQ1/uok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uDLKA-0002Si-2x; Fri, 09 May 2025 12:51:26 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uDLK8-001sIP-2c;
	Fri, 09 May 2025 12:51:24 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uDLK8-0006Lv-2I;
	Fri, 09 May 2025 12:51:24 +0200
Message-ID: <42a5119e547685f171be6f91e476a9b595599cf9.camel@pengutronix.de>
Subject: Re: [PATCH 5/8] PCI: rzg3s-host: Add Initial PCIe Host Driver for
 Renesas RZ/G3S SoC
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Claudiu <claudiu.beznea@tuxon.dev>, bhelgaas@google.com, 
 lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be,  magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org,  saravanak@google.com
Cc: linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, Claudiu
 Beznea <claudiu.beznea.uj@bp.renesas.com>
Date: Fri, 09 May 2025 12:51:24 +0200
In-Reply-To: <20250430103236.3511989-6-claudiu.beznea.uj@bp.renesas.com>
References: <20250430103236.3511989-1-claudiu.beznea.uj@bp.renesas.com>
	 <20250430103236.3511989-6-claudiu.beznea.uj@bp.renesas.com>
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

Hi Claudiu,

On Mi, 2025-04-30 at 13:32 +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
> Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
> only as a root complex, with a single-lane (x1) configuration. The
> controller includes Type 1 configuration registers, as well as IP
> specific registers (called AXI registers) required for various adjustment=
s.
>=20
> Other Renesas RZ SoCs (e.g., RZ/G3E, RZ/V2H) share the same AXI registers
> but have both Root Complex and Endpoint capabilities. As a result, the PC=
Ie
> host driver can be reused for these variants with minimal adjustments.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  MAINTAINERS                              |    8 +
>  drivers/pci/controller/Kconfig           |    7 +
>  drivers/pci/controller/Makefile          |    1 +
>  drivers/pci/controller/pcie-rzg3s-host.c | 1561 ++++++++++++++++++++++
>  4 files changed, 1577 insertions(+)
>  create mode 100644 drivers/pci/controller/pcie-rzg3s-host.c
>=20
[...]
> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> new file mode 100644
> index 000000000000..c3bce0acd57e
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -0,0 +1,1561 @@
[...]
> +static int rzg3s_pcie_resets_bulk_set(int (*action)(int num, struct rese=
t_control_bulk_data *rstcs),
> +				      struct reset_control **resets, u8 num_resets)
> +{
> +	struct reset_control_bulk_data *data __free(kfree) =3D
> +		kcalloc(num_resets, sizeof(*data), GFP_KERNEL);
> +
> +	if (!data)
> +		return -ENOMEM;
> +
> +	for (u8 i =3D 0; i < num_resets; i++)
> +		data[i].rstc =3D resets[i];
> +
> +	return action(num_resets, data);
> +}

What is the purpose of this? Can't you just store struct
reset_control_bulk_data in struct rzg3s_pcie_host and call
reset_control_bulk_assert/deassert() directly?

> +static int
> +rzg3s_pcie_resets_init(struct device *dev, struct reset_control ***reset=
s,
> +		       struct reset_control *(*action)(struct device *dev, const char =
*id),
> +		       const char * const *reset_names, u8 num_resets)
> +{
> +	*resets =3D devm_kcalloc(dev, num_resets, sizeof(struct reset_control *=
), GFP_KERNEL);
> +	if (!*resets)
> +		return -ENOMEM;
> +
> +	for (u8 i =3D 0; i < num_resets; i++) {
> +		(*resets)[i] =3D action(dev, reset_names[i]);
> +		if (IS_ERR((*resets)[i]))
> +			return PTR_ERR((*resets)[i]);
> +	}
> +
> +	return 0;
> +}

Why not use devm_reset_control_bulk_get_exclusive() directly?


regards
Philipp

