Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09CB1280633
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 20:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732407AbgJASG1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 14:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730029AbgJASG1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2020 14:06:27 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063A7C0613D0;
        Thu,  1 Oct 2020 11:06:26 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 197so4624337pge.8;
        Thu, 01 Oct 2020 11:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VidyP4Br3Bd5gpNl04/ZhGSkOKHbPGQFzy5qnDDJFBc=;
        b=ObjZLQEU100mPnxXXhtZeXbbNGSI92SaG4BVgKZwO0bjGKgPJcpQzKyqkXGr0mh/jJ
         0tZIaPcLqLPSgt8J0llgL7PAJ58unHGOa4aljkmfFWLva8RT8Vxy3pgc6yKS2v1hYEDC
         4j45Kc/45D2QPJqjuPZUZRqTnBmcw+u3yXYalMITB6rEAoI0kTzNcVb1ggWo7tRuRS05
         eghahMMO7RNm13z1w59Jdyc8qZdCi+/F+Jdu6ocWp9iGT6u4P9IvP7ivdLL2oczMNUxu
         GSTvNA1ydRqcrAxqqDo/sxfa2LpiU2dvZCmlZegOWyFeMQuMdsTioP3QYoHoKtlDTVR5
         75ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VidyP4Br3Bd5gpNl04/ZhGSkOKHbPGQFzy5qnDDJFBc=;
        b=WIp5BjX8lTupI87nCutIBB3s0PW9bNxfQM/SVFB3hJQ0WfnSoYfJVT8W04uiNCjCTN
         nP/mPb1XRKbbazJNQzdxB9r8ZCsqN4elm8YbuI5Pdt18L2sXXh/IkcRBSHZH9jmbWwbj
         wgnneaWmbt3/7nul6sSKy1M1DcGWvR6t0SwJkwInBO5UVySqbZSSz6HkRP9FayoKWEWj
         WJRBzQ2PaNXhOU7RD0Yl6kAsnv6uSjUD1xuzTvYahmT2JC3gj0QUSS7G2CymqpvyGoES
         7q0qRzu3CQ30Z7gFVu7+Qc9DRQemGAm4+Q9gSgNf2PguRBsMHodzn8m08GNARwixMx4O
         IHBw==
X-Gm-Message-State: AOAM533GF09gljy3UNQFpU+f6cMhXbq+nbA6MmXRCzKtfyZaHNsVjzAp
        XnNde4OY+4v5xqnO6o9mlhyEMCCM34N9oH3RRajvqQ7Gw/rshw==
X-Google-Smtp-Source: ABdhPJz5ykt96PRbBDJPSIKx/aKRKOeOOX0eav0SxbcpOlKJCQ/1BOciMnlqP+18oWVLWYVuYn1ezIVr5N+qo0bfLso=
X-Received: by 2002:aa7:81d5:0:b029:142:2501:39fa with SMTP id
 c21-20020aa781d50000b0290142250139famr8554374pfn.73.1601575586233; Thu, 01
 Oct 2020 11:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201001014250.26987-1-david.e.box@linux.intel.com>
 <20201001014250.26987-4-david.e.box@linux.intel.com> <CAHp75VdkjFvaGvw=a9kMO3ZW0+t0AvPDGySNXW6Nbi=YZkEcXg@mail.gmail.com>
 <CAKgT0UeNLKa1oshmL42pncFy5QYNOVZK=OJEQ8MNFQLrBPb_Pw@mail.gmail.com>
In-Reply-To: <CAKgT0UeNLKa1oshmL42pncFy5QYNOVZK=OJEQ8MNFQLrBPb_Pw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Oct 2020 21:06:07 +0300
Message-ID: <CAHp75VcmLbXpG6-Z6wrZn3MGWMDN8CGBAe2c3TYYy4MQk3jXNw@mail.gmail.com>
Subject: Re: [PATCH V7 3/5] platform/x86: Intel PMT class driver
To:     Alexander Duyck <alexander.duyck@gmail.com>
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

On Thu, Oct 1, 2020 at 8:44 PM Alexander Duyck
<alexander.duyck@gmail.com> wrote:
> On Thu, Oct 1, 2020 at 9:26 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thu, Oct 1, 2020 at 4:43 AM David E. Box <david.e.box@linux.intel.com> wrote:

...

> > > Intel Platform Monitoring Technology is meant to provide a common way to
> > > access telemetry and system metrics.
> > >
> > > Register mappings are not provided by the driver. Instead, a GUID is read
> > > from a header for each endpoint. The GUID identifies the device and is to
> > > be used with an XML, provided by the vendor, to discover the available set
> > > of metrics and their register mapping.  This allows firmware updates to
> > > modify the register space without needing to update the driver every time
> > > with new mappings. Firmware writes a new GUID in this case to specify the
> > > new mapping.  Software tools with access to the associated XML file can
> > > then interpret the changes.
> >
> > Where one may find a database of these reserved GUIDs / XMLs?
> > How do you prevent a chaos which happens with other registries?
>
> The database will be posted on intel.com eventually. Although I don't
> believe the URL is public yet.

How can we be sure that this won't be forgotten? How can we be sure it
will be public at the end? Please, elaborate this in the commit
message.

