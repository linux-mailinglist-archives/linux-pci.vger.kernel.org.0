Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB18584023
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jul 2022 15:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiG1NiO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jul 2022 09:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiG1NiI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jul 2022 09:38:08 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB8A54673;
        Thu, 28 Jul 2022 06:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659015487; x=1690551487;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L2FRLYaTBI7F5ftQ6oi1R3XDVtj/kTzSoGnS9O2fMz0=;
  b=NLgoZx2G4Pih9yiocwB+cazIVanC/HY/T2YOajpVQaqKa75pbmiov6iT
   Y3mH3uehpVQn9bkmoohuJPVolJmW9cqkG89Im4XWpsjdFPJICUMHeBJ9R
   dc6Jd3ZLGaZJCTZGGICwjvHR8XJrCeMjS9y+p/MXnXgq2QWLeIDF62WfY
   1gtggE3hz+weiA4CJ3XixVvu7yLPibAXxSK61lgdfuKq2hSloHUfnNFu4
   n7kXGzRq0KX7r4dlh2g27itjedXTJKy8jvJ24YwlEnxFyZ0c4e+ev14XZ
   nCX4jvnE2qxgwUpJAhbpHOcQFTi9k4P3xKuMnb9UyX5iBB4VTWiAHKWx4
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="275394349"
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="275394349"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 06:38:06 -0700
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="690318074"
Received: from hurleyst-mobl.amr.corp.intel.com (HELO [10.209.106.108]) ([10.209.106.108])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 06:38:06 -0700
Message-ID: <b841ef44-98f4-fddd-def9-963172a0c4f5@linux.intel.com>
Date:   Thu, 28 Jul 2022 06:38:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [External] Re: [PATCH v1] PCI/DPC: Skip EDR init when BIOS
 disable OS native DPC
Content-Language: en-US
To:     Xiaochun XC17 Li <lixc17@lenovo.com>,
        Xiaochun Lee <lixiaochun.2888@163.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1658919957-53006-1-git-send-email-lixiaochun.2888@163.com>
 <3dc43f00-0b01-1b02-74dc-6938f6db6e29@linux.intel.com>
 <TY2PR03MB45574010689A675444CCFA98BC969@TY2PR03MB4557.apcprd03.prod.outlook.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <TY2PR03MB45574010689A675444CCFA98BC969@TY2PR03MB4557.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/28/22 3:11 AM, Xiaochun XC17 Li wrote:
> Hi, 
>> -----Original Message-----
>> From: Sathyanarayanan Kuppuswamy
>> <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Sent: Wednesday, July 27, 2022 10:24 PM
>> To: Xiaochun Lee <lixiaochun.2888@163.com>; linux-pci@vger.kernel.org
>> Cc: bhelgaas@google.com; linux-kernel@vger.kernel.org; Xiaochun XC17 Li
>> <lixc17@lenovo.com>
>> Subject: [External] Re: [PATCH v1] PCI/DPC: Skip EDR init when BIOS disable
>> OS native DPC
>>
>> Hi,
>>
>> On 7/27/22 4:05 AM, Xiaochun Lee wrote:
>>> From: Xiaochun Lee <lixc17@lenovo.com>
>>>
>>> ACPI BIOS may disable OS native AER and DPC support to notify OS that
>>> our platform doesn't support AER and DPC via the _OSC method.
>>> BIOS also might leave the containment be accomplished purely in HW.
>>> When firmware is set to non-aware OS DPC, we skip to install EDR
>>> handler to an ACPI device.
>>
>> No, EDR is used when firmware controls the DPC.
>>
>> When the Firmware owns Downstream Port Containment, it is expected to
>> use the new “Error Disconnect Recover” notification to alert OSPM of a
>> Downstream Port Containment event.
> 
> Thank you for correcting me on that. Could you please share more information
> about the below questions? Many thanks!
> As you mentioned, when Firmware is set to the platform not to support
> OS native DPC,  should OS still have to handle DPC flow from an EDR event?

During OSC negotiation, OS will advertise its support for EDR, if it
is available. If DPC is owned by firmware, then it can leverage the
EDR support, to let OS handle the error recovery.

