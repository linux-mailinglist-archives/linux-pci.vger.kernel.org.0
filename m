Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35CD0160DEC
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2020 10:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbgBQJBT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Feb 2020 04:01:19 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38012 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728563AbgBQJBT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Feb 2020 04:01:19 -0500
Received: by mail-wm1-f65.google.com with SMTP id a9so17476341wmj.3
        for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2020 01:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Brb83lZtOeRlFQ/bRFw4GYUb2M+D+Mxxk7UBESF/VJw=;
        b=vNWO019J+EkB584lxB0GckEDBBfH9ga5QOX2gtMZmlcfhbgC0Vv5GmIo5ilaSatuO2
         kMSqQIkDKb/9GkARhFt5fjiTnpLzJitIxxwFAF4X4QDAiVHDqAmOIX3hqh5JfBhdQftH
         dnw56ku8wO3Dq/q3esdhDBSrDZuYgp648W4LVQ5+WDqyOnMyk8swSfl7vUs8V0QhnEF7
         1cB1XatwZx/9GCZIPOx8a1Fl74Y6n+cP0GoUEsisqUKYTz/T+zCJCwLW+enQ7kW8LcPP
         FyO+FZAwPZDSUhjufHRqzLvKZzQ11+6Ea2LykfxSLnGlM4AmKJgvyYq1fDVKd4SI7DOx
         rojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Brb83lZtOeRlFQ/bRFw4GYUb2M+D+Mxxk7UBESF/VJw=;
        b=Vh3TuGKzsNGo9x0e89fJW57/rnmfBjonAMoYZWOjkNINR2e14UhnslDKP/iq4iPNMq
         mjsq0bDiNfgO4IdaI5ZGCm0TexNGTpchInjXspnh62WWNggjMbtFMiGEohoGIfJ40esw
         T4laBM1OnTFaQmIUF+r60Z5Ucc0aByniFe+kr0zk+ufw6/n6RomQqiDORpcy7jlNM1qZ
         fXtSTaPnLyoLKMwFo9/lDNs03ILn8zfLAtXNj59zi8a/tjEXrtZnx+BFGPY5uHhGhPzG
         7+r9lXtjQVuYg+OQwsyYV6q0oCxo0MWYL6S5ronLjU0eEM4iTPVT6Mmk8cXXsj+8HOUF
         gboA==
X-Gm-Message-State: APjAAAW97oGJhpgE67kPs6B+NvdybIXUmKt3/dSyojCEY8NjljJP29M6
        VnLG1YUXBWxngLIK5TjtMugOKg==
X-Google-Smtp-Source: APXvYqzkpI772n/UQE5ai98F9d50e69d9O8VM028XZHeVkrEWip8LT7SDvd/+yCMdba14AIMpFdK4Q==
X-Received: by 2002:a1c:4008:: with SMTP id n8mr21058614wma.121.1581930076262;
        Mon, 17 Feb 2020 01:01:16 -0800 (PST)
Received: from myrica ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id a26sm19566259wmm.18.2020.02.17.01.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 01:01:15 -0800 (PST)
Date:   Mon, 17 Feb 2020 10:01:07 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, jacob.jun.pan@intel.com,
        bhelgaas@google.com, jasowang@redhat.com
Subject: Re: [PATCH 3/3] iommu/virtio: Enable x86 support
Message-ID: <20200217090107.GA1650092@myrica>
References: <20200214160413.1475396-1-jean-philippe@linaro.org>
 <20200214160413.1475396-4-jean-philippe@linaro.org>
 <311a1885-c619-3c8d-29dd-14fbfbf74898@arm.com>
 <20200216045006-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200216045006-mutt-send-email-mst@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Feb 16, 2020 at 04:50:33AM -0500, Michael S. Tsirkin wrote:
> On Fri, Feb 14, 2020 at 04:57:11PM +0000, Robin Murphy wrote:
> > On 14/02/2020 4:04 pm, Jean-Philippe Brucker wrote:
> > > With the built-in topology description in place, x86 platforms can now
> > > use the virtio-iommu.
> > > 
> > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > ---
> > >   drivers/iommu/Kconfig | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > > index 068d4e0e3541..adcbda44d473 100644
> > > --- a/drivers/iommu/Kconfig
> > > +++ b/drivers/iommu/Kconfig
> > > @@ -508,8 +508,9 @@ config HYPERV_IOMMU
> > >   config VIRTIO_IOMMU
> > >   	bool "Virtio IOMMU driver"
> > >   	depends on VIRTIO=y
> > > -	depends on ARM64
> > > +	depends on (ARM64 || X86)
> > >   	select IOMMU_API
> > > +	select IOMMU_DMA
> > 
> > Can that have an "if X86" for clarity? AIUI it's not necessary for
> > virtio-iommu itself (and really shouldn't be), but is merely to satisfy the
> > x86 arch code's expectation that IOMMU drivers bring their own DMA ops,
> > right?
> > 
> > Robin.
> 
> In fact does not this work on any platform now?

There is ongoing work to use the generic IOMMU_DMA ops on X86. AMD IOMMU
has been converted recently [1] but VT-d still implements its own DMA ops
(conversion patches are on the list [2]). On Arm the arch Kconfig selects
IOMMU_DMA, and I assume we'll have the same on X86 once Tom's work is
complete. Until then I can add a "if X86" here for clarity.

Thanks,
Jean

[1] https://lore.kernel.org/linux-iommu/20190613223901.9523-1-murphyt7@tcd.ie/
[2] https://lore.kernel.org/linux-iommu/20191221150402.13868-1-murphyt7@tcd.ie/
