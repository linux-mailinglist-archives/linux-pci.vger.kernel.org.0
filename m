Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27AC292D92
	for <lists+linux-pci@lfdr.de>; Mon, 19 Oct 2020 20:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbgJSSbA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Oct 2020 14:31:00 -0400
Received: from mga07.intel.com ([134.134.136.100]:45680 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbgJSSbA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Oct 2020 14:31:00 -0400
IronPort-SDR: tLk4OebSchgjzVBgYc03yjcXxJDudQ8POp36MDxp4HS4n5ZDK8VDmaIrTfBqy0KqmGRdZqWGPa
 IK4pHpx8nQ+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="231273765"
X-IronPort-AV: E=Sophos;i="5.77,395,1596524400"; 
   d="scan'208";a="231273765"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 11:30:57 -0700
IronPort-SDR: 3omxCU3HGeLsa9nXlDlOwZ+t4XZ/tEctu88AwdfLWv/at6Ju8X7n+ZGuTMytBbp8ditxc03TnY
 1nFtDlE1w56A==
X-IronPort-AV: E=Sophos;i="5.77,395,1596524400"; 
   d="scan'208";a="532734880"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 11:30:56 -0700
Date:   Mon, 19 Oct 2020 11:33:16 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, joro@8bytes.org, zhangfei.gao@linaro.org,
        wangzhou1@hisilicon.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-accelerators@lists.ozlabs.org, kevin.tian@intel.com,
        linux-pci@vger.kernel.org, "Lu, Baolu" <baolu.lu@intel.com>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [RFC PATCH 0/2] iommu: Avoid unnecessary PRI queue flushes
Message-ID: <20201019113316.2957c5f0@jacob-builder>
In-Reply-To: <20201019140824.GA1478235@myrica>
References: <20201015090028.1278108-1-jean-philippe@linaro.org>
        <20201015182211.GA54780@otc-nc-03>
        <20201016075923.GB1309464@myrica>
        <20201017112525.GA47206@otc-nc-03>
        <20201019140824.GA1478235@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jean-Philippe,

On Mon, 19 Oct 2020 16:08:24 +0200, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:

> On Sat, Oct 17, 2020 at 04:25:25AM -0700, Raj, Ashok wrote:
> > > For devices that *don't* use a stop marker, the PCIe spec says
> > > (10.4.1.2):
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
> > > completes this sequence before calling unbind(), then there shouldn't
> > > be any oustanding PR for the PASID, and unbind() doesn't need to
> > > flush, right?  
> > 
> > I can see how the device can complete #2,3 above. But the device driver
> > isn't the one managing page-responses right. So in order for the device
> > to know the above sequence is complete, it would need to get some
> > assist from IOMMU driver?  
> 
> No the device driver just waits for the device to indicate that it has
> completed the sequence. That's what the magic stop-PASID mechanism
> described by PCIe does. In 6.20.1 "Managing PASID TLP Prefix Usage" it
> says:
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
In step #3, I think it is possible that device driver received page response
as part of the auto page response, so it may not guarantee all the in-flight
PRQs are completed inside IOMMU. Therefore, drain is _always_ needed to be
sure?

> Thanks,
> Jean
> 
> > 
> > How does the driver know that everything host received has been
> > responded back to device?
> >   
> > >   
> > > > I'm not sure about other IOMMU's how they behave, When there is no
> > > > space in the PRQ, IOMMU auto-responds to the device. This puts the
> > > > device in a while (1) loop. The fake successful response will let
> > > > the device do a ATS lookup, and that would fail forcing the device
> > > > to do another PRQ.  
> > > 
> > > But in the sequence above, step 1 should ensure that the device will
> > > not send another PR for any successful response coming back at step
> > > 3.  
> > 
> > True, but there could be some page-request in flight on its way to the
> > IOMMU. By draining and getting that round trip back to IOMMU we
> > gaurantee things in flight are flushed to PRQ after that Drain
> > completes.  
> > > 
> > > So I agree with the below if we suspect there could be pending PR, but
> > > given that pending PR are a stop marker thing and we don't know any
> > > device using stop markers, I wondered why I bothered implementing
> > > PRIq flush at all for SMMUv3, hence this RFC.
> > >   
> > 
> > Cheers,
> > Ashok  


Thanks,

Jacob
