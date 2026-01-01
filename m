Return-Path: <linux-pci+bounces-43890-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D20CCECF40
	for <lists+linux-pci@lfdr.de>; Thu, 01 Jan 2026 11:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 623B33007259
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jan 2026 10:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3B727FD59;
	Thu,  1 Jan 2026 10:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tutamail.com header.i=@tutamail.com header.b="kx/eY+lW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.w13.tutanota.de (mail.w13.tutanota.de [185.205.69.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBCB244694
	for <linux-pci@vger.kernel.org>; Thu,  1 Jan 2026 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.205.69.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767263912; cv=none; b=TLXRKX11g4rW8E0QLfsu3BHpxKusS75kVE8AGZjIOMzbsadLKO3vbY4rACiNxKFOSrePrampDpFIJ38EF1zF62h6ORGA1I910PgjIhPbD03ZNXnEzaQuS4rtZATxgd30g6jtqWV/VcZBtBgEw6Ej+STn7gtV3SQX+989XrauIoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767263912; c=relaxed/simple;
	bh=W1W6kq471BbvGky5kFLupvL8P5T4FgkLWq/8leygWD0=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=NH8Gk5N1KjxEs9dQfzTwA/kMPrRdZ/TuzPCuZQfMjF1h+kvQxHe7ObP1dM7URiTpNKCCCbcrHAPnyfj4ADlE9wZQUYaotsvNtbiD2L5Sj0acrIpaglKVci78dmBS2q5Jh6IlJOxQAbRET1dFFCVxXPhtlfoT5ULDbZ/RkL8WiiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tutamail.com; spf=pass smtp.mailfrom=tutamail.com; dkim=pass (2048-bit key) header.d=tutamail.com header.i=@tutamail.com header.b=kx/eY+lW; arc=none smtp.client-ip=185.205.69.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tutamail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tutamail.com
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w13.tutanota.de (Postfix) with ESMTP id 253B5F76F588
	for <linux-pci@vger.kernel.org>; Thu,  1 Jan 2026 11:38:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767263897;
	s=s1; d=tutamail.com;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
	bh=uqlrxi6LQdn3wqC7xmAb92l4Z1dd4N/BCtPJRHPoM+I=;
	b=kx/eY+lWuNWS1dImVFwfiu8qKOobpiykokgGgvx5l0dEyJh2KzNhlL9IQGHn1hqY
	Ucgb7ZQ9AeBlIygGgwH3IRqnlkQ7LUxiYsLTHYQ3Z7UObWOwZ7oWQr8lEuKJ0zjDg3G
	WyCGNcJPNNL8VGxL/Xzf2DP/hEIDL99nBy5ymmWj6w2rGDZ3ni/LHjcdiDsGCEZdsbS
	0XyW7lw/ZKyeKgJ+GYdtauVEr68mTO8CRrfIT9urnuujbN3LJg+6CnEcuNyxq4ELV6c
	/JoPGif5n69A9zKggjCYTAPlO8kpTvfxsDe/mUiWFYU0vSKkD5co8FbXcIYnaox80Dz
	oJj4pCfo2A==
Date: Thu, 1 Jan 2026 11:38:17 +0100 (CET)
From: incredibletails@tutamail.com
To: Linux Usb <linux-usb@vger.kernel.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux Pci <linux-pci@vger.kernel.org>
Message-ID: <OhsTeeC--F-9@tutamail.com>
Subject: [BUG] USB-C DisplayPort Alt-Mode not detected on MSI Cyborg 15
 A12VE (Alder Lake + RTX 4050)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_846594_1174211588.1767263898144"
Feedback-ID: 01d4be02283f4a765bd9871db3aff90c0cc904cd28a0eecc43d93be3d806a07124a8df207de74c03d250d1261b0820ae84a57ff5ac37661223a74c9029c9854ab1:TurnOnPrivacy!:tutamail

------=_Part_846594_1174211588.1767263898144
Content-Type: multipart/alternative; 
	boundary="----=_Part_846595_542540372.1767263898144"

------=_Part_846595_542540372.1767263898144
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

=C2=A0Hi, I am having an issue with using DP over my USB-C port and hoping =
this report can help solve this gap in support. I believe this is my first =
bug report, although I do look foward to someday being on the maintainer si=
de of things when I can dedicate more time to this and have more overall ex=
perience beyond novice. I currently use linux as my daily driver for work/h=
obbies and can navigate the terminal good enough to be of assistance.

=C2=A0I use chatGPT frequently when I just need something to work on my pri=
mary system to help speed up the process, I apologize if this is considered=
 bad form. Below is mostly copy/pasted information from one of my chats, bu=
t should have most of the base information. I have reviewed it to verify it=
 is accurate.=C2=A0 Also, I have attached to this email 5 .txt output files=
 that should be relevant.

=C2=A0Please advise with any additional information I can provide. Thank yo=
u=C2=A0


Summary
USB-C DisplayPort Alt-Mode does not work on MSI Cyborg 15 A12VE under Linux=
.
The USB-C port functions as USB only; DP Alt-Mode is never negotiated.
No Type-C ports appear in=C2=A0/sys/class/typec, and no DP connector ever r=
eports=C2=A0connected.

OS: Garuda Linux "Broadwing" (250308)



Hardware

Laptop:=C2=A0MSI Cyborg 15 A12VE


CPU:=C2=A0Intel Alder Lake-P


iGPU:=C2=A0Intel UHD Graphics


dGPU:=C2=A0NVIDIA RTX 4050 Mobile (AD107M)


USB-C Port:=C2=A0USB 3.2 Gen1 with DP Alt-Mode (per MSI specs, non-Thunderb=
olt)



Kernel versions tested

6.17.8-zen1-1-zen=C2=A0[this was my default, I updated to 6.18.2-zen2-1-zen=
 and repeated the process of troubleshooting before switching to vanilla ar=
ch kernel for final attempts]


6.18.2-arch2-1=C2=A0(vanilla Arch kernel) [this was my 2nd attempt]


Same behavior on both.



Expected behavior

USB-C DP Alt-Mode should negotiate when a DP-capable monitor is connected


A Type-C port (e.g.=C2=A0/sys/class/typec/port0) should appear


A DP connector (e.g.=C2=A0card1-DP-1) should switch to=C2=A0connected



Actual behavior

/sys/class/typec=C2=A0does not exist by default


After=C2=A0modprobe typec,=C2=A0/sys/class/typec=C2=A0appears but is=C2=A0e=
mpty=C2=A0(no ports)


Plugging in a USB-C DP monitor does=C2=A0not=C2=A0create a partner or altmo=
de


/sys/class/drm/card1-DP-1/status=C2=A0always remains=C2=A0disconnected


Only a generic USB device is detected from the monitor: ... usb 1-5: New US=
B device found, idVendor=3D0bda, idProduct=3D5411




Relevant command output

Kernel

uname -r6.18.2-arch2-1

GPUs

# lspci | grep -E=C2=A0"VGA|3D"
=C2=A0"VGA compatible controller: Intel Corporation Alder Lake-P GT1 [UHD G=
raphics] (rev 0c) VGA compatible controller: NVIDIA Corporation AD107M [GeF=
orce RTX 4050 Mobile] (rev a1)"

Type-C sysfs

# ls /sys/class/typec  dir empty (directory only appears after modprobe)

DRM connector status

/sys/class/drm/card1-DP-1/status -> disconnected/sys/class/drm/card2-eDP-1/=
status -> connected/sys/class/drm/card2-HDMI-A-1/status -> disconnected

Type-C kernel config (enabled)

CONFIG_TYPEC=3DmCONFIG_TYPEC_DP_ALTMODE=3DmCONFIG_TYPEC_UCSI=3DmCONFIG_UCSI=
_ACPI=3DmCONFIG_TYPEC_TBT_ALTMODE=3Dm

Kernel log when plugging in monitor

usb 1-5: New USB device found, idVendor=3D0bda, idProduct=3D5411

No=C2=A0ucsi,=C2=A0typec,=C2=A0altmode, or=C2=A0dp=C2=A0messages appear.



Notes

NVIDIA DRM modesetting is enabled (nvidia-drm.modeset=3D1)


HDMI output works normally


Behavior is identical across kernels and display servers


Appears that the USB-C / UCSI controller is not being bound by any driver

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0
Regression?

Unknown. System is new; USB-C DP Alt-Mode has never worked under Linux on t=
his device.

---------

Misc. commands and print outs:
# xrandr --listmonitors
=C2=A0"0: +*eDP-1 1920/344x1080/193+0+0  eDP-1"

# xrandr --listproviders
=C2=A0"Providers: number : 0"

# zcat /proc/config.gz 2>/dev/null | grep CONFIG_TYPEC
=C2=A0"CONFIG_TYPEC=3DmCONFIG_TYPEC_TCPM=3DmCONFIG_TYPEC_TCPCI=3DmCONFIG_TY=
PEC_RT1711H=3DmCONFIG_TYPEC_MT6360=3DmCONFIG_TYPEC_TCPCI_MT6370=3DmCONFIG_T=
YPEC_TCPCI_MAXIM=3DmCONFIG_TYPEC_FUSB302=3DmCONFIG_TYPEC_WCOVE=3DmCONFIG_TY=
PEC_UCSI=3DmCONFIG_TYPEC_TPS6598X=3DmCONFIG_TYPEC_ANX7411=3DmCONFIG_TYPEC_R=
T1719=3DmCONFIG_TYPEC_HD3SS3220=3DmCONFIG_TYPEC_STUSB160X=3DmCONFIG_TYPEC_W=
USB3801=3DmCONFIG_TYPEC_MUX_FSA4480=3DmCONFIG_TYPEC_MUX_GPIO_SBU=3DmCONFIG_=
TYPEC_MUX_PI3USB30532=3DmCONFIG_TYPEC_MUX_INTEL_PMC=3DmCONFIG_TYPEC_MUX_IT5=
205=3DmCONFIG_TYPEC_MUX_NB7VPQ904M=3DmCONFIG_TYPEC_MUX_PS883X=3DmCONFIG_TYP=
EC_MUX_PTN36502=3DmCONFIG_TYPEC_MUX_TUSB1046=3DmCONFIG_TYPEC_MUX_WCD939X_US=
BSS=3DmCONFIG_TYPEC_DP_ALTMODE=3DmCONFIG_TYPEC_NVIDIA_ALTMODE=3DmCONFIG_TYP=
EC_TBT_ALTMODE=3Dm"

# zcat /proc/config.gz 2>/dev/null | grep UCSI
=C2=A0"CONFIG_I2C_CCGX_UCSI=3Dy CONFIG_TYPEC_UCSI=3DmCONFIG_UCSI_CCG=3DmCON=
FIG_UCSI_ACPI=3DmCONFIG_UCSI_STM32G0=3DmCONFIG_CROS_EC_UCSI=3Dm"

#=C2=A0lsmod | grep -E "typec|usb|thunder"
=C2=A0"typec_ucsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 77824=C2=A0 2 ucsi_ccg,ucsi_acpi
roles=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16384=C2=A0 1 typec_ucsi
typec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 114688=C2=A0 1 typec_ucsi
thunderbolt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 577=
536=C2=A0 1 typec
btusb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 81920=C2=A0 0
btmtk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32768=C2=A0 1 btusb
btrtl=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32768=C2=A0 1 btusb
btbcm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 24576=C2=A0 1 btusb
btintel=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 73728=C2=A0 1 btusb
bluetooth=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 1118208=C2=A0 34 btrtl,btmtk,btintel,btbcm,bnep,btusb,rfcomm"

# modprobe typec typec_ucsi ucsi_acpi ucsi_ccg
=C2=A0No error returned, but 'modprobe typec' seems to create both director=
ies /sys/class/typec/ & /sys/class/typec_mux/
... Both directories remain empty




--
Secured with Tuta Mail:
https://tuta.com/free-email

------=_Part_846595_542540372.1767263898144
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DUTF-8=
">
  </head>
  <body>
<div dir=3D"auto">&nbsp;Hi, I am having an issue with using DP over my USB-=
C port and hoping this report can help solve this gap in support. I believe=
 this is my first bug report, although I do look foward to someday being on=
 the maintainer side of things when I can dedicate more time to this and ha=
ve more overall experience beyond novice. I currently use linux as my daily=
 driver for work/hobbies and can navigate the terminal good enough to be of=
 assistance.<br></div><div dir=3D"auto"><br></div><div dir=3D"auto">&nbsp;I=
 use chatGPT frequently when I just need something to work on my primary sy=
stem to help speed up the process, I apologize if this is considered bad fo=
rm. Below is mostly copy/pasted information from one of my chats, but shoul=
d have most of the base information. I have reviewed it to verify it is acc=
urate.&nbsp; Also, I have attached to this email 5 .txt output files that s=
hould be relevant.<br></div><div dir=3D"auto"><br></div><div dir=3D"auto">&=
nbsp;Please advise with any additional information I can provide. Thank you=
&nbsp;<br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><h3=
 data-start=3D"1195" data-end=3D"1210" style=3D"scrollbar-color: rgb(208, 1=
96, 196) transparent; scrollbar-width: thin; box-sizing: border-box; margin=
: 0px; font-weight: normal; font-size: 25.6px; user-select: text !important=
; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;">=
<b data-start=3D"1199" data-end=3D"1210" style=3D"scrollbar-color: rgb(208,=
 196, 196) transparent; scrollbar-width: thin; user-select: text !important=
; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;">=
Summary</b><br></h3><div dir=3D"auto" style=3D"scrollbar-color: rgb(208, 19=
6, 196) transparent; scrollbar-width: thin; box-sizing: border-box; user-se=
lect: text !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webk=
it-user-drag: none;">USB-C DisplayPort Alt-Mode does not work on MSI Cyborg=
 15 A12VE under Linux.<br></div><div dir=3D"auto" style=3D"scrollbar-color:=
 rgb(208, 196, 196) transparent; scrollbar-width: thin; box-sizing: border-=
box; user-select: text !important; -webkit-tap-highlight-color: rgba(0, 0, =
0, 0); -webkit-user-drag: none;">The USB-C port functions as USB only; DP A=
lt-Mode is never negotiated.<br></div><div dir=3D"auto" style=3D"scrollbar-=
color: rgb(208, 196, 196) transparent; scrollbar-width: thin; box-sizing: b=
order-box; user-select: text !important; -webkit-tap-highlight-color: rgba(=
0, 0, 0, 0); -webkit-user-drag: none;">No Type-C ports appear in<span>&nbsp=
;</span><code data-start=3D"1389" data-end=3D"1407" style=3D"scrollbar-colo=
r: rgb(208, 196, 196) transparent; scrollbar-width: thin; box-sizing: borde=
r-box; user-select: text !important; -webkit-tap-highlight-color: rgba(0, 0=
, 0, 0); -webkit-user-drag: none;">/sys/class/typec</code>, and no DP conne=
ctor ever reports<span>&nbsp;</span><code data-start=3D"1442" data-end=3D"1=
453" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-wi=
dth: thin; box-sizing: border-box; user-select: text !important; -webkit-ta=
p-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;">connected</c=
ode>.<br></div><p style=3D"scrollbar-color: rgb(208, 196, 196) transparent;=
 scrollbar-width: thin; box-sizing: border-box; user-select: text !importan=
t; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"=
><b>OS: Garuda Linux "Broadwing" (250308)</b><br></p><div dir=3D"auto" styl=
e=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-width: thin=
; box-sizing: border-box; user-select: text !important; -webkit-tap-highlig=
ht-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><hr data-start=3D"145=
6" data-end=3D"1459" style=3D"scrollbar-color: rgb(208, 196, 196) transpare=
nt; scrollbar-width: thin; user-select: text !important; -webkit-tap-highli=
ght-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><br></div><h3 data-s=
tart=3D"1461" data-end=3D"1477" style=3D"scrollbar-color: rgb(208, 196, 196=
) transparent; scrollbar-width: thin; box-sizing: border-box; margin: 0px; =
font-weight: normal; font-size: 25.6px; user-select: text !important; -webk=
it-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><b data=
-start=3D"1465" data-end=3D"1477" style=3D"scrollbar-color: rgb(208, 196, 1=
96) transparent; scrollbar-width: thin; user-select: text !important; -webk=
it-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;">Hardwar=
e</b><br></h3><ul data-start=3D"1478" data-end=3D"1705" style=3D"scrollbar-=
color: rgb(208, 196, 196) transparent; scrollbar-width: thin; box-sizing: b=
order-box; user-select: text !important; -webkit-tap-highlight-color: rgba(=
0, 0, 0, 0); -webkit-user-drag: none;"><li data-start=3D"1478" data-end=3D"=
1513" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-w=
idth: thin; box-sizing: border-box; user-select: text !important; -webkit-t=
ap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><p data-sta=
rt=3D"1480" data-end=3D"1513" style=3D"scrollbar-color: rgb(208, 196, 196) =
transparent; scrollbar-width: thin; box-sizing: border-box; user-select: te=
xt !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-=
drag: none;"><b data-start=3D"1480" data-end=3D"1491" style=3D"scrollbar-co=
lor: rgb(208, 196, 196) transparent; scrollbar-width: thin; user-select: te=
xt !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-=
drag: none;">Laptop:</b><span>&nbsp;</span>MSI Cyborg 15 A12VE<br></p></li>=
<li data-start=3D"1514" data-end=3D"1545" style=3D"scrollbar-color: rgb(208=
, 196, 196) transparent; scrollbar-width: thin; box-sizing: border-box; use=
r-select: text !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -=
webkit-user-drag: none;"><p data-start=3D"1516" data-end=3D"1545" style=3D"=
scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-width: thin; box=
-sizing: border-box; user-select: text !important; -webkit-tap-highlight-co=
lor: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><b data-start=3D"1516" dat=
a-end=3D"1524" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; sc=
rollbar-width: thin; user-select: text !important; -webkit-tap-highlight-co=
lor: rgba(0, 0, 0, 0); -webkit-user-drag: none;">CPU:</b><span>&nbsp;</span=
>Intel Alder Lake-P<br></p></li><li data-start=3D"1546" data-end=3D"1578" s=
tyle=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-width: t=
hin; box-sizing: border-box; user-select: text !important; -webkit-tap-high=
light-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><p data-start=3D"1=
548" data-end=3D"1578" style=3D"scrollbar-color: rgb(208, 196, 196) transpa=
rent; scrollbar-width: thin; box-sizing: border-box; user-select: text !imp=
ortant; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: n=
one;"><b data-start=3D"1548" data-end=3D"1557" style=3D"scrollbar-color: rg=
b(208, 196, 196) transparent; scrollbar-width: thin; user-select: text !imp=
ortant; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: n=
one;">iGPU:</b><span>&nbsp;</span>Intel UHD Graphics<br></p></li><li data-s=
tart=3D"1579" data-end=3D"1624" style=3D"scrollbar-color: rgb(208, 196, 196=
) transparent; scrollbar-width: thin; box-sizing: border-box; user-select: =
text !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-use=
r-drag: none;"><p data-start=3D"1581" data-end=3D"1624" style=3D"scrollbar-=
color: rgb(208, 196, 196) transparent; scrollbar-width: thin; box-sizing: b=
order-box; user-select: text !important; -webkit-tap-highlight-color: rgba(=
0, 0, 0, 0); -webkit-user-drag: none;"><b data-start=3D"1581" data-end=3D"1=
590" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-wi=
dth: thin; user-select: text !important; -webkit-tap-highlight-color: rgba(=
0, 0, 0, 0); -webkit-user-drag: none;">dGPU:</b><span>&nbsp;</span>NVIDIA R=
TX 4050 Mobile (AD107M)<br></p></li><li data-start=3D"1625" data-end=3D"170=
5" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-widt=
h: thin; box-sizing: border-box; user-select: text !important; -webkit-tap-=
highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><p data-start=
=3D"1627" data-end=3D"1705" style=3D"scrollbar-color: rgb(208, 196, 196) tr=
ansparent; scrollbar-width: thin; box-sizing: border-box; user-select: text=
 !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-dr=
ag: none;"><b data-start=3D"1627" data-end=3D"1642" style=3D"scrollbar-colo=
r: rgb(208, 196, 196) transparent; scrollbar-width: thin; user-select: text=
 !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-dr=
ag: none;">USB-C Port:</b><span>&nbsp;</span>USB 3.2 Gen1 with DP Alt-Mode =
(per MSI specs, non-Thunderbolt)<br></p></li></ul><div dir=3D"auto" style=
=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-width: thin;=
 box-sizing: border-box; user-select: text !important; -webkit-tap-highligh=
t-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><hr data-start=3D"1707=
" data-end=3D"1710" style=3D"scrollbar-color: rgb(208, 196, 196) transparen=
t; scrollbar-width: thin; user-select: text !important; -webkit-tap-highlig=
ht-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><br></div><h3 data-st=
art=3D"1712" data-end=3D"1742" style=3D"scrollbar-color: rgb(208, 196, 196)=
 transparent; scrollbar-width: thin; box-sizing: border-box; margin: 0px; f=
ont-weight: normal; font-size: 25.6px; user-select: text !important; -webki=
t-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><b data-=
start=3D"1716" data-end=3D"1742" style=3D"scrollbar-color: rgb(208, 196, 19=
6) transparent; scrollbar-width: thin; user-select: text !important; -webki=
t-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;">Kernel v=
ersions tested</b><br></h3><ul data-start=3D"1743" data-end=3D"1805" style=
=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-width: thin;=
 box-sizing: border-box; user-select: text !important; -webkit-tap-highligh=
t-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><li data-start=3D"1743=
" data-end=3D"1764" style=3D"scrollbar-color: rgb(208, 196, 196) transparen=
t; scrollbar-width: thin; box-sizing: border-box; user-select: text !import=
ant; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none=
;"><p data-start=3D"1745" data-end=3D"1764" style=3D"scrollbar-color: rgb(2=
08, 196, 196) transparent; scrollbar-width: thin; box-sizing: border-box; u=
ser-select: text !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);=
 -webkit-user-drag: none;"><code data-start=3D"1745" data-end=3D"1764" styl=
e=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-width: thin=
; box-sizing: border-box; user-select: text !important; -webkit-tap-highlig=
ht-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;">6.17.8-zen1-1-zen&nbs=
p;</code>[this was my default, I updated to 6.18.2-zen2-1-zen and repeated =
the process of troubleshooting before switching to vanilla arch kernel for =
final attempts]<br></p></li><li data-start=3D"1765" data-end=3D"1805" style=
=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-width: thin;=
 box-sizing: border-box; user-select: text !important; -webkit-tap-highligh=
t-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><p data-start=3D"1767"=
 data-end=3D"1805" style=3D"scrollbar-color: rgb(208, 196, 196) transparent=
; scrollbar-width: thin; box-sizing: border-box; user-select: text !importa=
nt; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;=
"><code data-start=3D"1767" data-end=3D"1783" style=3D"scrollbar-color: rgb=
(208, 196, 196) transparent; scrollbar-width: thin; box-sizing: border-box;=
 user-select: text !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0=
); -webkit-user-drag: none;">6.18.2-arch2-1</code><span>&nbsp;</span>(vanil=
la Arch kernel) [this was my 2nd attempt]<br></p></li></ul><p data-start=3D=
"1807" data-end=3D"1829" style=3D"scrollbar-color: rgb(208, 196, 196) trans=
parent; scrollbar-width: thin; box-sizing: border-box; user-select: text !i=
mportant; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag:=
 none;">Same behavior on both.<br></p><div dir=3D"auto" style=3D"scrollbar-=
