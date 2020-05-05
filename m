Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445A31C5763
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 15:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgEENt6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 09:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728180AbgEENt6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 May 2020 09:49:58 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F81C061A0F;
        Tue,  5 May 2020 06:49:58 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id j21so1045683pgb.7;
        Tue, 05 May 2020 06:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9MCIO2OCfMOgmV5WblJ/wi27KouMeCD72GUlRx7Mb+U=;
        b=lYXFjuSEZ4adi7eHR0YNXLGvq1LdV3DVgdyuGbLYR/w4rHXXccdvf4YLmlBQNKX/0d
         u1Jj124H0EvE3WsYlxIiZVLPSIgpACDohDmsvOAiHSNTx721tSx2gKvKTu/vvaczOSXd
         ON+d0rpMccVye8GPS/8Ud9oQUbXN/bBkBj0JbyLzZAwdd4C8QlYdYqw5OHZRj034VmTA
         TkjsX1rg5TID1NYAIAizVjigOC0rtPhFuSxmpVzLPWNd1QtLkx5RVTMK8+SOp9RzLpG+
         bDshL/yqRl/K8TlZXtCPssIABxehIoWVUj9d8Xl6QdEDrAYmXupJPDJE7c9IahntKT2V
         MP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9MCIO2OCfMOgmV5WblJ/wi27KouMeCD72GUlRx7Mb+U=;
        b=mdZwIs068b6A/mjqB1AshCbqm86nI6Ldywy7Ebw6zANzqa60QHxD2CnYsv2T2pXH0G
         Ut2Z96O71DS1Nh2k/3mUq8ITctoRhhWfFiIueHr1Tk05b790YwO/xQBj2R+Iv7W3HUP/
         oezZ56urZIFbCxpIGaWXocCmSq9HPEpISDX7p2gnSFzdovh83ghpmLWNyPhzLZjO7u+I
         y/1cuqmleqLx6syeVU8Nc2fZnO/5GmK5Tg9VgSBCTQO/PZLLfeq3hbMZzhwSwUGUQzyv
         3SEY+M9nk9NayM1VlV2yxYO92AJJd9uSlraP9dDqdvq9/VYiHs9jtx46PpiZ3oOeqB2N
         breA==
X-Gm-Message-State: AGi0PuZ9TJ1tabC3m5xa1Kp93s6gd7azIonpTj4UuTeS/GrQ1wCXxBCJ
        pyyi7lJCi/rGhefQmfVy5KfcI1ajpyVnBnztmq916RBZUGs=
X-Google-Smtp-Source: APiQypLEjjkNBYqDj1xIa1IS20Q1twTdcOnA68o6+brisIVbghPEqqR8qaQvl3R23uiKsniAbHKbPYMgjmDuIoyZm6Y=
X-Received: by 2002:a62:5ec7:: with SMTP id s190mr3158550pfb.130.1588686597629;
 Tue, 05 May 2020 06:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200505013206.11223-1-david.e.box@linux.intel.com>
 <20200505023149.11630-1-david.e.box@linux.intel.com> <20200505023149.11630-2-david.e.box@linux.intel.com>
In-Reply-To: <20200505023149.11630-2-david.e.box@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 May 2020 16:49:50 +0300
Message-ID: <CAHp75VdnVg7q-Nr-3cO-NyKzk0ckfauOso3yDM4qUF3ofSK_VQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] platform/x86: Intel PMT Telemetry capability driver
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andy@infradead.org>,
        alexander.h.duyck@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 5, 2020 at 5:32 AM David E. Box <david.e.box@linux.intel.com> wrote:

...

> Register mappings are not provided by the driver. Instead, a GUID is read
> from a header for each endpoint. The GUID identifies the device and is to
> be used with an XML, provided by the vendor, to discover the available set
> of metrics and their register mapping.  This allows firmware updates to
> modify the register space without needing to update the driver every time
> with new mappings. Firmware writes a new GUID in this case to specify the
> new mapping.  Software tools with access to the associated XML file can
> then interpret the changes.

Is old hardware going to support this in the future?
(I have in mind Apollo Lake / Broxton)

> This module manages access to all PMT Telemetry endpoints on a system,
> regardless of the device exporting them. It creates an intel_pmt_telem

Name is not the best we can come up with. Would anyone else use PMT?
Would it be vendor-agnostic ABI?
(For example, I know that MIPI standardizes tracing protocols, like
STM, do we have any plans to standardize this one?)

telem -> telemetry.

> class to manage the list. For each endpoint, sysfs files provide GUID and
> size information as well as a pointer to the parent device the telemetry
> comes from. Software may discover the association between endpoints and
> devices by iterating through the list in sysfs, or by looking for the
> existence of the class folder under the device of interest.  A device node
> of the same name allows software to then map the telemetry space for direct
> access.

...

> +       tristate "Intel PMT telemetry driver"

