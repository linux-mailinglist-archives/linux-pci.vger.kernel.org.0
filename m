Return-Path: <linux-pci+bounces-13694-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF7698C51D
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 20:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B314E2845CD
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 18:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B461CC89D;
	Tue,  1 Oct 2024 18:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpNHcAmE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589A01CC885
	for <linux-pci@vger.kernel.org>; Tue,  1 Oct 2024 18:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727806187; cv=none; b=ZPyrbTx0zEGtO3hPlpwduucjt/G9OJYBcbeHV+k543JiZphg4euC2OcD1hZpB+J4K41qvOvJz8vzTGE7/Sr+qjovPSBsN0M6hGwK3bRpWvV8+8NksffL3c/nsu2mb+evL1B4E5GwsuGrOjgskxXJHZCde/vogSmk17LvTjIzeT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727806187; c=relaxed/simple;
	bh=QO5k6Mn2zTnt62az+LvMJvED3H8nPBgA5eDkntx5rPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q3ecpugWzGMKSdETAzLeBC1y5mZcqHi7xgd5oSgoTaq0a90L9tMwVqldezAE3wSWEkguuX23e0Fjs2S37+6Oyk+dw+R0Df4xciBWG3NQeKBxjNd55vPZz+78QjZZv1ZATBR3xXwSq5T2RCV0fgn30IoWiJ5FsqCe7cjv+GHO1IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpNHcAmE; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6dbc9a60480so48700967b3.0
        for <linux-pci@vger.kernel.org>; Tue, 01 Oct 2024 11:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727806184; x=1728410984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yhnut9z65Kl2+2x6xl6LSgf9hok/Xt3NwOsmQiMcodA=;
        b=kpNHcAmEx76DXO/vGUjvWI5olbJvHNB0FxoZBdIHiAbFo/BKRCrqKTYSvbV/j02dYp
         dQCI+gf5PX5v0cuvUSGPPSTPSKMzqmoaA288D7gFcPUgP3pzHVyuLtMcTulCg1C4c3dn
         gvHkE2WaNtDNeIC2H+GWsZpWs4GUA5CD/hO8XfOETb6Qp2nMenYbbwVeK14CTsZjH4aG
         zXpT2NPr4hRise6wVdv2HrwCG5ayvFTP6JwVscJWSjZW2+6eb34dTjDwmSS9M+bip2uO
         jNuLPTKlmK8E2mgBhsVG5DgFVFBloqFmJ5XqgewMHjKAAGuQZkfq+lf9cjX2QwbDm528
         bBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727806184; x=1728410984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yhnut9z65Kl2+2x6xl6LSgf9hok/Xt3NwOsmQiMcodA=;
        b=Nuor0fiIJrc9a8JwXLprtAQOO+OtgOmS/ev/m8/rx83oGkHF2KRzFM5ltMbVGRFRnK
         gPfFCFbQIk5NnPZsNovqBPLtRdiHgQ0E3O9c3uJ2piRnJARH2PJLHFCMMyK0nClxrCuC
         7CdRBX6f3SHd4AW/3g5WaPghMmCS5xD6RJf1RumA7/wrF7LO0tS/KQ73wJ5AOX5dVDvg
         N+RJfbpo3Wx/4gnMZ4jtjg/9NU9NpNzNBQlTkYcujDu33A1srNpCrojTL8X3Ya+VlhsT
         uFeA/YrQD+cnWt3HS6ncpoSwYVl7eWYrFQBr9qQzFJMiBQzLsarPkBEpv+xyjWNV9SvK
         3UMg==
X-Gm-Message-State: AOJu0YxzdXCVi4q6MsW3OQOlbxgifMgzkYjIN9dxLuYbVNRd4tq2Qexv
	Z5FzXAUnS6EgSW+gfoTdHDFtjsS07gCng1r0b2Q/CW0DEjIt0MzQL38on1XdWvo2uSWuaJN3Isf
	Mr6IJpIGIrTtXT1TM46gOORCqLDH6shEP
