Return-Path: <linux-pci+bounces-31268-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD07AF5A72
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 16:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446D2485022
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 14:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3445275AFF;
	Wed,  2 Jul 2025 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nDIzrr6W"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD089275AE8;
	Wed,  2 Jul 2025 14:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751465045; cv=none; b=MVEULCZZW3sTSEgiI7h0t//ZwsTpvvL5QuKnFCFGZDmjh9uDfUJbeyEVqYN9kx6zDlPx0BPZD/4HfgzL1k8hFOMNN57GxWaiGUCe/3rErR+ml+kVy7ptFBIzaYLFCC9E0sVowQljlsqlIZh0DiRhFis4RLUc8pzpF/Qto14kolo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751465045; c=relaxed/simple;
	bh=0MhlDQpiMGUkq4C8swXflDQe3D138a9T5O+UEquFdkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvVC4F8sjvcL2Q8C61l8N6l/QZI1dcX3Nbq61p/EC6xzGosyXDz0h5JsPaH7yEbknH934J0ch8OuVpye2VMgo6FbdqJ7/QVxUazAmGUwZZpj3YsojAkddXEJnQUg9E7G4MNsVQdIC6KLKC+6pT9xS6l6m0EapOPj+T3hIbGoOrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nDIzrr6W; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751465044; x=1783001044;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0MhlDQpiMGUkq4C8swXflDQe3D138a9T5O+UEquFdkM=;
  b=nDIzrr6WZ3yNs8YSjJD27PBeIwo/OTbVW2EjltVGR9c+abfrU+A6GgDc
   ryOZW7TOS9UBFK+upk2PLG1POb5iW8RNYpG71mDPEvHVAf/NLy2atFiAr
   8+Ahas6eddAfFDXQ7SUu2+CeoaJc4BeRnH31Pq3LdzSmyKZjNFB+rCwNj
   t0I4Ql806qtm2RZJGbgnQf2PgDLVBn4bgt/inQJVTZ2EiG5t15yX/sDai
   iF++aorK6SVESwqXauNGBt0mn9v0ZsAU9AA5N6STZKl9SUEfZVHpRl3Os
   nq4Faw+B4AmA0urlkjv8gsKSJrgeIvqrEIfkooQnSXo+7DThhUhoAkUSQ
   w==;
X-CSE-ConnectionGUID: 7EjI6esURQiEE4e5/zaxXw==
X-CSE-MsgGUID: jnW5S1bDSDOlNvhTC8TSWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="64007800"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="64007800"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 07:04:01 -0700
X-CSE-ConnectionGUID: RIKC5saoTcWylZFYvMd+Sw==
X-CSE-MsgGUID: 2OiPCNNORn+h4W0DRD7rSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="154430767"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 07:04:00 -0700
Received: from [10.124.222.214] (unknown [10.124.222.214])
	by linux.intel.com (Postfix) with ESMTP id EE48920B58A2;
	Wed,  2 Jul 2025 07:03:58 -0700 (PDT)
Message-ID: <83851fe3-58e4-41a0-b7cd-daee2d8d69aa@linux.intel.com>
Date: Wed, 2 Jul 2025 07:03:58 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/11] PCI/ACPI: Per root port allow one Aux power
 limit request
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Badal Nilawar <badal.nilawar@intel.com>, intel-xe@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
 anshuman.gupta@intel.com, lenb@kernel.org, bhelgaas@google.com,
 ilpo.jarvinen@linux.intel.com, lucas.demarchi@intel.com,
 rodrigo.vivi@intel.com, varun.gupta@intel.com,
 ville.syrjala@linux.intel.com, uma.shankar@intel.com
References: <20250529111654.3140766-1-badal.nilawar@intel.com>
 <20250529111654.3140766-3-badal.nilawar@intel.com>
 <98fc8402-0bda-4333-8407-75c7a6472375@linux.intel.com>
 <CAJZ5v0hm_UyEEXz+1LYGwGXNi908vYgKw0CD3C=wmBvT=vAh0Q@mail.gmail.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <CAJZ5v0hm_UyEEXz+1LYGwGXNi908vYgKw0CD3C=wmBvT=vAh0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/2/25 4:11 AM, Rafael J. Wysocki wrote:
