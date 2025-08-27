Return-Path: <linux-pci+bounces-34931-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23146B38894
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 19:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E1E57B6B45
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 17:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4F82D5A14;
	Wed, 27 Aug 2025 17:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBB1hUDx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCD221FF55;
	Wed, 27 Aug 2025 17:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756315684; cv=none; b=VkBvYIUFkmeSFJkhzHXOlkE9nj7Sjsoot2Hcpj3VLXF0NVEBwVKSJeKv0sfLZ4ak6hdyXKZ0vfDVUKQSiYPLfXI9tVYf/jvnagPQ9bOTQdnYh0B1ZGkeMyhcH5GvswYNi3+mta/OJ1jknyM9b7EKcOdk2/zJAfbg84f2u7VYnyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756315684; c=relaxed/simple;
	bh=eCrM59PsVPe9Woe+deQYZBGnEzzCSKoFCj9LLnGZrP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwoqRaAIpk6W0UrZ5N3b4JXdd3iEqg0+8Cq+jtsxw3uil2LrNqnE7oEWjq+e9DIr7AKnGDkrxgjvCS+/pdAqkxTNeHZfTb5xcjBHw68AfKxHcmxcx7RycRc0G3998F8TDtvmQSD5KVVgyUdjC1l92tiB05e5dYy15HXPi+D0juw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBB1hUDx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F59C4CEEB;
	Wed, 27 Aug 2025 17:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756315684;
	bh=eCrM59PsVPe9Woe+deQYZBGnEzzCSKoFCj9LLnGZrP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PBB1hUDxBn6uuVKrLdq9g3OvYfgdRcoE8pfxvTvd5i+/nr94RSe7bWL9r5hJZp+x5
	 m/evoylqvqOugK9Oe1gRtnPuVUzeGdToQ5PkHU0sSfPH0heDr+w50X7gJ+1tmx48Wp
	 At9FeVVcfTfwLPlJQ/EItqwGAtS0YGa/JtRKPxxzXwDXTwfu4+wmcc2kDYpvn80njR
	 66RuSyqxm3/c/OZxUFrDLzMZsOb04rh0lO5nz+Pi1YzQDrjmVgtqwdyUrb8Y3X94LM
	 oC5yc3+TzYjmnrkAq+22X2uVSuYAN/AabHDM5wuSZNunted097IZ2QuJRqgjd5mMMd
	 YF7eFoqjdmbMw==
Date: Wed, 27 Aug 2025 22:57:57 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Saravana Kannan <saravanak@google.com>, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 5/6] PCI: qcom: Parse PERST# from all PCIe bridge nodes
Message-ID: <gcrf4q45gpcmnvdz55qoga6sc7mxrizzhnb4h6afwgk4cmamp4@mggbezcfivff>
References: <20250819-pci-pwrctrl-perst-v1-0-4b74978d2007@oss.qualcomm.com>
 <20250819-pci-pwrctrl-perst-v1-5-4b74978d2007@oss.qualcomm.com>
 <CAMRc=MdyTOYyeMJa_HBgJVo=ZNxsgdTsw6rhOUmGtNYeSrXLCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdyTOYyeMJa_HBgJVo=ZNxsgdTsw6rhOUmGtNYeSrXLCw@mail.gmail.com>

