Return-Path: <linux-pci+bounces-34930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40737B3888F
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 19:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B6F67B6489
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 17:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594D12D739F;
	Wed, 27 Aug 2025 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbqqmd1z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26239274FEF;
	Wed, 27 Aug 2025 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756315626; cv=none; b=B0ViK3rnamUvWkepRPH+RltgwvtkjguTEG1FFW7DD8cIzBJkZTFSHjd+uSx2p86x4tEkITfInXeiZ7KrwXvpGw610ndAl6Qq8SJfe8QzVjtdUWkwNRTKUAclrT4dJ8CgY3IcqzNjUlnD+6WeQ3i4ZhRE62mQ5lJlzBdv7mvgqFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756315626; c=relaxed/simple;
	bh=jfCzujD04K2qEFGtWo/0kzfZOb+1+aeO6VcJTq7M92w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyP1YC8rpVSB/URKbA3wDj4QwdAmKkYY4xxcP4P9qgZ+uv7xNoGVvoOJj15ryISaokYIkX94SFQviG16Ahwvvb1pZLp5RSuczaxIY+xKEt7pmDuixhsTQkwq9crGPxLnpObFPXnxxtrjNmeYFC7J1MXkusK3nb7vUrUmcUPsSp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbqqmd1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF52C4CEEB;
	Wed, 27 Aug 2025 17:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756315625;
	bh=jfCzujD04K2qEFGtWo/0kzfZOb+1+aeO6VcJTq7M92w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cbqqmd1zUSp5vcT9g0YQI6RrfTpFyfI9QWX0DqrdnJHNB121+U/7YwNW05efbI5Va
	 xeaYq63aJ5WT8er+twcKBnHmiNvN4Yi48iccfBPkjtdH7bfRBHirP3aCoUtgxQPvog
	 /K/kCwMJ3yDQb1kb49Z+pJbA8bU4XgZ6DgsnX2CApjaMhpHEiyM1za97vgbeYSzpnt
	 SEuATk/kRthC+YGBjoQp5INE8tcychesKGMr0PloDYCaJQ9dxUx+6PqZYbrBJ+sTik
	 FUYYEQ+5lZh3FE/BCb3XHArf4uHiiS2oU/piSRxb1DiA29L4z0Wt+luddyXlya0txT
	 T/S9NJA1hQorw==
Date: Wed, 27 Aug 2025 22:56:58 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Saravana Kannan <saravanak@google.com>, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 3/6] PCI/pwrctrl: Add support for toggling PERST#
Message-ID: <3m2vknughsbyg4chwyfmbi6bh33kbwtn6n6izi74nba3fai6uz@oivedr3rftm3>
References: <20250819-pci-pwrctrl-perst-v1-0-4b74978d2007@oss.qualcomm.com>
 <20250819-pci-pwrctrl-perst-v1-3-4b74978d2007@oss.qualcomm.com>
 <CAMRc=Me2P9r9w-UPtjMAEvuQ_oNtibzPBg6tE7s1wdKkLmQgcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Me2P9r9w-UPtjMAEvuQ_oNtibzPBg6tE7s1wdKkLmQgcQ@mail.gmail.com>

