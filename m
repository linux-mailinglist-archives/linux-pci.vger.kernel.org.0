Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA3524DEFD
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 19:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgHUR6B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Aug 2020 13:58:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbgHUR6A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Aug 2020 13:58:00 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDDEF2076E;
        Fri, 21 Aug 2020 17:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598032679;
        bh=SY9zNs4J6t0vv72iGwx5CHsqBISRbTZU9+hhKRgBuhc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QZDE8vCDkAA5jlse0gEYh+PmM32pHu7oq7I5mhX53QFRvulP+td24khjIHsDQR8JC
         2Vz6TmZQtxsFZnwsBmRHXT5tFLTqSGZqulb3JUWDhvj+q7KcyzhoInrC2qXuS5FTOM
         HL8EaOM65oHoT6eTbvyU+OA7SkeBPiX9ugSGXD5k=
Received: by mail-oi1-f174.google.com with SMTP id l204so2245559oib.3;
        Fri, 21 Aug 2020 10:57:59 -0700 (PDT)
X-Gm-Message-State: AOAM532dC7ftBN8FTNgfCkcPTcDtINLaUOce+4mqGkVv1hK2gCkaBb9X
        l+GzdKxGCmtwvYctelWXIO038v7ZbpLpXRaezg==
X-Google-Smtp-Source: ABdhPJy56tMaoq7RPfeWnbGfE9RwrzQuC1O2g9otVdT7rq5KiAI44AsUU8Hy6kvdvNrjgZTmUbM4NN+8SLtytcLnC+Q=
X-Received: by 2002:aca:c3d8:: with SMTP id t207mr2564623oif.152.1598032679079;
 Fri, 21 Aug 2020 10:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <d007193ce73677713436c39684602f679d7623e4.camel@microchip.com> <20200820181018.GA1551400@bjorn-Precision-5520>
In-Reply-To: <20200820181018.GA1551400@bjorn-Precision-5520>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 21 Aug 2020 11:57:47 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL1FiQ1CxTeOcEV8Y=p1yZKkXLq5Zz3qZ+xiJqkvH+RxA@mail.gmail.com>
Message-ID: <CAL_JsqL1FiQ1CxTeOcEV8Y=p1yZKkXLq5Zz3qZ+xiJqkvH+RxA@mail.gmail.com>
Subject: Re: [PATCH v15 2/2] PCI: microchip: Add host driver for Microchip
 PCIe controller
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Daire McNamara <Daire.McNamara@microchip.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, david.abdurachmanov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 20, 2020 at 12:10 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Aug 19, 2020 at 04:33:10PM +0000, Daire.McNamara@microchip.com wrote:
>
> > + *   pcie-altera.c
> > + */
>
> Add a blank line here.
>
> > +#include <linux/irqchip/chained_irq.h>
> > +#include <linux/module.h>
>
> > +static struct mc_port *port;
>
> This file scope item is not ideal.  It might work in your situation if
> you can never have more than one device, but it's not a pattern we
> want other people to copy.

Indeed.

> I think I sort of see how it works:
>
>   mc_pci_host_probe
>     pci_host_common_probe
>       ops = of_device_get_match_data()              # mc_ecam_ops
>       gen_pci_init(..., ops)
>         pci_ecam_create(..., ops)
>           ops->init                                 # mc_ecam_ops.init
>             mc_platform_init(pci_config_window *)
>               port = devm_kzalloc(...)              # initialized
>     mc_setup_windows
>       bridge_base_addr = port->axi_base_addr + ...  # used
>
> And you're using the file scope "port" because mc_platform_init()
> doesn't have a pointer to the platform_device.

This is a simple fix. Move platform_set_drvdata to just after
devm_pci_alloc_host_bridge() in pci_host_common_probe(). (Don't fall
into the 'platform problem'[1] and work-around the core code.)

Then pci_host_common_probe can be called directly and mc_setup_windows
can be moved to mc_platform_init().

> But I think this
> abuses the pci_ecam_ops design to do host bridge initialization that
> it is not intended for.

What init should be done then? IMO, given this driver is using ECAM
support already and it's all one time init that fits into init(), it
seems like a fit to me.

> I'd suggest copying the host bridge init design from somewhere else.
> tango_pcie_probe() also calls pci_host_common_probe(), so maybe that's
> a good place.  But the fact that it's the *only* such caller makes me
> think it might not be the best thing to copy.
>
> Rob has been working in this area and probably has better insight.

It was my suggestion to move to the ECAM init. Prior versions had its own probe.

One question I've been wrestling with is if we can do all the firmware
setup for 'generic ECAM' on the same h/w we have drivers for, then
shouldn't we make the kernel driver create an ECAM setup? There's also
the question of why do root port config accesses go thru standard ECAM
config space in ECAM mode, but use different address space for
non-ECAM setup? DWC for example can probably do ECAM on more
platforms. There's some that can't which are generally ones w/o the
iATU or enough iATU entries or not enough memory space. The difference
from a config space standpoint is just DT configuration (in the case
of DWC with an iATU, the config space and memory space DT entries are
just iATU configuration not h/w constraints).

I think we have drivers too much in control of their initialization
ordering and things should be more the other way around with core code
calling h/w ops to do specific things. I don't have any grand plan
yet, but perhaps the generic/common host stuff evolves beyond just
ECAM and almost ECAM. The generic host would just have no h/w ops.

Rob

[1] https://lwn.net/Articles/443531/
