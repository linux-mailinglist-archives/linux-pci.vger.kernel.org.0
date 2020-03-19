Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6820C18C1F6
	for <lists+linux-pci@lfdr.de>; Thu, 19 Mar 2020 21:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgCSUzV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Mar 2020 16:55:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgCSUzV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Mar 2020 16:55:21 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0554520775;
        Thu, 19 Mar 2020 20:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584651320;
        bh=jtDjDtIzunkpG4Cz0Dpezg7XbfPh6A2lmqdzMYK7ESY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=w/50NKQRA8nJ1KRlLpWX9PJD+mHg5XOKJpFJUtz394wy4gczItXAntq58YpHWJnay
         aAmWgDxJGxMToDHsdX6uALATTyv5+MAIruDOu1Pixnu8iwJSVOV8mi4K4lGETOD7GS
         cDZ0STyyQb5hVQe9f9DVUNmOZCVQkEuQhM34mmFc=
Date:   Thu, 19 Mar 2020 15:55:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Saheed Bolarinwa <refactormyself@gmail.com>
Cc:     Bjorn Helgaas <bjorn@helgaas.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-pci@vger.kernel.org
Subject: Re: Linux Kernel Mentorship Summer 2020
Message-ID: <20200319205517.GA217429@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABGxfO5Mrzx0OKpuzzc+3X2J+s1oHbxzbHpCB_FzopPp+hgw=w@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

1) Your first couple emails were multi-part MIME messages, which do
not make it to the mailing lists reliably [1].  It looks like maybe
they were sent via Gmail, which I'm sorry to say is not very convenient
in this respect.  There should be a "plain text" option in the three
dots menu next to the trash can in the draft window, which helps a
little bit.

2) Please use "interleaved" style [2] when responding, so the
conversation is easier to follow.  Gmail again makes this more of a
hassle than it should be.

3) The "**val = 0*" below is confusing; I think the surrounding
asterisks were unhelpfully added by Gmail to indicate italicization.
If you just use plain text that should help.

On Thu, Mar 19, 2020 at 04:33:34PM +0100, Saheed Bolarinwa wrote:
> So please just to clarify, I think it will be better to ONLY set **val
> = 0* when
> returning -EINVAL
> In this case, we can just *return pci_read_config_word(),* then there is
> nothing to reset.

4) I'm not sure we should be returning -EINVAL from
pcie_capability_read_*().  Those functions can also return errors from
pci_read_config_*(), which are generally PCIBIOS_SUCCESSFUL (0) or a
PCIBIOS_* error (a positive integer).  It seems sort of weird to
return either a negative errno or a positive PCIBIOS* number on error.

Other similar cases, e.g., bonito64_pcibios_read(), return
PCIBIOS_BAD_REGISTER_NUMBER if the address isn't aligned correctly.

I suggest you do some research and see whether anything would break if
we made pcie_capability_read_*() return PCIBIOS_BAD_REGISTER_NUMBER in
that case.  If not, that could be its own preliminary patch.

5) Then there are two other questions.  The first is whether we should
set *val = 0 before returning -EINVAL/PCIBIOS_BAD_REGISTER_NUMBER.
This situation is a programming error (the caller should know to use
the correct alignment).  I looked at other config accessors that
return PCIBIOS_BAD_REGISTER_NUMBER; some of them set *val = ~0
(ixp4xx_pci_read_config(), msp_pcibios_read_config_word()), but most
do not (bonito64_pcibios_read(), loongson_pcibios_read(),
msc_pcibios_read(), nile4_pcibios_read(), etc).

Again, this will require some research to make sure we don't break
anything, but I suspect we may be able to leave *val untouched when
returning error due to unaligned address.  This should be a separate
patch.

6) The second question is whether pcie_capability_read_*() should set
*val = 0 before passing on an error from pci_read_config_word().  This
is the case I originally envisioned for this project, and my thought
was that it should not set *val = 0, and it should just leave *val as
whatever pci_read_config_word() set it to.

