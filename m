Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CB9669195
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 09:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240657AbjAMItp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 03:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240856AbjAMItb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 03:49:31 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B712F792;
        Fri, 13 Jan 2023 00:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673599768; x=1705135768;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SOjSO09isA8OQCKtWEdZRS285mnjUUfSV+vLHXafAtk=;
  b=PBaoZ35UB0+JxI4gWkuiKbrE7GjkVQVpfQ3chpMdPMBc+q/90e4495Mn
   0BA83RnfSIafvCZ6cxbuqWy044rz2l0Osv5gxALtDGROPzvak0OlltY6p
   hYQhTWen7SftyCJbaIG3nMhroOBLvApWPdly0vDlFhq2dxqJ1QH5NzEak
   LlFMjHJQ/EYSP7cuzoAY6gbgjJBClACs+aMUqRVWpVhF0c3ZIHVEOFKSj
   C7XL2UzvjJ3UU18IvP7wlX9k9buZh3xLVaEoI3hksd1Yc7JNYkdaJy9Qa
   Gf+Bfq1Y3PKrsHH0W//qzTsrvU1eCsUhgl0Eat9oHDhYLKBWclTAAdZlI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="303645553"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="303645553"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 00:49:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="800534242"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="800534242"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.190.181]) ([10.252.190.181])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 00:49:25 -0800
Message-ID: <e40bacb0-701c-5373-3890-d037f668829f@linux.intel.com>
Date:   Fri, 13 Jan 2023 16:49:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Tony Zhu <tony.zhu@intel.com>, linux-pci@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] PCI: Add translated request only flag for
 pci_enable_pasid()
To:     Matt Fagnani <matt.fagnani@bell.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>
References: <20230113014409.752405-1-baolu.lu@linux.intel.com>
 <c34d66a1-1564-1ec5-86de-6ebd1ebb2f71@bell.net>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <c34d66a1-1564-1ec5-86de-6ebd1ebb2f71@bell.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023/1/13 16:15, Matt Fagnani wrote:
> Baolu,
> 
> 6.2-rc3 with v2 of this patch applied booted normally without the black 
> screen problem. regzbot by Thorsten Leemhuis recommends adding the 
> following link tag to the previous discussion at 
> https://linux-regtracking.leemhuis.info/regzbot/mainline/ "When fixing, 
> add this to the commit message to make regzbot notice patch postings and 
> commits to resolve the issue:" Link: 
> https://lore.kernel.org/r/15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info/

Sure. I will add below:

