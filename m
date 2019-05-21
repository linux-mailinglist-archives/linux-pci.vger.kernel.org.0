Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83A5825AC0
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2019 01:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfEUXXN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 May 2019 19:23:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:10907 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbfEUXXN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 May 2019 19:23:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 May 2019 16:23:12 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 21 May 2019 16:23:11 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id CC8CA5803A5;
        Tue, 21 May 2019 16:23:11 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v2 2/5] PCI/ATS: Add PASID support for PCIe VF devices
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
References: <cover.1557162861.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <078b169334b4996d03d8608f205942c061590681.1557162861.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <b5f23aef-095a-3284-64a8-bb169cca4853@linux.intel.com>
Date:   Tue, 21 May 2019 16:21:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <078b169334b4996d03d8608f205942c061590681.1557162861.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

On 5/6/19 10:20 AM, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> When IOMMU tries to enable PASID for VF device in
> iommu_enable_dev_iotlb(), it always fails because PASID support for PCIe
> VF device is currently broken in PCIE driver. Current implementation
> expects the given PCIe device (PF & VF) to implement PASID capability
> before enabling the PASID support. But this assumption is incorrect. As
> per PCIe spec r4.0, sec 9.3.7.14, all VFs associated with PF can only
> use the PASID of the PF and not implement it.
>
> Since PASID is shared between PF/VF devices, following rules should
> apply.
>
> 1. Enable PASID in VF only if its already enabled in PF.

I need more eyes on how to interpret the spec for PF/VF PASID enable. As 
per PCIe spec r4.0. sec 9.3.7.14, PASID VF/PF dependency details are,

An Endpoint device is permitted to support PASID. The PASID 
configuration of the single function (Function or PF) representing the 
device is also used by all VFs in the device. A PF is permitted to 
implement the PASID capability, but VFs must not implement it. An 
Endpoint device is permitted to support PASID. The PASID configuration 
of the single function (Function or PF) representing the device is also 
used by all VFs in the device. A PF is permitted to implement the PASID 
capability, but VFs must not implement it.

Since it says that the VF uses PF configuration, I have interpreted it 
as "VF follows what ever we configure for PF and don't enable PASID in 
VF if its not enabled in PF" (otherwise it would require us modifying PF 
registers for VF use case). But I am not sure whether the my assumption 
is correct. In one of our testing, during IOMMU bind of VF device, PASID 
enable fails because associated PF device did not enable PASID. But I am 
sure whether we should expect PF PASID to be binded before VF.

So please let me know your comments.

> 2. Enable PASID in VF only if the requested features matches with PF
> config, otherwise return error.
> 3. When enabling/disabling PASID for VF, instead of configuring the PF
> registers just increase/decrease the usage count (pasid_ref_cnt).
> 4. Disable PASID in PF (configuring the registers) only if pasid_ref_cnt
> is zero.
> 5. When reading PASID features/settings for VF, use registers of
> corresponding PF.
>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Suggested-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>   drivers/pci/ats.c   | 55 ++++++++++++++++++++++++++++++++++++++++++++-
>   include/linux/pci.h |  1 +
>   2 files changed, 55 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 5582e5d83a3f..e7a904e347c3 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -345,6 +345,7 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
>   {
>   	u16 control, supported;
>   	int pos;
> +	struct pci_dev *pf;
>   
>   	if (WARN_ON(pdev->pasid_enabled))
>   		return -EBUSY;
> @@ -353,7 +354,33 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
>   		return -EINVAL;
>   
>   	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
> -	if (!pos)
> +
> +	if (pdev->is_virtfn) {
> +		/*
> +		 * Per PCIe r4.0, sec 9.3.7.14, VF must not implement
> +		 * Process Address Space ID (PASID) Capability.
> +		*/
> +		if (pos) {
> +			dev_err(&pdev->dev, "VF must not implement PASID\n");
> +			return -EINVAL
> +		}
> +		/* Since VF shares PASID with PF, use PF config */
> +		pf = pci_physfn(pdev);
> +
> +		/* If VF config does not match with PF, return error */
> +		if (!pf->pasid_enabled || pf->pasid_features != features)
> +			return -EINVAL;
> +
> +		pdev->pasid_features = features;
> +		pdev->pasid_enabled = 1;
> +
> +		/* Increment PF PASID refcount */
> +		atomic_inc(&pf->pasid_ref_cnt);
> +
> +		return 0;
> +	}
> +
> +	if (pdev->is_physfn && !pos)
>   		return -EINVAL;
>   
>   	pci_read_config_word(pdev, pos + PCI_PASID_CAP, &supported);
> @@ -382,10 +409,27 @@ void pci_disable_pasid(struct pci_dev *pdev)
>   {
>   	u16 control = 0;
>   	int pos;
> +	struct pci_dev *pf;
>   
>   	if (WARN_ON(!pdev->pasid_enabled))
>   		return;
>   
> +	/* All VFs PASID should be disabled before disabling PF PASID*/
> +	if (atomic_read(&pdev->pasid_ref_cnt))
> +		return;
> +
> +	if (pdev->is_virtfn) {
> +		/* Since VF shares PASID with PF, use PF config. */
> +		pf = pci_physfn(pdev);
> +
> +		/* Decrement PF PASID refcount */
> +		atomic_dec(&pf->pasid_ref_cnt);
> +
> +		pdev->pasid_enabled = 0;
> +
> +		return;
> +	}
> +
>   	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
>   	if (!pos)
>   		return;
> @@ -408,6 +452,9 @@ void pci_restore_pasid_state(struct pci_dev *pdev)
>   	if (!pdev->pasid_enabled)
>   		return;
>   
> +	if (pdev->is_virtfn)
> +		return;
> +
>   	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
>   	if (!pos)
>   		return;
> @@ -432,6 +479,9 @@ int pci_pasid_features(struct pci_dev *pdev)
>   	u16 supported;
>   	int pos;
>   
> +	if (pdev->is_virtfn)
> +		pdev = pci_physfn(pdev);
> +
>   	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
>   	if (!pos)
>   		return -EINVAL;
> @@ -488,6 +538,9 @@ int pci_max_pasids(struct pci_dev *pdev)
>   	u16 supported;
>   	int pos;
>   
> +	if (pdev->is_virtfn)
> +		pdev = pci_physfn(pdev);
> +
>   	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
>   	if (!pos)
>   		return -EINVAL;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 699c79c99a39..2a761ea63f8d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -454,6 +454,7 @@ struct pci_dev {
>   #endif
>   #ifdef CONFIG_PCI_PASID
>   	u16		pasid_features;
> +	atomic_t	pasid_ref_cnt;	/* Number of VFs with PASID enabled */
>   #endif
>   #ifdef CONFIG_PCI_P2PDMA
>   	struct pci_p2pdma *p2pdma;

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

