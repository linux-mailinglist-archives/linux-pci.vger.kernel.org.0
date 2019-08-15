Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD3D28F7BD
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 01:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfHOXsw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Aug 2019 19:48:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:48486 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfHOXsw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Aug 2019 19:48:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 16:48:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,391,1559545200"; 
   d="scan'208";a="201377119"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 15 Aug 2019 16:48:51 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id 8B0CE5806C4;
        Thu, 15 Aug 2019 16:48:51 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v6 3/9] PCI/ACPI: Expose EDR support via _OSC to BIOS
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
References: <cover.1564177080.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <c2841a077e304b3173e1c6f95f7fe488d1e15030.1564177080.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190815221934.GK253360@google.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <62dc67cc-de4d-bac9-bffb-b2ce2ce84f6b@linux.intel.com>
Date:   Thu, 15 Aug 2019 16:46:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815221934.GK253360@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/15/19 3:19 PM, Bjorn Helgaas wrote:
> On Fri, Jul 26, 2019 at 02:43:13PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> As per PCI firmware specification r3.2 Downstream Port Containment
>> Related Enhancements ECN, sec 4.5.1, table 4-4, if OS supports EDR,
>> it should expose its support to BIOS by setting bit 7 of _OSC Support
>> Field.
>>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Len Brown <lenb@kernel.org>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>   drivers/acpi/pci_root.c | 3 +++
>>   include/linux/acpi.h    | 1 +
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index 73b08f40b0da..988d09d788b6 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
>> @@ -132,6 +132,7 @@ static struct pci_osc_bit_struct pci_osc_support_bit[] = {
>>   	{ OSC_PCI_CLOCK_PM_SUPPORT, "ClockPM" },
>>   	{ OSC_PCI_SEGMENT_GROUPS_SUPPORT, "Segments" },
>>   	{ OSC_PCI_MSI_SUPPORT, "MSI" },
>> +	{ OSC_PCI_EDR_SUPPORT, "EDR" },
>>   	{ OSC_PCI_HPX_TYPE_3_SUPPORT, "HPX-Type3" },
>>   };
>>   
>> @@ -442,6 +443,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>>   		support |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
>>   	if (pci_msi_enabled())
>>   		support |= OSC_PCI_MSI_SUPPORT;
>> +	if (IS_ENABLED(CONFIG_PCIE_EDR))
>> +		support |= OSC_PCI_EDR_SUPPORT;
> Do we really support it here?  This is patch [3/9] and it looks like
> patch [6/9] might be where EDR support really gets added.  It's good
> to split changes into small pieces, but only if each piece is
> logically self-contained.
I will move this patch to the end of this series.
>
>>   	decode_osc_support(root, "OS supports", support);
>>   	status = acpi_pci_osc_support(root, support);
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index 8959ed322e15..b6b43da85d26 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -515,6 +515,7 @@ extern bool osc_pc_lpi_support_confirmed;
>>   #define OSC_PCI_CLOCK_PM_SUPPORT		0x00000004
>>   #define OSC_PCI_SEGMENT_GROUPS_SUPPORT		0x00000008
>>   #define OSC_PCI_MSI_SUPPORT			0x00000010
>> +#define OSC_PCI_EDR_SUPPORT			0x00000080
>>   #define OSC_PCI_HPX_TYPE_3_SUPPORT		0x00000100
>>   #define OSC_PCI_SUPPORT_MASKS			0x0000011f
> You defined a new bit above but didn't update OSC_PCI_SUPPORT_MASKS to
> include that bit.  This looks broken.
>
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

