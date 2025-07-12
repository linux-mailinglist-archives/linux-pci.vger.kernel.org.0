Return-Path: <linux-pci+bounces-31989-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCBEB02991
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 08:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F1753B7B94
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 06:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C5C1FBEA6;
	Sat, 12 Jul 2025 06:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3A4sEcx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390DA1E5B72;
	Sat, 12 Jul 2025 06:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752301258; cv=none; b=fPDjkAPzfLwmURCxLYjL79r3wWKqxSxbqyl5xEv5Yp+1TNz3LPe0gdStfYfIE79GG2yfdwSTNa5MZ2HW6lfFF8aEGsPckwEJ6DrGwM651303invnaDuMvB4rP3MXwgncfcaJTAW240mGUazQ6iFRkz1x/bYdKxbtbbet55bHC+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752301258; c=relaxed/simple;
	bh=QkNmhcbEazvrT9uEtFGrAFrqrlYwTmySxFHAtjav3gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhPVXtf2mG7Hyx/sbsoUcDdjtAVjUqNZ3USc/q/Dh0lU86J4iBU4h4wGgi8z96FKDkB6QndQNRt73lGDi65s5JggOFClM8CLjoGpg20wD9U2BRF4XvAu9RZIbpKf0Kkp8RLzSmE8q5IlJru/xm98ljKJTq0yr6/BaK7dPU4AVHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3A4sEcx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088D0C4CEEF;
	Sat, 12 Jul 2025 06:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752301258;
	bh=QkNmhcbEazvrT9uEtFGrAFrqrlYwTmySxFHAtjav3gQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M3A4sEcxfppnWxOi4Fre6laQwk0WY+cdzc3eXYFxrEN33lW3nsWH3oT5GRJzfeSAk
	 YtXE2V64avcKjQdVJtBKoM+fAEUUt7NyU54e+qf2LyyGplRjD6Yq8gjhxx2adse4Jd
	 FG1/9Iaoy0M+H4h6aeNCDbdlHj1uum5G4wG3aCsYX/rJ1jryeysQS2kAoxcNjlTwL0
	 t4ZzUPCje6uAO1ukAM7ayd2w9elkKgiOotXit0JoIzGP9r8DbMe18/t25KrIUEh+Iy
	 E+53tgWpHrOKpth2XQoOQhKMO3WXd5KvlFi2qKUZZPXdVv7ZEVvZZ+xmz8lJR0Fbxh
	 W3Jns+oCzBkhA==
Date: Sat, 12 Jul 2025 11:50:43 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH RFC 3/3] PCI: qcom: Allow pwrctrl framework to control
 PERST#
Message-ID: <qolpaorpkoyr5vzuowx3ml7uzwf4xc6atikrpilvbprc2ny5no@rcune7o57fuz>
References: <20250707-pci-pwrctrl-perst-v1-0-c3c7e513e312@kernel.org>
 <20250707-pci-pwrctrl-perst-v1-3-c3c7e513e312@kernel.org>
 <aHGhd3LLg8Dwk1qn@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aHGhd3LLg8Dwk1qn@google.com>

On Fri, Jul 11, 2025 at 04:42:47PM GMT, Brian Norris wrote:
> Hi,
> 
> On Mon, Jul 07, 2025 at 11:48:40PM +0530, Manivannan Sadhasivam wrote:
> > Since the Qcom platforms rely on pwrctrl framework to control the power
> > supplies, allow it to control PERST# also. PERST# should be toggled during
> > the power-on and power-off scenarios.
> > 
> > But the controller driver still need to assert PERST# during the controller
> > initialization. So only skip the deassert if pwrctrl usage is detected. The
> > pwrctrl framework will deassert PERST# after turning on the supplies.
> > 
> > The usage of pwrctrl framework is detected based on the new DT binding
> > i.e., with the presence of PERST# and PHY properties in the Root Port node
> > instead of the host bridge node.
> 
> I just noticed what this paragraph means. IIUC, this implies that in
> your new binding, one *must* describe one or more *-supply in the port
> or endpoint device(s). Otherwise, no pwrctrl devices will be created,
> and no one will deassert PERST# for you. My understanding is that
> *-supply is optional, and so this is a poor requirement.
> 

Your understanding is correct. But the problem is, you thought that pwrctrl
would work across all platforms without any modifications, which unfortunately
is not true and is the main source of confusion. And I never claim anywhere that
pwrctrl is ready for all platforms. I just want platforms to start showing
interest towards it and we will collectively solve the issues. Or I'll be happy
to solve the issues if platform maintainers show interest towards it. This is
what currently happening with brcmstb. I signed up for the transition to
pwrctrl as their out-of-tree is breaking with pwrctrl.

