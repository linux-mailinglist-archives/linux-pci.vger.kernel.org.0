Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D1246B59C
	for <lists+linux-pci@lfdr.de>; Tue,  7 Dec 2021 09:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbhLGIZL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 03:25:11 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:50724 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhLGIZL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Dec 2021 03:25:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 12C73CE19FA;
        Tue,  7 Dec 2021 08:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81803C341C1;
        Tue,  7 Dec 2021 08:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638865298;
        bh=81ezBwi4Gw0OWv//xVC704QCQgMXAEKmUfhLMAXppUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TH/YlLooPpA9/mTXfGh27VFDaRdFSa+QDNfFyBbpv2TI9gDuVVtgDUvWY1cEHZ1rw
         d7NMMCdgS2zwfOsO2TgrsfOv17Gvprfvs8AAsKoH3ogS+Y6KSf6urrDcjPRlGlksm6
         2hRfNjvRT3+8vBz3JNDvM7STpvhCM+Qz+yAn683U=
Date:   Tue, 7 Dec 2021 09:21:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: Re: [patch V2 29/31] genirq/msi: Add abuse prevention comment to msi
 header
Message-ID: <Ya8Zj+bADtKEISSP@kroah.com>
References: <20211206210600.123171746@linutronix.de>
 <20211206210749.170847844@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206210749.170847844@linutronix.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 06, 2021 at 11:51:49PM +0100, Thomas Gleixner wrote:
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/msi.h |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -2,6 +2,20 @@
>  #ifndef LINUX_MSI_H
>  #define LINUX_MSI_H
>  
> +/*
> + * This header file contains MSI data structures and functions which are
> + * only relevant for:
> + *	- Interrupt core code
> + *	- PCI/MSI core code
> + *	- MSI interrupt domain implementations
> + *	- IOMMU, low level VFIO, NTB and other justified exceptions
> + *	  dealing with low level MSI details.
> + *
> + * Regular device drivers have no business with any of these functions and
> + * especially storing MSI descriptor pointers in random code is considered
> + * abuse. The only function which is relevant for drivers is msi_get_virq().
> + */
> +
>  #include <linux/cpumask.h>
>  #include <linux/mutex.h>
>  #include <linux/list.h>
> 

Ah, to be young and idealistic and hope that kernel developers read
comments in header files :)

You might want to add this to the driver-api kernel doc build?

Anyway, looks good to me:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
