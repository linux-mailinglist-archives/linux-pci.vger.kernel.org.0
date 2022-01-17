Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA75491200
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jan 2022 23:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243669AbiAQWzr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jan 2022 17:55:47 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49646 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiAQWzq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jan 2022 17:55:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A561B81223;
        Mon, 17 Jan 2022 22:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA596C36AEC;
        Mon, 17 Jan 2022 22:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642460144;
        bh=MclqmDZx8r3dVXnL9Y5hPNJ+4+2V1RMl0nPPDLyyXXY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uiKlOLbquJRn8mmS95F5/I/Tbx1JJ/apTSdS6WFX0tyRTSCUpfWaTSSmyamNbRT8Y
         v3wpyMlNyj90Umzym3hkz/RFYfa+VhPPmry6mv92MTLRqpzowtcqt4piUJZcGS23UM
         AhmLPLPwVJK7n4TYBg5ptin9hcm3Qt0vfw9dkvzqYp/3z3GSNcQPvzYvKl8Tv4uygA
         bD2X3TxpvUjT+i7WsCTRoH87tS/S/MKmNoA15Rw11T0oe/aGvt17aa2tHA7hChED8d
         ABilFBgcWpev0t6VNInXTEGUtYiJi6Bu1Oh0wuVXDdILWyDYZOL0x7raSPqUP/d3P+
         Wz41uCQShkP9g==
Date:   Mon, 17 Jan 2022 16:55:42 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     yangyicong@hisilicon.com,
        Lukasz Maniak <lukasz.maniak@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?Q?=C5=81ukasz?= Gieryk <lukasz.gieryk@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] PCI: Reset IOV state on FLR to PF
Message-ID: <20220117225542.GA813284@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cb41c4c-5d44-ae60-f457-c317daa84c4f@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex in case he has comments on how FLR should work on
non-conforming hns3 devices]

On Sat, Jan 15, 2022 at 05:22:19PM +0800, Yicong Yang wrote:
> On 2022/1/15 0:37, Bjorn Helgaas wrote:
> > On Fri, Jan 14, 2022 at 05:42:48PM +0800, Yicong Yang wrote:
> >> On 2022/1/14 0:45, Lukasz Maniak wrote:
> >>> On Wed, Jan 12, 2022 at 08:49:03AM -0600, Bjorn Helgaas wrote:
> >>>> On Wed, Dec 22, 2021 at 08:19:57PM +0100, Lukasz Maniak wrote:
> >>>>> As per PCI Express specification, FLR to a PF resets the PF state as
> >>>>> well as the SR-IOV extended capability including VF Enable which means
> >>>>> that VFs no longer exist.
> >>>>
> >>>> Can you add a specific reference to the spec, please?
> >>>>
> >>> Following the Single Root I/O Virtualization and Sharing Specification:
> >>> 2.2.3. FLR That Targets a PF
> >>> PFs must support FLR.
> >>> FLR to a PF resets the PF state as well as the SR-IOV extended
> >>> capability including VF Enable which means that VFs no longer exist.
> >>>
> >>> For PCI Express Base Specification Revision 5.0 and later, this is
> >>> section 9.2.2.3.
> > 
> > This is also the section in the new PCIe r6.0.  Let's use that.
> > 
> >>>>> Currently, the IOV state is not updated during FLR, resulting in
> >>>>> non-compliant PCI driver behavior.
> >>>>
> >>>> And include a little detail about what problem is observed?  How would
> >>>> a user know this problem is occurring?
> >>>>
> >>> The problem is that the state of the kernel and HW as to the number of
> >>> VFs gets out of sync after FLR.
> >>>
> >>> This results in further listing, after the FLR is performed by the HW,
> >>> of VFs that actually no longer exist and should no longer be reported on
> >>> the PCI bus. lspci return FFs for these VFs.
> >>
> >> There're some exceptions. Take HiSilicon's hns3 and sec device as an
> >> example, the VF won't be destroyed after the FLR reset.
> > 
> > If FLR on an hns3 PF does *not* clear VF Enable, and the VFs still
> > exist after FLR, isn't that a violation of sec 9.2.2.3?
> 
> yes I think it's a violation to the spec.

