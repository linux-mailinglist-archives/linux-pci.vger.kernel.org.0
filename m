Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457B448EE4C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jan 2022 17:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbiANQhY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jan 2022 11:37:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37854 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiANQhX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jan 2022 11:37:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6053BB82972;
        Fri, 14 Jan 2022 16:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C858AC36AE5;
        Fri, 14 Jan 2022 16:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642178241;
        bh=KyaYGD5TS3Br73BBIPbcTLkwMqDxCiG+l/KbuuZdAy8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AaUMrzij4P2MAa40lkPmSIhzeb5kZFVDbxTlKd7MXQx4L3FGLU13Ne05okdgBLJ5v
         N/MULw5fupYSsXsQaD2znpBIqcTInIAzMHHgasCpEm/4jES5OGPbGWPytCp6lPBv2j
         M5uHj+kbuN3FZunCBw82zEsl2pPCPtDnO9Mg949YlK6XnNRLVqlFENV60r7ch38bMy
         EyuWBit/v0cPqFHjsMegI8u9AeDunI0lbM7zNoLfb7Z+X670tebzVHOAFXKxUIvBbv
         iMp0WIN7HjwEhByCuYND7mPTom3sA1+uwZicSWpLs1RZK5yLgDhJ0mD6oZ0sA+Q1Y6
         Ic9ixpD7zwwHg==
Date:   Fri, 14 Jan 2022 10:37:19 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     Lukasz Maniak <lukasz.maniak@linux.intel.com>,
        yangyicong@hisilicon.com, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?Q?=C5=81ukasz?= Gieryk <lukasz.gieryk@linux.intel.com>
Subject: Re: [PATCH] PCI: Reset IOV state on FLR to PF
Message-ID: <20220114163719.GA560703@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc6ec042-3a74-f5c3-5106-e3ff4689c009@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 14, 2022 at 05:42:48PM +0800, Yicong Yang wrote:
> On 2022/1/14 0:45, Lukasz Maniak wrote:
> > On Wed, Jan 12, 2022 at 08:49:03AM -0600, Bjorn Helgaas wrote:
> >> On Wed, Dec 22, 2021 at 08:19:57PM +0100, Lukasz Maniak wrote:
> >>> As per PCI Express specification, FLR to a PF resets the PF state as
> >>> well as the SR-IOV extended capability including VF Enable which means
> >>> that VFs no longer exist.
> >>
> >> Can you add a specific reference to the spec, please?
> >>
> > Following the Single Root I/O Virtualization and Sharing Specification:
> > 2.2.3. FLR That Targets a PF
> > PFs must support FLR.
> > FLR to a PF resets the PF state as well as the SR-IOV extended
> > capability including VF Enable which means that VFs no longer exist.
> > 
> > For PCI Express Base Specification Revision 5.0 and later, this is
> > section 9.2.2.3.

This is also the section in the new PCIe r6.0.  Let's use that.

> >>> Currently, the IOV state is not updated during FLR, resulting in
> >>> non-compliant PCI driver behavior.
> >>
> >> And include a little detail about what problem is observed?  How would
> >> a user know this problem is occurring?
> >>
> > The problem is that the state of the kernel and HW as to the number of
> > VFs gets out of sync after FLR.
> > 
> > This results in further listing, after the FLR is performed by the HW,
> > of VFs that actually no longer exist and should no longer be reported on
> > the PCI bus. lspci return FFs for these VFs.
> 
> There're some exceptions. Take HiSilicon's hns3 and sec device as an
> example, the VF won't be destroyed after the FLR reset.

If FLR on an hns3 PF does *not* clear VF Enable, and the VFs still
exist after FLR, isn't that a violation of sec 9.2.2.3?

If hns3 and sec don't conform to the spec, we should have some sort of
quirk that serves to document and work around this.

> Currently the transactions with the VF will be restored after the
> FLR. But this patch will break that, the VF is fully disabled and
> the transaction cannot be restored. User needs to reconfigure it,
> which is unnecessary before this patch.

What does it mean for a "transaction to be restored"?  Maybe you mean
this patch removes the *VFs* via sriov_del_vfs(), and whoever
initiated the FLR would need to re-enable VFs via pci_enable_sriov()
or something similar?

