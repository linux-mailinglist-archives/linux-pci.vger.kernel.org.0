Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380BA4A7EDA
	for <lists+linux-pci@lfdr.de>; Thu,  3 Feb 2022 06:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbiBCFGx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 00:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiBCFGx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Feb 2022 00:06:53 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CD1C061714
        for <linux-pci@vger.kernel.org>; Wed,  2 Feb 2022 21:06:53 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id oa14-20020a17090b1bce00b001b61aed4a03so1748455pjb.5
        for <linux-pci@vger.kernel.org>; Wed, 02 Feb 2022 21:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1JHTwPLvgnSdOvlUJPxurry7jIgozOgrWp88o7ApzHU=;
        b=AImR9zJ8OCzu9bnDTiEZfXEseEPGFUn05Zvepykpqlqvc7RbeCSp/6iFOcJwPh3ez+
         mDzMWl8Ox2lVLXTIQBCLACcbdQUsEpZLb5ojevv6AIVNO8tr8j7hKr9WjmyVXnG58cpl
         A89iTphpwTxZOuOIrayeZTiGDs6sHmRWimjAwiJ4LNmeBCW2mDZIywU3PKdtN4mQxggj
         JV4nzC4yN2pcQvLlsE2+r2Olgl40ix4pYgT0n9/atZn8deGCRee0ulyBlmfzvUhOCGm1
         SehZ0KEnjS34j2Ni/SdCmznHupRuOgWnY9p5PBoW3CfbDjm422am9J9EXUSUGrhNAdwW
         kRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1JHTwPLvgnSdOvlUJPxurry7jIgozOgrWp88o7ApzHU=;
        b=gLTwyyTTHpAaK85eqTWfKnf2yjRQdccIFC7MgL82+I8/fv4ZhUa/sUM/UaUyduKZNX
         iN+z0s8mLpU6Jend8wM9adP03YyC5YVntBFyzcqoLuTD6b1U7thOG6kzo+AoByk7iOXu
         +DDS5eYcatobIv4Y6cEpoSSkG7K3ft+seYCQ5CBzMD5joeBCKbiMiur6HpARYuq8aVGZ
         DQVIJPcgWR5Zxli1b8CuYLviWD0rpGK4a/shUhN8fsaSdyurVEHZShH2Py+ra1bWyC6Z
         fTFJCpyQ1aBeD5rh2JjrziZa0QGRSgoOTLTYIhxCYqSBdkeFo69FuK7W1nLT29vAg24L
         Np+g==
X-Gm-Message-State: AOAM530n/FymHmRClslwIb2cSu136ZiA2og9bJ1eEEgKSWVpen+lM6Np
        m7lR7yK2IIvUcrIAobTWMjv0aZH88Gva9OZ1SedgGg==
X-Google-Smtp-Source: ABdhPJxqM77is0yFSyX0KGpP8UcSw0l8m3YOfuSF4sUAAILJspUd73S24QbhCyeq0gImKi2X1JHSEnWeU5sIcL9wz+g=
X-Received: by 2002:a17:902:b20a:: with SMTP id t10mr33736247plr.132.1643864812773;
 Wed, 02 Feb 2022 21:06:52 -0800 (PST)
MIME-Version: 1.0
References: <20220128002707.391076-1-ben.widawsky@intel.com>
 <20220128002707.391076-3-ben.widawsky@intel.com> <CAPcyv4hHJcPLRJM-7z+wKhjBhp9HH2qXuEeC0VfDnD6yU9H-Wg@mail.gmail.com>
 <20220201145943.mevjv3rygo43o2lf@intel.com>
