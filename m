Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 360B61969DC
	for <lists+linux-pci@lfdr.de>; Sat, 28 Mar 2020 23:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgC1WkZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Mar 2020 18:40:25 -0400
Received: from mga05.intel.com ([192.55.52.43]:28826 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727737AbgC1WkZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Mar 2020 18:40:25 -0400
IronPort-SDR: NWJ5JxbmEykzMLfV6hRa4gMXdKuOqe4iD7eTengiiKXwEoVN415ppYeIAk++Db9rU6q6tMqys9
 jm0VqboEN7cQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2020 15:40:24 -0700
IronPort-SDR: JPpyxVS1t/VJvBHHFPlmvo87pu9QHSkNMQIScJL0nbw9KeTl7VDQZBpFH0JmzHhn9cAFpDuf1D
 TSJOSGo2/IIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,318,1580803200"; 
   d="scan'208";a="447830562"
Received: from ssafrin-mobl.ger.corp.intel.com (HELO [10.255.229.125]) ([10.255.229.125])
  by fmsmga005.fm.intel.com with ESMTP; 28 Mar 2020 15:40:24 -0700
Subject: Re: [PATCH v18 03/11] PCI/DPC: Fix DPC recovery issue in non hotplug
 case
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
References: <20200328222111.GA136384@google.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <621ef46b-3556-e667-3982-16f3c908a793@linux.intel.com>
Date:   Sat, 28 Mar 2020 15:40:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200328222111.GA136384@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/28/20 3:21 PM, Bjorn Helgaas wrote:
>>> OK, thanks.  I'm still uncomfortable with this issue, so I think I'm
>>> going to apply this series but omit this patch.  Here's why:
>>>
>>> 1) The fact that resets may cause hotplug events isn't specific to
>>> DPC, so I don't think dpc_reset_link() is the right place.  For
>>> instance, aer_root_reset() ultimately does a secondary bus reset.
>> Agree. Reset is common for pci_channel_io_frozen errors. I did not
>> look into aer_root_reset() implementation. So if state
>> is pci_channel_io_frozen then we can assume the slot has been
>> reseted.
>>   The
>>> pci_slot_reset() -> pciehp_reset_slot() path goes to some trouble to
>>> ignore the resulting hotplug event, but the pci_bus_reset() path does
>>> not.
>>>
>>> 2) I'm not convinced that "hotplug_is_native()" is the correct test.
>>> Even if we're using ACPI hotplug (acpiphp), that will detach the
>>> drivers and remove the devices, won't it?
>> Yes, agreed. It does not handle ACPI hotplug case. In case of
>> ACPI hotplug, native_pcie_hotplug = 0. May be we need a new helper
>> function. hotplug_is_enabled() ?
> I'm not proposing the patch below to be applied.  I only included it
> as an idea of where the hotplug testing should be.
> 
> I'm proposing to merge the pci/edr branch as-is, without these two
> patches:
> 
>    PCI: move {pciehp,shpchp}_is_native() definitions to pci.c
>    PCI/DPC: Fix DPC recovery issue in non hotplug case
> 
> accepting that we still have some issues in the non-hotplug case that
> we can fix later.
Ok. I am fine with it. Thanks for working on it.
> 