If FLR disables VFs, it seems like we should expect to have to
re-enable them if we want them.

> Can we handle this problem in another way? Maybe test the VF's
> vendor device ID after the FLR reset to see whether it has really
> gone or not?
>
> > sriov_numvfs in sysfs returns old invalid value and does not allow
> > setting a new value before explicitly setting 0 in the first place.
> > 
> >>> This patch introduces a simple function, called on the FLR path, that
> >>> removes the virtual function devices from the PCI bus and their
> >>> corresponding sysfs links with a final clear of the num_vfs value in IOV
> >>> state.
> >>>
> >>> Signed-off-by: Lukasz Maniak <lukasz.maniak@linux.intel.com>
> >>> ---
> >>>  drivers/pci/iov.c | 21 +++++++++++++++++++++
> >>>  drivers/pci/pci.c |  2 ++
> >>>  drivers/pci/pci.h |  4 ++++
> >>>  3 files changed, 27 insertions(+)
> >>>
> >>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> >>> index 0267977c9f17..69ee321027b4 100644
> >>> --- a/drivers/pci/iov.c
> >>> +++ b/drivers/pci/iov.c
> >>> @@ -1013,6 +1013,27 @@ int pci_iov_bus_range(struct pci_bus *bus)
> >>>  	return max ? max - bus->number : 0;
> >>>  }
> >>>  
> >>> +/**
> >>> + * pci_reset_iov_state - reset the state of the IOV capability
> >>> + * @dev: the PCI device
> >>> + */
> >>> +void pci_reset_iov_state(struct pci_dev *dev)
> >>> +{
> >>> +	struct pci_sriov *iov = dev->sriov;
> >>> +
> >>> +	if (!dev->is_physfn)
> >>> +		return;
> >>> +	if (!iov->num_VFs)
> >>> +		return;
> >>> +
> >>> +	sriov_del_vfs(dev);
> >>> +
> >>> +	if (iov->link != dev->devfn)
> >>> +		sysfs_remove_link(&dev->dev.kobj, "dep_link");
> >>> +
> >>> +	iov->num_VFs = 0;
> >>> +}
> >>> +
> >>>  /**
> >>>   * pci_enable_sriov - enable the SR-IOV capability
> >>>   * @dev: the PCI device
> >>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >>> index 3d2fb394986a..535f19d37e8d 100644
> >>> --- a/drivers/pci/pci.c
> >>> +++ b/drivers/pci/pci.c
> >>> @@ -4694,6 +4694,8 @@ EXPORT_SYMBOL(pci_wait_for_pending_transaction);
> >>>   */
> >>>  int pcie_flr(struct pci_dev *dev)
> >>>  {
> >>> +	pci_reset_iov_state(dev);
> >>> +
> >>>  	if (!pci_wait_for_pending_transaction(dev))
> >>>  		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
> >>>  
> >>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> >>> index 3d60cabde1a1..7bb144fbec76 100644
> >>> --- a/drivers/pci/pci.h
> >>> +++ b/drivers/pci/pci.h
> >>> @@ -480,6 +480,7 @@ void pci_iov_update_resource(struct pci_dev *dev, int resno);
> >>>  resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno);
> >>>  void pci_restore_iov_state(struct pci_dev *dev);
> >>>  int pci_iov_bus_range(struct pci_bus *bus);
> >>> +void pci_reset_iov_state(struct pci_dev *dev);
> >>>  extern const struct attribute_group sriov_pf_dev_attr_group;
> >>>  extern const struct attribute_group sriov_vf_dev_attr_group;
> >>>  #else
> >>> @@ -501,6 +502,9 @@ static inline int pci_iov_bus_range(struct pci_bus *bus)
> >>>  {
> >>>  	return 0;
> >>>  }
> >>> +static inline void pci_reset_iov_state(struct pci_dev *dev)
> >>> +{
> >>> +}
> >>>  
> >>>  #endif /* CONFIG_PCI_IOV */
> >>>  
> >>>
> >>> base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
> >>> -- 
> >>> 2.25.1
> >>>
> > .
> > 
