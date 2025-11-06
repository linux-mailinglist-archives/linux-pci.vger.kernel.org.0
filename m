Return-Path: <linux-pci+bounces-40519-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79573C3BC49
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 15:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8088418854A6
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 14:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FACD33033E;
	Thu,  6 Nov 2025 14:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJX7t4pg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19781E3DE8;
	Thu,  6 Nov 2025 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439534; cv=none; b=vCkR7pURWsMe81G9BSbXUAIHtUR3WGrP/yz5MhAmoUSdGxWE09KlmJClU1t+JZ/2qPRqBtPGFGwFDQO1ACxGFUcNHiTUTSzx5gnUPxE0Mvo1uUY37WGfbiE1xJdc3sFjuwzf65ixqEa80NtLKx4OhI02tJhkpoRq+6izJeCngAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439534; c=relaxed/simple;
	bh=smxgPni+XOx0Jk4VOOGxnMqDJbqmptrO8uIANUW5hTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNEc8PVwtDrz1oSN8+ctfc9VqQP43apy1nnL/xxkQDGq9K4iiYhnq+EDeZFszBMthUf8QuS15Gmgda9f3dxCTiySbEdRQo1385TJKTfZedFba8Ts8wnLthHYgxWTpNnPlEdVepj/AgnXOXbDRw/NniiZyK+PtmHHaBLNogSUMto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJX7t4pg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C30C4CEFB;
	Thu,  6 Nov 2025 14:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762439533;
	bh=smxgPni+XOx0Jk4VOOGxnMqDJbqmptrO8uIANUW5hTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bJX7t4pg/WECd8xf1IbVsO8VZ1eDnUzlNB0hmqShiM/x27ndGfn7cho4Hx06zPu0x
	 7b+AJBpRegoceGugk00Ui/ZlHDNxbgIMedoMSLRaYfrc2Swqsx+0vk/5JMw6QtaCC/
	 WOiW3HINNKJ5NMPBMwTpjDxUfdWQiX4iN0JUOkd47XFH6Awl3CguDmCeAbcGvekSPv
	 o8KR2ruASPDQpxP1Ghahhhk3y97WpVakDpKmhP3v/h/lIRdXgZkLqhoqW3LG1OlmYC
	 Kp5U6ynuEXElDHuW1UYIGkrBlnue6gx/YgOjyGESRV3M1GeVRFg2OTe8G1WJNe9nfP
	 b1LvApkuH+Wqg==
Date: Thu, 6 Nov 2025 20:02:01 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH 4/4] power: sequencing: Add the Power Sequencing driver
 for the PCIe M.2 connectors
Message-ID: <5wbwpr7ivnvpttacyl7b5fsexfda2uvoqau7yaaxuavskka4z6@vvntbnakzrjb>
References: <20251105-pci-m2-v1-0-84b5f1f1e5e8@oss.qualcomm.com>
 <20251105-pci-m2-v1-4-84b5f1f1e5e8@oss.qualcomm.com>
 <CAMRc=McB4Zk8WuSPL=7+7kX4RJbdFBNReWZyiFnH8vfVx3DxAg@mail.gmail.com>
 <tc2r2mme4wtre7vb7xj22vz55pks4fbdabyl62mgutyhcjxnlx@qn4jvx3jqhie>
 <CAMRc=McDYL_B+hFtLekevtB2XpUkaMN1dsDNeefvR+ppj4whFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McDYL_B+hFtLekevtB2XpUkaMN1dsDNeefvR+ppj4whFg@mail.gmail.com>

