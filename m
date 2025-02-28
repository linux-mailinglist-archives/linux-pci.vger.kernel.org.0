Return-Path: <linux-pci+bounces-22641-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1ECA4993C
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 13:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A841E1739CB
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 12:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6462426B2C0;
	Fri, 28 Feb 2025 12:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsExxEsu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389DE26AABA;
	Fri, 28 Feb 2025 12:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740745695; cv=none; b=n1hQH+g0c5DJGkJpgPoBaNtFE8GqI8jB/PcxZ7lhwpa8KC1N2Nsg8H8bw2jK8Z0HsMT/6jOORZY+vyuVTub8Q6VnUqsVqV1FgcwC7epnJuaBfofvQumeN/JTOcDb558PPwsSsw/6rDGPpE34hRTWlBedp0wzJ1Jvsvi5ko3lHqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740745695; c=relaxed/simple;
	bh=fyWO759wbCtQ9b973FjnYmJ4dfQHgCnzYCc3lnyU2as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FN7fwlRnyiVCJSyhi36G1fXb3FkN4slC0UN1a9h1l34v7lkX6cNOGQjCx2epKqY7qaOnE/dl6DO36cpzEh+NDnDYYxWeEaa3l2V6EqAhuClYyGrSEVVYAx1k5nEh8UNhtJ+kqZu3RX2lHctNnqMPStBr24yh8OHHoQwDthgqXKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsExxEsu; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54954fa61c9so459143e87.1;
        Fri, 28 Feb 2025 04:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740745691; x=1741350491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRsEJJq+lHbfCru1cPu244+Pyfj0ydxDTZwyy2ELrY4=;
        b=WsExxEsulvEyiBqKNHg78fnaA+IDlEdT6toc/0VmTaUodqClrGYnpjZgQFDCTp4pIT
         TuMqyJOk2mc7jQtEmuInWeIS6YmijXFD9gkbdIZDeLSjjAsnPWDMG+yl8e8pbgDFSWCJ
         RWf1eBneVMyLZVDnF6SWWohuSLdGgWhJRWcCQUY5uU+LYc/lSVRdQ5WDDAsQlQWtlkOj
         KjSNwidwafbnLomkPiA1tBVZMneVrRP/daaloZMdvUST4LW+jiT7fjTlLfBVEEqxPPNf
         HA0YUvqp934WSH8ldDE8LRMHfYxrtYg1ILPMFnQBH6rc17aCsj4V8H1A5jf6g6lDRP6K
         sU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740745691; x=1741350491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRsEJJq+lHbfCru1cPu244+Pyfj0ydxDTZwyy2ELrY4=;
        b=opA7JAsEArW4czbIHUrhYsGSgmRHB23GsBpf+gCl5jbRl7v49q8rks0R9SvdCJ94hE
         DkiQPSEj1fxy3xueSrmqhPEc6q/b4KVq8mypvf3sRt5RUK+GgHrAnxTXB1ehYXYWbcdF
         qPtcL3K5NZTId2i/adhyofacpWHfENLXptfNMPN5M4qkKuCv1F/yYtGPnNnYtTJta3mT
         +l0ifXlRbg1jHUEuH7z6OMLDLF3cW5fPwgsK4k5xETqpkeU6jAig7i7cNH8oPIE0V0Wu
         ZYlkP7DHqHdQ32mKMsgmritsleuuxtrqSJavP9EY2rX2icJz01PK35kXNBeFa5vHYQvA
         Z5fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpw+Sgd84+tsCkjQqXXpEcVO2NJps0b1bKdhvZsDZqHXM3pZU9E1szxXPT94vnDpWtv0Rrgzph2XUE@vger.kernel.org, AJvYcCWl0WRxP0B32t4UkscDO4aflYmBuLl8JKV8Ln8Ia0s0hKlqJTrgckUIB73xnUmJ9LED2GJMSm4u4D+/M+Ay@vger.kernel.org