Right now, we indeed create pwrctrl device based on the presence of power
supplies as that's how the sole user of pwrctrl (Qcom platforms) behave. But
sure, for some other platforms we might have only 'reset-gpios'. When we have to
support those platforms, we will extend the logic.

> And even if all QCOM device trees manage to have external regulators
> described in their device trees, there are certainly other systems where
> the driver might (optionally) use pwrctrl for some devices, but others
> will establish power on their own (e.g., PCIe tied to some other system
> power rail).
> 
> I think you either need the PCI core to tell you whether pwrctrl is in
> use, or else you need to disconnect this PERST# support from pwrctrl.
> 

It is not straightforward for the PCI core to tell whether pwrctrl is in use or
not. pwrctrl has no devicetree representation as it is not a separate hardware
entity. It just reuses the PCI device DT node. So I used the -supply properties
to assume that the pwrctrl device will be used. And almost none of the upstream
DTS has -supply properties in the PCI child node (only exception is brcmstb
where they define -supply properties in the PCI child node, but only in the DT
binding). So that added up.

> > When the legacy binding is used, PERST# is only controlled by the
> > controller driver since it is not reliable to detect whether pwrctrl is
> > used or not. So the legacy platforms are untouched by this commit.
> > 
> > Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-host.c |  1 +
> >  drivers/pci/controller/dwc/pcie-designware.h      |  1 +
> >  drivers/pci/controller/dwc/pcie-qcom.c            | 26 ++++++++++++++++++++++-
> >  3 files changed, 27 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index af6c91ec7312bab6c6e5ad35b051d0f452fe7b8d..e45f53bb135a75963318666a479eb6d9582f30eb 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -492,6 +492,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> >  		return -ENOMEM;
> >  
> >  	pp->bridge = bridge;
> > +	bridge->perst = pp->perst;
> >  
> >  	ret = dw_pcie_host_get_resources(pp);
> >  	if (ret)
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index 4165c49a0a5059cab92dee3c47f8024af9d840bd..7b28f76ebf6a2de8781746eba43a8e3ad9a5cbb2 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -430,6 +430,7 @@ struct dw_pcie_rp {
> >  	struct resource		*msg_res;
> >  	bool			use_linkup_irq;
> >  	struct pci_eq_presets	presets;
> > +	struct gpio_desc	**perst;
> >  };
> >  
> >  struct dw_pcie_ep_ops {
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 620ac7cf09472b84c37e83ee3ce40e94a1d9d878..61e1d0d6469030c549328ab4d8c65d5377d525e3 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -313,6 +313,11 @@ static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
> >  
> >  static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
> >  {
> > +	struct dw_pcie_rp *pp = &pcie->pci->pp;
> > +
> > +	if (pp->perst)
> 
> You're doing a non-NULL check here, but you forgot to reinitialize it to
> NULL in some cases below (qcom_pcie_parse_ports()).
> 
> This is also apparently where you assume |perst| implies pwrctrl. Per
> above, I don't think that's a good assumption.
> 

Atleast this assumption holds true for now. Otherwise, I'd have to implement
callbacks without any users.

> > +		return;
> > +
> >  	/* Ensure that PERST has been asserted for at least 100 ms */
> >  	msleep(PCIE_T_PVPERL_MS);
> >  	qcom_perst_assert(pcie, false);
> ...
> >  static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
> >  {
> > +	struct dw_pcie_rp *pp = &pcie->pci->pp;
> >  	struct device *dev = pcie->pci->dev;
> >  	struct qcom_pcie_port *port, *tmp;
> > +	int child_cnt;
> >  	int ret = -ENOENT;
> >  
> > +	child_cnt = of_get_available_child_count(dev->of_node);
> > +	if (!child_cnt)
> > +		return ret;
> > +
> > +	pp->perst = kcalloc(child_cnt, sizeof(struct gpio_desc *), GFP_KERNEL);
> > +	if (!pp->perst)
> > +		return -ENOMEM;
> > +
> >  	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> >  		ret = qcom_pcie_parse_port(pcie, of_port);
> >  		if (ret)
> > @@ -1747,6 +1769,7 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
> >  	return ret;
> >  
> >  err_port_del:
> > +	kfree(pp->perst);
> 
> You need this too:
> 
> 	pp->perst = NULL;
> 
> Otherwise, you leave a non-NULL (invalid) pointer for cases that
> qcom_pcie_parse_legacy_binding() might handle.
> 

Right, thanks for spotting!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