...

> > > +static const struct pci_device_id pmt_telem_early_client_pci_ids[] = {
> > > +       { PCI_VDEVICE(INTEL, 0x9a0d) }, /* TGL */
> > > +       { }
> > > +};
> > > +bool intel_pmt_is_early_client_hw(struct device *dev)
> > > +{
> > > +       struct pci_dev *parent = to_pci_dev(dev->parent);
> > > +
> > > +       return !!pci_match_id(pmt_telem_early_client_pci_ids, parent);
> > > +}
> > > +EXPORT_SYMBOL_GPL(intel_pmt_is_early_client_hw);
> >
> > What is this and why is it in the class driver?
>
> I chose to use the class driver as a central place to store code
> common to all of the instances of the class. In this case we have
> quirks that are specific to Tiger Lake and so I chose to store the
> function to test for the device here.

Can it be done in another file module at least (let's say intel_pmt_quirks.c)?

...

> > > +       if (off < 0)
> > > +               return -EINVAL;
> > Is this real or theoretical?
>
> Not sure. I am not that familiar with the interface. It was something
> I copied from read_bmof which is what I based this code on based on an
> earlier suggestion.

I'm not a fan of cargo cult when there is no understanding why certain
code appears in the driver.

...

> > > +       if (count)
> >
> > Useless.
>
> I'm assuming that is because memcpy_fromio is assumed to handle this case?

Right.

> > > +               memcpy_fromio(buf, entry->base + off, count);

...

> > > +       psize = (PFN_UP(entry->base_addr + entry->size) - pfn) * PAGE_SIZE;
> >
> > PFN_PHYS(PFN_UP(...)) ?
>
> I'm not sure how that would work. Basically what we are doing here is
> determining the size of the mapping based on the number of pages that
> will be needed. So we wake the pfn of the start of the region,
> subtract that from the pfn for the end of the region and multiply by
> the size of a page.

PFN_PHYS() is a replacement for multiplication. You may check its
implementation.

...

> > > +       /* if size is 0 assume no data buffer, so no file needed */
> > > +       if (!entry->size)
> > > +               return 0;
> >
> > Hmm... But presence of the file is also an information that might be
> > useful for user, no?
>
> I'm not sure what you mean? If the size of the region is zero it means
> there is no data there. There are cases in future devices where we may
> have controls for a telemetry function that is actually streaming the
> data elsewhere. That will be the use case for the entry size of 0 and
> in that case it doesn't make any sense to have a file as there is no
> data to present in it.

This is not understandable from 'no data buffer' above. Can you
elaborate in the comment?

...

> > > +       entry->base = devm_ioremap_resource(dev, &res);
> > > +       if (IS_ERR(entry->base)) {
> > > +               dev_err(dev, "Failed to ioremap device region\n");
> > > +               goto fail_ioremap;
> > > +       }
> >
> > > +       iounmap(entry->base);
> >
> > This is interesting. How do you avoid double unmap with (1)?
>
> I think I get what you are trying to say. This is redundant since we
> used the devm_ioremap_resource it will already be freed when the
> driver is detached, correct?

Right. Above is the leftover that shows the poor testing of v7.

> > > +#include <linux/platform_device.h>
> > > +#include <linux/xarray.h>
> > > +
> > > +/* PMT access types */
> > > +#define ACCESS_BARID           2
> > > +#define ACCESS_LOCAL           3
> > > +
> > > +/* PMT discovery base address/offset register layout */
> > > +#define GET_BIR(v)             ((v) & GENMASK(2, 0))
> > > +#define GET_ADDRESS(v)         ((v) & GENMASK(31, 3))
> >
> > bits.h
>
> That is already included from a few different sources.

Please, read again what I wrote below. Ditto for other inclusions.

> > > +struct intel_pmt_entry {

> > > +       struct bin_attribute    pmt_bin_attr;
> > > +       struct kobject          *kobj;
> > > +       void __iomem            *disc_tabl
> > > +       void __iomem            *base;
> > > +       unsigned long           base_addr;
> > > +       size_t                  size;
> >
> > > +       u32                     guid;
> >
> > types.h
>
> Is included through xarray.h.
>
> > > +       int                     devid;
> > > +};
> >
> > > +static inline int
> > > +intel_pmt_ioremap_discovery_table(struct intel_pmt_entry *entry,
> > > +                                 struct platform_device *pdev,  int i)
> > > +{
> >
> > > +       entry->disc_table = devm_platform_ioremap_resource(pdev, i);
> >
> > io.h ?
>
> That one I will move from the class.c file.
>
> > > +
> > > +       return PTR_ERR_OR_ZERO(entry->disc_table);
> >
> > err.h
>
> That is included as a part of io.h.
>
> > > +}
> >
> > The rule of thumb is to include all headers that you have direct users of.
> > Then you may optimize by removing those which are guaranteed to be
> > included by others, like bits.h always included by bitops.h.
>
> Yeah, from what I can tell the only one I didn't have was io.h and
> part of that is because this was something I had moved to the header
> file in order to commonize it since it was being used in the other
> drivers.

types.h not necessarily be included by above and so on...


-- 
With Best Regards,
Andy Shevchenko
