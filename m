Return-Path: <linux-pci+bounces-42036-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BEFC85382
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 14:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 801473444DB
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 13:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6D41DB125;
	Tue, 25 Nov 2025 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8RmKt9D"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343E83770B;
	Tue, 25 Nov 2025 13:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764078150; cv=none; b=dqSOel82+8zZr9ecOjz4UZmdf4GRmcwpQDQnHGRfJwMiirAvmAF3h/98F0M2Aqv9O7qhGKy7UXuWfKRkJ8J3kNmVICJ9Zv0LRTfWqikF5eU5Vu1BomS03+VfxYzgbvOuHljKTz3i2g21aU+DdIZ5plKeUg41WYWfElnbcEVOVVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764078150; c=relaxed/simple;
	bh=ed4WBLkfa56DJwFl+DKQb2vodTYt5cCQRM6lfl4Y0xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2HCnzVz3iD7iMjBBSRtpclxV5MXGzeFZKt5PBBc3JGjkjx/gmiwby786l2MIMHOjH96YHYvBIw6clA4h6wjgH4lpRr4QSehGD/m+zNZL++ZMkNQTMtJpzu0rkF6NlRO6R8KaBbUpWx1kSiNydIkjm/BZawYiIjESwU1DctNpM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8RmKt9D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59D0C4CEF1;
	Tue, 25 Nov 2025 13:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764078149;
	bh=ed4WBLkfa56DJwFl+DKQb2vodTYt5cCQRM6lfl4Y0xU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l8RmKt9Dqx69FnSupcsmEltPOUN0EjiDInTGN6+gvm4yXWH9e5EPzrdCQzJRoJ+dQ
	 v6nTMufoyQ/NOenjiKsBdnHNp7/Worfp6outM27KTt97tLPXxpBQEahRW8Xk+UFNVr
	 bKUz1kYCSMwBaQiUYuGP0+cEUMvYhsxMZPFB53FG5hYgAcMa1o4FDAZm269eR3329K
	 6i6qqt3vsZPgwO4xPtRTrGVr4N1gxO5jIPnK/VyU4K9350ufJNOm0/PGds0lsA+YhG
	 5M7wqs3Wd+getJrOJOW6xZnNrGW1je/P3raonuPRw6o6/4U6NQmCVnwrKPCB/lhr0S
	 sHlB3YtvEmi9w==
Date: Tue, 25 Nov 2025 19:12:15 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
	Brian Norris <briannorris@chromium.org>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>
Subject: Re: [PATCH 3/5] PCI/pwrctrl: Add APIs for explicitly creating and
 destroying pwrctrl devices
Message-ID: <pjns34mlopgv6wcfd55myh4qbbryfcokrvxdxclbmhkm4c4m5e@ysd4dnmbmsx5>
References: <20251124-pci-pwrctrl-rework-v1-0-78a72627683d@oss.qualcomm.com>
 <20251124-pci-pwrctrl-rework-v1-3-78a72627683d@oss.qualcomm.com>
 <CAGXv+5EyOOwZjUARfLzLvhX_vGdYHRz+0M=GbXaBMcaJ=0w+aA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5EyOOwZjUARfLzLvhX_vGdYHRz+0M=GbXaBMcaJ=0w+aA@mail.gmail.com>

