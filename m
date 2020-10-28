Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279C629E0E7
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 02:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbgJ2BpS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 21:45:18 -0400
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:46716 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729212AbgJ2BpR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Oct 2020 21:45:17 -0400
X-Greylist: delayed 12601 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Oct 2020 21:45:16 EDT
Received: from cpc98990-stkp12-2-0-cust216.10-2.cable.virginm.net ([86.26.12.217] helo=[192.168.0.10])
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1kXp8e-0000Cf-3h; Wed, 28 Oct 2020 17:21:32 +0000
In-Reply-To: <20201022132223.17789-4-daire.mcnamara@microchip.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH v17 3/3] PCI: microchip: Add host driver for Microchip
 PCIe controller
Organization: Codethink Limited.
Message-ID: <587df2af-c59e-371a-230c-9c7a614824bd@codethink.co.uk>
Date:   Wed, 28 Oct 2020 17:21:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, I have tried applying these patches to the v5.6.16 yocto kernel
supplied for the Icicle board. I've assumed this is a v5.9 patch set
as they don't apply cleanly to v5.6.16 so rebased up to v5.9

The PCie is failing to initialise on the icicle board. Is there
anything else needing to be done to get it working on this board?

Log excerpt from board boot:

> [    2.435747] microchip-pcie e0000000.pci: host bridge /pci@E0000000 ranges:
> [    2.442580] microchip-pcie e0000000.pci: Parsing ranges property...
> [    2.442611] microchip-pcie e0000000.pci:      MEM 0x00e8000000..0x00efffffff -> 0x00e8000000
> [    2.451177] microchip-pcie e0000000.pci: non-prefetchable memory resource required
> [    2.460943] microchip-pcie e0000000.pci: ECAM at [mem 0xe0000000-0xe7ffffff] : ESC[Bfor [bus 00-7f]
> [    2.469607] microchip-pcie e0000000.pci: PCI host bridge to bus 0000:00
> [    2.476287] pci_bus 0000:00: root bus resource [bus 00-7f]
> [    2.481724] pci_bus 0000:00: root bus resource [mem 0xe8000000-0xefffffff pre: ESC[Bf]
> [    2.489186] pci_bus 0000:00: scanning bus
> [    2.489283] pci 0000:00:00.0: [11aa:1556] type 01 class 0x040000
> [    2.495328] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x7fffffff 64bit pref: ESC[B]
> [    2.502610] pci 0000:00:00.0: supports D1 D2
> [    2.506942] pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    2.513544] pci 0000:00:00.0: PME# disabled
> [    2.514859] pci_bus 0000:00: fixups for bus
> [    2.514882] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 0
> [    2.514900] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> [    2.522847] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
> [    2.522972] pci_bus 0000:01: scanning bus
> [    2.573878] pci_bus 0000:01: fixups for bus
> [    2.573897] pci_bus 0000:01: bus scan returning with max=01
> [    2.573918] pci_bus 0000:01: busn_res: [bus 01-7f] end is updated to 01
> [    2.580477] pci_bus 0000:00: bus scan returning with max=01
> [    2.580530] pci 0000:00:00.0: BAR 0: no space for [mem size 0x80000000 64bit pref]
> [    2.588195] pci 0000:00:00.0: BAR 0: failed to assign [mem size 0x80000000 64bit pref]
> [    2.596168] pci 0000:00:00.0: BAR 8: no space for [mem size 0x00200000]
> [    2.602782] pci 0000:00:00.0: BAR 8: failed to assign [mem size 0x00200000]
> [    2.609887] pci 0000:00:00.0: BAR 9: assigned [mem 0xe8000000-0xe81fffff 64bit pref]
> [    2.617692] pci 0000:00:00.0: BAR 7: no space for [io  size 0x1000]
> [    2.624028] pci 0000:00:00.0: BAR 7: failed to assign [io  size 0x1000]
> [    2.630646] pci 0000:00:00.0: PCI bridge to [bus 01]
>     2.635780] pci 0000:00:00.0:   bridge window [mem 0xe8000000-0xe81fffff 64bi: ESC[Bt pref]


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
