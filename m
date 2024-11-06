Return-Path: <linux-pci+bounces-16176-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCACD9BF94A
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 23:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 841351F228BB
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 22:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73FA20CCD8;
	Wed,  6 Nov 2024 22:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwBqoK48"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FA120C313;
	Wed,  6 Nov 2024 22:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730932176; cv=none; b=N4iyeq79SeU26g/MZjModXsbkkjO0Be9fhQgvAAHA0nSLxWu8UaYNrj5QS4jJglCG7C+FSuWpYwDKEvnIUbFbXjuVdFEi/yGQO3fZlKr+taRkUyP1Cf+wrUbYtu6fiKsUKrrd571zh6aXKBlKoo5d9JxcPiu2gRQGsScATmIWew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730932176; c=relaxed/simple;
	bh=FHEZ8Db5PTgMmVRyesXrgUdXjQUoWglkt/etn3U6PNE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eWdni2068q5zQxvNyP2ssIxY2BcrgQFyp0mAxCatkdwKvPY5b/EqfpEA9AR70qTsPdN32rHt56jqap1KJQjN9cwcpd2jNsi83nBeVbgqut3i57nzihmqcuAdS0TUD61aPTI0R87WVjzJR2Fg0VufrGME9jFgwTo7oAflR6nSxYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwBqoK48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B420EC4CEC6;
	Wed,  6 Nov 2024 22:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730932175;
	bh=FHEZ8Db5PTgMmVRyesXrgUdXjQUoWglkt/etn3U6PNE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VwBqoK488rj4i5ZAs5nN/uCeP7h7zth66K1wgO39pGpLfXIiXeWtenBjfJhyvMNe7
	 mv07rsD6goSN/i0a8VR0F/IyfTPfMRI2Dv8i/Pvw8CLQaASyp4rwG1bScAnkMmqQ61
	 v60vLFFo0q2VvD6AucpE0Tj5ln7xxE813lpwCzQGU0oJO0flmfj5X8mLi9v7BMW9Sz
	 xSDL7J8lSfqV8JVK+mJBUZOmu2Je/8o5LQXTVqoEjnqjbMahPp4xtaqDCdfSInx1lT
	 QPZVvbKUkgWbaDLDo2fR+Yic0+RMp1Gh3L2ncFFu7w90J4AGSqJZPCfpdZ5jMow2Ra
	 S2rstTiEMhKzw==
Date: Wed, 6 Nov 2024 16:29:33 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	Frank Li <frank.li@nxp.com>, "mani@kernel.org" <mani@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH v2] PCI: dwc: Fix resume failure if no EP is connected at
 some platforms
Message-ID: <20241106222933.GA1543549@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8676998092241543AEABFAAB8C532@AS8PR04MB8676.eurprd04.prod.outlook.com>

On Wed, Nov 06, 2024 at 01:59:41AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: 2024年11月6日 7:27
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: kwilczynski@kernel.org; bhelgaas@google.com;
> > lorenzo.pieralisi@arm.com; Frank Li <frank.li@nxp.com>; mani@kernel.org;
> > linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; kernel@pengutronix.de; imx@lists.linux.dev
> > Subject: Re: [PATCH v2] PCI: dwc: Fix resume failure if no EP is connected at
> > some platforms
> > 
> > On Mon, Jul 22, 2024 at 02:15:13PM +0800, Richard Zhu wrote:
> > > The dw_pcie_suspend_noirq() function currently returns success
> > > directly if no endpoint (EP) device is connected. However, on some
> > > platforms, power loss occurs during suspend, causing dw_resume() to do
> > > nothing in this case.
> > > This results in a system halt because the DWC controller is not
> > > initialized after power-on during resume.

> > > @@ -933,23 +933,23 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
> > >  	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) &
> > PCI_EXP_LNKCTL_ASPM_L1)
> > >  		return 0;
> > >
> > > -	if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_ACT)
> > > -		return 0;
> > > -
> > > -	if (pci->pp.ops->pme_turn_off)
> > > -		pci->pp.ops->pme_turn_off(&pci->pp);
> > > -	else
> > > -		ret = dw_pcie_pme_turn_off(pci);
> > > +	if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_ACT) {
> > > +		/* Only send out PME_TURN_OFF when PCIE link is up */
> > > +		if (pci->pp.ops->pme_turn_off)
> > > +			pci->pp.ops->pme_turn_off(&pci->pp);
> > > +		else
> > > +			ret = dw_pcie_pme_turn_off(pci);
> > 
> > This looks possibly racy since the link can go down at any point.
>
> When link is down and without this commit changes,
> dw_pcie_suspend_noirq() return directly, and the PME_TURN_OFF
> wouldn't be kicked off.

Right, that's the code change.

> I change the behavior to issue the PME_TURN_OFF when link is up
> here.

But I don't think you responded to the race question.  What happens
here?

  if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_ACT) {
    --> link goes down here <--
    pci->pp.ops->pme_turn_off(&pci->pp);

You decide the LTSSM is active and the link is up.  Then the link goes
down.  Then you send PME_Turn_off.  Now what?

If it's safe to try to send PME_Turn_off regardless of whether the
link is up or down, there would be no need to test the LTSSM state.

Bjorn

