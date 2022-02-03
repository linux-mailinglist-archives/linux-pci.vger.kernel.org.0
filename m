Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712A34A909C
	for <lists+linux-pci@lfdr.de>; Thu,  3 Feb 2022 23:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238600AbiBCWXI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 17:23:08 -0500
Received: from mga06.intel.com ([134.134.136.31]:18353 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229910AbiBCWXH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Feb 2022 17:23:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643926987; x=1675462987;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7X+HO5Vi7bruQ6V26wftxg+qzEP/H2WFAebk1UK7gdc=;
  b=aQvtR86xwXO/ekD1wot1A78ogld4xQNLeJaYNu99DEryjbyRxmZW1dU+
   QKha5My1xKrvWsyXR4LE2b/IHBWB91TMjB8Nto/GqvJvnWeS8sT5va0bV
   /KmprjMMRK9IiwssDUEhhGJz1/fLUJPg9xug3ELM0lGj9CqH6aKS9xh+G
   Y93f+/2lRgUzLDejAqqpBA1NoHyjN30TzP8kMe5pR4ESCg+gfPqwaaxZz
   8aVzW8+94nWeNlTxTnKxqspQFBVnAh8yxp7d0+n2iUhh1pEmU//e11X44
   89shzR+AMOUq6kHAtgE55WYJsIOBwix8iRzUWCDN0Z6G2Xnf62fpjsBSu
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="309003129"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="309003129"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 14:23:03 -0800
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="535361825"
Received: from ssuh1-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.132.201])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 14:23:02 -0800
Date:   Thu, 3 Feb 2022 14:23:00 -0800
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
Message-ID: <20220203222300.gf4st36yoqjxq5q6@intel.com>
References: <20220128002707.391076-1-ben.widawsky@intel.com>
 <20220128002707.391076-3-ben.widawsky@intel.com>
 <CAPcyv4hHJcPLRJM-7z+wKhjBhp9HH2qXuEeC0VfDnD6yU9H-Wg@mail.gmail.com>
 <20220201231117.lksqoukbvss6e3ec@intel.com>
 <CAPcyv4iGQWXX8rzCH7BJUSyvDXbdiuHw4kLiuqGmVVBGTh2a1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPcyv4iGQWXX8rzCH7BJUSyvDXbdiuHw4kLiuqGmVVBGTh2a1Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-02-03 09:48:49, Dan Williams wrote:
> On Tue, Feb 1, 2022 at 3:11 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > On 22-01-28 16:25:34, Dan Williams wrote:
> > > On Thu, Jan 27, 2022 at 4:27 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > >
> > > > The region creation APIs create a vacant region. Configuring the region
> > > > works in the same way as similar subsystems such as devdax. Sysfs attrs
> > > > will be provided to allow userspace to configure the region.  Finally
> > > > once all configuration is complete, userspace may activate the region.
> > > >
> > > > Introduced here are the most basic attributes needed to configure a
> > > > region. Details of these attribute are described in the ABI
> > >
> > > s/attribute/attributes/
> > >
> > > > Documentation. Sanity checking of configuration parameters are done at
> > > > region binding time. This consolidates all such logic in one place,
> > > > rather than being strewn across multiple places.
> > >
> > > I think that's too late for some of the validation. The complex
> > > validation that the region driver does throughout the topology is
> > > different from the basic input validation that can  be done at the
> > > sysfs write time. For example ,this patch allows negative
> > > interleave_granularity values to specified, just return -EINVAL. I
> > > agree that sysfs should not validate everything, I disagree with
> > > pushing all validation to cxl_region_probe().
> > >
> >
> > Two points:c
> > 1. How do we distinguish "basic input validation". It'd be good if we could
> >    define "basic input validation". For instance, when I first wrote these
> >    patches, x3 would have been EINVAL, but today it's allowed. Can you help
> >    enumerate what you consider basic.
> 
> I internalized this kernel design principle from Dave Miller many
> years ago paraphrasing "push decision making out to leaf code as much
> as possible", and centralizing all validation in cxl_region_probe()
> violates. The software that makes the mistake does not know it made a
> mistake until much later and "probe failed" is less descriptive than
> "EINVAL writing interleave_ways" . I wish I could find the thread
> because it also talked about his iteration process.

