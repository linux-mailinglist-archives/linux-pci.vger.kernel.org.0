Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7C812B612
	for <lists+linux-pci@lfdr.de>; Fri, 27 Dec 2019 18:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfL0RPf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 27 Dec 2019 12:15:35 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52073 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfL0RPf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Dec 2019 12:15:35 -0500
Received: from mail-pj1-f69.google.com ([209.85.216.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iktD2-0002lL-Ak
        for linux-pci@vger.kernel.org; Fri, 27 Dec 2019 17:15:32 +0000
Received: by mail-pj1-f69.google.com with SMTP id f1so8284999pjg.7
        for <linux-pci@vger.kernel.org>; Fri, 27 Dec 2019 09:15:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KrWoelJmGiB71bSfb9IY5530bv8sUff/lG3OT8kddIY=;
        b=j0eYKaIKvNz79d+TRWu5J0e3U1efw1I5+yHTAChfEGqMdO2GrLhHUjMPhyE4N5y+hT
         yepz7tp7SaV/V3C8cvA+BcA78cJl16bgyD1dt8pt0OA7mL5Z+x0qeKaFyNW7eQn2Q1iZ
         PXm4ynTtgxjQ4o31kyU6KwxtlPq9EjVaaibpNhkW+viPXkAME2zTHbPFY5l8DOoOrMku
         IUG/aS7xC/zPHZ7D4SbLtPVGQY0+SRDVjxtPwSGfPn+8szROGn62o3Oa5ETMw3VWGQmQ
         CP10mmda+8ZWLw/PkJ0GHcVCVqFq2OCTdFbN8kNuo/YtH+Y47zfFR1J7PHj7Kj6Ez294
         iZPw==
X-Gm-Message-State: APjAAAUNBDR0SmsgNv2jwRkSfKsmuaQ4osLDjAHD7DhaKuIau0XkkXlp
        8L3AYzKMQnD0LVq0FNYRHHacXrhWjR7voH9TljiiMt581S/KbhbikRy7epGnWzQ5jPorMcM062S
        JW6PI2MxSEATl66crVKwY65qFdEPb3z/8DT/TGQ==
X-Received: by 2002:aa7:93ce:: with SMTP id y14mr56102167pff.185.1577466930673;
        Fri, 27 Dec 2019 09:15:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqzykHiHnrogfyc+ELP9XKCPhG/DJGzdhgr4sOoR6vPeZQUQ6bZnWl9DucoDstfKWXdUApHyBQ==
X-Received: by 2002:aa7:93ce:: with SMTP id y14mr56102051pff.185.1577466929498;
        Fri, 27 Dec 2019 09:15:29 -0800 (PST)
Received: from 2001-b011-380f-35a3-88bb-5c99-0021-8cca.dynamic-ip6.hinet.net (2001-b011-380f-35a3-88bb-5c99-0021-8cca.dynamic-ip6.hinet.net. [2001:b011:380f:35a3:88bb:5c99:21:8cca])
        by smtp.gmail.com with ESMTPSA id r2sm37569935pgv.16.2019.12.27.09.15.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Dec 2019 09:15:28 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH] PCI/PM: Report runtime wakeup is not supported if bridge
 isn't bound to driver
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <1948783.ToaVGCCZch@kreacher>
Date:   Sat, 28 Dec 2019 01:15:26 +0800
Cc:     bhelgaas@google.com, rafael.j.wysocki@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <C9708CF1-9F01-47BF-A568-53A01725AF95@canonical.com>
References: <20191227092405.29588-1-kai.heng.feng@canonical.com>
 <1948783.ToaVGCCZch@kreacher>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> On Dec 27, 2019, at 18:36, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> 
> On Friday, December 27, 2019 10:24:05 AM CET Kai-Heng Feng wrote:
>> We have a Pericom USB add-on card that has three USB controller
>> functions 06:00.[0-2], connected to bridge device 05:03.0, which is
>> connected to another bridge device 04:00.0:
>> 
>> -[0000:00]-+-00.0
>>           +-1c.6-[04-06]----00.0-[05-06]----03.0-[06]--+-00.0
>>           |                                            +-00.1
>>           |                                            \-00.2
>> 
>> When bridge device (05:03.0) and all three USB controller functions
>> (06:00.[0-2]) are runtime suspended, they don't get woken up by plugging
>> USB devices into the add-on card.
>> 
>> This is because the pcieport driver failed to probe on 04:00.0, since
>> the device supports neither legacy IRQ, MSI nor MSI-X. Because of that,
>> there's no native PCIe PME can work for devices connected to it.
> 
> But in that case the PME driver (drivers/pci/pcie/pme.c) should not bind
> to the port in question, so the "can_wakeup" flag should not be set for
> the devices under that port.

We can remove the can_wakeup flag for all its child devices once pcieport probe fails, but I think it's not intuitive.

> 
>> So let's correctly report runtime wakeup isn't supported when any of
>> PCIe bridges isn't bound to pcieport driver.
>> 
>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=205981
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> drivers/pci/pci.c | 12 ++++++++++++
>> 1 file changed, 12 insertions(+)
>> 
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 951099279192..ca686cfbd65e 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -2493,6 +2493,18 @@ bool pci_dev_run_wake(struct pci_dev *dev)
>> 	if (!pci_pme_capable(dev, pci_target_state(dev, true)))
>> 		return false;
>> 
>> +	/* If any upstream PCIe bridge isn't bound to pcieport driver, there's
>> +	 * no IRQ for PME.
>> +	 */
>> +	if (pci_is_pcie(dev)) {
>> +		while (bus->parent) {
>> +			if (!bus->self->driver)
>> +				return false;
>> +
>> +			bus = bus->parent;
>> +		}
>> +	}
>> +
> 
> So it looks like device_can_wakeup() returns 'true' for this device, but it
> should return 'false'.

The USB controllers can assert PME#, so it actually can wakeup, in a way.

I think the logical distinction between pci_dev_run_wake() and device_can_wakeup() is that,
pci_dev_run_wake() means it can actually do runtime wakeup, while device_can_wakeup()
only means it has the capability to wakeup. Am I correct here?

> 
> Do you know why the "can_wakeup" flag is set for it?

All PCI devices with PME cap calls device_set_wakeup_capable() in pci_pm_init().

> 
>> 	if (device_can_wakeup(&dev->dev))
>> 		return true;
>> 
>> 
> 
> Moreover, even if the native PME is not supported, there can be an ACPI GPE (or
> equivalent) that triggers when WAKE# is asserted by one of the PCIe devices
> connected to it, so the test added by this patch cannot be used in general.

Ok. So how to know when both native PME isn't supported and it doesn't use ACPI GPE?
I thought ACPI GPE only works for devices directly connect to Root Complex, but I can't find the reference now.

Another short-term workaround is to make pci_pme_list_scan() not skip bridge when it's in D3hot:

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e87196cc1a7f..3333194a62d3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2111,7 +2111,7 @@ static void pci_pme_list_scan(struct work_struct *work)
                         * configuration space of subordinate devices
                         * may be not accessible
                         */
-                       if (bridge && bridge->current_state != PCI_D0)
+                       if (bridge && bridge->current_state == PCI_D3cold)
                                continue;
                        /*
                         * If the device is in D3cold it should not be

I haven't seen any case that config space is not accessible under D3hot, but I don't have PCI spec to check.

Kai-Heng

