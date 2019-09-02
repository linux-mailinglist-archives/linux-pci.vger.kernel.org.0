Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A64D9A585A
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2019 15:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbfIBNr6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Sep 2019 09:47:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39747 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730638AbfIBNr5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Sep 2019 09:47:57 -0400
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1i4mgT-0002yC-RJ
        for linux-pci@vger.kernel.org; Mon, 02 Sep 2019 13:47:54 +0000
Received: by mail-pf1-f198.google.com with SMTP id v15so607807pfe.7
        for <linux-pci@vger.kernel.org>; Mon, 02 Sep 2019 06:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uNQp7GicPWK61ixZiQN6tZMRWgfyskms2Xm+47zkDXY=;
        b=TiZG0YL6+tFWMIJnqY4oWN/Gvk2pq3m/SzmuGECzRR/uOjKcIpQmYGPZhTG8UuAANo
         5howxzB5naHjtB3mcELpIDGNdE7eJ2m+mD9DHykqYe06aF/45LDK6VF5xJfrPeFM+6fr
         DQVb/Jaud0PUqtgjjPbmqFIIINL0gBT+h+i6MagpXVIpc3ydrjgRdFPWAqISXCaCj/5C
         2pMDOFJMANHdRVywr0u+qgiGXJd7Fwp2ljAXzObNH1Y0sCWjySW5/9HdGf6QDmKlkgSs
         B7PkJN8fXta+ywMciaOpC4k/Dx+eeuW3FsdNJwb4ZzGfbO3DDBlJAIdQSz4IqALEDiRf
         fR4Q==
X-Gm-Message-State: APjAAAVWmTS5epAuuLZ6nZ6K9SF2uR/2EYPkWn4gXShrg6rB7zzzO+I8
        RTAzR6fRPfpb9TEf27F9XbWbQpMDfCu5QqU/3c71RS7HCH2SnZLXO8D16nRGHBls57JTPJajZ9W
        LNA7hmXc03h5s3jJq25nemggTitz68r1Wzz7qYQ==
X-Received: by 2002:a17:90a:3be5:: with SMTP id e92mr13533015pjc.86.1567432071946;
        Mon, 02 Sep 2019 06:47:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzHjWc0RXmvqC7efr8SnkFNptO1R8/KexsfP+UXC+rJJUFCFEEUH8SemYJxlu081r4xUhcxjw==
X-Received: by 2002:a17:90a:3be5:: with SMTP id e92mr13532989pjc.86.1567432071608;
        Mon, 02 Sep 2019 06:47:51 -0700 (PDT)
Received: from 2001-b011-380f-3c42-e5a4-1fc5-bb40-7b2d.dynamic-ip6.hinet.net (2001-b011-380f-3c42-e5a4-1fc5-bb40-7b2d.dynamic-ip6.hinet.net. [2001:b011:380f:3c42:e5a4:1fc5:bb40:7b2d])
        by smtp.gmail.com with ESMTPSA id m125sm18618757pfm.139.2019.09.02.06.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 06:47:51 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] PCI / PM: Don't runtime suspend when device only supports
 wakeup from D0
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190709134538.GA35486@google.com>
Date:   Mon, 2 Sep 2019 21:47:48 +0800
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org
Content-Transfer-Encoding: 8bit
Message-Id: <FB60E420-2AB7-478D-A312-5FFD6A3AC8C9@canonical.com>
References: <20190522181157.GC79339@google.com>
 <Pine.LNX.4.44L0.1905221433310.1410-100000@iolanthe.rowland.org>
 <20190522205231.GD79339@google.com>
 <010C1D41-C66D-45C0-8AFF-6F746306CE29@canonical.com>
 <20190527165747.GF79339@google.com> <20190605115724.GE84290@google.com>
 <7E5CD0E5-2C23-4339-9660-74994FC5C111@canonical.com>
 <20190709134538.GA35486@google.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

