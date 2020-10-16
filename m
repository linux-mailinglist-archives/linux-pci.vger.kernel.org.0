Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232F428FF98
	for <lists+linux-pci@lfdr.de>; Fri, 16 Oct 2020 09:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404885AbgJPH7r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Oct 2020 03:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404879AbgJPH7q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Oct 2020 03:59:46 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36457C061755
        for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2020 00:59:45 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id u8so1847115ejg.1
        for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2020 00:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=03DOhrJDL5rvreyCBcw0jIDT7tlt+F6osYNRc3Rm0p0=;
        b=AXO/y3oqhkAx277okQZUKWEAw+vUgs2QZOnmeULGWOsnak6iU+2TBcGzkpnmpuotky
         UpXpFcAhSTZSCE9jdqC80S9vXD/c3NEc1X5B9I7NGxebA6uu5wBX6VkPI1PREroBfyLV
         QyZbRsFZlspUUYl2QwPLCcdui2ViKkbI1sKXffIF7w6flTckkVTX/WcwPN/GIZ7kYjDL
         y0IARGvoz1Nlccz2i4SgSYLvOk1FDUMA1+8LHw+5Z3QI14IQHYDqreh1V+fpyZf5XjJj
         fTgP6AAnXAfGOzP0YX15ng1rmFjZNXl6Z5VTrF/jRpfoO0W6vGM9XMbqbAsOZyHpiEgJ
         SMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=03DOhrJDL5rvreyCBcw0jIDT7tlt+F6osYNRc3Rm0p0=;
        b=ppLV7F93EyCU2YPrG4F39YwYqREoe1ka1Rrua9txvQLN19l/UfQoe+wBN74hecr489
         B8sbwDWVJpzg1VkXXqT5jEf1QlufOZb8DujKx+aFqUnHdySBcYobjxdwcs9sn2fFpUd6
         e15nm6au4z0lHWiAZc1acMpF6EdprLW3+hmXhTe3cYC7uobT9vx9j1twsyk/K/knCMAb
         18WxiTnWgnNEg8mKu3sbTsq9/YYxq3AWE0VfJ0EWKpmlBKw2ySCYHVe4KVADdpjAAQNX
         rvhqBZ4yMqZ/0ALv8soxPohlwPv2fkWlDkGGmmH8FfReQ81f5mV3kFKZWGcqnrRPv7+i
         pijQ==
X-Gm-Message-State: AOAM531PK7fOH72QRw5lDUQSVAvhpQ2Ia+IZ6TvXX8mw+hTPv9LiInoa
        ZAGppdxhEdo12TTUSPUKF9pfMw==
X-Google-Smtp-Source: ABdhPJzGVE1atWvkB7LrGmajoxWfG1xm3eNXeHUNWG/NObArKnYSB4e+4mDV6HjYs0wGZ3DY2ZmJug==
X-Received: by 2002:a17:906:5509:: with SMTP id r9mr2580181ejp.12.1602835183798;
        Fri, 16 Oct 2020 00:59:43 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id u18sm1010747ejm.115.2020.10.16.00.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 00:59:43 -0700 (PDT)
Date:   Fri, 16 Oct 2020 09:59:23 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        zhangfei.gao@linaro.org, wangzhou1@hisilicon.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-accelerators@lists.ozlabs.org,
        kevin.tian@intel.com, jacob.jun.pan@linux.intel.com,
        linux-pci@vger.kernel.org, "Lu, Baolu" <baolu.lu@intel.com>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>
Subject: Re: [RFC PATCH 0/2] iommu: Avoid unnecessary PRI queue flushes
Message-ID: <20201016075923.GB1309464@myrica>
References: <20201015090028.1278108-1-jean-philippe@linaro.org>
 <20201015182211.GA54780@otc-nc-03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015182211.GA54780@otc-nc-03>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 15, 2020 at 11:22:11AM -0700, Raj, Ashok wrote:
