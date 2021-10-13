Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EACE42C0F7
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 15:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbhJMNJA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 09:09:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233226AbhJMNI7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Oct 2021 09:08:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52EF4610FB;
        Wed, 13 Oct 2021 13:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634130416;
        bh=NseyoqpbduAc9FAUvydburYYNHvsl7nXiayEnmXGnmA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Fan/cpGHv9qVFtMeBI6hXkBNEw/7QjUYMWn6oJ9XsbFBbx0Q5YTIKTTibslw/N6QU
         hjGtUS11PeT8Vc31tNi9WvzNNhy4P65w/SI8v1BkEEavcJbw9L2RnCHL8W5oFBKzth
         q45qhofVRKJGDmMSQ5U91A/w+yRN/iMF/QTVY74MNMEGUBmeAYwz0LZe9UHMx10wFn
         g1Ihk2+aOJjXnL9Kx+a+G+KntiTl8pow+AXvOPGLjV1tRgRa/1xTdMskSSl7RIcf+J
         CdBWcEBVx+H1C4A7Hcb3CXMcV4nWKBYriqdTR9N2qG5LvnUvw/3evZEhNdnBWNrxrD
         UvYKH5S6c9InA==
Received: by mail-qt1-f169.google.com with SMTP id b12so2419702qtq.3;
        Wed, 13 Oct 2021 06:06:56 -0700 (PDT)
X-Gm-Message-State: AOAM532PlIC98bdpDhxW4UDNUzfAPiNGF+uH0en8m8zydKt2rhuouUF7
        pQAgxk5jTJNJ8hO1mjOe8q+6GmaOIH5W/GCgdA==
X-Google-Smtp-Source: ABdhPJzV8vN0pPyyeuhXbpSFHOceV0rE/LfbM2S4Qw1fs8rH1Zt6WNNdj9fAXUeThWHSqezui3EaHWo7AL6OJKcLgE8=
X-Received: by 2002:ac8:1090:: with SMTP id a16mr29380210qtj.297.1634130414188;
 Wed, 13 Oct 2021 06:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <YWS1QtNJh7vPCftH@robh.at.kernel.org> <20211013024355.GA1865721@bhelgaas>
In-Reply-To: <20211013024355.GA1865721@bhelgaas>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 13 Oct 2021 08:06:42 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLobP9MM0EFnof_nDOBrox=gKH3xe3EQbqPceq8pRRgyA@mail.gmail.com>
Message-ID: <CAL_JsqLobP9MM0EFnof_nDOBrox=gKH3xe3EQbqPceq8pRRgyA@mail.gmail.com>
Subject: Re: [PATCH 02/22] PCI: Unify PCI error response checking
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 12, 2021 at 9:43 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Pali]
>
> On Mon, Oct 11, 2021 at 05:05:54PM -0500, Rob Herring wrote:
> > On Mon, Oct 11, 2021 at 11:08:32PM +0530, Naveen Naidu wrote:
> > > An MMIO read from a PCI device that doesn't exist or doesn't respond
> > > causes a PCI error.  There's no real data to return to satisfy the
> > > CPU read, so most hardware fabricates ~0 data.
> > >
> > > Use SET_PCI_ERROR_RESPONSE() to set the error response and
> > > RESPONSE_IS_PCI_ERROR() to check the error response during hardware
> > > read.
> > >
> > > These definitions make error checks consistent and easier to find.
> > >
> > > Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> > > ---
> > >  drivers/pci/access.c | 22 +++++++++++-----------
> > >  1 file changed, 11 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> > > index 46935695cfb9..e1954bbbd137 100644
> > > --- a/drivers/pci/access.c
> > > +++ b/drivers/pci/access.c
> > > @@ -81,7 +81,7 @@ int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
> > >
> > >     addr = bus->ops->map_bus(bus, devfn, where);
> > >     if (!addr) {
> > > -           *val = ~0;
> > > +           SET_PCI_ERROR_RESPONSE(val);
> >
> > This to me doesn't look like kernel style. I'd rather see a define
> > replace just '~0', but I defer to Bjorn.
> >
> > >             return PCIBIOS_DEVICE_NOT_FOUND;
> >
> > Neither does this using custom error codes rather than standard Linux
> > errno. I point this out as I that's were I'd start with the config
> > accessors. Though there are lots of occurrences so we'd need a way to do
> > this in manageable steps.
>
> I would love to see PCIBIOS_* confined to arch/x86 and everywhere else
> using standard Linux error codes.

Based on Pali's and your replies, I take it that these values
originate in x86 firmware, so the x86 code needs to convert to Linux
error codes and everywhere else can use Linux error codes everywhere.

> That's probably a lot of work, but
> Naveen has a lot of energy :)

There's 210 in drivers/pci/, 62 in the rest of drivers/ and 437 in
arch/. 332 are PCIBIOS_SUCCESSFUL which won't change values. Most of
drivers/pci/ and arch/ returning the value while the rest of drivers/
is comparing the returned value (mostly to PCIBIOS_SUCCESSFUL). There
could be checks such as 'if (ret > 0)' which are harder to find. A
coccinelle patch might be helpful here.

I think we want to do things in the following order:
- Rework any callers expecting a positive return value
- Make the config accessor defines convert positive error codes to
Linux error codes
- Convert pci_ops implementations to Linux error codes one by one.

I also considered we could make the accessors convert negative error
codes back to positive PCIBIOS_ values, then no callers have to be
checked/fixed first.

> > Can't we make PCI_OP_READ and PCI_USER_READ_CONFIG set the data value
> > and delete the drivers all doing this? Then we have 2 copies (in source)
> > rather than the many this series modifies. Though I'm not sure if there
> > are other cases of calling pci_bus.ops.read() which expect to get ~0.
>
> That does seem like a really good idea.

I don't it matters what order we do these, so this can happen first.

Rob
