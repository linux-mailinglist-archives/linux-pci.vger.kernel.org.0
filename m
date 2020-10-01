Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5F62803D2
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 18:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732778AbgJAQXk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 12:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732610AbgJAQXj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2020 12:23:39 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6155C0613D0;
        Thu,  1 Oct 2020 09:23:39 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f18so4985951pfa.10;
        Thu, 01 Oct 2020 09:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aWqjuVX/rYSbvd6dEA6iMdBuygpme6QfEfawDQ8lNpM=;
        b=MIk9wjRDQIvMMCTAQK1l3SnKnzKyWfoGkmhjMIT8+69QOUyRwnKh4x1GPXiq3Pakit
         ReekxqlmTYuyQAgVnoeOlClNtXApk0YsVVFaiTvK/nX1kIVhk6K9HRPwIUxcy+U5O0FG
         BHg67RCo4Rh7o4n4sPphlIlgx44pyf6oXO5OmlLcqHfJoxau7bu+BYOWaBVUAzoeQH3g
         qADoXxQjddREvN6dwvrYoUaqgEhzaxZz6A47o6OUHcDfjZO9zvq9sRP0M4tlZqVkSuup
         l7e5Ws/tUxQ9gujK2R3pl5qKHJTdoPOkZjpMjj5mTHpH6E+q24qtLD8DVViVzPQehb8O
         X0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aWqjuVX/rYSbvd6dEA6iMdBuygpme6QfEfawDQ8lNpM=;
        b=oIy3nwUWPQ507LQ4xQobBLSEsd3/LDlLOyomGD6nR1CvBo56uwvVs6akGyiohBx+2s
         sW6RylSphYM4jh+uUaiB6a/LdHCWgNqLTs7sQwj/nLod3O0Iwzyt+QxX1iJGX0ah+Rws
         qoPaLB0/0b+YpgmP/VqRj31gYmswl/rVdHTBM0BO7BHnDvEJBnZ/MqRNd2Ie1K7yCvP3
         TNiq356BU29SkNn30h2ThWipaNrZlS5BY64RruJ1A9XKswrlEU0N03ckkJ0fYdIft27i
         lbc0yiT4I/DYO8M5h5xspNjlcitKJcTFB9DhpZiK9obQQ8i9O+mAuO/nMrIKFao7/eqq
         UfOw==
X-Gm-Message-State: AOAM531Chmq29PYqlO24RK2WYuwP9UJUMX7xvqdddoy2NaHhDmawgf4r
        MObpsUSb8aODz4mB8mHmbvfCKznpM+ckOg6bEjQ=
X-Google-Smtp-Source: ABdhPJxFNenEZvxR/hRDYbmiha04TRCRLTyA6smfQ2mY7RLaJ1atSCpJvD/PdJbyLkf6VB6ZL4kEpmeKVbXqy6fNr+w=
X-Received: by 2002:a63:d648:: with SMTP id d8mr6720220pgj.4.1601569419297;
 Thu, 01 Oct 2020 09:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <20201001014250.26987-1-david.e.box@linux.intel.com> <20201001014250.26987-4-david.e.box@linux.intel.com>
In-Reply-To: <20201001014250.26987-4-david.e.box@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Oct 2020 19:23:20 +0300
Message-ID: <CAHp75VdkjFvaGvw=a9kMO3ZW0+t0AvPDGySNXW6Nbi=YZkEcXg@mail.gmail.com>
Subject: Re: [PATCH V7 3/5] platform/x86: Intel PMT class driver
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        alexey.budankov@linux.intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 1, 2020 at 4:43 AM David E. Box <david.e.box@linux.intel.com> wrote:
>
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>
> Intel Platform Monitoring Technology is meant to provide a common way to
> access telemetry and system metrics.
>
> Register mappings are not provided by the driver. Instead, a GUID is read
> from a header for each endpoint. The GUID identifies the device and is to
> be used with an XML, provided by the vendor, to discover the available set
> of metrics and their register mapping.  This allows firmware updates to
> modify the register space without needing to update the driver every time
> with new mappings. Firmware writes a new GUID in this case to specify the
> new mapping.  Software tools with access to the associated XML file can
> then interpret the changes.

