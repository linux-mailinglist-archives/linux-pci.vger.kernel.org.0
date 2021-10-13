Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C6F42CD10
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 23:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhJMVuB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 17:50:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhJMVuB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Oct 2021 17:50:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD34061181;
        Wed, 13 Oct 2021 21:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634161677;
        bh=cPY8ryDhLA2mu3sMc9RHB2Q8pgUZLXNuVxNhYKTPEk0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Nio1CztCHhWTi0BI5AR5CBt1wFq+qAjZVsFNrlIjgGXhyI8WHbk0EpVJmWGDKCAZf
         IinbvKZbu4f4dheNeXCrTFx+QPhASMpsqsdeI5V3wA2b7EIMk3rnpC77Xo0F2XyqO2
         GA3Wa8hwAv2h3UKpv3t8poqhlOwamHAqtVzXY5o9XheG7ej8i3WR3a1bC17M3K7014
         zRVH6qCoB26M8vkXvDfTaV/ZBV6/ttEl2VO12jJk7HkreWJSeTt+E/diNdAMrDzVCD
         hPn7onSyFeBII68ENIuO+TwfMJx7rba6SOC/aSn69/hkFAgIzRKgIFvFwpxJEMBoCe
         rY1EP5xH/jjtw==
Received: by mail-ed1-f43.google.com with SMTP id p13so16251799edw.0;
        Wed, 13 Oct 2021 14:47:57 -0700 (PDT)
X-Gm-Message-State: AOAM533komsgYqulm5dI2yr3JaFpgFyhmObqi4HDTLX+OrR6tptakxSY
        nuBCHh+af08pZE2JbefI2fAv7q8R+bmBz566wQ==
X-Google-Smtp-Source: ABdhPJwiBpU9yR4Vs0CAGCioOsvMBU7iOl6cYtpWf3W8rRu5D2a/sa79oRT0vzePLOZp1n7ArGD0YMYncTJqW+EN28I=
X-Received: by 2002:a05:6402:27d3:: with SMTP id c19mr2848152ede.70.1634161676053;
 Wed, 13 Oct 2021 14:47:56 -0700 (PDT)
MIME-Version: 1.0
References: <YWS1QtNJh7vPCftH@robh.at.kernel.org> <20211013024355.GA1865721@bhelgaas>
 <CAL_JsqLobP9MM0EFnof_nDOBrox=gKH3xe3EQbqPceq8pRRgyA@mail.gmail.com> <20211013171653.zx4sxdzhvy2ujytd@theprophet>
