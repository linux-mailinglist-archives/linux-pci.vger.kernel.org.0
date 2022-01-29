Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373814A2A8D
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jan 2022 01:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237054AbiA2AZr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jan 2022 19:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236828AbiA2AZq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jan 2022 19:25:46 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA85FC06173B
        for <linux-pci@vger.kernel.org>; Fri, 28 Jan 2022 16:25:45 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id s61-20020a17090a69c300b001b4d0427ea2so12411236pjj.4
        for <linux-pci@vger.kernel.org>; Fri, 28 Jan 2022 16:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9cOh2EVyB0h1Z9A33mvCkWvJ7o5mEGa4uAPqUzGbsU8=;
        b=RIFsDdpVrDUNRYZsBWhNI4IRS4+aeLiO5yJwILA05LbKKfKktoxXo9h6iUf3Cmk5Mo
         SuQEWAoFk4bkTqC25JLRUnHGH/1Iie0GlO1FvSPeyU1o9iHCdw9RDF+XiixWB7hv8gmp
         HkKO8VoiYo6QconSnKfLbmATCjyMvNS0r5MGZNfVAbDwjW19bJoO3dNNIGM5MOypqK58
         1aDekxtJw9U3gry+bcBPM+jUVUPSB97mlq8rhftgBpLvjNsPZrHv6F/xCPvYtOT1USMg
         V8iDe4uEKBT16seBawP5/M3c5IPPZ4QyrDvBTGd4jPFqlpisMvkO9kNabEljw3VeichT
         dpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9cOh2EVyB0h1Z9A33mvCkWvJ7o5mEGa4uAPqUzGbsU8=;
        b=Dd8kpO4+jrYYuUvEXiAOKFLQI221omA0IF/+KODL7Hx6LzY2JVcQsirzdEq3uucDTT
         Aqqp+5HG3fVVqrkCmHBAEvOLuM9rnde2ghXaBaCmvmdN6tbusBelq36zJFehdBsy2SeO
         Bhv9YELM2Iix/8pEAINrgieLtLcbYKEhzliM254hm8dBrb2oz74PtTSThrUCI2Zp7fFK
         ybWB/sv6EOZ5nhqeF7i1zQOMStH/HZPbPgZrEDoQw5I1SmZiOO+aqJF+8fPwR3lotsq6
         KrJmrabj3lLhVh24BQc+6tPP8z46AS9Z6wHT1d7fqwfhRrKiNMX0l2fQ9pNZO8QKQcPc
         krbQ==
X-Gm-Message-State: AOAM533DUpDPddKsF0KSzBhp6u1vqvFu+rxIt5l1qyfXK09f2Gg9KPBL
        YyEt3bRWSDQVUkXWq7QpSlYNixOFELefXmaFgg5BQgYXkh4gnQ==
X-Google-Smtp-Source: ABdhPJy7EMF8MWAKclq5WfFsBzPisEwmRSDSFx+FWGfbtH9E+XbnZDv/QUSQ37s/ovcSBlKRfusyAhDS+l3vKAtwuPE=
X-Received: by 2002:a17:902:7c15:: with SMTP id x21mr11311794pll.147.1643415944712;
 Fri, 28 Jan 2022 16:25:44 -0800 (PST)
MIME-Version: 1.0
References: <20220128002707.391076-1-ben.widawsky@intel.com> <20220128002707.391076-3-ben.widawsky@intel.com>
In-Reply-To: <20220128002707.391076-3-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 28 Jan 2022 16:25:34 -0800
Message-ID: <CAPcyv4hHJcPLRJM-7z+wKhjBhp9HH2qXuEeC0VfDnD6yU9H-Wg@mail.gmail.com>
Subject: Re: [PATCH v3 02/14] cxl/region: Introduce concept of region configuration
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, patches@lists.linux.dev,
        kernel test robot <lkp@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 27, 2022 at 4:27 PM Ben Widawsky <ben.widawsky@intel.com> wrote=
:
>
> The region creation APIs create a vacant region. Configuring the region
> works in the same way as similar subsystems such as devdax. Sysfs attrs
> will be provided to allow userspace to configure the region.  Finally
> once all configuration is complete, userspace may activate the region.
>
> Introduced here are the most basic attributes needed to configure a
> region. Details of these attribute are described in the ABI

s/attribute/attributes/

> Documentation. Sanity checking of configuration parameters are done at
> region binding time. This consolidates all such logic in one place,
> rather than being strewn across multiple places.

I think that's too late for some of the validation. The complex
validation that the region driver does throughout the topology is
different from the basic input validation that can  be done at the
sysfs write time. For example ,this patch allows negative
interleave_granularity values to specified, just return -EINVAL. I
agree that sysfs should not validate everything, I disagree with
pushing all validation to cxl_region_probe().

