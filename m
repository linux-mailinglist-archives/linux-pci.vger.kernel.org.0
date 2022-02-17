Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F9C4BAB93
	for <lists+linux-pci@lfdr.de>; Thu, 17 Feb 2022 22:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbiBQVMh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Feb 2022 16:12:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240788AbiBQVMg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Feb 2022 16:12:36 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C2E28E35
        for <linux-pci@vger.kernel.org>; Thu, 17 Feb 2022 13:12:19 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id z17so5531161plb.9
        for <linux-pci@vger.kernel.org>; Thu, 17 Feb 2022 13:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=efHZusumUQaH81p0aIbMFGdUJidKe0NJ7mb6NRFMjFU=;
        b=KdoAZwnr1w3+BlHzOezDLQIhP0jxOW8VQOrGS8dFnXH6/cNdPAW3WEfEcRVbXVQunp
         Qf5WL/1qKcm+YHym2WsNYGJXvArMNIbAzno8YYcX8DbSAjtZ2ugEk/wB/PKDHpoPeIZR
         fOpV59Z8lZzW+NjKGOsenT9IWrltdrvlp9XTy03Veo3f0K4Ouenw09xsK2SUK/6d8BNG
         xzLRlWQrdZaK8N5we3CrlDU4QEis3dmfR+0x/q9N+QqEVOoGzLZ3qVvbILzp4+0+9o+R
         jz2n69MmLxWlSGqoqAcbrI3ek0mUL3cC2Qrv41hBJ7CLQhrTOlDUj52+TVNgZZapWTjx
         i8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=efHZusumUQaH81p0aIbMFGdUJidKe0NJ7mb6NRFMjFU=;
        b=iS0UWAsPHtNlhcaUDMP3rcIpDGf3qmLcL5gl4rWqBWI0eoGdUs38kk8VJhGco9JbFs
         AKGoz+5qwCe6NKUnqn785PRioawnVBgOWXPBKApKytT1XsPnEu4iXja4zc6GbZ6lspXU
         B72qvXaQg0wAWLQdus5YNH/ixRjPbPCIehyo1c3400qZJFOeDS5zaJyfbocb74/mRn+F
         uHIk+6lTUrPZ1tBn6lCJBvMrSHtZG3fx4yW4LPe+kmTYkO71WyrQ7vZl8aPqwVGRM1B5
         T8LzSFwzcyjZdcO+v/lFoF/IREDiU2Urtq9nft2sAz/hL76KWRyZIQqBGxk3XtT48sTr
         ZD2w==
X-Gm-Message-State: AOAM531KRR3CSRr+USaMRAKwO2rZIUmGKCGSdpBzP8h3Xgku0oiHuHIl
        pDZ594VI2wK7WbQXfyNaEmPMpNCBFd90JSQxfkGrFA==
X-Google-Smtp-Source: ABdhPJy9cJNdChndc8Vrn1wy9dgn5q+q5GuaL9Z+UwF53sEQLRfmEi8qElyW06OsYVZTuYdRcbf4vePzvSQD9hqdxsg=
X-Received: by 2002:a17:90b:1a92:b0:1b9:8094:446b with SMTP id
 ng18-20020a17090b1a9200b001b98094446bmr4822838pjb.93.1645132338875; Thu, 17
 Feb 2022 13:12:18 -0800 (PST)
MIME-Version: 1.0
References: <20220128002707.391076-1-ben.widawsky@intel.com>
 <20220128002707.391076-3-ben.widawsky@intel.com> <CAPcyv4hHJcPLRJM-7z+wKhjBhp9HH2qXuEeC0VfDnD6yU9H-Wg@mail.gmail.com>
 <20220217183628.6iwph6w3ndoct3o3@intel.com> <CAPcyv4gTgwmeX_WpsPdZ1K253XmwXwWU4629PKB__n4MF6CeFQ@mail.gmail.com>
 <20220217202024.x6rmx4ypvxi66tek@intel.com>
