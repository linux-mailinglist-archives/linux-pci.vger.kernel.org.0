Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3521466533
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 15:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358515AbhLBO1J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 09:27:09 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:57420 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347257AbhLBO1H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 09:27:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 927F9CE2304;
        Thu,  2 Dec 2021 14:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153FEC53FCB;
        Thu,  2 Dec 2021 14:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638455021;
        bh=oNnu/fYAquguLpIjYchK/Hyo7SQoNQsDNVEvVDkmwwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d/aD7jGGlhRQjYD/ICQSfDKoktRiprSbgaJ8mVVH9OPYzLELURNXeF3/gTDBLQ/Yy
         6x0JCTvaCeSp9JwZ1MYyDngkR4Hcx89iyNJ+Uo/WH50ZI+87VTZs0h3TOKCOnfzt48
         o4onjuvyaKSqZ5RiWx5EzAY8TzrdsK/qMfaG0rkE=
Date:   Thu, 2 Dec 2021 15:23:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Message-ID: <YajW6veanK4GZUkv@kroah.com>
References: <20211130202800.GE4670@nvidia.com>
 <87o861banv.ffs@tglx>
 <20211201001748.GF4670@nvidia.com>
 <87mtlkaauo.ffs@tglx>
 <20211201130023.GH4670@nvidia.com>
 <87y2548byw.ffs@tglx>
 <20211201181406.GM4670@nvidia.com>
 <87mtlk84ae.ffs@tglx>
 <87r1av7u3d.ffs@tglx>
 <20211202135502.GP4670@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202135502.GP4670@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 02, 2021 at 09:55:02AM -0400, Jason Gunthorpe wrote:
> Further, there is no reason why IMS should be reserved exclusively for
> VFIO! Why shouldn't the cdev be able to use IMS vectors too? It is
> just a feature of the PCI device like MSI. If the queue has a PASID it
> can use IDXD's IMS.

No, sorry, but a cdev is not for anything resembling any real resource
at all.

It is ONLY for the /dev/NODE interface that controls the character
device api to userspace.  The struct device involved in it is ONLY for
that, nothing else.  Any attempt to add things to it will be gleefully
rejected.

The cdev api today (in the kernel) exposes too much mess and there's at
least 4 or 5 different ways to use it.  It's on my long-term TODO list
to fix this up to not even allow abuses like you are considering here,
so please don't do that.

> If we really need a 2nd struct device to turn on IMS then, I'd suggest
> picking the cdev, as it keeps IMS and its allocator inside the IDXD
> PCIe driver and not in the VFIO world.

No!  Again, a cdev is to control the lifespan/lifecycle of the /dev/NODE
only.  Anything other than that is not ok to do at all.

thanks,

greg k-h
