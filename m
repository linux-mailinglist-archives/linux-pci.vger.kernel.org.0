Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3339A0961
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 20:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfH1SYv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 14:24:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:20397 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfH1SYv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Aug 2019 14:24:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 11:24:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; 
   d="scan'208";a="205450331"
Received: from skuppusw-desk.jf.intel.com (HELO skuppusw-desk.amr.corp.intel.com) ([10.54.74.33])
  by fmsmga004.fm.intel.com with ESMTP; 28 Aug 2019 11:24:50 -0700
Date:   Wed, 28 Aug 2019 11:21:53 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v5 4/7] PCI/ATS: Add PRI support for PCIe VF devices
Message-ID: <20190828182153.GH28404@skuppusw-desk.amr.corp.intel.com>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
References: <cover.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <827d051ef8c8bbfa815908ce927e607870780cb6.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190815222049.GL253360@google.com>
 <f05eb779-9f78-f20f-7626-16b8bd28af40@linux.intel.com>
 <20190819141500.GQ253360@google.com>
 <20190819225331.GB28404@skuppusw-desk.amr.corp.intel.com>
 <20190819231925.GW253360@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819231925.GW253360@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 19, 2019 at 06:19:25PM -0500, Bjorn Helgaas wrote:
> On Mon, Aug 19, 2019 at 03:53:31PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > On Mon, Aug 19, 2019 at 09:15:00AM -0500, Bjorn Helgaas wrote:
> > > On Thu, Aug 15, 2019 at 03:39:03PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > > > On 8/15/19 3:20 PM, Bjorn Helgaas wrote:
> > > > > [+cc Joerg, David, iommu list: because IOMMU drivers are the only
> > > > > callers of pci_enable_pri() and pci_enable_pasid()]
> > > > > 
> > > > > On Thu, Aug 01, 2019 at 05:06:01PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > > > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > > > > 
> > > > > > When IOMMU tries to enable Page Request Interface (PRI) for VF device
> > > > > > in iommu_enable_dev_iotlb(), it always fails because PRI support for
> > > > > > PCIe VF device is currently broken. Current implementation expects
> > > > > > the given PCIe device (PF & VF) to implement PRI capability before
> > > > > > enabling the PRI support. But this assumption is incorrect. As per PCIe
> > > > > > spec r4.0, sec 9.3.7.11, all VFs associated with PF can only use the
> > > > > > PRI of the PF and not implement it. Hence we need to create exception
> > > > > > for handling the PRI support for PCIe VF device.
> > > > > > 
> > > > > > Also, since PRI is a shared resource between PF/VF, following rules
> > > > > > should apply.
> > > > > > 
> > > > > > 1. Use proper locking before accessing/modifying PF resources in VF
> > > > > >     PRI enable/disable call.
> > > > > > 2. Use reference count logic to track the usage of PRI resource.
> > > > > > 3. Disable PRI only if the PRI reference count (pri_ref_cnt) is zero.
> > > 
> > > > > Wait, why do we need this at all?  I agree the spec says VFs may not
> > > > > implement PRI or PASID capabilities and that VFs use the PRI and
> > > > > PASID of the PF.
> > > > > 
> > > > > But why do we need to support pci_enable_pri() and pci_enable_pasid()
> > > > > for VFs?  There's nothing interesting we can *do* in the VF, and
> > > > > passing it off to the PF adds all this locking mess.  For VFs, can we
> > > > > just make them do nothing or return -EINVAL?  What functionality would
> > > > > we be missing if we did that?
> > > > 
> > > > Currently PRI/PASID capabilities are not enabled by default. IOMMU can
> > > > enable PRI/PASID for VF first (and not enable it for PF). In this case,
> > > > doing nothing for VF device will break the functionality.
> > > 
> > > What is the path where we can enable PRI/PASID for VF but not for the
> > > PF?  The call chains leading to pci_enable_pri() go through the
> > > iommu_ops.add_device interface, which makes me think this is part of
> > > the device enumeration done by the PCI core, and in that case I would
> > > think this it should be done for the PF before VFs.  But maybe this
> > > path isn't exercised until a driver does a DMA map or something
> > > similar?
> 
> > AFAIK, this path will only get exercised when the device does DMA and
> > hence there is no specific order in which PRI/PASID is enabled in PF/VF.
> > In fact, my v2 version of this patch set had a check to ensure PF
> > PRI/PASID enable is happened before VF attempts PRI/PASID
> > enable/disable. But I had to remove it in later version of this series
> > due to failure case reported by one the tester of this code. 
> 
> What's the path?  And does that path make sense?
> 
> I got this far before giving up:
> 
>     iommu_go_to_state                           # AMD
>       state_next
>         amd_iommu_init_pci
>           amd_iommu_init_api
>             bus_set_iommu
>               iommu_bus_init
>                 bus_for_each_dev(..., add_iommu_group)
>                   add_iommu_group
>                     iommu_probe_device
>                       amd_iommu_add_device                      # amd_iommu_ops.add_device
>                         init_iommu_group
>                           iommu_group_get_for_dev
>                             iommu_group_add_device
>                               __iommu_attach_device
>                                 amd_iommu_attach_device         # amd_iommu_ops.attach_dev
>                                   attach_device                 # amd_iommu
>                                     pdev_iommuv2_enable
>                                       pci_enable_pri
> 
> 
>     iommu_probe_device
>       intel_iommu_add_device                    # intel_iommu_ops.add_device
>         domain_add_dev_info
>           dmar_insert_one_dev_info
>             domain_context_mapping
>               domain_context_mapping_one
>                 iommu_enable_dev_iotlb
>                   pci_enable_pri
> 
> 
> These *look* like enumeration paths, not DMA setup paths.  But I could
> be wrong, since I gave up before getting to the source.
> 
> I don't want to add all this complexity because we *think* we need it.
> I want to think about whether it makes *sense*.  Maybe it's sensible
> for the PF enumeration or a PF driver to enable the hardware it owns.
> 
> If we leave it to the VFs, then we have issues with coordinating
> between VFs that want different settings, etc.
> 
> If we understand the whole picture and it needs to be in the VFs,
> that's fine.  But I don't think we understand the whole picture yet.