X-Gm-Message-State: AOJu0YyHLspB/Ro3TsNflpaK/r47kRqPKVFgELTrd7YS5chDUHPQjtEo
	KEf8FWWQuhOw9tV1P5nNbr70vp3YfyUdfbdj5gYaAQ2MLoD//KwM7swxEVYrN4afncIZwBE0zZV
	fb4FOS9iyCdRexQDMpPrmPLpAANhUN9o=
X-Gm-Gg: ASbGncu2IcoysgA++lx6giKR8Qx9b/qjEpoG67VuS9O1ykIULLZnvfcmjA2CJ04CpUL
	Zele87+2D2F5l/90n+MsDxFX6vsJi5RZLOJDcJyu0hateM5IEi2G31M6IUGm2QTLnsYnOGZBuOC
	zA/jdEQShw
X-Google-Smtp-Source: AGHT+IEOOp9hXlgVIgRg9mtyni5JG8O+61LT+FB3hGbI+Ejcr9pwZViSLTt/ouCy9mCfPDd7Kx75YZ/40onA3k6D0GM=
X-Received: by 2002:a05:6512:3b11:b0:545:8c5:44cb with SMTP id
 2adb3069b0e04-5494c320a53mr1387834e87.31.1740745690754; Fri, 28 Feb 2025
 04:28:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMciSVX3X=DxLU0tfj4rG5WPaS5BCUDcMp2MYWBitT0ecEH+ig@mail.gmail.com>
 <20250225203818.GA516645@bhelgaas> <CAMciSVUFpkuxt-8MzvsRnM9B8F0UQGjfUxBJufGVK1=m2DooNw@mail.gmail.com>
