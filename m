Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 331A314149D
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jan 2020 00:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbgAQXGp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jan 2020 18:06:45 -0500
Received: from mga14.intel.com ([192.55.52.115]:61007 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729099AbgAQXGo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Jan 2020 18:06:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 15:06:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,332,1574150400"; 
   d="scan'208";a="426157853"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jan 2020 15:06:43 -0800
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id 567F65803DA;
        Fri, 17 Jan 2020 15:06:43 -0800 (PST)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v12 8/8] PCI/ACPI: Enable EDR support
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Huong Nguyen <huong.nguyen@dell.com>,
        Austin Bolen <Austin.Bolen@dell.com>
References: <20200117204115.GA126492@google.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <cd68630b-a511-ade5-97ed-4ee0082b9f9e@linux.intel.com>
Date:   Fri, 17 Jan 2020 15:04:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200117204115.GA126492@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 1/17/20 12:41 PM, Bjorn Helgaas wrote:
> On Sun, Jan 12, 2020 at 02:44:02PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> As per PCI firmware specification r3.2 Downstream Port Containment
>> Related Enhancements ECN, sec 4.5.1, OS must implement following steps
>> to enable/use EDR feature.
>>
>> 1. OS can use bit 7 of _OSC Control Field to negotiate control over
>> Downstream Port Containment (DPC) configuration of PCIe port. After _OSC
>> negotiation, firmware will Set this bit to grant OS control over PCIe
>> DPC configuration and Clear it if this feature was requested and denied,
>> or was not requested.
>>
>> 2. Also, if OS supports EDR, it should expose its support to BIOS by
>> setting bit 7 of _OSC Support Field. And if OS sets bit 7 of _OSC
>> Control Field it must also expose support for EDR by setting bit 7 of
>> _OSC Support Field.
>> --- a/drivers/pci/pcie/portdrv_core.c
>> +++ b/drivers/pci/pcie/portdrv_core.c
>> @@ -253,10 +253,13 @@ static int get_port_device_capability(struct pci_dev *dev)
>>   	/*
>>   	 * With dpc-native, allow Linux to use DPC even if it doesn't have
>>   	 * permission to use AER.
>> +	 * If EDR support is enabled in OS, then even if AER is not handled in
>> +	 * OS, DPC service can be enabled.
> Can you clarify this comment?  It talks about AER, but the code you
> added:
Previously with condition
(pci_aer_available() && (pcie_ports_dpc_native || (services & 
PCIE_PORT_SERVICE_AER)))
we have only checked whether AER is enabled and supported before 
enabling DPC.

But with EDR support, we enumerate DPC driver even if AER is not 
supported or handled
in OS. And the or condition (IS_ENABLED(CONFIG_PCIE_EDR) && 
!host->native_dpc) adds this
support.


>    (IS_ENABLED(CONFIG_PCIE_EDR) && !host->native_dpc)
>
> doesn't have anything to do with AER.
>
>>   	 */
>>   	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
>> -	    pci_aer_available() &&
>> -	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
>> +	    ((IS_ENABLED(CONFIG_PCIE_EDR) && !host->native_dpc) ||
>> +	    (pci_aer_available() &&
>> +	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))))
>>   		services |= PCIE_PORT_SERVICE_DPC;

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

