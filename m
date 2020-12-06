Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDCD2D063D
	for <lists+linux-pci@lfdr.de>; Sun,  6 Dec 2020 18:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgLFRRn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Dec 2020 12:17:43 -0500
Received: from mail.htz-1.pr0.me ([49.12.46.224]:41680 "EHLO mail.htz-1.pr0.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgLFRRi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 6 Dec 2020 12:17:38 -0500
X-Greylist: delayed 556 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Dec 2020 12:17:36 EST
Received: from celsius.pr0.me (p200300c7ef134542e33fafa3ed2832ba.dip0.t-ipconnect.de [IPv6:2003:c7:ef13:4542:e33f:afa3:ed28:32ba])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail.htz-1.pr0.me (Postfix) with ESMTPSA id E4CE220C46
        for <linux-pci@vger.kernel.org>; Sun,  6 Dec 2020 17:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stengele.me; s=2020;
        t=1607274454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/4GJOc4ONjx316pI19jF6X2l0pxq/XOC84xc5pkcun0=;
        b=vbjQbtb1r4VrJhAV8huAxn1ck/q5VqxfHKk/Mn6UnH4W8MW4BVhGhni6ypyd7yx2KP8Czl
        VMOVZ5BoIqRoJsx+tZHjYGxToPI2J20m9agprzV8OU5rNJO5w9ZHUQkwRoakCUlY/c3IDL
        y8n+KPe4WTn3KEuZlbnGlYFc4gbmccKNjnQq35hsTfGSgxP5PFtYXsstDNLS43s42KqWmB
        vnrrps9p184NS4gdwzh+n8C/fCavll5JBQqvAa1mtue8XYrkW6VZ7IVXNVqt7KMx3uNrsP
        ve+ItPVWgn/owWk4P8YHno2jMYPbU6n0FBKHCW+tFcsvGOjTtEJKmXD6tMvqUw==
To:     linux-pci@vger.kernel.org
From:   Dennis Stengele <dennis@stengele.me>
Subject: [Possible Bug] Bandwidth (?) problems with ASM2142 PCIe USB 3.1
 Controller
Message-ID: <73a068bd-ebc6-a2d1-db1f-2f7d6185ccec@stengele.me>
Date:   Sun, 6 Dec 2020 18:07:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dstengele smtp.mailfrom=dennis@stengele.me
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

I am currently trying to use a Logitech Webcam with my system which 
requires USB 3.1. As my board does not have native USB-C ports, I am 
using a PCIe card with the ASmedia chipset ASM2142. The card itself is 
recognized as well as the camera or any other pripherals connected to it.

My problem ist that I am getting errors like this as soon as I am trying 
to capture video larger that 320x240@20fps:

> [ 7905.755830] uvcvideo: Failed to query (GET_CUR) UVC control 4 on unit 3: -110 (exp. 2).
> [ 7905.756050] xhci_hcd 0000:02:00.0: WARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.
> [ 7905.766944] xhci_hcd 0000:02:00.0: ERROR Transfer event TRB DMA ptr not part of current TD ep_index 10 comp_code 13
> [ 7905.766950] xhci_hcd 0000:02:00.0: Looking for event-dma 000000005c6e62a0 trb-start 000000005c6e62b0 trb-end 000000005c6e62b0 seg-start 000000005c6e6000 seg-end 000000005c6e6ff0
> [ 7906.346997] uvcvideo: Failed to query (GET_CUR) UVC control 13 on unit 1: -110 (exp. 8).
> [ 7911.843998] uvcvideo: Failed to set UVC probe control : -110 (exp. 26).
> [ 7916.964219] uvcvideo: Failed to set UVC probe control : -110 (exp. 26).
> [ 7922.084309] uvcvideo: Failed to set UVC commit control : -110 (exp. 26).
> [ 7922.085018] xhci_hcd 0000:02:00.0: WARN Event TRB for slot 2 ep 0 with no TDs queued?
> [ 7922.653363] uvcvideo: Failed to query (GET_CUR) UVC control 4 on unit 3: -110 (exp. 2).
> [ 7922.653579] xhci_hcd 0000:02:00.0: WARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.
> [ 7922.663557] xhci_hcd 0000:02:00.0: ERROR Transfer event TRB DMA ptr not part of current TD ep_index 10 comp_code 13
> [ 7922.663560] xhci_hcd 0000:02:00.0: Looking for event-dma 000000005c6e62c0 trb-start 000000005c6e62d0 trb-end 000000005c6e62d0 seg-start 000000005c6e6000 seg-end 000000005c6e6ff0
> [ 7922.679789] xhci_hcd 0000:02:00.0: ERROR Transfer event TRB DMA ptr not part of current TD ep_index 0 comp_code 1
> [ 7922.679792] xhci_hcd 0000:02:00.0: Looking for event-dma 000000005c6db290 trb-start 000000005c6db2a0 trb-end 000000005c6db2c0 seg-start 000000005c6db000 seg-end 000000005c6dbff0
> [ 7923.227523] uvcvideo: Failed to query (GET_CUR) UVC control 13 on unit 1: -110 (exp. 8).
> [ 7953.829367] uvcvideo: Failed to set UVC probe control : -110 (exp. 26).
> [ 7958.949511] uvcvideo: Failed to set UVC probe control : -110 (exp. 26).
> [ 7964.069687] uvcvideo: Failed to set UVC probe control : -110 (exp. 26).
> [ 7969.189886] uvcvideo: Failed to set UVC probe control : -110 (exp. 26).
> [ 7974.309955] uvcvideo: Failed to set UVC probe control : -110 (exp. 26).
> [ 7979.430131] uvcvideo: Failed to set UVC probe control : -110 (exp. 26).
> [ 7984.550275] uvcvideo: Failed to set UVC probe control : -110 (exp. 26).
> [ 7989.670438] uvcvideo: Failed to set UVC probe control : -110 (exp. 26).
> [ 7994.790625] uvcvideo: Failed to set UVC probe control : -110 (exp. 26).
> [ 7999.910767] uvcvideo: Failed to set UVC probe control : -110 (exp. 26).
> [ 8005.031160] uvcvideo: Failed to set UVC probe control : -110 (exp. 26).

The video capture seems to hang after this.

I have tried to apply some of the patches for other ASmedia chipsets in 
/drivers/usb/host/xhci-pci.c and building a custom kernel (5.9) with 
them, but none of them worked. When booting the machine with Windows the 
camera works, so the Hardware itself seems to be working.

I was hoping for someone to point me in the right direction what I can 
try next to get this thing working properly.


uname -a:
> Linux XXX 5.9.11-zen2-1-zen #1 ZEN SMP PREEMPT Sat, 28 Nov 2020 02:08:52 +0000 x86_64 GNU/Linux
lspci:
> 00:00.0 Host bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DMI2 (rev 02)
> 00:01.0 PCI bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCI Express Root Port 1 (rev 02)
> 00:01.1 PCI bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCI Express Root Port 1 (rev 02)
> 00:02.0 PCI bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCI Express Root Port 2 (rev 02)
> 00:02.1 PCI bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCI Express Root Port 2 (rev 02)
> 00:02.2 PCI bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCI Express Root Port 2 (rev 02)
> 00:02.3 PCI bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCI Express Root Port 2 (rev 02)
> 00:03.0 PCI bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCI Express Root Port 3 (rev 02)
> 00:05.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Address Map, VTd_Misc, System Management (rev 02)
> 00:05.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Hot Plug (rev 02)
> 00:05.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 RAS, Control Status and Global Errors (rev 02)
> 00:05.4 PIC: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 I/O APIC (rev 02)
> 00:11.0 Unassigned class [ff00]: Intel Corporation C610/X99 series chipset SPSR (rev 05)
> 00:11.4 SATA controller: Intel Corporation C610/X99 series chipset sSATA Controller [AHCI mode] (rev 05)
> 00:14.0 USB controller: Intel Corporation C610/X99 series chipset USB xHCI Host Controller (rev 05)
> 00:16.0 Communication controller: Intel Corporation C610/X99 series chipset MEI Controller #1 (rev 05)
> 00:19.0 Ethernet controller: Intel Corporation Ethernet Connection I217-LM (rev 05)
> 00:1a.0 USB controller: Intel Corporation C610/X99 series chipset USB Enhanced Host Controller #2 (rev 05)
> 00:1b.0 Audio device: Intel Corporation C610/X99 series chipset HD Audio Controller (rev 05)
> 00:1c.0 PCI bridge: Intel Corporation C610/X99 series chipset PCI Express Root Port #1 (rev d5)
> 00:1c.6 PCI bridge: Intel Corporation C610/X99 series chipset PCI Express Root Port #7 (rev d5)
> 00:1c.7 PCI bridge: Intel Corporation C610/X99 series chipset PCI Express Root Port #8 (rev d5)
> 00:1d.0 USB controller: Intel Corporation C610/X99 series chipset USB Enhanced Host Controller #1 (rev 05)
> 00:1f.0 ISA bridge: Intel Corporation C610/X99 series chipset LPC Controller (rev 05)
> 00:1f.2 SATA controller: Intel Corporation C610/X99 series chipset 6-Port SATA Controller [AHCI mode] (rev 05)
> 00:1f.3 SMBus: Intel Corporation C610/X99 series chipset SMBus Controller (rev 05)
> 02:00.0 USB controller: ASMedia Technology Inc. ASM2142 USB 3.1 Host Controller
> 06:00.0 Serial Attached SCSI controller: Adaptec ASC-1405 Unified Serial HBA (rev 02)
> 07:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Baffin [Radeon RX 460/560D / Pro 450/455/460/555/555X/560/560X] (rev e5)
> 07:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Baffin HDMI/DP Audio [Radeon RX 550 640SP / RX 560/560X]
> 09:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
> 0a:00.0 Serial controller: Device 1c00:3253 (rev 10)
> ff:0b.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 R3 QPI Link 0 & 1 Monitoring (rev 02)
> ff:0b.1 Performance counters: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 R3 QPI Link 0 & 1 Monitoring (rev 02)
> ff:0b.2 Performance counters: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 R3 QPI Link 0 & 1 Monitoring (rev 02)
> ff:0c.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Unicast Registers (rev 02)
> ff:0c.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Unicast Registers (rev 02)
> ff:0c.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Unicast Registers (rev 02)
> ff:0c.3 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Unicast Registers (rev 02)
> ff:0f.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Buffered Ring Agent (rev 02)
> ff:0f.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Buffered Ring Agent (rev 02)
> ff:0f.4 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 System Address Decoder & Broadcast Registers (rev 02)
> ff:0f.5 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 System Address Decoder & Broadcast Registers (rev 02)
> ff:0f.6 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 System Address Decoder & Broadcast Registers (rev 02)
> ff:10.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCIe Ring Interface (rev 02)
> ff:10.1 Performance counters: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCIe Ring Interface (rev 02)
> ff:10.5 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Scratchpad & Semaphore Registers (rev 02)
> ff:10.6 Performance counters: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Scratchpad & Semaphore Registers (rev 02)
> ff:10.7 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Scratchpad & Semaphore Registers (rev 02)
> ff:12.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Home Agent 0 (rev 02)
> ff:12.1 Performance counters: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Home Agent 0 (rev 02)
> ff:13.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Target Address, Thermal & RAS Registers (rev 02)
> ff:13.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Target Address, Thermal & RAS Registers (rev 02)
> ff:13.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target Address Decoder (rev 02)
> ff:13.3 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target Address Decoder (rev 02)
> ff:13.4 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target Address Decoder (rev 02)
> ff:13.5 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target Address Decoder (rev 02)
> ff:13.6 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO Channel 0/1 Broadcast (rev 02)
> ff:13.7 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO Global Broadcast (rev 02)
> ff:14.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 0 Thermal Control (rev 02)
> ff:14.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 1 Thermal Control (rev 02)
> ff:14.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 0 ERROR Registers (rev 02)
> ff:14.3 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 1 ERROR Registers (rev 02)
> ff:14.6 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 0 & 1 (rev 02)
> ff:14.7 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 0 & 1 (rev 02)
> ff:15.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 2 Thermal Control (rev 02)
> ff:15.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 3 Thermal Control (rev 02)
> ff:15.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 2 ERROR Registers (rev 02)
> ff:15.3 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 3 ERROR Registers (rev 02)
> ff:16.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 1 Target Address, Thermal & RAS Registers (rev 02)
> ff:16.6 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO Channel 2/3 Broadcast (rev 02)
> ff:16.7 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO Global Broadcast (rev 02)
> ff:17.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 1 Channel 0 Thermal Control (rev 02)
> ff:17.4 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 2 & 3 (rev 02)
> ff:17.5 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 2 & 3 (rev 02)
> ff:17.6 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 2 & 3 (rev 02)
> ff:17.7 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 2 & 3 (rev 02)
> ff:1e.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Power Control Unit (rev 02)
> ff:1e.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Power Control Unit (rev 02)
> ff:1e.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Power Control Unit (rev 02)
> ff:1e.3 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Power Control Unit (rev 02)
> ff:1e.4 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Power Control Unit (rev 02)
> ff:1f.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 VCU (rev 02)
> ff:1f.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 VCU (rev 02)


Thank you!

Dennis
