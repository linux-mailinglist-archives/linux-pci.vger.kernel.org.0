Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4237A186AED
	for <lists+linux-pci@lfdr.de>; Mon, 16 Mar 2020 13:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730984AbgCPMdk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Mar 2020 08:33:40 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41858 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730956AbgCPMdk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Mar 2020 08:33:40 -0400
Received: by mail-ot1-f67.google.com with SMTP id s15so17615216otq.8;
        Mon, 16 Mar 2020 05:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iU3FB0SyhngQVmNrB57sk80xf7jnFSDISDtNBOMq4Po=;
        b=Ho0aqwmb57ckxndR0nOlrJQQHdA2mJXB5YlwQQJnhKoJXqfcCp/6i4urvKVTyqUldz
         YbwtSkfbmHa2xl1j+qFKiM91ZBRZFyhjhBCe6r6LOMQ8BiL6PEDO+hHk8HlOQfTPnkch
         PfwZ4LoeKANmdvkQ87t5uFKZPMfXDxOsY8wpt2rdYr4zyt1KLSI2J3zFgWHpQaoD2gE4
         3xoE349tRVoJbH4NH8iqDyBEWdbxpGRp5jDY7EwAqIVIG8uMmXhR3T95mbtgBsJlGaOW
         lREaLGHlkUH+o9KybZIh3UGZw+I9Z+TFpELjB5Hc/dXxVC43ew+jXucZoJ87CxVYAgUE
         doww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iU3FB0SyhngQVmNrB57sk80xf7jnFSDISDtNBOMq4Po=;
        b=MVbCgZQScB8A4sPhuAFT06XLUvevSFv5KGgI8QOK7TOIwf5UwGBUcD+KPH4Sp8cZpJ
         ubXU6B5fo/PjXjFfcpHrPrO9OSPLXl+nYiZSLUhlYp+G950EbvIU39nMXNtEdKnm6Iw+
         6j61oSQCsUsigEN/Zli3lAIV2J5KwdI26gytqCAt7MHGxnoktbonLqDXXypb/YKZw9IB
         uQD05RyF0e+2stGO26wq/g6hc6oteIFLO/434D2qzy+GNAej+GadLD7FJQlIeIKPA7xI
         ocRh+mEq5AvPv1PjEJWXZkUTVHrFwcsbqwcAP0yqSaB+qoc5KoWwWMrUAE5P94/prMHg
         eI4A==
X-Gm-Message-State: ANhLgQ2OFpKQFL3lkVtELo99TsEGVqCeP2bSKkHlq+hfwv7GPnLuuvcV
        vJKxcdRAQHIbtkck8ooKnjwkmQUsy1xZ/QS951c=
X-Google-Smtp-Source: ADFU+vunioe+QWKw8j1Bl+f35z1EgNbIWiFK9X1ZpyeZAg5Og09WtiPgTXrhXd8gSYgqrBjQUh+ilgczIyEUJvIUgog=
X-Received: by 2002:a05:6830:20c9:: with SMTP id z9mr22360874otq.44.1584362018759;
 Mon, 16 Mar 2020 05:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200228154122.14164-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CA+V-a8vchrpa-1N1J+yVdo6-3zouOHX6=G4epWm68yirPirzag@mail.gmail.com> <20200316121859.GB5043@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200316121859.GB5043@e121166-lin.cambridge.arm.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 16 Mar 2020 12:33:12 +0000
Message-ID: <CA+V-a8tEty80_XsU2qhmxLVWXnsfv3PE+ZiVfw+jrcOJXTwr6A@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] Add support for PCIe controller to work in
 endpoint mode on R-Car SoCs
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andrew Murray <andrew.murray@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On Mon, Mar 16, 2020 at 12:19 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Mar 13, 2020 at 03:46:42PM +0000, Lad, Prabhakar wrote:
> > Hi Bjorn/Kishon,
> >
> > On Fri, Feb 28, 2020 at 3:41 PM Lad Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > >
> > > This patch series adds support for PCIe controller on rcar to work in
> > > endpoint mode, this also extends the epf framework to handle base region
> > > for mapping PCI address locally.
> > >
> > > Note:
> > > The cadence/rockchip/designware endpoint drivers are build tested only.
> > >
> > > Changes for v5:
> > > 1] Rebased the patches on next branch of https://git.kernel.org/pub/scm/
> > >    linux/kernel/git/helgaas/pci.git
> > > 2] Fixed review comments reported by Kishon while fetching the matching
> > >    window in function pci_epc_get_matching_window()
> > > 3] Fixed review comments reported by Bjorn
> > >    a] Split patch up first patch so that its easier to review and incremental
> > >    b] Fixed typos
> > > 4] Included Reviewed tag from Rob for the dt-binding patch
> > > 5] Fixed issue reported by Nathan for assigning variable to itself
> > >
> > > Changes for v4:
> > > 1] Fixed dtb_check error reported by Rob
> > > 2] Fixed review comments reported by Kishon
> > >    a] Dropped pci_epc_find_best_fit_window()
> > >    b] Fixed initializing mem ptr in __pci_epc_mem_init()
> > >    c] Dropped map_size from pci_epc_mem_window structure
> > >
> > > Changes for v3:
> > > 1] Fixed review comments from Bjorn and Kishon.
> > > 3] Converted to DT schema
> > >
> > > Changes for v2:
> > > 1] Fixed review comments from Biju for dt-bindings to include an example
> > >    for a tested platform.
> > > 2] Fixed review comments from Kishon to extend the features of outbound
> > >    regions in epf framework.
> > > 3] Added support to parse outbound-ranges in OF.
> > >
> > > Lad Prabhakar (7):
> > >   PCI: rcar: Rename pcie-rcar.c to pcie-rcar-host.c
> > >   PCI: rcar: Move shareable code to a common file
> > >   PCI: rcar: Fix calculating mask for PCIEPAMR register
> > >   PCI: endpoint: Add support to handle multiple base for mapping
> > >     outbound memory
> > >   dt-bindings: PCI: rcar: Add bindings for R-Car PCIe endpoint
> > >     controller
> > >   PCI: rcar: Add support for rcar PCIe controller in endpoint mode
> > >   misc: pci_endpoint_test: Add Device ID for RZ/G2E PCIe controller
> > >
> > Gentle ping.
>
> You should ask the R-CAR maintainers first to have a look at your
> code and ACK accordingly.
>
Thanks I have pinged the R-CAR maintainers to do the needy.

Cheers,
--Prabhakar
