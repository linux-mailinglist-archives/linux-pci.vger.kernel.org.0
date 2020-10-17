Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC07C2911A2
	for <lists+linux-pci@lfdr.de>; Sat, 17 Oct 2020 13:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437440AbgJQLZb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Oct 2020 07:25:31 -0400
Received: from mga03.intel.com ([134.134.136.65]:56571 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726543AbgJQLZ3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 17 Oct 2020 07:25:29 -0400
IronPort-SDR: /MNjUu7z8YiuzsXFgFHDUrv3PCZoE43UzLQ4PIFlbGuX0LJ9NbCpwLgMOvKL5PEjoX4C8f0t6f
 d7O+gcr8lNZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9776"; a="166864037"
X-IronPort-AV: E=Sophos;i="5.77,386,1596524400"; 
   d="scan'208";a="166864037"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2020 04:25:27 -0700
IronPort-SDR: fJYorjHmM8rSDgf+AxOo8DQPaNgLXY2tWkNpbZAoBerP99MSi411fEqxxCXwYO+Iv27hZtjlge
 nyFknD9/+HXQ==
X-IronPort-AV: E=Sophos;i="5.77,386,1596524400"; 
   d="scan'208";a="532052790"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2020 04:25:26 -0700
Date:   Sat, 17 Oct 2020 04:25:25 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        zhangfei.gao@linaro.org, wangzhou1@hisilicon.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-accelerators@lists.ozlabs.org,
        kevin.tian@intel.com, jacob.jun.pan@linux.intel.com,
        linux-pci@vger.kernel.org, "Lu, Baolu" <baolu.lu@intel.com>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [RFC PATCH 0/2] iommu: Avoid unnecessary PRI queue flushes
Message-ID: <20201017112525.GA47206@otc-nc-03>
References: <20201015090028.1278108-1-jean-philippe@linaro.org>
 <20201015182211.GA54780@otc-nc-03>
 <20201016075923.GB1309464@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016075923.GB1309464@myrica>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jean

On Fri, Oct 16, 2020 at 09:59:23AM +0200, Jean-Philippe Brucker wrote:
> On Thu, Oct 15, 2020 at 11:22:11AM -0700, Raj, Ashok wrote:
> > Hi Jean
> > 
> > + Baolu who is looking into this.
> > 
> > 
> > On Thu, Oct 15, 2020 at 11:00:27AM +0200, Jean-Philippe Brucker wrote:
> > > Add a parameter to iommu_sva_unbind_device() that tells the IOMMU driver
> > > whether the PRI queue needs flushing. When looking at the PCIe spec
> > > again I noticed that most of the time the SMMUv3 driver doesn't actually
> > > need to flush the PRI queue. Does this make sense for Intel VT-d as well
> > > or did I overlook something?
> > > 
> > > Before calling iommu_sva_unbind_device(), device drivers must stop the
> > > device from using the PASID. For PCIe devices, that consists of
> > > completing any pending DMA, and completing any pending page request
> > > unless the device uses Stop Markers. So unless the device uses Stop
> > > Markers, we don't need to flush the PRI queue. For SMMUv3, stopping DMA
> > > means completing all stall events, so we never need to flush the event
> > > queue.
> > 
> > I don't think this is true. Baolu is working on an enhancement to this,
> > I'll quickly summarize this below:
> > 
> > Stop markers are weird, I'm not certain there is any device today that
> > sends STOP markers. Even if they did, markers don't have a required
> > response, they are fire and forget from the device pov.
> 
> Definitely agree with this, and I hope none will implement stop marker.
> For devices that *don't* use a stop marker, the PCIe spec says (10.4.1.2):
> 
>   To stop [using a PASID] without using a Stop Marker Message, the
>   function shall:
>   1. Stop queueing new Page Request Messages for this PASID.

The device driver would need to tell stop sending any new PR's.

>   2. Finish transmitting any multi-page Page Request Messages for this
>      PASID (i.e. send the Page Request Message with the L bit Set).
>   3. Wait for PRG Response Messages associated any outstanding Page
>      Request Messages for the PASID.
> 
> So they have to flush their PR themselves. And since the device driver
> completes this sequence before calling unbind(), then there shouldn't be
> any oustanding PR for the PASID, and unbind() doesn't need to flush,
> right?

I can see how the device can complete #2,3 above. But the device driver
isn't the one managing page-responses right. So in order for the device to
know the above sequence is complete, it would need to get some assist from
IOMMU driver?

How does the driver know that everything host received has been responded
back to device?

> 
> > I'm not sure about other IOMMU's how they behave, When there is no space in
> > the PRQ, IOMMU auto-responds to the device. This puts the device in a
> > while (1) loop. The fake successful response will let the device do a ATS
> > lookup, and that would fail forcing the device to do another PRQ.
> 
> But in the sequence above, step 1 should ensure that the device will not
> send another PR for any successful response coming back at step 3.

True, but there could be some page-request in flight on its way to the
IOMMU. By draining and getting that round trip back to IOMMU we gaurantee
things in flight are flushed to PRQ after that Drain completes.
> 
> So I agree with the below if we suspect there could be pending PR, but
> given that pending PR are a stop marker thing and we don't know any device
> using stop markers, I wondered why I bothered implementing PRIq flush at
> all for SMMUv3, hence this RFC.
> 

Cheers,
Ashok
