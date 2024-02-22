Return-Path: <linux-pci+bounces-3885-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEF4860346
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 20:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D7C41C22436
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 19:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B036AF86;
	Thu, 22 Feb 2024 19:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UU9jxoAm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AF914B83F;
	Thu, 22 Feb 2024 19:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708631667; cv=none; b=ZUOEOueM9LLSnd9956e6ZIYlj+J/ZfSqkiCZ2QiyS1eC7FTQtFfYR6JrUiD9P8unUE3Rv7MJYXeYBpTj/bJlSu1/MYnX/xQy8mXbJGuT1sd1EfgT+Pu1BdY9JMxYDxojIFwYhAQwlY5ag4I8EVyRvKQPqY/WM2IG/tUFVJEp1Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708631667; c=relaxed/simple;
	bh=lySDqcRVwaUR8G5CVeP0COuKUlFPQsre28mxBWvZRzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kf2k2/IcPH664sI9KglxHF6/j/VNmVBZ/gIkWDqvHUwiG1LxX50n9BCi8MHsyh33Jqi2IRffeEvcSpoVF569okhGsW9E7+AO+p9n1hR25qkq9U9Ymft4qaYL91NtFWHUcX0fUqDbQRgX1yrzu4CysEqLIb/2Ko9CNnNKu4oRvfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UU9jxoAm; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708631666; x=1740167666;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lySDqcRVwaUR8G5CVeP0COuKUlFPQsre28mxBWvZRzc=;
  b=UU9jxoAmuMAcxkYncJKMLev7nefc6xc0ec95mg/BumAAlJh0qbGcyKoT
   fqinm94u90fr2uleH+xIq11YkmNDFWMA62jXo6qLy+am/ESEZOu/p4PYK
   /G2AWeF62uxk0odM8ohRItcZBGVi5FJfxcUr3jnWaNG7vtGf/w0pgWWfY
   b9fB0KzBHIj4QXnM4EbjcR5Vwg2wo4XsfDXWhrU4TP/+2GQuFo53OqVYb
   GL+q2HzE2YylWJXwZ0RboRHfuLBoSnupJXG7kTBL4kWPzM6qTlRaWNdAE
   KED+bKqnPHDXsWcsTFuGtsLu5jaLpwodVX6awc/2Z/drB3JSjRVV+oxOU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3041910"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3041910"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 11:54:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5588126"
Received: from rdegger-desk1.amr.corp.intel.com (HELO [10.209.74.18]) ([10.209.74.18])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 11:54:25 -0800
Message-ID: <057c9a17-bbf2-49c5-b7ee-d3357d5b5100@linux.intel.com>
Date: Thu, 22 Feb 2024 11:54:24 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] PCI/ASPM: Update saved buffers with latest ASPM
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com, macro@orcam.me.uk,
 ajayagarwal@google.com, ilpo.jarvinen@linux.intel.com,
 david.e.box@linux.intel.com, hkallweit1@gmail.com, johan+linaro@kernel.org,
 xueshuai@linux.alibaba.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20240222185434.GA24540@bhelgaas>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240222185434.GA24540@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/22/24 10:54 AM, Bjorn Helgaas wrote:
> On Thu, Feb 22, 2024 at 10:20:06AM -0800, Kuppuswamy Sathyanarayanan wrote:
>> On 2/22/24 9:44 AM, Vidya Sagar wrote:
>>> Many PCIe device drivers save the configuration state of their respective
>>> devices during probe and restore the same when their 'slot_reset' hook
>>> is called through PCIe Error Recovery Handler.
>>>
>>> If the system has a change in ASPM policy after the driver's probe is
>>> called and before error event occurred, 'slot_reset' hook restores the
>>> PCIe configuration state to what it was at the time of probe but not to
>>> what it was just before the occurrence of the error event.
>>> This effectively leads to a mismatch in the ASPM configuration between
>>> the device and its upstream parent device.
>>>
>>> Update the saved configuration state of the device with the latest info
>>> whenever there is a change w.r.t ASPM policy.
>>>
>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>> ---
>>> V4:
>>> * Rebased on top of pci/aspm branch
>>>
>>> V3:
>>> * Addressed sathyanarayanan.kuppuswamy's review comments
>>>
>>> V2:
>>> * Rebased on top of the tree code
>>> * Addressed Bjorn's review comments
>>>
>>>  drivers/pci/pcie/aspm.c | 28 ++++++++++++++++++++++++++--
>>>  3 files changed, 28 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>> index cfc5b84dc9c9..3db606ba9344 100644
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -1648,7 +1648,7 @@ static int pci_save_pcie_state(struct pci_dev *dev)
>>>  	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &cap[i++]);
>>>  	pcie_capability_read_word(dev, PCI_EXP_SLTCTL2, &cap[i++]);
>>>  
>>> -	pci_save_aspm_state(dev);
>>> +	pci_save_aspm_l1ss_state(dev);
>>>  	pci_save_ltr_state(dev);
>>>  
>>>  	return 0;
>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>> index b217e74966eb..9fe78eb8b07d 100644
>>> --- a/drivers/pci/pci.h
>>> +++ b/drivers/pci/pci.h
>>> @@ -95,7 +95,7 @@ void pci_msix_init(struct pci_dev *dev);
>>>  bool pci_bridge_d3_possible(struct pci_dev *dev);
>>>  void pci_bridge_d3_update(struct pci_dev *dev);
>>>  void pci_aspm_get_l1ss(struct pci_dev *pdev);
>>> -void pci_save_aspm_state(struct pci_dev *pdev);
>>> +void pci_save_aspm_l1ss_state(struct pci_dev *pdev);
>> is this rename a review request? It is not clear from the commit log
>> why you are doing it?
> David's changes already on pci/aspm added pci_save_aspm_state(), but
> it actually only saves L1SS data, and Vidya needs to save the non-L1SS
> data also.
>
> I think I'm going to rework David's changes a little bit so this is
> named pci_save_aspm_l1ss_state() from the beginning so we won't need
> the rename here.

Got it.

Change wise, this patch looks fine to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>
> Bjorn

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


