Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D6848A9F7
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jan 2022 09:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbiAKI5P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jan 2022 03:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236410AbiAKI5P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jan 2022 03:57:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA31C06173F;
        Tue, 11 Jan 2022 00:57:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3A110CE0CF3;
        Tue, 11 Jan 2022 08:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01CF8C36AE9;
        Tue, 11 Jan 2022 08:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641891431;
        bh=NdxodxWZzbwf/ggHaYd5sNJGA5eNob24Z1IUAg07QCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iqf1MXWMDx5bH13jjIOAjklovdMj8eHdh2yjJ9sI6CIPbsTZ1HDFHYiOxxhGg4lFf
         r/YSSUY+h33izj2tH2lWc2MpP6jlI4gx2RkJiwtH7SCOwjWlBExjRtQAwJS6lU+cEK
         orMkCoJgFyb0Iu6/5Lyj5ncCu7ThKgpUGn6nfkWc=
Date:   Tue, 11 Jan 2022 09:57:08 +0100
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
Subject: Re: [patch] genirq/msi: Populate sysfs entry only once
Message-ID: <Yd1GZMvstSNTc80B@kroah.com>
References: <20211206210600.123171746@linutronix.de>
 <20211206210749.224917330@linutronix.de>
 <87leznqx2a.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87leznqx2a.ffs@tglx>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 10, 2022 at 07:12:45PM +0100, Thomas Gleixner wrote:
> The MSI entries for multi-MSI are populated en bloc for the MSI descriptor,
> but the current code invokes the population inside the per interrupt loop
> which triggers a warning in the sysfs code and causes the interrupt
> allocation to fail.
> 
> Move it outside of the loop so it works correctly for single and multi-MSI.
> 
> Fixes: bf5e758f02fc ("genirq/msi: Simplify sysfs handling")
> Reported-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/irq/msi.c |   11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
