Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2D82651BE
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 23:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgIJVBR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 17:01:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:22318 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbgIJVA1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Sep 2020 17:00:27 -0400
IronPort-SDR: iKpigk4c9iyTCQTW8pVLunAf0bqUFrzNbbeH2VLJAC0jRrhNXHmex7ijWHS6osXsomesbze/AD
 /eyxGoy3NxMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="176695887"
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; 
   d="scan'208";a="176695887"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 14:00:21 -0700
IronPort-SDR: tdlYxdjh/7WkCMR3CoT2zUlwckWJnEPQIMRF2Db0GxWi/0KrJI/nyeSqnoEBgg0/vLhjfogbzL
 08HyLMKIgKUg==
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; 
   d="scan'208";a="329497302"
Received: from spkincai-mobl.amr.corp.intel.com (HELO [10.254.127.63]) ([10.254.127.63])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 14:00:20 -0700
Subject: Re: [PATCH v8 1/5] PCI: Conditionally initialize host bridge native_*
 members
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
References: <20200910194901.GA808976@bjorn-Precision-5520>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <f1655ddf-35dc-424e-1df4-f3821ab7500e@linux.intel.com>
Date:   Thu, 10 Sep 2020 14:00:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200910194901.GA808976@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/10/20 12:49 PM, Bjorn Helgaas wrote:
> On Fri, Jul 24, 2020 at 08:58:52PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> If CONFIG_PCIEPORTBUS is not enabled in kernel then initialing
>> struct pci_host_bridge PCIe specific native_* members to "1" is
>> incorrect. So protect the PCIe specific member initialization
>> with CONFIG_PCIEPORTBUS.
> 
> s/initialing/initializing/
will fix it in next version.
> 
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>   drivers/pci/probe.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 2f66988cea25..a94b97564ceb 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -588,12 +588,14 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>>   	 * may implement its own AER handling and use _OSC to prevent the
>>   	 * OS from interfering.
>>   	 */
>> +#ifdef CONFIG_PCIEPORTBUS
>>   	bridge->native_aer = 1;
>>   	bridge->native_pcie_hotplug = 1;
>> -	bridge->native_shpc_hotplug = 1;
>>   	bridge->native_pme = 1;
>>   	bridge->native_ltr = 1;
> 
> native_ltr isn't dependent on PCIEPORTBUS either, is it?  It's only
> used for ASPM.
Agreed. I was confused due to a comment in include/linux/pci.h

  unsigned int    native_ltr:1;           /* OS may use PCIe LTR */

> 
>>   	bridge->native_dpc = 1;
>> +#endif
>> +	bridge->native_shpc_hotplug = 1;
>>   
>>   	device_initialize(&bridge->dev);
>>   }
>> -- 
>> 2.17.1
>>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
