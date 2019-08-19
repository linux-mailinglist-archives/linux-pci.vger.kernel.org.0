Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9F9895133
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 00:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbfHSW4V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Aug 2019 18:56:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:10838 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728469AbfHSW4V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Aug 2019 18:56:21 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 15:56:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,406,1559545200"; 
   d="scan'208";a="172266590"
Received: from skuppusw-desk.jf.intel.com (HELO skuppusw-desk.amr.corp.intel.com) ([10.54.74.33])
  by orsmga008.jf.intel.com with ESMTP; 19 Aug 2019 15:56:20 -0700
Date:   Mon, 19 Aug 2019 15:53:31 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v5 4/7] PCI/ATS: Add PRI support for PCIe VF devices
Message-ID: <20190819225331.GB28404@skuppusw-desk.amr.corp.intel.com>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
References: <cover.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <827d051ef8c8bbfa815908ce927e607870780cb6.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190815222049.GL253360@google.com>
 <f05eb779-9f78-f20f-7626-16b8bd28af40@linux.intel.com>
 <20190819141500.GQ253360@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819141500.GQ253360@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 19, 2019 at 09:15:00AM -0500, Bjorn Helgaas wrote:
> On Thu, Aug 15, 2019 at 03:39:03PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > On 8/15/19 3:20 PM, Bjorn Helgaas wrote:
> > > [+cc Joerg, David, iommu list: because IOMMU drivers are the only
> > > callers of pci_enable_pri() and pci_enable_pasid()]
> > > 
> > > On Thu, Aug 01, 2019 at 05:06:01PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > > 
> > > > When IOMMU tries to enable Page Request Interface (PRI) for VF device
> > > > in iommu_enable_dev_iotlb(), it always fails because PRI support for
> > > > PCIe VF device is currently broken. Current implementation expects
> > > > the given PCIe device (PF & VF) to implement PRI capability before
> > > > enabling the PRI support. But this assumption is incorrect. As per PCIe
> > > > spec r4.0, sec 9.3.7.11, all VFs associated with PF can only use the
> > > > PRI of the PF and not implement it. Hence we need to create exception
> > > > for handling the PRI support for PCIe VF device.
> > > > 
> > > > Also, since PRI is a shared resource between PF/VF, following rules
> > > > should apply.
> > > > 
> > > > 1. Use proper locking before accessing/modifying PF resources in VF
> > > >     PRI enable/disable call.
> > > > 2. Use reference count logic to track the usage of PRI resource.
> > > > 3. Disable PRI only if the PRI reference count (pri_ref_cnt) is zero.
> 
> > > Wait, why do we need this at all?  I agree the spec says VFs may not
> > > implement PRI or PASID capabilities and that VFs use the PRI and
> > > PASID of the PF.
> > > 
> > > But why do we need to support pci_enable_pri() and pci_enable_pasid()
> > > for VFs?  There's nothing interesting we can *do* in the VF, and
> > > passing it off to the PF adds all this locking mess.  For VFs, can we
> > > just make them do nothing or return -EINVAL?  What functionality would
> > > we be missing if we did that?
> > 
> > Currently PRI/PASID capabilities are not enabled by default. IOMMU can
> > enable PRI/PASID for VF first (and not enable it for PF). In this case,
> > doing nothing for VF device will break the functionality.
> 
> What is the path where we can enable PRI/PASID for VF but not for the
> PF?  The call chains leading to pci_enable_pri() go through the
> iommu_ops.add_device interface, which makes me think this is part of
> the device enumeration done by the PCI core, and in that case I would
> think this it should be done for the PF before VFs.  But maybe this
> path isn't exercised until a driver does a DMA map or something
> similar?
AFAIK, this path will only get exercised when the device does DMA and
hence there is no specific order in which PRI/PASID is enabled in PF/VF.
In fact, my v2 version of this patch set had a check to ensure PF
PRI/PASID enable is happened before VF attempts PRI/PASID
enable/disable. But I had to remove it in later version of this series
due to failure case reported by one the tester of this code. 
> 
> Bjorn

-- 
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer
