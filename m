Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFB444DE03
	for <lists+linux-pci@lfdr.de>; Thu, 11 Nov 2021 23:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbhKKW76 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Nov 2021 17:59:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:34624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229652AbhKKW74 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Nov 2021 17:59:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3EF36117A;
        Thu, 11 Nov 2021 22:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636671426;
        bh=Fke2kpJoV7ZdebST5OG4QUzZNvn/+L40Mt3Qr+Q39dE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uA8Qh2ACUtM+Koojg7bk1RsGPOCuATq+VNvONtb+zgKIju2XN/DkFBUYWB5szQJaS
         GYg4kJsswJaEVh1zCZ0R5NiSwiEU3kOkXCLGMAsSF3aahtl2lCdItpFZZEncnjgvQO
         qENCtHbWMmvcd/fkJ00SacrSgFAKhGpFWzeMdq2hOuOJw1ZK8pFxhEhqQExAso3H9I
         S4e/Z3cNHKnhYSZ96vm7TpotdADkHyGx7lnIuQ7/3vFC7uEaocNJTeBB7RUQ6vjHXr
         LeofzqSiNiSwhLOb9YvPb1fESonBFXnIz708ZpgYnOH4tfe8R1hgArsveMMeB2kQwj
         uLk0dGBmshhOg==
Received: by mail-ed1-f48.google.com with SMTP id w1so30175152edd.10;
        Thu, 11 Nov 2021 14:57:06 -0800 (PST)
X-Gm-Message-State: AOAM532cBmkScPPpWLPdaSVP3TUBROu33iIGT/rZAtdWzZDZ+xSiMYlb
        ml9IeCtwDbLRaPjHc+fmDAVYjJ19Ohs7+fCRqA==
X-Google-Smtp-Source: ABdhPJyg4OjjlPogZaxOM6Go90c4QFQjKFlcoLadGYtyk1/S/dwzo3R6OBdK/gEByym5XEI3bgC/djwDXjvi5d6Z0dk=
X-Received: by 2002:a17:907:16ac:: with SMTP id hc44mr13340204ejc.363.1636671425091;
 Thu, 11 Nov 2021 14:57:05 -0800 (PST)
MIME-Version: 1.0
References: <20211110221456.11977-1-jim2101024@gmail.com> <20211110221456.11977-6-jim2101024@gmail.com>
In-Reply-To: <20211110221456.11977-6-jim2101024@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 11 Nov 2021 16:56:53 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+6g-EhyVCeWTMkjOZmBwsOOVZo2jXpzAkjOXcZaxb2eA@mail.gmail.com>
Message-ID: <CAL_Jsq+6g-EhyVCeWTMkjOZmBwsOOVZo2jXpzAkjOXcZaxb2eA@mail.gmail.com>
Subject: Re: [PATCH v8 5/8] PCI/portdrv: add mechanism to turn on subdev regulators
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 10, 2021 at 4:15 PM Jim Quinlan <jim2101024@gmail.com> wrote:
>
> Adds a mechanism inside the root port device to identify standard PCIe
> regulators in the DT, allocate them, and turn them on before the rest of
> the bus is scanned during pci_host_probe().  A root complex driver can
> leverage this mechanism by setting the pci_ops methods add_bus and
> remove_bus to pci_subdev_regulators_{add,remove}_bus.
>
> The allocated structure that contains the regulators is stored in
> dev.driver_data.
>
> The unabridged reason for doing this is as follows.  We would like the
> Broadcom STB PCIe root complex driver (and others) to be able to turn
> off/on regulators[1] that provide power to endpoint[2] devices.  Typically,
> the drivers of these endpoint devices are stock Linux drivers that are not
> aware that these regulator(s) exist and must be turned on for the driver to
> be probed.  The simple solution of course is to turn these regulators on at
> boot and keep them on.  However, this solution does not satisfy at least
> three of our usage modes:
>
> 1. For example, one customer uses multiple PCIe controllers, but wants the
> ability to, by script invoking and unbind, turn any or all of them by and
> their subdevices off to save power, e.g. when in battery mode.
>
> 2. Another example is when a watchdog script discovers that an endpoint
> device is in an unresponsive state and would like to unbind, power toggle,
> and re-bind just the PCIe endpoint and controller.
>
> 3. Of course we also want power turned off during suspend mode.  However,
> some endpoint devices may be able to "wake" during suspend and we need to
> recognise this case and veto the nominal act of turning off its regulator.
> Such is the case with Wake-on-LAN and Wake-on-WLAN support where PCIe
> end-point device needs to be kept powered on in order to receive network
> packets and wake-up the system.
>
> In all of these cases it is advantageous for the PCIe controller to govern
> the turning off/on the regulators needed by the endpoint device.  The first
> two cases can be done by simply unbinding and binding the PCIe controller,
> if the controller has control of these regulators.
>
> [1] These regulators typically govern the actual power supply to the
>     endpoint chip.  Sometimes they may be a the official PCIe socket
>     power -- such as 3.3v or aux-3.3v.  Sometimes they are truly
>     the regulator(s) that supply power to the EP chip.
>
> [2] The 99% configuration of our boards is a single endpoint device
>     attached to the PCIe controller.  I use the term endpoint but it could
>     possible mean a switch as well.
>
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  drivers/pci/bus.c              | 72 ++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h              |  8 ++++
>  drivers/pci/pcie/portdrv_pci.c | 32 +++++++++++++++
>  3 files changed, 112 insertions(+)
>
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 3cef835b375f..c39fdf36b0ad 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -419,3 +419,75 @@ void pci_bus_put(struct pci_bus *bus)
>         if (bus)
>                 put_device(&bus->dev);
>  }
> +
> +static void *alloc_subdev_regulators(struct device *dev)
> +{
> +       static const char * const supplies[] = {
> +               "vpcie3v3",
> +               "vpcie3v3aux",
> +               "vpcie12v",
> +       };
> +       const size_t size = sizeof(struct subdev_regulators)
> +               + sizeof(struct regulator_bulk_data) * ARRAY_SIZE(supplies);
> +       struct subdev_regulators *sr;
> +       int i;
> +
> +       sr = devm_kzalloc(dev, size, GFP_KERNEL);
> +
> +       if (sr) {
> +               sr->num_supplies = ARRAY_SIZE(supplies);
> +               for (i = 0; i < ARRAY_SIZE(supplies); i++)
> +                       sr->supplies[i].supply = supplies[i];
> +       }
> +
> +       return sr;
> +}
> +
> +
> +int pci_subdev_regulators_add_bus(struct pci_bus *bus)
> +{
> +       struct device *dev = &bus->dev;
> +       struct subdev_regulators *sr;
> +       int ret;
> +
> +       if (!pcie_is_port_dev(bus->self))
> +               return 0;
> +
> +       if (WARN_ON(bus->dev.driver_data))
> +               dev_err(dev, "multiple clients using dev.driver_data\n");
> +
> +       sr = alloc_subdev_regulators(&bus->dev);
> +       if (!sr)
> +               return -ENOMEM;
> +
> +       bus->dev.driver_data = sr;
> +       ret = regulator_bulk_get(dev, sr->num_supplies, sr->supplies);
> +       if (ret)
> +               return ret;
> +
> +       ret = regulator_bulk_enable(sr->num_supplies, sr->supplies);
> +       if (ret) {
> +               dev_err(dev, "failed to enable regulators for downstream device\n");
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_subdev_regulators_add_bus);

Can't these just go in the portdrv probe and remove functions now?

Rob
