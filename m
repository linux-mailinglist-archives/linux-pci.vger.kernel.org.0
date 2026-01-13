Return-Path: <linux-pci+bounces-44596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51176D17CE9
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 10:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5884A30319BD
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 09:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7006B341AB1;
	Tue, 13 Jan 2026 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="FgjeEKPK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42A832E6BE;
	Tue, 13 Jan 2026 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768297401; cv=none; b=uQ4lwF84yewKrpkMclfQpt4AVYkEsAPdFM1xNNy/uBm+jUou4IORKkkzoT0Wbab22if5V0Vw82JvxDjPlmzZJGv8dkaztz1dx9J5xdv3Zm/oomlZY8t/9iaLtivkGUrVmeIkSlgkKlkS5uvsoovK2424u1t8CnX+xHf6LqEIvkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768297401; c=relaxed/simple;
	bh=sguzIM1Ix6zHG6IpC4jfs/T5njy56yMXOeWVo46TLUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SwweP13lutEGHfApb9K2ZFjjKAFmmpk27JE9gGv837S7uB9t0IJai+pChKzygQb8E1V1wXd13xEjii9E1q7cU/KTlfgeOmvN6C4w88ymqcyTly2mppGid4hDFq++Ngj4z7qZudrOoxgXHKZ0QlL1S+V38aP7edJM+54HrcM4qrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=FgjeEKPK; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768297307; x=1768902107; i=spasswolf@web.de;
	bh=BpVw4XXspt886Oa/Z9L9aBMrhfeGgrATjtyMTzSgV7k=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FgjeEKPKhgeVQe6FYF31rker5RWsWeQ3Vm3gOHmy4KY4wTiSJl9ygydW9GuJBwXV
	 OTmK6+rY6jjVY4/bE6Ih+UVeHcE9Xptj8P4pCg9Y+9Uyd8/TGtwDc8jyRQDQP4DzO
	 2NcgeLZuwLUxBMd5NTPjUOQOdvaMfjw2zYzjk4WSt/z+RyXvCZ0jxLVk33d+aieHC
	 TEd+pwcmBmoGAArEEtVkC1R53m3O2363O3AVW2jML7wm/yFjnEmMyXBje9vQdujzK
	 s8+3Co2tOL6zfGh+YgwTmARpSS0kE/mSu9yIy/5Q4qYxIQuvncTG/oSkiHVTkLGPp
	 AcNUop5YVVRHRMyqhQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([95.223.134.88]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1Mcpuy-1wENUf20Ac-00jEMp; Tue, 13 Jan 2026 10:41:47 +0100
From: Bert Karwatzki <spasswolf@web.de>
To: linux-kernel@vger.kernel.org
Cc: Bert Karwatzki <spasswolf@web.de>,
	linux-next@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	regressions@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	acpica-devel@lists.linux.dev,
	Robert Moore <robert.moore@intel.com>,
	Saket Dumbre <saket.dumbre@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Clemens Ladisch <clemens@ladisch.de>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Yury Norov <yury.norov@gmail.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Baoquan He <bhe@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Doug Anderson <dianders@chromium.org>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Helge Deller <deller@gmx.de>,
	Ingo Molnar <mingo@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joanthan Cameron <Jonathan.Cameron@huawei.com>,
	Joel Granados <joel.granados@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Kees Cook <kees@kernel.org>,
	Li Huafei <lihuafei1@huawei.com>,
	"Luck, Tony" <tony.luck@intel.com>,
	Luo Gengkun <luogengkun@huaweicloud.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Nam Cao <namcao@linutronix.de>,
	oushixiong <oushixiong@kylinos.cn>,
	Petr Mladek <pmladek@suse.com>,
	Qianqiang Liu <qianqiang.liu@163.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleinxer <tglx@linutronix.de>,
	Thomas Zimemrmann <tzimmermann@suse.de>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Ville Syrjala <ville.syrjala@linux.intel.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	W_Armin@gmx.de
Subject: NMI stack overflow during resume of PCIe bridge with CONFIG_HARDLOCKUP_DETECTOR=y
Date: Tue, 13 Jan 2026 10:41:25 +0100
Message-ID: <20260113094129.3357-1-spasswolf@web.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: ec99725df78fdd0fd9d4398d00fdebb84cb38ee6.camel@web.de
References: 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NrS7vaaKUSELRDWuI139uxjTIayH++6LwQIfUKXACbKE7phNJkU
 n4txPDPjS/LEjw92o/CTf2nsNp6PE0T+Zm5np9TnnNCusycr7EcHfyWKS+sdLhwYZVxq/ox
 1LzIobGXqw8I6ZLNzvSfzhno0vyAAvhYGgwTGMXgqaFNAItMIVa+PITQFVXcCULsY97ForH
 1v6nEd6TZaCIThcg+8EqQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uPlfr/CF33M=;ekHu3INhWkzVQq+KGkdLZ+Ah9Ud
 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

The investigation into this bug has taken yet another dramatic turn of eve=
nts.
I'll summarize what I've found so far:

On my MSI Alpha 15 Dual GPU Laptop with the following hardware

$ lspci -nn
00:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Renoir/Ceza=
nne Root Complex [1022:1630]
00:00.2 IOMMU [0806]: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne IO=
MMU [1022:1631]
00:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Renoir PCIe=
 Dummy Host Bridge [1022:1632]
00:01.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Renoir PCIe =
GPP Bridge [1022:1633]
00:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Renoir PCIe=
 Dummy Host Bridge [1022:1632]
00:02.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Renoir/Cezan=
ne PCIe GPP Bridge [1022:1634]
00:02.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Renoir/Cezan=
ne PCIe GPP Bridge [1022:1634]
00:02.3 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Renoir/Cezan=
ne PCIe GPP Bridge [1022:1634]
00:02.4 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Renoir/Cezan=
ne PCIe GPP Bridge [1022:1634]
00:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Renoir PCIe=
 Dummy Host Bridge [1022:1632]
00:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Renoir Inter=
nal PCIe GPP Bridge to Bus [1022:1635]
00:14.0 SMBus [0c05]: Advanced Micro Devices, Inc. [AMD] FCH SMBus Control=
ler [1022:790b] (rev 51)
00:14.3 ISA bridge [0601]: Advanced Micro Devices, Inc. [AMD] FCH LPC Brid=
ge [1022:790e] (rev 51)
00:18.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Cezanne Dat=
a Fabric; Function 0 [1022:166a]
00:18.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Cezanne Dat=
a Fabric; Function 1 [1022:166b]
00:18.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Cezanne Dat=
a Fabric; Function 2 [1022:166c]
00:18.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Cezanne Dat=
a Fabric; Function 3 [1022:166d]
00:18.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Cezanne Dat=
a Fabric; Function 4 [1022:166e]
00:18.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Cezanne Dat=
a Fabric; Function 5 [1022:166f]
00:18.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Cezanne Dat=
a Fabric; Function 6 [1022:1670]
00:18.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Cezanne Dat=
a Fabric; Function 7 [1022:1671]
01:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 =
XL Upstream Port of PCI Express Switch [1002:1478] (rev c3)
02:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 =
XL Downstream Port of PCI Express Switch [1002:1479]
03:00.0 Display controller [0380]: Advanced Micro Devices, Inc. [AMD/ATI] =
Navi 23 [Radeon RX 6600/6600 XT/6600M] [1002:73ff] (rev c3)
03:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] Navi 2=
1/23 HDMI/DP Audio Controller [1002:ab28]
04:00.0 Network controller [0280]: MEDIATEK Corp. MT7921K (RZ608) Wi-Fi 6E=
 80MHz [14c3:0608]
05:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL811=
1/8168/8211/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev =
15)
06:00.0 Non-Volatile memory controller [0108]: Kingston Technology Company=
, Inc. KC3000/FURY Renegade NVMe SSD [E18] [2646:5013] (rev 01)
07:00.0 Non-Volatile memory controller [0108]: Micron/Crucial Technology P=
1 NVMe PCIe SSD[Frampton] [c0a9:2263] (rev 03)
08:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AM=
D/ATI] Cezanne [Radeon Vega Series / Radeon Vega Mobile Series] [1002:1638=
] (rev c5)
08:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] Renoir=
 Radeon High Definition Audio Controller [1002:1637]
08:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] F=
amily 17h (Models 10h-1fh) Platform Security Processor [1022:15df]
08:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Renoir/C=
ezanne USB 3.1 [1022:1639]
08:00.4 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Renoir/C=
ezanne USB 3.1 [1022:1639]
08:00.5 Multimedia controller [0480]: Advanced Micro Devices, Inc. [AMD] A=
udio Coprocessor [1022:15e2] (rev 01)
08:00.6 Audio device [0403]: Advanced Micro Devices, Inc. [AMD] Family 17h=
/19h/1ah HD Audio Controller [1022:15e3]
08:00.7 Signal processing controller [1180]: Advanced Micro Devices, Inc. =
[AMD] Sensor Fusion Hub [1022:15e4]

