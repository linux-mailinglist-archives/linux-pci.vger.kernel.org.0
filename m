Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101D527B2E4
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 19:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgI1RPt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 13:15:49 -0400
Received: from mga12.intel.com ([192.55.52.136]:55832 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbgI1RPt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Sep 2020 13:15:49 -0400
IronPort-SDR: tb41lbWrRFpG9ZRUAg6PYHWfEiQHilozQl4n4L5M1NinCHYvL0jm4ozlCnqMrUhoAwwEKZgJRH
 k67+wz6md/GA==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="141437653"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="141437653"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 10:15:47 -0700
IronPort-SDR: pUE4d4kRrN3n0sQhOro+Fv/Fo8sWe/Ulj1lzc9aUQqNIpzH5jDcjFd/8S27J26RmlOBX/b7y/3
 NuyX3c10hmUw==
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="307410544"
Received: from sethura1-mobl2.amr.corp.intel.com (HELO [10.254.88.203]) ([10.254.88.203])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 10:15:47 -0700
Subject: Re: [PATCH v3 1/1] PCI/ERR: Fix reset logic in pcie_do_recovery()
 call
To:     Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        Jay Vosburgh <jay.vosburgh@canonical.com>
References: <20200922233333.GA2239404@bjorn-Precision-5520>
 <704c39bf-6f0c-bba3-70b8-91de6a445e43@linux.intel.com>
 <3d27d0a4-2115-fa72-8990-a84910e4215f@kernel.org>
 <d5aa53dc-0c94-e57a-689a-1c1f89787af1@linux.intel.com>
 <526dc846-b12b-3523-4995-966eb972ceb7@kernel.org>
 <1fdcc4a6-53b7-2b5f-8496-f0f09405f561@linux.intel.com>
 <aef0b9aa-59f5-9ec3-adac-5bc366b362e0@kernel.org>
 <a647f485-8db4-db45-f404-940b55117b53@linux.intel.com>
 <aefd8842-90c4-836a-b43a-f21c5428d2ba@kernel.org>
 <95e23cb5-f6e1-b121-0de8-a2066d507d9c@linux.intel.com>
 <65238d0b-0a39-400a-3a18-4f68eb554538@kernel.org>
 <4ae86061-2182-bcf1-ebd7-485acf2d47b9@linux.intel.com>
 <f360165e-5f73-057c-efd1-557b5e5027eb@kernel.org>
 <8beca800-ffb5-c535-6d43-7e750cbf06d0@linux.intel.com>
 <44f0cac5-8deb-1169-eb6d-93ac4889fe7e@kernel.org>
 <3bc0fd23-8ddd-32c5-1dd9-4d5209ea68c3@linux.intel.com>
 <a2bbdfed-fb17-51dc-8ae4-55d924c13211@kernel.org>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <8a3aeb3c-83c4-8626-601d-360946d55dd8@linux.intel.com>
Date:   Mon, 28 Sep 2020 10:15:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a2bbdfed-fb17-51dc-8ae4-55d924c13211@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/28/20 4:17 AM, Sinan Kaya wrote:
> On 9/27/2020 10:43 PM, Kuppuswamy, Sathyanarayanan wrote:
>> FATAL + no-hotplug - In this case, link will still be reseted. But
>> currently driver state is not properly restored. So I attempted
>> to restore it using pci_reset_bus().
>>
>>           status = reset_link(dev);
>> -        if (status != PCI_ERS_RESULT_RECOVERED) {
>> +        if (status == PCI_ERS_RESULT_RECOVERED) {
>> +            status = PCI_ERS_RESULT_NEED_RESET;
>>
>> ...
>>
>>       if (status == PCI_ERS_RESULT_NEED_RESET) {
>>           /*
>> -         * TODO: Should call platform-specific
>> -         * functions to reset slot before calling
>> -         * drivers' slot_reset callbacks?
>> +         * TODO: Optimize the call to pci_reset_bus()
>> +         *
>> +         * There are two components to pci_reset_bus().
>> +         *
>> +         * 1. Do platform specific slot/bus reset.
>> +         * 2. Save/Restore all devices in the bus.
>> +         *
>> +         * For hotplug capable devices and fatal errors,
>> +         * device is already in reset state due to link
>> +         * reset. So repeating platform specific slot/bus
>> +         * reset via pci_reset_bus() call is redundant. So
>> +         * can optimize this logic and conditionally call
>> +         * pci_reset_bus().
>>            */
>> +        pci_reset_bus(dev);
> 
> I think we have to go to remove/rescan for this case as you also
> mentioned above. There is no state to save. All BAR assignments
> are gone. Entire device programming is also lost.
> 
> I don't think pci_reset_bus() can recover from this situation safely.
> It will make things worse by saving/restoring the hardware default
> state.
> 
> This should remove/rescan logic should be inside DPC's slot_reset()
> function BTW. Not here.
Since there is no state restoration for FATAL errors, I am wondering whether
calls to ->error_detected(), ->mmio_enabled() and ->slot_reset() are
required?

Let me know your comments about following pseudo code.

if (fatal error & hotplug_supported)
    do nothing // if fatal triggered by DPC, clear DPC state.

if (fatal error & no-hotplug)
   perform slot_reset and renumerate affected devices.

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
