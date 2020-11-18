Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135932B7D99
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 13:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgKRM0E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 07:26:04 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34547 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgKRM0D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Nov 2020 07:26:03 -0500
Received: by mail-ot1-f65.google.com with SMTP id j14so1553667ots.1;
        Wed, 18 Nov 2020 04:26:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PiA+hYcssZWHOVn8FUP0jNEzq1o0bLIoAhov7HTRa3s=;
        b=FhXiut2BdlaNbRz4GLN4QeL7bHmOhrVLxBNtOC2CobR8RpJwTenI1Xr6G/Z/BH5XTo
         o9VzSibPEI1YJfL/yfxPMngmvPaVHmd0mcg+lrS3DLcTMijAGgOMEaqAWp3AhySwOD3E
         BPmCOQClB3LcL+lQJWpjsuXFB0uiwBmmH8kgf0TfOVy7NBNteYPc9e6SVmvemzL7RxSO
         G6gIW4hbs9o1xtqbwFrwiRbCNSLLGuThNi4/NpcxnTnumbWsqFXnSvsM/57hm7ZEO4ma
         PJZ7715lrMFJOERyGsID+vfGRCoZZrYCYLQr8vy02r3XQ72/jxnDbvLbbxDJWGNQfAQN
         pICQ==
X-Gm-Message-State: AOAM532EM9+pMbw+TgbcyuS0A4J2af9AbC33rlTdKK85YL9oZufxNVVZ
        YvcBgCT/GsZ3I+oMpc081HyqnXvnuG9c4BmSYmY=
X-Google-Smtp-Source: ABdhPJzoeLJSnBwU2uet5BoMgaxg6p2GPAzJTKIfrW4HwcWnUV0X+T3Z2xvmIMz+HD3psO6w0GaKCsVc5AjXi/P4qGw=
X-Received: by 2002:a9d:16f:: with SMTP id 102mr6592389otu.206.1605702361517;
 Wed, 18 Nov 2020 04:26:01 -0800 (PST)
MIME-Version: 1.0
References: <20201111054356.793390-1-ben.widawsky@intel.com>
 <20201111054356.793390-3-ben.widawsky@intel.com> <20201116175909.00007e53@Huawei.com>
 <CAPcyv4h_kSYhcGAdZshFPFbGPgZKCvUh9q7M=jMMRaEauUPzaQ@mail.gmail.com>
In-Reply-To: <CAPcyv4h_kSYhcGAdZshFPFbGPgZKCvUh9q7M=jMMRaEauUPzaQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 Nov 2020 13:25:49 +0100
Message-ID: <CAJZ5v0ibEXVC5vsjCfougJqp_ZbENUKmbTkCjbxVTen-gsONXA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] cxl/acpi: add OSC support
To:     Dan Williams <dan.j.williams@intel.com>
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

On Tue, Nov 17, 2020 at 12:26 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Mon, Nov 16, 2020 at 10:00 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Tue, 10 Nov 2020 21:43:49 -0800
> > Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > > From: Vishal Verma <vishal.l.verma@intel.com>
> > >
> > > Add support to advertise OS capabilities, and request OS control for CXL
> > > features using the ACPI _OSC mechanism. Advertise support for all
> > > possible CXL features, and attempt to request control too for all
> > > possible features.
> > >
> > > Based on a patch by Sean Kelley.
> > >
> > > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> >
> > I guess unsurprisingly a lot of this is cut and paste from PCIe
> > so can we share some of the code?
> >
>
> I do not see a refactoring effort for these bit being all that
> fruitful.

Well, that depends on how much code duplication could be avoided this way.

> The backport pressure for this driver stack I expect will be
> higher than most, so I'm sensitive to avoiding unnecessary core
> entanglements.

If two pieces of code are based on the same underlying common code, it
is immediately clear to the reader how similar to each other they are.
Otherwise, they need to be carefully compared with each other to find
out what the differences are and whether or not they are arbitrary or
vitally important.  That is essential both from the revirem
perspective today and to anyone wanting to understand the given code
in the future (possibly in order to modify it without breaking it).
It outweighs the convenience by far IMV, with all due respect.

Recall how much effort it took to combine x86 with x86_64 and why it
turned out to be necessary to do that work, for one example.