color: rgb(208, 196, 196) transparent; scrollbar-width: thin; box-sizing: b=
order-box; user-select: text !important; -webkit-tap-highlight-color: rgba(=
0, 0, 0, 0); -webkit-user-drag: none;"><hr data-start=3D"1831" data-end=3D"=
1834" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-w=
idth: thin; user-select: text !important; -webkit-tap-highlight-color: rgba=
(0, 0, 0, 0); -webkit-user-drag: none;"><br></div><h3 data-start=3D"1836" d=
ata-end=3D"1861" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; =
scrollbar-width: thin; box-sizing: border-box; margin: 0px; font-weight: no=
rmal; font-size: 25.6px; user-select: text !important; -webkit-tap-highligh=
t-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><b data-start=3D"1840"=
 data-end=3D"1861" style=3D"scrollbar-color: rgb(208, 196, 196) transparent=
; scrollbar-width: thin; user-select: text !important; -webkit-tap-highligh=
t-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;">Expected behavior</b><=
br></h3><ul data-start=3D"1862" data-end=3D"2065" style=3D"scrollbar-color:=
 rgb(208, 196, 196) transparent; scrollbar-width: thin; box-sizing: border-=
box; user-select: text !important; -webkit-tap-highlight-color: rgba(0, 0, =
0, 0); -webkit-user-drag: none;"><li data-start=3D"1862" data-end=3D"1937" =
style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-width: =
thin; box-sizing: border-box; user-select: text !important; -webkit-tap-hig=
hlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><p data-start=3D"=
1864" data-end=3D"1937" style=3D"scrollbar-color: rgb(208, 196, 196) transp=
arent; scrollbar-width: thin; box-sizing: border-box; user-select: text !im=
portant; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: =
none;">USB-C DP Alt-Mode should negotiate when a DP-capable monitor is conn=
ected<br></p></li><li data-start=3D"1938" data-end=3D"1999" style=3D"scroll=
bar-color: rgb(208, 196, 196) transparent; scrollbar-width: thin; box-sizin=
g: border-box; user-select: text !important; -webkit-tap-highlight-color: r=
gba(0, 0, 0, 0); -webkit-user-drag: none;"><p data-start=3D"1940" data-end=
=3D"1999" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollb=
ar-width: thin; box-sizing: border-box; user-select: text !important; -webk=
it-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;">A Type-=
C port (e.g.<span>&nbsp;</span><code data-start=3D"1960" data-end=3D"1984" =
style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-width: =
thin; box-sizing: border-box; user-select: text !important; -webkit-tap-hig=
hlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;">/sys/class/typec/=
port0</code>) should appear<br></p></li><li data-start=3D"2000" data-end=3D=
"2065" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-=
width: thin; box-sizing: border-box; user-select: text !important; -webkit-=
tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><p data-st=
art=3D"2002" data-end=3D"2065" style=3D"scrollbar-color: rgb(208, 196, 196)=
 transparent; scrollbar-width: thin; box-sizing: border-box; user-select: t=
ext !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user=
-drag: none;">A DP connector (e.g.<span>&nbsp;</span><code data-start=3D"20=
23" data-end=3D"2035" style=3D"scrollbar-color: rgb(208, 196, 196) transpar=
ent; scrollbar-width: thin; box-sizing: border-box; user-select: text !impo=
rtant; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: no=
ne;">card1-DP-1</code>) should switch to<span>&nbsp;</span><code data-start=
=3D"2054" data-end=3D"2065" style=3D"scrollbar-color: rgb(208, 196, 196) tr=
ansparent; scrollbar-width: thin; box-sizing: border-box; user-select: text=
 !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-dr=
ag: none;">connected</code><br></p></li></ul><div dir=3D"auto" style=3D"scr=
ollbar-color: rgb(208, 196, 196) transparent; scrollbar-width: thin; box-si=
zing: border-box; user-select: text !important; -webkit-tap-highlight-color=
: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><hr data-start=3D"2067" data-=
end=3D"2070" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scro=
llbar-width: thin; user-select: text !important; -webkit-tap-highlight-colo=
r: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><br></div><h3 data-start=3D"=
2072" data-end=3D"2095" style=3D"scrollbar-color: rgb(208, 196, 196) transp=
arent; scrollbar-width: thin; box-sizing: border-box; margin: 0px; font-wei=
ght: normal; font-size: 25.6px; user-select: text !important; -webkit-tap-h=
ighlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><b data-start=
=3D"2076" data-end=3D"2095" style=3D"scrollbar-color: rgb(208, 196, 196) tr=
ansparent; scrollbar-width: thin; user-select: text !important; -webkit-tap=
-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;">Actual behavi=
or</b><br></h3><ul data-start=3D"2096" data-end=3D"2497" style=3D"scrollbar=
-color: rgb(208, 196, 196) transparent; scrollbar-width: thin; box-sizing: =
border-box; user-select: text !important; -webkit-tap-highlight-color: rgba=
(0, 0, 0, 0); -webkit-user-drag: none;"><li data-start=3D"2096" data-end=3D=
"2142" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-=
width: thin; box-sizing: border-box; user-select: text !important; -webkit-=
tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><p data-st=
art=3D"2098" data-end=3D"2142" style=3D"scrollbar-color: rgb(208, 196, 196)=
 transparent; scrollbar-width: thin; box-sizing: border-box; user-select: t=
ext !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user=
-drag: none;"><code data-start=3D"2098" data-end=3D"2116" style=3D"scrollba=
r-color: rgb(208, 196, 196) transparent; scrollbar-width: thin; box-sizing:=
 border-box; user-select: text !important; -webkit-tap-highlight-color: rgb=
a(0, 0, 0, 0); -webkit-user-drag: none;">/sys/class/typec</code><span>&nbsp=
;</span>does not exist by default<br></p></li><li data-start=3D"2143" data-=
end=3D"2223" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scro=
llbar-width: thin; box-sizing: border-box; user-select: text !important; -w=
ebkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><p d=
ata-start=3D"2145" data-end=3D"2223" style=3D"scrollbar-color: rgb(208, 196=
, 196) transparent; scrollbar-width: thin; box-sizing: border-box; user-sel=
ect: text !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webki=
t-user-drag: none;">After<span>&nbsp;</span><code data-start=3D"2151" data-=
end=3D"2167" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scro=
llbar-width: thin; box-sizing: border-box; user-select: text !important; -w=
ebkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;">modp=
robe typec</code>,<span>&nbsp;</span><code data-start=3D"2169" data-end=3D"=
2187" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-w=
idth: thin; box-sizing: border-box; user-select: text !important; -webkit-t=
ap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;">/sys/class/=
typec</code><span>&nbsp;</span>appears but is<span>&nbsp;</span><b data-sta=
rt=3D"2203" data-end=3D"2212" style=3D"scrollbar-color: rgb(208, 196, 196) =
transparent; scrollbar-width: thin; user-select: text !important; -webkit-t=
ap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;">empty</b><s=
pan>&nbsp;</span>(no ports)<br></p></li><li data-start=3D"2224" data-end=3D=
"2297" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-=
width: thin; box-sizing: border-box; user-select: text !important; -webkit-=
tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><p data-st=
art=3D"2226" data-end=3D"2297" style=3D"scrollbar-color: rgb(208, 196, 196)=
 transparent; scrollbar-width: thin; box-sizing: border-box; user-select: t=
ext !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user=
-drag: none;">Plugging in a USB-C DP monitor does<span>&nbsp;</span><b data=
-start=3D"2262" data-end=3D"2269" style=3D"scrollbar-color: rgb(208, 196, 1=
96) transparent; scrollbar-width: thin; user-select: text !important; -webk=
it-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;">not</b>=
<span>&nbsp;</span>create a partner or altmode<br></p></li><li data-start=
=3D"2298" data-end=3D"2364" style=3D"scrollbar-color: rgb(208, 196, 196) tr=
ansparent; scrollbar-width: thin; box-sizing: border-box; user-select: text=
 !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-dr=
ag: none;"><p data-start=3D"2300" data-end=3D"2364" style=3D"scrollbar-colo=
r: rgb(208, 196, 196) transparent; scrollbar-width: thin; box-sizing: borde=
r-box; user-select: text !important; -webkit-tap-highlight-color: rgba(0, 0=
, 0, 0); -webkit-user-drag: none;"><code data-start=3D"2300" data-end=3D"23=
34" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-wid=
th: thin; box-sizing: border-box; user-select: text !important; -webkit-tap=
-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;">/sys/class/dr=
m/card1-DP-1/status</code><span>&nbsp;</span>always remains<span>&nbsp;</sp=
an><code data-start=3D"2350" data-end=3D"2364" style=3D"scrollbar-color: rg=
b(208, 196, 196) transparent; scrollbar-width: thin; box-sizing: border-box=
; user-select: text !important; -webkit-tap-highlight-color: rgba(0, 0, 0, =
0); -webkit-user-drag: none;">disconnected</code><br></p></li><li data-star=
t=3D"2365" data-end=3D"2497" style=3D"scrollbar-color: rgb(208, 196, 196) t=
ransparent; scrollbar-width: thin; box-sizing: border-box; user-select: tex=
t !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-d=
rag: none;"><p data-start=3D"2367" data-end=3D"2422" style=3D"scrollbar-col=
or: rgb(208, 196, 196) transparent; scrollbar-width: thin; box-sizing: bord=
er-box; user-select: text !important; -webkit-tap-highlight-color: rgba(0, =
0, 0, 0); -webkit-user-drag: none;">Only a generic USB device is detected f=
rom the monitor: ... usb 1-5: New USB device found, idVendor=3D0bda, idProd=
uct=3D5411<br></p></li></ul><div dir=3D"auto" style=3D"scrollbar-color: rgb=
(208, 196, 196) transparent; scrollbar-width: thin; box-sizing: border-box;=
 user-select: text !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0=
); -webkit-user-drag: none;"><p data-start=3D"2367" data-end=3D"2422" style=
=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-width: thin;=
 box-sizing: border-box; user-select: text !important; -webkit-tap-highligh=
t-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><br></p></div><h3 data=
-start=3D"2504" data-end=3D"2535" style=3D"scrollbar-color: rgb(208, 196, 1=
96) transparent; scrollbar-width: thin; box-sizing: border-box; margin: 0px=
; font-weight: normal; font-size: 25.6px; user-select: text !important; -we=
bkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><b da=
ta-start=3D"2508" data-end=3D"2535" style=3D"scrollbar-color: rgb(208, 196,=
 196) transparent; scrollbar-width: thin; user-select: text !important; -we=
bkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;">Relev=
ant command output</b><br></h3><p data-start=3D"2537" data-end=3D"2547" sty=
le=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-width: thi=
n; box-sizing: border-box; user-select: text !important; -webkit-tap-highli=
ght-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><b data-start=3D"253=
7" data-end=3D"2547" style=3D"scrollbar-color: rgb(208, 196, 196) transpare=
nt; scrollbar-width: thin; user-select: text !important; -webkit-tap-highli=
ght-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;">Kernel</b><br></p><p=
re class=3D"" data-start=3D"2548" data-end=3D"2583" style=3D"scrollbar-colo=
r: rgb(208, 196, 196) transparent; scrollbar-width: thin; box-sizing: borde=
r-box; margin: 0px; user-select: text !important; -webkit-tap-highlight-col=
or: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><div class=3D"" style=3D"sc=
rollbar-color: rgb(208, 196, 196) transparent; scrollbar-width: thin; box-s=
izing: border-box; user-select: text !important; -webkit-tap-highlight-colo=
r: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><div class=3D"" dir=3D"ltr" =
style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-width: =
thin; box-sizing: border-box; user-select: text !important; -webkit-tap-hig=
hlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><code class=3D"" =
style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-width: =
thin; box-sizing: border-box; user-select: text !important; -webkit-tap-hig=
hlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><span style=3D"sc=
rollbar-color: rgb(208, 196, 196) transparent; scrollbar-width: thin; user-=
select: text !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -we=
bkit-user-drag: none;"><span style=3D"scrollbar-color: rgb(208, 196, 196) t=
ransparent; scrollbar-width: thin; user-select: text !important; -webkit-ta=
p-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><span class=
=3D"" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-w=
idth: thin; user-select: text !important; -webkit-tap-highlight-color: rgba=
(0, 0, 0, 0); -webkit-user-drag: none;">uname</span> -r
6.18.2-arch2-1</span></span></code><br></div></div></pre><p data-start=3D"2=
585" data-end=3D"2593" style=3D"scrollbar-color: rgb(208, 196, 196) transpa=
rent; scrollbar-width: thin; box-sizing: border-box; user-select: text !imp=
ortant; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: n=
one;"><b data-start=3D"2585" data-end=3D"2593" style=3D"scrollbar-color: rg=
b(208, 196, 196) transparent; scrollbar-width: thin; user-select: text !imp=
ortant; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: n=
one;">GPUs</b><br></p><div dir=3D"auto" style=3D"scrollbar-color: rgb(208, =
196, 196) transparent; scrollbar-width: thin; box-sizing: border-box; user-=
select: text !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -we=
bkit-user-drag: none;"><code class=3D"" style=3D"scrollbar-color: rgb(208, =
196, 196) transparent; scrollbar-width: thin; box-sizing: border-box; user-=
select: text !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -we=
bkit-user-drag: none;"><span style=3D"scrollbar-color: rgb(208, 196, 196) t=
ransparent; scrollbar-width: thin; user-select: text !important; -webkit-ta=
p-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><span style=
=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-width: thin;=
 user-select: text !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0=
); -webkit-user-drag: none;"># lspci | grep -E<span>&nbsp;</span><span clas=
s=3D"" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-=
width: thin; user-select: text !important; -webkit-tap-highlight-color: rgb=
a(0, 0, 0, 0); -webkit-user-drag: none;">"VGA|3D"</span></span></span></cod=
e><br></div><div dir=3D"auto" style=3D"scrollbar-color: rgb(208, 196, 196) =
transparent; scrollbar-width: thin; box-sizing: border-box; user-select: te=
xt !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-=
drag: none;"><code class=3D"" style=3D"scrollbar-color: rgb(208, 196, 196) =
transparent; scrollbar-width: thin; box-sizing: border-box; user-select: te=
xt !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-=
drag: none;"><span style=3D"scrollbar-color: rgb(208, 196, 196) transparent=
; scrollbar-width: thin; user-select: text !important; -webkit-tap-highligh=
t-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><span style=3D"scrollb=
ar-color: rgb(208, 196, 196) transparent; scrollbar-width: thin; user-selec=
t: text !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-=
user-drag: none;">&nbsp;"VGA compatible controller: Intel Corporation Alder=
 Lake-P GT1 [UHD Graphics] (rev 0c) VGA compatible controller: NVIDIA Corpo=
ration AD107M [GeForce RTX 4050 Mobile] (rev a1)"</span></span></code><br><=
/div><p data-start=3D"2806" data-end=3D"2822" style=3D"scrollbar-color: rgb=
(208, 196, 196) transparent; scrollbar-width: thin; box-sizing: border-box;=
 user-select: text !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0=
); -webkit-user-drag: none;"><b data-start=3D"2806" data-end=3D"2822" style=
=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-width: thin;=
 user-select: text !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0=
); -webkit-user-drag: none;">Type-C sysfs</b><br></p><pre class=3D"" data-s=
tart=3D"2823" data-end=3D"2902" style=3D"scrollbar-color: rgb(208, 196, 196=
) transparent; scrollbar-width: thin; box-sizing: border-box; margin: 0px; =
user-select: text !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0)=
; -webkit-user-drag: none;"><div class=3D"" style=3D"scrollbar-color: rgb(2=
08, 196, 196) transparent; scrollbar-width: thin; box-sizing: border-box; u=
ser-select: text !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);=
 -webkit-user-drag: none;"><div class=3D"" dir=3D"ltr" style=3D"scrollbar-c=
olor: rgb(208, 196, 196) transparent; scrollbar-width: thin; box-sizing: bo=
rder-box; user-select: text !important; -webkit-tap-highlight-color: rgba(0=
, 0, 0, 0); -webkit-user-drag: none;"><code class=3D"" style=3D"scrollbar-c=
olor: rgb(208, 196, 196) transparent; scrollbar-width: thin; box-sizing: bo=
rder-box; user-select: text !important; -webkit-tap-highlight-color: rgba(0=
, 0, 0, 0); -webkit-user-drag: none;"><span style=3D"scrollbar-color: rgb(2=
08, 196, 196) transparent; scrollbar-width: thin; user-select: text !import=
ant; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none=
;"><span style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollba=
r-width: thin; user-select: text !important; -webkit-tap-highlight-color: r=
gba(0, 0, 0, 0); -webkit-user-drag: none;"><span class=3D"" style=3D"scroll=
bar-color: rgb(208, 196, 196) transparent; scrollbar-width: thin; user-sele=
ct: text !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit=
-user-drag: none;"># ls</span></span><span style=3D"scrollbar-color: rgb(20=
8, 196, 196) transparent; scrollbar-width: thin; user-select: text !importa=
nt; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;=
"> /sys/class/typec
</span><span style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scro=
llbar-width: thin; user-select: text !important; -webkit-tap-highlight-colo=
r: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><span class=3D"" style=3D"sc=
rollbar-color: rgb(208, 196, 196) transparent; scrollbar-width: thin; user-=
select: text !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -we=
bkit-user-drag: none;">  dir empty (directory only appears after modprobe)<=
/span></span><span style=3D"scrollbar-color: rgb(208, 196, 196) transparent=
; scrollbar-width: thin; user-select: text !important; -webkit-tap-highligh=
t-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;">
</span></span></code><br></div></div></pre><p data-start=3D"2904" data-end=
=3D"2928" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollb=
ar-width: thin; box-sizing: border-box; user-select: text !important; -webk=
it-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><b data=
-start=3D"2904" data-end=3D"2928" style=3D"scrollbar-color: rgb(208, 196, 1=
96) transparent; scrollbar-width: thin; user-select: text !important; -webk=
it-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;">DRM con=
nector status</b><br></p><pre class=3D"" data-start=3D"2929" data-end=3D"30=
89" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-wid=
th: thin; box-sizing: border-box; margin: 0px; user-select: text !important=
; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;">=
<div class=3D"" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; s=
crollbar-width: thin; box-sizing: border-box; user-select: text !important;=
 -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><=
code class=3D"" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; s=
crollbar-width: thin; box-sizing: border-box; user-select: text !important;=
 -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><=
span style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-wi=
dth: thin; user-select: text !important; -webkit-tap-highlight-color: rgba(=
0, 0, 0, 0); -webkit-user-drag: none;"><span style=3D"scrollbar-color: rgb(=
208, 196, 196) transparent; scrollbar-width: thin; user-select: text !impor=
tant; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: non=
e;">/sys/class/drm/card1-DP-1/status -&gt; disconnected
/sys/class/drm/card2-eDP-1/status -&gt; connected
/sys/class/drm/card2-HDMI-A-1/status -&gt; disconnected
</span></span></code><br></div></pre><p data-start=3D"3091" data-end=3D"312=
5" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-widt=
h: thin; box-sizing: border-box; user-select: text !important; -webkit-tap-=
highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><b data-start=
=3D"3091" data-end=3D"3125" style=3D"scrollbar-color: rgb(208, 196, 196) tr=
ansparent; scrollbar-width: thin; user-select: text !important; -webkit-tap=
-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;">Type-C kernel=
 config (enabled)</b><br></p><pre class=3D"" data-start=3D"3126" data-end=
=3D"3244" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollb=
ar-width: thin; box-sizing: border-box; margin: 0px; user-select: text !imp=
ortant; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: n=
one;"><div class=3D"" style=3D"scrollbar-color: rgb(208, 196, 196) transpar=
ent; scrollbar-width: thin; box-sizing: border-box; user-select: text !impo=
rtant; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: no=
ne;"><code class=3D"" style=3D"scrollbar-color: rgb(208, 196, 196) transpar=
ent; scrollbar-width: thin; box-sizing: border-box; user-select: text !impo=
rtant; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: no=
ne;"><span style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scroll=
bar-width: thin; user-select: text !important; -webkit-tap-highlight-color:=
 rgba(0, 0, 0, 0); -webkit-user-drag: none;"><span style=3D"scrollbar-color=
: rgb(208, 196, 196) transparent; scrollbar-width: thin; user-select: text =
!important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-dra=
g: none;">CONFIG_TYPEC=3Dm
CONFIG_TYPEC_DP_ALTMODE=3Dm
CONFIG_TYPEC_UCSI=3Dm
CONFIG_UCSI_ACPI=3Dm
CONFIG_TYPEC_TBT_ALTMODE=3Dm
</span></span></code><br></div></pre><p data-start=3D"3246" data-end=3D"328=
5" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-widt=
h: thin; box-sizing: border-box; user-select: text !important; -webkit-tap-=
highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><b data-start=
=3D"3246" data-end=3D"3285" style=3D"scrollbar-color: rgb(208, 196, 196) tr=
ansparent; scrollbar-width: thin; user-select: text !important; -webkit-tap=
-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;">Kernel log wh=
en plugging in monitor</b><br></p><pre class=3D"" data-start=3D"3286" data-=
end=3D"3358" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scro=
llbar-width: thin; box-sizing: border-box; margin: 0px; user-select: text !=
important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag=
: none;"><div class=3D"" style=3D"scrollbar-color: rgb(208, 196, 196) trans=
parent; scrollbar-width: thin; box-sizing: border-box; user-select: text !i=
mportant; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag:=
 none;"><code class=3D"" style=3D"scrollbar-color: rgb(208, 196, 196) trans=
parent; scrollbar-width: thin; box-sizing: border-box; user-select: text !i=
mportant; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag:=
 none;"><span style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scr=
ollbar-width: thin; user-select: text !important; -webkit-tap-highlight-col=
or: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><span style=3D"scrollbar-co=
lor: rgb(208, 196, 196) transparent; scrollbar-width: thin; user-select: te=
xt !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-=
drag: none;">usb 1-5: New USB device found, idVendor=3D0bda, idProduct=3D54=
11
</span></span></code><br></div></pre><p data-start=3D"3360" data-end=3D"341=
5" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-widt=
h: thin; box-sizing: border-box; user-select: text !important; -webkit-tap-=
highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;">No<span>&nbsp;=
</span><code data-start=3D"3363" data-end=3D"3369" style=3D"scrollbar-color=
: rgb(208, 196, 196) transparent; scrollbar-width: thin; box-sizing: border=
-box; user-select: text !important; -webkit-tap-highlight-color: rgba(0, 0,=
 0, 0); -webkit-user-drag: none;">ucsi</code>,<span>&nbsp;</span><code data=
-start=3D"3371" data-end=3D"3378" style=3D"scrollbar-color: rgb(208, 196, 1=
96) transparent; scrollbar-width: thin; box-sizing: border-box; user-select=
: text !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-u=
ser-drag: none;">typec</code>,<span>&nbsp;</span><code data-start=3D"3380" =
data-end=3D"3389" style=3D"scrollbar-color: rgb(208, 196, 196) transparent;=
 scrollbar-width: thin; box-sizing: border-box; user-select: text !importan=
t; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"=
>altmode</code>, or<span>&nbsp;</span><code data-start=3D"3394" data-end=3D=
"3398" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-=
width: thin; box-sizing: border-box; user-select: text !important; -webkit-=
tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;">dp</code><=
span>&nbsp;</span>messages appear.<br></p><div dir=3D"auto" style=3D"scroll=
bar-color: rgb(208, 196, 196) transparent; scrollbar-width: thin; box-sizin=
g: border-box; user-select: text !important; -webkit-tap-highlight-color: r=
gba(0, 0, 0, 0); -webkit-user-drag: none;"><hr data-start=3D"3417" data-end=
=3D"3420" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollb=
ar-width: thin; user-select: text !important; -webkit-tap-highlight-color: =
rgba(0, 0, 0, 0); -webkit-user-drag: none;"><br></div><h3 data-start=3D"342=
2" data-end=3D"3435" style=3D"scrollbar-color: rgb(208, 196, 196) transpare=
nt; scrollbar-width: thin; box-sizing: border-box; margin: 0px; font-weight=
: normal; font-size: 25.6px; user-select: text !important; -webkit-tap-high=
light-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><b data-start=3D"3=
426" data-end=3D"3435" style=3D"scrollbar-color: rgb(208, 196, 196) transpa=
rent; scrollbar-width: thin; user-select: text !important; -webkit-tap-high=
light-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;">Notes</b><br></h3>=
<ul data-start=3D"3436" data-end=3D"3699" style=3D"scrollbar-color: rgb(208=
, 196, 196) transparent; scrollbar-width: thin; box-sizing: border-box; use=
r-select: text !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -=
webkit-user-drag: none;"><li data-start=3D"3436" data-end=3D"3496" style=3D=
"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-width: thin; bo=
x-sizing: border-box; user-select: text !important; -webkit-tap-highlight-c=
olor: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><p data-start=3D"3438" da=
ta-end=3D"3496" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; s=
crollbar-width: thin; box-sizing: border-box; user-select: text !important;=
 -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;">N=
VIDIA DRM modesetting is enabled (<code data-start=3D"3473" data-end=3D"349=
5" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-widt=
h: thin; box-sizing: border-box; user-select: text !important; -webkit-tap-=
highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;">nvidia-drm.mod=
eset=3D1</code>)<br></p></li><li data-start=3D"3536" data-end=3D"3564" styl=
e=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-width: thin=
; box-sizing: border-box; user-select: text !important; -webkit-tap-highlig=
ht-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><p data-start=3D"3538=
" data-end=3D"3564" style=3D"scrollbar-color: rgb(208, 196, 196) transparen=
t; scrollbar-width: thin; box-sizing: border-box; user-select: text !import=
ant; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none=
;">HDMI output works normally<br></p></li><li data-start=3D"3565" data-end=
=3D"3623" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollb=
ar-width: thin; box-sizing: border-box; user-select: text !important; -webk=
it-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><p data=
-start=3D"3567" data-end=3D"3623" style=3D"scrollbar-color: rgb(208, 196, 1=
96) transparent; scrollbar-width: thin; box-sizing: border-box; user-select=
: text !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-u=
ser-drag: none;">Behavior is identical across kernels and display servers<b=
r></p></li><li data-start=3D"3624" data-end=3D"3699" style=3D"scrollbar-col=
or: rgb(208, 196, 196) transparent; scrollbar-width: thin; box-sizing: bord=
er-box; user-select: text !important; -webkit-tap-highlight-color: rgba(0, =
0, 0, 0); -webkit-user-drag: none;"><p data-start=3D"3626" data-end=3D"3699=
" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-width=
: thin; box-sizing: border-box; user-select: text !important; -webkit-tap-h=
ighlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;">Appears that th=
e USB-C / UCSI controller is not being bound by any driver<br></p></li></ul=
><div dir=3D"auto" style=3D"scrollbar-color: rgb(208, 196, 196) transparent=
; scrollbar-width: thin; box-sizing: border-box; user-select: text !importa=
nt; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;=
"><div dir=3D"auto" style=3D"scrollbar-color: rgb(208, 196, 196) transparen=
t; scrollbar-width: thin; box-sizing: border-box; user-select: text !import=
ant; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none=
;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<br></div></div><h3 data-=
start=3D"3706" data-end=3D"3725" style=3D"scrollbar-color: rgb(208, 196, 19=
6) transparent; scrollbar-width: thin; box-sizing: border-box; margin: 0px;=
 font-weight: normal; font-size: 25.6px; user-select: text !important; -web=
kit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><b dat=
a-start=3D"3710" data-end=3D"3725" style=3D"scrollbar-color: rgb(208, 196, =
196) transparent; scrollbar-width: thin; user-select: text !important; -web=
kit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;">Regres=
sion?</b><br></h3><p data-start=3D"3726" data-end=3D"3812" style=3D"scrollb=
ar-color: rgb(208, 196, 196) transparent; scrollbar-width: thin; box-sizing=
: border-box; user-select: text !important; -webkit-tap-highlight-color: rg=
ba(0, 0, 0, 0); -webkit-user-drag: none;">Unknown. System is new; USB-C DP =
Alt-Mode has never worked under Linux on this device.<br></p><div dir=3D"au=
to" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-wid=
th: thin; box-sizing: border-box; user-select: text !important; -webkit-tap=
-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><div dir=3D"a=
uto" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-wi=
dth: thin; box-sizing: border-box; user-select: text !important; -webkit-ta=
p-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;">---------<br=
></div><div dir=3D"auto" style=3D"scrollbar-color: rgb(208, 196, 196) trans=
parent; scrollbar-width: thin; box-sizing: border-box; user-select: text !i=
mportant; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag:=
 none;"><br></div><div dir=3D"auto" style=3D"scrollbar-color: rgb(208, 196,=
 196) transparent; scrollbar-width: thin; box-sizing: border-box; user-sele=
ct: text !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit=
-user-drag: none;"><i><u><span class=3D"" style=3D"font-size: 23px">Misc. c=
ommands and print outs:</span></u></i></div><div dir=3D"auto" style=3D"scro=
llbar-color: rgb(208, 196, 196) transparent; scrollbar-width: thin; box-siz=
ing: border-box; user-select: text !important; -webkit-tap-highlight-color:=
 rgba(0, 0, 0, 0); -webkit-user-drag: none;"><br></div><div dir=3D"auto" st=
yle=3D"scrollbar-color: rgb(208, 196, 196) transparent; scrollbar-width: th=
in; box-sizing: border-box; user-select: text !important; -webkit-tap-highl=
ight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"># xrandr --listmoni=
tors<br></div><div dir=3D"auto" style=3D"scrollbar-color: rgb(208, 196, 196=
) transparent; scrollbar-width: thin; box-sizing: border-box; user-select: =
text !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-use=
r-drag: none;">&nbsp;"0: +*eDP-1 1920/344x1080/193+0+0  eDP-1"<br></div><di=
v dir=3D"auto" style=3D"scrollbar-color: rgb(208, 196, 196) transparent; sc=
rollbar-width: thin; box-sizing: border-box; user-select: text !important; =
-webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag: none;"><b=
r></div><div dir=3D"auto" style=3D"scrollbar-color: rgb(208, 196, 196) tran=
sparent; scrollbar-width: thin; box-sizing: border-box; user-select: text !=
important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-drag=
: none;"><div dir=3D"auto"># xrandr --listproviders<br></div><div dir=3D"au=
to">&nbsp;"Providers: number : 0"<br></div><div dir=3D"auto"><br></div><div=
 dir=3D"auto"># zcat /proc/config.gz 2&gt;/dev/null | grep CONFIG_TYPEC<br>=
</div></div><div dir=3D"auto" style=3D"scrollbar-color: rgb(208, 196, 196) =
transparent; scrollbar-width: thin; box-sizing: border-box; user-select: te=
xt !important; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); -webkit-user-=
drag: none;">&nbsp;"CONFIG_TYPEC=3Dm
CONFIG_TYPEC_TCPM=3Dm
CONFIG_TYPEC_TCPCI=3Dm
CONFIG_TYPEC_RT1711H=3Dm
CONFIG_TYPEC_MT6360=3Dm
CONFIG_TYPEC_TCPCI_MT6370=3Dm
CONFIG_TYPEC_TCPCI_MAXIM=3Dm
CONFIG_TYPEC_FUSB302=3Dm
CONFIG_TYPEC_WCOVE=3Dm
CONFIG_TYPEC_UCSI=3Dm
CONFIG_TYPEC_TPS6598X=3Dm
CONFIG_TYPEC_ANX7411=3Dm
CONFIG_TYPEC_RT1719=3Dm
CONFIG_TYPEC_HD3SS3220=3Dm
CONFIG_TYPEC_STUSB160X=3Dm
CONFIG_TYPEC_WUSB3801=3Dm
CONFIG_TYPEC_MUX_FSA4480=3Dm
CONFIG_TYPEC_MUX_GPIO_SBU=3Dm
CONFIG_TYPEC_MUX_PI3USB30532=3Dm
CONFIG_TYPEC_MUX_INTEL_PMC=3Dm
CONFIG_TYPEC_MUX_IT5205=3Dm
CONFIG_TYPEC_MUX_NB7VPQ904M=3Dm
CONFIG_TYPEC_MUX_PS883X=3Dm
CONFIG_TYPEC_MUX_PTN36502=3Dm
CONFIG_TYPEC_MUX_TUSB1046=3Dm
CONFIG_TYPEC_MUX_WCD939X_USBSS=3Dm
CONFIG_TYPEC_DP_ALTMODE=3Dm
CONFIG_TYPEC_NVIDIA_ALTMODE=3Dm
CONFIG_TYPEC_TBT_ALTMODE=3Dm"<br></div></div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto"># zcat /proc/config.gz 2&gt;/dev/null | grep UCSI<br></div>=
<div dir=3D"auto">&nbsp;"CONFIG_I2C_CCGX_UCSI=3Dy CONFIG_TYPEC_UCSI=3Dm
CONFIG_UCSI_CCG=3Dm
CONFIG_UCSI_ACPI=3Dm
CONFIG_UCSI_STM32G0=3Dm
CONFIG_CROS_EC_UCSI=3Dm"<br></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">#&nbsp;lsmod | grep -E "typec|usb|thunder"<br></div><div dir=3D"auto">=
&nbsp;"typec_ucsi&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 77824&nbsp; 2 ucsi_ccg,ucsi_acpi<br></div><div dir=3D"auto">=
roles&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16384&nbsp; 1 typec_ucsi<br></div><div dir=
=3D"auto">typec&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 114688&nbsp; 1 typec_ucsi<br></div><di=
v dir=3D"auto">thunderbolt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; 577536&nbsp; 1 typec<br></div><div dir=3D"auto">btusb&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 81920&nbsp; 0<br></div><div dir=3D"auto">btmtk&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 32768&nbsp; 1 btusb<br></div><div dir=3D"auto">btrtl&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 32768&nbsp; 1 btusb<br></div><div dir=3D"auto">btbcm&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; 24576&nbsp; 1 btusb<br></div><div dir=3D"auto">b=
tintel&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 73728&nbsp; 1 btusb<br></div><div dir=3D"auto">blueto=
oth&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11182=
08&nbsp; 34 btrtl,btmtk,btintel,btbcm,bnep,btusb,rfcomm"<br></div><div dir=
=3D"auto"><br></div><div dir=3D"auto"># modprobe typec typec_ucsi ucsi_acpi=
 ucsi_ccg<br></div><div dir=3D"auto">&nbsp;No error returned, but 'modprobe=
 typec' seems to create both directories /sys/class/typec/ &amp; /sys/class=
/typec_mux/<br></div><div dir=3D"auto">... Both directories remain empty<br=
></div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"=
auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto">--<br></div><=
div dir=3D"auto">Secured with Tuta Mail:<br></div><div dir=3D"auto"><a href=
=3D"https://tuta.com/free-email" rel=3D"noopener noreferrer" target=3D"_bla=
nk">https://tuta.com/free-email</a><br></div>  </body>
</html>

------=_Part_846595_542540372.1767263898144--

------=_Part_846594_1174211588.1767263898144
Content-Type: text/plain; charset=us-ascii; name=lspci-nnvv.txt
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=lspci-nnvv.txt

00:00.0 Host bridge [0600]: Intel Corporation 12th Gen Core Processor Host Bridge/DRAM Registers [8086:4629] (rev 02)
	DeviceName: Onboard - Other
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device [1462:13b9]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: <access denied>

