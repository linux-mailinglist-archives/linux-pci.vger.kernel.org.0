Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E844161391
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2020 14:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgBQNb7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Feb 2020 08:31:59 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54248 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726646AbgBQNb7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Feb 2020 08:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581946317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lUvyoUjfSX5f6/1RRB0VYzW8DlAUW685MiMJyCEtR08=;
        b=FrEsHmAKDp5a8cE88FbPYcSH1oDK/PL2EF+Ph7DwXrKspD4RTfKAACrO7xqFJCSrnbbopc
        m7NiL5GVETojjk09/aZlyx6kY2yl3TMGN7zlgx/cGz+mH7EsnxXnUSL07c42OabDoaCzFl
        DmncKaWjpZ4l447YeKJ5BvgsMqefNbU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-zbECV5yrNQCFrfKI6k2O5g-1; Mon, 17 Feb 2020 08:31:55 -0500
X-MC-Unique: zbECV5yrNQCFrfKI6k2O5g-1
Received: by mail-qk1-f200.google.com with SMTP id c77so11838967qke.7
        for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2020 05:31:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lUvyoUjfSX5f6/1RRB0VYzW8DlAUW685MiMJyCEtR08=;
        b=A71Blv8apxx5R3ytfG9sBnVJ0AdBF+Vo3WQ6Ijv3Kl2caHcu9K4hUbFn46FUmDqmTP
         WlQMEAc6XCNU2L87z7Vd2dNcmv8rthvNynELMpYMkrxlcuzz/Ep0meXFz2JCL8vTT12O
         PPuogao/ic/s+ou7N2dyCv9NNvXdd0OqqZBxoqCg+Z5F9DWQ0kpwF4Hs+cWTA7kzLO4d
         tIUl+/JLl9ttSgh8HQkXiKCAAPdk5dAILwxjPqe480clMBYvVNSbNReAtdFy0oDDn/0e
         tIWQo8W7CJzuyKHS2fMmDHcQpNxwxmhkRLcXkyxf2xu0XGnqoXqnLW24vhIsOLLvByys
         Xw8Q==
X-Gm-Message-State: APjAAAUITTykc2/GKYXc8XT7xPSncqbGZrsn6kdiQ6rbwZ73YNGhCnbn
        g5v6ddNiJ79zwCNz6r1uP02dFKSffCygdgKN8x0Z+3MZ0pK6hlBygDVjG5XX1pjqLU5zpBdZ4Gb
        dPKNCkFBOx9uQiH6LHvME
X-Received: by 2002:ad4:42aa:: with SMTP id e10mr12528995qvr.92.1581946314840;
        Mon, 17 Feb 2020 05:31:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqzFFpTGQ2FvYsH22BKJUIToZTIyrsUmR2uTpY59CIvpA4dXhekQ3/kJ/uLcJkmo5vzAaPoAiQ==
X-Received: by 2002:ad4:42aa:: with SMTP id e10mr12528952qvr.92.1581946314375;
        Mon, 17 Feb 2020 05:31:54 -0800 (PST)
Received: from redhat.com (bzq-79-176-28-95.red.bezeqint.net. [79.176.28.95])
        by smtp.gmail.com with ESMTPSA id c8sm216623qkk.37.2020.02.17.05.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 05:31:53 -0800 (PST)
Date:   Mon, 17 Feb 2020 08:31:48 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, jacob.jun.pan@intel.com,
        bhelgaas@google.com, jasowang@redhat.com
Subject: Re: [PATCH 3/3] iommu/virtio: Enable x86 support
Message-ID: <20200217083112-mutt-send-email-mst@kernel.org>
References: <20200214160413.1475396-1-jean-philippe@linaro.org>
 <20200214160413.1475396-4-jean-philippe@linaro.org>
 <311a1885-c619-3c8d-29dd-14fbfbf74898@arm.com>
 <20200216045006-mutt-send-email-mst@kernel.org>
 <20200217090107.GA1650092@myrica>
 <20200217080129-mutt-send-email-mst@kernel.org>
 <915044ae-6972-e0eb-43e8-d071af848fe3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <915044ae-6972-e0eb-43e8-d071af848fe3@arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 17, 2020 at 01:22:44PM +0000, Robin Murphy wrote:
> On 17/02/2020 1:01 pm, Michael S. Tsirkin wrote:
> > On Mon, Feb 17, 2020 at 10:01:07AM +0100, Jean-Philippe Brucker wrote:
> > > On Sun, Feb 16, 2020 at 04:50:33AM -0500, Michael S. Tsirkin wrote:
> > > > On Fri, Feb 14, 2020 at 04:57:11PM +0000, Robin Murphy wrote:
> > > > > On 14/02/2020 4:04 pm, Jean-Philippe Brucker wrote:
> > > > > > With the built-in topology description in place, x86 platforms can now
> > > > > > use the virtio-iommu.
> > > > > > 
> > > > > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > > > ---
> > > > > >    drivers/iommu/Kconfig | 3 ++-
> > > > > >    1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > > > > > index 068d4e0e3541..adcbda44d473 100644
> > > > > > --- a/drivers/iommu/Kconfig
> > > > > > +++ b/drivers/iommu/Kconfig
> > > > > > @@ -508,8 +508,9 @@ config HYPERV_IOMMU
> > > > > >    config VIRTIO_IOMMU
> > > > > >    	bool "Virtio IOMMU driver"
> > > > > >    	depends on VIRTIO=y
> > > > > > -	depends on ARM64
> > > > > > +	depends on (ARM64 || X86)
> > > > > >    	select IOMMU_API
> > > > > > +	select IOMMU_DMA
> > > > > 
> > > > > Can that have an "if X86" for clarity? AIUI it's not necessary for
> > > > > virtio-iommu itself (and really shouldn't be), but is merely to satisfy the
> > > > > x86 arch code's expectation that IOMMU drivers bring their own DMA ops,
> > > > > right?
> > > > > 
> > > > > Robin.
> > > > 
> > > > In fact does not this work on any platform now?
> > > 
> > > There is ongoing work to use the generic IOMMU_DMA ops on X86. AMD IOMMU
> > > has been converted recently [1] but VT-d still implements its own DMA ops
> > > (conversion patches are on the list [2]). On Arm the arch Kconfig selects
> > > IOMMU_DMA, and I assume we'll have the same on X86 once Tom's work is
> > > complete. Until then I can add a "if X86" here for clarity.
> > > 
> > > Thanks,
> > > Jean
> > > 
> > > [1] https://lore.kernel.org/linux-iommu/20190613223901.9523-1-murphyt7@tcd.ie/
> > > [2] https://lore.kernel.org/linux-iommu/20191221150402.13868-1-murphyt7@tcd.ie/
> > 
> > What about others? E.g. PPC?
> 
> That was the point I was getting at - while iommu-dma should build just fine
> for the likes of PPC, s390, 32-bit Arm, etc., they have no architecture code
> to correctly wire up iommu_dma_ops to devices. Thus there's currently no
> point pulling it in and pretending it's anything more than a waste of space
> for architectures other than arm64 and x86. It's merely a historical
> artefact of the x86 DMA API implementation that when the IOMMU drivers were
> split out to form drivers/iommu they took some of their relevant arch code
> with them.
> 
> Robin.


Rather than white-listing architectures, how about making the
architectures in question set some kind of symbol, and depend on it?

-- 
MST

