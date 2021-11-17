Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B46245491E
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 15:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhKQOuX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 09:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236167AbhKQOuH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Nov 2021 09:50:07 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6603FC061206
        for <linux-pci@vger.kernel.org>; Wed, 17 Nov 2021 06:46:59 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id n29so5163184wra.11
        for <linux-pci@vger.kernel.org>; Wed, 17 Nov 2021 06:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+7hqqiLWrr48kcGFaS+M7RRa+mz7YhBFsacMyU7epdU=;
        b=EJtXzYhGZcSNmWeDFK5M0Qx8G0NZYREaklJ7Gk6dUNu25BzOL1H0pCiJ/BDOX9aagU
         9zkB0RbbQmfeC3Z2wWs/bP2gMZxiYbXE4UFVITuNFI5k14F8xONZ1CK9KVfZ7MQfpm/C
         B2h5x6IY2OFpBcBQ+qP8bcE9JPOn+jylOircc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+7hqqiLWrr48kcGFaS+M7RRa+mz7YhBFsacMyU7epdU=;
        b=P4VIbRmGu5shd5q+PObNz6niuWHxWuVwqth0OkmRuMKLaB95ELwfFoOAmU8DDLlCZl
         A6XF0U6l8G2cV/K2SVUWr/9UAszIfqXygc1LbrXwxO+CMPv2pVNNpPXFBXfVw/MAdfc3
         W8i4EENTPfgfmsev/IrYwC0NyTyGNws1YRuOQXQnSjqYY43kSvfdzJ+piB2pnSYE6Ad6
         mO4kq06ryOwwmznTCuYChd0SLmcWGSwGR5lQjnIkafv6o/6+bDkoORsw3XHqpaBolewe
         Nb4M0NLdflyroRQFOe8eqQo0TZunIWue0+SBVVT/24e1is+9pBQpvT/KikQZqNxFndtw
         +lIQ==
X-Gm-Message-State: AOAM530K+OTv52kX4zg8GFm4OlElCx0oF1cQhcJHLb1jS24RjCFdpNz8
        KE836VFeE1yCbeEOfb8TSSeY2PaJgpe5q0e4tXGsoQ==
X-Google-Smtp-Source: ABdhPJzIFrz/SgJ45sdHrPH7Ndhw067YHedzEF6rp/Sh8vUQabGYn9JSW891AgA2pfT+ChwO0DEsyOzWclL0DvCfogo=
X-Received: by 2002:a5d:6dc1:: with SMTP id d1mr15476057wrz.282.1637160417549;
 Wed, 17 Nov 2021 06:46:57 -0800 (PST)
MIME-Version: 1.0
References: <20211110221456.11977-1-jim2101024@gmail.com> <20211110221456.11977-6-jim2101024@gmail.com>
 <CAL_Jsq+6g-EhyVCeWTMkjOZmBwsOOVZo2jXpzAkjOXcZaxb2eA@mail.gmail.com>
 <CA+-6iNxfrOQtH1JDEjAdSZQkENoaw1tUDTfVc5+G7P6BAbSc6g@mail.gmail.com> <CAL_JsqJno4ROQD38buz8Z-tU5aaQL5b_d1R0-D+c9UwnMKYNOw@mail.gmail.com>
