Return-Path: <linux-pci+bounces-6351-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21738A8407
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 15:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47A51C21F60
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 13:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D41813D62C;
	Wed, 17 Apr 2024 13:16:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5A513DDAE
	for <linux-pci@vger.kernel.org>; Wed, 17 Apr 2024 13:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359775; cv=none; b=GNTkatrzf+oHHLQTgQHgVMreT5eI5dnLfSOKyTOn5It3Psu9PzBU2BIV3wXFCLnVjDvYmlcDPSRR5bsZSMvzeMTR8C7na30DP3s7zk+E81nOlJNP7NGOS+rWpYxHAGvs6hu6aJtt7fT3acB5cEnH1VHf7mcW75CsWe408M6MAoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359775; c=relaxed/simple;
	bh=05iGaNZerxPYbvgZ8UhCGbTTyp/C7lHEXiSREq79azY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=a8J2J6Iof/YOJQZF4ACi8xa4c7OdJOKKtCyoJbPw26u8bhoCQh4OajHh5XzVxFVWxQISnWfUG8iZSRzMouKvb6C/FFHQUd2Rq39L/ZQJjwI4ULEcaqXDWuRk5JMT1fc7kx7aTk7LuYI5bICj6fDzvUfv7oN3HFgsFWCXX6ap64c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bakke.com; spf=pass smtp.mailfrom=bakke.com; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bakke.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bakke.com
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 472D380E62;
	Wed, 17 Apr 2024 13:16:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: dag@bakke.com) by omf19.hostedemail.com (Postfix) with ESMTPA id C18B620029;
	Wed, 17 Apr 2024 13:16:07 +0000 (UTC)
Message-ID: <45df4a61-580d-49f9-96a9-13b091b9e256@bakke.com>
Date: Wed, 17 Apr 2024 15:16:06 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Dag B <dag@bakke.com>
Subject: PCIE BAR resizing blocked by another BAR on same device?
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C18B620029
X-Stat-Signature: td67afji5eww5x69186kk975riampwqj
X-Rspamd-Server: rspamout07
X-Session-Marker: 6461674062616B6B652E636F6D
X-Session-ID: U2FsdGVkX19eB91gdPZBmwwUHxlKiPD3hMW7fbfUwu8=
X-HE-Tag: 1713359767-260895
X-HE-Meta: U2FsdGVkX19ssJrft2qhHkruSTpGI80SOKyiGCLggIvMH3/GFhtwickDScYt7pyq4lsdVMPofM6Y6xxX5Sc7BmPokmzoylEkMW8vyZHMOfI7une0tmM70vwOrcIVulVm+mAoH5GhFfm/cUua1yvl9euHPDqwKEtIF6CdbTf868vJ6zQ8jXn1m5ezS3SnJPVWOL2y6//ut/OsXT4HnU5jA3o4WrULnw1yh4E9EyAkOIYoP1bsQzIX2Rt5n8VDsxfejhVrtHSc1K0wMziAZ9k7pO72Y4QMrrZNIe49WWi1J4ZVC8CWIEa+ug2lcFhmJsmtr85tix56chWBLFJb7dUd5MOfDLJ1gdIQ

Hi.

In short, I have a GPU for which lspci reveals:

Capabilities: [bb0 v1] Physical Resizable BAR

         BAR 0: current size: 16MB, supported: 16MB
         BAR 1: current size: 128MB, supported: 64MB 128MB 256MB 512MB 
1GB 2GB 4GB 8GB 16GB 32GB
         BAR 3: current size: 32MB, supported: 32MB

In dmesg I see:

[    0.517191] pci 0000:08:00.0: BAR 1 [mem 0x6000000000-0x600fffffff 
64bit pref]: assigned
[    0.517238] pci 0000:08:00.0: BAR 3 [mem 0x6010000000-0x6011ffffff 
64bit pref]: assigned
[    0.517261] pci 0000:08:00.0: BAR 0 [mem 0xa4000000-0xa4ffffff]: assigned

I take it the location of BAR 3 right after BAR 1 explains why I get:

p53 # echo 9 > resource1_resize
-bash: echo: write error: No space left on device

Shrinking it and increasing it to the orginal size works.


Is there anything I can do with current kernel functionality to reserve 
memory address space for the full-fat BAR 1? Or relocate it?

