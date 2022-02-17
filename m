Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC62E4BAA72
	for <lists+linux-pci@lfdr.de>; Thu, 17 Feb 2022 20:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239875AbiBQT62 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Feb 2022 14:58:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiBQT61 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Feb 2022 14:58:27 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28733289A4
        for <linux-pci@vger.kernel.org>; Thu, 17 Feb 2022 11:58:11 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id p8so567457pfh.8
        for <linux-pci@vger.kernel.org>; Thu, 17 Feb 2022 11:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=usFF6AowuFDTJX5CR1mCYBUZOWqpefpPd3EYJPLBzSM=;
        b=F9CpQIDApThhj8ivHhpf9l9Hp7ornRsyOidRF3FJbgEGDC51nBt9OwAbAIiNkXdVLZ
         raDyOoCd2YkQWqQNVsPAcyTl2Wt5UDiChjjpsw9NWBsTMdl35r4GmnpIEs4OXZtCjEXD
         1c8EgRMc9koT069OEijY6eVubecvTPe3MLz5QgXsLIefyVUYPQ0eNwC0pXLIiTobeEMV
         wI5MPn6oRuUgsglI8wmt2PWB1T8hQChIyczw9r0Wx/oEwsSi8tcMOpcceB7cFUFVCUTG
         Nr/PNxA2IRlyrGM1zUZ3x1/rMb4SMDDmdDwH8G/HxzVajyCDXo9EdkXCKX8HH+SZa3Po
         la5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=usFF6AowuFDTJX5CR1mCYBUZOWqpefpPd3EYJPLBzSM=;
        b=Z/0fKtqerO29FPfVKRPHkzOfpeLsU2E7TImjxcjMLqumnxNAEH8aMLgQWEMWSFL3WR
         wKWxNhnc4PsXKGXHho0tWAhFSyaHQza54n2Z/ZGVYcelklClDLF2/z0+8DD3AUDIDZCi
         baRYJtOnHOi4RLs97VZuFhtJjuZz9FH0ilSXHG00Mkcd6tYoNHGCS3XXvM7oTvJvqN0Q
         bbIkq2ikD2dwt+IzTcqUMucFYXT41VIKROOtjtaHpPULkEHNQHBhtPwudoZ5U+3bebCB
         KMjuUNoUXWICub/Pm176Lsy2w86FhPKB9LleG9OblqDxiD/IBT9UT90nMUI2oxTmLeHe
         cijg==
X-Gm-Message-State: AOAM533jWeK7GZmETHdjbQUXLETGBeb3rRVyDd8TDZNqPzJE0pxXpSKX
        tldoUUTeLJcE/7h7i3uSE7WgCby0S/6Vfrji1Ry2Sw==
X-Google-Smtp-Source: ABdhPJxpfpSGRi7gOS1mxOUyXji5C3uhmWjCwi93VRLFpb+FN4G/n7sVFUZD2J1MfB+8Sei0823y8ax4KeHZPRz9WVY=
X-Received: by 2002:a62:ab09:0:b0:4e0:d967:318f with SMTP id
 p9-20020a62ab09000000b004e0d967318fmr4674976pff.86.1645127890400; Thu, 17 Feb
 2022 11:58:10 -0800 (PST)
MIME-Version: 1.0
References: <20220128002707.391076-1-ben.widawsky@intel.com>
 <20220128002707.391076-3-ben.widawsky@intel.com> <CAPcyv4hHJcPLRJM-7z+wKhjBhp9HH2qXuEeC0VfDnD6yU9H-Wg@mail.gmail.com>
 <20220217183628.6iwph6w3ndoct3o3@intel.com>
In-Reply-To: <20220217183628.6iwph6w3ndoct3o3@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 17 Feb 2022 11:57:59 -0800
Message-ID: <CAPcyv4gTgwmeX_WpsPdZ1K253XmwXwWU4629PKB__n4MF6CeFQ@mail.gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 17, 2022 at 10:36 AM Ben Widawsky <ben.widawsky@intel.com> wrot=
e:
>
> Consolidating earlier discussions...
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
> Okay. It might save us some back and forth if you could outline everythin=
g you'd
> expect to be validated, but I can also make an attempt to figure out the
> reasonable set of things.

Input validation. Every value that gets written to a sysfs attribute
should be checked for validity, more below:

>
> > >
> > > A example is provided below:
> > >
> > > /sys/bus/cxl/devices/region0.0:0
> > > =E2=94=9C=E2=94=80=E2=94=80 interleave_granularity

...validate granularity is within spec and can be supported by the root dec=
oder.

> > > =E2=94=9C=E2=94=80=E2=94=80 interleave_ways

...validate ways is within spec and can be supported by the root decoder.

> > > =E2=94=9C=E2=94=80=E2=94=80 offset
> > > =E2=94=9C=E2=94=80=E2=94=80 size

...try to reserve decoder capacity to validate that there is available spac=
e.

> > > =E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../../../../../../bus/cxl
> > > =E2=94=9C=E2=94=80=E2=94=80 target0

