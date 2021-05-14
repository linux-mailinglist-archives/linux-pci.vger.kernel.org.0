Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314373811D2
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 22:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhENUa5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 16:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhENUa4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 May 2021 16:30:56 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914B5C061574
        for <linux-pci@vger.kernel.org>; Fri, 14 May 2021 13:29:44 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id n25so36057668edr.5
        for <linux-pci@vger.kernel.org>; Fri, 14 May 2021 13:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5yLL40jnp/JyochnQZGNB1kpm63b4ANhjiGt5dp8TwM=;
        b=EgFraUSBIbTQFFJbEIeB6T/26SFYGJlZBeS4e/DmQRBg6Jw2BQ37gymJBPeVX1ynng
         gLsbaKnm39XSGjgjcsOBrClWV9P2towyHWblzwNVlQ5dSUJxsf/jrcHUhk9MXKI9aUnP
         JOOFtbsCLXmzDvH70ekrNT7i7O87hx19FvLtC/dcHBQ4UON2Po//U6OZQha99KSVmVys
         Bs4ECRfRkRaYYKC/8sjpwUGc6BxWndaakM2RlpCKAkf12+Kms37etfKiOLo1r5Rv08Rn
         DeKNSXZj3Px380vwYPhSzVfDA0eI75tyQygSFJHLeyGRqV0WVM8ygu1y5XhhD22agMYF
         J05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5yLL40jnp/JyochnQZGNB1kpm63b4ANhjiGt5dp8TwM=;
        b=t3+wKTRd/b8M3RaYYIww9Q5abwI2VZdG3BuujO323KwhjEjWFO7XUnm/WB0pia0SrK
         Wx4goNG9tCEupXc8g0Y0gKvX0JZYdBqpx+idiNkP58AHV8x86Sv4QXJuxoHaHSLBK/it
         pI20zkRcDqWm6iUSBfwGKTTRkyQElRGxDqy/dlTSmSh3k5ciyOUsbC6P18QwUs+i0S8n
         O/hGe2kHGQPqdv3ZFwYXJEWi7U0g2vtsK67xOSbXfAwOMb3axfgpWwIZwvUtNbidHgYG
         HQEVOGa4Y2fuFeNOPN/mEw5JhnEQkzcvFM0MWtWsdvGTwBft5kz2Rtg/Rvx3OYd3GuVR
         lGXQ==
X-Gm-Message-State: AOAM530KzLPt4RS3aPTctLR7+oVR7mYhBelB06yRIDvefQKX32t8RWdD
        qiWa3TEl1l7mgrxNy4gAzQHVZ8/9ay1mnmAY1CFFhA==
X-Google-Smtp-Source: ABdhPJwjzR90EU3j4VM/TAeOVfah6Sp56DGhezKrSqeaGKYeBzA45aUC74juyu0klKi5Wj1G+W3dP6rGWk4obKEa6RE=
X-Received: by 2002:a05:6402:128f:: with SMTP id w15mr12334574edv.354.1621024183325;
 Fri, 14 May 2021 13:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <162096970332.1865304.10280028741091576940.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162096973052.1865304.12885652112595883151.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210514101700.00004fbc@Huawei.com>
In-Reply-To: <20210514101700.00004fbc@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 14 May 2021 13:29:32 -0700
Message-ID: <CAPcyv4jodAKZjAPQf6Q87o3JQ2sSJLmCTS1PdQ_oKyCRuVJqEg@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] cxl/acpi: Introduce ACPI0017 driver and cxl_root
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 14, 2021 at 2:19 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 13 May 2021 22:22:10 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > While CXL builds upon the PCI software model for dynamic enumeration and
> > control, a static platform component is required to bootstrap the CXL
> > memory layout. In addition to identifying the host bridges ACPI is
> > responsible for enumerating the CXL memory space that can be addressed
> > by decoders. This is similar to the requirement for ACPI to publish
> > resources reported by _CRS for PCI host bridges.
> >
> > Introduce the cxl_root object as an abstract "port" into the CXL.mem
> > address space described by HDM decoders identified by the ACPI
> > CEDT.CHBS.
> >
> > For now just establish the initial boilerplate and sysfs attributes, to
> > be followed by enumeration of the ports within the host bridge.
> >
> > Note the allocation of CXL core device objects is split into separate
> > alloc and add steps in order to separate the alloc error path (kfree())
> > from the device add error path (put_device()).
> >
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> A few really minor editorial things in the docs that need tidying up.

Sure, I'm going to see if b4 can follow a v5 reply to just this one
patch, or otherwise hack it to support that flow so I don't need to
resend the full series.

> With that done
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> I'll make the bold assumption that this is going to get applied
> before the DOE series and base that on top of this one.

Yes, the plan is to make the 'next' branch of:

git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git

...the stable non-rebasing development branch for contributions. bf gntcbttttt

>
> Thanks,
>
> Jonathan
>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl |   78 +++++++
> >  drivers/cxl/Kconfig                     |   14 +
> >  drivers/cxl/Makefile                    |    2
> >  drivers/cxl/acpi.c                      |   39 +++
> >  drivers/cxl/core.c                      |  360 +++++++++++++++++++++++++++++++
> >  drivers/cxl/cxl.h                       |   65 ++++++
> >  6 files changed, 558 insertions(+)
> >  create mode 100644 drivers/cxl/acpi.c
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > index 2fe7490ad6a8..d21469e2bf8b 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -24,3 +24,81 @@ Description:
> >               (RO) "Persistent Only Capacity" as bytes. Represents the
> >               identically named field in the Identify Memory Device Output
> >               Payload in the CXL-2.0 specification.
> > +
> > +What:           /sys/bus/cxl/devices/address_spaceX/start
> > +Date:           May, 2021
> > +KernelVersion:  v5.14
> > +Contact:        linux-cxl@vger.kernel.org
> > +Description:
>
> I'm not that fussy about this, but others may comment on wrapping lines around 70 chars
> whereas can at least go to 80 for docs.

Sure I can reflow.

>
> > +             (RO) System-physical base address for an address range
> > +             that supports CXL.mem targets. A CXL address space can
> > +             be optionally populated with endpoints that decode that
> > +             range, similar to how devices behind a PCI bridge can
> > +             decode a portion of the bridge's secondary bus address
> > +             space.
> > +
> > +What:           /sys/bus/cxl/devices/address_spaceX/end
> > +Date:           May, 2021
> > +KernelVersion:  v5.14
> > +Contact:        linux-cxl@vger.kernel.org
> > +Description:
> > +             (RO) System-physical end address for an address range
> > +             that supports CXL.mem targets. A CXL address space can
> > +             be optionally populated with endpoints that decode that
> > +             range, similar to how devices behind a PCI bridge can
> > +             decode a portion of the bridge's secondary bus address
> > +             space.
> > +
> > +What:                /sys/bus/cxl/devices/address_spaceX/supports_ram
>
> Inconsistent tabs vs spaces.

ok.
