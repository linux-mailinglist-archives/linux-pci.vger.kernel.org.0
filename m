Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43C621FF87
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jul 2020 23:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgGNVCm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jul 2020 17:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbgGNVCm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2020 17:02:42 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509C5C061755;
        Tue, 14 Jul 2020 14:02:42 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id r12so53018ilh.4;
        Tue, 14 Jul 2020 14:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2npQXh+dkmWmSHKIQodxnxIAaeJj1A/FFr2Ll6AD3Hs=;
        b=cUVYKmbuMquj1tPPomJ3QAhJreggNlTpwsACBo1UIJy8ABrEJRvYcUBJ+BzMm+B8Pw
         MqSqKdxiUZLp3/SF8aRm3MPFEOcuXTXzReaF83C04QfRQHgm5C83Tljo6P1xGnktBhzD
         OT+ejuCCRxGNB8MkOVi2pHeVYazL4B1RPNhoCnI8kHFaP6uAtl1cDWerw9s1oH2TTw0B
         LM7J/Ue++Hb1A6pAPvTDsxvbkSlC8xNFDSx4dnf7ckP1Hwf+uHJfUVUzdHq5jQZARzeY
         kP3Kn/qUbeuD8v9JUHRLTRkHEjvJZJQ63Z+mmdiHUET6RLX7HxZvg2kwWAFQoo3rA3v3
         6aTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2npQXh+dkmWmSHKIQodxnxIAaeJj1A/FFr2Ll6AD3Hs=;
        b=qwBz6cpTztDr+VsGfHlbeUB1eDw8ra2ncX7HmEGbwMpDo565vKQDn1MPAzT1am94md
         LK0aVCDISIFjPj0yuE89IddNKThF9Fg+6bi0ubiqT2IID4+0SLTDdA2CopsNWR9e2jA/
         um/tbkClS1JBWdMtQfdsxQGV+7VXkisi/7QMPcTGYnB/cw5T57y2VVQhs60rswriMXRs
         lUDJ7rNe42+dcDkpGdh0WQMohRI48velBOYLyEUXhNFYz+1ErDHMEqgZ1Oj42wcJ6rM4
         R7se7cqCgPVF6Q1enrZN1uBpA9FsYZoQO26Y4rTCpX4XvjeTdzV4mE+bb53JKUrEq+nf
         zSng==
X-Gm-Message-State: AOAM533mMYWOKUMz7bmVwC3qJr/yQHnFDBikiTIxepo8TP/t5Kn6z1vE
        zkeOmrh60EoyH7PSDV+QogmQwxyd5E3EalmviHk=
X-Google-Smtp-Source: ABdhPJwkddnl6FvRyOMdkmyyDRG9lWADdbl/Rct2E+/PQzsVJk9f8CH9Av6NUhTRswYDc3FssSb6pCSldchYVLW9F38=
X-Received: by 2002:a92:9a4f:: with SMTP id t76mr6568425ili.174.1594760561627;
 Tue, 14 Jul 2020 14:02:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6602:21d8:0:0:0:0 with HTTP; Tue, 14 Jul 2020 14:02:40
 -0700 (PDT)
In-Reply-To: <20200714184550.GA397277@bjorn-Precision-5520>
References: <CAK8P3a3NWSZw6678k1O2eJ6-c5GuW7484PRvEzU9MEPPrCD-yw@mail.gmail.com>
 <20200714184550.GA397277@bjorn-Precision-5520>
From:   Kjetil Oftedal <oftedal@gmail.com>
Date:   Tue, 14 Jul 2020 23:02:40 +0200
Message-ID: <CALMQjD9OVTbLVPGX-9+GDekZ02Wsqdz57-k1uCBMXC7cT3K_7w@mail.gmail.com>
Subject: Re: [RFC PATCH 00/35] Move all PCIBIOS* definitions into arch/x86
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
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
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14/07/2020, Bjorn Helgaas <helgaas@kernel.org> wrote:

>>
>> a) callers of the high-level config space accessors
>>    pci_{write,read}_config_{byte,word,dword}, mostly in device
>>    drivers.
>> b) low-level implementation of the config space accessors
>>     through struct pci_ops
>> c) all other occurrences of these constants
>>
>> Starting with a), my first question is whether any high-level
>> drivers even need to care about errors from these functions. I see
>> 4913 callers that ignore the return code, and 576 that actually
>> check it, and almost none care about the specific error (as you
>> found as well). Unless we conclude that most PCI drivers are wrong,
>> could we just change the return type to 'void' and assume they never
>> fail for valid arguments on a valid pci_device* ?
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

Let us not do this. Reading config space is really expensive on some
architectures. Requiring a driver to do it twice on some values does not
improve upon that situation. And is quite redundant if the Root Complex
driver already knows that the first access has failed.

Additionally since multiple config accesses to the same devices is not
allowed in the spec, the hardware must block and wait for a timeout if
a config access does not get a response.
(Can happen if a intermediate link between the RC and endpoint has to retrain)
Having to block twice is very much not ideal. And in the case with
retraining the secondary access might even succeed. As the link might
recover between reading the first config word and reading PCI_VENDOR_ID.
Thus allowing the driver to accept invalid data from the device.

>
>> For b), it might be nice to also change other aspects of the
>> interface, e.g. passing a pci_host_bridge pointer plus bus number
>> instead of a pci_bus pointer, or having the callback in the
>> pci_host_bridge structure.
>
> I like this idea a lot, too.  I think the fact that
> pci_bus_read_config_word() requires a pci_bus * complicates things in
> a few places.
>
> I think it's completely separate, as you say, and we should defer it
> for now because even part a) is a lot of work.  I added it to my list
> of possible future projects.
>

What about strange PCI devices such as Non-Transparent bridges?
They will require their own PCI Config space accessors that is not
connected to a host bridge if one wants to do some sort of
punch-through enumeration.
I guess the kernel doesn't care much about them?

Best regards,
Kjetil Oftedal