In-Reply-To: <20211013171653.zx4sxdzhvy2ujytd@theprophet>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 13 Oct 2021 16:47:43 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL0d4qOR+wsnpdRUc+EQ6_diUzPbMj3Tv-Ly29or6Asvw@mail.gmail.com>
Message-ID: <CAL_JsqL0d4qOR+wsnpdRUc+EQ6_diUzPbMj3Tv-Ly29or6Asvw@mail.gmail.com>
Subject: Re: [PATCH 02/22] PCI: Unify PCI error response checking
To:     Naveen Naidu <naveennaidu479@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 13, 2021 at 12:17 PM Naveen Naidu <naveennaidu479@gmail.com> wrote:
>
> On 13/10, Rob Herring wrote:
> > On Tue, Oct 12, 2021 at 9:43 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > [+cc Pali]
> > >
> > > On Mon, Oct 11, 2021 at 05:05:54PM -0500, Rob Herring wrote:
> > > > On Mon, Oct 11, 2021 at 11:08:32PM +0530, Naveen Naidu wrote:
> > > > > An MMIO read from a PCI device that doesn't exist or doesn't respond
> > > > > causes a PCI error.  There's no real data to return to satisfy the
> > > > > CPU read, so most hardware fabricates ~0 data.
> > > > >
> > > > > Use SET_PCI_ERROR_RESPONSE() to set the error response and
> > > > > RESPONSE_IS_PCI_ERROR() to check the error response during hardware
> > > > > read.
> > > > >
> > > > > These definitions make error checks consistent and easier to find.
> > > > >
> > > > > Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> > > > > ---
> > > > >  drivers/pci/access.c | 22 +++++++++++-----------
> > > > >  1 file changed, 11 insertions(+), 11 deletions(-)
> > > > >
> > > > > diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> > > > > index 46935695cfb9..e1954bbbd137 100644
> > > > > --- a/drivers/pci/access.c
> > > > > +++ b/drivers/pci/access.c
> > > > > @@ -81,7 +81,7 @@ int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
> > > > >
> > > > >     addr = bus->ops->map_bus(bus, devfn, where);
> > > > >     if (!addr) {
> > > > > -           *val = ~0;
> > > > > +           SET_PCI_ERROR_RESPONSE(val);
> > > >
> > > > This to me doesn't look like kernel style. I'd rather see a define
> > > > replace just '~0', but I defer to Bjorn.
> > > >
> > > > >             return PCIBIOS_DEVICE_NOT_FOUND;
> > > >
> > > > Neither does this using custom error codes rather than standard Linux
> > > > errno. I point this out as I that's were I'd start with the config
> > > > accessors. Though there are lots of occurrences so we'd need a way to do
> > > > this in manageable steps.
> > >
> > > I would love to see PCIBIOS_* confined to arch/x86 and everywhere else
> > > using standard Linux error codes.
> >
>
> Digging through the mailing list, I see that something similar was
> attempted here
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2020-July/214437.html
> which did not move forward because there were a lot of moving parts (I
> guess). But reading through the thread did give me an overview of what
> we might wanna do.

Skimming it, looks like good advice from Arnd on what to do or not do.

> The thread does bring up a good point, about not returning any error
> values in pci_read_config_*() and converting the function definition to
> something like
>
>   void pci_read_config_word(struct pci_dev *dev, int where, u16 *val)
>
> The reason stated in the thread was that, the error values returned from
> these functions are either ignored or are not used properly. And
> whenever an error occurs, the error value ~0 is anyway stored in val, we
> could use that to test errors.

Presumably, there could be some register somewhere where all 1s is
valid? So I think we need the error values.

Also, I seem to recall only the vendor/device IDs are defined to be
all 1s for non-existent devices. Other errors are undefined?

> Ref:
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2020-July/214562.html
>
> I bring this point because Pali mentioned that config read function can
> return only PCIBIOS_SUCCESSFUL value.
>
> Maybe instead of us trying to change pci_read_config_word, we might
> wanna start small with changing PCI_OP_READ and PCI_USER_READ_CONFIG
> such that they would only ever return PCI_SUCCESFUL and if any these
> config accessor defines detect any error they can fabricate the value ~0
> for "val" argument.
>
> And at the caller site, instead of checking the return value of
> PCI_OP_READ to detect errors, we could check the "val" for ~0 value.
>
> But I am unable to gauge, if we should take this task before we begin
> the project of removing PCIBIOS_* OR if this should be done after we
> compelete with PCIBIOS_* work.
>
> I guess the better question would be, if making PCI_OP_READ return only
> PCI_SUCCESSFULL or converting it to a void, help the PCIBIOS_* work
> easier?
>
> > Based on Pali's and your replies, I take it that these values
> > originate in x86 firmware, so the x86 code needs to convert to Linux
> > error codes and everywhere else can use Linux error codes everywhere.
> >
> > > That's probably a lot of work, but
> > > Naveen has a lot of energy :)
> >
> > There's 210 in drivers/pci/, 62 in the rest of drivers/ and 437 in
> > arch/. 332 are PCIBIOS_SUCCESSFUL which won't change values. Most of
> > drivers/pci/ and arch/ returning the value while the rest of drivers/
> > is comparing the returned value (mostly to PCIBIOS_SUCCESSFUL). There
> > could be checks such as 'if (ret > 0)' which are harder to find. A
> > coccinelle patch might be helpful here.
> >
> > I think we want to do things in the following order:
> > - Rework any callers expecting a positive return value
> > - Make the config accessor defines convert positive error codes to
> > Linux error codes
> > - Convert pci_ops implementations to Linux error codes one by one.
> >
>
> Thank you very much for this list, this really helps me. I have been
> starting at the screen since morning to come up with something like
> this. IIUC, you mean:
>
> 1. When you mean "PCIBIOS_SUCCESSFUL which won't change values", did you
>    mean to say, that we would keep "PCIBIOS_SUCCESSFUL" define as it is
>    and not bother replacing it with "0"? (Atleast for the first version
>    of patch, and can be done in a later series)