> In my systems, when I disable native DPC in UEFI BIOS, kernel messages
> show the "platform does not support [SHPCHotplug AER DPC]" as follows,
> and it says OS now controls capabilities that do not include AER DPC.
> 
> [    2.400996] acpi PNP0A08:04: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
> [    2.402227] acpi PNP0A08:04: _OSC: platform does not support [SHPCHotplug AER DPC]
> [    2.402520] acpi PNP0A08:04: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> [    2.402521] acpi PNP0A08:04: FADT indicates ASPM is unsupported, using BIOS configuration
> 
> After I injected a PCIE CTO UCE DER event received and DPC started
> running as you said, But there is a little bit of confusion as to why I
> disable OS native DCP, it still be triggered. 
> The injection message listed as below.
> 
> [  832.834785] pcieport 0000:a7:01.0: EDR: EDR event received
> [  832.835232] pcieport 0000:a7:01.0: DPC: containment event, status:0x1f09 source:0x0000
> [  832.835239] pcieport 0000:a7:01.0: DPC: unmasked uncorrectable error detected
> [  832.835246] pcieport 0000:a7:01.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> [  832.835253] pcieport 0000:a7:01.0:   device [8086:352a] error status/mask=00004000/00180020
> [  832.835258] pcieport 0000:a7:01.0:    [14] CmpltTO                (First)
> [  903.394837] pcieport 0000:a7:01.0: AER: device recovery successful

EDR is the hybird mode. In this case, the firmware owns the DPC and will detect
the DPC event. But for error recovery, it will let OS handle it to EDR
notification.

You can find more details in the latest PCIe firmware specification and APCI
specification.

> 
> On the contrary, if we keep OS native AER DPC enabled on BIOS,
> we can see the message as below, OS now controls AER DPC. 
> Under these settings, who should  handle DPC if an error is coming?

If native DPC is enabled then OS will handle the DPC detection and
error recover.

In firmwre DPC mode, firmware will do the DPC detection and it can
optionally use OS for error recovery using EDR>

> Is it the EDR event or the DPC interrupt (dpc_irq)? 
> Does the BIOS participate in the DPC process in this situation? If BIOS
> do not notify OS EDR via send WHEASCI, do we need to  install edr notifier
> handler in function pci_acpi_add_edr_notifier? 
> How about we skip EDR init when OS native AER/DPC enabled? Because we
> now trigger DPC that be notified by an interrupt of DPC Control (DPCCTL)
> register, install EDR handler seems redundant on OS native AER/DPC enabled.

Installing handler will just register callback with ACPI device. AFAIK,
preventing it in OS native DPC case is not going to fix anything or
optimize the path.

> Thanks!
> [    2.350709] acpi PNP0A08:04: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
> [    2.351799] acpi PNP0A08:04: _OSC: platform does not support [SHPCHotplug]
> [    2.353144] acpi PNP0A08:04: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability LTR DPC]
> [    2.353145] acpi PNP0A08:04: FADT indicates ASPM is unsupported, using BIOS configuration
> 
>>
>>>
>>> Signed-off-by: Xiaochun Lee <lixc17@lenovo.com>
>>> ---
>>>  drivers/pci/pcie/edr.c | 16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>>
>>> diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c index
>>> a6b9b47..97a680b 100644
>>> --- a/drivers/pci/pcie/edr.c
>>> +++ b/drivers/pci/pcie/edr.c
>>> @@ -19,6 +19,17 @@
>>>  #define EDR_OST_SUCCESS			0x80
>>>  #define EDR_OST_FAILED			0x81
>>>
>>> +static int pcie_dpc_is_native(struct pci_dev *dev) {
>>> +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>>> +
>>> +	if (!dev->dpc_cap)
>>> +		return 0;
>>> +
>>> +	return pcie_ports_dpc_native || host->native_dpc; }
>>> +
>>> +
>>>  /*
>>>   * _DSM wrapper function to enable/disable DPC
>>>   * @pdev   : PCI device structure
>>> @@ -212,6 +223,11 @@ void pci_acpi_add_edr_notifier(struct pci_dev
>> *pdev)
>>>  		return;
>>>  	}
>>>
>>> +	if (!pcie_dpc_is_native(pdev) && !pcie_aer_is_native(pdev)) {
>>> +		pci_dbg(pdev, "OS doesn't control DPC, skipping EDR init\n");
>>> +		return;
>>> +	}
>>> +
>>>  	status = acpi_install_notify_handler(adev->handle,
>> ACPI_SYSTEM_NOTIFY,
>>>  					     edr_handle_event, pdev);
>>>  	if (ACPI_FAILURE(status)) {
>>
>> --
>> Sathyanarayanan Kuppuswamy
>> Linux Kernel Developer

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
