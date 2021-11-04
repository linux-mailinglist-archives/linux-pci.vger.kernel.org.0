Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E79B44558A
	for <lists+linux-pci@lfdr.de>; Thu,  4 Nov 2021 15:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhKDOpc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Nov 2021 10:45:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:57030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230409AbhKDOp1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Nov 2021 10:45:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78512611EE;
        Thu,  4 Nov 2021 14:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636036969;
        bh=n0CzbhBUbgevxQWjjtb4wBTU1nHZxIHCQLQyJbqJ9So=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j+WEmNhZNbzEI0icdK6TZFy0yBqKjsQ9BHQtFlWfWhbEhe7nD79OmcPWML2fi2KKF
         7znem49g6JuW+JiTJtg2673yZhArNI8kpVmKmRAGuJlFWm4kHX8eyk2UwQCDBUxrSK
         RBL531RVUoFOiu8k3q9Hf26RIhJlCoGi52CoMEfo/g6RdG+76Kuk5JsYJhdLhVqPjR
         HJ/RfxYX51nbosuSDGEgqq+RcruTcAzpyXHcI8RTe6KySjYIK1fcPfpaI25vFgws+j
         ORLh2dJUnHtnYTBF0vlgHD6zO4Fs1RiiAlyzZwYiMxJD/0X2fuk+3ciDXAELkthKSg
         vxEM7DW+efsTA==
Received: by mail-ed1-f52.google.com with SMTP id b15so2961836edd.7;
        Thu, 04 Nov 2021 07:42:49 -0700 (PDT)
X-Gm-Message-State: AOAM533UN0CSsXc/07VNBk9yCJqmKir73d3eBzYe1IQma1s6F61cuDqi
        BUMNAQxa2AQaWMWe4Ya5Jv9CWaW3xvBZADJRuQ==
X-Google-Smtp-Source: ABdhPJy6P/8T2QkdFCza1adxwbd7SLzZ9Y6/ekNEpVkworwq423dcdxpGyT6AJAuyvFvRLeBH+tBIMAGgd/eVM0CKSc=
X-Received: by 2002:a17:907:a411:: with SMTP id sg17mr38835733ejc.84.1636036967479;
 Thu, 04 Nov 2021 07:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211029200319.23475-1-jim2101024@gmail.com> <20211029200319.23475-8-jim2101024@gmail.com>
 <YYFgmxMCnKtTlaqL@robh.at.kernel.org> <CA+-6iNwdLt96U26eW-GDJFD3XB9unKX-ucF3gZ754ux78yMRCw@mail.gmail.com>
In-Reply-To: <CA+-6iNwdLt96U26eW-GDJFD3XB9unKX-ucF3gZ754ux78yMRCw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 4 Nov 2021 09:42:34 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLttThthFof2wgQDg+v8wqwvrWGR+2j8RR4E0BLHr4heA@mail.gmail.com>
Message-ID: <CAL_JsqLttThthFof2wgQDg+v8wqwvrWGR+2j8RR4E0BLHr4heA@mail.gmail.com>
Subject: Re: [PATCH v6 7/9] PCI: brcmstb: Add control of subdevice voltage regulators
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        PCI <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 2, 2021 at 5:36 PM Jim Quinlan <james.quinlan@broadcom.com> wrote:
>
> On Tue, Nov 2, 2021 at 12:00 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Oct 29, 2021 at 04:03:15PM -0400, Jim Quinlan wrote:
> > > This Broadcom STB PCIe RC driver has one port and connects directly to one
> > > device, be it a switch or an endpoint.  We want to be able to turn on/off
> > > any regulators for that device.  Control of regulators is needed because of
> > > the chicken-and-egg situation: although the regulator is "owned" by the
> > > device and would be best handled by its driver, the device cannot be
> > > discovered and probed unless its regulator is already turned on.
> >
> > I think this can be done in a much more simple way that avoids the
> > prior patches using the pci_ops.add_bus() (and remove_bus()) hook.
> > add_bus is called before the core scans a child bus. In the handler, you
> > just need to get the bridge device, then the bridge DT node, and then
> > get the regulators and enable.
> Hi Rob,
> In reply to my bindings commit you wanted to put the "xxx-supply"
> property(s) under the
> bridge node rather than under the pci-ep node.   This not only makes
> sense but also removes
> the burden of prematurely creating the struct device *ptr as the
> bridge device has
> already been created.
>
> However, there is still an issue:  if  the pcie-link is not
> successful, we want the bus enumeration
> to stop and not read the vendor/dev id of the EP.  Our controller has
> the disadvantage of causing
> an abort when accessing config space when the link is not established.  Other
> controllers kindly return 0xffffffff as the data.
>
> Doing something like this gets around the issue:
>
> static struct pci_bus *pci_alloc_child_bus(...)
> {
>         /* ... */
> add_dev:
>         /* ... */
>         if (child->ops->add_bus) {
>                 ret = child->ops->add_bus(child);
> +               if (ret == -ENOLINK)
> +                       return NULL;
>                 if (WARN_ON(ret < 0))
>                         dev_err(&child->dev, "failed to add bus: %d\n", ret);
>         }
>
> Is this acceptable?  Other suggestions?

Acceptable yes once we agree on error code to return. I'd just do -ENODEV.

> > Given we're talking about standard properties in a standard (bridge)
> > node, I think the implementation for .add_bus should be common
> > (drivers/pci/of.c). It doesn't scale to be doing this in every host
> > bridge driver.
> Are you saying that the bridge DT node  should have a property such as
> "get-and-turn-on-subdev-regulators;" which would invoke what I'm now
> calling brcm_pcie_add_bus()?

No! Define a common function that host drivers can opt in to by
setting their .add_bus() hook to or calling from their own add_bus
function.

Ideally, it would work on Rockchip too as it's the same supplies.
However, that would require some reworking of the link initialization
and PERST handling. As Bjorn has mentioned, all that should be per RP,
not per host bridge anyways. I'm taking it one step further and saying
it should be per PCI bridge. Hikey for example needs PERST handling on
bridges behind a switch.

Rob
