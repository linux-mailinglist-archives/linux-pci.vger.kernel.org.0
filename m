Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559D8471415
	for <lists+linux-pci@lfdr.de>; Sat, 11 Dec 2021 14:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhLKN7B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Dec 2021 08:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhLKN7B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Dec 2021 08:59:01 -0500
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [IPv6:2001:67c:2050:1::465:107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B685C061714
        for <linux-pci@vger.kernel.org>; Sat, 11 Dec 2021 05:59:01 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:105:465:1:4:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4JB8Wj5ZbqzQj8m;
        Sat, 11 Dec 2021 14:58:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Message-ID: <ee612558-18e6-1ef0-3a48-7a971fdd57f2@denx.de>
Date:   Sat, 11 Dec 2021 14:58:53 +0100
MIME-Version: 1.0
Subject: Re: [RFC PATCH] PCI/MSI: Only mask all MSI-X entries when MSI-X is
 used
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Marek Vasut <marex@denx.de>
References: <20211210161025.3287927-1-sr@denx.de> <87czm3wimf.ffs@tglx>
From:   Stefan Roese <sr@denx.de>
In-Reply-To: <87czm3wimf.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

On 12/11/21 11:17, Thomas Gleixner wrote:
> Stefan,
> 
> On Fri, Dec 10 2021 at 17:10, Stefan Roese wrote:
>> I've debugged the MSI integration of the ZynqMP PCIe rootport driver
>> (pcie-xilinx-nwl.c) and found no issues there. Also the MSI framework
>> in the Kernel did not reveal any problems - at least for me. Looking
>> a bit deeper into the lspci output, I found an interesting difference
>> between v5.4 and v5.10 (or later).
>>
>> v5.4:
>> 04:00.0 Non-Volatile memory controller: Marvell Technology Group Ltd. Device 1321 (rev 02) (prog-if 02 [NVM Express])
>>          ...
>> 	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable+ 64bit+
>> 		Address: 00000000fd480000  Data: 0004
>> 		Masking: 00000000  Pending: 00000000
>> 	Capabilities: [70] Express (v2) Endpoint, MSI 00
>> 	...
>> 	Capabilities: [b0] MSI-X: Enable- Count=67 Masked-
>> 		Vector table: BAR=0 offset=00002000
>> 		PBA: BAR=0 offset=00003000
>> 	...
>>
>> v5.10:
>> 04:00.0 Non-Volatile memory controller: Marvell Technology Group Ltd. Device 1321 (rev 02) (prog-if 02 [NVM Express])
>>          ...
>>          Capabilities: [50] MSI: Enable+ Count=1/1 Maskable+ 64bit+
>>                  Address: 00000000fd480000  Data: 0004
>>                  Masking: 00000000  Pending: 00000000
>>          Capabilities: [70] Express (v2) Endpoint, MSI 00
>>          ...
>>          Capabilities: [b0] MSI-X: Enable- Count=67 Masked+
>>                  Vector table: BAR=0 offset=00002000
>>                  PBA: BAR=0 offset=00003000
>>          ...
>>
>> So the only difference here being the "Masked+" compared to the
>> "Masked-" in the working v5.4 Kernel. Testing in this area has shown,
>> that the root cause for the masked bit being set was the call to
>> msix_mask_all() in msix_capability_init(). Without this, all works just
>> fine and the MSI interrupts are received again by the NVMe driver.
> 
> Not really. The Masked+ in the capabilities entry has nothing to do with
> the entries in the table being masked. The Masked+ reflects the
> PCI_MSIX_FLAGS_MASKALL bit in the MSI-X control register.
> 
> That is set early on and not cleared in the error handling path. The
> error handling just clears the MSIX_FLAGS_ENABLE bit.
> 
> Can you try the patch below?

Sure, please see below.

> It might still be that this Marvell part really combines the per entry
> mask bits from MSI-X with MSI, then we need both.

With your patch applied only (mine not), the Masked+ is gone but still
the MSI interrupts are not received in the system. So you seem to have
guessed correctly, that we need both changes.

How to continue? Should I integrate your patch into mine and send a new
version? Or will you send it separately to the list for integration?

Thanks,
Stefan

> Thanks,
> 
>          tglx
> ---
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -777,7 +777,7 @@ static int msix_capability_init(struct p
>   	free_msi_irqs(dev);
>   
>   out_disable:
> -	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
> +	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL | PCI_MSIX_FLAGS_ENABLE, 0);
>   
>   	return ret;
>   }
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
