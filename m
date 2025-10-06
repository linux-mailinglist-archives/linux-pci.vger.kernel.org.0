Return-Path: <linux-pci+bounces-37611-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7BABBDFA7
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 14:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A43B4EC979
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 12:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0E227B327;
	Mon,  6 Oct 2025 12:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="pszRXVPs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EA627F003;
	Mon,  6 Oct 2025 12:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759752618; cv=none; b=O6UOygcpMoW+iVzlf5jzuuR0Qp91K/a5/IU0eBrMo/R1b/YUsXtLaascoYS9p91zZfXU13S9ecYQto5FYjCY0v2PymKHsmdH1MXQgaxkTLCDANU4u4z9DZfVUZHmJZkOgNr1Bc2ZiEfWPOtPfPYMSeILAfFTfxbPnyMZJIBH5BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759752618; c=relaxed/simple;
	bh=WxZw2Wt81/rgyyIZp4xdLCwIoRLC27gppGB6poDm/Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qtlUGKNTYF/U96in5X4IolMDr5KeSZG79jN8HXVFJziafPlYggrGWAC8q2Aq5U2qjKX/ePZHMO5Cgv8aZ5s/Sz9530dT43SNBMkoDXcJZ18XU3ZgHGJDhrvKqVUUk+l+lRA6PP60ldidenFeaDTXK93TIf9eMiSDoCnfFW5rrjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=pszRXVPs; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759752587; x=1760357387; i=spasswolf@web.de;
	bh=Q1BBf+jUHV2Ob/ge+t1cqvovwqe1LmGMCy17qJKTfjc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pszRXVPs5RTEC3sMGkuH/4kEGxo129jSBmAy7AMr8TJNJJhqgmnJqUV5/6RNFJo8
	 8z7Zeg3V6fHVgr+pD9VikcZUZ/kZ7xlA/5qgT6PkcdfoW1Ik0r4PtRet50NLLUhJK
	 Q+nMbxlIVJiZBkhXmbaAQ6x9PIR7pnScvoIoW/9ggNRLeBnbm6zMnKh/3ESiBGmsT
	 O7Z8/vKEmL6W5EhpsIahW1xDVNvyfL9m9gvXwB5LXeAizyaYOsgqnLhUuholviQwU
	 lnS8cEgBY9QR2et5CGOULyoLMPvUbo1DmspeW0tsauVNjsIyuNC27OJsMhEzly77T
	 653kf9kMyyjputOUMw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([95.223.134.88]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MgRMB-1udHF60J1L-00gbBh; Mon, 06 Oct 2025 14:09:47 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: linux-kernel@vger.kernel.org
Cc: Bert Karwatzki <spasswolf@web.de>,
	linux-next@vger.kernel.org,
	linux-stable@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Mario Limonciello <superm1@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [REGRESSION 00/04] Crash during resume of pcie bridge
Date: Mon,  6 Oct 2025 14:09:39 +0200
Message-ID: <20251006120944.7880-1-spasswolf@web.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P+vNO8gfXOXYI4FrJk74p2/M3/CJJn69GR45lWQEO7qRKyP2ZPV
 8R/aFJ8MFV6bLRq5v3xkda0e5bfwHdsdDdw/vQ6FKWahOdnl7JRxcEcpC2OpVUbWFPBTMSa
 513E0MooCpOsxjCdy8XPIBArnEhyZmxiPfBz9SQ/TsULhUVfaLv1qK38MTp1Sb9jlf3Ihdj
 faSSkrjBR+J32YUwWq7aQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5M5JPAuAcuY=;VadelFY27ZD/5G3rS8WgSPviAzU
 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
 opnqJoLG2rxv/M5hI=

Since linux version v6.15 I experience random crashes on my MSI Alpha 15 L=
aptop
running debian trixie (amd64). The first such crash happened about in the =
midth
of june, and as there were no useful log messages and even using netconsol=
e
gave no useful message I suspected faulty hardware. So I ran memtest86+ an=
d
found a faulty address line and replaced the memory (unfortunately 64G to =
16G).
But the crashes occured again and so I did a thorough investigation.

The crashes occur after 30min to 33h (yes, hours) of uptime and consist of=
 a
sudden reboot after which the PCI bridge at 00:02.4 and the nvme device=20
connected to it are missing. If there's sound running during the crash the=
n the
first sign of the crash is the sound looping like a broken record for abou=
t 2s,
after which the reboot happens. With the missing nvme device the reboot dr=
ops to
a rescue shell. Using "shutdown -h now" from that shell and starting the l=
aptop
with the power button restores the missing PCI bridge and nvme device.

The hardware is the following (it's a dual GPU laptop where the GUI
runs on the built-in GPU):

$ cat /proc/cpuinfo=20
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 25
model		: 80
model name	: AMD Ryzen 7 5800H with Radeon Graphics
stepping	: 0
microcode	: 0xa50000c
cpu MHz		: 3394.238
cache size	: 512 KB
physical id	: 0
siblings	: 16
core id		: 0
cpu cores	: 8
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 16
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat=
 pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdt=
scp lm constant_tsc rep_good nopl xtopology nonstop_tsc cpuid extd_apicid =
aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 x2apic =
movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_=
legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext=
 perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pst=
ate ssbd mba ibrs ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 erms inv=
pcid cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xget=
bv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf=
 xsaveerptr rdpru wbnoinvd cppc arat npt lbrv svm_lock nrip_save tsc_scale=
 vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsav=
e_vmload vgif v_spec_ctrl umip pku ospke vaes vpclmulqdq rdpid overflow_re=
cov succor smca fsrm debug_swap
bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass srso ibpb_=
no_ret
bogomips	: 6388.57
TLB size	: 2560 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 48 bits physical, 48 bits virtual
power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]

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

