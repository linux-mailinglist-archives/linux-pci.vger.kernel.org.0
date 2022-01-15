Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE33148F618
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jan 2022 10:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbiAOJWW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 Jan 2022 04:22:22 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:31161 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbiAOJWV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 Jan 2022 04:22:21 -0500
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JbXg95SrYz8wGj;
        Sat, 15 Jan 2022 17:19:33 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 15 Jan 2022 17:22:19 +0800
CC:     <yangyicong@hisilicon.com>,
        Lukasz Maniak <lukasz.maniak@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?=c5=81ukasz_Gieryk?= <lukasz.gieryk@linux.intel.com>
Subject: Re: [PATCH] PCI: Reset IOV state on FLR to PF
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20220114163719.GA560703@bhelgaas>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <9cb41c4c-5d44-ae60-f457-c317daa84c4f@huawei.com>
Date:   Sat, 15 Jan 2022 17:22:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20220114163719.GA560703@bhelgaas>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/1/15 0:37, Bjorn Helgaas wrote:
> On Fri, Jan 14, 2022 at 05:42:48PM +0800, Yicong Yang wrote:
>> On 2022/1/14 0:45, Lukasz Maniak wrote:
>>> On Wed, Jan 12, 2022 at 08:49:03AM -0600, Bjorn Helgaas wrote:
>>>> On Wed, Dec 22, 2021 at 08:19:57PM +0100, Lukasz Maniak wrote:
>>>>> As per PCI Express specification, FLR to a PF resets the PF state as
>>>>> well as the SR-IOV extended capability including VF Enable which means
>>>>> that VFs no longer exist.
>>>>
>>>> Can you add a specific reference to the spec, please?
>>>>
>>> Following the Single Root I/O Virtualization and Sharing Specification:
>>> 2.2.3. FLR That Targets a PF
>>> PFs must support FLR.
>>> FLR to a PF resets the PF state as well as the SR-IOV extended
>>> capability including VF Enable which means that VFs no longer exist.
>>>
>>> For PCI Express Base Specification Revision 5.0 and later, this is
>>> section 9.2.2.3.
> 
> This is also the section in the new PCIe r6.0.  Let's use that.
> 
>>>>> Currently, the IOV state is not updated during FLR, resulting in
>>>>> non-compliant PCI driver behavior.
>>>>
>>>> And include a little detail about what problem is observed?  How would
>>>> a user know this problem is occurring?
>>>>
>>> The problem is that the state of the kernel and HW as to the number of
>>> VFs gets out of sync after FLR.
>>>
>>> This results in further listing, after the FLR is performed by the HW,
>>> of VFs that actually no longer exist and should no longer be reported on
>>> the PCI bus. lspci return FFs for these VFs.
>>
>> There're some exceptions. Take HiSilicon's hns3 and sec device as an
>> example, the VF won't be destroyed after the FLR reset.
> 
> If FLR on an hns3 PF does *not* clear VF Enable, and the VFs still
> exist after FLR, isn't that a violation of sec 9.2.2.3?
> 

yes I think it's a violation to the spec.

> If hns3 and sec don't conform to the spec, we should have some sort of
> quirk that serves to document and work around this.
> 

ok I think it'll help. Do you mean something like this based on this patch:

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 69ee321027b4..0e4976c669b2 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -1025,6 +1025,8 @@ void pci_reset_iov_state(struct pci_dev *dev)
 		return;
 	if (!iov->num_VFs)
 		return;
+	if (dev->flr_no_vf_reset)
+		return;

 	sriov_del_vfs(dev);

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 003950c738d2..c8ffcb0ac612 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1860,6 +1860,17 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa256, quirk_huawei_pcie_sva);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa258, quirk_huawei_pcie_sva);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa259, quirk_huawei_pcie_sva);

+/*
+ * Some HiSilicon PCIe devices' VF won't be destroyed after a FLR reset.
+ * Don't reset these devices' IOV state when doing FLR.
+ */
+static void quirk_huawei_pcie_flr(struct pci_dev *pdev)
+{
+	pdev->flr_no_vf_reset = 1;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa255, quirk_huawei_pcie_flr);
+/* ...some other devices have this quirk */
+
 /*
  * It's possible for the MSI to get corrupted if SHPC and ACPI are used
  * together on certain PXH-based systems.
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 18a75c8e615c..e62f9fa4d48f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -454,6 +454,7 @@ struct pci_dev {
 	unsigned int	is_probed:1;		/* Device probing in progress */
 	unsigned int	link_active_reporting:1;/* Device capable of reporting link active */
 	unsigned int	no_vf_scan:1;		/* Don't scan for VFs after IOV enablement */
+	unsigned int	flr_no_vf_reset:1;	/* VF won't be destroyed after PF's FLR */
 	unsigned int	no_command_memory:1;	/* No PCI_COMMAND_MEMORY */
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
-- 
2.24.0


>> Currently the transactions with the VF will be restored after the
>> FLR. But this patch will break that, the VF is fully disabled and
>> the transaction cannot be restored. User needs to reconfigure it,
>> which is unnecessary before this patch.
> 
> What does it mean for a "transaction to be restored"?  Maybe you mean
> this patch removes the *VFs* via sriov_del_vfs(), and whoever
> initiated the FLR would need to re-enable VFs via pci_enable_sriov()
> or something similar?
> 