On Wed, Aug 27, 2025 at 06:34:38PM GMT, Bartosz Golaszewski wrote:
> On Tue, Aug 19, 2025 at 9:15 AM Manivannan Sadhasivam via B4 Relay
> <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
> >
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> >
> > Devicetree schema allows the PERST# GPIO to be present in all PCIe bridge
> > nodes, not just in Root Port node. But the current logic parses PERST# only
> > from the Root Port node. Though it is not causing any issue on the current
> > platforms, the upcoming platforms will have PERST# in PCIe switch
> > downstream ports also. So this requires parsing all the PCIe bridge nodes
> > for the PERST# GPIO.
> >
> > Hence, rework the parsing logic to extend to all PCIe bridge nodes starting
> > from Root Port node. If the 'reset-gpios' property is found for a node, the
> > GPIO descriptor will be stored in IDR structure with node BDF as the ID.
> >
> > It should be noted that if more than one bridge node has the same GPIO for
> > PERST# (shared PERST#), the driver will error out. This is due to the
> > limitation in the GPIOLIB subsystem that allows only exclusive (non-shared)
> > access to GPIOs from consumers. But this is soon going to get fixed. Once
> > that happens, it will get incorporated in this driver.
> >
> > So for now, PERST# sharing is not supported.
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 90 +++++++++++++++++++++++++++-------
> >  1 file changed, 73 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index bcd080315d70e64eafdefd852740fe07df3dbe75..5d73c46095af3219687ff77e5922f08bb41e43a9 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/iopoll.h>
> >  #include <linux/kernel.h>
> >  #include <linux/limits.h>
> > +#include <linux/idr.h>
> >  #include <linux/init.h>
> >  #include <linux/of.h>
> >  #include <linux/of_pci.h>
> > @@ -286,6 +287,7 @@ struct qcom_pcie {
> >         const struct qcom_pcie_cfg *cfg;
> >         struct dentry *debugfs;
> >         struct list_head ports;
> > +       struct idr perst;
> >         bool suspended;
> >         bool use_pm_opp;
> >  };
> > @@ -294,14 +296,15 @@ struct qcom_pcie {
> >
> >  static void qcom_perst_assert(struct qcom_pcie *pcie, bool assert)
> >  {
> > -       struct qcom_pcie_port *port;
> >         int val = assert ? 1 : 0;
> > +       struct gpio_desc *perst;
> > +       int bdf;
> >
> > -       if (list_empty(&pcie->ports))
> > +       if (idr_is_empty(&pcie->perst))
> >                 gpiod_set_value_cansleep(pcie->reset, val);
> > -       else
> > -               list_for_each_entry(port, &pcie->ports, list)
> > -                       gpiod_set_value_cansleep(port->reset, val);
> > +
> > +       idr_for_each_entry(&pcie->perst, perst, bdf)
> > +               gpiod_set_value_cansleep(perst, val);
> >  }
> >
> >  static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
> > @@ -1702,20 +1705,58 @@ static const struct pci_ecam_ops pci_qcom_ecam_ops = {
> >         }
> >  };
> >
> > -static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node)
> > +/* Parse PERST# from all nodes in depth first manner starting from @np */
> > +static int qcom_pcie_parse_perst(struct qcom_pcie *pcie,
> > +                                struct device_node *np)
> >  {
> >         struct device *dev = pcie->pci->dev;
> > -       struct qcom_pcie_port *port;
> >         struct gpio_desc *reset;
> > -       struct phy *phy;
> >         int ret;
> >
> > -       reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
> > -                                     "reset", GPIOD_OUT_HIGH, "PERST#");
> > -       if (IS_ERR(reset))
> > +       if (!of_find_property(np, "reset-gpios", NULL))
> > +               goto parse_child_node;
> > +
> > +       ret = of_pci_get_bdf(np);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(np), "reset",
> > +                                     GPIOD_OUT_HIGH, "PERST#");
> > +       if (IS_ERR(reset)) {
> > +               /*
> > +                * FIXME: GPIOLIB currently supports exclusive GPIO access only.
> > +                * Non exclusive access is broken. But shared PERST# requires
> > +                * non-exclusive access. So once GPIOLIB properly supports it,
> > +                * implement it here.
> > +                */
> > +               if (PTR_ERR(reset) == -EBUSY)
> > +                       dev_err(dev, "Shared PERST# is not supported\n");
> 
> Then maybe just use the GPIOD_FLAGS_BIT_NONEXCLUSIVE flag for now and
> don't bail-out - it will make it easier to spot it when converting to
> the new solution?
> 

But that gives the impression that shared PERST# is supported, but in reality it
is not.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