In-Reply-To: <20220217202024.x6rmx4ypvxi66tek@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 17 Feb 2022 13:12:07 -0800
Message-ID: <CAPcyv4hOFpVRs=D=ppMWv668dX0deaOVYTLG8QxAp45t3ctDfw@mail.gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 17, 2022 at 12:20 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
[..]
> > > > > +static bool is_region_active(struct cxl_region *cxlr)
> > > > > +{
> > > > > +       /* TODO: Regions can't be activated yet. */
> > > > > +       return false;
> > > >
> > > > This function seems redundant with just checking "cxlr->dev.driver !=
> > > > NULL"? The benefit of that is there is no need to carry a TODO in the
> > > > series.
> > > >
> > >
> > > The idea behind this was to give the reviewer somewhat of a bigger picture as to
> > > how things should work in the code rather than in a commit message. I will
> > > remove this.
> >
> > They look premature to me.
> >
>
> Given that you don't want me to reference the DWG, it is. The steps outlined
> with TODOs were all based on the DWG's overall flow.

Right, the DWG is a good bootstrap, but the Linux implementation is
going to go beyond it so might as well couch all the language in terms
of base spec references and Linux documentation and not have this
indirection to a 3rd document.

[..]
> > > > ...to shutdown configuration writes once the region is active. Might
> > > > also need a region-wide seqlock like target_list_show. So that region
> > > > probe drains  all active sysfs writers before assuming the
> > > > configuration is stable.
> > >
> > > Initially my thought here is that this is a problem for userspace to deal with.
> > > If userspace can't figure out how to synchronously configure and bind the
> > > region, that's not a kernel problem.
> >
> > The kernel always needs to protect itself. Userspace is free to race
> > itself, but it can not be allowed to trigger a kernel race. So there
> > needs to be protection against userspace writing interleave_ways and
> > the kernel being able to trust that interleave_ways is now static for
> > the life of the region.
>
> Yeah - originally I was relying on the device_lock for this, but that now
> doesn't work. seqlock is fine. I could also copy all the config information at
> the beginning of probe and simply use that.
>
> If we're going the route of making interleave_ways write-once, why not make all
> attributes the same?

Sure. It could always be relaxed later if there was a convincing need
to modify an existing region without tearing it down first. In fact,
that reconfigure flexibility was a source of bugs in NVDIMM sysfs ABI
that the tooling did not leverage because "ndctl create-namespace
--reconfigure" internally did: read namespace attributes, destroy
namepsace, create new namespace with saved attributes.

[..]
> > > > > +static size_t show_targetN(struct cxl_region *cxlr, char *buf, int n)
> > > > > +{
> > > > > +       int ret;
> > > > > +
> > > > > +       device_lock(&cxlr->dev);
> > > > > +       if (!cxlr->config.targets[n])
> > > > > +               ret = sysfs_emit(buf, "\n");
> > > > > +       else
> > > > > +               ret = sysfs_emit(buf, "%s\n",
> > > > > +                                dev_name(&cxlr->config.targets[n]->dev));
> > > > > +       device_unlock(&cxlr->dev);
> > > >
> > > > The component contribution of a memdev to a region is a DPA-span, not
> > > > the whole memdev. I would expect something like dax_mapping_attributes
> > > > or REGION_MAPPING() from drivers/nvdimm/region_devs.c. A tuple of
> > > > information about the component contribution of a memdev to a region.
> > > >
> > >
> > > I think show_target should just return the chosen decoder and then the decoder
> > > attributes will tell the rest, wouldn't they?
> >
> > Given the conflicts that can arise between HDM decoders needing to map
> > increasing DPA values and other conflicts that there will be
> > situations where the kernel auto-picking a decoder will get in the
> > way. Exposing the decoder selection to userspace also gives one more
> > place to do leaf validation. I.e. at decoder-to-region assignment time
> > the kernel can validate that the DPA is available and can be mapped by
> > the given decoder given the state of other decoders on that device.
> >
>
> Okay, but per below, these are associated with setting the target. The attribute
> show does only need to provide the decoder, then userspace can look at the
> decoder to find if it's active/DPAs/etc.

Yes.

>
> > >
> > > > > +
> > > > > +       return ret;
> > > > > +}
> > > > > +
> > > > > +static size_t set_targetN(struct cxl_region *cxlr, const char *buf, int n,
> > > > > +                         size_t len)
> > > > > +{
> > > > > +       struct device *memdev_dev;
> > > > > +       struct cxl_memdev *cxlmd;
> > > > > +
> > > > > +       device_lock(&cxlr->dev);
> > > > > +
> > > > > +       if (len == 1 || cxlr->config.targets[n])
> > > > > +               remove_target(cxlr, n);
> > > > > +
> > > > > +       /* Remove target special case */
> > > > > +       if (len == 1) {
> > > > > +               device_unlock(&cxlr->dev);
> > > > > +               return len;
> > > > > +       }
> > > > > +
> > > > > +       memdev_dev = bus_find_device_by_name(&cxl_bus_type, NULL, buf);
> > > >
> > > > I think this wants to be an endpoint decoder, not a memdev. Because
> > > > it's the decoder that joins a memdev to a region, or at least a
> > > > decoder should be picked when the memdev is assigned so that the DPA
> > > > mapping can be registered. If all the decoders are allocated then fail
> > > > here.
> > > >
> > >
> > > Per above, I think making this decoders makes sense. I could make it flexible
> > > for ease of use, like if you specify memX, the kernel will pick a decoder for
> > > you however I suspect you won't like that.
> >
> > Right, put the user friendliness in the tooling, not sysfs ABI.
> >
>
> Okay.
>
> > >
> > > > > +       if (!memdev_dev) {
> > > > > +               device_unlock(&cxlr->dev);
> > > > > +               return -ENOENT;
> > > > > +       }
> > > > > +
> > > > > +       /* reference to memdev held until target is unset or region goes away */
> > > > > +
> > > > > +       cxlmd = to_cxl_memdev(memdev_dev);
> > > > > +       cxlr->config.targets[n] = cxlmd;
> > > > > +
> > > > > +       device_unlock(&cxlr->dev);
> > > > > +
> > > > > +       return len;
> > > > > +}
> > > > > +
> > > > > +#define TARGET_ATTR_RW(n)                                                      \
> > > > > +       static ssize_t target##n##_show(                                       \
> > > > > +               struct device *dev, struct device_attribute *attr, char *buf)  \
> > > > > +       {                                                                      \
> > > > > +               return show_targetN(to_cxl_region(dev), buf, (n));             \
> > > > > +       }                                                                      \
> > > > > +       static ssize_t target##n##_store(struct device *dev,                   \
> > > > > +                                        struct device_attribute *attr,        \
> > > > > +                                        const char *buf, size_t len)          \
> > > > > +       {                                                                      \
> > > > > +               return set_targetN(to_cxl_region(dev), buf, (n), len);         \
> > > > > +       }                                                                      \
> > > > > +       static DEVICE_ATTR_RW(target##n)
> > > > > +
> > > > > +TARGET_ATTR_RW(0);
> > > > > +TARGET_ATTR_RW(1);
> > > > > +TARGET_ATTR_RW(2);
> > > > > +TARGET_ATTR_RW(3);
> > > > > +TARGET_ATTR_RW(4);
> > > > > +TARGET_ATTR_RW(5);
> > > > > +TARGET_ATTR_RW(6);
> > > > > +TARGET_ATTR_RW(7);
> > > > > +TARGET_ATTR_RW(8);
> > > > > +TARGET_ATTR_RW(9);
> > > > > +TARGET_ATTR_RW(10);
> > > > > +TARGET_ATTR_RW(11);
> > > > > +TARGET_ATTR_RW(12);
> > > > > +TARGET_ATTR_RW(13);
> > > > > +TARGET_ATTR_RW(14);
> > > > > +TARGET_ATTR_RW(15);
> > > > > +
> > > > > +static struct attribute *interleave_attrs[] = {
> > > > > +       &dev_attr_target0.attr,
> > > > > +       &dev_attr_target1.attr,
> > > > > +       &dev_attr_target2.attr,
> > > > > +       &dev_attr_target3.attr,
> > > > > +       &dev_attr_target4.attr,
> > > > > +       &dev_attr_target5.attr,
> > > > > +       &dev_attr_target6.attr,
> > > > > +       &dev_attr_target7.attr,
> > > > > +       &dev_attr_target8.attr,
> > > > > +       &dev_attr_target9.attr,
> > > > > +       &dev_attr_target10.attr,
> > > > > +       &dev_attr_target11.attr,
> > > > > +       &dev_attr_target12.attr,
> > > > > +       &dev_attr_target13.attr,
> > > > > +       &dev_attr_target14.attr,
> > > > > +       &dev_attr_target15.attr,
> > > > > +       NULL,
> > > > > +};
> > > > > +
> > > > > +static umode_t visible_targets(struct kobject *kobj, struct attribute *a, int n)
> > > > > +{
> > > > > +       struct device *dev = container_of(kobj, struct device, kobj);
> > > > > +       struct cxl_region *cxlr = to_cxl_region(dev);
> > > > > +
> > > > > +       if (n < cxlr->config.interleave_ways)
> > > > > +               return a->mode;
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +static const struct attribute_group region_interleave_group = {
> > > > > +       .attrs = interleave_attrs,
> > > > > +       .is_visible = visible_targets,
> > > > > +};
> > > > > +
> > > > > +static const struct attribute_group *region_groups[] = {
> > > > > +       &region_group,
> > > > > +       &region_interleave_group,
> > > > > +       NULL,
> > > > > +};
> > > > > +
> > > > >  static void cxl_region_release(struct device *dev);
> > > > >
> > > > >  static const struct device_type cxl_region_type = {
> > > > >         .name = "cxl_region",
> > > > >         .release = cxl_region_release,
> > > > > +       .groups = region_groups
> > > > >  };
> > > > >
> > > > >  static ssize_t create_region_show(struct device *dev,
> > > > > @@ -108,8 +405,11 @@ static void cxl_region_release(struct device *dev)
> > > > >  {
> > > > >         struct cxl_decoder *cxld = to_cxl_decoder(dev->parent);
> > > > >         struct cxl_region *cxlr = to_cxl_region(dev);
> > > > > +       int i;
> > > > >
> > > > >         ida_free(&cxld->region_ida, cxlr->id);
> > > > > +       for (i = 0; i < cxlr->config.interleave_ways; i++)
> > > > > +               remove_target(cxlr, i);
> > > >
> > > > Like the last patch this feels too late. I expect whatever unregisters
> > > > the region should have already handled removing the targets.
> > > >
> > >
> > > Would remove() be more appropriate?
> >
> > ->remove() does not seem a good fit since it may be the case that
> > someone wants do "echo $region >
> > /sys/bus/cxl/drivers/cxl_region/unbind; echo $region >
> > /sys/bus/cxl/drivers/cxl_region/bind;" without needing to go
> > reconfigure the targets. I am suggesting that before
> > device_unregister(&cxlr->dev) the targets are released.
>
> Okay.
>
> Why would one want to do this? I acknowledge someone *may* do that. I'd like to
> know what value you see there.

There are several debug and error handling scenarios that say "quiesce
CXL.mem". Seems reasonable to map those to "cxl disable-region", and
seems unreasonable that "cxl disable-region" requires "cxl
create-region" to get back to operational state.
