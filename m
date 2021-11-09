Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B65644B07C
	for <lists+linux-pci@lfdr.de>; Tue,  9 Nov 2021 16:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbhKIPj0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Nov 2021 10:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhKIPjZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Nov 2021 10:39:25 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4AEC061764;
        Tue,  9 Nov 2021 07:36:39 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so3037439otl.3;
        Tue, 09 Nov 2021 07:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RR3QN0NI9RVBRz+V6Hj1u5sfZyMJiXNLDpbhxazT2xs=;
        b=jQX16Zh4v0keepX9fXwhdZKw5A+hf/Fb9v0N6E0OK5UVkjX3rRGsJgVXxsM0BsGyTg
         SiONozkAwCo+LjPxaHUP5hKxf1z/YYdnObsp/8zI7nQWyXNjR0cY7RW0MLAkxKxciQW/
         YH0QwCYSm46w9dExO0kmH0zuqMJBAadrBbN6x3O4AA+58x2kuNcwntZbPPZjxkmQydAt
         D06E9B6C8Faxxahh8qraL1FRkvO/31KM+Y4hCVFIAOnzUz6uZ8SSU1TlNv3LIw4/ExgK
         vVHTOJ+Fz+ey9oGczzW54YRJ8Hk93mEdnVYiSga8JcYaAGv3BUgb8YhfWnQWBLQit4Z/
         +2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RR3QN0NI9RVBRz+V6Hj1u5sfZyMJiXNLDpbhxazT2xs=;
        b=b9hoJhlrFF4xCKRMoq+x9vxZQlUrq0JXNs2vBJLSOO0cKx85eK9wGwYidoOBMqOOxx
         M7U1h4iqYhQaUWGe4JXjSE7VYljkAmOvwTK1lL2NONaOJjaBF+5HMsdSJo8fKegvzwJV
         1IcoJTCAfA57pWZ05Ps5ZpzR1CGAvG4CNVD2uOycrww5kt2pZt0Am1/2VKI0jkeIpvsU
         4SIbCKON0bPP57vdzwH0mnlv2TmKrG2mdanlruxtHGBmUtf0ICd7FscF120vUHSW37SQ
         9rO2mbYLgZeYOFnsq0bTu4SYqzvvkBIcDQEYNH5JvMbs1gaoTduZf4Oe1GsIxhl6z/Gb
         N29g==
X-Gm-Message-State: AOAM533ynfJWqWWSJw4fVw20muxfTXjnsfIVEaC8zKyWdRxGXxraxoj/
        wkA/aLf1Vm21D1o16/3f+s4=
X-Google-Smtp-Source: ABdhPJz7daEraPWgwpUSKrpiEQJR1Cdy3WKcjo2W3Lc8WGK5g6FVCGsK6E3uFRKG7IbYztNzuzt9SQ==
X-Received: by 2002:a9d:de1:: with SMTP id 88mr6619869ots.286.1636472198867;
        Tue, 09 Nov 2021 07:36:38 -0800 (PST)
Received: from ?IPV6:2603:8081:2802:9dfb:4d0e:8889:a357:613e? (2603-8081-2802-9dfb-4d0e-8889-a357-613e.res6.spectrum.com. [2603:8081:2802:9dfb:4d0e:8889:a357:613e])
        by smtp.gmail.com with ESMTPSA id e28sm7606758oiy.10.2021.11.09.07.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 07:36:38 -0800 (PST)
Message-ID: <912e5d6c-b6d2-d4b7-d3f3-8c6624a14eb6@gmail.com>
Date:   Tue, 9 Nov 2021 09:36:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: HW power fault defect cause system hang on kernel 5.4.y
Content-Language: en-US
To:     "Bao, Joseph" <joseph.bao@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
References: <DM8PR11MB5702255A6A92F735D90A4446868B9@DM8PR11MB5702.namprd11.prod.outlook.com>
 <20211102223401.GA651784@bhelgaas>
 <DM8PR11MB570219FE94A7983E0F61A3BA86929@DM8PR11MB5702.namprd11.prod.outlook.com>
From:   stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <DM8PR11MB570219FE94A7983E0F61A3BA86929@DM8PR11MB5702.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/9/2021 1:59 AM, Bao, Joseph wrote:
> Hi Lukas/Stuart,
> Want to follow up with you whether the system hang is expected when HW has a defect keeping PCI_EXP_SLTSTA_PFD always HIGH.
> 
> 
> Regards
> Joseph
> 

It does appear that the code will hang when pciehp_isr sees PFD high and
power_fault_detected isn't yet set, if PFD doesn't clear when a 1 is
written to it.  It will continue to loop trying to clear it, and
power_fault_detected won't get set until after it gets through this loop.

It wouldn't be hard to modify that code to only attempt to clear each bit
once.  I wouldn't expect the same event bit to get set twice within this
loop, so this might fix it (I did not test).  Alternately, a loop counter
could be added to prevent it from looping more than some arbitrary number
(6?) of times in case of stuck bits.

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 3024d7e85e6a..3e502b4e8ef7 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -594,7 +594,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
  	struct controller *ctrl = (struct controller *)dev_id;
  	struct pci_dev *pdev = ctrl_dev(ctrl);
  	struct device *parent = pdev->dev.parent;
-	u16 status, events = 0;
+	u16 changed, status, events = 0;
  
  	/*
  	 * Interrupts only occur in D3hot or shallower and only if enabled
@@ -643,6 +643,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
  	if (ctrl->power_fault_detected)
  		status &= ~PCI_EXP_SLTSTA_PFD;
  
+	changed = status ^ events;
  	events |= status;
  	if (!events) {
  		if (parent)
@@ -659,7 +660,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
  		 * So re-read the Slot Status register in case a bit was set
  		 * between read and write.
  		 */