On Tue, Nov 25, 2025 at 04:18:49PM +0800, Chen-Yu Tsai wrote:
> On Tue, Nov 25, 2025 at 3:13 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@oss.qualcomm.com> wrote:
> >
> > From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> >
> > Previously, the PCI core created pwrctrl devices during pci_scan_device()
> > on its own and then skipped enumeration of those devices, hoping the
> > pwrctrl driver would power them on and trigger a bus rescan.
> >
> > This approach works for endpoint devices directly connected to Root Ports,
> > but it fails for PCIe switches acting as bus extenders. When the switch
> > requires pwrctrl support, and the pwrctrl driver is not available during
> > the pwrctrl device creation, it's enumeration will be skipped during the
> > initial PCI bus scan.
> >
> > This premature scan leads the PCI core to allocate resources (bridge
> > windows, bus numbers) for the upstream bridge based on available downstream
> > buses at scan time. For non-hotplug capable bridges, PCI core typically
> > allocates resources based on the number of buses available during the
> > initial bus scan, which happens to be just one if the switch is not powered
> > on and enumerated at that time. When the switch gets enumerated later on,
> > it will fail due to the lack of upstream resources.
> >
> > As a result, a PCIe switch powered on by the pwrctrl driver cannot be
> > reliably enumerated currently. Either the switch has to be enabled in the
> > bootloader or the switch pwrctrl driver has to be loaded during the pwrctrl
> > device creation time to workaround these issues.
> >
> > This commit introduces new APIs to explicitly create and destroy pwrctrl
> > devices from controller drivers by recursively scanning the PCI child nodes
> > of the controller. These APIs allow creating pwrctrl devices based on the
> > original criteria and are intended to be called during controller probe and
> > removal.
> >
> > These APIs, together with the upcoming APIs for power on/off will allow the
> > controller drivers to power on all the devices before starting the initial
> > bus scan, thereby solving the resource allocation issue.
> >
> > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > [mani: splitted the patch, cleaned up the code, and rewrote description]
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  drivers/pci/pwrctrl/core.c  | 112 ++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/pci-pwrctrl.h |   8 +++-
> >  2 files changed, 119 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> > index 6bdbfed584d6..6eca54e0d540 100644
> > --- a/drivers/pci/pwrctrl/core.c
> > +++ b/drivers/pci/pwrctrl/core.c
> > @@ -3,14 +3,21 @@
> >   * Copyright (C) 2024 Linaro Ltd.
> >   */
> >
> > +#define dev_fmt(fmt) "Pwrctrl: " fmt
> > +
> >  #include <linux/device.h>
> >  #include <linux/export.h>
> >  #include <linux/kernel.h>
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> >  #include <linux/pci.h>
> >  #include <linux/pci-pwrctrl.h>
> > +#include <linux/platform_device.h>
> >  #include <linux/property.h>
> >  #include <linux/slab.h>
> >
> > +#include "../pci.h"
> > +
> >  static int pci_pwrctrl_notify(struct notifier_block *nb, unsigned long action,
> >                               void *data)
> >  {
> > @@ -145,6 +152,111 @@ int devm_pci_pwrctrl_device_set_ready(struct device *dev,
> >  }
> >  EXPORT_SYMBOL_GPL(devm_pci_pwrctrl_device_set_ready);
> >
> > +static int pci_pwrctrl_create_device(struct device_node *np, struct device *parent)
> > +{
> > +       struct platform_device *pdev;
> > +       int ret;
> > +
> > +       for_each_available_child_of_node_scoped(np, child) {
> > +               ret = pci_pwrctrl_create_device(child, parent);
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> > +       /* Bail out if the platform device is already available for the node */
> > +       pdev = of_find_device_by_node(np);
> > +       if (pdev) {
> > +               put_device(&pdev->dev);
> > +               return 0;
> > +       }
> > +
> > +       /*
> > +        * Sanity check to make sure that the node has the compatible property
> > +        * to allow driver binding.
> > +        */
> > +       if (!of_property_present(np, "compatible"))
> > +               return 0;
> > +
> > +       /*
> > +        * Check whether the pwrctrl device really needs to be created or not.
> > +        * This is decided based on at least one of the power supplies being
> > +        * defined in the devicetree node of the device.
> > +        */
> > +       if (!of_pci_supply_present(np)) {
> 
> This symbol is not exported for modules to use, and will cause the build
> to fail if PCI_PWRCTRL* is m.
> 

Ok. I'll export this symbol in next version. Thanks for spotting it!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