It would definitely be interesting to understand why pushing decision making
into the leaf code is a violation. Was it primary around the descriptiveness of
the error?

> 
> Basic input validation to me is things like:
> 
> - Don't allow writes while the region is active
> - Check that values are in bound. So yes, the interleave-ways value of
> 3 would fail until the kernel supports it, and granularity values >
> 16K would also fail.
> - Check that memdevs are actually downstream targets of the given decoder
> - Check that the region uuid is unique

These are obviously easy and informative at attr store time (in fact, active was
meant to be checked already for many cases). So if we agree to codify this at
probe via WARN, and add it to kdoc, I've no problem with it.

> - Check that decoder has capacity
> - Check that the memdev has capacity
> - Check that the decoder to map the DPA is actually available given
> decoders must be programmed in increasing DPA order
> 
> Essentially any validation short of walking the topology to program
> upstream decoders since those errors are only resolved by racing
> region probes that try to grab upstream decoder resources.
> 

I intentionally avoided doing a lot of these until probe because it seemed like
not a great policy to deny regions from being populated if another region
utilizing those resources hasn't been bound yes. For a simple example, if x1
region A is created and utilizes all of memdev ɑ's capacity you block out any
other region setup using memdev ɑ, even if region A wasn't bound. There's a
similar problem with specifying decoders as part of configuration.

I'll infer from your comment that you are fine with this tradeoff, or you have
some other way to manage this in mind.

I really see any validation which requires removal of resources from the system
to be more fit for bind time. I suppose if the proposal is to move the region
attributes to be DEVICE_ATTR_ADMIN, that pushes the problem onto the system
administrator. It just seemed like most of the interface could be non-root.

> >
> > 2. I like the idea that all validation takes place in one place. Obviously you
> >    do not. So, see #1 and I will rework.
> 
> The validation helpers need to be written once, where they are called
> does not much matter, does it?
> 

Somewhat addressed above too...

I think that depends on whether the full list is established as mentioned. If in
the region driver we can put several assertions that a variety of things don't
need [re]validation, then it doesn't matter. Without this, when trying to debug
or add code you need to figure out which place is doing the validation and which
place should do it.

At the very least I think the plan should be established in a kdoc.