> Hi Jean
> 
> + Baolu who is looking into this.
> 
> 
> On Thu, Oct 15, 2020 at 11:00:27AM +0200, Jean-Philippe Brucker wrote:
> > Add a parameter to iommu_sva_unbind_device() that tells the IOMMU driver
> > whether the PRI queue needs flushing. When looking at the PCIe spec
> > again I noticed that most of the time the SMMUv3 driver doesn't actually
> > need to flush the PRI queue. Does this make sense for Intel VT-d as well
> > or did I overlook something?
> > 
> > Before calling iommu_sva_unbind_device(), device drivers must stop the
> > device from using the PASID. For PCIe devices, that consists of
> > completing any pending DMA, and completing any pending page request
> > unless the device uses Stop Markers. So unless the device uses Stop
> > Markers, we don't need to flush the PRI queue. For SMMUv3, stopping DMA
> > means completing all stall events, so we never need to flush the event
> > queue.
> 
> I don't think this is true. Baolu is working on an enhancement to this,
> I'll quickly summarize this below:
> 
> Stop markers are weird, I'm not certain there is any device today that
> sends STOP markers. Even if they did, markers don't have a required
> response, they are fire and forget from the device pov.

Definitely agree with this, and I hope none will implement stop marker.
For devices that *don't* use a stop marker, the PCIe spec says (10.4.1.2):

  To stop [using a PASID] without using a Stop Marker Message, the
  function shall:
  1. Stop queueing new Page Request Messages for this PASID.
  2. Finish transmitting any multi-page Page Request Messages for this
     PASID (i.e. send the Page Request Message with the L bit Set).
  3. Wait for PRG Response Messages associated any outstanding Page
     Request Messages for the PASID.

So they have to flush their PR themselves. And since the device driver
completes this sequence before calling unbind(), then there shouldn't be
any oustanding PR for the PASID, and unbind() doesn't need to flush,
right?

> I'm not sure about other IOMMU's how they behave, When there is no space in
> the PRQ, IOMMU auto-responds to the device. This puts the device in a
> while (1) loop. The fake successful response will let the device do a ATS
> lookup, and that would fail forcing the device to do another PRQ.

But in the sequence above, step 1 should ensure that the device will not
send another PR for any successful response coming back at step 3.

So I agree with the below if we suspect there could be pending PR, but
given that pending PR are a stop marker thing and we don't know any device
using stop markers, I wondered why I bothered implementing PRIq flush at
all for SMMUv3, hence this RFC.

Thanks,
Jean


> The idea
> is somewhere there the OS has repeated the others and this will find a way
> in the PRQ. The point is this is less reliable and can't be the only
> indication. PRQ draining has a specific sequence. 
> 
> The detailed steps are outlined in 
> "Chapter 7.10 "Software Steps to Drain Page Requests & Responses"
> 
> - Submit invalidation wait with fence flag to ensure all prior
>   invalidations are processed.
> - submit iotlb followed by devtlb invalidation
> - Submit invalidation wait with page-drain to make sure any page-requests
>   issued by the device are flushed when this invalidation wait completes.
> - If during the above process there was a queue overflow SW can assume no
>   outstanding page-requests are there. If we had a queue full condition,
>   then sw must repeat step 2,3 above.
> 
> 
> To that extent the proposal is as follows: names are suggestive :-) I'm
> making this up as I go!
> 
> - iommu_stop_page_req() - Kernel needs to make sure we respond to all
>   outstanding requests (since we can't drop responses) 
>   - Ensure we respond immediatly for anything that comes before the drain
>     sequence completes
> - iommu_drain_page_req() - Which does the above invalidation with
>   Page_drain set.
> 
> Once the driver has performed a reset and before issuing any new request,
> it does iommu_resume_page_req() this will ensure we start processing
> incoming page-req after this point.
> 
> 
> > 
> > First patch adds flags to unbind(), and the second one lets device
> > drivers tell whether the PRI queue needs to be flushed.
> > 
> > Other remarks:
> > 
> > * The PCIe spec (see quote on patch 2), says that the device signals
> >   whether it has sent a Stop Marker or not during Stop PASID. In reality
> >   it's unlikely that a given device will sometimes use one stop method
> >   and sometimes the other, so it could be a device-wide flag rather than
> >   passing it at each unbind(). I don't want to speculate too much about
> >   future implementation so I prefer having the flag in unbind().
> > 
> > * In patch 1, uacce passes 0 to unbind(). To pass the right flag I'm
> >   thinking that uacce->ops->stop_queue(), which tells the device driver
> >   to stop DMA, should return whether faults are pending. This can be
> >   added later once uacce has an actual PCIe user, but we need to
> >   remember to do it.
> 
> I think intel iommmu driver does this today for SVA when pasid is being
> freed. Its still important to go through the drain before that PASID can be
> re-purposed.
> 
> Cheers,
> Ashok
