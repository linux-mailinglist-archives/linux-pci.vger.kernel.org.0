Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B88B298370
	for <lists+linux-pci@lfdr.de>; Sun, 25 Oct 2020 20:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418643AbgJYTvv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 25 Oct 2020 15:51:51 -0400
Received: from chronos.abteam.si ([46.4.99.117]:48767 "EHLO chronos.abteam.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1418642AbgJYTvt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 25 Oct 2020 15:51:49 -0400
X-Greylist: delayed 349 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Oct 2020 15:51:42 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
        by chronos.abteam.si (Postfix) with ESMTP id 28B755D0007A
        for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2020 20:45:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bstnet.org; h=
        content-transfer-encoding:content-language:content-type
        :content-type:mime-version:user-agent:date:date:message-id
        :subject:subject:from:from; s=default; t=1603655151; x=
        1605469552; bh=kgkvt46+u0RY9+RfdXJCVegwYOqYNbfPL2d32xKl+xU=; b=u
        Ke6zcQDM0Bh1udxb+5A2jAhtF1n39ml5KE2+BmLX5MRTMBdArBioeSlI4SXU+AdO
        A04IOnb8hzYZS+kwytn2Jw/JDhJ/GkDt0eqbNbQJ3Yh504kawMxwTk5jYNj3Jv20
        f5aUVj8HPQhZVOI305nQkfurMM1ieMFmYtLKnUj+vo=
Received: from chronos.abteam.si ([127.0.0.1])
        by localhost (chronos.abteam.si [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CmUpjfoMe-5v for <linux-pci@vger.kernel.org>;
        Sun, 25 Oct 2020 20:45:51 +0100 (CET)
Received: from bst-slack.bstnet.org (unknown [IPv6:2a00:ee2:4d00:602:55ba:eee4:b8b8:69b3])
        (Authenticated sender: boris@abteam.si)
        by chronos.abteam.si (Postfix) with ESMTPSA id 766635D00072
        for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2020 20:45:51 +0100 (CET)
To:     linux-pci@vger.kernel.org
From:   "Boris V." <borisvk@bstnet.org>
Subject: Kernel 5.9 IOMMU groups regression/change
Message-ID: <74aeea93-8a46-5f5a-343c-790d4c655da3@bstnet.org>
Date:   Sun, 25 Oct 2020 20:45:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With upgrade to kernel 5.9 my VMs stopped working, because some devices=20
can't be passed through.
This is caused by different IOMMU groups and devices being in the same=20
group.

For ex. with kernel 5.8 this are IOMMU groups:
IOMMU Group 40:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 08:01.0 PCI bridge [0604]: AS=
Media Technology Inc. Device=20
[1b21:118f]
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 09:00.0 Ethernet controller [=
0200]: Intel Corporation I211=20
Gigabit Network Connection [8086:1539] (rev 03)
IOMMU Group 43:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0c:00.0 SATA controller [0106=
]: ASMedia Technology Inc. ASM1062=20
Serial ATA Controller [1b21:0612] (rev 02)
IOMMU Group 44:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0d:00.0 USB controller [0c03]=
: ASMedia Technology Inc. ASM1042A=20
USB 3.0 Host Controller [1b21:1142]

Ethernet, SATA and USB controller in its own group.

And with 5.9, everything is in one group:
IOMMU Group 29:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:1c.0 PCI bridge [0604]: In=
tel Corporation C610/X99 series=20
chipset PCI Express Root Port #1 [8086:8d10] (rev d5)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:1c.3 PCI bridge [0604]: In=
tel Corporation C610/X99 series=20
chipset PCI Express Root Port #4 [8086:8d16] (rev d5)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:1c.4 PCI bridge [0604]: In=
tel Corporation C610/X99 series=20
chipset PCI Express Root Port #5 [8086:8d18] (rev d5)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:1c.6 PCI bridge [0604]: In=
tel Corporation C610/X99 series=20
chipset PCI Express Root Port #7 [8086:8d1c] (rev d5)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 07:00.0 PCI bridge [0604]: AS=
Media Technology Inc. Device=20
[1b21:118f]
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 08:01.0 PCI bridge [0604]: AS=
Media Technology Inc. Device=20
[1b21:118f]
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 08:03.0 PCI bridge [0604]: AS=
Media Technology Inc. Device=20
[1b21:118f]
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 08:04.0 PCI bridge [0604]: AS=
Media Technology Inc. Device=20
[1b21:118f]
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 09:00.0 Ethernet controller [=
0200]: Intel Corporation I211=20
Gigabit Network Connection [8086:1539] (rev 03)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0c:00.0 SATA controller [0106=
]: ASMedia Technology Inc. ASM1062=20
Serial ATA Controller [1b21:0612] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0d:00.0 USB controller [0c03]=
: ASMedia Technology Inc. ASM1042A=20
USB 3.0 Host Controller [1b21:1142]


This seems to be caused by commit 52fbf5bdeeef415b28b8e6cdade1e48927927f6=
0.
commit 52fbf5bdeeef415b28b8e6cdade1e48927927f60
Author: Rajat Jain <rajatja@google.com>
Date:=C2=A0=C2=A0 Tue Jul 7 15:46:02 2020 -0700

 =C2=A0=C2=A0=C2=A0 PCI: Cache ACS capability offset in device

 =C2=A0=C2=A0=C2=A0 Currently the ACS capability is being looked up at a =
number of=20
places. Read
 =C2=A0=C2=A0=C2=A0 and store it once at enumeration so that it can be us=
ed by all=20
later.=C2=A0 No
 =C2=A0=C2=A0=C2=A0 functional change intended.

 =C2=A0=C2=A0=C2=A0 Link:=20
https://lore.kernel.org/r/20200707224604.3737893-2-rajatja@google.com
 =C2=A0=C2=A0=C2=A0 Signed-off-by: Rajat Jain <rajatja@google.com>
 =C2=A0=C2=A0=C2=A0 Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

 =C2=A0drivers/pci/p2pdma.c |=C2=A0 2 +-
 =C2=A0drivers/pci/pci.c=C2=A0=C2=A0=C2=A0 | 20 ++++++++++++++++----
 =C2=A0drivers/pci/pci.h=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
 =C2=A0drivers/pci/probe.c=C2=A0 |=C2=A0 2 +-
 =C2=A0drivers/pci/quirks.c |=C2=A0 8 ++++----
 =C2=A0include/linux/pci.h=C2=A0 |=C2=A0 1 +
 =C2=A06 files changed, 24 insertions(+), 11 deletions(-)


If I revert this commit, I get back old groups.

In commit log there is message 'No functional change intended'. But=20
there is functional change.

This is Intel Core i7-5930K CPU and X99 chipset. But I see the same=20
thing on other Intel systems (didn't test on AMD).


Below are full IOMMU groups.

Kernel 5.8 or 5.9 with commit 52fbf5bdeeef415b28b8e6cdade1e48927927f60=20
reverted:

IOMMU Group 0:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:0b.0 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 R3 QPI Link 0 & 1 Monitoring [8086:2f81] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:0b.1 Performance counters =
[1101]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 R3 QPI Link 0 & 1 Monitoring [8086:2f36] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:0b.2 Performance counters =
[1101]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 R3 QPI Link 0 & 1 Monitoring [8086:2f37] (rev 02)
IOMMU Group 1:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:0c.0 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Unicast Registers [8086:2fe0] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:0c.1 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Unicast Registers [8086:2fe1] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:0c.2 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Unicast Registers [8086:2fe2] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:0c.3 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Unicast Registers [8086:2fe3] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:0c.4 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Unicast Registers [8086:2fe4] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:0c.5 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Unicast Registers [8086:2fe5] (rev 02)
IOMMU Group 10:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:1e.0 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Power Control Unit [8086:2f98] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:1e.1 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Power Control Unit [8086:2f99] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:1e.2 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Power Control Unit [8086:2f9a] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:1e.3 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Power Control Unit [8086:2fc0] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:1e.4 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Power Control Unit [8086:2f9c] (rev 02)
IOMMU Group 11:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:1f.0 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 VCU [8086:2f88] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:1f.2 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 VCU [8086:2f8a] (rev 02)
IOMMU Group 12:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:00.0 Host bridge [0600]: I=
ntel Corporation Xeon E7 v3/Xeon=20
E5 v3/Core i7 DMI2 [8086:2f00] (rev 02)
IOMMU Group 13:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:01.0 PCI bridge [0604]: In=
tel Corporation Xeon E7 v3/Xeon E5=20
v3/Core i7 PCI Express Root Port 1 [8086:2f02] (rev 02)
IOMMU Group 14:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:01.1 PCI bridge [0604]: In=
tel Corporation Xeon E7 v3/Xeon E5=20
v3/Core i7 PCI Express Root Port 1 [8086:2f03] (rev 02)
IOMMU Group 15:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:02.0 PCI bridge [0604]: In=
tel Corporation Xeon E7 v3/Xeon E5=20
v3/Core i7 PCI Express Root Port 2 [8086:2f04] (rev 02)
IOMMU Group 16:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:03.0 PCI bridge [0604]: In=
tel Corporation Xeon E7 v3/Xeon E5=20
v3/Core i7 PCI Express Root Port 3 [8086:2f08] (rev 02)
IOMMU Group 17:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:03.2 PCI bridge [0604]: In=
tel Corporation Xeon E7 v3/Xeon E5=20
v3/Core i7 PCI Express Root Port 3 [8086:2f0a] (rev 02)
IOMMU Group 18:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:05.0 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Address Map, VTd_Misc, System Management=20
[8086:2f28] (rev 02)
IOMMU Group 19:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:05.1 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Hot Plug [8086:2f29] (rev 02)
IOMMU Group 2:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:0f.0 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Buffered Ring Agent [8086:2ff8] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:0f.1 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Buffered Ring Agent [8086:2ff9] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:0f.4 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 System Address Decoder & Broadcast Registers=20
[8086:2ffc] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:0f.5 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 System Address Decoder & Broadcast Registers=20
[8086:2ffd] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:0f.6 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 System Address Decoder & Broadcast Registers=20
[8086:2ffe] (rev 02)
IOMMU Group 20:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:05.2 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 RAS, Control Status and Global Errors [8086:2f2a]=20
(rev 02)
IOMMU Group 21:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:05.4 PIC [0800]: Intel Cor=
poration Xeon E7 v3/Xeon E5=20
v3/Core i7 I/O APIC [8086:2f2c] (rev 02)
IOMMU Group 22:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:11.0 Unassigned class [ff0=
0]: Intel Corporation C610/X99=20
series chipset SPSR [8086:8d7c] (rev 05)
IOMMU Group 23:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:11.4 SATA controller [0106=
]: Intel Corporation C610/X99=20
series chipset sSATA Controller [AHCI mode] [8086:8d62] (rev 05)
IOMMU Group 24:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:14.0 USB controller [0c03]=
: Intel Corporation C610/X99=20
series chipset USB xHCI Host Controller [8086:8d31] (rev 05)
IOMMU Group 25:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:16.0 Communication control=
ler [0780]: Intel Corporation=20
C610/X99 series chipset MEI Controller #1 [8086:8d3a] (rev 05)
IOMMU Group 26:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:19.0 Ethernet controller [=
0200]: Intel Corporation Ethernet=20
Connection (2) I218-V [8086:15a1] (rev 05)
IOMMU Group 27:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:1a.0 USB controller [0c03]=
: Intel Corporation C610/X99=20
series chipset USB Enhanced Host Controller #2 [8086:8d2d] (rev 05)
IOMMU Group 28:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:1b.0 Audio device [0403]: =
Intel Corporation C610/X99 series=20
chipset HD Audio Controller [8086:8d20] (rev 05)
IOMMU Group 29:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:1c.0 PCI bridge [0604]: In=
tel Corporation C610/X99 series=20
chipset PCI Express Root Port #1 [8086:8d10] (rev d5)
IOMMU Group 3:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:10.0 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 PCIe Ring Interface [8086:2f1d] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:10.1 Performance counters =
[1101]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 PCIe Ring Interface [8086:2f34] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:10.5 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Scratchpad & Semaphore Registers [8086:2f1e] (rev 0=
2)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:10.6 Performance counters =
[1101]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Scratchpad & Semaphore Registers [8086:2f7d] (rev 0=
2)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:10.7 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Scratchpad & Semaphore Registers [8086:2f1f] (rev 0=
2)
IOMMU Group 30:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:1c.3 PCI bridge [0604]: In=
tel Corporation C610/X99 series=20
chipset PCI Express Root Port #4 [8086:8d16] (rev d5)
IOMMU Group 31:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:1c.4 PCI bridge [0604]: In=
tel Corporation C610/X99 series=20
chipset PCI Express Root Port #5 [8086:8d18] (rev d5)
IOMMU Group 32:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:1c.6 PCI bridge [0604]: In=
tel Corporation C610/X99 series=20
chipset PCI Express Root Port #7 [8086:8d1c] (rev d5)
IOMMU Group 33:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:1d.0 USB controller [0c03]=
: Intel Corporation C610/X99=20
series chipset USB Enhanced Host Controller #1 [8086:8d26] (rev 05)
IOMMU Group 34:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:1f.0 ISA bridge [0601]: In=
tel Corporation C610/X99 series=20
chipset LPC Controller [8086:8d47] (rev 05)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:1f.2 SATA controller [0106=
]: Intel Corporation C610/X99=20
series chipset 6-Port SATA Controller [AHCI mode] [8086:8d02] (rev 05)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:1f.3 SMBus [0c05]: Intel C=
orporation C610/X99 series chipset=20
SMBus Controller [8086:8d22] (rev 05)
IOMMU Group 35:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 05:00.0 Non-Volatile memory c=
ontroller [0108]: Samsung=20
Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983 [144d:a808]
IOMMU Group 36:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 03:00.0 VGA compatible contro=
ller [0300]: NVIDIA Corporation=20
GM204 [GeForce GTX 980] [10de:13c0] (rev a1)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 03:00.1 Audio device [0403]: =
NVIDIA Corporation GM204 High=20
Definition Audio Controller [10de:0fbb] (rev a1)
IOMMU Group 37:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 02:00.0 Ethernet controller [=
0200]: Mellanox Technologies=20
MT27500 Family [ConnectX-3] [15b3:1003]
IOMMU Group 38:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 01:00.0 VGA compatible contro=
ller [0300]: NVIDIA Corporation=20
GP107 [GeForce GTX 1050 Ti] [10de:1c82] (rev a1)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 01:00.1 Audio device [0403]: =
NVIDIA Corporation GP107GL High=20
Definition Audio Controller [10de:0fb9] (rev a1)
IOMMU Group 39:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 07:00.0 PCI bridge [0604]: AS=
Media Technology Inc. Device=20
[1b21:118f]
IOMMU Group 4:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:12.0 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Home Agent 0 [8086:2fa0] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:12.1 Performance counters =
[1101]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Home Agent 0 [8086:2f30] (rev 02)
IOMMU Group 40:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 08:01.0 PCI bridge [0604]: AS=
Media Technology Inc. Device=20
[1b21:118f]
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 09:00.0 Ethernet controller [=
0200]: Intel Corporation I211=20
Gigabit Network Connection [8086:1539] (rev 03)
IOMMU Group 41:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 08:03.0 PCI bridge [0604]: AS=
Media Technology Inc. Device=20
[1b21:118f]
IOMMU Group 42:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 08:04.0 PCI bridge [0604]: AS=
Media Technology Inc. Device=20
[1b21:118f]
IOMMU Group 43:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0c:00.0 SATA controller [0106=
]: ASMedia Technology Inc. ASM1062=20
Serial ATA Controller [1b21:0612] (rev 02)
IOMMU Group 44:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0d:00.0 USB controller [0c03]=
: ASMedia Technology Inc. ASM1042A=20
USB 3.0 Host Controller [1b21:1142]
IOMMU Group 5:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:13.0 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Target Address,=20
Thermal & RAS Registers [8086... (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:13.1 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Target Address,=20
Thermal & RAS Registers [8086... (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:13.2 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target=20
Address Decoder [8086:2faa] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:13.3 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target=20
Address Decoder [8086:2fab] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:13.4 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target=20
Address Decoder [8086:2fac] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:13.5 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target=20
Address Decoder [8086:2fad] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:13.6 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 DDRIO Channel 0/1 Broadcast [8086:2fae] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:13.7 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 DDRIO Global Broadcast [8086:2faf] (rev 02)
IOMMU Group 6:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:14.0 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 0 Thermal=20
Control [8086:2fb0] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:14.1 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 1 Thermal=20
Control [8086:2fb1] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:14.2 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 0 ERROR=20
Registers [8086:2fb2] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:14.3 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 1 ERROR=20
Registers [8086:2fb3] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:14.4 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 0 & 1 [8086:2fbc] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:14.5 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 0 & 1 [8086:2fbd] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:14.6 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 0 & 1 [8086:2fbe] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:14.7 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 0 & 1 [8086:2fbf] (rev 02)
IOMMU Group 7:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:15.0 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 2 Thermal=20
Control [8086:2fb4] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:15.1 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 3 Thermal=20
Control [8086:2fb5] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:15.2 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 2 ERROR=20
Registers [8086:2fb6] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:15.3 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 3 ERROR=20
Registers [8086:2fb7] (rev 02)
IOMMU Group 8:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:16.0 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Integrated Memory Controller 1 Target Address,=20
Thermal & RAS Registers [8086... (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:16.6 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 DDRIO Channel 2/3 Broadcast [8086:2f6e] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:16.7 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 DDRIO Global Broadcast [8086:2f6f] (rev 02)
IOMMU Group 9:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:17.0 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Integrated Memory Controller 1 Channel 0 Thermal=20
Control [8086:2fd0] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:17.4 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 2 & 3 [8086:2fb8] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:17.5 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 2 & 3 [8086:2fb9] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:17.6 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 2 & 3 [8086:2fba] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:17.7 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 2 & 3 [8086:2fbb] (rev 02)


Kernel 5.9:

IOMMU Group 0:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:0b.0 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 R3 QPI Link 0 & 1 Monitoring [8086:2f81] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:0b.1 Performance counters =
[1101]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 R3 QPI Link 0 & 1 Monitoring [8086:2f36] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:0b.2 Performance counters =
[1101]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 R3 QPI Link 0 & 1 Monitoring [8086:2f37] (rev 02)
IOMMU Group 1:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:0c.0 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Unicast Registers [8086:2fe0] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:0c.1 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Unicast Registers [8086:2fe1] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:0c.2 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Unicast Registers [8086:2fe2] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:0c.3 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Unicast Registers [8086:2fe3] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:0c.4 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Unicast Registers [8086:2fe4] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:0c.5 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Unicast Registers [8086:2fe5] (rev 02)
IOMMU Group 10:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:1e.0 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Power Control Unit [8086:2f98] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:1e.1 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Power Control Unit [8086:2f99] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:1e.2 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Power Control Unit [8086:2f9a] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:1e.3 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Power Control Unit [8086:2fc0] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:1e.4 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Power Control Unit [8086:2f9c] (rev 02)
IOMMU Group 11:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:1f.0 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 VCU [8086:2f88] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:1f.2 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 VCU [8086:2f8a] (rev 02)
IOMMU Group 12:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:00.0 Host bridge [0600]: I=
ntel Corporation Xeon E7 v3/Xeon=20
E5 v3/Core i7 DMI2 [8086:2f00] (rev 02)
IOMMU Group 13:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:01.0 PCI bridge [0604]: In=
tel Corporation Xeon E7 v3/Xeon E5=20
v3/Core i7 PCI Express Root Port 1 [8086:2f02] (rev 02)
IOMMU Group 14:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:01.1 PCI bridge [0604]: In=
tel Corporation Xeon E7 v3/Xeon E5=20
v3/Core i7 PCI Express Root Port 1 [8086:2f03] (rev 02)
IOMMU Group 15:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:02.0 PCI bridge [0604]: In=
tel Corporation Xeon E7 v3/Xeon E5=20
v3/Core i7 PCI Express Root Port 2 [8086:2f04] (rev 02)
IOMMU Group 16:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:03.0 PCI bridge [0604]: In=
tel Corporation Xeon E7 v3/Xeon E5=20
v3/Core i7 PCI Express Root Port 3 [8086:2f08] (rev 02)
IOMMU Group 17:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:03.2 PCI bridge [0604]: In=
tel Corporation Xeon E7 v3/Xeon E5=20
v3/Core i7 PCI Express Root Port 3 [8086:2f0a] (rev 02)
IOMMU Group 18:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:05.0 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Address Map, VTd_Misc, System Management=20
[8086:2f28] (rev 02)
IOMMU Group 19:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:05.1 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Hot Plug [8086:2f29] (rev 02)
IOMMU Group 2:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:0f.0 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Buffered Ring Agent [8086:2ff8] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:0f.1 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Buffered Ring Agent [8086:2ff9] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:0f.4 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 System Address Decoder & Broadcast Registers=20
[8086:2ffc] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:0f.5 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 System Address Decoder & Broadcast Registers=20
[8086:2ffd] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:0f.6 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 System Address Decoder & Broadcast Registers=20
[8086:2ffe] (rev 02)
IOMMU Group 20:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:05.2 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 RAS, Control Status and Global Errors [8086:2f2a]=20
(rev 02)
IOMMU Group 21:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:05.4 PIC [0800]: Intel Cor=
poration Xeon E7 v3/Xeon E5=20
v3/Core i7 I/O APIC [8086:2f2c] (rev 02)
IOMMU Group 22:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:11.0 Unassigned class [ff0=
0]: Intel Corporation C610/X99=20
series chipset SPSR [8086:8d7c] (rev 05)
IOMMU Group 23:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:11.4 SATA controller [0106=
]: Intel Corporation C610/X99=20
series chipset sSATA Controller [AHCI mode] [8086:8d62] (rev 05)
IOMMU Group 24:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:14.0 USB controller [0c03]=
: Intel Corporation C610/X99=20
series chipset USB xHCI Host Controller [8086:8d31] (rev 05)
IOMMU Group 25:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:16.0 Communication control=
ler [0780]: Intel Corporation=20
C610/X99 series chipset MEI Controller #1 [8086:8d3a] (rev 05)
IOMMU Group 26:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:19.0 Ethernet controller [=
0200]: Intel Corporation Ethernet=20
Connection (2) I218-V [8086:15a1] (rev 05)
IOMMU Group 27:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:1a.0 USB controller [0c03]=
: Intel Corporation C610/X99=20
series chipset USB Enhanced Host Controller #2 [8086:8d2d] (rev 05)
IOMMU Group 28:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:1b.0 Audio device [0403]: =
Intel Corporation C610/X99 series=20
chipset HD Audio Controller [8086:8d20] (rev 05)
IOMMU Group 29:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:1c.0 PCI bridge [0604]: In=
tel Corporation C610/X99 series=20
chipset PCI Express Root Port #1 [8086:8d10] (rev d5)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:1c.3 PCI bridge [0604]: In=
tel Corporation C610/X99 series=20
chipset PCI Express Root Port #4 [8086:8d16] (rev d5)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:1c.4 PCI bridge [0604]: In=
tel Corporation C610/X99 series=20
chipset PCI Express Root Port #5 [8086:8d18] (rev d5)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:1c.6 PCI bridge [0604]: In=
tel Corporation C610/X99 series=20
chipset PCI Express Root Port #7 [8086:8d1c] (rev d5)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 07:00.0 PCI bridge [0604]: AS=
Media Technology Inc. Device=20
[1b21:118f]
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 08:01.0 PCI bridge [0604]: AS=
Media Technology Inc. Device=20
[1b21:118f]
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 08:03.0 PCI bridge [0604]: AS=
Media Technology Inc. Device=20
[1b21:118f]
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 08:04.0 PCI bridge [0604]: AS=
Media Technology Inc. Device=20
[1b21:118f]
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 09:00.0 Ethernet controller [=
0200]: Intel Corporation I211=20
Gigabit Network Connection [8086:1539] (rev 03)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0c:00.0 SATA controller [0106=
]: ASMedia Technology Inc. ASM1062=20
Serial ATA Controller [1b21:0612] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0d:00.0 USB controller [0c03]=
: ASMedia Technology Inc. ASM1042A=20
USB 3.0 Host Controller [1b21:1142]
IOMMU Group 3:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:10.0 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 PCIe Ring Interface [8086:2f1d] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:10.1 Performance counters =
[1101]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 PCIe Ring Interface [8086:2f34] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:10.5 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Scratchpad & Semaphore Registers [8086:2f1e] (rev 0=
2)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:10.6 Performance counters =
[1101]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Scratchpad & Semaphore Registers [8086:2f7d] (rev 0=
2)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:10.7 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Scratchpad & Semaphore Registers [8086:2f1f] (rev 0=
2)
IOMMU Group 30:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:1d.0 USB controller [0c03]=
: Intel Corporation C610/X99=20
series chipset USB Enhanced Host Controller #1 [8086:8d26] (rev 05)
IOMMU Group 31:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:1f.0 ISA bridge [0601]: In=
tel Corporation C610/X99 series=20
chipset LPC Controller [8086:8d47] (rev 05)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:1f.2 SATA controller [0106=
]: Intel Corporation C610/X99=20
series chipset 6-Port SATA Controller [AHCI mode] [8086:8d02] (rev 05)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:1f.3 SMBus [0c05]: Intel C=
orporation C610/X99 series chipset=20
SMBus Controller [8086:8d22] (rev 05)
IOMMU Group 32:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 05:00.0 Non-Volatile memory c=
ontroller [0108]: Samsung=20
Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983 [144d:a808]
IOMMU Group 33:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 03:00.0 VGA compatible contro=
ller [0300]: NVIDIA Corporation=20
GM204 [GeForce GTX 980] [10de:13c0] (rev a1)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 03:00.1 Audio device [0403]: =
NVIDIA Corporation GM204 High=20
Definition Audio Controller [10de:0fbb] (rev a1)
IOMMU Group 34:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 02:00.0 Ethernet controller [=
0200]: Mellanox Technologies=20
MT27500 Family [ConnectX-3] [15b3:1003]
IOMMU Group 35:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 01:00.0 VGA compatible contro=
ller [0300]: NVIDIA Corporation=20
GP107 [GeForce GTX 1050 Ti] [10de:1c82] (rev a1)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 01:00.1 Audio device [0403]: =
NVIDIA Corporation GP107GL High=20
Definition Audio Controller [10de:0fb9] (rev a1)
IOMMU Group 4:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:12.0 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Home Agent 0 [8086:2fa0] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:12.1 Performance counters =
[1101]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Home Agent 0 [8086:2f30] (rev 02)
IOMMU Group 5:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:13.0 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Target Address,=20
Thermal & RAS Registers [8086... (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:13.1 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Target Address,=20
Thermal & RAS Registers [8086... (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:13.2 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target=20
Address Decoder [8086:2faa] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:13.3 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target=20
Address Decoder [8086:2fab] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:13.4 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target=20
Address Decoder [8086:2fac] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:13.5 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target=20
Address Decoder [8086:2fad] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:13.6 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 DDRIO Channel 0/1 Broadcast [8086:2fae] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:13.7 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 DDRIO Global Broadcast [8086:2faf] (rev 02)
IOMMU Group 6:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:14.0 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 0 Thermal=20
Control [8086:2fb0] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:14.1 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 1 Thermal=20
Control [8086:2fb1] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:14.2 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 0 ERROR=20
Registers [8086:2fb2] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:14.3 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 1 ERROR=20
Registers [8086:2fb3] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:14.4 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 0 & 1 [8086:2fbc] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:14.5 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 0 & 1 [8086:2fbd] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:14.6 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 0 & 1 [8086:2fbe] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:14.7 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 0 & 1 [8086:2fbf] (rev 02)
IOMMU Group 7:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:15.0 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 2 Thermal=20
Control [8086:2fb4] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:15.1 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 3 Thermal=20
Control [8086:2fb5] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:15.2 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 2 ERROR=20
Registers [8086:2fb6] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:15.3 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 3 ERROR=20
Registers [8086:2fb7] (rev 02)
IOMMU Group 8:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:16.0 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Integrated Memory Controller 1 Target Address,=20
Thermal & RAS Registers [8086... (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:16.6 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 DDRIO Channel 2/3 Broadcast [8086:2f6e] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:16.7 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 DDRIO Global Broadcast [8086:2f6f] (rev 02)
IOMMU Group 9:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:17.0 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 Integrated Memory Controller 1 Channel 0 Thermal=20
Control [8086:2fd0] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:17.4 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 2 & 3 [8086:2fb8] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:17.5 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 2 & 3 [8086:2fb9] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:17.6 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 2 & 3 [8086:2fba] (rev 02)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff:17.7 System peripheral [08=
80]: Intel Corporation Xeon E7=20
v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 2 & 3 [8086:2fbb] (rev 02)

