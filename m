Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86A6814D2C0
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 22:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgA2VzY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 16:55:24 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46434 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgA2VzY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jan 2020 16:55:24 -0500
Received: by mail-ot1-f65.google.com with SMTP id g64so1083000otb.13;
        Wed, 29 Jan 2020 13:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YgpLdar8ZVGRCK6kjDAKTFtWYogyKiuDiyRyWZas17k=;
        b=IJ5CjNQrYuBQNbkIasSXpLxFzaKpxci6iFoX6f8xxSbnC2FcE7aySkRVOcc4+Vs3PE
         RaDUIzV5SCzAiTsN2pbL4P/coN3qOszNDCiMJM49V8Y7TiXF063r6YaqufIJZL7O9x4t
         lD2GKr46gyq1CA66fRH9ZBlcPZD5rbWFgp0YLHJUPDtPBFeSehKegTiIqPd7uvJgxlZQ
         sAZvLGzqJySP8PcC/2y6gK4xUHwvM8Xl/a7YlubdxlDBHmXUFX1owV0vwrju7+Mlo8tZ
         BFBMw3C4mLKvqOlctl6d3fenJKTB4XriIl/DQn5LUdrMTUi+uoIOISSRNQrt7G0yddnt
         hgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YgpLdar8ZVGRCK6kjDAKTFtWYogyKiuDiyRyWZas17k=;
        b=dNy5xyKDE4mV2caH/EIOOdVrHgOhSS20pk4RH5gEOnk3O4o2+giX/rZZ08rY9dVoB7
         DioiIpAYxhz9saGPPV3X1PgsMHr9k4P5yf7UfwdvGL0v7CwFT6JY3ZBukYuhHqzjW8Sp
         bylqqoN9gGEE2+TTWcGR+RRIjsOl0/X4OxJl2B7IBV35SPMtY8z80E3CLzyikMdRIynF
         jRVsoKWu1XBJgqZS42ZmMmX9tyveRhTpg8MeTVo9OtOHltg5r/eco4oGL+oDj4PBa710
         a1TODlN0LGSOhPOh7HcigF0fegxEAhtpsKA/IkaOSgDHvKp9eSHSErVNtjm2fw0ieEEE
         Yf2g==
X-Gm-Message-State: APjAAAWyozmtil7C8QJMEV86znhVd/ua+sWungK81I94tB7+G4u53cOD
        OQRM4SgL1R/WuwkfrxzTZXA=
X-Google-Smtp-Source: APXvYqzkZ9KSIvuTojSgea4UjwCcU2uNQ3Nh05QNNfvfORKf6YTQHnP+Hgpwlz7JhJ0HAgJEH7wdaQ==
X-Received: by 2002:a05:6830:610:: with SMTP id w16mr1120166oti.239.1580334922708;
        Wed, 29 Jan 2020 13:55:22 -0800 (PST)
Received: from [100.71.96.87] ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id t131sm1039194oih.35.2020.01.29.13.55.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jan 2020 13:55:22 -0800 (PST)
Subject: Re: [PATCH v2] PCI: pciehp: Make sure pciehp_isr clears interrupt
 events
To:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc:     Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Enzo Matsumiya <ematsumiya@suse.de>,
        kbusch@kernel.org
