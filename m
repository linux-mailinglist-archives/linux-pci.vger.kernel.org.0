Return-Path: <linux-pci+bounces-378-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEB2801D57
	for <lists+linux-pci@lfdr.de>; Sat,  2 Dec 2023 15:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A7D28121B
	for <lists+linux-pci@lfdr.de>; Sat,  2 Dec 2023 14:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2EF17732;
	Sat,  2 Dec 2023 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="r/bbhO2H"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677E1129
	for <linux-pci@vger.kernel.org>; Sat,  2 Dec 2023 06:44:07 -0800 (PST)
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3E6FC3FB62
	for <linux-pci@vger.kernel.org>; Sat,  2 Dec 2023 14:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1701528245;
	bh=r6jeVOJ8uNScbavO6oRhJDbP/R2qrE1dKTxqhisFANk=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=r/bbhO2Hv9InIQ0eXoQKVigbKPg24PzuHDEKI0tp9CAVJXzF2qzQzn5e+49GTiLIN
	 D8TQlYBM5DdzU0rN9LiAVYO50KLqY2E8VsFVqu/Yr6oSVThWHB9qe49VLRYC+JZtjO
	 b4aG1iFjDTTtwCjfLNu57nvfM7t8fNWVY3NcRsh19uVsS3rlSiTLiAo4BwL7CWCKWa
	 hDg3EbQd5a13Pv0fJ1jpxx3Nnp/xnkx6l+QkPG6ur5Mjeg2ptlQgpbwjspbcHatELA
	 YXrUAT8TMjnO49EedbQCM9rgAE2kTogFvh8QcPDDatQwJ7MjpTDeLL2Yo0pMatSY1p
	 lHR5aQXW8eI8Q==
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-423f436ed56so40535791cf.1
        for <linux-pci@vger.kernel.org>; Sat, 02 Dec 2023 06:44:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701528244; x=1702133044;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r6jeVOJ8uNScbavO6oRhJDbP/R2qrE1dKTxqhisFANk=;
        b=EIQY/z2jAotcxVG8HYKLXU6GdpPEqZP+BgZnw3x0ZrFCCOU7xtTNeUwo5WGuETzXL0
         KQMzHmqUkQyE/EJlnHf+NE3DOKvJTk/A1/+EivE4lWDyWGl203D7vF9QzHiSpiVME6nN
         1vc7rau1ge84wvCyrycmg/7RcBjvYOMFBpFuCvSVFG85ocGO0Kn6QasujBp3wC3UYylt
         1FuB1xvLyoftv+s+lQA9ZCrjj++55axMIch8IgB0LKk80PGKwXcKxSl4ts/rjV71HpvY
         crHvyfOkiy5oCsdLNjfwa51j+gGlDVD6U1jBp6huxlVDFI+B2xgKhMf3gvk6h8UNxhxg
         De6g==
X-Gm-Message-State: AOJu0YzUhrWbZDhMHNKpdVMh4ejwcw+RF4kjIErfZobPDuTxIJFluEd0
	J0X27fkhcBGonzmRx2Qeh5DquTJJ0QV9GEisdjSFn7aAOvPQJA5B5P0ZefzkRgfDJqbeGreZ9QR
	gu6ly5nyezhx+cmgAAl0JiWrlXp+lrOU6xX+sfJgtuf9mkgQ6H15I/w==
X-Received: by 2002:a05:622a:86:b0:425:4043:5f41 with SMTP id o6-20020a05622a008600b0042540435f41mr1919267qtw.127.1701528244255;
        Sat, 02 Dec 2023 06:44:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfPh334flr508EAZGNmLTyM+4QVgpXEgp8thSKGdCRPDIkTWGyXFCRDmz6MtLcyELHQnAA8WedEPZYZ24lPUA=
