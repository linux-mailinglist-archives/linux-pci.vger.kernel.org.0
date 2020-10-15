Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551FF28F863
	for <lists+linux-pci@lfdr.de>; Thu, 15 Oct 2020 20:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgJOSWO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 14:22:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:57535 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgJOSWO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Oct 2020 14:22:14 -0400
IronPort-SDR: JWuBrvANZ+Xe30Wj+g4hD0MPMfLxfiCV0jP0m5cM/XQKrv/h//0u/JKMTU4HpJs0QaQzubhdL4
 tYyff4OS8/4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="145731700"
X-IronPort-AV: E=Sophos;i="5.77,379,1596524400"; 
   d="scan'208";a="145731700"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 11:22:13 -0700
IronPort-SDR: ttF7ZwHPrxPuTc6JfEHnZrBd7RNp2hy47u3std+EIzNHXG//TdQcJesemkY2F0ldWMI6WSCjVV
 JSI/CEeCn87Q==
X-IronPort-AV: E=Sophos;i="5.77,379,1596524400"; 
   d="scan'208";a="521941595"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 11:22:12 -0700
Date:   Thu, 15 Oct 2020 11:22:11 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        zhangfei.gao@linaro.org, wangzhou1@hisilicon.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-accelerators@lists.ozlabs.org,
        kevin.tian@intel.com, jacob.jun.pan@linux.intel.com,
        linux-pci@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
        "Lu, Baolu" <baolu.lu@intel.com>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>
Subject: Re: [RFC PATCH 0/2] iommu: Avoid unnecessary PRI queue flushes
Message-ID: <20201015182211.GA54780@otc-nc-03>
References: <20201015090028.1278108-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015090028.1278108-1-jean-philippe@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jean

+ Baolu who is looking into this.


On Thu, Oct 15, 2020 at 11:00:27AM +0200, Jean-Philippe Brucker wrote:
> Add a parameter to iommu_sva_unbind_device() that tells the IOMMU driver
> whether the PRI queue needs flushing. When looking at the PCIe spec
> again I noticed that most of the time the SMMUv3 driver doesn't actually
> need to flush the PRI queue. Does this make sense for Intel VT-d as well
> or did I overlook something?
> 
> Before calling iommu_sva_unbind_device(), device drivers must stop the
> device from using the PASID. For PCIe devices, that consists of
> completing any pending DMA, and completing any pending page request
> unless the device uses Stop Markers. So unless the device uses Stop
> Markers, we don't need to flush the PRI queue. For SMMUv3, stopping DMA
> means completing all stall events, so we never need to flush the event
> queue.

I don't think this is true. Baolu is working on an enhancement to this,
I'll quickly summarize this below:

Stop markers are weird, I'm not certain there is any device today that
sends STOP markers. Even if they did, markers don't have a required
response, they are fire and forget from the device pov.

I'm not sure about other IOMMU's how they behave, When there is no space in
the PRQ, IOMMU auto-responds to the device. This puts the device in a
while (1) loop. The fake successful response will let the device do a ATS
lookup, and that would fail forcing the device to do another PRQ. The idea
is somewhere there the OS has repeated the others and this will find a way
in the PRQ. The point is this is less reliable and can't be the only
indication. PRQ draining has a specific sequence. 

The detailed steps are outlined in 
"Chapter 7.10 "Software Steps to Drain Page Requests & Responses"

- Submit invalidation wait with fence flag to ensure all prior
  invalidations are processed.
- submit iotlb followed by devtlb invalidation
- Submit invalidation wait with page-drain to make sure any page-requests
  issued by the device are flushed when this invalidation wait completes.
- If during the above process there was a queue overflow SW can assume no
  outstanding page-requests are there. If we had a queue full condition,
  then sw must repeat step 2,3 above.


To that extent the proposal is as follows: names are suggestive :-) I'm
making this up as I go!

- iommu_stop_page_req() - Kernel needs to make sure we respond to all
  outstanding requests (since we can't drop responses) 
  - Ensure we respond immediatly for anything that comes before the drain
    sequence completes
- iommu_drain_page_req() - Which does the above invalidation with
  Page_drain set.

Once the driver has performed a reset and before issuing any new request,
it does iommu_resume_page_req() this will ensure we start processing
incoming page-req after this point.


> 
> First patch adds flags to unbind(), and the second one lets device
> drivers tell whether the PRI queue needs to be flushed.
> 
> Other remarks:
> 
> * The PCIe spec (see quote on patch 2), says that the device signals
>   whether it has sent a Stop Marker or not during Stop PASID. In reality
>   it's unlikely that a given device will sometimes use one stop method
>   and sometimes the other, so it could be a device-wide flag rather than
>   passing it at each unbind(). I don't want to speculate too much about
>   future implementation so I prefer having the flag in unbind().
> 
> * In patch 1, uacce passes 0 to unbind(). To pass the right flag I'm
>   thinking that uacce->ops->stop_queue(), which tells the device driver
>   to stop DMA, should return whether faults are pending. This can be
>   added later once uacce has an actual PCIe user, but we need to
>   remember to do it.

I think intel iommmu driver does this today for SVA when pasid is being
freed. Its still important to go through the drain before that PASID can be
re-purposed.

Cheers,
Ashok