In-Reply-To: <20220201145943.mevjv3rygo43o2lf@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 2 Feb 2022 21:06:40 -0800
Message-ID: <CAPcyv4jNDRwgOFKtaVf2KZtMOWag2=zTbiUq=R-5UJ_BV6kNmA@mail.gmail.com>
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
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 1, 2022 at 6:59 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> I will cut to the part that effects ABI so tool development can continue. I'll
> get back to the other bits later.
>
> On 22-01-28 16:25:34, Dan Williams wrote:
>
> [snip]
>
> >
> > > +
> > > +       return ret;
> > > +}
> > > +
> > > +static size_t set_targetN(struct cxl_region *cxlr, const char *buf, int n,
> > > +                         size_t len)
> > > +{
> > > +       struct device *memdev_dev;
> > > +       struct cxl_memdev *cxlmd;
> > > +
> > > +       device_lock(&cxlr->dev);
> > > +
> > > +       if (len == 1 || cxlr->config.targets[n])
> > > +               remove_target(cxlr, n);
> > > +
> > > +       /* Remove target special case */
> > > +       if (len == 1) {
> > > +               device_unlock(&cxlr->dev);
> > > +               return len;
> > > +       }
> > > +
> > > +       memdev_dev = bus_find_device_by_name(&cxl_bus_type, NULL, buf);
> >
> > I think this wants to be an endpoint decoder, not a memdev. Because
> > it's the decoder that joins a memdev to a region, or at least a
> > decoder should be picked when the memdev is assigned so that the DPA
> > mapping can be registered. If all the decoders are allocated then fail
> > here.
> >
>
> You've put two points in here:
>
> 1. Handle decoder allocation at sysfs boundary. I'll respond to this when I come
> back around to the rest of the review comments.
>
> 2. Take a decoder for target instead of a memdev. I don't agree with this
> direction as it's asymmetric to how LSA processing works. The goal was to model
> the LSA for configuration. The kernel will have to be in the business of
> reserving and enumerating decoders out of memdevs for both LSA (where we have a
> list of memdevs) and volatile (where we use the memdevs in the system to
> enumerate populated decoders). I don't see much value in making userspace do the
> same.
>
> I'd like to ask you reconsider if you still think it's preferable to use
> decoders as part of the ABI and if you still feel that way I can go change it
> since it has minimal impact overall.

It's more than a preference. I think there are fundamental recovery
scenarios where the kernel needs userspace help to resolve decoder /
DPA assignment and conflicts.

PMEM interleaves behave similarly to RAID where you have multiple
devices in a set that can each fail independently, and because they
are hotplug capable the chances of migrating devices from one system
to another are higher than PMEM devices today where hotplug is mostly
non-existent. If you lurk on linux-raid long enough you will
inevitably encounter someone coming to the list saying, "help a drive
in my RAID array was dying. I managed to save it off, help me
reassemble my array". The story often gets worse when they say "I
managed to corrupt my metadata block, so I don't know what order the
drives are supposed to be in". There are several breadcrumbs and trial
and error steps that one takes to try to get the data back online:
https://raid.wiki.kernel.org/index.php/RAID_Recovery.

Now imagine that scenario with CXL where there are additional
complicating factors like label-storage-area can fail independently of
the data area, there are region labels with HPA fields that mandate
assembly at a given address, decoders must be programmed in increasing
DPA order, volatile memory and locked/fixed decoders complicate
decoder selection. Considering all the ways that CXL region assembly
can fail it seems inevitable that someone will get into a situation
where they need to pick the decoder and the DPA to map while also not
clobbering the LSA. I.e. I see a "CXL Recovery" wiki in our future.

The requirements that I think fall out from that are:

1/ Region assembly needs to be possible without updating labels. So,
in contrast to the way that nvdimm does it, instead of updating the
region label on every attribute write there would be a commit step
that realizes the current region configuration in the labels, or is
ommitted in recovery scenarios where you are not ready to clobber the
labels.

2/ Userspace needs the flexibility to be able to select/override which
DPA gets mapped in which decoder (kernel would handle DPA skip).

All the ways I can think of to augment the ABI to allow for this style
of recovery devolve to just assigning decoders to regions in the first
instance.