>
> A example is provided below:
>
> /sys/bus/cxl/devices/region0.0:0
> =E2=94=9C=E2=94=80=E2=94=80 interleave_granularity
> =E2=94=9C=E2=94=80=E2=94=80 interleave_ways
> =E2=94=9C=E2=94=80=E2=94=80 offset
> =E2=94=9C=E2=94=80=E2=94=80 size
> =E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../../../../../../bus/cxl
> =E2=94=9C=E2=94=80=E2=94=80 target0
> =E2=94=9C=E2=94=80=E2=94=80 uevent
> =E2=94=94=E2=94=80=E2=94=80 uuid

As mentioned off-list, it looks like devtype and modalias are missing.

>
> Reported-by: kernel test robot <lkp@intel.com> (v2)
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |  40 ++++
>  drivers/cxl/core/region.c               | 300 ++++++++++++++++++++++++
>  2 files changed, 340 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/=
testing/sysfs-bus-cxl
> index dcc728458936..50ba5018014d 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -187,3 +187,43 @@ Description:
>                 region driver before being deleted. The attributes expect=
s a
>                 region in the form "regionX.Y:Z". The region's name, allo=
cated
>                 by reading create_region, will also be released.
> +
> +What:          /sys/bus/cxl/devices/decoderX.Y/regionX.Y:Z/offset

This is just another 'resource' attribute for the physical base
address of the region, right? 'offset' sounds like something that
would be relative instead of absolute.

> +Date:          August, 2021

Same date update comment here.

> +KernelVersion: v5.18
> +Contact:       linux-cxl@vger.kernel.org
> +Description:
> +               (RO) A region resides within an address space that is cla=
imed by
> +               a decoder.

"A region is a contiguous partition of a CXL Root decoder address space."

>                  Region space allocation is handled by the driver, but

"Region capacity is allocated by writing to the size attribute, the
resulting physical address base determined by the driver is reflected
here."

> +               the offset may be read by userspace tooling in order to
> +               determine fragmentation, and available size for new regio=
ns.

I would also expect, before / along with these new region attributes,
there would be 'available' and 'max_extent_available' at the decoder
level to indicate how much free space the decoder has and how big the
next region creation can be. User tooling can walk  the decoder and
the regions together to determine fragmentation if necessary, but for
the most part the tool likely only cares about "how big can the next
region be?" and "how full is this decoder?".


> +
> +What:
> +/sys/bus/cxl/devices/decoderX.Y/regionX.Y:Z/{interleave,size,uuid,target=
[0-15]}
> +Date:          August, 2021
> +KernelVersion: v5.18
> +Contact:       linux-cxl@vger.kernel.org
> +Description:
> +               (RW) Configuring regions requires a minimal set of parame=
ters in
> +               order for the subsequent bind operation to succeed. The
> +               following parameters are defined:

Let's split up the descriptions into individual sections. That can
also document the order that attributes must be written. For example,
doesn't size need to be set before targets are added so that targets
can be validated whether they have sufficient capacity?

> +
> +               =3D=3D      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +               interleave_granularity Mandatory. Number of consecutive b=
ytes
> +                       each device in the interleave set will claim. The
> +                       possible interleave granularity values are determ=
ined by
> +                       the CXL spec and the participating devices.
> +               interleave_ways Mandatory. Number of devices participatin=
g in the
> +                       region. Each device will provide 1/interleave of =
storage
> +                       for the region.
> +               size    Manadatory. Phsyical address space the region wil=
l
> +                       consume.

s/Phsyical/Physical/

> +               target  Mandatory. Memory devices are the backing storage=
 for a
> +                       region. There will be N targets based on the numb=
er of
> +                       interleave ways that the top level decoder is con=
figured
> +                       for.

That doesn't sound right, IW at the root !=3D IW at the endpoint level
and the region needs to record all the endpoint level targets.

> Each target must be set with a memdev device ie.
> +                       'mem1'. This attribute only becomes available aft=
er
> +                       setting the 'interleave' attribute.
> +               uuid    Optional. A unique identifier for the region. If =
none is
> +                       selected, the kernel will create one.

Let's drop the Mandatory / Optional distinction, or I am otherwise not
understanding what this is trying to document. For example 'uuid' is
"mandatory" for PMEM regions and "omitted" for volatile regions not
optional.

