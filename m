Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1DC48E7BA
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jan 2022 10:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbiANJmw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jan 2022 04:42:52 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:35842 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiANJmu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jan 2022 04:42:50 -0500
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JZxCh0K0mzccbV;
        Fri, 14 Jan 2022 17:42:08 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 14 Jan 2022 17:42:48 +0800
CC:     <yangyicong@hisilicon.com>, Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?=c5=81ukasz_Gieryk?= <lukasz.gieryk@linux.intel.com>
Subject: Re: [PATCH] PCI: Reset IOV state on FLR to PF
To:     Lukasz Maniak <lukasz.maniak@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <20211222191958.955681-1-lukasz.maniak@linux.intel.com>
 <20220112144903.GA253960@bhelgaas>
 <20220113164538.GA577231@lmaniak-dev.igk.intel.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <cc6ec042-3a74-f5c3-5106-e3ff4689c009@huawei.com>
Date:   Fri, 14 Jan 2022 17:42:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20220113164538.GA577231@lmaniak-dev.igk.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/1/14 0:45, Lukasz Maniak wrote:
> On Wed, Jan 12, 2022 at 08:49:03AM -0600, Bjorn Helgaas wrote:
>> On Wed, Dec 22, 2021 at 08:19:57PM +0100, Lukasz Maniak wrote:
>>> As per PCI Express specification, FLR to a PF resets the PF state as
>>> well as the SR-IOV extended capability including VF Enable which means
>>> that VFs no longer exist.
>>
>> Can you add a specific reference to the spec, please?
>>
> Following the Single Root I/O Virtualization and Sharing Specification:
> 2.2.3. FLR That Targets a PF
> PFs must support FLR.
> FLR to a PF resets the PF state as well as the SR-IOV extended
> capability including VF Enable which means that VFs no longer exist.
> 
> For PCI Express Base Specification Revision 5.0 and later, this is
> section 9.2.2.3.
> 
>>> Currently, the IOV state is not updated during FLR, resulting in
>>> non-compliant PCI driver behavior.
>>
>> And include a little detail about what problem is observed?  How would
>> a user know this problem is occurring?
>>
> The problem is that the state of the kernel and HW as to the number of
> VFs gets out of sync after FLR.
> 
> This results in further listing, after the FLR is performed by the HW,
> of VFs that actually no longer exist and should no longer be reported on
> the PCI bus. lspci return FFs for these VFs.
> 

There're some exceptions. Take HiSilicon's hns3 and sec device as an example,
the VF won't be destroyed after the FLR reset. Currently the transactions
with the VF will be restored after the FLR. But this patch will break that,
the VF is fully disabled and the transaction cannot be restored. User needs
to reconfigure it, which is unnecessary before this patch.

Can we handle this problem in another way? Maybe test the VF's vendor device
ID after the FLR reset to see whether it has really gone or not?

Thanks,
Yicong

> sriov_numvfs in sysfs returns old invalid value and does not allow
> setting a new value before explicitly setting 0 in the first place.
> 
>>> This patch introduces a simple function, called on the FLR path, that
>>> removes the virtual function devices from the PCI bus and their
>>> corresponding sysfs links with a final clear of the num_vfs value in IOV
>>> state.
>>>
>>> Signed-off-by: Lukasz Maniak <lukasz.maniak@linux.intel.com>
>>> ---
>>>  drivers/pci/iov.c | 21 +++++++++++++++++++++
>>>  drivers/pci/pci.c |  2 ++
>>>  drivers/pci/pci.h |  4 ++++
>>>  3 files changed, 27 insertions(+)
>>>
>>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>>> index 0267977c9f17..69ee321027b4 100644
>>> --- a/drivers/pci/iov.c
>>> +++ b/drivers/pci/iov.c
>>> @@ -1013,6 +1013,27 @@ int pci_iov_bus_range(struct pci_bus *bus)
>>>  	return max ? max - bus->number : 0;
>>>  }
>>>  
>>> +/**
>>> + * pci_reset_iov_state - reset the state of the IOV capability
>>> + * @dev: the PCI device
>>> + */
>>> +void pci_reset_iov_state(struct pci_dev *dev)
>>> +{
>>> +	struct pci_sriov *iov = dev->sriov;
>>> +
>>> +	if (!dev->is_physfn)
>>> +		return;
>>> +	if (!iov->num_VFs)
>>> +		return;
>>> +
>>> +	sriov_del_vfs(dev);
>>> +
>>> +	if (iov->link != dev->devfn)
>>> +		sysfs_remove_link(&dev->dev.kobj, "dep_link");
>>> +
>>> +	iov->num_VFs = 0;
>>> +}
>>> +
>>>  /**
>>>   * pci_enable_sriov - enable the SR-IOV capability
>>>   * @dev: the PCI device
>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>> index 3d2fb394986a..535f19d37e8d 100644
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -4694,6 +4694,8 @@ EXPORT_SYMBOL(pci_wait_for_pending_transaction);
>>>   */
>>>  int pcie_flr(struct pci_dev *dev)
>>>  {
>>> +	pci_reset_iov_state(dev);
>>> +
>>>  	if (!pci_wait_for_pending_transaction(dev))
>>>  		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
>>>  
>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>> index 3d60cabde1a1..7bb144fbec76 100644
>>> --- a/drivers/pci/pci.h
>>> +++ b/drivers/pci/pci.h
>>> @@ -480,6 +480,7 @@ void pci_iov_update_resource(struct pci_dev *dev, int resno);
>>>  resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno);
>>>  void pci_restore_iov_state(struct pci_dev *dev);
>>>  int pci_iov_bus_range(struct pci_bus *bus);
>>> +void pci_reset_iov_state(struct pci_dev *dev);
>>>  extern const struct attribute_group sriov_pf_dev_attr_group;
>>>  extern const struct attribute_group sriov_vf_dev_attr_group;
>>>  #else
>>> @@ -501,6 +502,9 @@ static inline int pci_iov_bus_range(struct pci_bus *bus)
>>>  {
>>>  	return 0;
>>>  }
>>> +static inline void pci_reset_iov_state(struct pci_dev *dev)
>>> +{
>>> +}
>>>  
>>>  #endif /* CONFIG_PCI_IOV */
>>>  
>>>
>>> base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
>>> -- 
>>> 2.25.1
>>>
> .
> 
