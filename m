Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DE742C81E
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 19:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238323AbhJMR4T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 13:56:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238258AbhJMR4P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Oct 2021 13:56:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EF6C6113D;
        Wed, 13 Oct 2021 17:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634147651;
        bh=Lv7mWk6/WjzrSdYfEt1L01wcXOqzH0v0cjOUYtPZZTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NQA8vQ00PGc6DBcqAXRI3IaWAxJdsE+3hdqQRkQZRW4TD5U7QUjaQnw29sp0tBpKB
         YjOBwH+ge5DT5QmIaNbMhu2neJe5vsFndq91/+/Gb6hlQ3Ugh7B1pEqpFNzLrCam/o
         QXVUSEzcxFfSKfYNwNrON76vS8gkpUW6zgJdr2VewXyh1RVSxkMTOAANrMzh/UloV9
         my5Cx7g1lR0NStHKYrjLYfKQmIv+yW5yxq594HTwmkDCTyLN0Q/LEoXPo56gLZJdLx
         xYk22aWp646Cl7exAjk5NGLxIeFb+BVyO0lzzLRtwTcxWZIOtOxzlI669a/3m/SGRb
         qpqP+jv/PWUxQ==
Received: by pali.im (Postfix)
        id 873567FF; Wed, 13 Oct 2021 19:54:08 +0200 (CEST)
Date:   Wed, 13 Oct 2021 19:54:08 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Naveen Naidu <naveennaidu479@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/22] PCI: Unify PCI error response checking
Message-ID: <20211013175408.5km2xng2rdqhp6q4@pali>
References: <YWS1QtNJh7vPCftH@robh.at.kernel.org>
 <20211013024355.GA1865721@bhelgaas>
 <CAL_JsqLobP9MM0EFnof_nDOBrox=gKH3xe3EQbqPceq8pRRgyA@mail.gmail.com>
 <20211013171653.zx4sxdzhvy2ujytd@theprophet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013171653.zx4sxdzhvy2ujytd@theprophet>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On Wednesday 13 October 2021 22:46:53 Naveen Naidu wrote:
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
> 
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
> 
> Ref:
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2020-July/214562.html
> 
> I bring this point because Pali mentioned that config read function can
> return only PCIBIOS_SUCCESSFUL value.

Just correction. It is PCBIOS API (for x86). Read Configuration Byte has
defined only one return code: SUCCESSFUL. So if our kernel PCI API
follows this PCBIOS API then it can have only SUCCESSFUL return value.

Read Configuration Word and Read Configuration Dword have defined also
one additional return value: BAD_REGISTER_NUMBER. This return value is
retuned when you try to read 16 or 32-bit value from register which is
not aligned to 16 or 32 bits. Obviously this should not happen as kernel
code should call read function with correct argument. But bugs in kernel
code are possible...

Maybe todays compilers could allows us to define compile time checks
for PCI_OP_READ with len = 2 and 4 that register is valid number? I'm
not sure.

Anyway, runtime check for register alignment is already done in
PCI_OP_READ and PCI_USER_READ_CONFIG and it already returns
PCIBIOS_BAD_REGISTER_NUMBER. So ->read() callback itself should not be
called with incorrect argument (unless there is invisible bug).

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

I would like to still see ability to indicate linux errno from read and
write config functions. Just as additional information why operation
failed. Some hardware supports it.

For example it could be used for better workarounding / fixing doing
retry on CRS response when HW does not support it (even it is mandatory
per PCIe spec). For example read / write config functions could return
-EAGAIN and PCI core would know about it... See thread and patch:
https://lore.kernel.org/linux-pci/20211007192553.GA1259781@bhelgaas/

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
> 
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
> 
>    Is there any easy way to search for these patterns, or should I look
>    for each instance of pci_read_config_* and other such variants and
>    see if such an case exists?
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
> 
> 
> 4. "Convert pci_ops implementations to Linux error codes one by one"
>     
>     Finally, remove all the PCIBIOS_* references from the pci_ops
>     implementation of various drivers. 
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
>         SET_PCI_ERROR_RESPONSE(val);
> 
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
> 
> Pali, would you have concerns with the above design?

Beware that not all controllers are using map_bus callback. E.g.
pci-aardvark does not use map_bus and neither pci_generic_config_read(),
instead it implements own read callback.

But idea to fabricate 0xffffffff in PCI core code based on return value
and let controller drivers to just return -errno (without need to
fabricate *value in ptr) is a nice cleanup. It removes lot of repeated
code. And also some bugs :-) as I see that in some cases fabricated
0xffffffff is not set on error.

I like it.

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
> 
> Thanks,
> Naveen