In-Reply-To: <CAMciSVUFpkuxt-8MzvsRnM9B8F0UQGjfUxBJufGVK1=m2DooNw@mail.gmail.com>
From: Naveen Kumar P <naveenkumar.parna@gmail.com>
Date: Fri, 28 Feb 2025 17:57:58 +0530
X-Gm-Features: AQ5f1Jr6SUgifiawbhkwr0F_oKKd_s8EhUUgPgWC4I3G1Ie7aZjJdpTXHN5pZbc
Message-ID: <CAMciSVUgioFq=N9bDLvKPQtvuPCYCOrMNjGtvxm7rnsCy_wcsA@mail.gmail.com>
Subject: Re: PCI: hotplug_event: PCIe PLDA Device BAR Reset
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernelnewbies <kernelnewbies@kernelnewbies.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 6:28=E2=80=AFPM Naveen Kumar P
<naveenkumar.parna@gmail.com> wrote:
>
> On Wed, Feb 26, 2025 at 2:08=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org=
> wrote:
> >
> > On Tue, Feb 25, 2025 at 06:46:02PM +0530, Naveen Kumar P wrote:
> > > On Tue, Feb 25, 2025 at 1:24=E2=80=AFAM Bjorn Helgaas <helgaas@kernel=
.org> wrote:
> > > > On Tue, Feb 25, 2025 at 12:29:00AM +0530, Naveen Kumar P wrote:
> > > > > On Mon, Feb 24, 2025 at 11:03=E2=80=AFPM Bjorn Helgaas <helgaas@k=
ernel.org> wrote:
> > > > > > On Mon, Feb 24, 2025 at 05:45:35PM +0530, Naveen Kumar P wrote:
> > > > > > > On Wed, Feb 19, 2025 at 10:36=E2=80=AFPM Bjorn Helgaas <helga=
as@kernel.org> wrote:
> > > > > > > > On Wed, Feb 19, 2025 at 05:52:47PM +0530, Naveen Kumar P wr=
ote:
> > > > > > > > > Hi all,
> > > > > > > > >
> > > > > > > > > I am writing to seek assistance with an issue we are expe=
riencing with
> > > > > > > > > a PCIe device (PLDA Device 5555) connected through PCI Ex=
press Root
> > > > > > > > > Port 1 to the host bridge.
> > > > > > > > >
> > > > > > > > > We have observed that after booting the system, the Base =
Address
> > > > > > > > > Register (BAR0) memory of this device gets reset to 0x0 a=
fter
> > > > > > > > > approximately one hour or more (the timing is inconsisten=
t). This was
> > > > > > > > > verified using the lspci output and the setpci -s 01:00.0
> > > > > > > > > BASE_ADDRESS_0 command.
> > > >
> > > > > ...
> > > > > I booted with the pcie_aspm=3Doff kernel parameter, which means t=
hat
> > > > > PCIe Active State Power Management (ASPM) is disabled. Given this
> > > > > context, should I consider removing this setting to see if it aff=
ects
> > > > > the occurrence of the Bus Check notifications and the BAR0 reset
> > > > > issue?
> > > >
> > > > Doesn't seem likely to be related.  Once configured, ASPM operates
> > > > without any software intervention.  But note that "pcie_aspm=3Doff"
> > > > means the kernel doesn't touch ASPM configuration at all, and any
> > > > configuration done by firmware remains in effect.
> > > >
> > > > You can tell whether ASPM has been enabled by firmware with "sudo
> > > > lspci -vv" before the problem occurs.
> > > >
> > > > > > > During the ACPI_NOTIFY_BUS_CHECK event, the lspci output init=
ially
> > > > > > > showed all FF's, and then the next run of the same command sh=
owed
> > > > > > > BASE_ADDRESS_0 reset to zero:
> > > > > > > $ sudo lspci -xxx -s 01:00.0 | grep "10:"
> > > > > > > 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > > > >
> > > > > > Looks like the device isn't responding at all here.  Could happ=
en if
> > > > > > the device is reset or powered down.
> > > > >
> > > > > From the kernel driver or user space tools, is it possible to
> > > > > determine whether the device has been reset or powered down?  Are
> > > > > there any power management settings or configurations that could =
be
> > > > > causing the device to reset or power down unexpectedly?
> > > >
> > > > Not really.  By "powered down", I meant D3cold, where the main powe=
r
> > > > is removed.  Config space is readable in all other power states.
> > > >
> > > > > > What is this device?  What driver is bound to it?  I don't see
> > > > > > anything in dmesg that identifies a driver.
> > > > >
> > > > > The PCIe device in question is a Xilinx FPGA endpoint, which is
> > > > > flashed with RTL code to expose several host interfaces to the sy=
stem
> > > > > via the PCIe link.
> > > > >
> > > > > We have an out-of-tree driver for this device, but to eliminate t=
he
> > > > > driver's role in this issue, I renamed the driver to prevent it f=
rom
> > > > > loading automatically after rebooting the machine. Despite not us=
ing
> > > > > the driver, the issue still occurred.
> > > >
> > > > Oh, right, I forgot that you mentioned this before.
> > > >
> > > > > > You're seeing the problem on v5.4 (Nov 2019), which is much new=
er than
> > > > > > v4.4 (Jan 2016).  But v5.4 is still really too old to spend a l=
ot of
> > > > > > time on unless the problem still happens on a current kernel.
> > > >
> > > > This part is important.  We don't want to spend a lot of time
> > > > debugging an issue that may have already been fixed upstream.
> > >
> > > Sure, I started building the 6.13 kernel and will post more
> > > information if I notice the issue on the 6.13 kernel.
> I have downloaded the 6.13 kernel source and added additional debug
> logs in hotplug_event(), then built the kernel. After that rebooted
> with the new kernel using the following parameters:
> BOOT_IMAGE=3D/vmlinuz-6.13.0+ root=3D/dev/mapper/vg00-rootvol ro quiet
> libata.force=3Dnoncq pci=3Dnomsi pcie_aspm=3Doff pcie_ports=3Don "dyndbg=
=3Dfile
> drivers/pci/* +p; file drivers/acpi/* +p"
>
> After some time post-boot, I ran the following commands without
> initially checking the dmesg log:
> $sudo lspci -xxx -s 01:00.0 | grep "10:"
> 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>
> $sudo lspci -xxx -s 01:00.0 | grep "10:"
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
> The first run of lspci showed all FF's, and the next run showed
> BASE_ADDRESS_0 reset to zero. After observing this, I checked the
> dmesg log and found the following information:
>
> [ 2434.267810] ACPI: GPE event 0x01
> [ 2434.374249] ACPI: \_SB_.PCI0.RP01: ACPI: ACPI_NOTIFY_BUS_CHECK event
> [ 2434.374375] ACPI: \_SB_.PCI0.RP01: ACPI: OSL: Scheduling hotplug
> event 0 for deferred handling
> [ 2434.376001] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bridge acquired in
> hotplug_event()
> [ 2434.376125] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bus check in hotplug_=
event()
> [ 2434.376268] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Checking bridge in
> hotplug_event()
> [ 2434.376615] ACPI: \_SB_.PCI0.RP01.PXSX: ACPI: utils: Evaluate
> [_STA]: AE_NOT_FOUND
> [ 2434.377652] ACPI: \_SB_.PCI0.RP01.PXSX._ADR: ACPI: No context!
> [ 2434.379715] ACPI: \_SB_.PCI0.RP01.PXSX._PRW: ACPI: No context!
> [ 2434.383699] ACPI: \_SB_.PCI0.RP01.PXSX: ACPI: utils: Evaluate
> [_STA]: AE_NOT_FOUND
> [ 2434.383723] ACPI: Device [PXSX] status [0000000f]
> [ 2434.386059] ACPI: \_SB_.PCI0.RP01.D015._ADR: ACPI: No context!
> [ 2434.388332] ACPI: \_SB_.PCI0.RP01.D015: ACPI: utils: Evaluate
> [_STA]: AE_NOT_FOUND
> [ 2434.388354] ACPI: Device [D015] status [0000000f]
> [ 2434.388857] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Releasing bridge
> in hotplug_event()
> [ 2434.592773] ACPI: \_SB_.PCI0.SBRG.ADP1: ACPI: utils: Return value [1]
> [ 2450.241979] ACPI: \_SB_.PCI0.SBRG.ADP1: ACPI: utils: Return value [1]
> [ 2451.897846] ACPI: \_SB_.PCI0.SBRG.ADP1: ACPI: utils: Return value [1]
>
> Prior to this and afterwards, the dmesg log was flooded with "ACPI:
> _SB_.PCI0.SBRG.ADP1: ACPI: utils: Return value [1]" statements.
>
> Complete dmesg log and the patch(to get additional debug information)
> are attached to this email.
I would greatly appreciate any guidance or next steps you could
provide to help debug this issue.

>
> Any further guidance on these observations?
>
> Additionally, I noticed that the initial bootup logs with the
> "0.000000" timestamp are missing in the dmesg log with this new
> kernel. I'm unsure what might be causing this issue.
>
> > >
> > > Regarding the CommClk- (Common Clock Configuration) bit, it indicates
> > > whether the common clock configuration is enabled or disabled. When i=
t
> > > is set to CommClk-, it means that the common clock configuration is
> > > disabled.
> > >
> > > LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
> > >         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> > >
> > > For my device, I noticed that the common clock configuration is
> > > disabled. Could this be causing the BAR reset issue?
> >
> > Not to my knowledge.
> >
> > > How is the CommClk bit determined(to set or clear)? and is it okay to
> > > enable this bit after booting the kernel?
> >
> > It is somewhere in drivers/pci/pcie/aspm.c, i.e.,
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/pci/pcie/aspm.c?id=3Dv6.13#n383