> On Thu, May 29, 2025 at 11:41 PM Sathyanarayanan Kuppuswamy
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>
>> On 5/29/25 4:16 AM, Badal Nilawar wrote:
>>> For given root port allow one Aux power limit request.
>>>
>>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> Cc: Anshuman Gupta <anshuman.gupta@intel.com>
>>> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
>>> ---
>>>    drivers/acpi/scan.c     |  1 +
>>>    drivers/pci/pci-acpi.c  | 25 ++++++++++++++++++++++++-
>>>    include/acpi/acpi_bus.h |  2 ++
>>>    3 files changed, 27 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>>> index fb1fe9f3b1a3..9ae7be9db01a 100644
>>> --- a/drivers/acpi/scan.c
>>> +++ b/drivers/acpi/scan.c
>>> @@ -745,6 +745,7 @@ int acpi_device_add(struct acpi_device *device)
>>>        INIT_LIST_HEAD(&device->physical_node_list);
>>>        INIT_LIST_HEAD(&device->del_list);
>>>        mutex_init(&device->physical_node_lock);
>>> +     mutex_init(&device->power.aux_pwr_lock);
>>>
>>>        mutex_lock(&acpi_device_lock);
>>>
>>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>>> index 87f30910a5f1..d33efba4ca94 100644
>>> --- a/drivers/pci/pci-acpi.c
>>> +++ b/drivers/pci/pci-acpi.c
>>> @@ -1451,6 +1451,7 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
>>>        union acpi_object *out_obj;
>>>        acpi_handle handle;
>>>        int result, ret = -EINVAL;
>>> +     struct acpi_device *adev;
>>>
>>>        if (!dev || !retry_interval)
>>>                return -EINVAL;
>>> @@ -1464,11 +1465,27 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
>>>                return -ENODEV;
>>>        }
>>>
>>> +     adev = ACPI_COMPANION(&dev->dev);
>>> +     if (!adev)
>>> +             return -EINVAL;
>>> +
>>> +     mutex_lock(&adev->power.aux_pwr_lock);
>>> +
>>> +     /* Check if aux power already granted */
>>> +     if (adev->power.aux_power_limit) {
>>> +             pci_info(dev, "D3cold Aux Power request already granted: %u mW\n",
>>> +                      adev->power.aux_power_limit);
>>> +             mutex_unlock(&adev->power.aux_pwr_lock);
>>> +             return -EPERM;
>>> +     }
>>> +
>>>        out_obj = acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 4,
>>>                                          DSM_PCI_D3COLD_AUX_POWER_LIMIT,
>>>                                          &in_obj, ACPI_TYPE_INTEGER);
>>> -     if (!out_obj)
>>> +     if (!out_obj) {
>>> +             mutex_unlock(&adev->power.aux_pwr_lock);
>>>                return -EINVAL;
>>> +     }
>>>
>>>        result = out_obj->integer.value;
>>>        if (retry_interval)
>>> @@ -1478,14 +1495,17 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
>>>        case 0x0:
>>>                pci_dbg(dev, "D3cold Aux Power %u mW request denied\n",
>>>                        requested_power);
>>> +             adev->power.aux_power_limit = 0;
>>>                break;
>>>        case 0x1:
>>>                pci_info(dev, "D3cold Aux Power request granted: %u mW\n",
>>>                         requested_power);
>>> +             adev->power.aux_power_limit = requested_power;
>>>                ret = 0;
>>>                break;
>>>        case 0x2:
>>>                pci_info(dev, "D3cold Aux Power: Main power won't be removed\n");
>>> +             adev->power.aux_power_limit = 0;
>>>                ret = -EBUSY;
>>>                break;
>>>        default:
>>> @@ -1500,9 +1520,12 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
>>>                        pci_err(dev, "D3cold Aux Power: Reserved or unsupported response: 0x%x\n",
>>>                                result);
>>>                }
>>> +             adev->power.aux_power_limit = 0;
>>>                break;
>>>        }
>>>
>>> +     mutex_unlock(&adev->power.aux_pwr_lock);
>>> +
>>>        ACPI_FREE(out_obj);
>>>        return ret;
>>>    }
>>> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
>>> index aad1a95e6863..c4ce3d84be00 100644
>>> --- a/include/acpi/acpi_bus.h
>>> +++ b/include/acpi/acpi_bus.h
>>> @@ -294,6 +294,8 @@ struct acpi_device_power {
>>>        struct acpi_device_power_flags flags;
>>>        struct acpi_device_power_state states[ACPI_D_STATE_COUNT];      /* Power states (D0-D3Cold) */
>>>        u8 state_for_enumeration; /* Deepest power state for enumeration */
>>> +     u32 aux_power_limit;            /* aux power limit granted by bios */
>>> +     struct mutex aux_pwr_lock;      /* prevent concurrent aux power limit requests */
>>
>> Do you need a new lock ?
> Yes.
>
>> Is it possible to reuse existing mutex like device_lock()?
> No.
>
> Doing such things results in code where nobody knows what the given
> lock scope is.

Got it. Thanks for the clarification.


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