My reasoning is that callers of pci_read_config_word() really need to
check for "val == ~0" if they care about detecting errors, and it
probably should be the same for pcie_capability_read_*().

This also requires research to see how it would affect callers.  Many
callers check for success and never look at *val if
pcie_capability_read_*() fails; those are easy.  Some callers consume
the data (*val) without checking for success -- those are the
important ones to look at.

I think the first step here is to *identify* those callers and analyze
whether they need to check for failure and how they should do it.

[1] http://vger.kernel.org/majordomo-info.html
[2] https://en.wikipedia.org/wiki/Posting_style#Interleaved_style

> On Wed, Mar 18, 2020 at 4:04 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > [+cc linux-pci because there are lots of interesting wrinkles in this
> > issue -- as background, my idea for this project was to make
> > pcie_capability_read_word() return errors  more like
> > pci_read_config_word() does.  When a PCI error occurs,
> > pci_read_config_word() returns ~0 data, but
> > pcie_capability_read_word() return 0 data.]
> >
> > On Mon, Mar 16, 2020 at 02:03:57PM +0100, Saheed Bolarinwa wrote:
> > > I have checked the function the  pcie_capability_read_word() that
> > > sets *val = 0  when pci_read_config_word() fails.
> > >
> > > I am still trying to get familiar to the code, I just wondering why
> > > the result of pci_read_config_word()  is not being returned directly
> > > since  *val  is passed into it.
> >
> > pci_read_config_word() needs to return two things:
> >
> >   1) A success/failure indication.  This is either 0 or an error like
> >   PCIBIOS_DEVICE_NOT_FOUND, PCIBIOS_BAD_REGISTER_NUMBER, etc.  This is
> >   the function return value.
> >
> >   2) A 16-bit value read from PCI config space.  This is what goes in
> >   *val.
> >
> > pcie_capability_read_word() is similar.  The idea of this project is
> > to change part 2, the value in *val.
> >
> > The reason is that sometimes the config read fails on PCI.  This can
> > happen because the device has been physically removed, it's been
> > electrically isolated, or some other PCI error.  When a config read
> > fails, the PCI host bridge generally returns ~0 data to satisfy the
> > CPU load instruction.
> >
> > The PCI core, i.e., pci_read_config_word() can't tell whether ~0 means
> > (a) the config read was successful and the register on the PCI card
> > happened to contain ~0, or (b) the config read failed because of a PCI
> > error.
> >
> > Only the driver knows whether ~0 is a valid value for a config space
> > register, so the driver has to be involved in looking for this error.
> >
> > My idea for this project is to make this checking more uniform between
> > pci_read_config_word() and pcie_capability_read_word().
> >
> > For example, pci_read_config_word() sets *val = ~0 when it returns
> > PCIBIOS_DEVICE_NOT_FOUND.
> >
> > On the other hand, pcie_capability_read_word() sets *val = 0 when it
> > returns -EINVAL, PCIBIOS_DEVICE_NOT_FOUND, etc.
> >
> > > This is what is done inside pci_read_config_word() when
> > > pci_bus_read_config_word() is called. I tried to find the definition
> > > of  pci_bus_read_config_word() but I couldn't find it.  I am not
> > > sure I need it, though.
> >
> > pci_bus_read_config_word() and similar functions are defined by the
> > PCI_OP_READ() macro in drivers/pci/access.c.  It's sort of annoying
> > because grep/cscope/etc don't find those functions very well.  But
> > you're right; they aren't really relevant to this project.
> >
> > > I am also confused with the last statement of the Project
> > > description on the Project List
> > > <https://wiki.linuxfoundation.org/lkmp/lkmp_project_list> page. It
> > > says, "*This will require changes to some callers of
> > > pci_read_config_word() that assume the read returns 0 on error.*" I
> > > think the callers pcie_capability_read_word() are supposedly being
> > > referred to here.
> >
> > Yes, that's a typo.  The idea is to change pcie_capability_read_*(),
> > so we'd probably need to change some callers to match.
> >
