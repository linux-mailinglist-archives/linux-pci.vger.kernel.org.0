Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80B78182B04
	for <lists+linux-pci@lfdr.de>; Thu, 12 Mar 2020 09:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgCLISz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Mar 2020 04:18:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:51333 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgCLISz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Mar 2020 04:18:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 01:18:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,544,1574150400"; 
   d="scan'208";a="261424574"
Received: from unknown (HELO [10.254.208.137]) ([10.254.208.137])
  by orsmga002.jf.intel.com with ESMTP; 12 Mar 2020 01:18:47 -0700
Cc:     baolu.lu@linux.intel.com, bhelgaas@google.com, will@kernel.org,
        robh+dt@kernel.org, joro@8bytes.org, sudeep.holla@arm.com,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
        lorenzo.pieralisi@arm.com, corbet@lwn.net, mark.rutland@arm.com,
        liviu.dudau@arm.com, guohanjun@huawei.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        amurray@thegoodpenguin.co.uk, frowand.list@gmail.com
Subject: Re: [PATCH v2 08/11] iommu/vt-d: Use pci_ats_supported()
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20200311124506.208376-1-jean-philippe@linaro.org>
 <20200311124506.208376-9-jean-philippe@linaro.org>
 <7019230c-3c56-e6db-6704-d73f23fa39b5@linux.intel.com>
 <20200312075436.GA568802@myrica>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5e508904-e432-e3b9-1fe4-0c4e11df10fc@linux.intel.com>
Date:   Thu, 12 Mar 2020 16:18:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312075436.GA568802@myrica>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/3/12 15:54, Jean-Philippe Brucker wrote:
> Hi Baolu,
> 
> On Thu, Mar 12, 2020 at 09:44:16AM +0800, Lu Baolu wrote:
>> Hi Jean,
>>
>> On 2020/3/11 20:45, Jean-Philippe Brucker wrote:
>>> The pci_ats_supported() function checks if a device supports ATS and is
>>> allowed to use it.
>>>
>>> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>> ---
>>>    drivers/iommu/intel-iommu.c | 9 +++------
>>>    1 file changed, 3 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>>> index 6fa6de2b6ad5..17208280ef5c 100644
>>> --- a/drivers/iommu/intel-iommu.c
>>> +++ b/drivers/iommu/intel-iommu.c
>>> @@ -1454,8 +1454,7 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
>>>    	    !pci_reset_pri(pdev) && !pci_enable_pri(pdev, 32))
>>>    		info->pri_enabled = 1;
>>>    #endif
>>> -	if (!pdev->untrusted && info->ats_supported &&
>>> -	    pci_ats_page_aligned(pdev) &&
>>> +	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
>>>    	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
>>>    		info->ats_enabled = 1;
>>>    		domain_update_iotlb(info->domain);
>>> @@ -2611,10 +2610,8 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>>>    	if (dev && dev_is_pci(dev)) {
>>>    		struct pci_dev *pdev = to_pci_dev(info->dev);
>>> -		if (!pdev->untrusted &&
>>> -		    !pci_ats_disabled() &&
>>
>> The pci_ats_disabled() couldn't be replaced by pci_ats_supported(). Even
>> pci_ats_supported() returns true, user still can disable it. Or move
>> ats_disabled into pci_ats_supported()?
> 
> It is already there, but hidden behind the "if (!dev->ats_cap)":
> pci_ats_init() only sets dev->ats_cap after checking that
> pci_ats_disabled() returns false.
>

Ah! Yes.

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

> Thanks,
> Jean

Best regards,
baolu
