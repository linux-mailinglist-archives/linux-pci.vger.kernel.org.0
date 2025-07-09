Return-Path: <linux-pci+bounces-31758-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C35CAFE271
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 10:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A05E166F42
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 08:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378172737FA;
	Wed,  9 Jul 2025 08:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLvZ3KjU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083AF272808;
	Wed,  9 Jul 2025 08:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752049446; cv=none; b=fqVtAAK1WM/Glb5myVQltzrFhxrTp17dv/tHnPB/hEwCoS8X9QxT1Y9VoENhxa6r6SIeb0eJxesMUHEkFQ4RpaWZi6RPsw8D/zL/AsyaGHt6nQhDyHhy4Ly85eNvvcD3eS+p2q2qmlkskS98WbHNVcYHTSZajcE5PBekll4uYoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752049446; c=relaxed/simple;
	bh=kd4fZ9hjJhejqE60Ux6jIEdKJbcKfAKqOtQDvcCmobo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfQHeTGJUobgB3oP8e0PPyRZxGDtsNhESe2CgRb4GlEbwWdDsE5Q/ovC7BvYil1Olq2Pfrls3akvCVjYH1na2FkupXXZP1ww1OVyikdrX2WBUAPOAMGwqcfBJv/Qjb/pP8/VrqugxTSdQjaHkhXBHxJ4n0k0XCbDNf7Rjzr/OqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLvZ3KjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4595EC4CEEF;
	Wed,  9 Jul 2025 08:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752049445;
	bh=kd4fZ9hjJhejqE60Ux6jIEdKJbcKfAKqOtQDvcCmobo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FLvZ3KjUKCmazemAEuyodtlyTLhEpoP9m+dwEpnLbYDaOFCZqYbb48gn/E3sJMtE9
	 9nSAUbaGKQSnH4wRpH7dGyKMqVXeqz5snzYI2kIh2Il7ZS/MRfRj0TihdekMgz3ZfR
	 gCyLaSPPdNw367CCXnebmSGz0UPCPOSo/bVjXSm7f7LxRso0dlrJdUDs+xNYYZPOkf
	 9M2XA5ICNM4fn4ILcWdQeHTZFbUIz6DH1NNOGMIaANYjAiqbv4rbnYLy7zbxDBGAgO
	 8Xhkeh1/sZpBnPeHj4p3TtFDlmgYVO6je2bjYQlr7k2PycxbrJ16cT2cYn4WZE/bV4
	 VDCapKAGrs7Yg==
Date: Wed, 9 Jul 2025 13:53:53 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH RFC 3/3] PCI: qcom: Allow pwrctrl framework to control
 PERST#
Message-ID: <btxanvs4enrenhowrf47llnvu6az3jx5gjzba5mulxb5jyqgtp@e5tdobflcyxz>
References: <20250707-pci-pwrctrl-perst-v1-0-c3c7e513e312@kernel.org>
 <20250707-pci-pwrctrl-perst-v1-3-c3c7e513e312@kernel.org>
 <aG3fblf5twIAitvg@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aG3fblf5twIAitvg@google.com>

On Tue, Jul 08, 2025 at 08:18:06PM GMT, Brian Norris wrote:
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
> > 
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
> 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 620ac7cf09472b84c37e83ee3ce40e94a1d9d878..61e1d0d6469030c549328ab4d8c65d5377d525e3 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> 
> > @@ -1724,6 +1730,12 @@ static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node
> >  	if (ret)
> >  		return ret;
> >  
> > +	devfn = of_pci_get_devfn(node);
> > +	if (devfn < 0)
> > +		return -ENOENT;
> > +
> > +	pp->perst[PCI_SLOT(devfn)] = reset;
> 
> It seems like you assume a well-written device tree, such that this
> PCI_SLOT(devfn) doesn't overflow the perst[] array. It seems like we
> should guard against that somehow.
> 

Sure. I will add a check.

> Also see my comment below, where I believe even a well-written device
> tree could trip this up.
> 
> > +
> >  	port->reset = reset;
> >  	port->phy = phy;
> >  	INIT_LIST_HEAD(&port->list);
> > @@ -1734,10 +1746,20 @@ static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node
> >  
> >  static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
> >  {
> > +	struct dw_pcie_rp *pp = &pcie->pci->pp;
> >  	struct device *dev = pcie->pci->dev;
> >  	struct qcom_pcie_port *port, *tmp;
> > +	int child_cnt;
> >  	int ret = -ENOENT;
> >  
> > +	child_cnt = of_get_available_child_count(dev->of_node);
> 
> I think you're assuming "available children" correlate precisely with a
> 0-indexed array of ports. But what if, e.g., port 0 is disabled in the
> device tree, and only port 1 is available? Then you'll overflow.
> 

Right. I will take care it in next version.

> > +	if (!child_cnt)
> > +		return ret;
> > +
> > +	pp->perst = kcalloc(child_cnt, sizeof(struct gpio_desc *), GFP_KERNEL);
> 
> IIUC, you kfree() this on error, but otherwise, you never free it. I
> also see that this driver can't actually be unbound (commit f9a666008338
> ("PCI: qcom: Make explicitly non-modular")), so technically there's no
> way to "leak" this other than by probe errors...
> ...but it still seems like devm_*() would fit better.
> 

Even if we use devm_(), we need to free the array when qcom_pcie_parse_port()
fails. And as you spotted, we don't remove the driver currently. So I decided to
use kfree(). Someone would argue that if we manually free the memory, then it
defeats the purpose of devm_() variants.

> (NB: I'm not sure I agree with commit f9a666008338 that "[driver unbind]
> doesn't have a sensible use case anyway". That just sounds like
> laziness. And it *can* have a useful purpose for testing.)
> 

There was a whole debate on it. It is mostly due to the fact that this driver
implements the MSI controller and the IRQCHIP drivers are not expected to go
away during runtime. But atleast, I would like to build this driver as a module
and not remove it. The patch is pending for some time.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

