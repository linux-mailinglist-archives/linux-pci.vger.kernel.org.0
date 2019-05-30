Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECAF30123
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2019 19:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbfE3Rl3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 May 2019 13:41:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:26068 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbfE3Rl3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 May 2019 13:41:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 May 2019 10:41:28 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 30 May 2019 10:41:28 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id A26095804BA;
        Thu, 30 May 2019 10:41:27 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v2 1/5] PCI/ATS: Add PRI support for PCIe VF devices
To:     "Raj, Ashok" <ashok.raj@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com
References: <cover.1557162861.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <f773440c0eee2a8d4e5d6e2856717404ac836458.1557162861.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190529225714.GE28250@google.com>
 <20190529230426.GB5108@araj-mobl1.jf.intel.com>
 <20190530131738.GK28250@google.com>
 <20190530172055.GB18559@araj-mobl1.jf.intel.com>
From:   sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <b531ba10-0776-a5d0-77e4-b0bcaba1b558@linux.intel.com>
Date:   Thu, 30 May 2019 10:39:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190530172055.GB18559@araj-mobl1.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 5/30/19 10:20 AM, Raj, Ashok wrote:
> On Thu, May 30, 2019 at 08:17:38AM -0500, Bjorn Helgaas wrote:
>> On Wed, May 29, 2019 at 04:04:27PM -0700, Raj, Ashok wrote:
>>> On Wed, May 29, 2019 at 05:57:14PM -0500, Bjorn Helgaas wrote:
>>>> On Mon, May 06, 2019 at 10:20:03AM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>>>>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>>>
>>>>> When IOMMU tries to enable PRI for VF device in
>>>>> iommu_enable_dev_iotlb(), it always fails because PRI support for PCIe
>>>>> VF device is currently broken in PCIE driver. Current implementation
>>>>> expects the given PCIe device (PF & VF) to implement PRI capability
>>>>> before enabling the PRI support. But this assumption is incorrect. As
>>>>> per PCIe spec r4.0, sec 9.3.7.11, all VFs associated with PF can only
>>>>> use the Page Request Interface (PRI) of the PF and not implement it.
>>>>> Hence we need to create exception for handling the PRI support for PCIe
>>>>> VF device.
>>>>>
>>>>> Since PRI is shared between PF/VF devices, following rules should apply.
>>>>>
>>>>> 1. Enable PRI in VF only if its already enabled in PF.
>>>>> 2. When enabling/disabling PRI for VF, instead of configuring the
>>>>> registers just increase/decrease the usage count (pri_ref_cnt) of PF.
>>>>> 3. Disable PRI in PF only if pr_ref_cnt is zero.
>>>> s/pr_ref_cnt/pri_ref_cnt/
>>>>
>>>>> Cc: Ashok Raj <ashok.raj@intel.com>
>>>>> Cc: Keith Busch <keith.busch@intel.com>
>>>>> Suggested-by: Ashok Raj <ashok.raj@intel.com>
>>>>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>>> ---
>>>>>   drivers/pci/ats.c   | 53 +++++++++++++++++++++++++++++++++++++++++++--
>>>>>   include/linux/pci.h |  1 +
>>>>>   2 files changed, 52 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
>>>>> index 97c08146534a..5582e5d83a3f 100644
>>>>> --- a/drivers/pci/ats.c
>>>>> +++ b/drivers/pci/ats.c
>>>>> @@ -181,12 +181,39 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
>>>>>   	u16 control, status;
>>>>>   	u32 max_requests;
>>>>>   	int pos;
>>>>> +	struct pci_dev *pf;
>>>>>   
>>>>>   	if (WARN_ON(pdev->pri_enabled))
>>>>>   		return -EBUSY;
>>>>>   
>>>>>   	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
>>>>> -	if (!pos)
>>>>> +
>>>>> +	if (pdev->is_virtfn) {
>>>>> +		/*
>>>>> +		 * Per PCIe r4.0, sec 9.3.7.11, VF must not implement PRI
>>>>> +		 * Capability.
>>>>> +		 */
>>>>> +		if (pos) {
>>>>> +			dev_err(&pdev->dev, "VF must not implement PRI");
>>>>> +			return -EINVAL;
>>>>> +		}
>>>> This seems gratuitous.  It finds implementation errors, but since we
>>>> correctly use the PF here anyway, it doesn't *need* to prevent PRI on
>>>> the VF from working.
>>>>
>>>> I think you should just have:
>>>>
>>>>    if (pdev->is_virtfn) {
>>>>      pf = pci_physfn(pdev);
>>>>      if (!pf->pri_enabled)
>>>>        return -EINVAL;
>>> This would be incorrect. Since if we never did any bind_mm to the PF
>>> PRI would not have been enabled. Currently this is done in the IOMMU
>>> driver, and not in the device driver.
>> This is functionally the same as the original patch, only omitting the
>> "VF must not implement PRI" check.
>>
>>> I suppose we should enable PF capability if its not enabled. Same
>>> comment would be applicable for PASID as well.
>> Operating on a device other than the one the driver owns opens the
>> issue of mutual exclusion and races, so would require careful
>> scrutiny.  Are PRI/PASID things that could be *always* enabled for the
>> PF at enumeration-time, or do we have to wait until a driver claims
>> the VF?  If the latter, are there coordination issues between drivers
>> of different VFs?
> I suppose that's a reasonably good alternative. You mean we could
> do this when VF's are being created? Otherwise we can do this as its
> done today, on demand for all normal PF's.

If we are going to enable it with default features then its doable. But 
for cases with custom requirements, it will become complicated. For 
example, in following code, IOMMU sets PRI Outstanding Page Allocation 
quota as 32 or 1 based on errata info. So if we just enable it by 
default then we may not be able to take these requirements into 
consideration.

2051 static int pdev_iommuv2_enable(struct pci_dev *pdev)
2052 {
2053         bool reset_enable;
2054         int reqs, ret;
2055
2056         /* FIXME: Hardcode number of outstanding requests for now */
2057         reqs = 32;
2058         if (pdev_pri_erratum(pdev, AMD_PRI_DEV_ERRATUM_LIMIT_REQ_ONE))
2059                 reqs = 1;
2060         reset_enable = pdev_pri_erratum(pdev, 
AMD_PRI_DEV_ERRATUM_ENABLE_RESET);

2073         ret = pci_enable_pri(pdev, reqs);


>
>
> Cheers,
> Ashok
>
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

