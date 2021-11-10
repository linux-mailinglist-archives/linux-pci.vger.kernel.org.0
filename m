Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B2344C4BB
	for <lists+linux-pci@lfdr.de>; Wed, 10 Nov 2021 16:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhKJP7n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Nov 2021 10:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbhKJP7n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Nov 2021 10:59:43 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC3AC061764;
        Wed, 10 Nov 2021 07:56:55 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id t19so6096872oij.1;
        Wed, 10 Nov 2021 07:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AuJxsO7KTO/hpmKYv4YTvzchts2QUUvDZsXG6/D9BhE=;
        b=H03nDMDtviKlPIX4YSrumSYVD/e65kt/m+Td06j2CRGEPRrieLdNRTnfZa4XNFYd3i
         tZCqLyMULpNwSb4KuKAasSKtomAN5pAZ2yw5qPl6G0QkTu025QpaKGbYrM7HwrfYsk00
         TVlJv799cCvkcL7hpiED2CGzSvQn7u3t9l1CWKQvv7+HB6Lbs3H0rBgupMLbmfYzZfJk
         LiJWm0UYeKmNov8XzQCwWMap4iTbbX32uClM5AoAODQ+KoUk4k9nqufvvrDUyl3At+A6
         M2q/2YOxAPbzb3JKsHhh/xlSsKpNxyaZU59Jde8LHzUcZEsq9UC9pWOlzy4hw2zeLYWd
         jUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AuJxsO7KTO/hpmKYv4YTvzchts2QUUvDZsXG6/D9BhE=;
        b=NRw0rmAjDc/BTQtGjwb4jTqX9YDVGnjlSrLMiO6T9mT7KOZ/TY1jgt4ym4rDYbcNHm
         2UL604d7/WwjCsMznwf6tSpUwBHKeTNihCaflrD8Gcp1uLGLhIc3hSxPi481zjO9Y466
         Hk5WHbmtiwQubeLnwDqxYuyw78PFhyU+mchVURPSfz+cLPzUD2nA8S6MxLAjEsep2nEh
         IXSBBwBnx+tjTPYlF1KLMz+HwV8NWoruwcNsSagAcYri8862DT6JmAIZ7InCVBOjX5cO
         3LRSmChZ/a/13xp4KE3pkn4cV95RYi6U/hVgbLbCMNHmqK+1NQK5SKWHqChmrRgRctvA
         eQDg==
X-Gm-Message-State: AOAM531kAdOEnCQ8Eh9zE29L0sT04Ly5rMfXK7UmwECoVzMuwaM2usy4
        e8vb/QvnnBHBnT8sox9R4Kv/y9gRO3M=
X-Google-Smtp-Source: ABdhPJxSf3Fd5gca9QiirazhCJemRYqVi7EKrdbcgNfD+rCn6YxARCojOkX2qzMsQJe8e12lCYGZIQ==
X-Received: by 2002:a05:6808:b0d:: with SMTP id s13mr124140oij.53.1636559814500;
        Wed, 10 Nov 2021 07:56:54 -0800 (PST)
Received: from ?IPV6:2603:8081:2802:9dfb:e414:9d10:17d8:2a45? (2603-8081-2802-9dfb-e414-9d10-17d8-2a45.res6.spectrum.com. [2603:8081:2802:9dfb:e414:9d10:17d8:2a45])
        by smtp.gmail.com with ESMTPSA id y28sm29748oix.57.2021.11.10.07.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 07:56:53 -0800 (PST)
Message-ID: <1cb9c906-826b-5eb9-af45-41a2e0987428@gmail.com>
Date:   Wed, 10 Nov 2021 09:56:52 -0600
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
 <912e5d6c-b6d2-d4b7-d3f3-8c6624a14eb6@gmail.com>
 <DM8PR11MB570293D37A0027753CEE3F8386939@DM8PR11MB5702.namprd11.prod.outlook.com>
From:   stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <DM8PR11MB570293D37A0027753CEE3F8386939@DM8PR11MB5702.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/10/2021 3:20 AM, Bao, Joseph wrote:
> Hi Stuart,
> The patch you attached does not work for me, the logic should be ok but I have not figured out why. But a loop counter actually helps mitigate this issue. Thank you very much!
> 

I think I see the error in the logic... the patch I suggested yesterday would see bits that got cleared as changed and cause it to loop forever, when all we want to check for is if any new bits get set in each loop.  Maybe try this patch?  The only difference is the line "changed = status ^ (events & status);", which hopefully will only compare those status bits that are currently set against those same bits from the previous loop.


diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 3024d7e85e6a..bf8fe868a293 100644
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
  