Yes, removal of PCIBIOS_SUCCESSFUL can be done after/separately. That
greatly reduces the number of callers to touch.

> 2. "Rework any callers expecting a positive return value"
>
>    This means, find out the places where we have something like
>
>      err = pci_read_config_dword();
>         if (err > 0)
>
>    Then change it to:
>
>      err = pci_read_config_dword(pdev, PCI_REG_NPKDSC, &npkdsc);
>         if (err != PCIBIOS_SUCCESSFUL)

As Bjorn said, don't add more!

Just:

if (err)

Because that works whether we change the error codes or not.

>    Is there any easy way to search for these patterns, or should I look
>    for each instance of pci_read_config_* and other such variants and
>    see if such an case exists?

Besides grep and/or coccigrep, change the function definitions to
return void (or a ptr) and do allyesconfig builds (with 'make -k') .

Using coccinelle directly would make the changes for you. It's fairly
hard to understand and use in my limited experience.

Also keep in mind the error could get passed out of a function and
then checked elsewhere. That you can't really automate checking.
Searching, that seems to be fairly common, but I would guess most
cases are just comparing to 0 if they check. This is what I used:

git grep -W '=\spci_read_config_'

You could then grep/sed the result of this to get the functions, and
then grep using those functions to check the callers.

I also see several cases checking for < 0 already, so we'd actually be
fixing those. :)

>
> 3. "Make the config accessor defines convert positive error codes to Linux error codes"
>
>     Do you mean something like:
>
>       #define PCI_OP_READ(size, type, len) \
>       int noinline pci_bus_read_config_##size \
>         (struct pci_bus *bus, unsigned int devfn, int pos, type *value)
>         \
>         {
>            if (PCI_##size##_BAD) return pcibios_err_to_errno(PCIBIOS_BAD_REGISTER_NUMBER);
>            ...
>            ...
>            return pcibios_err_to_errno(res);

Right.

>
> 4. "Convert pci_ops implementations to Linux error codes one by one"
>
>     Finally, remove all the PCIBIOS_* references from the pci_ops
>     implementation of various drivers.

Right.

>
> > I also considered we could make the accessors convert negative error
> > codes back to positive PCIBIOS_ values, then no callers have to be
> > checked/fixed first.
> >
> > > > Can't we make PCI_OP_READ and PCI_USER_READ_CONFIG set the data value
>
> Rob, When you say this do you mean - we have something like:
>
>   #define PCI_OPS_READ()
>     res = bus->ops->read();
>     if (res != PCIBIOS_SUCCESSFUL)

if (res)

>         SET_PCI_ERROR_RESPONSE(val);

I still don't like that style, but when there's only 2 occurrences, I
don't really care.

> And the pci_ops implementation would look like:
>
>   pci_generic_config_read()
>   {
>      addr = bus->ops->map_bus();
>      if (!addr)
>         return PCIBIOS_DEVICE_NOT_FOUND;
>   }
>
> This way the controller/drivers does not have to bother fabricating the
> ~0 value, all they have to do when they detect any error is return the
> error. And the PCI_OP_READ and PCI_USER_READ_CONFIG will set the ~0
> value for "val".

Right.

>
> Pali, would you have concerns with the above design?
>
> > > > and delete the drivers all doing this? Then we have 2 copies (in source)
> > > > rather than the many this series modifies. Though I'm not sure if there
> > > > are other cases of calling pci_bus.ops.read() which expect to get ~0.
> > >
> > > That does seem like a really good idea.
> >
> > I don't it matters what order we do these, so this can happen first.
> >
>
> Yes, this makes sense. I can send a patch for this first and then start
> working on the PCIBIOS_* project. If anybody has any objection please do
> let me know.
>
> Thanks for the comment, it cleared up a lot of my doubts ^^

Sure, thanks for working on this.

Rob
