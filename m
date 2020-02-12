Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E884B15A236
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2020 08:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgBLHi7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Feb 2020 02:38:59 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45175 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbgBLHi7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Feb 2020 02:38:59 -0500
Received: by mail-oi1-f194.google.com with SMTP id v19so1106615oic.12;
        Tue, 11 Feb 2020 23:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XWghytwp0n8q64ohIAtcpx40VHgmilMQUtH3KTGYx7s=;
        b=TC9l1keL4Hd58ZG6CwkLWbCSXi5tO6plnzWPUvdQr3NN3ngxbK8wuGWtKxo3V2o0IF
         35uTR//ax4ujBc5PoSxF448KRz+e2JRA/9tboijhEqO4xvGUdJ3w3qu0cgB7JLy3KCvN
         ZV9RPjikYG5lPOx/BpbwfcbWOa4ta+57T3E/8GZT72GEbeDiyk4YbifmxU2gA7bX7stq
         Yyay/i9ESUd6i51aqEw9scXiXaPLZR7cl2dA/XS4X1b1DvLceTqs36YW0fBJe0TNWdQN
         dR8NlBMscQr7A7gjx+20IohWRh97Il+wzZJKrowF0vOxTG4AORg/XckkIfwTFN+Hrxlw
         xKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XWghytwp0n8q64ohIAtcpx40VHgmilMQUtH3KTGYx7s=;
        b=mUQewgiLB/6OoUXDNnHqecB446cqr6T9X3hFtg5SF+AnYBEu+wPsm9GxYy3sXKFTCx
         qT6rVzbcrnqs621UygT95Icve37fKhfmlkKC+TfIOCcBVowR83pUmU2lra7LWqfbeWej
         BZmPiDuFFhFpDGF6AvNJ2XzNEhMtmHW/TqpKKm4jM6b0p+VEjyhLc1vodzCCgDJxgTr8
         IV75fyucmXcDuEbTNTw8Trt+8tIdp+CdJJsbcLBYwsnztpSTBFCMJHe8nPJId4lxaVHC
         vdepExLj/9YTJV5LbqBwcA8CqL+FYaYVQeXUJtopiRTV8Zlwj25B7k7hH+e+SDLE4ir1
         EJ1A==
X-Gm-Message-State: APjAAAXwhQ5Q0NvcH+08Gr0VxE/QV0kEsCiR4zpka7OHwGL+EvTAgnEw
        r+fUYqYTQKkfDiEcIMhEl5YRTeubFOwYezKLjW0=
X-Google-Smtp-Source: APXvYqy+D0WYnWREpjT/u0UNR1D7So/F/RtHMLjlI1VSXbpeR4V4jqXmLbxEl/+iyD6g9WR4zGz6r2ARl+qBlG1GTW0=
X-Received: by 2002:aca:5a04:: with SMTP id o4mr5370457oib.71.1581493138499;
 Tue, 11 Feb 2020 23:38:58 -0800 (PST)
MIME-Version: 1.0
References: <20200208183641.6674-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200208183641.6674-6-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200212034239.GA38314@ubuntu-m2-xlarge-x86>
In-Reply-To: <20200212034239.GA38314@ubuntu-m2-xlarge-x86>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 12 Feb 2020 07:38:32 +0000
Message-ID: <CA+V-a8vMcRvsh7+pcgD4jk50X0DtZ9uXFegZVXM5M1k-R6jOVA@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] PCI: rcar: Add support for rcar PCIe controller in
 endpoint mode
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Andrew Murray <andrew.murray@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Nathan,

On Wed, Feb 12, 2020 at 3:42 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Hi Lad,
>
> On Sat, Feb 08, 2020 at 06:36:40PM +0000, Lad Prabhakar wrote:
> > This patch adds support for rcar PCIe controller to work in endpoint mode.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/pci/controller/Kconfig        |   7 +
> >  drivers/pci/controller/Makefile       |   1 +
> >  drivers/pci/controller/pcie-rcar-ep.c | 492 ++++++++++++++++++++++++++++++++++
> >  drivers/pci/controller/pcie-rcar.h    |   6 +
> >  4 files changed, 506 insertions(+)
> >  create mode 100644 drivers/pci/controller/pcie-rcar-ep.c
> >
>
> <snip>
>
> > diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controller/pcie-rcar-ep.c
> > new file mode 100644
> > index 0000000..32a7fca
> > --- /dev/null
> > +++ b/drivers/pci/controller/pcie-rcar-ep.c
>
> <snip>
>
> > +static int rcar_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no,
> > +                             struct pci_epf_bar *epf_bar)
> > +{
> > +     struct rcar_pcie *ep = epc_get_drvdata(epc);
> > +     dma_addr_t cpu_addr = epf_bar->phys_addr;
> > +     int flags = epf_bar->flags | LAR_ENABLE | LAM_64BIT;
> > +     enum pci_barno bar = epf_bar->barno;
> > +     u64 size = 1ULL << fls64(epf_bar->size - 1);
> > +     u32 mask;
> > +     int idx;
> > +     int err;
> > +
> > +     idx = find_first_zero_bit(ep->ib_window_map, ep->num_ib_windows);
> > +     if (idx >= ep->num_ib_windows) {
> > +             dev_err(ep->dev, "no free inbound window\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     if ((flags & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_IO)
> > +             flags |= IO_SPACE;
> > +
> > +     ep->bar_to_atu[bar] = idx;
> > +     /* use 64 bit bars */
> > +     set_bit(idx, ep->ib_window_map);
> > +     set_bit(idx + 1, ep->ib_window_map);
> > +
> > +     if (cpu_addr > 0) {
> > +             unsigned long nr_zeros = __ffs64(cpu_addr);
> > +             u64 alignment = 1ULL << nr_zeros;
> > +
> > +             size = min(size, alignment);
> > +     } else {
> > +             size = size;
> > +     }
>
> We received a report from the 0day bot that clang warns that this is
> unnecessary. Would you mind removing it if you have to spin up a new
> version?
>
Sure ill fix that.

Cheers,
--Prabhakar Lad

> You can view the full report here:
>
> https://groups.google.com/d/msg/clang-built-linux/KHUKw5L8yxw/Mb7KRMG7BQAJ
>
> Cheers,
> Nathan
