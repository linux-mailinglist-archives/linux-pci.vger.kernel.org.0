Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB8C2805BE
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 19:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732941AbgJARor (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 13:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732096AbgJARon (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2020 13:44:43 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A01C0613D0;
        Thu,  1 Oct 2020 10:44:41 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id z5so7032693ilq.5;
        Thu, 01 Oct 2020 10:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y7S3lt0Z9YlatmMip4LbOnhbepXZ4CZI5iBcjQhx7Lc=;
        b=UDGl3UdeKxNYmZjsrUbrq+KUcdUvggNY/DyEZs+8Q62K1TnQBZPBc9S5YI88wksN4n
         H0QIR3HyTGnBGdMNOCP/iw2w/9GG9rEaojSXo5E7IzVS/hXJ2mWnLn2pyaPgR+QyIy/q
         Ma3uoP7SlRfP3tOjMwr77nstPrAb2xLD/9cV6LmWkP4W+ANdUi6n5e56tDhh9Uxj5tlf
         GrC4yg8BQz7K/sn0Jkt/lybVQLPX0zcJV3qA6zHpbEUDJKaQl0sKODr1BWgeLpeV+2MJ
         7OR3vOtQbqjybBTCANG652T+WDzGDqZpTFGQlZreSmyxOl/MMT8lFfsjQ2x6J2c+jmQa
         MkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y7S3lt0Z9YlatmMip4LbOnhbepXZ4CZI5iBcjQhx7Lc=;
        b=fYt68o1BvjRf3pLkx6RYlf+4OdJjDj48GMAsyx4VL9h/Z4mTVnZNebVpRenl5ec92j
         EbXuBDGRMNud1h2+Iv1oxavzOVOwMEHbxbLC8HwD2QRU90vaRI1I8AAJA64U6TFBJGfs
         oOWoj3TtKyfVhqnJ0YAy60+siBIbYtzZ28OYLoWMeXpaYAh8mAvpg8IDEzPWXJylUfHl
         VO1A++WGJCe2Oz8yaASGvFlqux/ObupMCqIBnYNgyFePo1ysZAKi0/QM+y1XgO9pKSke
         Yxe7w3vn+PM/efo/iOlHKw35KOOobxO77d+TAgdXG9u45qqAa6q4OwMk3djYF8vBhMip
         JT1Q==
X-Gm-Message-State: AOAM532MrIUDAROVVtWNGREkZnVu4lD6YXeApSXz2niDq9+D9MnL6WkJ
        uZ88rveaYL7sCFTRqAnqAOWxPwlmSLPHFhAl+m/fPrTN1RLFEg==
X-Google-Smtp-Source: ABdhPJyB4z+gyUxySufwTpNB8gUw0CPzEQCuUe4kh0fYDgt/semyZjkbNtWlao/msfPZamA38cUrLrO0Sv8RegX23II=
X-Received: by 2002:a92:91dd:: with SMTP id e90mr156831ill.237.1601574280729;
 Thu, 01 Oct 2020 10:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201001014250.26987-1-david.e.box@linux.intel.com>
 <20201001014250.26987-4-david.e.box@linux.intel.com> <CAHp75VdkjFvaGvw=a9kMO3ZW0+t0AvPDGySNXW6Nbi=YZkEcXg@mail.gmail.com>
In-Reply-To: <CAHp75VdkjFvaGvw=a9kMO3ZW0+t0AvPDGySNXW6Nbi=YZkEcXg@mail.gmail.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 1 Oct 2020 10:44:29 -0700
Message-ID: <CAKgT0UeNLKa1oshmL42pncFy5QYNOVZK=OJEQ8MNFQLrBPb_Pw@mail.gmail.com>
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

On Thu, Oct 1, 2020 at 9:26 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Oct 1, 2020 at 4:43 AM David E. Box <david.e.box@linux.intel.com> wrote:
> >
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > Intel Platform Monitoring Technology is meant to provide a common way to
> > access telemetry and system metrics.
> >
> > Register mappings are not provided by the driver. Instead, a GUID is read
> > from a header for each endpoint. The GUID identifies the device and is to
> > be used with an XML, provided by the vendor, to discover the available set
> > of metrics and their register mapping.  This allows firmware updates to
> > modify the register space without needing to update the driver every time
> > with new mappings. Firmware writes a new GUID in this case to specify the
> > new mapping.  Software tools with access to the associated XML file can
> > then interpret the changes.
>
> Where one may find a database of these reserved GUIDs / XMLs?
> How do you prevent a chaos which happens with other registries?

The database will be posted on intel.com eventually. Although I don't
believe the URL is public yet.

> > The module manages access to all Intel PMT endpoints on a system,
> > independent of the device exporting them. It creates an intel_pmt class to
> > manage the devices. For each telemetry endpoint, sysfs files provide GUID
> > and size information as well as a pointer to the parent device the
> > telemetry came from. Software may discover the association between
> > endpoints and devices by iterating through the list in sysfs, or by looking
> > for the existence of the class folder under the device of interest.  A
> > binary sysfs attribute of the same name allows software to then read or map
> > the telemetry space for direct access.
>
> What are the security implications by direct access?

In this case minimal as it would really be no different than the read.
The registers in the memory regions themselves are read-only with no
read side effects.

> ...
>
> > +static const struct pci_device_id pmt_telem_early_client_pci_ids[] = {
> > +       { PCI_VDEVICE(INTEL, 0x9a0d) }, /* TGL */
> > +       { }
> > +};
> > +bool intel_pmt_is_early_client_hw(struct device *dev)
> > +{
> > +       struct pci_dev *parent = to_pci_dev(dev->parent);
> > +
> > +       return !!pci_match_id(pmt_telem_early_client_pci_ids, parent);
> > +}
> > +EXPORT_SYMBOL_GPL(intel_pmt_is_early_client_hw);
>
> What is this and why is it in the class driver?

I chose to use the class driver as a central place to store code
common to all of the instances of the class. In this case we have
quirks that are specific to Tiger Lake and so I chose to store the
function to test for the device here.

> > +static ssize_t
> > +intel_pmt_read(struct file *filp, struct kobject *kobj,
> > +              struct bin_attribute *attr, char *buf, loff_t off,
> > +              size_t count)
> > +{
> > +       struct intel_pmt_entry *entry = container_of(attr,
> > +                                                    struct intel_pmt_entry,
> > +                                                    pmt_bin_attr);
>
> > +       if (off < 0)
> > +               return -EINVAL;
> Is this real or theoretical?

Not sure. I am not that familiar with the interface. It was something
I copied from read_bmof which is what I based this code on based on an
earlier suggestion.

> > +       if (count)
>
> Useless.

I'm assuming that is because memcpy_fromio is assumed to handle this case?

> > +               memcpy_fromio(buf, entry->base + off, count);
> > +
> > +       return count;
> > +}
>
> ...
>
> > +       psize = (PFN_UP(entry->base_addr + entry->size) - pfn) * PAGE_SIZE;
>
> PFN_PHYS(PFN_UP(...)) ?

I'm not sure how that would work. Basically what we are doing here is
determining the size of the mapping based on the number of pages that
will be needed. So we wake the pfn of the start of the region,
subtract that from the pfn for the end of the region and multiply by
the size of a page.

> > +static struct attribute *intel_pmt_attrs[] = {
> > +       &dev_attr_guid.attr,
> > +       &dev_attr_size.attr,
> > +       &dev_attr_offset.attr,
> > +       NULL
> > +};
>
> > +
>
> Unneeded blank line.
>
> > +ATTRIBUTE_GROUPS(intel_pmt);
>
> ...
>
> > +       /* if size is 0 assume no data buffer, so no file needed */
> > +       if (!entry->size)
> > +               return 0;
>
> Hmm... But presence of the file is also an information that might be
> useful for user, no?

I'm not sure what you mean? If the size of the region is zero it means
there is no data there. There are cases in future devices where we may
have controls for a telemetry function that is actually streaming the
data elsewhere. That will be the use case for the entry size of 0 and
in that case it doesn't make any sense to have a file as there is no
data to present in it.

> ...
>
> > +       entry->base = devm_ioremap_resource(dev, &res);
>
> (1)
>
> > +       if (IS_ERR(entry->base)) {
>
> > +               dev_err(dev, "Failed to ioremap device region\n");
>
> Duplicates core message.

I'll drop it since it is a redundant.

> > +               ret = -EIO;
>
> Why shadowing real error code?

I will just convert it instead. I think there might have been a bug
here in an earlier version where it was testing for NULL instead.

> > +               goto fail_ioremap;
> > +       }
>
> > +       iounmap(entry->base);
>
> This is interesting. How do you avoid double unmap with (1)?

I think I get what you are trying to say. This is redundant since we
used the devm_ioremap_resource it will already be freed when the
driver is detached, correct?

> > +#include <linux/platform_device.h>
> > +#include <linux/xarray.h>
> > +
> > +/* PMT access types */
> > +#define ACCESS_BARID           2
> > +#define ACCESS_LOCAL           3
> > +
> > +/* PMT discovery base address/offset register layout */
> > +#define GET_BIR(v)             ((v) & GENMASK(2, 0))
> > +#define GET_ADDRESS(v)         ((v) & GENMASK(31, 3))
>
> bits.h

That is already included from a few different sources.

> > +struct intel_pmt_entry {
> > +       struct bin_attribute    pmt_bin_attr;
> > +       struct kobject          *kobj;
> > +       void __iomem            *disc_tabl
> > +       void __iomem            *base;
> > +       unsigned long           base_addr;
> > +       size_t                  size;
>
> > +       u32                     guid;
>
> types.h

Is included through xarray.h.

> > +       int                     devid;
> > +};
>
> > +static inline int
> > +intel_pmt_ioremap_discovery_table(struct intel_pmt_entry *entry,
> > +                                 struct platform_device *pdev,  int i)
> > +{
>
> > +       entry->disc_table = devm_platform_ioremap_resource(pdev, i);
>
> io.h ?

That one I will move from the class.c file.

> > +
> > +       return PTR_ERR_OR_ZERO(entry->disc_table);
>
> err.h

That is included as a part of io.h.

> > +}
>
> The rule of thumb is to include all headers that you have direct users of.
> Then you may optimize by removing those which are guaranteed to be
> included by others, like bits.h always included by bitops.h.

Yeah, from what I can tell the only one I didn't have was io.h and
part of that is because this was something I had moved to the header
file in order to commonize it since it was being used in the other
drivers.
