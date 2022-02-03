Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284B64A8AA1
	for <lists+linux-pci@lfdr.de>; Thu,  3 Feb 2022 18:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245117AbiBCRtE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 12:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbiBCRtD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Feb 2022 12:49:03 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46548C06173B
        for <linux-pci@vger.kernel.org>; Thu,  3 Feb 2022 09:49:03 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 77so42030pgc.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Feb 2022 09:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0xxJfJf3QrcpslRn2ySmfMjePpOBb7Fqelin0Q5ZXy8=;
        b=hEKr+wo358U8uAjU3b7Yt7D/NFY0ikZkOKbIjBgP13HM+1oLk2ffdQGtkGj7CDcUjP
         Bu7ykpdup41iX2/lzU5cL9uKOi9LYdnVxyg24jVQLlA55d7XOSgTgQqwTol+pYYGpnST
         Q/LNONNnB4oYO+xi6hw26qxARx0KvCj9Ov2gbd91zvDolQ8HhVRfjFacmewKUCC+uTLP
         4HXE8XF/t9JINso1TuSdEqNeuRaeEK4kLYcNQpWZ3ey03ymvYZk6J3m7CnCWElKLi8dJ
         3e3zyet5kNMchlu1FG2OvInHGYqcu55UcLwxxqKUPwJ1flQPjdp3RIfsnOIRlTCmVFlo
         HyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0xxJfJf3QrcpslRn2ySmfMjePpOBb7Fqelin0Q5ZXy8=;
        b=RN9fsMKCdVgiXdl9IcknlRWfe1Cg+oaocDoJjJSTwiwLiDPejJP1onZCC57NaPjJOi
         +/z6vm3mzfwcda6FIUdKasgeNsDq4LbeAAMZHLYYJ7DU5oz3yU6yxHSVTguXTUvIAw+Y
         7qaUh1EN7YEHaA9vdgR3gVLuxomcLlgR+NwXkbsm+h62/XtYEY/4FL0uwO3LmuV1mM+M
         AnUp9foDEK8TxdU8qDSoGiKShYf1fpSRyyXiDvVbIdubHc3cUleriT5qQW2xtUEqckNP
         329HxhrOpv2HJWCt71vtOeTnyt/f/SxML72HFYB6p3wMlYNmn6jYPKd610nuFwQEmN6/
         j0rw==
X-Gm-Message-State: AOAM532G7qkWtPeYzYXUkxCYdgSXAf8tbjnRNr9G8pB6IyDd//n6qLKi
        rlZzO/00dYNyzXZ2yzVlY2ElzEXiDpt40qKKuoFfEg==
X-Google-Smtp-Source: ABdhPJwt93c0pj29ZN5+3k/PGFhojfiOzwW9IraaTP8Ddn+2CVw7YdWhPikq0bUGdbOJwV0TMqYeB1Db3CtnvlQZ8tA=
X-Received: by 2002:a63:4717:: with SMTP id u23mr29446927pga.74.1643910542458;
 Thu, 03 Feb 2022 09:49:02 -0800 (PST)
MIME-Version: 1.0
References: <20220128002707.391076-1-ben.widawsky@intel.com>
 <20220128002707.391076-3-ben.widawsky@intel.com> <CAPcyv4hHJcPLRJM-7z+wKhjBhp9HH2qXuEeC0VfDnD6yU9H-Wg@mail.gmail.com>
 <20220201231117.lksqoukbvss6e3ec@intel.com>
In-Reply-To: <20220201231117.lksqoukbvss6e3ec@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 3 Feb 2022 09:48:49 -0800
Message-ID: <CAPcyv4iGQWXX8rzCH7BJUSyvDXbdiuHw4kLiuqGmVVBGTh2a1Q@mail.gmail.com>
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

