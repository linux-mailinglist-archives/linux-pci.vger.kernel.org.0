Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478C631CE65
	for <lists+linux-pci@lfdr.de>; Tue, 16 Feb 2021 17:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhBPQtY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Feb 2021 11:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhBPQtY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Feb 2021 11:49:24 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0428C06174A
        for <linux-pci@vger.kernel.org>; Tue, 16 Feb 2021 08:48:43 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id f14so17609082ejc.8
        for <linux-pci@vger.kernel.org>; Tue, 16 Feb 2021 08:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ecI3AnraXxD8s3/KbtK83ACA5HZ+x4/w5NBzKVHXCM=;
        b=Wm4E81qbjZm4Ote4+krHtLMT/Sg47muTNtm9HAKUxuG6Ynbpz/zx9MMwTAxRVTsgVJ
         /dzzWYIWuocSvGpYzRWHIensXSKdcLuR4nL7RXCE+p8DgFHIcvSeX0wcN5u7/JmCK0qp
         acnyO5VrRzp2jteOXYfH01EwKQRMekKGfugDte/4je+KFj4VmoylnLVz45G4U+t/SrpB
         iZWqFLwHhLLKfGymiYFRCCxGZPBfX3wrdFNwaXAyieuKeokwaE98+EHOUIK5WC+f3xUs
         9De32myHYjeq1IRoGAK7DkzalOxPCkwfTVMLHCtzioAjkOxq3Tp1syboSAYFWZtlM49Y
         /hvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ecI3AnraXxD8s3/KbtK83ACA5HZ+x4/w5NBzKVHXCM=;
        b=lUAFp6ln+r5oGlv6Ej6joQ71xmuupEuQvguzBlAvKslz9+ZDCt8P12vNQQ+mxfWCm1
         GmJ4Xb18AtCrExvhKSDMAmHw7fcT21cMD8GeBsyh3sxCNHwSA42zneqY6bXAtQwUOrEm
         cbkmqPxj/LD0Y5pP31Oas2gtR6iC47RBuZWnGb73PBH+/WFZvWQ35BUUwPEeImFcquVJ
         P0r9K7pYNUb6nrmjdvBdmQ1oJZnJU50qVEC3tr/b6Tgb5AYRmW2FvdoJR4dIBKjX8jsC
         pGgDRITaxZcX5feH5D5lUV28xBwY+sQVs7aRR5QQnrBN2cQ99/kI00Vp28+iDoQVM3cl
         AlHg==
X-Gm-Message-State: AOAM532p8ohhMcScZS5ttlCdBKFusJci16amXi35kgKHBDtimzoAzpub
        OqoawVaU83lvl2XI1uhS5/xjb2UbZL38jWcsnOt9mw==
X-Google-Smtp-Source: ABdhPJw7/a6RtFAeh/ix7sMWO3UbzMvUPTqfzkV9KVjhDzFN7lG80bkPRoVGizFBbZxeH5ml2XKSfBwSVxENdDqxJEM=
X-Received: by 2002:a17:906:5655:: with SMTP id v21mr3112272ejr.264.1613494122365;
 Tue, 16 Feb 2021 08:48:42 -0800 (PST)
MIME-Version: 1.0
References: <20210216014538.268106-1-ben.widawsky@intel.com>
 <20210216014538.268106-10-ben.widawsky@intel.com> <20210216154857.0000261d@Huawei.com>
In-Reply-To: <20210216154857.0000261d@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 16 Feb 2021 08:48:32 -0800
Message-ID: <CAPcyv4j+DZq7fkRTW+_O1-AtAQwOPD65A8M5AWg7XU9N+TksRA@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] cxl/mem: Add payload dumping for debug
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Linux ACPI <linux-acpi@vger.kernel.org>,
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

On Tue, Feb 16, 2021 at 7:50 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 15 Feb 2021 17:45:38 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> > It's often useful in debug scenarios to see what the hardware has dumped
> > out. As it stands today, any device error will result in the payload not
> > being copied out, so there is no way to triage commands which weren't
> > expected to fail (and sometimes the payload may have that information).
> >
> > The functionality is protected by normal kernel security mechanisms as
> > well as a CONFIG option in the CXL driver.
> >
> > This was extracted from the original version of the CXL enabling patch
> > series.
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
>
> My gut feeling here is use a tracepoint rather than spamming the kernel
> log.  Alternatively just don't bother merging this patch - it's on the list
> now anyway so trivial for anyone doing such debug to pick it up.
>

I've long wanted to make dev_dbg() a way to declare trace-points. With
that, enabling it as a log message, or a trace-point is user policy.
The value of this is having it readily available, not digging up a
patch off the list for a debug session.
