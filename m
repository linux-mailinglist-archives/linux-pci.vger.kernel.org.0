Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F07E474128
	for <lists+linux-pci@lfdr.de>; Tue, 14 Dec 2021 12:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbhLNLKe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Dec 2021 06:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhLNLKd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Dec 2021 06:10:33 -0500
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [IPv6:2001:67c:2050:1::465:107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41501C061574
        for <linux-pci@vger.kernel.org>; Tue, 14 Dec 2021 03:10:33 -0800 (PST)
Received: from smtp2.mailbox.org (unknown [91.198.250.124])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4JCwdw6zHgzQlFs;
        Tue, 14 Dec 2021 12:10:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Message-ID: <c3bc7444-7079-9995-dd7f-8bfe214df4b1@denx.de>
Date:   Tue, 14 Dec 2021 12:10:20 +0100
MIME-Version: 1.0
Subject: Re: [RFC PATCH] PCI/MSI: Only mask all MSI-X entries when MSI-X is
 used
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Marek Vasut <marex@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20211210161025.3287927-1-sr@denx.de> <87czm3wimf.ffs@tglx>
 <ee612558-18e6-1ef0-3a48-7a971fdd57f2@denx.de> <87tufevoqx.ffs@tglx>
From:   Stefan Roese <sr@denx.de>
In-Reply-To: <87tufevoqx.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

On 12/11/21 22:02, Thomas Gleixner wrote:
> Stefan,
> 
> On Sat, Dec 11 2021 at 14:58, Stefan Roese wrote:
>> On 12/11/21 11:17, Thomas Gleixner wrote:
>>> Can you try the patch below?
>>
>> Sure, please see below.
>>
>>> It might still be that this Marvell part really combines the per entry
>>> mask bits from MSI-X with MSI, then we need both.
>>
>> With your patch applied only (mine not), the Masked+ is gone but still
>> the MSI interrupts are not received in the system. So you seem to have
>> guessed correctly, that we need both changes.
> 
> Groan. How is that device specification compliant?
> 
> Vector Control for MSI-X Table Entries
> --------------------------------------
> 
> "00: Mask bit:  When this bit is set, the function is prohibited from
>                  sending a message using this MSI-X Table entry.
>                  ....
>                  This bit’s state after reset is 1 (entry is masked)."
> 
> So how can that work in the first place if that device is PCI
> specification compliant? Seems that PCI/SIG compliance program is just
> another rubberstamping nonsense.
> 
> Can someone who has access to that group please ask them what their
> specification compliance stuff is actualy testing?
> 
> Sure, that went unnoticed so far on that marvelous device because the
> kernel was missing a defense line, but sigh...
> 
>> How to continue? Should I integrate your patch into mine and send a new
>> version? Or will you send it separately to the list for integration?
> 
> Your patch is incomplete. The function can fail later on, which results
> in the same problem, no?

Yes, agreed.

> So we need something like the below.

The patch below works fine on my ZynqMP platform. MSI interrupts are now
received okay.

> Just to satisfy my curiosity:
> 
>    The device supports obviously MSI-X, which is preferred over MSI.

I would gladly use MSI-X interrupts, if easily possible. But...

>    So why is the MSI-X initialization failing in the first place on this
>    platform?

... the ZyqnMP PCIe rootport driver only support legacy and MSI
interrupts but not MSI-X (yet) [1].

Thanks,
Stefan

[1] 
https://elixir.bootlin.com/linux/latest/source/drivers/pci/controller/pcie-xilinx-nwl.c

> Thanks,
> 
>          tglx
> ---
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -722,9 +722,6 @@ static int msix_capability_init(struct p
>   		goto out_disable;
>   	}
>   
> -	/* Ensure that all table entries are masked. */
> -	msix_mask_all(base, tsize);
> -
>   	ret = msix_setup_entries(dev, base, entries, nvec, affd);
>   	if (ret)
>   		goto out_disable;
> @@ -751,6 +748,9 @@ static int msix_capability_init(struct p
>   	/* Set MSI-X enabled bits and unmask the function */
>   	pci_intx_for_msi(dev, 0);
>   	dev->msix_enabled = 1;
> +
> +	/* Ensure that all table entries are masked. */
> +	msix_mask_all(base, tsize);
>   	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
>   
>   	pcibios_free_irq(dev);
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
