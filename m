Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D4144DDF6
	for <lists+linux-pci@lfdr.de>; Thu, 11 Nov 2021 23:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhKKWxX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Nov 2021 17:53:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:45434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230348AbhKKWxX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Nov 2021 17:53:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7AD2F6124C;
        Thu, 11 Nov 2021 22:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636671032;
        bh=rUZ/Su4Jl9SXavYFg86d3hFyhvDkfAvKNMakYbH1QTw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NdYdmViqHHtW3NRI2Qj/Jh9/nQ+EJoliqOEzceXvrjEjZ6Vpnr1awkroIRoUkGLKV
         IGbwEKHlbJbVKo+azupgmKT0u/LGZafN2rlBussfRMS+I8iY5+K3yG1ZOD9V6dp+lW
         tTOwan1JPh+uf0Dq+dLEP6FHzjteU1vMeelVzf8362AT3c//gXvvuskMlEadGhtGVF
         6vuuLZKVwYWab83p+lEvDifruuXGsJevcNmJg6Os+AVRMmtTGZqIzfTF2r2cN5S3P5
         bLtlMTtMccdShXU710JdhrkjA/CuCta14YhS4YU/u48XNEQoEUSJ+H2+qSDa2ooEJG
         WDjRjw1CIyxWw==
Received: by mail-ed1-f50.google.com with SMTP id w1so30128916edd.10;
        Thu, 11 Nov 2021 14:50:32 -0800 (PST)
X-Gm-Message-State: AOAM530cfeRc5xFX8fPVW9yV/yx0HVraQ0dwA+x8icGzne5WlDRnXMwP
        3QerJiVbrLiVbTs+RJvtaY5subtHHIdl92iULg==
X-Google-Smtp-Source: ABdhPJze04ZeyAA1HXsFKVxztXrqGOkqREekona/1epONO6xOls/I2pCo6lWPiyQ9oY6CqZ0UlZkZHl7hkXZeKP8caE=
X-Received: by 2002:aa7:c444:: with SMTP id n4mr14872255edr.6.1636671030995;
 Thu, 11 Nov 2021 14:50:30 -0800 (PST)
MIME-Version: 1.0
References: <20211110221456.11977-6-jim2101024@gmail.com> <20211111221250.GA1353701@bhelgaas>
In-Reply-To: <20211111221250.GA1353701@bhelgaas>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 11 Nov 2021 16:50:19 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+VnHC_af=d9o=BX=dtMJ84ipjDsq6R7gBkvZZJ6ARTLw@mail.gmail.com>
Message-ID: <CAL_Jsq+VnHC_af=d9o=BX=dtMJ84ipjDsq6R7gBkvZZJ6ARTLw@mail.gmail.com>
Subject: Re: [PATCH v8 5/8] PCI/portdrv: add mechanism to turn on subdev regulators
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        PCI <linux-pci@vger.kernel.org>,
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

On Thu, Nov 11, 2021 at 4:12 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Capitalize "Add" in subject.
>
> On Wed, Nov 10, 2021 at 05:14:45PM -0500, Jim Quinlan wrote:
> > Adds a mechanism inside the root port device to identify standard PCIe
> > regulators in the DT, allocate them, and turn them on before the rest of
> > the bus is scanned during pci_host_probe().  A root complex driver can
> > leverage this mechanism by setting the pci_ops methods add_bus and
> > remove_bus to pci_subdev_regulators_{add,remove}_bus.
>
> s/Adds a/Add a/
>
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
>
> s/may be a the/may be the/
>
> > [2] The 99% configuration of our boards is a single endpoint device
> >     attached to the PCIe controller.  I use the term endpoint but it could
> >     possible mean a switch as well.
>
> s/possible/possibly/
>
> This adds generic code, so it needs some connection to the generic DT
> binding for these things, e.g., a commit in this series that adds it
> (I see commits that touch brcm,stb-pcie.yaml, but not a generic
> place).

That's pending here: https://github.com/devicetree-org/dt-schema/pull/63

Rob
