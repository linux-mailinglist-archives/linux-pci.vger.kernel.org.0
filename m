Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67BA4A6862
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 00:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242753AbiBAXLW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 18:11:22 -0500
Received: from mga04.intel.com ([192.55.52.120]:3388 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbiBAXLU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 18:11:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643757080; x=1675293080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xB74PCTiG3B6GgKTfF9NXZ8EDHyHVjhCGN4iA6byXqk=;
  b=kkHrszP/GQ3wl22NzORbauBVY7/g3jXpPxjPfWkd4FEKjIx83D5a1eKd
   yoTU44I4jzvYTVY1+FYFxbIrfteURA7FIRoZj7E1Ze+Mbfcd6JRdKY7cQ
   vT9drBZA9EJwFkDqOomAjkbk91mJRhK7zZ8XS/UXIBKH+XmHyRukYoodM
   slIGKLDYD8yxinMrX16+9BpCzd1kxchiLhE28FRp1Sf9IsTqdVDRlix7r
   gWhK094ZJdPHewHulfueBEO3TKpu0A6a5RJMpoOVUPF4PPOXXfW+JhoTr
   UUyykLskFpHNzV/7URFyt6gms3GR+XzMUnZZ0BjgukikzONGva9RACGjm
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="246646736"
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="246646736"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 15:11:19 -0800
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="538026836"
Received: from aphan2-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.131.48])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 15:11:18 -0800
Date:   Tue, 1 Feb 2022 15:11:17 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, patches@lists.linux.dev,
        kernel test robot <lkp@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 02/14] cxl/region: Introduce concept of region
 configuration
Message-ID: <20220201231117.lksqoukbvss6e3ec@intel.com>
References: <20220128002707.391076-1-ben.widawsky@intel.com>
 <20220128002707.391076-3-ben.widawsky@intel.com>
 <CAPcyv4hHJcPLRJM-7z+wKhjBhp9HH2qXuEeC0VfDnD6yU9H-Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPcyv4hHJcPLRJM-7z+wKhjBhp9HH2qXuEeC0VfDnD6yU9H-Wg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-01-28 16:25:34, Dan Williams wrote:
> On Thu, Jan 27, 2022 at 4:27 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > The region creation APIs create a vacant region. Configuring the region
> > works in the same way as similar subsystems such as devdax. Sysfs attrs
> > will be provided to allow userspace to configure the region.  Finally
> > once all configuration is complete, userspace may activate the region.
> >
> > Introduced here are the most basic attributes needed to configure a
> > region. Details of these attribute are described in the ABI
> 
> s/attribute/attributes/
> 
> > Documentation. Sanity checking of configuration parameters are done at
> > region binding time. This consolidates all such logic in one place,
> > rather than being strewn across multiple places.
> 
> I think that's too late for some of the validation. The complex
> validation that the region driver does throughout the topology is
> different from the basic input validation that can  be done at the
> sysfs write time. For example ,this patch allows negative
> interleave_granularity values to specified, just return -EINVAL. I
> agree that sysfs should not validate everything, I disagree with
> pushing all validation to cxl_region_probe().
> 

Two points:c
1. How do we distinguish "basic input validation". It'd be good if we could
   define "basic input validation". For instance, when I first wrote these
   patches, x3 would have been EINVAL, but today it's allowed. Can you help
   enumerate what you consider basic.

2. I like the idea that all validation takes place in one place. Obviously you
   do not. So, see #1 and I will rework.

> >
> > A example is provided below:
> >
> > /sys/bus/cxl/devices/region0.0:0
> > ├── interleave_granularity
> > ├── interleave_ways
> > ├── offset
> > ├── size
> > ├── subsystem -> ../../../../../../bus/cxl
> > ├── target0
> > ├── uevent
> > └── uuid
> 
> As mentioned off-list, it looks like devtype and modalias are missing.
> 

Thanks.

