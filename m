Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E75442AB7F
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 20:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbhJLSFG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 14:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233507AbhJLSE4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Oct 2021 14:04:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 294BE610CE;
        Tue, 12 Oct 2021 18:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634061774;
        bh=xTN1PjqxcKL64k4FjBSP0uPIUc967wpJd6JWcfYGptQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VkWxnZ4AdwcZOrLECs7LwOd2c9krNsSkWbN4SZ1zwEAlTpWr00f/aWx22Zqx82KkV
         zZ2r1bSmAmhv2WVSmNCLAKRgHWRNZ+reGUKY6CSZ1qGVsGPyZXs6IB/Ei0ATlAl5kI
         f0UJV8f/xAe9Ou5SJOWwXdnzg9cACx+LAYP6jL8qAgfyAN4yU8dMYPAhIqI03q0vjm
         JWRls1TQp/KVRaC/D4/eYBSXcQR0BSjrBOS1LicD+vyGkJ9MkcObROljn1ufaKTHPy
         OfdyvXa7gBCsthA5+L2mrwVaM4pni2MlpQLe5rfSw2/rtSgXgZQfKzUEFp0sr9Py3x
         QaCdUJNUOUxIw==
Received: by mail-ed1-f42.google.com with SMTP id d9so2738642edh.5;
        Tue, 12 Oct 2021 11:02:54 -0700 (PDT)
X-Gm-Message-State: AOAM530ZmPkw9u4gyxy79iH6AP2Qnpax4oEw97RepjechBdV0ll024/Z
        edTMrzsKzyaHoN2BuAiHbEFWLiy0cCLPMTUI8w==
X-Google-Smtp-Source: ABdhPJxx05UpaUAZBZhobVr3mWSJ/Vmt1Vre3u4+SUHd1FZeloZmFdpglKPZPp5Q7X+iaEzRfGBddajKTnGEf+TRS58=
X-Received: by 2002:a05:6402:1d55:: with SMTP id dz21mr1780223edb.164.1634061772482;
 Tue, 12 Oct 2021 11:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633972263.git.naveennaidu479@gmail.com>
 <c632b07eb1b08cc7d4346455a55641436a379abd.1633972263.git.naveennaidu479@gmail.com>
 <YWS1QtNJh7vPCftH@robh.at.kernel.org> <20211012162054.rxx7aubwdvhl2eqj@theprophet>
In-Reply-To: <20211012162054.rxx7aubwdvhl2eqj@theprophet>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 12 Oct 2021 13:02:39 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKYP+6Bzm5hvcVbAz5R3+omREDJoOspJ4eTBeMwBSfkfw@mail.gmail.com>
Message-ID: <CAL_JsqKYP+6Bzm5hvcVbAz5R3+omREDJoOspJ4eTBeMwBSfkfw@mail.gmail.com>
Subject: Re: [PATCH 02/22] PCI: Unify PCI error response checking
To:     Naveen Naidu <naveennaidu479@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 12, 2021 at 11:21 AM Naveen Naidu <naveennaidu479@gmail.com> wrote:
>
> On 11/10, Rob Herring wrote:
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
>
> Apologies, if this is a lame question. Why is the macro
> SET_PCI_ERROR_RESPONSE not a kernel style. I ask this so that I do not
> end up making the same mistake again.

Generally, we don't do macros if a static inline function will work
because you get more type checking with a function. There's exceptions
like struct initializers which need to work in declarations.

Second, I think the above obfuscates the code. I know exactly what the
original line is doing to val. With SET_PCI_ERROR_RESPONSE(), I have
to go look and it hasn't saved us any LOC to make the caller more
readable. The downside of the original way, is I don't know why we set
val to ~0, but just a define would tell me that.

> Bjorn, did initally make a patch with only replacing '~0' but then
> Andrew suggested in the patch [1] that we should use the macro.
>
> [1]:
> https://lore.kernel.org/linux-pci/20190823104415.GC14582@e119886-lin.cambridge.arm.com/
> [Adding Andrew in the CC for this]

He's no longer at Arm nor active upstream.

> Apologies, I should have added this link in the cover letter but I
> completely forgot about it.
>
> That's why I decided to go with the macro. If that is not the right
> approach please let me know and I can fix it up.
>
> > >             return PCIBIOS_DEVICE_NOT_FOUND;
> >
> > Neither does this using custom error codes rather than standard Linux
> > errno. I point this out as I that's were I'd start with the config
> > accessors. Though there are lots of occurrences so we'd need a way to do
> > this in manageable steps.
> >
>
> I am sorry, but I do not have any answer for this. I really do not know
> why we return custom error codes instead of standard Linux errno. Maybe
> someone else can pitch in on this.

I don't either. My guess is either just too many places to fix or
somehow it trickles up to userspace (but probably not since the error
codes aren't in a uapi header).

> > Can't we make PCI_OP_READ and PCI_USER_READ_CONFIG set the data value
> > and delete the drivers all doing this? Then we have 2 copies (in source)
> > rather than the many this series modifies. Though I'm not sure if there
> > are other cases of calling pci_bus.ops.read() which expect to get ~0.
> >
>
> This seems like a really good idea :) But again, I am not entirely sure
> if doing so would give us any unexpected behaviour. I'll wait for some
> one to reply to this and if people agree to it, I would be glad to make
> the changes to PCI_OP_READ and PCI_USER_READ_CONFIG and send a new
> patch.

I'm expecting Bjorn to chime in.

Rob