These devices are attached to the PCI bus like this:

$ lspci -t
-[0000:00]-+-00.0
           +-00.2
           +-01.0
           +-01.1-[01-03]----00.0-[02-03]----00.0-[03]--+-00.0 // This is =
the bridge which causes the crash
           |                                            \-00.1
           +-02.0
           +-02.1-[04]----00.0
           +-02.2-[05]----00.0
           +-02.3-[06]----00.0
           +-02.4-[07]----00.0 // These are the bridge and nvme device whi=
ch disappear after the crash.
           +-08.0
           +-08.1-[08]--+-00.0
           |            +-00.1
           |            +-00.2
           |            +-00.3
           |            +-00.4
           |            +-00.5
           |            +-00.6
           |            \-00.7
           +-14.0
           +-14.3
           +-18.0
           +-18.1
           +-18.2
           +-18.3
           +-18.4
           +-18.5
           +-18.6
           \-18.7

I tried to bisect this between v6.14 and v6.15 but due to the wildly varyi=
ng time
it takes to trigger the bug the bisections were not successful. Neverthele=
ss they
gave lots of data about affected and non-affected version of the linux ker=
nel,
and it's quite likely that version v6.14 is indeed free of the bug.

Here's an almost complete list of tested versions:
(Somewhat) sorted (by kernel version, 6.14.0-rc* kernels are from attempte=
d bisections
between v6.14 and v6.15)
v6.14.0							no crash after 16h
v6.14.11						no crash after 7.5h
6.14.0-rc1-bisect-00003-g541ddf31e300			booted 12:24, 22.8.2025, no crash =
after {48h, 17h}
6.14.0-rc1-mystery-00134-gcc28c0e5e725			booted 11:42, 5.8.2025, no crash =
after 10.5h
6.14.0-rc1-mystery-00198-gd7f6f07ecec9			booted 22:27, 5.8.2025, no crash =
after 12h
6.14.0-rc4-mystery-01022-gab498828fad7			booted 21:04, 3.8.2025, no crash =
after {14h, 24h}=20
6.14.0-rc4-mystery-01427-g7547510d4a91			booted 11:11, 4.8.2025, no crash =
after {13h, 23h}
6.14.0-rc6-mystery-01641-g0f04462874e1			booted 00:26, 5.8.2025, no crash =
after {11h, 24h}
6.14.0-mystery-00826-g327ecdbc0fda			no crash after {16h, 17h, 6.5h}
############## here the crashes start (time to each crash, crashes do not =
always occur) ########
6.14.0-bisect-01053-gebfb94d87b35			booted 10:15, 20.8.2025 crash after ~3=
3h
6.14.0-mystery-09584-g7d06015d936c			crash 20.44 3.8.2025 after 7h
6.14.0-mystery-11703-geb0ece16027f      		crash 13.22 3.8.2025 after 1.75h
6.15.0							crashed around 15-17.6.2025, unknown uptime (This is the firs=
t crash!)
6.15.0-nort  						crash after 6.75h
6.16-rc4 (next-20250627)				crash after ~4h
6.16-rc4 (next-20250630)				crash after ~5h
6.16-rc4 (next-20250703) 				crash after ~2.5h (sound buffer repeated for =
~1s before restarting) =09
6.16-rc6 (next-20250718)				crash after {2h, 2h}
6.16-rc7 (next-20250721)				crash after {~30min, 2h, 5.5h}
6.16.0-nortlockdep					crash after 4h
6.17.0-rc4-next-20250902-master				booted 8:36, 3.9.2025, crash after ~3.5=
h
6.17.0-rc5-next-20250908-master				booted 10:25, 9.9.2025, crash after {~6=
.5h, 14h}
6.17.0-rc6-next-20250917-acpidebug 			booted 12:41, 20.9.2025, crash 15:22=
 20.8.2025 (~3h, 647 GPP notifies)
