Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2CB0103635
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 09:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfKTItZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 03:49:25 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:40299 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbfKTItZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Nov 2019 03:49:25 -0500
Received: by mail-qv1-f68.google.com with SMTP id i3so9389344qvv.7;
        Wed, 20 Nov 2019 00:49:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U7zfNdmgpyMiboihJa1xiLHQ3jUJYyUMIT0Y6QJ7Ulc=;
        b=udUUlmrHK2QtoQJAgkKU87gIQ7Eg5+tahrXLo561bkxmkafJzlipih929OidOYiXoC
         4uMQXYvTGCLLYS2214W/Pgi2kUy4FUJG27fy5Z7JMJJdl1VYRZasBxjuHGnoHRrktls7
         Dy2ngDpV8ppTIyTICERN141djmmga6BQLoGFgjulrHa4n2vL0PchonNXvJPiv9yvb/Zm
         2srZZRhcRF6XNsee6ghb0Bvzb8/U7FxqvnWvfQ3TR0qnwxg2ivtI7x+ttC8RQjKrW4NL
         XKBwr5QwJTEvVArrB6t2WqzdFkCedqNthDR5VKkK4EZzJcWjT6Y7aj/yhsIyp/o71eVD
         hLxA==
X-Gm-Message-State: APjAAAWmwMoe2tyKezHgE4gUlC29DvUpOjJ0OLMSPaU5EuvGhjnwbM5w
        s7zLJ0BSx7sNCDamaTfouY5lP5uwgxBcvB9SgZA=
X-Google-Smtp-Source: APXvYqzoC89VsyKqH8kM+v4dtaa6bLp+LA8RW0cstsBLyISicvDtIlO4aN1V8hZ2omsd9l0HY5hQ+UHjdp9Z6QCWhbg=
X-Received: by 2002:a0c:e90b:: with SMTP id a11mr1449888qvo.229.1574239763803;
 Wed, 20 Nov 2019 00:49:23 -0800 (PST)
MIME-Version: 1.0
References: <20191119191505.25286-1-geert+renesas@glider.be> <20191119194800.GA204901@google.com>
In-Reply-To: <20191119194800.GA204901@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Nov 2019 09:49:12 +0100
Message-ID: <CAMuHMdULQ6-tSy79XRo8d3ujrxXfCcHDzduX2fnVZku80ofLFg@mail.gmail.com>
Subject: Re: [PATCH] PCI: of: Restore alignment/indentation in host bridge
 window table
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Tue, Nov 19, 2019 at 8:48 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Nov 19, 2019 at 08:15:05PM +0100, Geert Uytterhoeven wrote:
> > Since the printing of the inbound resources was added, alignment and
> > indentation of the host bridge window table is broken because of two
> > reasons:
> >   1. The "IB MEM" row header is longer than the other headers,
> >   2. Inbound ranges typically extend beyond 32-bit address space, and thus
> >      don't fit in "#010llx".
> >
> > Fix this by extending the row header field to 6 characters, and the
> > format string to 40-bit addresses.
> >
> > Use "%6s" to handle field size and right-alignment, instead of manual
> > preparation using error-prone snprintf() calls.  Use the exact same
> > format string for both cases, to allow sharing.
> >
> > Impact on kernel boot log on r8a7791/koelsch:
> >
> >      rcar-pcie fe000000.pcie: host bridge /soc/pcie@fe000000 ranges:
> >     -rcar-pcie fe000000.pcie:    IO 0xfe100000..0xfe1fffff -> 0x00000000
> >     -rcar-pcie fe000000.pcie:   MEM 0xfe200000..0xfe3fffff -> 0xfe200000
> >     -rcar-pcie fe000000.pcie:   MEM 0x30000000..0x37ffffff -> 0x30000000
> >     -rcar-pcie fe000000.pcie:   MEM 0x38000000..0x3fffffff -> 0x38000000
> >     -rcar-pcie fe000000.pcie: IB MEM 0x40000000..0xbfffffff -> 0x40000000
> >     -rcar-pcie fe000000.pcie: IB MEM 0x200000000..0x2ffffffff -> 0x200000000
> >     +rcar-pcie fe000000.pcie:       IO 0x00fe100000..0x00fe1fffff -> 0x0000000000
> >     +rcar-pcie fe000000.pcie:      MEM 0x00fe200000..0x00fe3fffff -> 0x00fe200000
> >     +rcar-pcie fe000000.pcie:      MEM 0x0030000000..0x0037ffffff -> 0x0030000000
> >     +rcar-pcie fe000000.pcie:      MEM 0x0038000000..0x003fffffff -> 0x0038000000
> >     +rcar-pcie fe000000.pcie:   IB MEM 0x0040000000..0x00bfffffff -> 0x0040000000
> >     +rcar-pcie fe000000.pcie:   IB MEM 0x0200000000..0x02ffffffff -> 0x0200000000
> >
> > Fixes: 52ac576f88f9f701 ("PCI: of: Add inbound resource parsing to helpers")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> This is fine with me, and since it applies on top of 52ac576f88f9f701
> (longer than the usual 12-char SHA1, BTW), which is on Lorenzo's
> pci/mmio-dma-ranges branch, I assume Lorenzo will be the one to take
> care of this.
>
> pci_register_host_bridge() prints some of this info like this:
>
>   pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
>   pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
>   pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
>   pci_bus 0000:00: root bus resource [mem 0xdc800000-0xfebfffff window]
>
> Is there any opportunity for consolidating these or at least making
> the format the same?
>
> I assume we're currently printing most of that info twice, once
> in devm_of_pci_get_host_bridge_resources() and again in
> pci_register_host_bridge()?

(after ignoring PCIe link down, as I don't have a spare PCIe card to plug in)

  rcar-pcie fe000000.pcie: host bridge /soc/pcie@fe000000 ranges:
  rcar-pcie fe000000.pcie:       IO 0x00fe100000..0x00fe1fffff -> 0x0000000000
  rcar-pcie fe000000.pcie:      MEM 0x00fe200000..0x00fe3fffff -> 0x00fe200000
  rcar-pcie fe000000.pcie:      MEM 0x0030000000..0x0037ffffff -> 0x0030000000
  rcar-pcie fe000000.pcie:      MEM 0x0038000000..0x003fffffff -> 0x0038000000
  rcar-pcie fe000000.pcie:   IB MEM 0x0040000000..0x00bfffffff -> 0x0040000000
  rcar-pcie fe000000.pcie:   IB MEM 0x0200000000..0x02ffffffff -> 0x0200000000
  rcar-pcie fe000000.pcie: PCIe link down (ignored)
  rcar-pcie fe000000.pcie: PCIe x4: link up
  rcar-pcie fe000000.pcie: PCI host bridge to bus 0002:00
  pci_bus 0002:00: root bus resource [bus 00-ff]
  pci_bus 0002:00: root bus resource [io  0x0000-0xfffff]
  pci_bus 0002:00: root bus resource [mem 0xfe200000-0xfe3fffff]
  pci_bus 0002:00: root bus resource [mem 0x30000000-0x37ffffff]
  pci_bus 0002:00: root bus resource [mem 0x38000000-0x3fffffff pref]
  pci 0002:00:00.0: [1912:001f] type 01 class 0x060400
  pci 0002:00:00.0: enabling Extended Tags
  pci 0002:00:00.0: PME# supported from D0 D3hot D3cold
  PCI: bus0: Fast back to back transfers disabled

So some, but not all, info is indeed duplicated.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