On Tue, Feb 1, 2022 at 3:11 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 22-01-28 16:25:34, Dan Williams wrote:
> > On Thu, Jan 27, 2022 at 4:27 PM Ben Widawsky <ben.widawsky@intel.com> w=
rote:
> > >
> > > The region creation APIs create a vacant region. Configuring the regi=
on
> > > works in the same way as similar subsystems such as devdax. Sysfs att=
rs
> > > will be provided to allow userspace to configure the region.  Finally
> > > once all configuration is complete, userspace may activate the region=
.
> > >
> > > Introduced here are the most basic attributes needed to configure a
> > > region. Details of these attribute are described in the ABI
> >
> > s/attribute/attributes/
> >
> > > Documentation. Sanity checking of configuration parameters are done a=
t
> > > region binding time. This consolidates all such logic in one place,
> > > rather than being strewn across multiple places.
> >
> > I think that's too late for some of the validation. The complex
> > validation that the region driver does throughout the topology is
> > different from the basic input validation that can  be done at the
> > sysfs write time. For example ,this patch allows negative
> > interleave_granularity values to specified, just return -EINVAL. I
> > agree that sysfs should not validate everything, I disagree with
> > pushing all validation to cxl_region_probe().
> >
>
> Two points:c
> 1. How do we distinguish "basic input validation". It'd be good if we cou=
ld
>    define "basic input validation". For instance, when I first wrote thes=
e
>    patches, x3 would have been EINVAL, but today it's allowed. Can you he=
lp
>    enumerate what you consider basic.

I internalized this kernel design principle from Dave Miller many
years ago paraphrasing "push decision making out to leaf code as much
as possible", and centralizing all validation in cxl_region_probe()
violates. The software that makes the mistake does not know it made a
mistake until much later and "probe failed" is less descriptive than
"EINVAL writing interleave_ways" . I wish I could find the thread
because it also talked about his iteration process.

Basic input validation to me is things like:

- Don't allow writes while the region is active
- Check that values are in bound. So yes, the interleave-ways value of
3 would fail until the kernel supports it, and granularity values >
16K would also fail.
- Check that memdevs are actually downstream targets of the given decoder
- Check that the region uuid is unique
- Check that decoder has capacity
- Check that the memdev has capacity
- Check that the decoder to map the DPA is actually available given
decoders must be programmed in increasing DPA order

Essentially any validation short of walking the topology to program
upstream decoders since those errors are only resolved by racing
region probes that try to grab upstream decoder resources.

>
> 2. I like the idea that all validation takes place in one place. Obviousl=
y you
>    do not. So, see #1 and I will rework.

The validation helpers need to be written once, where they are called
does not much matter, does it?

>
> > >
> > > A example is provided below:
> > >
> > > /sys/bus/cxl/devices/region0.0:0
> > > =E2=94=9C=E2=94=80=E2=94=80 interleave_granularity
> > > =E2=94=9C=E2=94=80=E2=94=80 interleave_ways
> > > =E2=94=9C=E2=94=80=E2=94=80 offset
> > > =E2=94=9C=E2=94=80=E2=94=80 size
> > > =E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../../../../../../bus/cxl
> > > =E2=94=9C=E2=94=80=E2=94=80 target0
> > > =E2=94=9C=E2=94=80=E2=94=80 uevent
> > > =E2=94=94=E2=94=80=E2=94=80 uuid
> >
> > As mentioned off-list, it looks like devtype and modalias are missing.
> >
>
> Thanks.
>
> > >
> > > Reported-by: kernel test robot <lkp@intel.com> (v2)
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-cxl |  40 ++++
> > >  drivers/cxl/core/region.c               | 300 ++++++++++++++++++++++=
++
> > >  2 files changed, 340 insertions(+)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/=
ABI/testing/sysfs-bus-cxl
> > > index dcc728458936..50ba5018014d 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > > @@ -187,3 +187,43 @@ Description:
> > >                 region driver before being deleted. The attributes ex=
pects a
> > >                 region in the form "regionX.Y:Z". The region's name, =
allocated
> > >                 by reading create_region, will also be released.
> > > +
> > > +What:          /sys/bus/cxl/devices/decoderX.Y/regionX.Y:Z/offset
> >
> > This is just another 'resource' attribute for the physical base
> > address of the region, right? 'offset' sounds like something that
> > would be relative instead of absolute.
> >
>
> It is offset. I can change it to physical base if you'd like but I though=
t that
> information wasn't critically important for userspace to have. Does users=
pace
> care about the physical base?

Yes, similar use case as /proc/iomem. Error handling comes to mind as
you can see physical address data in the messages like machine check
notification and go immediately match that to a CXL region. PCI,
NVDIMM, and DAX all emit a "resource" attribute to identify the
physical address base.

>
> > > +Date:          August, 2021
> >
> > Same date update comment here.
> >
> > > +KernelVersion: v5.18
> > > +Contact:       linux-cxl@vger.kernel.org
> > > +Description:
> > > +               (RO) A region resides within an address space that is=
 claimed by
