Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F3E276781
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 06:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgIXEGF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 00:06:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:1793 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgIXEGF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Sep 2020 00:06:05 -0400
IronPort-SDR: YPZAqsJ9FuUwt5BasewU/KjFjsMOKv5hXl6drtc1Jo+7WCM/SAsK3SuPS9XMsA/hC+ruSFrEH2
 yUqDB0Q0XBVQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="148742977"
X-IronPort-AV: E=Sophos;i="5.77,296,1596524400"; 
   d="scan'208";a="148742977"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 21:06:04 -0700
IronPort-SDR: lCB7twMKEy7YoLxAl1iGlDk04HMidEkWq+sreiWlLZaGvJnMXn503NT6308WSABhaEwtzNtxy+
 dwk/HuFUWwhg==
X-IronPort-AV: E=Sophos;i="5.77,296,1596524400"; 
   d="scan'208";a="382903886"
Received: from jdelagui-mobl.amr.corp.intel.com (HELO [10.255.231.15]) ([10.255.231.15])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 21:06:04 -0700
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
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <a647f485-8db4-db45-f404-940b55117b53@linux.intel.com>
Date:   Wed, 23 Sep 2020 21:06:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <aef0b9aa-59f5-9ec3-adac-5bc366b362e0@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/23/20 8:13 PM, Sinan Kaya wrote:
> On 9/23/2020 10:51 PM, Kuppuswamy, Sathyanarayanan wrote:
>>>
>>> I see. Can I assume that your system supports DPC?
>>> DPC is supposed to recover the link via dpc_reset_link().
>> Yes. But the affected device/drivers cleanup during error recovery
>> is handled by hotplug handler. So we are facing issue when dealing
>> with non hotplug capable ports.
> 
> This is confusing.
> 
> Why would hotplug driver be involved unless port supports hotplug and
> the link goes down? You said that DLLSC is only supported on hotplug
> capable ports.
hotplug driver is *only* involved when dealing with recovery of hotplug
capable ports. For hotplug capable ports, when DPC is triggered and link
goes down, DLLSC handler in pciehp driver will remove the affected
devices/drivers. Once the link comes back it will re-attach them.

> 
> Need a better description of symptoms and what triggers hotplug driver
> to activate.
For problem description, please check the following details

Current pcie_do_recovery() implementation has following two issues:

1. Fatal (DPC) error recovery is currently broken for non-hotplug
capable devices. Current fatal error recovery implementation relies
on PCIe hotplug (pciehp) handler for detaching and re-enumerating
the affected devices/drivers. pciehp handler listens for DLLSC state
changes and handles device/driver detachment on DLLSC_LINK_DOWN event
and re-enumeration on DLLSC_LINK_UP event. So when dealing with
non-hotplug capable devices, recovery code does not restore the state
of the affected devices correctly. Correct implementation should
restore the device state and call report_slot_reset() function after
resetting the link to restore the state of the device/driver.

You can find fatal non-hotplug related issues reported in following links:

https://lore.kernel.org/linux-pci/20200527083130.4137-1-Zhiqiang.Hou@nxp.com/
https://lore.kernel.org/linux-pci/12115.1588207324@famine/
https://lore.kernel.org/linux-pci/0e6f89cd6b9e4a72293cc90fafe93487d7c2d295.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com/

2. For non-fatal errors if report_error_detected() or
report_mmio_enabled() functions requests PCI_ERS_RESULT_NEED_RESET then
current pcie_do_recovery() implementation does not do the requested
explicit device reset, instead just calls the report_slot_reset() on all
affected devices. Notifying about the reset via report_slot_reset()
without doing the actual device reset is incorrect.

To fix above issues, use PCI_ERS_RESULT_NEED_RESET as error state after
successful reset_link() operation. This will ensure ->slot_reset() be
called after reset_link() operation for fatal errors. Also call
pci_bus_reset() to do slot/bus reset() before triggering device specific
->slot_reset() callback. Also, using pci_bus_reset() will restore the state
of the devices after performing the reset operation.

Even though using pci_bus_reset() will do redundant reset operation after
->reset_link() for fatal errors, it should should affect the functional
behavior.

> 
> Can you expand this a little bit?
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
