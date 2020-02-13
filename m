Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFEF15CBD5
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 21:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgBMUTS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Feb 2020 15:19:18 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46810 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgBMUTS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2020 15:19:18 -0500
Received: by mail-oi1-f196.google.com with SMTP id a22so7096240oid.13;
        Thu, 13 Feb 2020 12:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Bfr+esBsHNaFRTQzYPRTVOspPKJf2wCefrCUUIjTbrM=;
        b=NPUn1NnqWMHNRr9KUxHDsJXvr20A4UQ+WdrH80a6RRn0IunEBBtMaO5vUSmsoNGxHa
         42Y8zL9NtLkzgoqXiAfaRQBJB99tyLLcNkfQd6fQ8Ky6mc5ipCanm8yigkxQGUxEcm4e
         IXuDbI8INxiq2595087Si5qhClXNHIiEMfmYeaxOjYwHAesyJARK8OycsAhQIQnsGEhL
         xNBxsTsjSnCHE5JRMoxWYiO0+p+ov4nmMupyvQfSSUQnObWuY1zQW/Y9CPtWEny06SYl
         L8BjVTJnzPYZMYYCV4zG8VVHrw77hLBuzXNaNvtKkI5I278pZLk0gx7/HIAnJ0N6l7JS
         ltOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bfr+esBsHNaFRTQzYPRTVOspPKJf2wCefrCUUIjTbrM=;
        b=aOcYxdbQOBBUvKy2wDPGQ5b2ukOru3AZilqvdF0EpsbSoZIdE8SMoWK93kojSBaOn6
         N2jm9IBAf8DJmweM4hQfJmalSCaL+/KuWJzkcJz3MzVkDNqJRIh/sRz7m05W6aJWvMya
         eXoGIOO9wQJntrlH1kH3j+dvq+6mjgk7M4GzH8eB1yweMwBtX+szdHhT2wP3EgfsHPJv
         HX00p5Sel2QvpPfPKhHwhz7F0G+Cj+307LN/hM1GhE5yxodmnxHQKCcL7eZP4vLBgkHN
         DbNh+/OPrMBLrxoNhge9AGAAz1xaSxa2fqsRxyezbwYShhTYjmvp+ZMGrISa9xvmnKgr
         V5rA==
X-Gm-Message-State: APjAAAW5yUEgd1gecPpwD5LkUaX4Qr46JPekyhkKt800zhIKvjAbtUpi
        F7YetupAYuAMjutGgjaD4TI=
X-Google-Smtp-Source: APXvYqzDNKV11rJwNaq95rUg/4Mu3e50MemTBFAz7q8b5nBFi6k2OjPGRoW305AblRQDLr/TOJvUhA==
X-Received: by 2002:aca:1012:: with SMTP id 18mr4002409oiq.151.1581625156920;
        Thu, 13 Feb 2020 12:19:16 -0800 (PST)
Received: from [100.71.96.87] ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id l1sm1022530oic.22.2020.02.13.12.19.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2020 12:19:15 -0800 (PST)
Subject: Re: [PATCH v3] PCI: pciehp: Make sure pciehp_isr clears interrupt
 events
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Keith Busch <kbusch@kernel.org>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, narendra_k@dell.com,
        Enzo Matsumiya <ematsumiya@suse.com>
References: <20200207195450.52026-1-stuart.w.hayes@gmail.com>
 <20200209150328.2x2zumhqbs6fihmc@wunner.de>
 <20200209180722.ikuyjignnd7ddfp5@wunner.de>
 <20200209202512.rzaqoc7tydo2ouog@wunner.de>
 <0f772c73-5616-ae7c-6808-ecefac8ebf13@gmail.com>
Message-ID: <55648b65-146c-4970-3ae9-53fee03afbd2@gmail.com>
Date:   Thu, 13 Feb 2020 14:19:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0f772c73-5616-ae7c-6808-ecefac8ebf13@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/10/20 3:40 PM, Stuart Hayes wrote:
> 
> 
> On 2/9/20 2:25 PM, Lukas Wunner wrote:
>> On Sun, Feb 09, 2020 at 07:07:22PM +0100, Lukas Wunner wrote:
>>> Actually, scratch that.  After thinking about this problem for a day
>>> I've come up with a much simpler and more elegant solution.  Could you
>>> test if the below works for you?
>>
>> Sorry, I missed a few things:
>>
>> * pm_runtime_put() is called too often in the MSI case.
>> * If only the CC bit is set or if ignore_hotplug is set, the function
>>   may return prematurely without re-reading the Slot Status register.
>> * Returning IRQ_NONE in the MSI case even though the IRQ thread was woken
>>   may incorrectly signal a spurious interrupt to the genirq code.
>>   It's better to return IRQ_HANDLED instead.
>>
>> Below is another attempt.  I'll have to take a look at this with a
>> fresh pair of eyeballs though to verify I haven't overlooked anything
>> else and also to determine if this is actually simpler than Stuart's
>> approach.  Again, the advantage here is that processing of the events
>> by the IRQ thread is sped up by not delaying it until the Slot Status
>> register has settled.
>>
>> Thanks.
>>
>> -- >8 --
>> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
>> index c3e3f53..db5baa5 100644
>> --- a/drivers/pci/hotplug/pciehp_hpc.c
>> +++ b/drivers/pci/hotplug/pciehp_hpc.c
>> @@ -530,6 +530,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>>  	struct controller *ctrl = (struct controller *)dev_id;
>>  	struct pci_dev *pdev = ctrl_dev(ctrl);
>>  	struct device *parent = pdev->dev.parent;
>> +	irqreturn_t ret = IRQ_NONE;
>>  	u16 status, events;
>>  
>>  	/*
>> @@ -553,6 +554,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>>  		}
>>  	}
>>  
>> +read_status:
>>  	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
>>  	if (status == (u16) ~0) {
>>  		ctrl_info(ctrl, "%s: no response from device\n", __func__);
>> @@ -579,13 +581,11 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>>  	if (!events) {
>>  		if (parent)
>>  			pm_runtime_put(parent);
>> -		return IRQ_NONE;
>> +		return ret;
>>  	}
>>  
>>  	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, events);
>>  	ctrl_dbg(ctrl, "pending interrupts %#06x from Slot Status\n", events);
>> -	if (parent)
>> -		pm_runtime_put(parent);
>>  
>>  	/*
>>  	 * Command Completed notifications are not deferred to the
>> @@ -595,21 +595,33 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>>  		ctrl->cmd_busy = 0;
>>  		smp_mb();
>>  		wake_up(&ctrl->queue);
>> -
>> -		if (events == PCI_EXP_SLTSTA_CC)
>> -			return IRQ_HANDLED;
>> -
>>  		events &= ~PCI_EXP_SLTSTA_CC;
>>  	}
>>  
>>  	if (pdev->ignore_hotplug) {
>>  		ctrl_dbg(ctrl, "ignoring hotplug event %#06x\n", events);
>> -		return IRQ_HANDLED;
>> +		events = 0;
>>  	}
>>  
>>  	/* Save pending events for consumption by IRQ thread. */
>>  	atomic_or(events, &ctrl->pending_events);
>> -	return IRQ_WAKE_THREAD;
>> +
>> +	/*
>> +	 * In MSI mode, all event bits must be zero before the port will send
>> +	 * a new interrupt (PCIe Base Spec r5.0 sec 6.7.3.4).  So re-read the
>> +	 * Slot Status register in case a bit was set between read and write.
>> +	 */
>> +	if (pci_dev_msi_enabled(pdev) && !pciehp_poll_mode) {
>> +		irq_wake_thread(irq, ctrl);
>> +		ret = IRQ_HANDLED;
>> +		goto read_status;
>> +	}
>> +
>> +	if (parent)
>> +		pm_runtime_put(parent);
>> +	if (events)
>> +		return IRQ_WAKE_THREAD;
>> +	return IRQ_HANDLED;
>>  }
>>  
>>  static irqreturn_t pciehp_ist(int irq, void *dev_id)
>>
> 
> I tested this patch, and it fixes the issue on my system.
> 

CCing Enzo Matsumiya.