-		if (pci_dev_msi_enabled(pdev) && !pciehp_poll_mode)
+		if (pci_dev_msi_enabled(pdev) && !pciehp_poll_mode && changed)
  			goto read_status;
  	}
  


> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>> Sent: Wednesday, November 3, 2021 6:34 AM
> To: Bao, Joseph <joseph.bao@intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Stuart Hayes <stuart.w.hayes@gmail.com>; Lukas Wunner <lukas@wunner.de>
> Subject: Re: HW power fault defect cause system hang on kernel 5.4.y
> 
> [+cc Stuart, author of 8edf5332c393 ("PCI: pciehp: Fix MSI interrupt race"), Lukas, pciehp expert]
> 
> On Tue, Nov 02, 2021 at 03:45:00AM +0000, Bao, Joseph wrote:
>> Hi, dear kernel developer,
>>
>> Recently we encounter system hang (dead spinlock) when move to kernel
>> linux-5.4.y.
>>
>> Finally, we use bisect to locate the suspicious commit
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.4.y&id=4667358dab9cc07da044d5bc087065545b1000df.
> 
> 4667358dab9c backported upstream commit 8edf5332c393 ("PCI: pciehp:
> Fix MSI interrupt race") to v5.4.69 just over a year ago.
> 
>> Our system has some HW defect, which will wrongly set
>> PCI_EXP_SLTSTA_PFD high, and this commit will lead to infinite loop
>> jumping to read_status (no chance to clear status PCI_EXP_SLTSTA_PFD
>> bit since ctrl is not updated), I know this is our HW defect, but this
>> commit makes kernel trapped in this isr function and leads to kernel
>> hang (then the user could not get useful information to show what's
>> wrong), which I think is not expected behavior, so I would like to
>> report to you for discussion.
> 
> I guess this happens because the first time we handle PFD,
> pciehp_ist() sets "ctrl->power_fault_detected = 1", and when power_fault_detected is set, pciehp_isr() won't clear PFD from PCI_EXP_SLTSTA?
> 
> It looks like the only place we clear power_fault_detected is in pciehp_power_on_slot(), and I don't think we call that unless we have a presence detect or link status change.
> 
> It would definitely be nice if we could arrange so this hardware defect didn't cause a kernel hang.
> 
> I think the diff below is the backport of 8edf5332c393 ("PCI: pciehp:
> Fix MSI interrupt race").
> 
>> diff --git a/drivers/pci/hotplug/pciehp_hpc.c
>> b/drivers/pci/hotplug/pciehp_hpc.c
>> index 356786a3b7f4b..88b996764ff95 100644
>> ---
>> a/https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tre
>> e/drivers/pci/hotplug/pciehp_hpc.c?h=linux-5.4.y&id=ca767cf0152d18fc29
>> 9cde85b18d1f46ac21e1ba
>> +++ b/https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
>> +++ /tree/drivers/pci/hotplug/pciehp_hpc.c?h=linux-5.4.y&id=4667358dab
>> +++ 9cc07da044d5bc087065545b1000df
>> @@ -529,7 +529,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>>   	struct controller *ctrl = (struct controller *)dev_id;
>>   	struct pci_dev *pdev = ctrl_dev(ctrl);
>>   	struct device *parent = pdev->dev.parent;
>> -	u16 status, events;
>> +	u16 status, events = 0;
>>   
>>   	/*
>>   	 * Interrupts only occur in D3hot or shallower and only if enabled
>> @@ -554,6 +554,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>>   		}
>>   	}
>>   
>> +read_status:
>>   	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
>>   	if (status == (u16) ~0) {
>>   		ctrl_info(ctrl, "%s: no response from device\n", __func__); @@
>> -566,24 +567,37 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>>   	 * Slot Status contains plain status bits as well as event
>>   	 * notification bits; right now we only want the event bits.
>>   	 */
>> -	events = status & (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
>> -			   PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_CC |
>> -			   PCI_EXP_SLTSTA_DLLSC);
>> +	status &= PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
>> +		  PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_CC |
>> +		  PCI_EXP_SLTSTA_DLLSC;
>>   
>>   	/*
>>   	 * If we've already reported a power fault, don't report it again
>>   	 * until we've done something to handle it.
>>   	 */
>>   	if (ctrl->power_fault_detected)
>> -		events &= ~PCI_EXP_SLTSTA_PFD;
>> +		status &= ~PCI_EXP_SLTSTA_PFD;
>>   
>> +	events |= status;
>>   	if (!events) {
>>   		if (parent)
>>   			pm_runtime_put(parent);
>>   		return IRQ_NONE;
>>   	}
>>   
>> -	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, events);
>> +	if (status) {
>> +		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, events);
>> +
>> +		/*
>> +		 * In MSI mode, all event bits must be zero before the port
>> +		 * will send a new interrupt (PCIe Base Spec r5.0 sec 6.7.3.4).
>> +		 * So re-read the Slot Status register in case a bit was set
>> +		 * between read and write.
>> +		 */
>> +		if (pci_dev_msi_enabled(pdev) && !pciehp_poll_mode)
>> +			goto read_status;
>> +	}
>> +
>>   	ctrl_dbg(ctrl, "pending interrupts %#06x from Slot Status\n", events);
>>   	if (parent)
>>   		pm_runtime_put(parent);