> >
> > > >
> > > > A example is provided below:
> > > >
> > > > /sys/bus/cxl/devices/region0.0:0
> > > > ├── interleave_granularity
> > > > ├── interleave_ways
> > > > ├── offset
> > > > ├── size
> > > > ├── subsystem -> ../../../../../../bus/cxl
> > > > ├── target0
> > > > ├── uevent
> > > > └── uuid
> > >
> > > As mentioned off-list, it looks like devtype and modalias are missing.
> > >
> >
> > Thanks.
> >
> > > >
> > > > Reported-by: kernel test robot <lkp@intel.com> (v2)
> > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > > ---
> > > >  Documentation/ABI/testing/sysfs-bus-cxl |  40 ++++
> > > >  drivers/cxl/core/region.c               | 300 ++++++++++++++++++++++++
> > > >  2 files changed, 340 insertions(+)
> > > >
> > > > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > > > index dcc728458936..50ba5018014d 100644
> > > > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > > > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > > > @@ -187,3 +187,43 @@ Description:
> > > >                 region driver before being deleted. The attributes expects a
> > > >                 region in the form "regionX.Y:Z". The region's name, allocated
> > > >                 by reading create_region, will also be released.
> > > > +
> > > > +What:          /sys/bus/cxl/devices/decoderX.Y/regionX.Y:Z/offset
> > >
> > > This is just another 'resource' attribute for the physical base
> > > address of the region, right? 'offset' sounds like something that
> > > would be relative instead of absolute.
> > >
> >
> > It is offset. I can change it to physical base if you'd like but I thought that
> > information wasn't critically important for userspace to have. Does userspace
> > care about the physical base?
> 
> Yes, similar use case as /proc/iomem. Error handling comes to mind as
> you can see physical address data in the messages like machine check
> notification and go immediately match that to a CXL region. PCI,
> NVDIMM, and DAX all emit a "resource" attribute to identify the
> physical address base.
> 
> >
> > > > +Date:          August, 2021
> > >
> > > Same date update comment here.
> > >
> > > > +KernelVersion: v5.18
> > > > +Contact:       linux-cxl@vger.kernel.org
> > > > +Description:
> > > > +               (RO) A region resides within an address space that is claimed by
> > > > +               a decoder.
> > >
> > > "A region is a contiguous partition of a CXL Root decoder address space."
> > >
> > > >                  Region space allocation is handled by the driver, but
> > >
> > > "Region capacity is allocated by writing to the size attribute, the
> > > resulting physical address base determined by the driver is reflected
> > > here."
> > >
> > > > +               the offset may be read by userspace tooling in order to
> > > > +               determine fragmentation, and available size for new regions.
> > >
> > > I would also expect, before / along with these new region attributes,
> > > there would be 'available' and 'max_extent_available' at the decoder
> > > level to indicate how much free space the decoder has and how big the
> > > next region creation can be. User tooling can walk  the decoder and
> > > the regions together to determine fragmentation if necessary, but for
> > > the most part the tool likely only cares about "how big can the next
> > > region be?" and "how full is this decoder?".
> >
> > Sounds good.
> >
> > >
> > >
> > > > +
> > > > +What:
> > > > +/sys/bus/cxl/devices/decoderX.Y/regionX.Y:Z/{interleave,size,uuid,target[0-15]}
> > > > +Date:          August, 2021
> > > > +KernelVersion: v5.18
> > > > +Contact:       linux-cxl@vger.kernel.org
> > > > +Description:
> > > > +               (RW) Configuring regions requires a minimal set of parameters in
> > > > +               order for the subsequent bind operation to succeed. The
> > > > +               following parameters are defined:
> > >
> > > Let's split up the descriptions into individual sections. That can
> > > also document the order that attributes must be written. For example,
> > > doesn't size need to be set before targets are added so that targets
> > > can be validated whether they have sufficient capacity?
> > >
> >
> > Okay. Order doesn't matter if you do validation all in one place as it is, but
> > sounds like we're changing that. So I can split it when we figure out what
> > validation is actually occurring at the sysfs attr boundary.
> 
> Forcing a write order simplifies the validation matrix. Consider the
> reduction in test surface if the kernel is more strict about what it
> allows into the kernel early. Let's make syzbot's job harder.
> 
> >
> > > > +
> > > > +               ==      ========================================================
> > > > +               interleave_granularity Mandatory. Number of consecutive bytes
> > > > +                       each device in the interleave set will claim. The
> > > > +                       possible interleave granularity values are determined by
> > > > +                       the CXL spec and the participating devices.
> > > > +               interleave_ways Mandatory. Number of devices participating in the
> > > > +                       region. Each device will provide 1/interleave of storage
> > > > +                       for the region.
> > > > +               size    Manadatory. Phsyical address space the region will
> > > > +                       consume.
> > >
> > > s/Phsyical/Physical/
> > >
> > > > +               target  Mandatory. Memory devices are the backing storage for a
> > > > +                       region. There will be N targets based on the number of
> > > > +                       interleave ways that the top level decoder is configured
> > > > +                       for.
> > >
> > > That doesn't sound right, IW at the root != IW at the endpoint level
> > > and the region needs to record all the endpoint level targets.
> >
> >
> > Yes This is wrong. I thought I had fixed it, but I guess not.
> >
> > >
> > > > Each target must be set with a memdev device ie.
> > > > +                       'mem1'. This attribute only becomes available after
> > > > +                       setting the 'interleave' attribute.
> > > > +               uuid    Optional. A unique identifier for the region. If none is
> > > > +                       selected, the kernel will create one.
> > >
> > > Let's drop the Mandatory / Optional distinction, or I am otherwise not
> > > understanding what this is trying to document. For example 'uuid' is
> > > "mandatory" for PMEM regions and "omitted" for volatile regions not
> > > optional.
> > >
> >
> > Well the kernel fills it in if userspace leaves it out. I'm guessing you're
> > going to ask me to change that, so I will remove Mandatory/Optional.
> 
> Yeah, why carry unnecessary code in the kernel? Userspace is well
> equipped to meet the requirement that it writes the UUID.
> 
> >
> > > > +               ==      ========================================================
> > > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > > index 1a448543db0d..3b48e0469fc7 100644
> > > > --- a/drivers/cxl/core/region.c
> > > > +++ b/drivers/cxl/core/region.c
> > > > @@ -3,9 +3,12 @@
> > > >  #include <linux/io-64-nonatomic-lo-hi.h>
> > > >  #include <linux/device.h>
> > > >  #include <linux/module.h>
> > > > +#include <linux/sizes.h>
> > > >  #include <linux/slab.h>
> > > > +#include <linux/uuid.h>
> > > >  #include <linux/idr.h>
> > > >  #include <region.h>
> > > > +#include <cxlmem.h>
> > > >  #include <cxl.h>
> > > >  #include "core.h"
> > > >
> > > > @@ -18,11 +21,305 @@
> > > >   * (programming the hardware) is handled by a separate region driver.
> > > >   */
> > > >
> > > > +struct cxl_region *to_cxl_region(struct device *dev);
> > > > +static const struct attribute_group region_interleave_group;
> > > > +
> > > > +static bool is_region_active(struct cxl_region *cxlr)
> > > > +{
> > > > +       /* TODO: Regions can't be activated yet. */
> > > > +       return false;
> > >
> > > This function seems redundant with just checking "cxlr->dev.driver !=
> > > NULL"? The benefit of that is there is no need to carry a TODO in the
> > > series.
> > >
> >
> > Yeah. I think checking driver bind status is sufficient to replace this.
> >
> > > > +}
> > > > +
> > > > +static void remove_target(struct cxl_region *cxlr, int target)
> > > > +{
> > > > +       struct cxl_memdev *cxlmd;
> > > > +
> > > > +       cxlmd = cxlr->config.targets[target];
> > > > +       if (cxlmd)
> > > > +               put_device(&cxlmd->dev);
> > >
> > > A memdev can be a member of multiple regions at once, shouldn't this
> > > be an endpoint decoder or similar, not the entire memdev?
> >
> > Is this referring to the later question about whether targets are decoders or
> > memdevs?
> 
> Yes.
> 
> > The thought was each region would hold a reference to all memdevs in
> > the interleave set.
> 
> It's not clear that a region needs to hold a reference if a memdev
> self removes itself from the region before it is unregistered. I am
> open to being convinced this is needed but it would need come with an
> explanation of what can a region do with a memdev reference after that
> memdev has experienced a ->remove() event.
> 
> > > Also, if memdevs autoremove themselves from regions at memdev
> > > ->remove() time then I don't think the region needs to hold references
> > > on memdevs.
> > >
> >
> > I'll defer to you on that. I'll remove holding the reference, but I definitely
> > haven't solved the interaction when a memdev goes away. I had been thinking the
> > inverse originally, a memdev can't go away until the region is gone. According
> > to the spec, these devices can't be hot removed, only managed remove, so if
> > things blew up, not our problem. However, if we have decent infrastructure to
> > support better than that, we should.
> 
> It turns out there's no such thing as "managed remove" as far as the
> kernel is concerned, it's all up to userspace. ->remove() can happen
> at any time and ->remove() can not fail. Per Bjorn Linux does not
> support PCIe hotplug latching so there is no kernel mechanism to block
> hotplug. Unless and until the PCIe native hotplug code picks up a
> mechanism to deny unplug events CXL needs to be prepared for any
> memdev to experience ->remove() regardless of region status.
> 
> For example, I expect the "managed remove" flow is something like this:
> 
> # cxl disable-memdev mem3
> cxl memdev: action_disable: mem3 is part of an active region
> cxl memdev: cmd_disable_memdev: disabled 0 mem
> 
> ...where the tool tries to enforce safety, but if someone really wants
> that device gone:
> 
> # cxl disable-memdev mem3 --force
> cxl memdev: cmd_disable_memdev: disabled 1 mem
> 
> ...and the CXL sub-system will need to trigger memory-failure across
> all the regions that were impacted by that violent event.
> 
> >
> > > > +       cxlr->config.targets[target] = NULL;
> > > > +}
> > > > +
> > > > +static ssize_t interleave_ways_show(struct device *dev,
> > > > +                                   struct device_attribute *attr, char *buf)
> > > > +{
> > > > +       struct cxl_region *cxlr = to_cxl_region(dev);
> > > > +
> > > > +       return sysfs_emit(buf, "%d\n", cxlr->config.interleave_ways);
> > > > +}
> > > > +
> > > > +static ssize_t interleave_ways_store(struct device *dev,
> > > > +                                    struct device_attribute *attr,
> > > > +                                    const char *buf, size_t len)
> > > > +{
> > > > +       struct cxl_region *cxlr = to_cxl_region(dev);
> > > > +       int ret, prev_iw;
> > > > +       int val;
> > >
> > > I would expect:
> > >
> > > if (dev->driver)
> > >    return -EBUSY;
> > >
> > > ...to shutdown configuration writes once the region is active. Might
> > > also need a region-wide seqlock like target_list_show. So that region
> > > probe drains  all active sysfs writers before assuming the
> > > configuration is stable.
> > >
> >
> > Okay.
> >
> > > > +
> > > > +       prev_iw = cxlr->config.interleave_ways;
> > > > +       ret = kstrtoint(buf, 0, &val);
> > > > +       if (ret)
> > > > +               return ret;
> > > > +       if (ret < 0 || ret > CXL_DECODER_MAX_INTERLEAVE)
> > > > +               return -EINVAL;
> > > > +
> > > > +       cxlr->config.interleave_ways = val;
> > > > +
> > > > +       ret = sysfs_update_group(&dev->kobj, &region_interleave_group);
> > > > +       if (ret < 0)
> > > > +               goto err;
> > > > +
> > > > +       sysfs_notify(&dev->kobj, NULL, "target_interleave");
> > >
> > > Why?
> > >
> >
> > I copied it from another driver. I didn't check if it was actually needed or
> > not.
> 
> It's not needed since the agent that wrote interleave ways is also
> expected to be the agent that is configuring the rest of the
> parameters.
> 
> >
> > > > +
> > > > +       while (prev_iw > cxlr->config.interleave_ways)
> > > > +               remove_target(cxlr, --prev_iw);
> > >
> > > To make the kernel side simpler this attribute could just require that
> > > setting interleave ways is a one way street, if you want to change it
> > > you need to delete the region and start over.
> > >
> >
> > I'm fine with that.
> >
> > > > +
> > > > +       return len;
> > > > +
> > > > +err:
> > > > +       cxlr->config.interleave_ways = prev_iw;
> > > > +       return ret;
> > > > +}
> > > > +static DEVICE_ATTR_RW(interleave_ways);
> > > > +
> > > > +static ssize_t interleave_granularity_show(struct device *dev,
> > > > +                                          struct device_attribute *attr,
> > > > +                                          char *buf)
> > > > +{
> > > > +       struct cxl_region *cxlr = to_cxl_region(dev);
> > > > +
> > > > +       return sysfs_emit(buf, "%d\n", cxlr->config.interleave_granularity);
> > > > +}
> > > > +
> > > > +static ssize_t interleave_granularity_store(struct device *dev,
> > > > +                                           struct device_attribute *attr,
> > > > +                                           const char *buf, size_t len)
> > > > +{
> > > > +       struct cxl_region *cxlr = to_cxl_region(dev);
> > > > +       int val, ret;
> > > > +
> > > > +       ret = kstrtoint(buf, 0, &val);
> > > > +       if (ret)
> > > > +               return ret;
> > > > +       cxlr->config.interleave_granularity = val;
> > >
> > > This wants minimum input validation and synchronization against an
> > > active region.
> > >
> > > > +
> > > > +       return len;
> > > > +}
> > > > +static DEVICE_ATTR_RW(interleave_granularity);
> > > > +
> > > > +static ssize_t offset_show(struct device *dev, struct device_attribute *attr,
> > > > +                          char *buf)
> > > > +{
> > > > +       struct cxl_decoder *cxld = to_cxl_decoder(dev->parent);
> > > > +       struct cxl_region *cxlr = to_cxl_region(dev);
> > > > +       resource_size_t offset;
> > > > +
> > > > +       if (!cxlr->res)
> > > > +               return sysfs_emit(buf, "\n");
> > >
> > > Should be an error I would think. I.e. require size to be set before
> > > s/offset/resource/ can be read.
> > >
> > > > +
> > > > +       offset = cxld->platform_res.start - cxlr->res->start;
> > >
> > > Why make usersapce do the offset math?
> > >
> > > > +
> > > > +       return sysfs_emit(buf, "%pa\n", &offset);
> > > > +}
> > > > +static DEVICE_ATTR_RO(offset);
> > >
> > > This can be DEVICE_ATTR_ADMIN_RO() to hide physical address layout
> > > information from non-root.
> > >
> > > > +
> > > > +static ssize_t size_show(struct device *dev, struct device_attribute *attr,
> > > > +                        char *buf)
> > > > +{
> > > > +       struct cxl_region *cxlr = to_cxl_region(dev);
> > > > +
> > > > +       return sysfs_emit(buf, "%llu\n", cxlr->config.size);
> > >
> > > Perhaps no need to store size separately if this becomes:
> > >
> > > sysfs_emit(buf, "%llu\n", (unsigned long long) resource_size(cxlr->res));
> > >
> > >
> > > ...?
> > >
> > > > +}
> > > > +
> > > > +static ssize_t size_store(struct device *dev, struct device_attribute *attr,
> > > > +                         const char *buf, size_t len)
> > > > +{
> > > > +       struct cxl_region *cxlr = to_cxl_region(dev);
> > > > +       unsigned long long val;
> > > > +       ssize_t rc;
> > > > +
> > > > +       rc = kstrtoull(buf, 0, &val);
> > > > +       if (rc)
> > > > +               return rc;
> > > > +
> > > > +       device_lock(&cxlr->dev);
> > > > +       if (is_region_active(cxlr))
> > > > +               rc = -EBUSY;
> > > > +       else
> > > > +               cxlr->config.size = val;
> > > > +       device_unlock(&cxlr->dev);
> > >
> > > I think lockdep will complain about device_lock() usage in an
> > > attribute. Try changing this to cxl_device_lock() with
> > > CONFIG_PROVE_CXL_LOCKING=y.
> > >
> > > > +
> > > > +       return rc ? rc : len;
> > > > +}
> > > > +static DEVICE_ATTR_RW(size);
> > > > +
> > > > +static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
> > > > +                        char *buf)
> > > > +{
> > > > +       struct cxl_region *cxlr = to_cxl_region(dev);
> > > > +
> > > > +       return sysfs_emit(buf, "%pUb\n", &cxlr->config.uuid);
> > > > +}
> > > > +
> > > > +static ssize_t uuid_store(struct device *dev, struct device_attribute *attr,
> > > > +                         const char *buf, size_t len)
> > > > +{
> > > > +       struct cxl_region *cxlr = to_cxl_region(dev);
> > > > +       ssize_t rc;
> > > > +
> > > > +       if (len != UUID_STRING_LEN + 1)
> > > > +               return -EINVAL;
> > > > +
> > > > +       device_lock(&cxlr->dev);
> > > > +       if (is_region_active(cxlr))
> > > > +               rc = -EBUSY;
> > > > +       else
> > > > +               rc = uuid_parse(buf, &cxlr->config.uuid);
> > > > +       device_unlock(&cxlr->dev);
> > > > +
> > > > +       return rc ? rc : len;
> > > > +}
> > > > +static DEVICE_ATTR_RW(uuid);
> > > > +
> > > > +static struct attribute *region_attrs[] = {
> > > > +       &dev_attr_interleave_ways.attr,
> > > > +       &dev_attr_interleave_granularity.attr,
> > > > +       &dev_attr_offset.attr,
> > > > +       &dev_attr_size.attr,
> > > > +       &dev_attr_uuid.attr,
> > > > +       NULL,
> > > > +};
> > > > +
> > > > +static const struct attribute_group region_group = {
> > > > +       .attrs = region_attrs,
> > > > +};
> > > > +
> > > > +static size_t show_targetN(struct cxl_region *cxlr, char *buf, int n)
> > > > +{
> > > > +       int ret;
> > > > +
> > > > +       device_lock(&cxlr->dev);
> > > > +       if (!cxlr->config.targets[n])
> > > > +               ret = sysfs_emit(buf, "\n");
> > > > +       else
> > > > +               ret = sysfs_emit(buf, "%s\n",
> > > > +                                dev_name(&cxlr->config.targets[n]->dev));
> > > > +       device_unlock(&cxlr->dev);
> > >
> > > The component contribution of a memdev to a region is a DPA-span, not
> > > the whole memdev. I would expect something like dax_mapping_attributes
> > > or REGION_MAPPING() from drivers/nvdimm/region_devs.c. A tuple of
> > > information about the component contribution of a memdev to a region.
> > >
> >
> > I had been thinking the kernel would manage the DPS spans of a memdev (and
> > create the mappings). I can make this look like dax_mapping_attributes.
> 
> I think we get this for free by just linking the region to each
> endpoint decoder in use and then userspace can walk that to get DPA
> info from the decoder (modulo extending endpoint decoders with DPA
> extent info).
> 
> >
> > > > +
> > > > +       return ret;
> > > > +}
> > > > +
> > > > +static size_t set_targetN(struct cxl_region *cxlr, const char *buf, int n,
> > > > +                         size_t len)
> > > > +{
> > > > +       struct device *memdev_dev;
> > > > +       struct cxl_memdev *cxlmd;
> > > > +
> > > > +       device_lock(&cxlr->dev);
> > > > +
> > > > +       if (len == 1 || cxlr->config.targets[n])
> > > > +               remove_target(cxlr, n);
> > > > +
> > > > +       /* Remove target special case */
> > > > +       if (len == 1) {
> > > > +               device_unlock(&cxlr->dev);
> > > > +               return len;
> > > > +       }
> > > > +
> > > > +       memdev_dev = bus_find_device_by_name(&cxl_bus_type, NULL, buf);
> > >
> > > I think this wants to be an endpoint decoder, not a memdev. Because
> > > it's the decoder that joins a memdev to a region, or at least a
> > > decoder should be picked when the memdev is assigned so that the DPA
> > > mapping can be registered. If all the decoders are allocated then fail
> > > here.
> > >
> >
> > My preference is obviously how it is, using memdevs and having the decoders
> > allocated at bind time. I don't have an objective argument why one is better
> > than the other so I will change it. I will make the interface take a set of
> > decoders.
> 
> Let me know if the arguments I have made for why more granularity is
> necessary have changed your preference. I'm open to hearing alternate
> ideas.
