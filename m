Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB94F4A6991
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 02:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243149AbiBBBSa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 20:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243032AbiBBBS2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 20:18:28 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ADFC06173B
        for <linux-pci@vger.kernel.org>; Tue,  1 Feb 2022 17:18:28 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id cq9-20020a17090af98900b001b8262fe2d5so988646pjb.0
        for <linux-pci@vger.kernel.org>; Tue, 01 Feb 2022 17:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GZoglC+ge1/99sWCkClXyTN7rb8YyTH+ODtl0a/JGbU=;
        b=18M2BdDfm/5B8kM8ilplUX6iGkgJTOHlDzgN2eNKlUZxamjhDokdAusL197I7R72eR
         tKAslpONvIyxbJhcyVg9kgjl4hInCrnaS+Snfo6yyEnqVHtCtksJFqAmBDV476GAuqJ1
         QqLFnyMnoNjSz65W6dPMkA89Vqdq0z+BgCwtXmnJsG/m6rsG4mNT4NcLsq41hndgbF84
         s0HlVR7LNc6Ulx3zzOHMKMBqc9b/MsFzNVFiqZAsT4k6OIehTyMz0tKwALOiPfA6LT5i
         Uitiq4H1dYIN9QGimJf/uTfQSga/JlnYqdQS41hrp1904oZRUQbp5nP2A3bLmdi+GZcx
         CXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GZoglC+ge1/99sWCkClXyTN7rb8YyTH+ODtl0a/JGbU=;
        b=DMa7XLCv9KZeoXeaw1co2CFQOhw2lZCLRZ7zrLViYOBfiZ+6xnqFL+w2rW3DE1llNn
         Et2gYFoUYVdPE168ilMofeKhEL3q7Xc3WeiNwEJBpKwKAkLxb5s/i6k/v9ezUf61Sprw
         tbZHNO3lk2r74T4B2nJ5X7YHoRUWpuah8NmnHwMIFwnAvuY1Js9G7QKJXIPf5f8APgIa
         Xh5I+NZZF0hBMTyyOt6IK2GzYzMHD6JEs/PDrgpZKXxwOKleRNVXCbcHuR5S/kLzNEWD
         cPGt6cxIl1IEvwXe0uOJWF4w6JeY6aBlrrdYJ8nB6Xtbwg7UjvmwEawEBqKqoc+e6UB6
         JJuA==
X-Gm-Message-State: AOAM5301vJeJyoDPZQcDKGmog50uEQMLdVO6plIDAhwRZcqFPD6jFVwo
        pfliC7M1NAQwwip10tASbIkgOaXFAsZwKGGBAOmikGhbaxk=
X-Google-Smtp-Source: ABdhPJwk7Oc7NbOGM9oqNhNg31hkcCL0gPpe9YgWryGjzEvWTuEX48SKeDm5Vh0Tdbl3hybV1iwW5b6PeJpLQd7Iiso=
X-Received: by 2002:a17:90b:3ece:: with SMTP id rm14mr1232162pjb.220.1643764708061;
 Tue, 01 Feb 2022 17:18:28 -0800 (PST)
MIME-Version: 1.0
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298428430.3018233.16409089892707993289.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220201153154.jpyxayuulbhdran4@intel.com>
In-Reply-To: <20220201153154.jpyxayuulbhdran4@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 1 Feb 2022 17:18:21 -0800
Message-ID: <CAPcyv4jBZALQH1zhuMw5O6u+OfyXmdQN_j7jwvLbFB=X2zHQVg@mail.gmail.com>
Subject: Re: [PATCH v3 31/40] cxl/memdev: Add numa_node attribute
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 1, 2022 at 7:32 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 22-01-23 16:31:24, Dan Williams wrote:
> > While CXL memory targets will have their own memory target node,
> > individual memory devices may be affinitized like other PCI devices.
> > Emit that attribute for memdevs.
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> This brings up an interesting question. Are all devices in a region affinitized
> to the same NUMA node? I think they must be - at which point, should this
> attribute be a part of a region, rather than a device?
>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl |    9 +++++++++
> >  drivers/cxl/core/memdev.c               |   17 +++++++++++++++++
> >  tools/testing/cxl/test/cxl.c            |    1 +
> >  3 files changed, 27 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > index 87c0e5e65322..0b51cfec0c66 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -34,6 +34,15 @@ Description:
> >               capability. Mandatory for CXL devices, see CXL 2.0 8.1.12.2
> >               Memory Device PCIe Capabilities and Extended Capabilities.
> >
> > +What:                /sys/bus/cxl/devices/memX/numa_node
> > +Date:                January, 2022
> > +KernelVersion:       v5.18
> > +Contact:     linux-cxl@vger.kernel.org
> > +Description:
> > +             (RO) If NUMA is enabled and the platform has affinitized the
> > +             host PCI device for this memory device, emit the CPU node
> > +             affinity for this device.
> > +
>
> I think you'd want to say something about the device actively decoding. Perhaps
> I'm mistaken though, can you affinitize without setting up HDM decoders for the
> device?

Missed replying to this.

No, the memory decode is independent of the CPU to device affinity.
This affinity is like the affinity of an NVME device i.e. the affinity
of PCI.mmio to a CPU, not the resulting CXL.mem node of which there
may be multiple for a single device.