at 21:45, Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Fri, Jul 05, 2019 at 03:02:01PM +0800, Kai-Heng Feng wrote:
>> at 19:57, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>> On Mon, May 27, 2019 at 11:57:47AM -0500, Bjorn Helgaas wrote:
>
>>>> I'm wondering if this platform has a firmware defect.  Here's my
>>>> thinking.  The xHC is a Root Complex Integrated Endpoint, so its PME
>>>> signaling is a little unusual.
>>>>
>>>> The typical scenario is that a PCIe device is below a Root Port.  In
>>>> that case, it would send a PME Message upstream to the Root Port.  Per
>>>> PCIe r4.0, sec 6.1.6, when configured for native PME support (for ACPI
>>>> systems, I assume this means "when firmware has granted PME control to
>>>> the OS via _OSC"), the Root Port would generate a normal PCI INTx or
>>>> MSI interrupt:
>>>>
>>>>   PCI Express-aware software can enable a mode where the Root Complex
>>>>   signals PME via an interrupt. When configured for native PME
>>>>   support, a Root Port receives the PME Message and sets the PME
>>>>   Status bit in its Root Status register. If software has set the PME
>>>>   Interrupt Enable bit in the Root Control register to 1b, the Root
>>>>   Port then generates an interrupt.
>>>>
>>>> But on this platform the xHC is a Root Complex Integrated Endpoint, so
>>>> there is no Root Port upstream from it, and that mechanism can't be
>>>> used.  Per PCIe r4.0, sec 1.3.2.3, RCiEPs signal PME via "the same
>>>> mechanism as PCI systems" or via Root Complex Event Collectors:
>>>>
>>>>   An RCiEP must signal PME and error conditions through the same
>>>>   mechanisms used on PCI systems. If a Root Complex Event Collector is
>>>>   implemented, an RCiEP may optionally signal PME and error conditions
>>>>   through a Root Complex Event Collector.
>>>>
>>>> This platform has no Root Complex Event Collectors, so the xHC should
>>>> signal PME via the same mechanism as PCI systems, i.e., asserting a
>>>> PME# signal.  I think this means the OS cannot use native PCIe PME
>>>> control because it doesn't know what interrupt PME# is connected to.
>>>> The PCI Firmware Spec r3.2, sec 4.5.1 (also quoted in ACPI v6.2, sec
>>>> 6.2.11.3), says:
>>>>
>>>>   PCI Express Native Power Management Events control
>>>>
>>>>   The firmware sets this bit to 1 to grant control over PCI Express
>>>>   native power management event interrupts (PMEs). If firmware
>>>>   allows the operating system control of this feature, then in the
>>>>   context of the _OSC method, it must ensure that all PMEs are
>>>>   routed to root port interrupts as described in the PCI Express
>>>>   Base Specification.
>>>>
>>>> This platform cannot route all PMEs to Root Port interrupts because
>>>> the xHC RCiEP cannot report PME via a Root Port, so I think its _OSC
>>>> method should not grant control of PCIe Native Power Management Events
>>>> to the OS, and I think that would mean we have to use the ACPI
>>>> mechanism for PME on this platform.
>>>>
>>>> Can you confirm or deny any of this line of reasoning?  I'm wondering
>>>> if there's something wrong with the platform's _OSC, so Linux thinks
>>>> it can use native PME, but that doesn't work for this device.
>>>>
>>>>> It’s a platform in development so the name can’t be disclosed.
>>>>
>>>> Please attach a complete dmesg log to the bugzilla.  You can remove
>>>> identifying details like the platform name, but I want to see the
>>>> results of the _OSC negotiation.
>>>
>>> Thanks for the dmesg log
>>> (https://bugzilla.kernel.org/attachment.cgi?id=283109).  It shows:
>>>
>>>   acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
>>>   acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug LTR]
>>>   acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
>>>
>>> I think it is incorrect for the platform to give the OS native control
>>> over PME because the OS has no way to know how the RCiEP PMEs are
>>> routed.  But it would be interesting to know how BIOSes on other
>>> platforms with RCiEPs handle this, and I did post a question to the
>>> PCI-SIG to see if there's any guidance there.
>>
>> Is there any update from PCI-SIG?
>
> Yes, but I did a terrible job asking the question, so we didn't
> really get an answer for this situation.  The thread on the forum is
> https://forum.pcisig.com/viewtopic.php?f=85&t=1081 (requires PCI-SIG
> login, unfortunately).  My question was:
>
>   Given an RCiEP that supports PME, can firmware grant control over
>   native power management events to the OS?
>
>   The PCI Firmware spec, r3.2, sec 4.5.1, says:
>
>     PCI Express Native Power Management Events control
>
>     The firmware sets this bit to 1 to grant control over PCI Express
>     native power management event interrupts (PMEs). If firmware
>     allows the operating system control of this feature, then in the
>     context of the _OSC method, it must ensure that all PMEs are
>     routed to root port interrupts as described in the PCI Express
>     Base Specification.
>
>   I don't think there's a mechanism for RCiEPs to route PMEs to a Root
>   Port interrupt.
>
>   PCIe r4.0, sec 1.3.2.3, says:
>
>     An RCiEP must signal PME and error conditions through the same
>     mechanisms used on PCI systems. If a Root Complex Event Collector
>     is implemented, an RCiEP may optionally signal PME and error
>     conditions through a Root Complex Event Collector.
>
>   If the OS can be granted native PME control, how does it learn where
>   the RCiEP PME is routed?
>
> And the response from Robert Gough:
>
>   The routing of root complex devices- Root Ports and Root Complex
>   Integrated Endpionts- to Event Collectors is described in the Event
>   Collector's RCEC Endpoint Association Capability Structure.
>
>   In order for OSPM to process PMEs routed to an Event Collector, the
>   source of the PME is found in the PME Requester ID field within the
>   Root Status register of the Event Collector, in the same way that
>   PME messages from children of Root Ports are serviced.
>
> I just posted this follow-up question:
>
>   Thanks, that clarifies one piece. The PCI Firmware spec, r3.2, sec
>   4.5.1, says that if firmware allows OSPM control of PME, all PMEs
>   should be routed to Root Port interrupts. Your answer suggests that
>   this should be updated to say something like "all PMEs are routed to
>   Root Port *or RCEC* interrupts".
>
>   The piece I still don't understand is what happens when firmware
>   allows OSPM control of PME in a system with an RCiEP but no RCEC.
>   Where are PMEs from the RCiEP routed, and how does OSPM discover
>   that? Or is it simply illegal for firmware to allow OSPM control of
>   PME in that case?
>
> The system we're looking at doesn't have any RCECs, so I don't think
> the Root Complex Event Collector Endpoint Association Capability (what
> a mouthful :)) is applicable, but I don't think Linux currently has
> any support for it, so I think we're likely to trip over similar
> issues on systems that do have RCECs.
>
> It would be good if somebody added support for that capability.

I just found the same issue on another Stoney Ridge laptop so I’d like to  
bring up this issue again.

The original approach I took is based on the feed back from BIOS team. They  
modified the return value of _S0W method to 0, to prevent the device from  
being runtime suspended.

But since the D0 PME# doesn’t work, I think maybe it’s better to just  
remove D0 PME# from its PM CAP?
I’ll send a patch with quirk to the mailing list.

Kai-Heng

>
> Bjorn