If not, is this something which *can* be worked around in the kernel? 
And if so, does it belong with the PCI subsystem? Or the devicedriver 
for the device in question?

Is there a good ELI13 resource explaining how resizable BAR works in Linux?

My current kernel command-line contains: pci=assign-busses,realloc

My GPU is attached via TB3 to a system for which resizable BAR is and 
will remain a foreign concept in the BIOS.

dmesg excerpt below reflects resizing the BAR to 128MB and then back to 
256MB.

[ 1730.091789] pci 0000:08:00.0: BAR 1 [mem 0x6000000000-0x600fffffff 
64bit pref]: releasing
[ 1730.091875] pci 0000:08:00.0: BAR 3 [mem 0x6010000000-0x6011ffffff 
64bit pref]: releasing
[ 1730.092072] pcieport 0000:07:01.0: bridge window [mem 
0x6000000000-0x6017ffffff 64bit pref]: releasing
[ 1730.092151] pcieport 0000:07:01.0: bridge window [mem 
0x6000000000-0x6017ffffff 64bit pref]: assigned
[ 1730.092223] pci 0000:08:00.0: BAR 1 [mem 0x6000000000-0x600fffffff 
64bit pref]: assigned
[ 1730.092335] pci 0000:08:00.0: BAR 3 [mem 0x6010000000-0x6011ffffff 
64bit pref]: assigned
[ 1730.092444] pcieport 0000:06:00.0: PCI bridge to [bus 07-09]
[ 1730.092510] pcieport 0000:06:00.0:   bridge window [io 0x4000-0x6fff]
[ 1730.092595] pcieport 0000:06:00.0:   bridge window [mem 
0xa4000000-0xafffffff]
[ 1730.092680] pcieport 0000:06:00.0:   bridge window [mem 
0x6000000000-0x601fffffff 64bit pref]
[ 1730.092778] pcieport 0000:07:01.0: PCI bridge to [bus 08]
[ 1730.092850] pcieport 0000:07:01.0:   bridge window [io 0x4000-0x4fff]
[ 1730.092933] pcieport 0000:07:01.0:   bridge window [mem 
0xa4000000-0xa57fffff]
[ 1730.093018] pcieport 0000:07:01.0:   bridge window [mem 
0x6000000000-0x6017ffffff 64bit pref]
[ 1759.817306] pci 0000:08:00.0: BAR 1 [mem 0x6000000000-0x600fffffff 
64bit pref]: releasing
[ 1759.817394] pci 0000:08:00.0: BAR 3 [mem 0x6010000000-0x6011ffffff 
64bit pref]: releasing
[ 1759.817591] pcieport 0000:07:01.0: bridge window [mem 
0x6000000000-0x6017ffffff 64bit pref]: releasing
[ 1759.817668] pcieport 0000:07:01.0: bridge window [mem 
0x6000000000-0x600bffffff 64bit pref]: assigned
[ 1759.817740] pci 0000:08:00.0: BAR 1 [mem 0x6000000000-0x6007ffffff 
64bit pref]: assigned
[ 1759.817853] pci 0000:08:00.0: BAR 3 [mem 0x6008000000-0x6009ffffff 
64bit pref]: assigned
[ 1759.817964] pcieport 0000:06:00.0: PCI bridge to [bus 07-09]
[ 1759.818035] pcieport 0000:06:00.0:   bridge window [io 0x4000-0x6fff]
[ 1759.818120] pcieport 0000:06:00.0:   bridge window [mem 
0xa4000000-0xafffffff]
[ 1759.818204] pcieport 0000:06:00.0:   bridge window [mem 
0x6000000000-0x601fffffff 64bit pref]
[ 1759.818303] pcieport 0000:07:01.0: PCI bridge to [bus 08]
[ 1759.818374] pcieport 0000:07:01.0:   bridge window [io 0x4000-0x4fff]
[ 1759.818459] pcieport 0000:07:01.0:   bridge window [mem 
0xa4000000-0xa57fffff]
[ 1759.818544] pcieport 0000:07:01.0:   bridge window [mem 
0x6000000000-0x600bffffff 64bit pref]
[ 1769.797178] pci 0000:08:00.0: BAR 1 [mem 0x6000000000-0x6007ffffff 
64bit pref]: releasing
[ 1769.797241] pci 0000:08:00.0: BAR 3 [mem 0x6008000000-0x6009ffffff 
64bit pref]: releasing
[ 1769.797417] pcieport 0000:07:01.0: bridge window [mem 
0x6000000000-0x600bffffff 64bit pref]: releasing
[ 1769.797473] pcieport 0000:07:01.0: bridge window [mem size 0x30000000 
64bit pref]: can't assign; no space
[ 1769.797515] pcieport 0000:07:01.0: bridge window [mem size 0x30000000 
64bit pref]: failed to assign
[ 1769.797557] pci 0000:08:00.0: BAR 1 [mem size 0x20000000 64bit pref]: 
can't assign; no space
[ 1769.797594] pci 0000:08:00.0: BAR 1 [mem size 0x20000000 64bit pref]: 
failed to assign
[ 1769.797630] pci 0000:08:00.0: BAR 3 [mem size 0x02000000 64bit pref]: 
can't assign; no space
[ 1769.797666] pci 0000:08:00.0: BAR 3 [mem size 0x02000000 64bit pref]: 
failed to assign
[ 1769.797703] pcieport 0000:06:00.0: PCI bridge to [bus 07-09]
[ 1769.797761] pcieport 0000:06:00.0:   bridge window [io 0x4000-0x6fff]
[ 1769.797829] pcieport 0000:06:00.0:   bridge window [mem 
0xa4000000-0xafffffff]
[ 1769.797895] pcieport 0000:06:00.0:   bridge window [mem 
0x6000000000-0x601fffffff 64bit pref]
[ 1769.797972] pcieport 0000:07:01.0: PCI bridge to [bus 08]
[ 1769.798027] pcieport 0000:07:01.0:   bridge window [io 0x4000-0x4fff]
[ 1769.798089] pcieport 0000:07:01.0:   bridge window [mem 
0xa4000000-0xa57fffff]
[ 1769.798155] pcieport 0000:07:01.0:   bridge window [mem 
0x6000000000-0x600bffffff 64bit pref]
[ 1769.798270] pci 0000:08:00.0: BAR 1 [mem 0x6000000000-0x6007ffffff 
64bit pref]: assigned
[ 1769.798358] pci 0000:08:00.0: BAR 3 [mem 0x6008000000-0x6009ffffff 
64bit pref]: assigned
[ 2669.324929] pci 0000:08:00.0: BAR 1 [mem 0x6000000000-0x6007ffffff 
64bit pref]: releasing
[ 2669.324992] pci 0000:08:00.0: BAR 3 [mem 0x6008000000-0x6009ffffff 
64bit pref]: releasing
[ 2669.325164] pcieport 0000:07:01.0: bridge window [mem 
0x6000000000-0x600bffffff 64bit pref]: releasing
[ 2669.325219] pcieport 0000:07:01.0: bridge window [mem size 0x30000000 
64bit pref]: can't assign; no space
[ 2669.327023] pcieport 0000:07:01.0: bridge window [mem size 0x30000000 
64bit pref]: failed to assign
[ 2669.328798] pci 0000:08:00.0: BAR 1 [mem size 0x20000000 64bit pref]: 
can't assign; no space
[ 2669.330482] pci 0000:08:00.0: BAR 1 [mem size 0x20000000 64bit pref]: 
failed to assign
[ 2669.331104] pci 0000:08:00.0: BAR 3 [mem size 0x02000000 64bit pref]: 
can't assign; no space
[ 2669.331682] pci 0000:08:00.0: BAR 3 [mem size 0x02000000 64bit pref]: 
failed to assign
[ 2669.332258] pcieport 0000:06:00.0: PCI bridge to [bus 07-09]
[ 2669.332855] pcieport 0000:06:00.0:   bridge window [io 0x4000-0x6fff]
[ 2669.333444] pcieport 0000:06:00.0:   bridge window [mem 
0xa4000000-0xafffffff]
[ 2669.334130] pcieport 0000:06:00.0:   bridge window [mem 
0x6000000000-0x601fffffff 64bit pref]
[ 2669.334821] pcieport 0000:07:01.0: PCI bridge to [bus 08]
[ 2669.335460] pcieport 0000:07:01.0:   bridge window [io 0x4000-0x4fff]
[ 2669.336063] pcieport 0000:07:01.0:   bridge window [mem 
0xa4000000-0xa57fffff]
[ 2669.336657] pcieport 0000:07:01.0:   bridge window [mem 
0x6000000000-0x600bffffff 64bit pref]
[ 2669.337442] pci 0000:08:00.0: BAR 1 [mem 0x6000000000-0x6007ffffff 
64bit pref]: assigned
[ 2669.338073] pci 0000:08:00.0: BAR 3 [mem 0x6008000000-0x6009ffffff 
64bit pref]: assigned
[ 2673.200263] pci 0000:08:00.0: BAR 1 [mem 0x6000000000-0x6007ffffff 
64bit pref]: releasing
[ 2673.201935] pci 0000:08:00.0: BAR 3 [mem 0x6008000000-0x6009ffffff 
64bit pref]: releasing
[ 2673.203801] pcieport 0000:07:01.0: bridge window [mem 
0x6000000000-0x600bffffff 64bit pref]: releasing
[ 2673.205461] pcieport 0000:07:01.0: bridge window [mem 
0x6000000000-0x6017ffffff 64bit pref]: assigned
[ 2673.206197] pci 0000:08:00.0: BAR 1 [mem 0x6000000000-0x600fffffff 
64bit pref]: assigned
[ 2673.206800] pci 0000:08:00.0: BAR 3 [mem 0x6010000000-0x6011ffffff 
64bit pref]: assigned
[ 2673.207534] pcieport 0000:06:00.0: PCI bridge to [bus 07-09]
[ 2673.208143] pcieport 0000:06:00.0:   bridge window [io 0x4000-0x6fff]
[ 2673.208734] pcieport 0000:06:00.0:   bridge window [mem 
0xa4000000-0xafffffff]
[ 2673.209323] pcieport 0000:06:00.0:   bridge window [mem 
0x6000000000-0x601fffffff 64bit pref]
[ 2673.209916] pcieport 0000:07:01.0: PCI bridge to [bus 08]
[ 2673.210526] pcieport 0000:07:01.0:   bridge window [io 0x4000-0x4fff]
[ 2673.211170] pcieport 0000:07:01.0:   bridge window [mem 
0xa4000000-0xa57fffff]
[ 2673.211755] pcieport 0000:07:01.0:   bridge window [mem 
0x6000000000-0x6017ffffff 64bit pref]