> >
> > Reported-by: kernel test robot <lkp@intel.com> (v2)
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl |  40 ++++
> >  drivers/cxl/core/region.c               | 300 ++++++++++++++++++++++++
> >  2 files changed, 340 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > index dcc728458936..50ba5018014d 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -187,3 +187,43 @@ Description:
> >                 region driver before being deleted. The attributes expects a
> >                 region in the form "regionX.Y:Z". The region's name, allocated
> >                 by reading create_region, will also be released.
> > +
> > +What:          /sys/bus/cxl/devices/decoderX.Y/regionX.Y:Z/offset
> 
> This is just another 'resource' attribute for the physical base
> address of the region, right? 'offset' sounds like something that
> would be relative instead of absolute.
> 

It is offset. I can change it to physical base if you'd like but I thought that
information wasn't critically important for userspace to have. Does userspace
care about the physical base?

> > +Date:          August, 2021
> 
> Same date update comment here.
> 
> > +KernelVersion: v5.18
> > +Contact:       linux-cxl@vger.kernel.org
> > +Description:
> > +               (RO) A region resides within an address space that is claimed by
> > +               a decoder.
> 
> "A region is a contiguous partition of a CXL Root decoder address space."
> 
> >                  Region space allocation is handled by the driver, but
> 
> "Region capacity is allocated by writing to the size attribute, the
> resulting physical address base determined by the driver is reflected
> here."
> 
> > +               the offset may be read by userspace tooling in order to
> > +               determine fragmentation, and available size for new regions.
> 
> I would also expect, before / along with these new region attributes,
> there would be 'available' and 'max_extent_available' at the decoder
> level to indicate how much free space the decoder has and how big the
> next region creation can be. User tooling can walk  the decoder and
> the regions together to determine fragmentation if necessary, but for
> the most part the tool likely only cares about "how big can the next
> region be?" and "how full is this decoder?".

Sounds good.

> 
> 
> > +
> > +What:
> > +/sys/bus/cxl/devices/decoderX.Y/regionX.Y:Z/{interleave,size,uuid,target[0-15]}
> > +Date:          August, 2021
> > +KernelVersion: v5.18
> > +Contact:       linux-cxl@vger.kernel.org
> > +Description:
> > +               (RW) Configuring regions requires a minimal set of parameters in
> > +               order for the subsequent bind operation to succeed. The
> > +               following parameters are defined:
> 
> Let's split up the descriptions into individual sections. That can
> also document the order that attributes must be written. For example,
> doesn't size need to be set before targets are added so that targets
> can be validated whether they have sufficient capacity?
> 

Okay. Order doesn't matter if you do validation all in one place as it is, but
sounds like we're changing that. So I can split it when we figure out what
validation is actually occurring at the sysfs attr boundary.

> > +
> > +               ==      ========================================================
> > +               interleave_granularity Mandatory. Number of consecutive bytes
> > +                       each device in the interleave set will claim. The
> > +                       possible interleave granularity values are determined by
> > +                       the CXL spec and the participating devices.
> > +               interleave_ways Mandatory. Number of devices participating in the
> > +                       region. Each device will provide 1/interleave of storage
> > +                       for the region.
> > +               size    Manadatory. Phsyical address space the region will
> > +                       consume.
> 
> s/Phsyical/Physical/
> 
> > +               target  Mandatory. Memory devices are the backing storage for a
> > +                       region. There will be N targets based on the number of
> > +                       interleave ways that the top level decoder is configured
> > +                       for.
> 
> That doesn't sound right, IW at the root != IW at the endpoint level
> and the region needs to record all the endpoint level targets.


Yes This is wrong. I thought I had fixed it, but I guess not.

> 
> > Each target must be set with a memdev device ie.
> > +                       'mem1'. This attribute only becomes available after
> > +                       setting the 'interleave' attribute.
> > +               uuid    Optional. A unique identifier for the region. If none is
> > +                       selected, the kernel will create one.
> 
> Let's drop the Mandatory / Optional distinction, or I am otherwise not
> understanding what this is trying to document. For example 'uuid' is
> "mandatory" for PMEM regions and "omitted" for volatile regions not
> optional.
> 

