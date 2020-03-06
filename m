Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5293617C6A6
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 20:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgCFT7F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 14:59:05 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45064 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgCFT7F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Mar 2020 14:59:05 -0500
Received: by mail-ot1-f66.google.com with SMTP id f21so3610754otp.12;
        Fri, 06 Mar 2020 11:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9iMEAOJp31ZT3tbWUq0vVLKvRWpPQYGZdT0+aeaOx0U=;
        b=puBHa+EImZpqs7EwGJ/YJHv+T/U6xfKvKJpTI3fIoKsp3WvXacEwlGNnSlR3ynznrP
         fyHfEWsQ9NO/NfM+bWi2Wpovh+gumYQ9UxatPIU8Q2md9A7VWmHexcbRAbCd1XxV9vSC
         S7Q+fAw8IX3GXZkrXHn/HhuZs3l9iLm2M2NW056NdvmsO0md2aMezTcdG4ezxQuQiD/L
         SnojqdWKfgVX8lBZEswBsZSeINJFE6bD5g6+OmrjDJ2taRMzV+H/2wEgKMkWylpHWcf2
         0cd4WiXzqTv8YEm6iVMO8lYRiIXpldz5r5YcBjnf76wsaM+eMl5NIBlYFSFe4LUv2czV
         9M7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9iMEAOJp31ZT3tbWUq0vVLKvRWpPQYGZdT0+aeaOx0U=;
        b=S2tDOavAVbGkKce1o0vnvCOt4yJTdqjGeaw+Vrpg9fwfSMeCrhqIO+2RTdZCC7ckpR
         jgB80hgp9KunTFIFmFSpg40qTz8a0qIIQNBkJSKwqIa8H7UFpELrwI6Jq/G7fUcEHIVt
         HUhRDglXkOa3Uab1CF61xLTFPkVTKwGSb3hq7tnThWDFBd+t1Gj1E1AvuwZbdEwdpl8C
         wwonCNQSh0WW1/W2gFDqmXlqKnRxCq0hxacdmUxioa48npbKCcDVqN1I2zkpBFOnm+wl
         GZylo7KSE6eEFRHE7NQmOmORuuk+c38pyyfTl4uPi4Di5MDIiRjLxxBH3ng/s1w6/HDL
         5CYA==
X-Gm-Message-State: ANhLgQ0nQHk8ikl+BO0rwW95YuSa9XFDIeDTXbjRG/nVo9uMZWCQX8x8
        cPq75q9Zk3PZbpzqUHEQsy+qyafQwQ+qqw==
X-Google-Smtp-Source: ADFU+vve+niu4SAo5/TFA8c8/hIWThZFju8y6ueh+HqfbYM8guXHo+GPOAUwp3p+L80vfYmevZYR6Q==
X-Received: by 2002:a05:6830:1e07:: with SMTP id s7mr3984755otr.85.1583524744150;
        Fri, 06 Mar 2020 11:59:04 -0800 (PST)
Received: from [100.71.96.87] ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id v140sm67853oif.56.2020.03.06.11.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Mar 2020 11:59:02 -0800 (PST)
Subject: Re: [PATCH v4] PCI: pciehp: Fix MSI interrupt race
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Austin Bolen <austin_bolen@dell.com>,
        Keith Busch <kbusch@kernel.org>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, narendra_k@dell.com,
        Enzo Matsumiya <ematsumiya@suse.com>
