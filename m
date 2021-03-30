Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4EC134EEC4
	for <lists+linux-pci@lfdr.de>; Tue, 30 Mar 2021 19:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbhC3RA5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Mar 2021 13:00:57 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:46728 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbhC3RAr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Mar 2021 13:00:47 -0400
Received: by mail-ot1-f47.google.com with SMTP id 68-20020a9d0f4a0000b02901b663e6258dso16193092ott.13;
        Tue, 30 Mar 2021 10:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GrRt3u7iqTFYKYQM2kMqnl4TPPvQxpiAG7TTBqlqQcY=;
        b=SUvdubfcuobp6viiZFjLvFggNNsSllcy6DzV0ka1Ep+I000Q52ZOKzBEGpUXd5RH5C
         wXsCCXDc9Esu40/RaTBhpC0BvK5Cc2KtETE6ows1X6LntO4wsqN8oey4ff1+TeX4e1ef
         RsRxGgkOrjO551hPt+Qfu8SkJcHFF37z6BGzwXHvXc6wLC8dGPSfIimfwrT++O9lLQ71
         HJno3G6zns7h+YhHRPbUjCw+OX523ZoHgESpfgvnKs0Z2Q4ipV4hWLdUUSQZmbGC36B8
         KGT/XFWYPKr6qdKoudHHnGLbqDSkONI+Zm2T7Wongyn+4A9RWyO0t1niiArQIipGDZDM
         1lhw==
X-Gm-Message-State: AOAM5319S6u/OwUz0vTPPcatNsf7P3PRS2AmsBwdNc8n4UcK2z8GOuov
        iO0M9eMr1Xc1KNMkxHmPIFYkqPhFNeovnvC055c=
X-Google-Smtp-Source: ABdhPJz+lW82gZmQ0GMHD4FdEDFEY51f8BcLrLAWfgu86kEPKK44Q3AH1fe7Dl5zN+oDsSjCsVO2M430UPrtd5vx+BA=
X-Received: by 2002:a05:6830:20d2:: with SMTP id z18mr27637560otq.260.1617123646616;
 Tue, 30 Mar 2021 10:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <1616831193-17920-1-git-send-email-tanxiaofei@huawei.com>
 <1616831193-17920-5-git-send-email-tanxiaofei@huawei.com> <6df04be78e544e17b3b57f159312541f@AcuMS.aculab.com>
 <34dd3de8-644d-6e44-965a-0991b7027cae@huawei.com> <b5ad5909f3fb14b46d6ff0f81c10e42507a60c74.camel@intel.com>
 <af3fd5adb62dcac93f2ff4ea7b6aff74d0106ac5.camel@intel.com> <6df8e01e2e9e4906be5ceaea72c61c0f@AcuMS.aculab.com>