Thanks for confirming that.

> > If hns3 and sec don't conform to the spec, we should have some sort of
> > quirk that serves to document and work around this.
> 
> ok I think it'll help. Do you mean something like this based on this patch:
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 69ee321027b4..0e4976c669b2 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -1025,6 +1025,8 @@ void pci_reset_iov_state(struct pci_dev *dev)
>  		return;
>  	if (!iov->num_VFs)
>  		return;
> +	if (dev->flr_no_vf_reset)
> +		return;
> 
>  	sriov_del_vfs(dev);
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 003950c738d2..c8ffcb0ac612 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1860,6 +1860,17 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa256, quirk_huawei_pcie_sva);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa258, quirk_huawei_pcie_sva);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa259, quirk_huawei_pcie_sva);
> 
> +/*
> + * Some HiSilicon PCIe devices' VF won't be destroyed after a FLR reset.
> + * Don't reset these devices' IOV state when doing FLR.
> + */
> +static void quirk_huawei_pcie_flr(struct pci_dev *pdev)
> +{
> +	pdev->flr_no_vf_reset = 1;
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa255, quirk_huawei_pcie_flr);
> +/* ...some other devices have this quirk */

Yes, I think something along this line will help.

> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 18a75c8e615c..e62f9fa4d48f 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -454,6 +454,7 @@ struct pci_dev {
>  	unsigned int	is_probed:1;		/* Device probing in progress */
>  	unsigned int	link_active_reporting:1;/* Device capable of reporting link active */
>  	unsigned int	no_vf_scan:1;		/* Don't scan for VFs after IOV enablement */
> +	unsigned int	flr_no_vf_reset:1;	/* VF won't be destroyed after PF's FLR */
> 
> >> Currently the transactions with the VF will be restored after the
> >> FLR. But this patch will break that, the VF is fully disabled and
> >> the transaction cannot be restored. User needs to reconfigure it,
> >> which is unnecessary before this patch.
> > 
> > What does it mean for a "transaction to be restored"?  Maybe you mean
> > this patch removes the *VFs* via sriov_del_vfs(), and whoever
> > initiated the FLR would need to re-enable VFs via pci_enable_sriov()
> > or something similar?
> 
> Partly. It'll also terminate the VF users.
> Think that I attach the VF of hns to a VM by vfio and ping the network
> in the VM, when doing FLR the 'ping' will pause and after FLR it'll
> resume. Currenlty The driver handle this in the ->reset_{prepare, done}()
> methods. The user of VM may not realize there is a FLR of the PF as the
> VF always exists and the 'ping' is never terminated.
> 
> If we remove the VF when doing FLR, then 1) we'll block in the VF->remove()
> until no one is using the device, for example the 'ping' is finished.
> 2) the VF in the VM no longer exists and we have to re-enable VF and hotplug
> it into the VM and restart the ping. That's a big difference.
> 
> > If FLR disables VFs, it seems like we should expect to have to
> > re-enable them if we want them.
> 
> It involves a remove()/probe() process of the VF driver and the user
> of the VF will be terminated, just like the situation illustrated
> above.

I think users of FLR should be able to rely on it working per spec,
i.e., that VFs will be destroyed.  If hardware like hns3 doesn't do
that, the quirk should work around that in software by doing it
explicitly.

I don't think the non-standard behavior should be exposed to the
users.  The user should not have to know about this hns3 issue.

If FLR on a standard NIC terminates a ping on a VF, FLR on an hns3 NIC
should also terminate a ping on a VF.