X-Google-Smtp-Source: AGHT+IEOCro8iC+S3D4s8EJzLt0E5QvVJOca13juMXj2a1jj7WIfxX5h8KNF6meMymjKvZbPGcj4WqkSqb4sJHL/sVU=
X-Received: by 2002:a05:690c:f12:b0:6b3:a6ff:7676 with SMTP id
 00721157ae682-6e2a2b728damr7345447b3.3.1727806184213; Tue, 01 Oct 2024
 11:09:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALfBBTsmKYf5FT-pxLfM-C1EgdrKKhQU43OhMDBz2ZPtKcxaLQ@mail.gmail.com>
 <20240930192834.GA187120@bhelgaas> <CALfBBTv3_4_x3aXfoDgQ93LCAbfC-2djnfwbHS+hqmOff8+8+g@mail.gmail.com>
In-Reply-To: <CALfBBTv3_4_x3aXfoDgQ93LCAbfC-2djnfwbHS+hqmOff8+8+g@mail.gmail.com>
From: Maverickk 78 <maverickk1778@gmail.com>
Date: Tue, 1 Oct 2024 23:39:33 +0530
Message-ID: <CALfBBTtdtzL4TatBOOzc=c+k9YdNDPd=UPppbo5U5fuK+YscvQ@mail.gmail.com>
Subject: Re: pcie hotplug driver probe is not getting called
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

I was able to trigger an interrupt, the pciehp_isr was triggered and
there are "Timeouts" while processing the hotplug,
I suspect this is due to the slowness of the simulation platform, is
my assumption correct?

[26599.580420] pcieport 0000:02:01.0: pciehp: pending interrupts
0x0001 from Slot Status
[26599.580575] pcieport 0000:02:01.0: pciehp: Slot(0): Button press:
will power on in 5 sec
[26599.593768] pcieport 0000:02:01.0: pciehp: Timeout on hotplug
command 0x17e1 (issued 42213 msec ago)
[26599.598920] pcieport 0000:02:01.0: pciehp: pciehp_set_indicators:
SLOTCTRL 80 write cmd 2c0
[26605.104802] pcieport 0000:02:01.0: pciehp:
pciehp_check_link_active: lnk_status =3D 2025
[26605.104840] pcieport 0000:02:01.0: pciehp: Slot(0): Link Up
[26605.109616] pcieport 0000:02:01.0: pciehp: pciehp_get_power_status:
SLOTCTRL 80 value read 16e1
[26605.126589] pcieport 0000:02:01.0: pciehp: Timeout on hotplug
command 0x16e1 (issued 5528 msec ago)
[26606.458516] pcieport 0000:02:01.0: pciehp: Timeout on hotplug
command 0x12e1 (issued 1327 msec ago)
[26606.458554] pcieport 0000:02:01.0: pciehp: pciehp_power_on_slot:
SLOTCTRL 80 write cmd 0
[26606.475509] pcieport 0000:02:01.0: pciehp: Timeout on hotplug
command 0x12e1 (issued 1344 msec ago)
[26606.481024] pcieport 0000:02:01.0: pciehp: pciehp_set_indicators:
SLOTCTRL 80 write cmd 200
[26606.618088] pcieport 0000:02:01.0: pciehp:
pciehp_check_link_status: lnk_status =3D 2025
[26606.674790] pci 0000:03:00.0: [abcd:0000] type 00 class 0x000000
PCIe Endpoint
[26606.725288] pci 0000:03:00.0: BAR 0 [mem 0xf8000000-0xf9ffffff]
[26607.867503] pci 0000:03:00.0: 63.014 Gb/s available PCIe bandwidth,
limited by 32.0 GT/s PCIe x2 link at 0000:02:01.0 (capable of 1024.000
Gb/s with 64.0 GT/s PCIe x16 link)
[26608.386085] pci 0000:03:00.0: vgaarb: pci_notify
[26608.491596] pcieport 0000:02:01.0: distributing available resources
[26608.491637] pcieport 0000:02:01.0: PCI bridge to [bus 03]
[26608.495947] pcieport 0000:02:01.0:   bridge window [io  0x1000-0x1fff]
[26608.513041] pcieport 0000:02:01.0:   bridge window [mem
0xf8000000-0xf9ffffff]
[26608.521771] pcieport 0000:02:01.0:   bridge window [mem
0xfe200000-0xfe3fffff 64bit pref]
[26608.647492] pcieport 0000:02:01.0: pciehp: Timeout on hotplug
command 0x12e1 (issued 2167 msec ago)
[26608.652270] pcieport 0000:02:01.0: pciehp: pciehp_set_indicators:
SLOTCTRL 80 write cmd 1c0

