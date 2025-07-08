Return-Path: <linux-pci+bounces-31660-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2B0AFC475
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 09:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8D3018981A7
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 07:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66259221278;
	Tue,  8 Jul 2025 07:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVkRS8VB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B4C3FC2;
	Tue,  8 Jul 2025 07:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960846; cv=none; b=HVxV8R0Kq0dqsDQF/lVkxqC3qr8vvCFvv0A+9QnAk6dnfOf6UycYY3IvKHHavXQxI4NroSfppdeuy25iJogzzk9U/QGdubdv3Azdj0FPlwEYdBWfq86IUQ4AH68bAPrX0WKlrx8py4rHYQ8i4RJ98zGQci3360BChGYPNsaUeaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960846; c=relaxed/simple;
	bh=jVUpAdZABGByW3BC0gUxQ8Gy88WyihYZ+pUcIVfwLQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UULiciRN8UZfaJDFOZDvsEwN8RODy9XE4AZNROrBts34eeQLGYob8mPBaKf0eByZ0MxHQIuljrd8ZlXnHWwE3RH9tFQmxq/leoEYiuwujr3USTRvom1hB8j3hjP7sfdZlAFda14fvumIH4o2Lh1Gon1FdsSfhVwGyFI1ECnZCB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVkRS8VB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CE8C4CEED;
	Tue,  8 Jul 2025 07:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751960845;
	bh=jVUpAdZABGByW3BC0gUxQ8Gy88WyihYZ+pUcIVfwLQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jVkRS8VBYxowV5hhTK7yaNDVcqGnPinoVsHNURk3RmxUwNbHyp5BrW+BP9sYAuRfM
	 U87i2zE9OjaSrS6jIE0MwdRGAwx3cwEJsL4DPsbb9ktRm96Hliys51kEQO1ECd6CHk
	 mn9FMbDOM7XDGntSbRc89ePBIznvU8T8Aln7rehpe5HPbgqM+06k13Ex3T/a1CxNj5
	 wBPm5PnQNSA0CL0wtzF8uMW4xFwpLMCBlIfGhW5mF1h/oIWBBcj1ALT6H0Qz07JnLN
	 ikBoMMUfSyYXHSPM7gUXrqirNShQdBGp7a2vDwvdwd7WtV4bYGZqLRUpqw68Shj0qX
	 xHCfg52YvR/KQ==
Date: Tue, 8 Jul 2025 13:17:15 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: "tharvey@gateworks.com" <tharvey@gateworks.com>, 
	Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] PCI: imx6: Remove apps_reset toggle in
 _core_reset functions
Message-ID: <lavz3wv5vysmb7gle5s57tc2tj4a6euh2e4fdwdrezvsejxiip@2fa4sblpau6a>
References: <20250616085742.2684742-1-hongxing.zhu@nxp.com>
 <20250616085742.2684742-2-hongxing.zhu@nxp.com>
 <kjsaipr2xq777dmiv2ac7qzrxw47nevc75j7ryma32vsnyr2le@mrwurn6rgnac>
 <CAJ+vNU3mKiEE86SYFS0aEabkqRKADFDJN0giX73E0cA=GOyhjA@mail.gmail.com>
 <AS8PR04MB867638BDCA5F47D478F597808C4EA@AS8PR04MB8676.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB867638BDCA5F47D478F597808C4EA@AS8PR04MB8676.eurprd04.prod.outlook.com>