> +               =3D=3D      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 1a448543db0d..3b48e0469fc7 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3,9 +3,12 @@
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
> +#include <linux/sizes.h>
>  #include <linux/slab.h>
> +#include <linux/uuid.h>
>  #include <linux/idr.h>
>  #include <region.h>
> +#include <cxlmem.h>
>  #include <cxl.h>
>  #include "core.h"
>
> @@ -18,11 +21,305 @@
>   * (programming the hardware) is handled by a separate region driver.
>   */
>
> +struct cxl_region *to_cxl_region(struct device *dev);
> +static const struct attribute_group region_interleave_group;
> +
> +static bool is_region_active(struct cxl_region *cxlr)
> +{
> +       /* TODO: Regions can't be activated yet. */
> +       return false;

This function seems redundant with just checking "cxlr->dev.driver !=3D
NULL"? The benefit of that is there is no need to carry a TODO in the
series.

> +}
> +
> +static void remove_target(struct cxl_region *cxlr, int target)
> +{
> +       struct cxl_memdev *cxlmd;
> +
> +       cxlmd =3D cxlr->config.targets[target];
> +       if (cxlmd)
> +               put_device(&cxlmd->dev);

A memdev can be a member of multiple regions at once, shouldn't this
be an endpoint decoder or similar, not the entire memdev?

Also, if memdevs autoremove themselves from regions at memdev
->remove() time then I don't think the region needs to hold references
on memdevs.

> +       cxlr->config.targets[target] =3D NULL;
> +}
> +
> +static ssize_t interleave_ways_show(struct device *dev,
> +                                   struct device_attribute *attr, char *=
buf)
> +{
> +       struct cxl_region *cxlr =3D to_cxl_region(dev);
> +
> +       return sysfs_emit(buf, "%d\n", cxlr->config.interleave_ways);
> +}
> +
> +static ssize_t interleave_ways_store(struct device *dev,
> +                                    struct device_attribute *attr,
> +                                    const char *buf, size_t len)
> +{
> +       struct cxl_region *cxlr =3D to_cxl_region(dev);
> +       int ret, prev_iw;
> +       int val;

I would expect:

if (dev->driver)
   return -EBUSY;

...to shutdown configuration writes once the region is active. Might
also need a region-wide seqlock like target_list_show. So that region
probe drains  all active sysfs writers before assuming the
configuration is stable.

> +
> +       prev_iw =3D cxlr->config.interleave_ways;
> +       ret =3D kstrtoint(buf, 0, &val);
> +       if (ret)
> +               return ret;
> +       if (ret < 0 || ret > CXL_DECODER_MAX_INTERLEAVE)
> +               return -EINVAL;
> +
> +       cxlr->config.interleave_ways =3D val;
> +
> +       ret =3D sysfs_update_group(&dev->kobj, &region_interleave_group);
> +       if (ret < 0)
> +               goto err;
> +
> +       sysfs_notify(&dev->kobj, NULL, "target_interleave");

Why?

> +
> +       while (prev_iw > cxlr->config.interleave_ways)
> +               remove_target(cxlr, --prev_iw);

To make the kernel side simpler this attribute could just require that
setting interleave ways is a one way street, if you want to change it
you need to delete the region and start over.

> +
> +       return len;
> +
> +err:
> +       cxlr->config.interleave_ways =3D prev_iw;
> +       return ret;
> +}
> +static DEVICE_ATTR_RW(interleave_ways);
> +
> +static ssize_t interleave_granularity_show(struct device *dev,
> +                                          struct device_attribute *attr,
> +                                          char *buf)
> +{
> +       struct cxl_region *cxlr =3D to_cxl_region(dev);
> +
> +       return sysfs_emit(buf, "%d\n", cxlr->config.interleave_granularit=
y);
> +}
> +
> +static ssize_t interleave_granularity_store(struct device *dev,
> +                                           struct device_attribute *attr=
,
> +                                           const char *buf, size_t len)
> +{
> +       struct cxl_region *cxlr =3D to_cxl_region(dev);
> +       int val, ret;
> +
> +       ret =3D kstrtoint(buf, 0, &val);
> +       if (ret)
> +               return ret;
> +       cxlr->config.interleave_granularity =3D val;

This wants minimum input validation and synchronization against an
active region.

> +
> +       return len;
> +}
> +static DEVICE_ATTR_RW(interleave_granularity);
> +
> +static ssize_t offset_show(struct device *dev, struct device_attribute *=
attr,
> +                          char *buf)
> +{
> +       struct cxl_decoder *cxld =3D to_cxl_decoder(dev->parent);
> +       struct cxl_region *cxlr =3D to_cxl_region(dev);
> +       resource_size_t offset;
> +
> +       if (!cxlr->res)
> +               return sysfs_emit(buf, "\n");

Should be an error I would think. I.e. require size to be set before
s/offset/resource/ can be read.

> +
> +       offset =3D cxld->platform_res.start - cxlr->res->start;

Why make usersapce do the offset math?

> +
> +       return sysfs_emit(buf, "%pa\n", &offset);
> +}
> +static DEVICE_ATTR_RO(offset);