Where one may find a database of these reserved GUIDs / XMLs?
How do you prevent a chaos which happens with other registries?

> The module manages access to all Intel PMT endpoints on a system,
> independent of the device exporting them. It creates an intel_pmt class to
> manage the devices. For each telemetry endpoint, sysfs files provide GUID
> and size information as well as a pointer to the parent device the
> telemetry came from. Software may discover the association between
> endpoints and devices by iterating through the list in sysfs, or by looking
> for the existence of the class folder under the device of interest.  A
> binary sysfs attribute of the same name allows software to then read or map
> the telemetry space for direct access.

What are the security implications by direct access?

...

> +static const struct pci_device_id pmt_telem_early_client_pci_ids[] = {
> +       { PCI_VDEVICE(INTEL, 0x9a0d) }, /* TGL */
> +       { }
> +};
> +bool intel_pmt_is_early_client_hw(struct device *dev)
> +{
> +       struct pci_dev *parent = to_pci_dev(dev->parent);
> +
> +       return !!pci_match_id(pmt_telem_early_client_pci_ids, parent);
> +}
> +EXPORT_SYMBOL_GPL(intel_pmt_is_early_client_hw);

What is this and why is it in the class driver?

> +static ssize_t
> +intel_pmt_read(struct file *filp, struct kobject *kobj,
> +              struct bin_attribute *attr, char *buf, loff_t off,
> +              size_t count)
> +{
> +       struct intel_pmt_entry *entry = container_of(attr,
> +                                                    struct intel_pmt_entry,
> +                                                    pmt_bin_attr);

> +       if (off < 0)
> +               return -EINVAL;

Is this real or theoretical?

> +       if (count)

Useless.

> +               memcpy_fromio(buf, entry->base + off, count);
> +
> +       return count;
> +}

...

> +       psize = (PFN_UP(entry->base_addr + entry->size) - pfn) * PAGE_SIZE;

PFN_PHYS(PFN_UP(...)) ?

...

> +static struct attribute *intel_pmt_attrs[] = {
> +       &dev_attr_guid.attr,
> +       &dev_attr_size.attr,
> +       &dev_attr_offset.attr,
> +       NULL
> +};

> +

Unneeded blank line.

> +ATTRIBUTE_GROUPS(intel_pmt);

...

> +       /* if size is 0 assume no data buffer, so no file needed */
> +       if (!entry->size)
> +               return 0;

Hmm... But presence of the file is also an information that might be
useful for user, no?

...

> +       entry->base = devm_ioremap_resource(dev, &res);

(1)

> +       if (IS_ERR(entry->base)) {

> +               dev_err(dev, "Failed to ioremap device region\n");

Duplicates core message.

> +               ret = -EIO;

Why shadowing real error code?

> +               goto fail_ioremap;
> +       }

> +       iounmap(entry->base);

This is interesting. How do you avoid double unmap with (1)?

> +#include <linux/platform_device.h>
> +#include <linux/xarray.h>
> +
> +/* PMT access types */
> +#define ACCESS_BARID           2
> +#define ACCESS_LOCAL           3
> +
> +/* PMT discovery base address/offset register layout */
> +#define GET_BIR(v)             ((v) & GENMASK(2, 0))
> +#define GET_ADDRESS(v)         ((v) & GENMASK(31, 3))

bits.h

> +struct intel_pmt_entry {
> +       struct bin_attribute    pmt_bin_attr;
> +       struct kobject          *kobj;
> +       void __iomem            *disc_table;
> +       void __iomem            *base;
> +       unsigned long           base_addr;
> +       size_t                  size;

> +       u32                     guid;

types.h

> +       int                     devid;
> +};

> +static inline int
> +intel_pmt_ioremap_discovery_table(struct intel_pmt_entry *entry,
> +                                 struct platform_device *pdev,  int i)
> +{

> +       entry->disc_table = devm_platform_ioremap_resource(pdev, i);

io.h ?

> +
> +       return PTR_ERR_OR_ZERO(entry->disc_table);

err.h

> +}

The rule of thumb is to include all headers that you have direct users of.
Then you may optimize by removing those which are guaranteed to be
included by others, like
bits.h always included by bitops.h.


-- 
With Best Regards,
Andy Shevchenko