I've been encountering random crashes when resuming the discrete GPU

03:00.0 Display controller [0380]: Advanced Micro Devices, Inc. [AMD/ATI] =
Navi 23 [Radeon RX 6600/6600 XT/6600M] [1002:73ff] (rev c3)

These random crashes can actually be provoked by the following script

#!/bin/bash
for i in {0..10000}
do
	echo $i
	evolution &
	sleep 5
	killall evolution
	sleep 5
done

or

#!/bin/bash

while :
do
	DRI_PRIME=3D1 glxinfo > /dev/null
	sleep 10
done

though it still takes between 2 and 5 hours to trigger a crash.

The actual crash happens when resuming the PCI bridge to which the GPU is =
connected

00:01.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Renoir PCIe =
GPP Bridge [1022:1633]

As there are no error message for this in dmesg (using netconsole) and nei=
ter kdump or kgdboE
work in this case I used printk()s in the resume code to locate try and lo=
cate the
exact place of the crash. I found that the last shown printk message befor=
e the crash
was in the ACPICA interpreter in acpi_ex_system_memory_space_handler():

acpi_ex_system_memory_space_handler(...)
{
	[...]
	/*
	 * Perform the memory read or write
	 *
	 * Note: For machines that do not support non-aligned transfers, the targ=
et
	 * address was checked for alignment above. We do not attempt to break th=
e
	 * transfer up into smaller (byte-size) chunks because the AML specifical=
ly
	 * asked for a transfer width that the hardware may require.
	 */
	switch (function) {
	case ACPI_READ:
		if (debug)
			printk(KERN_INFO "%s %d value =3D %px\n", __func__, __LINE__, value);

		*value =3D 0;
		if (debug)
			printk(KERN_INFO "%s %d\n", __func__, __LINE__);
		switch (bit_width) {
		case 8:

			*value =3D (u64)ACPI_GET8(logical_addr_ptr);
			break;

		case 16:

			*value =3D (u64)ACPI_GET16(logical_addr_ptr);
			break;

		case 32:

			if (debug) // This is the last message shown on netconsole!
				printk(KERN_INFO "%s %d: logical_addr_ptr =3D %px\n", __func__, __LINE=
__, logical_addr_ptr);
			*value =3D (u64)ACPI_GET32(logical_addr_ptr);
			if (debug)
				printk(KERN_INFO "%s %d\n", __func__, __LINE__);
			break;

		case 64:

			*value =3D (u64)ACPI_GET64(logical_addr_ptr);
			break;

		default:

			/* bit_width was already validated */

			break;
		}
		break;

	case ACPI_WRITE:
		if (debug)
			printk(KERN_INFO "%s %d\n", __func__, __LINE__);

		switch (bit_width) {
			[...]
		}
		break;

	default:
		if (debug)
			printk(KERN_INFO "%s %d\n", __func__, __LINE__);

		status =3D AE_BAD_PARAMETER;
		break;
	}

	[...]
}

The memory which ACPICA is trying to read is at physical address 0xf010000=
0,
which belongs to the PCI ECAM memory on my machine (from /proc/iomem):

f0000000-fcffffff : PCI Bus 0000:00
  f0000000-f7ffffff : PCI ECAM 0000 [bus 00-7f]
    f0000000-f7ffffff : pnp 00:00

According to the PCIe specification the failing address 0xf0100000 is belo=
ngs to bus 01:
00:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Renoir PCIe=
 Dummy Host Bridge [1022:1632]
00:01.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Renoir PCIe =
GPP Bridge [1022:1633]
so the error occurs when trying to read ECAM memory that belongs to a fail=
ing device.

The code used to get to this can be found here (based on v6.14) (It's rath=
er messy though)
https://gitlab.freedesktop.org/spasswolf/linux-stable/-/commits/amdgpu_sus=
pend_resume_4?ref_type=3Dheads
and more details on the investigation can be found here:
https://github.com/acpica/acpica/issues/1060

So we seem to have a read to IO memory where the physical address fails as=
 the
device stopped working. I tried to consult the Documentation  (AMD64 Archi=
tecture Programmer=E2=80=99s Manual
Volume 2: System Programming), to find if an execption is raised in this c=
ase, but the Documentation
doesn't consider this case.