Fixes: 201007ef707a ("PCI: Enable PASID only when ACS RR & UF enabled on 
upstream path")
Reported-by: Matt Fagnani <matt.fagnani@bell.net>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216865
Link: 
https://lore.kernel.org/r/15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info/

By the way, can I add your tested-by?

--
Best regards,
baolu

> 
> Thanks,
> 
> Matt
> 
> On 1/12/23 20:44, Lu Baolu wrote:
>> The PCIe fabric routes Memory Requests based on the TLP address, ignoring
>> the PASID. In order to ensure system integrity, commit 201007ef707a 
>> ("PCI:
>> Enable PASID only when ACS RR & UF enabled on upstream path") requires
>> some ACS features being supported on device's upstream path when enabling
>> PCI/PASID.
>>
>> One alternative is ATS which lets the device resolve the PASID+addr pair
>> before a memory request is made into a routeable TLB address through the
>> TA. Those resolved addresses are then cached on the device instead of
>> in the IOMMU TLB and the device always sets the translated bit for PASID.
>> One example of those devices are AMD graphic devices that always have ACS
>> or ATS enabled together with PASID.
>>
>> This adds a flag parameter in the pci_enable_pasid() helper, with which
>> the device driver could opt-in the fact that device always sets the
>> translated bit for PASID.
>>
>> It also applies this opt-in for AMD graphic devices. Without this change,
>> kernel boots to black screen on a system with below AMD graphic device:
>>
>> 00:01.0 VGA compatible controller: Advanced Micro Devices, Inc.
>>          [AMD/ATI] Wani [Radeon R5/R6/R7 Graphics] (rev ca)
>>          (prog-if 00 [VGA controller])
>>     DeviceName: ATI EG BROADWAY
>>     Subsystem: Hewlett-Packard Company Device 8332
>>
>> At present, it is a common practice to enable/disable PCI PASID in the
>> iommu drivers. Considering that the device driver knows more about the
>> specific device, we will follow up by moving pci_enable_pasid() into
>> the specific device drivers.
>>
>> Fixes: 201007ef707a ("PCI: Enable PASID only when ACS RR & UF enabled 
>> on upstream path")
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216865
>> Reported-by: Matt Fagnani <matt.fagnani@bell.net>
>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   include/linux/pci-ats.h                     | 6 ++++--
>>   drivers/iommu/amd/iommu.c                   | 2 +-
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
>>   drivers/iommu/intel/iommu.c                 | 3 ++-
>>   drivers/pci/ats.c                           | 8 ++++++--
>>   5 files changed, 14 insertions(+), 7 deletions(-)
>>
>> Change log:
>> v2:
>>   - Convert the bool to a named flag;
>>   - Convert TRANSLED to XLATED.
>>
>> v1:
>>   - 
>> https://lore.kernel.org/linux-iommu/20230112084629.737653-1-baolu.lu@linux.intel.com/
>>
>> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
>> index df54cd5b15db..750fca736ef4 100644
>> --- a/include/linux/pci-ats.h
>> +++ b/include/linux/pci-ats.h
>> @@ -4,6 +4,8 @@
>>   #include <linux/pci.h>
>> +#define PCI_PASID_XLATED_REQ_ONLY    BIT(0)
>> +
>>   #ifdef CONFIG_PCI_ATS
>>   /* Address Translation Service */
>>   bool pci_ats_supported(struct pci_dev *dev);
>> @@ -35,12 +37,12 @@ static inline bool pci_pri_supported(struct 
>> pci_dev *pdev)
>>   #endif /* CONFIG_PCI_PRI */
>>   #ifdef CONFIG_PCI_PASID
>> -int pci_enable_pasid(struct pci_dev *pdev, int features);
>> +int pci_enable_pasid(struct pci_dev *pdev, int features, int flags);
>>   void pci_disable_pasid(struct pci_dev *pdev);
>>   int pci_pasid_features(struct pci_dev *pdev);
>>   int pci_max_pasids(struct pci_dev *pdev);
>>   #else /* CONFIG_PCI_PASID */
>> -static inline int pci_enable_pasid(struct pci_dev *pdev, int features)
>> +static inline int pci_enable_pasid(struct pci_dev *pdev, int 
>> features, int flags)
>>   { return -EINVAL; }
>>   static inline void pci_disable_pasid(struct pci_dev *pdev) { }
>>   static inline int pci_pasid_features(struct pci_dev *pdev)
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index cbeaab55c0db..64a8c03d7dfa 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -1700,7 +1700,7 @@ static int pdev_pri_ats_enable(struct pci_dev 
>> *pdev)
>>       int ret;
>>       /* Only allow access to user-accessible pages */
>> -    ret = pci_enable_pasid(pdev, 0);
>> +    ret = pci_enable_pasid(pdev, 0, PCI_PASID_XLATED_REQ_ONLY);
>>       if (ret)
>>           goto out_err;
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c 
>> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index ab160198edd6..891bf53c45dc 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -2350,7 +2350,7 @@ static int arm_smmu_enable_pasid(struct 
>> arm_smmu_master *master)
>>       if (num_pasids <= 0)
>>           return num_pasids;
>> -    ret = pci_enable_pasid(pdev, features);
>> +    ret = pci_enable_pasid(pdev, features, 0);
>>       if (ret) {
>>           dev_err(&pdev->dev, "Failed to enable PASID\n");
>>           return ret;
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 59df7e42fd53..5cc13f02a5ac 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -1425,7 +1425,8 @@ static void iommu_enable_pci_caps(struct 
>> device_domain_info *info)
>>          undefined. So always enable PASID support on devices which
>>          have it, even if we can't yet know if we're ever going to
>>          use it. */
>> -    if (info->pasid_supported && !pci_enable_pasid(pdev, 
>> info->pasid_supported & ~1))
>> +    if (info->pasid_supported &&
>> +        !pci_enable_pasid(pdev, info->pasid_supported & ~1, 0))
>>           info->pasid_enabled = 1;
>>       if (info->pri_supported &&
>> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
>> index f9cc2e10b676..3a2d9e0ba1d8 100644
>> --- a/drivers/pci/ats.c
>> +++ b/drivers/pci/ats.c
>> @@ -353,12 +353,15 @@ void pci_pasid_init(struct pci_dev *pdev)
>>    * pci_enable_pasid - Enable the PASID capability
>>    * @pdev: PCI device structure
>>    * @features: Features to enable
>> + * @flags: device-specific flags
>> + *   - PCI_PASID_XLATED_REQ_ONLY: The PCI device only issues PASID
>> + *                                memory requests of translated type.
>>    *
>>    * Returns 0 on success, negative value on error. This function checks
>>    * whether the features are actually supported by the device and 
>> returns
>>    * an error if not.
>>    */
>> -int pci_enable_pasid(struct pci_dev *pdev, int features)
>> +int pci_enable_pasid(struct pci_dev *pdev, int features, int flags)
>>   {
>>       u16 control, supported;
>>       int pasid = pdev->pasid_cap;
>> @@ -382,7 +385,8 @@ int pci_enable_pasid(struct pci_dev *pdev, int 
>> features)
>>       if (!pasid)
>>           return -EINVAL;
>> -    if (!pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR | PCI_ACS_UF))
>> +    if (!(flags & PCI_PASID_XLATED_REQ_ONLY) &&
>> +        !pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR | PCI_ACS_UF))
>>           return -EINVAL;
>>       pci_read_config_word(pdev, pasid + PCI_PASID_CAP, &supported);

