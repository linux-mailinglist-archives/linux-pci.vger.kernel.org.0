Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC4A3CC0C2
	for <lists+linux-pci@lfdr.de>; Sat, 17 Jul 2021 04:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbhGQCq6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jul 2021 22:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbhGQCq6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jul 2021 22:46:58 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94918C06175F
        for <linux-pci@vger.kernel.org>; Fri, 16 Jul 2021 19:44:01 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id p67so13311062oig.2
        for <linux-pci@vger.kernel.org>; Fri, 16 Jul 2021 19:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bmlEnPOKgfIO2z3IyeC41bhkbZbLqUNwpemYc6rL7cw=;
        b=oaQOJwki9tlOcO1eJlQ/dmJalpsQALuScSRjPvY/1nziDADrVMaqFllvvU+o00cR9y
         Cc+C8nVAHeEW3zssfe6mfK613KGrVxqFyUxgoaIFNK43D68CN0ncDpUjdAQkKiq451Pe
         P4TwyG4FZogVa1O+JSpR6bFzQFOoe7So0a+26+Ku6tANSzbiZrvnvyc01M3cOVb/n3Uo
         7U4Oa7CzKS9PBOeEqMkNsAAtzpkfyyo92b3ZlGLKegy48lz3MSq+X4bLRATObBdNDRbT
         aPH3i9EXzxWlQ2RFDVSV+y5PNZSagGKgLx1kbFnX8RzBZfR+s53vPbiDu+ZpFpJUyYNk
         ZdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bmlEnPOKgfIO2z3IyeC41bhkbZbLqUNwpemYc6rL7cw=;
        b=bJ9DOcLUAHpiWmTVSLgTXS3dnfscRseRYD6I9uMWaRxLMyliPv3DK31nXyIKReGYKh
         w6RFE0UHhMCVR+CXJxsKyyE/J6wcoIJT2TMCQ0hTs9ycslQJtoJKijAWOARJPURnTDoH
         pcbwndQa1tu/+KqGiW0+89PD8NEnU4QbjP/46JwnP7mC/j/feUgLv4/6eStV6hNkCe5I
         IXwsbMiUQEv4KKoCuYvj5/hViQgaFxMzTT6D2mBSiK/Fk7TDVWFaudXpULM5FSaBjPNl
         dOrPnHD7zgsgPH9/vFUEAglcxVq4oxxVvzstsRX0/yqp1LCdQKLWvQRb602HnMmP9cRM
         h2bA==
X-Gm-Message-State: AOAM530gJHBY0PBpjiXNFYJkqTZ1F16cBxLB+dipNyydMhD1KWpwlbi5
        rISugFeDFgOLhtlRcc4Q0Rk9FPYpFFxElg==
X-Google-Smtp-Source: ABdhPJz8gMjhsjiBv2QZ7y93xJMVRJzqh4JEavPIsO6qxKgbHakG8tJbs0w5irETNkAXa0cusmCXAg==
X-Received: by 2002:aca:1308:: with SMTP id e8mr14763444oii.168.1626489840954;
        Fri, 16 Jul 2021 19:44:00 -0700 (PDT)
Received: from ?IPv6:2603:8081:2802:9dfb:49b3:8e2:3d6d:26c8? (2603-8081-2802-9dfb-49b3-08e2-3d6d-26c8.res6.spectrum.com. [2603:8081:2802:9dfb:49b3:8e2:3d6d:26c8])
        by smtp.gmail.com with ESMTPSA id q9sm2286269otk.18.2021.07.16.19.44.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 19:44:00 -0700 (PDT)
