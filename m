Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B504A9129
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 00:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355993AbiBCX1R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 18:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240907AbiBCX1R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Feb 2022 18:27:17 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164E1C06173B
        for <linux-pci@vger.kernel.org>; Thu,  3 Feb 2022 15:27:17 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id y5-20020a17090aca8500b001b8127e3d3aso4483492pjt.3
        for <linux-pci@vger.kernel.org>; Thu, 03 Feb 2022 15:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BsyblFTmw+r35ga77s3th7VRl5YZ95yIbDncHVc3CwA=;
        b=e+FUaAtomXP56EwVWn4BuwpGpvYl4YQM7pG4oxgQNn45tNFG5riFGIvo3/r9SuLfwF
         n1wFpJH8gKTkiTbktN6vdtjWmK9EXwQjEA8+zGlN8Int9bd71XHmRbdfzNM6452KKvyK
         aMIg6aRhWNcobFrh72guWDPhLg0lHz9UnG74ZPwTy5155OhElQ5Iu17EdBBt6lc1yIeq
         dgWBKblxpwRSm6v1iQNTLz9uUVUKUHRvqvZrJ6FHOHb9iIr2dJV7hN8No5e1Xon6XBKr
         quz2oQFkDH56iNPWIj8x68fHzIPZqaEAV6a9M5pK9GBnCCgiVCLsyUCyIgsfg3ODF3dg
         Jmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BsyblFTmw+r35ga77s3th7VRl5YZ95yIbDncHVc3CwA=;
        b=oOmdCN2+bOjzRgGPEb1UHFAALqpudjaCCfk+VEsjwjNpHrI2n5Gai71BRcjxJui5Fn
         878SFekyU7u3KQEn8il3o4vYgRnPggfLCMFmDkhFi1znwAerXtjJf/SmFV1phIVeRmNx
         RQF4IFsbfnou8wLE7eBajcBEWH/GQQNnc6rvcysBqQ1xNIz9AKd1fRcFQhWt2EUCxoI3
         aaxl+jKKa6/ZdcPQf0+vuE3OandKkHXanrCQhcv+mxKjBVunGr1c3tZbLol6Z+XR7Xhp
         N7A/ZWhSZeMMY2TXnuJeyR3WeZD3kfUBbWOLsMJkajqnf2kyXy432yCRhn+9URHmMd9z
         Elkw==
X-Gm-Message-State: AOAM531RRGTpZexbRmhhjcdcC1tTEeiHBiWkphjEjVjXRHuQbWjmGxtk
        vCwkkk08RaExA2s3DS8gf5lYkr1vAiBR2sDFVpnpTA==
X-Google-Smtp-Source: ABdhPJzEUtyjmmacvDfTXnelwWli6Ri0H9Z6WDKS4HmGdq7uyuvN9ne5eixusBC3CvFjQUXEhYGsd1zm9YB/Q+V0jSY=
X-Received: by 2002:a17:902:bcca:: with SMTP id o10mr385365pls.147.1643930836509;
 Thu, 03 Feb 2022 15:27:16 -0800 (PST)
MIME-Version: 1.0
References: <20220128002707.391076-1-ben.widawsky@intel.com>
 <20220128002707.391076-3-ben.widawsky@intel.com> <CAPcyv4hHJcPLRJM-7z+wKhjBhp9HH2qXuEeC0VfDnD6yU9H-Wg@mail.gmail.com>
 <20220201231117.lksqoukbvss6e3ec@intel.com> <CAPcyv4iGQWXX8rzCH7BJUSyvDXbdiuHw4kLiuqGmVVBGTh2a1Q@mail.gmail.com>
 <20220203222300.gf4st36yoqjxq5q6@intel.com>
In-Reply-To: <20220203222300.gf4st36yoqjxq5q6@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 3 Feb 2022 15:27:02 -0800
Message-ID: <CAPcyv4icq8_9E+ziU5KKYrAepUtNP32Qf6wYGYpcUU2K1P4mAA@mail.gmail.com>
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

On Thu, Feb 3, 2022 at 2:23 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 22-02-03 09:48:49, Dan Williams wrote:
> > On Tue, Feb 1, 2022 at 3:11 PM Ben Widawsky <ben.widawsky@intel.com> wr=
ote:
> > >
> > > On 22-01-28 16:25:34, Dan Williams wrote:
> > > > On Thu, Jan 27, 2022 at 4:27 PM Ben Widawsky <ben.widawsky@intel.co=
m> wrote:
> > > > >
> > > > > The region creation APIs create a vacant region. Configuring the =
region
> > > > > works in the same way as similar subsystems such as devdax. Sysfs=
 attrs
> > > > > will be provided to allow userspace to configure the region.  Fin=
ally
> > > > > once all configuration is complete, userspace may activate the re=
gion.
> > > > >
> > > > > Introduced here are the most basic attributes needed to configure=
 a
> > > > > region. Details of these attribute are described in the ABI
> > > >
> > > > s/attribute/attributes/
> > > >
> > > > > Documentation. Sanity checking of configuration parameters are do=
ne at
> > > > > region binding time. This consolidates all such logic in one plac=
e,
> > > > > rather than being strewn across multiple places.
> > > >
> > > > I think that's too late for some of the validation. The complex
> > > > validation that the region driver does throughout the topology is
> > > > different from the basic input validation that can  be done at the
> > > > sysfs write time. For example ,this patch allows negative
> > > > interleave_granularity values to specified, just return -EINVAL. I
> > > > agree that sysfs should not validate everything, I disagree with
> > > > pushing all validation to cxl_region_probe().
> > > >
> > >
> > > Two points:c
> > > 1. How do we distinguish "basic input validation". It'd be good if we=
 could
