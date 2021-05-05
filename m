Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9D937363E
	for <lists+linux-pci@lfdr.de>; Wed,  5 May 2021 10:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhEEI2u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 May 2021 04:28:50 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:38761 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229566AbhEEI2u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 May 2021 04:28:50 -0400
Received: from [192.168.0.7] (ip5f5aeee6.dynamic.kabel-deutschland.de [95.90.238.230])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id BA7FD61E5FE02;
        Wed,  5 May 2021 10:27:52 +0200 (CEST)
Subject: Re: `quirk_usb_handoff_xhci` takes 60 ms with ASM1042
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-pci@vger.kernel.org
References: <eed7681d-2bbf-b3a5-4ee3-729b614545bf@molgen.mpg.de>
 <YJJTQzJS/8Loz8kV@kroah.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <e4d36cdd-3998-3ed3-76d9-56541d89a182@molgen.mpg.de>
Date:   Wed, 5 May 2021 10:27:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YJJTQzJS/8Loz8kV@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dear Greg,


Thank you for the quick reply.

Am 05.05.21 um 10:11 schrieb Greg Kroah-Hartman:
> On Wed, May 05, 2021 at 09:57:44AM +0200, Paul Menzel wrote:

>> On an Asus F2A85-M PRO, BIOS 6601 11/25/2014, with an ASM1042 SuperSpeed USB
>> Host Controller [1b21:1042], and the xHCI drivers built as modules
>>
>>      CONFIG_USB_XHCI_PCI=m
>>      CONFIG_USB_XHCI_HCD=m
>>
>> `quirk_usb_handoff_xhci` takes 60 ms, which is 15 % of the time to reaching
>> `run_init_process()`. I addded some prints, showing the f
>>
>>      [    0.308841] pci 0000:03:00.0: PCI->APIC IRQ transform: INT A -> IRQ 17
>>      [    0.369858] pci 0000:03:00.0: handshake done with timeout = 0
>>      [    0.369862] pci 0000:03:00.0: hc_init reached
>>      [    0.369865] pci 0000:03:00.0: second handshake done
>>      [    0.369869] pci 0000:03:00.0: third handshake done
>>      [    0.369909] pci 0000:03:00.0: quirk_usb_early_handoff+0x0/0x670 took 59661 usecs
>>      […]
>>      [    0.415223] Run /lib/systemd/systemd as init process
>>
>> Is there a way to optimize this, or move it out “the hot path”?
> 
> That's the hardware taking so long, all that function does is make some
> PCI calls to the device.

In your experience, do most devices take that long?

> If the driver is built as a module, there should not be any "hot
> path" here as the module is loaded async when the device is
> discovered, right?
     obj-$(CONFIG_USB_PCI)   += pci-quirks.o

So all quirks are run independently of the USB “variant” (UHCI, OHCI, 
EHCI, xHCI).

Indeed, this driver is built into the Linux kernel.

     $ grep USB_PCI .config
     CONFIG_USB_PCI=y

So, should `pci-quirks.c` be split up to have more fine grained control?

> What is waiting for this module to load in order to cause your init to
> stall?  Perhaps fix your initramfs logic or build the driver into the
> kernel itself to take it off of this "load all the modules and wait"
> path?

Sorry, for causing some confusion. But as written above, this all 
happens before the initrd is involved.


Kind regards,

Paul
