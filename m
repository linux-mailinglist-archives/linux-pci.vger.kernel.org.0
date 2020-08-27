Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC06025509E
	for <lists+linux-pci@lfdr.de>; Thu, 27 Aug 2020 23:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgH0VeE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Aug 2020 17:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgH0VeE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Aug 2020 17:34:04 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F43C061264
        for <linux-pci@vger.kernel.org>; Thu, 27 Aug 2020 14:34:04 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id w14so6232061eds.0
        for <linux-pci@vger.kernel.org>; Thu, 27 Aug 2020 14:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x8j0V5r/wdP8vZ6VBLvhGQ0X+phPNL3od/ID9nsoXUI=;
        b=dwwhR5U8KcTZrsL4kAe0h6+JfxBbV1UxQURdiBpmqyxtY6HLmETahMpRhG16Vuv3eU
         7irPitpu06miZftdKza17e2IZb8htTOzNWYherpZMivoxEFNFB8pX4BSZjMgO1y5aTOe
         ZKc06aVuQoZbGp3DiwXgdtvyRwGg3nCkXL9nFTRTPFtpT81fdKTC2DgORp0czYF5qaa3
         cZXkeSqbjH7o+zg+m6T1um1O8Y8SjigHsI2ZFl4zwez0EA/lO0GehlMFtV/ZPz3UGONx
         YEFkUwsc5rG5DGW/Y3fcCnys++sszds06jJ/AElMeLX/iV2rvOyV6bkfDjRW9p2B1dWB
         /eKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x8j0V5r/wdP8vZ6VBLvhGQ0X+phPNL3od/ID9nsoXUI=;
        b=fKQSV+nL/ZBPIAvozroUIXDmKoF8FU7BRC0sBEUG9m3a1wOxkUcDn8uuLp5WR8/iqq
         opzgY82UFlUDXxnOIb0dr/9jXXq5rQiyBEeZ9qVqwTGgz1FOOArk7UoIpO18HUTfd0wP
         I5jWAsnDrPZcaOheRXZBkLCJOizLhJIOpB3JErVFGCf5eS7vRQbaaZv8kik+aKRJYwhR
         KIGxE8r3R5D4Mnw3K1NKx7aazWYQy7mM6EUa3elEL2uALY9n/iGK0Wj6IrxBQV3bLFEH
         GATuDuvKY5iEhjDaDEpK5hcyCMcw3gbibW934UmPp+MJiTse2BL9NXlwIlUuTNQVUWP/
         2sRQ==
X-Gm-Message-State: AOAM533APVr+H5dxc0c/GZHaQlHzp1p3F8fN68f64vQQSqXuZPc5OmKu
        VyHVvaRT2XKED20r+ohBfOiIZTAaaln3Yo0KPTYjDA==
X-Google-Smtp-Source: ABdhPJyQG2mzRHuWimFvSyXypx1pnBbhELgTiyxW2XR3lliG442+ltdwMIzoOC48RwGHJ16s7ysT0Ru2bwS2oGZEIjE=
X-Received: by 2002:a05:6402:3128:: with SMTP id dd8mr21084149edb.97.1598564042754;
 Thu, 27 Aug 2020 14:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200821123222.32093-1-kai.heng.feng@canonical.com>
 <20200825062320.GA27116@infradead.org> <cd5aa2fef13f14b30c139d03d5256cf93c7195dc.camel@intel.com>
 <20200827063406.GA13738@infradead.org> <660c8671a51eec447dc7fab22bacbc9c600508d9.camel@intel.com>
 <20200827162333.GA6822@infradead.org> <eb45485d9107440a667e598da99ad949320b77b1.camel@intel.com>
In-Reply-To: <eb45485d9107440a667e598da99ad949320b77b1.camel@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 27 Aug 2020 14:33:56 -0700
Message-ID: <CAPcyv4ie53kswpk8E8=SCv4HBUAjCuFTNb6mLNUR+V-=cJ_XtA@mail.gmail.com>
Subject: Re: [PATCH] PCI/ASPM: Enable ASPM for links under VMD domain
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>,
        "kw@linux.com" <kw@linux.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "Mario.Limonciello@dell.com" <Mario.Limonciello@dell.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Huffman, Amber" <amber.huffman@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 27, 2020 at 9:46 AM Derrick, Jonathan
<jonathan.derrick@intel.com> wrote:
>
> On Thu, 2020-08-27 at 17:23 +0100, hch@infradead.org wrote:
> > On Thu, Aug 27, 2020 at 04:13:44PM +0000, Derrick, Jonathan wrote:
> > > On Thu, 2020-08-27 at 06:34 +0000, hch@infradead.org wrote:
> > > > On Wed, Aug 26, 2020 at 09:43:27PM +0000, Derrick, Jonathan wrote:
> > > > > Feel free to review my set to disable the MSI remapping which will
> > > > > make
> > > > > it perform as well as direct-attached:
> > > > >
> > > > > https://patchwork.kernel.org/project/linux-pci/list/?series=325681
> > > >
> > > > So that then we have to deal with your schemes to make individual
> > > > device direct assignment work in a convoluted way?
> > >
> > > That's not the intent of that patchset -at all-. It was to address the
> > > performance bottlenecks with VMD that you constantly complain about.
> >
> > I know.  But once we fix that bottleneck we fix the next issue,
> > then to tackle the next.  While at the same time VMD brings zero
> > actual benefits.
> >
>
> Just a few benefits and there are other users with unique use cases:
> 1. Passthrough of the endpoint to OSes which don't natively support
> hotplug can enable hotplug for that OS using the guest VMD driver
> 2. Some hypervisors have a limit on the number of devices that can be
> passed through. VMD endpoint is a single device that expands to many.
> 3. Expansion of possible bus numbers beyond 256 by using other
> segments.
> 4. Custom RAID LED patterns driven by ledctl
>
> I'm not trying to market this. Just pointing out that this isn't
> "bringing zero actual benefits" to many users.
>

The initial intent of the VMD driver was to allow Linux to find and
initialize devices behind a VMD configuration where VMD was required
for a non-Linux OS. For Linux, if full native PCI-E is an available
configuration option I think it makes sense to recommend Linux users
to flip that knob rather than continue to wrestle with the caveats of
the VMD driver. Where that knob isn't possible / available VMD can be
a fallback, but full native PCI-E is what Linux wants in the end.
