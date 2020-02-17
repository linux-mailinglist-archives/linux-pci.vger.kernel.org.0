Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E379161298
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2020 14:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgBQNCE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Feb 2020 08:02:04 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26086 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728297AbgBQNCD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Feb 2020 08:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581944522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TP4MnY7tGPhZNJTAZItTt9kiyklHpFFJJPLHhX1/LOE=;
        b=hX31T17MTaJbEWb7LfEG3wNXS/qY3INES+eWfUbrIRQ2522tYUziFXtMiPlKfJPuoJpe2v
        9cbKSrkFZ7oaVe45uPkp80Uy/zr/Lm03P+ui/4XLjHMaDEQ0ErLRUd9NRqKhjytYNhjllP
        Yi4Sbl3mmojyYctcFDbErK6JNQYOVcE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-1UfLfJ4UMPOjzeGRbTos3Q-1; Mon, 17 Feb 2020 08:01:56 -0500
X-MC-Unique: 1UfLfJ4UMPOjzeGRbTos3Q-1
Received: by mail-qt1-f200.google.com with SMTP id c22so10853554qtn.23
        for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2020 05:01:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TP4MnY7tGPhZNJTAZItTt9kiyklHpFFJJPLHhX1/LOE=;
        b=KXZ/p4w6qTC2dxt/S0Dve5yGG1To8fpNIJYEvA1FwXLr97Ul7joEdRlB+g2EJK4VlP
         5XSN7dFqjvmYNZPC96QjfS6i4eyl8czjsAPUV4qBak1ll2zgOo8PtfL0JrFUzC+ZRTgR
         dtxNrEv8Q4EF2NfHvCkDXtf1DbQJyy3pNM7O79ojItdqDr512VFUwy4KnjjqorFGtRVV
         or6pvOM8g2MBEmFyX1M3I62RqioY8T76fhgkN+YlccnrctvtH8UKwxarsS5AYWWG36nn
         m+vsdVz/Lhc2M7bks1cCx5X9wpP+fx4uBBrOm5kSldwExe4GPnmT1u6v3Oxz89/PHCMY
         6XlQ==
X-Gm-Message-State: APjAAAX0XxPUZX4TvIWOaQfNSTaawOxGmPLjkK7KuI4ZGnkNu8aTdRDL
        npvQNz5t7u4RNkyS4+TACtJMUN6R6Z8KpTwSaH0BNdV/jGf90I7XkSWjjFQ6XFx+YZnwYTW5jJM
        EIKFJ5x/bFJxkA6FPbNPz
X-Received: by 2002:a37:9d7:: with SMTP id 206mr11068866qkj.416.1581944516121;
        Mon, 17 Feb 2020 05:01:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqyQ8C5G4SdbUsD8P4MFfVMK/CjTlG/8dSUmGSJJgcnBeSViAiOdw0hxzTa6igiB5lQZky9sqA==
X-Received: by 2002:a37:9d7:: with SMTP id 206mr11068844qkj.416.1581944515885;
        Mon, 17 Feb 2020 05:01:55 -0800 (PST)
Received: from redhat.com (bzq-79-176-28-95.red.bezeqint.net. [79.176.28.95])
        by smtp.gmail.com with ESMTPSA id n4sm133284qti.55.2020.02.17.05.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 05:01:55 -0800 (PST)
Date:   Mon, 17 Feb 2020 08:01:49 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, jacob.jun.pan@intel.com,
        bhelgaas@google.com, jasowang@redhat.com
Subject: Re: [PATCH 3/3] iommu/virtio: Enable x86 support
Message-ID: <20200217080129-mutt-send-email-mst@kernel.org>
References: <20200214160413.1475396-1-jean-philippe@linaro.org>
 <20200214160413.1475396-4-jean-philippe@linaro.org>
 <311a1885-c619-3c8d-29dd-14fbfbf74898@arm.com>
 <20200216045006-mutt-send-email-mst@kernel.org>
 <20200217090107.GA1650092@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217090107.GA1650092@myrica>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 17, 2020 at 10:01:07AM +0100, Jean-Philippe Brucker wrote:
> On Sun, Feb 16, 2020 at 04:50:33AM -0500, Michael S. Tsirkin wrote:
> > On Fri, Feb 14, 2020 at 04:57:11PM +0000, Robin Murphy wrote:
> > > On 14/02/2020 4:04 pm, Jean-Philippe Brucker wrote:
> > > > With the built-in topology description in place, x86 platforms can now
> > > > use the virtio-iommu.
> > > > 
> > > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > ---
> > > >   drivers/iommu/Kconfig | 3 ++-
> > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > > > index 068d4e0e3541..adcbda44d473 100644
> > > > --- a/drivers/iommu/Kconfig
> > > > +++ b/drivers/iommu/Kconfig
> > > > @@ -508,8 +508,9 @@ config HYPERV_IOMMU
> > > >   config VIRTIO_IOMMU
> > > >   	bool "Virtio IOMMU driver"
> > > >   	depends on VIRTIO=y
> > > > -	depends on ARM64
> > > > +	depends on (ARM64 || X86)
> > > >   	select IOMMU_API
> > > > +	select IOMMU_DMA
> > > 
> > > Can that have an "if X86" for clarity? AIUI it's not necessary for
> > > virtio-iommu itself (and really shouldn't be), but is merely to satisfy the
> > > x86 arch code's expectation that IOMMU drivers bring their own DMA ops,
> > > right?
> > > 
> > > Robin.
> > 
> > In fact does not this work on any platform now?
> 
> There is ongoing work to use the generic IOMMU_DMA ops on X86. AMD IOMMU
> has been converted recently [1] but VT-d still implements its own DMA ops
> (conversion patches are on the list [2]). On Arm the arch Kconfig selects
> IOMMU_DMA, and I assume we'll have the same on X86 once Tom's work is
> complete. Until then I can add a "if X86" here for clarity.
> 
> Thanks,
> Jean
> 
> [1] https://lore.kernel.org/linux-iommu/20190613223901.9523-1-murphyt7@tcd.ie/
> [2] https://lore.kernel.org/linux-iommu/20191221150402.13868-1-murphyt7@tcd.ie/

What about others? E.g. PPC?

-- 
MST

