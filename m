Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781BF1CE595
	for <lists+linux-pci@lfdr.de>; Mon, 11 May 2020 22:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731672AbgEKUch (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 May 2020 16:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729517AbgEKUcg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 May 2020 16:32:36 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD61C061A0C
        for <linux-pci@vger.kernel.org>; Mon, 11 May 2020 13:32:34 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id d22so2627361lfm.11
        for <linux-pci@vger.kernel.org>; Mon, 11 May 2020 13:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FkxZVAtU+G2bSVwd5pdyFQQWmCwDKF3sYHGz7WeVpUw=;
        b=ohOnQic8BsVvrb5GjV+XEl9aVJ+dM/ztKzQmdjv8JR5rjSCX9hV/OGO7feChO5HPz8
         Au2JChh5XplJtr3M3na7x/qs3t1pr+mAiKIkqyhl4OZsM9lG4UlgQ8ocLFq4GlAO/9fY
         ydFw0Tj5bCVs9k6KINEL8ZEwprTzcFCKAzlvS7s9g6nqRypzFXrrOxq9s9wuzSPh1UGW
         xefRXJMU9zBAucru4crFUWCx2JMzaeW0rDxj7u/McYoQpv/sc1RuVopnQHsR/oqgw6py
         AV4nH2IXX0LZMI7eQFmMSXd7O9Klkw8EXi143x14UhkS9z+Ctap1SDb1DF8A2rfxsQgQ
         gwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FkxZVAtU+G2bSVwd5pdyFQQWmCwDKF3sYHGz7WeVpUw=;
        b=StN0vWcBVSk2TluGdowyXJgA2wTFSsW/UPVYciSm2g1nwTa54u/C0iTZ7XB3/CvSs5
         VUQXNQVdiuqFOY3oK47a78+J0Gdu0RHrcELwGCEVk5WcLL4K2njhAwMv6DovG4ZNYd2A
         jB005pTBq3Vc3ImZHKkyoAnH7YPUbblHjTv9uq+g5LjTRYmj1PpeC4te/MDJdfBJ7E3Q
         dwZ7a7d/4o0ckiNm4dYqh3FhTHFZdrqYf5bf2wf7jTN7HK0CftTSHE+HWYDAnQTQRRiI
         Wfwnih3gJZ+MUJRrmbQwzQNzpIsfom8xErjst5cjhb+/hnPxpFL2wIRCg8t+xxO9hGko
         7kIw==
X-Gm-Message-State: AOAM531C1Cl7VZNW1t1b69s36RnEi23Hw7sqU80UBrIKa01FoJ+V8S8t
        7PKp6WDvGA/jxsfeJp2xK6vtEHS2kAYV9EDOde/bxA==
X-Google-Smtp-Source: ABdhPJx6rXMDIdTQ1Msjxj6G/2lAMLiDfEqjOQBPtVaKnTubQbaa75dst1IRoMNE7cuQmJ/CKMtEALoKOqtOLAgrCwI=
X-Received: by 2002:ac2:4293:: with SMTP id m19mr3095430lfh.204.1589229153148;
 Mon, 11 May 2020 13:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <CACK8Z6E8pjVeC934oFgr=VB3pULx_GyT2NkzAogdRQJ9TKSX9A@mail.gmail.com>
In-Reply-To: <CACK8Z6E8pjVeC934oFgr=VB3pULx_GyT2NkzAogdRQJ9TKSX9A@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 11 May 2020 13:31:56 -0700
Message-ID: <CACK8Z6FEZFKA9xo-UkADAun-hK71CdFu=1OjukEF=zC9kbpKPQ@mail.gmail.com>
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Zubin Mithra <zsm@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        "Keany, Bernie" <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Fri, May 1, 2020 at 4:07 PM Rajat Jain <rajatja@google.com> wrote:
>
> Hi,
>
> Currently, the PCI subsystem marks the PCI devices as "untrusted", if
> the firmware asks it to:
>
> 617654aae50e ("PCI / ACPI: Identify untrusted PCI devices")
> 9cb30a71acd4 ("PCI: OF: Support "external-facing" property")
>
> An "untrusted" device indicates a (likely external facing) device that
> may be malicious, and can trigger DMA attacks on the system. It may
> also try to exploit any vulnerabilities exposed by the driver, that
> may allow it to read/write unintended addresses in the host (e.g. if
> DMA buffers for the device, share memory pages with other driver data
> structures or code etc).
>
> High Level proposal
> ===============
> Currently, the "untrusted" device property is used as a hint to enable
> IOMMU restrictions (on Intel), disable ATS (on ARM) etc. We'd like to
> go a step further, and allow the administrator to build a list of
> whitelisted drivers for these "untrusted" devices. This whitelist of
> drivers are the ones that he trusts enough to have little or no
> vulnerabilities. (He may have built this list of whitelisted drivers
> by a combination of code analysis of drivers, or by extensive testing
> using PCIe fuzzing etc). We propose that the administrator be allowed
> to specify this list of whitelisted drivers to the kernel, and the PCI
> subsystem to impose this behavior:
>
> 1) The "untrusted" devices can bind to only "whitelisted drivers".
> 2) The other devices (i.e. dev->untrusted=0) can bind to any driver.
>
> Of course this behavior is to be imposed only if such a whitelist is
> provided by the administrator.

I was wondering if you got a chance to look at this proposal? WDYT?

Thanks & Best Regards,

Rajat


>
> Details
> ======
>
> 1) A kernel argument ("pci.impose_driver_whitelisting") to enable
> imposing of whitelisting by PCI subsystem.
>
> 2) Add a flag ("whitelisted") in struct pci_driver to indicate whether
> the driver is whitelisted.
>
> 3) Use the driver's "whitelisted" flag and the device's "untrusted"
> flag, to make a decision about whether to bind or not in
> pci_bus_match() or similar.
>
> 4) A mechanism to allow the administrator to specify the whitelist of
> drivers. I think this needs more thought as there are multiple
> options.
>
> a) Expose individual driver's "whitelisted" flag to userspace so a
> boot script can whitelist that driver. There are questions that still
> need answered though e.g. what to do about the devices that may have
> already been enumerated and rejected by then? What to do with the
> already bound devices, if the user changes a driver to remove it from
> the whitelist. etc.
>
>       b) Provide a way to specify the whitelist via the kernel command
> line. Accept a ("pci.whitelist") kernel parameter which is a comma
> separated list of driver names (just like "module_blacklist"), and
> then use it to initialize each driver's "whitelisted" flag as the
> drivers are registered. Essentially this would mean that the whitelist
> of devices cannot be changed after boot.
>
> To me (b) looks a better option but I think a future requirement would
> be the ability to remove the drivers from the whitelist after boot
> (adding drivers to whitelist at runtime may not be that critical IMO)
>
>  WDYT?
>
> Thanks,
>
> Rajat