In-Reply-To: <CAL_JsqJno4ROQD38buz8Z-tU5aaQL5b_d1R0-D+c9UwnMKYNOw@mail.gmail.com>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Wed, 17 Nov 2021 09:46:46 -0500
Message-ID: <CA+-6iNy7-CjQpua9tjMt=bLCanbTqRHPkwdKM2AH7HU1a1BQzg@mail.gmail.com>
Subject: Re: [PATCH v8 5/8] PCI/portdrv: add mechanism to turn on subdev regulators
To:     Rob Herring <robh@kernel.org>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 16, 2021 at 12:41 PM Rob Herring <robh@kernel.org> wrote:
>
> +Pali
>
> On Mon, Nov 15, 2021 at 2:44 PM Jim Quinlan <james.quinlan@broadcom.com> wrote:
> >
> > On Thu, Nov 11, 2021 at 5:57 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Wed, Nov 10, 2021 at 4:15 PM Jim Quinlan <jim2101024@gmail.com> wrote:
> > > >
> > > > Adds a mechanism inside the root port device to identify standard PCIe
> > > > regulators in the DT, allocate them, and turn them on before the rest of
> > > > the bus is scanned during pci_host_probe().  A root complex driver can
> > > > leverage this mechanism by setting the pci_ops methods add_bus and
> > > > remove_bus to pci_subdev_regulators_{add,remove}_bus.
> > > >
> > > > The allocated structure that contains the regulators is stored in
> > > > dev.driver_data.
> > > >
> > > > The unabridged reason for doing this is as follows.  We would like the
> > > > Broadcom STB PCIe root complex driver (and others) to be able to turn
> > > > off/on regulators[1] that provide power to endpoint[2] devices.  Typically,
> > > > the drivers of these endpoint devices are stock Linux drivers that are not
> > > > aware that these regulator(s) exist and must be turned on for the driver to
> > > > be probed.  The simple solution of course is to turn these regulators on at
> > > > boot and keep them on.  However, this solution does not satisfy at least
> > > > three of our usage modes:drivers/pci/pcie/aspm.cdrivers/pci/pcie/aspm.c
> > > >
> > > > 1. For example, one customer uses multiple PCIe controllers, but wants the
> > > > ability to, by script invoking and unbind, turn any or all of them by and
> > > > their subdevices off to save power, e.g. when in battery mode.
> > > >
> > > > 2. Another example is when a watchdog script discovers that an endpoint
> > > > device is in an unresponsive state and would like to unbind, power toggle,
> > > > and re-bind just the PCIe endpoint and controller.
> > > >
> > > > 3. Of course we also want power turned off during suspend mode.  However,
> > > > some endpoint devices may be able to "wake" during suspend and we need to
> > > > recognise this case and veto the nominal act of turning off its regulator.
> > > > Such is the case with Wake-on-LAN and Wake-on-WLAN support where PCIe
> > > > end-point device needs to be kept powered on in order to receive network
> > > > packets and wake-up the system.
> > > >
> > > > In all of these cases it is advantageous for the PCIe controller to govern
> > > > the turning off/on the regulators needed by the endpoint device.  The first
> > > > two cases can be done by simply unbinding and binding the PCIe controller,
> > > > if the controller has control of these regulators.
> > > >
> > > > [1] These regulators typically govern the actual power supply to the
> > > >     endpoint chip.  Sometimes they may be a the official PCIe socket
> > > >     power -- such as 3.3v or aux-3.3v.  Sometimes they are truly
> > > >     the regulator(s) that supply power to the EP chip.
> > > >
> > > > [2] The 99% configuration of our boards is a single endpoint device
> > > >     attached to the PCIe controller.  I use the term endpoint but it could
> > > >     possible mean a switch as well.
> > > >
> > > > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > > > ---
> > > >  drivers/pci/bus.c              | 72 ++++++++++++++++++++++++++++++++++
> > > >  drivers/pci/pci.h              |  8 ++++
> > > >  drivers/pci/pcie/portdrv_pci.c | 32 +++++++++++++++
> > > >  3 files changed, 112 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > > > index 3cef835b375f..c39fdf36b0ad 100644
> > > > --- a/drivers/pci/bus.c
> > > > +++ b/drivers/pci/bus.c
> > > > @@ -419,3 +419,75 @@ void pci_bus_put(struct pci_bus *bus)
> > > >         if (bus)
> > > >                 put_device(&bus->dev);
> > > >  }
> > > > +
> > > > +static void *alloc_subdev_regulators(struct device *dev)
> > > > +{
> > > > +       static const char * const supplies[] = {
> > > > +               "vpcie3v3",
> > > > +               "vpcie3v3aux",
> > > > +               "vpcie12v",
> > > > +       };
> > > > +       const size_t size = sizeof(struct subdev_regulators)
> > > > +               + sizeof(struct regulator_bulk_data) * ARRAY_SIZE(supplies);
> > > > +       struct subdev_regulators *sr;
> > > > +       int i;
> > > > +
> > > > +       sr = devm_kzalloc(dev, size, GFP_KERNEL);
> > > > +
> > > > +       if (sr) {
> > > > +               sr->num_supplies = ARRAY_SIZE(supplies);
> > > > +               for (i = 0; i < ARRAY_SIZE(supplies); i++)
> > > > +                       sr->supplies[i].supply = supplies[i];
> > > > +       }
> > > > +
> > > > +       return sr;
> > > > +}
> > > > +
> > > > +
> > > > +int pci_subdev_regulators_add_bus(struct pci_bus *bus)
> > > > +{
> > > > +       struct device *dev = &bus->dev;
> > > > +       struct subdev_regulators *sr;
> > > > +       int ret;
> > > > +
> > > > +       if (!pcie_is_port_dev(bus->self))
> > > > +               return 0;
> > > > +
> > > > +       if (WARN_ON(bus->dev.driver_data))
> > > > +               dev_err(dev, "multiple clients using dev.driver_data\n");
> > > > +
> > > > +       sr = alloc_subdev_regulators(&bus->dev);
> > > > +       if (!sr)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       bus->dev.driver_data = sr;
> > > > +       ret = regulator_bulk_get(dev, sr->num_supplies, sr->supplies);
> > > > +       if (ret)
> > > > +               return ret;
> > > > +
> > > > +       ret = regulator_bulk_enable(sr->num_supplies, sr->supplies);
> > > > +       if (ret) {
> > > > +               dev_err(dev, "failed to enable regulators for downstream device\n");
> > > > +               return ret;
> > > > +       }
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(pci_subdev_regulators_add_bus);
> > >
> > > Can't these just go in the portdrv probe and remove functions now?
> > >
> > > Rob
> >
> > Not really.  The idea is that  only when a host controller driver does this
> >
> > static struct pci_ops my_pcie_ops = {
> >     .add_bus = pci_subdev_regulators_add_bus , /* see  note below */
> >     .remove_bus = pci_subdev_regulators_remove_bus,
> >     ...
> > }
> >
> > does it explicitly want this feature.  Without doing this, every PCI
> > port in the world will execute a devm_kzalloc() and
> > devm_regulator_bulk_get() to (likely) grab nothing, and then there
> > will be three superfluous lines in the boot log:
>
> You can opt-in based on there being a DT node.
Will do, thanks.
>
> > pci_bus 0001:01: 0001:01 supply vpcie12v not found, using dummy regulator
> > pci_bus 0001:01: 0001:01 supply vpcie3v3 not found, using dummy regulator
> > pci_bus 0001:01: 0001:01 supply vpcie3v3aux not found, using dummy regulator
>
> This would be annoying, but not really a reason for how to design this.
>
> > Secondly, our  HW needs to know when the  alloc/get/enable of
> > regulators is done so that the PCIe link can then be attempted.   This
> > is pretty much the cornerstone of this patchset.   To do this the brcm
> > RC driver's call to pci_subdev_regulators_add_bus() is wrapped by
> > brcm_pcie_add_bus() so that we can do this:
> >
> > static struct pci_ops my_pcie_ops = {
> >     .add_bus = brcm_pcie_add_bus ,   /* calls pci_subdev_regulators_add_bus() */
> >     .remove_bus = pci_subdev_regulators_remove_bus,
>
> Do add_bus/remove_bus get called during resume/suspend? If not, how do
> you handle the link during resume?
No to the first question, and incorrectly to the second.  As it turns
out, my suspend/resume test for this patchset was flawed and wasn't
testing what I thought it was.  The suspend/resume is broken in V8.

Using pcie_port_device_resume_noirq() is not early enough to turn on
the regulators during resume.  However,  if I have my RC driver handle
 only the suspend/resume of the regulators, all is fine and as an
added benefit the patchset has no modifications to
portdrv_{pci,core}.c.  This is what I will submit for V9, assuming
there is one.

>
> Maybe there needs to be explicit hooks for link handling. Pali has
> been looking into this some.
I will reply to Pali's recent email now.
Regards,
Jim Quinlan
Broadcom STB
>
> Rob
