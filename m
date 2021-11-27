Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BA045FE99
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 13:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237278AbhK0Mio (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Nov 2021 07:38:44 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38978 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242443AbhK0Mgn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Nov 2021 07:36:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD159B81B33;
        Sat, 27 Nov 2021 12:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB5FC53FAD;
        Sat, 27 Nov 2021 12:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638016406;
        bh=jDfQyHsi3RriZ5ZWV8f+HEUm1N4gUzCAPBaQlnUROlA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RvixBZ/ISwOAUImnksfi7zufQTgUiqeLh/7boi8Gt5SIP7YchCvymFs19VAM+pqQo
         zjsGrjhGOqrYedKeM7bug0fJlGXWkldVSjj/ZtkL8dpoOrPARzAeroMsQSxSSLXYZ+
         GT3Hs1K1hfMe+l7Tkwp0ugaxHRcZ+LUpK2NveDWM=
Date:   Sat, 27 Nov 2021 13:33:24 +0100
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
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: Re: [patch 32/32] genirq/msi: Convert storage to xarray
Message-ID: <YaIllD3pSVCI/gbj@kroah.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232736.190744801@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126232736.190744801@linutronix.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 27, 2021 at 02:23:17AM +0100, Thomas Gleixner wrote:
> The current linked list storage for MSI descriptors is suboptimal in
> several ways:
> 
>   1) Looking up a MSI desciptor requires a O(n) list walk in the worst case
> 
>   2) The upcoming support of runtime expansion of MSI-X vectors would need
>      to do a full list walk to figure out whether a particular index is
>      already associated.
> 
>   3) Runtime expansion of sparse allocations is even more complex as the
>      current implementation assumes an ordered list (increasing MSI index).
> 
> Use an xarray which solves all of the above problems nicely.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/msi.h |   19 ++---
>  kernel/irq/msi.c    |  188 ++++++++++++++++++++++------------------------------
>  2 files changed, 90 insertions(+), 117 deletions(-)

Much simpler code too, nice!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
