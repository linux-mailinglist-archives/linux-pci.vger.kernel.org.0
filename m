Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC34A280759
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 21:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732462AbgJATCx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 15:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729418AbgJATCx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2020 15:02:53 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6CCC0613D0;
        Thu,  1 Oct 2020 12:02:53 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id z13so8034432iom.8;
        Thu, 01 Oct 2020 12:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8z1IpKSF7eJBQNiEBan0G7sHx3B7n42/BWgS7aCb0fs=;
        b=rwghStm4hD1cA83tsP8r77T2kcoAZHCu0PL8QJ6f1Rn+Tg61Uel63no7CCXO/cqWpj
         FHffC3YHrNYa6YwlwZwarpYm8Kl+xE6dyQuDyTUteJfbCc+culGos0koDrG2fXeKXdq7
         m/PQXdwy3SIdr5wgumNg8n7DKHOISTaHOCPNrfZn354ps+SQcKaaDw9A34Zgxkp5O0a0
         lZV7UiNVNpU6pcrZkhsYx2YMJ2ystLCdmycuZ0SQRMgFCSXvd9O4QLGXJ8UmSXFd58Gn
         qPQ4JY6MR30SBxP12LgeUO3Qph/EgQCA2w48gxhDcFonT+dn9Qh8dNXKW65L30+J5nsC
         6Kug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8z1IpKSF7eJBQNiEBan0G7sHx3B7n42/BWgS7aCb0fs=;
        b=imH5XjvTRv0a/IvT2wCbG8Eactb8mOXZ2AfFdC/1eXvkL00RHWvPucyqHOQLxaHcex
         BtoHXR+yc3VYUP2HI90rplbKEEEHCifZPDfAYGRoEpqSSxf+xkIGr4OylI/7epyoZzhs
         hv125txzw2bSNgqQrtLvLnuxAfo1AHJhsIlD2AmwT0k8/UQB4s1/X4wkFvlo6JOQsccZ
         74q97TlFpVRDbTuhXpIQyJ4hBDyFBBP9DdUUdalbDy1jiWtKym6xBpGHCaj/CK2vwK3t
         KGpwLgkaDGIXZWbIQ2ovNN0iKMK2H8bxzPbC7sflSPs6zgvduNT5hquEWoXNNeYGMPmX
         eK7A==
X-Gm-Message-State: AOAM532e440EHva7TuMPcivWJf809EbCH8DQVZGnI2dBbM0eQv6yZobS
        3Nj4LSA6iYeqK1unCpM8iv66OWqYPH3vatt6UVMVbDkjC2c=
X-Google-Smtp-Source: ABdhPJwiBYt+YxnJnNPM6Hbh+gA2ZiYXM8566KUW3U4iuFEJ8C42BBzUnWKh4UIk/nqdJ3pNaOgzX08gMi0jNDb/Omw=
X-Received: by 2002:a02:93a3:: with SMTP id z32mr7482836jah.96.1601578971622;
 Thu, 01 Oct 2020 12:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20201001014250.26987-1-david.e.box@linux.intel.com>
 <20201001014250.26987-4-david.e.box@linux.intel.com> <CAHp75VdkjFvaGvw=a9kMO3ZW0+t0AvPDGySNXW6Nbi=YZkEcXg@mail.gmail.com>
 <CAKgT0UeNLKa1oshmL42pncFy5QYNOVZK=OJEQ8MNFQLrBPb_Pw@mail.gmail.com> <CAHp75VcmLbXpG6-Z6wrZn3MGWMDN8CGBAe2c3TYYy4MQk3jXNw@mail.gmail.com>