In-Reply-To: <6df8e01e2e9e4906be5ceaea72c61c0f@AcuMS.aculab.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 30 Mar 2021 19:00:31 +0200
Message-ID: <CAJZ5v0hz8dadumTTDbe6+xyNBMhkTLq6C60U+=Ec44WxL2Jdxw@mail.gmail.com>
Subject: Re: [PATCH v2 04/15] ACPI: table: replace __attribute__((packed)) by __packed
To:     David Laight <David.Laight@aculab.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 30, 2021 at 10:15 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Zhang Rui
> > Sent: 30 March 2021 09:00
> > To: Xiaofei Tan <tanxiaofei@huawei.com>; David Laight <David.Laight@ACULAB.COM>; rjw@rjwysocki.net;
> > lenb@kernel.org; bhelgaas@google.com
> > Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org;
> > linuxarm@openeuler.org
> > Subject: Re: [PATCH v2 04/15] ACPI: table: replace __attribute__((packed)) by __packed
> >
> > On Tue, 2021-03-30 at 15:31 +0800, Zhang Rui wrote:
> > > On Tue, 2021-03-30 at 10:23 +0800, Xiaofei Tan wrote:
> > > > Hi David,
> > > >
> > > > On 2021/3/29 18:09, David Laight wrote:
> > > > > From: Xiaofei Tan
> > > > > > Sent: 27 March 2021 07:46
> > > > > >
> > > > > > Replace __attribute__((packed)) by __packed following the
> > > > > > advice of checkpatch.pl.
> > > > > >
> > > > > > Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
> > > > > > ---
> > > > > >  drivers/acpi/acpi_fpdt.c | 6 +++---
> > > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/acpi/acpi_fpdt.c
> > > > > > b/drivers/acpi/acpi_fpdt.c
> > > > > > index a89a806..690a88a 100644
> > > > > > --- a/drivers/acpi/acpi_fpdt.c
> > > > > > +++ b/drivers/acpi/acpi_fpdt.c
> > > > > > @@ -53,7 +53,7 @@ struct resume_performance_record {
> > > > > >       u32 resume_count;
> > > > > >       u64 resume_prev;
> > > > > >       u64 resume_avg;
> > > > > > -} __attribute__((packed));
> > > > > > +} __packed;
> > > > > >
> > > > > >  struct boot_performance_record {
> > > > > >       struct fpdt_record_header header;
> > > > > > @@ -63,13 +63,13 @@ struct boot_performance_record {
> > > > > >       u64 bootloader_launch;
> > > > > >       u64 exitbootservice_start;
> > > > > >       u64 exitbootservice_end;
> > > > > > -} __attribute__((packed));
> > > > > > +} __packed;
> > > > > >
> > > > > >  struct suspend_performance_record {
> > > > > >       struct fpdt_record_header header;
> > > > > >       u64 suspend_start;
> > > > > >       u64 suspend_end;
> > > > > > -} __attribute__((packed));
> > > > > > +} __packed;
> > > > >
> > > > > My standard question about 'packed' is whether it is actually
> > > > > needed.
> > > > > It should only be used if the structures might be misaligned in
> > > > > memory.
> > > > > If the only problem is that a 64bit item needs to be 32bit
> > > > > aligned
> > > > > then a suitable type should be used for those specific fields.
> > > > >
> > > > > Those all look very dubious - the standard header isn't packed
> > > > > so everything must eb assumed to be at least 32bit aligned.
> > > > >
> > > > > There are also other sub-structures that contain 64bit values.
> > > > > These don't contain padding - but that requires 64bit alignement.
> > > > >
> > > > > The only problematic structure is the last one - which would have
> > > > > a 32bit pad after the header.
> > > > > Is this even right given than there are explicit alignment pads
> > > > > in some of the other structures.
> > > > >
> > > > > If 64bit alignment isn't guaranteed then a '64bit aligned to
> > > > > 32bit'
> > > > > type should be used for the u64 fields.
> > > > >
> > > >
> > > > Yes, some of them has been aligned already, then nothing changed
> > > > when
> > > > add this "packed ". Maybe the purpose of the original author is
> > > > for
> > > > extension, and can tell others that this struct need be packed.
> > > >
> > >
> > > The patch is upstreamed recently but it was made long time ago.
> > > I think the original problem is that one of the address, probably the
> > > suspend_performance record, is not 64bit aligned, thus we can not
> > > read
> > > the proper content of suspend_start and suspend_end, mapped from
> > > physical memory.
> > >
> > > I will try to find a machine to reproduce the problem with all
> > > __attribute__((packed)) removed to double confirm this.
> > >
> >
> > So here is the problem, without __attribute__((packed))
> >
> > [    0.858442] suspend_record: 0xffffaad500175020
> > /sys/firmware/acpi/fpdt/suspend/suspend_end_ns:addr:
> > 0xffffaad500175030, 15998179292659843072
> > /sys/firmware/acpi/fpdt/suspend/suspend_start_ns:addr:
> > 0xffffaad500175028, 0
> >
> > suspend_record is mapped to 0xffffaad500175020, and it is combined with
> > one 32bit header and two 64bit fields (suspend_start and suspend_end),
> > this is how it is located in physical memory.
> > So the addresses of the two 64bit fields are actually not 64bit
> > aligned.
> >
> > David,
> > Is this the "a 64bit item needs to be 32bit aligned" problem you
> > referred?
> > If yes, what is the proper fix? should I used two 32bits for each of
> > the field instead?
>
> Define something like:
> typedef u64 __attribute__((aligned(4))) u64_align32;
> and then use it for the 64bit structure members.
>
> There doesn't seem to be a standard type name for it - although
> it is used in several places.
>
> I'm not entirely sure but is ACPI always LE?

Yes.

> (is it even x86 only??)

No.
