Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A406640B641
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 19:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhINRzS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 13:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhINRzP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Sep 2021 13:55:15 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AA2C061574
        for <linux-pci@vger.kernel.org>; Tue, 14 Sep 2021 10:53:58 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id s11so13464815pgr.11
        for <linux-pci@vger.kernel.org>; Tue, 14 Sep 2021 10:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dYpAQA0tbQZfMcz8zOrS6/NwGbmoaqWAssb2XF6h/jc=;
        b=iZXBU8Xt9dVleHmWvdHvdeH8deQj+0Ls5rdVLhtdRRgJZBO6hA/yz9Ykl4GGjwNhAm
         P7JJ4gd6lBVpaew0Hl/YZWyfpmaMRol1s5eN9Y5JwGXIqI0fm2kdlZxtVao6vFCcuiFs
         hl0UjZ+nRQh+yOiu9mBpqh9Jg+ecoFfDrDFWNyNMtXK7UlSdNZOOQHkmzumNr21ZdZjZ
         96Bt5NCpFPfEMKqH5imbaxqE4JXx+qWoEPJRUZktvgmM/geTuhqYBIcmbK+QYrDw0n1k
         Ia0v890i9/KI0/HeiddsIYcDXQzDuwPkc8VLObm+Feve2AJAn3FasiP79kx7O3SuB9zM
         yiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dYpAQA0tbQZfMcz8zOrS6/NwGbmoaqWAssb2XF6h/jc=;
        b=r0FIn1RHitkiZmldrP/nvr+HUU3hxAvsoKq9iHeSTJMTi0fWBpLyBNCNoyG9mq0Jhl
         3y3a0LJHUjD5UCyRuV11gF5xxxNYcfmmPj8ns6jKo5flPWjFmdpZWWQlqBO7I7Uv5vxo
         Vk+vU7kYfuTW7NoDV7wFfyFyVOFtB5JT0X1kHPdH19liWCV5zjOaH3JBux4KMdt5AC2k
         et2bj3U/Z5aXvDcpHBhvztrAPZyX/4VJR8YoTQ5p7Hnin5Vc71Ybz/I/mFP1H04XV3v0
         TLZN1QwsmvdzcqAyAeE08vBbfMwDehix3bwDzFW+mC1KG1T7Jbe4uJH8HV8xH3Xwvkoo
         TVXg==
X-Gm-Message-State: AOAM532jwdbIhZvhLjrvCpPmxYXdT0jj0jbo+fXUXnxO5nEz7CVeKCpI
        +WtXHMJmUihaLaA/JN31F0rk+qRcOKnjzMRyjuXckw==
X-Google-Smtp-Source: ABdhPJyAc15V77dGNJ+6cV02dE4mBOPP1dSbXvWeYFLxZwXk6shY4z/KNp+FBxwXwP+1B+DyHOcOIVdj1m7H/U2sG/8=
X-Received: by 2002:a63:7013:: with SMTP id l19mr16342904pgc.342.1631642037206;
 Tue, 14 Sep 2021 10:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210913163847.GA1335093@bjorn-Precision-5520> <9cae764f00c5969c364728ed031c29ce49c03480.camel@amazon.de>
In-Reply-To: <9cae764f00c5969c364728ed031c29ce49c03480.camel@amazon.de>
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 14 Sep 2021 10:53:20 -0700
Message-ID: <CACK8Z6HcG45DNYQEGxDvZbL8WkF2uVoO5rCTOh1yCjxnxco5ig@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] PCI: Add CRS handling to pci_dev_wait()
To:     "Spassov, Stanislav" <stanspas@amazon.de>
Cc:     "helgaas@kernel.org" <helgaas@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "okaya@kernel.org" <Okaya@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        =?UTF-8?B?U2Now7ZuaGVyciwgSmFuIEgu?= <jschoenh@amazon.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 13, 2021 at 11:04 AM Spassov, Stanislav <stanspas@amazon.de> wrote:
>
> On Mon, 2021-09-13 at 11:38 -0500, Bjorn Helgaas wrote:
> > On Mon, Sep 13, 2021 at 04:29:51PM +0000, Spassov, Stanislav wrote:
> > > On Sat, 2021-09-11 at 09:03 -0500, Bjorn Helgaas wrote:
> > >
> > > I later understood the specific CPU did have a proprietary register for
> > > "limiting the number of loops" that the PCIe spec talks about, and indeed
> > > that register was set to "no limit". Coupled with the stuck device, these
> > > indefinite retries eventually triggered TOR timeout.
> >
> > "No limit" sounds like a pretty bad choice, given that it means the
> > CPU will essentially hang forever because of a defective I/O device.
> > There should be a timeout so software can recover (the *device* may
> > never recover, but that's no reason why the kernel must crash).
> >
>
> Correct. "No limit" is definitely a bad choice for that register,
> and fixing the value would be preferable to any software solution.
>
> Unfortunately, at least in the case I worked on, that register was
> not accessible by the kernel.

I can acknowledge that I have across exactly the same issue (no limit
on retries, results in CPU hang) on another old Intel root port too in
the past:
https://lore.kernel.org/linux-pci/53FFA54D.9000907@gmail.com/
https://lkml.org/lkml/2014/8/1/186

and had the same problem (no way to limit the number of retries). I'd
be interested and will keep a lookout for the next patch Stanislav
sends out!

Thanks!

Rajat

> Intel exposes many CPU configuration
> registers in terms of virtual PCI devices residing directly on Root
> Buses, and the system/platform firmware is able to use vendor-provided
> means to completely hide some of these pseudo-devices from the OS.
>
> Additionally, the way the PCIe spec is phrased, not every Root Complex
> implementation is required to even have such a limiting register, while
> all implementations that advertise CRS SV capability are required to
> behave as prescribed when PCI_VENDOR_ID is read. Hence why I believe
> this patch is a general robustness improvement, rather than a workaround
> for a specific device/platform.
>
>
>
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
>
>