References: <20200129005151.GA247355@google.com>
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
Message-ID: <97162f37-9cde-d349-52e0-c1aaa70ec7a9@gmail.com>
Date:   Wed, 29 Jan 2020 15:55:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200129005151.GA247355@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 1/28/20 6:51 PM, Bjorn Helgaas wrote:
> [+cc Enzo]
> 
> On Wed, Nov 20, 2019 at 05:20:43PM -0500, Stuart Hayes wrote:
>> Without this patch, a pciehp hotplug port can stop generating interrupts
>> on hotplug events, so device adds and removals will not be seen.
>>
>> The pciehp interrupt handler pciehp_isr() will read the slot status
>> register and then write back to it to clear the bits that caused the
>> interrupt. If a different interrupt event bit gets set between the read and
>> the write, pciehp_isr will exit without having cleared all of the interrupt
>> event bits. If this happens, and the port is using an MSI interrupt where
>> per-vector masking is not supported, we won't get any more hotplug
>> interrupts from that device.
>>
>> That is expected behavior, according to the PCI Express Base Specification
>> Revision 5.0 Version 1.0, section 6.7.3.4, "Software Notification of Hot-
>> Plug Events".
>>
>> Because the "presence detect changed" and "data link layer state changed"
>> event bits are both getting set at nearly the same time when a device is
>> added or removed, this is more likely to happen than it might seem. The
>> issue was found (and can be reproduced rather easily) by connecting and
>> disconnecting an NVMe storage device on at least one system model.
>>
>> This issue was found while adding and removing various NVMe storage devices
>> on an AMD PCIe port (PCI device 0x1022/0x1483).
>>
>> This patch fixes this issue by modifying pciehp_isr() by looping back and
>> re-reading the slot status register immediately after writing to it, until
>> it sees that all of the event status bits have been cleared.
> 
> I see that Lukas took a look at this earlier; I'd really like to have
> his reviewed-by, since he's the expert on this code.
> 
>> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
>> ---
>> v2:
>>   * fixed ctrl_warn() call
>>   * improved comments
>>   * added pvm_capable flag and changed pciehp_isr() to loop back only when
>>     pvm_capable flag not set (suggested by Lukas Wunner)
>>   
>>  drivers/pci/hotplug/pciehp.h     |  3 ++
>>  drivers/pci/hotplug/pciehp_hpc.c | 50 ++++++++++++++++++++++++++++----
>>  2 files changed, 47 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
>> index 654c972b8ea0..1804277ec433 100644
>> --- a/drivers/pci/hotplug/pciehp.h
>> +++ b/drivers/pci/hotplug/pciehp.h
>> @@ -47,6 +47,8 @@ extern int pciehp_poll_time;
>>   * struct controller - PCIe hotplug controller
>>   * @pcie: pointer to the controller's PCIe port service device
>>   * @slot_cap: cached copy of the Slot Capabilities register
>> + * @pvm_capable: set if per-vector masking is supported (if not set, the ISR
>> + *	needs to ensure all event bits cleared)
>>   * @slot_ctrl: cached copy of the Slot Control register
>>   * @ctrl_lock: serializes writes to the Slot Control register
>>   * @cmd_started: jiffies when the Slot Control register was last written;
>> @@ -83,6 +85,7 @@ struct controller {
>>  	struct pcie_device *pcie;
>>  
>>  	u32 slot_cap;				/* capabilities and quirks */
>> +	unsigned int pvm_capable:1;
>>  
>>  	u16 slot_ctrl;				/* control register access */
>>  	struct mutex ctrl_lock;
>> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
>> index 1a522c1c4177..4ffd489a5413 100644
>> --- a/drivers/pci/hotplug/pciehp_hpc.c
>> +++ b/drivers/pci/hotplug/pciehp_hpc.c
>> @@ -487,12 +487,21 @@ void pciehp_power_off_slot(struct controller *ctrl)
>>  		 PCI_EXP_SLTCTL_PWR_OFF);
>>  }
>>  
>> +/*
>> + * We should never need to re-read the slot status register this many times,
>> + * because there are only six possible events that could generate this
>> + * interrupt.  If we still see events after this many reads, there's a stuck
>> + * bit.
>> + */
>> +#define MAX_ISR_STATUS_READS 6
>> +
>>  static irqreturn_t pciehp_isr(int irq, void *dev_id)
>>  {
>>  	struct controller *ctrl = (struct controller *)dev_id;
>>  	struct pci_dev *pdev = ctrl_dev(ctrl);
>>  	struct device *parent = pdev->dev.parent;
>> -	u16 status, events;
>> +	u16 status, events = 0;
>> +	int status_reads = 0;
>>  
>>  	/*
>>  	 * Interrupts only occur in D3hot or shallower and only if enabled
>> @@ -517,6 +526,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>>  		}
>>  	}
>>  
>> +read_status:
>>  	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
>>  	if (status == (u16) ~0) {
>>  		ctrl_info(ctrl, "%s: no response from device\n", __func__);
>> @@ -529,24 +539,44 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>>  	 * Slot Status contains plain status bits as well as event
>>  	 * notification bits; right now we only want the event bits.
>>  	 */
>> -	events = status & (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
>> -			   PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_CC |
>> -			   PCI_EXP_SLTSTA_DLLSC);
>> +	status &= (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
>> +		   PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_CC |
>> +		   PCI_EXP_SLTSTA_DLLSC);
>>  
>>  	/*
>>  	 * If we've already reported a power fault, don't report it again
>>  	 * until we've done something to handle it.
>>  	 */
>>  	if (ctrl->power_fault_detected)
>> -		events &= ~PCI_EXP_SLTSTA_PFD;
>> +		status &= ~PCI_EXP_SLTSTA_PFD;
>>  
>> +	events |= status;
>>  	if (!events) {
>>  		if (parent)
>>  			pm_runtime_put(parent);
>>  		return IRQ_NONE;
>>  	}
>>  
>> -	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, events);
>> +	if (status) {
>> +		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, status);
>> +
>> +		/*
>> +		 * If MSI per-vector masking is not supported by the port,
>> +		 * all of the event bits must be zero before the port will
>> +		 * send a new interrupt (see PCI Express Base Specification
>> +		 * Revision 5.0 Version 1.0, section 6.7.3.4, "Software
>> +		 * Notification of Hot-Plug Events"). So in that case, if
>> +		 * event bit gets set between the read and the write of
>> +		 * PCI_EXP_SLTSTA, we need to loop back and try again.
>> +		 */
>> +		if (!ctrl->pvm_capable) {
> 
> I don't think this per-vector masking check is correct.  It's true
> that if the device does not support masking, it must send an interrupt
> every time this expression transitions from FALSE to TRUE:
> 
>   (INT ENABLE == 1) AND ((event status == 1) AND event enable == 1)
> 
> But if the device *does* support per-vector masking, an interrupt
> message must be sent every time this expression transitions from FALSE
> to TRUE:
> 
>   (MSI vector is unmasked) AND (INT ENABLE == 1) AND
>     ((event status == 1) AND event enable == 1)
> 
> I don't know what whether the MSI vector is masked or not at this
> point, and I don't think this code *should* know that.  All it should
> know is "we got an interrupt via some mechanism".  Actually, it can't
> even know that, because it should always be safe to call an ISR
> because the interrupt may be shared with other devices, and this ISR
> may be called because a different device interrupted.
> 
> So if we assume the vector is unmasked, the situation is the same as
> when the device doesn't support per-vector masking.
> 

I agree.  I am happy to remove the check if per-vector masking is
supported and fix the comment.


>> +			if (status_reads++ < MAX_ISR_STATUS_READS)
>> +				goto read_status;
> 
> I don't understand this limit of six.  We clear a status bit above,
> but what's to prevent that same bit from being set again after we read
> it but before we write it?
> 

I think the nature of the status bits (power fault, link active, etc)
means that they shouldn't be toggling at a high frequency, and there are
only six status bits that can cause this interrupt, which is why I chose
six.  But it is really just an arbitrary number that should be larger
than any non-broken system would ever get to, just to safeguard against
getting stuck in the ISR.

I guess if a raw, unbounced attention button is connected, that one
status bit might toggle repeatedly at a high rate--but, if only a
single bit is toggling, the write to the status register would clear
the status register even if that status bit gets set again before the
status register is read back, so in that case it should still be able
to generate another interrupt after pciehp_isr() exits, and it won't
matter that the loop was aborted after six tries to clear the status.


>> +			ctrl_warn(ctrl, "Hot plug event bit stuck (%x)\n",
>> +				  status);
>> +		}
>> +	}
>> +
>>  	ctrl_dbg(ctrl, "pending interrupts %#06x from Slot Status\n", events);
>>  	if (parent)
>>  		pm_runtime_put(parent);
>> @@ -812,6 +842,7 @@ struct controller *pcie_init(struct pcie_device *dev)
>>  {
>>  	struct controller *ctrl;
>>  	u32 slot_cap, link_cap;
>> +	u16 msiflags;
>>  	u8 poweron;
>>  	struct pci_dev *pdev = dev->port;
>>  	struct pci_bus *subordinate = pdev->subordinate;
>> @@ -881,6 +912,13 @@ struct controller *pcie_init(struct pcie_device *dev)
>>  		}
>>  	}
>>  
>> +	ctrl->pvm_capable = 1;
>> +	if (pdev->msi_enabled) {
>> +		pci_read_config_word(pdev, pdev->msi_cap + PCI_MSI_FLAGS,
>> +				     &msiflags);
>> +		ctrl->pvm_capable = !!(msiflags & PCI_MSI_FLAGS_MASKBIT);
>> +	}
>> +
>>  	return ctrl;
>>  }
>>  
>> -- 
>> 2.18.1
>>
