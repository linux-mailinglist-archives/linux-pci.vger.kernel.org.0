Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F384901F7
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jan 2022 07:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbiAQG3i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jan 2022 01:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbiAQG3h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jan 2022 01:29:37 -0500
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [IPv6:2001:67c:2050:1::465:204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46E7C061574
        for <linux-pci@vger.kernel.org>; Sun, 16 Jan 2022 22:29:37 -0800 (PST)
Received: from smtp202.mailbox.org (unknown [91.198.250.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4Jchp750r0zQjYL;
        Mon, 17 Jan 2022 07:29:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Message-ID: <74523201-db9e-38d0-c7eb-1f6be8265e7e@denx.de>
Date:   Mon, 17 Jan 2022 07:29:30 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] PCI/portdrv: Don't disable AER reporting in
 get_port_device_capability()
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Yao Hongbo <yaohongbo@linux.alibaba.com>,
        Naveen Naidu <naveennaidu479@gmail.com>
References: <20220114201935.GA572866@bhelgaas>
From:   Stefan Roese <sr@denx.de>
In-Reply-To: <20220114201935.GA572866@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/14/22 21:19, Bjorn Helgaas wrote:
> On Thu, Jan 13, 2022 at 12:36:04PM +0100, Stefan Roese wrote:
>> Testing has shown, that AER reporting is currently disabled in the
>> DevCtl registers of all non Root Port PCIe devices on systems using
>> pcie_ports_native || host->native_aer. Practically disabling AER
>> completely in such systems.
> 
> I want to be a little pedantic here because the error landscape is
> complicated, and I think it will help if we correspond closely to the
> spec language.
> 
> Device Control controls Error Reporting (whether the device sends
> ERR_* messages), and IIUC this is relevant even without AER (I'm
> looking at PCIe r6.0, sec 6.2.5, which refers to CERE, NERE, FERE
> outside the AER box).
> 
> Can you update this with analysis of the code as opposed to what we
> observe in testing?  Hopefully the analysis corresponds to the
> observations :)  Here's my take; probably too much for a commit log,
> but maybe it can be distilled:
> 
>    pcie_portdrv_probe
>      pcie_port_device_register
>        get_port_device_capability
>          pci_disable_pcie_error_reporting
>            clear CERE NFERE FERE URRE               # <-- disable for RP USP DSP
>        pcie_device_init
>          device_register                            # new AER service device
>            aer_probe
>              aer_enable_rootport                    # RP only
>                set_downstream_devices_error_reporting
>                  set_device_error_reporting         # self (RP)
>                    if (RP || USP || DSP)
>                      pci_enable_pcie_error_reporting
>                        set CERE NFERE FERE URRE     # <-- enable for RP
>                  pci_walk_bus
>                    set_device_error_reporting
>                      if (RP || USP || DSP)
>                        pci_enable_pcie_error_reporting
>                          set CERE NFERE FERE URRE   # <-- enable for USP DSP
> 
> In a typical Root Port -> Endpoint hierarchy, the above:
> 
>    - Disables Error Reporting for the Root Port,
> 
>    - Enables Error Reporting for the Root Port,
> 
>    - Does NOT enable Error Reporting for the Endpoint because it is not
>      a Root Port or Switch Port.
> 
> In a deeper Root Port -> Upstream Switch Port -> Downstream Switch
> Port -> Endpoint hierarchy:
> 
>    - Disables Error Reporting for the Root Port,
> 
>    - Enables Error Reporting for the Root Port,
> 
>    - Enables Error Reporting for both Switch Ports,
> 
>    - Does NOT enable Error Reporting for the Endpoint because it is not
>      a Root Port or Switch Port,
> 
>    - Disables Error Reporting for the Switch Ports when
>      pcie_portdrv_probe() claims them.  AER does not re-enable it
>      because these are not Root Ports.
> 
> I think the bottom line is that the current code leaves reporting
> enabled on Root Ports and disabled everywhere else.  It's enabled
> temporarily on Switch Ports, but disabled again when
> pcie_portdrv_probe() claims them.
> 
> The core doesn't do anything with Endpoints, but a few drivers enable
> reporting themselves.  This probably only works when their devices are
> directly connected to a Root Port.

Correct. This is also my understanding.

>> This is due to the fact that with commit 2bd50dd800b5 ("PCI: PCIe:
>> Disable PCIe port services during port initialization"), a call to
>> pci_disable_pcie_error_reporting() was added *after* the PCIe AER
>> setup was completed for the PCIe device tree.
> 
> IIUC, 2bd50dd800b5 is really only an issue for Switch Ports, because
> it makes portdrv disable reporting for them, but AER doesn't re-enable
> it.
> 
>> This patch now removes this call to pci_disable_pcie_error_reporting()
>> from get_port_device_capability(), leaving the already enabled AER
>> configuration intact. With this change, I'm able to fully use the
>> Kernel AER infrastructure on a ZynqMP system which has a PCIe switch
>> connected to the host CPU PCIe Root Port.
> 
> This patch doesn't affect the Endpoint, and I assume you also need to
> enable reporting there?

Yes. If we want the PCI core to have control here and fully enable the
AER including the PCIe devices, as we agreed upon in the other thread,
then the Endpoint also needs to have AER enabled. I'll probably add 2
2nd patch to this one (with updated commit message), which handles the
Endpoint AER.

Thanks,
Stefan

>> Fixes: 2bd50dd800b5 ("PCI: PCIe: Disable PCIe port services during port initialization")
>> Signed-off-by: Stefan Roese <sr@denx.de>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: Bjorn Helgaas <helgaas@kernel.org>
>> Cc: Pali Rohár <pali@kernel.org>
>> Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
>> Cc: Michal Simek <michal.simek@xilinx.com>
>> Cc: Yao Hongbo <yaohongbo@linux.alibaba.com>
>> Cc: Naveen Naidu <naveennaidu479@gmail.com>
>> ---
>>   drivers/pci/pcie/portdrv_core.c | 9 +--------
>>   1 file changed, 1 insertion(+), 8 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
>> index 4dab74ff4368..48f5e67709f7 100644
>> --- a/drivers/pci/pcie/portdrv_core.c
>> +++ b/drivers/pci/pcie/portdrv_core.c
>> @@ -244,15 +244,8 @@ static int get_port_device_capability(struct pci_dev *dev)
>>   
>>   #ifdef CONFIG_PCIEAER
>>   	if (dev->aer_cap && pci_aer_available() &&
>> -	    (pcie_ports_native || host->native_aer)) {
>> +	    (pcie_ports_native || host->native_aer))
>>   		services |= PCIE_PORT_SERVICE_AER;
>> -
>> -		/*
>> -		 * Disable AER on this port in case it's been enabled by the
>> -		 * BIOS (the AER service driver will enable it when necessary).
>> -		 */
>> -		pci_disable_pcie_error_reporting(dev);
>> -	}
>>   #endif
>>   
>>   	/* Root Ports and Root Complex Event Collectors may generate PMEs */
>> -- 
>> 2.34.1
>>

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
