Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A853414F56
	for <lists+linux-pci@lfdr.de>; Wed, 22 Sep 2021 19:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236815AbhIVRnt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Sep 2021 13:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236781AbhIVRnt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Sep 2021 13:43:49 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50928C061574;
        Wed, 22 Sep 2021 10:42:18 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id u8so3851970vsp.1;
        Wed, 22 Sep 2021 10:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i2/5vU8okCommsTVep4U8g3zmRtYGj4z1dqrBTnZYKM=;
        b=k4Db82ziafPM+lBnAm8x403uzHXRieH784TaSW+HWkfU1/m73XvJT/4Ju4iH+/9AYy
         qhItsf3xKDVAdoSe03Zo4GcACIz76UOOKM/ewbf9v3V2ZbJuDJ7jcgaYcSM4rqy5Vmc/
         xcimu96gz6twv1vSaXxcoMFAfMKFZ8RYNMAGcrkyA8xmuNiVzuUSHThy/eXwDTXCXpXy
         1vbHqz4QuU1n92Tfqspy/ra2EOtKQBbN0KeSa+I5j7JPM8+OlotXcZ04sbN+atVcm+b8
         aGtlo9evKIWpYQss1ypxKc/GdxmC9RUfbCC4VgmioL9DQa5jHLl0WEDm5wx0YFltP3kD
         cGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i2/5vU8okCommsTVep4U8g3zmRtYGj4z1dqrBTnZYKM=;
        b=AKw4ajdR3IHQSGaV9Y8pkGHauZiXU58UcBDu8pWFty7TL1cSx9UsUqhHdebJzUXbAi
         N28qUm+9Y9gWq0xEbVm6/JFaO2HAhcniKl5cxa6lOEXvSNtyS4C98VCvaVVyDRH/BI4V
         e++NdvRDgLBRAYY9MSUAWmks9vU9cv2Atkuj9N86PVHeQr8bYo3AmhtpZhzsikKzc0Ej
         bayBHwC4hUoUCU8B9QnvGDpVT09eGUmajlxPKZ1mXNCbDjzs48r+i74HA8WddkME5cw/
         0w1wvZy0Xp2KmVnm0SZhSOfvXy6dJKz4d2K8Qz4WtVfdUKRwh9gh+VMd9BfNJXMGwoHU
         pqUQ==
X-Gm-Message-State: AOAM530zlQmz9Bv/zQF+Bc1f2RJnwrhD6tOHtG6hCfDiaL7Tz5s4YC2i
        LwaO4l8qQMWChLXzm3wSGARt3dEGDu9zOFXk31M=
X-Google-Smtp-Source: ABdhPJyaivZW6j74z3cSzPRtOsWARdibu4oASTZaqOFdznpmvxF3THVCojbU4d46EccKkqiRkq6Q6b0a2toNIbm0Vag=
X-Received: by 2002:a05:6102:3005:: with SMTP id s5mr607253vsa.48.1632332537186;
 Wed, 22 Sep 2021 10:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210922042041.16326-1-sergio.paracuellos@gmail.com> <CAK8P3a2WPOYS7ra_epyZ_bBBpPK8+AgEynK0pKOUZ6ajubcHew@mail.gmail.com>
In-Reply-To: <CAK8P3a2WPOYS7ra_epyZ_bBBpPK8+AgEynK0pKOUZ6ajubcHew@mail.gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 22 Sep 2021 19:42:06 +0200
Message-ID: <CAMhs-H8EyBmahhLsx+a0aoy+znY=PCm4BT97UBg4xcAy3x2oXg@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: of: Avoid pci_remap_iospace() when PCI_IOBASE not defined
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev, gregkh <gregkh@linuxfoundation.org>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Rob Herring <robh@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Arnd,

Thanks for reviewing this.

On Wed, Sep 22, 2021 at 5:47 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Sep 22, 2021 at 6:23 AM Sergio Paracuellos
> <sergio.paracuellos@gmail.com> wrote:
>
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index d84381ce82b5..7d7aab1d1d64 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -564,12 +564,14 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
> >
> >                 switch (resource_type(res)) {
> >                 case IORESOURCE_IO:
> > +#ifdef PCI_IOBASE
> >                         err = devm_pci_remap_iospace(dev, res, iobase);
> >                         if (err) {
> >                                 dev_warn(dev, "error %d: failed to map resource %pR\n",
> >                                          err, res);
> >                                 resource_list_destroy_entry(win);
> >                         }
> > +#endif
> >                         break;
>
> I wonder if we should have a different symbol controlling this than PCI_IOBASE,
> because we are somewhat overloading the semantics here. There are a couple
> of ways that I/O space can be handled
>
> a) inb()/outb() are custom instructions, as on x86, PCI_IOBASE is not defined
> b) there is no I/O space, as on s390, PCI_IOBASE is not defined
> c) PCI_IOBASE points to a virtual address used for dynamic mapping of I/O
>     space, as on ARM
> d) PCI_IOBASE is NULL, and the port number corresponds to the virtual
>    address (some older architectures)
>
> I'm not completely sure where your platform fits in here, it sounds like you
> address them using a machine specific physical address as the base in
> inb() plus the port number as an offset, is that correct?

I guess none of the above options? I will try to explain this as per
my understanding.

[+cc Thomas Bogendoerfer as mips maintainer and with better knowledge
of mips platforms than me]

On MIPS I/O ports are memory mapped, so we access them using normal
load/store instructions.
Mips 'plat_mem_setup()' function does a 'set_io_port_base(KSEG1)'.
There, variable 'mips_io_port_base'
is set then using this address which is a virtual address to which all
ports are being mapped.
KSEG1 addresses are uncached and are not translated by the MMU. This
KSEG1 range is directly mapped in physical space starting with address
0x0.
Because of this reason, defining PCI_IOBASE as KSEG1 won't work since,
at the end 'pci_parse_request_of_pci_ranges' tries to remap to a fixed
virtual address (PCI_IOBASE). This can't work for KSEG1 addresses.
What happens if I try to do that is that I get bad addresses at pci
enumeration for IO resources. Mips ralink mt7621 SoC (which is the one
I am using and trying to mainline the driver from staging) have I/O at
address 0x1e160000. So instead of getting this address for pcie IO
BARS I get a range from 0x0000 to 0xffff since 'pci_adress_to_pio' in
that case got that range 0x0-0xffff which is wrong. To have this
working this way we would need to put PCI_IOBASE somewhere into KSEG2
which will result in creating TLB entries for IO addresses, which most
of the time isn't needed on MIPS because of access via KSEG1. Instead
of that, what happens when I avoid defining PCI_IOBASE and set
IO_SPACE_LIMIT  (See [0] and [1] commits already added to staging tree
which was part of this patch series for context of what works with
this patch together) all works properly. There have also been some
patches accepted in the past which avoid this
'pci_parse_request_of_pci_ranges' call since it is not working for
most pci legacy drivers of arch/mips for ralinks platform [2].

So I am not sure what should be the correct approach to properly make
this work (this one works for me and I cannot see others better) but I
will be happy to try whatever you propose for me to do.

Thanks in advance for your time.

Best regards,
    Sergio Paracuellos

[0]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-testing&id=159697474db41732ef3b6c2e8d9395f09d1f659e
[1]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-testing&id=50fb34eca2944fd67493717c9fbda125336f1655
[2]: https://www.spinics.net/lists/stable-commits/msg197972.html


>
>        Arnd
