Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47C463ECAC
	for <lists+linux-pci@lfdr.de>; Thu,  1 Dec 2022 10:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiLAJlF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Dec 2022 04:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiLAJkz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Dec 2022 04:40:55 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C048E5B4
        for <linux-pci@vger.kernel.org>; Thu,  1 Dec 2022 01:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669887654; x=1701423654;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NwpPELaC3wHuInj0CgNYmo6074xYqTIEqhVDCya7mBo=;
  b=iudMnYtQ2aMX0wADMDBhBoTYemBVQKqMVGzN6c3jiocZqB5ISJBPJMeV
   wPB2pFLoD85DOfAxfBH2IDK/6lPDOAXR4dqFkZJ+FPYh47nCIhgd5GIIT
   b1/8disJjRp36wDjVPiSlUxfjDVGbS6wVn89TN9z4iMcbSiaD2/s3/Jxq
   ol4YBKW1sibSXKqiAFj7AyaLpVd3Z8DBPmknU2YIiJskQOPb9y9Aaey43
   8ROHSzu4iYes/EM2T61nh9dPPCG0Hjxxwkvs3nBtUc7JZjHvMj4gmpF7S
   4o3t+DgkjuZcFR2pjKvLS0S3hE0oTpZ1qvCQPXgNIL8wJ6YJ0OML8mVUc
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="295998056"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="295998056"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 01:40:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="595000590"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="595000590"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 01 Dec 2022 01:40:51 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 82EB3179; Thu,  1 Dec 2022 11:41:18 +0200 (EET)
Date:   Thu, 1 Dec 2022 11:41:18 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: PCI resource allocation mismatch with BIOS
Message-ID: <Y4h2vkDMzpkojMT4@black.fi.intel.com>
References: <20221128150617.14c98c2e.alex.williamson@redhat.com>
 <20221129064812.GA1555@wunner.de>
 <20221129065242.07b5bcbf.alex.williamson@redhat.com>
 <Y4YgKaml6nh5cB9r@black.fi.intel.com>
 <20221129084646.0b22c80b.alex.williamson@redhat.com>
 <20221129160626.GA19822@wunner.de>
 <20221129091249.3b60dd58.alex.williamson@redhat.com>
 <20221130074347.GC8198@wunner.de>
 <Y4cM3qYnaHl3fQsU@black.fi.intel.com>
 <20221130084738.57281dac.alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221130084738.57281dac.alex.williamson@redhat.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Wed, Nov 30, 2022 at 08:47:38AM -0700, Alex Williamson wrote:
> On Wed, 30 Nov 2022 09:57:18 +0200
> Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> 
> > Hi,
> > 
> > On Wed, Nov 30, 2022 at 08:43:47AM +0100, Lukas Wunner wrote:
> > > On Tue, Nov 29, 2022 at 09:12:49AM -0700, Alex Williamson wrote:  
> > > > On Tue, 29 Nov 2022 17:06:26 +0100 Lukas Wunner <lukas@wunner.de> wrote:  
> > > > > On Tue, Nov 29, 2022 at 08:46:46AM -0700, Alex Williamson wrote:  
> > > > > > Maybe the elephant in the room is why it's apparently such common
> > > > > > practice to need to perform a hard reset these devices outside of
> > > > > > virtualization scenarios...    
> > > > > 
> > > > > These GPUs are used as accelerators in cloud environments.
> > > > > 
> > > > > They're reset to a pristine state when handed out to another tenant
> > > > > to avoid info leaks from the previous tenant.
> > > > > 
> > > > > That should be a legitimate usage of PCIe reset, no?  
> > > > 
> > > > Absolutely, but why the whole switch?  Thanks,  
> > > 
> > > The reset is propagated down the hierarchy, so by resetting the
> > > Switch Upstream Port, it is guaranteed that all endpoints are
> > > reset with just a single operation.  Per PCIe r6.0.1 sec 6.6.1:
> > > 
> > >    "For a Switch, the following must cause a hot reset to be sent
> > >     on all Downstream Ports:
> > >     [...]
> > >     Receiving a hot reset on the Upstream Port"  
> 
> This was never in doubt.
>  
> > Adding here the reason I got from the GPU folks:
> > 
> > In addition to the use case when the GPU is reset when switched to
> > another tenant, this is used for recovery. The "first level" recovery is
> > handled by the graphics driver that does Function Level Reset but if
> > that does not work data centers may trigger reset at higher level (root
> > port or switch upstream port) to reset the whole card. So called "big
> > hammer".
> 
> Ok, so the first level issue can be solved by the reset_method
> attribute, allowing userspace to trigger a SBR for a signle function
> endpoint rather than an FLR (though this might suggest some hardware
> issues in the FLR implementation).  This will save and restore the
> device config space, so there should be no resource reallocation issues.

Right, I think that already works.

> > There is another use case too - firmware upgrade. This allows data
> > centers to upgrade firmware on those cards without need to reboot - they
> > just reset the whole thing to make it run the new firmware.
> 
> The above can also be used for this, so long as the firmware update
> only targets the GPU and device config space layout and features is not
> modified by the update.  This touches on a long standing issue Bjorn
> has had with performing bus resets where we assume we get back
> essentially the same devices after the reset.  That's not guaranteed
> with a pending firmware update.

Fair enough but if the firmware does not change the resource consumption
then we would get back the same devices. I guess this is the use-case
with these cards.

> >From the logs in this case, I notice that the BIOS didn't assigned the
> ROM BAR for the GPU while Linux did when re-scanning.  That's a
> different address space from the SR-IOV BARs, so doesn't explain this
> failure, but I wonder if there's another resource in the hierarchy that
> the BIOS didn't program, ex. BAR0 on the upstream switch maybe?

I don't think there is.

> Possibly if the host were booted with pci=realloc, Linux might expand
> the resources to something it's happy with, allowing future re-scans.

This was tried (sorry I did not mention that) and it did not work either
because of the way Linux allocates the resource space. BIOS allocates
"minimal" window that fulfills the alignment requirement so if we had
just 16G+16M BARs then we would get 16G+16M bridge window aligned for
that 16G. However, Linux tries to align the size of the window too so
instead we get 16G aligned to 8G so 24G memory window. This does not fit
to the resources BIOS allocated.

With pci=realloc Linux tries to release the resources from the upper
level bridges and re-allocates more but the IOV resources are put into
the "additional" list so it is fine if those don't get allocated in the
end.

> Otherwise I think we'd need a log of all BIOS vs Linux resource
> allocations from the root port down to see what might be the issue with
> the rescan.  Thanks,

Sure, I will share dmesg from that system showing the initial allocation
and the re-scan as soon as I get confirmation that there is nothing
under embargo in there.
