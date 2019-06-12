Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C890442F3E
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2019 20:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfFLSnk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jun 2019 14:43:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:39216 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbfFLSnk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jun 2019 14:43:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 11:43:40 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jun 2019 11:43:39 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id D014E5803E4;
        Wed, 12 Jun 2019 11:43:39 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v2 1/1] PCI/IOV: Fix incorrect cfg_size for VF > 0
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        keith.busch@intel.com, mike.campin@intel.com
References: <20190612170647.43220-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190612121910.231368e2@x1.home>
From:   sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <0b21c76e-53f3-c35e-cebf-00719e451b11@linux.intel.com>
Date:   Wed, 12 Jun 2019 11:41:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190612121910.231368e2@x1.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 6/12/19 11:19 AM, Alex Williamson wrote:
> On Wed, 12 Jun 2019 10:06:47 -0700
> sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> Commit 975bb8b4dc93 ("PCI/IOV: Use VF0 cached config space size for
>> other VFs") calculates and caches the cfg_size for VF0 device before
>> initializing the pcie_cap of the device which results in using incorrect
>> cfg_size for all VF devices > 0. So set pcie_cap of the device before
>> calculating the cfg_size of VF0 device.
>>
>> Fixes: 975bb8b4dc93 ("PCI/IOV: Use VF0 cached config space size for
>> other VFs")
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Suggested-by: Mike Campin <mike.campin@intel.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>
>> Changes since v1:
>>   * Fixed a typo in commit message.
>>
>>   drivers/pci/iov.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>> index 3aa115ed3a65..2869011c0e35 100644
>> --- a/drivers/pci/iov.c
>> +++ b/drivers/pci/iov.c
>> @@ -160,6 +160,7 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>>   	virtfn->device = iov->vf_device;
>>   	virtfn->is_virtfn = 1;
>>   	virtfn->physfn = pci_dev_get(dev);
>> +	virtfn->pcie_cap = pci_find_capability(virtfn, PCI_CAP_ID_EXP);
>>   
>>   	if (id == 0)
>>   		pci_read_vf_config_common(virtfn);
> Why not re-order until after we've setup pcie_cap?
>
> https://lore.kernel.org/linux-pci/20190604143617.0a226555@x1.home/T/#

pci_read_vf_config_common() also caches values for properties like 
class, hdr_type, susbsystem_vendor/device. These values are read/used in 
pci_setup_device(). So if we can use cached values in 
pci_setup_device(), we don't have to read them from registers twice for 
each device.

>
> Thanks,
> Alex
>
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