00:01.0 PCI bridge [0604]: Intel Corporation 12th Gen Core Processor PCI Express x16 Controller #1 [8086:460d] (rev 02) (prog-if 00 [Normal decode])
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device [1462:13b9]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 120
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 4000-4fff [size=4K] [16-bit]
	Memory behind bridge: 51000000-520fffff [size=17M] [32-bit]
	Prefetchable memory behind bridge: 6000000000-6201ffffff [size=8224M] [32-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:02.0 VGA compatible controller [0300]: Intel Corporation Alder Lake-P GT1 [UHD Graphics] [8086:46a3] (rev 0c) (prog-if 00 [VGA controller])
	DeviceName: Onboard - Video
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device [1462:13b9]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 164
	Region 0: Memory at 6202000000 (64-bit, non-prefetchable) [size=16M]
	Region 2: Memory at 4000000000 (64-bit, prefetchable) [size=256M]
	Region 4: I/O ports at 5000 [size=64]
	Expansion ROM at 000c0000 [virtual] [disabled] [size=128K]
	Capabilities: <access denied>
	Kernel driver in use: i915
	Kernel modules: i915, xe

00:04.0 Signal processing controller [1180]: Intel Corporation Alder Lake Innovation Platform Framework Processor Participant [8086:461d] (rev 02)
	DeviceName: Onboard - Other
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device [1462:13b9]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at 6203100000 (64-bit, non-prefetchable) [size=128K]
	Capabilities: <access denied>
	Kernel driver in use: proc_thermal_pci
	Kernel modules: processor_thermal_device_pci

00:06.0 PCI bridge [0604]: Intel Corporation 12th Gen Core Processor PCI Express x4 Controller #0 [8086:464d] (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin D routed to IRQ 121
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: [disabled] [16-bit]
	Memory behind bridge: [disabled] [32-bit]
	Prefetchable memory behind bridge: [disabled] [64-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:06.2 PCI bridge [0604]: Intel Corporation 12th Gen Core Processor PCI Express x4 Controller #2 [8086:463d] (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 122
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: [disabled] [16-bit]
	Memory behind bridge: 52300000-523fffff [size=1M] [32-bit]
	Prefetchable memory behind bridge: [disabled] [64-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:08.0 System peripheral [0880]: Intel Corporation 12th Gen Core Processor Gaussian & Neural Accelerator [8086:464f] (rev 02)
	DeviceName: Onboard - Other
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device [1462:13b9]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 255
	Region 0: Memory at 6203140000 (64-bit, non-prefetchable) [disabled] [size=4K]
	Capabilities: <access denied>

00:14.0 USB controller [0c03]: Intel Corporation Alder Lake PCH USB 3.2 xHCI Host Controller [8086:51ed] (rev 01) (prog-if 30 [XHCI])
	DeviceName: Onboard - Other
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device [1462:13b9]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 125
	Region 0: Memory at 6203120000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: <access denied>
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci

00:14.2 RAM memory [0500]: Intel Corporation Alder Lake PCH Shared SRAM [8086:51ef] (rev 01)
	DeviceName: Onboard - Other
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Region 0: Memory at 6203138000 (64-bit, non-prefetchable) [disabled] [size=16K]
	Region 2: Memory at 620313f000 (64-bit, non-prefetchable) [disabled] [size=4K]
	Capabilities: <access denied>

00:14.3 Network controller [0280]: Intel Corporation Alder Lake-P PCH CNVi WiFi [8086:51f0] (rev 01)
	DeviceName: Onboard - Ethernet
	Subsystem: Intel Corporation Dual Band Wi-Fi 6(802.11ax) AX201 160MHz 2x2 [Harrison Peak] [8086:0074]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at 6203134000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: <access denied>
	Kernel driver in use: iwlwifi
	Kernel modules: iwlwifi

00:15.0 Serial bus controller [0c80]: Intel Corporation Alder Lake PCH Serial IO I2C Controller #0 [8086:51e8] (rev 01)
	DeviceName: Onboard - Other
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device [1462:13b9]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 27
	Region 0: Memory at 4017000000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: <access denied>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:16.0 Communication controller [0780]: Intel Corporation Alder Lake PCH HECI Controller [8086:51e0] (rev 01)
	DeviceName: Onboard - Other
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device [1462:13b9]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 255
	Region 0: Memory at 620313d000 (64-bit, non-prefetchable) [disabled] [size=4K]
	Capabilities: <access denied>
	Kernel modules: mei_me

00:1c.0 PCI bridge [0604]: Intel Corporation Device [8086:51b8] (rev 01) (prog-if 00 [Normal decode])
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device [1462:13b9]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin ? routed to IRQ 123
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: [disabled] [16-bit]
	Memory behind bridge: [disabled] [32-bit]
	Prefetchable memory behind bridge: [disabled] [64-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:1c.5 PCI bridge [0604]: Intel Corporation Alder Lake-P PCH PCIe Root Port #6 [8086:51bd] (rev 01) (prog-if 00 [Normal decode])
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device [1462:13b9]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 124
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
	I/O behind bridge: 3000-3fff [size=4K] [16-bit]
	Memory behind bridge: 52200000-522fffff [size=1M] [32-bit]
	Prefetchable memory behind bridge: [disabled] [64-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:1f.0 ISA bridge [0601]: Intel Corporation Alder Lake PCH eSPI Controller [8086:5182] (rev 01)
	DeviceName: Onboard - Other
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device [1462:13b9]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

00:1f.3 Multimedia audio controller [0401]: Intel Corporation Alder Lake PCH-P High Definition Audio Controller [8086:51c8] (rev 01)
	DeviceName: Onboard - Sound
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device [1462:13e8]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 165
	Region 0: Memory at 6203130000 (64-bit, non-prefetchable) [size=16K]
	Region 4: Memory at 6203000000 (64-bit, non-prefetchable) [size=1M]
	Capabilities: <access denied>
	Kernel driver in use: sof-audio-pci-intel-tgl
	Kernel modules: snd_soc_avs, snd_sof_pci_intel_tgl, snd_hda_intel

00:1f.4 SMBus [0c05]: Intel Corporation Alder Lake PCH-P SMBus Host Controller [8086:51a3] (rev 01)
	DeviceName: Onboard - Other
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device [1462:13b9]
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at 620313c000 (64-bit, non-prefetchable) [size=256]
	Region 4: I/O ports at efa0 [size=32]
	Kernel driver in use: i801_smbus
	Kernel modules: i2c_i801

00:1f.5 Serial bus controller [0c80]: Intel Corporation Alder Lake-P PCH SPI Controller [8086:51a4] (rev 01)
	DeviceName: Onboard - Other
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device [1462:13b9]
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Region 0: Memory at 50400000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: intel-spi
	Kernel modules: spi_intel_pci

01:00.0 VGA compatible controller [0300]: NVIDIA Corporation AD107M [GeForce RTX 4050 Max-Q / Mobile] [10de:28a1] (rev a1) (prog-if 00 [VGA controller])
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device [1462:13b9]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 133
	Region 0: Memory at 51000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at 6000000000 (64-bit, prefetchable) [size=8G]
	Region 3: Memory at 6200000000 (64-bit, prefetchable) [size=32M]
	Region 5: I/O ports at 4000 [size=128]
	Expansion ROM at 52000000 [virtual] [disabled] [size=512K]
	Capabilities: <access denied>
	Kernel driver in use: nvidia
	Kernel modules: nouveau, nvidia_drm, nvidia

01:00.1 Audio device [0403]: NVIDIA Corporation AD107 High Definition Audio Controller [10de:22be] (rev a1) (prog-if 00 [HDA compatible])
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device [1462:13b9]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 17
	Region 0: Memory at 52080000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: <access denied>
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel

03:00.0 Non-Volatile memory controller [0108]: Micron Technology Inc 2400 NVMe SSD (DRAM-less) [1344:5413] (rev 03) (prog-if 02 [NVM Express])
	Subsystem: Micron Technology Inc Device [1344:1100]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at 52300000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: <access denied>
	Kernel driver in use: nvme
	Kernel modules: nvme

05:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev 15)
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device [1462:13b9]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at 3000 [size=256]
	Region 2: Memory at 52204000 (64-bit, non-prefetchable) [size=4K]
	Region 4: Memory at 52200000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: <access denied>
	Kernel driver in use: r8169
	Kernel modules: r8169


------=_Part_846594_1174211588.1767263898144
Content-Type: text/plain; charset=us-ascii; name=lsusb-vv.txt
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=lsusb-vv.txt


[When I ran "lsusb -vv > lsusb-vv.txt" it produced this file, with the following error print in terminal:
Couldn't open device, some information will be missing
Couldn't open device, some information will be missing
Couldn't open device, some information will be missing
Couldn't open device, some information will be missing
Couldn't open device, some information will be missing
Couldn't open device, some information will be missing

Not sure if its relevant]


Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Negotiated speed: High Speed (480Mbps)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 [unknown]
  bDeviceProtocol         1 Single TT
  bMaxPacketSize0        64
  idVendor           0x1d6b Linux Foundation
  idProduct          0x0002 2.0 root hub
  bcdDevice            6.18
  iManufacturer           3 Linux 6.18.2-arch2-1 xhci-hcd
  iProduct                2 xHCI Host Controller
  iSerial                 1 0000:00:14.0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x0019
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 [unknown]
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval              12

Bus 001 Device 003: ID 3938:1289 Telink onn.Wireless Gaming Mouse
Negotiated speed: Full Speed (12Mbps)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 [unknown]
  bDeviceSubClass         0 [unknown]
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x3938 Telink
  idProduct          0x1289 onn.Wireless Gaming Mouse
  bcdDevice            1.04
  iManufacturer           1 Telink
  iProduct                2 onn.Wireless Gaming Mouse
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x0042
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              400mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      2 Mouse
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      93
          Report Descriptors: 
            ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      2 Mouse
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     158
          Report Descriptors: 
            ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x05  EP 5 OUT
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1

Bus 001 Device 008: ID 5986:211b Bison Electronics Inc. HD Webcam
Negotiated speed: High Speed (480Mbps)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.01
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2 [unknown]
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x5986 Bison Electronics Inc.
  idProduct          0x211b HD Webcam
  bcdDevice            3.01
  iManufacturer           1 SunplusIT Inc
  iProduct                2 HD Webcam
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x02f2
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              500mA
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         0
      bInterfaceCount         2
      bFunctionClass         14 Video
      bFunctionSubClass       3 Video Interface Collection
      bFunctionProtocol       0 
      iFunction               4 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      1 Video Control
      bInterfaceProtocol      0 
      iInterface              4 
      VideoControl Interface Descriptor:
        bLength                13
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdUVC               1.00
        wTotalLength       0x006d
        dwClockFrequency       48.000000MHz
        bInCollection           1
        baInterfaceNr( 0)       1
      VideoControl Interface Descriptor:
        bLength                18
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             1
        wTerminalType      0x0201 Camera Sensor
        bAssocTerminal          0
        iTerminal               0 
        wObjectiveFocalLengthMin      0
        wObjectiveFocalLengthMax      0
        wOcularFocalLength            0
        bControlSize                  3
        bmControls           0x00000004
          Auto-Exposure Priority
      VideoControl Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      5 (PROCESSING_UNIT)
      Warning: Descriptor too short
        bUnitID                 2
        bSourceID               1
        wMaxMultiplier      16384
        bControlSize            2
        bmControls     0x0000147f
          Brightness
          Contrast
          Hue
          Saturation
          Sharpness
          Gamma
          White Balance Temperature
          Power Line Frequency
          White Balance Temperature, Auto
        iProcessing             0 
        bmVideoStandards     0x1d
          None
          PAL - 625/50
          SECAM - 625/50
          NTSC - 625/50
      VideoControl Interface Descriptor:
        bLength                29
        bDescriptorType        36
        bDescriptorSubtype      6 (EXTENSION_UNIT)
        bUnitID                 3
        guidExtensionCode         {26b8105a-0713-4870-979d-da79444bb68e}
        bNumControls            1
        bNrInPins               1
        baSourceID( 0)          2
        bControlSize            4
        bmControls( 0)       0x04
        bmControls( 1)       0x00
        bmControls( 2)       0x00
        bmControls( 3)       0x00
        iExtension              0 
      VideoControl Interface Descriptor:
        bLength                29
        bDescriptorType        36
        bDescriptorSubtype      6 (EXTENSION_UNIT)
        bUnitID                 4
        guidExtensionCode         {63610682-5070-49ab-b8cc-b3855e8d221d}
        bNumControls           23
        bNrInPins               1
        baSourceID( 0)          3
        bControlSize            4
        bmControls( 0)       0xff
        bmControls( 1)       0xff
        bmControls( 2)       0x71
        bmControls( 3)       0x2c
        iExtension              0 
      VideoControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             5
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               4
        iTerminal               0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x87  EP 7 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval               8
        VideoControl Endpoint Descriptor:
          bLength                 5
          bDescriptorType        37
          bDescriptorSubtype      3 (EP_INTERRUPT)
          wMaxTransferSize     1029
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      VideoStreaming Interface Descriptor:
        bLength                            15
        bDescriptorType                    36
        bDescriptorSubtype                  1 (INPUT_HEADER)
        bNumFormats                         2
        wTotalLength                   0x01a6
        bEndpointAddress                 0x81  EP 1 IN
        bmInfo                              0
        bTerminalLink                       5
        bStillCaptureMethod                 2
        bTriggerSupport                     1
        bTriggerUsage                       0
        bControlSize                        1
        bmaControls( 0)                     4
        bmaControls( 1)                     0
      VideoStreaming Interface Descriptor:
        bLength                            11
        bDescriptorType                    36
        bDescriptorSubtype                  6 (FORMAT_MJPEG)
        bFormatIndex                        1
        bNumFrameDescriptors                6
        bFlags                              1
          Fixed-size samples: Yes
        bDefaultFrameIndex                  1
        bAspectRatioX                       0
        bAspectRatioY                       0
        bmInterlaceFlags                 0x00
          Interlaced stream or variable: No
          Fields per frame: 1 fields
          Field 1 first: No
          Field pattern: Field 1 only
        bCopyProtect                        0
      VideoStreaming Interface Descriptor:
        bLength                            30
        bDescriptorType                    36
        bDescriptorSubtype                  7 (FRAME_MJPEG)
        bFrameIndex                         1
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                           1280
        wHeight                           720
        dwMinBitRate                442368000
        dwMaxBitRate                442368000
        dwMaxVideoFrameBufferSize     1843200
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  1
        dwFrameInterval( 0)            333333
      VideoStreaming Interface Descriptor:
        bLength                            30
        bDescriptorType                    36
        bDescriptorSubtype                  7 (FRAME_MJPEG)
        bFrameIndex                         2
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           480
        dwMinBitRate                147456000
        dwMaxBitRate                147456000
        dwMaxVideoFrameBufferSize      614400
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  1
        dwFrameInterval( 0)            333333
      VideoStreaming Interface Descriptor:
        bLength                            30
        bDescriptorType                    36
        bDescriptorSubtype                  7 (FRAME_MJPEG)
        bFrameIndex                         3
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           360
        dwMinBitRate                110592000
        dwMaxBitRate                110592000
        dwMaxVideoFrameBufferSize      460800
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  1
        dwFrameInterval( 0)            333333
      VideoStreaming Interface Descriptor:
        bLength                            30
        bDescriptorType                    36
        bDescriptorSubtype                  7 (FRAME_MJPEG)
        bFrameIndex                         4
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            320
        wHeight                           240
        dwMinBitRate                 36864000
        dwMaxBitRate                 36864000
        dwMaxVideoFrameBufferSize      153600
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  1
        dwFrameInterval( 0)            333333
      VideoStreaming Interface Descriptor:
        bLength                            30
        bDescriptorType                    36
        bDescriptorSubtype                  7 (FRAME_MJPEG)
        bFrameIndex                         5
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           360
        dwMinBitRate                110592000
        dwMaxBitRate                110592000
        dwMaxVideoFrameBufferSize      460800
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  1
        dwFrameInterval( 0)            333333
      VideoStreaming Interface Descriptor:
        bLength                            30
        bDescriptorType                    36
        bDescriptorSubtype                  7 (FRAME_MJPEG)
        bFrameIndex                         6
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           360
        dwMinBitRate                110592000
        dwMaxBitRate                110592000
        dwMaxVideoFrameBufferSize      460800
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  1
        dwFrameInterval( 0)            333333
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                  3 (STILL_IMAGE_FRAME)
        bEndpointAddress                 0x00  EP 0 OUT
        bNumImageSizePatterns               6
        wWidth( 0)                       1280
        wHeight( 0)                       720
        wWidth( 1)                        640
        wHeight( 1)                       480
        wWidth( 2)                        640
        wHeight( 2)                       360
        wWidth( 3)                        320
        wHeight( 3)                       240
        wWidth( 4)                        640
        wHeight( 4)                       360
        wWidth( 5)                        640
        wHeight( 5)                       360
        bNumCompressionPatterns             4
        bCompression( 0)                    1
        bCompression( 1)                    5
        bCompression( 2)                   10
        bCompression( 3)                   20
      VideoStreaming Interface Descriptor:
        bLength                             6
        bDescriptorType                    36
        bDescriptorSubtype                 13 (COLORFORMAT)
        bColorPrimaries                     1 (BT.709,sRGB)
        bTransferCharacteristics            1 (BT.709)
        bMatrixCoefficients                 4 (SMPTE 170M (BT.601))
      VideoStreaming Interface Descriptor:
        bLength                            27
        bDescriptorType                    36
        bDescriptorSubtype                  4 (FORMAT_UNCOMPRESSED)
        bFormatIndex                        2
        bNumFrameDescriptors                4
        guidFormat                            {32595559-0000-0010-8000-00aa00389b71}
        bBitsPerPixel                      16
        bDefaultFrameIndex                  1
        bAspectRatioX                       0
        bAspectRatioY                       0
        bmInterlaceFlags                 0x00
          Interlaced stream or variable: No
          Fields per frame: 2 fields
          Field 1 first: No
          Field pattern: Field 1 only
        bCopyProtect                        0
      VideoStreaming Interface Descriptor:
        bLength                            30
        bDescriptorType                    36
        bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
        bFrameIndex                         1
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                           1280
        wHeight                           720
        dwMinBitRate                147456000
        dwMaxBitRate                147456000
        dwMaxVideoFrameBufferSize     1843200
        dwDefaultFrameInterval        1000000
        bFrameIntervalType                  1
        dwFrameInterval( 0)           1000000
      VideoStreaming Interface Descriptor:
        bLength                            30
        bDescriptorType                    36
        bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
        bFrameIndex                         2
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           480
        dwMinBitRate                147456000
        dwMaxBitRate                147456000
        dwMaxVideoFrameBufferSize      614400
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  1
        dwFrameInterval( 0)            333333
      VideoStreaming Interface Descriptor:
        bLength                            30
        bDescriptorType                    36
        bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
        bFrameIndex                         3
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           360
        dwMinBitRate                110592000
        dwMaxBitRate                110592000
        dwMaxVideoFrameBufferSize      460800
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  1
        dwFrameInterval( 0)            333333
      VideoStreaming Interface Descriptor:
        bLength                            30
        bDescriptorType                    36
        bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
        bFrameIndex                         4
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            320
        wHeight                           240
        dwMinBitRate                 36864000
        dwMaxBitRate                 36864000
        dwMaxVideoFrameBufferSize      153600
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  1
        dwFrameInterval( 0)            333333
      VideoStreaming Interface Descriptor:
        bLength                            23
        bDescriptorType                    36
        bDescriptorSubtype                  3 (STILL_IMAGE_FRAME)
        bEndpointAddress                 0x00  EP 0 OUT
        bNumImageSizePatterns               4
        wWidth( 0)                       1280
        wHeight( 0)                       720
        wWidth( 1)                        640
        wHeight( 1)                       480
        wWidth( 2)                        640
        wHeight( 2)                       360
        wWidth( 3)                        320
        wHeight( 3)                       240
        bNumCompressionPatterns             1
        bCompression( 0)                    1
      VideoStreaming Interface Descriptor:
        bLength                             6
        bDescriptorType                    36
        bDescriptorSubtype                 13 (COLORFORMAT)
        bColorPrimaries                     1 (BT.709,sRGB)
        bTransferCharacteristics            1 (BT.709)
        bMatrixCoefficients                 4 (SMPTE 170M (BT.601))
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x00c0  1x 192 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0180  1x 384 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       3
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       4
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0280  1x 640 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       5
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0320  1x 800 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       6
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x03b0  1x 944 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       7
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0a80  2x 640 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       8
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0b20  2x 800 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       9
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0be0  2x 992 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting      10
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x13c0  3x 960 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting      11
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x13fc  3x 1020 bytes
        bInterval               1

Bus 001 Device 009: ID 8087:0026 Intel Corp. AX201 Bluetooth
Negotiated speed: Full Speed (12Mbps)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.01
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  bMaxPacketSize0        64
  idVendor           0x8087 Intel Corp.
  idProduct          0x0026 AX201 Bluetooth
  bcdDevice            0.02
  iManufacturer           0 
  iProduct                0 
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x00c8
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0000  1x 0 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0000  1x 0 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0009  1x 9 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0009  1x 9 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0011  1x 17 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0011  1x 17 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       3
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0019  1x 25 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0019  1x 25 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       4
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0021  1x 33 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0021  1x 33 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       5
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0031  1x 49 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0031  1x 49 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       6
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x003f  1x 63 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x003f  1x 63 bytes
        bInterval               1

Bus 001 Device 013: ID 0bda:5411 Realtek Semiconductor Corp. RTS5411 Hub
Negotiated speed: High Speed (480Mbps)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 [unknown]
  bDeviceProtocol         2 TT per port
  bMaxPacketSize0        64
  idVendor           0x0bda Realtek Semiconductor Corp.
  idProduct          0x5411 RTS5411 Hub
  bcdDevice            1.47
  iManufacturer           1 Generic
  iProduct                2 USB2.1 Hub
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x0029
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 [unknown]
      bInterfaceProtocol      1 Single TT
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0001  1x 1 bytes
        bInterval              12
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 [unknown]
      bInterfaceProtocol      2 TT per port
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0001  1x 1 bytes
        bInterval              12

Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Negotiated speed: SuperSpeed+ (10Gbps)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               3.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 [unknown]
  bDeviceProtocol         3 
  bMaxPacketSize0         9
  idVendor           0x1d6b Linux Foundation
  idProduct          0x0003 3.0 root hub
  bcdDevice            6.18
  iManufacturer           3 Linux 6.18.2-arch2-1 xhci-hcd
  iProduct                2 xHCI Host Controller
  iSerial                 1 0000:00:14.0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x001f
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 [unknown]
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval              12
        bMaxBurst               0
        wBytesPerInterval       2

------=_Part_846594_1174211588.1767263898144
Content-Type: text/plain; charset=us-ascii; name=dmesg.txt
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=dmesg.txt

[    0.000000] Linux version 6.18.2-arch2-1 (linux@archlinux) (gcc (GCC) 15.2.1 20251112, GNU ld (GNU Binutils) 2.45.1) #1 SMP PREEMPT_DYNAMIC Thu, 18 Dec 2025 18:00:18 +0000
[    0.000000] Command line: BOOT_IMAGE=/@/boot/vmlinuz-linux root=UUID=REDACTED rw rootflags=subvol=@ root=UUID=REDACTED rootfstype=btrfs rootflags=subvol=@ rw quiet resume=UUID=REDACTED loglevel=3 quiet splash nvidia-drm.modeset=1
[    0.000000] x86/split lock detection: #AC: crashing the kernel on kernel split_locks and warning on user-space split_locks
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009efff] reserved
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003d9adfff] usable
[    0.000000] BIOS-e820: [mem 0x000000003d9ae000-0x0000000040aadfff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000040aae000-0x0000000040bb6fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000040bb7000-0x0000000040cd1fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000040cd2000-0x0000000043efefff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000043eff000-0x0000000043efffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000043f00000-0x0000000049ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000004a200000-0x000000004a3fffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000004b000000-0x00000000503fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000c0000000-0x00000000cfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed20000-0x00000000fed7ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000008afbfffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] efi: EFI v2.8 by American Megatrends
[    0.000000] efi: ACPI=0x40bb6000 ACPI 2.0=0x40bb6014 TPMFinalLog=0x40c3f000 SMBIOS=0x43b8a000 SMBIOS 3.0=0x43b89000 MEMATTR=0x386b4318 ESRT=0x3a55a018 INITRD=0x36110c18 RNG=0x40ae2018 TPMEventLog=0x40ad8018 
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem77: MMIO range=[0xc0000000-0xcfffffff] (256MB) from e820 map
[    0.000000] e820: remove [mem 0xc0000000-0xcfffffff] reserved
[    0.000000] efi: Not removing mem78: MMIO range=[0xfe000000-0xfe010fff] (68KB) from e820 map
[    0.000000] efi: Not removing mem79: MMIO range=[0xfec00000-0xfec00fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem80: MMIO range=[0xfed00000-0xfed00fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem82: MMIO range=[0xfee00000-0xfee00fff] (4KB) from e820 map
[    0.000000] efi: Remove mem83: MMIO range=[0xff000000-0xffffffff] (16MB) from e820 map
[    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
[    0.000000] SMBIOS 3.5.0 present.
[    0.000000] DMI: Micro-Star International Co., Ltd. Cyborg 15 A12VE/MS-15K1, BIOS E15K1IMS.306 12/30/2022
[    0.000000] DMI: Memory slots populated: 2/2
[    0.000000] tsc: Detected 2500.000 MHz processor
[    0.000000] tsc: Detected 2496.000 MHz TSC
[    0.000934] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000936] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000941] last_pfn = 0x8afc00 max_arch_pfn = 0x400000000
[    0.000944] MTRR map: 5 entries (3 fixed + 2 variable; max 23), built from 10 variable MTRRs
[    0.000945] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.001321] last_pfn = 0x43f00 max_arch_pfn = 0x400000000
[    0.013001] esrt: Reserving ESRT space from 0x000000003a55a018 to 0x000000003a55a0c8.
[    0.013005] e820: update [mem 0x3a55a000-0x3a55afff] usable ==> reserved
[    0.013015] Using GB pages for direct mapping
[    0.013223] Secure boot disabled
[    0.013223] RAMDISK: [mem 0x1cfe6000-0x23e7efff]
[    0.013227] ACPI: Early table checksum verification disabled
[    0.013229] ACPI: RSDP 0x0000000040BB6014 000024 (v02 MSI_NB)
[    0.013232] ACPI: XSDT 0x0000000040BB5728 00013C (v01 MSI_NB MEGABOOK 01072009 AMI  01000013)
[    0.013236] ACPI: FACP 0x0000000040BAF000 000114 (v06 MSI_NB MEGABOOK 01072009 AMI  01000013)
[    0.013239] ACPI: DSDT 0x0000000040B21000 08D6E1 (v02 MSI_NB MEGABOOK 01072009 INTL 20200717)
[    0.013241] ACPI: FACS 0x0000000040CD1000 000040
[    0.013243] ACPI: SSDT 0x0000000040BB0000 00457B (v02 DptfTb DptfTabl 00001000 INTL 20200717)
[    0.013244] ACPI: FIDT 0x0000000040B20000 00009C (v01 MSI_NB MEGABOOK 01072009 AMI  00010013)
[    0.013246] ACPI: MSDM 0x0000000040B1F000 000055 (v03 MSI_NB MEGABOOK 01072009 AMI  01000013)
[    0.013248] ACPI: SLIC 0x0000000040B1E000 000176 (v01 MSI_NB MEGABOOK 01072009 AMI  01000013)
[    0.013250] ACPI: SSDT 0x0000000040B1D000 00038C (v02 PmaxDv Pmax_Dev 00000001 INTL 20200717)
[    0.013251] ACPI: SSDT 0x0000000040B1C000 000066 (v02 MSI_NB MsiNvs   00003000 INTL 20200717)
[    0.013253] ACPI: SSDT 0x0000000040B16000 005D34 (v02 CpuRef CpuSsdt  00003000 INTL 20200717)
[    0.013255] ACPI: SSDT 0x0000000040B13000 002935 (v02 SaSsdt SaSsdt   00003000 INTL 20200717)
[    0.013257] ACPI: SSDT 0x0000000040B0F000 0033E9 (v02 INTEL  IgfxSsdt 00003000 INTL 20200717)
[    0.013258] ACPI: HPET 0x0000000040B0E000 000038 (v01 MSI_NB MEGABOOK 01072009 AMI  01000013)
[    0.013260] ACPI: APIC 0x0000000040B0D000 0001DC (v05 MSI_NB MEGABOOK 01072009 AMI  01000013)
[    0.013262] ACPI: MCFG 0x0000000040B0C000 00003C (v01 MSI_NB MEGABOOK 01072009 AMI  01000013)
[    0.013264] ACPI: SSDT 0x0000000040B04000 0078CE (v02 MSI_NB AdlP_Rvp 00001000 INTL 20200717)
[    0.013265] ACPI: UEFI 0x0000000040C25000 000048 (v01 MSI_NB MEGABOOK 01072009 AMI  01000013)
[    0.013267] ACPI: LPIT 0x0000000040B03000 0000CC (v01 MSI_NB MEGABOOK 01072009 AMI  01000013)
[    0.013269] ACPI: SSDT 0x0000000040AFF000 002A83 (v02 MSI_NB PtidDevc 00001000 INTL 20200717)
[    0.013270] ACPI: SSDT 0x0000000040AFC000 002357 (v02 MSI_NB TbtTypeC 00000000 INTL 20200717)
[    0.013272] ACPI: DBGP 0x0000000040AFB000 000034 (v01 MSI_NB MEGABOOK 01072009 AMI  01000013)
[    0.013274] ACPI: DBG2 0x0000000040AFA000 000054 (v00 MSI_NB MEGABOOK 01072009 AMI  01000013)
[    0.013275] ACPI: SSDT 0x0000000040AF8000 00190A (v02 MSI_NB UsbCTabl 00001000 INTL 20200717)
[    0.013277] ACPI: NHLT 0x0000000040AF7000 000F4E (v00 MSI_NB MEGABOOK 01072009 AMI  01000013)
[    0.013279] ACPI: DMAR 0x0000000040AF6000 000088 (v02 INTEL  EDK2     00000002      01000013)
[    0.013281] ACPI: FPDT 0x0000000040AF5000 000044 (v01 MSI_NB A M I    01072009 AMI  01000013)
[    0.013282] ACPI: SSDT 0x0000000040AF4000 000A77 (v02 INTEL  xh_adlLP 00000000 INTL 20200717)
[    0.013284] ACPI: SSDT 0x0000000040AF0000 003AEA (v02 SocGpe SocGpe   00003000 INTL 20200717)
[    0.013286] ACPI: SSDT 0x0000000040AEC000 0039DA (v02 SocCmn SocCmn   00003000 INTL 20200717)
[    0.013288] ACPI: SSDT 0x0000000040AEB000 000457 (v02 HgRef  HgRpSsdt 00001000 INTL 20200717)
[    0.013290] ACPI: SSDT 0x0000000040AEA000 000144 (v02 Intel  ADebTabl 00001000 INTL 20200717)
[    0.013291] ACPI: BGRT 0x0000000040AE9000 000038 (v01 MSI_NB MEGABOOK 01072009 AMI  00010013)
[    0.013293] ACPI: TPM2 0x0000000040AE8000 00004C (v04 MSI_NB MEGABOOK 00000001 AMI  00000000)
[    0.013295] ACPI: SSDT 0x0000000040AE5000 002F79 (v01 OptRf2 Opt2Tabl 00001000 INTL 20200717)
[    0.013296] ACPI: PHAT 0x0000000040AE4000 000591 (v01 MSI_NB MEGABOOK 00000005 MSFT 0100000D)
[    0.013298] ACPI: WSMT 0x0000000040B02000 000028 (v01 MSI_NB MEGABOOK 01072009 AMI  00010013)
[    0.013300] ACPI: BGRT 0x0000000040AE3000 000038 (v01 MSI_NB MEGABOOK 01072009 AMI  00010013)
[    0.013301] ACPI: Reserving FACP table memory at [mem 0x40baf000-0x40baf113]
[    0.013302] ACPI: Reserving DSDT table memory at [mem 0x40b21000-0x40bae6e0]
[    0.013303] ACPI: Reserving FACS table memory at [mem 0x40cd1000-0x40cd103f]
[    0.013303] ACPI: Reserving SSDT table memory at [mem 0x40bb0000-0x40bb457a]
[    0.013304] ACPI: Reserving FIDT table memory at [mem 0x40b20000-0x40b2009b]
[    0.013304] ACPI: Reserving MSDM table memory at [mem 0x40b1f000-0x40b1f054]
[    0.013305] ACPI: Reserving SLIC table memory at [mem 0x40b1e000-0x40b1e175]
[    0.013305] ACPI: Reserving SSDT table memory at [mem 0x40b1d000-0x40b1d38b]
[    0.013306] ACPI: Reserving SSDT table memory at [mem 0x40b1c000-0x40b1c065]
[    0.013306] ACPI: Reserving SSDT table memory at [mem 0x40b16000-0x40b1bd33]
[    0.013306] ACPI: Reserving SSDT table memory at [mem 0x40b13000-0x40b15934]
[    0.013307] ACPI: Reserving SSDT table memory at [mem 0x40b0f000-0x40b123e8]
[    0.013307] ACPI: Reserving HPET table memory at [mem 0x40b0e000-0x40b0e037]
[    0.013308] ACPI: Reserving APIC table memory at [mem 0x40b0d000-0x40b0d1db]
[    0.013308] ACPI: Reserving MCFG table memory at [mem 0x40b0c000-0x40b0c03b]
[    0.013309] ACPI: Reserving SSDT table memory at [mem 0x40b04000-0x40b0b8cd]
[    0.013309] ACPI: Reserving UEFI table memory at [mem 0x40c25000-0x40c25047]
[    0.013310] ACPI: Reserving LPIT table memory at [mem 0x40b03000-0x40b030cb]
[    0.013310] ACPI: Reserving SSDT table memory at [mem 0x40aff000-0x40b01a82]
[    0.013310] ACPI: Reserving SSDT table memory at [mem 0x40afc000-0x40afe356]
[    0.013311] ACPI: Reserving DBGP table memory at [mem 0x40afb000-0x40afb033]
[    0.013311] ACPI: Reserving DBG2 table memory at [mem 0x40afa000-0x40afa053]
[    0.013312] ACPI: Reserving SSDT table memory at [mem 0x40af8000-0x40af9909]
[    0.013312] ACPI: Reserving NHLT table memory at [mem 0x40af7000-0x40af7f4d]
[    0.013313] ACPI: Reserving DMAR table memory at [mem 0x40af6000-0x40af6087]
[    0.013313] ACPI: Reserving FPDT table memory at [mem 0x40af5000-0x40af5043]
[    0.013314] ACPI: Reserving SSDT table memory at [mem 0x40af4000-0x40af4a76]
[    0.013314] ACPI: Reserving SSDT table memory at [mem 0x40af0000-0x40af3ae9]
[    0.013314] ACPI: Reserving SSDT table memory at [mem 0x40aec000-0x40aef9d9]
[    0.013315] ACPI: Reserving SSDT table memory at [mem 0x40aeb000-0x40aeb456]
[    0.013315] ACPI: Reserving SSDT table memory at [mem 0x40aea000-0x40aea143]
[    0.013316] ACPI: Reserving BGRT table memory at [mem 0x40ae9000-0x40ae9037]
[    0.013316] ACPI: Reserving TPM2 table memory at [mem 0x40ae8000-0x40ae804b]
[    0.013317] ACPI: Reserving SSDT table memory at [mem 0x40ae5000-0x40ae7f78]
[    0.013317] ACPI: Reserving PHAT table memory at [mem 0x40ae4000-0x40ae4590]
[    0.013318] ACPI: Reserving WSMT table memory at [mem 0x40b02000-0x40b02027]
[    0.013318] ACPI: Reserving BGRT table memory at [mem 0x40ae3000-0x40ae3037]
[    0.013495] No NUMA configuration found
[    0.013495] Faking a node at [mem 0x0000000000000000-0x00000008afbfffff]
[    0.013499] NODE_DATA(0) allocated [mem 0x8afbd5280-0x8afbfffff]
[    0.013639] Zone ranges:
[    0.013640]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.013641]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.013642]   Normal   [mem 0x0000000100000000-0x00000008afbfffff]
[    0.013642]   Device   empty
[    0.013643] Movable zone start for each node
[    0.013644] Early memory node ranges
[    0.013644]   node   0: [mem 0x0000000000001000-0x000000000009dfff]
[    0.013645]   node   0: [mem 0x000000000009f000-0x000000000009ffff]
[    0.013645]   node   0: [mem 0x0000000000100000-0x000000003d9adfff]
[    0.013646]   node   0: [mem 0x0000000043eff000-0x0000000043efffff]
[    0.013646]   node   0: [mem 0x0000000100000000-0x00000008afbfffff]
[    0.013648] Initmem setup node 0 [mem 0x0000000000001000-0x00000008afbfffff]
[    0.013651] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.013652] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.013667] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.014761] On node 0, zone DMA32: 25937 pages in unavailable ranges
[    0.046241] On node 0, zone Normal: 16640 pages in unavailable ranges
[    0.046247] On node 0, zone Normal: 1024 pages in unavailable ranges
[    0.046286] Reserving Intel graphics memory at [mem 0x4c800000-0x503fffff]
[    0.046683] ACPI: PM-Timer IO Port: 0x1808
[    0.046690] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.046691] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.046692] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.046692] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.046692] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.046693] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.046693] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.046693] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.046694] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.046694] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.046694] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.046695] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.046695] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.046695] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.046696] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.046696] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.046696] ACPI: LAPIC_NMI (acpi_id[0x11] high edge lint[0x1])
[    0.046697] ACPI: LAPIC_NMI (acpi_id[0x12] high edge lint[0x1])
[    0.046697] ACPI: LAPIC_NMI (acpi_id[0x13] high edge lint[0x1])
[    0.046697] ACPI: LAPIC_NMI (acpi_id[0x14] high edge lint[0x1])
[    0.046698] ACPI: LAPIC_NMI (acpi_id[0x15] high edge lint[0x1])
[    0.046698] ACPI: LAPIC_NMI (acpi_id[0x16] high edge lint[0x1])
[    0.046698] ACPI: LAPIC_NMI (acpi_id[0x17] high edge lint[0x1])
[    0.046699] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.046733] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    0.046735] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.046736] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.046739] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.046740] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.046745] e820: update [mem 0x382ef000-0x383e2fff] usable ==> reserved
[    0.046752] TSC deadline timer available
[    0.046754] CPU topo: Max. logical packages:   1
[    0.046755] CPU topo: Max. logical dies:       1
[    0.046755] CPU topo: Max. dies per package:   1
[    0.046757] CPU topo: Max. threads per core:   2
[    0.046757] CPU topo: Num. cores per package:     8
[    0.046758] CPU topo: Num. threads per package:  12
[    0.046758] CPU topo: Allowing 12 present CPUs plus 0 hotplug CPUs
[    0.046770] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.046771] PM: hibernation: Registered nosave memory: [mem 0x0009e000-0x0009efff]
[    0.046772] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.046773] PM: hibernation: Registered nosave memory: [mem 0x382ef000-0x383e2fff]
[    0.046774] PM: hibernation: Registered nosave memory: [mem 0x3a55a000-0x3a55afff]
[    0.046775] PM: hibernation: Registered nosave memory: [mem 0x3d9ae000-0x43efefff]
[    0.046776] PM: hibernation: Registered nosave memory: [mem 0x43f00000-0xffffffff]
[    0.046776] [mem 0x50400000-0xfdffffff] available for PCI devices
[    0.046777] Booting paravirtualized kernel on bare hardware
[    0.046779] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.051405] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:12 nr_cpu_ids:12 nr_node_ids:1
[    0.051784] percpu: Embedded 62 pages/cpu s217088 r8192 d28672 u262144
[    0.051788] pcpu-alloc: s217088 r8192 d28672 u262144 alloc=1*2097152
[    0.051790] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 -- -- -- -- 
[    0.051803] Kernel command line: BOOT_IMAGE=/@/boot/vmlinuz-linux root=UUID=REDACTED rw rootflags=subvol=@ root=UUID=REDACTED rootfstype=btrfs rootflags=subvol=@ rw quiet resume=UUID=REDACTED loglevel=3 quiet splash nvidia-drm.modeset=1
[    0.051867] Unknown kernel command line parameters "splash", will be passed to user space.
[    0.051875] printk: log buffer data + meta data: 131072 + 458752 = 589824 bytes
[    0.053923] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.054981] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.055076] software IO TLB: area num 16.
[    0.063281] Fallback order for Node 0: 0 
[    0.063283] Built 1 zonelists, mobility grouping on.  Total pages: 8312141
[    0.063284] Policy zone: Normal
[    0.063443] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.102382] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=12, Nodes=1
[    0.107869] ftrace: allocating 57002 entries in 224 pages
[    0.107870] ftrace: allocated 224 pages with 3 groups
[    0.107933] Dynamic Preempt: full
[    0.107976] rcu: Preemptible hierarchical RCU implementation.
[    0.107977] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=12.
[    0.107977] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.107978] 	Trampoline variant of Tasks RCU enabled.
[    0.107978] 	Rude variant of Tasks RCU enabled.
[    0.107979] 	Tracing variant of Tasks RCU enabled.
[    0.107979] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.107979] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=12
[    0.107987] RCU Tasks: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=12.
[    0.107988] RCU Tasks Rude: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=12.
[    0.107989] RCU Tasks Trace: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=12.
[    0.111183] NR_IRQS: 524544, nr_irqs: 2152, preallocated irqs: 16
[    0.111473] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.111684] kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
[    0.111710] Console: colour dummy device 80x25
[    0.111712] printk: legacy console [tty0] enabled
[    0.111742] ACPI: Core revision 20250807
[    0.111985] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.112070] APIC: Switch to symmetric I/O mode setup
[    0.112072] DMAR: Host address width 39
[    0.112073] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.112076] DMAR: dmar0: reg_base_addr fed90000 ver 4:0 cap 1c0000c40660462 ecap 29a00f0505e
[    0.112077] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.112080] DMAR: dmar1: reg_base_addr fed91000 ver 5:0 cap d2008c40660462 ecap f050da
[    0.112082] DMAR: RMRR base: 0x0000004c000000 end: 0x000000503fffff
[    0.112083] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.112084] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.112085] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.113628] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.113629] x2apic enabled
[    0.113676] APIC: Switched APIC routing to: cluster x2apic
[    0.118199] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x23fa772cf26, max_idle_ns: 440795269835 ns
[    0.118203] Calibrating delay loop (skipped), value calculated using timer frequency.. 4992.00 BogoMIPS (lpj=2496000)
[    0.118251] x86/cpu: VMX (outside TXT) disabled by BIOS
[    0.118258] CPU0: Thermal monitoring enabled (TM1)
[    0.118260] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.118363] CET detected: Indirect Branch Tracking enabled
[    0.118364] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.118365] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.118369] process: using mwait in idle threads
[    0.118371] mitigations: Enabled attack vectors: user_kernel, user_user, guest_host, guest_guest, SMT mitigations: auto
[    0.118373] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.118374] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.118375] Register File Data Sampling: Mitigation: Clear Register File
[    0.118376] VMSCAPE: Mitigation: IBPB before exit to userspace
[    0.118376] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.118377] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
[    0.118378] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.118386] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.118387] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.118388] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.118388] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.118389] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow User registers'
[    0.118389] x86/fpu: Supporting XSAVE feature 0x1000: 'Control-flow Kernel registers (KVM only)'
[    0.118390] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.118391] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8
[    0.118391] x86/fpu: xstate_offset[11]:  840, xstate_sizes[11]:   16
[    0.118392] x86/fpu: xstate_offset[12]:  856, xstate_sizes[12]:   24
[    0.118392] x86/fpu: Enabled xstate features 0x1a07, context size is 880 bytes, using 'compacted' format.
[    0.119202] Freeing SMP alternatives memory: 56K
[    0.119202] pid_max: default: 32768 minimum: 301
[    0.119202] LSM: initializing lsm=capability,landlock,lockdown,yama,bpf
[    0.119202] landlock: Up and running.
[    0.119202] Yama: becoming mindful.
[    0.119202] LSM support for eBPF active
[    0.119202] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.119202] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.119202] smpboot: CPU0: 12th Gen Intel(R) Core(TM) i5-12450H (family: 0x6, model: 0x9a, stepping: 0x3)
[    0.119202] Performance Events: XSAVE Architectural LBR, PEBS fmt4+-baseline,  AnyThread deprecated, Alderlake Hybrid events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.119202] core: cpu_core PMU driver: 
[    0.119202] ... version:                   5
[    0.119202] ... bit width:                 48
[    0.119202] ... generic counters:          8
[    0.119202] ... generic bitmap:            00000000000000ff
[    0.119202] ... fixed-purpose counters:    4
[    0.119202] ... fixed-purpose bitmap:      000000000000000f
[    0.119202] ... value mask:                0000ffffffffffff
[    0.119202] ... max period:                00007fffffffffff
[    0.119202] ... global_ctrl mask:          0001000f000000ff
[    0.119202] signal: max sigframe size: 3632
[    0.119202] Estimated ratio of average max frequency by base frequency (times 1024): 1679
[    0.119202] rcu: Hierarchical SRCU implementation.
[    0.119202] rcu: 	Max phase no-delay instances is 400.
[    0.119202] Timer migration: 2 hierarchy levels; 8 children per group; 2 crossnode level
[    0.119202] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.119202] smp: Bringing up secondary CPUs ...
[    0.119231] smpboot: x86: Booting SMP configuration:
[    0.119232] .... node  #0, CPUs:        #2  #4  #6  #8  #9 #10 #11
[    0.007588] core: cpu_atom PMU driver: 
[    0.007588] ... version:                   5
[    0.007588] ... bit width:                 48
[    0.007588] ... generic counters:          6
[    0.007588] ... generic bitmap:            000000000000003f
[    0.007588] ... fixed-purpose counters:    3
[    0.007588] ... fixed-purpose bitmap:      0000000000000007
[    0.007588] ... value mask:                0000ffffffffffff
[    0.007588] ... max period:                00007fffffffffff
[    0.007588] ... global_ctrl mask:          000000070000003f
[    0.123270]   #1  #3  #5  #7
[    0.125262] smp: Brought up 1 node, 12 CPUs
[    0.125262] smpboot: Total of 12 processors activated (59904.00 BogoMIPS)
[    0.126266] Memory: 32410852K/33248564K available (20303K kernel code, 2937K rwdata, 16372K rodata, 4732K init, 4788K bss, 813684K reserved, 0K cma-reserved)
[    0.126873] devtmpfs: initialized
[    0.126873] x86/mm: Memory block size: 128MB
[    0.128234] ACPI: PM: Registering ACPI NVS region [mem 0x40bb7000-0x40cd1fff] (1159168 bytes)
[    0.128254] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.128254] posixtimers hash table entries: 8192 (order: 5, 131072 bytes, linear)
[    0.128254] futex hash table entries: 4096 (262144 bytes on 1 NUMA nodes, total 256 KiB, linear).
[    0.128283] pinctrl core: initialized pinctrl subsystem
[    0.128494] PM: RTC time: 04:47:58, date: 2026-01-01
[    0.128829] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.129312] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
[    0.129595] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.129881] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.129884] audit: initializing netlink subsys (disabled)
[    0.129889] audit: type=2000 audit(1767242878.011:1): state=initialized audit_enabled=0 res=1
[    0.129889] thermal_sys: Registered thermal governor 'fair_share'
[    0.129889] thermal_sys: Registered thermal governor 'bang_bang'
[    0.129889] thermal_sys: Registered thermal governor 'step_wise'
[    0.129889] thermal_sys: Registered thermal governor 'user_space'
[    0.129889] thermal_sys: Registered thermal governor 'power_allocator'
[    0.129889] cpuidle: using governor ladder
[    0.129889] cpuidle: using governor menu
[    0.129889] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.129889] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.129889] PCI: ECAM [mem 0xc0000000-0xcfffffff] (base 0xc0000000) for domain 0000 [bus 00-ff]
[    0.129889] PCI: Using configuration type 1 for base access
[    0.130244] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.134259] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.134259] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.134259] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.134259] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.135223] raid6: skipped pq benchmark and selected avx2x4
[    0.135225] raid6: using avx2x2 recovery algorithm
[    0.135294] ACPI: Added _OSI(Module Device)
[    0.135295] ACPI: Added _OSI(Processor Device)
[    0.135296] ACPI: Added _OSI(Processor Aggregator Device)
[    0.232693] ACPI: 17 ACPI AML tables successfully acquired and loaded
[    0.255139] ACPI: Dynamic OEM Table Load:
[    0.255148] ACPI: SSDT 0xFFFF8B86014F8C00 000394 (v02 PmRef  Cpu0Cst  00003001 INTL 20200717)
[    0.258211] ACPI: Dynamic OEM Table Load:
[    0.258211] ACPI: SSDT 0xFFFF8B86014F5800 0005E4 (v02 PmRef  Cpu0Ist  00003000 INTL 20200717)
[    0.260852] ACPI: Dynamic OEM Table Load:
[    0.260859] ACPI: SSDT 0xFFFF8B8601F3DA00 0001AB (v02 PmRef  Cpu0Psd  00003000 INTL 20200717)
[    0.263562] ACPI: Dynamic OEM Table Load:
[    0.263568] ACPI: SSDT 0xFFFF8B86014F7800 0004B5 (v02 PmRef  Cpu0Hwp  00003000 INTL 20200717)
[    0.267101] ACPI: Dynamic OEM Table Load:
[    0.267110] ACPI: SSDT 0xFFFF8B86014E6000 001BAF (v02 PmRef  ApIst    00003000 INTL 20200717)
[    0.271378] ACPI: Dynamic OEM Table Load:
[    0.271385] ACPI: SSDT 0xFFFF8B86014E2000 001038 (v02 PmRef  ApHwp    00003000 INTL 20200717)
[    0.275180] ACPI: Dynamic OEM Table Load:
[    0.275187] ACPI: SSDT 0xFFFF8B86029F4000 001349 (v02 PmRef  ApPsd    00003000 INTL 20200717)
[    0.279021] ACPI: Dynamic OEM Table Load:
[    0.279028] ACPI: SSDT 0xFFFF8B8601502000 000FBB (v02 PmRef  ApCst    00003000 INTL 20200717)
[    0.288250] ACPI: EC: EC started
[    0.288251] ACPI: EC: interrupt blocked
[    0.294858] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.294860] ACPI: \_SB_.PC00.LPCB.EC__: Boot DSDT EC used to handle transactions
[    0.294861] ACPI: Interpreter enabled
[    0.294911] ACPI: PM: (supports S0 S3 S4 S5)
[    0.294911] ACPI: Using IOAPIC for interrupt routing
[    0.298913] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.298914] PCI: Using E820 reservations for host bridge windows
[    0.300876] ACPI: Enabled 9 GPEs in block 00 to 7F
[    0.302911] ACPI: \_SB_.PC00.PEG1.PXP_: New power resource
[    0.325067] ACPI: \_SB_.PC00.XHCI.RHUB.HS10.BTRT: New power resource
[    0.326081] ACPI: \_SB_.PC00.PAUD: New power resource
[    0.327924] ACPI: \_SB_.PC00.I2C0.PXTC: New power resource
[    0.342279] ACPI: \_SB_.PC00.CNVW.WRST: New power resource
[    0.353518] ACPI: \PIN_: New power resource
[    0.354851] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-fe])
[    0.354856] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    0.356795] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR DPC]
[    0.356797] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    0.358740] PCI host bridge to bus 0000:00
[    0.358744] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.358747] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.358748] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.358750] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000fffff window]
[    0.358751] pci_bus 0000:00: root bus resource [mem 0x50400000-0xbfffffff window]
[    0.358752] pci_bus 0000:00: root bus resource [mem 0x4000000000-0x7fffffffff window]
[    0.358753] pci_bus 0000:00: root bus resource [mem 0xfe0b0400-0xfe0b13ff window]
[    0.358754] pci_bus 0000:00: root bus resource [bus 00-fe]
[    0.358784] pci 0000:00:00.0: [8086:4629] type 00 class 0x060000 conventional PCI endpoint
[    0.358931] pci 0000:00:01.0: [8086:460d] type 01 class 0x060400 PCIe Root Port
[    0.358947] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.358949] pci 0000:00:01.0:   bridge window [io  0x4000-0x4fff]
[    0.358951] pci 0000:00:01.0:   bridge window [mem 0x51000000-0x520fffff]
[    0.358957] pci 0000:00:01.0:   bridge window [mem 0x6000000000-0x6201ffffff 64bit pref]
[    0.358997] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.359022] pci 0000:00:01.0: PTM enabled (root), 4ns granularity
[    0.359837] pci 0000:00:02.0: [8086:46a3] type 00 class 0x030000 PCIe Root Complex Integrated Endpoint
[    0.359851] pci 0000:00:02.0: BAR 0 [mem 0x6202000000-0x6202ffffff 64bit]
[    0.359854] pci 0000:00:02.0: BAR 2 [mem 0x4000000000-0x400fffffff 64bit pref]
[    0.359855] pci 0000:00:02.0: BAR 4 [io  0x5000-0x503f]
[    0.359865] pci 0000:00:02.0: DMAR: Skip IOMMU disabling for graphics
[    0.359868] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.359894] pci 0000:00:02.0: VF BAR 0 [mem 0x00000000-0x00ffffff 64bit]
[    0.359896] pci 0000:00:02.0: VF BAR 0 [mem 0x00000000-0x06ffffff 64bit]: contains BAR 0 for 7 VFs
[    0.359898] pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0x1fffffff 64bit pref]
[    0.359899] pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0xdfffffff 64bit pref]: contains BAR 2 for 7 VFs
[    0.360100] pci 0000:00:04.0: [8086:461d] type 00 class 0x118000 conventional PCI endpoint
[    0.360128] pci 0000:00:04.0: BAR 0 [mem 0x6203100000-0x620311ffff 64bit]
[    0.360494] pci 0000:00:06.0: [8086:464d] type 01 class 0x060400 PCIe Root Port
[    0.360521] pci 0000:00:06.0: PCI bridge to [bus 02]
[    0.360580] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
[    0.360630] pci 0000:00:06.0: PTM enabled (root), 4ns granularity
[    0.361490] pci 0000:00:06.2: [8086:463d] type 01 class 0x060400 PCIe Root Port
[    0.361508] pci 0000:00:06.2: PCI bridge to [bus 03]
[    0.361515] pci 0000:00:06.2:   bridge window [mem 0x52300000-0x523fffff]
[    0.361569] pci 0000:00:06.2: PME# supported from D0 D3hot D3cold
[    0.361600] pci 0000:00:06.2: PTM enabled (root), 4ns granularity
[    0.362451] pci 0000:00:08.0: [8086:464f] type 00 class 0x088000 conventional PCI endpoint
[    0.362468] pci 0000:00:08.0: BAR 0 [mem 0x6203140000-0x6203140fff 64bit]
[    0.362599] pci 0000:00:14.0: [8086:51ed] type 00 class 0x0c0330 conventional PCI endpoint
[    0.362646] pci 0000:00:14.0: BAR 0 [mem 0x6203120000-0x620312ffff 64bit]
[    0.362698] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.365189] pci 0000:00:14.2: [8086:51ef] type 00 class 0x050000 conventional PCI endpoint
[    0.365239] pci 0000:00:14.2: BAR 0 [mem 0x6203138000-0x620313bfff 64bit]
[    0.365243] pci 0000:00:14.2: BAR 2 [mem 0x620313f000-0x620313ffff 64bit]
[    0.365434] pci 0000:00:14.3: [8086:51f0] type 00 class 0x028000 PCIe Root Complex Integrated Endpoint
[    0.365524] pci 0000:00:14.3: BAR 0 [mem 0x6203134000-0x6203137fff 64bit]
[    0.365644] pci 0000:00:14.3: PME# supported from D0 D3hot D3cold
[    0.366256] pci 0000:00:15.0: [8086:51e8] type 00 class 0x0c8000 conventional PCI endpoint
[    0.366366] pci 0000:00:15.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.376552] pci 0000:00:16.0: [8086:51e0] type 00 class 0x078000 conventional PCI endpoint
[    0.376608] pci 0000:00:16.0: BAR 0 [mem 0x620313d000-0x620313dfff 64bit]
[    0.376667] pci 0000:00:16.0: PME# supported from D3hot
[    0.377366] pci 0000:00:1c.0: [8086:51b8] type 01 class 0x060400 PCIe Root Port
[    0.377395] pci 0000:00:1c.0: PCI bridge to [bus 04]
[    0.377475] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.378334] pci 0000:00:1c.5: [8086:51bd] type 01 class 0x060400 PCIe Root Port
[    0.378359] pci 0000:00:1c.5: PCI bridge to [bus 05]
[    0.378363] pci 0000:00:1c.5:   bridge window [io  0x3000-0x3fff]
[    0.378366] pci 0000:00:1c.5:   bridge window [mem 0x52200000-0x522fffff]
[    0.378449] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.378486] pci 0000:00:1c.5: PTM enabled (root), 4ns granularity
[    0.379337] pci 0000:00:1f.0: [8086:5182] type 00 class 0x060100 conventional PCI endpoint
[    0.379755] pci 0000:00:1f.3: [8086:51c8] type 00 class 0x040100 conventional PCI endpoint
[    0.379857] pci 0000:00:1f.3: BAR 0 [mem 0x6203130000-0x6203133fff 64bit]
[    0.379869] pci 0000:00:1f.3: BAR 4 [mem 0x6203000000-0x62030fffff 64bit]
[    0.379967] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.380085] pci 0000:00:1f.4: [8086:51a3] type 00 class 0x0c0500 conventional PCI endpoint
[    0.380136] pci 0000:00:1f.4: BAR 0 [mem 0x620313c000-0x620313c0ff 64bit]
[    0.380143] pci 0000:00:1f.4: BAR 4 [io  0xefa0-0xefbf]
[    0.380463] pci 0000:00:1f.5: [8086:51a4] type 00 class 0x0c8000 conventional PCI endpoint
[    0.380519] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]
[    0.380625] pci 0000:01:00.0: [10de:28a1] type 00 class 0x030000 PCIe Legacy Endpoint
[    0.380648] pci 0000:01:00.0: BAR 0 [mem 0x51000000-0x51ffffff]
[    0.380650] pci 0000:01:00.0: BAR 1 [mem 0x6000000000-0x61ffffffff 64bit pref]
[    0.380652] pci 0000:01:00.0: BAR 3 [mem 0x6200000000-0x6201ffffff 64bit pref]
[    0.380654] pci 0000:01:00.0: BAR 5 [io  0x4000-0x407f]
[    0.380656] pci 0000:01:00.0: ROM [mem 0x52000000-0x5207ffff pref]
[    0.380703] pci 0000:01:00.0: PME# supported from D0 D3hot
[    0.381171] pci 0000:01:00.1: [10de:22be] type 00 class 0x040300 PCIe Endpoint
[    0.381193] pci 0000:01:00.1: BAR 0 [mem 0x52080000-0x52083fff]
[    0.381288] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.381348] pci 0000:00:06.0: PCI bridge to [bus 02]
[    0.381423] pci 0000:03:00.0: [1344:5413] type 00 class 0x010802 PCIe Endpoint
[    0.381447] pci 0000:03:00.0: BAR 0 [mem 0x52300000-0x52303fff 64bit]
[    0.382012] pci 0000:00:06.2: PCI bridge to [bus 03]
[    0.382075] pci 0000:00:1c.0: PCI bridge to [bus 04]
[    0.382158] pci 0000:05:00.0: [10ec:8168] type 00 class 0x020000 PCIe Endpoint
[    0.382224] pci 0000:05:00.0: BAR 0 [io  0x3000-0x30ff]
[    0.382231] pci 0000:05:00.0: BAR 2 [mem 0x52204000-0x52204fff 64bit]
[    0.382235] pci 0000:05:00.0: BAR 4 [mem 0x52200000-0x52203fff 64bit]
[    0.382359] pci 0000:05:00.0: supports D1 D2
[    0.382360] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.382611] pci 0000:00:1c.5: PCI bridge to [bus 05]
[    0.387257] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.387375] ACPI: PCI: Interrupt link LNKB configured for IRQ 1
[    0.387492] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.387608] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.387726] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.387843] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.387959] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.388079] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    1.359630] Low-power S0 idle used by default for system suspend
[    1.360075] ACPI: EC: interrupt unblocked
[    1.360077] ACPI: EC: event unblocked
[    1.360209] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    1.360209] ACPI: EC: GPE=0x6e
[    1.360209] ACPI: \_SB_.PC00.LPCB.EC__: Boot DSDT EC initialization complete
[    1.360209] ACPI: \_SB_.PC00.LPCB.EC__: EC: Used to handle transactions and events
[    1.360212] iommu: Default domain type: Translated
[    1.360212] iommu: DMA domain TLB invalidation policy: lazy mode
[    1.360331] SCSI subsystem initialized
[    1.360339] libata version 3.00 loaded.
[    1.360339] ACPI: bus type USB registered
[    1.360339] usbcore: registered new interface driver usbfs
[    1.360339] usbcore: registered new interface driver hub
[    1.360339] usbcore: registered new device driver usb
[    1.360339] EDAC MC: Ver: 3.0.0
[    1.360444] efivars: Registered efivars operations
[    1.360453] NetLabel: Initializing
[    1.360454] NetLabel:  domain hash size = 128
[    1.360455] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    1.360471] NetLabel:  unlabeled traffic allowed by default
[    1.360475] mctp: management component transport protocol core
[    1.360476] NET: Registered PF_MCTP protocol family
[    1.360485] PCI: Using ACPI for IRQ routing
[    1.383846] PCI: pci_cache_line_size set to 64 bytes
[    1.383984] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]: can't claim; no compatible bridge window
[    1.384084] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    1.384086] e820: reserve RAM buffer [mem 0x382ef000-0x3bffffff]
[    1.384087] e820: reserve RAM buffer [mem 0x3a55a000-0x3bffffff]
[    1.384088] e820: reserve RAM buffer [mem 0x3d9ae000-0x3fffffff]
[    1.384088] e820: reserve RAM buffer [mem 0x43f00000-0x43ffffff]
[    1.384089] e820: reserve RAM buffer [mem 0x8afc00000-0x8afffffff]
[    1.384212] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    1.384212] pci 0000:00:02.0: vgaarb: bridge control possible
[    1.384212] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    1.384215] pci 0000:01:00.0: vgaarb: bridge control possible
[    1.384216] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    1.384217] vgaarb: loaded
[    1.384393] clocksource: Switched to clocksource tsc-early
[    1.384794] VFS: Disk quotas dquot_6.6.0
[    1.384803] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.384815] pnp: PnP ACPI init
[    1.385203] system 00:01: [io  0x0680-0x069f] has been reserved
[    1.385206] system 00:01: [io  0x164e-0x164f] has been reserved
[    1.387561] pnp 00:02: disabling [mem 0xc0000000-0xcfffffff] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    1.387583] system 00:02: [mem 0xfedc0000-0xfedc7fff] has been reserved
[    1.387585] system 00:02: [mem 0xfeda0000-0xfeda0fff] has been reserved
[    1.387586] system 00:02: [mem 0xfeda1000-0xfeda1fff] has been reserved
[    1.387588] system 00:02: [mem 0xfed20000-0xfed7ffff] could not be reserved
[    1.387592] system 00:02: [mem 0xfed90000-0xfed93fff] could not be reserved
[    1.387593] system 00:02: [mem 0xfed45000-0xfed8ffff] could not be reserved
[    1.387595] system 00:02: [mem 0xfee00000-0xfeefffff] could not be reserved
[    1.388087] system 00:03: [io  0x2000-0x20fe] has been reserved
[    1.389184] pnp: PnP ACPI: found 5 devices
[    1.394613] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    1.394669] NET: Registered PF_INET protocol family
[    1.394847] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    1.408184] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes, linear)
[    1.408218] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    1.408375] TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    1.408690] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
[    1.408802] TCP: Hash tables configured (established 262144 bind 65536)
[    1.408931] MPTCP token hash table entries: 32768 (order: 8, 786432 bytes, linear)
[    1.409050] UDP hash table entries: 16384 (order: 8, 1048576 bytes, linear)
[    1.409189] UDP-Lite hash table entries: 16384 (order: 8, 1048576 bytes, linear)
[    1.409291] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    1.409301] NET: Registered PF_XDP protocol family
[    1.409318] pci 0000:00:02.0: VF BAR 2 [mem 0x4020000000-0x40ffffffff 64bit pref]: assigned
[    1.409323] pci 0000:00:02.0: VF BAR 0 [mem 0x4010000000-0x4016ffffff 64bit]: assigned
[    1.409325] pci 0000:00:15.0: BAR 0 [mem 0x4017000000-0x4017000fff 64bit]: assigned
[    1.409343] resource: avoiding allocation from e820 entry [mem 0x000a0000-0x000fffff]
[    1.409345] resource: avoiding allocation from e820 entry [mem 0x000a0000-0x000fffff]
[    1.409346] pci 0000:00:1f.5: BAR 0 [mem 0x50400000-0x50400fff]: assigned
[    1.409358] pci 0000:00:01.0: PCI bridge to [bus 01]
[    1.409359] pci 0000:00:01.0:   bridge window [io  0x4000-0x4fff]
[    1.409362] pci 0000:00:01.0:   bridge window [mem 0x51000000-0x520fffff]
[    1.409364] pci 0000:00:01.0:   bridge window [mem 0x6000000000-0x6201ffffff 64bit pref]
[    1.409368] pci 0000:00:06.0: PCI bridge to [bus 02]
[    1.409379] pci 0000:00:06.2: PCI bridge to [bus 03]
[    1.409385] pci 0000:00:06.2:   bridge window [mem 0x52300000-0x523fffff]
[    1.409392] pci 0000:00:1c.0: PCI bridge to [bus 04]
[    1.409409] pci 0000:00:1c.5: PCI bridge to [bus 05]
[    1.409411] pci 0000:00:1c.5:   bridge window [io  0x3000-0x3fff]
[    1.409415] pci 0000:00:1c.5:   bridge window [mem 0x52200000-0x522fffff]
[    1.409422] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    1.409423] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    1.409424] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    1.409425] pci_bus 0000:00: resource 7 [mem 0x000e0000-0x000fffff window]
[    1.409426] pci_bus 0000:00: resource 8 [mem 0x50400000-0xbfffffff window]
[    1.409427] pci_bus 0000:00: resource 9 [mem 0x4000000000-0x7fffffffff window]
[    1.409429] pci_bus 0000:00: resource 10 [mem 0xfe0b0400-0xfe0b13ff window]
[    1.409430] pci_bus 0000:01: resource 0 [io  0x4000-0x4fff]
[    1.409431] pci_bus 0000:01: resource 1 [mem 0x51000000-0x520fffff]
[    1.409432] pci_bus 0000:01: resource 2 [mem 0x6000000000-0x6201ffffff 64bit pref]
[    1.409433] pci_bus 0000:03: resource 1 [mem 0x52300000-0x523fffff]
[    1.409434] pci_bus 0000:05: resource 0 [io  0x3000-0x3fff]
[    1.409435] pci_bus 0000:05: resource 1 [mem 0x52200000-0x522fffff]
[    1.410192] pci 0000:01:00.1: extending delay after power-on from D3hot to 20 msec
[    1.410219] pci 0000:01:00.1: D0 power state depends on 0000:01:00.0
[    1.410282] PCI: CLS 64 bytes, default 64
[    1.410322] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.410323] software IO TLB: mapped [mem 0x0000000029118000-0x000000002d118000] (64MB)
[    1.410385] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x23fa772cf26, max_idle_ns: 440795269835 ns
[    1.410539] clocksource: Switched to clocksource tsc
[    1.410558] platform rtc_cmos: registered platform RTC device (no PNP device found)
[    1.410594] Trying to unpack rootfs image as initramfs...
[    1.432979] Initialise system trusted keyrings
[    1.432989] Key type blacklist registered
[    1.433197] workingset: timestamp_bits=36 max_order=23 bucket_order=0
[    1.433470] fuse: init (API version 7.45)
[    1.433549] integrity: Platform Keyring initialized
[    1.433552] integrity: Machine keyring initialized
[    1.442211] xor: automatically using best checksumming function   avx       
[    1.442214] Key type asymmetric registered
[    1.442215] Asymmetric key parser 'x509' registered
[    1.442246] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
[    1.442468] io scheduler mq-deadline registered
[    1.442470] io scheduler kyber registered
[    1.442486] io scheduler bfq registered
[    1.443869] ledtrig-cpu: registered to indicate activity on CPUs
[    1.444179] pcieport 0000:00:01.0: PME: Signaling with IRQ 120
[    1.444352] pcieport 0000:00:01.0: AER: enabled with IRQ 120
[    1.444721] pcieport 0000:00:06.0: PME: Signaling with IRQ 121
[    1.444854] pcieport 0000:00:06.0: AER: enabled with IRQ 121
[    1.445172] pcieport 0000:00:06.2: PME: Signaling with IRQ 122
[    1.445331] pcieport 0000:00:06.2: AER: enabled with IRQ 122
[    1.445495] pcieport 0000:00:1c.0: PME: Signaling with IRQ 123
[    1.445807] pcieport 0000:00:1c.5: PME: Signaling with IRQ 124
[    1.445953] pcieport 0000:00:1c.5: AER: enabled with IRQ 124
[    1.446229] ACPI: AC: AC Adapter [ADP1] (on-line)
[    1.446269] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:35/PNP0C09:00/PNP0C0D:00/input/input0
[    1.450718] ACPI: button: Lid Switch [LID0]
[    1.450768] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
[    1.450784] ACPI: button: Sleep Button [SLPB]
[    1.450809] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input2
[    1.450886] ACPI: button: Power Button [PWRB]
[    1.454620] thermal LNXTHERM:00: registered as thermal_zone0
[    1.454623] ACPI: thermal: Thermal Zone [THRM] (77 C)
[    1.454809] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    1.456356] hpet_acpi_add: no address or irqs in _CRS
[    1.456395] Non-volatile memory driver v1.3
[    1.456396] Linux agpgart interface v0.103
[    1.492248] ACPI: bus type drm_connector registered
[    1.494476] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.494486] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    1.495603] xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000100200009810
[    1.495971] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.495976] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    1.495978] xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperSpeed
[    1.496044] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.18
[    1.496048] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.496049] usb usb1: Product: xHCI Host Controller
[    1.496050] usb usb1: Manufacturer: Linux 6.18.2-arch2-1 xhci-hcd
[    1.496051] usb usb1: SerialNumber: 0000:00:14.0
[    1.496195] hub 1-0:1.0: USB hub found
[    1.496218] hub 1-0:1.0: 12 ports detected
[    1.498718] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.18
[    1.498722] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.498723] usb usb2: Product: xHCI Host Controller
[    1.498727] usb usb2: Manufacturer: Linux 6.18.2-arch2-1 xhci-hcd
[    1.498728] usb usb2: SerialNumber: 0000:00:14.0
[    1.498837] hub 2-0:1.0: USB hub found
[    1.498853] hub 2-0:1.0: 4 ports detected
[    1.499897] usbcore: registered new interface driver usbserial_generic
[    1.499902] usbserial: USB Serial support registered for generic
[    1.499934] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    1.499936] i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
[    1.501669] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.501877] rtc_cmos rtc_cmos: RTC can wake from S4
[    1.502772] rtc_cmos rtc_cmos: registered as rtc0
[    1.502940] rtc_cmos rtc_cmos: setting system clock to 2026-01-01T04:47:59 UTC (1767242879)
[    1.502969] rtc_cmos rtc_cmos: alarms up to one month, y3k, 114 bytes nvram
[    1.504843] intel_pstate: Intel P-state driver initializing
[    1.506042] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input3
[    1.506047] intel_pstate: HWP enabled
[    1.506321] simple-framebuffer simple-framebuffer.0: [drm] Registered 1 planes with drm panic
[    1.506322] [drm] Initialized simpledrm 1.0.0 for simple-framebuffer.0 on minor 0
[    1.506630] fbcon: Deferring console take-over
[    1.506631] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledrmdrmfb frame buffer device
[    1.506662] hid: raw HID events driver (C) Jiri Kosina
[    1.506675] usbcore: registered new interface driver usbhid
[    1.506675] usbhid: USB HID core driver
[    1.506707] rust_binder: Loaded Rust Binder.
[    1.506728] drop_monitor: Initializing network drop monitor service
[    1.506798] NET: Registered PF_INET6 protocol family
[    1.506981] Segment Routing with IPv6
[    1.506983] RPL Segment Routing with IPv6
[    1.506986] In-situ OAM (IOAM) with IPv6
[    1.507000] NET: Registered PF_PACKET protocol family
[    1.511018] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    1.513823] microcode: Current revision: 0x0000043a
[    1.513824] microcode: Updated early from: 0x00000424
[    1.514037] IPI shorthand broadcast: enabled
[    1.515001] sched_clock: Marking stable (1508000688, 6588318)->(1547656251, -33067245)
[    1.515335] registered taskstats version 1
[    1.515846] Loading compiled-in X.509 certificates
[    1.556106] ACPI: battery: Slot [BAT1] (battery present)
[    1.572859] Freeing initrd memory: 113252K
[    1.577450] Loaded X.509 cert 'Build time autogenerated kernel key: a5b00b95218882d944c89b2378e440be4d948982'
[    1.578732] zswap: loaded using pool zstd
[    1.578920] Demotion targets for Node 0: null
[    1.579124] Key type .fscrypt registered
[    1.579125] Key type fscrypt-provisioning registered
[    1.579281] Btrfs loaded, zoned=yes, fsverity=yes
[    1.579295] Key type big_key registered
[    1.579512] integrity: Loading X.509 certificate: UEFI:db
[    1.579523] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: REDACTED'
[    1.579523] integrity: Loading X.509 certificate: UEFI:db
[    1.579529] integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: REDACTED'
[    1.580370] PM:   Magic number: 10:699:766
[    1.581095] RAS: Correctable Errors collector initialized.
[    1.583967] clk: Disabling unused clocks
[    1.583969] PM: genpd: Disabling unused power domains
[    1.594878] Freeing unused decrypted memory: 2028K
[    1.595554] Freeing unused kernel image (initmem) memory: 4732K
[    1.595568] Write protecting the kernel read-only data: 36864k
[    1.596078] Freeing unused kernel image (text/rodata gap) memory: 176K
[    1.596349] Freeing unused kernel image (rodata/data gap) memory: 12K
[    1.602006] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.602009] rodata_test: all tests were successful
[    1.602013] Run /init as init process
[    1.602013]   with arguments:
[    1.602014]     /init
[    1.602015]     splash
[    1.602015]   with environment:
[    1.602016]     HOME=/
[    1.602016]     TERM=linux
[    1.638029] systemd[1]: Successfully made /usr/ read-only.
[    1.638310] systemd[1]: systemd 259-1-arch running in system mode (+PAM +AUDIT -SELINUX +APPARMOR -IMA +IPE +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +UTMP -SYSVINIT +LIBARCHIVE)
[    1.638320] systemd[1]: Detected architecture x86-64.
[    1.638323] systemd[1]: Running in initrd.
[    1.638588] systemd[1]: Hostname set to <REDACTED>.
[    1.719792] systemd[1]: bpf-restrict-fs: LSM BPF program attached
[    1.733607] usb 1-4: new full-speed USB device number 2 using xhci_hcd
[    1.754412] systemd[1]: /usr/lib/systemd/system/systemd-udevd.service:56: System call bpf cannot be resolved as libseccomp is not available, ignoring: Operation not supported
[    1.754535] systemd[1]: /usr/lib/systemd/system/systemd-udevd.service.d/50-rc_keymap.conf:3: System call bpf cannot be resolved as libseccomp is not available, ignoring: Operation not supported
[    1.761671] systemd[1]: Queued start job for default target Initrd Default Target.
[    1.825318] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    1.825359] systemd[1]: Expecting device /dev/disk/by-uuid/REDACTED...
[    1.825366] systemd[1]: Expecting device /dev/disk/by-uuid/REDACTED...
[    1.825392] systemd[1]: Reached target Initrd /usr File System.
[    1.825411] systemd[1]: Reached target Path Units.
[    1.825431] systemd[1]: Reached target Slice Units.
[    1.825446] systemd[1]: Reached target Swaps.
[    1.825460] systemd[1]: Reached target Timer Units.
[    1.825544] systemd[1]: Listening on Journal Socket (/dev/log).
[    1.825607] systemd[1]: Listening on Journal Sockets.
[    1.825658] systemd[1]: Listening on udev Control Socket.
[    1.825696] systemd[1]: Listening on udev Kernel Socket.
[    1.825711] systemd[1]: Reached target Socket Units.
[    1.832107] systemd[1]: Starting Create List of Static Device Nodes...
[    1.835340] systemd[1]: Starting Early Battery Level Check...
[    1.838266] systemd[1]: Starting Journal Service...
[    1.841442] systemd[1]: Starting Load Kernel Modules...
[    1.841842] systemd[1]: TPM PCR Barrier (initrd) was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    1.843721] systemd[1]: Starting Virtual Console Setup...
[    1.844187] systemd-journald[228]: Collecting audit messages is disabled.
[    1.846702] usb 1-4: device descriptor read/64, error -71
[    1.858354] systemd[1]: Finished Create List of Static Device Nodes.
[    1.859142] i2c_dev: i2c /dev entries driver
[    1.865010] systemd[1]: Finished Early Battery Level Check.
[    1.866740] wmi_bus wmi_bus-PNP0C14:00: [Firmware Bug]: WQAK data block query control method not found
[    1.866750] wmi_bus wmi_bus-PNP0C14:00: [Firmware Bug]: WQAL data block query control method not found
[    1.866754] wmi_bus wmi_bus-PNP0C14:00: [Firmware Bug]: WMAJ method block execution control method not found
[    1.870482] systemd[1]: Finished Virtual Console Setup.
[    1.870694] systemd[1]: dracut ask for additional cmdline parameters was skipped because no trigger condition checks were met.
[    1.870762] vboxdrv: loading out-of-tree module taints kernel.
[    1.870768] vboxdrv: module verification failed: signature and/or required key missing - tainting kernel
[    1.873463] systemd[1]: Starting dracut cmdline hook...
[    1.885345] vboxdrv: Found 12 processor cores/threads
[    1.885839] systemd[1]: Starting Create Static Device Nodes in /dev gracefully...
[    1.885946] systemd[1]: Started Journal Service.
[    1.901872] vboxdrv: TSC mode is Invariant, tentative frequency 2495999617 Hz
[    1.901874] vboxdrv: Successfully loaded version 7.2.4 r170995 (interface 0x00340001)
[    1.905606] VBoxNetAdp: Successfully started.
[    1.907633] VBoxNetFlt: Successfully started.
[    1.986774] nvidia-nvlink: Nvlink Core is being initialized, major device number 239