In-Reply-To: <CAHp75VcmLbXpG6-Z6wrZn3MGWMDN8CGBAe2c3TYYy4MQk3jXNw@mail.gmail.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 1 Oct 2020 12:02:40 -0700
Message-ID: <CAKgT0UcDvw_RTcWms1nVd+8EnAB-CVppjsA86z3KBO2LSCugAQ@mail.gmail.com>
Subject: Re: [PATCH V7 3/5] platform/x86: Intel PMT class driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 1, 2020 at 11:06 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Oct 1, 2020 at 8:44 PM Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
> > On Thu, Oct 1, 2020 at 9:26 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Thu, Oct 1, 2020 at 4:43 AM David E. Box <david.e.box@linux.intel.com> wrote:
>
> ...
>
> > > > Intel Platform Monitoring Technology is meant to provide a common way to
> > > > access telemetry and system metrics.
> > > >
> > > > Register mappings are not provided by the driver. Instead, a GUID is read
> > > > from a header for each endpoint. The GUID identifies the device and is to
> > > > be used with an XML, provided by the vendor, to discover the available set
> > > > of metrics and their register mapping.  This allows firmware updates to
> > > > modify the register space without needing to update the driver every time
> > > > with new mappings. Firmware writes a new GUID in this case to specify the
> > > > new mapping.  Software tools with access to the associated XML file can
> > > > then interpret the changes.
> > >
> > > Where one may find a database of these reserved GUIDs / XMLs?
> > > How do you prevent a chaos which happens with other registries?
> >
> > The database will be posted on intel.com eventually. Although I don't
> > believe the URL is public yet.
>
> How can we be sure that this won't be forgotten? How can we be sure it
> will be public at the end? Please, elaborate this in the commit
> message.

Okay, I will work with David on that.