> > >    define "basic input validation". For instance, when I first wrote =
these
> > >    patches, x3 would have been EINVAL, but today it's allowed. Can yo=
u help
> > >    enumerate what you consider basic.
> >
> > I internalized this kernel design principle from Dave Miller many
> > years ago paraphrasing "push decision making out to leaf code as much
> > as possible", and centralizing all validation in cxl_region_probe()
> > violates. The software that makes the mistake does not know it made a
> > mistake until much later and "probe failed" is less descriptive than
> > "EINVAL writing interleave_ways" . I wish I could find the thread
> > because it also talked about his iteration process.
>
> It would definitely be interesting to understand why pushing decision mak=
ing
> into the leaf code is a violation. Was it primary around the descriptiven=
ess of
> the error?

You mean the other way round, why is it a violation to move decision
making into the core? It was a comment about the inflexibility of the
core logic vs leaf logic, in the case of CXL it's about the
observability of errors at the right granularity which the core can
not do because the core is disconnected from the transaction that
injected the error.

> > Basic input validation to me is things like:
> >
> > - Don't allow writes while the region is active
> > - Check that values are in bound. So yes, the interleave-ways value of
> > 3 would fail until the kernel supports it, and granularity values >
> > 16K would also fail.
> > - Check that memdevs are actually downstream targets of the given decod=
er
> > - Check that the region uuid is unique
>
> These are obviously easy and informative at attr store time (in fact, act=
ive was
> meant to be checked already for many cases). So if we agree to codify thi=
s at
> probe via WARN, and add it to kdoc, I've no problem with it.

Why is WARN needed? Either the sysfs validation does it job correctly
or it doesn't. Also if sysfs didn't WARN when the bad input is
specified why would the core do anything higher than dev_err()?
Basically I think the bar for WARN is obvious kernel programming error
where only a kernel-developer will see it vs EINVAL at runtime
scenarios. I have seen Greg raise the bar for WARN in his reviews
given how many deployments turn on 'panic_on_warn'.

> > - Check that decoder has capacity
> > - Check that the memdev has capacity
> > - Check that the decoder to map the DPA is actually available given
> > decoders must be programmed in increasing DPA order
> >
> > Essentially any validation short of walking the topology to program
> > upstream decoders since those errors are only resolved by racing
> > region probes that try to grab upstream decoder resources.
> >
>
> I intentionally avoided doing a lot of these until probe because it seeme=
d like
> not a great policy to deny regions from being populated if another region
> utilizing those resources hasn't been bound yes. For a simple example, if=
 x1
> region A is created and utilizes all of memdev =C9=91's capacity you bloc=
k out any
> other region setup using memdev =C9=91, even if region A wasn't bound. Th=
ere's a
> similar problem with specifying decoders as part of configuration.
>
> I'll infer from your comment that you are fine with this tradeoff, or you=
 have
> some other way to manage this in mind.

It comes back to observability if threadA allocates all the DPA then
yes all other threads should see -ENOSPC. No different than if 3 fdisk
threads all tried to create a partition, the first one to the kernel
wins. If threadA does not end up activating that regionA's capacity
that's userspace's fault, and the admin needs to make sure that
configuration does not race itself. The kernel allocating DPA
immediately lets those races be found early such that threadB finds
all the DPA gone and stops trying to create the region.

> I really see any validation which requires removal of resources from the =
system
> to be more fit for bind time. I suppose if the proposal is to move the re=
gion
> attributes to be DEVICE_ATTR_ADMIN, that pushes the problem onto the syst=
em
> administrator. It just seemed like most of the interface could be non-roo=
t.

None of the sysfs entries for CXL are writable by non-root.

DEVICE_ATTR_RW() is 0644
DEVICE_ATTR_ADMIN_RW() is 0600

Yes, pushing the problem onto the sysadmin is the only option. Only
CAP_SYS_ADMIN can be trusted to muck with the physical address layout
of the system. Even then CONFIG_LOCKDOWN_KERNEL wants to limit what
CAP_SYS_ADMIN can to do the memory configuration, so I don't see any
room for non-root to be considered in this ABI.

>
> > >
> > > 2. I like the idea that all validation takes place in one place. Obvi=
ously you
> > >    do not. So, see #1 and I will rework.
> >
> > The validation helpers need to be written once, where they are called
> > does not much matter, does it?
> >
>
> Somewhat addressed above too...
>
> I think that depends on whether the full list is established as mentioned=
. If in
> the region driver we can put several assertions that a variety of things =
don't
> need [re]validation, then it doesn't matter. Without this, when trying to=
 debug
> or add code you need to figure out which place is doing the validation an=
d which
> place should do it.

All I can say it has not been a problem in practice for NVDIMM debug
scenarios which does validation at probe for pre-existing namespaces
and validation at sysfs write for namespace creation.

> At the very least I think the plan should be established in a kdoc.

Sure, a "CXL Region: Theory of Operation" would be a good document to
lead into the patch series as a follow-on to "CXL Bus: Theory of
Operation".