> > > +               a decoder.
> >
> > "A region is a contiguous partition of a CXL Root decoder address space=
."
> >
> > >                  Region space allocation is handled by the driver, bu=
t
> >
> > "Region capacity is allocated by writing to the size attribute, the
> > resulting physical address base determined by the driver is reflected
> > here."
> >
> > > +               the offset may be read by userspace tooling in order =
to
> > > +               determine fragmentation, and available size for new r=
egions.
> >
> > I would also expect, before / along with these new region attributes,
> > there would be 'available' and 'max_extent_available' at the decoder
> > level to indicate how much free space the decoder has and how big the
> > next region creation can be. User tooling can walk  the decoder and
> > the regions together to determine fragmentation if necessary, but for
> > the most part the tool likely only cares about "how big can the next
> > region be?" and "how full is this decoder?".
>
> Sounds good.
>
> >
> >
> > > +
> > > +What:
> > > +/sys/bus/cxl/devices/decoderX.Y/regionX.Y:Z/{interleave,size,uuid,ta=
rget[0-15]}
> > > +Date:          August, 2021
> > > +KernelVersion: v5.18
> > > +Contact:       linux-cxl@vger.kernel.org
> > > +Description:
> > > +               (RW) Configuring regions requires a minimal set of pa=
rameters in
> > > +               order for the subsequent bind operation to succeed. T=
he
> > > +               following parameters are defined:
> >
> > Let's split up the descriptions into individual sections. That can
> > also document the order that attributes must be written. For example,
> > doesn't size need to be set before targets are added so that targets
> > can be validated whether they have sufficient capacity?
> >
>
> Okay. Order doesn't matter if you do validation all in one place as it is=
, but
> sounds like we're changing that. So I can split it when we figure out wha=
t
> validation is actually occurring at the sysfs attr boundary.

Forcing a write order simplifies the validation matrix. Consider the
reduction in test surface if the kernel is more strict about what it
allows into the kernel early. Let's make syzbot's job harder.

>
> > > +
> > > +               =3D=3D      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +               interleave_granularity Mandatory. Number of consecuti=
ve bytes
> > > +                       each device in the interleave set will claim.=
 The
> > > +                       possible interleave granularity values are de=
termined by
> > > +                       the CXL spec and the participating devices.
> > > +               interleave_ways Mandatory. Number of devices particip=
ating in the
> > > +                       region. Each device will provide 1/interleave=
 of storage
> > > +                       for the region.
> > > +               size    Manadatory. Phsyical address space the region=
 will
> > > +                       consume.
> >
> > s/Phsyical/Physical/
> >
> > > +               target  Mandatory. Memory devices are the backing sto=
rage for a
> > > +                       region. There will be N targets based on the =
number of
> > > +                       interleave ways that the top level decoder is=
 configured
> > > +                       for.
> >
> > That doesn't sound right, IW at the root !=3D IW at the endpoint level
> > and the region needs to record all the endpoint level targets.
>
>
> Yes This is wrong. I thought I had fixed it, but I guess not.
>
> >
> > > Each target must be set with a memdev device ie.
> > > +                       'mem1'. This attribute only becomes available=
 after
> > > +                       setting the 'interleave' attribute.
> > > +               uuid    Optional. A unique identifier for the region.=
 If none is
> > > +                       selected, the kernel will create one.
> >
> > Let's drop the Mandatory / Optional distinction, or I am otherwise not
> > understanding what this is trying to document. For example 'uuid' is
> > "mandatory" for PMEM regions and "omitted" for volatile regions not
> > optional.
> >
>
> Well the kernel fills it in if userspace leaves it out. I'm guessing you'=
re
> going to ask me to change that, so I will remove Mandatory/Optional.

Yeah, why carry unnecessary code in the kernel? Userspace is well
equipped to meet the requirement that it writes the UUID.