I think user should understand what is it from the title (hint: spell
PMT fully).

...

>  obj-$(CONFIG_PMC_ATOM)                 += pmc_atom.o
> +obj-$(CONFIG_INTEL_PMT_TELEM)          += intel_pmt_telem.o

Keep this and Kconfig section in order with the other stuff.

...

bits.h?

> +#include <linux/cdev.h>
> +#include <linux/intel-dvsec.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +#include <linux/xarray.h>

...

> +/* platform device name to bind to driver */
> +#define TELEM_DRV_NAME         "pmt_telemetry"

Shouldn't be part of MFD header?

...

> +#define TELEM_TBIR_MASK                0x7

GENMASK() ?

> +struct pmt_telem_priv {
> +       struct device                   *dev;
> +       struct intel_dvsec_header       *dvsec;
> +       struct telem_header             header;
> +       unsigned long                   base_addr;
> +       void __iomem                    *disc_table;
> +       struct cdev                     cdev;
> +       dev_t                           devt;
> +       int                             devid;
> +};

...

> +       unsigned long phys = priv->base_addr;
> +       unsigned long pfn = PFN_DOWN(phys);
> +       unsigned long psize;
> +
> +       psize = (PFN_UP(priv->base_addr + priv->header.size) - pfn) * PAGE_SIZE;
> +       if (vsize > psize) {
> +               dev_err(priv->dev, "Requested mmap size is too large\n");
> +               return -EINVAL;
> +       }

...


> +static ssize_t guid_show(struct device *dev, struct device_attribute *attr,
> +                        char *buf)
> +{
> +       struct pmt_telem_priv *priv = dev_get_drvdata(dev);
> +
> +       return sprintf(buf, "0x%x\n", priv->header.guid);
> +}

So, it's not a GUID but rather some custom number? Can we actually do
a real GUID / UUID here?
Because of TODO below I suppose it's not carved in stone (yet) and
basically a protocol defined by firmware (which can be amended).

...

> +       /* TODO: replace with device properties??? */

So, please, fulfill. swnode I guess is what you are looking for.

> +       priv->dvsec = dev_get_platdata(&pdev->dev);
> +       if (!priv->dvsec) {
> +               dev_err(&pdev->dev, "Platform data not found\n");
> +               return -ENODEV;
> +       }

...

> +       /* Local access and BARID only for now */
> +       switch (priv->header.access_type) {
> +       case TELEM_ACCESS_LOCAL:
> +               if (priv->header.tbir) {
> +                       dev_err(&pdev->dev,
> +                               "Unsupported BAR index %d for access type %d\n",
> +                               priv->header.tbir, priv->header.access_type);
> +                       return -EINVAL;
> +               }

> +               fallthrough;

What's the point?

> +
> +       case TELEM_ACCESS_BARID:
> +               break;
> +       default:
> +               dev_err(&pdev->dev, "Unsupported access type %d\n",
> +                       priv->header.access_type);
> +               return -EINVAL;
> +       }

> +       err = alloc_chrdev_region(&priv->devt, 0, 1, TELEM_DRV_NAME);

err or ret? Be consistent in the module.

> +       if (err < 0) {

' < 0' Do we need it?

> +               dev_err(&pdev->dev,
> +                       "PMT telemetry chrdev_region err: %d\n", err);
> +               return err;
> +       }

...

> +       err = pmt_telem_create_dev(priv);
> +       if (err < 0)

' < 0' Do we need it?

> +               goto fail_create_dev;
> +
> +       return 0;

> +}

...

> +static const struct platform_device_id pmt_telem_table[] = {
> +       {
> +               .name = "pmt_telemetry",
> +       }, {
> +               /* sentinel */
> +       }

{ .name = ... },
{}

is enough.

> +};

...

> +static int __init pmt_telem_init(void)
> +{

> +       int ret = class_register(&pmt_telem_class);
> +
> +       if (ret)

int ret;

ret = ...
if (ret)

> +               return ret;
> +
> +       ret = platform_driver_register(&pmt_telem_driver);
> +       if (ret)
> +               class_unregister(&pmt_telem_class);
> +
> +       return ret;
> +}

...

> +{

> +}

> +

Extra blank line.

> +module_init(pmt_telem_init);
> +module_exit(pmt_telem_exit);

Better to attach to the respective functions.

...

> +#include <linux/intel-dvsec.h>

There is no user of this below, but types.h has users here.

> +/* Telemetry types */
> +#define PMT_TELEM_TELEMETRY    0
> +#define PMT_TELEM_CRASHLOG     1
> +
> +struct telem_header {

> +       u8      access_type;

If it's part of hardware communication, shouldn't be rather __uXX
types to show that this is part of protocol between software and
hardware?

> +       u8      telem_type;
> +       u16     size;
> +       u32     guid;
> +       u32     base_offset;
> +       u8      tbir;
> +};


-- 
With Best Regards,
Andy Shevchenko
