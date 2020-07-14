Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0072200ED
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jul 2020 01:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgGNXO1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jul 2020 19:14:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbgGNXO0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jul 2020 19:14:26 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B74362075F;
        Tue, 14 Jul 2020 23:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594768465;
        bh=r7uog4cESi48Yw4dYY/DbLx7RZlV6wCw1CEWWq+6XlA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uhqM1DKsUBkSb34ZnuySBr11C/IVPTDM78HhVr6YtPYQ3Bc4x1bvgqjEx581Hv2FW
         EIuFsrRT+78H956XxDDewcRuBohQqiLDDl575JzoIe5NYEoONSm81aWVgO2DaJDI9D
         DOoHqhOtl8Tr4c+O5x3B1xslQtiC68LEHOSdon54=
Received: by mail-oi1-f176.google.com with SMTP id t4so318186oij.9;
        Tue, 14 Jul 2020 16:14:25 -0700 (PDT)
X-Gm-Message-State: AOAM530cKChUQxMJmm8eJgrEdFK4uZOvLQOdzu4mM5vWYYybiIBjcVs/
        7dN1utjuHPfTdn2zBuqgolJhnjJyVlDFnHljIA==
X-Google-Smtp-Source: ABdhPJyPeAsck+oWahDAYilS/PEH/rJeSk/8KZU/L05nx97DSP/InZ2NhVXCgkioINrDYey4E+B55UCj7W0qHUAPUos=
X-Received: by 2002:aca:30d2:: with SMTP id w201mr5744639oiw.147.1594768464844;
 Tue, 14 Jul 2020 16:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a3NWSZw6678k1O2eJ6-c5GuW7484PRvEzU9MEPPrCD-yw@mail.gmail.com>
 <20200714184550.GA397277@bjorn-Precision-5520>
