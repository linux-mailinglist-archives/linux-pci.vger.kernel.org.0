Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3E622005E
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jul 2020 00:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgGNWCR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jul 2020 18:02:17 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:36431 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbgGNWCR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2020 18:02:17 -0400
Received: from mail-qv1-f50.google.com ([209.85.219.50]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MkYkI-1kZiA41Kl4-00m0VJ; Wed, 15 Jul 2020 00:02:14 +0200
Received: by mail-qv1-f50.google.com with SMTP id h18so23076qvl.3;
        Tue, 14 Jul 2020 15:02:13 -0700 (PDT)
X-Gm-Message-State: AOAM531ILk7S+60OO27o1mOL4kMgX72CRnxAc3k0w3hSiCJvbA2N0Bni
        wu5G60RbnBrHP2QKq0vBsBZfyucnJ4BdR2theDw=
X-Google-Smtp-Source: ABdhPJznSzLhDwcnDZmpeVRogK9o+2OI/Kw97MVSd98PzQaS/otI9FtvjiXpPZMRdXNdxDurpAOdHjSmk9v+bKI3/P4=
X-Received: by 2002:a0c:f802:: with SMTP id r2mr6638892qvn.197.1594764132842;
 Tue, 14 Jul 2020 15:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a3NWSZw6678k1O2eJ6-c5GuW7484PRvEzU9MEPPrCD-yw@mail.gmail.com>
 <20200714184550.GA397277@bjorn-Precision-5520>
In-Reply-To: <20200714184550.GA397277@bjorn-Precision-5520>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Jul 2020 00:01:56 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3EZX8=649R9cYF6_=ivh1Xyrgsc5mUtS=d5yvQ3doZaQ@mail.gmail.com>
Message-ID: <CAK8P3a3EZX8=649R9cYF6_=ivh1Xyrgsc5mUtS=d5yvQ3doZaQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/35] Move all PCIBIOS* definitions into arch/x86
To:     Bjorn Helgaas <helgaas@kernel.org>
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
        Rob Herring <robh@kernel.org>,
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
X-Provags-ID: V03:K1:htIIEHJ+2VRo89KGgM54VbdWzY1F+p4UyOUPMeF4OPh5z8bpbUB
 sVv1cpiVoPWwICHEllgO0HS0l52ZbIaCDTXB27qFm+eZ9Yomzn6dGglu0GEDntD91Ws8O9f
 gnoT+46mW7EFaZL1TnYcDKSuTb3IwxhZODjYXY4LFMYZYL+IvYR1F6Pssxt1jeklbUQFJwr
 xQlo/x9romh/cGtYDM4DA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gdfHMQ5pVVk=:AnH71DF6zO5WmImmh4KV8/
 fgL/3Mb8jPf4tlByzGC7eAwL7drU7S9U7uVTqh0Wg85PEMDe60IDJnD9qpGbe6x3u5iz76CvH
 e9TJQ3YDjnigJj/tZEV2/hsDxwsjS6lbXqrDLQkFi89rJuMlIlljApWmZSwtANDZrxqY5UfjH
 TWYLBZfksBEq9UxTrW6r1Rch21YGvqGjJiP5JAtW3NeGiUA/B0516sSFM08wsRiHhQr3X+0it
 kjVFNgiZVvXwb9xyA8lJjBJ9Fy2B85UPYLUUMbhRunzn7A6e8grmwCyLtmA/0gsf+azsZEhJv
 pg8qaTAfJc9KLRyRZN0HAB1PGFdhmXGLYNn5qiswG8DwG+GxPiim1ZlsFvEjKuOLQqGvi/WSa
 EzHPgN9UzeaKmiNRVXIJfcjRQWlrDn/Vm0uvVFcx1/aStiUC1q1WmTNwhVJrINFTHeQgMh2oz
 B480IYi5J63gkhm279kA3Ep4bx7ED4/YoY7GnZYxxzsFxuXD9D4ur02Nv555BdKc/7n3nRwCI
 GtUajzqELc8S3cGPknxX0/w+zumNQJrek67uwoiR6QIlnUU48sqxhk23VNPia+pi8OmBWwTaI
 OAPiFAleHr42OFbv1dAK3lT4XpWHlIcqq7TPy3CO/bGYOIGGqJtAWdF9eawyAgL8qOim+xuAy
 MPCAXLtwFEErucsFzeIei3ZWAWwt217rNsoOW4CEEWBc/OX3i4abwVXrdstYeE1zuMFC20MkU
 UtUf1j63XE7KCkAAqM5cFzfnv4gAc57xtp2J94/WuDXY7hGz8BLNimh1+znE8YefWF3+2Sfie
 EhWHGBzZ5sCGCrHM+feK60kGX76xSuvhng5wws072WTqrjSngTRa52U3X9bq+hlszxsEAO9CB
 sgBBcYPGFn4L6CRaS/RnAIGZYPjebFrNCh+AXGsDYzemxapy9BlCsqhVer85s7kNrfhl2GALp
 BkdE/jOBbwR28ylZCpVvBLZLGebmHI+dsb1cA5O1dtzTJCjALqM0G
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 14, 2020 at 8:45 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Mon, Jul 13, 2020 at 05:08:10PM +0200, Arnd Bergmann wrote:
> > On Mon, Jul 13, 2020 at 3:22 PM Saheed O. Bolarinwa
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

