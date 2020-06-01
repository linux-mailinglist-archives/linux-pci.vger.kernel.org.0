Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68AF01EB1CE
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 00:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbgFAWl4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jun 2020 18:41:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgFAWl4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Jun 2020 18:41:56 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E6EB2054F;
        Mon,  1 Jun 2020 22:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591051315;
        bh=4F8oMtoJEn7cRi6K3anCXx2Ba1M2zTlRhq8VCfHkgS8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PIcYkU+hKADLakAdTD5EGrqWronIlkWSQYseQF8lkznESRa/sMQp2J7tSWyPHQDtF
         5ITmAKC7jI8iHZbv4hQwD45BAYuto93jMqe3IHV7vdGdI9aL/AVhNlmR1UhB+DxjOX
         99LfJlJAAKgfsrp5J5gyM2us3+OVHENxJOvmOiII=
Date:   Mon, 1 Jun 2020 17:41:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Darrel Goeddel <DGoeddel@forcepoint.com>,
        Mark Scott <mscott@forcepoint.com>,
        Romil Sharma <rsharma@forcepoint.com>
Subject: Re: [PATCH] PCI: Relax ACS requirement for Intel RCiEP devices.
Message-ID: <20200601224154.GA769388@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200601155655.1519bc86@x1.home>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 01, 2020 at 03:56:55PM -0600, Alex Williamson wrote:
> On Mon, 1 Jun 2020 14:40:23 -0700
> "Raj, Ashok" <ashok.raj@intel.com> wrote:
> 
> > On Mon, Jun 01, 2020 at 04:25:19PM -0500, Bjorn Helgaas wrote:
> > > On Thu, May 28, 2020 at 01:57:42PM -0700, Ashok Raj wrote:  
> > > > All Intel platforms guarantee that all root complex implementations
> > > > must send transactions up to IOMMU for address translations. Hence for
> > > > RCiEP devices that are Vendor ID Intel, can claim exception for lack of
> > > > ACS support.
> > > > 
> > > > 
> > > > 3.16 Root-Complex Peer to Peer Considerations
> > > > When DMA remapping is enabled, peer-to-peer requests through the
> > > > Root-Complex must be handled
> > > > as follows:
> > > > • The input address in the request is translated (through first-level,
> > > >   second-level or nested translation) to a host physical address (HPA).
> > > >   The address decoding for peer addresses must be done only on the
> > > >   translated HPA. Hardware implementations are free to further limit
> > > >   peer-to-peer accesses to specific host physical address regions
> > > >   (or to completely disallow peer-forwarding of translated requests).
> > > > • Since address translation changes the contents (address field) of
> > > >   the PCI Express Transaction Layer Packet (TLP), for PCI Express
> > > >   peer-to-peer requests with ECRC, the Root-Complex hardware must use
> > > >   the new ECRC (re-computed with the translated address) if it
> > > >   decides to forward the TLP as a peer request.
> > > > • Root-ports, and multi-function root-complex integrated endpoints, may
> > > >   support additional peerto-peer control features by supporting PCI Express
> > > >   Access Control Services (ACS) capability. Refer to ACS capability in
> > > >   PCI Express specifications for details.
> > > > 
> > > > Since Linux didn't give special treatment to allow this exception, certain
> > > > RCiEP MFD devices are getting grouped in a single iommu group. This
> > > > doesn't permit a single device to be assigned to a guest for instance.
> > > > 
> > > > In one vendor system: Device 14.x were grouped in a single IOMMU group.
> > > > 
> > > > /sys/kernel/iommu_groups/5/devices/0000:00:14.0
> > > > /sys/kernel/iommu_groups/5/devices/0000:00:14.2
> > > > /sys/kernel/iommu_groups/5/devices/0000:00:14.3
> > > > 
> > > > After the patch:
> > > > /sys/kernel/iommu_groups/5/devices/0000:00:14.0
> > > > /sys/kernel/iommu_groups/5/devices/0000:00:14.2
> > > > /sys/kernel/iommu_groups/6/devices/0000:00:14.3 <<< new group
> > > > 
> > > > 14.0 and 14.2 are integrated devices, but legacy end points.
> > > > Whereas 14.3 was a PCIe compliant RCiEP.
> > > > 
> > > > 00:14.3 Network controller: Intel Corporation Device 9df0 (rev 30)
> > > > Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
> > > > 
> > > > This permits assigning this device to a guest VM.
> > > > 
> > > > Fixes: f096c061f552 ("iommu: Rework iommu_group_get_for_pci_dev()")
> > > > Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> > > > To: Joerg Roedel <joro@8bytes.org>
> > > > To: Bjorn Helgaas <bhelgaas@google.com>
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Cc: iommu@lists.linux-foundation.org
> > > > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > > > Cc: Alex Williamson <alex.williamson@redhat.com>
> > > > Cc: Darrel Goeddel <DGoeddel@forcepoint.com>
> > > > Cc: Mark Scott <mscott@forcepoint.com>,
> > > > Cc: Romil Sharma <rsharma@forcepoint.com>
> > > > Cc: Ashok Raj <ashok.raj@intel.com>  
> > > 
> > > Tentatively applied to pci/virtualization for v5.8, thanks!
> > > 
> > > The spec says this handling must apply "when DMA remapping is
> > > enabled".  The patch does not check whether DMA remapping is enabled.
> > > 
> > > Is there any case where DMA remapping is *not* enabled, and we rely on
> > > this patch to tell us whether the device is isolated?  It sounds like
> > > it may give the wrong answer in such a case?
> > > 
> > > Can you confirm that I don't need to worry about this?    
> > 
> > I think all of this makes sense only when DMA remapping is enabled.
> > Otherwise there is no enforcement for isolation. 
> 
> Yep, without an IOMMU all devices operate in the same IOVA space and we
> have no isolation.  We only enable ACS when an IOMMU driver requests it
> and it's only used by IOMMU code to determine IOMMU grouping of
> devices.  Thanks,

Thanks, Ashok and Alex.  I wish it were more obvious from the code,
but I am reassured.

I also added a stable tag to help get this backported.