In-Reply-To: <20200714184550.GA397277@bjorn-Precision-5520>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 14 Jul 2020 17:14:13 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL21k8wyxfGfVdwz0jBEVME5b+rvLrwF4waZeiHZkuvhA@mail.gmail.com>
Message-ID: <CAL_JsqL21k8wyxfGfVdwz0jBEVME5b+rvLrwF4waZeiHZkuvhA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/35] Move all PCIBIOS* definitions into arch/x86
To:     Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, Shuah Khan <skhan@linuxfoundation.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Russell King <linux@armlinux.org.uk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux <sparclinux@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 14, 2020 at 12:45 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [trimmed the cc list; it's still too large but maybe arch folks care]
>
> On Mon, Jul 13, 2020 at 05:08:10PM +0200, Arnd Bergmann wrote:
> > On Mon, Jul 13, 2020 at 3:22 PM Saheed O. Bolarinwa
> > <refactormyself@gmail.com> wrote:
> > > This goal of these series is to move the definition of *all*
> > > PCIBIOS* from include/linux/pci.h to arch/x86 and limit their use
> > > within there.  All other tree specific definition will be left for
> > > intact. Maybe they can be renamed.
> > >
> > > PCIBIOS* is an x86 concept as defined by the PCI spec. The
> > > returned error codes of PCIBIOS* are positive values and this
> > > introduces some complexities which other archs need not incur.
> >
> > I think the intention is good, but I find the series in its current
> > form very hard to review, in particular the way you touch some
> > functions three times with trivial changes. Instead of
> >
> > 1) replace PCIBIOS_SUCCESSFUL with 0
> > 2) drop pointless 0-comparison
> > 3) reformat whitespace
> >
> > I would suggest to combine the first two steps into one patch per
> > subsystem and drop the third step.
>
> I agree.  BUT please don't just run out and post new patches to do
> this.  Let's talk about Arnd's further ideas below first.
>
> > ...
> > Maybe the work can be split up differently, with a similar end
> > result but fewer and easier reviewed patches. The way I'd look at
> > the problem, there are three main areas that can be dealt with one
> > at a time:
> >
> > a) callers of the high-level config space accessors
> >    pci_{write,read}_config_{byte,word,dword}, mostly in device
> >    drivers.
> > b) low-level implementation of the config space accessors
> >     through struct pci_ops
> > c) all other occurrences of these constants
> >
> > Starting with a), my first question is whether any high-level
> > drivers even need to care about errors from these functions. I see
> > 4913 callers that ignore the return code, and 576 that actually
> > check it, and almost none care about the specific error (as you
> > found as well). Unless we conclude that most PCI drivers are wrong,
> > could we just change the return type to 'void' and assume they never
> > fail for valid arguments on a valid pci_device* ?
>
> I really like this idea.
>
> pci_write_config_*() has one return value, and only 100ish of 2500
> callers check for errors.  It's sometimes possible for config
> accessors to detect PCI errors and return failure, e.g., device was
> removed or didn't respond, but most of them don't, and detecting these
> errors is not really that valuable.
>
> pci_read_config_*() is much more interesting because it returns two
> things, the function return value and the value read from the PCI
> device, and it's complicated to check both.
>
> Again it's sometimes possible for config read accessors to detect PCI
> errors, but in most cases a PCI error means the accessor returns
> success and the value from PCI is ~0.
>
> Checking the function return value catches programming errors (bad
> alignment, etc) but misses most of the interesting errors (device was
> unplugged or reported a PCI error).
>
> Checking the value returned from PCI is tricky because ~0 is a valid
> value for some config registers, and only the driver knows for sure.
> If the driver knows that ~0 is a possible value, it would have to do
> something else, e.g., another config read of a register that *cannot*
> be ~0, to see whether it's really an error.
>
> I suspect that if we had a single value to look at it would be easier
> to get right.  Error checking with current interface would look like
> this:
>
>   err = pci_read_config_word(dev, addr, &val);
>   if (err)
>     return -EINVAL;
>
>   if (PCI_POSSIBLE_ERROR(val)) {
>     /* if driver knows ~0 is invalid */
>     return -EINVAL;
>
>     /* if ~0 is potentially a valid value */
>     err = pci_read_config_word(dev, PCI_VENDOR_ID, &val2);
>     if (err)
>       return -EINVAL;
>
>     if (PCI_POSSIBLE_ERROR(val2))
>       return -EINVAL;
>   }
>
> Error checking with a possible interface that returned only a single
> value could look like this:
>
>   val = pci_config_read_word(dev, addr);
>   if (PCI_POSSIBLE_ERROR(val)) {
>     /* if driver knows ~0 is invalid */
>     return -EINVAL;
>
>     /* if ~0 is potentially a valid value */
>     val2 = pci_config_read_word(dev, PCI_VENDOR_ID);
>     if (PCI_POSSIBLE_ERROR(val2))
>       return -EINVAL;
>   }
>
> Am I understanding you correctly?
>
> > For b), it might be nice to also change other aspects of the
> > interface, e.g. passing a pci_host_bridge pointer plus bus number
> > instead of a pci_bus pointer, or having the callback in the
> > pci_host_bridge structure.
>
> I like this idea a lot, too.  I think the fact that
> pci_bus_read_config_word() requires a pci_bus * complicates things in
> a few places.

I've been looking at the various host implementations of config
accessors as well as probe functions. Needing the pci_bus pointer is a
big reason why host drivers will have 2 sets of config accessors or
don't use the generic ones. Often that's just for the root bus config
space init before pci_host_probe() is called. Perhaps that's better
addressed with a fixup hook for the host bridge? ftpci100i is a good
example of this.

The root bus accesses are often different from the rest of config
space. Determining if an access is for the root bus or not is all over
the map, but often involves a private bus number variable. I have a
series to use pci_is_root_bus() instead and eliminate a bunch of bus
number handling in the host drivers (I'm sure there's a bunch of hosts
that would be broken if the root bus is not 0). The majority of hosts
don't really need to know anything about the bus number. The more I've
thought about it, it would be better if the PCI core handled this and
picked the right ops to call. We already have several cases of host
drivers with their own ops for this and we could eliminate several
layers of indirection (looking at you, DWC). Any thoughts on direction
here would be helpful.

> I think it's completely separate, as you say, and we should defer it
> for now because even part a) is a lot of work.  I added it to my list
> of possible future projects.

Got that published somewhere? :)

Rob
