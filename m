Return-Path: <linux-pci+bounces-3836-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0994185E562
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 19:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01C128342C
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 18:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1583585264;
	Wed, 21 Feb 2024 18:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEnlp1Od"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECC384FC5;
	Wed, 21 Feb 2024 18:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539606; cv=none; b=fE5nB6pK2N+xPZTxbI30hw090ijgvWbnpmHGLc2cVtJedfqx52vUzfsQ/uYWaH1Yxflj5Dqkx0f9eQDW1rIQIsqSR8tNPcxkOkfV9B+1TS3osqMBzhRcxEIGs1m8JkoEoZadwgja/B1F4WrohIo+Re32ZsAMp+/vwxBTXvKhUtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539606; c=relaxed/simple;
	bh=li3AAvdCGDOSuLorXbpdLhAoR1v3aT31mkw+qfafJus=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Zd0ltvsM6DiUzpshSbTD1eIAoomMuXD5xAeHtm/bscTSjmQYj21R6ywpr5IcdICl78c4+FGy+g+1Wv+Am/hX1J1ummCBxplxFBxoc1pwYMBATAoLY8RYxfUlFtWft4etyXkzTf9DfLvZ0IBeqAMynTjZzLgXoRF0wcGhTw1ApYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEnlp1Od; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19280C433F1;
	Wed, 21 Feb 2024 18:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708539605;
	bh=li3AAvdCGDOSuLorXbpdLhAoR1v3aT31mkw+qfafJus=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WEnlp1OdwtWAiM2QTFeWAdKrsgH2tq1eKMBZ4OythNTbeJUqcd+SU0fXodxrznLjH
	 O7U3ceHcN93Cg2Asa64KuHQz9rAIMrN38z3CYT5eEaZDLi1xxF7WtQyFLwWYRi7Gc9
	 lNoBgE70VNl7ZJWdMM2sJu4LEGDdj32i6aQs2j1LGDWp0UfkJDvogZnS+N34jWlB+E
	 j9BXTsbyzlYUhdKar98mQ2XVvVlZIsQ+M6yPr7TqwJ777lbp4p1eEFOUSDslnuLa0C
	 xnHdSTTs/QJUaJPqJRYSTWWJH+mEAlaoJQtTqtbssQPuWw7qY+WAbMcf5k+cexGvhO
	 HO4XozNa8PFRg==
Date: Wed, 21 Feb 2024 12:20:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	quic_krichai@quicinc.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Add D3 support for PCI bridges in DT based
 platforms
Message-ID: <20240221182000.GA1533634@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240221051958.GA11693@thinkpad>

On Wed, Feb 21, 2024 at 10:49:58AM +0530, Manivannan Sadhasivam wrote:
> On Tue, Feb 20, 2024 at 04:02:40PM -0600, Bjorn Helgaas wrote:
> > On Wed, Feb 14, 2024 at 05:16:09PM +0530, Manivannan Sadhasivam wrote:
> > > Currently, PCI core will enable D3 support for PCI bridges only when the
> > > following conditions are met:
> > 
> > Whenever I read "D3", I first have to figure out whether we're talking
> > about D3hot or D3cold.  Please save me the effort :)
> 
> Both actually, that's why I used "D3" as in the spec. I should've explicitly
> mentioned that in the commit message.
> 
> > > 1. Platform is ACPI based
> > > 2. Thunderbolt controller is used
> > > 3. pcie_port_pm=force passed in cmdline
> > 
> > Are these joined by "AND" or "OR"?  I guess probably "OR"?
> > 
> > "... all the following conditions are met" or "... one of the
> > following conditions is met" would clarify this.
> 
> Will use "one of the..."
> 
> > > While options 1 and 2 do not apply to most of the DT based
> > > platforms, option 3 will make the life harder for distro
> > > maintainers. Due to this, runtime PM is also not getting enabled
> > > for the bridges.
> > > 
> > > To fix this, let's make use of the "supports-d3" property [1] in
> > > the bridge DT nodes to enable D3 support for the capable
> > > bridges. This will also allow the capable bridges to support
> > > runtime PM, thereby conserving power.
> > 
> > Looks like "supports-d3" was added by
> > https://github.com/devicetree-org/dt-schema/commit/4548397d7522.
> > The commit log mentions "platform specific ways", which suggests maybe
> > this is D3cold, since D3hot should be supported via PMCSR without any
> > help from the platform.
> > 
> > So I *guess* this really means "platform provides some non-architected
> > way to put devices in D3cold and bring them back to D0"?
> 
> By reading the comments and git log of the pci_bridge_d3_possible()
> function in drivers/pci/pci.c, we can understand that some of the
> old bridges do not support both D3hot and D3cold. And to
> differentiate such bridges, platforms have to notify the OS using
> some ways.
> 
> ACPI has its own implementation [1] and DT uses "supports-d3"
> property.
> 
> And yes, in an ideal world PMCSR should be sufficient for D3hot, but
> you know the PCI vendors more than me ;)

