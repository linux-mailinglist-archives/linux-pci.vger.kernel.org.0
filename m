Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFB8B95198
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 01:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbfHSXT3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Aug 2019 19:19:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728351AbfHSXT2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Aug 2019 19:19:28 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE82B22CF5;
        Mon, 19 Aug 2019 23:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566256767;
        bh=/U24B9TaxxF1vlGxeESWReYVH7i7OAUtClMvsU3EdvM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o0R/EgUPhF9FY6E542/3Z5Nl5x0AHpjNTj0sEnqfoWnXp6jO9Qq92C3huOKNcGMBF
         jerVASiKpJezaFUwCCwN0s369N7YaIajE2pw7shSFQKVVFCyTwotyNgKdT3AB+YZd7
         k5QmIF+f0oLVRWxhPDD+1cqbeWZ6hhCVcrGdpKuk=
Date:   Mon, 19 Aug 2019 18:19:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v5 4/7] PCI/ATS: Add PRI support for PCIe VF devices
Message-ID: <20190819231925.GW253360@google.com>
References: <cover.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <827d051ef8c8bbfa815908ce927e607870780cb6.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190815222049.GL253360@google.com>
 <f05eb779-9f78-f20f-7626-16b8bd28af40@linux.intel.com>
 <20190819141500.GQ253360@google.com>
 <20190819225331.GB28404@skuppusw-desk.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819225331.GB28404@skuppusw-desk.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 19, 2019 at 03:53:31PM -0700, Kuppuswamy Sathyanarayanan wrote:
> On Mon, Aug 19, 2019 at 09:15:00AM -0500, Bjorn Helgaas wrote:
> > On Thu, Aug 15, 2019 at 03:39:03PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > > On 8/15/19 3:20 PM, Bjorn Helgaas wrote:
> > > > [+cc Joerg, David, iommu list: because IOMMU drivers are the only
> > > > callers of pci_enable_pri() and pci_enable_pasid()]
> > > > 
> > > > On Thu, Aug 01, 2019 at 05:06:01PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > > > 
> > > > > When IOMMU tries to enable Page Request Interface (PRI) for VF device
> > > > > in iommu_enable_dev_iotlb(), it always fails because PRI support for
> > > > > PCIe VF device is currently broken. Current implementation expects
> > > > > the given PCIe device (PF & VF) to implement PRI capability before
> > > > > enabling the PRI support. But this assumption is incorrect. As per PCIe
> > > > > spec r4.0, sec 9.3.7.11, all VFs associated with PF can only use the
> > > > > PRI of the PF and not implement it. Hence we need to create exception
> > > > > for handling the PRI support for PCIe VF device.
> > > > > 
> > > > > Also, since PRI is a shared resource between PF/VF, following rules
> > > > > should apply.
> > > > > 
> > > > > 1. Use proper locking before accessing/modifying PF resources in VF
> > > > >     PRI enable/disable call.
> > > > > 2. Use reference count logic to track the usage of PRI resource.
> > > > > 3. Disable PRI only if the PRI reference count (pri_ref_cnt) is zero.
> > 
> > > > Wait, why do we need this at all?  I agree the spec says VFs may not
> > > > implement PRI or PASID capabilities and that VFs use the PRI and
> > > > PASID of the PF.
> > > > 
> > > > But why do we need to support pci_enable_pri() and pci_enable_pasid()
> > > > for VFs?  There's nothing interesting we can *do* in the VF, and
> > > > passing it off to the PF adds all this locking mess.  For VFs, can we
> > > > just make them do nothing or return -EINVAL?  What functionality would
> > > > we be missing if we did that?
> > > 
> > > Currently PRI/PASID capabilities are not enabled by default. IOMMU can
> > > enable PRI/PASID for VF first (and not enable it for PF). In this case,
> > > doing nothing for VF device will break the functionality.
> > 
> > What is the path where we can enable PRI/PASID for VF but not for the
> > PF?  The call chains leading to pci_enable_pri() go through the
> > iommu_ops.add_device interface, which makes me think this is part of
> > the device enumeration done by the PCI core, and in that case I would
> > think this it should be done for the PF before VFs.  But maybe this
> > path isn't exercised until a driver does a DMA map or something
> > similar?

> AFAIK, this path will only get exercised when the device does DMA and
> hence there is no specific order in which PRI/PASID is enabled in PF/VF.
> In fact, my v2 version of this patch set had a check to ensure PF
> PRI/PASID enable is happened before VF attempts PRI/PASID
> enable/disable. But I had to remove it in later version of this series
> due to failure case reported by one the tester of this code. 

What's the path?  And does that path make sense?

I got this far before giving up:

    iommu_go_to_state                           # AMD
      state_next
        amd_iommu_init_pci
          amd_iommu_init_api
            bus_set_iommu
              iommu_bus_init
                bus_for_each_dev(..., add_iommu_group)
                  add_iommu_group
                    iommu_probe_device
                      amd_iommu_add_device                      # amd_iommu_ops.add_device
                        init_iommu_group
                          iommu_group_get_for_dev
                            iommu_group_add_device
                              __iommu_attach_device
                                amd_iommu_attach_device         # amd_iommu_ops.attach_dev
                                  attach_device                 # amd_iommu
                                    pdev_iommuv2_enable
                                      pci_enable_pri


    iommu_probe_device
      intel_iommu_add_device                    # intel_iommu_ops.add_device
        domain_add_dev_info
          dmar_insert_one_dev_info
            domain_context_mapping
              domain_context_mapping_one
                iommu_enable_dev_iotlb
                  pci_enable_pri


These *look* like enumeration paths, not DMA setup paths.  But I could
be wrong, since I gave up before getting to the source.

I don't want to add all this complexity because we *think* we need it.
I want to think about whether it makes *sense*.  Maybe it's sensible
for the PF enumeration or a PF driver to enable the hardware it owns.

If we leave it to the VFs, then we have issues with coordinating
between VFs that want different settings, etc.

If we understand the whole picture and it needs to be in the VFs,
that's fine.  But I don't think we understand the whole picture yet.

Bjorn
