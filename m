Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C77D17C0F0
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 15:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgCFOws (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 09:52:48 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38800 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgCFOws (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Mar 2020 09:52:48 -0500
Received: by mail-qk1-f194.google.com with SMTP id j7so2514293qkd.5
        for <linux-pci@vger.kernel.org>; Fri, 06 Mar 2020 06:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+GR87JEz7bnHSu9Y+6bwTYgFaQr/zFIG/NuG9Kdwt4s=;
        b=aihyF2t/7s9DwcSYHNvpWHnT3C1bxl/IZjNLEoNgOyzpHGq2CUT5SBQgARQYZcC3G6
         3QQcrLEwVInFxDWyTBXRLmXxACdXjYVIqAViex2/tQdPqzBlGGoQch5dkM9CiRhOY7Yr
         yUUf7KhbVdR7MKAD56vslHiz5RAfoDjMkqmQ4qTCQQ6gYW3ezJVfIhj1mUTLOa6MObXQ
         NNFpk5xfcDcsqIhcLIaVcUtJ5aS7/SVw3PB4wRfYRl19e3Sdp1bfYlUxjk95UosNuxLf
         bfLFXQreuG1sjxtV/SfKboz2+FupAmFWP79r+I3j96a8IihKr6R1cSfkp7pDo/v0x+v/
         8FdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+GR87JEz7bnHSu9Y+6bwTYgFaQr/zFIG/NuG9Kdwt4s=;
        b=OcO626GGsXUvlaJ720I1SXzhWpA1UiX8cvY/jQ4OHoHJDvtd04dMiLA+zF/Ge3G4kj
         zScF0V75P5V5Jcfi5x7Ms7kKFn32T1RIKGCbZ9893O7sOYVT3wD/sxMmET2HCo/uNFrz
         Zedz2MZ24UAQPFGES0htYSplFTDwkGrzxqmrMwn2noZM+Zo0FfMHq5m03rZcxncTdIZv
         /KQ6xYxV2S3wdG1y85/mC4FHEqtly1X7b2Ih+C1ulIH6fVyHL3WXygjjMawfGnueDb2Y
         esggRtMBOIREiFdH1rPCDzmn2I5jz3ppUMJ3iRl1Z9jaFquNenf+KZzpQzBH/fS+BYZ1
         0umA==
X-Gm-Message-State: ANhLgQ0o5iQ5w8cwTy5/CAHSLHxJHKAmlLQmb7be6WCGEkUh8f1LnEop
        8SLBYAceBGWyJbquRFpx74OoQg==
X-Google-Smtp-Source: ADFU+vt8B7E7ypc6uA8DcBdUQZ7yTuum2anrkiUB7D/EpPFaARsWnBpjWIkRxETgE9O5KR7vdHN99g==
X-Received: by 2002:a05:620a:1427:: with SMTP id k7mr3113149qkj.377.1583506366542;
        Fri, 06 Mar 2020 06:52:46 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id n59sm8640178qtd.77.2020.03.06.06.52.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Mar 2020 06:52:46 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jAELF-00041P-Jc; Fri, 06 Mar 2020 10:52:45 -0400
Date:   Fri, 6 Mar 2020 10:52:45 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     mark.rutland@arm.com, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, will@kernel.org,
        Dimitri Sivanich <sivanich@sgi.com>, catalin.marinas@arm.com,
        zhangfei.gao@linaro.org, devicetree@vger.kernel.org,
        kevin.tian@intel.com, Arnd Bergmann <arnd@arndb.de>,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        iommu@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        robin.murphy@arm.com, christian.koenig@amd.com
Subject: Re: [PATCH v4 01/26] mm/mmu_notifiers: pass private data down to
 alloc_notifier()
Message-ID: <20200306145245.GK31668@ziepe.ca>
References: <20200224190056.GT31668@ziepe.ca>
 <20200225092439.GB375953@myrica>
 <20200225140814.GW31668@ziepe.ca>
 <20200228143935.GA2156@myrica>
 <20200228144844.GQ31668@ziepe.ca>
 <20200228150427.GF2156@myrica>
 <20200228151339.GS31668@ziepe.ca>
 <20200306095614.GA50020@myrica>
 <20200306130919.GJ31668@ziepe.ca>
 <20200306143556.GA99609@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306143556.GA99609@myrica>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 06, 2020 at 03:35:56PM +0100, Jean-Philippe Brucker wrote:
> On Fri, Mar 06, 2020 at 09:09:19AM -0400, Jason Gunthorpe wrote:
> > On Fri, Mar 06, 2020 at 10:56:14AM +0100, Jean-Philippe Brucker wrote:
> > > I tried to keep it simple like that: normally mmu_notifier_get() is called
> > > in bind(), and mmu_notifier_put() is called in unbind(). 
> > > 
> > > Multiple device drivers may call bind() with the same mm. Each bind()
> > > calls mmu_notifier_get(), obtains the same io_mm, and returns a new bond
> > > (a device<->mm link). Each bond is freed by calling unbind(), which calls
> > > mmu_notifier_put().
> > > 
> > > That's the most common case. Now if the process is killed and the mm
> > > disappears, we do need to avoid use-after-free caused by DMA of the
> > > mappings and the page tables. 
> > 
> > This is why release must do invalidate all - but it doesn't need to do
> > any more - as no SPTE can be established without a mmget() - and
> > mmget() is no longer possible past release.
> 
> In our case we don't have SPTEs, the whole pgd is shared between MMU and
> IOMMU (isolated using PASID tables).

Okay, but this just means that 'invalidate all' also requires
switching the PASID to use some pgd that is permanently 'all fail'.

> At this point no one told the device to stop working on this queue,
> it may still be doing DMA on this address space.

Sure, but there are lots of cases where a defective user space can
cause pages under active DMA to disappear, like munmap for
instance. Process exit is really no different, the PASID should take
errors and the device & driver should do whatever error flow it has.

Involving a complex driver flow in the exit_mmap path seems like
dangerous complexity to me.

Jason