On Tue, 1 Oct 2024 at 18:18, Maverickk 78 <maverickk1778@gmail.com> wrote:
>
> Hi Bjorn,
>
> Yes, it's a virtual x86 Qemu environment with rtl simulated pcie gen6
> switch hooked to the host controller.
>
> The simulation environment is 3rd party and my guess is it's a
> passthrough(guessing) .
>
> I can confirm that msi is received to the Qemu host because the USP
> port has f0, f1, f2, f3, f4 and f4 is an scsi end point function and
> interrupts are used for command/response.
>
> I enabled a few more debugs, now I can see more information from
> pciehp dumped into the kernel log.
>
> Thanks for the details, I was not aware that _OSC flags need to be
> built by firmware to enable native PCIe hotplug.
>
> On Tue, 1 Oct 2024 at 00:58, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Sun, Sep 29, 2024 at 07:29:32PM +0530, Maverickk 78 wrote:
> > > Hi Bjorn,
> > >
> > > I have a switch connecting to the Host bridge, one of the downstream
> > > port(02:1.0) on the switch has the slot enabled.
> > >
> > > Appended pcie_ports=3Dnative along with pciehp.pciehp_force=3D1
> > > pciehp.pciehp_debug=3D1  to the cmdline and I see the driver creating=
 symlink
> > > to sysfs device node.
> > >
> > > Does this mean pciehp can handle the hotplug events? asking this beca=
use
> > > none of the functions in pciehp_core listed in ftrace?
> >
> > From the dmesg log you attached:
> >
> >   [    0.000000] DMI: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.1=
4.0-0-g155821a-20210629_105355-sharpie 04/01/2014
> >   [    0.000000] Hypervisor detected: KVM
> >   [    0.408755] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-6.11.0=
+ root=3DUUID=3Df563804b-1b93-4921-90e1-4114c8111e8f ro modprobe.blacklist=
=3Dmpt3sas ftrace=3Dfunction_graph ftrace_graph_filter=3D*pcie* pciehp.pcie=
hp_force=3D1 pciehp.pciehp_debug=3D1 pcie_ports=3Dnative quite splash crash=
kernel=3D512M-:192M vt.handoff=3D7
> >   [    1.640055] acpiphp: ACPI Hot Plug PCI Controller Driver version: =
0.5
> >   [    1.736168] acpi PNP0A08:00: _OSC: platform does not support [PCIe=
Hotplug LTR DPC]
> >   [    1.738096] acpi PNP0A08:00: _OSC: OS now controls [SHPCHotplug PM=
E AER PCIeCapability]
> >   [    9.885390] pcieport 0000:02:01.0: pciehp: Slot #0 AttnBtn+ PwrCtr=
l+ MRL+ AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock- NoCompl- IbPresDis- =
LLActRep+
> >
> > I assume this kernel is running as a KVM guest.  The firmware _OSC
> > says the platform (QEMU) doesn't support native PCIe hotplug, so
> > host->native_pcie_hotplug will be false.  But of course
> > "pcie_ports=3Dnative" would set pcie_ports_native, so the portdrv
> > get_port_device_capability() will set PCIE_PORT_SERVICE_HP, which
> > allows pciehp to bind to 02:01.0.
> >
> > The "pcieport 0000:02:01.0: pciehp: Slot #0" line shows that
> > pciehp_probe() was called.
> >
> > I don't know whether QEMU supports PCIe hotplug interrupts though.
> >
> > When do you expect pciehp to do something?  Are you hotplugging a
> > physical device that is passed through to this guest?
> >
> > Bjorn