[    1.990528] nvidia 0000:01:00.0: enabling device (0000 -> 0003)
[    1.990721] nvidia 0000:01:00.0: vgaarb: VGA decodes changed: olddecodes=io+mem,decodes=none:owns=none
[    2.034756] NVRM: loading NVIDIA UNIX Open Kernel Module for x86_64  590.48.01  Release Build  (root@REDACTED)  
[    2.061644] usb 1-4: device descriptor read/64, error -71
[    2.074130] nvidia-modeset: Loading NVIDIA UNIX Open Kernel Mode Setting Driver for x86_64  590.48.01  Release Build  (root@REDACTED)  
[    2.118052] [drm] [nvidia-drm] [GPU ID 0x00000100] Loading driver
[    2.120799] intel-lpss 0000:00:15.0: enabling device (0004 -> 0006)
[    2.132556] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    2.133841] Key type psk registered
[    2.187386] ACPI Warning: \_SB.NPCF._DSM: Argument #4 type mismatch - Found [Buffer], ACPI requires [Package] (20250807/nsarguments-61)
[    2.187428] ACPI Warning: \_SB.PC00.PEG1.PEGP._DSM: Argument #4 type mismatch - Found [Buffer], ACPI requires [Package] (20250807/nsarguments-61)
[    2.187617] NVRM: GPU0 testIfDsmSubFunctionEnabled: GPS ACPI DSM called before _acpiDsmSupportedFuncCacheInit subfunction = 11.
[    2.187740] NVRM: GPU0 _acpiDsmCapsInit: SBIOS suggested NBCI supports function 1, but the call failed!
[    2.216801] input: ELAN0307:00 04F3:3282 Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-ELAN0307:00/0018:04F3:3282.0001/input/input4
[    2.216907] input: ELAN0307:00 04F3:3282 Touchpad as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-ELAN0307:00/0018:04F3:3282.0001/input/input6
[    2.216949] hid-generic 0018:04F3:3282.0001: input,hidraw0: I2C HID v1.00 Mouse [ELAN0307:00 04F3:3282] on i2c-ELAN0307:00
[    2.220151] nvme 0000:03:00.0: platform quirk: setting simple suspend
[    2.220200] nvme nvme0: pci function 0000:03:00.0
[    2.254669] input: ELAN0307:00 04F3:3282 Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-ELAN0307:00/0018:04F3:3282.0001/input/input7
[    2.254744] input: ELAN0307:00 04F3:3282 Touchpad as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-ELAN0307:00/0018:04F3:3282.0001/input/input9
[    2.254814] hid-multitouch 0018:04F3:3282.0001: input,hidraw0: I2C HID v1.00 Mouse [ELAN0307:00 04F3:3282] on i2c-ELAN0307:00
[    2.258866] nvme nvme0: allocated 64 MiB host memory buffer (16 segments).
[    2.277726] nvme nvme0: 12/0/0 default/read/poll queues
[    2.277729] usb 1-4: new full-speed USB device number 3 using xhci_hcd
[    2.285732]  nvme0n1: p1 p2 p3
[    2.336057] PM: Image not found (code -22)
[    2.405384] usb 1-4: New USB device found, idVendor=3938, idProduct=1289, bcdDevice= 1.04
[    2.405403] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.405405] usb 1-4: Product: onn.Wireless Gaming Mouse
[    2.405406] usb 1-4: Manufacturer: Telink
[    2.407923] input: Telink onn.Wireless Gaming Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:3938:1289.0002/input/input10
[    2.408041] hid-generic 0003:3938:1289.0002: input,hidraw1: USB HID v1.11 Mouse [Telink onn.Wireless Gaming Mouse] on usb-0000:00:14.0-4/input0
[    2.410802] input: Telink onn.Wireless Gaming Mouse Keyboard as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.1/0003:3938:1289.0003/input/input11
[    2.461819] input: Telink onn.Wireless Gaming Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.1/0003:3938:1289.0003/input/input12
[    2.461925] input: Telink onn.Wireless Gaming Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.1/0003:3938:1289.0003/input/input13
[    2.462069] hid-generic 0003:3938:1289.0003: input,hiddev96,hidraw2: USB HID v1.11 Keyboard [Telink onn.Wireless Gaming Mouse] on usb-0000:00:14.0-4/input1
[    2.573721] usb 1-5: new full-speed USB device number 4 using xhci_hcd
[    2.685860] usb 1-5: device descriptor read/64, error -71
[    2.902795] usb 1-5: device descriptor read/64, error -71
[    3.117707] usb 1-5: new full-speed USB device number 5 using xhci_hcd
[    3.229859] usb 1-5: device descriptor read/64, error -71
[    3.445857] usb 1-5: device descriptor read/64, error -71
[    3.549908] usb usb1-port5: attempt power cycle
[    3.626950] NVRM: testIfDsmSubFunctionEnabled: GPS ACPI DSM called before _acpiDsmSupportedFuncCacheInit subfunction = 11.
[    3.831071] [drm] Initialized nvidia-drm 0.0.0 for 0000:01:00.0 on minor 1
[    3.895662] nvidia 0000:01:00.0: [drm] Cannot find any crtc or sizes
[    3.929647] usb 1-5: new full-speed USB device number 6 using xhci_hcd
[    3.929792] usb 1-5: Device not responding to setup address.
[    4.134169] usb 1-5: Device not responding to setup address.
[    4.341775] usb 1-5: device not accepting address 6, error -71
[    4.342018] usb 1-5: WARN: invalid context state for evaluate context command.
[    4.453759] usb 1-5: new full-speed USB device number 7 using xhci_hcd
[    4.454102] usb 1-5: Device not responding to setup address.
[    4.662134] usb 1-5: Device not responding to setup address.
[    4.869828] usb 1-5: device not accepting address 7, error -71
[    4.870084] usb 1-5: WARN: invalid context state for evaluate context command.
[    4.870290] usb usb1-port5: unable to enumerate USB device
[    4.982778] usb 1-6: new high-speed USB device number 8 using xhci_hcd
[    5.118928] usb 1-6: New USB device found, idVendor=5986, idProduct=211b, bcdDevice= 3.01
[    5.118958] usb 1-6: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    5.118969] usb 1-6: Product: HD Webcam
[    5.118977] usb 1-6: Manufacturer: SunplusIT Inc
[    5.238830] usb 1-10: new full-speed USB device number 9 using xhci_hcd
[    5.365399] usb 1-10: New USB device found, idVendor=8087, idProduct=0026, bcdDevice= 0.02
[    5.365430] usb 1-10: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    5.604893] BTRFS: device fsid 24ab3d31-5e91-45d9-9a60-184512a8aef2 devid 1 transid 254221 /dev/nvme0n1p2 (259:2) scanned by mount (452)
[    5.605422] BTRFS info (device nvme0n1p2): first mount of filesystem 24ab3d31-5e91-45d9-9a60-184512a8aef2
[    5.605448] BTRFS info (device nvme0n1p2): using crc32c (crc32c-lib) checksum algorithm
[    5.664515] BTRFS info (device nvme0n1p2): enabling ssd optimizations
[    5.664531] BTRFS info (device nvme0n1p2): turning on async discard
[    5.664537] BTRFS info (device nvme0n1p2): enabling free space tree
[    6.301496] systemd-journald[228]: Received SIGTERM from PID 1 (systemd).
[    6.375789] systemd[1]: systemd 259-1-arch running in system mode (+PAM +AUDIT -SELINUX +APPARMOR -IMA +IPE +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +UTMP -SYSVINIT +LIBARCHIVE)
[    6.375801] systemd[1]: Detected architecture x86-64.
[    6.537897] systemd[1]: bpf-restrict-fs: LSM BPF program attached
[    6.790546] zram: Added device: zram0
[    6.839349] systemd[1]: /usr/lib/systemd/system/ananicy-cpp.service:16: Support for option CPUAccounting= has been removed and it is ignored
[    6.916834] systemd[1]: initrd-switch-root.service: Deactivated successfully.
[    6.916960] systemd[1]: Stopped Switch Root.
[    6.917668] systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 1.
[    6.917935] systemd[1]: Created slice Virtual Machine and Container Slice.
[    6.918266] systemd[1]: Created slice Slice /system/dirmngr.
[    6.918535] systemd[1]: Created slice Slice /system/getty.
[    6.918786] systemd[1]: Created slice Slice /system/gpg-agent.
[    6.919019] systemd[1]: Created slice Slice /system/gpg-agent-browser.
[    6.919265] systemd[1]: Created slice Slice /system/gpg-agent-extra.
[    6.919480] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
[    6.919689] systemd[1]: Created slice Slice /system/keyboxd.
[    6.919892] systemd[1]: Created slice Slice /system/systemd-fsck.
[    6.920097] systemd[1]: Created slice Slice /system/systemd-zram-setup.
[    6.920220] systemd[1]: Created slice User and Session Slice.
[    6.920252] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    6.920269] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    6.920359] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    6.920365] systemd[1]: Expecting device /dev/disk/by-uuid/24ab3d31-REDACTED...
[    6.920368] systemd[1]: Expecting device /dev/disk/by-uuid/REDACTED...
[    6.920371] systemd[1]: Expecting device /dev/disk/by-uuid/REDACTED...
[    6.920376] systemd[1]: Expecting device /dev/zram0...
[    6.920383] systemd[1]: Reached target Local Encrypted Volumes.
[    6.920391] systemd[1]: Reached target Login Prompts.
[    6.920397] systemd[1]: Reached target Image Downloads.
[    6.920405] systemd[1]: Stopped target Switch Root.
[    6.920413] systemd[1]: Stopped target Initrd File Systems.
[    6.920419] systemd[1]: Stopped target Initrd Root File System.
[    6.920427] systemd[1]: Reached target Local Integrity Protected Volumes.
[    6.920444] systemd[1]: Reached target Remote File Systems.
[    6.920451] systemd[1]: Reached target Slice Units.
[    6.920458] systemd[1]: Reached target Mounting snaps.
[    6.920472] systemd[1]: Reached target Local Verity Protected Volumes.
[    6.920509] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    6.920558] systemd[1]: Listening on LVM2 poll daemon socket.
[    6.921013] systemd[1]: Listening on Query the User Interactively for a Password.
[    6.921527] systemd[1]: Listening on Process Core Dump Socket.
[    6.921819] systemd[1]: Listening on Credential Encryption/Decryption.
[    6.922219] systemd[1]: Listening on Factory Reset Management.
[    6.922671] systemd[1]: Listening on Console Output Muting Service Socket.
[    6.922719] systemd[1]: Listening on Userspace Out-Of-Memory (OOM) Killer Socket.
[    6.923064] systemd[1]: TPM PCR Measurements was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    6.923073] systemd[1]: Make TPM PCR Policy was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    6.923383] systemd[1]: Listening on Disk Repartitioning Service Socket.
[    6.923411] systemd[1]: Listening on udev Control Socket.
[    6.923435] systemd[1]: Listening on udev Varlink Socket.
[    6.923459] systemd[1]: Listening on User Database Manager Socket.
[    6.924460] systemd[1]: Mounting Huge Pages File System...
[    6.924850] systemd[1]: Mounting POSIX Message Queue File System...
[    6.925333] systemd[1]: Mounting Kernel Debug File System...
[    6.925752] systemd[1]: Mounting Kernel Trace File System...
[    6.926608] systemd[1]: Starting Create List of Static Device Nodes...
[    6.927968] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[    6.928005] systemd[1]: Load Kernel Module configfs was skipped because of an unmet condition check (ConditionKernelModuleLoaded=!configfs).
[    6.928042] systemd[1]: Load Kernel Module drm was skipped because of an unmet condition check (ConditionKernelModuleLoaded=!drm).
[    6.928070] systemd[1]: Load Kernel Module fuse was skipped because of an unmet condition check (ConditionKernelModuleLoaded=!fuse).
[    6.929096] systemd[1]: Mounting FUSE Control File System...
[    6.929192] systemd[1]: systemd-fsck-root.service: Deactivated successfully.
[    6.929235] systemd[1]: Stopped File System Check on Root Device.
[    6.929441] systemd[1]: Clear Stale Hibernate Storage Info was skipped because of an unmet condition check (ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-REDACTED).
[    6.930635] systemd[1]: Starting Journal Service...
[    6.931317] systemd[1]: Starting Load Kernel Modules...
[    6.931341] systemd[1]: TPM PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    6.931369] systemd[1]: TPM NvPCR Product ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    6.932624] systemd[1]: Starting Remount Root and Kernel File Systems...
[    6.932671] systemd[1]: Early TPM SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    6.933258] systemd[1]: Starting Load udev Rules from Credentials...
[    6.934485] systemd[1]: Starting Coldplug All udev Devices...
[    6.937767] systemd[1]: Mounted Huge Pages File System.
[    6.937840] systemd[1]: Mounted POSIX Message Queue File System.
[    6.937885] systemd[1]: Mounted Kernel Debug File System.
[    6.937925] systemd[1]: Mounted Kernel Trace File System.
[    6.938092] systemd[1]: Finished Create List of Static Device Nodes.
[    6.938161] systemd[1]: Mounted FUSE Control File System.
[    6.938824] systemd[1]: Starting Create Static Device Nodes in /dev gracefully...
[    6.960232] systemd-journald[692]: Collecting audit messages is disabled.
[    6.961009] systemd[1]: Finished Load udev Rules from Credentials.
[    6.961531] systemd[1]: Started Journal Service.
[    7.004388] BTRFS info (device nvme0n1p2 state M): use zstd compression, level 3
[    7.015599] device-mapper: uevent: version 1.0.3
[    7.015650] device-mapper: ioctl: 4.50.0-ioctl (2025-04-28) initialised: dm-devel@lists.linux.dev
[    7.169375] zram0: detected capacity change from 0 to 65110016
[    7.242764] mousedev: PS/2 mouse device common for all mice
[    7.281897] Adding 35817692k swap on /dev/nvme0n1p3.  Priority:-2 extents:1 across:35817692k SS
[    7.290266] input: Intel HID events as /devices/platform/INTC1070:00/input/input14
[    7.291040] intel-hid INTC1070:00: platform supports 5 button array
[    7.291086] input: Intel HID 5 button array as /devices/platform/INTC1070:00/input/input15
[    7.348283] intel_pmc_core INT33A1:00:  initialized
[    7.406071] Adding 32555004k swap on /dev/zram0.  Priority:100 extents:1 across:32555004k SSDsc
[    7.412635] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    7.412668] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    7.416728] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    7.421102] Loaded X.509 cert 'sforshee: REDACTED'
[    7.421168] i2c i2c-3: Successfully instantiated SPD at 0x50
[    7.421211] Loaded X.509 cert 'wens: REDACTED'
[    7.427363] input: MSI WMI hotkeys as /devices/virtual/input/input16
[    7.446923] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
[    7.446926] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    7.446927] RAPL PMU: hw unit of domain package 2^-14 Joules
[    7.446927] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    7.446928] RAPL PMU: hw unit of domain psys 2^-14 Joules
[    7.457096] iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
[    7.460181] ACPI Warning: \_SB.PC00.CNVW._DSM: Argument #4 type mismatch - Found [Buffer], ACPI requires [Package] (20250807/nsarguments-61)
[    7.460722] iwlwifi 0000:00:14.3: Detected crf-id 0x1300504, cnv-id 0x80400 wfpm id 0x80000030
[    7.460764] iwlwifi 0000:00:14.3: PCI dev 51f0/0074, rev=0x370, rfid=0x10a100
[    7.460767] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX201 160MHz
[    7.462868] mc: Linux media interface: v0.10
[    7.468387] iwlwifi 0000:00:14.3: loaded firmware version 89.7207fc64.0 so-a0-hr-b0-89.ucode op_mode iwlmvm
[    7.488673] Bluetooth: Core ver 2.22
[    7.488688] NET: Registered PF_BLUETOOTH protocol family
[    7.488689] Bluetooth: HCI device and connection manager initialized
[    7.488692] Bluetooth: HCI socket layer initialized
[    7.488694] Bluetooth: L2CAP socket layer initialized
[    7.488696] Bluetooth: SCO socket layer initialized
[    7.493729] videodev: Linux video capture interface: v2.00
[    7.499353] r8169 0000:05:00.0: can't disable ASPM; OS doesn't have ASPM control
[    7.503752] pps_core: LinuxPPS API ver. 1 registered
[    7.503755] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    7.509014] msi_ec: Firmware version is not supported: '15K1IMS1.104'
[    7.509836] input: gpio-keys as /devices/platform/ACPI0011:00/gpio-keys.1.auto/input/input17
[    7.516293] PTP clock support registered
[    7.518854] r8169 0000:05:00.0 eth0: RTL8168h/8111h, 04:7c:16:3d:39:ed, XID 541, IRQ 163
[    7.518860] r8169 0000:05:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
[    7.565956] r8169 0000:05:00.0 enp5s0: renamed from eth0
[    7.815606] i915 0000:00:02.0: [drm] Found alderlake_p (device ID 46a3) integrated display version 13.00 stepping D0
[    7.818057] intel_rapl_msr: PL4 support detected.
[    7.818204] intel_rapl_common: Found RAPL domain package
[    7.818207] intel_rapl_common: Found RAPL domain core
[    7.818207] iTCO_vendor_support: vendor-support=0
[    7.818208] intel_rapl_common: Found RAPL domain uncore
[    7.818210] intel_rapl_common: Found RAPL domain psys
[    7.822228] spd5118 3-0050: DDR5 temperature sensor: vendor 0x06:0x32 revision 1.6
[    7.822985] proc_thermal_pci 0000:00:04.0: enabling device (0000 -> 0002)
[    7.823135] intel_rapl_common: Found RAPL domain package
[    7.823521] intel_tcc_cooling: TCC Offset locked
[    7.826088] spi-nor spi0.0: supply vcc not found, using dummy regulator
[    7.828584] Creating 1 MTD partitions on "0000:00:1f.5":
[    7.828624] 0x000000000000-0x000002000000 : "BIOS"
[    7.829691] spd5118 3-0052: DDR5 temperature sensor: vendor 0x06:0x32 revision 1.6
[    7.832093] iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=6, TCOBASE=0x0400)
[    7.832160] iTCO_wdt iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    7.832532] usbcore: registered new interface driver btusb
[    7.833160] uvcvideo 1-6:1.0: Found UVC 1.00 device HD Webcam (5986:211b)
[    7.834611] Bluetooth: hci0: Device revision is 2
[    7.834614] Bluetooth: hci0: Secure boot is enabled
[    7.834615] Bluetooth: hci0: OTP lock is enabled
[    7.834616] Bluetooth: hci0: API lock is enabled
[    7.834617] Bluetooth: hci0: Debug lock is disabled
[    7.834618] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[    7.834619] Bluetooth: hci0: Bootloader timestamp 2019.40 buildtype 1 build 38
[    7.834661] ACPI Warning: \_SB.PC00.XHCI.RHUB.HS10._DSM: Argument #4 type mismatch - Found [Integer], ACPI requires [Package] (20250807/nsarguments-61)
[    7.834680] Bluetooth: hci0: DSM reset method type: 0x00
[    7.835867] i915 0000:00:02.0: vgaarb: deactivate vga console
[    7.835931] i915 0000:00:02.0: [drm] Using Transparent Hugepages
[    7.836487] i915 0000:00:02.0: vgaarb: VGA decodes changed: olddecodes=io+mem,decodes=none:owns=io+mem
[    7.838448] Bluetooth: hci0: Found device firmware: intel/ibt-0040-4150.sfi
[    7.838462] Bluetooth: hci0: Boot Address: 0x100800
[    7.838464] Bluetooth: hci0: Firmware Version: 133-20.25
[    7.839412] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/adlp_dmc.bin (v2.20)
[    7.841598] snd_hda_intel 0000:00:1f.3: Digital mics found on Skylake+ platform, using SOF driver
[    7.841646] snd_hda_intel 0000:01:00.1: enabling device (0000 -> 0002)
[    7.841738] snd_hda_intel 0000:01:00.1: Disabling MSI
[    7.841743] snd_hda_intel 0000:01:00.1: Handle vga_switcheroo audio client
[    7.853760] i915 0000:00:02.0: [drm] GT0: GuC firmware i915/adlp_guc_70.bin version 70.49.4
[    7.853765] i915 0000:00:02.0: [drm] GT0: HuC firmware i915/tgl_huc.bin version 7.9.3
[    7.854446] usbcore: registered new interface driver uvcvideo
[    7.866007] input: HDA NVidia HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card0/input18
[    7.866042] input: HDA NVidia HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card0/input19
[    7.866064] input: HDA NVidia HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card0/input20
[    7.866087] input: HDA NVidia HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card0/input21
[    7.872233] i915 0000:00:02.0: [drm] GT0: HuC: authenticated for all workloads
[    7.872642] i915 0000:00:02.0: [drm] GT0: GUC: submission enabled
[    7.872645] i915 0000:00:02.0: [drm] GT0: GUC: SLPC enabled
[    7.873014] i915 0000:00:02.0: [drm] GT0: GUC: RC enabled
[    7.873778] i915 0000:00:02.0: [drm] Protected Xe Path (PXP) protected content support initialized
[    7.881280] i915 0000:00:02.0: [drm] Registered 4 planes with drm panic
[    7.881283] [drm] Initialized i915 1.6.0 for 0000:00:02.0 on minor 2
[    7.881531] ACPI: video: Video Device [PEGP] (multi-head: no  rom: yes  post: no)
[    7.881567] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:00/LNXVIDEO:00/input/input22
[    7.882999] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    7.883448] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:01/input/input23
[    7.894007] fbcon: i915drmfb (fb0) is primary device
[    7.894009] fbcon: Deferring console take-over
[    7.894011] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[    7.936994] loop: module loaded
[    7.937446] loop0: detected capacity change from 0 to 168088
[    7.937449] loop2: detected capacity change from 0 to 8
[    7.937499] loop1: detected capacity change from 0 to 187776
[    7.938282] loop3: detected capacity change from 0 to 113624
[    7.938749] loop4: detected capacity change from 0 to 100952
[    7.939530] sof-audio-pci-intel-tgl 0000:00:1f.3: enabling device (0000 -> 0002)
[    7.939766] sof-audio-pci-intel-tgl 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if 0x040100
[    7.939823] sof-audio-pci-intel-tgl 0000:00:1f.3: bound 0000:00:02.0 (ops intel_audio_component_bind_ops [i915])
[    7.943051] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    7.946372] sof-audio-pci-intel-tgl 0000:00:1f.3: use msi interrupt mode
[    7.962922] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x20
[    7.962971] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[    7.962979] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
[    7.962988] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x10
[    7.963038] iwlwifi 0000:00:14.3: Detected RF HR B5, rfid=0x10a100
[    7.964269] iwlwifi 0000:00:14.3: RFIm is deactivated, reason = 4
[    8.027020] systemd-journald[692]: Received client request to flush runtime journal.
[    8.029281] iwlwifi 0000:00:14.3: base HW address: 70:d8:23:79:e2:80
[    8.150630] iwlwifi 0000:00:14.3 wlo1: renamed from wlan0
[    8.176250] sof-audio-pci-intel-tgl 0000:00:1f.3: hda codecs found, mask 5
[    8.176254] sof-audio-pci-intel-tgl 0000:00:1f.3: using HDA machine driver skl_hda_dsp_generic now
[    8.176255] sof-audio-pci-intel-tgl 0000:00:1f.3: NHLT device BT(0) detected, ssp_mask 0x4
[    8.176256] sof-audio-pci-intel-tgl 0000:00:1f.3: BT link detected in NHLT tables: 0x4
[    8.176258] sof-audio-pci-intel-tgl 0000:00:1f.3: DMICs detected in NHLT tables: 2
[    8.179633] sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware paths/files for ipc type 0:
[    8.179637] sof-audio-pci-intel-tgl 0000:00:1f.3:  Firmware file:     intel/sof/sof-adl.ri
[    8.179639] sof-audio-pci-intel-tgl 0000:00:1f.3:  Topology file:     intel/sof-tplg/sof-hda-generic-2ch.tplg
[    8.180007] sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware info: version 2:2:0-57864
[    8.180009] sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware: ABI 3:22:1 Kernel ABI 3:23:1
[    8.290738] sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware info: version 2:2:0-57864
[    8.290741] sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware: ABI 3:22:1 Kernel ABI 3:23:1
[    8.308623] sof-audio-pci-intel-tgl 0000:00:1f.3: Topology: ABI 3:22:1 Kernel ABI 3:23:1
[    8.308796] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: Parent card not yet available, widget card binding deferred
[    8.330745] snd_hda_codec_alc269 ehdaudio0D0: autoconfig for ALC256: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[    8.330748] snd_hda_codec_alc269 ehdaudio0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    8.330749] snd_hda_codec_alc269 ehdaudio0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
[    8.330750] snd_hda_codec_alc269 ehdaudio0D0:    mono: mono_out=0x0
[    8.330750] snd_hda_codec_alc269 ehdaudio0D0:    inputs:
[    8.330751] snd_hda_codec_alc269 ehdaudio0D0:      Mic=0x19
[    8.368256] skl_hda_dsp_generic skl_hda_dsp_generic: hda_dsp_hdmi_build_controls: no PCM in topology for HDMI converter 3
[    8.384748] input: sof-hda-dsp Mic as /devices/pci0000:00/0000:00:1f.3/skl_hda_dsp_generic/sound/card1/input24
[    8.384774] input: sof-hda-dsp Headphone as /devices/pci0000:00/0000:00:1f.3/skl_hda_dsp_generic/sound/card1/input25
[    8.384797] input: sof-hda-dsp HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/skl_hda_dsp_generic/sound/card1/input26
[    8.384818] input: sof-hda-dsp HDMI/DP,pcm=4 as /devices/pci0000:00/0000:00:1f.3/skl_hda_dsp_generic/sound/card1/input27
[    8.384847] input: sof-hda-dsp HDMI/DP,pcm=5 as /devices/pci0000:00/0000:00:1f.3/skl_hda_dsp_generic/sound/card1/input28
[    9.059762] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    9.059765] Bluetooth: BNEP filters: protocol multicast
[    9.059768] Bluetooth: BNEP socket layer initialized
[    9.185615] Generic FE-GE Realtek PHY r8169-0-500:00: attached PHY driver (mii_bus:phy_addr=r8169-0-500:00, irq=MAC)
[    9.194933] Bluetooth: hci0: Waiting for firmware download to complete
[    9.195571] Bluetooth: hci0: Firmware loaded in 1325311 usecs
[    9.195651] Bluetooth: hci0: Waiting for device to boot
[    9.204790] NET: Registered PF_QIPCRTR protocol family
[    9.210570] Bluetooth: hci0: Device booted in 14583 usecs
[    9.212730] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-0040-4150.ddc
[    9.214566] Bluetooth: hci0: Applying Intel DDC parameters completed
[    9.217594] Bluetooth: hci0: Firmware timestamp 2025.20 buildtype 1 build 82053
[    9.217597] Bluetooth: hci0: Firmware SHA1: 0x937bca4a
[    9.221571] Bluetooth: hci0: Fseq status: Success (0x00)
[    9.221574] Bluetooth: hci0: Fseq executed: 00.00.02.41
[    9.221575] Bluetooth: hci0: Fseq BT Top: 00.00.02.41
[    9.290809] Bluetooth: MGMT ver 1.23
[    9.295069] NET: Registered PF_ALG protocol family
[    9.331766] r8169 0000:05:00.0 enp5s0: Link is Down
[    9.442633] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x20
[    9.442680] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[    9.442689] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
[    9.442697] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x10
[    9.443944] iwlwifi 0000:00:14.3: RFIm is deactivated, reason = 4
[    9.644022] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x20
[    9.644069] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[    9.644077] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
[    9.644085] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x10
[    9.645337] iwlwifi 0000:00:14.3: RFIm is deactivated, reason = 4
[   15.756610] Initializing XFRM netlink socket
[   15.774998] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[   20.417447] nvme nvme0: using unchecked data buffer
[   20.421561] block nvme0n1: No UUID available providing old NGUID
[   22.229787] Bluetooth: RFCOMM TTY layer initialized
[   22.229796] Bluetooth: RFCOMM socket layer initialized
[   22.229798] Bluetooth: RFCOMM ver 1.11
[   22.490783] wlo1: authenticate with 38:88:71:44:c4:41 (local address=70:d8:23:79:e2:80)
[   22.491659] wlo1: send auth to 38:88:71:44:c4:41 (try 1/3)
[   22.516708] wlo1: authenticated
[   22.517634] wlo1: associate with 38:88:71:44:c4:41 (try 1/3)
[   22.520931] wlo1: RX AssocResp from 38:88:71:44:c4:41 (capab=0x1c11 status=0 aid=3)
[   22.527374] wlo1: associated
[   22.591534] wlo1: Limiting TX power to 30 (30 - 0) dBm as advertised by 38:88:71:44:c4:41
[   23.291962] warning: `kdeconnectd' uses wireless extensions which will stop working for Wi-Fi 7 hardware; use nl80211
[   32.411630] usb 1-5: new high-speed USB device number 10 using xhci_hcd
[   32.552079] usb 1-5: New USB device found, idVendor=0bda, idProduct=5411, bcdDevice= 1.47
[   32.552084] usb 1-5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   32.552085] usb 1-5: Product: USB2.1 Hub
[   32.552086] usb 1-5: Manufacturer: Generic
[   32.553309] hub 1-5:1.0: USB hub found
[   32.554749] hub 1-5:1.0: 2 ports detected
[   64.335578] wlo1: disconnect from AP 38:88:71:44:c4:41 for new auth to 38:88:71:44:c4:42
[   64.357227] wlo1: authenticate with 38:88:71:44:c4:42 (local address=70:d8:23:79:e2:80)
[   64.358159] wlo1: send auth to 38:88:71:44:c4:42 (try 1/3)
[   64.425667] wlo1: authenticated
[   64.426755] wlo1: associate with 38:88:71:44:c4:42 (try 1/3)
[   64.429854] wlo1: RX ReassocResp from 38:88:71:44:c4:42 (capab=0x1911 status=0 aid=5)
[   64.434586] wlo1: associated
[   64.468870] wlo1: Limiting TX power to 30 (30 - 0) dBm as advertised by 38:88:71:44:c4:42
[   88.922566] ACPI: bus type thunderbolt registered
[  352.239917] usb 1-5: USB disconnect, device number 10
[  355.329778] usb 1-5: new high-speed USB device number 12 using xhci_hcd
[  355.469411] usb 1-5: New USB device found, idVendor=0bda, idProduct=5411, bcdDevice= 1.47
[  355.469415] usb 1-5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[  355.469416] usb 1-5: Product: USB2.1 Hub
[  355.469417] usb 1-5: Manufacturer: Generic
[  355.470593] hub 1-5:1.0: USB hub found
[  355.471916] hub 1-5:1.0: 2 ports detected
[  462.423049] usb 1-5: USB disconnect, device number 12
[  468.239511] usb 1-5: new high-speed USB device number 13 using xhci_hcd
[  468.380425] usb 1-5: New USB device found, idVendor=0bda, idProduct=5411, bcdDevice= 1.47
[  468.380429] usb 1-5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[  468.380430] usb 1-5: Product: USB2.1 Hub
[  468.380431] usb 1-5: Manufacturer: Generic
[  468.382038] hub 1-5:1.0: USB hub found
[  468.383240] hub 1-5:1.0: 2 ports detected
[  805.478121] BTRFS info (device nvme0n1p2): scrub: started on devid 1
[ 1036.497439] BTRFS info (device nvme0n1p2): scrub: finished on devid 1 with status: 0
[ 1036.501523] BTRFS info (device nvme0n1p2): balance: start -dusage=0
[ 1036.501775] BTRFS info (device nvme0n1p2): balance: ended with status: 0
[ 1036.510155] BTRFS info (device nvme0n1p2): balance: start -dusage=5
[ 1036.510386] BTRFS info (device nvme0n1p2): balance: ended with status: 0
[ 1036.518471] BTRFS info (device nvme0n1p2): balance: start -dusage=10
[ 1036.518754] BTRFS info (device nvme0n1p2): relocating block group 468584497152 flags data
[ 1036.655958] BTRFS info (device nvme0n1p2): found 4 extents, stage: move data extents
[ 1036.705739] BTRFS info (device nvme0n1p2): found 4 extents, stage: update data pointers
[ 1036.733033] BTRFS info (device nvme0n1p2): relocating block group 450297331712 flags data
[ 1036.849618] BTRFS info (device nvme0n1p2): found 2 extents, stage: move data extents
[ 1036.869364] BTRFS info (device nvme0n1p2): found 2 extents, stage: update data pointers
[ 1036.882616] BTRFS info (device nvme0n1p2): relocating block group 449223589888 flags data
[ 1036.963153] BTRFS info (device nvme0n1p2): found 2 extents, stage: move data extents
[ 1036.990464] BTRFS info (device nvme0n1p2): found 2 extents, stage: update data pointers
[ 1037.014751] BTRFS info (device nvme0n1p2): balance: ended with status: 0
[ 1037.033995] BTRFS info (device nvme0n1p2): balance: start -musage=0 -susage=0
[ 1037.034123] BTRFS info (device nvme0n1p2): relocating block group 669508435968 flags system|dup
[ 1037.041386] BTRFS info (device nvme0n1p2): balance: ended with status: 0
[ 1037.052410] BTRFS info (device nvme0n1p2): balance: start -musage=5 -susage=5
[ 1037.052696] BTRFS info (device nvme0n1p2): relocating block group 660884946944 flags system|dup
[ 1037.062583] BTRFS info (device nvme0n1p2): found 1 extents, stage: move data extents
[ 1037.069655] BTRFS info (device nvme0n1p2): balance: ended with status: 0

------=_Part_846594_1174211588.1767263898144
Content-Type: text/plain; charset=us-ascii; name=proc-cmdline.txt
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=proc-cmdline.txt

BOOT_IMAGE=/@/boot/vmlinuz-linux root=UUID=REDACTED rw rootflags=subvol=@
root=UUID=REDACTED rootfstype=btrfs rootflags=subvol=@ rw quiet resume=UUID=REDACTED
loglevel=3 quiet splash nvidia-drm.modeset=1

------=_Part_846594_1174211588.1767263898144
Content-Type: text/plain; charset=us-ascii; name=lsmod.txt
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=lsmod.txt

Module                  Size  Used by
ucsi_ccg               36864  0
ucsi_acpi              12288  0
typec_ucsi             77824  2 ucsi_ccg,ucsi_acpi
roles                  16384  1 typec_ucsi
typec                 114688  1 typec_ucsi
thunderbolt           577536  1 typec
udp_diag               12288  0
tcp_diag               20480  0
inet_diag              20480  2 tcp_diag,udp_diag
ccm                    20480  6
snd_seq_dummy          12288  0
snd_hrtimer            12288  1
rfcomm                102400  6
snd_seq               135168  7 snd_seq_dummy
snd_seq_device         16384  1 snd_seq
xt_conntrack           12288  1
xt_MASQUERADE          16384  1
bridge                462848  0
stp                    12288  1 bridge
llc                    16384  2 bridge,stp
xfrm_user              73728  1
xfrm_algo              16384  1 xfrm_user
xt_set                 24576  0
ip_set                 69632  1 xt_set
nft_chain_nat          12288  5
nf_nat                 61440  2 nft_chain_nat,xt_MASQUERADE
nf_conntrack          196608  3 xt_conntrack,nf_nat,xt_MASQUERADE
nf_defrag_ipv6         24576  1 nf_conntrack
nf_defrag_ipv4         12288  1 nf_conntrack
xt_addrtype            12288  4
nft_compat             24576  6
x_tables               65536  5 xt_conntrack,nft_compat,xt_addrtype,xt_set,xt_MASQUERADE
nf_tables             397312  57 nft_compat,nft_chain_nat
overlay               245760  0
uhid                   28672  4
cmac                   12288  2
algif_hash             16384  1
algif_skcipher         12288  1
af_alg                 32768  6 algif_hash,algif_skcipher
qrtr                   57344  2
bnep                   36864  2
snd_ctl_led            28672  0
snd_soc_skl_hda_dsp    16384  4
snd_soc_intel_sof_board_helpers    28672  1 snd_soc_skl_hda_dsp
snd_sof_probes         36864  0
snd_soc_intel_hda_dsp_common    16384  1 snd_soc_intel_sof_board_helpers
snd_hda_codec_intelhdmi    28672  1
snd_hda_codec_alc269   147456  1
snd_hda_scodec_component    20480  1 snd_hda_codec_alc269
snd_hda_codec_realtek_lib    61440  1 snd_hda_codec_alc269
snd_hda_codec_generic   114688  2 snd_hda_codec_realtek_lib,snd_hda_codec_alc269
snd_soc_dmic           12288  1
xe                   3956736  0
squashfs               94208  5
snd_sof_pci_intel_tgl    12288  0
vfat                   24576  1
loop                   49152  10
fat                   114688  1 vfat
snd_sof_pci_intel_cnl    20480  1 snd_sof_pci_intel_tgl
snd_sof_intel_hda_generic    40960  2 snd_sof_pci_intel_tgl,snd_sof_pci_intel_cnl
soundwire_intel        94208  1 snd_sof_intel_hda_generic
snd_sof_intel_hda_sdw_bpt    24576  1 soundwire_intel
drm_gpuvm              49152  1 xe
snd_sof_intel_hda_common   204800  4 snd_sof_intel_hda_sdw_bpt,snd_sof_intel_hda_generic,snd_sof_pci_intel_tgl,snd_sof_pci_intel_cnl
drm_gpusvm_helper      40960  1 xe
snd_soc_hdac_hda       24576  1 snd_sof_intel_hda_common
gpu_sched              69632  1 xe
snd_sof_intel_hda_mlink    36864  4 snd_sof_intel_hda_sdw_bpt,soundwire_intel,snd_sof_intel_hda_common,snd_sof_intel_hda_generic
drm_exec               12288  2 drm_gpuvm,xe
snd_sof_intel_hda      20480  2 snd_sof_intel_hda_common,snd_sof_intel_hda_generic
drm_suballoc_helper    16384  1 xe
soundwire_cadence      57344  1 soundwire_intel
snd_sof_pci            24576  3 snd_sof_intel_hda_generic,snd_sof_pci_intel_tgl,snd_sof_pci_intel_cnl
snd_sof_xtensa_dsp     16384  1 snd_sof_intel_hda_generic
snd_sof               479232  7 snd_sof_intel_hda_sdw_bpt,snd_sof_pci,snd_sof_intel_hda_common,snd_sof_intel_hda_generic,snd_sof_probes,snd_sof_intel_hda,snd_sof_pci_intel_cnl
snd_sof_utils          16384  1 snd_sof
snd_soc_acpi_intel_match   143360  4 snd_soc_intel_sof_board_helpers,snd_sof_intel_hda_generic,snd_sof_pci_intel_tgl,snd_sof_pci_intel_cnl
snd_soc_acpi_intel_sdca_quirks    12288  1 snd_soc_acpi_intel_match
soundwire_generic_allocation    20480  1 soundwire_intel
snd_soc_acpi           16384  2 snd_soc_acpi_intel_match,snd_sof_intel_hda_generic
soundwire_bus        1208320  3 soundwire_intel,soundwire_generic_allocation,soundwire_cadence
snd_soc_sdca           98304  2 snd_soc_acpi_intel_sdca_quirks,soundwire_bus
crc8                   12288  1 soundwire_cadence
snd_hda_codec_nvhdmi    16384  1
snd_soc_avs           262144  0
intel_uncore_frequency    12288  0
intel_uncore_frequency_common    16384  1 intel_uncore_frequency
snd_hda_codec_hdmi     61440  2 snd_hda_codec_nvhdmi,snd_hda_codec_intelhdmi
snd_soc_hda_codec      28672  1 snd_soc_avs
snd_hda_intel          69632  1
snd_hda_ext_core       36864  7 snd_sof_intel_hda_sdw_bpt,snd_soc_avs,snd_soc_hda_codec,snd_sof_intel_hda_common,snd_soc_hdac_hda,snd_sof_intel_hda_mlink,snd_sof_intel_hda
iwlmvm                708608  0
btusb                  81920  0
iTCO_wdt               16384  0
uvcvideo              176128  0
snd_hda_codec         217088  13 snd_hda_codec_generic,snd_soc_avs,snd_hda_codec_hdmi,snd_soc_hda_codec,snd_hda_intel,snd_hda_codec_nvhdmi,snd_soc_intel_hda_dsp_common,snd_hda_codec_realtek_lib,snd_soc_hdac_hda,snd_hda_codec_alc269,snd_sof_intel_hda,snd_soc_skl_hda_dsp,snd_hda_codec_intelhdmi
btmtk                  32768  1 btusb
spi_nor               172032  0
videobuf2_vmalloc      20480  1 uvcvideo
intel_pmc_bxt          16384  1 iTCO_wdt
processor_thermal_device_pci    16384  0
uvc                    12288  1 uvcvideo
mtd                   110592  3 spi_nor
iTCO_vendor_support    12288  1 iTCO_wdt
spd5118                16384  0
intel_rapl_msr         20480  0
mac80211             1683456  1 iwlmvm
videobuf2_memops       16384  1 videobuf2_vmalloc
processor_thermal_device    20480  1 processor_thermal_device_pci
btrtl                  32768  1 btusb
x86_pkg_temp_thermal    16384  0
snd_hda_core          147456  14 snd_hda_codec_generic,snd_soc_avs,snd_hda_codec_hdmi,snd_soc_hda_codec,snd_hda_intel,snd_hda_ext_core,snd_hda_codec,snd_soc_intel_hda_dsp_common,snd_sof_intel_hda_common,snd_hda_codec_realtek_lib,snd_soc_hdac_hda,snd_hda_codec_alc269,snd_sof_intel_hda,snd_hda_codec_intelhdmi
snd_soc_core          430080  11 snd_soc_avs,snd_soc_hda_codec,soundwire_intel,snd_sof,snd_soc_intel_sof_board_helpers,snd_soc_sdca,snd_sof_intel_hda_common,snd_soc_hdac_hda,snd_sof_probes,snd_soc_dmic,snd_soc_skl_hda_dsp
processor_thermal_wt_hint    12288  2 processor_thermal_device_pci,processor_thermal_device
videobuf2_v4l2         40960  1 uvcvideo
snd_intel_dspcfg       45056  5 snd_soc_avs,snd_hda_intel,snd_sof,snd_sof_intel_hda_common,snd_sof_intel_hda_generic
ptp                    53248  1 iwlmvm
btbcm                  24576  1 btusb
intel_powerclamp       20480  0
snd_compress           32768  3 snd_soc_avs,snd_soc_core,snd_sof_probes
platform_temperature_control    16384  1 processor_thermal_device
gpio_keys              24576  0
i915                 4829184  90
ac97_bus               12288  1 snd_soc_core
videobuf2_common       94208  4 videobuf2_vmalloc,videobuf2_v4l2,uvcvideo,videobuf2_memops
btintel                73728  1 btusb
snd_intel_sdw_acpi     16384  2 snd_intel_dspcfg,snd_sof_intel_hda_generic
r8169                 143360  0
pps_core               32768  1 ptp
libarc4                12288  1 mac80211
snd_hwdep              24576  1 snd_hda_codec
snd_pcm_dmaengine      20480  1 snd_soc_core
processor_thermal_soc_slider    16384  1 processor_thermal_device
videodev              397312  2 videobuf2_v4l2,uvcvideo
platform_profile       20480  1 processor_thermal_soc_slider
bluetooth            1118208  34 btrtl,btmtk,btintel,btbcm,bnep,btusb,rfcomm
coretemp               20480  0
realtek                57344  1
snd_pcm               212992  14 snd_soc_avs,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,soundwire_intel,snd_sof,snd_soc_sdca,snd_sof_intel_hda_common,snd_compress,snd_sof_intel_hda_generic,snd_soc_core,snd_sof_utils,snd_hda_core,snd_pcm_dmaengine
processor_thermal_rfim    28672  1 processor_thermal_device
mc                     90112  4 videodev,videobuf2_v4l2,uvcvideo,videobuf2_common
drm_buddy              28672  2 xe,i915
rapl                   20480  0
mdio_devres            12288  1 r8169
processor_thermal_rapl    16384  1 processor_thermal_device
iwlwifi               610304  1 iwlmvm
intel_rapl_common      53248  2 intel_rapl_msr,processor_thermal_rapl
libphy                180224  3 r8169,mdio_devres,realtek
snd_timer              57344  3 snd_seq,snd_hrtimer,snd_pcm
i2c_algo_bit           24576  2 xe,i915
intel_cstate           20480  0
msi_wmi_platform       20480  0
msi_wmi                20480  0
processor_thermal_wt_req    12288  1 processor_thermal_device
wmi_bmof               12288  0
intel_uncore          266240  0
drm_display_helper    278528  2 xe,i915
spi_intel_pci          12288  0
mdio_bus               65536  3 r8169,libphy,realtek
snd                   159744  28 snd_ctl_led,snd_hda_codec_generic,snd_seq,snd_seq_device,snd_hda_codec_hdmi,snd_hwdep,snd_hda_intel,snd_hda_codec,snd_sof,snd_soc_sdca,snd_timer,snd_hda_codec_realtek_lib,snd_compress,snd_hda_codec_alc269,snd_soc_core,snd_pcm
i2c_i801               40960  0
cfg80211             1429504  3 iwlmvm,iwlwifi,mac80211
processor_thermal_power_floor    12288  2 processor_thermal_device_pci,processor_thermal_device
spi_intel              36864  1 spi_intel_pci
cec                    94208  3 drm_display_helper,xe,i915
i2c_smbus              20480  1 i2c_i801
soundcore              16384  2 snd_ctl_led,snd
rfkill                 45056  9 iwlmvm,bluetooth,cfg80211
i2c_mux                16384  1 i2c_i801
processor_thermal_mbox    12288  4 processor_thermal_power_floor,processor_thermal_wt_req,processor_thermal_rfim,processor_thermal_wt_hint
intel_gtt              28672  1 i915
intel_pmc_core        151552  0
int3403_thermal        16384  0
pmt_telemetry          16384  1 intel_pmc_core
int340x_thermal_zone    16384  2 int3403_thermal,processor_thermal_device
pmt_discovery          16384  1 pmt_telemetry
pmt_class              20480  2 pmt_telemetry,pmt_discovery
int3400_thermal        20480  0
intel_pmc_ssram_telemetry    16384  1 intel_pmc_core
intel_hid              28672  0
acpi_thermal_rel       24576  1 int3400_thermal
intel_vsec             28672  3 intel_pmc_ssram_telemetry,pmt_telemetry,xe
sparse_keymap          12288  2 intel_hid,msi_wmi
soc_button_array       24576  0
acpi_pad              184320  0
acpi_tad               20480  0
joydev                 24576  0
mousedev               28672  0
mac_hid                12288  0
dm_mod                229376  0
nfnetlink              20480  5 nft_compat,nf_tables,ip_set
zram                   65536  1
842_decompress         16384  1 zram
842_compress           24576  1 zram
lz4hc_compress         20480  1 zram
lz4_compress           24576  1 zram
hid_multitouch         36864  0
nvme                   73728  3
nvme_core             270336  4 nvme
polyval_clmulni        12288  0
ghash_clmulni_intel    12288  0
nvme_keyring           20480  1 nvme_core
aesni_intel            98304  6
nvme_auth              32768  1 nvme_core
hkdf                   12288  1 nvme_auth
intel_lpss_pci         28672  0
i2c_hid_acpi           12288  0
intel_lpss             12288  1 intel_lpss_pci
nvidia_drm            147456  3
idma64                 20480  0
i2c_hid                45056  1 i2c_hid_acpi
intel_oc_wdt           12288  0
pinctrl_tigerlake      28672  3
serio_raw              20480  0
nvidia_uvm           2568192  4
nvidia_modeset       2121728  3 nvidia_drm
nvidia              16306176  42 nvidia_uvm,nvidia_modeset
vboxnetflt             45056  0
vboxnetadp             32768  0
drm_ttm_helper         16384  2 nvidia_drm,xe
ttm                   122880  3 drm_ttm_helper,xe,i915
video                  81920  4 msi_wmi,xe,i915,nvidia_modeset
vboxdrv               667648  2 vboxnetadp,vboxnetflt
wmi                    32768  4 video,wmi_bmof,msi_wmi,msi_wmi_platform
uinput                 24576  0
ntsync                 20480  0
i2c_dev                28672  0
crypto_user            12288  0

------=_Part_846594_1174211588.1767263898144--

