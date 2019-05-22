Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF18526558
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2019 16:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbfEVOCi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 May 2019 10:02:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbfEVOCi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 May 2019 10:02:38 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C56320675;
        Wed, 22 May 2019 14:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558533757;
        bh=KTu3NjSg2iiGDgoB9aRWVmkH5c55r6B+TEQSSjSQf3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TiB5IfV+S9KxIVjx6O4i4vgHsQOlh+RmPNLDUeSKScVe/Ik1n+H4rDSt4n0688O7h
         lNapBWDrWoQDfX/n8gtkEjdNgBr/q6eYeOZmzfMtERPy3LMVl33T2tZ5QrDXkTbzA0
         iit2/21VJMjnlzoVA1c/tDP/mr6ZVU4mSkNK1WOQ=
Date:   Wed, 22 May 2019 09:02:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, kishon@ti.com, catalin.marinas@arm.com,
        will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V7 04/15] PCI: dwc: Move config space capability search
 API
Message-ID: <20190522140235.GB79339@google.com>
References: <20190517123846.3708-1-vidyas@nvidia.com>
 <20190517123846.3708-5-vidyas@nvidia.com>
 <20190521211757.GF57618@google.com>
 <fd164d1f-cf99-fe81-c368-46e3a3742a59@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd164d1f-cf99-fe81-c368-46e3a3742a59@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 22, 2019 at 02:26:08PM +0530, Vidya Sagar wrote:
> On 5/22/2019 2:47 AM, Bjorn Helgaas wrote:
> > On Fri, May 17, 2019 at 06:08:35PM +0530, Vidya Sagar wrote:
> > > Move PCIe config space capability search API to common DesignWare file
> > > as this can be used by both host and ep mode codes.

> > >   .../pci/controller/dwc/pcie-designware-ep.c   | 37 +----------------
> > >   drivers/pci/controller/dwc/pcie-designware.c  | 40 +++++++++++++++++++
> > >   drivers/pci/controller/dwc/pcie-designware.h  |  2 +
> > >   3 files changed, 44 insertions(+), 35 deletions(-)

> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -14,6 +14,46 @@
> > >   #include "pcie-designware.h"
> > > +/*
> > > + * These APIs are different from standard pci_find_*capability() APIs in the
> > > + * sense that former can only be used post device enumeration as they require
> > > + * 'struct pci_dev *' pointer whereas these APIs require 'struct dw_pcie *'
> > > + * pointer and can be used before link up also.
> > 
> > I think this comment is slightly misleading because it suggests the
> > reason we need these DW interfaces is because we're doing something
> > before a pci_dev pointer is available.
> > 
> > But these DW interfaces are used on devices that will *never* have a
> > pci_dev pointer because they are not PCI devices.  They're used on
> > host controller devices, which have a PCIe link on the downstream
> > side, but the host controller driver operates them using their
> > upstream, non-PCI interfaces.  Logically, I think they would be
> > considered parts of Root Complexes, not Root Ports.
> > 
> > There's actually no reason why that upstream interface should look
> > anything like PCI; it doesn't need to organize registers into
> > capability lists at all.  It might be convenient for the hardware to
> > do that and share things with a Root Port device, which *is* a PCI
> > device, but it's not required.
> > 
> > It also really has nothing to do with whether the link is up.  This
> > code operates on hardware that is upstream from the link, so we can
> > reach it regardless of the link.
>
> I added this comment after receiving a review comment to justify why
> standard pci_find_*capability() APIs can't be used here. Hence added
> this.  I understand your comment that DW interface need not have to
> be a PCI device, but what is present in the hardware is effectively
> a root port implementation and post enumeration, we get a 'struct
> pci_dev' created for it, hence I thought it is fine to bring 'struct
> pci_dev' into picture.

This code operates on the host controller.  It configures the bridge
that leads *to* PCI devices.  Since that bridge is not a PCI device,
the PCI specs don't say anything about how to program it.

The fact that the host controller programming interface happens to
resemble the PCI programming interface is purely coincidental.

> Also, I agree that mention of 'link up' is unwarranted and could be
> reworded in a better way.
>
> Do you suggest to remove this comment altogether or reword it s/and
> can be used before link up also/and can be used before 'struct
> pci_dev' is available/ ?

Maybe something like this?

    These interfaces resemble the pci_find_*capability() interfaces,
    but these are for configuring host controllers, which are bridges
    *to* PCI devices but are not PCI devices themselves.