So I put printk()s in most of the execption handlers to find out if there =
is a chance
to catch this failed memory access and work around it. The code used in th=
is investigation can be found here:
https://gitlab.freedesktop.org/spasswolf/linux-stable/-/commits/amdgpu_sus=
pend_resume_fault_handler?ref_type=3Dheads

The result from this is that after the debug messages from the ACPICA inte=
rpreter
stop (where I previously thought a crash had occured), there are message f=
rom exc_nmi()
and the functions called by it.

Here's what I've found for a normal NMI:
2026-01-12T04:23:56.396721+01:00 T279584;exc_nmi: 0
2026-01-12T04:23:56.396721+01:00 C10;exc_nmi: 10.3
2026-01-12T04:23:56.396721+01:00 C10;default_do_nmi=20
2026-01-12T04:23:56.396721+01:00 C10;nmi_handle: type=3D0x0
2026-01-12T04:23:56.396721+01:00 C10;nmi_handle: a=3D0xffffffffa1612de0
2026-01-12T04:23:56.396721+01:00 C10;nmi_handle: a->handler=3Dperf_event_n=
mi_handler+0x0/0xa6
2026-01-12T04:23:56.396721+01:00 C10;perf_event_nmi_handler: 0
2026-01-12T04:23:56.396721+01:00 C10;perf_event_nmi_handler: 1
2026-01-12T04:23:56.396721+01:00 C10;perf_event_nmi_handler: 2
2026-01-12T04:23:56.396721+01:00 C10;x86_pmu_handle_irq: 2
2026-01-12T04:23:56.396721+01:00 C10;x86_pmu_handle_irq: 2.6
2026-01-12T04:23:56.396721+01:00 C10;__perf_event_overflow: 0
2026-01-12T04:23:56.396721+01:00 C10;__perf_event_overflow: 6.99: overflow=
_handler=3Dwatchdog_overflow_callback+0x0/0x10d
2026-01-12T04:23:56.396721+01:00 C10;watchdog_overflow_callback: 0
2026-01-12T04:23:56.396721+01:00 C10;__ktime_get_fast_ns_debug: 0.1
2026-01-12T04:23:56.396721+01:00 C10;tk_clock_read_debug: read=3Dread_hpet=
+0x0/0xf0
2026-01-12T04:23:56.396721+01:00 C10;read_hpet: 0
2026-01-12T04:23:56.396721+01:00 C10;read_hpet: 0.1
2026-01-12T04:23:56.396721+01:00 C10;timekeeping_cycles_to_ns_debug: 0
2026-01-12T04:23:56.396721+01:00 C10;watchdog_check_timestamp: 0
2026-01-12T04:23:56.396721+01:00 C10;watchdog_check_timestamp: 1
2026-01-12T04:23:56.396721+01:00 C10;watchdog_check_timestamp: 2
2026-01-12T04:23:56.396721+01:00 C10;watchdog_check_timestamp: 3
2026-01-12T04:23:56.396721+01:00 C10;watchdog_overflow_callback: 1
2026-01-12T04:23:56.396721+01:00 C10;watchdog_overflow_callback: 2
2026-01-12T04:23:56.396721+01:00 C10;__perf_event_overflow: 7
2026-01-12T04:23:56.396721+01:00 C10;__perf_event_overflow: ret=3D0x0
2026-01-12T04:23:56.396721+01:00 C10;x86_pmu_handle_irq: 2.7
2026-01-12T04:23:56.396721+01:00 C10;x86_pmu_handle_irq: handled=3D0x1
2026-01-12T04:23:56.396721+01:00 C10;perf_event_nmi_handler: ret =3D 1
2026-01-12T04:23:56.396721+01:00 C10;perf_event_nmi_handler: 3
2026-01-12T04:23:56.396721+01:00 C10;nmi_handle: thishandled=3D0x1
2026-01-12T04:23:56.396721+01:00 C10;nmi_handle: a=3D0xffffffffa1623040
2026-01-12T04:23:56.396721+01:00 C10;nmi_handle: a->handler=3Dnmi_cpu_back=
trace_handler+0x0/0x20
2026-01-12T04:23:56.396721+01:00 C10;nmi_handle: thishandled=3D0x0
2026-01-12T04:23:56.396721+01:00 C10;nmi_handle: a=3D0xffffffffa16148e0
2026-01-12T04:23:56.396721+01:00 C10;nmi_handle: a->handler=3Dperf_ibs_nmi=
_handler+0x0/0x60
2026-01-12T04:23:56.396721+01:00 C10;nmi_handle: thishandled=3D0x0
2026-01-12T04:23:56.396721+01:00 C10;exc_nmi: 10.4
2026-01-12T04:23:56.396721+01:00 T279584;exc_nmi: 11
2026-01-12T04:23:56.396721+01:00 T279584;exc_nmi: 12
2026-01-12T04:23:56.396721+01:00 T279584;exc_nmi: 13

