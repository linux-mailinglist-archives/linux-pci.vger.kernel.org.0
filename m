Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDC41969BA
	for <lists+linux-pci@lfdr.de>; Sat, 28 Mar 2020 23:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbgC1WEG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Mar 2020 18:04:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:53443 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727461AbgC1WEG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Mar 2020 18:04:06 -0400
IronPort-SDR: K5p7DTiQCKHtU/L8rWMPTC8jFZrDxLKdQ6QHlUD6M36fwx0OerqxBlVkI7qXI5X29+dzJILF0J
 8jpcD91W9rwQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2020 15:04:05 -0700
IronPort-SDR: izN4+8b4S/AEaALwxroq9hJE9KbskAnvb7Ow3KEGkDzQxNgFve1NspxEgLy2LAmiI4XzKAUvsC
 fazewe774ZoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,317,1580803200"; 
   d="scan'208";a="447824669"
Received: from ssafrin-mobl.ger.corp.intel.com (HELO [10.255.229.125]) ([10.255.229.125])
  by fmsmga005.fm.intel.com with ESMTP; 28 Mar 2020 15:04:05 -0700
Subject: Re: [PATCH v18 03/11] PCI/DPC: Fix DPC recovery issue in non hotplug
 case
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
References: <20200328171007.GA49779@google.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <181a0c8c-0773-77d1-cbb5-ba01fb01c14f@linux.intel.com>
Date:   Sat, 28 Mar 2020 15:04:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200328171007.GA49779@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 3/28/20 10:10 AM, Bjorn Helgaas wrote:
> On Tue, Mar 24, 2020 at 06:17:44PM -0700, Kuppuswamy, Sathyanarayanan wrote:
>> On 3/24/20 4:49 PM, Bjorn Helgaas wrote:
>>> I don't understand why hotplug is relevant here.  This path
>>> (dpc_reset_link()) is only used for downstream ports that support DPC.
>>> DPC has already disabled the link, which resets everything below the
>>> port, regardless of whether the port supports hotplug.
>>>
>>> I do see that PCI_ERS_RESULT_NEED_RESET seems to promise a lot more
>>> than it actually *does*.  The doc (pci-error-recovery.rst) says
>>> .error_detected() can return PCI_ERS_RESULT_NEED_RESET to *request* a
>>> slot reset.  But if that happens, pcie_do_recovery() doesn't do a
>>> reset at all.  It calls the driver's .slot_reset() method, which tells
>>> the driver "we've reset your device; please re-initialize the
>>> hardware."
>>>
>>> I guess this abuses PCI_ERS_RESULT_NEED_RESET by taking advantage of
>>> that implementation deficiency in pcie_do_recovery(): we know the
>>> downstream devices have already been reset via DPC, and returning
>>> PCI_ERS_RESULT_NEED_RESET means we'll call .slot_reset() to tell the
>>> driver about that reset.
>>>
>>> I can see how this achieves the desired result, but if/when we fix
>>> pcie_do_recovery() to actually *do* the reset promised by
>>> PCI_ERS_RESULT_NEED_RESET, we will be doing *two* resets: the first
>>> via DPC and a second via whatever slot reset mechanism
>>> pcie_do_recovery() would use.
>>
>> When we fix this issue, if we make sure the reset logic is
>> implemented before we call .reset_link callback we should be
>> able to avoid resetting the device twice. Before we call DPC
>> .reset_link callback, the device link will not up and hence we
>> should not able to reset it.
>>
>>> So I guess the real issue (as you allude to in the commit log) is that
>>> we rely on hotplug to unbind/rebind the driver, and without hotplug we
>>> need to at least tell the driver the device was reset.
>>
>> Agree
>>
>>> I'll try to expand the comment here so it reminds me what's going on
>>> when we have to look at this again:)   Let me know if I'm on the right
>>> track.
>>
>> Yes, your understanding is correct.
> 
> OK, thanks.  I'm still uncomfortable with this issue, so I think I'm
> going to apply this series but omit this patch.  Here's why:
> 
> 1) The fact that resets may cause hotplug events isn't specific to
> DPC, so I don't think dpc_reset_link() is the right place.  For
> instance, aer_root_reset() ultimately does a secondary bus reset. 
Agree. Reset is common for pci_channel_io_frozen errors. I did not
look into aer_root_reset() implementation. So if state
is pci_channel_io_frozen then we can assume the slot has been
reseted.
  The
> pci_slot_reset() -> pciehp_reset_slot() path goes to some trouble to
> ignore the resulting hotplug event, but the pci_bus_reset() path does
> not.
> 
> 2) I'm not convinced that "hotplug_is_native()" is the correct test.
> Even if we're using ACPI hotplug (acpiphp), that will detach the
> drivers and remove the devices, won't it?
Yes, agreed. It does not handle ACPI hotplug case. In case of
ACPI hotplug, native_pcie_hotplug = 0. May be we need a new helper
function. hotplug_is_enabled() ?
> 
> I considered something like the patch below, which partly addresses my
> first concern, but not the second.  Even the first one is awfully
> messy because of the different ways the aer_root_reset() path can
> work.
> 
> 
> PCI/ERR: Skip driver callbacks if reset causes hotplug remove/add
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 1ac57e9e1e71..000551a06013 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -208,6 +208,18 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
>   		status = reset_link(dev, service);
>   		if (status != PCI_ERS_RESULT_RECOVERED)
>   			goto failed;
> +
> +		/*
> +		 * If pdev supports hotplug, a link reset causes a hotplug
> +		 * remove event.  If we have a hotplug driver, it will
> +		 * detach all drivers of downstream devices and remove the
> +		 * devices, so we can't call any driver error recovery
> +		 * callbacks.  Bringing the link back up causes a hotplug
> +		 * add event, and the devices should be re-enumerated and
> +		 * the drivers re-attached.
> +		 */
> +		if (hotplug_is_native(pdev))
> +			goto succeeded;
>   	} else {
>   		pci_walk_bus(bus, report_normal_detected, &status);
>   	}
> @@ -224,7 +236,11 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
>   		 * functions to reset slot before calling
>   		 * drivers' slot_reset callbacks?
>   		 */
> +		pci_warn(pdev, "driver requested reset, but that's not implemented\n");
>   		status = PCI_ERS_RESULT_RECOVERED;
> +	}
> +
> +	if (status == PCI_ERS_RESULT_RECOVERED) {
Moving it outside status == PCI_ERS_NEED_RESET check will let it execute
in non frozen error as well. IIUC, we should not call it on all error
types. Let me know your comments.
>   		pci_dbg(dev, "broadcast slot_reset message\n");
>   		pci_walk_bus(bus, report_slot_reset, &status);
>   	}
> @@ -235,6 +251,7 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
>   	pci_dbg(dev, "broadcast resume message\n");
>   	pci_walk_bus(bus, report_resume, &status);
>   
> +succeeded:
>   	pci_aer_clear_device_status(dev);
>   	pci_cleanup_aer_uncorrect_error_status(dev);
>   	pci_info(dev, "device recovery successful\n");
> 
