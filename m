Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953032B8374
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 18:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgKRR6Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 12:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgKRR6Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Nov 2020 12:58:24 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B869FC0613D6
        for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2020 09:58:23 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id f23so4046998ejk.2
        for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2020 09:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CUfbbHmtoDuKn7TpUZ579udEm3PcirZfq0eQV5TKq9o=;
        b=tvpfEwP+ZZMkMQ93Mh1f6j5FKNXm5M2Ak6FsBNIIN8BiaV0BTYVl+2KI363P4pPGhk
         4XCHCy6c/5qihFsPbRNd1ryg08ayiY0WUlMRJ7tsItKKpdl+0gXny2bzA4Yc7BDDciiF
         lm0yCD7b8wCqJOooSmMwFcwAUUnlD0g20c5tSUb4HBEO3d+SZUI228DolNZjs7b8A2Gb
         2/lhmqWLg3vKRpt8+5DeljAmd22yWaWMCTaw2KqeGnVRMXy3rZs5tI/ni2Qe2EHepKE+
         o1al2whOOjuL2T1TY5X7PNOayGhFCs+jfIlZ3vTJ4lgvHtGKFbdbUxJeUDrWuKJFi6l/
         S4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CUfbbHmtoDuKn7TpUZ579udEm3PcirZfq0eQV5TKq9o=;
        b=ktTaUkv103HnPwmeOzJHBwYmkzeAaXRlOX1QmbZbKscHqMYkvuMhTi9MAgNvS+vkAc
         ugrVjhlInFLW7ty8sQMHr+Lm4qRF3OTZWoDVegBUcwteOEsav8jRO6q52leYpKXPRcrf
         JFX6zcBQ0ymIpZTchvfY6J2yl3D79z5rRBgiX3Tr85sN5iWgFmur0nlRtpi3jlVJ8SKi
         sN5+ZckzTXFI8zEo4sBqGjM+bh9UVUjtGehzEIZsM+RsyhLIiOeumXTQ+KTcfyfiu7tO
         p0pqZ0FI6ad/Tzzt9n4hASiM8FPo4bi+ZEzRgGyhuPRmwLon2K42wGwzjw2i9FFdxf6u
         Zcqw==
X-Gm-Message-State: AOAM532Sds53nAKJo3ZKhUHIo8L9fH5L3tE4u+eEOmbTocnhxfWOWd0M
        fPc6irD2G6aIDzmpntkYf/751xh7oC/jtwmCXxjbP+P4Lz8=
X-Google-Smtp-Source: ABdhPJzAo7X20AwJvG1rn3bcJsj4ua9pJG670rFxHdWk1YJl4d0tkmXpxpdfWZiNhtz2BTcFoV1XlqYQxL6b9QgLA2M=
X-Received: by 2002:a17:906:ad8e:: with SMTP id la14mr21620775ejb.264.1605722302429;
 Wed, 18 Nov 2020 09:58:22 -0800 (PST)
MIME-Version: 1.0
References: <20201111054356.793390-1-ben.widawsky@intel.com>
 <20201111054356.793390-3-ben.widawsky@intel.com> <20201116175909.00007e53@Huawei.com>
 <CAPcyv4h_kSYhcGAdZshFPFbGPgZKCvUh9q7M=jMMRaEauUPzaQ@mail.gmail.com> <CAJZ5v0ibEXVC5vsjCfougJqp_ZbENUKmbTkCjbxVTen-gsONXA@mail.gmail.com>
In-Reply-To: <CAJZ5v0ibEXVC5vsjCfougJqp_ZbENUKmbTkCjbxVTen-gsONXA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 18 Nov 2020 09:58:11 -0800
Message-ID: <CAPcyv4ixeG9Puoob5yKRe3UDgehzJKPA32aiurZi-55-G-U17A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] cxl/acpi: add OSC support
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 18, 2020 at 4:26 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Nov 17, 2020 at 12:26 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Mon, Nov 16, 2020 at 10:00 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Tue, 10 Nov 2020 21:43:49 -0800
> > > Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > > From: Vishal Verma <vishal.l.verma@intel.com>
> > > >
> > > > Add support to advertise OS capabilities, and request OS control for CXL
> > > > features using the ACPI _OSC mechanism. Advertise support for all
> > > > possible CXL features, and attempt to request control too for all
> > > > possible features.
> > > >
> > > > Based on a patch by Sean Kelley.
> > > >
> > > > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > >
> > > I guess unsurprisingly a lot of this is cut and paste from PCIe
> > > so can we share some of the code?
> > >
> >
> > I do not see a refactoring effort for these bit being all that
> > fruitful.
>
> Well, that depends on how much code duplication could be avoided this way.
>
> > The backport pressure for this driver stack I expect will be
> > higher than most, so I'm sensitive to avoiding unnecessary core
> > entanglements.
>
> If two pieces of code are based on the same underlying common code, it
> is immediately clear to the reader how similar to each other they are.
> Otherwise, they need to be carefully compared with each other to find
> out what the differences are and whether or not they are arbitrary or
> vitally important.  That is essential both from the revirem
> perspective today and to anyone wanting to understand the given code
> in the future (possibly in order to modify it without breaking it).
> It outweighs the convenience by far IMV, with all due respect.
>
> Recall how much effort it took to combine x86 with x86_64 and why it
> turned out to be necessary to do that work, for one example.

I agree with above, but the degree of potential code sharing and
refactoring for CXL is nowhere near approaching the x86_64 situation.
There's also the counter example in ext3 and ext4 where a split is
maintained for good reason. All I'm saying is that let's judge patches
and not theory when it comes to refactoring CXL, my expectation is
that those opportunities will be few and far between. CXL is a
superset of PCIE functionality so it should not put much pressure on
common core PCIE code to change vs incremental CXL extensions.
