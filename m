Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24EC4515FB
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 22:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352335AbhKOVEz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 16:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353256AbhKOUzc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Nov 2021 15:55:32 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF561C06122A
        for <linux-pci@vger.kernel.org>; Mon, 15 Nov 2021 12:44:51 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id u18so33165800wrg.5
        for <linux-pci@vger.kernel.org>; Mon, 15 Nov 2021 12:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vTY9c4nGjIAug267W1FIDAR4zM5DtlqZP0wVMolCP6Y=;
        b=ZK96HyZ2YT+avJ1gsOlAqjWYenDUxGgPr9tGQAWxohnH0c2uivMzzbZz5kQmad8fU1
         OjdtDg1nlws8wGQGHmhE+Sg+MiRV6Ju/TYmo/5EP9AYdFtlJUajxsESL+wtI2F6AyPOE
         p5L+TXv6Zy8YUITp7yqzY8yqmhn/oXubFx9o8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vTY9c4nGjIAug267W1FIDAR4zM5DtlqZP0wVMolCP6Y=;
        b=aaSiuipnurRnl7Mqz+ZAaDXATPF8EiWFCUjseK6ZFbtmuOJzMxb/EIgDlGhCQkrwK2
         0YS81l+jZCWL6TGjIz4vxcyZboiCgqfXzMF+RYLyBM07/vVgH8/6kdWFCY+fwuvwD1Uj
         +etJ0isIwbktxnhuPeXrbEaDMGH0dCF/RszTalF1BGZYbPWzWorIPsxTqWuYT89zFVZn
         RDpj4MBE5lEdXAGHDroBaqKPSUcBCYtVFaOySUWn3uhgIc7M3RMxFKZyUFs+8H2AXO6f
         MUI7wm9wSsbktnxBAYcD+zsMtjS97ep9b1CRhWM6inxhqktwFiLRxq2kElYlgdNVQrwa
         JesQ==
X-Gm-Message-State: AOAM531kbW1WJ2+hdzXp2EHT8WgtzwYUtsx7fgaTmPOWWjV84t25LVr3
        Rt/0k8IJ+YlwtvboJy6JoB+bnxIx9aYrrhrOR6e4wQ==
X-Google-Smtp-Source: ABdhPJz0N8/xG/aw3eeYg6AUrhU2UbyR1m/ZTw9COLLRNJzPTKFIafhrFVxB9Y+TQHKhIUCugNzRHfp/8kzPUtpQ8kw=
X-Received: by 2002:a5d:4b41:: with SMTP id w1mr2249118wrs.437.1637009090444;
 Mon, 15 Nov 2021 12:44:50 -0800 (PST)
MIME-Version: 1.0
References: <20211110221456.11977-1-jim2101024@gmail.com> <20211110221456.11977-6-jim2101024@gmail.com>
 <CAL_Jsq+6g-EhyVCeWTMkjOZmBwsOOVZo2jXpzAkjOXcZaxb2eA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+6g-EhyVCeWTMkjOZmBwsOOVZo2jXpzAkjOXcZaxb2eA@mail.gmail.com>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Mon, 15 Nov 2021 15:44:39 -0500
Message-ID: <CA+-6iNxfrOQtH1JDEjAdSZQkENoaw1tUDTfVc5+G7P6BAbSc6g@mail.gmail.com>
Subject: Re: [PATCH v8 5/8] PCI/portdrv: add mechanism to turn on subdev regulators
To:     Rob Herring <robh@kernel.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
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