Well the kernel fills it in if userspace leaves it out. I'm guessing you're
going to ask me to change that, so I will remove Mandatory/Optional.

> > +               ==      ========================================================
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 1a448543db0d..3b48e0469fc7 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -3,9 +3,12 @@
> >  #include <linux/io-64-nonatomic-lo-hi.h>
> >  #include <linux/device.h>
> >  #include <linux/module.h>
> > +#include <linux/sizes.h>
> >  #include <linux/slab.h>
> > +#include <linux/uuid.h>
> >  #include <linux/idr.h>
> >  #include <region.h>
> > +#include <cxlmem.h>
> >  #include <cxl.h>
> >  #include "core.h"
> >
> > @@ -18,11 +21,305 @@
> >   * (programming the hardware) is handled by a separate region driver.
> >   */
> >
> > +struct cxl_region *to_cxl_region(struct device *dev);
> > +static const struct attribute_group region_interleave_group;
> > +
> > +static bool is_region_active(struct cxl_region *cxlr)
> > +{
> > +       /* TODO: Regions can't be activated yet. */
> > +       return false;
> 
> This function seems redundant with just checking "cxlr->dev.driver !=
> NULL"? The benefit of that is there is no need to carry a TODO in the
> series.
> 

Yeah. I think checking driver bind status is sufficient to replace this.

> > +}
> > +
> > +static void remove_target(struct cxl_region *cxlr, int target)
> > +{
> > +       struct cxl_memdev *cxlmd;
> > +
> > +       cxlmd = cxlr->config.targets[target];
> > +       if (cxlmd)
> > +               put_device(&cxlmd->dev);
> 
> A memdev can be a member of multiple regions at once, shouldn't this
> be an endpoint decoder or similar, not the entire memdev?

Is this referring to the later question about whether targets are decoders or
memdevs? The thought was each region would hold a reference to all memdevs in
the interleave set.

> 
> Also, if memdevs autoremove themselves from regions at memdev
> ->remove() time then I don't think the region needs to hold references
> on memdevs.
> 

I'll defer to you on that. I'll remove holding the reference, but I definitely
haven't solved the interaction when a memdev goes away. I had been thinking the
inverse originally, a memdev can't go away until the region is gone. According
to the spec, these devices can't be hot removed, only managed remove, so if
things blew up, not our problem. However, if we have decent infrastructure to
support better than that, we should.

> > +       cxlr->config.targets[target] = NULL;
> > +}
> > +
> > +static ssize_t interleave_ways_show(struct device *dev,
> > +                                   struct device_attribute *attr, char *buf)
> > +{
> > +       struct cxl_region *cxlr = to_cxl_region(dev);
> > +
> > +       return sysfs_emit(buf, "%d\n", cxlr->config.interleave_ways);
> > +}
> > +
> > +static ssize_t interleave_ways_store(struct device *dev,
> > +                                    struct device_attribute *attr,
> > +                                    const char *buf, size_t len)
> > +{
> > +       struct cxl_region *cxlr = to_cxl_region(dev);
> > +       int ret, prev_iw;
> > +       int val;
> 
> I would expect:
> 
> if (dev->driver)
>    return -EBUSY;
> 
> ...to shutdown configuration writes once the region is active. Might
> also need a region-wide seqlock like target_list_show. So that region
> probe drains  all active sysfs writers before assuming the
> configuration is stable.
> 

Okay.

> > +
> > +       prev_iw = cxlr->config.interleave_ways;
> > +       ret = kstrtoint(buf, 0, &val);
> > +       if (ret)
> > +               return ret;
> > +       if (ret < 0 || ret > CXL_DECODER_MAX_INTERLEAVE)
> > +               return -EINVAL;
> > +
> > +       cxlr->config.interleave_ways = val;
> > +
> > +       ret = sysfs_update_group(&dev->kobj, &region_interleave_group);
> > +       if (ret < 0)
> > +               goto err;
> > +
> > +       sysfs_notify(&dev->kobj, NULL, "target_interleave");
> 
> Why?
> 

I copied it from another driver. I didn't check if it was actually needed or
not.

> > +
> > +       while (prev_iw > cxlr->config.interleave_ways)
> > +               remove_target(cxlr, --prev_iw);
> 
> To make the kernel side simpler this attribute could just require that
> setting interleave ways is a one way street, if you want to change it
> you need to delete the region and start over.
> 

I'm fine with that.

> > +
> > +       return len;
> > +
> > +err:
> > +       cxlr->config.interleave_ways = prev_iw;
> > +       return ret;
> > +}
> > +static DEVICE_ATTR_RW(interleave_ways);
> > +
> > +static ssize_t interleave_granularity_show(struct device *dev,
> > +                                          struct device_attribute *attr,
> > +                                          char *buf)
> > +{
> > +       struct cxl_region *cxlr = to_cxl_region(dev);
> > +
> > +       return sysfs_emit(buf, "%d\n", cxlr->config.interleave_granularity);
> > +}
> > +
> > +static ssize_t interleave_granularity_store(struct device *dev,
> > +                                           struct device_attribute *attr,
> > +                                           const char *buf, size_t len)
> > +{
> > +       struct cxl_region *cxlr = to_cxl_region(dev);
> > +       int val, ret;
> > +
> > +       ret = kstrtoint(buf, 0, &val);
> > +       if (ret)
> > +               return ret;
> > +       cxlr->config.interleave_granularity = val;
> 
> This wants minimum input validation and synchronization against an
> active region.
> 
> > +
> > +       return len;
> > +}
> > +static DEVICE_ATTR_RW(interleave_granularity);
> > +
> > +static ssize_t offset_show(struct device *dev, struct device_attribute *attr,
> > +                          char *buf)
> > +{
> > +       struct cxl_decoder *cxld = to_cxl_decoder(dev->parent);
> > +       struct cxl_region *cxlr = to_cxl_region(dev);
> > +       resource_size_t offset;
> > +
> > +       if (!cxlr->res)
> > +               return sysfs_emit(buf, "\n");
> 
> Should be an error I would think. I.e. require size to be set before
> s/offset/resource/ can be read.
> 
> > +
> > +       offset = cxld->platform_res.start - cxlr->res->start;
> 
> Why make usersapce do the offset math?
> 
> > +
> > +       return sysfs_emit(buf, "%pa\n", &offset);
> > +}
> > +static DEVICE_ATTR_RO(offset);
> 
> This can be DEVICE_ATTR_ADMIN_RO() to hide physical address layout
> information from non-root.
> 
> > +
> > +static ssize_t size_show(struct device *dev, struct device_attribute *attr,
> > +                        char *buf)
> > +{
> > +       struct cxl_region *cxlr = to_cxl_region(dev);
> > +
> > +       return sysfs_emit(buf, "%llu\n", cxlr->config.size);
> 
> Perhaps no need to store size separately if this becomes:
> 
> sysfs_emit(buf, "%llu\n", (unsigned long long) resource_size(cxlr->res));
> 
> 
> ...?
> 
> > +}
> > +
> > +static ssize_t size_store(struct device *dev, struct device_attribute *attr,
> > +                         const char *buf, size_t len)
> > +{
> > +       struct cxl_region *cxlr = to_cxl_region(dev);
> > +       unsigned long long val;
> > +       ssize_t rc;
> > +
> > +       rc = kstrtoull(buf, 0, &val);
> > +       if (rc)
> > +               return rc;
> > +
> > +       device_lock(&cxlr->dev);
> > +       if (is_region_active(cxlr))
> > +               rc = -EBUSY;
> > +       else
> > +               cxlr->config.size = val;
> > +       device_unlock(&cxlr->dev);
> 
> I think lockdep will complain about device_lock() usage in an
> attribute. Try changing this to cxl_device_lock() with
> CONFIG_PROVE_CXL_LOCKING=y.
> 
> > +
> > +       return rc ? rc : len;
> > +}
> > +static DEVICE_ATTR_RW(size);
> > +
> > +static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
> > +                        char *buf)
> > +{
> > +       struct cxl_region *cxlr = to_cxl_region(dev);
> > +
> > +       return sysfs_emit(buf, "%pUb\n", &cxlr->config.uuid);
> > +}
> > +
> > +static ssize_t uuid_store(struct device *dev, struct device_attribute *attr,
> > +                         const char *buf, size_t len)
> > +{
> > +       struct cxl_region *cxlr = to_cxl_region(dev);
> > +       ssize_t rc;
> > +
> > +       if (len != UUID_STRING_LEN + 1)
> > +               return -EINVAL;
> > +
> > +       device_lock(&cxlr->dev);
> > +       if (is_region_active(cxlr))
> > +               rc = -EBUSY;
> > +       else
> > +               rc = uuid_parse(buf, &cxlr->config.uuid);
> > +       device_unlock(&cxlr->dev);
> > +
> > +       return rc ? rc : len;
> > +}
> > +static DEVICE_ATTR_RW(uuid);
> > +
> > +static struct attribute *region_attrs[] = {
> > +       &dev_attr_interleave_ways.attr,
> > +       &dev_attr_interleave_granularity.attr,
> > +       &dev_attr_offset.attr,
> > +       &dev_attr_size.attr,
> > +       &dev_attr_uuid.attr,
> > +       NULL,
> > +};
> > +
> > +static const struct attribute_group region_group = {
> > +       .attrs = region_attrs,
> > +};
> > +
> > +static size_t show_targetN(struct cxl_region *cxlr, char *buf, int n)
> > +{
> > +       int ret;
> > +
> > +       device_lock(&cxlr->dev);
> > +       if (!cxlr->config.targets[n])
> > +               ret = sysfs_emit(buf, "\n");
> > +       else
> > +               ret = sysfs_emit(buf, "%s\n",
> > +                                dev_name(&cxlr->config.targets[n]->dev));
> > +       device_unlock(&cxlr->dev);
> 
> The component contribution of a memdev to a region is a DPA-span, not
> the whole memdev. I would expect something like dax_mapping_attributes
> or REGION_MAPPING() from drivers/nvdimm/region_devs.c. A tuple of
> information about the component contribution of a memdev to a region.
> 

I had been thinking the kernel would manage the DPS spans of a memdev (and
create the mappings). I can make this look like dax_mapping_attributes.

> > +
> > +       return ret;
> > +}
> > +
> > +static size_t set_targetN(struct cxl_region *cxlr, const char *buf, int n,
> > +                         size_t len)
> > +{
> > +       struct device *memdev_dev;
> > +       struct cxl_memdev *cxlmd;
> > +
> > +       device_lock(&cxlr->dev);
> > +
> > +       if (len == 1 || cxlr->config.targets[n])
> > +               remove_target(cxlr, n);
> > +
> > +       /* Remove target special case */
> > +       if (len == 1) {
> > +               device_unlock(&cxlr->dev);
> > +               return len;
> > +       }
> > +
> > +       memdev_dev = bus_find_device_by_name(&cxl_bus_type, NULL, buf);
> 
> I think this wants to be an endpoint decoder, not a memdev. Because
> it's the decoder that joins a memdev to a region, or at least a
> decoder should be picked when the memdev is assigned so that the DPA
> mapping can be registered. If all the decoders are allocated then fail
> here.
> 

My preference is obviously how it is, using memdevs and having the decoders
allocated at bind time. I don't have an objective argument why one is better
than the other so I will change it. I will make the interface take a set of
decoders.

> > +       if (!memdev_dev) {
> > +               device_unlock(&cxlr->dev);
> > +               return -ENOENT;
> > +       }
> > +
> > +       /* reference to memdev held until target is unset or region goes away */
> > +
> > +       cxlmd = to_cxl_memdev(memdev_dev);
> > +       cxlr->config.targets[n] = cxlmd;
> > +
> > +       device_unlock(&cxlr->dev);
> > +
> > +       return len;
> > +}
> > +
> > +#define TARGET_ATTR_RW(n)                                                      \
> > +       static ssize_t target##n##_show(                                       \
> > +               struct device *dev, struct device_attribute *attr, char *buf)  \
> > +       {                                                                      \
> > +               return show_targetN(to_cxl_region(dev), buf, (n));             \
> > +       }                                                                      \
> > +       static ssize_t target##n##_store(struct device *dev,                   \
> > +                                        struct device_attribute *attr,        \
> > +                                        const char *buf, size_t len)          \
> > +       {                                                                      \
> > +               return set_targetN(to_cxl_region(dev), buf, (n), len);         \
> > +       }                                                                      \
> > +       static DEVICE_ATTR_RW(target##n)
> > +
> > +TARGET_ATTR_RW(0);
> > +TARGET_ATTR_RW(1);
> > +TARGET_ATTR_RW(2);
> > +TARGET_ATTR_RW(3);
> > +TARGET_ATTR_RW(4);
> > +TARGET_ATTR_RW(5);
> > +TARGET_ATTR_RW(6);
> > +TARGET_ATTR_RW(7);
> > +TARGET_ATTR_RW(8);
> > +TARGET_ATTR_RW(9);
> > +TARGET_ATTR_RW(10);
> > +TARGET_ATTR_RW(11);
> > +TARGET_ATTR_RW(12);
> > +TARGET_ATTR_RW(13);
> > +TARGET_ATTR_RW(14);
> > +TARGET_ATTR_RW(15);
> > +
> > +static struct attribute *interleave_attrs[] = {
> > +       &dev_attr_target0.attr,
> > +       &dev_attr_target1.attr,
> > +       &dev_attr_target2.attr,
> > +       &dev_attr_target3.attr,
> > +       &dev_attr_target4.attr,
> > +       &dev_attr_target5.attr,
> > +       &dev_attr_target6.attr,
> > +       &dev_attr_target7.attr,
> > +       &dev_attr_target8.attr,
> > +       &dev_attr_target9.attr,
> > +       &dev_attr_target10.attr,
> > +       &dev_attr_target11.attr,
> > +       &dev_attr_target12.attr,
> > +       &dev_attr_target13.attr,
> > +       &dev_attr_target14.attr,
> > +       &dev_attr_target15.attr,
> > +       NULL,
> > +};
> > +
> > +static umode_t visible_targets(struct kobject *kobj, struct attribute *a, int n)
> > +{
> > +       struct device *dev = container_of(kobj, struct device, kobj);
> > +       struct cxl_region *cxlr = to_cxl_region(dev);
> > +
> > +       if (n < cxlr->config.interleave_ways)
> > +               return a->mode;
> > +       return 0;
> > +}
> > +
> > +static const struct attribute_group region_interleave_group = {
> > +       .attrs = interleave_attrs,
> > +       .is_visible = visible_targets,
> > +};
> > +
> > +static const struct attribute_group *region_groups[] = {
> > +       &region_group,
> > +       &region_interleave_group,
> > +       NULL,
> > +};
> > +
> >  static void cxl_region_release(struct device *dev);
> >
> >  static const struct device_type cxl_region_type = {
> >         .name = "cxl_region",
> >         .release = cxl_region_release,
> > +       .groups = region_groups
> >  };
> >
> >  static ssize_t create_region_show(struct device *dev,
> > @@ -108,8 +405,11 @@ static void cxl_region_release(struct device *dev)
> >  {
> >         struct cxl_decoder *cxld = to_cxl_decoder(dev->parent);
> >         struct cxl_region *cxlr = to_cxl_region(dev);
> > +       int i;
> >
> >         ida_free(&cxld->region_ida, cxlr->id);
> > +       for (i = 0; i < cxlr->config.interleave_ways; i++)
> > +               remove_target(cxlr, i);
> 
> Like the last patch this feels too late. I expect whatever unregisters
> the region should have already handled removing the targets.
> 

I think I already explained why it works this way. I will change it.

> >         kfree(cxlr);
> >  }
> >
> > --
> > 2.35.0
> >