My thinking was more that most of the time the error checking may
be completely bogus to start with, and I would just not check for
errors at all.

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

That would require changing all callers of the function, which
I think would involve changing some 700 files. What I was
suggesting was to only change the return type to void and
categorize all drivers that today check it as either

a) checking the return code is not helpful, or possibly even
    wrong, so we just stop doing it. I expect those to be the
    vast majority of callers, but that could be wrong.

b) Code that legitimately check the error code and need to
   take an appropriate action. These could be changed to
   calling a different interface such as 'pci_bus_read_config_word'
   or a new 'pci_device_last_error()' function.

The reasons I suspect that most callers don't actually need
to check for errors are:

- Most error checking is static: PCIBIOS_BAD_REGISTER_NUMBER
  only happens if you pass an invalid register number, but most
  callers pass a compile-time constant register number that is
  known to be correct, or the driver would never work. Similarly,
  PCIBIOS_DEVICE_NOT_FOUND wouldn't normally happen
  since you pass a valid pci_device pointer that was already
  probed.

- config space accesses are very rare compared to memory
  space access and on the hardware side the error handling
  would be similar, but readl/writel don't return errors, they just
  access wrong registers or return 0xffffffff.
  arch/powerpc/kernel/eeh.c has a ton extra code written to
  deal with it, but no other architectures do.

- If we add code to detect errors in pci_read_config_*
  and do some of the stuff from powerpc's
  eeh_dev_check_failure(), we are more likely to catch
  intermittent failures when drivers don't check, or bugs
  with invalid arguments in device drivers than relying on
  drivers to get their error handling right when those code
  paths don't ever get covered in normal testing.

Looking at a couple of random drivers that do check the
return codes, I find:

drivers/edac/amd8131_edac.c: prints the register number,
then keeps going. This is not useful

drivers/net/ethernet/mellanox/mlx4/reset.c: error handling
in mlx4_reset() seems reasonable, but it gets called
from mlx4_pci_resume(), which has a 'void' return code and
cannot propagate the error further. My guess is that it
would try to keep going after a failed resume and run into
random other problems then.

drivers/ata/pata_cs5536.c: error code gets passed to
caller and then always ignored. Can clearly be changed

drivers/net/wireless/intersil/prism54/islpci_hotplug.c:
Out of two calls, only one is checked, which seems bogus

drivers/usb/host/pci-quirks.c: only one of many instances
has a check, again this seems bogus.

drivers/leds/leds-ss4200.c: called from probe(), which
seems to correctly deal with errors by failing the probe.
Not sure this can ever fail though, since the driver only does
it after pci_enable_device() succeeds first. Note that
pci_enable_device() ignores pci_read_config_byte()
errors but sanity-checks the register contents/

        Arnd