...validate that the target maps to the decoder.

> > > =E2=94=9C=E2=94=80=E2=94=80 uevent
> > > =E2=94=94=E2=94=80=E2=94=80 uuid

...validate that the uuid is unique relative to other regions.

> >
> > As mentioned off-list, it looks like devtype and modalias are missing.
> >
>
> Yep. This belongs in the previous patch though.
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
> It was meant to be relative. I can make it absolute if that's preferable =
but the
> physical base is known at the decoder level already.

Yes, but it saves userspace a step to get the absolute value here and
matches what happens in PCI sysfs where the user is not required to
look up the bridge base to calculate the absolute value.

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
> >
>
> Since this is the configuration part of the ABI, I'd rather add that info=
rmation
> when the plumbing to report them exists. I'm struggling to understand the
> balance (as mentioned also earlier in this mail thread) as to what usersp=
ace
> does and what the kernel does. I will add these as you request.

Userspace asks by DPA size and SPA size and the kernel validates /
performs the allocation on its behalf.

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
> Okay. Since we're moving toward making the sysfs ABI stateful,

sysfs is always stateful. Stateless would be an ioctl.

> would you like me
> to make the attrs only visible when they can actually be set?

No, that's a bit too much magic, and it would be racy.

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
> Correct.
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
>
> Okay.
>
> >
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
> The idea behind this was to give the reviewer somewhat of a bigger pictur=
e as to
> how things should work in the code rather than in a commit message. I wil=
l
> remove this.

They look premature to me.

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
> >
> > Also, if memdevs autoremove themselves from regions at memdev
> > ->remove() time then I don't think the region needs to hold references
> > on memdevs.
> >
>
> This needs some work. The concern I have is region operations will need t=
o
> operate on memdevs/decoders at various points in time. When the memdev go=
es
> away, the region will also need to go away. None of that plumbing was in =
place
> in v3 and the reference on the memdev was just a half-hearted attempt at =
doing
> the right thing.
>
> For now if you prefer I remove the reference, but perhaps the decoder ref=
erence
> would buy us some safety?

So, I don't want to merge an interim solution. I think this series
needs to prove out the end to end final ABI with all the lifetime
issues worked out before committing to it upstream because lifetime
issues get much harder to fix when they also need to conform to a
legacy ABI.

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
>
> Initially my thought here is that this is a problem for userspace to deal=
 with.
> If userspace can't figure out how to synchronously configure and bind the
> region, that's not a kernel problem.

The kernel always needs to protect itself. Userspace is free to race
itself, but it can not be allowed to trigger a kernel race. So there
needs to be protection against userspace writing interleave_ways and
the kernel being able to trust that interleave_ways is now static for
the life of the region.

> However, we've put some effort into
> protecting userspace from itself in the create ABI, so it might be more i=
n line
> to do that here.

That safety was about preventing userspace from leaking kernel memory,
not about protecting userspace from itself. It's still the case that
userspace racing itself will get horribly confused when it collides
region creation, but the kernel protects itself by resolving the race.

> In summary, I'm fine to add it, but I think I really need to get more in =
your
> brain about the userspace/kernel divide sooner rather than later.

Don't let userspace break the kernel, that's it.

>
> >
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
> copypasta
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
> Okay. One of the earlier versions did this implicitly since the #ways was=
 needed
> to create the region. I thought from the ABI perspective, flexibility was=
 good.
> Userspace may choose not to utilize it.

More flexibility =3D=3D more maintenance burden. If it's not strictly
necessary, don't expose it, so making this read-only seems simpler to
me.

[..]
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
>
> I might have messed it up, but I didn't seem to run into an issue. With t=
he
> driver bound check though, it can go away.
>
> I think it would be really good to add this kind of detail to sysfs.rst. =
Quick
> grep finds me arm64/kernel/mte and the nfit driver taking the device lock=
 in an
> attr.

Yeah, CONFIG_PROVE_{NVDIMM,CXL}_LOCKING needs to annotate the
driver-core as well. I'm concerned there's a class of deadlocks that
lockdep just can't see.

>
>
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
> I think show_target should just return the chosen decoder and then the de=
coder
> attributes will tell the rest, wouldn't they?

Given the conflicts that can arise between HDM decoders needing to map
increasing DPA values and other conflicts that there will be
situations where the kernel auto-picking a decoder will get in the
way. Exposing the decoder selection to userspace also gives one more
place to do leaf validation. I.e. at decoder-to-region assignment time
the kernel can validate that the DPA is available and can be mapped by
the given decoder given the state of other decoders on that device.

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
> Per above, I think making this decoders makes sense. I could make it flex=
ible
> for ease of use, like if you specify memX, the kernel will pick a decoder=
 for
> you however I suspect you won't like that.

Right, put the user friendliness in the tooling, not sysfs ABI.