Partly. It'll also terminate the VF users.
Think that I attach the VF of hns to a VM by vfio and ping the network
in the VM, when doing FLR the 'ping' will pause and after FLR it'll
resume. Currenlty The driver handle this in the ->reset_{prepare, done}()
methods. The user of VM may not realize there is a FLR of the PF as the
VF always exists and the 'ping' is never terminated.

If we remove the VF when doing FLR, then 1) we'll block in the VF->remove()
until no one is using the device, for example the 'ping' is finished.
2) the VF in the VM no longer exists and we have to re-enable VF and hotplug
it into the VM and restart the ping. That's a big difference.

> If FLR disables VFs, it seems like we should expect to have to
> re-enable them if we want them.
> 

It involves a remove()/probe() process of the VF driver and the user of the VF
will be terminated, just like the situation illustrated above.

Thanks,
Yicong

>> Can we handle this problem in another way? Maybe test the VF's
>> vendor device ID after the FLR reset to see whether it has really
>> gone or not?
>>
>>> sriov_numvfs in sysfs returns old invalid value and does not allow
>>> setting a new value before explicitly setting 0 in the first place.
>>>
>>>>> This patch introduces a simple function, called on the FLR path, that
>>>>> removes the virtual function devices from the PCI bus and their
>>>>> corresponding sysfs links with a final clear of the num_vfs value in IOV
>>>>> state.
>>>>>
>>>>> Signed-off-by: Lukasz Maniak <lukasz.maniak@linux.intel.com>
>>>>> ---
>>>>>  drivers/pci/iov.c | 21 +++++++++++++++++++++
>>>>>  drivers/pci/pci.c |  2 ++
>>>>>  drivers/pci/pci.h |  4 ++++
>>>>>  3 files changed, 27 insertions(+)
>>>>>
>>>>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>>>>> index 0267977c9f17..69ee321027b4 100644
>>>>> --- a/drivers/pci/iov.c
>>>>> +++ b/drivers/pci/iov.c
>>>>> @@ -1013,6 +1013,27 @@ int pci_iov_bus_range(struct pci_bus *bus)
>>>>>  	return max ? max - bus->number : 0;
>>>>>  }
>>>>>  
>>>>> +/**
>>>>> + * pci_reset_iov_state - reset the state of the IOV capability
>>>>> + * @dev: the PCI device
>>>>> + */
>>>>> +void pci_reset_iov_state(struct pci_dev *dev)
>>>>> +{
>>>>> +	struct pci_sriov *iov = dev->sriov;
>>>>> +
>>>>> +	if (!dev->is_physfn)
>>>>> +		return;
>>>>> +	if (!iov->num_VFs)
>>>>> +		return;
>>>>> +
>>>>> +	sriov_del_vfs(dev);
>>>>> +
>>>>> +	if (iov->link != dev->devfn)
>>>>> +		sysfs_remove_link(&dev->dev.kobj, "dep_link");
>>>>> +
>>>>> +	iov->num_VFs = 0;
>>>>> +}
>>>>> +
>>>>>  /**
>>>>>   * pci_enable_sriov - enable the SR-IOV capability
>>>>>   * @dev: the PCI device
>>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>>> index 3d2fb394986a..535f19d37e8d 100644
>>>>> --- a/drivers/pci/pci.c
>>>>> +++ b/drivers/pci/pci.c
>>>>> @@ -4694,6 +4694,8 @@ EXPORT_SYMBOL(pci_wait_for_pending_transaction);
>>>>>   */
>>>>>  int pcie_flr(struct pci_dev *dev)
>>>>>  {
>>>>> +	pci_reset_iov_state(dev);
>>>>> +
>>>>>  	if (!pci_wait_for_pending_transaction(dev))
>>>>>  		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
>>>>>  
>>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>>>> index 3d60cabde1a1..7bb144fbec76 100644
>>>>> --- a/drivers/pci/pci.h
>>>>> +++ b/drivers/pci/pci.h
>>>>> @@ -480,6 +480,7 @@ void pci_iov_update_resource(struct pci_dev *dev, int resno);
>>>>>  resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno);
>>>>>  void pci_restore_iov_state(struct pci_dev *dev);
>>>>>  int pci_iov_bus_range(struct pci_bus *bus);
>>>>> +void pci_reset_iov_state(struct pci_dev *dev);
>>>>>  extern const struct attribute_group sriov_pf_dev_attr_group;
>>>>>  extern const struct attribute_group sriov_vf_dev_attr_group;
>>>>>  #else
>>>>> @@ -501,6 +502,9 @@ static inline int pci_iov_bus_range(struct pci_bus *bus)
>>>>>  {
>>>>>  	return 0;
>>>>>  }
>>>>> +static inline void pci_reset_iov_state(struct pci_dev *dev)
>>>>> +{
>>>>> +}
>>>>>  
>>>>>  #endif /* CONFIG_PCI_IOV */
>>>>>  
>>>>>
>>>>> base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
>>>>> -- 
>>>>> 2.25.1
>>>>>
>>> .
>>>
> .
> 