On Wed, Aug 27, 2025 at 06:32:30PM GMT, Bartosz Golaszewski wrote:
> On Tue, Aug 19, 2025 at 9:15 AM Manivannan Sadhasivam via B4 Relay
> <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
> >
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> >
> > As per PCIe spec r6.0, sec 6.6.1, PERST# is an auxiliary signal provided by
> > the system to a component as a Fundamental Reset. This signal if available,
> > should conform to the rules defined by the electromechanical form factor
> > specifications like PCIe CEM spec r4.0, sec 2.2.
> >
> > Since pwrctrl driver is meant to control the power supplies, it should also
> > control the PERST# signal if available. But traditionally, the host bridge
> > (controller) drivers are the ones parsing and controlling the PERST#
> > signal. They also sometimes need to assert PERST# during their own hardware
> > initialization. So it is not possible to move the PERST# control away from
> > the controller drivers and it must be shared logically.
> >
> > Hence, add a new callback 'pci_host_bridge::toggle_perst', that allows the
> > pwrctrl core to toggle PERST# with the help of the controller drivers. But
> > care must be taken care by the controller drivers to not deassert the
> > PERST# signal if this callback is populated.
> >
> > This callback if available, will be called by the pwrctrl core during the
> > device power up and power down scenarios. Controller drivers should
> > identify the device using the 'struct device_node' passed during the
> > callback and toggle PERST# accordingly.
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  drivers/pci/pwrctrl/core.c | 27 +++++++++++++++++++++++++++
> >  include/linux/pci.h        |  1 +
> >  2 files changed, 28 insertions(+)
> >
> > diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> > index 6bdbfed584d6d79ce28ba9e384a596b065ca69a4..8a26f432436d064acb7ebbbc9ce8fc339909fbe9 100644
> > --- a/drivers/pci/pwrctrl/core.c
> > +++ b/drivers/pci/pwrctrl/core.c
> > @@ -6,6 +6,7 @@
> >  #include <linux/device.h>
> >  #include <linux/export.h>
> >  #include <linux/kernel.h>
> > +#include <linux/of.h>
> >  #include <linux/pci.h>
> >  #include <linux/pci-pwrctrl.h>
> >  #include <linux/property.h>
> > @@ -61,6 +62,28 @@ void pci_pwrctrl_init(struct pci_pwrctrl *pwrctrl, struct device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(pci_pwrctrl_init);
> >
> > +static void pci_pwrctrl_perst_deassert(struct pci_pwrctrl *pwrctrl)
> > +{
> > +       struct pci_host_bridge *host_bridge = to_pci_host_bridge(pwrctrl->dev->parent);
> > +       struct device_node *np = dev_of_node(pwrctrl->dev);
> > +
> > +       if (!host_bridge->toggle_perst)
> > +               return;
> > +
> > +       host_bridge->toggle_perst(host_bridge, np, false);
> > +}
> > +
> > +static void pci_pwrctrl_perst_assert(struct pci_pwrctrl *pwrctrl)
> > +{
> > +       struct pci_host_bridge *host_bridge = to_pci_host_bridge(pwrctrl->dev->parent);
> > +       struct device_node *np = dev_of_node(pwrctrl->dev);
> > +
> > +       if (!host_bridge->toggle_perst)
> > +               return;
> > +
> > +       host_bridge->toggle_perst(host_bridge, np, true);
> > +}
> > +
> >  /**
> >   * pci_pwrctrl_device_set_ready() - Notify the pwrctrl subsystem that the PCI
> >   * device is powered-up and ready to be detected.
> > @@ -82,6 +105,8 @@ int pci_pwrctrl_device_set_ready(struct pci_pwrctrl *pwrctrl)
> >         if (!pwrctrl->dev)
> >                 return -ENODEV;
> >
> > +       pci_pwrctrl_perst_deassert(pwrctrl);
> > +
> >         pwrctrl->nb.notifier_call = pci_pwrctrl_notify;
> >         ret = bus_register_notifier(&pci_bus_type, &pwrctrl->nb);
> >         if (ret)
> > @@ -103,6 +128,8 @@ void pci_pwrctrl_device_unset_ready(struct pci_pwrctrl *pwrctrl)
> >  {
> >         cancel_work_sync(&pwrctrl->work);
> >
> > +       pci_pwrctrl_perst_assert(pwrctrl);
> > +
> >         /*
> >          * We don't have to delete the link here. Typically, this function
> >          * is only called when the power control device is being detached. If
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 59876de13860dbe50ee6c207cd57e54f51a11079..9eeee84d550bb9f15a90b5db9da03fccef8097ee 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -605,6 +605,7 @@ struct pci_host_bridge {
> >         void (*release_fn)(struct pci_host_bridge *);
> >         int (*enable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
> >         void (*disable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
> > +       void (*toggle_perst)(struct pci_host_bridge *bridge, struct device_node *np, bool assert);
> 
> Shouldn't this be wrapped in an #if IS_ENABLED(PCI_PWRCTL)?
> 

Ack.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