The versions below contain additional debugging printk()s and dev_info()s.
The details of these debugging statements are explained below.
6.17.0-rc6-next-20250917-gpudebug-00018-g7a38b625a003	booted 12:58, 26.9.2=
025, crash 12:01, 27.9.2025 (~23h, 1500 GPP notifies)
6.17.0-rc6-next-20250917-gpudebug-00021-gab98d880e3c8	booted 23:52, 28.9.2=
025, crash 2:25, 30.9.2025 (26.5h, 1504GPP0, 889GPP2)
6.17.0-rc6-next-20250917-gpudebug-00024-g5c6b49b810db	booted 9:10, 2.10.20=
25, 60h 3093 GPP0 notifies without crash (too many printk()s?)
6.17.0-rc6-next-20250917-gpudebug-00028-gf99cf81b1da7	booted 21:21, 4.10.2=
025 first try stopped after 77min due to hung tasks
6.17.0-rc6-next-20250917-gpudebug-00028-gf99cf81b1da7	booted 23:37, 4.10.2=
025 crash 4:52, 6.10.2025 (~27.5h)
6.17.0-rc6-next-20250917-gpudebug-00029-ge797f42363d1	booted 13:00, 6.10.2=
025 currently testing

As the bisections were not succesfull I tried to monitor the crash using
netconsole and CONFIG_ACPI_DEBUG and "acpi.debug_layer=3D0xf acpi.debug_le=
vel=3D0x107"
as command line parameters. With this the last message on netconsole befor=
e
the crash is usually:

[21465.639279] [    T251]    evmisc-0132 ev_queue_notify_reques: Dispatchi=
ng Notify on [GPP0] (Device) Value 0x00 (Bus Check) Node 00000000f81f36b8

GPP0 is the ACPI name of this PCI bridge (at least that's my best guess):

00:01.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Renoir PCIe =
GPP Bridge [1022:1633]

to which the discrete GPU is connected

03:00.0 Display controller [0380]: Advanced Micro Devices, Inc. [AMD/ATI] =
Navi 23 [Radeon RX 6600/6600 XT/6600M] [1002:73ff] (rev c3)

via the pci express switch

01:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 =
XL Upstream Port of PCI Express Switch [1002:1478] (rev c3)
02:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 =
XL Downstream Port of PCI Express Switch [1002:1479]

While the GUI (xfce on xorg) on my laptop runs on the built-in GPU the dis=
crete=20
GPU usually wakes up quite often, e.g. when a window is opened or when scr=
olling down on youtube.

A somewhat reliable method to generate GPP0 notifies is putting on a youtu=
be
video and the periodically starting evolution with this script:

#!/bin/bash
for i in {0..1000}
do
	echo $i
	evolution &
	sleep 5
	killall evolution
	sleep 55
done

This is also the method I used to test the debug kernel in the following m=
ails.

Bert Karwatzki

