Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4AE1A3257
	for <lists+linux-pci@lfdr.de>; Thu,  9 Apr 2020 12:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgDIKPG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Apr 2020 06:15:06 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43693 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgDIKPG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Apr 2020 06:15:06 -0400
Received: by mail-ot1-f67.google.com with SMTP id n25so7286341otr.10;
        Thu, 09 Apr 2020 03:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/NSZZSKSu5WJt1RNoef9dBjCn8fIK10WqZ6WGC2+h/M=;
        b=iQL+Gq3QA9xSB0G77RYT1DZl9zxaKwiQKV7PF57j5DmP4f7Z+K389I+vbjLtPG0pyw
         TsgkfIqwbahrRJXW8+QzFOO4x6LTG5trpY7ZUktLi8S7PL9Ekma4X2V2Cx+W6nUc/hBP
         o8WvUlKV5Pm80i7lOPwWp7H6C8ljw9sMS24M3L83ZVjo8e/XavF7iDhLPZJuU6P8JADJ
         ROC17jM7JvA/1li4pUqoH2bNUu+g3zK4qs0i8GBIPfm6oJBciuxGe5xjvSUfcOJB1XQF
         ZnBjsViCtVXvHYEeBNexwrm34bN3C5mE/kI0lc084QX8A9v2+w7IAa67TUTcdks1+NHE
         UKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/NSZZSKSu5WJt1RNoef9dBjCn8fIK10WqZ6WGC2+h/M=;
        b=pw90wKgMwoIxtYdUcUHsBgOAwcvDYSe4Wr6vnRAAhDL6zesqJpmqf+/+g9xBUR5qwt
         97ot9VL4Djn4C//HuMPV/+CJrThTwyaFJDTSbSWEfHptCSN6UZmI+crPPLoN00ZWQE2b
         OTSI8Lf/ge3dKJsXk+3UL9YgIQjpkpOaN7AxF5+f2i8uAgPN+wdBkd6Br8FPrDX9Wrjv
         JamGcXzHyB8uaw+Mu/9woybBzxAUO30G8e0m1wW1CiNBfFQTiM5D18YapWKB/e4PUD8p
         flGhkGSX0LgINmYRh7lTChuJjN/mW9zr1f2EN6WQr8f3yiaKIsJ8odDxMb4Dvh/C6foY
         tQng==
X-Gm-Message-State: AGi0PuYt0N/PZ1sbSRhXPL2m1XLUcDJwvgPfijtuhR2AQhMtWkkDYYdi
        obZ0487HEJnrCQNzxWt+BTi2C+PQEH0xzGlzXHE=
X-Google-Smtp-Source: APiQypJZ7ipa4bMCkW9mI2xrPpPXDZ+7ffNf67WIS2NRxz3lWs1SiJCULWWWchWx+Is+aY4H+ame5VIgN7uLwHuVtno=
X-Received: by 2002:a9d:895:: with SMTP id 21mr8780254otf.365.1586427305866;
 Thu, 09 Apr 2020 03:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <1586360280-10956-7-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200408235133.GA151858@google.com>
In-Reply-To: <20200408235133.GA151858@google.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 9 Apr 2020 11:14:39 +0100
Message-ID: <CA+V-a8taA-CYNC2vLoPPm9WHZwTOFoHe-c2zus_n5=qr4x32WQ@mail.gmail.com>
Subject: Re: [PATCH v7 6/8] PCI: rcar: Add support for R-Car PCIe controller
 in endpoint mode
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thank you for the review.

On Thu, Apr 9, 2020 at 12:51 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Maybe:
>
>   PCI: rcar: Add endpoint mode support
>
> so the important "endpoint mode" part is early and doesn't get chopped
> off or wrapped.  We already know it's PCIe and rcar-related.
>
Agreed will change it.

> On Wed, Apr 08, 2020 at 04:37:58PM +0100, Lad Prabhakar wrote:
> > This patch adds support for R-Car PCIe controller to work in endpoint mode.
>
> s/This patch adds/Add/
>
OK

> > +static int rcar_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no,
> > +                             struct pci_epf_bar *epf_bar)
> > +{
> > +     int flags = epf_bar->flags | LAR_ENABLE | LAM_64BIT;
> > +     struct rcar_pcie_endpoint *ep = epc_get_drvdata(epc);
> > +     u64 size = 1ULL << fls64(epf_bar->size - 1);
> > +     dma_addr_t cpu_addr = epf_bar->phys_addr;
> > +     enum pci_barno bar = epf_bar->barno;
> > +     struct rcar_pcie *pcie = &ep->pcie;
> > +     u32 mask;
> > +     int idx;
> > +     int err;
> > +
> > +     idx = find_first_zero_bit(ep->ib_window_map, ep->num_ib_windows);
> > +     if (idx >= ep->num_ib_windows) {
> > +             dev_err(pcie->dev, "no free inbound window\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     if ((flags & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_IO)
> > +             flags |= IO_SPACE;
> > +
> > +     ep->bar_to_atu[bar] = idx;
> > +     /* use 64 bit bars */
>
> s/64 bit bars/64-bit BARs/
>
OK shall replace it.

> > +static const struct pci_epc_features rcar_pcie_epc_features = {
> > +     .linkup_notifier = false,
> > +     .msi_capable = true,
> > +     .msix_capable = false,
> > +     /* use 64-bit bars so mark bar1/3/5 as reserved */
>
> s/bar/BAR/g
OK shall replace it.

Cheers,
--Prabhakar