So it sounds like this is supposed to cover two cases:

  1) D3hot doesn't work per spec.  This sounds like a hardware
     defect in the device that should be a quirk based on
     Vendor/Device ID, not something in DT.  I don't actually know if
     this is common, although there are several existing quirks that
     mention issues with D3.

  2) The platform doesn't support putting the bridge in D3cold and
     back to D0.  I don't understand this either because I assumed DT
     would describe *hardware*, and "supports-d3" might imply the
     presence of hardware power control, but doesn't tell us how to
     operate it, and it must be up to a native driver to know how to
     do it.

These are two vastly different scenarios, and I would really like to
untangle them so they aren't conflated.  I see that you're extending
platform_pci_bridge_d3(), which apparently has that conflation baked
into it already, but my personal experience is that this is really
hard to maintain.

> > > Ideally, D3 support should be enabled by default for the more recent PCI
> > > bridges, but we do not have a sane way to detect them.
> > > 
> > > [1] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/pci-pci-bridge.yaml#L31

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pci-acpi.c#n976
> 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > > This patch is tested on Qcom SM8450 based development board with an out-of-tree
> > > DT patch.
> > > 
> > > NOTE: I will submit the DT patches adding this property for applicable bridges
> > > in Qcom SoCs separately.
> > > 
> > > Changes in v3:
> > > - Fixed kdoc, used of_property_present() and dev_of_node() (Lukas)
> > > - Link to v2: https://lore.kernel.org/r/20240214-pcie-qcom-bridge-v2-1-9dd6dbb1b817@linaro.org
> > > 
> > > Changes in v2:
> > > - Switched to DT based approach as suggested by Lukas.
> > > - Link to v1: https://lore.kernel.org/r/20240202-pcie-qcom-bridge-v1-0-46d7789836c0@linaro.org
> > > ---
> > >  drivers/pci/of.c  | 12 ++++++++++++
> > >  drivers/pci/pci.c |  3 +++
> > >  drivers/pci/pci.h |  6 ++++++
> > >  3 files changed, 21 insertions(+)
> > > 
> > > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > > index 51e3dd0ea5ab..24b0107802af 100644
> > > --- a/drivers/pci/of.c
> > > +++ b/drivers/pci/of.c
> > > @@ -786,3 +786,15 @@ u32 of_pci_get_slot_power_limit(struct device_node *node,
> > >  	return slot_power_limit_mw;
> > >  }
> > >  EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
> > > +
> > > +/**
> > > + * of_pci_bridge_d3 - Check if the bridge is supporting D3 states or not
> > > + *
> > > + * @node: device tree node of the bridge
> > > + *
> > > + * Return: %true if the bridge is supporting D3 states, %false otherwise.
> > > + */
> > > +bool of_pci_bridge_d3(struct device_node *node)
> > > +{
> > > +	return of_property_present(node, "supports-d3");
> > > +}
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index d8f11a078924..8678fba092bb 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -1142,6 +1142,9 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
> > >  	if (pci_use_mid_pm())
> > >  		return false;
> > >  
> > > +	if (dev_of_node(&dev->dev))
> > > +		return of_pci_bridge_d3(dev->dev.of_node);
> > > +
> > >  	return acpi_pci_bridge_d3(dev);
> > >  }
> > >  
> > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > index 2336a8d1edab..10387461b1fe 100644
> > > --- a/drivers/pci/pci.h
> > > +++ b/drivers/pci/pci.h
> > > @@ -635,6 +635,7 @@ int of_pci_get_max_link_speed(struct device_node *node);
> > >  u32 of_pci_get_slot_power_limit(struct device_node *node,
> > >  				u8 *slot_power_limit_value,
> > >  				u8 *slot_power_limit_scale);
> > > +bool of_pci_bridge_d3(struct device_node *node);
> > >  int pci_set_of_node(struct pci_dev *dev);
> > >  void pci_release_of_node(struct pci_dev *dev);
> > >  void pci_set_bus_of_node(struct pci_bus *bus);
> > > @@ -673,6 +674,11 @@ of_pci_get_slot_power_limit(struct device_node *node,
> > >  	return 0;
> > >  }
> > >  
> > > +static inline bool of_pci_bridge_d3(struct device_node *node)
> > > +{
> > > +	return false;
> > > +}
> > > +
> > >  static inline int pci_set_of_node(struct pci_dev *dev) { return 0; }
> > >  static inline void pci_release_of_node(struct pci_dev *dev) { }
> > >  static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
> > > 
> > > ---
> > > base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> > > change-id: 20240131-pcie-qcom-bridge-b6802a9770a3
> > > 
> > > Best regards,
> > > -- 
> > > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