>
> > > +       if (!memdev_dev) {
> > > +               device_unlock(&cxlr->dev);
> > > +               return -ENOENT;
> > > +       }
> > > +
> > > +       /* reference to memdev held until target is unset or region g=
oes away */
> > > +
> > > +       cxlmd =3D to_cxl_memdev(memdev_dev);
> > > +       cxlr->config.targets[n] =3D cxlmd;
> > > +
> > > +       device_unlock(&cxlr->dev);
> > > +
> > > +       return len;
> > > +}
> > > +
> > > +#define TARGET_ATTR_RW(n)                                           =
           \
> > > +       static ssize_t target##n##_show(                             =
          \
> > > +               struct device *dev, struct device_attribute *attr, ch=
ar *buf)  \
> > > +       {                                                            =
          \
> > > +               return show_targetN(to_cxl_region(dev), buf, (n));   =
          \
> > > +       }                                                            =
          \
> > > +       static ssize_t target##n##_store(struct device *dev,         =
          \
> > > +                                        struct device_attribute *att=
r,        \
> > > +                                        const char *buf, size_t len)=
          \
> > > +       {                                                            =
          \
> > > +               return set_targetN(to_cxl_region(dev), buf, (n), len)=
;         \
> > > +       }                                                            =
          \
> > > +       static DEVICE_ATTR_RW(target##n)
> > > +
> > > +TARGET_ATTR_RW(0);
> > > +TARGET_ATTR_RW(1);
> > > +TARGET_ATTR_RW(2);
> > > +TARGET_ATTR_RW(3);
> > > +TARGET_ATTR_RW(4);
> > > +TARGET_ATTR_RW(5);
> > > +TARGET_ATTR_RW(6);
> > > +TARGET_ATTR_RW(7);
> > > +TARGET_ATTR_RW(8);
> > > +TARGET_ATTR_RW(9);
> > > +TARGET_ATTR_RW(10);
> > > +TARGET_ATTR_RW(11);
> > > +TARGET_ATTR_RW(12);
> > > +TARGET_ATTR_RW(13);
> > > +TARGET_ATTR_RW(14);
> > > +TARGET_ATTR_RW(15);
> > > +
> > > +static struct attribute *interleave_attrs[] =3D {
> > > +       &dev_attr_target0.attr,
> > > +       &dev_attr_target1.attr,
> > > +       &dev_attr_target2.attr,
> > > +       &dev_attr_target3.attr,
> > > +       &dev_attr_target4.attr,
> > > +       &dev_attr_target5.attr,
> > > +       &dev_attr_target6.attr,
> > > +       &dev_attr_target7.attr,
> > > +       &dev_attr_target8.attr,
> > > +       &dev_attr_target9.attr,
> > > +       &dev_attr_target10.attr,
> > > +       &dev_attr_target11.attr,
> > > +       &dev_attr_target12.attr,
> > > +       &dev_attr_target13.attr,
> > > +       &dev_attr_target14.attr,
> > > +       &dev_attr_target15.attr,
> > > +       NULL,
> > > +};
> > > +
> > > +static umode_t visible_targets(struct kobject *kobj, struct attribut=
e *a, int n)
> > > +{
> > > +       struct device *dev =3D container_of(kobj, struct device, kobj=
);
> > > +       struct cxl_region *cxlr =3D to_cxl_region(dev);
> > > +
> > > +       if (n < cxlr->config.interleave_ways)
> > > +               return a->mode;
> > > +       return 0;
> > > +}
> > > +
> > > +static const struct attribute_group region_interleave_group =3D {
> > > +       .attrs =3D interleave_attrs,
> > > +       .is_visible =3D visible_targets,
> > > +};
> > > +
> > > +static const struct attribute_group *region_groups[] =3D {
> > > +       &region_group,
> > > +       &region_interleave_group,
> > > +       NULL,
> > > +};
> > > +
> > >  static void cxl_region_release(struct device *dev);
> > >
> > >  static const struct device_type cxl_region_type =3D {
> > >         .name =3D "cxl_region",
> > >         .release =3D cxl_region_release,
> > > +       .groups =3D region_groups
> > >  };
> > >
> > >  static ssize_t create_region_show(struct device *dev,
> > > @@ -108,8 +405,11 @@ static void cxl_region_release(struct device *de=
v)
> > >  {
> > >         struct cxl_decoder *cxld =3D to_cxl_decoder(dev->parent);
> > >         struct cxl_region *cxlr =3D to_cxl_region(dev);
> > > +       int i;
> > >
> > >         ida_free(&cxld->region_ida, cxlr->id);
> > > +       for (i =3D 0; i < cxlr->config.interleave_ways; i++)
> > > +               remove_target(cxlr, i);
> >
> > Like the last patch this feels too late. I expect whatever unregisters
> > the region should have already handled removing the targets.
> >
>
> Would remove() be more appropriate?

->remove() does not seem a good fit since it may be the case that
someone wants do "echo $region >
/sys/bus/cxl/drivers/cxl_region/unbind; echo $region >
/sys/bus/cxl/drivers/cxl_region/bind;" without needing to go
reconfigure the targets. I am suggesting that before
device_unregister(&cxlr->dev) the targets are released.
