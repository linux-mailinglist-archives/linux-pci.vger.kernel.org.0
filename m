Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E71487530
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 11:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346620AbiAGKFC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 05:05:02 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55788 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346627AbiAGKFC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jan 2022 05:05:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 027CA61EDB
        for <linux-pci@vger.kernel.org>; Fri,  7 Jan 2022 10:05:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED2FC36AE9;
        Fri,  7 Jan 2022 10:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641549901;
        bh=E6gvoEl19nY9Ml1EKzn3gbPgZpPgOunf0VAlxsKIAxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sx+KPMy3xSaF9bMs0RaNlvjrPD7QLlJl+c2KWJxa3X6WA87qNPia25qBjA7N1ombj
         ER015NQXZYrDe0tQ74zEHqNh+mojiZRE/jJlJeRv6lypZuIKgVAN2AQWyGU/mvqA7i
         ZmzvG/9tNVPlza8/KYT/LmYyVk4qlkIj80udf0hZRdhrKq281LLQQpt1TdfJcytt5e
         5XsR/3Li3uxuAUCfkxQkpQPunxhQ0QKJLlKLAsxLHyaYF9cBPEopQBv+3kepLJUBL6
         /pNM/3zKOlw6/j0A53zvrK3c+VzaXdeHJN5Cp0cwHDChx7ERGmV8mIbYXuiBBURCHi
         b48GnF3sU8T4Q==
Received: by pali.im (Postfix)
        id 46C1BB22; Fri,  7 Jan 2022 11:04:58 +0100 (CET)
Date:   Fri, 7 Jan 2022 11:04:58 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <kbusch@kernel.org>,
        Bharat Kumar Gogada <bharatku@xilinx.com>
Subject: Re: PCIe AER generates no interrupts on host (ZynqMP)
Message-ID: <20220107100458.sfqcq7gy6nwwamjt@pali>
References: <4736848c-7b3b-a99d-8fd3-540ec6eb920b@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4736848c-7b3b-a99d-8fd3-540ec6eb920b@denx.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello! You asked me in another email for comments to this email, so I'm
replying directly to this email...

On Tuesday 04 January 2022 10:02:18 Stefan Roese wrote:
> Hi,
> 
> I'm trying to get the Kernel PCIe AER infrastructure to work on my
> ZynqMP based system. E.g. handle the events (correctable, uncorrectable
> etc). In my current tests, no AER interrupt is generated though. I'm
> currently using the "surprise down error status" in the uncorrectable
> error status register of the connected PCIe switch (PLX / Broadcom
> PEX8718). Here the bit is correctly logged in the PEX switch
> uncorrectable error status register but no interrupt is generated
> to the root-port / system. And hence no AER message(s) reported.
> 
> Does any one of you have some ideas on what might be missing? Why are
> these events not reported to the PCIe rootport driver via IRQ? Might
> this be a problem of the missing MSI-X support of the ZynqMP? The AER
> interrupt is connected as legacy IRQ:
> 
> cat /proc/interrupts | grep -i aer
>  58:          0          0          0          0  nwl_pcie:legacy   0 Level
> PCIe PME, aerdrv

Error events (correctable, non-fatal and fatal) are reported by PCIe
devices to the Root Complex via PCIe error messages (Message code of TLP
is set to Error Message) and not via interrupts. Root Port is then
responsible to "convert" these PCIe error messages to MSI(X) interrupt
and report it to the system. According to PCIe spec, AER is supported
only via MSI(X) interrupts, not legacy INTx.

Via Bridge Control register (SERR# enable bit) on the Root Port it is
possible to enable / disable reporting of these errors from PCIe devices
on the other end of PCIe link to the system. Then via Command register
(SERR# enable bit) and Device Control register it is possible to enable
/ disable reporting of all errors (from Root Port and also devices on
other end of the link). And via AER registers on the Root Port it is
also possible to disable generating MSI(X) interrupts when error is
reported. And IIRC via PCIe Downstream Port Containment there is also
way how to "mask" reporting of error events. But I do not have PCIe
devices with DPC support, so I have not played with it yet. So there are
many places where error event can be stopped. But important is that
kernel AER driver should correctly enable all required bits to start
receiving MSI(X) interrupts for error events.

On other devices I'm seeing following issues... Root Ports are not
compliant to PCIe spec and do not implement error reporting at all. Or
they do not implement those enable/disable bits correctly. Or they do
not implement proper support for extended PCIe config space for Root
Port (AER is in extended space). Or they report error events via custom
proprietary interrupts and not via MSI(X) as required by PCIe spec. This
is the case for (all?) Marvell PCIe controllers and I saw here on
linux-pci list that it applies also for PCIe controllers from some other
vendors. Also drivers for Marvell PCIe controllers requires additional
code to access extended PCIe config space of Root Port (accessing config
space of PCIe devices on the other end of PCIe link is working fine).

So the first suspicious thing is why kernel AER driver is using legacy
shared INTx interrupt as in most cases Root Port would not report any
error event via INTx. And the second thing, try to look into
documentation for used PCIe controller, just in case if vendor
"invented" some proprietary and non-compliant way how to report error /
AER events to OS...

I saw more issues with PCIe controllers as with PCIe switches so in my
opinion issue would be either in controller driver or controller hw
itself. And if you see event status logged in PCIe switch register I
would expect that switch correctly sent PCIe Error message to Root
Complex.

> BTW: This was tested on v5.10 and recent v5.16-rc6.
> 
> Thanks,
> Stefan
