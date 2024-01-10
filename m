Return-Path: <linux-pci+bounces-2013-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA1382A337
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 22:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 377D9B214B1
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 21:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847124F5E8;
	Wed, 10 Jan 2024 21:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pW1dcj1z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626D94F21E;
	Wed, 10 Jan 2024 21:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987E4C433C7;
	Wed, 10 Jan 2024 21:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704921784;
	bh=U23M4BnqUmQe+FZ2LuryebH7D7fAcpk83TMAju7/hB8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pW1dcj1zvTnNRPfns6XF7nTb/HfRSXkkdg277b9w4HlSt/MGZ+sRontsI+MDrCrQA
	 ecRE5ZHr/jADkYEJQKWBRPEyDgp98YJwPNkyjv7YAf9ltbUUWLYcQxf3/bn36DjSCU
	 j2CIiud87RJT529EZfj24laCjFErXJ53QC6Fj6iezUUgJzPCvDDZmppw7hw5QMWPt3
	 7FqTDPHmnRXQ803YjSj9r6DGexm4lb8+iCb6J0A5y9YsLe2TsAtMeuTkDQW0gmizep
	 q20LAkMkwanoHrfPwVR3jdIZhX9b72nuZJidKSqhvTqSG+ciwNJm6h7Z7Vn9sw/LaG
	 vOR9dtaWXwosw==
Date: Wed, 10 Jan 2024 15:23:02 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-omap@vger.kernel.org
Subject: Re: mt7621 static check warning
Message-ID: <20240110212302.GA2123146@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMhs-H_7EovAntGwmDUDS3HNKV5H4w1UM=7cpk9GMi7Hi_kQVQ@mail.gmail.com>

[+cc Vignesh for dra7xx snprintf issue and CONFIG_TI_PIPE3 question]

On Wed, Jan 10, 2024 at 08:16:33AM +0100, Sergio Paracuellos wrote:
> On Wed, Jan 10, 2024 at 12:51 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > FYI:
> >
> >   $ make W=1 drivers/pci/
> >     CC      drivers/pci/controller/pcie-mt7621.o
> >   drivers/pci/controller/pcie-mt7621.c: In function ‘mt7621_pcie_probe’:
> >   drivers/pci/controller/pcie-mt7621.c:228:49: error: ‘snprintf’ output may be truncated before the last format character [-Werror=format-truncation=]
> >     228 |         snprintf(name, sizeof(name), "pcie-phy%d", slot);
> >         |                                                 ^
> >   drivers/pci/controller/pcie-mt7621.c:228:9: note: ‘snprintf’ output between 10 and 11 bytes into a destination of size 10
> >     228 |         snprintf(name, sizeof(name), "pcie-phy%d", slot);
> >         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> 
> Would you be happy if I just increment the buffer as follows?
> 
> diff --git a/drivers/pci/controller/pcie-mt7621.c
> b/drivers/pci/controller/pcie-mt7621.c
> index 79e225edb42a..d97b956e6e57 100644
> --- a/drivers/pci/controller/pcie-mt7621.c
> +++ b/drivers/pci/controller/pcie-mt7621.c
> @@ -202,7 +202,7 @@ static int mt7621_pcie_parse_port(struct mt7621_pcie *pcie,
>         struct mt7621_pcie_port *port;
>         struct device *dev = pcie->dev;
>         struct platform_device *pdev = to_platform_device(dev);
> -       char name[10];
> +       char name[11];
>         int err;
> 
>         port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> 
> Or should I use scnprintf instead? Since the statement is not using
> function return value at all snprintf looks more correct and simpler
> at a first glance.

I don't know enough to have an opinion, but grep says all similar
cases in drivers/pci/ use snprintf(), so I guess I would follow the
crowd.  If there's an argument for scnprintf() instead, we can convert
them all at once.

> diff --git a/drivers/pci/controller/pcie-mt7621.c
> b/drivers/pci/controller/pcie-mt7621.c
> index 79e225edb42a..0eae1b5b079e 100644
> --- a/drivers/pci/controller/pcie-mt7621.c
> +++ b/drivers/pci/controller/pcie-mt7621.c
> @@ -225,7 +225,7 @@ static int mt7621_pcie_parse_port(struct mt7621_pcie *pcie,
>                 return PTR_ERR(port->pcie_rst);
>         }
> 
> -       snprintf(name, sizeof(name), "pcie-phy%d", slot);
> +       scnprintf(name, sizeof(name), "pcie-phy%d", slot);
>         port->phy = devm_of_phy_get(dev, node, name);
>         if (IS_ERR(port->phy)) {
>                 dev_err(dev, "failed to get pcie-phy%d\n", slot);
> 
> Both of them silence the warning, so let me know your preference here.
> 
> > I know we'll never actually hit this, but it'd be nice to clean this
> > up, and I don't think it would really cost us anything.  I think it's
> > currently the only "W=1" warning in drivers/pci/.
> 
> I am also getting this:
> 
> drivers/pci/controller/dwc/pci-dra7xx.c: In function ‘dra7xx_pcie_probe’:
> drivers/pci/controller/dwc/pci-dra7xx.c:754:41: error: ‘%d’ directive
> output may be truncated writing between 1 and 10 bytes into a region
> of size 2 [-Werror=format-truncation=]
>   754 |   snprintf(name, sizeof(name), "pcie-phy%d", i);
>       |                                         ^~
> drivers/pci/controller/dwc/pci-dra7xx.c:754:32: note: directive
> argument in the range [0, 2147483646]
>   754 |   snprintf(name, sizeof(name), "pcie-phy%d", i);
>       |                                ^~~~~~~~~~~~
> drivers/pci/controller/dwc/pci-dra7xx.c:754:3: note: ‘snprintf’ output
> between 10 and 19 bytes into a destination of size 10
>   754 |   snprintf(name, sizeof(name), "pcie-phy%d", i);
>       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Oh, thanks for this.  I didn't have CONFIG_TI_PIPE3=y in my .config,
which CONFIG_PCI_DRA7XX depends on.

I didn't go to the trouble of trying to figure out exactly what
CONFIG_TI_PIPE3=y enables, but with the patch below, I *was* able to
successfully build and link a kernel with:

  CONFIG_COMPILE_TEST=y
  CONFIG_PCI_DRA7XX=y
  CONFIG_PCI_DRA7XX_HOST=y
  CONFIG_PCI_DRA7XX_EP=y
  # CONFIG_TI_PIPE3 is not set

So maybe there's a way to write these dependencies in a way that would
give us better compile-testing?

Bjorn

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 5ac021dbd46a..8b837b183981 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -376,7 +376,7 @@ config PCI_DRA7XX
 config PCI_DRA7XX_HOST
 	tristate "TI DRA7xx PCIe controller (host mode)"
 	depends on SOC_DRA7XX || COMPILE_TEST
-	depends on OF && HAS_IOMEM && TI_PIPE3
+	depends on OF && HAS_IOMEM
 	depends on PCI_MSI
 	select PCIE_DW_HOST
 	select PCI_DRA7XX
@@ -392,7 +392,7 @@ config PCI_DRA7XX_HOST
 config PCI_DRA7XX_EP
 	tristate "TI DRA7xx PCIe controller (endpoint mode)"
 	depends on SOC_DRA7XX || COMPILE_TEST
-	depends on OF && HAS_IOMEM && TI_PIPE3
+	depends on OF && HAS_IOMEM
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
 	select PCI_DRA7XX

