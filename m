Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8103B2F48B2
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jan 2021 11:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbhAMKaG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jan 2021 05:30:06 -0500
Received: from halon2.esss.lu.se ([194.47.240.53]:18597 "EHLO
        halon2.esss.lu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbhAMKaG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jan 2021 05:30:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ess.eu; s=dec2019;
        h=content-transfer-encoding:content-type:mime-version:date:message-id:subject:
         from:to:from;
        bh=V7Wv9LqMn/5EUiZUl9grwq+YiLymwWUhJR4z486Eqk4=;
        b=ExOUkViCU5R4cBimezznUDee5aDgtIeCF7CHKsOhJ8WrJtXtmaAVAOwLAX+QoMHKqaTxD3Ln+MbPk
         jZcd7Uq65QAF1RcF0hYnh04tO3VAnP4ptZDYC6p4MEAqUj5jg0vebYNN3hyjp42FRTljHlQ3kfokzR
         QwUJ78HvPfOw/d7enTSOZDYpDRH5pY7cPVuIJDFHiy6JZ5Z6mec9K3aGke6Pq5puaaHAR3EpPuQ62L
         GsQ8zfHwGGN64z/4gSFHNacWmeGigYOL9QidYVo8tZPwigB7jTvnXEIIZvrauiMKRA2AEAZPj/1j3y
         vyyHdqgWkUdP1vht4K3n5esO46/FCMg==
Received: from mail.esss.lu.se (it-exch16-4.esss.lu.se [10.0.42.134])
        by halon2.esss.lu.se (Halon) with ESMTPS
        id 302b2cd3-558a-11eb-8373-005056a642a7;
        Wed, 13 Jan 2021 10:29:16 +0000 (UTC)
Received: from [192.168.0.6] (194.47.241.248) by it-exch16-4.esss.lu.se
 (10.0.42.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 13 Jan
 2021 11:29:22 +0100
To:     Linux PCI <linux-pci@vger.kernel.org>
From:   Hinko Kocevar <hinko.kocevar@ess.eu>
Subject: /proc/iomem and /proc/ioports show 0 for address range
Message-ID: <375ef4e6-b9a1-d4f2-81b6-582f2152820d@ess.eu>
Date:   Wed, 13 Jan 2021 11:29:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [194.47.241.248]
X-ClientProxiedBy: it-exch16-2.esss.lu.se (10.0.42.132) To
 it-exch16-4.esss.lu.se (10.0.42.134)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[I noticed this while working on PCI devices; not sure which kernel list 
would be best for this, though]

I noticed that my system shows address range for iomem and ioports as 
all 0. Sometimes (after a power cycle) the addresses are proper, albeit 
I have not been able to see that in a while now, after performing 
numerous reboots in the last coupe of days.

FWIW, I think the list of devices (names, count) looks the same in both 
cases. The system seems to work in both cases; at least I have not seen 
any complaints in kernel logs, OTOH, not sure what the error message 
would be.

What may be the reason for not getting the proper addresses listed?

This likely poses any issues for userspace tools that would look at 
those /proc files, OTOH, I wonder if would kernel suffer in any way as 
well?

Kernel version is 5.10.0 (pci git tree).

[dev@bd-cpu18 ~]$ cat /proc/iomem
00000000-00000000 : Reserved
00000000-00000000 : System RAM
00000000-00000000 : Reserved
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : Video ROM
00000000-00000000 : Reserved
   00000000-00000000 : System ROM
00000000-00000000 : System RAM
   00000000-00000000 : Kernel code
   00000000-00000000 : Kernel rodata
   00000000-00000000 : Kernel data
   00000000-00000000 : Kernel bss
00000000-00000000 : ACPI Non-volatile Storage
00000000-00000000 : Reserved
00000000-00000000 : System RAM
00000000-00000000 : Reserved
00000000-00000000 : System RAM
00000000-00000000 : ACPI Non-volatile Storage
00000000-00000000 : Reserved
00000000-00000000 : System RAM
00000000-00000000 : Reserved
   00000000-00000000 : Graphics Stolen Memory
00000000-00000000 : PCI Bus 0000:00
   00000000-00000000 : PCI Bus 0000:01
     00000000-00000000 : PCI Bus 0000:02
       00000000-00000000 : PCI Bus 0000:03
         00000000-00000000 : PCI Bus 0000:04
           00000000-00000000 : PCI Bus 0000:05
           00000000-00000000 : PCI Bus 0000:06
           00000000-00000000 : PCI Bus 0000:07
           00000000-00000000 : PCI Bus 0000:08
           00000000-00000000 : PCI Bus 0000:09
   00000000-00000000 : 0000:00:02.0
   00000000-00000000 : 0000:00:02.0
   00000000-00000000 : PCI Bus 0000:01
     00000000-00000000 : PCI Bus 0000:02
       00000000-00000000 : PCI Bus 0000:03
         00000000-00000000 : PCI Bus 0000:04
           00000000-00000000 : PCI Bus 0000:08
           00000000-00000000 : 0000:08:00.0
           00000000-00000000 : xdma
           00000000-00000000 : 0000:08:00.0
           00000000-00000000 : xdma
         00000000-00000000 : 0000:03:00.0
     00000000-00000000 : 0000:01:00.0
   00000000-00000000 : PCI Bus 0000:12
     00000000-00000000 : 0000:12:00.0
       00000000-00000000 : igb
     00000000-00000000 : 0000:12:00.0
       00000000-00000000 : igb
   00000000-00000000 : PCI Bus 0000:11
     00000000-00000000 : 0000:11:00.0
       00000000-00000000 : igb
     00000000-00000000 : 0000:11:00.0
       00000000-00000000 : igb
   00000000-00000000 : PCI Bus 0000:10
     00000000-00000000 : 0000:10:00.0
       00000000-00000000 : igb
     00000000-00000000 : 0000:10:00.0
       00000000-00000000 : igb
   00000000-00000000 : PCI Bus 0000:0f
     00000000-00000000 : 0000:0f:00.0
       00000000-00000000 : igb
     00000000-00000000 : 0000:0f:00.0
       00000000-00000000 : igb
   00000000-00000000 : 0000:00:1f.3
     00000000-00000000 : ICH HD audio
   00000000-00000000 : 0000:00:14.0
     00000000-00000000 : xhci-hcd
   00000000-00000000 : 0000:00:1f.3
     00000000-00000000 : ICH HD audio
   00000000-00000000 : 0000:00:1f.2
   00000000-00000000 : 0000:00:17.0
     00000000-00000000 : ahci
   00000000-00000000 : 0000:00:1f.4
   00000000-00000000 : 0000:00:17.0
     00000000-00000000 : ahci
   00000000-00000000 : 0000:00:17.0
     00000000-00000000 : ahci
   00000000-00000000 : 0000:00:16.0
     00000000-00000000 : mei_me
   00000000-00000000 : 0000:00:15.1
     00000000-00000000 : lpss_dev
       00000000-00000000 : i2c_designware.1 lpss_dev
     00000000-00000000 : lpss_priv
     00000000-00000000 : idma64.1
       00000000-00000000 : idma64.1 idma64.1
   00000000-00000000 : 0000:00:15.0
     00000000-00000000 : lpss_dev
       00000000-00000000 : i2c_designware.0 lpss_dev
     00000000-00000000 : lpss_priv
     00000000-00000000 : idma64.0
       00000000-00000000 : idma64.0 idma64.0
   00000000-00000000 : 0000:00:14.2
     00000000-00000000 : Intel PCH thermal driver
   00000000-00000000 : 0000:00:08.0
   00000000-00000000 : pnp 00:04
00000000-00000000 : PCI MMCONFIG 0000 [bus 00-ff]
   00000000-00000000 : Reserved
     00000000-00000000 : pnp 00:04
00000000-00000000 : PCI Bus 0000:00
   00000000-00000000 : pnp 00:05
   00000000-00000000 : INT345D:00
     00000000-00000000 : INT345D:00 INT345D:00
   00000000-00000000 : pnp 00:05
   00000000-00000000 : INT345D:00
     00000000-00000000 : INT345D:00 INT345D:00
   00000000-00000000 : INT345D:00
     00000000-00000000 : INT345D:00 INT345D:00
   00000000-00000000 : pnp 00:05
     00000000-00000000 : iTCO_wdt
   00000000-00000000 : Reserved
   00000000-00000000 : pnp 00:05
   00000000-00000000 : pnp 00:05
   00000000-00000000 : pnp 00:05
00000000-00000000 : Reserved
   00000000-00000000 : IOAPIC 0
00000000-00000000 : Reserved
   00000000-00000000 : HPET 0
     00000000-00000000 : PNP0103:00
00000000-00000000 : pnp 00:04
00000000-00000000 : pnp 00:04
00000000-00000000 : pnp 00:04
00000000-00000000 : pnp 00:04
00000000-00000000 : MSFT0101:00
   00000000-00000000 : MSFT0101:00
00000000-00000000 : pnp 00:04
00000000-00000000 : dmar0
00000000-00000000 : dmar1
00000000-00000000 : Local APIC
   00000000-00000000 : Reserved
00000000-00000000 : Reserved
   00000000-00000000 : INT0800:00
     00000000-00000000 : pnp 00:04
00000000-00000000 : System RAM
00000000-00000000 : RAM buffer
[dev@bd-cpu18 ~]$ cat /proc/ioports
0000-0000 : PCI Bus 0000:00
   0000-0000 : dma1
   0000-0000 : pic1
   0000-0000 : timer0
   0000-0000 : timer1
   0000-0000 : keyboard
   0000-0000 : keyboard
   0000-0000 : rtc0
   0000-0000 : dma page reg
   0000-0000 : pic2
   0000-0000 : dma2
   0000-0000 : fpu
     0000-0000 : PNP0C04:00
   0000-0000 : vga+
   0000-0000 : serial
   0000-0000 : serial
   0000-0000 : iTCO_wdt
   0000-0000 : pnp 00:00
   0000-0000 : pnp 00:01
0000-0000 : PCI conf1
0000-0000 : PCI Bus 0000:00
   0000-0000 : pnp 00:00
   0000-0000 : pnp 00:00
     0000-0000 : ACPI PM1a_EVT_BLK
     0000-0000 : ACPI PM1a_CNT_BLK
     0000-0000 : ACPI PM_TMR
     0000-0000 : ACPI PM2_CNT_BLK
     0000-0000 : pnp 00:03
     0000-0000 : ACPI GPE0_BLK
   0000-0000 : PCI Bus 0000:01
     0000-0000 : PCI Bus 0000:02
       0000-0000 : PCI Bus 0000:03
         0000-0000 : PCI Bus 0000:04
           0000-0000 : PCI Bus 0000:05
           0000-0000 : PCI Bus 0000:06
           0000-0000 : PCI Bus 0000:07
           0000-0000 : PCI Bus 0000:08
           0000-0000 : PCI Bus 0000:09
   0000-0000 : PCI Bus 0000:12
     0000-0000 : 0000:12:00.0
   0000-0000 : PCI Bus 0000:11
     0000-0000 : 0000:11:00.0
   0000-0000 : PCI Bus 0000:10
     0000-0000 : 0000:10:00.0
   0000-0000 : PCI Bus 0000:0f
     0000-0000 : 0000:0f:00.0
   0000-0000 : 0000:00:02.0
   0000-0000 : 0000:00:1f.4
     0000-0000 : i801_smbus
   0000-0000 : 0000:00:17.0
     0000-0000 : ahci
   0000-0000 : 0000:00:17.0
     0000-0000 : ahci
   0000-0000 : 0000:00:17.0
     0000-0000 : ahci
   0000-0000 : pnp 00:06
   0000-0000 : pnp 00:00
     0000-0000 : pnp 00:00
       0000-0000 : pnp 00:00


Thanks!

//hinko
