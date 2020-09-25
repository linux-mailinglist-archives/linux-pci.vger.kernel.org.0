Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5034277FCB
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 07:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgIYFLe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 01:11:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:52590 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbgIYFLe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Sep 2020 01:11:34 -0400
IronPort-SDR: z1zjwufh3XYBfnat5kGQYUt1z0EbJB/2iJ7loeOtwdRliM5twIKWPFVpXK/+1kW/BqZZDpKlt4
 EbMupY6bMvYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="179527374"
X-IronPort-AV: E=Sophos;i="5.77,300,1596524400"; 
   d="scan'208";a="179527374"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 22:11:34 -0700
IronPort-SDR: /nCpROfC3SgDLAmMaP0FrqslV94eDqiFjYLWqQsjHApa0D3EholJeYQUbW5ieHqSobsAPhnTh7
 nuDFo1hSnNsw==
X-IronPort-AV: E=Sophos;i="5.77,300,1596524400"; 
   d="scan'208";a="487301794"
Received: from eowgint-mobl.gar.corp.intel.com (HELO [10.254.87.250]) ([10.254.87.250])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 22:11:33 -0700
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
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <95e23cb5-f6e1-b121-0de8-a2066d507d9c@linux.intel.com>
Date:   Thu, 24 Sep 2020 22:11:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <aefd8842-90c4-836a-b43a-f21c5428d2ba@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/24/20 1:52 PM, Sinan Kaya wrote:
> On 9/24/2020 12:06 AM, Kuppuswamy, Sathyanarayanan wrote:
>> For problem description, please check the following details
>>
>> Current pcie_do_recovery() implementation has following two issues:
>>
>> 1. Fatal (DPC) error recovery is currently broken for non-hotplug
>> capable devices. Current fatal error recovery implementation relies
>> on PCIe hotplug (pciehp) handler for detaching and re-enumerating
>> the affected devices/drivers. pciehp handler listens for DLLSC state
>> changes and handles device/driver detachment on DLLSC_LINK_DOWN event
>> and re-enumeration on DLLSC_LINK_UP event. So when dealing with
>> non-hotplug capable devices, recovery code does not restore the state
>> of the affected devices correctly. Correct implementation should
>> restore the device state and call report_slot_reset() function after
>> resetting the link to restore the state of the device/driver.
>>
> 
> So, this is a matter of moving the save/restore logic from the hotplug
> driver into common code so that DPC slot reset takes advantage of it?
We are not moving it out of hotplug path. But fixing it in this code path.
With this fix, we will not depend on hotplug driver to restore the state.
> 
> If that's direction we are going, this is fine change IMO.
> 
>> You can find fatal non-hotplug related issues reported in following links:
>>
>> https://lore.kernel.org/linux-pci/20200527083130.4137-1-Zhiqiang.Hou@nxp.com/
>>
>> https://lore.kernel.org/linux-pci/12115.1588207324@famine/
>> https://lore.kernel.org/linux-pci/0e6f89cd6b9e4a72293cc90fafe93487d7c2d295.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>>
>>
>> 2. For non-fatal errors if report_error_detected() or
>> report_mmio_enabled() functions requests PCI_ERS_RESULT_NEED_RESET then
>> current pcie_do_recovery() implementation does not do the requested
>> explicit device reset, instead just calls the report_slot_reset() on all
>> affected devices. Notifying about the reset via report_slot_reset()
>> without doing the actual device reset is incorrect.
>>
> 
> This makes sens too. There seems to be an ordering issue per your
> description.
Yes
> 
>> To fix above issues, use PCI_ERS_RESULT_NEED_RESET as error state after
>> successful reset_link() operation. This will ensure ->slot_reset() be
>> called after reset_link() operation for fatal errors.
> 
> You lost me here. Why do we want to do secondary bus reset on top of
> DPC reset?
For non-hotplug capable slots, when reset (PCI_ERS_RESULT_NEED_RESET) is
requested, we want to reset it before calling ->slot_reset() callback.
> 
>> Also call
>> pci_bus_reset() to do slot/bus reset() before triggering device specific
>> ->slot_reset() callback. Also, using pci_bus_reset() will restore the state
>> of the devices after performing the reset operation.
>>
>> Even though using pci_bus_reset() will do redundant reset operation after
>> ->reset_link() for fatal errors, it should should affect the functional
>> behavior.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
