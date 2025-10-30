Return-Path: <linux-pci+bounces-39766-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA203C1F0B7
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 09:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181DB19C4D9C
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 08:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF60B33C502;
	Thu, 30 Oct 2025 08:43:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D866D339702
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 08:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761813823; cv=none; b=LsHO+IrKAgQhAHI6Gj2lhju6N2WwKe5EF3iIGj0YBRK5HCjQk5iQg/+A8Rv7R5uY34eBe1mmrVzzFDys4s0oRfeWk/HckWbnsvVfDWBuGTTsmvVaoiZteKydfANZAR4VtaasmPs82RVlSj+uTzMYxBZwSYa0995wDISZuU2dPkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761813823; c=relaxed/simple;
	bh=LcHZDPAbfQKcPbtW4crsMg3p6AgNd6ywFc7ZOHB4Eck=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FYUnyowA+OhFC2aQDouVosbZpe/eNsIoKRCTcmt+4H29Ag3+MRplkYoPkhaCNMKH0uZ2bgY+FrClyJmbsWBQhr3ex2jN9+UYh+DKrkobDMlOuEORIiHuLd+Fnei6bW1SHmc6/mjXdA8y/jGjdpHjMxeSs4th5kuNTzmdQ9yBN94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vEOFk-0007i2-7c; Thu, 30 Oct 2025 09:43:28 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vEOFg-006BKb-2G;
	Thu, 30 Oct 2025 09:43:24 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vEOFg-000000003si-2Uey;
	Thu, 30 Oct 2025 09:43:24 +0100
Message-ID: <e29ccabbe674f0a8a45978db68ca627353694e42.camel@pengutronix.de>
Subject: Re: [PATCH v4 2/2] PCI: EIC7700: Add Eswin PCIe host controller
 driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: zhangsenchuan@eswincomputing.com, bhelgaas@google.com, mani@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, jingoohan1@gmail.com, 
	gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	christian.bruel@foss.st.com, mayank.rana@oss.qualcomm.com,
 shradha.t@samsung.com, 	krishna.chundru@oss.qualcomm.com,
 thippeswamy.havalige@amd.com, 	inochiama@gmail.com
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com, 
	pinkesh.vaghela@einfochips.com, ouyanghui@eswincomputing.com
Date: Thu, 30 Oct 2025 09:43:24 +0100
In-Reply-To: <20251030083143.1341-1-zhangsenchuan@eswincomputing.com>
References: <20251030082900.1304-1-zhangsenchuan@eswincomputing.com>
	 <20251030083143.1341-1-zhangsenchuan@eswincomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
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

On Do, 2025-10-30 at 16:31 +0800, zhangsenchuan@eswincomputing.com
wrote:
> From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
>=20
> Add driver for the Eswin EIC7700 PCIe host controller, which is based on
> the DesignWare PCIe core, IP revision 6.00a. The PCIe Gen.3 controller
> supports a data rate of 8 GT/s and 4 channels, support INTX and MSI
> interrupts.
>=20
> Signed-off-by: Yu Ning <ningyu@eswincomputing.com>
> Signed-off-by: Yanghui Ou <ouyanghui@eswincomputing.com>
> Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> ---
>  drivers/pci/controller/dwc/Kconfig        |  11 +
>  drivers/pci/controller/dwc/Makefile       |   1 +
>  drivers/pci/controller/dwc/pcie-eic7700.c | 462 ++++++++++++++++++++++
>  3 files changed, 474 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-eic7700.c
>=20
[...]
> diff --git a/drivers/pci/controller/dwc/pcie-eic7700.c b/drivers/pci/cont=
roller/dwc/pcie-eic7700.c
> new file mode 100644
> index 000000000000..0016dd0be743
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-eic7700.c
> @@ -0,0 +1,462 @@
[...]
> +static int eswin_pcie_deassert(struct eswin_pcie *pcie)
> +{
> +	int ret;
> +
> +	ret =3D reset_control_deassert(pcie->cfg_rst);
> +	if (ret) {
> +		dev_err(pcie->pci.dev, "Failed to deassert CFG#");
> +		return ret;
> +	}
> +
> +	ret =3D reset_control_deassert(pcie->powerup_rst);
> +	if (ret) {
> +		dev_err(pcie->pci.dev, "Failed to deassert POWERUP#");
> +		goto err_powerup;
> +	}
> +
> +	return 0;
> +
> +err_powerup:
> +	reset_control_assert(pcie->cfg_rst);
> +
> +	return ret;
> +}
> +
> +static void eswin_pcie_assert(struct eswin_pcie *pcie)
> +{
> +	reset_control_assert(pcie->powerup_rst);
> +	reset_control_assert(pcie->cfg_rst);
> +}

These look like cfg and powerup resets could be controlled together via
reset_control_bulk_assert/deassert().

[...]
> +static int eswin_pcie_parse_port(struct eswin_pcie *pcie,
> +				 struct device_node *node)
> +{		return -ENOMEM;
[...]
> +	port->perst =3D of_reset_control_get(node, "perst");

Please use of_reset_control_get_exclusive() directly.


[...]
> +static int eswin_pcie_probe(struct platform_device *pdev)
> +{
[...]
> +	pcie->powerup_rst =3D devm_reset_control_get(&pdev->dev, "powerup");
> +	if (IS_ERR(pcie->powerup_rst))
> +		return dev_err_probe(dev, PTR_ERR(pcie->powerup_rst),
> +				     "Failed to get powerup reset\n");
> +
> +	pcie->cfg_rst =3D devm_reset_control_get(&pdev->dev, "dbi");
> +	if (IS_ERR(pcie->cfg_rst))
> +		return dev_err_probe(dev, PTR_ERR(pcie->cfg_rst),
> +				     "Failed to get dbi reset\n");

Please use devm_reset_control_get_exclusive() directly.

Alternatively, you could get powerup and cfg/dbi resets in bulk via
devm_reset_control_bulk_get_exclusive().

regards
Philipp

