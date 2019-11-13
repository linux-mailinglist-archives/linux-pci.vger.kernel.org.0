Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8234DFA7D3
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 05:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfKMEIF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Nov 2019 23:08:05 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41580 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfKMEIF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Nov 2019 23:08:05 -0500
Received: by mail-oi1-f193.google.com with SMTP id e9so538902oif.8;
        Tue, 12 Nov 2019 20:08:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SfWsvDTJzevdEjzMrngS03ZeASmUAsKr6Bk84qRvmhU=;
        b=lWkOrY6Ei/bGZoT3h0ZLzCVDxsZMY7ea12wDZxWc2DgCXpC1TNb3PLCdqz3gn9mOVa
         ZSWlnEGg7h822JuhyOSp2krq1BlFTwEh6SUTNMLxpC/+V6GrNbErqx8KkfaizqSI+dsO
         CfDDyT/u6Yg0oaWtcNiBE5I/gjW75lZQDm9CuVBJiKuK1b1tZF9gXYV9+nGyWvy3Arjh
         ADDGUPcQS0SqVsBWp8zKEL/nY8CBBr5BwOowVlgi30ECD48YjcuCZ+jOe1fVt7KqBqt1
         7KgeEPrAmU632auPCVJ7nSgfevHf7OoHb/l6NVkRkLMRGPXWjWdy/1VGd1i/+n84vyEo
         KUhA==
X-Gm-Message-State: APjAAAU6t7KtjWEA11atbzBaKxRvkkYu8De04FJFqF4w7Da1+qr9KvBM
        G4/1Xncuycb7zLtVzPqTRw==
X-Google-Smtp-Source: APXvYqwRUjP0Ny/K1cwD676eUUZNEvW/sKvkoiqZmyITmDaRQZxyPexAR+dfGrVGINIfyHcGyj/tlQ==
X-Received: by 2002:aca:5cd5:: with SMTP id q204mr900116oib.14.1573618083945;
        Tue, 12 Nov 2019 20:08:03 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e193sm296871oib.53.2019.11.12.20.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 20:08:03 -0800 (PST)
Date:   Tue, 12 Nov 2019 22:08:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Murray <andrew.murray@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 3/5] PCI: rcar: Add R-Car PCIe endpoint device tree
 bindings
Message-ID: <20191113040802.GA8269@bogus>
References: <20191106193609.19645-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20191106193609.19645-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVZwgVnq2kwjNJQHfvUH0sk6M7Hz-AJR82jMOsCNfW9wQ@mail.gmail.com>
 <CA+V-a8swtOUaxKnCdiTV5wvvxLEJ6XdODL=7bvQmFKY0zQTj2w@mail.gmail.com>
 <CAMuHMdXkbWkQgswMNL7Dw7_jucH+MsuAW+-CjoGVYsm=tjShRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXkbWkQgswMNL7Dw7_jucH+MsuAW+-CjoGVYsm=tjShRw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 07, 2019 at 09:08:35PM +0100, Geert Uytterhoeven wrote:
> Hi Prabhakar,
> 
> On Thu, Nov 7, 2019 at 10:26 AM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Thu, Nov 7, 2019 at 8:44 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Wed, Nov 6, 2019 at 8:36 PM Lad Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > > From: "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > This patch adds the bindings for the R-Car PCIe endpoint driver.
> > > >
> > > > Signed-off-by: Lad, Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Thanks for your patch!
> > >
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.txt
> > > > @@ -0,0 +1,43 @@
> > > > +* Renesas R-Car PCIe Endpoint Controller DT description
> > > > +
> > > > +Required properties:
> > > > +           "renesas,pcie-ep-r8a774c0" for the R8A774C0 SoC;
> > > > +           "renesas,pcie-ep-rcar-gen3" for a generic R-Car Gen3 or
> > > > +                                    RZ/G2 compatible device.
> > >
> > > Unless I'm missing something, this is for the exact same hardware block as
> > > Documentation/devicetree/bindings/pci/rcar-pci.txt?
> > > So shouldn't you amend those bindings, instead of adding new compatible
> > > values?
> > > Please remember that DT describes hardware, not software policy.
> > > So IMHO choosing between host and endpoint is purely a configuration
> > > issue, and could be indicated by the presence or lack of some DT properties.
> > > E.g. host mode requires both "bus-range" and "device_type" properties,
> > > so their absence could indicate endpoint mode.
> > >
> > yes its the same hardware block as described in the rcar-pci.txt, I
> > did think about amending it
> > but  it might turn out to be bit messy,
> >
> > required properties host ======required properties Endpoint
> > ====================||==================
> > 1: reg                                || reg
> > 2:bus-range                      || reg names
> > 3: device_type                  || resets
> > 4: ranges                          || clocks
> > 5: dma-ranges                  || clock-names
> > 6: interrupts                      ||
> > 7: interrupt-cells               ||
> > 8: interrupt-map-mask     ||
> > 9: clocks                          ||
> > 10: clock-names             ||
> 
> We have a similar situation with SPI, where a controller can operate in
> master or slave mode, based on the absence or presence of the
> "spi-slave" DT property.
> 
> > and if I go ahead with the same compatible string that would mean to
> > add support for endpoint
> > mode in the host driver itself. I did follow the examples of
> 
> You can still have two separate drivers, binding against the same
> compatible value.  Just let the .probe() function return -ENODEV if it
> discovers (by looking at DT properties) if the node is configured for
> the other mode.
> Which brings us to my next questions: is there any code that could be
> shared between the drivers for the two modes?
> 
> > rockchip/cadence/designware where
> > its the same hardware block but has two different binding files one
> > for host mode and other for
> > endpoint mode.
> 
> Having two separate DT binding documents sounds fine to me, if unifying
> them makes things too complex.
> However, I think they should use the same compatible value, because the
> hardware block is the same, but just used in a different mode.
> 
> Rob/Mark: Any input from the DT maintainers?

Separate files makes sense because different modes will want to 
include different common schemas. We've generally been doing different 
compatibles too which makes validating the node has the right set of 
properties easier.
 
> > > > +- reg: Five register ranges as listed in the reg-names property
> > > > +- reg-names: Must include the following names
> > > > +       - "apb-base"
> > > > +       - "memory0"
> > > > +       - "memory1"
> > > > +       - "memory2"
> > > > +       - "memory3"
> > >
> > > What is the purpose of the last 4 regions?
> > > Can they be chosen by the driver, at runtime?
> > >
> > no the driver cannot choose them at runtime, as these are the only
> > PCIE memory(0/1/2/3) ranges
> > in the AXI address space where host memory can be mapped.
> 
> Are they fixed by the PCIe hardware, i.e. could they be looked up by the
> driver based on the compatible value?

That would be strange for a memory range.

Sounds like like 'ranges' though I'm not sure if 'ranges' for an EP 
makes sense or what that should look like.

Rob