X-Received: by 2002:a05:622a:86:b0:425:4043:5f41 with SMTP id
 o6-20020a05622a008600b0042540435f41mr1919239qtw.127.1701528243903; Sat, 02
 Dec 2023 06:44:03 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 2 Dec 2023 06:44:03 -0800
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231115114912.71448-20-minda.chen@starfivetech.com>
References: <20231115114912.71448-1-minda.chen@starfivetech.com> <20231115114912.71448-20-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Sat, 2 Dec 2023 06:44:03 -0800
Message-ID: <CAJM55Z8hb3vBgwOHoHuJpEPFVMNirhcs8AfZWRn4EgxbOGsq2Q@mail.gmail.com>
Subject: Re: [PATCH v11 19/20] PCI: starfive: Add JH7110 PCIe controller
To: Minda Chen <minda.chen@starfivetech.com>, Conor Dooley <conor@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Daire McNamara <daire.mcnamara@microchip.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Mason Huo <mason.huo@starfivetech.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>, 
	Kevin Xie <kevin.xie@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"

Minda Chen wrote:
> Add StarFive JH7110 SoC PCIe controller platform driver codes, JH7110
> with PLDA host PCIe core.
>
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Co-developed-by: Kevin Xie <kevin.xie@starfivetech.com>
> Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
> ---
>  MAINTAINERS                                 |   7 +
>  drivers/pci/controller/plda/Kconfig         |  11 +
>  drivers/pci/controller/plda/Makefile        |   1 +
>  drivers/pci/controller/plda/pcie-plda.h     |  71 ++-
>  drivers/pci/controller/plda/pcie-starfive.c | 460 ++++++++++++++++++++
>  drivers/pci/pci.h                           |   7 +
>  6 files changed, 556 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pci/controller/plda/pcie-starfive.c
>

...

> +
> +static int starfive_pcie_parse_dt(struct starfive_jh7110_pcie *pcie,
> +				  struct device *dev)
> +{
> +	int domain_nr;
> +
> +	pcie->num_clks = devm_clk_bulk_get_all(dev, &pcie->clks);
> +	if (pcie->num_clks < 0)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "failed to get pcie clocks\n");

Hi Minda,

From Damian's mail I noticed that this should propagate the error from
devm_clk_bulk_get_all() properly, so -EPROBE is converted to an -ENODEV error.
Eg.

	if (pcie->num_clks < 0)
		return dev_err_probe(dev, pcie->num_clks,
				     "failed to get pcie clocks\n");

> +
> +	pcie->resets = devm_reset_control_array_get_exclusive(dev);
> +	if (IS_ERR(pcie->resets))
> +		return dev_err_probe(dev, PTR_ERR(pcie->resets),
> +				     "failed to get pcie resets");
> +
> +	pcie->reg_syscon =
> +		syscon_regmap_lookup_by_phandle(dev->of_node,
> +						"starfive,stg-syscon");
> +
> +	if (IS_ERR(pcie->reg_syscon))
> +		return dev_err_probe(dev, PTR_ERR(pcie->reg_syscon),
> +				     "failed to parse starfive,stg-syscon\n");
> +
> +	pcie->phy = devm_phy_optional_get(dev, NULL);
> +	if (IS_ERR(pcie->phy))
> +		return dev_err_probe(dev, PTR_ERR(pcie->phy),
> +				     "failed to get pcie phy\n");
> +
> +	domain_nr = of_get_pci_domain_nr(dev->of_node);
> +
> +	if (domain_nr < 0 || domain_nr > 1)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "failed to get valid pcie domain\n");
> +
> +	if (domain_nr == 0)
> +		pcie->stg_pcie_base = STG_SYSCON_PCIE0_BASE;
> +	else
> +		pcie->stg_pcie_base = STG_SYSCON_PCIE1_BASE;
> +
> +	pcie->reset_gpio = devm_gpiod_get_optional(dev, "perst",
> +						   GPIOD_OUT_HIGH);
> +	if (IS_ERR(pcie->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(pcie->reset_gpio),
> +				     "failed to get perst-gpio\n");
> +
> +	pcie->power_gpio = devm_gpiod_get_optional(dev, "enable",
> +						   GPIOD_OUT_LOW);
> +	if (IS_ERR(pcie->power_gpio))
> +		return dev_err_probe(dev, PTR_ERR(pcie->power_gpio),
> +				     "failed to get power-gpio\n");
> +
> +	return 0;
> +}