On Thu, Nov 06, 2025 at 10:53:05AM +0100, Bartosz Golaszewski wrote:
> On Wed, Nov 5, 2025 at 6:46 PM Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Wed, Nov 05, 2025 at 05:21:46PM +0100, Bartosz Golaszewski wrote:
> > > On Wed, Nov 5, 2025 at 10:17 AM Manivannan Sadhasivam
> > > <manivannan.sadhasivam@oss.qualcomm.com> wrote:
> > > >
> > > > This driver is used to control the PCIe M.2 connectors of different
> > > > Mechanical Keys attached to the host machines and supporting different
> > > > interfaces like PCIe/SATA, USB/UART etc...
> > > >
> > > > Currently, this driver supports only the Mechanical Key M connectors with
> > > > PCIe interface. The driver also only supports driving the mandatory 3.3v
> > > > and optional 1.8v power supplies. The optional signals of the Key M
> > > > connectors are not currently supported.
> > > >
> > >
> > > I'm assuming you followed some of the examples from the existing WCN
> > > power sequencing driver. Not all of them are good or matching this
> > > one, please see below.
> > >
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > > ---
> > > >  MAINTAINERS                               |   7 ++
> > > >  drivers/power/sequencing/Kconfig          |   8 ++
> > > >  drivers/power/sequencing/Makefile         |   1 +
> > > >  drivers/power/sequencing/pwrseq-pcie-m2.c | 138 ++++++++++++++++++++++++++++++
> > > >  4 files changed, 154 insertions(+)
> > > >
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 46126ce2f968e4f9260263f1574ee29f5ff0de1c..9b3f689d1f50c62afa3772a0c6802f99a98ac2de 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -20474,6 +20474,13 @@ F:     Documentation/driver-api/pwrseq.rst
> > > >  F:     drivers/power/sequencing/
> > > >  F:     include/linux/pwrseq/
> > > >
> > > > +PCIE M.2 POWER SEQUENCING
> > > > +M:     Manivannan Sadhasivam <mani@kernel.org>
> > > > +L:     linux-pci@vger.kernel.org
> > > > +S:     Maintained
> > > > +F:     Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
> > > > +F:     drivers/power/sequencing/pwrseq-pcie-m2.c
> > > > +
> > > >  POWER STATE COORDINATION INTERFACE (PSCI)
> > > >  M:     Mark Rutland <mark.rutland@arm.com>
> > > >  M:     Lorenzo Pieralisi <lpieralisi@kernel.org>
> > > > diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
> > > > index 280f92beb5d0ed524e67a28d1c5dd264bbd6c87e..f5fff84566ba463b55d3cd0c07db34c82f9f1e31 100644
> > > > --- a/drivers/power/sequencing/Kconfig
> > > > +++ b/drivers/power/sequencing/Kconfig
> > > > @@ -35,4 +35,12 @@ config POWER_SEQUENCING_TH1520_GPU
> > > >           GPU. This driver handles the complex clock and reset sequence
> > > >           required to power on the Imagination BXM GPU on this platform.
> > > >
> > > > +config POWER_SEQUENCING_PCIE_M2
> > > > +       tristate "PCIe M.2 connector power sequencing driver"
> > > > +       depends on OF || COMPILE_TEST
> > >
> > > The OF dependency in the WCN driver is there because we're doing some
> > > phandle parsing and inspecting the parent-child relationships of the
> > > associated nodes. It doesn't look like you need it here. On the other
> > > hand, if you add more logic to the match() callback, this may come
> > > into play.
> > >
> >
> > For sure the driver will build fine for !CONFIG_OF, but it is not going to work.
> > And for the build coverage, COMPILE_TEST is already present. Maybe I was wrong
> > to enforce functional dependency in Kconfig.
> >
> 
> Given what you said below for the regulator API, let's keep it as is.
> 
> > > > +
> > > > +static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
> > > > +                                struct device *dev)
> > > > +{
> > > > +       return PWRSEQ_MATCH_OK;
> > >
> > > Eek! That will match any device we check. I'm not sure this is what
> > > you want. Looking at the binding example, I assume struct device *
> > > here will be the endpoint? If so, you should resolve it and confirm
> > > it's the one referenced from the connector node.
> > >
> >
> > I was expecting this question, so returned PWRSEQ_MATCH_OK on purpose. I feel it
> > is redundant to have match callback that just does link resolution and matches
> > the of_node of the caller. Can't we have a default match callback that does just
> > this?
> >
> 
> To be clear: the above is certainly wrong. Any power sequencing
> consumer would match against this device.
> 
> To answer your question: sure, there is nothing wrong with having a
> default match callback but first: I'd like to see more than one user
> before we generalize it, and second: it still needs some logic. What
> is the relationship between the firmware nodes of dev and pwrseq here
> exactly?
> 

The 'dev' belongs to the PCIe Root Port node where the graph port is defined:

&pcie6_port0 {
	...
	port {
		pcie6a_port0_ep: endpoint {
			remote-endpoint = <&m2_pcie_ep>;
		};
	};
};

So I have to do remote-endpoint lookup from the pwrseq and compare the of_node
of the parent with 'dev->of_node', I believe. If so, this looks like a common
pattern.

> > > > +       if (!ctx->pdata)
> > > > +               return dev_err_probe(dev, -ENODEV,
> > > > +                                    "Failed to obtain platform data\n");
> > > > +
> > > > +       ret = of_regulator_bulk_get_all(dev, dev_of_node(dev), &ctx->regs);
> > >
> > > Same here, you already have the device, no need to get the regulators
> > > through the OF node. Just use devm_regulator_bulk_get()
> > >
> >
> > I used it on purpose. This is the only regulator API that just gets all
> > regulators defined in the devicetree node without complaining. Here, 3.3v is
> > mandatory and 1.8v is optional. There could be other supplies in the future and
> > I do not want to hardcode the supply names in the driver. IMO, the driver should
> > trust devicetree to supply enough supplies and it should just consume them
> > instead of doing validation. I proposed to add a devm_ variant for this, but
> > Mark was against that idea.
> >
> 
> What was the reason for being against it?

Mark doesn't want the drivers to trust DT for regulators. It was an IRC
discussion and the conclusion was the drivers had to specify the supplies
manually and not trust DT to provide required regulators. But then we already
have this API that does the same.

> Anyway: in that case, would
> you mind adding a comment containing what you wrote here so that
> people don't mindlessly try convert it to the regular variant in the
> future?
> 

Sure.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

