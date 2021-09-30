Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2024C41E2A8
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 22:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347883AbhI3UZw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 16:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhI3UZv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Sep 2021 16:25:51 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB3DC06176C
        for <linux-pci@vger.kernel.org>; Thu, 30 Sep 2021 13:24:08 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so363391pjb.3
        for <linux-pci@vger.kernel.org>; Thu, 30 Sep 2021 13:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YNu/YUTTEta1euczrqSgmEotnhGowg7gkC/LCBiwK4s=;
        b=xj9wCZapqmLIJztql+O6rs7uhLCij1deyqu/+aL8hw5KpdACRtEzLzlrczZPQazJf2
         FupFdb9n864IVhhEWE2BFU2kLYdnzUmtFaxbjHm6lb//5fDkvE5CAaUcSQvsRG36P8PP
         eun2CY6L6A5F0Wlzc/fObt5myxz90grs1McqqY8m7v98HFHvToc+FDZTHTkWeW44HECM
         xCD+ovGiDADokJx7WJDuutLzRkMC4VORWMEfE6EY2d8Olt83Rs2NuhEFcPoVePw5SUH+
         SZYrcirr0KsiRYZZIdz5IaTMK6SzVZ+teg347CmH3QnWX3NUvpnIOGpCQjLVm0yeaTnN
         DPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YNu/YUTTEta1euczrqSgmEotnhGowg7gkC/LCBiwK4s=;
        b=AcBCNilysaW4c8RaUrp9+LXeJJD5GbV7xDcGuSOdyDZphosXMQb+lu9jSdmgRRIYCX
         Qq2O0JCWQkUmWWRDNmE0DmRcrV9z507IczOf45DMUyxIW5+c25Vohuj/AZhxMEYKCdrO
         kf0aa94AZFzpb30/mF80zJjuoXpTq26537MNeOgfosh2jn0aNPmd+fh9C+M8zCL2D87P
         xnuZMVVzOAkjanzxlLKK4MoVKjUgQwq2HbINVKOJ4eifegumlufoi87EJP2h0dDRezDm
         YsYL7YqCOXwauaQYZlTks+x2mRvRGGhjr8u4kyi6VagS1to8axFBFsawsk/dG9tQVFha
         8vLQ==
X-Gm-Message-State: AOAM531Qrnxl1fwj7X/fQSIagtK8K1MwOb6den0Lfzs7iW9gdGOolJ0t
        N9va3V5GYU5jLF67Dbdx7G3bacValPnwlV9eBR4NXg==
X-Google-Smtp-Source: ABdhPJxHo0SPWEXvKFwCQCE3PBZOqr998IUbVvJMOZmF3XCbHGVfqolawYuaus/mRtyLVKphZnv5zDwZadqtIJCP1+I=
X-Received: by 2002:a17:90b:3ec3:: with SMTP id rm3mr7610144pjb.93.1633033447983;
 Thu, 30 Sep 2021 13:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CA+CmpXtXn5wjxwow5va5u9qHcQDLkd4Sh2dcqB545SXaxV1GkQ@mail.gmail.com>
 <CAPcyv4iNp41mZcpzGCPR9Xty83j+abk_SOxvsx1xaQ8wALRv0Q@mail.gmail.com>
 <CA+CmpXvGCAny-WHGioJQHF9ZZ5pCaR-E_rw5oeE82xC30naVXg@mail.gmail.com>
 <CAPcyv4ixqiMw1KTB8rbzzrtaErV4PT3R3XqshHhAXv6Ohjzs1Q@mail.gmail.com> <c701ca61-4e7d-1060-102f-8f92dd6e6802@linux.intel.com>
In-Reply-To: <c701ca61-4e7d-1060-102f-8f92dd6e6802@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 30 Sep 2021 13:23:57 -0700
Message-ID: <CAPcyv4gZ=pm5GKV5q-QDqaVw+HAepiLdAokbcgqKooH-6bZcEg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] driver core: Move the "authorized" attribute from
 USB/Thunderbolt to core
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Yehezkel Bernat <yehezkelshb@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Michael Jamet <michael.jamet@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Wang <jasowang@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 30, 2021 at 12:50 PM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 9/30/21 12:04 PM, Dan Williams wrote:
> >>> That's why it was highlighted in the changelog. Hopefully a
> >>> Thunderbolt developer can confirm if it is a non-issue.
> >>> Documentation/ABI/testing/sysfs-bus-thunderbolt does not seem to
> >>> answer this question about whether authorized_show and
> >>> authorized_store need to be symmetric.
> >> Apparently, Bolt does read it [1] and cares about it [2].
> > Ah, thank you!
> >
> > Yeah, looks like the conversion to bool was indeed too hopeful.
> >
>
> IIUC, the end result of value "2" in authorized sysfs is to just
> "authorize" or "de-authorize". In that case, can the user space
> driver adapt to this int->bool change? Just want to know the
> possibility.

ABIs are forever. The kernel has to uphold its contract to bolt that
it will return '2' and not '1' after '2' has been written.
