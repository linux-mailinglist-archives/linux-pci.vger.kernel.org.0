Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35BAC1A5C64
	for <lists+linux-pci@lfdr.de>; Sun, 12 Apr 2020 05:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgDLDuV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Apr 2020 23:50:21 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:40008 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgDLDuV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Apr 2020 23:50:21 -0400
Received: by mail-qv1-f66.google.com with SMTP id k9so2892732qvw.7
        for <linux-pci@vger.kernel.org>; Sat, 11 Apr 2020 20:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zhoRhZDp08/Quy9bCcHgtDQxeTieG6fo0BmAZCUWVT0=;
        b=wLCfbz64y+8kPiY0+va7itbGbEkr9OiPxqNpPlyD19X7zcskbzPg+3TG4gR26frwtI
         Ty3K7iiNK/as921hvyJeGC7dDDXKgS+V7UsP34ZFPt1LqkpWmtTCc/3GPOWZtVaPET7m
         rXU2n3JmL/VisI/TYM6QT+xrNb+7kpzAlIEQ7rsXyogDxbsh0PmdsoUtLJ8hkdJ13Uqz
         2Uxl+dDBnVwOaPvEHayPxS5+nF7CWu33rz4QWdA9kbGSc31KE37TYvpa9CTbYXYL/e1Z
         kdCQwfvvOQPRTjI62pwH+lK9FiCQ9YrS/pXmLuh9XY41pWNZiGu50EEAYk5o2lEnTGWE
         uG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zhoRhZDp08/Quy9bCcHgtDQxeTieG6fo0BmAZCUWVT0=;
        b=VQzrq9ohA2S2N7+lf4/udxHMX7KUeoOJdg6tvsL7W837lR1o0Qn0QbCU5DNvVCfPD5
         kjy29Cy3W8/QwpLr8U2mLYOMGvEcY2nKBxlUxLHo7/C/CySjNgUOhj5yIQ8wOey6oqSq
         A7sIBQQfXXH41Wedpv/kEG4UGOpVLc9icEywJfbuYpuB5greZQEluGeXW0wyiefqFuDj
         QGsulrGqKcyiss1PBc7FC+dOEPqHZZY6W2PudH41F/2J6qz5w/ZsiEEblAkeDtRGGH4R
         Z1my/eS9NnOEjeNumNj30aqu7UsJpCirinIQ5rvSsgWpV0AS7GjAydJOE/sQAjYhbtPU
         BcFw==
X-Gm-Message-State: AGi0PuY1ws+O2LyrCOw/tmjyiR7v4khzigHBo3DqGVL0P/O7nqkDG0he
        74aQV7waiGuX0p8aVmbbjPixR/6/FaTgMtqgdJJNrQ==
X-Google-Smtp-Source: APiQypIPtGp+Rk2/ThEt56ejQs/3C9hKMliJgxzSeMLEWQqrnotFIgltyl8Zm3S3qvJdGxZ/XTZeHCqFOn4SYHNPH+Q=
X-Received: by 2002:a05:6214:1781:: with SMTP id ct1mr11957162qvb.87.1586663420608;
 Sat, 11 Apr 2020 20:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200409191736.6233-1-jonathan.derrick@intel.com> <20200409191736.6233-2-jonathan.derrick@intel.com>
In-Reply-To: <20200409191736.6233-2-jonathan.derrick@intel.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Sun, 12 Apr 2020 11:50:09 +0800
Message-ID: <CAD8Lp442LO1Sq5xpKOaRUKLsEyGbou4TiHQrDdnMbCOV-TG0+g@mail.gmail.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: use DMA domain for real DMA devices and subdevices
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jon,

Thanks for picking this up. Apologies for my absence here - I wasn't
able to work on this recently, but I'm back again now.

On Fri, Apr 10, 2020 at 3:32 AM Jon Derrick <jonathan.derrick@intel.com> wrote:
> This becomes problematic if the real DMA device and the subdevices have
> different addressing capabilities and some require translation. Instead we can
> put the real DMA dev and any subdevices on the DMA domain. This change assigns
> subdevices to the DMA domain, and moves the real DMA device to the DMA domain
> if necessary.

Have you tested this with the real DMA device in identity mode?
It is not quite working for me. (Again, I'm not using VMD here, but
have looked closely and believe we're working under the same
constraints)

First, the real DMA device gets added to the group:
 pci 0000:00:17.0: Adding to iommu group 9
(it's in IDENTITY mode here)

Then later, the first subdevice comes along, and these are the results:
 pci 10000:00:00.0: [8086:02d7] type 00 class 0x010601
 pci 10000:00:00.0: reg 0x10: [mem 0xae1a0000-0xae1a7fff]
 pci 10000:00:00.0: reg 0x14: [mem 0xae1a8000-0xae1a80ff]
 pci 10000:00:00.0: reg 0x18: [io  0x3090-0x3097]
 pci 10000:00:00.0: reg 0x1c: [io  0x3080-0x3083]
 pci 10000:00:00.0: reg 0x20: [io  0x3060-0x307f]
 pci 10000:00:00.0: reg 0x24: [mem 0xae100000-0xae103fff]
 pci 10000:00:00.0: PME# supported from D3hot
 pci 10000:00:00.0: Adding to iommu group 9
 pci 10000:00:00.0: DMAR: Failed to get a private domain.

That final message is added by your patch and indicates that it's not working.

This is because the subdevice got added to the iommu group before the
code you added tried to change to the DMA domain.

It first gets added to the group through this call path:
    intel_iommu_add_device
-> iommu_group_get_for_dev
-> iommu_group_add_device

Then, continuing within intel_iommu_add_device we get to the code you
added, which tries to move the real DMA dev to DMA mode instead. It
calls:

   intel_iommu_request_dma_domain_for_dev
-> iommu_request_dma_domain_for_dev
-> request_default_domain_for_dev

Which fails here:
    /* Don't change mappings of existing devices */
    ret = -EBUSY;
    if (iommu_group_device_count(group) != 1)
        goto out;

because we already have 2 devices in the group (the real DMA dev, plus
the subdevice we're in the process of handling now).

Next I'll look into the iommu group rework that Baolu mentioned.

Thanks,
Daniel
