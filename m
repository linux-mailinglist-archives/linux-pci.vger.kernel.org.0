Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E81293058
	for <lists+linux-pci@lfdr.de>; Mon, 19 Oct 2020 23:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbgJSVQO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Oct 2020 17:16:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:23214 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbgJSVQO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Oct 2020 17:16:14 -0400
IronPort-SDR: aTJfIgVgYfspjpKNvfzp+LCP/tjI6vsS8JDPXO38Mn7Ude3oiUS99TuMQuoq8GFDmRSs1uUNVH
 ImLxUx/bIviQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="251802583"
X-IronPort-AV: E=Sophos;i="5.77,395,1596524400"; 
   d="scan'208";a="251802583"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 14:16:09 -0700
IronPort-SDR: CD359c4xk3Rf5x/5MIJhCR+FanRrzqfrS0rmjpc53eh6Mc5CuJOA3jRoJQHw7dASZ8S8ab517E
 oIggluFAQglg==
X-IronPort-AV: E=Sophos;i="5.77,395,1596524400"; 
   d="scan'208";a="347587269"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 14:16:09 -0700
Date:   Mon, 19 Oct 2020 14:16:08 -0700
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
Message-ID: <20201019211608.GA79633@otc-nc-03>
References: <20201015090028.1278108-1-jean-philippe@linaro.org>
 <20201015182211.GA54780@otc-nc-03>
 <20201016075923.GB1309464@myrica>
 <20201017112525.GA47206@otc-nc-03>
 <20201019140824.GA1478235@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019140824.GA1478235@myrica>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jean

On Mon, Oct 19, 2020 at 04:08:24PM +0200, Jean-Philippe Brucker wrote:
> On Sat, Oct 17, 2020 at 04:25:25AM -0700, Raj, Ashok wrote:
> > > For devices that *don't* use a stop marker, the PCIe spec says (10.4.1.2):
> > > 
> > >   To stop [using a PASID] without using a Stop Marker Message, the
> > >   function shall:
> > >   1. Stop queueing new Page Request Messages for this PASID.
> > 
> > The device driver would need to tell stop sending any new PR's.
> > 
> > >   2. Finish transmitting any multi-page Page Request Messages for this
> > >      PASID (i.e. send the Page Request Message with the L bit Set).
> > >   3. Wait for PRG Response Messages associated any outstanding Page
> > >      Request Messages for the PASID.
> > > 
> > > So they have to flush their PR themselves. And since the device driver
> > > completes this sequence before calling unbind(), then there shouldn't be
> > > any oustanding PR for the PASID, and unbind() doesn't need to flush,
> > > right?
> > 
> > I can see how the device can complete #2,3 above. But the device driver
> > isn't the one managing page-responses right. So in order for the device to
> > know the above sequence is complete, it would need to get some assist from
> > IOMMU driver?
> 
> No the device driver just waits for the device to indicate that it has
> completed the sequence. That's what the magic stop-PASID mechanism
> described by PCIe does. In 6.20.1 "Managing PASID TLP Prefix Usage" it
> says:

The goal is we do this when the device is in a messup up state. So we can't
take for granted the device is properly operating which is why we are going
to wack the device with a flr().

The only thing that's supposed to work without a brain freeze is the
invalidation logic. Spec requires devices to respond to invalidations even when
they are in the process of flr().

So when IOMMU does an invalidation wait with a Page-Drain, IOMMU waits till
the response for that arrives before completing the descriptor. Due to 
the posted semantics it will ensure any PR's issued and in the fabric are flushed 
out to memory. 

I suppose you can wait for the device to vouch for all responses, but that
is assuming the device is still functioning properly. Given that we use it
in two places,

* Reclaiming a PASID - only during a tear down sequence, skipping it
  doesn't really buy us much.
* During FLR this can't be skipped anyway due to the above sequence
  requirement. 

> 
> "A Function must have a mechanism to request that it gracefully stop using
>  a specific PASID. This mechanism is device specific but must satisfy the
>  following rules:
>  [...]
>  * When the stop request mechanism indicates completion, the Function has:
>    [...]
>    * Complied with additional rules described in Address Translation
>      Services (Chapter 10 [10.4.1.2 quoted above]) if Address Translations
>      or Page Requests were issued on the behalf of this PASID."
> 
> So after the device driver initiates this mechanism in the device, the
> device must be able to indicate completion of the mechanism, which
> includes completing all in-flight Page Requests. At that point the device
> driver can call unbind() knowing there is no pending PR for this PASID.
> 

Cheers,
Ashok
