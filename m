Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D2331948E
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 21:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhBKUfa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 15:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhBKUf1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Feb 2021 15:35:27 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129E7C061786
        for <linux-pci@vger.kernel.org>; Thu, 11 Feb 2021 12:34:47 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id w2so12007810ejk.13
        for <linux-pci@vger.kernel.org>; Thu, 11 Feb 2021 12:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tgwnKmmGdWDCxHejoZP0bKZIVRKg9fBvIThmjXyQsEw=;
        b=T4khnwoqjyVlyFJZe9yf1Hqe4YwtQNZKtdD3iNfNqQ3nG8ihJ93iGi2kdceUV+6WzP
         U30lqWYAoU4mnF/BTzmNiDn4M6OkmoL/HSgxMTpuO8yxCwt9b20YfLoT23FpwzW1dGZV
         bJ9zVra/TCEhEZSE2YLcmboDfhtC1K936PkyqsjxzXjp6koe4GNl9qeIo5TqD11dyDhQ
         rl8C6iPZN9DWwkPlmqnfjSZEIMNUIg8irYR1gK33qxg7+RjyMrbSLaErpObkBK/eVVOw
         as5S3Ag8QkadmDt6w065AidBrxpozcVJ5kcqol0urwlsmpCou6dwkfgMj5QHHlihU880
         k99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tgwnKmmGdWDCxHejoZP0bKZIVRKg9fBvIThmjXyQsEw=;
        b=Av0v+3/emySCm8DXJ8rPq+ThSE9HshLoQ3RLCfmV0q4O8qYEpYqfsAN3l8wKMVMLIp
         7EkRJksbjeHVuKX7Hs2Du6B5U7QgVVWBb3IpqHZOsnXRqQZlEDMlH08AWXt7eG8uhgKR
         iTEwDkideFMx/VY5TiyJMtAKK8wBdtxPCgAQ2ZlljJYPxpxnI5WpynDMMOzw7b8/P5KD
         azwko76HwrZoU/akqKdgQugDuAQYFMIEQbm5pj/v8qYoVaok5StT0+jAD1IUH3tOMjdy
         4lMf4RcI7yIQCBUrCMviRYbGqclfz5xT8AEKoSq8d8JkguEkiEjOXNijIQVbtI3+a7w2
         zrGA==
X-Gm-Message-State: AOAM531xI2pRPUSYoptW+2E0WLf6JFQk+VSKEVCLDTOhP9nnzlxCagTq
        yviWnz9ondr9Eao0vOlo1WJnAyCUnfiaNlMh7zo3zutDJFI=
X-Google-Smtp-Source: ABdhPJyw5zAj09pkfw9O4vZ91q761XWqJWsJYNmylmwXEAFa0RMljdC5RPj7aoX4jj2C6VUAHgj24Ehk/wHibuXDiBo=
X-Received: by 2002:a17:906:36cc:: with SMTP id b12mr10342308ejc.323.1613075685691;
 Thu, 11 Feb 2021 12:34:45 -0800 (PST)
MIME-Version: 1.0
References: <20210210000259.635748-1-ben.widawsky@intel.com>
 <20210210000259.635748-7-ben.widawsky@intel.com> <20210211120215.00007d3d@Huawei.com>
 <20210211174502.72thmdqlh2q5tdu3@intel.com>
In-Reply-To: <20210211174502.72thmdqlh2q5tdu3@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 11 Feb 2021 12:34:35 -0800
Message-ID: <CAPcyv4iXYxTc5uu7Jq0=X9C0+5QW8ZbnwebhWAw5c2DhwqY72Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] cxl/mem: Enable commands via CEL
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 11, 2021 at 9:45 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
[..]
> > > +   if (mbox_cmd.size_out > sizeof(gsl)) {
> > > +           dev_warn(dev, "%zu excess logs\n",
> > > +                    (mbox_cmd.size_out - sizeof(gsl)) /
> > > +                            sizeof(struct gsl_entry));
> >
> > This could well happen given spec seems to allow for other
> > entries defined by other specs.
>
> Interesting. When I read the spec before (multiple times) I was certain it said
> other UUIDs aren't allowed. You're correct though that the way it is worded,
> this is a bad check. AIUI, the spec permits any UUID and as such I think we
> should remove tainting for unknown UUIDs. Let me put the exact words:
>
> Table 169 & 170
> "Log Identifier: UUID representing the log to retrieve data for. The following
>  Log Identifier UUIDs are defined in this specification"
>
> To me this implies UUIDs from other (not "this") specifications are permitted.
>
> Dan, I'd like your opinion here. I'm tempted to change the current WARN to a
> dev_dbg or somesuch.

Yeah, sounds ok, and the command is well defined to be a read-only,
zero-side-effect affair. If a vendor did really want to sneak in a
proprietary protocol over this interface it would be quite awkward.
