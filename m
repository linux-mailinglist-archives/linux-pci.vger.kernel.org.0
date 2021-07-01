Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF543B9714
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 22:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbhGAUST (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 16:18:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232113AbhGAUSR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Jul 2021 16:18:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76C6661411;
        Thu,  1 Jul 2021 20:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625170546;
        bh=mDHH5k4BbJmf2Zws784yhvUtgLilXdWIMMsget5ZbDM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gSdR4+83pd3eDayQpkjTGyRT9eWXelciijCQgcv7/WVpDp8f9I1vhHPT1t//TG6S5
         rVc5vAAjvidShogvjJJ1pP3LeKOvN9mmCDFTMyOn4VcXCmv4yuj/YfXGpBwGoPPLeR
         UwNt1mlXFgRNarkKG/ZSCnAFROFBsk5C7vd/trSaXsH+iNexjWhZT/qOgm1pGlMjkR
         UmzbOMzwSEt2oZv+F/thJlgML0SZ6hIemGZcJzZLLyUFjYNI2YpVaCIK8tembAsrZU
         FPp44QOteflolVhRd4XS4b5ieA43ocwblH+ljHEGN+qy/b0R7tiZwFl5O4rN6vUDLH
         bK3BS9mHQYqxQ==
Date:   Thu, 1 Jul 2021 15:15:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Robert Straw <drbawb@fatalsyntax.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex.williamson@redhat.com
Subject: Re: [PATCH v2] PCI: Disable Samsung SM951/PM951 NVMe before FLR
Message-ID: <20210701201545.GA85919@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YN4etaP6hInKvSgG@infradead.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 01, 2021 at 08:59:49PM +0100, Christoph Hellwig wrote:
> On Thu, Jul 01, 2021 at 02:38:56PM -0500, Bjorn Helgaas wrote:
> > On Fri, Apr 30, 2021 at 06:01:19PM -0500, Robert Straw wrote:
> > > The SM951/PM951, when used in conjunction with the vfio-pci driver and
> > > passed to a KVM guest, can exhibit the fatal state addressed by the
> > > existing `nvme_disable_and_flr` quirk. If the guest cleanly shuts down
> > > the SSD, and vfio-pci attempts an FLR to the device while it is in this
> > > state, the nvme driver will fail when it attempts to bind to the device
> > > after the FLR due to the frozen config area, e.g:
> > > 
> > >   nvme nvme2: frozen state error detected, reset controller
> > >   nvme nvme2: Removing after probe failure status: -12
> > > 
> > > By including this older model (Samsung 950 PRO) of the controller in the
> > > existing quirk: the device is able to be cleanly reset after being used
> > > by a KVM guest.
> > > 
> > > Signed-off-by: Robert Straw <drbawb@fatalsyntax.com>
> > 
> > Applied to pci/virtualization for v5.14, thanks!
> 
> FYI, I really do not like the idea of the PCIe core messing with NVMe
> registers like this.

I hadn't looked at the nvme_disable_and_flr() implementation, but yes,
I see what you mean, that *is* ugly.  I dropped this patch for now.

I see that you suggested earlier that we not allow these devices to be
assigned via VFIO [1].  Is that practical?  Sounds like it could be
fairly punitive.

I assume this reset is normally used when vfio-pci is the driver in
the host kernel and there probably is no guest.  In that particular
case, I'd guess there's no conflict, but as you say, the sysfs reset
attribute could trigger this reset when there *is* a guest driver, so
there *would* be a conflict.

Could we coordinate this reset with vfio somehow so we only use
nvme_disable_and_flr() when there is no guest?

Bjorn

[1] https://lore.kernel.org/r/YKTP2GQkLz5jma/q@infradead.org