After re-analyzing the code paths, I also could not find the use case
where PF/VF PRI/PASID is enabled in out of order(VF first and then PF).
Also, I had no luck in finding that old bug report email which triggered
me to come up with this complicated fix. As per my current analysis, as
you have mentioned, PF/VF PRI/PASID enable seems to happen only during
device creation time.

Following are some of the possible code paths:

VF PRI/PASID enable path is,

[ 8367.161880]  iommu_enable_dev_iotlb+0x83/0x180
[ 8367.168061]  domain_context_mapping_one+0x44f/0x500
[ 8367.174264]  ? domain_context_mapping_one+0x500/0x500
[ 8367.180429]  pci_for_each_dma_alias+0x30/0x170
[ 8367.186368]  dmar_insert_one_dev_info+0x43f/0x4d0
[ 8367.192288]  domain_add_dev_info+0x50/0x90
[ 8367.197973]  intel_iommu_attach_device+0x9c/0x130
[ 8367.203726]  __iommu_attach_device+0x47/0xb0
[ 8367.209292]  ? _cond_resched+0x15/0x40
[ 8367.214643]  iommu_group_add_device+0x13a/0x2c0
[ 8367.220102]  iommu_group_get_for_dev+0xa8/0x220
[ 8367.225460]  intel_iommu_add_device+0x61/0x590
[ 8367.230708]  iommu_bus_notifier+0xb1/0xe0
[ 8367.235768]  notifier_call_chain+0x47/0x70
[ 8367.240757]  blocking_notifier_call_chain+0x3e/0x60
[ 8367.245854]  device_add+0x3ec/0x690
[ 8367.250533]  pci_device_add+0x26b/0x660
[ 8367.255207]  pci_iov_add_virtfn+0x1ce/0x3b0
[ 8367.259873]  sriov_enable+0x254/0x410
[ 8367.264323]  dev_fops_ioctl+0x1378/0x1520 [sad8]
[ 8367.322115]  init_fops_ioctl+0x12c/0x150 [sad8]
[ 8367.324921]  do_vfs_ioctl+0xa4/0x630
[ 8367.327415]  ksys_ioctl+0x70/0x80
[ 8367.329822]  __x64_sys_ioctl+0x16/0x20
[ 8367.332310]  do_syscall_64+0x5b/0x1a0
[ 8367.334771]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

PF PRI/PASID enable path is,

[   11.084005] Call Trace:
[   11.084005]  dump_stack+0x5c/0x7b
[   11.084005]  iommu_enable_dev_iotlb+0x83/0x180
[   11.084005]  domain_context_mapping_one+0x44f/0x500
[   11.084005]  ? domain_context_mapping_one+0x500/0x500
[   11.084005]  pci_for_each_dma_alias+0x30/0x170
[   11.084005]  dmar_insert_one_dev_info+0x43f/0x4d0
[   11.084005]  domain_add_dev_info+0x50/0x90
[   11.084005]  intel_iommu_attach_device+0x9c/0x130
[   11.084005]  __iommu_attach_device+0x47/0xb0
[   11.084005]  ? _cond_resched+0x15/0x40
[   11.084005]  iommu_group_add_device+0x13a/0x2c0
[   11.084005]  iommu_group_get_for_dev+0xa8/0x220
[   11.084005]  intel_iommu_add_device+0x61/0x590
[   11.084005]  ? iommu_probe_device+0x40/0x40
[   11.084005]  add_iommu_group+0xa/0x20
[   11.084005]  bus_for_each_dev+0x76/0xc0
[   11.084005]  bus_set_iommu+0x85/0xc0
[   11.084005]  intel_iommu_init+0xfe5/0x11c1
[   11.084005]  ? __fput+0x134/0x220
[   11.084005]  ? set_debug_rodata+0x11/0x11
[   11.084005]  ? e820__memblock_setup+0x60/0x60
[   11.084005]  ? pci_iommu_init+0x16/0x3f
[   11.084005]  pci_iommu_init+0x16/0x3f
[   11.084005]  do_one_initcall+0x46/0x1f4
[   11.084005]  kernel_init_freeable+0x1ba/0x283
[   11.084005]  ? rest_init+0xb0/0xb0
[   11.084005]  kernel_init+0xa/0x120
[   11.084005]  ret_from_fork+0x1f/0x40

Similarly PF/VF PRI/PASID possible disable paths are,

iommu_hotplug_path->disable_dmar_iommu->__dmar_remove_one_dev_info->iommu_disable_dev_iotlb

domain_exit()->domain_remove_dev_info->iommu_disable_dev_iotlb

vfio_iommu_type1_detach_group()->iommu_detach_group()->intel_iommu_detach_device->dmar_remove_one_dev_info

But even in all of these paths, PF/VF PRI/PASID disable have to happen
in order (VF first and then PF).

So we can implement the logic of not doing anything for VF when its
related PRI/PASID calls. But my questions is, is it safe to go with
these assumptions? Since all these dependencies we have found are not
explicitly defined, if some one breaks it will also affect PRI/PASID
logic. Let me know your comments.



> 
> Bjorn

-- 
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer
