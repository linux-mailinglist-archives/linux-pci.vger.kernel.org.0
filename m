Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B4D3B49CC
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 22:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhFYUlH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Jun 2021 16:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhFYUlH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jun 2021 16:41:07 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42286C061574
        for <linux-pci@vger.kernel.org>; Fri, 25 Jun 2021 13:38:45 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 84so12744982oie.2
        for <linux-pci@vger.kernel.org>; Fri, 25 Jun 2021 13:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1L5le695Ym2CUBoVToCTjeQOuAZdS6iOsXc6nqXldrc=;
        b=BkAlsTtHDnokPGDRGwaXKVm2hCybdF4YIQqJZFeqqDIhhfpoGCSMPUHtDTwj2knw48
         wx/uxfKNYXaG6m50SCdoAZCXh3rfebLSPTPhXBXKNErRcwxCjqgQu65wUjYsUxauaDAw
         FF9nVU2meBQXT9zzztlcFi2lKg9Dcvkp4dw5XIgBJ9CGO7ZYS+fDQ6ugYw2S8NQwE4cl
         vQXRMOmj0pW6tlobMMk8H6217RG61ayyXPms73w4y91xBl0q/CeeqdZPqgyycuhWVDbu
         mLQhWJQtHv+QaqZF9L4lGU+0c7UXugPoBmPfPVhEcKon6KxIJliBIDujCEeFDQ+ruQro
         pl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1L5le695Ym2CUBoVToCTjeQOuAZdS6iOsXc6nqXldrc=;
        b=aHAHdjNDmRAve7ThaGXkGfHmV9pKrsTGB8Y7Zj6aiWbxZsfMDXt3hZrndDrfqFOtod
         J8g+LmDQ2ifRUjeIFkdHEHkmc5GkSA97tUQq9v3EB9kn3X1npYlqEKocOvSauNP5mHbS
         khLU0lIO2iH4lcMHzyGKQ4Kt1KeU5q2KfGw1Rnbo5iZ2b10vX3erwKCEeLFBzuGIXBGt
         5wTw7Qb6PaeaNvt/IV/coqoImjCV59tRpK26jYDzfN9UcXQvg04XH4k5pWtgElYoVOP5
         aSawWf15+8oPKFpLFvc7MmoboKm5w9xvo6tJa1kD9pd6Btlvs+SKEBulmuSTXVh4ViV7
         lC9g==
X-Gm-Message-State: AOAM530DL5FfC2HaDTcwqNInhmE/DV+up667MSupj5j4nYzWqD5c32st
        muZ6jmuKkG5nm1B/Nu+LoNg=
X-Google-Smtp-Source: ABdhPJyaALdzaPMmcS5DUZSUin9dCt24Vf5KFg8wZKa/IyPpT2EyJ8yz/Fzzn1wLgpMcJHiB6JuRjg==
X-Received: by 2002:aca:bb46:: with SMTP id l67mr9480684oif.74.1624653524440;
        Fri, 25 Jun 2021 13:38:44 -0700 (PDT)
Received: from ?IPv6:2603:8081:2802:9dfb:bc6a:3c7b:6677:d2be? (2603-8081-2802-9dfb-bc6a-3c7b-6677-d2be.res6.spectrum.com. [2603:8081:2802:9dfb:bc6a:3c7b:6677:d2be])
        by smtp.gmail.com with ESMTPSA id n35sm1594680otn.9.2021.06.25.13.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 13:38:43 -0700 (PDT)
Subject: Re: [PATCH v2] PCI: pciehp: Ignore Link Down/Up caused by DPC
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ethan Zhao <haifeng.zhao@intel.com>,
        Sinan Kaya <okaya@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-pci@vger.kernel.org, Russell Currey <ruscur@russell.cc>,
        Oliver OHalloran <oohall@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <0be565d97438fe2a6d57354b3aa4e8626952a00b.1619857124.git.lukas@wunner.de>
 <20210616221945.GA3010216@bjorn-Precision-5520>
 <20210620073804.GA13118@wunner.de>
From:   stuart hayes <stuart.w.hayes@gmail.com>
Message-ID: <08c046b0-c9f2-3489-eeef-7e7aca435bb9@gmail.com>
Date:   Fri, 25 Jun 2021 15:38:41 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210620073804.GA13118@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/20/2021 2:38 AM, Lukas Wunner wrote:
> On Wed, Jun 16, 2021 at 05:19:45PM -0500, Bjorn Helgaas wrote:
>> On Sat, May 01, 2021 at 10:29:00AM +0200, Lukas Wunner wrote:
>>> Downstream Port Containment (PCIe Base Spec, sec. 6.2.10) disables the
>>> link upon an error and attempts to re-enable it when instructed by the
>>> DPC driver.
>>>
>>> A slot which is both DPC- and hotplug-capable is currently brought down
>>> by pciehp once DPC is triggered (due to the link change) and brought up
>>> on successful recovery.  That's undesirable, the slot should remain up
>>> so that the hotplugged device remains bound to its driver.
>>
>> I think the slot being "brought down" means slot power is turned off,
>> right?
>>
>> I reworded it along those lines and applied this to pci/hotplug for
>> v5.14, thanks!
> 
> Thanks, the reworded commit message LGTM and is more readable.
> 
> "Being brought down" is just a colloquial term for pciehp_disable_slot(),
> i.e. unbinding and removal of the pci_dev's below the hotplug port,
> removing slot power, turning off the power LED and setting the slot's
> state to OFF_STATE.
> 
> Indeed, turning off slot power concurrently to DPC recovery is wrong
> and likely the biggest contributor to the problems seen.
> 
> Another issue is that after bringing down the slot due to the Link Change
> event, pciehp will notice that Presence Detect State is set and will try
> to bring the slot up again, even though DPC recovery may not have completed
> yet.
> 
> The commit should solve all those synchronization issues between pciehp
> and DPC.
> 
> Thanks,
> 
> Lukas
> 

Lukas--

I have a system that is failing to recover after an EDR event with (or 
without...) this patch.  It looks like the problem is similar to what 
this patch is trying to fix, except that on my system, the hotplug port 
is downstream of the root port that has DPC, so the "link down" event on 
it is not being ignored.  So the hotplug code disables the slot (which 
contains an NVMe device on this system) while the nvme driver is trying 
to use it, which results in a failed recovery and another EDR event, and 
the kernel ends up with the DPC trigger status bit set in the root port, 
so everything downstream is gone.

I added the hack below so the hotplug code will ignore the "link down" 
events on the ports downstream of the root port during DPC recovery, and 
it recovers no problem.  (I'm not proposing this as a correct fix.)

Does this sound like a real issue, or am I possibly misunderstanding 
something about how this should work?

Thanks
Stuart

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index b576aa890c76..dfd983c3c5bf 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -119,8 +132,10 @@ static int report_slot_reset(struct pci_dev *dev, 
void *data)
  		!dev->driver->err_handler->slot_reset)
  		goto out;

+	set_bit(PCI_DPC_RECOVERING, &dev->priv_flags);
  	err_handler = dev->driver->err_handler;
  	vote = err_handler->slot_reset(dev);
+	clear_bit(PCI_DPC_RECOVERING, &dev->priv_flags);
  	*result = merge_result(*result, vote);
  out:
  	device_unlock(&dev->dev);