Here the interrupt handling works without triggering additional NMIs.

Here's the result in case of the crash:
2026-01-12T04:24:36.809904+01:00 T1510;acpi_ex_system_memory_space_handler=
 255: logical_addr_ptr =3D ffffc066977b3000
2026-01-12T04:24:36.846170+01:00 C14;exc_nmi: 0
2026-01-12T04:24:36.960760+01:00 C14;exc_nmi: 10.3
2026-01-12T04:24:36.960760+01:00 C14;default_do_nmi=20
2026-01-12T04:24:36.960760+01:00 C14;nmi_handle: type=3D0x0
2026-01-12T04:24:36.960760+01:00 C14;nmi_handle: a=3D0xffffffffa1612de0
2026-01-12T04:24:36.960760+01:00 C14;nmi_handle: a->handler=3Dperf_event_n=
mi_handler+0x0/0xa6
2026-01-12T04:24:36.960760+01:00 C14;perf_event_nmi_handler: 0
2026-01-12T04:24:36.960760+01:00 C14;perf_event_nmi_handler: 1
2026-01-12T04:24:36.960760+01:00 C14;perf_event_nmi_handler: 2
2026-01-12T04:24:36.960760+01:00 C14;x86_pmu_handle_irq: 2
2026-01-12T04:24:36.960760+01:00 C14;x86_pmu_handle_irq: 2.6
2026-01-12T04:24:36.960760+01:00 C14;__perf_event_overflow: 0
2026-01-12T04:24:36.960760+01:00 C14;__perf_event_overflow: 6.99: overflow=
_handler=3Dwatchdog_overflow_callback+0x0/0x10d
2026-01-12T04:24:36.960760+01:00 C14;watchdog_overflow_callback: 0
2026-01-12T04:24:36.960760+01:00 C14;__ktime_get_fast_ns_debug: 0.1
2026-01-12T04:24:36.960760+01:00 C14;tk_clock_read_debug: read=3Dread_hpet=
+0x0/0xf0
2026-01-12T04:24:36.960760+01:00 C14;read_hpet: 0
2026-01-12T04:24:36.960760+01:00 C14;read_hpet: 0.1
2026-01-12T04:24:36.960760+01:00 T0;exc_nmi: 0
2026-01-12T04:24:38.674625+01:00 C13;exc_nmi: 10.3
2026-01-12T04:24:38.674625+01:00 C13;default_do_nmi=20
2026-01-12T04:24:38.674625+01:00 C13;nmi_handle: type=3D0x0
2026-01-12T04:24:38.674625+01:00 C13;nmi_handle: a=3D0xffffffffa1612de0
2026-01-12T04:24:38.674625+01:00 C13;nmi_handle: a->handler=3Dperf_event_n=
mi_handler+0x0/0xa6
2026-01-12T04:24:38.674625+01:00 C13;perf_event_nmi_handler: 0
2026-01-12T04:24:38.674625+01:00 C13;perf_event_nmi_handler: 1
2026-01-12T04:24:38.674625+01:00 C13;perf_event_nmi_handler: 2
2026-01-12T04:24:38.674625+01:00 C13;x86_pmu_handle_irq: 2
2026-01-12T04:24:38.674625+01:00 C13;x86_pmu_handle_irq: 2.6
2026-01-12T04:24:38.674625+01:00 C13;__perf_event_overflow: 0
2026-01-12T04:24:38.674625+01:00 C13;__perf_event_overflow: 6.99: overflow=
_handler=3Dwatchdog_overflow_callback+0x0/0x10d
2026-01-12T04:24:38.674625+01:00 C13;watchdog_overflow_callback: 0
2026-01-12T04:24:38.674625+01:00 C13;__ktime_get_fast_ns_debug: 0.1
2026-01-12T04:24:38.674625+01:00 C13;tk_clock_read_debug: read=3Dread_hpet=
+0x0/0xf0
2026-01-12T04:24:38.674625+01:00 C13;read_hpet: 0
2026-01-12T04:24:38.674625+01:00 C13;read_hpet: 0.1
2026-01-12T04:24:38.674625+01:00 T0;exc_nmi: 0
2026-01-12T04:24:39.355101+01:00 C2;exc_nmi: 10.3
2026-01-12T04:24:39.355101+01:00 C2;default_do_nmi=20
2026-01-12T04:24:39.355101+01:00 C2;nmi_handle: type=3D0x0
2026-01-12T04:24:39.355101+01:00 C2;nmi_handle: a=3D0xffffffffa1612de0
2026-01-12T04:24:39.355101+01:00 C2;nmi_handle: a->handler=3Dperf_event_nm=
i_handler+0x0/0xa6
2026-01-12T04:24:39.355101+01:00 C2;perf_event_nmi_handler: 0
2026-01-12T04:24:39.355101+01:00 C2;perf_event_nmi_handler: 1
2026-01-12T04:24:39.355101+01:00 C2;perf_event_nmi_handler: 2
2026-01-12T04:24:39.355101+01:00 C2;x86_pmu_handle_irq: 2
2026-01-12T04:24:39.355101+01:00 C2;x86_pmu_handle_irq: 2.6
2026-01-12T04:24:39.355101+01:00 C2;__perf_event_overflow: 0
2026-01-12T04:24:39.355101+01:00 C2;__perf_event_overflow: 6.99: overflow_=
handler=3Dwatchdog_overflow_callback+0x0/0x10d
2026-01-12T04:24:39.355101+01:00 C2;watchdog_overflow_callback: 0
2026-01-12T04:24:39.355101+01:00 C2;__ktime_get_fast_ns_debug: 0.1
2026-01-12T04:24:39.355101+01:00 C2;tk_clock_read_debug: read=3Dread_hpet+=
0x0/0xf0
2026-01-12T04:24:39.355101+01:00 C2;read_hpet: 0
2026-01-12T04:24:39.355101+01:00 C2;read_hpet: 0.1
2026-01-12T04:24:39.355101+01:00 T0;exc_nmi: 0
2026-01-12T04:24:39.410207+01:00 C0;exc_nmi: 10.3
2026-01-12T04:24:39.410207+01:00 C0;default_do_nmi=20
2026-01-12T04:24:39.410207+01:00 C0;nmi_handle: type=3D0x0
2026-01-12T04:24:39.410207+01:00 C0;nmi_handle: a=3D0xffffffffa1612de0
2026-01-12T04:24:39.410207+01:00 C0;nmi_handle: a->handler=3Dperf_event_nm=
i_handler+0x0/0xa6
2026-01-12T04:24:39.410207+01:00 C0;perf_event_nmi_handler: 0
2026-01-12T04:24:39.410207+01:00 C0;perf_event_nmi_handler: 1
2026-01-12T04:24:39.410207+01:00 C0;perf_event_nmi_handler: 2
2026-01-12T04:24:39.410207+01:00 C0;x86_pmu_handle_irq: 2
2026-01-12T04:24:39.410207+01:00 C0;x86_pmu_handle_irq: 2.6
2026-01-12T04:24:39.410207+01:00 C0;__perf_event_overflow: 0
2026-01-12T04:24:39.410207+01:00 C0;__perf_event_overflow: 6.99: overflow_=
handler=3Dwatchdog_overflow_callback+0x0/0x10d
2026-01-12T04:24:39.410207+01:00 C0;watchdog_overflow_callback: 0
2026-01-12T04:24:39.410207+01:00 C0;__ktime_get_fast_ns_debug: 0.1
2026-01-12T04:24:39.410207+01:00 C0;tk_clock_read_debug: read=3Dread_hpet+=
0x0/0xf0
2026-01-12T04:24:39.410207+01:00 C0;read_hpet: 0
2026-01-12T04:24:39.410207+01:00 C0;read_hpet: 0.1
2026-01-12T04:24:39.410207+01:00 T0;exc_nmi: 0

In the case of the crash the interrupt handler never returns because when =
accessing
the HPET another NMI is triggered. This goes on until a crash happens, pro=
bably because
of stack overflow.

One can work around this bug by disabling CONFIG_HARDLOCKUP_DETECT in .con=
fig, but
I've only tested this twice so far.

The behaviour described here seems to be similar to the bug that commit
3d5f4f15b778 ("watchdog: skip checks when panic is in progress") is fixing=
, but
this is actually a different bug as kernel 6.18 (which contains 3d5f4f15b7=
78)
is also affected (I've conducted 5 tests with 6.18 so far and got 4 crashe=
s (crashes occured
after (0.5h, 1h, 4.5h, 1.5h) of testing)).=20
Nevertheless these look similar enough to CC the involved people.

Bert Karwatzki


