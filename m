Return-Path: <linux-pci+bounces-44969-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C999FD25676
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 16:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1458300E3C8
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 15:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30207286412;
	Thu, 15 Jan 2026 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYM4CjX9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0892566D3;
	Thu, 15 Jan 2026 15:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768491360; cv=none; b=kKCZg1qiTZayw3m+XW9wl+G/PhFQueRBcA/EQM7UBTUodDoFm/fOqqb+3AWcBSV6uPYtJQQwg106UAUHfjBNYNcKfwLnKfuTbYD3Uoo5yoQUSNIsELFzwtP7TODGYqGK/uUenju/EXq9msTLXGlKp6A49vyff8fvYJcU6VdJ50I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768491360; c=relaxed/simple;
	bh=ba4TWvFWpSIOZy47Mwu+Mtaoe2Sy+4tdPfiDGXoPsgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdGHcVGpJIj5DgzGajBgbvpJCiGCYd7hBsq8yLr1K8nu1ovgfI0lAJM2K/ZpAJj2IzaS+tsVIHbZm3tnd8IWphqzujFCPDHgZN4zzu9dkTuLK9/sggbNI4m9nCJzXi12AD1/Gj0vKcBBwVKi0yw5C0y+yHofxJEXZKy7KQSQM9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYM4CjX9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE23EC116D0;
	Thu, 15 Jan 2026 15:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768491359;
	bh=ba4TWvFWpSIOZy47Mwu+Mtaoe2Sy+4tdPfiDGXoPsgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CYM4CjX9tlHYehK4JYmPMTSTc+H2yn9ztnTSQD1VHNDXoY8xVduFYQ+yXBwvKJcmw
	 mODvHP41pzinHYaNSg/h03Azc4gfzgBFQ8QWv8VNtAuPdLWQLT+p/dV0OmuQUWJU+J
	 qyc6+R42hoIVDNVBZCC5Rk4HPe6WRggwvj72CHc0vrPszPj7PBHQLEQKBHHo+cbv+9
	 4JUSrqpmoW3eDI38d1Hit39os9PtI7mTBtWE1WeKmZsjnKQquygmSbvgmEOjDMK5eM
	 6jgomLdWialEZcebnX3avfpLPtzf82gBm0z+2kqJTMmqzQRJr/eUW4cSokEH+nNv7Q
	 Av4+8r8sZ6fEQ==
Date: Thu, 15 Jan 2026 21:05:44 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Frank Li <frank.li@nxp.com>, 
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v8 2/2] PCI: dwc: Don't return error when wait for link
 up in dw_pcie_resume_noirq()
Message-ID: <egnjo4t6odkhnbcusy2daosqm37a36bu6xc25pdgr4bbli2v5j@r7cwxkwfafbj>
References: <20260107024553.3307205-1-hongxing.zhu@nxp.com>
 <20260107024553.3307205-3-hongxing.zhu@nxp.com>
 <7akwvdfve5jcj2tm7jiwowkvcctsmqeslia4pulvtdgcgicp4p@h5ztwyp4h7ft>
 <AS8PR04MB8833FD0095481ADD280363628C8FA@AS8PR04MB8833.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8833FD0095481ADD280363628C8FA@AS8PR04MB8833.eurprd04.prod.outlook.com>

On Wed, Jan 14, 2026 at 06:46:23AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Manivannan Sadhasivam <mani@kernel.org>
> > Sent: 2026年1月13日 23:30
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: Frank Li <frank.li@nxp.com>; jingoohan1@gmail.com;
> > l.stach@pengutronix.de; lpieralisi@kernel.org; kwilczynski@kernel.org;
> > robh@kernel.org; bhelgaas@google.com; shawnguo@kernel.org;
> > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > imx@lists.linux.dev; linux-kernel@vger.kernel.org; stable@vger.kernel.org
> > Subject: Re: [PATCH v8 2/2] PCI: dwc: Don't return error when wait for link up
> > in dw_pcie_resume_noirq()
> >
> > On Wed, Jan 07, 2026 at 10:45:53AM +0800, Richard Zhu wrote:
> > > When waiting for the PCIe link to come up, both link up and link down
> > > are valid results depending on the device state.
> > >
> > > Since the link may come up later and to get rid of the following
> > > mis-reported PM errors. Do not return an -ETIMEDOUT error, as the
> > > outcome has already been reported in dw_pcie_wait_for_link().
> > >
> > > PM error logs introduced by the -ETIMEDOUT error return.
> > > imx6q-pcie 33800000.pcie: Phy link never came up imx6q-pcie
> > > 33800000.pcie: PM: dpm_run_callback(): genpd_resume_noirq returns -110
> > > imx6q-pcie 33800000.pcie: PM: failed to resume noirq: error -110
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume
> > > functionality")
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware-host.c | 7 +++----
> > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index 06cbfd9e1f1e..025e11ebd571 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -1245,10 +1245,9 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
> > >     if (ret)
> > >             return ret;
> > >
> > > -   ret = dw_pcie_wait_for_link(pci);
> > > -   if (ret)
> > > -           return ret;
> > > +   /* Ignore errors, the link may come up later */
> > > +   dw_pcie_wait_for_link(pci);
> >
> > It is not safe to ignore failures during resume. Because, if a device gets
> > removed during suspend, the link up error will be unnoticed. I've proposed a
> > different logic in this series, which should address your issue:
> > https://lore.kern/
> > el.org%2Flinux-pci%2F20260107-pci-dwc-suspend-rework-v4-0-9b5f3c72df0a%
> > 40oss.qualcomm.com%2F&data=05%7C02%7Chongxing.zhu%40nxp.com%7Cf8
> > 79871f9d0445aa0a3c08de52b8a2c0%7C686ea1d3bc2b4c6fa92cd99c5c301635
> > %7C0%7C0%7C639039150121991830%7CUnknown%7CTWFpbGZsb3d8eyJFbXB
> > 0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbC
> > IsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=PNdsT530dbRQkgYsrr99gB1cUE
> > BLOkynvciC9tiB0Ic%3D&reserved=0
> >
> > Please test it out.
> Hi Mani:
> You're right.
> Tested on i.MX platforms, no error return anymore. Only "Device not found" is
>  dumped out when no endpoint device is connected. Thanks.
> Tested-by: Richard Zhu <hongxing.zhu@nxp.com>
> 

Please share the tag by replying to that series.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