> ...
>
> > > > +static const struct pci_device_id pmt_telem_early_client_pci_ids[] = {
> > > > +       { PCI_VDEVICE(INTEL, 0x9a0d) }, /* TGL */
> > > > +       { }
> > > > +};
> > > > +bool intel_pmt_is_early_client_hw(struct device *dev)
> > > > +{
> > > > +       struct pci_dev *parent = to_pci_dev(dev->parent);
> > > > +
> > > > +       return !!pci_match_id(pmt_telem_early_client_pci_ids, parent);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(intel_pmt_is_early_client_hw);
> > >
> > > What is this and why is it in the class driver?
> >
> > I chose to use the class driver as a central place to store code
> > common to all of the instances of the class. In this case we have
> > quirks that are specific to Tiger Lake and so I chose to store the
> > function to test for the device here.
>
> Can it be done in another file module at least (let's say intel_pmt_quirks.c)?

I suppose, but then it is adding a file for essentially 13 lines of
code. Maybe I will just move this back to intel_pmt_telemetry.c and we
can revisit where this should go if/when we add the watcher driver.

> ...
>
> > > > +       if (off < 0)
> > > > +               return -EINVAL;
> > > Is this real or theoretical?
> >
> > Not sure. I am not that familiar with the interface. It was something
> > I copied from read_bmof which is what I based this code on based on an
> > earlier suggestion.
>
> I'm not a fan of cargo cult when there is no understanding why certain
> code appears in the driver.

Well with something like this I usually question if it provides any
value. The problem is I don't know enough about binary sysfs
attributes to say one way or another. If you know that the offset
provided cannot be negative I can drop it. However I haven't seen
anything that seems to say one way or another.

> ...
>
> > > > +       if (count)
> > >
> > > Useless.
> >
> > I'm assuming that is because memcpy_fromio is assumed to handle this case?
>
> Right.
>
> > > > +               memcpy_fromio(buf, entry->base + off, count);
>
> ...
>
> > > > +       psize = (PFN_UP(entry->base_addr + entry->size) - pfn) * PAGE_SIZE;
> > >
> > > PFN_PHYS(PFN_UP(...)) ?
> >
> > I'm not sure how that would work. Basically what we are doing here is
> > determining the size of the mapping based on the number of pages that
> > will be needed. So we wake the pfn of the start of the region,
> > subtract that from the pfn for the end of the region and multiply by
> > the size of a page.
>
> PFN_PHYS() is a replacement for multiplication. You may check its
> implementation.

Ah, okay so you meant PFN_PHYS(PFN_UP(...)-pfn)

> ...
>
> > > > +       /* if size is 0 assume no data buffer, so no file needed */
> > > > +       if (!entry->size)
> > > > +               return 0;
> > >
> > > Hmm... But presence of the file is also an information that might be
> > > useful for user, no?
> >
> > I'm not sure what you mean? If the size of the region is zero it means
> > there is no data there. There are cases in future devices where we may
> > have controls for a telemetry function that is actually streaming the
> > data elsewhere. That will be the use case for the entry size of 0 and
> > in that case it doesn't make any sense to have a file as there is no
> > data to present in it.
>
> This is not understandable from 'no data buffer' above. Can you
> elaborate in the comment?

Having a file here implies there is something to read. There are
devices supported by PMT which are essentially just control only,
specifically some of the watchers. So the file would have nothing to
read/mmap. In such a case it wouldn't make sense to provide a binary
sysfs attribute as there is no data to associate with it.

> ...
>
> > > > +       entry->base = devm_ioremap_resource(dev, &res);
> > > > +       if (IS_ERR(entry->base)) {
> > > > +               dev_err(dev, "Failed to ioremap device region\n");
> > > > +               goto fail_ioremap;
> > > > +       }
> > >
> > > > +       iounmap(entry->base);
> > >
> > > This is interesting. How do you avoid double unmap with (1)?
> >
> > I think I get what you are trying to say. This is redundant since we
> > used the devm_ioremap_resource it will already be freed when the
> > driver is detached, correct?
>
> Right. Above is the leftover that shows the poor testing of v7.

I will admit I don't think we tested the case where
sysfs_create_bin_file failed.

> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/xarray.h>
> > > > +
> > > > +/* PMT access types */
> > > > +#define ACCESS_BARID           2
> > > > +#define ACCESS_LOCAL           3
> > > > +
> > > > +/* PMT discovery base address/offset register layout */
> > > > +#define GET_BIR(v)             ((v) & GENMASK(2, 0))
> > > > +#define GET_ADDRESS(v)         ((v) & GENMASK(31, 3))
> > >
> > > bits.h
> >
> > That is already included from a few different sources.
>
> Please, read again what I wrote below. Ditto for other inclusions.
>
> > > > +struct intel_pmt_entry {
>
> > > > +       struct bin_attribute    pmt_bin_attr;
> > > > +       struct kobject          *kobj;
> > > > +       void __iomem            *disc_tabl
> > > > +       void __iomem            *base;
> > > > +       unsigned long           base_addr;
> > > > +       size_t                  size;
> > >
> > > > +       u32                     guid;
> > >
> > > types.h
> >
> > Is included through xarray.h.
> >
> > > > +       int                     devid;
> > > > +};
> > >
> > > > +static inline int
> > > > +intel_pmt_ioremap_discovery_table(struct intel_pmt_entry *entry,
> > > > +                                 struct platform_device *pdev,  int i)
> > > > +{
> > >
> > > > +       entry->disc_table = devm_platform_ioremap_resource(pdev, i);
> > >
> > > io.h ?
> >
> > That one I will move from the class.c file.
> >
> > > > +
> > > > +       return PTR_ERR_OR_ZERO(entry->disc_table);
> > >
> > > err.h
> >
> > That is included as a part of io.h.
> >
> > > > +}
> > >
> > > The rule of thumb is to include all headers that you have direct users of.
> > > Then you may optimize by removing those which are guaranteed to be
> > > included by others, like bits.h always included by bitops.h.
> >
> > Yeah, from what I can tell the only one I didn't have was io.h and
> > part of that is because this was something I had moved to the header
> > file in order to commonize it since it was being used in the other
> > drivers.
>
> types.h not necessarily be included by above and so on...

Okay, I will just explicitly add those headers then.
