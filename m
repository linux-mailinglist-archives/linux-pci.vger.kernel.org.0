Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A504A68D0
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 00:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243001AbiBAX4S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 18:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242999AbiBAX4S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 18:56:18 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34431C06173B
        for <linux-pci@vger.kernel.org>; Tue,  1 Feb 2022 15:56:18 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id my12-20020a17090b4c8c00b001b528ba1cd7so4262369pjb.1
        for <linux-pci@vger.kernel.org>; Tue, 01 Feb 2022 15:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CEfWmFa6h1pSisWUvUHFqdY1xxpJcSJ77JcYULSeoMg=;
        b=x9eEhKXjotb03EBl7uteomY26LqM/y4ciidoaVzvnI7NgTTn0X2msquA4LxcSW9Sui
         Ohj8JXxvyumrePoS9Oh1/gINTrj7ps6S5YWT4C7ZTbB/wJEpRa2gYNGY5AVzxplzFt/6
         B2TM/Yez1HtdKgI4VACGb+EcjHPzBEXD3x7OkujXZXjUG4C3X1kdUxzaCt4dWx6Izmvs
         LPsynTrrZEmF4LglOjpBc+wc0xiTPoe/+01+MJnUWzLl08LLy2y388dgsIg4oStQnVZk
         a84QYRTl82OxKtJ7FWYxNqfm4hCgm3YHzQwM5A42iCrSHzBtua6e+zt9OQgst/AFR8PJ
         xcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CEfWmFa6h1pSisWUvUHFqdY1xxpJcSJ77JcYULSeoMg=;
        b=mNxIFhPZFViaZtaKynoT4ZvJvlrhROidtZ6wgs5j/V5UXhN4qEQKwRn3YUk1EwPqzA
         EmHPUDpFtK1o5p9O80Y1HUUBGlL/D6d1MsbXfksgzbFS315om+x93LMS/ssBq2unHK0S
         hsMUH+Fing45QmXoWO9D0QSdRKQHg+6UiTbG0nmk5KdTxYV/LeE81cjv07G7nJ/TdahV
         iVqu5V2sABpX5IQlVB67lX50D70LPJ3W4oicSr6CIp4Asc6bonZEw+JCWHVTtoBAxm4y
         IBDDncVQoQJ7yoQH45ifJWsxjn7jC5TYx6qJ6iNhTFBnnHn5pT0vGDhuhFr3BDw8idyl
         dWxw==
X-Gm-Message-State: AOAM5339TFBrOxTxABhwlfdMdhX+AelhUdUaEMRVRpumizprPcp0TLWq
        Nnu6so+KTQynVAIun7vA/cfnBYVMTGsX2QKy2jS2fg==
X-Google-Smtp-Source: ABdhPJwVKeLD51uxXWe19JmZTmvBXefzk63Jw4s2H90HY14DG2NRaOY3gyf0F+eH0LhIpYHi0bdbBmN6hNo5jxnhFLM=
X-Received: by 2002:a17:90b:3ece:: with SMTP id rm14mr901277pjb.220.1643759777648;
 Tue, 01 Feb 2022 15:56:17 -0800 (PST)
MIME-Version: 1.0
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298427373.3018233.9309741847039301834.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220131182939.000001db@Huawei.com>
In-Reply-To: <20220131182939.000001db@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 1 Feb 2022 15:56:10 -0800
Message-ID: <CAPcyv4ifmCh1bBiFztafOMyk0Y4V2ER-VRcAPE2ae2B+J73SEw@mail.gmail.com>
Subject: Re: [PATCH v3 29/40] cxl/pci: Implement wait for media active
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 31, 2022 at 10:30 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Sun, 23 Jan 2022 16:31:13 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > From: Ben Widawsky <ben.widawsky@intel.com>
> >
> > CXL 2.0 8.1.3.8.2 states:
> >
> >   Memory_Active: When set, indicates that the CXL Range 1 memory is
> >   fully initialized and available for software use. Must be set within
> >   Range 1. Memory_Active_Timeout of deassertion of reset to CXL device
> >   if CXL.mem HwInit Mode=1
> >
> > Unfortunately, Memory_Active can take quite a long time depending on
> > media size (up to 256s per 2.0 spec). Provide a callback for the
> > eventual establishment of CXL.mem operations via the 'cxl_mem' driver
> > the 'struct cxl_memdev'. The implementation waits for 60s by default for
> > now and can be overridden by the mbox_ready_time module parameter.
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > [djbw: switch to sleeping wait]
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Not being a memory device person, I'm not sure whether my query below
> is realistic but I worry a little that minimum sleep if not immediately
> ready of 1 second is a bit long.

Perhaps, but I think the chance of getting to this point is slim in
the common case where platform firmware has already done CXL memory
init.

> Perhaps that's something to optimize once there are a large number
> of implementations to assess if it is worth bothering or not.

Sounds good.

>
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
>
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 5c43886dc2af..513cb0e2a70a 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -49,7 +49,7 @@
> >  static unsigned short mbox_ready_timeout = 60;
> >  module_param(mbox_ready_timeout, ushort, 0600);
> >  MODULE_PARM_DESC(mbox_ready_timeout,
> > -              "seconds to wait for mailbox ready status");
> > +              "seconds to wait for mailbox ready / memory active status");
> >
> >  static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
> >  {
> > @@ -417,6 +417,51 @@ static int wait_for_valid(struct cxl_dev_state *cxlds)
> >       return -ETIMEDOUT;
> >  }
> >
> > +/*
> > + * Wait up to @mbox_ready_timeout for the device to report memory
> > + * active.
> > + */
> > +static int wait_for_media_ready(struct cxl_dev_state *cxlds)
> > +{
> > +     struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> > +     int d = cxlds->cxl_dvsec;
> > +     bool active = false;
> > +     u64 md_status;
> > +     int rc, i;
> > +
> > +     rc = wait_for_valid(cxlds);
> > +     if (rc)
> > +             return rc;
> > +
> > +     for (i = mbox_ready_timeout; i; i--) {
> > +             u32 temp;
> > +             int rc;
> > +
> > +             rc = pci_read_config_dword(
> > +                     pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &temp);
> > +             if (rc)
> > +                     return rc;
> > +
> > +             active = FIELD_GET(CXL_DVSEC_MEM_ACTIVE, temp);
> > +             if (active)
> > +                     break;
> > +             msleep(1000);
> Whilst it can be a while, this seems a bit of an excessive step to me.
> If the thing is ready in 10msecs we stil end up waiting a second.
> Might be worth checking more often, or doing some sort of fall off
> in frequency of checking.

I dunno, when the minimum hardware precision in the spec is 1 second
it's not clear that the driver can do better than this in practice.
Let's see what real platforms do. Part of me also thinks that this is
an incentive for devices to get ready before the OS might penalize
them with a coarse wait.