This can be DEVICE_ATTR_ADMIN_RO() to hide physical address layout
information from non-root.

> +
> +static ssize_t size_show(struct device *dev, struct device_attribute *at=
tr,
> +                        char *buf)
> +{
> +       struct cxl_region *cxlr =3D to_cxl_region(dev);
> +
> +       return sysfs_emit(buf, "%llu\n", cxlr->config.size);

Perhaps no need to store size separately if this becomes:

sysfs_emit(buf, "%llu\n", (unsigned long long) resource_size(cxlr->res));


...?

> +}
> +
> +static ssize_t size_store(struct device *dev, struct device_attribute *a=
ttr,
> +                         const char *buf, size_t len)
> +{
> +       struct cxl_region *cxlr =3D to_cxl_region(dev);
> +       unsigned long long val;
> +       ssize_t rc;
> +
> +       rc =3D kstrtoull(buf, 0, &val);
> +       if (rc)
> +               return rc;
> +
> +       device_lock(&cxlr->dev);
> +       if (is_region_active(cxlr))
> +               rc =3D -EBUSY;
> +       else
> +               cxlr->config.size =3D val;
> +       device_unlock(&cxlr->dev);

I think lockdep will complain about device_lock() usage in an
attribute. Try changing this to cxl_device_lock() with
CONFIG_PROVE_CXL_LOCKING=3Dy.

> +
> +       return rc ? rc : len;
> +}
> +static DEVICE_ATTR_RW(size);
> +
> +static ssize_t uuid_show(struct device *dev, struct device_attribute *at=
tr,
> +                        char *buf)
> +{
> +       struct cxl_region *cxlr =3D to_cxl_region(dev);
> +
> +       return sysfs_emit(buf, "%pUb\n", &cxlr->config.uuid);
> +}
> +
> +static ssize_t uuid_store(struct device *dev, struct device_attribute *a=
ttr,
> +                         const char *buf, size_t len)
> +{
> +       struct cxl_region *cxlr =3D to_cxl_region(dev);
> +       ssize_t rc;
> +
> +       if (len !=3D UUID_STRING_LEN + 1)
> +               return -EINVAL;
> +
> +       device_lock(&cxlr->dev);
> +       if (is_region_active(cxlr))
> +               rc =3D -EBUSY;
> +       else
> +               rc =3D uuid_parse(buf, &cxlr->config.uuid);
> +       device_unlock(&cxlr->dev);
> +
> +       return rc ? rc : len;
> +}
> +static DEVICE_ATTR_RW(uuid);
> +
> +static struct attribute *region_attrs[] =3D {
> +       &dev_attr_interleave_ways.attr,
> +       &dev_attr_interleave_granularity.attr,
> +       &dev_attr_offset.attr,
> +       &dev_attr_size.attr,
> +       &dev_attr_uuid.attr,
> +       NULL,
> +};
> +
> +static const struct attribute_group region_group =3D {
> +       .attrs =3D region_attrs,
> +};
> +
> +static size_t show_targetN(struct cxl_region *cxlr, char *buf, int n)
> +{
> +       int ret;
> +
> +       device_lock(&cxlr->dev);
> +       if (!cxlr->config.targets[n])
> +               ret =3D sysfs_emit(buf, "\n");
> +       else
> +               ret =3D sysfs_emit(buf, "%s\n",
> +                                dev_name(&cxlr->config.targets[n]->dev))=
;
> +       device_unlock(&cxlr->dev);

The component contribution of a memdev to a region is a DPA-span, not
the whole memdev. I would expect something like dax_mapping_attributes
or REGION_MAPPING() from drivers/nvdimm/region_devs.c. A tuple of
information about the component contribution of a memdev to a region.

> +
> +       return ret;
> +}
> +
> +static size_t set_targetN(struct cxl_region *cxlr, const char *buf, int =
n,
> +                         size_t len)
> +{
> +       struct device *memdev_dev;
> +       struct cxl_memdev *cxlmd;
> +
> +       device_lock(&cxlr->dev);
> +
> +       if (len =3D=3D 1 || cxlr->config.targets[n])
> +               remove_target(cxlr, n);
> +
> +       /* Remove target special case */
> +       if (len =3D=3D 1) {
> +               device_unlock(&cxlr->dev);
> +               return len;
> +       }
> +
> +       memdev_dev =3D bus_find_device_by_name(&cxl_bus_type, NULL, buf);

I think this wants to be an endpoint decoder, not a memdev. Because
it's the decoder that joins a memdev to a region, or at least a
decoder should be picked when the memdev is assigned so that the DPA
mapping can be registered. If all the decoders are allocated then fail
here.

> +       if (!memdev_dev) {
> +               device_unlock(&cxlr->dev);
> +               return -ENOENT;
> +       }
> +
> +       /* reference to memdev held until target is unset or region goes =
away */
> +
> +       cxlmd =3D to_cxl_memdev(memdev_dev);
> +       cxlr->config.targets[n] =3D cxlmd;
> +
> +       device_unlock(&cxlr->dev);
> +
> +       return len;
> +}
> +
> +#define TARGET_ATTR_RW(n)                                               =
       \