On Thu, Nov 11, 2021 at 5:57 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Nov 10, 2021 at 4:15 PM Jim Quinlan <jim2101024@gmail.com> wrote:
> >
> > Adds a mechanism inside the root port device to identify standard PCIe
> > regulators in the DT, allocate them, and turn them on before the rest of
> > the bus is scanned during pci_host_probe().  A root complex driver can
> > leverage this mechanism by setting the pci_ops methods add_bus and
> > remove_bus to pci_subdev_regulators_{add,remove}_bus.
> >
> > The allocated structure that contains the regulators is stored in
> > dev.driver_data.
> >
> > The unabridged reason for doing this is as follows.  We would like the
> > Broadcom STB PCIe root complex driver (and others) to be able to turn
> > off/on regulators[1] that provide power to endpoint[2] devices.  Typically,
> > the drivers of these endpoint devices are stock Linux drivers that are not
> > aware that these regulator(s) exist and must be turned on for the driver to
> > be probed.  The simple solution of course is to turn these regulators on at
> > boot and keep them on.  However, this solution does not satisfy at least
> > three of our usage modes:
> >
> > 1. For example, one customer uses multiple PCIe controllers, but wants the
> > ability to, by script invoking and unbind, turn any or all of them by and
> > their subdevices off to save power, e.g. when in battery mode.
> >
> > 2. Another example is when a watchdog script discovers that an endpoint
> > device is in an unresponsive state and would like to unbind, power toggle,
> > and re-bind just the PCIe endpoint and controller.
> >
> > 3. Of course we also want power turned off during suspend mode.  However,
> > some endpoint devices may be able to "wake" during suspend and we need to
> > recognise this case and veto the nominal act of turning off its regulator.
> > Such is the case with Wake-on-LAN and Wake-on-WLAN support where PCIe
> > end-point device needs to be kept powered on in order to receive network
> > packets and wake-up the system.
> >
> > In all of these cases it is advantageous for the PCIe controller to govern
> > the turning off/on the regulators needed by the endpoint device.  The first
> > two cases can be done by simply unbinding and binding the PCIe controller,
> > if the controller has control of these regulators.
> >
> > [1] These regulators typically govern the actual power supply to the
> >     endpoint chip.  Sometimes they may be a the official PCIe socket
> >     power -- such as 3.3v or aux-3.3v.  Sometimes they are truly
> >     the regulator(s) that supply power to the EP chip.
> >
> > [2] The 99% configuration of our boards is a single endpoint device
> >     attached to the PCIe controller.  I use the term endpoint but it could
> >     possible mean a switch as well.
> >
> > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > ---
> >  drivers/pci/bus.c              | 72 ++++++++++++++++++++++++++++++++++
> >  drivers/pci/pci.h              |  8 ++++
> >  drivers/pci/pcie/portdrv_pci.c | 32 +++++++++++++++
> >  3 files changed, 112 insertions(+)
> >
> > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > index 3cef835b375f..c39fdf36b0ad 100644
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> > @@ -419,3 +419,75 @@ void pci_bus_put(struct pci_bus *bus)
> >         if (bus)
> >                 put_device(&bus->dev);
> >  }
> > +
> > +static void *alloc_subdev_regulators(struct device *dev)
> > +{
> > +       static const char * const supplies[] = {
> > +               "vpcie3v3",
> > +               "vpcie3v3aux",
> > +               "vpcie12v",
> > +       };
> > +       const size_t size = sizeof(struct subdev_regulators)
> > +               + sizeof(struct regulator_bulk_data) * ARRAY_SIZE(supplies);
> > +       struct subdev_regulators *sr;
> > +       int i;
> > +
> > +       sr = devm_kzalloc(dev, size, GFP_KERNEL);
> > +
> > +       if (sr) {
> > +               sr->num_supplies = ARRAY_SIZE(supplies);
> > +               for (i = 0; i < ARRAY_SIZE(supplies); i++)
> > +                       sr->supplies[i].supply = supplies[i];
> > +       }
> > +
> > +       return sr;
> > +}
> > +
> > +
> > +int pci_subdev_regulators_add_bus(struct pci_bus *bus)
> > +{
> > +       struct device *dev = &bus->dev;
> > +       struct subdev_regulators *sr;
> > +       int ret;
> > +
> > +       if (!pcie_is_port_dev(bus->self))
> > +               return 0;
> > +
> > +       if (WARN_ON(bus->dev.driver_data))
> > +               dev_err(dev, "multiple clients using dev.driver_data\n");
> > +
> > +       sr = alloc_subdev_regulators(&bus->dev);
> > +       if (!sr)
> > +               return -ENOMEM;
> > +
> > +       bus->dev.driver_data = sr;
> > +       ret = regulator_bulk_get(dev, sr->num_supplies, sr->supplies);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret = regulator_bulk_enable(sr->num_supplies, sr->supplies);
> > +       if (ret) {
> > +               dev_err(dev, "failed to enable regulators for downstream device\n");
> > +               return ret;
> > +       }
> > +
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_subdev_regulators_add_bus);
>
> Can't these just go in the portdrv probe and remove functions now?
>
> Rob

Not really.  The idea is that  only when a host controller driver does this

static struct pci_ops my_pcie_ops = {
    .add_bus = pci_subdev_regulators_add_bus , /* see  note below */
    .remove_bus = pci_subdev_regulators_remove_bus,
    ...
}

does it explicitly want this feature.  Without doing this, every PCI
port in the world will execute a devm_kzalloc() and
devm_regulator_bulk_get() to (likely) grab nothing, and then there
will be three superfluous lines in the boot log:

pci_bus 0001:01: 0001:01 supply vpcie12v not found, using dummy regulator
pci_bus 0001:01: 0001:01 supply vpcie3v3 not found, using dummy regulator
pci_bus 0001:01: 0001:01 supply vpcie3v3aux not found, using dummy regulator

Secondly, our  HW needs to know when the  alloc/get/enable of
regulators is done so that the PCIe link can then be attempted.   This
is pretty much the cornerstone of this patchset.   To do this the brcm
RC driver's call to pci_subdev_regulators_add_bus() is wrapped by
brcm_pcie_add_bus() so that we can do this:

static struct pci_ops my_pcie_ops = {
    .add_bus = brcm_pcie_add_bus ,   /* calls pci_subdev_regulators_add_bus() */
    .remove_bus = pci_subdev_regulators_remove_bus,
    ...
}

Regards,
Jim Quinlan
Broadcom STB