+	changed = status ^ (events & status);
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
  


> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 88b996764ff9..3d2c336ff740 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -529,7 +529,8 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>          struct controller *ctrl = (struct controller *)dev_id;
>          struct pci_dev *pdev = ctrl_dev(ctrl);
>          struct device *parent = pdev->dev.parent;
> -       u16 status, events = 0;
> +       u16 status, events, read_retry_count = 0;
> +       u8 READ_RETRY_MAX = 6;
> 
>          /*
>           * Interrupts only occur in D3hot or shallower and only if enabled
> @@ -585,7 +586,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>                  return IRQ_NONE;
>          }
> 
> -       if (status) {
> +       if (status && (read_retry_count < READ_RETRY_MAX)) {
>                  pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, events);
> 
>                  /*
> @@ -594,8 +595,10 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>                   * So re-read the Slot Status register in case a bit was set
>                   * between read and write.
>                   */
> -               if (pci_dev_msi_enabled(pdev) && !pciehp_poll_mode)
> +               if (pci_dev_msi_enabled(pdev) && !pciehp_poll_mode) {
> +                       read_retry_count++;
>                          goto read_status;
> +               }
>          }
> Regards.
> Joseph
> 
> Regards.
> Joseph
> 
> -----Original Message-----
> From: stuart hayes <stuart.w.hayes@gmail.com>
> Sent: Tuesday, November 9, 2021 11:37 PM
> To: Bao, Joseph <joseph.bao@intel.com>; Bjorn Helgaas <helgaas@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Lukas Wunner <lukas@wunner.de>
> Subject: Re: HW power fault defect cause system hang on kernel 5.4.y
> 
> 
> 
> On 11/9/2021 1:59 AM, Bao, Joseph wrote:
>> Hi Lukas/Stuart,
>> Want to follow up with you whether the system hang is expected when HW has a defect keeping PCI_EXP_SLTSTA_PFD always HIGH.
>>
>>
>> Regards
>> Joseph
>>
> 
> It does appear that the code will hang when pciehp_isr sees PFD high and power_fault_detected isn't yet set, if PFD doesn't clear when a 1 is written to it.  It will continue to loop trying to clear it, and power_fault_detected won't get set until after it gets through this loop.
> 
> It wouldn't be hard to modify that code to only attempt to clear each bit once.  I wouldn't expect the same event bit to get set twice within this loop, so this might fix it (I did not test).  Alternately, a loop counter could be added to prevent it from looping more than some arbitrary number
> (6?) of times in case of stuck bits.
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 3024d7e85e6a..3e502b4e8ef7 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -594,7 +594,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>    	struct controller *ctrl = (struct controller *)dev_id;
>    	struct pci_dev *pdev = ctrl_dev(ctrl);
>    	struct device *parent = pdev->dev.parent;
> -	u16 status, events = 0;
> +	u16 changed, status, events = 0;
>    
>    	/*
>    	 * Interrupts only occur in D3hot or shallower and only if enabled @@ -643,6 +643,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>    	if (ctrl->power_fault_detected)
>    		status &= ~PCI_EXP_SLTSTA_PFD;
>    
> +	changed = status ^ events;
>    	events |= status;
>    	if (!events) {
>    		if (parent)
> @@ -659,7 +660,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>    		 * So re-read the Slot Status register in case a bit was set
>    		 * between read and write.
>    		 */
> -		if (pci_dev_msi_enabled(pdev) && !pciehp_poll_mode)
> +		if (pci_dev_msi_enabled(pdev) && !pciehp_poll_mode && changed)
>    			goto read_status;
>    	}
>    
> 
> 
>> -----Original Message-----
>> From: Bjorn Helgaas <helgaas@kernel.org>> Sent: Wednesday, November 3,
>> 2021 6:34 AM
>> To: Bao, Joseph <joseph.bao@intel.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org;
>> linux-kernel@vger.kernel.org; Stuart Hayes <stuart.w.hayes@gmail.com>;
>> Lukas Wunner <lukas@wunner.de>
>> Subject: Re: HW power fault defect cause system hang on kernel 5.4.y
>>
>> [+cc Stuart, author of 8edf5332c393 ("PCI: pciehp: Fix MSI interrupt
>> race"), Lukas, pciehp expert]
>>
>> On Tue, Nov 02, 2021 at 03:45:00AM +0000, Bao, Joseph wrote:
>>> Hi, dear kernel developer,
>>>
>>> Recently we encounter system hang (dead spinlock) when move to kernel
>>> linux-5.4.y.
>>>
>>> Finally, we use bisect to locate the suspicious commit
>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.4.y&id=4667358dab9cc07da044d5bc087065545b1000df.
>>
>> 4667358dab9c backported upstream commit 8edf5332c393 ("PCI: pciehp:
>> Fix MSI interrupt race") to v5.4.69 just over a year ago.
>>
>>> Our system has some HW defect, which will wrongly set
>>> PCI_EXP_SLTSTA_PFD high, and this commit will lead to infinite loop
>>> jumping to read_status (no chance to clear status PCI_EXP_SLTSTA_PFD
>>> bit since ctrl is not updated), I know this is our HW defect, but
>>> this commit makes kernel trapped in this isr function and leads to
>>> kernel hang (then the user could not get useful information to show
>>> what's wrong), which I think is not expected behavior, so I would
>>> like to report to you for discussion.
>>
>> I guess this happens because the first time we handle PFD,
>> pciehp_ist() sets "ctrl->power_fault_detected = 1", and when power_fault_detected is set, pciehp_isr() won't clear PFD from PCI_EXP_SLTSTA?
>>
>> It looks like the only place we clear power_fault_detected is in pciehp_power_on_slot(), and I don't think we call that unless we have a presence detect or link status change.
>>
>> It would definitely be nice if we could arrange so this hardware defect didn't cause a kernel hang.
>>
>> I think the diff below is the backport of 8edf5332c393 ("PCI: pciehp:
>> Fix MSI interrupt race").
>>
>>> diff --git a/drivers/pci/hotplug/pciehp_hpc.c
>>> b/drivers/pci/hotplug/pciehp_hpc.c
>>> index 356786a3b7f4b..88b996764ff95 100644
>>> ---
>>> a/https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tr
>>> e
>>> e/drivers/pci/hotplug/pciehp_hpc.c?h=linux-5.4.y&id=ca767cf0152d18fc2
>>> 9
>>> 9cde85b18d1f46ac21e1ba
>>> +++ b/https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi
>>> +++ t
>>> +++ /tree/drivers/pci/hotplug/pciehp_hpc.c?h=linux-5.4.y&id=4667358da
>>> +++ b
>>> +++ 9cc07da044d5bc087065545b1000df
>>> @@ -529,7 +529,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>>>    	struct controller *ctrl = (struct controller *)dev_id;
>>>    	struct pci_dev *pdev = ctrl_dev(ctrl);
>>>    	struct device *parent = pdev->dev.parent;
>>> -	u16 status, events;
>>> +	u16 status, events = 0;
>>>    
>>>    	/*
>>>    	 * Interrupts only occur in D3hot or shallower and only if enabled
>>> @@ -554,6 +554,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>>>    		}
>>>    	}
>>>    
>>> +read_status:
>>>    	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
>>>    	if (status == (u16) ~0) {
>>>    		ctrl_info(ctrl, "%s: no response from device\n", __func__); @@
>>> -566,24 +567,37 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>>>    	 * Slot Status contains plain status bits as well as event
>>>    	 * notification bits; right now we only want the event bits.
>>>    	 */
>>> -	events = status & (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
>>> -			   PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_CC |
>>> -			   PCI_EXP_SLTSTA_DLLSC);
>>> +	status &= PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
>>> +		  PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_CC |
>>> +		  PCI_EXP_SLTSTA_DLLSC;
>>>    
>>>    	/*
>>>    	 * If we've already reported a power fault, don't report it again
>>>    	 * until we've done something to handle it.
>>>    	 */
>>>    	if (ctrl->power_fault_detected)
>>> -		events &= ~PCI_EXP_SLTSTA_PFD;
>>> +		status &= ~PCI_EXP_SLTSTA_PFD;
>>>    
>>> +	events |= status;
>>>    	if (!events) {
>>>    		if (parent)
>>>    			pm_runtime_put(parent);
>>>    		return IRQ_NONE;
>>>    	}
>>>    
>>> -	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, events);
>>> +	if (status) {
>>> +		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, events);
>>> +
>>> +		/*
>>> +		 * In MSI mode, all event bits must be zero before the port
>>> +		 * will send a new interrupt (PCIe Base Spec r5.0 sec 6.7.3.4).
>>> +		 * So re-read the Slot Status register in case a bit was set
>>> +		 * between read and write.
>>> +		 */
>>> +		if (pci_dev_msi_enabled(pdev) && !pciehp_poll_mode)
>>> +			goto read_status;
>>> +	}
>>> +
>>>    	ctrl_dbg(ctrl, "pending interrupts %#06x from Slot Status\n", events);
>>>    	if (parent)
>>>    		pm_runtime_put(parent);