> >> Can we handle this problem in another way? Maybe test the VF's
> >> vendor device ID after the FLR reset to see whether it has really
> >> gone or not?
> >>
> >>> sriov_numvfs in sysfs returns old invalid value and does not allow
> >>> setting a new value before explicitly setting 0 in the first place.
> >>>
> >>>>> This patch introduces a simple function, called on the FLR path, that
> >>>>> removes the virtual function devices from the PCI bus and their
> >>>>> corresponding sysfs links with a final clear of the num_vfs value in IOV
> >>>>> state.
> >>>>>
> >>>>> Signed-off-by: Lukasz Maniak <lukasz.maniak@linux.intel.com>
> >>>>> ---
> >>>>>  drivers/pci/iov.c | 21 +++++++++++++++++++++
> >>>>>  drivers/pci/pci.c |  2 ++
> >>>>>  drivers/pci/pci.h |  4 ++++
> >>>>>  3 files changed, 27 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> >>>>> index 0267977c9f17..69ee321027b4 100644
> >>>>> --- a/drivers/pci/iov.c
> >>>>> +++ b/drivers/pci/iov.c
> >>>>> @@ -1013,6 +1013,27 @@ int pci_iov_bus_range(struct pci_bus *bus)
> >>>>>  	return max ? max - bus->number : 0;
> >>>>>  }
> >>>>>  
> >>>>> +/**
> >>>>> + * pci_reset_iov_state - reset the state of the IOV capability
> >>>>> + * @dev: the PCI device
> >>>>> + */
> >>>>> +void pci_reset_iov_state(struct pci_dev *dev)
> >>>>> +{
> >>>>> +	struct pci_sriov *iov = dev->sriov;
> >>>>> +
> >>>>> +	if (!dev->is_physfn)
> >>>>> +		return;
> >>>>> +	if (!iov->num_VFs)
> >>>>> +		return;
> >>>>> +
> >>>>> +	sriov_del_vfs(dev);
> >>>>> +
> >>>>> +	if (iov->link != dev->devfn)
> >>>>> +		sysfs_remove_link(&dev->dev.kobj, "dep_link");
> >>>>> +
> >>>>> +	iov->num_VFs = 0;
> >>>>> +}
> >>>>> +
> >>>>>  /**
> >>>>>   * pci_enable_sriov - enable the SR-IOV capability
> >>>>>   * @dev: the PCI device
> >>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >>>>> index 3d2fb394986a..535f19d37e8d 100644
> >>>>> --- a/drivers/pci/pci.c
> >>>>> +++ b/drivers/pci/pci.c
> >>>>> @@ -4694,6 +4694,8 @@ EXPORT_SYMBOL(pci_wait_for_pending_transaction);
> >>>>>   */
> >>>>>  int pcie_flr(struct pci_dev *dev)
> >>>>>  {
> >>>>> +	pci_reset_iov_state(dev);
> >>>>> +
> >>>>>  	if (!pci_wait_for_pending_transaction(dev))
> >>>>>  		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
> >>>>>  
> >>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> >>>>> index 3d60cabde1a1..7bb144fbec76 100644
> >>>>> --- a/drivers/pci/pci.h
> >>>>> +++ b/drivers/pci/pci.h
> >>>>> @@ -480,6 +480,7 @@ void pci_iov_update_resource(struct pci_dev *dev, int resno);
> >>>>>  resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno);
> >>>>>  void pci_restore_iov_state(struct pci_dev *dev);
> >>>>>  int pci_iov_bus_range(struct pci_bus *bus);
> >>>>> +void pci_reset_iov_state(struct pci_dev *dev);
> >>>>>  extern const struct attribute_group sriov_pf_dev_attr_group;
> >>>>>  extern const struct attribute_group sriov_vf_dev_attr_group;
> >>>>>  #else
> >>>>> @@ -501,6 +502,9 @@ static inline int pci_iov_bus_range(struct pci_bus *bus)
> >>>>>  {
> >>>>>  	return 0;
> >>>>>  }
> >>>>> +static inline void pci_reset_iov_state(struct pci_dev *dev)
> >>>>> +{
> >>>>> +}
> >>>>>  
> >>>>>  #endif /* CONFIG_PCI_IOV */