Unsure what else from dmesg or kernel config is relevant here. Can post 
the full 100k here or somewhere else. Or excerpts.

[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x00000000000fffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000006f23bfff] usable
[    0.000000] BIOS-e820: [mem 0x000000006f23c000-0x000000006f23cfff] 
reserved
[    0.000000] BIOS-e820: [mem 0x000000006f23d000-0x000000007a792fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007a793000-0x000000007fa6cfff] 
reserved
[    0.000000] BIOS-e820: [mem 0x000000007fa6d000-0x000000007fca9fff] 
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007fcaa000-0x000000007fd0efff] 
ACPI data
[    0.000000] BIOS-e820: [mem 0x000000007fd0f000-0x000000007fd0ffff] usable
[    0.000000] BIOS-e820: [mem 0x000000007fd10000-0x0000000087ffffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x0000000088000000-0x00000000887fffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000088800000-0x000000008f7fffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe010000-0x00000000fe010fff] 
reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000106c7fffff] usable
[    0.000000] efi: Not removing mem55: MMIO 
range=[0xfe010000-0xfe010fff] (4KB) from e820 map
[    0.000003] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000006] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.503260] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    0.503262] e820: reserve RAM buffer [mem 0x6f23c000-0x6fffffff]
[    0.503263] e820: reserve RAM buffer [mem 0x7a793000-0x7bffffff]
[    0.503264] e820: reserve RAM buffer [mem 0x7fd10000-0x7fffffff]
[    0.503265] e820: reserve RAM buffer [mem 0x88800000-0x8bffffff]
[    0.503266] e820: reserve RAM buffer [mem 0x106c800000-0x106fffffff]


[    0.255546] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.445755] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM 
ClockPM Segments MSI HPX-Type3]
[    0.447023] acpi PNP0A08:00: _OSC: platform does not support [AER]
[    0.449507] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME 
PCIeCapability LTR]
[    0.449511] acpi PNP0A08:00: FADT indicates ASPM is unsupported, 
using BIOS configuration

[    0.522380] caller snb_uncore_imc_init_box+0x73/0xd0 mapping multiple 
BARs


Thanks,


Dag B