> +       static ssize_t target##n##_show(                                 =
      \
> +               struct device *dev, struct device_attribute *attr, char *=
buf)  \
> +       {                                                                =
      \
> +               return show_targetN(to_cxl_region(dev), buf, (n));       =
      \
> +       }                                                                =
      \
> +       static ssize_t target##n##_store(struct device *dev,             =
      \
> +                                        struct device_attribute *attr,  =
      \
> +                                        const char *buf, size_t len)    =
      \
> +       {                                                                =
      \
> +               return set_targetN(to_cxl_region(dev), buf, (n), len);   =
      \
> +       }                                                                =
      \
> +       static DEVICE_ATTR_RW(target##n)
> +
> +TARGET_ATTR_RW(0);
> +TARGET_ATTR_RW(1);
> +TARGET_ATTR_RW(2);
> +TARGET_ATTR_RW(3);
> +TARGET_ATTR_RW(4);
> +TARGET_ATTR_RW(5);
> +TARGET_ATTR_RW(6);
> +TARGET_ATTR_RW(7);
> +TARGET_ATTR_RW(8);
> +TARGET_ATTR_RW(9);
> +TARGET_ATTR_RW(10);
> +TARGET_ATTR_RW(11);
> +TARGET_ATTR_RW(12);
> +TARGET_ATTR_RW(13);
> +TARGET_ATTR_RW(14);
> +TARGET_ATTR_RW(15);
> +
> +static struct attribute *interleave_attrs[] =3D {
> +       &dev_attr_target0.attr,
> +       &dev_attr_target1.attr,
> +       &dev_attr_target2.attr,
> +       &dev_attr_target3.attr,
> +       &dev_attr_target4.attr,
> +       &dev_attr_target5.attr,
> +       &dev_attr_target6.attr,
> +       &dev_attr_target7.attr,
> +       &dev_attr_target8.attr,
> +       &dev_attr_target9.attr,
> +       &dev_attr_target10.attr,
> +       &dev_attr_target11.attr,
> +       &dev_attr_target12.attr,
> +       &dev_attr_target13.attr,
> +       &dev_attr_target14.attr,
> +       &dev_attr_target15.attr,
> +       NULL,
> +};
> +
> +static umode_t visible_targets(struct kobject *kobj, struct attribute *a=
, int n)
> +{
> +       struct device *dev =3D container_of(kobj, struct device, kobj);
> +       struct cxl_region *cxlr =3D to_cxl_region(dev);
> +
> +       if (n < cxlr->config.interleave_ways)
> +               return a->mode;
> +       return 0;
> +}
> +
> +static const struct attribute_group region_interleave_group =3D {
> +       .attrs =3D interleave_attrs,
> +       .is_visible =3D visible_targets,
> +};
> +
> +static const struct attribute_group *region_groups[] =3D {
> +       &region_group,
> +       &region_interleave_group,
> +       NULL,
> +};
> +
>  static void cxl_region_release(struct device *dev);
>
>  static const struct device_type cxl_region_type =3D {
>         .name =3D "cxl_region",
>         .release =3D cxl_region_release,
> +       .groups =3D region_groups
>  };
>
>  static ssize_t create_region_show(struct device *dev,
> @@ -108,8 +405,11 @@ static void cxl_region_release(struct device *dev)
>  {
>         struct cxl_decoder *cxld =3D to_cxl_decoder(dev->parent);
>         struct cxl_region *cxlr =3D to_cxl_region(dev);
> +       int i;
>
>         ida_free(&cxld->region_ida, cxlr->id);
> +       for (i =3D 0; i < cxlr->config.interleave_ways; i++)
> +               remove_target(cxlr, i);

Like the last patch this feels too late. I expect whatever unregisters
the region should have already handled removing the targets.

>         kfree(cxlr);
>  }
>
> --
> 2.35.0
>
