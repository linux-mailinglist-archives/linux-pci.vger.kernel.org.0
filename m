Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41F435177F
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 19:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbhDARmS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 13:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbhDARl1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Apr 2021 13:41:27 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB44AC0319DA;
        Thu,  1 Apr 2021 10:29:50 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id t23-20020a0568301e37b02901b65ab30024so2807917otr.4;
        Thu, 01 Apr 2021 10:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h/Y0TLuXldSxTdiqZd7pJGoS1WrwZ+szrP8juLbRVoE=;
        b=hkd7Wgr66M1x3TUeOgNtvPYD41ItceMUGmm+DHR2TWouNeWTt67Cns2aAymq6g1XmO
         n5V4nJoAEbaoimndwP7DHBygrmjKWwCb4mbPR1UYov3TV7o1naepBdQsZc+dkQYBgMRu
         58TPsNL9QBkh1DJDdAZYCiPpCizXN1FUwJkSWJlHrFBriMCSEwfB4R3rCF37l1YKpeM5
         rqkAywyqa1eekp5AphuzGVgc9p9/p9BwRliJX9NQXBiZTu0HdLgp4+hzWSICCYrCmQkK
         w3+GwpFTOlkk5JD1pEdMP7LlyYrEp457kNnmPwX1wCDt2Xr/5d0jo5WOu8sHxUx3tHyP
         4P7Q==
X-Gm-Message-State: AOAM5303bpa38PgLut9l40K6wVo/yiQ02waGCsdaas0px6qgO35shlsP
        roCFROnmnp7Didz9y/VaOl3p92wp8SSAgeGnqcs=
X-Google-Smtp-Source: ABdhPJxB+a85xzGa1aBcrm1XeVIq1EGWAh8fIgqpKk8CzFKZH4xWv4cuKYRlQXuKB+REgIX3kbXuq7r8gsu4V4bQt6c=
X-Received: by 2002:a05:6830:55b:: with SMTP id l27mr7147365otb.260.1617298188698;
 Thu, 01 Apr 2021 10:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <e0d626837e577e60f226b8bbf354bd8cbb1fe40a.camel@intel.com>
 <20210331172210.GA1397554@bjorn-Precision-5520> <100f5a45dae14c77b341b7f1c5ea1db0@AcuMS.aculab.com>
 <CAJZ5v0jJ2XDYSwqP3AyKuUvuxhwuNwvk3Z=xwtAL3hG5uYGG-Q@mail.gmail.com> <a0ec3dbdffc145ac909089048e552eb6@AcuMS.aculab.com>
In-Reply-To: <a0ec3dbdffc145ac909089048e552eb6@AcuMS.aculab.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 1 Apr 2021 19:29:37 +0200
Message-ID: <CAJZ5v0h0XMkrYYyOLd8bDcngxnei7VbAh=cYWA4Sy3qm2b69iQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/15] ACPI: table: replace __attribute__((packed)) by __packed
To:     David Laight <David.Laight@aculab.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
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

On Thu, Apr 1, 2021 at 4:23 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Rafael J. Wysocki
> > Sent: 01 April 2021 14:50
> ...
> > So what exactly is wrong with using "packed"?  It is way easier to
> > understand for a casual reader of the code.
>
> Because it is usually wrong!
>
> If I have:
>         struct foo {
>                 u64 val;
>         } __packed;
>
> And then have:
> u64 bar(struct foo *foo)
> {
>         return foo->val;
> }
>
> The on some cpu the compiler has to generate the equivalent of:
>         u8 *x = (void *)&foo->val;
>         return x[0] | x[1] << 8 | x[2] << 16 | x[3] << 24 | x[4] << 32 | x[5] << 40 | x[6] << 48 | x[7] << 56;
>
> If you can guarantee that the structure is 32bit aligned
> then it can generate the simpler:
>         u32 *x = (void *)&foo->val;
>         return x[0] | x[1] << 32;
>
> (Yes I've missed out the 64-bit casts)
>
> This is why you should almost never use __packed.
>
> There are historic structures with 64 bit items on 4 byte boundaries
> (and 32 bit values on 2 byte boundaries).
> Typically most of the fields are shorter so can be read directly
> (although they might need a byte-swapping load).

The possible overhead impact is clear to me, but I really don't like
the "local" typedef idea.

It at least would need to be accompanied by a comment explaining why
it is there and why using it is better than using __packed and why
this needs to be defined locally and not in some generic header file.

Also, the FPDT code is just one function that parses the entire table
and there is no object passing between functions in it etc, so is
__packed still problematic in there?