References: <20200207195450.52026-1-stuart.w.hayes@gmail.com>
 <78b4ced5072bfe6e369d20e8b47c279b8c7af12e.1582121613.git.lukas@wunner.de>
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
Message-ID: <860e81c0-8030-57cd-2847-a8a7a9bbda5c@gmail.com>
Date:   Fri, 6 Mar 2020 13:59:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <78b4ced5072bfe6e369d20e8b47c279b8c7af12e.1582121613.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/19/20 8:31 AM, Lukas Wunner wrote:
> From: Stuart Hayes <stuart.w.hayes@gmail.com>
> 
> Without this commit, a PCIe hotplug port can stop generating interrupts
> on hotplug events, so device adds and removals will not be seen:
> 
> The pciehp interrupt handler pciehp_isr() reads the Slot Status register
> and then writes back to it to clear the bits that caused the interrupt.
> If a different interrupt event bit gets set between the read and the
> write, pciehp_isr() returns without having cleared all of the interrupt
> event bits.  If this happens when the MSI isn't masked (which by default
> it isn't in handle_edge_irq(), and which it will never be when MSI
> per-vector masking is not supported), we won't get any more hotplug
> interrupts from that device.
> 
> That is expected behavior, according to the PCIe Base Spec r5.0, section
> 6.7.3.4, "Software Notification of Hot-Plug Events".
> 
> Because the Presence Detect Changed and Data Link Layer State Changed
> event bits can both get set at nearly the same time when a device is
> added or removed, this is more likely to happen than it might seem.
> The issue was found (and can be reproduced rather easily) by connecting
> and disconnecting an NVMe storage device on at least one system model
> where the NVMe devices were being connected to an AMD PCIe port (PCI
> device 0x1022/0x1483).
> 
> Fix the issue by modifying pciehp_isr() to loop back and re-read the
> Slot Status register immediately after writing to it, until it sees that
> all of the event status bits have been cleared.
> 
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> [lukas: drop loop count limitation, write "events" instead of "status",
> don't loop back in INTx and poll modes, tweak code comment & commit msg]
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
> v4 (lukas):
>   * drop "MAX_ISR_STATUS_READS" loop count limitation
>   * drop unnecessary braces around PCI_EXP_SLTSTA_* flags
>   * write "events" instead of "status" variable to Slot Status register
>     to avoid unnecessary loop iterations if the same bit gets set
>     repeatedly
>   * don't loop back in INTx and poll modes
>   * shorten and tweak code comment & commit message
> 
> v3:
>   * removed pvm_capable flag (from v2) since MSI may not be masked
>     regardless of whether per-vector masking is supported
>   * tweaked comments
> 
> v2:
>   * fixed ctrl_warn() call
>   * improved comments
>   * added pvm_capable flag and changed pciehp_isr() to loop back only when
>     pvm_capable flag not set (suggested by Lukas Wunner)
> 
>  drivers/pci/hotplug/pciehp_hpc.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 8a2cb1764386..f64d10df9eb5 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -527,7 +527,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>  	struct controller *ctrl = (struct controller *)dev_id;
>  	struct pci_dev *pdev = ctrl_dev(ctrl);
>  	struct device *parent = pdev->dev.parent;
> -	u16 status, events;
> +	u16 status, events = 0;
>  
>  	/*
>  	 * Interrupts only occur in D3hot or shallower and only if enabled
> @@ -552,6 +552,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>  		}
>  	}
>  
> +read_status:
>  	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
>  	if (status == (u16) ~0) {
>  		ctrl_info(ctrl, "%s: no response from device\n", __func__);
> @@ -564,24 +565,37 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>  	 * Slot Status contains plain status bits as well as event
>  	 * notification bits; right now we only want the event bits.
>  	 */
> -	events = status & (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
> -			   PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_CC |
> -			   PCI_EXP_SLTSTA_DLLSC);
> +	status &= PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
> +		  PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_CC |
> +		  PCI_EXP_SLTSTA_DLLSC;
>  
>  	/*
>  	 * If we've already reported a power fault, don't report it again
>  	 * until we've done something to handle it.
>  	 */
>  	if (ctrl->power_fault_detected)
> -		events &= ~PCI_EXP_SLTSTA_PFD;
> +		status &= ~PCI_EXP_SLTSTA_PFD;
>  
> +	events |= status;
>  	if (!events) {
>  		if (parent)
>  			pm_runtime_put(parent);
>  		return IRQ_NONE;
>  	}
>  
> -	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, events);
> +	if (status) {
> +		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, events);
> +
> +		/*
> +		 * In MSI mode, all event bits must be zero before the port
> +		 * will send a new interrupt (PCIe Base Spec r5.0 sec 6.7.3.4).
> +		 * So re-read the Slot Status register in case a bit was set
> +		 * between read and write.
> +		 */
> +		if (pci_dev_msi_enabled(pdev) && !pciehp_poll_mode)
> +			goto read_status;
> +	}
> +
>  	ctrl_dbg(ctrl, "pending interrupts %#06x from Slot Status\n", events);
>  	if (parent)
>  		pm_runtime_put(parent);
> 

If it helps, you can add...
Tested-by: Stuart Hayes <stuart.w.hayes@gmail.com>