>
> > > +               =3D=3D      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > index 1a448543db0d..3b48e0469fc7 100644
> > > --- a/drivers/cxl/core/region.c
> > > +++ b/drivers/cxl/core/region.c
> > > @@ -3,9 +3,12 @@
> > >  #include <linux/io-64-nonatomic-lo-hi.h>
> > >  #include <linux/device.h>
> > >  #include <linux/module.h>
> > > +#include <linux/sizes.h>
> > >  #include <linux/slab.h>
> > > +#include <linux/uuid.h>
> > >  #include <linux/idr.h>
> > >  #include <region.h>
> > > +#include <cxlmem.h>
> > >  #include <cxl.h>
> > >  #include "core.h"
> > >
> > > @@ -18,11 +21,305 @@
> > >   * (programming the hardware) is handled by a separate region driver=
.
> > >   */
> > >
> > > +struct cxl_region *to_cxl_region(struct device *dev);
> > > +static const struct attribute_group region_interleave_group;
> > > +
> > > +static bool is_region_active(struct cxl_region *cxlr)
> > > +{
> > > +       /* TODO: Regions can't be activated yet. */
> > > +       return false;
> >
> > This function seems redundant with just checking "cxlr->dev.driver !=3D
> > NULL"? The benefit of that is there is no need to carry a TODO in the
> > series.
> >
>
> Yeah. I think checking driver bind status is sufficient to replace this.
>
> > > +}
> > > +
> > > +static void remove_target(struct cxl_region *cxlr, int target)
> > > +{
> > > +       struct cxl_memdev *cxlmd;
> > > +
> > > +       cxlmd =3D cxlr->config.targets[target];
> > > +       if (cxlmd)
> > > +               put_device(&cxlmd->dev);
> >
> > A memdev can be a member of multiple regions at once, shouldn't this
> > be an endpoint decoder or similar, not the entire memdev?
>
> Is this referring to the later question about whether targets are decoder=
s or
> memdevs?

Yes.

> The thought was each region would hold a reference to all memdevs in
> the interleave set.

It's not clear that a region needs to hold a reference if a memdev
self removes itself from the region before it is unregistered. I am
open to being convinced this is needed but it would need come with an
explanation of what can a region do with a memdev reference after that
memdev has experienced a ->remove() event.

> > Also, if memdevs autoremove themselves from regions at memdev
> > ->remove() time then I don't think the region needs to hold references
> > on memdevs.
> >
>
> I'll defer to you on that. I'll remove holding the reference, but I defin=
itely
> haven't solved the interaction when a memdev goes away. I had been thinki=
ng the
> inverse originally, a memdev can't go away until the region is gone. Acco=
rding
> to the spec, these devices can't be hot removed, only managed remove, so =
if
> things blew up, not our problem. However, if we have decent infrastructur=
e to
> support better than that, we should.

It turns out there's no such thing as "managed remove" as far as the
kernel is concerned, it's all up to userspace. ->remove() can happen
at any time and ->remove() can not fail. Per Bjorn Linux does not
support PCIe hotplug latching so there is no kernel mechanism to block
hotplug. Unless and until the PCIe native hotplug code picks up a
mechanism to deny unplug events CXL needs to be prepared for any
memdev to experience ->remove() regardless of region status.

For example, I expect the "managed remove" flow is something like this:

# cxl disable-memdev mem3
cxl memdev: action_disable: mem3 is part of an active region
cxl memdev: cmd_disable_memdev: disabled 0 mem

...where the tool tries to enforce safety, but if someone really wants
that device gone:

# cxl disable-memdev mem3 --force
cxl memdev: cmd_disable_memdev: disabled 1 mem

...and the CXL sub-system will need to trigger memory-failure across
all the regions that were impacted by that violent event.

>
> > > +       cxlr->config.targets[target] =3D NULL;
> > > +}
> > > +
> > > +static ssize_t interleave_ways_show(struct device *dev,
> > > +                                   struct device_attribute *attr, ch=
ar *buf)
> > > +{
> > > +       struct cxl_region *cxlr =3D to_cxl_region(dev);
> > > +
> > > +       return sysfs_emit(buf, "%d\n", cxlr->config.interleave_ways);
> > > +}
> > > +
> > > +static ssize_t interleave_ways_store(struct device *dev,
> > > +                                    struct device_attribute *attr,
> > > +                                    const char *buf, size_t len)
> > > +{
> > > +       struct cxl_region *cxlr =3D to_cxl_region(dev);
> > > +       int ret, prev_iw;
> > > +       int val;
> >
> > I would expect:
> >
> > if (dev->driver)
> >    return -EBUSY;
> >
> > ...to shutdown configuration writes once the region is active. Might
> > also need a region-wide seqlock like target_list_show. So that region
> > probe drains  all active sysfs writers before assuming the
> > configuration is stable.
> >
>
> Okay.
>
> > > +
> > > +       prev_iw =3D cxlr->config.interleave_ways;
> > > +       ret =3D kstrtoint(buf, 0, &val);
> > > +       if (ret)
> > > +               return ret;
> > > +       if (ret < 0 || ret > CXL_DECODER_MAX_INTERLEAVE)
> > > +               return -EINVAL;
> > > +
> > > +       cxlr->config.interleave_ways =3D val;
> > > +
> > > +       ret =3D sysfs_update_group(&dev->kobj, &region_interleave_gro=
up);
> > > +       if (ret < 0)
> > > +               goto err;
> > > +
> > > +       sysfs_notify(&dev->kobj, NULL, "target_interleave");
> >
> > Why?
> >
>
> I copied it from another driver. I didn't check if it was actually needed=
 or
> not.

It's not needed since the agent that wrote interleave ways is also
expected to be the agent that is configuring the rest of the
parameters.

>
> > > +
> > > +       while (prev_iw > cxlr->config.interleave_ways)
> > > +               remove_target(cxlr, --prev_iw);
> >
> > To make the kernel side simpler this attribute could just require that
> > setting interleave ways is a one way street, if you want to change it
> > you need to delete the region and start over.
> >
>
> I'm fine with that.
>
> > > +
> > > +       return len;
> > > +
> > > +err:
> > > +       cxlr->config.interleave_ways =3D prev_iw;
> > > +       return ret;
> > > +}
> > > +static DEVICE_ATTR_RW(interleave_ways);
> > > +
> > > +static ssize_t interleave_granularity_show(struct device *dev,
> > > +                                          struct device_attribute *a=
ttr,
> > > +                                          char *buf)
> > > +{
> > > +       struct cxl_region *cxlr =3D to_cxl_region(dev);
> > > +
> > > +       return sysfs_emit(buf, "%d\n", cxlr->config.interleave_granul=
arity);
> > > +}
> > > +
> > > +static ssize_t interleave_granularity_store(struct device *dev,
> > > +                                           struct device_attribute *=
attr,
> > > +                                           const char *buf, size_t l=
en)
> > > +{
> > > +       struct cxl_region *cxlr =3D to_cxl_region(dev);
> > > +       int val, ret;
> > > +
> > > +       ret =3D kstrtoint(buf, 0, &val);
> > > +       if (ret)
> > > +               return ret;
> > > +       cxlr->config.interleave_granularity =3D val;
> >
> > This wants minimum input validation and synchronization against an
> > active region.
> >
> > > +
> > > +       return len;
> > > +}
> > > +static DEVICE_ATTR_RW(interleave_granularity);
> > > +
> > > +static ssize_t offset_show(struct device *dev, struct device_attribu=
te *attr,
> > > +                          char *buf)
> > > +{
> > > +       struct cxl_decoder *cxld =3D to_cxl_decoder(dev->parent);
> > > +       struct cxl_region *cxlr =3D to_cxl_region(dev);
> > > +       resource_size_t offset;
> > > +
> > > +       if (!cxlr->res)
> > > +               return sysfs_emit(buf, "\n");
> >
> > Should be an error I would think. I.e. require size to be set before
> > s/offset/resource/ can be read.
> >
> > > +
> > > +       offset =3D cxld->platform_res.start - cxlr->res->start;
> >
> > Why make usersapce do the offset math?
> >
> > > +
> > > +       return sysfs_emit(buf, "%pa\n", &offset);
> > > +}
> > > +static DEVICE_ATTR_RO(offset);
> >
> > This can be DEVICE_ATTR_ADMIN_RO() to hide physical address layout
> > information from non-root.
> >
> > > +
> > > +static ssize_t size_show(struct device *dev, struct device_attribute=
 *attr,
> > > +                        char *buf)
> > > +{
> > > +       struct cxl_region *cxlr =3D to_cxl_region(dev);
> > > +
> > > +       return sysfs_emit(buf, "%llu\n", cxlr->config.size);
> >
> > Perhaps no need to store size separately if this becomes:
> >
> > sysfs_emit(buf, "%llu\n", (unsigned long long) resource_size(cxlr->res)=
);
> >
> >
> > ...?
> >
> > > +}
> > > +
> > > +static ssize_t size_store(struct device *dev, struct device_attribut=
e *attr,
> > > +                         const char *buf, size_t len)
> > > +{
> > > +       struct cxl_region *cxlr =3D to_cxl_region(dev);
> > > +       unsigned long long val;
> > > +       ssize_t rc;
> > > +
> > > +       rc =3D kstrtoull(buf, 0, &val);
> > > +       if (rc)
> > > +               return rc;
> > > +
> > > +       device_lock(&cxlr->dev);
> > > +       if (is_region_active(cxlr))
> > > +               rc =3D -EBUSY;
> > > +       else
> > > +               cxlr->config.size =3D val;
> > > +       device_unlock(&cxlr->dev);
> >
> > I think lockdep will complain about device_lock() usage in an
> > attribute. Try changing this to cxl_device_lock() with
> > CONFIG_PROVE_CXL_LOCKING=3Dy.
> >
> > > +
> > > +       return rc ? rc : len;
> > > +}
> > > +static DEVICE_ATTR_RW(size);
> > > +
> > > +static ssize_t uuid_show(struct device *dev, struct device_attribute=
 *attr,
> > > +                        char *buf)
> > > +{
> > > +       struct cxl_region *cxlr =3D to_cxl_region(dev);
> > > +
> > > +       return sysfs_emit(buf, "%pUb\n", &cxlr->config.uuid);
> > > +}
> > > +
> > > +static ssize_t uuid_store(struct device *dev, struct device_attribut=
e *attr,
> > > +                         const char *buf, size_t len)
> > > +{
> > > +       struct cxl_region *cxlr =3D to_cxl_region(dev);
> > > +       ssize_t rc;
> > > +
> > > +       if (len !=3D UUID_STRING_LEN + 1)
> > > +               return -EINVAL;
> > > +
> > > +       device_lock(&cxlr->dev);
> > > +       if (is_region_active(cxlr))
> > > +               rc =3D -EBUSY;
> > > +       else
> > > +               rc =3D uuid_parse(buf, &cxlr->config.uuid);
> > > +       device_unlock(&cxlr->dev);
> > > +
> > > +       return rc ? rc : len;
> > > +}
> > > +static DEVICE_ATTR_RW(uuid);
> > > +
> > > +static struct attribute *region_attrs[] =3D {
> > > +       &dev_attr_interleave_ways.attr,
> > > +       &dev_attr_interleave_granularity.attr,
> > > +       &dev_attr_offset.attr,
> > > +       &dev_attr_size.attr,
> > > +       &dev_attr_uuid.attr,
> > > +       NULL,
> > > +};
> > > +
> > > +static const struct attribute_group region_group =3D {
> > > +       .attrs =3D region_attrs,
> > > +};
> > > +
> > > +static size_t show_targetN(struct cxl_region *cxlr, char *buf, int n=
)
> > > +{
> > > +       int ret;
> > > +
> > > +       device_lock(&cxlr->dev);
> > > +       if (!cxlr->config.targets[n])
> > > +               ret =3D sysfs_emit(buf, "\n");
> > > +       else
> > > +               ret =3D sysfs_emit(buf, "%s\n",
> > > +                                dev_name(&cxlr->config.targets[n]->d=
ev));
> > > +       device_unlock(&cxlr->dev);
> >
> > The component contribution of a memdev to a region is a DPA-span, not
> > the whole memdev. I would expect something like dax_mapping_attributes
> > or REGION_MAPPING() from drivers/nvdimm/region_devs.c. A tuple of
> > information about the component contribution of a memdev to a region.
> >
>
> I had been thinking the kernel would manage the DPS spans of a memdev (an=
d
> create the mappings). I can make this look like dax_mapping_attributes.

I think we get this for free by just linking the region to each
endpoint decoder in use and then userspace can walk that to get DPA
info from the decoder (modulo extending endpoint decoders with DPA
extent info).

>
> > > +
> > > +       return ret;
> > > +}
> > > +
> > > +static size_t set_targetN(struct cxl_region *cxlr, const char *buf, =
int n,
> > > +                         size_t len)
> > > +{
> > > +       struct device *memdev_dev;
> > > +       struct cxl_memdev *cxlmd;
> > > +
> > > +       device_lock(&cxlr->dev);
> > > +
> > > +       if (len =3D=3D 1 || cxlr->config.targets[n])
> > > +               remove_target(cxlr, n);
> > > +
> > > +       /* Remove target special case */
> > > +       if (len =3D=3D 1) {
> > > +               device_unlock(&cxlr->dev);
> > > +               return len;
> > > +       }
> > > +
> > > +       memdev_dev =3D bus_find_device_by_name(&cxl_bus_type, NULL, b=
uf);
> >
> > I think this wants to be an endpoint decoder, not a memdev. Because
> > it's the decoder that joins a memdev to a region, or at least a
> > decoder should be picked when the memdev is assigned so that the DPA
> > mapping can be registered. If all the decoders are allocated then fail
> > here.
> >
>
> My preference is obviously how it is, using memdevs and having the decode=
rs
> allocated at bind time. I don't have an objective argument why one is bet=
ter
> than the other so I will change it. I will make the interface take a set =
of
> decoders.

Let me know if the arguments I have made for why more granularity is
necessary have changed your preference. I'm open to hearing alternate
ideas.
