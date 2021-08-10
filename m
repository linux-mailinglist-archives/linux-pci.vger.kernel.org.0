Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B773E5E4E
	for <lists+linux-pci@lfdr.de>; Tue, 10 Aug 2021 16:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241321AbhHJOrm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Aug 2021 10:47:42 -0400
Received: from foss.arm.com ([217.140.110.172]:57182 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241835AbhHJOrk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Aug 2021 10:47:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28E621FB;
        Tue, 10 Aug 2021 07:47:18 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A38B23F718;
        Tue, 10 Aug 2021 07:47:17 -0700 (PDT)
Subject: Re: [PATCH 3/3] PCI/ACPI: Add new quirk detection, enable bcm2711
To:     Shanker R Donthineni <sdonthineni@nvidia.com>,
        linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, nsaenz@kernel.org, bhelgaas@google.com,
        rjw@rjwysocki.net, lenb@kernel.org, robh@kernel.org, kw@linux.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210805211200.491275-1-jeremy.linton@arm.com>
 <20210805211200.491275-4-jeremy.linton@arm.com>
 <b574f9bb-72f3-72cd-9a6a-f1f4d998afda@nvidia.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <1ed33f6e-fbfb-e8a0-741e-6961f9a7072b@arm.com>
Date:   Tue, 10 Aug 2021 09:47:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <b574f9bb-72f3-72cd-9a6a-f1f4d998afda@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Thanks for looking at this!

On 8/10/21 9:31 AM, Shanker R Donthineni wrote:
> Hi Jeremy,
> 
> On 8/5/21 4:12 PM, Jeremy Linton wrote:
>> Now that we have a bcm2711 quirk, we need to be able to
>> detect it when the MCFG is missing. Use a namespace
>> property as an alternative to the MCFG OEM.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   drivers/acpi/pci_mcfg.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
>> index 53cab975f612..7d77fc72c2a4 100644
>> --- a/drivers/acpi/pci_mcfg.c
>> +++ b/drivers/acpi/pci_mcfg.c
>> @@ -169,6 +169,9 @@ static struct mcfg_fixup mcfg_quirks[] = {
>>          ALTRA_ECAM_QUIRK(1, 13),
>>          ALTRA_ECAM_QUIRK(1, 14),
>>          ALTRA_ECAM_QUIRK(1, 15),
>> +
>> +       { "bcm2711", "", 0, 0, MCFG_BUS_ANY, &bcm2711_pcie_ops,
>> +         DEFINE_RES_MEM(0xFD500000, 0xA000) },
>>   };
>>
>>   static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
>> @@ -198,8 +201,19 @@ static void pci_mcfg_apply_quirks(struct acpi_pci_root *root,
>>          u16 segment = root->segment;
>>          struct resource *bus_range = &root->secondary;
>>          struct mcfg_fixup *f;
>> +       const char *soc;
>>          int i;
>>
>> +       /*
>> +        * This could be a machine with a PCI/SMC conduit,
>> +        * which means it doens't have MCFG. Get the machineid from
>> +        * the namespace definition instead.
>> +        */
>> +       if (!fwnode_property_read_string(acpi_fwnode_handle(root->device),
>> +                                        "linux,pcie-quirk", &soc)) {
>> +               memcpy(mcfg_oem_id, soc, ACPI_OEM_ID_SIZE);
>> +       }
>> +
> 
> Is there any specific reason for not using the firmware agnostic API to get properties?
>   
> 
>   if (!device_property_read_string(root->device, "linux,pcie-quirk", &soc)) {
>       memcpy(mcfg_oem_id, soc, ACPI_OEM_ID_SIZE);
>   }
> 
> 

IIRC it was because the "device" here isn't a struct device, rather a 
struct acpi_device. I think this is the normal way in this situation 
since we are directly picking up the fwnode rather than finding a 
generic node and then backtracking to get the fwnode.

