Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7072210413B
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 17:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731673AbfKTQqC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 11:46:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:40490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729901AbfKTQqC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Nov 2019 11:46:02 -0500
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEC0020895;
        Wed, 20 Nov 2019 16:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574268361;
        bh=R6SyimNGQdLtKwjwUdKxJ320G/EPgQrR9kg29Psq5yU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jmceyR3LJHIz0w3HzRscmksCTlcPlDgJWFZalPz+nP0bd4CZwC1wiEUQ5u2k9vNWJ
         DFDzBzoQ5nKbTq2QPnAzM1mA8mn1KRuWl0T0j18DrJpWia3ZyLCjArUYzukF314peb
         aj4anLFnIvEp7JiX7R1/InSspip7Uu8sfYRH12po=
Received: by mail-qk1-f171.google.com with SMTP id q70so321711qke.12;
        Wed, 20 Nov 2019 08:46:00 -0800 (PST)
X-Gm-Message-State: APjAAAW4rjpEHvJ9A7A4K4I1/D9V2P0nJAxjJ3l8lxm81v1jteeQPTq1
        IrIESX7wL5jDNHrRe8DuB6fWN0s+f3FLhEa1kg==
X-Google-Smtp-Source: APXvYqyQsCsFWc9QmmtpDwHH2Qlb9K29LoKr0bRhwaNQe0r2nm77ICaneDWw99PkBech78rMFBTJ7acTuCde/90tiCQ=
X-Received: by 2002:a05:620a:205d:: with SMTP id d29mr3294545qka.152.1574268360061;
 Wed, 20 Nov 2019 08:46:00 -0800 (PST)
MIME-Version: 1.0
References: <20191119191505.25286-1-geert+renesas@glider.be> <20191120162750.GA3279@e121166-lin.cambridge.arm.com>
In-Reply-To: <20191120162750.GA3279@e121166-lin.cambridge.arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 20 Nov 2019 10:45:48 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL_kLOGM0QyCHo-vM14P42YQ4Ny+YJS0Ysh-3X2FDTg_A@mail.gmail.com>
Message-ID: <CAL_JsqL_kLOGM0QyCHo-vM14P42YQ4Ny+YJS0Ysh-3X2FDTg_A@mail.gmail.com>
Subject: Re: [PATCH] PCI: of: Restore alignment/indentation in host bridge
 window table
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        PCI <linux-pci@vger.kernel.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 20, 2019 at 10:27 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
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
> > ---
> >  drivers/pci/of.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
>
> Hi Rob,
>
> do you mind if I squash this patch in the Fixes: above ?

No, LGTM.

Rob