Subject: Re: [PATCH v2] PCI/portdrv: Use link bandwidth notification
 capability bit
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>
References: <20210716215647.GA2146665@bjorn-Precision-5520>
From:   stuart hayes <stuart.w.hayes@gmail.com>
Message-ID: <b49039c4-3c31-5b0e-a7be-a01355e166dd@gmail.com>
Date:   Fri, 16 Jul 2021 21:43:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716215647.GA2146665@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/16/2021 4:56 PM, Bjorn Helgaas wrote:
> On Thu, May 13, 2021 at 03:03:14AM +0530, Stuart Hayes wrote:
>> The pcieport driver can fail to attach to a downstream port that doesn't
>> support bandwidth notification.  This can happen when, in
>> pcie_port_device_register(), pci_init_service_irqs() tries (and fails) to
>> set up a bandwidth notification IRQ for a device that doesn't support it.
> 
> I'm trying to figure out exactly how this fails.  The only failure
> path in pcie_init_service_irqs() is when
> pci_alloc_irq_vectors(PCI_IRQ_LEGACY) fails, which I guess means the
> port's dev->irq was zero?
> 

Yes... dev->irq is zero.  Here's "lspci -v "for the device in case it helps:

66:00.0 PCI bridge: Broadcom / LSI PEX880xx PCIe Gen 4 Switch (rev b0) 
(prog-if 00 [Normal decode])
         Flags: bus master, fast devsel, latency 0, NUMA node 0
         Bus: primary=66, secondary=67, subordinate=70, sec-latency=0
         I/O behind bridge: [disabled]
         Memory behind bridge: be000000-bf4fffff [size=21M]
         Prefetchable memory behind bridge: 
00000d0000000000-00000d00017fffff [size=24M]
         Capabilities: [40] Power Management version 3
         Capabilities: [68] Express Downstream Port (Slot-), MSI 00
         Capabilities: [a4] Subsystem: Broadcom / LSI Device a064
         Capabilities: [100] Device Serial Number 00-80-5e-10-56-39-53-50
         Capabilities: [fb4] Advanced Error Reporting
         Capabilities: [148] Virtual Channel
         Capabilities: [b70] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
         Capabilities: [e00] Multicast
         Capabilities: [f24] Access Control Services

> And to even attempt legacy IRQs, either we had pcie_pme_no_msi() or
> pcie_port_enable_irq_vec() failed?
> 

pcie_port_enable_irq_vec() failed.  I don't believe this device has the 
ability to generate interrupts.

>> This patch changes get_port_device_capability() to look at the link
>> bandwidth notification capability bit in the link capabilities register of
>> the port, instead of assuming that all downstream ports have that
>> capability.
> 
> I think this needs:
> 
>    Fixes: e8303bb7a75c ("PCI/LINK: Report degraded links via link bandwidth notification")
> 
> because even though b4c7d2076b4e ("PCI/LINK: Remove bandwidth
> notification") removed *most* of e8303bb7a75c, it did not remove the
> code in get_port_device_capability() that you're fixing here.
> 
> I can fix this up locally, no need to resend.  I think the patch
> itself is fine, just trying to understand the commit log.
> 

Thank you!


>> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
>> Reviewed-by: Lukas Wunner <lukas@wunner.de>
>> ---
>>
>> changes from v1:
>> 	- corrected spelling errors in commit message
>> 	- added Lukas' reviewed-by:
>>
>> ---
>>   drivers/pci/pcie/portdrv_core.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
>> index e1fed6649c41..3ee63968deaa 100644
>> --- a/drivers/pci/pcie/portdrv_core.c
>> +++ b/drivers/pci/pcie/portdrv_core.c
>> @@ -257,8 +257,13 @@ static int get_port_device_capability(struct pci_dev *dev)
>>   		services |= PCIE_PORT_SERVICE_DPC;
>>   
>>   	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
>> -	    pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
>> -		services |= PCIE_PORT_SERVICE_BWNOTIF;
>> +	    pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
>> +		u32 linkcap;
>> +
>> +		pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &linkcap);
>> +		if (linkcap & PCI_EXP_LNKCAP_LBNC)
>> +			services |= PCIE_PORT_SERVICE_BWNOTIF;
>> +	}
>>   
>>   	return services;
>>   }
>> -- 
>> 2.27.0
>>