On Tue, Jul 08, 2025 at 02:37:00AM GMT, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Tim Harvey <tharvey@gateworks.com>
> > Sent: 2025年6月24日 1:33
> > To: Manivannan Sadhasivam <mani@kernel.org>
> > Cc: Hongxing Zhu <hongxing.zhu@nxp.com>; Frank Li <frank.li@nxp.com>;
> > l.stach@pengutronix.de; lpieralisi@kernel.org; kwilczynski@kernel.org;
> > robh@kernel.org; bhelgaas@google.com; shawnguo@kernel.org;
> > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > imx@lists.linux.dev; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v3 1/2] PCI: imx6: Remove apps_reset toggle in
> > _core_reset functions
> > 
> > On Mon, Jun 23, 2025 at 4:42 AM Manivannan Sadhasivam <mani@kernel.org>
> > wrote:
> > >
> > > On Mon, Jun 16, 2025 at 04:57:41PM +0800, Richard Zhu wrote:
> > > > apps_reset is LTSSM_EN on i.MX7, i.MX8MQ, i.MX8MM and i.MX8MP
> > platforms.
> > > > Since the assertion/de-assertion of apps_reset(LTSSM_EN bit) had
> > > > been wrappered in imx_pcie_ltssm_enable() and
> > > > imx_pcie_ltssm_disable();
> > > >
> > >
> > > What about other i.MX chipsets like 6Q and its cousins? Wouldn't this
> > > change affect them since they treat 'apps_reset' differently?
> > >
> > > - Mani
> 
> Hi Mani:
> Sorry to reply late.
> Only i.MX7D, i.MX8MQ, i.MX8MM, and i.MX8MP have the apps_reset. No problems
> are found with this change in my local tests on these four platforms.
> With this change, the assertion/deassertion of ltssm_en bit are unified into
>  imx_pcie_ltssm_enable() and imx_pcie_ltssm_disable() functions, aligned with
> other i.MX platforms.
> 

Okay, thanks for clarifying. Please include this information in the commit
message as well and also CC stable list for backporting since it fixes a bug.

- Mani

> Best Regards
> Richard Zhu
> > 
> > Hi Main,
> > 
> > This patch effectively brings back the behavior prior to commit
> > ef61c7d8d032 ("PCI: imx6: Deassert apps_reset in
> > imx_pcie_deassert_core_reset()") which caused the original regressions.
> > 
> > To ease your concerns I've tested this patch on top of v6.16-rc3 with the
> > following IMX6 boards I have here with and without a PCI device
> > attached:
> > imx6q-gw51xx - no switch
> > imx6q-gw54xx - switch
> > 
> > I only have imx6qdl/imx8mm/imx8mp boards to test with.
> > 
> > From what I can tell it doesn't look like the original patch that added the
> > 'symmetric' apps_reset de-assert was necessarily well tested. It started out
> > being added because as far as I can tell it 'looked' like the right thing to do [1].
> > You requested changes to the commit log for wording [2],[3] but I'm unclear
> > that anyone tested this.
> >
> Hi Tim: 
> Thanks for your explains and tests.
> 
> Best Regards
> Richard Zhu
> 
> > Best Regards,
> > 
> > Tim
> > [1]
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatch
> > work.kernel.org%2Fproject%2Flinux-pci%2Fpatch%2F1727148464-14341-6-gi
> > t-send-email-hongxing.zhu%40nxp.com%2F&data=05%7C02%7Chongxing.zhu
> > %40nxp.com%7Cdac60212c1c94cb24d7508ddb27c0f92%7C686ea1d3bc2b4c
> > 6fa92cd99c5c301635%7C0%7C0%7C638862968081967795%7CUnknown%7
> > CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJ
> > XaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=8I
> > 7qGI92BfsbAERknsVjZO6cI527Enxgiiw%2FVatI7h4%3D&reserved=0
> > [2]
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatch
> > work.kernel.org%2Fproject%2Flinux-pci%2Fpatch%2F1728981213-8771-6-git
> > -send-email-hongxing.zhu%40nxp.com%2F&data=05%7C02%7Chongxing.zhu
> > %40nxp.com%7Cdac60212c1c94cb24d7508ddb27c0f92%7C686ea1d3bc2b4c
> > 6fa92cd99c5c301635%7C0%7C0%7C638862968081993466%7CUnknown%7
> > CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJ
> > XaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=lh
> > ER8F9ApfpgQcVCyMOBYho%2BXvlp79re4jX5C5gj1XY%3D&reserved=0
> > [3]
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatch
> > work.kernel.org%2Fproject%2Flinux-pci%2Fpatch%2F20241101070610.1267
> > 391-6-hongxing.zhu%40nxp.com%2F&data=05%7C02%7Chongxing.zhu%40nx
> > p.com%7Cdac60212c1c94cb24d7508ddb27c0f92%7C686ea1d3bc2b4c6fa92c
> > d99c5c301635%7C0%7C0%7C638862968082007982%7CUnknown%7CTWFp
> > bGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4z
> > MiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=kp4EqnV
> > lfUsVq4k9UV33LSpiwn%2F2OJlPzu2PApAttNs%3D&reserved=0

-- 
மணிவண்ணன் சதாசிவம்

