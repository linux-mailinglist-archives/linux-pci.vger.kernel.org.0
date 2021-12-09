Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D87346F4F8
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 21:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbhLIUgU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 15:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhLIUgT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Dec 2021 15:36:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAC8C061746;
        Thu,  9 Dec 2021 12:32:45 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639081963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d2Zx4DzHcJuKFVR6I6pM84QqZd+nRGuDXek8rfRkIMk=;
        b=PMlHc47jMHeHpw99BO9sg3zedLq5d4B8nc3AxuM6euhsArxYRgHrHGCwaVgT6koam6q5Fb
        7IjyWHHcnuesdfp9jyBgc9ldc07rTB+ZCXXZ3tiHeLSgWFNSGaF11VKKpzij6SanhQ5g6i
        lZbtftMQFAmyK1fyrHXZQtwJ171iCSKKMfZep2mtrRxMd/0P3lI55EUG0HEjx2Fnz7DbeU
        DV4wBmFy7GEtXMUz0Pty++mqTHGOWwvtDvE+Jtu8ejdELCsF082WxVkklmlPlnvaqiabnt
        jEW2zMrN6ILYghH7VFsjyu4Wv7EOCKwrtDR2XCW9drIVh1aBWYRZrolwCoywWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639081963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d2Zx4DzHcJuKFVR6I6pM84QqZd+nRGuDXek8rfRkIMk=;
        b=u5GXr0BaWLLYyA2le45d4B9fuhsMSv0ml5F/eXn19auKX+MOSBHJylA2QvG23s4uSJwHUK
        mZuRMCGg3H/EBLDw==
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <20211209162129.GS6385@nvidia.com>
References: <20211201001748.GF4670@nvidia.com> <87mtlkaauo.ffs@tglx>
 <8c2262ba-173e-0007-bc4c-94ec54b2847d@intel.com> <87pmqg88xq.ffs@tglx>
 <df00b87e-00dc-d998-8b64-46b16dba46eb@intel.com> <87k0go8432.ffs@tglx>
 <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com> <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx> <20211209162129.GS6385@nvidia.com>
Date:   Thu, 09 Dec 2021 21:32:42 +0100
Message-ID: <878rwtzfh1.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 09 2021 at 12:21, Jason Gunthorpe wrote:
> On Thu, Dec 09, 2021 at 09:37:06AM +0100, Thomas Gleixner wrote:
> If we keep the MSI emulation in the hypervisor then MSI != IMS.  The
> MSI code needs to write a addr/data pair compatible with the emulation
> and the IMS code needs to write an addr/data pair from the
> hypercall. Seems like this scenario is best avoided!
>
> From this perspective I haven't connected how virtual interrupt
> remapping helps in the guest? Is this a way to provide the hypercall
> I'm imagining above?

That was my thought to avoid having different mechanisms.

The address/data pair is computed in two places:

  1) Activation of an interrupt
  2) Affinity setting on an interrupt

Both configure the IRTE when interrupt remapping is in place.

In both cases a vector is allocated in the vector domain and based on
the resulting target APIC / vector number pair the IRTE is
(re)configured.

So putting the hypercall into the vIRTE update is the obvious
place. Both activation and affinity setting can fail and propagate an
error code down to the originating caller.

Hmm?

Thanks,

        tglx


