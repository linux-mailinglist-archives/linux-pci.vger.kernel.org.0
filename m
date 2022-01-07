Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD1A487CE8
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 20:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbiAGTUW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 14:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiAGTUV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jan 2022 14:20:21 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC87BC061574
        for <linux-pci@vger.kernel.org>; Fri,  7 Jan 2022 11:20:21 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id m13so5929795pji.3
        for <linux-pci@vger.kernel.org>; Fri, 07 Jan 2022 11:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0KUHdYWZrNQNGd+wqJYrVbHFyI10Jcy+xpDfU5P3J28=;
        b=VniaEUOJjfHFUTU+bdguSmbz3nDd7hjAGjCTcSZwPzluLWmAaLu/IEMmu16Hjkv6mX
         5kgSvqc8NZdVqCQaI4eYeT4HTQzfckR9gHjXko3ouU4O/KOqkJSKQNR/8KpMDEJZ8y9A
         0G8Fuxu5OZQCYkVMWTADPiX528ASEDm0nSeR6vWg/wI4SFsYwVFSRgb8dPKbiXQXokPY
         xVCoqY61Q0uo2s9KWkxWznmHemXlIojSHUULCCDSclaNX9rBTwIn5eKIvmmC/35T3sLx
         uZTohww8udIskzgZZdtor7Iriq01DGywF01j+2cga7sFEBocYwYMulZIbnR/Zlla5qA0
         AMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0KUHdYWZrNQNGd+wqJYrVbHFyI10Jcy+xpDfU5P3J28=;
        b=3SGZCi8XERoM3dygqMDKC4rnNOjW9DZca4dWs1yxzT5LC+tTGzqCM0+D9s5nlYoIoY
         UahZOGisuzCzPPjV8q2hy8u5guaMDa8IvpesdxKjqWYU+Kt6kKUQ7IvLQ0ufC+mmb1A4
         HlnPho4l4QgAp52kz4fWm2nQEMGFIQEIEGxvDSHG9PGPkNuQmRTFGVCVzqUQozMULYoi
         Gchh97Ne6vltw3YypsV4u7XDf77ISU7WglCquap7ZzfZ43PxW2tk2tZ5EjPshyIUz+zA
         GNwlDdHXDgs04rQoqaJPtpppbyAxx43SVrv0J/UhJAKV1zOZ0ZAMmOhXK5iO8kXAnYpc
         045A==
X-Gm-Message-State: AOAM530y21GQdbHw1lQExNQbyA0CP81p9ZyF8rbcLz9hc+0T3atcbw+K
        J12jIdpOVPMae026hKdB/jKZB1LXIANpLpu8iFKDmg==
X-Google-Smtp-Source: ABdhPJyJf8RMwf7gYVJ0h6mf+V2vkE5ytFqOUl5SZvDR+zFeHtA7ne8qbFO9vjyorkThp60xVYTI+LFqhXMZEYfLiSo=
X-Received: by 2002:a17:90a:7101:: with SMTP id h1mr17108928pjk.93.1641583221168;
 Fri, 07 Jan 2022 11:20:21 -0800 (PST)
MIME-Version: 1.0
References: <20220107003756.806582-1-ben.widawsky@intel.com>
 <20220107003756.806582-13-ben.widawsky@intel.com> <20220107181454.00004a1b@huawei.com>
In-Reply-To: <20220107181454.00004a1b@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 7 Jan 2022 11:20:10 -0800
Message-ID: <CAPcyv4hmt0mJ9Bek7R0dOeX1aQm_yKkv6JhXcTzG36Zs7xVRYg@mail.gmail.com>
Subject: Re: [PATCH 12/13] cxl/region: Record host bridge target list
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux PCI <linux-pci@vger.kernel.org>, patches@lists.linux.dev,
        Bjorn Helgaas <helgaas@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 7, 2022 at 10:15 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu,  6 Jan 2022 16:37:55 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> > Part of host bridge verification in the CXL Type 3 Memory Device
> > Software Guide calculates the host bridge interleave target list (6th
> > step in the flow chart). With host bridge verification already done, it
> > is trivial to store away the configuration information.
> >
> > TODO: Needs support for switches (7th step in the flow chart).
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> >  drivers/cxl/region.c | 41 +++++++++++++++++++++++++++++++----------
> >  1 file changed, 31 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
> > index eafd95419895..3120b65b0bc5 100644
> > --- a/drivers/cxl/region.c
> > +++ b/drivers/cxl/region.c
> > @@ -385,6 +385,7 @@ static bool region_hb_rp_config_valid(struct cxl_region *region,
> >       }
> >
> >       for (i = 0; i < hb_count; i++) {
> > +             struct cxl_decoder *cxld;
> >               int idx, position_mask;
> >               struct cxl_dport *rp;
> >               struct cxl_port *hb;
> > @@ -422,10 +423,8 @@ static bool region_hb_rp_config_valid(struct cxl_region *region,
> >                               if (get_rp(ep) != rp)
> >                                       continue;
> >
> > -                             if (port_grouping == -1) {
> > +                             if (port_grouping == -1)
> >                                       port_grouping = idx & position_mask;
> > -                                     continue;
> > -                             }
> >
> >                               /*
> >                                * Do all devices in the region connected to this CXL
> > @@ -436,10 +435,32 @@ static bool region_hb_rp_config_valid(struct cxl_region *region,
> >                                                         "One or more devices are not connected to the correct Host Bridge Root Port\n");
> >                                       return false;
> >                               }
> > +
> > +                             if (!state_update)
> > +                                     continue;
> > +
> > +                             if (dev_WARN_ONCE(&cxld->dev,
> > +                                               port_grouping >= cxld->nr_targets,
> > +                                               "Invalid port grouping %d/%d\n",
> > +                                               port_grouping, cxld->nr_targets))
> > +                                     return false;
> > +
> > +                             cxld->interleave_ways++;
> > +                             cxld->target[port_grouping] = get_rp(ep);
>
> Hi Ben,
>
> Just one more based on debug rather than review.
>
> The reason is across 2 patches so not necessary obvious from what is visible here,
> but port_grouping here for a 2hb, 2rp on each and 1 ep on each of those
> case goes 0,1,2,3 resulting in us setting one of the host bridges to have
> a decoder with targets 2 and 3 rather than 0 and 1 set.
>
> I haven't figured out a particularly good solution yet...  If everything is nice and symmetric
> and power of 2 then you can simply change the mask on the index to reflect num_root_ports / num_host_bridges
>
> With that change in place my decoders all look good on this particular configuration :)
> Note this is eyeball based testing only and on just one configuration so far.
>
> I'll have to try your tool as it is really annoying that the mem devices change order on every
> boot as my script is dumb currently so have to edit it every run.

I have support pending for cxl-cli that lets memdevs be filtered by
serial number so you don't need to worry about dynamic kernel device
names.

Should be posted later today.
