Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39813234886
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jul 2020 17:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgGaPci (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Jul 2020 11:32:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbgGaPch (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Jul 2020 11:32:37 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 763BD2245C;
        Fri, 31 Jul 2020 15:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596209556;
        bh=wYzf+2brtM3bwigWDhYjt0sg7jxC8tK4H51bPDfvYJk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H+3Nm7MBMWlmBuU09BMx36oPZGaIrk7x2MdF652Y3zm0mrPT2XLC4yh/7y+d4nfsu
         KFf9txu4PstMlhhHGqbmZaRSyqjwHqr3CyLx8HD5cQ9rQ1vVYYElkiG1Vo5yu3V7XN
         KZf/uJCoc8iC3Gvx0L/XW7zyNkVsLRpttC7IZjfs=
Received: by mail-oi1-f170.google.com with SMTP id k4so27056218oik.2;
        Fri, 31 Jul 2020 08:32:36 -0700 (PDT)
X-Gm-Message-State: AOAM533Xpnla2IrELpV3NP/1/X1UFYj4Uv8+Htw79pBDnPHI0y/W6mpJ
        re6p4CFMilkQ4xhRJidLjncVSctHMIUGhEp5ow==
X-Google-Smtp-Source: ABdhPJyyRnLBA0WxHZIzpHMNV7YoainKdcdBPAdzF/GqsTsiGD5j0V7vSDrqcYePaPbUzanCEfEhJaQdzhpEaD9uqkA=
X-Received: by 2002:aca:4844:: with SMTP id v65mr3474230oia.152.1596209555800;
 Fri, 31 Jul 2020 08:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200731033956.6058-1-mark.tomlinson@alliedtelesis.co.nz> <20200731033956.6058-2-mark.tomlinson@alliedtelesis.co.nz>
In-Reply-To: <20200731033956.6058-2-mark.tomlinson@alliedtelesis.co.nz>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 31 Jul 2020 09:32:24 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJgD_Ys3xjoJYuQ3R9bL7gUC+NKwkq71eTngj5uvcpk6Q@mail.gmail.com>
Message-ID: <CAL_JsqJgD_Ys3xjoJYuQ3R9bL7gUC+NKwkq71eTngj5uvcpk6Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] PCI: Reduce warnings on possible RW1C corruption
To:     Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Cc:     Ray Jui <ray.jui@broadcom.com>, Bjorn Helgaas <helgaas@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 30, 2020 at 9:40 PM Mark Tomlinson
<mark.tomlinson@alliedtelesis.co.nz> wrote:
>
> For hardware that only supports 32-bit writes to PCI there is the
> possibility of clearing RW1C (write-one-to-clear) bits. A rate-limited
> messages was introduced by fb2659230120, but rate-limiting is not the
> best choice here. Some devices may not show the warnings they should if
> another device has just produced a bunch of warnings. Also, the number
> of messages can be a nuisance on devices which are otherwise working
> fine.
>
> This patch changes the ratelimit to a single warning per bus. This
> ensures no bus is 'starved' of emitting a warning and also that there
> isn't a continuous stream of warnings. It would be preferable to have a
> warning per device, but the pci_dev structure is not available here, and
> a lookup from devfn would be far too slow.

If we don't want to just warn when a 8 or 16 bit access occurs (I'm
not sure if 32-bit only accesses is possible or common. Seems like
PCI_COMMAND would always get written?), then a simple way to do this
is just move this out of line and do something like this where the bus
or device is created/registered:

if (bus->ops->write == pci_generic_config_write32)
    warn()

>
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Fixes: fb2659230120 ("PCI: Warn on possible RW1C corruption for sub-32 bit config writes")
> Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
> ---
>  drivers/pci/access.c | 9 ++++++---
>  include/linux/pci.h  | 1 +
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 79c4a2ef269a..ab85cb7df9b6 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -160,9 +160,12 @@ int pci_generic_config_write32(struct pci_bus *bus, unsigned int devfn,
>          * write happen to have any RW1C (write-one-to-clear) bits set, we
>          * just inadvertently cleared something we shouldn't have.
>          */
> -       dev_warn_ratelimited(&bus->dev, "%d-byte config write to %04x:%02x:%02x.%d offset %#x may corrupt adjacent RW1C bits\n",
> -                            size, pci_domain_nr(bus), bus->number,
> -                            PCI_SLOT(devfn), PCI_FUNC(devfn), where);
> +       if (!bus->unsafe_warn) {
> +               dev_warn(&bus->dev, "%d-byte config write to %04x:%02x:%02x.%d offset %#x may corrupt adjacent RW1C bits\n",
> +                        size, pci_domain_nr(bus), bus->number,
> +                        PCI_SLOT(devfn), PCI_FUNC(devfn), where);
> +               bus->unsafe_warn = true;
> +       }
>
>         mask = ~(((1 << (size * 8)) - 1) << ((where & 0x3) * 8));
>         tmp = readl(addr) & mask;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 34c1c4f45288..5b6ab593ae09 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -613,6 +613,7 @@ struct pci_bus {
>         unsigned char   primary;        /* Number of primary bridge */
>         unsigned char   max_bus_speed;  /* enum pci_bus_speed */
>         unsigned char   cur_bus_speed;  /* enum pci_bus_speed */
> +       bool            unsafe_warn;    /* warned about RW1C config write */

Make this a bitfield next to 'is_added'.

>  #ifdef CONFIG_PCI_DOMAINS_GENERIC
>         int             domain_nr;
>  #endif
> --
> 2.28.0
>
