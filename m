Return-Path: <linux-pci+bounces-23312-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E83A592AB
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 12:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 852B6188E267
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 11:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79F321E082;
	Mon, 10 Mar 2025 11:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKK2ZmBD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B8F28EA;
	Mon, 10 Mar 2025 11:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605812; cv=none; b=EefPRYLaeV/6PGqVEneRsq3n39M0zUzVUzL/B39/WQeRWyoQE1fxav+BtglX0s3zGjgxfqr9r6ZdjmlTaFjBq+b29W5tZD9SkHmR3vCBvHko/zxExng7qIIhncumDpJe0kBXEh8JDZNMn8OnfefGlc7Sxq/Ct/ouV9Z/Kg+qQvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605812; c=relaxed/simple;
	bh=EYxaFCxaBSc9qHK/8aL3VHGayn9D6cbFl4Kie90VO5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5Zh260O0jc61PLA8aJXL/t6tNwbmxiSO3y/cYIGX16AdP3Su2lagQtHCEZ8G3OAmQi/tHjeOOkL7EKxwrVaJWuVUUA7rwzGsdorNNxtUxz0khdbvI5apSdquKhqmKQyObNJWpsvmg/gm4PnsZjZlUoR7TH31NnxDybAEIjFCkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKK2ZmBD; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30c091b54aaso15306891fa.3;
        Mon, 10 Mar 2025 04:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741605804; x=1742210604; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LPCc6TQ+OSpK282OpFaM8WyROxoWXW94+/aoXXiiN2E=;
        b=DKK2ZmBD4eSjyyeC5VTWpzgoFVq6tFMymZWoh6qUxnMzLIOabGIxpCjcjSTqei4E+N
         YRfs5D00hA2mbC7pnnEBZP81vpByaS4RNOtmK5H4HHwktR/Y8+jKdvVuQt9B3DgfAvX4
         Qrtc1rYOpf7+xupDdK/Oqtia/TXF7j4N1wdsWF4hQQKgalbEItQ79GaDd1nIWu6tt4Tn
         rDdpVcCoEe4bYnQ8zAFqHh40viieR2Z9NIcyX/VfPsWbDMYBzODS6cu1LdQCJ+Nb40Mt
         PxWmmWWfO06FUIr+F/CehWyjL6hkRXi+UCROmOyL0LLzRiG19MTlNgsTqL5IJM+eTBns
         wkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741605804; x=1742210604;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LPCc6TQ+OSpK282OpFaM8WyROxoWXW94+/aoXXiiN2E=;
        b=lpDWm2G/KE9NQ4HQSeoBjMm5Skuu0bQv/T7wjH++3qdWTxAhwqOzjZcfMV7y56ROOp
         ncjxBAvxyGMcfhHgxxZ5tCNHg4svmWWfO40w8UfadnFU7lxVA+O3iZThv+Igey7Zrko3
         dvsNyMzm6JqlpPtlYGp64mq92rvJBlSuhEIb+tdSmc2IFoblYsurFH1lBCWsyJuaQ+eS
         ySMZfID6+p/afgmVpmEwXOQ/GL+SVX/ecZAfVMzWBrL6Q2fyflkDITzaDADI7kXCnSG4
         CketSw3VfN2uru9iiyGZkx5DWIzv4IORywnod7pl1kS21x3dFoyiZ9D5Is8tmwB0MuR5
         ky3g==
X-Forwarded-Encrypted: i=1; AJvYcCUuz30Qh2iyxYVwtNffUzUMK9IsEJnzVDxmAk6jdo4UsMKgO0S5uyC1XQJiwVBvIN/rqMdTD02e2kVs@vger.kernel.org, AJvYcCWzj+hze3itBCJ5iwivH2uWrT4ZwCs4bzqzmLhXL0kWxUznQMmLAohu5AzjVj8RXDk6CBA+6pgA1ThB+FeZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+bgbabjl8Ti8livsilzHNUKu48YXfg9naVn4DgjeR5akK6ogb
	ujsIclTuVAPI8CUmpmB56Eru0u4cqxUMIC9lS/L7t3mltMPudYGDwBm11IMXbcC0NWCZwjrD/ZV
	EanbAFMpYiidyKuN35BRMXTLukLi4r2A=
X-Gm-Gg: ASbGncvnuE5MAeJSn2NlOCr7F2Rs7GSmt5SkXvuQA+R1IhbVHWtOkasvQfzHEoCY9uc
	9Rk0Qe8/4k9CbPB3VFjQRFbrZYZBFzhG5kD5sCiBlBWnZkvjqZ7zrlJ+f246nMyfr/6x+L769zD
	sZzHiHtLiaqXUxZWVEfedmh8mgsg==
X-Google-Smtp-Source: AGHT+IFXMkkmo8cSAUTlMt4MqA1Kk/psuf8PeEcMyCVdvCB9cqQi59fR972k5Wup+vl4cezNktW34rNYhodYvx+4Ur4=
X-Received: by 2002:a05:651c:39e:b0:30b:efa5:69c3 with SMTP id
 38308e7fff4ca-30bf4550e90mr31393501fa.22.1741605803334; Mon, 10 Mar 2025
 04:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMciSVVhdRjfVYZGg+0Yo6EV4P80No3kLxCL8+LyVjwywiWxYg@mail.gmail.com>
 <20250304210122.GA257363@bhelgaas> <CAMciSVWfLVRQB4afDe=6e=n_j7+4DX-tvDpeEx6QUkvBym+7GQ@mail.gmail.com>
In-Reply-To: <CAMciSVWfLVRQB4afDe=6e=n_j7+4DX-tvDpeEx6QUkvBym+7GQ@mail.gmail.com>
From: Naveen Kumar P <naveenkumar.parna@gmail.com>
Date: Mon, 10 Mar 2025 16:53:10 +0530
X-Gm-Features: AQ5f1JrCtz083hA9Y6X4FYvyC6-8GZP7r7AFIhlS8X2v6VJlM1FdNIluctz2WB8
Message-ID: <CAMciSVV317JUzxoL1yO_rC_=p8hJUsfBK5UpxDFYNjjaw0ePcQ@mail.gmail.com>
Subject: Re: PCI: hotplug_event: PCIe PLDA Device BAR Reset
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernelnewbies <kernelnewbies@kernelnewbies.org>, linux-acpi@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000003f4e67062ffb336d"

--0000000000003f4e67062ffb336d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 4:14=E2=80=AFAM Naveen Kumar P
<naveenkumar.parna@gmail.com> wrote:
>
> On Wed, Mar 5, 2025 at 2:31=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
> >
> > On Tue, Mar 04, 2025 at 10:19:07PM +0530, Naveen Kumar P wrote:
> > > On Tue, Mar 4, 2025 at 1:35=E2=80=AFPM Naveen Kumar P
> > > <naveenkumar.parna@gmail.com> wrote:
> > > ...
> >
> > > For this test run, I removed all three parameters (pcie_aspm=3Doff,
> > > pci=3Dnomsi, and pcie_ports=3Don) and booted with the following kerne=
l
> > > command line arguments:
> > >
> > > cat /proc/cmdline
> > > BOOT_IMAGE=3D/vmlinuz-6.13.0+ root=3D/dev/mapper/vg00-rootvol ro quie=
t
> > > "dyndbg=3Dfile drivers/pci/* +p; file drivers/acpi/bus.c +p; file
> > > drivers/acpi/osl.c +p"
> > >
> > > This time, the issue occurred earlier, at 22998 seconds. Below is the
> > > relevant dmesg log during the ACPI_NOTIFY_BUS_CHECK event. The
> > > complete log is attached (dmesg_march4th_log.txt).
> > >
> > > [22998.536705] ACPI: \_SB_.PCI0.RP01: ACPI: ACPI_NOTIFY_BUS_CHECK eve=
nt
> > > [22998.536753] ACPI: \_SB_.PCI0.RP01: ACPI: OSL: Scheduling hotplug
> > > event 0 for deferred handling
> > > [22998.536934] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bridge acquired i=
n
> > > hotplug_event()
> > > [22998.536972] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bus check in hotp=
lug_event()
> > > [22998.537002] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Checking bridge i=
n
> > > hotplug_event()
> > > [22998.537024] PCI READ: res=3D0, bus=3D01 dev=3D00 func=3D0 pos=3D0x=
00 len=3D4
> > > data=3D0x55551556
> > > [22998.537066] PCI READ: res=3D0, bus=3D01 dev=3D00 func=3D0 pos=3D0x=
00 len=3D4
> > > data=3D0x55551556
> >
> > Fine again.
> >
> > > [22998.537094] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Enabling slot in
> > > acpiphp_check_bridge()
> > > [22998.537155] ACPI: Device [PXSX] status [0000000f]
> > > [22998.537206] ACPI: Device [D015] status [0000000f]
> > > [22998.537276] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Releasing bridge
> > > in hotplug_event()
> > >
> > > sudo lspci -xxx -s 01:00.0 | grep 10:
> > > 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >
> > Obviously a problem.  Can you start including the whole
> > "lspci -x -s 01:00.0" output?  Obviously the Vendor ID reads above
> > worked fine.  I *assume* it's still fine here, and only the BARs are
> > zeroed out?
> I've captured the complete lspci output from the last run, and it is as f=
ollows:
>
> $sudo lspci -xxx -s 01:00.0
> 01:00.0 RAM memory: PLDA Device 5555
> 00: 56 15 55 55 00 00 10 00 00 00 00 05 00 00 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 40 00 00
> 30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00
> 40: 01 48 03 00 08 00 00 00 05 60 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 10 00 02 00 c2 8f 00 00 10 28 00 00 21 f4 03 00
> 70: 00 00 21 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00
> 90: 20 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
> I've also observed some inconsistencies in the behavior. In previous
> runs, the first invocation of lspci showed all FF's, and then the next
> run resulted in a PCI BAR reset, as mentioned below.
>
> Previous runs - first invocation of lspci output :
> --------------------------------------------------
> $sudo lspci -xxx -s 01:00.0
> 01:00.0 RAM memory: PLDA Device 5555 (rev ff)
> 00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>
> Previous runs - second invocation of lspci output :
> --------------------------------------------------
> $sudo lspci -xxx -s 01:00.0
> 01:00.0 RAM memory: PLDA Device 5555
> 00: 56 15 55 55 00 00 10 00 00 00 00 05 00 00 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 40 00 00
> 30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00
> 40: 01 48 03 00 08 00 00 00 05 60 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 10 00 02 00 c2 8f 00 00 10 28 00 00 21 f4 03 00
> 70: 00 00 21 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00
> 90: 20 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
> However this time, the first run didn't show all FF's but instead
> directly resulted in a PCI BAR reset.
>
>
> >
> > I assume you saw no new dmesg logs about config accesses to the device
> > before the lspci.  If you instrumented the user config accessors
> > (pci_user_read_config_*(), also in access.c), you should see those
> > accesses.
> i will try this and update you with the results soon.
> >
> > You could sprinkle some calls to early_dump_pci_device() through the
> > acpiphp path.  Turn off the kernel config access tracing when you do
> > this so it doesn't clutter things up.
I instrumented the user config accessors (pci_user_read_config_*())
and added calls to early_dump_pci_device() in the ACPIPHP path. The
corresponding patch
(0003-added-early_dump_pci_device-through-the-acpiphp-path.patch) is
attached for reference.

After rebuilding the kernel with these changes, I rebooted the system
and monitored the ACPI_NOTIFY_BUS_CHECK event in dmesg, but it did not
appear initially. After waiting for three days, I manually ran lspci,
which resulted in all 0xFFs in the PCI config space from 0x00 to 0x3F
as shown below:
$ sudo lspci -xxx -s 01:00.0
01:00.0 RAM memory: PLDA Device 5555 (rev ff)
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
40: 01 48 03 00 08 00 00 00 05 60 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 02 00 c2 8f 00 00 10 28 00 00 21 f4 03 00
70: 00 00 21 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00
90: 20 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


The corresponding dmesg log confirms this:

[260228.608982] USER PCI READ: ret=3D0, bus=3D01 dev=3D00 func=3D0 pos=3D0x=
00
len=3D4 data=3D0xffffffff
...
[260228.609741] USER PCI READ: ret=3D0, bus=3D01 dev=3D00 func=3D0 pos=3D0x=
3c
len=3D4 data=3D0xffffffff
[260228.640346] USER PCI READ: ret=3D0, bus=3D01 dev=3D00 func=3D0 pos=3D0x=
40
len=3D4 data=3D0x34801
..
[260228.640666] USER PCI READ: ret=3D0, bus=3D01 dev=3D00 func=3D0 pos=3D0x=
fc
len=3D4 data=3D0x0


However, after completing this command, the ACPI_NOTIFY_BUS_CHECK
event was triggered. At this point, the early_dump_pci_device() output
reflected the correct values in the PCI config space (0x00 to 0x3F),
except for BAR0 (offset 0x10), which had been reset to 0x0:

[260228.711860] ACPI: \_SB_.PCI0.RP01: ACPI: ACPI_NOTIFY_BUS_CHECK event
[260228.711902] ACPI: \_SB_.PCI0.RP01: ACPI: OSL: Scheduling hotplug
event 0 for deferred handling
[260228.712004] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bridge acquired
in hotplug_event()
[260228.712032] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bus check in
hotplug_event()
[260228.712053] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Checking bridge
in hotplug_event()
[260228.712096] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: calling
early_dump_pci_device() before enable_slot() in acpiphp_check_bridge()
[260228.712121] pcieport 0000:00:1c.0: config space:
[260228.712217] 00000000: 86 80 48 0f 07 04 10 00 11 00 04 06 10 00 81 00
[260228.712232] 00000010: 00 00 00 00 00 00 00 00 00 01 01 00 10 10 00 20
[260228.712246] 00000020: 40 b0 70 b0 f1 ff 01 00 00 00 00 00 00 00 00 00
[260228.712258] 00000030: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 12 00
[260228.712270] 00000040: 10 80 42 01 00 80 00 00 00 00 11 00 22 4c 31 01
[260228.712282] 00000050: 00 0c 21 30 60 00 04 00 00 00 40 01 00 00 00 00
[260228.712294] 00000060: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
[260228.712306] 00000070: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
[260228.712318] 00000080: 05 90 01 00 00 20 e0 fe 20 00 00 00 00 00 00 00
[260228.712330] 00000090: 0d a0 00 00 86 80 48 0f 00 00 00 00 00 00 00 00
[260228.712342] 000000a0: 01 00 03 c8 00 00 00 00 00 00 00 00 00 00 00 00
[260228.712354] 000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[260228.712366] 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[260228.712378] 000000d0: 00 c0 00 00 42 08 00 00 00 80 11 c9 00 00 00 00
[260228.712390] 000000e0: 00 00 00 00 00 00 00 00 04 00 00 00 00 00 00 00
[260228.712402] 000000f0: 50 00 00 00 c0 00 00 00 1a 0f 13 01 00 40 00 01
[260228.712420] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Enabling slot in
acpiphp_check_bridge()


A second lspci command confirmed that BAR0 remained 0x00, aligning
with the early_dump_pci_device() output:
$sudo lspci -xxx -s 01:00.0
01:00.0 RAM memory: PLDA Device 5555
00: 56 15 55 55 00 00 10 00 00 00 00 05 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 40 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00
40: 01 48 03 00 08 00 00 00 05 60 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 02 00 c2 8f 00 00 10 28 00 00 21 f4 03 00
70: 00 00 21 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00
90: 20 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

While I can now reliably reproduce the issue, I still don=E2=80=99t have
clarity on why BAR0 is being reset to zero?

I would like to summarize my observations as follows. Based on my
testing, I have noticed that the PCI BAR0 address (offset 0x10) gets
reset to zero under the following scenarios:

1. Spontaneous ACPI BUS CHECK Event
After booting the system, at an unpredictable time, an
ACPI_NOTIFY_BUS_CHECK event appears in the dmesg log.
Running lspci -xxx -s 01:00.0 after this event shows that BAR0 (offset
0x10) is reset to zero.

2. ACPI BUS CHECK Event Triggered After lspci Shows All 0xFF=E2=80=99s (Ful=
l
Config Space)
I waited for the ACPI_NOTIFY_BUS_CHECK event, but it did not appear in
the dmesg log.
Running lspci -xxx -s 01:00.0 at this stage resulted in all 0xFF's in
the PCI configuration space from offset 0x00 to 0xFF.
Immediately after this, the ACPI_NOTIFY_BUS_CHECK event appeared in dmesg.
After this event, running lspci again showed correct values in the PCI
configuration space, except BAR0 (offset 0x10) was still reset to
zero.

3. ACPI BUS CHECK Event Triggered After lspci Shows Partial 0xFF=E2=80=99s
(First 64 Bytes - as observed in this dmesg log)
This scenario is similar to the second one.
Running lspci -xxx -s 01:00.0 resulted in all 0xFF's from offset 0x00
to 0x3F instead of the entire config space.
The ACPI_NOTIFY_BUS_CHECK event then appeared, and lspci showed
correct values except for BAR0 (offset 0x10), which was reset to zero.


Why does reading the PCI configuration space with lspci sometimes
return 0xFF's for the first 64 bytes (offset 0x00 to 0x3F) and other
times for the entire 256-byte space (offset 0x00 to 0xFF)?

Does the kernel provide any debug messages or hooks that can help
determine why the PCI config space reads all 0xFF's before the ACPI
BUS CHECK event?

Should I add any additional instrumentation in the kernel (e.g.,
deeper tracing in access.c, ACPI hotplug path, or PCIe port handling)
to gather more information on why BAR0 is being reset?

I have attached the patch
0003-added-early_dump_pci_device-through-the-acpiphp-path.patch and
the full dmesg log for reference.

Looking forward to your thoughts.

> >
> > What is this device?  Is it a shipping product?  Do you have good
> The PCIe device in question is a Xilinx FPGA endpoint, which is
> flashed with RTL code to expose several host interfaces to the system
> via the PCIe link.
>
> > confidence that the hardware is working correctly?  I guess you said
> > it works correctly on a different machine with an older kernel.  I
> > would swap the cards between machines in case one card is broken.
> >
> > You could try bisecting between the working kernel and the broken one.
> > It's kind of painful since it takes so long to reproduce the problem.
> >
> > Bjorn

--0000000000003f4e67062ffb336d
Content-Type: text/plain; charset="US-ASCII"; name="dmesg_march9th_log.txt"
Content-Disposition: attachment; filename="dmesg_march9th_log.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_m82z16yg0>
X-Attachment-Id: f_m82z16yg0

WyAgICAwLjAwMDAwMF0gTGludXggdmVyc2lvbiA2LjE0LjAtcmM1KyAobmF2ZWVuQGJ0dGVzdCkg
KGdjYyAoVWJ1bnR1IDkuNC4wLTF1YnVudHUxfjIwLjA0LjEpIDkuNC4wLCBHTlUgbGQgKEdOVSBC
aW51dGlscyBmb3IgVWJ1bnR1KSAyLjM0KSAjNSBTTVAgUFJFRU1QVF9EWU5BTUlDIFRodSBNYXIg
IDYgMTg6MzE6MjEgSVNUIDIwMjUKWyAgICAwLjAwMDAwMF0gQ29tbWFuZCBsaW5lOiBCT09UX0lN
QUdFPS92bWxpbnV6LTYuMTQuMC1yYzUrIHJvb3Q9L2Rldi9tYXBwZXIvdmcwMC1yb290dm9sIHJv
IHF1aWV0ICJkeW5kYmc9ZmlsZSBkcml2ZXJzL3BjaS8qICtwOyBmaWxlIGRyaXZlcnMvYWNwaS9i
dXMuYyArcDsgZmlsZSBkcml2ZXJzL2FjcGkvb3NsLmMgK3AiClsgICAgMC4wMDAwMDBdIEtFUk5F
TCBzdXBwb3J0ZWQgY3B1czoKWyAgICAwLjAwMDAwMF0gICBJbnRlbCBHZW51aW5lSW50ZWwKWyAg
ICAwLjAwMDAwMF0gICBBTUQgQXV0aGVudGljQU1EClsgICAgMC4wMDAwMDBdICAgSHlnb24gSHln
b25HZW51aW5lClsgICAgMC4wMDAwMDBdICAgQ2VudGF1ciBDZW50YXVySGF1bHMKWyAgICAwLjAw
MDAwMF0gICB6aGFveGluICAgU2hhbmdoYWkgIApbICAgIDAuMDAwMDAwXSBCSU9TLXByb3ZpZGVk
IHBoeXNpY2FsIFJBTSBtYXA6ClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAw
MDAwMDAwMDAwMDAtMHgwMDAwMDAwMDAwMDlkN2ZmXSB1c2FibGUKWyAgICAwLjAwMDAwMF0gQklP
Uy1lODIwOiBbbWVtIDB4MDAwMDAwMDAwMDA5ZDgwMC0weDAwMDAwMDAwMDAwOWZmZmZdIHJlc2Vy
dmVkClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwMDAwZTAwMDAtMHgw
MDAwMDAwMDAwMGZmZmZmXSByZXNlcnZlZApbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0g
MHgwMDAwMDAwMDAwMTAwMDAwLTB4MDAwMDAwMDAxZWZmZmZmZl0gdXNhYmxlClsgICAgMC4wMDAw
MDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwMWYwMDAwMDAtMHgwMDAwMDAwMDFmMGZmZmZm
XSByZXNlcnZlZApbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMDFmMTAw
MDAwLTB4MDAwMDAwMDAxZmZmZmZmZl0gdXNhYmxlClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDog
W21lbSAweDAwMDAwMDAwMjAwMDAwMDAtMHgwMDAwMDAwMDIwMGZmZmZmXSByZXNlcnZlZApbICAg
IDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMDIwMTAwMDAwLTB4MDAwMDAwMDA5
OTYxNGZmZl0gdXNhYmxlClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAw
OTk2MTUwMDAtMHgwMDAwMDAwMDk5NjQ0ZmZmXSByZXNlcnZlZApbICAgIDAuMDAwMDAwXSBCSU9T
LWU4MjA6IFttZW0gMHgwMDAwMDAwMDk5NjQ1MDAwLTB4MDAwMDAwMDA5OTY1NGZmZl0gQUNQSSBk
YXRhClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwOTk2NTUwMDAtMHgw
MDAwMDAwMDk5N2RhZmZmXSBBQ1BJIE5WUwpbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0g
MHgwMDAwMDAwMDk5N2RiMDAwLTB4MDAwMDAwMDA5OWFmYmZmZl0gcmVzZXJ2ZWQKWyAgICAwLjAw
MDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDA5OWFmYzAwMC0weDAwMDAwMDAwOTlhZmNm
ZmZdIHVzYWJsZQpbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMDk5YWZk
MDAwLTB4MDAwMDAwMDA5OWIzZWZmZl0gcmVzZXJ2ZWQKWyAgICAwLjAwMDAwMF0gQklPUy1lODIw
OiBbbWVtIDB4MDAwMDAwMDA5OWIzZjAwMC0weDAwMDAwMDAwOTljYWRmZmZdIHVzYWJsZQpbICAg
IDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMDk5Y2FlMDAwLTB4MDAwMDAwMDA5
OWZmOWZmZl0gcmVzZXJ2ZWQKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAw
MDA5OWZmYTAwMC0weDAwMDAwMDAwOTlmZmZmZmZdIHVzYWJsZQpbICAgIDAuMDAwMDAwXSBCSU9T
LWU4MjA6IFttZW0gMHgwMDAwMDAwMGUwMDAwMDAwLTB4MDAwMDAwMDBlZmZmZmZmZl0gcmVzZXJ2
ZWQKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDBmZWMwMDAwMC0weDAw
MDAwMDAwZmVjMDBmZmZdIHJlc2VydmVkClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAw
eDAwMDAwMDAwZmVkMDEwMDAtMHgwMDAwMDAwMGZlZDAxZmZmXSByZXNlcnZlZApbICAgIDAuMDAw
MDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMGZlZDAzMDAwLTB4MDAwMDAwMDBmZWQwM2Zm
Zl0gcmVzZXJ2ZWQKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDBmZWQw
ODAwMC0weDAwMDAwMDAwZmVkMDhmZmZdIHJlc2VydmVkClsgICAgMC4wMDAwMDBdIEJJT1MtZTgy
MDogW21lbSAweDAwMDAwMDAwZmVkMGMwMDAtMHgwMDAwMDAwMGZlZDBmZmZmXSByZXNlcnZlZApb
ICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMGZlZDFjMDAwLTB4MDAwMDAw
MDBmZWQxY2ZmZl0gcmVzZXJ2ZWQKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAw
MDAwMDBmZWUwMDAwMC0weDAwMDAwMDAwZmVlMDBmZmZdIHJlc2VydmVkClsgICAgMC4wMDAwMDBd
IEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwZmVmMDAwMDAtMHgwMDAwMDAwMGZlZmZmZmZmXSBy
ZXNlcnZlZApbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMGZmYjAwMDAw
LTB4MDAwMDAwMDBmZmZmZmZmZl0gcmVzZXJ2ZWQKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBb
bWVtIDB4MDAwMDAwMDEwMDAwMDAwMC0weDAwMDAwMDAxNWZmZmZmZmZdIHVzYWJsZQpbICAgIDAu
MDAwMDAwXSBOWCAoRXhlY3V0ZSBEaXNhYmxlKSBwcm90ZWN0aW9uOiBhY3RpdmUKWyAgICAwLjAw
MDAwMF0gQVBJQzogU3RhdGljIGNhbGxzIGluaXRpYWxpemVkClsgICAgMC4wMDAwMDBdIFNNQklP
UyAyLjggcHJlc2VudC4KWyAgICAwLjAwMDAwMF0gRE1JOiBBRExJTksgVGVjaG5vbG9neSBJbmMu
IG5hbm9YLUJUL1RvIGJlIGZpbGxlZCBieSBPLkUuTS4sIEJJT1MgUUMwMSAwOS8xMC8yMDI0Clsg
ICAgMC4wMDAwMDBdIERNSTogTWVtb3J5IHNsb3RzIHBvcHVsYXRlZDogMS8xClsgICAgMC4wMDAw
MDBdIHRzYzogRGV0ZWN0ZWQgMTkxNi42NjcgTUh6IHByb2Nlc3NvcgpbICAgIDAuMDAyMjAxXSBl
ODIwOiB1cGRhdGUgW21lbSAweDAwMDAwMDAwLTB4MDAwMDBmZmZdIHVzYWJsZSA9PT4gcmVzZXJ2
ZWQKWyAgICAwLjAwMjIxMF0gZTgyMDogcmVtb3ZlIFttZW0gMHgwMDBhMDAwMC0weDAwMGZmZmZm
XSB1c2FibGUKWyAgICAwLjAwMjIzNl0gbGFzdF9wZm4gPSAweDE2MDAwMCBtYXhfYXJjaF9wZm4g
PSAweDQwMDAwMDAwMApbICAgIDAuMDAyMjUwXSB0b3RhbCBSQU0gY292ZXJlZDogNDUxMk0KWyAg
ICAwLjAwMjc2OV0gRm91bmQgb3B0aW1hbCBzZXR0aW5nIGZvciBtdHJyIGNsZWFuIHVwClsgICAg
MC4wMDI3NzFdICBncmFuX3NpemU6IDY0SyAJY2h1bmtfc2l6ZTogNjRLIAludW1fcmVnOiA1ICAJ
bG9zZSBjb3ZlciBSQU06IDBHClsgICAgMC4wMDI3ODNdIE1UUlIgbWFwOiA2IGVudHJpZXMgKDQg
Zml4ZWQgKyAyIHZhcmlhYmxlOyBtYXggMjApLCBidWlsdCBmcm9tIDggdmFyaWFibGUgTVRSUnMK
WyAgICAwLjAwMjc4N10geDg2L1BBVDogQ29uZmlndXJhdGlvbiBbMC03XTogV0IgIFdDICBVQy0g
VUMgIFdCICBXUCAgVUMtIFdUICAKWyAgICAwLjAwMjkxMF0gZTgyMDogdXBkYXRlIFttZW0gMHg5
YTAwMDAwMC0weGZmZmZmZmZmXSB1c2FibGUgPT0+IHJlc2VydmVkClsgICAgMC4wMDI5MjBdIGxh
c3RfcGZuID0gMHg5YTAwMCBtYXhfYXJjaF9wZm4gPSAweDQwMDAwMDAwMApbICAgIDAuMDEwMzA5
XSBmb3VuZCBTTVAgTVAtdGFibGUgYXQgW21lbSAweDAwMGZkNmQwLTB4MDAwZmQ2ZGZdClsgICAg
MC4wMTQ1NjBdIFJBTURJU0s6IFttZW0gMHgyNjlkZDAwMC0weDJmNGU1ZmZmXQpbICAgIDAuMDE0
NTc4XSBBQ1BJOiBFYXJseSB0YWJsZSBjaGVja3N1bSB2ZXJpZmljYXRpb24gZGlzYWJsZWQKWyAg
ICAwLjAxNDU4Nl0gQUNQSTogUlNEUCAweDAwMDAwMDAwMDAwRjA0QTAgMDAwMDI0ICh2MDIgQUxB
U0tBKQpbICAgIDAuMDE0NTk2XSBBQ1BJOiBYU0RUIDB4MDAwMDAwMDA5OTY0QTA4MCAwMDAwN0Mg
KHYwMSBBTEFTS0EgQSBNIEkgICAgMDEwNzIwMDkgQU1JICAwMDAxMDAxMykKWyAgICAwLjAxNDYw
OV0gQUNQSTogRkFDUCAweDAwMDAwMDAwOTk2NTJGQzAgMDAwMTBDICh2MDUgQUxBU0tBIEEgTSBJ
ICAgIDAxMDcyMDA5IEFNSSAgMDAwMTAwMTMpClsgICAgMC4wMTQ2MjJdIEFDUEkgQklPUyBXYXJu
aW5nIChidWcpOiAzMi82NFggbGVuZ3RoIG1pc21hdGNoIGluIEZBRFQvR3BlMEJsb2NrOiAxMjgv
MzIgKDIwMjQwODI3L3RiZmFkdC01NjApClsgICAgMC4wMTQ2MzRdIEFDUEk6IERTRFQgMHgwMDAw
MDAwMDk5NjRBMTg4IDAwOEUzMiAodjAyIEFMQVNLQSBBIE0gSSAgICAwMTA3MjAwOSBJTlRMIDIw
MTIwOTEzKQpbICAgIDAuMDE0NjQ0XSBBQ1BJOiBGQUNTIDB4MDAwMDAwMDA5OTdEQUY4MCAwMDAw
NDAKWyAgICAwLjAxNDY1Ml0gQUNQSTogQVBJQyAweDAwMDAwMDAwOTk2NTMwRDAgMDAwMDg0ICh2
MDMgQUxBU0tBIEEgTSBJICAgIDAxMDcyMDA5IEFNSSAgMDAwMTAwMTMpClsgICAgMC4wMTQ2NjJd
IEFDUEk6IEZQRFQgMHgwMDAwMDAwMDk5NjUzMTU4IDAwMDA0NCAodjAxIEFMQVNLQSBBIE0gSSAg
ICAwMTA3MjAwOSBBTUkgIDAwMDEwMDEzKQpbICAgIDAuMDE0NjcyXSBBQ1BJOiBMUElUIDB4MDAw
MDAwMDA5OTY1MzFBMCAwMDAxMDQgKHYwMSBBTEFTS0EgQSBNIEkgICAgMDAwMDAwMDMgVkxWMiAw
MTAwMDAwRCkKWyAgICAwLjAxNDY4MV0gQUNQSTogTUNGRyAweDAwMDAwMDAwOTk2NTMyQTggMDAw
MDNDICh2MDEgQUxBU0tBIEEgTSBJICAgIDAxMDcyMDA5IE1TRlQgMDAwMDAwOTcpClsgICAgMC4w
MTQ2OTFdIEFDUEk6IEhQRVQgMHgwMDAwMDAwMDk5NjUzMkU4IDAwMDAzOCAodjAxIEFMQVNLQSBB
IE0gSSAgICAwMTA3MjAwOSBBTUkuIDAwMDAwMDA1KQpbICAgIDAuMDE0NzAxXSBBQ1BJOiBTU0RU
IDB4MDAwMDAwMDA5OTY1MzMyMCAwMDA3NjMgKHYwMSBQbVJlZiAgQ3B1UG0gICAgMDAwMDMwMDAg
SU5UTCAyMDA2MTEwOSkKWyAgICAwLjAxNDcxMF0gQUNQSTogU1NEVCAweDAwMDAwMDAwOTk2NTNB
ODggMDAwMjkwICh2MDEgUG1SZWYgIENwdTBUc3QgIDAwMDAzMDAwIElOVEwgMjAwNjExMDkpClsg
ICAgMC4wMTQ3MjBdIEFDUEk6IFNTRFQgMHgwMDAwMDAwMDk5NjUzRDE4IDAwMDE3QSAodjAxIFBt
UmVmICBBcFRzdCAgICAwMDAwMzAwMCBJTlRMIDIwMDYxMTA5KQpbICAgIDAuMDE0NzMwXSBBQ1BJ
OiBVRUZJIDB4MDAwMDAwMDA5OTY1M0U5OCAwMDAwNDIgKHYwMSBBTEFTS0EgQSBNIEkgICAgMDAw
MDAwMDAgICAgICAwMDAwMDAwMCkKWyAgICAwLjAxNDc0MF0gQUNQSTogQ1NSVCAweDAwMDAwMDAw
OTk2NTNFRTAgMDAwMTRDICh2MDAgSU5URUwgIEVESzIgICAgIDAwMDAwMDA1IElOVEwgMjAxMjA2
MjQpClsgICAgMC4wMTQ3NDhdIEFDUEk6IFJlc2VydmluZyBGQUNQIHRhYmxlIG1lbW9yeSBhdCBb
bWVtIDB4OTk2NTJmYzAtMHg5OTY1MzBjYl0KWyAgICAwLjAxNDc1Ml0gQUNQSTogUmVzZXJ2aW5n
IERTRFQgdGFibGUgbWVtb3J5IGF0IFttZW0gMHg5OTY0YTE4OC0weDk5NjUyZmI5XQpbICAgIDAu
MDE0NzU1XSBBQ1BJOiBSZXNlcnZpbmcgRkFDUyB0YWJsZSBtZW1vcnkgYXQgW21lbSAweDk5N2Rh
ZjgwLTB4OTk3ZGFmYmZdClsgICAgMC4wMTQ3NThdIEFDUEk6IFJlc2VydmluZyBBUElDIHRhYmxl
IG1lbW9yeSBhdCBbbWVtIDB4OTk2NTMwZDAtMHg5OTY1MzE1M10KWyAgICAwLjAxNDc2MV0gQUNQ
STogUmVzZXJ2aW5nIEZQRFQgdGFibGUgbWVtb3J5IGF0IFttZW0gMHg5OTY1MzE1OC0weDk5NjUz
MTliXQpbICAgIDAuMDE0NzY0XSBBQ1BJOiBSZXNlcnZpbmcgTFBJVCB0YWJsZSBtZW1vcnkgYXQg
W21lbSAweDk5NjUzMWEwLTB4OTk2NTMyYTNdClsgICAgMC4wMTQ3NjddIEFDUEk6IFJlc2Vydmlu
ZyBNQ0ZHIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4OTk2NTMyYTgtMHg5OTY1MzJlM10KWyAgICAw
LjAxNDc3MF0gQUNQSTogUmVzZXJ2aW5nIEhQRVQgdGFibGUgbWVtb3J5IGF0IFttZW0gMHg5OTY1
MzJlOC0weDk5NjUzMzFmXQpbICAgIDAuMDE0NzczXSBBQ1BJOiBSZXNlcnZpbmcgU1NEVCB0YWJs
ZSBtZW1vcnkgYXQgW21lbSAweDk5NjUzMzIwLTB4OTk2NTNhODJdClsgICAgMC4wMTQ3NzZdIEFD
UEk6IFJlc2VydmluZyBTU0RUIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4OTk2NTNhODgtMHg5OTY1
M2QxN10KWyAgICAwLjAxNDc3OV0gQUNQSTogUmVzZXJ2aW5nIFNTRFQgdGFibGUgbWVtb3J5IGF0
IFttZW0gMHg5OTY1M2QxOC0weDk5NjUzZTkxXQpbICAgIDAuMDE0NzgyXSBBQ1BJOiBSZXNlcnZp
bmcgVUVGSSB0YWJsZSBtZW1vcnkgYXQgW21lbSAweDk5NjUzZTk4LTB4OTk2NTNlZDldClsgICAg
MC4wMTQ3ODVdIEFDUEk6IFJlc2VydmluZyBDU1JUIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4OTk2
NTNlZTAtMHg5OTY1NDAyYl0KWyAgICAwLjAxNTAwNl0gTm8gTlVNQSBjb25maWd1cmF0aW9uIGZv
dW5kClsgICAgMC4wMTUwMDldIEZha2luZyBhIG5vZGUgYXQgW21lbSAweDAwMDAwMDAwMDAwMDAw
MDAtMHgwMDAwMDAwMTVmZmZmZmZmXQpbICAgIDAuMDE1MDMwXSBOT0RFX0RBVEEoMCkgYWxsb2Nh
dGVkIFttZW0gMHgxNWZmZDFhMDAtMHgxNWZmZmJmZmZdClsgICAgMC4wMTU2NzNdIFpvbmUgcmFu
Z2VzOgpbICAgIDAuMDE1Njc1XSAgIERNQSAgICAgIFttZW0gMHgwMDAwMDAwMDAwMDAxMDAwLTB4
MDAwMDAwMDAwMGZmZmZmZl0KWyAgICAwLjAxNTY4MV0gICBETUEzMiAgICBbbWVtIDB4MDAwMDAw
MDAwMTAwMDAwMC0weDAwMDAwMDAwZmZmZmZmZmZdClsgICAgMC4wMTU2ODVdICAgTm9ybWFsICAg
W21lbSAweDAwMDAwMDAxMDAwMDAwMDAtMHgwMDAwMDAwMTVmZmZmZmZmXQpbICAgIDAuMDE1Njg5
XSAgIERldmljZSAgIGVtcHR5ClsgICAgMC4wMTU2OTJdIE1vdmFibGUgem9uZSBzdGFydCBmb3Ig
ZWFjaCBub2RlClsgICAgMC4wMTU2OTddIEVhcmx5IG1lbW9yeSBub2RlIHJhbmdlcwpbICAgIDAu
MDE1Njk5XSAgIG5vZGUgICAwOiBbbWVtIDB4MDAwMDAwMDAwMDAwMTAwMC0weDAwMDAwMDAwMDAw
OWNmZmZdClsgICAgMC4wMTU3MDNdICAgbm9kZSAgIDA6IFttZW0gMHgwMDAwMDAwMDAwMTAwMDAw
LTB4MDAwMDAwMDAxZWZmZmZmZl0KWyAgICAwLjAxNTcwNl0gICBub2RlICAgMDogW21lbSAweDAw
MDAwMDAwMWYxMDAwMDAtMHgwMDAwMDAwMDFmZmZmZmZmXQpbICAgIDAuMDE1NzA5XSAgIG5vZGUg
ICAwOiBbbWVtIDB4MDAwMDAwMDAyMDEwMDAwMC0weDAwMDAwMDAwOTk2MTRmZmZdClsgICAgMC4w
MTU3MTNdICAgbm9kZSAgIDA6IFttZW0gMHgwMDAwMDAwMDk5YWZjMDAwLTB4MDAwMDAwMDA5OWFm
Y2ZmZl0KWyAgICAwLjAxNTcxNl0gICBub2RlICAgMDogW21lbSAweDAwMDAwMDAwOTliM2YwMDAt
MHgwMDAwMDAwMDk5Y2FkZmZmXQpbICAgIDAuMDE1NzE5XSAgIG5vZGUgICAwOiBbbWVtIDB4MDAw
MDAwMDA5OWZmYTAwMC0weDAwMDAwMDAwOTlmZmZmZmZdClsgICAgMC4wMTU3MjFdICAgbm9kZSAg
IDA6IFttZW0gMHgwMDAwMDAwMTAwMDAwMDAwLTB4MDAwMDAwMDE1ZmZmZmZmZl0KWyAgICAwLjAx
NTcyNl0gSW5pdG1lbSBzZXR1cCBub2RlIDAgW21lbSAweDAwMDAwMDAwMDAwMDEwMDAtMHgwMDAw
MDAwMTVmZmZmZmZmXQpbICAgIDAuMDE1NzM4XSBPbiBub2RlIDAsIHpvbmUgRE1BOiAxIHBhZ2Vz
IGluIHVuYXZhaWxhYmxlIHJhbmdlcwpbICAgIDAuMDE1Nzk5XSBPbiBub2RlIDAsIHpvbmUgRE1B
OiA5OSBwYWdlcyBpbiB1bmF2YWlsYWJsZSByYW5nZXMKWyAgICAwLjAxODMzOV0gT24gbm9kZSAw
LCB6b25lIERNQTMyOiAyNTYgcGFnZXMgaW4gdW5hdmFpbGFibGUgcmFuZ2VzClsgICAgMC4wMjg1
MjRdIE9uIG5vZGUgMCwgem9uZSBETUEzMjogMjU2IHBhZ2VzIGluIHVuYXZhaWxhYmxlIHJhbmdl
cwpbICAgIDAuMDI4NTYxXSBPbiBub2RlIDAsIHpvbmUgRE1BMzI6IDEyNTUgcGFnZXMgaW4gdW5h
dmFpbGFibGUgcmFuZ2VzClsgICAgMC4wMjg1NzVdIE9uIG5vZGUgMCwgem9uZSBETUEzMjogNjYg
cGFnZXMgaW4gdW5hdmFpbGFibGUgcmFuZ2VzClsgICAgMC4wMjg2MDBdIE9uIG5vZGUgMCwgem9u
ZSBETUEzMjogODQ0IHBhZ2VzIGluIHVuYXZhaWxhYmxlIHJhbmdlcwpbICAgIDAuMDM3NjM3XSBP
biBub2RlIDAsIHpvbmUgTm9ybWFsOiAyNDU3NiBwYWdlcyBpbiB1bmF2YWlsYWJsZSByYW5nZXMK
WyAgICAwLjAzNzY1NV0geDg2L2hwZXQ6IFdpbGwgZGlzYWJsZSB0aGUgSFBFVCBmb3IgdGhpcyBw
bGF0Zm9ybSBiZWNhdXNlIGl0J3Mgbm90IHJlbGlhYmxlClsgICAgMC4wMzc2NjFdIFJlc2Vydmlu
ZyBJbnRlbCBncmFwaGljcyBtZW1vcnkgYXQgW21lbSAweDliMDAwMDAwLTB4OWVmZmZmZmZdClsg
ICAgMC4wMzc3NjhdIEFDUEk6IFBNLVRpbWVyIElPIFBvcnQ6IDB4NDA4ClsgICAgMC4wMzc3OTJd
IEFDUEk6IExBUElDX05NSSAoYWNwaV9pZFsweDAxXSBsb3cgcmVzIGxpbnRbMHhjNl0pClsgICAg
MC4wMzc3OTddIEFDUEk6IE5NSSBub3QgY29ubmVjdGVkIHRvIExJTlQgMSEKWyAgICAwLjAzNzc5
OV0gQUNQSTogTEFQSUNfTk1JIChhY3BpX2lkWzB4MDJdIGhpZ2ggZGZsIGxpbnRbMHhkY10pClsg
ICAgMC4wMzc4MDJdIEFDUEk6IE5NSSBub3QgY29ubmVjdGVkIHRvIExJTlQgMSEKWyAgICAwLjAz
NzgwNF0gQUNQSTogTEFQSUNfTk1JIChhY3BpX2lkWzB4MDNdIGxvdyBlZGdlIGxpbnRbMHg5OV0p
ClsgICAgMC4wMzc4MDddIEFDUEk6IE5NSSBub3QgY29ubmVjdGVkIHRvIExJTlQgMSEKWyAgICAw
LjAzNzgwOV0gQUNQSTogTEFQSUNfTk1JIChhY3BpX2lkWzB4MDRdIGRmbCBkZmwgbGludFsweDc0
XSkKWyAgICAwLjAzNzgxMV0gQUNQSTogTk1JIG5vdCBjb25uZWN0ZWQgdG8gTElOVCAxIQpbICAg
IDAuMDM3ODI0XSBJT0FQSUNbMF06IGFwaWNfaWQgMSwgdmVyc2lvbiAzMiwgYWRkcmVzcyAweGZl
YzAwMDAwLCBHU0kgMC04NgpbICAgIDAuMDM3ODMyXSBBQ1BJOiBJTlRfU1JDX09WUiAoYnVzIDAg
YnVzX2lycSAwIGdsb2JhbF9pcnEgMiBkZmwgZGZsKQpbICAgIDAuMDM3ODM3XSBBQ1BJOiBJTlRf
U1JDX09WUiAoYnVzIDAgYnVzX2lycSA5IGdsb2JhbF9pcnEgOSBoaWdoIGxldmVsKQpbICAgIDAu
MDM3ODQ4XSBBQ1BJOiBVc2luZyBBQ1BJIChNQURUKSBmb3IgU01QIGNvbmZpZ3VyYXRpb24gaW5m
b3JtYXRpb24KWyAgICAwLjAzNzg1MV0gQUNQSTogSFBFVCBpZDogMHg4MDg2YTIwMSBiYXNlOiAw
eGZlZDAwMDAwClsgICAgMC4wMzc4NjNdIFRTQyBkZWFkbGluZSB0aW1lciBhdmFpbGFibGUKWyAg
ICAwLjAzNzg3N10gQ1BVIHRvcG86IE1heC4gbG9naWNhbCBwYWNrYWdlczogICAxClsgICAgMC4w
Mzc4NzldIENQVSB0b3BvOiBNYXguIGxvZ2ljYWwgZGllczogICAgICAgMQpbICAgIDAuMDM3ODgx
XSBDUFUgdG9wbzogTWF4LiBkaWVzIHBlciBwYWNrYWdlOiAgIDEKWyAgICAwLjAzNzg5NV0gQ1BV
IHRvcG86IE1heC4gdGhyZWFkcyBwZXIgY29yZTogICAxClsgICAgMC4wMzc4OThdIENQVSB0b3Bv
OiBOdW0uIGNvcmVzIHBlciBwYWNrYWdlOiAgICAgNApbICAgIDAuMDM3OTAwXSBDUFUgdG9wbzog
TnVtLiB0aHJlYWRzIHBlciBwYWNrYWdlOiAgIDQKWyAgICAwLjAzNzkwMl0gQ1BVIHRvcG86IEFs
bG93aW5nIDQgcHJlc2VudCBDUFVzIHBsdXMgMCBob3RwbHVnIENQVXMKWyAgICAwLjAzNzk2OF0g
UE06IGhpYmVybmF0aW9uOiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6IFttZW0gMHgwMDAwMDAw
MC0weDAwMDAwZmZmXQpbICAgIDAuMDM3OTc1XSBQTTogaGliZXJuYXRpb246IFJlZ2lzdGVyZWQg
bm9zYXZlIG1lbW9yeTogW21lbSAweDAwMDlkMDAwLTB4MDAwOWRmZmZdClsgICAgMC4wMzc5Nzhd
IFBNOiBoaWJlcm5hdGlvbjogUmVnaXN0ZXJlZCBub3NhdmUgbWVtb3J5OiBbbWVtIDB4MDAwOWUw
MDAtMHgwMDA5ZmZmZl0KWyAgICAwLjAzNzk4MF0gUE06IGhpYmVybmF0aW9uOiBSZWdpc3RlcmVk
IG5vc2F2ZSBtZW1vcnk6IFttZW0gMHgwMDBhMDAwMC0weDAwMGRmZmZmXQpbICAgIDAuMDM3OTgz
XSBQTTogaGliZXJuYXRpb246IFJlZ2lzdGVyZWQgbm9zYXZlIG1lbW9yeTogW21lbSAweDAwMGUw
MDAwLTB4MDAwZmZmZmZdClsgICAgMC4wMzc5ODhdIFBNOiBoaWJlcm5hdGlvbjogUmVnaXN0ZXJl
ZCBub3NhdmUgbWVtb3J5OiBbbWVtIDB4MWYwMDAwMDAtMHgxZjBmZmZmZl0KWyAgICAwLjAzNzk5
NF0gUE06IGhpYmVybmF0aW9uOiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6IFttZW0gMHgyMDAw
MDAwMC0weDIwMGZmZmZmXQpbICAgIDAuMDM4MDAwXSBQTTogaGliZXJuYXRpb246IFJlZ2lzdGVy
ZWQgbm9zYXZlIG1lbW9yeTogW21lbSAweDk5NjE1MDAwLTB4OTk2NDRmZmZdClsgICAgMC4wMzgw
MDJdIFBNOiBoaWJlcm5hdGlvbjogUmVnaXN0ZXJlZCBub3NhdmUgbWVtb3J5OiBbbWVtIDB4OTk2
NDUwMDAtMHg5OTY1NGZmZl0KWyAgICAwLjAzODAwNV0gUE06IGhpYmVybmF0aW9uOiBSZWdpc3Rl
cmVkIG5vc2F2ZSBtZW1vcnk6IFttZW0gMHg5OTY1NTAwMC0weDk5N2RhZmZmXQpbICAgIDAuMDM4
MDA3XSBQTTogaGliZXJuYXRpb246IFJlZ2lzdGVyZWQgbm9zYXZlIG1lbW9yeTogW21lbSAweDk5
N2RiMDAwLTB4OTlhZmJmZmZdClsgICAgMC4wMzgwMTNdIFBNOiBoaWJlcm5hdGlvbjogUmVnaXN0
ZXJlZCBub3NhdmUgbWVtb3J5OiBbbWVtIDB4OTlhZmQwMDAtMHg5OWIzZWZmZl0KWyAgICAwLjAz
ODAxOV0gUE06IGhpYmVybmF0aW9uOiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6IFttZW0gMHg5
OWNhZTAwMC0weDk5ZmY5ZmZmXQpbICAgIDAuMDM4MDI0XSBQTTogaGliZXJuYXRpb246IFJlZ2lz
dGVyZWQgbm9zYXZlIG1lbW9yeTogW21lbSAweDlhMDAwMDAwLTB4OWFmZmZmZmZdClsgICAgMC4w
MzgwMjddIFBNOiBoaWJlcm5hdGlvbjogUmVnaXN0ZXJlZCBub3NhdmUgbWVtb3J5OiBbbWVtIDB4
OWIwMDAwMDAtMHg5ZWZmZmZmZl0KWyAgICAwLjAzODAyOV0gUE06IGhpYmVybmF0aW9uOiBSZWdp
c3RlcmVkIG5vc2F2ZSBtZW1vcnk6IFttZW0gMHg5ZjAwMDAwMC0weGRmZmZmZmZmXQpbICAgIDAu
MDM4MDMyXSBQTTogaGliZXJuYXRpb246IFJlZ2lzdGVyZWQgbm9zYXZlIG1lbW9yeTogW21lbSAw
eGUwMDAwMDAwLTB4ZWZmZmZmZmZdClsgICAgMC4wMzgwMzRdIFBNOiBoaWJlcm5hdGlvbjogUmVn
aXN0ZXJlZCBub3NhdmUgbWVtb3J5OiBbbWVtIDB4ZjAwMDAwMDAtMHhmZWJmZmZmZl0KWyAgICAw
LjAzODAzN10gUE06IGhpYmVybmF0aW9uOiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6IFttZW0g
MHhmZWMwMDAwMC0weGZlYzAwZmZmXQpbICAgIDAuMDM4MDM5XSBQTTogaGliZXJuYXRpb246IFJl
Z2lzdGVyZWQgbm9zYXZlIG1lbW9yeTogW21lbSAweGZlYzAxMDAwLTB4ZmVkMDBmZmZdClsgICAg
MC4wMzgwNDJdIFBNOiBoaWJlcm5hdGlvbjogUmVnaXN0ZXJlZCBub3NhdmUgbWVtb3J5OiBbbWVt
IDB4ZmVkMDEwMDAtMHhmZWQwMWZmZl0KWyAgICAwLjAzODA0NF0gUE06IGhpYmVybmF0aW9uOiBS
ZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6IFttZW0gMHhmZWQwMjAwMC0weGZlZDAyZmZmXQpbICAg
IDAuMDM4MDQ3XSBQTTogaGliZXJuYXRpb246IFJlZ2lzdGVyZWQgbm9zYXZlIG1lbW9yeTogW21l
bSAweGZlZDAzMDAwLTB4ZmVkMDNmZmZdClsgICAgMC4wMzgwNDldIFBNOiBoaWJlcm5hdGlvbjog
UmVnaXN0ZXJlZCBub3NhdmUgbWVtb3J5OiBbbWVtIDB4ZmVkMDQwMDAtMHhmZWQwN2ZmZl0KWyAg
ICAwLjAzODA1Ml0gUE06IGhpYmVybmF0aW9uOiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6IFtt
ZW0gMHhmZWQwODAwMC0weGZlZDA4ZmZmXQpbICAgIDAuMDM4MDU0XSBQTTogaGliZXJuYXRpb246
IFJlZ2lzdGVyZWQgbm9zYXZlIG1lbW9yeTogW21lbSAweGZlZDA5MDAwLTB4ZmVkMGJmZmZdClsg
ICAgMC4wMzgwNTZdIFBNOiBoaWJlcm5hdGlvbjogUmVnaXN0ZXJlZCBub3NhdmUgbWVtb3J5OiBb
bWVtIDB4ZmVkMGMwMDAtMHhmZWQwZmZmZl0KWyAgICAwLjAzODA1OV0gUE06IGhpYmVybmF0aW9u
OiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6IFttZW0gMHhmZWQxMDAwMC0weGZlZDFiZmZmXQpb
ICAgIDAuMDM4MDYxXSBQTTogaGliZXJuYXRpb246IFJlZ2lzdGVyZWQgbm9zYXZlIG1lbW9yeTog
W21lbSAweGZlZDFjMDAwLTB4ZmVkMWNmZmZdClsgICAgMC4wMzgwNjRdIFBNOiBoaWJlcm5hdGlv
bjogUmVnaXN0ZXJlZCBub3NhdmUgbWVtb3J5OiBbbWVtIDB4ZmVkMWQwMDAtMHhmZWRmZmZmZl0K
WyAgICAwLjAzODA2Nl0gUE06IGhpYmVybmF0aW9uOiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6
IFttZW0gMHhmZWUwMDAwMC0weGZlZTAwZmZmXQpbICAgIDAuMDM4MDY5XSBQTTogaGliZXJuYXRp
b246IFJlZ2lzdGVyZWQgbm9zYXZlIG1lbW9yeTogW21lbSAweGZlZTAxMDAwLTB4ZmVlZmZmZmZd
ClsgICAgMC4wMzgwNzFdIFBNOiBoaWJlcm5hdGlvbjogUmVnaXN0ZXJlZCBub3NhdmUgbWVtb3J5
OiBbbWVtIDB4ZmVmMDAwMDAtMHhmZWZmZmZmZl0KWyAgICAwLjAzODA3NF0gUE06IGhpYmVybmF0
aW9uOiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6IFttZW0gMHhmZjAwMDAwMC0weGZmYWZmZmZm
XQpbICAgIDAuMDM4MDc2XSBQTTogaGliZXJuYXRpb246IFJlZ2lzdGVyZWQgbm9zYXZlIG1lbW9y
eTogW21lbSAweGZmYjAwMDAwLTB4ZmZmZmZmZmZdClsgICAgMC4wMzgwODFdIFttZW0gMHg5ZjAw
MDAwMC0weGRmZmZmZmZmXSBhdmFpbGFibGUgZm9yIFBDSSBkZXZpY2VzClsgICAgMC4wMzgwODRd
IEJvb3RpbmcgcGFyYXZpcnR1YWxpemVkIGtlcm5lbCBvbiBiYXJlIGhhcmR3YXJlClsgICAgMC4w
MzgwODldIGNsb2Nrc291cmNlOiByZWZpbmVkLWppZmZpZXM6IG1hc2s6IDB4ZmZmZmZmZmYgbWF4
X2N5Y2xlczogMHhmZmZmZmZmZiwgbWF4X2lkbGVfbnM6IDc2NDU1MTk2MDAyMTE1NjggbnMKWyAg
ICAwLjAzODEyMF0gc2V0dXBfcGVyY3B1OiBOUl9DUFVTOjgxOTIgbnJfY3B1bWFza19iaXRzOjQg
bnJfY3B1X2lkczo0IG5yX25vZGVfaWRzOjEKWyAgICAwLjAzOTE5Ml0gcGVyY3B1OiBFbWJlZGRl
ZCA2NiBwYWdlcy9jcHUgczIzMzQ3MiByODE5MiBkMjg2NzIgdTUyNDI4OApbICAgIDAuMDM5MjE2
XSBwY3B1LWFsbG9jOiBzMjMzNDcyIHI4MTkyIGQyODY3MiB1NTI0Mjg4IGFsbG9jPTEqMjA5NzE1
MgpbICAgIDAuMDM5MjI0XSBwY3B1LWFsbG9jOiBbMF0gMCAxIDIgMyAKWyAgICAwLjAzOTI4N10g
S2VybmVsIGNvbW1hbmQgbGluZTogQk9PVF9JTUFHRT0vdm1saW51ei02LjE0LjAtcmM1KyByb290
PS9kZXYvbWFwcGVyL3ZnMDAtcm9vdHZvbCBybyBxdWlldCAiZHluZGJnPWZpbGUgZHJpdmVycy9w
Y2kvKiArcDsgZmlsZSBkcml2ZXJzL2FjcGkvYnVzLmMgK3A7IGZpbGUgZHJpdmVycy9hY3BpL29z
bC5jICtwIgpbICAgIDAuMDM5NDQ0XSBVbmtub3duIGtlcm5lbCBjb21tYW5kIGxpbmUgcGFyYW1l
dGVycyAiQk9PVF9JTUFHRT0vdm1saW51ei02LjE0LjAtcmM1KyIsIHdpbGwgYmUgcGFzc2VkIHRv
IHVzZXIgc3BhY2UuClsgICAgMC4wMzk0NzJdIHJhbmRvbTogY3JuZyBpbml0IGRvbmUKWyAgICAw
LjAzOTQ3NV0gcHJpbnRrOiBsb2cgYnVmZmVyIGRhdGEgKyBtZXRhIGRhdGE6IDI2MjE0NCArIDkx
NzUwNCA9IDExNzk2NDggYnl0ZXMKWyAgICAwLjA0MDc0NF0gRGVudHJ5IGNhY2hlIGhhc2ggdGFi
bGUgZW50cmllczogNTI0Mjg4IChvcmRlcjogMTAsIDQxOTQzMDQgYnl0ZXMsIGxpbmVhcikKWyAg
ICAwLjA0MTQxN10gSW5vZGUtY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiAyNjIxNDQgKG9yZGVy
OiA5LCAyMDk3MTUyIGJ5dGVzLCBsaW5lYXIpClsgICAgMC4wNDE1NDldIEZhbGxiYWNrIG9yZGVy
IGZvciBOb2RlIDA6IDAgClsgICAgMC4wNDE1NjFdIEJ1aWx0IDEgem9uZWxpc3RzLCBtb2JpbGl0
eSBncm91cGluZyBvbi4gIFRvdGFsIHBhZ2VzOiAxMDIxMjIzClsgICAgMC4wNDE1NjVdIFBvbGlj
eSB6b25lOiBOb3JtYWwKWyAgICAwLjA0MTU4N10gbWVtIGF1dG8taW5pdDogc3RhY2s6b2ZmLCBo
ZWFwIGFsbG9jOm9uLCBoZWFwIGZyZWU6b2ZmClsgICAgMC4wNDE2MDBdIHNvZnR3YXJlIElPIFRM
QjogYXJlYSBudW0gNC4KWyAgICAwLjEyMDU5NV0gU0xVQjogSFdhbGlnbj02NCwgT3JkZXI9MC0z
LCBNaW5PYmplY3RzPTAsIENQVXM9NCwgTm9kZXM9MQpbICAgIDAuMTIwNjY3XSBLZXJuZWwvVXNl
ciBwYWdlIHRhYmxlcyBpc29sYXRpb246IGVuYWJsZWQKWyAgICAwLjEyMDc3MF0gZnRyYWNlOiBh
bGxvY2F0aW5nIDU1MDE5IGVudHJpZXMgaW4gMjE1IHBhZ2VzClsgICAgMC4yMDM3MDZdIGZ0cmFj
ZTogYWxsb2NhdGVkIDIxNSBwYWdlcyB3aXRoIDYgZ3JvdXBzClsgICAgMC4yMDU1NTldIER5bmFt
aWMgUHJlZW1wdDogdm9sdW50YXJ5ClsgICAgMC4yMDU2OTldIHJjdTogUHJlZW1wdGlibGUgaGll
cmFyY2hpY2FsIFJDVSBpbXBsZW1lbnRhdGlvbi4KWyAgICAwLjIwNTcwMl0gcmN1OiAJUkNVIHJl
c3RyaWN0aW5nIENQVXMgZnJvbSBOUl9DUFVTPTgxOTIgdG8gbnJfY3B1X2lkcz00LgpbICAgIDAu
MjA1NzA2XSAJVHJhbXBvbGluZSB2YXJpYW50IG9mIFRhc2tzIFJDVSBlbmFibGVkLgpbICAgIDAu
MjA1NzA4XSAJUnVkZSB2YXJpYW50IG9mIFRhc2tzIFJDVSBlbmFibGVkLgpbICAgIDAuMjA1NzA5
XSAJVHJhY2luZyB2YXJpYW50IG9mIFRhc2tzIFJDVSBlbmFibGVkLgpbICAgIDAuMjA1NzExXSBy
Y3U6IFJDVSBjYWxjdWxhdGVkIHZhbHVlIG9mIHNjaGVkdWxlci1lbmxpc3RtZW50IGRlbGF5IGlz
IDI1IGppZmZpZXMuClsgICAgMC4yMDU3MTRdIHJjdTogQWRqdXN0aW5nIGdlb21ldHJ5IGZvciBy
Y3VfZmFub3V0X2xlYWY9MTYsIG5yX2NwdV9pZHM9NApbICAgIDAuMjA1NzMyXSBSQ1UgVGFza3M6
IFNldHRpbmcgc2hpZnQgdG8gMiBhbmQgbGltIHRvIDEgcmN1X3Rhc2tfY2JfYWRqdXN0PTEgcmN1
X3Rhc2tfY3B1X2lkcz00LgpbICAgIDAuMjA1NzM4XSBSQ1UgVGFza3MgUnVkZTogU2V0dGluZyBz
aGlmdCB0byAyIGFuZCBsaW0gdG8gMSByY3VfdGFza19jYl9hZGp1c3Q9MSByY3VfdGFza19jcHVf
aWRzPTQuClsgICAgMC4yMDU3NDJdIFJDVSBUYXNrcyBUcmFjZTogU2V0dGluZyBzaGlmdCB0byAy
IGFuZCBsaW0gdG8gMSByY3VfdGFza19jYl9hZGp1c3Q9MSByY3VfdGFza19jcHVfaWRzPTQuClsg
ICAgMC4yMTcxNTJdIE5SX0lSUVM6IDUyNDU0NCwgbnJfaXJxczogMTAyNCwgcHJlYWxsb2NhdGVk
IGlycXM6IDE2ClsgICAgMC4yMTc0ODZdIHJjdTogc3JjdV9pbml0OiBTZXR0aW5nIHNyY3Vfc3Ry
dWN0IHNpemVzIGJhc2VkIG9uIGNvbnRlbnRpb24uClsgICAgMC4yMTc2MTldIHNwdXJpb3VzIDgy
NTlBIGludGVycnVwdDogSVJRNy4KWyAgICAwLjIxNzY2M10gQ29uc29sZTogY29sb3VyIGR1bW15
IGRldmljZSA4MHgyNQpbICAgIDAuMjE3NjcyXSBwcmludGs6IGxlZ2FjeSBjb25zb2xlIFt0dHkw
XSBlbmFibGVkClsgICAgMC4yMTc4MThdIEFDUEk6IENvcmUgcmV2aXNpb24gMjAyNDA4MjcKWyAg
ICAwLjIxNzk4N10gQVBJQzogU3dpdGNoIHRvIHN5bW1ldHJpYyBJL08gbW9kZSBzZXR1cApbICAg
IDAuMjE4NTc1XSBjbG9ja3NvdXJjZTogdHNjLWVhcmx5OiBtYXNrOiAweGZmZmZmZmZmZmZmZmZm
ZmYgbWF4X2N5Y2xlczogMHgzNzQxNTk0ZDM0ZCwgbWF4X2lkbGVfbnM6IDg4MTU5MDQyMDU2NCBu
cwpbICAgIDAuMjE4NTkyXSBDYWxpYnJhdGluZyBkZWxheSBsb29wIChza2lwcGVkKSwgdmFsdWUg
Y2FsY3VsYXRlZCB1c2luZyB0aW1lciBmcmVxdWVuY3kuLiAzODMzLjMzIEJvZ29NSVBTIChscGo9
NzY2NjY2OCkKWyAgICAwLjIxODY2MV0gTGFzdCBsZXZlbCBpVExCIGVudHJpZXM6IDRLQiA0OCwg
Mk1CIDAsIDRNQiAwClsgICAgMC4yMTg2NjddIExhc3QgbGV2ZWwgZFRMQiBlbnRyaWVzOiA0S0Ig
MTI4LCAyTUIgMTYsIDRNQiAxNiwgMUdCIDAKWyAgICAwLjIxODY3N10gcHJvY2VzczogdXNpbmcg
bXdhaXQgaW4gaWRsZSB0aHJlYWRzClsgICAgMC4yMTg2ODVdIFNwZWN0cmUgVjEgOiBNaXRpZ2F0
aW9uOiB1c2VyY29weS9zd2FwZ3MgYmFycmllcnMgYW5kIF9fdXNlciBwb2ludGVyIHNhbml0aXph
dGlvbgpbICAgIDAuMjE4NjkyXSBTcGVjdHJlIFYyIDogTWl0aWdhdGlvbjogUmV0cG9saW5lcwpb
ICAgIDAuMjE4Njk1XSBTcGVjdHJlIFYyIDogU3BlY3RyZSB2MiAvIFNwZWN0cmVSU0IgbWl0aWdh
dGlvbjogRmlsbGluZyBSU0Igb24gY29udGV4dCBzd2l0Y2gKWyAgICAwLjIxODY5OF0gU3BlY3Ry
ZSBWMiA6IFNwZWN0cmUgdjIgLyBTcGVjdHJlUlNCIDogRmlsbGluZyBSU0Igb24gVk1FWElUClsg
ICAgMC4yMTg3MDFdIFNwZWN0cmUgVjIgOiBFbmFibGluZyBSZXN0cmljdGVkIFNwZWN1bGF0aW9u
IGZvciBmaXJtd2FyZSBjYWxscwpbICAgIDAuMjE4NzA3XSBTcGVjdHJlIFYyIDogbWl0aWdhdGlv
bjogRW5hYmxpbmcgY29uZGl0aW9uYWwgSW5kaXJlY3QgQnJhbmNoIFByZWRpY3Rpb24gQmFycmll
cgpbICAgIDAuMjE4NzEyXSBNRFM6IE1pdGlnYXRpb246IENsZWFyIENQVSBidWZmZXJzClsgICAg
MC4yMTg3MTZdIE1NSU8gU3RhbGUgRGF0YTogVW5rbm93bjogTm8gbWl0aWdhdGlvbnMKWyAgICAw
LjIxODcyMV0geDg2L2ZwdTogeDg3IEZQVSB3aWxsIHVzZSBGWFNBVkUKWyAgICAwLjIyMjU4Nl0g
RnJlZWluZyBTTVAgYWx0ZXJuYXRpdmVzIG1lbW9yeTogNDRLClsgICAgMC4yMjI1ODZdIHBpZF9t
YXg6IGRlZmF1bHQ6IDMyNzY4IG1pbmltdW06IDMwMQpbICAgIDAuMjIyNTg2XSBMU006IGluaXRp
YWxpemluZyBsc209bG9ja2Rvd24sY2FwYWJpbGl0eSx5YW1hLGFwcGFybW9yLGltYSxldm0KWyAg
ICAwLjIyMjU4Nl0gWWFtYTogYmVjb21pbmcgbWluZGZ1bC4KWyAgICAwLjIyMjU4Nl0gQXBwQXJt
b3I6IEFwcEFybW9yIGluaXRpYWxpemVkClsgICAgMC4yMjI1ODZdIE1vdW50LWNhY2hlIGhhc2gg
dGFibGUgZW50cmllczogODE5MiAob3JkZXI6IDQsIDY1NTM2IGJ5dGVzLCBsaW5lYXIpClsgICAg
MC4yMjI1ODZdIE1vdW50cG9pbnQtY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiA4MTkyIChvcmRl
cjogNCwgNjU1MzYgYnl0ZXMsIGxpbmVhcikKWyAgICAwLjIyMjU4Nl0gc21wYm9vdDogQ1BVMDog
SW50ZWwoUikgQXRvbShUTSkgQ1BVICBFMzg0NSAgQCAxLjkxR0h6IChmYW1pbHk6IDB4NiwgbW9k
ZWw6IDB4MzcsIHN0ZXBwaW5nOiAweDkpClsgICAgMC4yMjI1ODZdIFBlcmZvcm1hbmNlIEV2ZW50
czogUEVCUyBmbXQyKywgOC1kZWVwIExCUiwgU2lsdmVybW9udCBldmVudHMsIDgtZGVlcCBMQlIs
IGZ1bGwtd2lkdGggY291bnRlcnMsIEludGVsIFBNVSBkcml2ZXIuClsgICAgMC4yMjI1ODZdIC4u
LiB2ZXJzaW9uOiAgICAgICAgICAgICAgICAzClsgICAgMC4yMjI1ODZdIC4uLiBiaXQgd2lkdGg6
ICAgICAgICAgICAgICA0MApbICAgIDAuMjIyNTg2XSAuLi4gZ2VuZXJpYyByZWdpc3RlcnM6ICAg
ICAgMgpbICAgIDAuMjIyNTg2XSAuLi4gdmFsdWUgbWFzazogICAgICAgICAgICAgMDAwMDAwZmZm
ZmZmZmZmZgpbICAgIDAuMjIyNTg2XSAuLi4gbWF4IHBlcmlvZDogICAgICAgICAgICAgMDAwMDAw
N2ZmZmZmZmZmZgpbICAgIDAuMjIyNTg2XSAuLi4gZml4ZWQtcHVycG9zZSBldmVudHM6ICAgMwpb
ICAgIDAuMjIyNTg2XSAuLi4gZXZlbnQgbWFzazogICAgICAgICAgICAgMDAwMDAwMDcwMDAwMDAw
MwpbICAgIDAuMjIyNTg2XSBzaWduYWw6IG1heCBzaWdmcmFtZSBzaXplOiAxNDQwClsgICAgMC4y
MjI1ODZdIEVzdGltYXRlZCByYXRpbyBvZiBhdmVyYWdlIG1heCBmcmVxdWVuY3kgYnkgYmFzZSBm
cmVxdWVuY3kgKHRpbWVzIDEwMjQpOiAxMDI0ClsgICAgMC4yMjI1ODZdIHJjdTogSGllcmFyY2hp
Y2FsIFNSQ1UgaW1wbGVtZW50YXRpb24uClsgICAgMC4yMjI1ODZdIHJjdTogCU1heCBwaGFzZSBu
by1kZWxheSBpbnN0YW5jZXMgaXMgMTAwMC4KWyAgICAwLjIyMjU4Nl0gVGltZXIgbWlncmF0aW9u
OiAxIGhpZXJhcmNoeSBsZXZlbHM7IDggY2hpbGRyZW4gcGVyIGdyb3VwOyAxIGNyb3Nzbm9kZSBs
ZXZlbApbICAgIDAuMjIzNjUxXSBOTUkgd2F0Y2hkb2c6IEVuYWJsZWQuIFBlcm1hbmVudGx5IGNv
bnN1bWVzIG9uZSBody1QTVUgY291bnRlci4KWyAgICAwLjIyMzg2NV0gc21wOiBCcmluZ2luZyB1
cCBzZWNvbmRhcnkgQ1BVcyAuLi4KWyAgICAwLjIzMDc1OF0gc21wYm9vdDogeDg2OiBCb290aW5n
IFNNUCBjb25maWd1cmF0aW9uOgpbICAgIDAuMjMwNzY1XSAuLi4uIG5vZGUgICMwLCBDUFVzOiAg
ICAgICMxICMyICMzClsgICAgMC4yNjI3NDNdIHNtcDogQnJvdWdodCB1cCAxIG5vZGUsIDQgQ1BV
cwpbICAgIDAuMjYyNzQzXSBzbXBib290OiBUb3RhbCBvZiA0IHByb2Nlc3NvcnMgYWN0aXZhdGVk
ICgxNTMzMy4zMyBCb2dvTUlQUykKWyAgICAwLjI2MzI3M10gTWVtb3J5OiAzNzQ3NzI4Sy80MDg0
ODkySyBhdmFpbGFibGUgKDE3OTA1SyBrZXJuZWwgY29kZSwgMzI4MEsgcndkYXRhLCAxMzQ4MEsg
cm9kYXRhLCA0Nzg0SyBpbml0LCA2MTAwSyBic3MsIDMyOTQxMksgcmVzZXJ2ZWQsIDBLIGNtYS1y
ZXNlcnZlZCkKWyAgICAwLjI2MzMxN10gZGV2dG1wZnM6IGluaXRpYWxpemVkClsgICAgMC4yNjMz
MTddIHg4Ni9tbTogTWVtb3J5IGJsb2NrIHNpemU6IDEyOE1CClsgICAgMC4yNjcxNTFdIEFDUEk6
IFBNOiBSZWdpc3RlcmluZyBBQ1BJIE5WUyByZWdpb24gW21lbSAweDk5NjU1MDAwLTB4OTk3ZGFm
ZmZdICgxNTk3NDQwIGJ5dGVzKQpbICAgIDAuMjY3MTUxXSBjbG9ja3NvdXJjZTogamlmZmllczog
bWFzazogMHhmZmZmZmZmZiBtYXhfY3ljbGVzOiAweGZmZmZmZmZmLCBtYXhfaWRsZV9uczogNzY0
NTA0MTc4NTEwMDAwMCBucwpbICAgIDAuMjY3MTUxXSBmdXRleCBoYXNoIHRhYmxlIGVudHJpZXM6
IDEwMjQgKG9yZGVyOiA0LCA2NTUzNiBieXRlcywgbGluZWFyKQpbICAgIDAuMjY3MTUxXSBwaW5j
dHJsIGNvcmU6IGluaXRpYWxpemVkIHBpbmN0cmwgc3Vic3lzdGVtClsgICAgMC4yNjcyNjFdIFBN
OiBSVEMgdGltZTogMTY6MjM6NDMsIGRhdGU6IDIwMjUtMDMtMDYKWyAgICAwLjI2OTIxOV0gTkVU
OiBSZWdpc3RlcmVkIFBGX05FVExJTksvUEZfUk9VVEUgcHJvdG9jb2wgZmFtaWx5ClsgICAgMC4y
Njk3ODBdIERNQTogcHJlYWxsb2NhdGVkIDUxMiBLaUIgR0ZQX0tFUk5FTCBwb29sIGZvciBhdG9t
aWMgYWxsb2NhdGlvbnMKWyAgICAwLjI3MDY4MF0gRE1BOiBwcmVhbGxvY2F0ZWQgNTEyIEtpQiBH
RlBfS0VSTkVMfEdGUF9ETUEgcG9vbCBmb3IgYXRvbWljIGFsbG9jYXRpb25zClsgICAgMC4yNzA4
NThdIERNQTogcHJlYWxsb2NhdGVkIDUxMiBLaUIgR0ZQX0tFUk5FTHxHRlBfRE1BMzIgcG9vbCBm
b3IgYXRvbWljIGFsbG9jYXRpb25zClsgICAgMC4yNzA5MTNdIGF1ZGl0OiBpbml0aWFsaXppbmcg
bmV0bGluayBzdWJzeXMgKGRpc2FibGVkKQpbICAgIDAuMjcwOTY4XSBhdWRpdDogdHlwZT0yMDAw
IGF1ZGl0KDE3NDEyNzgyMjMuMDUyOjEpOiBzdGF0ZT1pbml0aWFsaXplZCBhdWRpdF9lbmFibGVk
PTAgcmVzPTEKWyAgICAwLjI3MDk5MV0gdGhlcm1hbF9zeXM6IFJlZ2lzdGVyZWQgdGhlcm1hbCBn
b3Zlcm5vciAnZmFpcl9zaGFyZScKWyAgICAwLjI3MDk5N10gdGhlcm1hbF9zeXM6IFJlZ2lzdGVy
ZWQgdGhlcm1hbCBnb3Zlcm5vciAnYmFuZ19iYW5nJwpbICAgIDAuMjcxMDAyXSB0aGVybWFsX3N5
czogUmVnaXN0ZXJlZCB0aGVybWFsIGdvdmVybm9yICdzdGVwX3dpc2UnClsgICAgMC4yNzEwMDVd
IHRoZXJtYWxfc3lzOiBSZWdpc3RlcmVkIHRoZXJtYWwgZ292ZXJub3IgJ3VzZXJfc3BhY2UnClsg
ICAgMC4yNzEwMzJdIEVJU0EgYnVzIHJlZ2lzdGVyZWQKWyAgICAwLjI3MTA1N10gY3B1aWRsZTog
dXNpbmcgZ292ZXJub3IgbGFkZGVyClsgICAgMC4yNzEwNTddIGNwdWlkbGU6IHVzaW5nIGdvdmVy
bm9yIG1lbnUKWyAgICAwLjI3MTA1N10gYWNwaXBocDogQUNQSSBIb3QgUGx1ZyBQQ0kgQ29udHJv
bGxlciBEcml2ZXIgdmVyc2lvbjogMC41ClsgICAgMC4yNzEwNTddIFBDSTogRUNBTSBbbWVtIDB4
ZTAwMDAwMDAtMHhlZmZmZmZmZl0gKGJhc2UgMHhlMDAwMDAwMCkgZm9yIGRvbWFpbiAwMDAwIFti
dXMgMDAtZmZdClsgICAgMC4yNzEwNzRdIFBDSTogVXNpbmcgY29uZmlndXJhdGlvbiB0eXBlIDEg
Zm9yIGJhc2UgYWNjZXNzClsgICAgMC4yNzEyOTVdIGtwcm9iZXM6IGtwcm9iZSBqdW1wLW9wdGlt
aXphdGlvbiBpcyBlbmFibGVkLiBBbGwga3Byb2JlcyBhcmUgb3B0aW1pemVkIGlmIHBvc3NpYmxl
LgpbICAgIDAuMjc0ODgwXSBIdWdlVExCOiByZWdpc3RlcmVkIDIuMDAgTWlCIHBhZ2Ugc2l6ZSwg
cHJlLWFsbG9jYXRlZCAwIHBhZ2VzClsgICAgMC4yNzQ4ODBdIEh1Z2VUTEI6IDI4IEtpQiB2bWVt
bWFwIGNhbiBiZSBmcmVlZCBmb3IgYSAyLjAwIE1pQiBwYWdlClsgICAgMC4yNzQ5MzZdIEFDUEk6
IEFkZGVkIF9PU0koTW9kdWxlIERldmljZSkKWyAgICAwLjI3NDkzNl0gQUNQSTogQWRkZWQgX09T
SShQcm9jZXNzb3IgRGV2aWNlKQpbICAgIDAuMjc0OTM2XSBBQ1BJOiBBZGRlZCBfT1NJKDMuMCBf
U0NQIEV4dGVuc2lvbnMpClsgICAgMC4yNzQ5MzZdIEFDUEk6IEFkZGVkIF9PU0koUHJvY2Vzc29y
IEFnZ3JlZ2F0b3IgRGV2aWNlKQpbICAgIDAuMjk0NjA3XSBBQ1BJOiA0IEFDUEkgQU1MIHRhYmxl
cyBzdWNjZXNzZnVsbHkgYWNxdWlyZWQgYW5kIGxvYWRlZApbICAgIDAuMzI3MjU2XSBBQ1BJOiBE
eW5hbWljIE9FTSBUYWJsZSBMb2FkOgpbICAgIDAuMzI3Mjc5XSBBQ1BJOiBTU0RUIDB4RkZGRjk2
MjFDMDMyN0MwMCAwMDAzN0EgKHYwMSBQbVJlZiAgQ3B1MElzdCAgMDAwMDMwMDAgSU5UTCAyMDA2
MTEwOSkKWyAgICAwLjMyOTE1MV0gQUNQSTogRHluYW1pYyBPRU0gVGFibGUgTG9hZDoKWyAgICAw
LjMyOTE2OF0gQUNQSTogU1NEVCAweEZGRkY5NjIxQzA5MkM4MDAgMDAwNDMzICh2MDEgUG1SZWYg
IENwdTBDc3QgIDAwMDAzMDAxIElOVEwgMjAwNjExMDkpClsgICAgMC4zMzEzODVdIEFDUEk6IER5
bmFtaWMgT0VNIFRhYmxlIExvYWQ6ClsgICAgMC4zMzE0MDJdIEFDUEk6IFNTRFQgMHhGRkZGOTYy
MUMwMjgyODAwIDAwMDE1RiAodjAxIFBtUmVmICBBcElzdCAgICAwMDAwMzAwMCBJTlRMIDIwMDYx
MTA5KQpbICAgIDAuMzMyNzc1XSBBQ1BJOiBEeW5hbWljIE9FTSBUYWJsZSBMb2FkOgpbICAgIDAu
MzMyNzkwXSBBQ1BJOiBTU0RUIDB4RkZGRjk2MjFDMEQyOEQ4MCAwMDAwOEQgKHYwMSBQbVJlZiAg
QXBDc3QgICAgMDAwMDMwMDAgSU5UTCAyMDA2MTEwOSkKWyAgICAwLjMzNzI0OF0gQUNQSTogSW50
ZXJwcmV0ZXIgZW5hYmxlZApbICAgIDAuMzM3MzA3XSBBQ1BJOiBQTTogKHN1cHBvcnRzIFMwIFMz
IFM0IFM1KQpbICAgIDAuMzM3MzEzXSBBQ1BJOiBVc2luZyBJT0FQSUMgZm9yIGludGVycnVwdCBy
b3V0aW5nClsgICAgMC4zMzc0MThdIFBDSTogVXNpbmcgaG9zdCBicmlkZ2Ugd2luZG93cyBmcm9t
IEFDUEk7IGlmIG5lY2Vzc2FyeSwgdXNlICJwY2k9bm9jcnMiIGFuZCByZXBvcnQgYSBidWcKWyAg
ICAwLjMzNzQyNF0gUENJOiBJZ25vcmluZyBFODIwIHJlc2VydmF0aW9ucyBmb3IgaG9zdCBicmlk
Z2Ugd2luZG93cwpbICAgIDAuMzM4NTE0XSBBQ1BJOiBFbmFibGVkIDEzIEdQRXMgaW4gYmxvY2sg
MDAgdG8gM0YKWyAgICAwLjMzODc5Ml0gQUNQSTogRGV2aWNlIFtBQ1BJXSBzdGF0dXMgWzAwMDAw
MDBmXQpbICAgIDAuMzM4OTQ4XSBBQ1BJOiBEZXZpY2UgW0NQVTBdIHN0YXR1cyBbMDAwMDAwMGZd
ClsgICAgMC4zMzkwNDZdIEFDUEk6IERldmljZSBbQ1BVMV0gc3RhdHVzIFswMDAwMDAwZl0KWyAg
ICAwLjMzOTEzOV0gQUNQSTogRGV2aWNlIFtDUFUyXSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgIDAu
MzM5MjM5XSBBQ1BJOiBEZXZpY2UgW0NQVTNdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgMC4zMzkz
NjZdIEFDUEk6IERldmljZSBbX1NCXSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgIDAuMzM5NTE5XSBB
Q1BJOiBEZXZpY2UgW1JUQzBdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgMC4zMzk3NjddIEFDUEk6
IERldmljZSBbSFBFVF0gc3RhdHVzIFswMDAwMDAwZl0KWyAgICAwLjM0MDk3OV0gQUNQSTogRGV2
aWNlIFtQQ0kwXSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgIDAuMzQxMTEzXSBBQ1BJOiBEZXZpY2Ug
W1ZMVkNdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgMC4zNDEyNTVdIEFDUEk6IERldmljZSBbR0ZY
MF0gc3RhdHVzIFswMDAwMDAwZl0KWyAgICAwLjM0MTQ5NF0gQUNQSTogRGV2aWNlIFtERDAxXSBz
dGF0dXMgWzAwMDAwMDBmXQpbICAgIDAuMzQxNzMyXSBBQ1BJOiBEZXZpY2UgW0REMDJdIHN0YXR1
cyBbMDAwMDAwMGZdClsgICAgMC4zNDE5NTNdIEFDUEk6IERldmljZSBbREQwM10gc3RhdHVzIFsw
MDAwMDAwZl0KWyAgICAwLjM0MjE3N10gQUNQSTogRGV2aWNlIFtERDA0XSBzdGF0dXMgWzAwMDAw
MDBmXQpbICAgIDAuMzQyNDAyXSBBQ1BJOiBEZXZpY2UgW0REMDVdIHN0YXR1cyBbMDAwMDAwMGZd
ClsgICAgMC4zNDI3NDldIEFDUEk6IERldmljZSBbREQwNl0gc3RhdHVzIFswMDAwMDAwZl0KWyAg
ICAwLjM0Mjk1NV0gQUNQSTogRGV2aWNlIFtERDA3XSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgIDAu
MzQzMTUyXSBBQ1BJOiBEZXZpY2UgW0REMDhdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgMC4zNDMz
NTZdIEFDUEk6IERldmljZSBbREQxRl0gc3RhdHVzIFswMDAwMDAwZl0KWyAgICAwLjM0MzY4OV0g
QUNQSTogRGV2aWNlIFtJU1AwXSBzdGF0dXMgWzAwMDAwMDAwXQpbICAgIDAuMzQzODE3XSBBQ1BJ
OiBEZXZpY2UgW1NCUkddIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgMC4zNDM5OTldIEFDUEk6IERl
dmljZSBbSF9FQ10gc3RhdHVzIFswMDAwMDAwMF0KWyAgICAwLjM0NDE4MV0gQUNQSTogRGV2aWNl
IFtCQVQwXSBzdGF0dXMgWzAwMDAwMDAwXQpbICAgIDAuMzQ0MzUyXSBBQ1BJOiBEZXZpY2UgW0JB
VDFdIHN0YXR1cyBbMDAwMDAwMDBdClsgICAgMC4zNDQ1MDldIEFDUEk6IERldmljZSBbQkFUMl0g
c3RhdHVzIFswMDAwMDAwMF0KWyAgICAwLjM0NDY1OV0gQUNQSTogRGV2aWNlIFtGV0hEXSBzdGF0
dXMgWzAwMDAwMDBmXQpbICAgIDAuMzQ0ODE5XSBBQ1BJOiBEZXZpY2UgW0lQSUNdIHN0YXR1cyBb
MDAwMDAwMGZdClsgICAgMC4zNDQ5ODZdIEFDUEk6IERldmljZSBbTERSQ10gc3RhdHVzIFswMDAw
MDAwZl0KWyAgICAwLjM0NTEyN10gQUNQSTogRGV2aWNlIFtUSU1SXSBzdGF0dXMgWzAwMDAwMDBm
XQpbICAgIDAuMzQ1MzAyXSBBQ1BJOiBEZXZpY2UgW1dQQ05dIHN0YXR1cyBbMDAwMDAwMDBdClsg
ICAgMC4zNDU2NzJdIEFDUEk6IERldmljZSBbVUFSNV0gc3RhdHVzIFswMDAwMDAwMF0KWyAgICAw
LjM0NjE0OF0gQUNQSTogRGV2aWNlIFtVQVI4XSBzdGF0dXMgWzAwMDAwMDAwXQpbICAgIDAuMzQ3
MDkxXSBBQ1BJOiBEZXZpY2UgW1NJTzFdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgMC4zNDk1Njhd
IEFDUEk6IERldmljZSBbTFBURV0gc3RhdHVzIFswMDAwMDAwMF0KWyAgICAwLjM1MDA1NV0gQUNQ
STogRGV2aWNlIFtQUzJLXSBzdGF0dXMgWzAwMDAwMDAwXQpbICAgIDAuMzUxMDE1XSBBQ1BJOiBE
ZXZpY2UgW1BTMk1dIHN0YXR1cyBbMDAwMDAwMDBdClsgICAgMC4zNTE1MTRdIEFDUEk6IERldmlj
ZSBbU1NQSV0gc3RhdHVzIFswMDAwMDAwMF0KWyAgICAwLjM1MTY3M10gQUNQSTogRGV2aWNlIFtT
R1BJXSBzdGF0dXMgWzAwMDAwMDAwXQpbICAgIDAuMzUxODM0XSBBQ1BJOiBEZXZpY2UgW1NIV01d
IHN0YXR1cyBbMDAwMDAwMDBdClsgICAgMC4zNTE5OTFdIEFDUEk6IERldmljZSBbU0NQSV0gc3Rh
dHVzIFswMDAwMDAwMF0KWyAgICAwLjM1MzI5Nl0gQUNQSTogRGV2aWNlIFtVQVIxXSBzdGF0dXMg
WzAwMDAwMDAwXQpbICAgIDAuMzU0NTcyXSBBQ1BJOiBEZXZpY2UgW1VBUjJdIHN0YXR1cyBbMDAw
MDAwMDBdClsgICAgMC4zNTQ3MDddIEFDUEk6IERldmljZSBbQURQMV0gc3RhdHVzIFswMDAwMDAw
Zl0KWyAgICAxLjk3NDk2OF0gQUNQSTogRGV2aWNlIFtCQVQxXSBzdGF0dXMgWzAwMDAwMDBmXQpb
ICAgIDIuNzg1NTA3XSBBQ1BJOiBEZXZpY2UgW0JBVDJdIHN0YXR1cyBbMDAwMDAwMDBdClsgICAg
Mi43ODU5MDBdIEFDUEk6IERldmljZSBbUENVMV0gc3RhdHVzIFswMDAwMDAwZl0KWyAgICAyLjc4
NjAzOV0gQUNQSTogRGV2aWNlIFtEMDA0XSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgIDIuNzg2MTQ2
XSBBQ1BJOiBEZXZpY2UgW0QwMDVdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgMi43ODYyNTZdIEFD
UEk6IERldmljZSBbRDAwNl0gc3RhdHVzIFswMDAwMDAwZl0KWyAgICAyLjk4MjYxNF0gQUNQSTog
RGV2aWNlIFtTQVRBXSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgIDIuOTgyODA0XSBBQ1BJOiBEZXZp
Y2UgW1hIQzFdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgMi45ODMwNzFdIEFDUEk6IERldmljZSBb
UkhVQl0gc3RhdHVzIFswMDAwMDAwZl0KWyAgICAyLjk4MzE3N10gQUNQSTogRGV2aWNlIFtTU1Ax
XSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgIDIuOTgzMzQ4XSBBQ1BJOiBEZXZpY2UgW0hTMDFdIHN0
YXR1cyBbMDAwMDAwMGZdClsgICAgMi45ODM1MTJdIEFDUEk6IERldmljZSBbSFMwMl0gc3RhdHVz
IFswMDAwMDAwZl0KWyAgICAyLjk4MzY4MV0gQUNQSTogRGV2aWNlIFtIUzAzXSBzdGF0dXMgWzAw
MDAwMDBmXQpbICAgIDIuOTgzODQ0XSBBQ1BJOiBEZXZpY2UgW0hTMDRdIHN0YXR1cyBbMDAwMDAw
MGZdClsgICAgMi45ODQwMTNdIEFDUEk6IERldmljZSBbSFNDMV0gc3RhdHVzIFswMDAwMDAwZl0K
WyAgICAyLjk4NDE3NV0gQUNQSTogRGV2aWNlIFtIU0MyXSBzdGF0dXMgWzAwMDAwMDBmXQpbICAg
IDIuOTg0MzQ3XSBBQ1BJOiBEZXZpY2UgW0QwMDldIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgMi45
ODQ0NTJdIEFDUEk6IERldmljZSBbWEhDMl0gc3RhdHVzIFswMDAwMDAwZl0KWyAgICAyLjk4NDU2
Ml0gQUNQSTogRGV2aWNlIFtEMDBCXSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgIDIuOTg0NjY2XSBB
Q1BJOiBEZXZpY2UgW0dMQU5dIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgMi45ODQ4NDldIEFDUEk6
IERldmljZSBbSERFRl0gc3RhdHVzIFswMDAwMDAwZl0KWyAgICAyLjk4NTA2OF0gQUNQSTogRGV2
aWNlIFtFSEMxXSBzdGF0dXMgWzAwMDAwMDAwXQpbICAgIDIuOTg1MzExXSBBQ1BJOiBEZXZpY2Ug
W0hVQk5dIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgMi45ODU0MjJdIEFDUEk6IERldmljZSBbUFIw
MV0gc3RhdHVzIFswMDAwMDAwZl0KWyAgICAyLjk4NTU0MF0gQUNQSTogRGV2aWNlIFtQUjExXSBz
dGF0dXMgWzAwMDAwMDBmXQpbICAgIDIuOTg1NjY1XSBBQ1BJOiBEZXZpY2UgW1BSMTJdIHN0YXR1
cyBbMDAwMDAwMGZdClsgICAgMi45ODU3ODNdIEFDUEk6IERldmljZSBbUFIxM10gc3RhdHVzIFsw
MDAwMDAwZl0KWyAgICAyLjk4NTkwNl0gQUNQSTogRGV2aWNlIFtQUjE0XSBzdGF0dXMgWzAwMDAw
MDBmXQpbICAgIDIuOTg2MDI0XSBBQ1BJOiBEZXZpY2UgW1BSMTVdIHN0YXR1cyBbMDAwMDAwMGZd
ClsgICAgMi45ODYxNDhdIEFDUEk6IERldmljZSBbUFIxNl0gc3RhdHVzIFswMDAwMDAwZl0KWyAg
ICAyLjk4NjI2Nl0gQUNQSTogRGV2aWNlIFtQUjE3XSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgIDIu
OTg2MzkwXSBBQ1BJOiBEZXZpY2UgW1BSMThdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgMi45ODY1
MjRdIEFDUEk6IERldmljZSBbU0JVU10gc3RhdHVzIFswMDAwMDAwZl0KWyAgICAyLjk4NjY3Nl0g
QUNQSTogRGV2aWNlIFtSUDAxXSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgIDIuOTg2Nzk2XSBBQ1BJ
OiBEZXZpY2UgW1BYU1hdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgMi45ODY5MzBdIEFDUEk6IERl
dmljZSBbRDAxNV0gc3RhdHVzIFswMDAwMDAwZl0KWyAgICAyLjk4NzA0MV0gQUNQSTogRGV2aWNl
IFtSUDAyXSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgIDIuOTg3MTU2XSBBQ1BJOiBEZXZpY2UgW1BY
U1hdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgMi45ODcyODddIEFDUEk6IERldmljZSBbRDAxNl0g
c3RhdHVzIFswMDAwMDAwZl0KWyAgICAyLjk4NzM5M10gQUNQSTogRGV2aWNlIFtSUDAzXSBzdGF0
dXMgWzAwMDAwMDBmXQpbICAgIDIuOTg3NTI1XSBBQ1BJOiBEZXZpY2UgW1BYU1hdIHN0YXR1cyBb
MDAwMDAwMGZdClsgICAgMi45ODc2NjVdIEFDUEk6IERldmljZSBbRDAxN10gc3RhdHVzIFswMDAw
MDAwZl0KWyAgICAyLjk4Nzc3Nl0gQUNQSTogRGV2aWNlIFtSUDA0XSBzdGF0dXMgWzAwMDAwMDBm
XQpbICAgIDIuOTg3ODkwXSBBQ1BJOiBEZXZpY2UgW1BYU1hdIHN0YXR1cyBbMDAwMDAwMGZdClsg
ICAgMi45ODgwMjNdIEFDUEk6IERldmljZSBbRDAxOF0gc3RhdHVzIFswMDAwMDAwZl0KWyAgICAy
Ljk4ODEyOF0gQUNQSTogRGV2aWNlIFtEMDJBXSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgIDIuOTg4
MjM3XSBBQ1BJOiBEZXZpY2UgW0QwMTldIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgMi45ODgzNDFd
IEFDUEk6IERldmljZSBbRDAxQV0gc3RhdHVzIFswMDAwMDAwZl0KWyAgICAyLjk4ODQ1N10gQUNQ
STogRGV2aWNlIFtEMDFCXSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgIDIuOTg4NTY3XSBBQ1BJOiBE
ZXZpY2UgW0QwMUNdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgMi45ODg2NzFdIEFDUEk6IERldmlj
ZSBbRDAxRF0gc3RhdHVzIFswMDAwMDAwZl0KWyAgICAyLjk4ODc4MF0gQUNQSTogRGV2aWNlIFtE
MDFFXSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgIDIuOTg4ODg0XSBBQ1BJOiBEZXZpY2UgW0QwMUZd
IHN0YXR1cyBbMDAwMDAwMGZdClsgICAgMi45ODg5OTNdIEFDUEk6IERldmljZSBbRDAyMF0gc3Rh
dHVzIFswMDAwMDAwZl0KWyAgICAyLjk4OTA5OF0gQUNQSTogRGV2aWNlIFtEMDIxXSBzdGF0dXMg
WzAwMDAwMDBmXQpbICAgIDIuOTg5MjA3XSBBQ1BJOiBEZXZpY2UgW0QwMjJdIHN0YXR1cyBbMDAw
MDAwMGZdClsgICAgMi45ODkzMjJdIEFDUEk6IERldmljZSBbRDAyM10gc3RhdHVzIFswMDAwMDAw
Zl0KWyAgICAyLjk4OTQzMl0gQUNQSTogRGV2aWNlIFtEMDI0XSBzdGF0dXMgWzAwMDAwMDBmXQpb
ICAgIDIuOTg5NTM2XSBBQ1BJOiBEZXZpY2UgW0QwMjVdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAg
Mi45ODk2NDVdIEFDUEk6IERldmljZSBbRDAyNl0gc3RhdHVzIFswMDAwMDAwZl0KWyAgICAyLjk4
OTc0OV0gQUNQSTogRGV2aWNlIFtEMDI3XSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgIDIuOTg5ODU4
XSBBQ1BJOiBEZXZpY2UgW0QwMjhdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgMi45OTAwNzBdIEFD
UEk6IERldmljZSBbRU00MV0gc3RhdHVzIFswMDAwMDAwMF0KWyAgICAyLjk5MDE5MF0gQUNQSTog
RGV2aWNlIFtDQVJEXSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgIDIuOTkwMzkxXSBBQ1BJOiBEZXZp
Y2UgW0VNNDVdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgMi45OTA1MDVdIEFDUEk6IERldmljZSBb
Q0FSRF0gc3RhdHVzIFswMDAwMDAwZl0KWyAgICAyLjk5MDY3Nl0gQUNQSTogRGV2aWNlIFtPVEcx
XSBzdGF0dXMgWzAwMDAwMDAwXQpbICAgIDIuOTkwNzg1XSBBQ1BJOiBcX1NCXy5VU0JDOiBOZXcg
cG93ZXIgcmVzb3VyY2UKWyAgICAyLjk5MTE5Nl0gQUNQSTogRGV2aWNlIFtTRUMwXSBzdGF0dXMg
WzAwMDAwMDBmXQpbICAgIDIuOTkxMzk1XSBBQ1BJOiBEZXZpY2UgW1BEUkNdIHN0YXR1cyBbMDAw
MDAwMGZdClsgICAgMi45OTE4MTldIEFDUEk6IERldmljZSBbTE5LQV0gc3RhdHVzIFswMDAwMDAw
Yl0KWyAgICAyLjk5MjIzN10gQUNQSTogRGV2aWNlIFtMTktCXSBzdGF0dXMgWzAwMDAwMDA5XQpb
ICAgIDIuOTkyNjM0XSBBQ1BJOiBEZXZpY2UgW0xOS0NdIHN0YXR1cyBbMDAwMDAwMGJdClsgICAg
Mi45OTMwMzZdIEFDUEk6IERldmljZSBbTE5LRF0gc3RhdHVzIFswMDAwMDAwYl0KWyAgICAyLjk5
MzQzOV0gQUNQSTogRGV2aWNlIFtMTktFXSBzdGF0dXMgWzAwMDAwMDBiXQpbICAgIDIuOTkzODM3
XSBBQ1BJOiBEZXZpY2UgW0xOS0ZdIHN0YXR1cyBbMDAwMDAwMGJdClsgICAgMi45OTQyNDBdIEFD
UEk6IERldmljZSBbTE5LR10gc3RhdHVzIFswMDAwMDAwYl0KWyAgICAyLjk5NDY0NV0gQUNQSTog
RGV2aWNlIFtMTktIXSBzdGF0dXMgWzAwMDAwMDBiXQpbICAgIDIuOTk1MjQ3XSBBQ1BJOiBEZXZp
Y2UgW0xQRUFdIHN0YXR1cyBbMDAwMDAwMDBdClsgICAgMi45OTUzMjBdIEFDUEk6IFxfU0JfLkxQ
RUEuUExQRTogTmV3IHBvd2VyIHJlc291cmNlClsgICAgMi45OTYyOTVdIEFDUEk6IERldmljZSBb
TFBBMl0gc3RhdHVzIFswMDAwMDAwMF0KWyAgICAyLjk5NjM2N10gQUNQSTogXF9TQl8uTFBBMi5Q
TFBFOiBOZXcgcG93ZXIgcmVzb3VyY2UKWyAgICAyLjk5Njg2Ml0gQUNQSTogRGV2aWNlIFtBRE1B
XSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgIDIuOTk3MDM1XSBBQ1BJOiBEZXZpY2UgW1BXUkJdIHN0
YXR1cyBbMDAwMDAwMGZdClsgICAgMi45OTcxODddIEFDUEk6IERldmljZSBbU0xQQl0gc3RhdHVz
IFswMDAwMDAwZl0KWyAgICAyLjk5NzYwN10gQUNQSTogRGV2aWNlIFtMSUQwXSBzdGF0dXMgWzAw
MDAwMDBmXQpbICAgIDIuOTk4MTUxXSBBQ1BJOiBEZXZpY2UgW0dQRURdIHN0YXR1cyBbMDAwMDAw
MDBdClsgICAgMi45OTg0MTldIEFDUEk6IERldmljZSBbTUJJRF0gc3RhdHVzIFswMDAwMDAwZl0K
WyAgICAyLjk5ODYzMV0gQUNQSTogRGV2aWNlIFtQSU5EXSBzdGF0dXMgWzAwMDAwMDAwXQpbICAg
IDIuOTk4NzUyXSBBQ1BJOiBEZXZpY2UgW19UWl0gc3RhdHVzIFswMDAwMDAwZl0KWyAgICAyLjk5
OTI4N10gQUNQSTogRGV2aWNlIFtBQ1BJXSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgIDIuOTk5MzE0
XSBBQ1BJOiBEZXZpY2UgW0NQVTBdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgMi45OTkzOTJdIEFD
UEk6IERldmljZSBbQ1BVMV0gc3RhdHVzIFswMDAwMDAwZl0KWyAgICAyLjk5OTQyNF0gQUNQSTog
RGV2aWNlIFtDUFUyXSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgIDIuOTk5NDU2XSBBQ1BJOiBEZXZp
Y2UgW0NQVTNdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgMi45OTk0ODddIEFDUEk6IERldmljZSBb
X1NCXSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgIDIuOTk5NTEzXSBBQ1BJOiBEZXZpY2UgW1JUQzBd
IHN0YXR1cyBbMDAwMDAwMGZdClsgICAgMi45OTk1NTddIEFDUEk6IERldmljZSBbSFBFVF0gc3Rh
dHVzIFswMDAwMDAwZl0KWyAgICAyLjk5OTcxMV0gQUNQSTogRGV2aWNlIFtQQ0kwXSBzdGF0dXMg
WzAwMDAwMDBmXQpbICAgIDMuMDAwMjMxXSBBQ1BJOiBQQ0kgUm9vdCBCcmlkZ2UgW1BDSTBdIChk
b21haW4gMDAwMCBbYnVzIDAwLWZmXSkKWyAgICAzLjAwMDI1MF0gYWNwaSBQTlAwQTA4OjAwOiBf
T1NDOiBPUyBzdXBwb3J0cyBbRXh0ZW5kZWRDb25maWcgQVNQTSBDbG9ja1BNIFNlZ21lbnRzIE1T
SSBIUFgtVHlwZTNdClsgICAgMy4wMDA4NDBdIGFjcGkgUE5QMEEwODowMDogX09TQzogcGxhdGZv
cm0gZG9lcyBub3Qgc3VwcG9ydCBbUENJZUhvdHBsdWcgU0hQQ0hvdHBsdWcgUE1FXQpbICAgIDMu
MDAxNjE0XSBhY3BpIFBOUDBBMDg6MDA6IF9PU0M6IE9TIG5vdyBjb250cm9scyBbQUVSIFBDSWVD
YXBhYmlsaXR5IExUUl0KWyAgICAzLjAwMzM3N10gUENJIGhvc3QgYnJpZGdlIHRvIGJ1cyAwMDAw
OjAwClsgICAgMy4wMDMzOTNdIHBjaV9idXMgMDAwMDowMDogcm9vdCBidXMgcmVzb3VyY2UgW2lv
ICAweDAwNzAtMHgwMDc3XQpbICAgIDMuMDAzNDAxXSBwY2lfYnVzIDAwMDA6MDA6IHJvb3QgYnVz
IHJlc291cmNlIFtpbyAgMHgwMDAwLTB4MDA2ZiB3aW5kb3ddClsgICAgMy4wMDM0MDddIHBjaV9i
dXMgMDAwMDowMDogcm9vdCBidXMgcmVzb3VyY2UgW2lvICAweDAwNzgtMHgwY2Y3IHdpbmRvd10K
WyAgICAzLjAwMzQxM10gcGNpX2J1cyAwMDAwOjAwOiByb290IGJ1cyByZXNvdXJjZSBbaW8gIDB4
MGQwMC0weGZmZmYgd2luZG93XQpbICAgIDMuMDAzNDE5XSBwY2lfYnVzIDAwMDA6MDA6IHJvb3Qg
YnVzIHJlc291cmNlIFttZW0gMHgwMDBhMDAwMC0weDAwMGZmZmZmIHdpbmRvd10KWyAgICAzLjAw
MzQyNV0gcGNpX2J1cyAwMDAwOjAwOiByb290IGJ1cyByZXNvdXJjZSBbbWVtIDB4YTAwMDAwMDAt
MHhiMGIxN2ZmZiB3aW5kb3ddClsgICAgMy4wMDM0MzFdIHBjaV9idXMgMDAwMDowMDogcm9vdCBi
dXMgcmVzb3VyY2UgW2J1cyAwMC1mZl0KWyAgICAzLjAwMzQ0NV0gcGNpX2J1cyAwMDAwOjAwOiBz
Y2FubmluZyBidXMKWyAgICAzLjAwMzQ3Nl0gcGNpIDAwMDA6MDA6MDAuMDogWzgwODY6MGYwMF0g
dHlwZSAwMCBjbGFzcyAweDA2MDAwMCBjb252ZW50aW9uYWwgUENJIGVuZHBvaW50ClsgICAgMy4w
MDM3MzJdIHBjaSAwMDAwOjAwOjAyLjA6IFs4MDg2OjBmMzFdIHR5cGUgMDAgY2xhc3MgMHgwMzAw
MDAgY29udmVudGlvbmFsIFBDSSBlbmRwb2ludApbICAgIDMuMDAzNzYyXSBwY2kgMDAwMDowMDow
Mi4wOiBCQVIgMCBbbWVtIDB4YjAwMDAwMDAtMHhiMDNmZmZmZl0KWyAgICAzLjAwMzc3MV0gcGNp
IDAwMDA6MDA6MDIuMDogQkFSIDIgW21lbSAweGEwMDAwMDAwLTB4YWZmZmZmZmYgcHJlZl0KWyAg
ICAzLjAwMzc3OF0gcGNpIDAwMDA6MDA6MDIuMDogQkFSIDQgW2lvICAweGUwODAtMHhlMDg3XQpb
ICAgIDMuMDAzODAyXSBwY2kgMDAwMDowMDowMi4wOiBWaWRlbyBkZXZpY2Ugd2l0aCBzaGFkb3dl
ZCBST00gYXQgW21lbSAweDAwMGMwMDAwLTB4MDAwZGZmZmZdClsgICAgMy4wMDQwNDZdIHBjaSAw
MDAwOjAwOjEzLjA6IFs4MDg2OjBmMjNdIHR5cGUgMDAgY2xhc3MgMHgwMTA2MDEgY29udmVudGlv
bmFsIFBDSSBlbmRwb2ludApbICAgIDMuMDA0MDkxXSBwY2kgMDAwMDowMDoxMy4wOiBCQVIgMCBb
aW8gIDB4ZTA3MC0weGUwNzddClsgICAgMy4wMDQwOTldIHBjaSAwMDAwOjAwOjEzLjA6IEJBUiAx
IFtpbyAgMHhlMDYwLTB4ZTA2M10KWyAgICAzLjAwNDEwNl0gcGNpIDAwMDA6MDA6MTMuMDogQkFS
IDIgW2lvICAweGUwNTAtMHhlMDU3XQpbICAgIDMuMDA0MTEyXSBwY2kgMDAwMDowMDoxMy4wOiBC
QVIgMyBbaW8gIDB4ZTA0MC0weGUwNDNdClsgICAgMy4wMDQxMThdIHBjaSAwMDAwOjAwOjEzLjA6
IEJBUiA0IFtpbyAgMHhlMDIwLTB4ZTAzZl0KWyAgICAzLjAwNDEyNF0gcGNpIDAwMDA6MDA6MTMu
MDogQkFSIDUgW21lbSAweGIwYjE3MDAwLTB4YjBiMTc3ZmZdClsgICAgMy4wMDQxNzNdIHBjaSAw
MDAwOjAwOjEzLjA6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDNob3QKWyAgICAzLjAwNDE4M10gcGNp
IDAwMDA6MDA6MTMuMDogUE1FIyBkaXNhYmxlZApbICAgIDMuMDA0MzY4XSBwY2kgMDAwMDowMDox
NC4wOiBbODA4NjowZjM1XSB0eXBlIDAwIGNsYXNzIDB4MGMwMzMwIGNvbnZlbnRpb25hbCBQQ0kg
ZW5kcG9pbnQKWyAgICAzLjAwNDQwOF0gcGNpIDAwMDA6MDA6MTQuMDogQkFSIDAgW21lbSAweGIw
YjAwMDAwLTB4YjBiMGZmZmYgNjRiaXRdClsgICAgMy4wMDQ0NTRdIHBjaSAwMDAwOjAwOjE0LjA6
IFBNRSMgc3VwcG9ydGVkIGZyb20gRDNob3QgRDNjb2xkClsgICAgMy4wMDQ0NjNdIHBjaSAwMDAw
OjAwOjE0LjA6IFBNRSMgZGlzYWJsZWQKWyAgICAzLjAwNDg2NV0gcGNpIDAwMDA6MDA6MTcuMDog
WzgwODY6MGY1MF0gdHlwZSAwMCBjbGFzcyAweDA4MDUwMSBjb252ZW50aW9uYWwgUENJIGVuZHBv
aW50ClsgICAgMy4wMDQ5MTVdIHBjaSAwMDAwOjAwOjE3LjA6IEJBUiAwIFttZW0gMHhiMGIxNjAw
MC0weGIwYjE2ZmZmXQpbICAgIDMuMDA0OTIzXSBwY2kgMDAwMDowMDoxNy4wOiBCQVIgMSBbbWVt
IDB4YjBiMTUwMDAtMHhiMGIxNWZmZl0KWyAgICAzLjAwNDk3MV0gcGNpIDAwMDA6MDA6MTcuMDog
UE1FIyBzdXBwb3J0ZWQgZnJvbSBEMCBEM2hvdApbICAgIDMuMDA0OTgxXSBwY2kgMDAwMDowMDox
Ny4wOiBQTUUjIGRpc2FibGVkClsgICAgMy4wMDUzMDhdIHBjaSAwMDAwOjAwOjFhLjA6IFs4MDg2
OjBmMThdIHR5cGUgMDAgY2xhc3MgMHgxMDgwMDAgY29udmVudGlvbmFsIFBDSSBlbmRwb2ludApb
ICAgIDMuMDA1MzcyXSBwY2kgMDAwMDowMDoxYS4wOiBCQVIgMCBbbWVtIDB4YjA5MDAwMDAtMHhi
MDlmZmZmZl0KWyAgICAzLjAwNTM4MV0gcGNpIDAwMDA6MDA6MWEuMDogQkFSIDEgW21lbSAweGIw
ODAwMDAwLTB4YjA4ZmZmZmZdClsgICAgMy4wMDU0NDddIHBjaSAwMDAwOjAwOjFhLjA6IFBNRSMg
c3VwcG9ydGVkIGZyb20gRDAgRDNob3QKWyAgICAzLjAwNTQ1N10gcGNpIDAwMDA6MDA6MWEuMDog
UE1FIyBkaXNhYmxlZApbICAgIDMuMDA1NjUwXSBwY2kgMDAwMDowMDoxYi4wOiBbODA4NjowZjA0
XSB0eXBlIDAwIGNsYXNzIDB4MDQwMzAwIGNvbnZlbnRpb25hbCBQQ0kgZW5kcG9pbnQKWyAgICAz
LjAwNTY5N10gcGNpIDAwMDA6MDA6MWIuMDogQkFSIDAgW21lbSAweGIwYjEwMDAwLTB4YjBiMTNm
ZmYgNjRiaXRdClsgICAgMy4wMDU3NDldIHBjaSAwMDAwOjAwOjFiLjA6IFBNRSMgc3VwcG9ydGVk
IGZyb20gRDAgRDNob3QgRDNjb2xkClsgICAgMy4wMDU3NTldIHBjaSAwMDAwOjAwOjFiLjA6IFBN
RSMgZGlzYWJsZWQKWyAgICAzLjAwNTk0OV0gcGNpIDAwMDA6MDA6MWMuMDogWzgwODY6MGY0OF0g
dHlwZSAwMSBjbGFzcyAweDA2MDQwMCBQQ0llIFJvb3QgUG9ydApbICAgIDMuMDA1OTc2XSBwY2kg
MDAwMDowMDoxYy4wOiBQQ0kgYnJpZGdlIHRvIFtidXMgMDFdClsgICAgMy4wMDU5ODZdIHBjaSAw
MDAwOjAwOjFjLjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4YjA0MDAwMDAtMHhiMDdmZmZmZl0K
WyAgICAzLjAwNjA1Ml0gcGNpIDAwMDA6MDA6MWMuMDogUE1FIyBzdXBwb3J0ZWQgZnJvbSBEMCBE
M2hvdCBEM2NvbGQKWyAgICAzLjAwNjA2MV0gcGNpIDAwMDA6MDA6MWMuMDogUE1FIyBkaXNhYmxl
ZApbICAgIDMuMDA2MjcyXSBwY2kgMDAwMDowMDoxYy4yOiBbODA4NjowZjRjXSB0eXBlIDAxIGNs
YXNzIDB4MDYwNDAwIFBDSWUgUm9vdCBQb3J0ClsgICAgMy4wMDYyOTldIHBjaSAwMDAwOjAwOjFj
LjI6IFBDSSBicmlkZ2UgdG8gW2J1cyAwMl0KWyAgICAzLjAwNjM2OV0gcGNpIDAwMDA6MDA6MWMu
MjogUE1FIyBzdXBwb3J0ZWQgZnJvbSBEMCBEM2hvdCBEM2NvbGQKWyAgICAzLjAwNjM3OF0gcGNp
IDAwMDA6MDA6MWMuMjogUE1FIyBkaXNhYmxlZApbICAgIDMuMDA2NTg2XSBwY2kgMDAwMDowMDox
Yy4zOiBbODA4NjowZjRlXSB0eXBlIDAxIGNsYXNzIDB4MDYwNDAwIFBDSWUgUm9vdCBQb3J0Clsg
ICAgMy4wMDY2MTVdIHBjaSAwMDAwOjAwOjFjLjM6IFBDSSBicmlkZ2UgdG8gW2J1cyAwM10KWyAg
ICAzLjAwNjYyM10gcGNpIDAwMDA6MDA6MWMuMzogICBicmlkZ2Ugd2luZG93IFtpbyAgMHhkMDAw
LTB4ZGZmZl0KWyAgICAzLjAwNjYzMV0gcGNpIDAwMDA6MDA6MWMuMzogICBicmlkZ2Ugd2luZG93
IFttZW0gMHhiMGEwMDAwMC0weGIwYWZmZmZmXQpbICAgIDMuMDA2Njk2XSBwY2kgMDAwMDowMDox
Yy4zOiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQwIEQzaG90IEQzY29sZApbICAgIDMuMDA2NzA0XSBw
Y2kgMDAwMDowMDoxYy4zOiBQTUUjIGRpc2FibGVkClsgICAgMy4wMDY5MTRdIHBjaSAwMDAwOjAw
OjFmLjA6IFs4MDg2OjBmMWNdIHR5cGUgMDAgY2xhc3MgMHgwNjAxMDAgY29udmVudGlvbmFsIFBD
SSBlbmRwb2ludApbICAgIDMuMDA3MjQ0XSBwY2kgMDAwMDowMDoxZi4zOiBbODA4NjowZjEyXSB0
eXBlIDAwIGNsYXNzIDB4MGMwNTAwIGNvbnZlbnRpb25hbCBQQ0kgZW5kcG9pbnQKWyAgICAzLjAw
NzM0M10gcGNpIDAwMDA6MDA6MWYuMzogQkFSIDAgW21lbSAweGIwYjE0MDAwLTB4YjBiMTQwMWZd
ClsgICAgMy4wMDczNjBdIHBjaSAwMDAwOjAwOjFmLjM6IEJBUiA0IFtpbyAgMHhlMDAwLTB4ZTAx
Zl0KWyAgICAzLjAwNzU5MV0gcGNpX2J1cyAwMDAwOjAwOiBmaXh1cHMgZm9yIGJ1cwpbICAgIDMu
MDA3NjAwXSBwY2kgMDAwMDowMDoxYy4wOiBzY2FubmluZyBbYnVzIDAxLTAxXSBiZWhpbmQgYnJp
ZGdlLCBwYXNzIDAKWyAgICAzLjAwNzcxOF0gcGNpX2J1cyAwMDAwOjAxOiBzY2FubmluZyBidXMK
WyAgICAzLjAwNzc2Ml0gcGNpIDAwMDA6MDE6MDAuMDogWzE1NTY6NTU1NV0gdHlwZSAwMCBjbGFz
cyAweDA1MDAwMCBQQ0llIEVuZHBvaW50ClsgICAgMy4wMDc4MzhdIHBjaSAwMDAwOjAxOjAwLjA6
IEJBUiAwIFttZW0gMHhiMDQwMDAwMC0weGIwN2ZmZmZmXQpbICAgIDMuMDE0NjMxXSBwY2lfYnVz
IDAwMDA6MDE6IGZpeHVwcyBmb3IgYnVzClsgICAgMy4wMTQ2MzhdIHBjaSAwMDAwOjAwOjFjLjA6
IFBDSSBicmlkZ2UgdG8gW2J1cyAwMV0KWyAgICAzLjAxNDY1MV0gcGNpX2J1cyAwMDAwOjAxOiBi
dXMgc2NhbiByZXR1cm5pbmcgd2l0aCBtYXg9MDEKWyAgICAzLjAxNDY2MF0gcGNpIDAwMDA6MDA6
MWMuMjogc2Nhbm5pbmcgW2J1cyAwMi0wMl0gYmVoaW5kIGJyaWRnZSwgcGFzcyAwClsgICAgMy4w
MTQ3NzFdIHBjaV9idXMgMDAwMDowMjogc2Nhbm5pbmcgYnVzClsgICAgMy4wMTQ3ODBdIHBjaV9i
dXMgMDAwMDowMjogZml4dXBzIGZvciBidXMKWyAgICAzLjAxNDc4NF0gcGNpIDAwMDA6MDA6MWMu
MjogUENJIGJyaWRnZSB0byBbYnVzIDAyXQpbICAgIDMuMDE0Nzk2XSBwY2lfYnVzIDAwMDA6MDI6
IGJ1cyBzY2FuIHJldHVybmluZyB3aXRoIG1heD0wMgpbICAgIDMuMDE0ODA1XSBwY2kgMDAwMDow
MDoxYy4zOiBzY2FubmluZyBbYnVzIDAzLTAzXSBiZWhpbmQgYnJpZGdlLCBwYXNzIDAKWyAgICAz
LjAxNDkyOF0gcGNpX2J1cyAwMDAwOjAzOiBzY2FubmluZyBidXMKWyAgICAzLjAxNDk3OV0gcGNp
IDAwMDA6MDM6MDAuMDogd29ya2luZyBhcm91bmQgUk9NIEJBUiBvdmVybGFwIGRlZmVjdApbICAg
IDMuMDE0OTg1XSBwY2kgMDAwMDowMzowMC4wOiBbODA4NjoxNTMzXSB0eXBlIDAwIGNsYXNzIDB4
MDIwMDAwIFBDSWUgRW5kcG9pbnQKWyAgICAzLjAxNTA1OV0gcGNpIDAwMDA6MDM6MDAuMDogQkFS
IDAgW21lbSAweGIwYTAwMDAwLTB4YjBhN2ZmZmZdClsgICAgMy4wMTUwNjldIHBjaSAwMDAwOjAz
OjAwLjA6IEJBUiAyIFtpbyAgMHhkMDAwLTB4ZDAxZl0KWyAgICAzLjAxNTA3N10gcGNpIDAwMDA6
MDM6MDAuMDogQkFSIDMgW21lbSAweGIwYTgwMDAwLTB4YjBhODNmZmZdClsgICAgMy4wMTUyMDhd
IHBjaSAwMDAwOjAzOjAwLjA6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDAgRDNob3QgRDNjb2xkClsg
ICAgMy4wMTUyMTldIHBjaSAwMDAwOjAzOjAwLjA6IFBNRSMgZGlzYWJsZWQKWyAgICAzLjAxNTUx
M10gcGNpX2J1cyAwMDAwOjAzOiBmaXh1cHMgZm9yIGJ1cwpbICAgIDMuMDE1NTIwXSBwY2kgMDAw
MDowMDoxYy4zOiBQQ0kgYnJpZGdlIHRvIFtidXMgMDNdClsgICAgMy4wMTU1MzJdIHBjaV9idXMg
MDAwMDowMzogYnVzIHNjYW4gcmV0dXJuaW5nIHdpdGggbWF4PTAzClsgICAgMy4wMTU1NDFdIHBj
aSAwMDAwOjAwOjFjLjA6IHNjYW5uaW5nIFtidXMgMDEtMDFdIGJlaGluZCBicmlkZ2UsIHBhc3Mg
MQpbICAgIDMuMDE1NTUyXSBwY2kgMDAwMDowMDoxYy4yOiBzY2FubmluZyBbYnVzIDAyLTAyXSBi
ZWhpbmQgYnJpZGdlLCBwYXNzIDEKWyAgICAzLjAxNTU2Ml0gcGNpIDAwMDA6MDA6MWMuMzogc2Nh
bm5pbmcgW2J1cyAwMy0wM10gYmVoaW5kIGJyaWRnZSwgcGFzcyAxClsgICAgMy4wMTU1NzFdIHBj
aV9idXMgMDAwMDowMDogYnVzIHNjYW4gcmV0dXJuaW5nIHdpdGggbWF4PTAzClsgICAgMy4wMTU2
NDBdIEFDUEk6IERldmljZSBbVkxWQ10gc3RhdHVzIFswMDAwMDAwZl0KWyAgICAzLjAxNTY1OV0g
QUNQSTogRGV2aWNlIFtHRlgwXSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgIDMuMDE1Njg3XSBBQ1BJ
OiBEZXZpY2UgW0REMDFdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgMy4wMTU2OTldIEFDUEk6IERl
dmljZSBbREQwMl0gc3RhdHVzIFswMDAwMDAwZl0KWyAgICAzLjAxNTcxMV0gQUNQSTogRGV2aWNl
IFtERDAzXSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgIDMuMDE1NzIyXSBBQ1BJOiBEZXZpY2UgW0RE
MDRdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgMy4wMTU3MzRdIEFDUEk6IERldmljZSBbREQwNV0g
c3RhdHVzIFswMDAwMDAwZl0KWyAgICAzLjAxNTc0NV0gQUNQSTogRGV2aWNlIFtERDA2XSBzdGF0
dXMgWzAwMDAwMDBmXQpbICAgIDMuMDE1NzU3XSBBQ1BJOiBEZXZpY2UgW0REMDddIHN0YXR1cyBb
MDAwMDAwMGZdClsgICAgMy4wMTU3NjhdIEFDUEk6IERldmljZSBbREQwOF0gc3RhdHVzIFswMDAw
MDAwZl0KWyAgICAzLjAxNTc3OV0gQUNQSTogRGV2aWNlIFtERDFGXSBzdGF0dXMgWzAwMDAwMDBm
XQpbICAgIDMuMDE1ODY2XSBBQ1BJOiBEZXZpY2UgW0lTUDBdIHN0YXR1cyBbMDAwMDAwMDBdClsg
ICAgMy4wMTU4ODFdIEFDUEk6IERldmljZSBbU0JSR10gc3RhdHVzIFswMDAwMDAwZl0KWyAgICAz
LjAxNTk1OV0gQUNQSTogRGV2aWNlIFtIX0VDXSBzdGF0dXMgWzAwMDAwMDAwXQpbICAgIDMuMDE1
OTcyXSBBQ1BJOiBEZXZpY2UgW0ZXSERdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgMy4wMTYwOTNd
IEFDUEk6IERldmljZSBbSVBJQ10gc3RhdHVzIFswMDAwMDAwZl0KWyAgICAzLjAxNjEyMV0gQUNQ
STogRGV2aWNlIFtMRFJDXSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgIDMuMDE2MTM4XSBBQ1BJOiBE
ZXZpY2UgW1RJTVJdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgMy4wMTYyMDhdIEFDUEk6IERldmlj
ZSBbV1BDTl0gc3RhdHVzIFswMDAwMDAwMF0KWyAgICAzLjAxNjIyNF0gQUNQSTogRGV2aWNlIFtT
SU8xXSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgIDMuMDE2NTI2XSBBQ1BJOiBEZXZpY2UgW0xQVEVd
IHN0YXR1cyBbMDAwMDAwMDBdClsgICAgMy4wMTY4MTBdIEFDUEk6IERldmljZSBbUFMyS10gc3Rh
dHVzIFswMDAwMDAwMF0KWyAgICAzLjAxNzA5Nl0gQUNQSTogRGV2aWNlIFtQUzJNXSBzdGF0dXMg
WzAwMDAwMDAwXQpbICAgIDMuMDE3MTMzXSBBQ1BJOiBEZXZpY2UgW1NTUEldIHN0YXR1cyBbMDAw
MDAwMDBdClsgICAgMy4wMTcxNjldIEFDUEk6IERldmljZSBbU0dQSV0gc3RhdHVzIFswMDAwMDAw
MF0KWyAgICAzLjAxNzIwNF0gQUNQSTogRGV2aWNlIFtTSFdNXSBzdGF0dXMgWzAwMDAwMDAwXQpb
ICAgIDMuMDE3MjQwXSBBQ1BJOiBEZXZpY2UgW1NDUEldIHN0YXR1cyBbMDAwMDAwMDBdClsgICAg
My4wMTc1MjNdIEFDUEk6IERldmljZSBbVUFSMV0gc3RhdHVzIFswMDAwMDAwMF0KWyAgICAzLjAx
NzgwOF0gQUNQSTogRGV2aWNlIFtVQVIyXSBzdGF0dXMgWzAwMDAwMDAwXQpbICAgIDMuMDE3ODIz
XSBBQ1BJOiBEZXZpY2UgW0FEUDFdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgNC42Mzg1MTJdIEFD
UEk6IERldmljZSBbQkFUMV0gc3RhdHVzIFswMDAwMDAwZl0KWyAgICA1LjQ0ODk1Nl0gQUNQSTog
RGV2aWNlIFtCQVQyXSBzdGF0dXMgWzAwMDAwMDAwXQpbICAgIDUuNDQ5MDQzXSBBQ1BJOiBEZXZp
Y2UgW1BDVTFdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgNS40NDkwNjldIEFDUEk6IERldmljZSBb
RDAwNF0gc3RhdHVzIFswMDAwMDAwZl0KWyAgICA1LjQ0OTA4NF0gQUNQSTogRGV2aWNlIFtEMDA1
XSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgIDUuNDQ5MDk2XSBBQ1BJOiBEZXZpY2UgW0QwMDZdIHN0
YXR1cyBbMDAwMDAwMGZdClsgICAgNS42NDY2MTRdIEFDUEk6IERldmljZSBbU0FUQV0gc3RhdHVz
IFswMDAwMDAwZl0KWyAgICA1LjY0NjY4NV0gQUNQSTogRGV2aWNlIFtYSEMxXSBzdGF0dXMgWzAw
MDAwMDBmXQpbICAgIDUuNjQ2NzAxXSBBQ1BJOiBEZXZpY2UgW1JIVUJdIHN0YXR1cyBbMDAwMDAw
MGZdClsgICAgNS42NDY3MTRdIEFDUEk6IERldmljZSBbU1NQMV0gc3RhdHVzIFswMDAwMDAwZl0K
WyAgICA1LjY0NjcyNl0gQUNQSTogRGV2aWNlIFtIUzAxXSBzdGF0dXMgWzAwMDAwMDBmXQpbICAg
IDUuNjQ2NzM4XSBBQ1BJOiBEZXZpY2UgW0hTMDJdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgNS42
NDY3NDldIEFDUEk6IERldmljZSBbSFMwM10gc3RhdHVzIFswMDAwMDAwZl0KWyAgICA1LjY0Njc2
MF0gQUNQSTogRGV2aWNlIFtIUzA0XSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgIDUuNjQ2NzcxXSBB
Q1BJOiBEZXZpY2UgW0hTQzFdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgNS42NDY3ODNdIEFDUEk6
IERldmljZSBbSFNDMl0gc3RhdHVzIFswMDAwMDAwZl0KWyAgICA1LjY0Njc5NV0gQUNQSTogRGV2
aWNlIFtEMDA5XSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgIDUuNjQ2ODA2XSBBQ1BJOiBEZXZpY2Ug
W1hIQzJdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgNS42NDY4MTddIEFDUEk6IERldmljZSBbRDAw
Ql0gc3RhdHVzIFswMDAwMDAwZl0KWyAgICA1LjY0NjgyOF0gQUNQSTogRGV2aWNlIFtHTEFOXSBz
dGF0dXMgWzAwMDAwMDBmXQpbICAgIDUuNjQ2ODk2XSBBQ1BJOiBEZXZpY2UgW0hERUZdIHN0YXR1
cyBbMDAwMDAwMGZdClsgICAgNS42NDY5NjJdIEFDUEk6IERldmljZSBbRUhDMV0gc3RhdHVzIFsw
MDAwMDAwMF0KWyAgICA1LjY0Njk3Nl0gQUNQSTogRGV2aWNlIFtTQlVTXSBzdGF0dXMgWzAwMDAw
MDBmXQpbICAgIDUuNjQ2OTkwXSBBQ1BJOiBEZXZpY2UgW1JQMDFdIHN0YXR1cyBbMDAwMDAwMGZd
ClsgICAgNS42NDcwMDJdIEFDUEk6IERldmljZSBbUFhTWF0gc3RhdHVzIFswMDAwMDAwZl0KWyAg
ICA1LjY0NzAxM10gQUNQSTogRGV2aWNlIFtEMDE1XSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgIDUu
NjQ3MDI2XSBBQ1BJOiBEZXZpY2UgW1JQMDJdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgNS42NDcw
MzddIEFDUEk6IERldmljZSBbUFhTWF0gc3RhdHVzIFswMDAwMDAwZl0KWyAgICA1LjY0NzA0OF0g
QUNQSTogRGV2aWNlIFtEMDE2XSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgIDUuNjQ3MDU5XSBBQ1BJ
OiBEZXZpY2UgW1JQMDNdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgNS42NDcwNzBdIEFDUEk6IERl
dmljZSBbUFhTWF0gc3RhdHVzIFswMDAwMDAwZl0KWyAgICA1LjY0NzA4MV0gQUNQSTogRGV2aWNl
IFtEMDE3XSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgIDUuNjQ3MDkyXSBBQ1BJOiBEZXZpY2UgW1JQ
MDRdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgNS42NDcxMDNdIEFDUEk6IERldmljZSBbUFhTWF0g
c3RhdHVzIFswMDAwMDAwZl0KWyAgICA1LjY0NzExNV0gQUNQSTogRGV2aWNlIFtEMDE4XSBzdGF0
dXMgWzAwMDAwMDBmXQpbICAgIDUuNjQ3MTI2XSBBQ1BJOiBEZXZpY2UgW0QwMkFdIHN0YXR1cyBb
MDAwMDAwMGZdClsgICAgNS42NDcxMzddIEFDUEk6IERldmljZSBbRDAxOV0gc3RhdHVzIFswMDAw
MDAwZl0KWyAgICA1LjY0NzE0OV0gQUNQSTogRGV2aWNlIFtEMDFBXSBzdGF0dXMgWzAwMDAwMDBm
XQpbICAgIDUuNjQ3MTYwXSBBQ1BJOiBEZXZpY2UgW0QwMUJdIHN0YXR1cyBbMDAwMDAwMGZdClsg
ICAgNS42NDcxNzFdIEFDUEk6IERldmljZSBbRDAxQ10gc3RhdHVzIFswMDAwMDAwZl0KWyAgICA1
LjY0NzE4Ml0gQUNQSTogRGV2aWNlIFtEMDFEXSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgIDUuNjQ3
MTkzXSBBQ1BJOiBEZXZpY2UgW0QwMUVdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgNS42NDcyMDRd
IEFDUEk6IERldmljZSBbRDAxRl0gc3RhdHVzIFswMDAwMDAwZl0KWyAgICA1LjY0NzIxNV0gQUNQ
STogRGV2aWNlIFtEMDIwXSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgIDUuNjQ3MjI3XSBBQ1BJOiBE
ZXZpY2UgW0QwMjFdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgNS42NDcyMzhdIEFDUEk6IERldmlj
ZSBbRDAyMl0gc3RhdHVzIFswMDAwMDAwZl0KWyAgICA1LjY0NzI0OV0gQUNQSTogRGV2aWNlIFtE
MDIzXSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgIDUuNjQ3MjYwXSBBQ1BJOiBEZXZpY2UgW0QwMjRd
IHN0YXR1cyBbMDAwMDAwMGZdClsgICAgNS42NDcyNzFdIEFDUEk6IERldmljZSBbRDAyNV0gc3Rh
dHVzIFswMDAwMDAwZl0KWyAgICA1LjY0NzI4M10gQUNQSTogRGV2aWNlIFtEMDI2XSBzdGF0dXMg
WzAwMDAwMDBmXQpbICAgIDUuNjQ3Mjk0XSBBQ1BJOiBEZXZpY2UgW0QwMjddIHN0YXR1cyBbMDAw
MDAwMGZdClsgICAgNS42NDczMDVdIEFDUEk6IERldmljZSBbRDAyOF0gc3RhdHVzIFswMDAwMDAw
Zl0KWyAgICA1LjY0NzM5OV0gQUNQSTogRGV2aWNlIFtFTTQxXSBzdGF0dXMgWzAwMDAwMDAwXQpb
ICAgIDUuNjQ3NDk3XSBBQ1BJOiBEZXZpY2UgW0VNNDVdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAg
NS42NDc1MTJdIEFDUEk6IERldmljZSBbQ0FSRF0gc3RhdHVzIFswMDAwMDAwZl0KWyAgICA1LjY0
NzU4M10gQUNQSTogRGV2aWNlIFtPVEcxXSBzdGF0dXMgWzAwMDAwMDAwXQpbICAgIDUuNjQ3NjUw
XSBBQ1BJOiBEZXZpY2UgW1NFQzBdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgNS42NDc2NjZdIEFD
UEk6IERldmljZSBbUERSQ10gc3RhdHVzIFswMDAwMDAwZl0KWyAgICA1LjY0NzcwOF0gQUNQSTog
RGV2aWNlIFtVU0JDXSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgIDUuNjQ3Nzg2XSBBQ1BJOiBEZXZp
Y2UgW0xOS0FdIHN0YXR1cyBbMDAwMDAwMGJdClsgICAgNS42NDc5NDhdIEFDUEk6IFBDSTogSW50
ZXJydXB0IGxpbmsgTE5LQSBjb25maWd1cmVkIGZvciBJUlEgMTEKWyAgICA1LjY0ODA1Ml0gQUNQ
STogRGV2aWNlIFtMTktCXSBzdGF0dXMgWzAwMDAwMDA5XQpbICAgIDUuNjQ4MjA1XSBBQ1BJOiBQ
Q0k6IEludGVycnVwdCBsaW5rIExOS0IgY29uZmlndXJlZCBmb3IgSVJRIDAKWyAgICA1LjY0ODIx
MV0gQUNQSTogUENJOiBJbnRlcnJ1cHQgbGluayBMTktCIGRpc2FibGVkClsgICAgNS42NDgzMTZd
IEFDUEk6IERldmljZSBbTE5LQ10gc3RhdHVzIFswMDAwMDAwYl0KWyAgICA1LjY0ODQ2N10gQUNQ
STogUENJOiBJbnRlcnJ1cHQgbGluayBMTktDIGNvbmZpZ3VyZWQgZm9yIElSUSAxMQpbICAgIDUu
NjQ4NTc0XSBBQ1BJOiBEZXZpY2UgW0xOS0RdIHN0YXR1cyBbMDAwMDAwMGJdClsgICAgNS42NDg3
MjVdIEFDUEk6IFBDSTogSW50ZXJydXB0IGxpbmsgTE5LRCBjb25maWd1cmVkIGZvciBJUlEgMTAK
WyAgICA1LjY0ODgzMF0gQUNQSTogRGV2aWNlIFtMTktFXSBzdGF0dXMgWzAwMDAwMDBiXQpbICAg
IDUuNjQ4OTgxXSBBQ1BJOiBQQ0k6IEludGVycnVwdCBsaW5rIExOS0UgY29uZmlndXJlZCBmb3Ig
SVJRIDExClsgICAgNS42NDkwODddIEFDUEk6IERldmljZSBbTE5LRl0gc3RhdHVzIFswMDAwMDAw
Yl0KWyAgICA1LjY0OTIzOF0gQUNQSTogUENJOiBJbnRlcnJ1cHQgbGluayBMTktGIGNvbmZpZ3Vy
ZWQgZm9yIElSUSAxMQpbICAgIDUuNjQ5MzQ1XSBBQ1BJOiBEZXZpY2UgW0xOS0ddIHN0YXR1cyBb
MDAwMDAwMGJdClsgICAgNS42NDk0OTZdIEFDUEk6IFBDSTogSW50ZXJydXB0IGxpbmsgTE5LRyBj
b25maWd1cmVkIGZvciBJUlEgMTAKWyAgICA1LjY0OTYwMl0gQUNQSTogRGV2aWNlIFtMTktIXSBz
dGF0dXMgWzAwMDAwMDBiXQpbICAgIDUuNjQ5NzUzXSBBQ1BJOiBQQ0k6IEludGVycnVwdCBsaW5r
IExOS0ggY29uZmlndXJlZCBmb3IgSVJRIDEwClsgICAgNS42NDk4MzRdIEFDUEk6IERldmljZSBb
UExQRV0gc3RhdHVzIFswMDAwMDAwMV0KWyAgICA1LjY0OTk2OF0gQUNQSTogRGV2aWNlIFtMUEVB
XSBzdGF0dXMgWzAwMDAwMDAwXQpbICAgIDUuNjUwMDA1XSBBQ1BJOiBEZXZpY2UgW1BMUEVdIHN0
YXR1cyBbMDAwMDAwMDFdClsgICAgNS42NTAxMzldIEFDUEk6IERldmljZSBbTFBBMl0gc3RhdHVz
IFswMDAwMDAwMF0KWyAgICA1LjY1MDE1M10gQUNQSTogRGV2aWNlIFtQV1JCXSBzdGF0dXMgWzAw
MDAwMDBmXQpbICAgIDUuNjUwMjY3XSBBQ1BJOiBEZXZpY2UgW1NMUEJdIHN0YXR1cyBbMDAwMDAw
MGZdClsgICAgNS42NTAzNjFdIEFDUEk6IERldmljZSBbTElEMF0gc3RhdHVzIFswMDAwMDAwZl0K
WyAgICA1LjY1MDQ3N10gQUNQSTogRGV2aWNlIFtHUEVEXSBzdGF0dXMgWzAwMDAwMDAwXQpbICAg
IDUuNjUwNDkyXSBBQ1BJOiBEZXZpY2UgW01CSURdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgNS42
NTA2OTldIEFDUEk6IERldmljZSBbUElORF0gc3RhdHVzIFswMDAwMDAwMF0KWyAgICA1LjY1MDcx
M10gQUNQSTogRGV2aWNlIFtfVFpdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAgNS42NTEzMjddIGlv
bW11OiBEZWZhdWx0IGRvbWFpbiB0eXBlOiBUcmFuc2xhdGVkClsgICAgNS42NTEzMjddIGlvbW11
OiBETUEgZG9tYWluIFRMQiBpbnZhbGlkYXRpb24gcG9saWN5OiBsYXp5IG1vZGUKWyAgICA1LjY1
MTMyN10gU0NTSSBzdWJzeXN0ZW0gaW5pdGlhbGl6ZWQKWyAgICA1LjY1MTMyN10gbGliYXRhIHZl
cnNpb24gMy4wMCBsb2FkZWQuClsgICAgNS42NTEzMjddIEFDUEk6IGJ1cyB0eXBlIFVTQiByZWdp
c3RlcmVkClsgICAgNS42NTEzMjddIHVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBk
cml2ZXIgdXNiZnMKWyAgICA1LjY1MTMyN10gdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJm
YWNlIGRyaXZlciBodWIKWyAgICA1LjY1MTMyN10gdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgZGV2
aWNlIGRyaXZlciB1c2IKWyAgICA1LjY1MTMyN10gcHBzX2NvcmU6IExpbnV4UFBTIEFQSSB2ZXIu
IDEgcmVnaXN0ZXJlZApbICAgIDUuNjUxMzI3XSBwcHNfY29yZTogU29mdHdhcmUgdmVyLiA1LjMu
NiAtIENvcHlyaWdodCAyMDA1LTIwMDcgUm9kb2xmbyBHaW9tZXR0aSA8Z2lvbWV0dGlAbGludXgu
aXQ+ClsgICAgNS42NTEzMjddIFBUUCBjbG9jayBzdXBwb3J0IHJlZ2lzdGVyZWQKWyAgICA1LjY1
MTMyN10gRURBQyBNQzogVmVyOiAzLjAuMApbICAgIDUuNjUxMzI3XSBOZXRMYWJlbDogSW5pdGlh
bGl6aW5nClsgICAgNS42NTEzMjddIE5ldExhYmVsOiAgZG9tYWluIGhhc2ggc2l6ZSA9IDEyOApb
ICAgIDUuNjUxMzI3XSBOZXRMYWJlbDogIHByb3RvY29scyA9IFVOTEFCRUxFRCBDSVBTT3Y0IENB
TElQU08KWyAgICA1LjY1MTMyN10gTmV0TGFiZWw6ICB1bmxhYmVsZWQgdHJhZmZpYyBhbGxvd2Vk
IGJ5IGRlZmF1bHQKWyAgICA1LjY1MTMyN10gUENJOiBVc2luZyBBQ1BJIGZvciBJUlEgcm91dGlu
ZwpbICAgIDUuNjU1OTg1XSBQQ0k6IHBjaV9jYWNoZV9saW5lX3NpemUgc2V0IHRvIDY0IGJ5dGVz
ClsgICAgNS42NTYwNDNdIGU4MjA6IHJlc2VydmUgUkFNIGJ1ZmZlciBbbWVtIDB4MDAwOWQ4MDAt
MHgwMDA5ZmZmZl0KWyAgICA1LjY1NjA0OV0gZTgyMDogcmVzZXJ2ZSBSQU0gYnVmZmVyIFttZW0g
MHgxZjAwMDAwMC0weDFmZmZmZmZmXQpbICAgIDUuNjU2MDU0XSBlODIwOiByZXNlcnZlIFJBTSBi
dWZmZXIgW21lbSAweDk5NjE1MDAwLTB4OWJmZmZmZmZdClsgICAgNS42NTYwNThdIGU4MjA6IHJl
c2VydmUgUkFNIGJ1ZmZlciBbbWVtIDB4OTlhZmQwMDAtMHg5YmZmZmZmZl0KWyAgICA1LjY1NjA2
Ml0gZTgyMDogcmVzZXJ2ZSBSQU0gYnVmZmVyIFttZW0gMHg5OWNhZTAwMC0weDliZmZmZmZmXQpb
ICAgIDUuNjU2MDY2XSBlODIwOiByZXNlcnZlIFJBTSBidWZmZXIgW21lbSAweDlhMDAwMDAwLTB4
OWJmZmZmZmZdClsgICAgNS42NTg2MTJdIHBjaSAwMDAwOjAwOjAyLjA6IHZnYWFyYjogc2V0dGlu
ZyBhcyBib290IFZHQSBkZXZpY2UKWyAgICA1LjY1ODYxOV0gcGNpIDAwMDA6MDA6MDIuMDogdmdh
YXJiOiBicmlkZ2UgY29udHJvbCBwb3NzaWJsZQpbICAgIDUuNjU4NjIzXSBwY2kgMDAwMDowMDow
Mi4wOiB2Z2FhcmI6IFZHQSBkZXZpY2UgYWRkZWQ6IGRlY29kZXM9aW8rbWVtLG93bnM9aW8rbWVt
LGxvY2tzPW5vbmUKWyAgICA1LjY1ODYzNF0gdmdhYXJiOiBsb2FkZWQKWyAgICA1LjY1ODc2OF0g
Y2xvY2tzb3VyY2U6IFN3aXRjaGVkIHRvIGNsb2Nrc291cmNlIHRzYy1lYXJseQpbICAgIDUuNjYw
MzcyXSBWRlM6IERpc2sgcXVvdGFzIGRxdW90XzYuNi4wClsgICAgNS42NjA0MDhdIFZGUzogRHF1
b3QtY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiA1MTIgKG9yZGVyIDAsIDQwOTYgYnl0ZXMpClsg
ICAgNS42NjA2MThdIEFwcEFybW9yOiBBcHBBcm1vciBGaWxlc3lzdGVtIEVuYWJsZWQKWyAgICA1
LjY2MDY4NV0gcG5wOiBQblAgQUNQSSBpbml0ClsgICAgNS42NjEyNDNdIHN5c3RlbSAwMDowMTog
W2lvICAweDA2ODAtMHgwNjlmXSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDUuNjYxMjU0XSBzeXN0
ZW0gMDA6MDE6IFtpbyAgMHgwNDAwLTB4MDQ3Zl0gaGFzIGJlZW4gcmVzZXJ2ZWQKWyAgICA1LjY2
MTI2MF0gc3lzdGVtIDAwOjAxOiBbaW8gIDB4MDUwMC0weDA1ZmVdIGhhcyBiZWVuIHJlc2VydmVk
ClsgICAgNS42NjEyNjZdIHN5c3RlbSAwMDowMTogW2lvICAweDA2MDAtMHgwNjFmXSBoYXMgYmVl
biByZXNlcnZlZApbICAgIDUuNjYxNzY3XSBzeXN0ZW0gMDA6MDI6IFtpbyAgMHgwYTAwLTB4MGEw
Zl0gaGFzIGJlZW4gcmVzZXJ2ZWQKWyAgICA1LjY2MTc3Nl0gc3lzdGVtIDAwOjAyOiBbaW8gIDB4
MGExMC0weDBhMWZdIGhhcyBiZWVuIHJlc2VydmVkClsgICAgOC4zMDIzMjddIHN5c3RlbSAwMDow
NDogW21lbSAweGUwMDAwMDAwLTB4ZWZmZmZmZmZdIGNvdWxkIG5vdCBiZSByZXNlcnZlZApbICAg
IDguMzAyMzQwXSBzeXN0ZW0gMDA6MDQ6IFttZW0gMHhmZWQwMTAwMC0weGZlZDAxZmZmXSBoYXMg
YmVlbiByZXNlcnZlZApbICAgIDguMzAyMzQ3XSBzeXN0ZW0gMDA6MDQ6IFttZW0gMHhmZWQwMzAw
MC0weGZlZDAzZmZmXSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDguMzAyMzYxXSBzeXN0ZW0gMDA6
MDQ6IFttZW0gMHhmZWQwNDAwMC0weGZlZDA0ZmZmXSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDgu
MzAyMzY4XSBzeXN0ZW0gMDA6MDQ6IFttZW0gMHhmZWQwYzAwMC0weGZlZDBmZmZmXSBoYXMgYmVl
biByZXNlcnZlZApbICAgIDguMzAyMzc0XSBzeXN0ZW0gMDA6MDQ6IFttZW0gMHhmZWQwODAwMC0w
eGZlZDA4ZmZmXSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDguMzAyMzgwXSBzeXN0ZW0gMDA6MDQ6
IFttZW0gMHhmZWQxYzAwMC0weGZlZDFjZmZmXSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDguMzAy
Mzg2XSBzeXN0ZW0gMDA6MDQ6IFttZW0gMHhmZWUwMDAwMC0weGZlZWZmZmZmXSBjb3VsZCBub3Qg
YmUgcmVzZXJ2ZWQKWyAgICA4LjMwMjM5Ml0gc3lzdGVtIDAwOjA0OiBbbWVtIDB4ZmVmMDAwMDAt
MHhmZWZmZmZmZl0gaGFzIGJlZW4gcmVzZXJ2ZWQKWyAgICA4LjMwMzEyN10gcG5wOiBQblAgQUNQ
STogZm91bmQgNSBkZXZpY2VzClsgICAgOC4zMTM1MjZdIGNsb2Nrc291cmNlOiBhY3BpX3BtOiBt
YXNrOiAweGZmZmZmZiBtYXhfY3ljbGVzOiAweGZmZmZmZiwgbWF4X2lkbGVfbnM6IDIwODU3MDEw
MjQgbnMKWyAgICA4LjMxMzcwOF0gTkVUOiBSZWdpc3RlcmVkIFBGX0lORVQgcHJvdG9jb2wgZmFt
aWx5ClsgICAgOC4zMTM4ODJdIElQIGlkZW50cyBoYXNoIHRhYmxlIGVudHJpZXM6IDY1NTM2IChv
cmRlcjogNywgNTI0Mjg4IGJ5dGVzLCBsaW5lYXIpClsgICAgOC4zNDYzOTddIHRjcF9saXN0ZW5f
cG9ydGFkZHJfaGFzaCBoYXNoIHRhYmxlIGVudHJpZXM6IDIwNDggKG9yZGVyOiAzLCAzMjc2OCBi
eXRlcywgbGluZWFyKQpbICAgIDguMzQ2NDcyXSBUYWJsZS1wZXJ0dXJiIGhhc2ggdGFibGUgZW50
cmllczogNjU1MzYgKG9yZGVyOiA2LCAyNjIxNDQgYnl0ZXMsIGxpbmVhcikKWyAgICA4LjM0NjU4
Ml0gVENQIGVzdGFibGlzaGVkIGhhc2ggdGFibGUgZW50cmllczogMzI3NjggKG9yZGVyOiA2LCAy
NjIxNDQgYnl0ZXMsIGxpbmVhcikKWyAgICA4LjM0Njk0M10gVENQIGJpbmQgaGFzaCB0YWJsZSBl
bnRyaWVzOiAzMjc2OCAob3JkZXI6IDgsIDEwNDg1NzYgYnl0ZXMsIGxpbmVhcikKWyAgICA4LjM0
NzI3OF0gVENQOiBIYXNoIHRhYmxlcyBjb25maWd1cmVkIChlc3RhYmxpc2hlZCAzMjc2OCBiaW5k
IDMyNzY4KQpbICAgIDguMzQ3NDI4XSBVRFAgaGFzaCB0YWJsZSBlbnRyaWVzOiAyMDQ4IChvcmRl
cjogNSwgMTMxMDcyIGJ5dGVzLCBsaW5lYXIpClsgICAgOC4zNDc1MzNdIFVEUC1MaXRlIGhhc2gg
dGFibGUgZW50cmllczogMjA0OCAob3JkZXI6IDUsIDEzMTA3MiBieXRlcywgbGluZWFyKQpbICAg
IDguMzQ3NzA2XSBORVQ6IFJlZ2lzdGVyZWQgUEZfVU5JWC9QRl9MT0NBTCBwcm90b2NvbCBmYW1p
bHkKWyAgICA4LjM0NzczMV0gTkVUOiBSZWdpc3RlcmVkIFBGX1hEUCBwcm90b2NvbCBmYW1pbHkK
WyAgICA4LjM0Nzc1Nl0gcGNpIDAwMDA6MDA6MWMuMDogYnJpZGdlIHdpbmRvdyBbaW8gIDB4MTAw
MC0weDBmZmZdIHRvIFtidXMgMDFdIGFkZF9zaXplIDEwMDAKWyAgICA4LjM0Nzc2OV0gcGNpIDAw
MDA6MDA6MWMuMDogYnJpZGdlIHdpbmRvdyBbbWVtIDB4MDAxMDAwMDAtMHgwMDBmZmZmZiA2NGJp
dCBwcmVmXSB0byBbYnVzIDAxXSBhZGRfc2l6ZSAyMDAwMDAgYWRkX2FsaWduIDEwMDAwMApbICAg
IDguMzQ3Nzc5XSBwY2kgMDAwMDowMDoxYy4yOiBicmlkZ2Ugd2luZG93IFtpbyAgMHgxMDAwLTB4
MGZmZl0gdG8gW2J1cyAwMl0gYWRkX3NpemUgMTAwMApbICAgIDguMzQ3Nzg2XSBwY2kgMDAwMDow
MDoxYy4yOiBicmlkZ2Ugd2luZG93IFttZW0gMHgwMDEwMDAwMC0weDAwMGZmZmZmIDY0Yml0IHBy
ZWZdIHRvIFtidXMgMDJdIGFkZF9zaXplIDIwMDAwMCBhZGRfYWxpZ24gMTAwMDAwClsgICAgOC4z
NDc3OTRdIHBjaSAwMDAwOjAwOjFjLjI6IGJyaWRnZSB3aW5kb3cgW21lbSAweDAwMTAwMDAwLTB4
MDAwZmZmZmZdIHRvIFtidXMgMDJdIGFkZF9zaXplIDIwMDAwMCBhZGRfYWxpZ24gMTAwMDAwClsg
ICAgOC4zNDc4MDJdIHBjaSAwMDAwOjAwOjFjLjM6IGJyaWRnZSB3aW5kb3cgW21lbSAweDAwMTAw
MDAwLTB4MDAwZmZmZmYgNjRiaXQgcHJlZl0gdG8gW2J1cyAwM10gYWRkX3NpemUgMjAwMDAwIGFk
ZF9hbGlnbiAxMDAwMDAKWyAgICA4LjM0NzgyOF0gcGNpIDAwMDA6MDA6MWMuMDogYnJpZGdlIHdp
bmRvdyBbbWVtIHNpemUgMHgwMDIwMDAwMCA2NGJpdCBwcmVmXTogY2FuJ3QgYXNzaWduOyBubyBz
cGFjZQpbICAgIDguMzQ3ODM2XSBwY2kgMDAwMDowMDoxYy4wOiBicmlkZ2Ugd2luZG93IFttZW0g
c2l6ZSAweDAwMjAwMDAwIDY0Yml0IHByZWZdOiBmYWlsZWQgdG8gYXNzaWduClsgICAgOC4zNDc4
NDRdIHBjaSAwMDAwOjAwOjFjLjI6IGJyaWRnZSB3aW5kb3cgW21lbSBzaXplIDB4MDAyMDAwMDBd
OiBjYW4ndCBhc3NpZ247IG5vIHNwYWNlClsgICAgOC4zNDc4NDldIHBjaSAwMDAwOjAwOjFjLjI6
IGJyaWRnZSB3aW5kb3cgW21lbSBzaXplIDB4MDAyMDAwMDBdOiBmYWlsZWQgdG8gYXNzaWduClsg
ICAgOC4zNDc4NjNdIHBjaSAwMDAwOjAwOjFjLjI6IGJyaWRnZSB3aW5kb3cgW21lbSBzaXplIDB4
MDAyMDAwMDAgNjRiaXQgcHJlZl06IGNhbid0IGFzc2lnbjsgbm8gc3BhY2UKWyAgICA4LjM0Nzg3
MF0gcGNpIDAwMDA6MDA6MWMuMjogYnJpZGdlIHdpbmRvdyBbbWVtIHNpemUgMHgwMDIwMDAwMCA2
NGJpdCBwcmVmXTogZmFpbGVkIHRvIGFzc2lnbgpbICAgIDguMzQ3ODc5XSBwY2kgMDAwMDowMDox
Yy4zOiBicmlkZ2Ugd2luZG93IFttZW0gc2l6ZSAweDAwMjAwMDAwIDY0Yml0IHByZWZdOiBjYW4n
dCBhc3NpZ247IG5vIHNwYWNlClsgICAgOC4zNDc4ODVdIHBjaSAwMDAwOjAwOjFjLjM6IGJyaWRn
ZSB3aW5kb3cgW21lbSBzaXplIDB4MDAyMDAwMDAgNjRiaXQgcHJlZl06IGZhaWxlZCB0byBhc3Np
Z24KWyAgICA4LjM0Nzg5Ml0gcGNpIDAwMDA6MDA6MWMuMDogYnJpZGdlIHdpbmRvdyBbaW8gIDB4
MTAwMC0weDFmZmZdOiBhc3NpZ25lZApbICAgIDguMzQ3OTAwXSBwY2kgMDAwMDowMDoxYy4yOiBi
cmlkZ2Ugd2luZG93IFtpbyAgMHgyMDAwLTB4MmZmZl06IGFzc2lnbmVkClsgICAgOC4zNDc5MTFd
IHBjaSAwMDAwOjAwOjFjLjM6IGJyaWRnZSB3aW5kb3cgW21lbSBzaXplIDB4MDAyMDAwMDAgNjRi
aXQgcHJlZl06IGNhbid0IGFzc2lnbjsgbm8gc3BhY2UKWyAgICA4LjM0NzkxN10gcGNpIDAwMDA6
MDA6MWMuMzogYnJpZGdlIHdpbmRvdyBbbWVtIHNpemUgMHgwMDIwMDAwMCA2NGJpdCBwcmVmXTog
ZmFpbGVkIHRvIGFzc2lnbgpbICAgIDguMzQ3OTI0XSBwY2kgMDAwMDowMDoxYy4yOiBicmlkZ2Ug
d2luZG93IFttZW0gc2l6ZSAweDAwMjAwMDAwXTogY2FuJ3QgYXNzaWduOyBubyBzcGFjZQpbICAg
IDguMzQ3OTI5XSBwY2kgMDAwMDowMDoxYy4yOiBicmlkZ2Ugd2luZG93IFttZW0gc2l6ZSAweDAw
MjAwMDAwXTogZmFpbGVkIHRvIGFzc2lnbgpbICAgIDguMzQ3OTM3XSBwY2kgMDAwMDowMDoxYy4y
OiBicmlkZ2Ugd2luZG93IFttZW0gc2l6ZSAweDAwMjAwMDAwIDY0Yml0IHByZWZdOiBjYW4ndCBh
c3NpZ247IG5vIHNwYWNlClsgICAgOC4zNDc5NDNdIHBjaSAwMDAwOjAwOjFjLjI6IGJyaWRnZSB3
aW5kb3cgW21lbSBzaXplIDB4MDAyMDAwMDAgNjRiaXQgcHJlZl06IGZhaWxlZCB0byBhc3NpZ24K
WyAgICA4LjM0Nzk1MV0gcGNpIDAwMDA6MDA6MWMuMDogYnJpZGdlIHdpbmRvdyBbbWVtIHNpemUg
MHgwMDIwMDAwMCA2NGJpdCBwcmVmXTogY2FuJ3QgYXNzaWduOyBubyBzcGFjZQpbICAgIDguMzQ3
OTU2XSBwY2kgMDAwMDowMDoxYy4wOiBicmlkZ2Ugd2luZG93IFttZW0gc2l6ZSAweDAwMjAwMDAw
IDY0Yml0IHByZWZdOiBmYWlsZWQgdG8gYXNzaWduClsgICAgOC4zNDc5NjZdIHBjaSAwMDAwOjAw
OjFjLjA6IFBDSSBicmlkZ2UgdG8gW2J1cyAwMV0KWyAgICA4LjM0Nzk3M10gcGNpIDAwMDA6MDA6
MWMuMDogICBicmlkZ2Ugd2luZG93IFtpbyAgMHgxMDAwLTB4MWZmZl0KWyAgICA4LjM0Nzk4Ml0g
cGNpIDAwMDA6MDA6MWMuMDogICBicmlkZ2Ugd2luZG93IFttZW0gMHhiMDQwMDAwMC0weGIwN2Zm
ZmZmXQpbICAgIDguMzQ3OTkzXSBwY2kgMDAwMDowMDoxYy4yOiBQQ0kgYnJpZGdlIHRvIFtidXMg
MDJdClsgICAgOC4zNDc5OThdIHBjaSAwMDAwOjAwOjFjLjI6ICAgYnJpZGdlIHdpbmRvdyBbaW8g
IDB4MjAwMC0weDJmZmZdClsgICAgOC4zNDgwMTFdIHBjaSAwMDAwOjAwOjFjLjM6IFBDSSBicmlk
Z2UgdG8gW2J1cyAwM10KWyAgICA4LjM0ODAxNl0gcGNpIDAwMDA6MDA6MWMuMzogICBicmlkZ2Ug
d2luZG93IFtpbyAgMHhkMDAwLTB4ZGZmZl0KWyAgICA4LjM0ODAyNF0gcGNpIDAwMDA6MDA6MWMu
MzogICBicmlkZ2Ugd2luZG93IFttZW0gMHhiMGEwMDAwMC0weGIwYWZmZmZmXQpbICAgIDguMzQ4
MDM1XSBwY2lfYnVzIDAwMDA6MDA6IHJlc291cmNlIDQgW2lvICAweDAwNzAtMHgwMDc3XQpbICAg
IDguMzQ4MDQwXSBwY2lfYnVzIDAwMDA6MDA6IHJlc291cmNlIDUgW2lvICAweDAwMDAtMHgwMDZm
IHdpbmRvd10KWyAgICA4LjM0ODA0Nl0gcGNpX2J1cyAwMDAwOjAwOiByZXNvdXJjZSA2IFtpbyAg
MHgwMDc4LTB4MGNmNyB3aW5kb3ddClsgICAgOC4zNDgwNTFdIHBjaV9idXMgMDAwMDowMDogcmVz
b3VyY2UgNyBbaW8gIDB4MGQwMC0weGZmZmYgd2luZG93XQpbICAgIDguMzQ4MDU2XSBwY2lfYnVz
IDAwMDA6MDA6IHJlc291cmNlIDggW21lbSAweDAwMGEwMDAwLTB4MDAwZmZmZmYgd2luZG93XQpb
ICAgIDguMzQ4MDYyXSBwY2lfYnVzIDAwMDA6MDA6IHJlc291cmNlIDkgW21lbSAweGEwMDAwMDAw
LTB4YjBiMTdmZmYgd2luZG93XQpbICAgIDguMzQ4MDY3XSBwY2lfYnVzIDAwMDA6MDE6IHJlc291
cmNlIDAgW2lvICAweDEwMDAtMHgxZmZmXQpbICAgIDguMzQ4MDcyXSBwY2lfYnVzIDAwMDA6MDE6
IHJlc291cmNlIDEgW21lbSAweGIwNDAwMDAwLTB4YjA3ZmZmZmZdClsgICAgOC4zNDgwNzhdIHBj
aV9idXMgMDAwMDowMjogcmVzb3VyY2UgMCBbaW8gIDB4MjAwMC0weDJmZmZdClsgICAgOC4zNDgw
ODNdIHBjaV9idXMgMDAwMDowMzogcmVzb3VyY2UgMCBbaW8gIDB4ZDAwMC0weGRmZmZdClsgICAg
OC4zNDgwODhdIHBjaV9idXMgMDAwMDowMzogcmVzb3VyY2UgMSBbbWVtIDB4YjBhMDAwMDAtMHhi
MGFmZmZmZl0KWyAgICA4LjM0ODc1M10gUENJOiBDTFMgNjQgYnl0ZXMsIGRlZmF1bHQgNjQKWyAg
ICA4LjM0ODc4MF0gUENJLURNQTogVXNpbmcgc29mdHdhcmUgYm91bmNlIGJ1ZmZlcmluZyBmb3Ig
SU8gKFNXSU9UTEIpClsgICAgOC4zNDg3ODVdIHNvZnR3YXJlIElPIFRMQjogbWFwcGVkIFttZW0g
MHgwMDAwMDAwMDk1NjE1MDAwLTB4MDAwMDAwMDA5OTYxNTAwMF0gKDY0TUIpClsgICAgOC4zNDg5
NDhdIFRyeWluZyB0byB1bnBhY2sgcm9vdGZzIGltYWdlIGFzIGluaXRyYW1mcy4uLgpbICAgIDgu
MzQ5Mzk1XSBjbG9ja3NvdXJjZTogdHNjOiBtYXNrOiAweGZmZmZmZmZmZmZmZmZmZmYgbWF4X2N5
Y2xlczogMHgzNzQxNTk0ZDM0ZCwgbWF4X2lkbGVfbnM6IDg4MTU5MDQyMDU2NCBucwpbICAgIDgu
MzQ5NDU1XSBjbG9ja3NvdXJjZTogU3dpdGNoZWQgdG8gY2xvY2tzb3VyY2UgdHNjClsgICAgOC4z
NDk2NDRdIGlvc2ZfbWJpX3BjaSAwMDAwOjAwOjAwLjA6IHZnYWFyYjogcGNpX25vdGlmeQpbICAg
IDguMzQ5NjU5XSBpb3NmX21iaV9wY2kgMDAwMDowMDowMC4wOiBydW50aW1lIElSUSBtYXBwaW5n
IG5vdCBwcm92aWRlZCBieSBhcmNoClsgICAgOC4zNDk2OThdIGlvc2ZfbWJpX3BjaSAwMDAwOjAw
OjAwLjA6IHZnYWFyYjogcGNpX25vdGlmeQpbICAgIDguMzUwNjkxXSBJbml0aWFsaXNlIHN5c3Rl
bSB0cnVzdGVkIGtleXJpbmdzClsgICAgOC4zNTA3MjNdIEtleSB0eXBlIGJsYWNrbGlzdCByZWdp
c3RlcmVkClsgICAgOC4zNTA4NjddIHdvcmtpbmdzZXQ6IHRpbWVzdGFtcF9iaXRzPTM2IG1heF9v
cmRlcj0yMCBidWNrZXRfb3JkZXI9MApbICAgIDguMzUwOTEzXSB6YnVkOiBsb2FkZWQKWyAgICA4
LjM1MTYxMl0gc3F1YXNoZnM6IHZlcnNpb24gNC4wICgyMDA5LzAxLzMxKSBQaGlsbGlwIExvdWdo
ZXIKWyAgICA4LjM1MTk3N10gZnVzZTogaW5pdCAoQVBJIHZlcnNpb24gNy40MikKWyAgICA4LjM1
MjM2N10gaW50ZWdyaXR5OiBQbGF0Zm9ybSBLZXlyaW5nIGluaXRpYWxpemVkClsgICAgOC4zOTAw
NjZdIEtleSB0eXBlIGFzeW1tZXRyaWMgcmVnaXN0ZXJlZApbICAgIDguMzkwMDgyXSBBc3ltbWV0
cmljIGtleSBwYXJzZXIgJ3g1MDknIHJlZ2lzdGVyZWQKWyAgICA4LjM5MDE4OF0gQmxvY2sgbGF5
ZXIgU0NTSSBnZW5lcmljIChic2cpIGRyaXZlciB2ZXJzaW9uIDAuNCBsb2FkZWQgKG1ham9yIDI0
NSkKWyAgICA4LjM5MDQxNF0gaW8gc2NoZWR1bGVyIG1xLWRlYWRsaW5lIHJlZ2lzdGVyZWQKWyAg
ICA4LjM5MzUxN10gbGVkdHJpZy1jcHU6IHJlZ2lzdGVyZWQgdG8gaW5kaWNhdGUgYWN0aXZpdHkg
b24gQ1BVcwpbICAgIDguMzkzNTc1XSBwY2llaHA6IHBjaWVfcG9ydF9zZXJ2aWNlX3JlZ2lzdGVy
ID0gMApbICAgIDguMzkzNjA2XSBwY2llcG9ydCAwMDAwOjAwOjFjLjA6IHZnYWFyYjogcGNpX25v
dGlmeQpbICAgIDguMzkzNjI2XSBwY2llcG9ydCAwMDAwOjAwOjFjLjA6IHJ1bnRpbWUgSVJRIG1h
cHBpbmcgbm90IHByb3ZpZGVkIGJ5IGFyY2gKWyAgICA4LjM5NDAzMl0gcGNpZXBvcnQgMDAwMDow
MDoxYy4wOiBid2N0cmw6IGVuYWJsZWQgd2l0aCBJUlEgODcKWyAgICA4LjM5NDA1OF0gcGNpZXBv
cnQgMDAwMDowMDoxYy4wOiBzYXZlIGNvbmZpZyAweDAwOiAweDBmNDg4MDg2ClsgICAgOC4zOTQw
NjZdIHBjaWVwb3J0IDAwMDA6MDA6MWMuMDogc2F2ZSBjb25maWcgMHgwNDogMHgwMDEwMDQwNwpb
ICAgIDguMzk0MDczXSBwY2llcG9ydCAwMDAwOjAwOjFjLjA6IHNhdmUgY29uZmlnIDB4MDg6IDB4
MDYwNDAwMTEKWyAgICA4LjM5NDA3OF0gcGNpZXBvcnQgMDAwMDowMDoxYy4wOiBzYXZlIGNvbmZp
ZyAweDBjOiAweDAwODEwMDEwClsgICAgOC4zOTQwODRdIHBjaWVwb3J0IDAwMDA6MDA6MWMuMDog
c2F2ZSBjb25maWcgMHgxMDogMHgwMDAwMDAwMApbICAgIDguMzk0MDkwXSBwY2llcG9ydCAwMDAw
OjAwOjFjLjA6IHNhdmUgY29uZmlnIDB4MTQ6IDB4MDAwMDAwMDAKWyAgICA4LjM5NDA5NV0gcGNp
ZXBvcnQgMDAwMDowMDoxYy4wOiBzYXZlIGNvbmZpZyAweDE4OiAweDAwMDEwMTAwClsgICAgOC4z
OTQxMDFdIHBjaWVwb3J0IDAwMDA6MDA6MWMuMDogc2F2ZSBjb25maWcgMHgxYzogMHgwMDAwMTAx
MApbICAgIDguMzk0MTA3XSBwY2llcG9ydCAwMDAwOjAwOjFjLjA6IHNhdmUgY29uZmlnIDB4MjA6
IDB4YjA3MGIwNDAKWyAgICA4LjM5NDExMl0gcGNpZXBvcnQgMDAwMDowMDoxYy4wOiBzYXZlIGNv
bmZpZyAweDI0OiAweDAwMDFmZmYxClsgICAgOC4zOTQxMThdIHBjaWVwb3J0IDAwMDA6MDA6MWMu
MDogc2F2ZSBjb25maWcgMHgyODogMHgwMDAwMDAwMApbICAgIDguMzk0MTIzXSBwY2llcG9ydCAw
MDAwOjAwOjFjLjA6IHNhdmUgY29uZmlnIDB4MmM6IDB4MDAwMDAwMDAKWyAgICA4LjM5NDEyOV0g
cGNpZXBvcnQgMDAwMDowMDoxYy4wOiBzYXZlIGNvbmZpZyAweDMwOiAweDAwMDAwMDAwClsgICAg
OC4zOTQxMzRdIHBjaWVwb3J0IDAwMDA6MDA6MWMuMDogc2F2ZSBjb25maWcgMHgzNDogMHgwMDAw
MDA0MApbICAgIDguMzk0MTQwXSBwY2llcG9ydCAwMDAwOjAwOjFjLjA6IHNhdmUgY29uZmlnIDB4
Mzg6IDB4MDAwMDAwMDAKWyAgICA4LjM5NDE0NV0gcGNpZXBvcnQgMDAwMDowMDoxYy4wOiBzYXZl
IGNvbmZpZyAweDNjOiAweDAwMTIwMTBiClsgICAgOC4zOTQxNzddIHBjaWVwb3J0IDAwMDA6MDA6
MWMuMDogdmdhYXJiOiBwY2lfbm90aWZ5ClsgICAgOC4zOTQxOTldIHBjaWVwb3J0IDAwMDA6MDA6
MWMuMjogdmdhYXJiOiBwY2lfbm90aWZ5ClsgICAgOC4zOTQyMTFdIHBjaWVwb3J0IDAwMDA6MDA6
MWMuMjogcnVudGltZSBJUlEgbWFwcGluZyBub3QgcHJvdmlkZWQgYnkgYXJjaApbICAgIDguMzk0
NDc3XSBwY2llcG9ydCAwMDAwOjAwOjFjLjI6IGJ3Y3RybDogZW5hYmxlZCB3aXRoIElSUSA4OApb
ICAgIDguMzk0NTAwXSBwY2llcG9ydCAwMDAwOjAwOjFjLjI6IHNhdmUgY29uZmlnIDB4MDA6IDB4
MGY0YzgwODYKWyAgICA4LjM5NDUwOF0gcGNpZXBvcnQgMDAwMDowMDoxYy4yOiBzYXZlIGNvbmZp
ZyAweDA0OiAweDAwMTAwNDA3ClsgICAgOC4zOTQ1MTRdIHBjaWVwb3J0IDAwMDA6MDA6MWMuMjog
c2F2ZSBjb25maWcgMHgwODogMHgwNjA0MDAxMQpbICAgIDguMzk0NTE5XSBwY2llcG9ydCAwMDAw
OjAwOjFjLjI6IHNhdmUgY29uZmlnIDB4MGM6IDB4MDA4MTAwMTAKWyAgICA4LjM5NDUyNV0gcGNp
ZXBvcnQgMDAwMDowMDoxYy4yOiBzYXZlIGNvbmZpZyAweDEwOiAweDAwMDAwMDAwClsgICAgOC4z
OTQ1MzFdIHBjaWVwb3J0IDAwMDA6MDA6MWMuMjogc2F2ZSBjb25maWcgMHgxNDogMHgwMDAwMDAw
MApbICAgIDguMzk0NTM2XSBwY2llcG9ydCAwMDAwOjAwOjFjLjI6IHNhdmUgY29uZmlnIDB4MTg6
IDB4MDAwMjAyMDAKWyAgICA4LjM5NDU0Ml0gcGNpZXBvcnQgMDAwMDowMDoxYy4yOiBzYXZlIGNv
bmZpZyAweDFjOiAweDAwMDAyMDIwClsgICAgOC4zOTQ1NDddIHBjaWVwb3J0IDAwMDA6MDA6MWMu
Mjogc2F2ZSBjb25maWcgMHgyMDogMHgwMDAwZmZmMApbICAgIDguMzk0NTUzXSBwY2llcG9ydCAw
MDAwOjAwOjFjLjI6IHNhdmUgY29uZmlnIDB4MjQ6IDB4MDAwMWZmZjEKWyAgICA4LjM5NDU1OF0g
cGNpZXBvcnQgMDAwMDowMDoxYy4yOiBzYXZlIGNvbmZpZyAweDI4OiAweDAwMDAwMDAwClsgICAg
OC4zOTQ1NjRdIHBjaWVwb3J0IDAwMDA6MDA6MWMuMjogc2F2ZSBjb25maWcgMHgyYzogMHgwMDAw
MDAwMApbICAgIDguMzk0NTY5XSBwY2llcG9ydCAwMDAwOjAwOjFjLjI6IHNhdmUgY29uZmlnIDB4
MzA6IDB4MDAwMDAwMDAKWyAgICA4LjM5NDU3NV0gcGNpZXBvcnQgMDAwMDowMDoxYy4yOiBzYXZl
IGNvbmZpZyAweDM0OiAweDAwMDAwMDQwClsgICAgOC4zOTQ1ODBdIHBjaWVwb3J0IDAwMDA6MDA6
MWMuMjogc2F2ZSBjb25maWcgMHgzODogMHgwMDAwMDAwMApbICAgIDguMzk0NTg2XSBwY2llcG9y
dCAwMDAwOjAwOjFjLjI6IHNhdmUgY29uZmlnIDB4M2M6IDB4MDAxMjAzMGIKWyAgICA4LjM5NDYx
Ml0gcGNpZXBvcnQgMDAwMDowMDoxYy4yOiB2Z2FhcmI6IHBjaV9ub3RpZnkKWyAgICA4LjM5NDYz
M10gcGNpZXBvcnQgMDAwMDowMDoxYy4zOiB2Z2FhcmI6IHBjaV9ub3RpZnkKWyAgICA4LjM5NDY0
NV0gcGNpZXBvcnQgMDAwMDowMDoxYy4zOiBydW50aW1lIElSUSBtYXBwaW5nIG5vdCBwcm92aWRl
ZCBieSBhcmNoClsgICAgOC4zOTQ5MzBdIHBjaWVwb3J0IDAwMDA6MDA6MWMuMzogYndjdHJsOiBl
bmFibGVkIHdpdGggSVJRIDg5ClsgICAgOC4zOTQ5NTNdIHBjaWVwb3J0IDAwMDA6MDA6MWMuMzog
c2F2ZSBjb25maWcgMHgwMDogMHgwZjRlODA4NgpbICAgIDguMzk0OTYwXSBwY2llcG9ydCAwMDAw
OjAwOjFjLjM6IHNhdmUgY29uZmlnIDB4MDQ6IDB4MDAxMDA0MDcKWyAgICA4LjM5NDk2N10gcGNp
ZXBvcnQgMDAwMDowMDoxYy4zOiBzYXZlIGNvbmZpZyAweDA4OiAweDA2MDQwMDExClsgICAgOC4z
OTQ5NzJdIHBjaWVwb3J0IDAwMDA6MDA6MWMuMzogc2F2ZSBjb25maWcgMHgwYzogMHgwMDgxMDAx
MApbICAgIDguMzk0OTc4XSBwY2llcG9ydCAwMDAwOjAwOjFjLjM6IHNhdmUgY29uZmlnIDB4MTA6
IDB4MDAwMDAwMDAKWyAgICA4LjM5NDk4M10gcGNpZXBvcnQgMDAwMDowMDoxYy4zOiBzYXZlIGNv
bmZpZyAweDE0OiAweDAwMDAwMDAwClsgICAgOC4zOTQ5ODldIHBjaWVwb3J0IDAwMDA6MDA6MWMu
Mzogc2F2ZSBjb25maWcgMHgxODogMHgwMDAzMDMwMApbICAgIDguMzk0OTk0XSBwY2llcG9ydCAw
MDAwOjAwOjFjLjM6IHNhdmUgY29uZmlnIDB4MWM6IDB4MDAwMGQwZDAKWyAgICA4LjM5NTAwMF0g
cGNpZXBvcnQgMDAwMDowMDoxYy4zOiBzYXZlIGNvbmZpZyAweDIwOiAweGIwYTBiMGEwClsgICAg
OC4zOTUwMDZdIHBjaWVwb3J0IDAwMDA6MDA6MWMuMzogc2F2ZSBjb25maWcgMHgyNDogMHgwMDAx
ZmZmMQpbICAgIDguMzk1MDExXSBwY2llcG9ydCAwMDAwOjAwOjFjLjM6IHNhdmUgY29uZmlnIDB4
Mjg6IDB4MDAwMDAwMDAKWyAgICA4LjM5NTAxN10gcGNpZXBvcnQgMDAwMDowMDoxYy4zOiBzYXZl
IGNvbmZpZyAweDJjOiAweDAwMDAwMDAwClsgICAgOC4zOTUwMjJdIHBjaWVwb3J0IDAwMDA6MDA6
MWMuMzogc2F2ZSBjb25maWcgMHgzMDogMHgwMDAwMDAwMApbICAgIDguMzk1MDI3XSBwY2llcG9y
dCAwMDAwOjAwOjFjLjM6IHNhdmUgY29uZmlnIDB4MzQ6IDB4MDAwMDAwNDAKWyAgICA4LjM5NTAz
M10gcGNpZXBvcnQgMDAwMDowMDoxYy4zOiBzYXZlIGNvbmZpZyAweDM4OiAweDAwMDAwMDAwClsg
ICAgOC4zOTUwMzldIHBjaWVwb3J0IDAwMDA6MDA6MWMuMzogc2F2ZSBjb25maWcgMHgzYzogMHgw
MDEyMDQwYQpbICAgIDguMzk1MDY3XSBwY2llcG9ydCAwMDAwOjAwOjFjLjM6IHZnYWFyYjogcGNp
X25vdGlmeQpbICAgIDguMzk1MTU0XSBzaHBjaHA6IFN0YW5kYXJkIEhvdCBQbHVnIFBDSSBDb250
cm9sbGVyIERyaXZlciB2ZXJzaW9uOiAwLjQKWyAgICA5LjM0Mjg0MV0gRnJlZWluZyBpbml0cmQg
bWVtb3J5OiAxNDIzNzJLClsgICAxMC4wMzk3NDNdIEFDUEk6IEFDOiBBQyBBZGFwdGVyIFtBRFAx
XSAob24tbGluZSkKWyAgIDEwLjAzOTk1MV0gaW5wdXQ6IFBvd2VyIEJ1dHRvbiBhcyAvZGV2aWNl
cy9MTlhTWVNUTTowMC9MTlhTWUJVUzowMC9QTlAwQzBDOjAwL2lucHV0L2lucHV0MApbICAgMTAu
MDQxMTQyXSBBQ1BJOiBidXR0b246IFBvd2VyIEJ1dHRvbiBbUFdSQl0KWyAgIDEwLjA0MTE1M10g
QUNQSTogRHJpdmVyIFtidXR0b25dIHN1Y2Nlc3NmdWxseSBib3VuZCB0byBkZXZpY2UgW1BXUkJd
ClsgICAxMC4wNDExNTldIEFDUEk6IEZvdW5kIGRyaXZlciBbYnV0dG9uXSBmb3IgZGV2aWNlIFtQ
V1JCXQpbICAgMTAuMDQxMjgzXSBpbnB1dDogU2xlZXAgQnV0dG9uIGFzIC9kZXZpY2VzL0xOWFNZ
U1RNOjAwL0xOWFNZQlVTOjAwL1BOUDBDMEU6MDAvaW5wdXQvaW5wdXQxClsgICAxMC4wNDIyNjNd
IEFDUEk6IGJ1dHRvbjogU2xlZXAgQnV0dG9uIFtTTFBCXQpbICAgMTAuMDQyMjc0XSBBQ1BJOiBE
cml2ZXIgW2J1dHRvbl0gc3VjY2Vzc2Z1bGx5IGJvdW5kIHRvIGRldmljZSBbU0xQQl0KWyAgIDEw
LjA0MjI3OV0gQUNQSTogRm91bmQgZHJpdmVyIFtidXR0b25dIGZvciBkZXZpY2UgW1NMUEJdClsg
ICAxMC4wNDI0MTBdIGlucHV0OiBMaWQgU3dpdGNoIGFzIC9kZXZpY2VzL0xOWFNZU1RNOjAwL0xO
WFNZQlVTOjAwL1BOUDBDMEQ6MDAvaW5wdXQvaW5wdXQyClsgICAxMC4wNDM0NjldIEFDUEk6IGJ1
dHRvbjogTGlkIFN3aXRjaCBbTElEMF0KWyAgIDEwLjA0MzQ4MV0gQUNQSTogRHJpdmVyIFtidXR0
b25dIHN1Y2Nlc3NmdWxseSBib3VuZCB0byBkZXZpY2UgW0xJRDBdClsgICAxMC4wNDM0ODZdIEFD
UEk6IEZvdW5kIGRyaXZlciBbYnV0dG9uXSBmb3IgZGV2aWNlIFtMSUQwXQpbICAgMTAuMDQzNjE5
XSBpbnB1dDogUG93ZXIgQnV0dG9uIGFzIC9kZXZpY2VzL0xOWFNZU1RNOjAwL0xOWFBXUkJOOjAw
L2lucHV0L2lucHV0MwpbICAgMTAuMDQ0Njk0XSBBQ1BJOiBidXR0b246IFBvd2VyIEJ1dHRvbiBb
UFdSRl0KWyAgIDEwLjA0NDcwNl0gQUNQSTogRHJpdmVyIFtidXR0b25dIHN1Y2Nlc3NmdWxseSBi
b3VuZCB0byBkZXZpY2UgW1BXUkZdClsgICAxMC4wNDQ3MTFdIEFDUEk6IEZvdW5kIGRyaXZlciBb
YnV0dG9uXSBmb3IgZGV2aWNlIFtQV1JGXQpbICAgMTAuMDUyNTU1XSBTZXJpYWw6IDgyNTAvMTY1
NTAgZHJpdmVyLCAzMiBwb3J0cywgSVJRIHNoYXJpbmcgZW5hYmxlZApbICAgMTAuMDUyODUyXSAw
MDowMzogdHR5UzAgYXQgSS9PIDB4M2Y4IChpcnEgPSA0LCBiYXNlX2JhdWQgPSAxMTUyMDApIGlz
IGEgMTY1NTBBClsgICAxMC4wNzg0NDddIEFDUEk6IERldmljZSBbSVNQMF0gc3RhdHVzIFswMDAw
MDAwMF0KWyAgIDEwLjA3ODUzMF0gQUNQSTogRGV2aWNlIFtIX0VDXSBzdGF0dXMgWzAwMDAwMDAw
XQpbICAgMTAuMDc4NTY2XSBBQ1BJOiBEZXZpY2UgW0JBVDBdIHN0YXR1cyBbMDAwMDAwMDBdClsg
ICAxMC4wNzg2MDFdIEFDUEk6IERldmljZSBbQkFUMV0gc3RhdHVzIFswMDAwMDAwMF0KWyAgIDEw
LjA3ODYzNl0gQUNQSTogRGV2aWNlIFtCQVQyXSBzdGF0dXMgWzAwMDAwMDAwXQpbICAgMTAuMDc4
Njk1XSBBQ1BJOiBEZXZpY2UgW1dQQ05dIHN0YXR1cyBbMDAwMDAwMDBdClsgICAxMC4wNzg3NTBd
IEFDUEk6IERldmljZSBbVUFSNV0gc3RhdHVzIFswMDAwMDAwMF0KWyAgIDEwLjA3ODgwNl0gQUNQ
STogRGV2aWNlIFtVQVI4XSBzdGF0dXMgWzAwMDAwMDAwXQpbICAgMTAuMDc5MTAwXSBBQ1BJOiBE
ZXZpY2UgW0xQVEVdIHN0YXR1cyBbMDAwMDAwMDBdClsgICAxMC4wNzkzODJdIEFDUEk6IERldmlj
ZSBbUFMyS10gc3RhdHVzIFswMDAwMDAwMF0KWyAgIDEwLjA3OTY2NF0gQUNQSTogRGV2aWNlIFtQ
UzJNXSBzdGF0dXMgWzAwMDAwMDAwXQpbICAgMTAuMDc5NzAwXSBBQ1BJOiBEZXZpY2UgW1NTUEld
IHN0YXR1cyBbMDAwMDAwMDBdClsgICAxMC4wNzk3MzZdIEFDUEk6IERldmljZSBbU0dQSV0gc3Rh
dHVzIFswMDAwMDAwMF0KWyAgIDEwLjA3OTc3MF0gQUNQSTogRGV2aWNlIFtTSFdNXSBzdGF0dXMg
WzAwMDAwMDAwXQpbICAgMTAuMDc5ODA0XSBBQ1BJOiBEZXZpY2UgW1NDUEldIHN0YXR1cyBbMDAw
MDAwMDBdClsgICAxMC4wODAwODNdIEFDUEk6IERldmljZSBbVUFSMV0gc3RhdHVzIFswMDAwMDAw
MF0KWyAgIDEwLjA4MDM2NF0gQUNQSTogRGV2aWNlIFtVQVIyXSBzdGF0dXMgWzAwMDAwMDAwXQpb
ICAgMTMuMjg1MDI5XSBBQ1BJOiBEZXZpY2UgW0JBVDJdIHN0YXR1cyBbMDAwMDAwMDBdClsgICAx
My41MTgzODVdIEFDUEk6IERldmljZSBbRUhDMV0gc3RhdHVzIFswMDAwMDAwMF0KWyAgIDEzLjU0
NDAzMF0gQUNQSTogRGV2aWNlIFtIVUJOXSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgMTMuNTQ0NjY2
XSBBQ1BJOiBEZXZpY2UgW1BSMDFdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAxMy41NzAzMjFdIEFD
UEk6IERldmljZSBbUFIxMV0gc3RhdHVzIFswMDAwMDAwZl0KWyAgIDEzLjU5NjI0OF0gQUNQSTog
RGV2aWNlIFtQUjEyXSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgMTMuNjIyMTQ2XSBBQ1BJOiBEZXZp
Y2UgW1BSMTNdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAxMy42NDgxMTldIEFDUEk6IERldmljZSBb
UFIxNF0gc3RhdHVzIFswMDAwMDAwZl0KWyAgIDEzLjY3NDA5Nl0gQUNQSTogRGV2aWNlIFtQUjE1
XSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgMTMuNzAwMDExXSBBQ1BJOiBEZXZpY2UgW1BSMTZdIHN0
YXR1cyBbMDAwMDAwMGZdClsgICAxMy43MjYwMjJdIEFDUEk6IERldmljZSBbUFIxN10gc3RhdHVz
IFswMDAwMDAwZl0KWyAgIDEzLjc1MTg0NV0gQUNQSTogRGV2aWNlIFtQUjE4XSBzdGF0dXMgWzAw
MDAwMDBmXQpbICAgMTQuMjcxOTQ0XSBBQ1BJOiBEZXZpY2UgW0VNNDFdIHN0YXR1cyBbMDAwMDAw
MDBdClsgICAxNC4yOTc1NjldIEFDUEk6IERldmljZSBbQ0FSRF0gc3RhdHVzIFswMDAwMDAwZl0K
WyAgIDE0LjM3NTI5Nl0gQUNQSTogRGV2aWNlIFtPVEcxXSBzdGF0dXMgWzAwMDAwMDAwXQpbICAg
MTQuNDAxNDM5XSBBQ1BJOiBEZXZpY2UgW0xQRUFdIHN0YXR1cyBbMDAwMDAwMDBdClsgICAxNC40
Mjc2ODBdIEFDUEk6IERldmljZSBbTFBBMl0gc3RhdHVzIFswMDAwMDAwMF0KWyAgIDE0LjQyNzY5
Nl0gQUNQSTogRGV2aWNlIFtBRE1BXSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgMTQuNDUzOTcxXSBB
Q1BJOiBEZXZpY2UgW0dQRURdIHN0YXR1cyBbMDAwMDAwMDBdClsgICAxNC41MDU3NTNdIEFDUEk6
IERldmljZSBbUElORF0gc3RhdHVzIFswMDAwMDAwMF0KWyAgIDE0LjU1NzI0Nl0gaHBldDogbnVt
YmVyIGlycXMgZG9lc24ndCBhZ3JlZSB3aXRoIG51bWJlciBvZiB0aW1lcnMKWyAgIDE0LjU1NzM0
MV0gTGludXggYWdwZ2FydCBpbnRlcmZhY2UgdjAuMTAzClsgICAxNC41NjU5OTldIGxvb3A6IG1v
ZHVsZSBsb2FkZWQKWyAgIDE0LjU2NjY5OF0gdHVuOiBVbml2ZXJzYWwgVFVOL1RBUCBkZXZpY2Ug
ZHJpdmVyLCAxLjYKWyAgIDE0LjU2Njg3N10gUFBQIGdlbmVyaWMgZHJpdmVyIHZlcnNpb24gMi40
LjIKWyAgIDE0LjU2NzIzMl0gVkZJTyAtIFVzZXIgTGV2ZWwgbWV0YS1kcml2ZXIgdmVyc2lvbjog
MC4zClsgICAxNC41Njc0NzFdIHhoY2lfaGNkIDAwMDA6MDA6MTQuMDogdmdhYXJiOiBwY2lfbm90
aWZ5ClsgICAxNC41Njc0ODVdIHhoY2lfaGNkIDAwMDA6MDA6MTQuMDogcnVudGltZSBJUlEgbWFw
cGluZyBub3QgcHJvdmlkZWQgYnkgYXJjaApbICAgMTQuNTg1MDUzXSB4aGNpX2hjZCAwMDAwOjAw
OjE0LjA6IGVuYWJsaW5nIGJ1cyBtYXN0ZXJpbmcKWyAgIDE0LjU4NTA2OV0geGhjaV9oY2QgMDAw
MDowMDoxNC4wOiB4SENJIEhvc3QgQ29udHJvbGxlcgpbICAgMTQuNTg1MTE2XSB4aGNpX2hjZCAw
MDAwOjAwOjE0LjA6IG5ldyBVU0IgYnVzIHJlZ2lzdGVyZWQsIGFzc2lnbmVkIGJ1cyBudW1iZXIg
MQpbICAgMTQuNTg2MTk3XSB4aGNpX2hjZCAwMDAwOjAwOjE0LjA6IGhjYyBwYXJhbXMgMHgyMDAw
NzdjMSBoY2kgdmVyc2lvbiAweDEwMCBxdWlya3MgMHgwMDAwMDAwMDAwMDA5ODEwClsgICAxNC41
ODYyMTBdIHhoY2lfaGNkIDAwMDA6MDA6MTQuMDogY2FjaGUgbGluZSBzaXplIG9mIDY0IGlzIG5v
dCBzdXBwb3J0ZWQKWyAgIDE0LjU4NjUyMF0geGhjaV9oY2QgMDAwMDowMDoxNC4wOiB4SENJIEhv
c3QgQ29udHJvbGxlcgpbICAgMTQuNTg2NTMxXSB4aGNpX2hjZCAwMDAwOjAwOjE0LjA6IG5ldyBV
U0IgYnVzIHJlZ2lzdGVyZWQsIGFzc2lnbmVkIGJ1cyBudW1iZXIgMgpbICAgMTQuNTg2NTQwXSB4
aGNpX2hjZCAwMDAwOjAwOjE0LjA6IEhvc3Qgc3VwcG9ydHMgVVNCIDMuMCBTdXBlclNwZWVkClsg
ICAxNC41ODkyMDNdIHVzYiB1c2IxOiBOZXcgVVNCIGRldmljZSBmb3VuZCwgaWRWZW5kb3I9MWQ2
YiwgaWRQcm9kdWN0PTAwMDIsIGJjZERldmljZT0gNi4xNApbICAgMTQuNTg5MjEyXSB1c2IgdXNi
MTogTmV3IFVTQiBkZXZpY2Ugc3RyaW5nczogTWZyPTMsIFByb2R1Y3Q9MiwgU2VyaWFsTnVtYmVy
PTEKWyAgIDE0LjU4OTIxOF0gdXNiIHVzYjE6IFByb2R1Y3Q6IHhIQ0kgSG9zdCBDb250cm9sbGVy
ClsgICAxNC41ODkyMjJdIHVzYiB1c2IxOiBNYW51ZmFjdHVyZXI6IExpbnV4IDYuMTQuMC1yYzUr
IHhoY2ktaGNkClsgICAxNC41ODkyMjddIHVzYiB1c2IxOiBTZXJpYWxOdW1iZXI6IDAwMDA6MDA6
MTQuMApbICAgMTQuNjEzMjg4XSBodWIgMS0wOjEuMDogVVNCIGh1YiBmb3VuZApbICAgMTQuNjEz
MzI0XSBodWIgMS0wOjEuMDogNiBwb3J0cyBkZXRlY3RlZApbICAgMTQuNjY3NzY1XSB1c2IgdXNi
MjogTmV3IFVTQiBkZXZpY2UgZm91bmQsIGlkVmVuZG9yPTFkNmIsIGlkUHJvZHVjdD0wMDAzLCBi
Y2REZXZpY2U9IDYuMTQKWyAgIDE0LjY2Nzc3OV0gdXNiIHVzYjI6IE5ldyBVU0IgZGV2aWNlIHN0
cmluZ3M6IE1mcj0zLCBQcm9kdWN0PTIsIFNlcmlhbE51bWJlcj0xClsgICAxNC42Njc3ODVdIHVz
YiB1c2IyOiBQcm9kdWN0OiB4SENJIEhvc3QgQ29udHJvbGxlcgpbICAgMTQuNjY3NzkwXSB1c2Ig
dXNiMjogTWFudWZhY3R1cmVyOiBMaW51eCA2LjE0LjAtcmM1KyB4aGNpLWhjZApbICAgMTQuNjY3
Nzk0XSB1c2IgdXNiMjogU2VyaWFsTnVtYmVyOiAwMDAwOjAwOjE0LjAKWyAgIDE0LjY2ODgwN10g
aHViIDItMDoxLjA6IFVTQiBodWIgZm91bmQKWyAgIDE0LjY2ODgzOV0gaHViIDItMDoxLjA6IDEg
cG9ydCBkZXRlY3RlZApbICAgMTQuNzIxNzU5XSB4aGNpX2hjZCAwMDAwOjAwOjE0LjA6IHZnYWFy
YjogcGNpX25vdGlmeQpbICAgMTQuNzIxODg5XSBpODA0MjogUE5QOiBObyBQUy8yIGNvbnRyb2xs
ZXIgZm91bmQuClsgICAxNC43MjI2MzRdIG1vdXNlZGV2OiBQUy8yIG1vdXNlIGRldmljZSBjb21t
b24gZm9yIGFsbCBtaWNlClsgICAxNC43MjM4NzddIHJ0Y19jbW9zIDAwOjAwOiBSVEMgY2FuIHdh
a2UgZnJvbSBTNApbICAgMTQuNzI0MzU2XSBydGNfY21vcyAwMDowMDogcmVnaXN0ZXJlZCBhcyBy
dGMwClsgICAxNC43MjQzOTJdIHJ0Y19jbW9zIDAwOjAwOiBzZXR0aW5nIHN5c3RlbSBjbG9jayB0
byAyMDI1LTAzLTA2VDE2OjIzOjU3IFVUQyAoMTc0MTI3ODIzNykKWyAgIDE0LjcyNDQ4NF0gcnRj
X2Ntb3MgMDA6MDA6IGFsYXJtcyB1cCB0byBvbmUgbW9udGgsIHkzaywgMjQyIGJ5dGVzIG52cmFt
ClsgICAxNC43MjQ1MTZdIGkyY19kZXY6IGkyYyAvZGV2IGVudHJpZXMgZHJpdmVyClsgICAxNC43
MjQ1NjVdIGRldmljZS1tYXBwZXI6IGNvcmU6IENPTkZJR19JTUFfRElTQUJMRV9IVEFCTEUgaXMg
ZGlzYWJsZWQuIER1cGxpY2F0ZSBJTUEgbWVhc3VyZW1lbnRzIHdpbGwgbm90IGJlIHJlY29yZGVk
IGluIHRoZSBJTUEgbG9nLgpbICAgMTQuNzI0NTk1XSBkZXZpY2UtbWFwcGVyOiB1ZXZlbnQ6IHZl
cnNpb24gMS4wLjMKWyAgIDE0LjcyNDczMl0gZGV2aWNlLW1hcHBlcjogaW9jdGw6IDQuNDkuMC1p
b2N0bCAoMjAyNS0wMS0xNykgaW5pdGlhbGlzZWQ6IGRtLWRldmVsQGxpc3RzLmxpbnV4LmRldgpb
ICAgMTQuNzI0Nzg5XSBwbGF0Zm9ybSBlaXNhLjA6IFByb2JpbmcgRUlTQSBidXMgMApbICAgMTQu
NzI0Nzk3XSBwbGF0Zm9ybSBlaXNhLjA6IEVJU0E6IENhbm5vdCBhbGxvY2F0ZSByZXNvdXJjZSBm
b3IgbWFpbmJvYXJkClsgICAxNC43MjQ4MDNdIHBsYXRmb3JtIGVpc2EuMDogQ2Fubm90IGFsbG9j
YXRlIHJlc291cmNlIGZvciBFSVNBIHNsb3QgMQpbICAgMTQuNzI0ODA4XSBwbGF0Zm9ybSBlaXNh
LjA6IENhbm5vdCBhbGxvY2F0ZSByZXNvdXJjZSBmb3IgRUlTQSBzbG90IDIKWyAgIDE0LjcyNDgx
Ml0gcGxhdGZvcm0gZWlzYS4wOiBDYW5ub3QgYWxsb2NhdGUgcmVzb3VyY2UgZm9yIEVJU0Egc2xv
dCAzClsgICAxNC43MjQ4MTddIHBsYXRmb3JtIGVpc2EuMDogQ2Fubm90IGFsbG9jYXRlIHJlc291
cmNlIGZvciBFSVNBIHNsb3QgNApbICAgMTQuNzI0ODIxXSBwbGF0Zm9ybSBlaXNhLjA6IENhbm5v
dCBhbGxvY2F0ZSByZXNvdXJjZSBmb3IgRUlTQSBzbG90IDUKWyAgIDE0LjcyNDgyNl0gcGxhdGZv
cm0gZWlzYS4wOiBDYW5ub3QgYWxsb2NhdGUgcmVzb3VyY2UgZm9yIEVJU0Egc2xvdCA2ClsgICAx
NC43MjQ4MzBdIHBsYXRmb3JtIGVpc2EuMDogQ2Fubm90IGFsbG9jYXRlIHJlc291cmNlIGZvciBF
SVNBIHNsb3QgNwpbICAgMTQuNzI0ODM1XSBwbGF0Zm9ybSBlaXNhLjA6IENhbm5vdCBhbGxvY2F0
ZSByZXNvdXJjZSBmb3IgRUlTQSBzbG90IDgKWyAgIDE0LjcyNDgzOV0gcGxhdGZvcm0gZWlzYS4w
OiBFSVNBOiBEZXRlY3RlZCAwIGNhcmRzClsgICAxNC43MjQ4NTBdIGludGVsX3BzdGF0ZTogSW50
ZWwgUC1zdGF0ZSBkcml2ZXIgaW5pdGlhbGl6aW5nClsgICAxNC43MjU4NTldIGVmaWZiOiBwcm9i
aW5nIGZvciBlZmlmYgpbICAgMTQuNzI1ODgyXSBlZmlmYjogTm8gQkdSVCwgbm90IHNob3dpbmcg
Ym9vdCBncmFwaGljcwpbICAgMTQuNzI1ODg2XSBlZmlmYjogZnJhbWVidWZmZXIgYXQgMHhhMDAw
MCwgdXNpbmcgNjRrLCB0b3RhbCA2NGsKWyAgIDE0LjcyNTg5MF0gZWZpZmI6IG1vZGUgaXMgNjQw
eDQ4MHgxLCBsaW5lbGVuZ3RoPTgwLCBwYWdlcz0xClsgICAxNC43MjU4OTVdIGVmaWZiOiBzY3Jv
bGxpbmc6IHJlZHJhdwpbICAgMTQuNzI1ODk3XSBlZmlmYjogVHJ1ZWNvbG9yOiBzaXplPTg6ODo4
OjgsIHNoaWZ0PTI0OjE2Ojg6MApbICAgMTQuNzI2MjU2XSBmYmNvbjogRGVmZXJyaW5nIGNvbnNv
bGUgdGFrZS1vdmVyClsgICAxNC43MjYyNjJdIGZiMDogRUZJIFZHQSBmcmFtZSBidWZmZXIgZGV2
aWNlClsgICAxNC43MjY1MjVdIGRyb3BfbW9uaXRvcjogSW5pdGlhbGl6aW5nIG5ldHdvcmsgZHJv
cCBtb25pdG9yIHNlcnZpY2UKWyAgIDE0LjcyNjc0NV0gTkVUOiBSZWdpc3RlcmVkIFBGX0lORVQ2
IHByb3RvY29sIGZhbWlseQpbICAgMTQuNzUyMTcwXSBTZWdtZW50IFJvdXRpbmcgd2l0aCBJUHY2
ClsgICAxNC43NTIyMTJdIEluLXNpdHUgT0FNIChJT0FNKSB3aXRoIElQdjYKWyAgIDE0Ljc1MjI3
NV0gTkVUOiBSZWdpc3RlcmVkIFBGX1BBQ0tFVCBwcm90b2NvbCBmYW1pbHkKWyAgIDE0Ljc1MzEy
NV0gS2V5IHR5cGUgZG5zX3Jlc29sdmVyIHJlZ2lzdGVyZWQKWyAgIDE0Ljc1Nzc0MF0gRU5FUkdZ
X1BFUkZfQklBUzogU2V0IHRvICdub3JtYWwnLCB3YXMgJ3BlcmZvcm1hbmNlJwpbICAgMTQuNzU4
MjE2XSBtaWNyb2NvZGU6IEN1cnJlbnQgcmV2aXNpb246IDB4MDAwMDA5MGQKWyAgIDE0Ljc1OTIz
NV0gSVBJIHNob3J0aGFuZCBicm9hZGNhc3Q6IGVuYWJsZWQKWyAgIDE0Ljc2NDQzMl0gc2NoZWRf
Y2xvY2s6IE1hcmtpbmcgc3RhYmxlICgxNDc2MDAwNzMyMywgMTA3MzAwNCktPigxNDgyOTY2ODEz
MywgLTY4NTg3ODA2KQpbICAgMTQuNzY1Mjg0XSByZWdpc3RlcmVkIHRhc2tzdGF0cyB2ZXJzaW9u
IDEKWyAgIDE0Ljc2NjIyMV0gTG9hZGluZyBjb21waWxlZC1pbiBYLjUwOSBjZXJ0aWZpY2F0ZXMK
WyAgIDE0Ljc2ODg0OF0gTG9hZGVkIFguNTA5IGNlcnQgJ0J1aWxkIHRpbWUgYXV0b2dlbmVyYXRl
ZCBrZXJuZWwga2V5OiA0OTZlNDA5ZGFhY2E1YmU1ODVjMjYwYTFlNDA2MzViMGJkNjcwYjEzJwpb
ICAgMTQuNzc0NjE3XSBEZW1vdGlvbiB0YXJnZXRzIGZvciBOb2RlIDA6IG51bGwKWyAgIDE0Ljc3
NTkzMF0gS2V5IHR5cGUgLmZzY3J5cHQgcmVnaXN0ZXJlZApbICAgMTQuNzc1OTM2XSBLZXkgdHlw
ZSBmc2NyeXB0LXByb3Zpc2lvbmluZyByZWdpc3RlcmVkClsgICAxNC43OTc4MjJdIGNyeXB0ZDog
bWF4X2NwdV9xbGVuIHNldCB0byAxMDAwClsgICAxNC45MTM1NjRdIHVzYiAxLTM6IG5ldyBoaWdo
LXNwZWVkIFVTQiBkZXZpY2UgbnVtYmVyIDIgdXNpbmcgeGhjaV9oY2QKWyAgIDE0Ljk1NDkzNl0g
QUNQSTogRGV2aWNlIFtCQVQxXSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgMTQuOTU0OTUxXSBBQ1BJ
OiBiYXR0ZXJ5OiBTbG90IFtCQVQxXSAoYmF0dGVyeSBhYnNlbnQpClsgICAxNC45NTUwNDJdIEFD
UEk6IERyaXZlciBbYmF0dGVyeV0gc3VjY2Vzc2Z1bGx5IGJvdW5kIHRvIGRldmljZSBbQkFUMV0K
WyAgIDE0Ljk1NTA0OF0gQUNQSTogRm91bmQgZHJpdmVyIFtiYXR0ZXJ5XSBmb3IgZGV2aWNlIFtC
QVQxXQpbICAgMTUuMDIwNzE1XSBLZXkgdHlwZSBlbmNyeXB0ZWQgcmVnaXN0ZXJlZApbICAgMTUu
MDIwNzMyXSBBcHBBcm1vcjogQXBwQXJtb3Igc2hhMjU2IHBvbGljeSBoYXNoaW5nIGVuYWJsZWQK
WyAgIDE1LjAyMDc2MV0gaW1hOiBObyBUUE0gY2hpcCBmb3VuZCwgYWN0aXZhdGluZyBUUE0tYnlw
YXNzIQpbICAgMTUuMDIwNzc0XSBMb2FkaW5nIGNvbXBpbGVkLWluIG1vZHVsZSBYLjUwOSBjZXJ0
aWZpY2F0ZXMKWyAgIDE1LjAyMjYzN10gTG9hZGVkIFguNTA5IGNlcnQgJ0J1aWxkIHRpbWUgYXV0
b2dlbmVyYXRlZCBrZXJuZWwga2V5OiA0OTZlNDA5ZGFhY2E1YmU1ODVjMjYwYTFlNDA2MzViMGJk
NjcwYjEzJwpbICAgMTUuMDIyNjQ2XSBpbWE6IEFsbG9jYXRlZCBoYXNoIGFsZ29yaXRobTogc2hh
MQpbICAgMTUuMDIyNjYzXSBpbWE6IE5vIGFyY2hpdGVjdHVyZSBwb2xpY2llcyBmb3VuZApbICAg
MTUuMDIyNzA3XSBldm06IEluaXRpYWxpc2luZyBFVk0gZXh0ZW5kZWQgYXR0cmlidXRlczoKWyAg
IDE1LjAyMjcxMl0gZXZtOiBzZWN1cml0eS5zZWxpbnV4ClsgICAxNS4wMjI3MTVdIGV2bTogc2Vj
dXJpdHkuU01BQ0s2NApbICAgMTUuMDIyNzE4XSBldm06IHNlY3VyaXR5LlNNQUNLNjRFWEVDClsg
ICAxNS4wMjI3MjFdIGV2bTogc2VjdXJpdHkuU01BQ0s2NFRSQU5TTVVURQpbICAgMTUuMDIyNzIz
XSBldm06IHNlY3VyaXR5LlNNQUNLNjRNTUFQClsgICAxNS4wMjI3MjZdIGV2bTogc2VjdXJpdHku
YXBwYXJtb3IKWyAgIDE1LjAyMjcyOV0gZXZtOiBzZWN1cml0eS5pbWEKWyAgIDE1LjAyMjczMV0g
ZXZtOiBzZWN1cml0eS5jYXBhYmlsaXR5ClsgICAxNS4wMjI3MzRdIGV2bTogSE1BQyBhdHRyczog
MHgxClsgICAxNS4wMjM1NjBdIFBNOiAgIE1hZ2ljIG51bWJlcjogMTo5NTA6Mzg3ClsgICAxNS4w
MjM2MDldIHRoZXJtYWwgY29vbGluZ19kZXZpY2UyOiBoYXNoIG1hdGNoZXMKWyAgIDE1LjAyNDc2
N10gUkFTOiBDb3JyZWN0YWJsZSBFcnJvcnMgY29sbGVjdG9yIGluaXRpYWxpemVkLgpbICAgMTUu
MDU1MjYxXSB1c2IgMS0zOiBOZXcgVVNCIGRldmljZSBmb3VuZCwgaWRWZW5kb3I9MDRkOCwgaWRQ
cm9kdWN0PTAwMGEsIGJjZERldmljZT0gMS4wMApbICAgMTUuMDU1Mjc1XSB1c2IgMS0zOiBOZXcg
VVNCIGRldmljZSBzdHJpbmdzOiBNZnI9MSwgUHJvZHVjdD0yLCBTZXJpYWxOdW1iZXI9MApbICAg
MTUuMDU1MjgxXSB1c2IgMS0zOiBQcm9kdWN0OiBTaW1wbGUgQ0RDIERldmljZSBEZW1vClsgICAx
NS4wNTUyODVdIHVzYiAxLTM6IE1hbnVmYWN0dXJlcjogTWljcm9jaGlwIFRlY2hub2xvZ3kgSW5j
LgpbICAgMTUuMDYyMDQ2XSBjbGs6IERpc2FibGluZyB1bnVzZWQgY2xvY2tzClsgICAxNS4wNjIw
ODFdIFBNOiBnZW5wZDogRGlzYWJsaW5nIHVudXNlZCBwb3dlciBkb21haW5zClsgICAxNS4wNzUy
MjNdIEZyZWVpbmcgdW51c2VkIGRlY3J5cHRlZCBtZW1vcnk6IDIwMjhLClsgICAxNS4wNzg0NDZd
IEZyZWVpbmcgdW51c2VkIGtlcm5lbCBpbWFnZSAoaW5pdG1lbSkgbWVtb3J5OiA0Nzg0SwpbICAg
MTUuMDc5MDM3XSBXcml0ZSBwcm90ZWN0aW5nIHRoZSBrZXJuZWwgcmVhZC1vbmx5IGRhdGE6IDMy
NzY4awpbICAgMTUuMDgwNTIyXSBGcmVlaW5nIHVudXNlZCBrZXJuZWwgaW1hZ2UgKHRleHQvcm9k
YXRhIGdhcCkgbWVtb3J5OiA1MjRLClsgICAxNS4wODE4NzVdIEZyZWVpbmcgdW51c2VkIGtlcm5l
bCBpbWFnZSAocm9kYXRhL2RhdGEgZ2FwKSBtZW1vcnk6IDg1NksKWyAgIDE1LjE2NzM2OF0geDg2
L21tOiBDaGVja2VkIFcrWCBtYXBwaW5nczogcGFzc2VkLCBubyBXK1ggcGFnZXMgZm91bmQuClsg
ICAxNS4xNjgwOTFdIHg4Ni9tbTogQ2hlY2tpbmcgdXNlciBzcGFjZSBwYWdlIHRhYmxlcwpbICAg
MTUuMjQ5NTY3XSB4ODYvbW06IENoZWNrZWQgVytYIG1hcHBpbmdzOiBwYXNzZWQsIG5vIFcrWCBw
YWdlcyBmb3VuZC4KWyAgIDE1LjI0OTU4Ml0gUnVuIC9pbml0IGFzIGluaXQgcHJvY2VzcwpbICAg
MTUuMjQ5NTg3XSAgIHdpdGggYXJndW1lbnRzOgpbICAgMTUuMjQ5NTkwXSAgICAgL2luaXQKWyAg
IDE1LjI0OTU5NF0gICB3aXRoIGVudmlyb25tZW50OgpbICAgMTUuMjQ5NTk3XSAgICAgSE9NRT0v
ClsgICAxNS4yNDk2MDBdICAgICBURVJNPWxpbnV4ClsgICAxNS4yNDk2MDNdICAgICBCT09UX0lN
QUdFPS92bWxpbnV6LTYuMTQuMC1yYzUrClsgICAxNy41NTQ3OTldIHNkaGNpOiBTZWN1cmUgRGln
aXRhbCBIb3N0IENvbnRyb2xsZXIgSW50ZXJmYWNlIGRyaXZlcgpbICAgMTcuNTU0ODA5XSBzZGhj
aTogQ29weXJpZ2h0KGMpIFBpZXJyZSBPc3NtYW4KWyAgIDE3LjU1ODI2MF0gYWhjaSAwMDAwOjAw
OjEzLjA6IHZnYWFyYjogcGNpX25vdGlmeQpbICAgMTcuNTU4Mjc5XSBhaGNpIDAwMDA6MDA6MTMu
MDogcnVudGltZSBJUlEgbWFwcGluZyBub3QgcHJvdmlkZWQgYnkgYXJjaApbICAgMTcuNTU4Mjg4
XSBhaGNpIDAwMDA6MDA6MTMuMDogdmVyc2lvbiAzLjAKWyAgIDE3LjU2MjQyMl0gYWhjaSAwMDAw
OjAwOjEzLjA6IGNvbnRyb2xsZXIgY2FuJ3QgZG8gREVWU0xQLCB0dXJuaW5nIG9mZgpbICAgMTcu
NTcyMzM5XSBzZGhjaS1wY2kgMDAwMDowMDoxNy4wOiB2Z2FhcmI6IHBjaV9ub3RpZnkKWyAgIDE3
LjU3MjM2MF0gc2RoY2ktcGNpIDAwMDA6MDA6MTcuMDogcnVudGltZSBJUlEgbWFwcGluZyBub3Qg
cHJvdmlkZWQgYnkgYXJjaApbICAgMTcuNTcyMzY4XSBzZGhjaS1wY2kgMDAwMDowMDoxNy4wOiBT
REhDSSBjb250cm9sbGVyIGZvdW5kIFs4MDg2OjBmNTBdIChyZXYgMTEpClsgICAxNy41NzYwMDBd
IGFoY2kgMDAwMDowMDoxMy4wOiBBSENJIHZlcnMgMDAwMS4wMzAwLCAzMiBjb21tYW5kIHNsb3Rz
LCAzIEdicHMsIFNBVEEgbW9kZQpbICAgMTcuNTc2MDE4XSBhaGNpIDAwMDA6MDA6MTMuMDogMS8y
IHBvcnRzIGltcGxlbWVudGVkIChwb3J0IG1hc2sgMHgyKQpbICAgMTcuNTc2MDI1XSBhaGNpIDAw
MDA6MDA6MTMuMDogZmxhZ3M6IDY0Yml0IG5jcSBwbSBsZWQgY2xvIHBpbyBzbHVtIHBhcnQgZGVz
byAKWyAgIDE3LjU3NzI2N10gc2NzaSBob3N0MDogYWhjaQpbICAgMTcuNTc4NjI2XSBzY3NpIGhv
c3QxOiBhaGNpClsgICAxNy41Nzg3OTNdIGF0YTE6IERVTU1ZClsgICAxNy41Nzg4MDBdIGF0YTI6
IFNBVEEgbWF4IFVETUEvMTMzIGFiYXIgbTIwNDhAMHhiMGIxNzAwMCBwb3J0IDB4YjBiMTcxODAg
aXJxIDkxIGxwbS1wb2wgMwpbICAgMTcuNTc4ODk1XSBhaGNpIDAwMDA6MDA6MTMuMDogdmdhYXJi
OiBwY2lfbm90aWZ5ClsgICAxNy41OTAwNDFdIG1tYzA6IFNESENJIGNvbnRyb2xsZXIgb24gUENJ
IFswMDAwOjAwOjE3LjBdIHVzaW5nIEFETUEKWyAgIDE3LjU5MDEwOF0gc2RoY2ktcGNpIDAwMDA6
MDA6MTcuMDogdmdhYXJiOiBwY2lfbm90aWZ5ClsgICAxNy42NDE0MTNdIEFDUEk6IGJ1cyB0eXBl
IGRybV9jb25uZWN0b3IgcmVnaXN0ZXJlZApbICAgMTcuNzkzMTI2XSBtbWMwOiBGYWlsZWQgdG8g
aW5pdGlhbGl6ZSBhIG5vbi1yZW1vdmFibGUgY2FyZApbICAgMTcuODU0MzIyXSBzZGhjaS1wY2kg
MDAwMDowMDoxNy4wOiBzYXZlIGNvbmZpZyAweDAwOiAweDBmNTA4MDg2ClsgICAxNy44NTQzMzhd
IHNkaGNpLXBjaSAwMDAwOjAwOjE3LjA6IHNhdmUgY29uZmlnIDB4MDQ6IDB4MDAxMDAwMDYKWyAg
IDE3Ljg1NDM0NV0gc2RoY2ktcGNpIDAwMDA6MDA6MTcuMDogc2F2ZSBjb25maWcgMHgwODogMHgw
ODA1MDExMQpbICAgMTcuODU0MzUzXSBzZGhjaS1wY2kgMDAwMDowMDoxNy4wOiBzYXZlIGNvbmZp
ZyAweDBjOiAweDAwMDAwMDEwClsgICAxNy44NTQzNTldIHNkaGNpLXBjaSAwMDAwOjAwOjE3LjA6
IHNhdmUgY29uZmlnIDB4MTA6IDB4YjBiMTYwMDAKWyAgIDE3Ljg1NDM2NV0gc2RoY2ktcGNpIDAw
MDA6MDA6MTcuMDogc2F2ZSBjb25maWcgMHgxNDogMHhiMGIxNTAwMApbICAgMTcuODU0MzcxXSBz
ZGhjaS1wY2kgMDAwMDowMDoxNy4wOiBzYXZlIGNvbmZpZyAweDE4OiAweDAwMDAwMDAwClsgICAx
Ny44NTQzNzddIHNkaGNpLXBjaSAwMDAwOjAwOjE3LjA6IHNhdmUgY29uZmlnIDB4MWM6IDB4MDAw
MDAwMDAKWyAgIDE3Ljg1NDM4Ml0gc2RoY2ktcGNpIDAwMDA6MDA6MTcuMDogc2F2ZSBjb25maWcg
MHgyMDogMHgwMDAwMDAwMApbICAgMTcuODU0Mzg4XSBzZGhjaS1wY2kgMDAwMDowMDoxNy4wOiBz
YXZlIGNvbmZpZyAweDI0OiAweDAwMDAwMDAwClsgICAxNy44NTQzOTRdIHNkaGNpLXBjaSAwMDAw
OjAwOjE3LjA6IHNhdmUgY29uZmlnIDB4Mjg6IDB4MDAwMDAwMDAKWyAgIDE3Ljg1NDQwMF0gc2Ro
Y2ktcGNpIDAwMDA6MDA6MTcuMDogc2F2ZSBjb25maWcgMHgyYzogMHgwMDAwMDAwMApbICAgMTcu
ODU0NDA2XSBzZGhjaS1wY2kgMDAwMDowMDoxNy4wOiBzYXZlIGNvbmZpZyAweDMwOiAweDAwMDAw
MDAwClsgICAxNy44NTQ0MTFdIHNkaGNpLXBjaSAwMDAwOjAwOjE3LjA6IHNhdmUgY29uZmlnIDB4
MzQ6IDB4MDAwMDAwODAKWyAgIDE3Ljg1NDQxN10gc2RoY2ktcGNpIDAwMDA6MDA6MTcuMDogc2F2
ZSBjb25maWcgMHgzODogMHgwMDAwMDAwMApbICAgMTcuODU0NDIzXSBzZGhjaS1wY2kgMDAwMDow
MDoxNy4wOiBzYXZlIGNvbmZpZyAweDNjOiAweDAwMDAwMTBhClsgICAxNy44NTQ0NDFdIHNkaGNp
LXBjaSAwMDAwOjAwOjE3LjA6IFBNRSMgZW5hYmxlZApbICAgMTcuODkyNDcyXSBhdGEyOiBTQVRB
IGxpbmsgdXAgMy4wIEdicHMgKFNTdGF0dXMgMTIzIFNDb250cm9sIDMwMCkKWyAgIDE3Ljg5MzU5
OF0gYXRhMi4wMDogQVRBLTEwOiBUUzEyOEdNVFM4MzBTLCAyMloyVjNQRCwgbWF4IFVETUEvMTMz
ClsgICAxNy44OTM5MzddIGF0YTIuMDA6IDI1MDA2OTY4MCBzZWN0b3JzLCBtdWx0aSAxNjogTEJB
NDggTkNRIChkZXB0aCAzMiksIEFBClsgICAxNy44OTU0MTRdIGF0YTIuMDA6IEZlYXR1cmVzOiBE
ZXYtU2xlZXAKWyAgIDE3Ljg5NzA2Nl0gYXRhMi4wMDogY29uZmlndXJlZCBmb3IgVURNQS8xMzMK
WyAgIDE3LjkwODE3OV0gc2NzaSAxOjA6MDowOiBEaXJlY3QtQWNjZXNzICAgICBBVEEgICAgICBU
UzEyOEdNVFM4MzBTICAgIFYzUEQgUFE6IDAgQU5TSTogNQpbICAgMTcuOTA5MTk3XSBzZCAxOjA6
MDowOiBbc2RhXSAyNTAwNjk2ODAgNTEyLWJ5dGUgbG9naWNhbCBibG9ja3M6ICgxMjggR0IvMTE5
IEdpQikKWyAgIDE3LjkwOTI1OV0gc2QgMTowOjA6MDogQXR0YWNoZWQgc2NzaSBnZW5lcmljIHNn
MCB0eXBlIDAKWyAgIDE3LjkwOTMwOF0gc2QgMTowOjA6MDogW3NkYV0gV3JpdGUgUHJvdGVjdCBp
cyBvZmYKWyAgIDE3LjkwOTMxNl0gc2QgMTowOjA6MDogW3NkYV0gTW9kZSBTZW5zZTogMDAgM2Eg
MDAgMDAKWyAgIDE3LjkwOTM3Ml0gc2QgMTowOjA6MDogW3NkYV0gV3JpdGUgY2FjaGU6IGVuYWJs
ZWQsIHJlYWQgY2FjaGU6IGVuYWJsZWQsIGRvZXNuJ3Qgc3VwcG9ydCBEUE8gb3IgRlVBClsgICAx
Ny45MDk1MTVdIHNkIDE6MDowOjA6IFtzZGFdIFByZWZlcnJlZCBtaW5pbXVtIEkvTyBzaXplIDUx
MiBieXRlcwpbICAgMTcuOTMzNTU2XSAgc2RhOiBzZGExIHNkYTIgc2RhMwpbICAgMTcuOTM0Mjkx
XSBzZCAxOjA6MDowOiBbc2RhXSBBdHRhY2hlZCBTQ1NJIGRpc2sKWyAgIDE3Ljk0MjEwNl0gZGNh
IHNlcnZpY2Ugc3RhcnRlZCwgdmVyc2lvbiAxLjEyLjEKWyAgIDE3Ljk2NjYzMl0gaWdiOiBJbnRl
bChSKSBHaWdhYml0IEV0aGVybmV0IE5ldHdvcmsgRHJpdmVyClsgICAxNy45NjY2NDNdIGlnYjog
Q29weXJpZ2h0IChjKSAyMDA3LTIwMTQgSW50ZWwgQ29ycG9yYXRpb24uClsgICAxNy45NjY2OTJd
IGlnYiAwMDAwOjAzOjAwLjA6IHZnYWFyYjogcGNpX25vdGlmeQpbICAgMTcuOTY2NzA2XSBpZ2Ig
MDAwMDowMzowMC4wOiBydW50aW1lIElSUSBtYXBwaW5nIG5vdCBwcm92aWRlZCBieSBhcmNoClsg
ICAxNy45OTA1ODhdIGlnYiAwMDAwOjAzOjAwLjA6IHNhdmUgY29uZmlnIDB4MDA6IDB4MTUzMzgw
ODYKWyAgIDE3Ljk5MDYwNF0gaWdiIDAwMDA6MDM6MDAuMDogc2F2ZSBjb25maWcgMHgwNDogMHgw
MDEwMDAwNwpbICAgMTcuOTkwNjExXSBpZ2IgMDAwMDowMzowMC4wOiBzYXZlIGNvbmZpZyAweDA4
OiAweDAyMDAwMDAzClsgICAxNy45OTA2MThdIGlnYiAwMDAwOjAzOjAwLjA6IHNhdmUgY29uZmln
IDB4MGM6IDB4MDAwMDAwMTAKWyAgIDE3Ljk5MDYyNV0gaWdiIDAwMDA6MDM6MDAuMDogc2F2ZSBj
b25maWcgMHgxMDogMHhiMGEwMDAwMApbICAgMTcuOTkwNjMyXSBpZ2IgMDAwMDowMzowMC4wOiBz
YXZlIGNvbmZpZyAweDE0OiAweDAwMDAwMDAwClsgICAxNy45OTA2MzhdIGlnYiAwMDAwOjAzOjAw
LjA6IHNhdmUgY29uZmlnIDB4MTg6IDB4MDAwMGQwMDEKWyAgIDE3Ljk5MDY0NV0gaWdiIDAwMDA6
MDM6MDAuMDogc2F2ZSBjb25maWcgMHgxYzogMHhiMGE4MDAwMApbICAgMTcuOTkwNjUxXSBpZ2Ig
MDAwMDowMzowMC4wOiBzYXZlIGNvbmZpZyAweDIwOiAweDAwMDAwMDAwClsgICAxNy45OTA2NThd
IGlnYiAwMDAwOjAzOjAwLjA6IHNhdmUgY29uZmlnIDB4MjQ6IDB4MDAwMDAwMDAKWyAgIDE3Ljk5
MDY2NF0gaWdiIDAwMDA6MDM6MDAuMDogc2F2ZSBjb25maWcgMHgyODogMHgwMDAwMDAwMApbICAg
MTcuOTkwNjcwXSBpZ2IgMDAwMDowMzowMC4wOiBzYXZlIGNvbmZpZyAweDJjOiAweDAwMDBmZmZm
ClsgICAxNy45OTA2NzddIGlnYiAwMDAwOjAzOjAwLjA6IHNhdmUgY29uZmlnIDB4MzA6IDB4MDAw
MDAwMDAKWyAgIDE3Ljk5MDY4M10gaWdiIDAwMDA6MDM6MDAuMDogc2F2ZSBjb25maWcgMHgzNDog
MHgwMDAwMDA0MApbICAgMTcuOTkwNjkwXSBpZ2IgMDAwMDowMzowMC4wOiBzYXZlIGNvbmZpZyAw
eDM4OiAweDAwMDAwMDAwClsgICAxNy45OTA2OTZdIGlnYiAwMDAwOjAzOjAwLjA6IHNhdmUgY29u
ZmlnIDB4M2M6IDB4MDAwMDAxMGEKWyAgIDE4LjAyNTI5MF0gaWdiIDAwMDA6MDM6MDAuMDogYWRk
ZWQgUEhDIG9uIGV0aDAKWyAgIDE4LjAyNTMyMF0gaWdiIDAwMDA6MDM6MDAuMDogSW50ZWwoUikg
R2lnYWJpdCBFdGhlcm5ldCBOZXR3b3JrIENvbm5lY3Rpb24KWyAgIDE4LjAyNTMyNV0gaWdiIDAw
MDA6MDM6MDAuMDogZXRoMDogKFBDSWU6Mi41R2IvczpXaWR0aCB4MSkgMDA6MzA6NjQ6YTI6NTk6
YWEKWyAgIDE4LjAyNTM3NV0gaWdiIDAwMDA6MDM6MDAuMDogZXRoMDogUEJBIE5vOiAwMDAzMDAt
MDAwClsgICAxOC4wMjUzNzldIGlnYiAwMDAwOjAzOjAwLjA6IFVzaW5nIE1TSS1YIGludGVycnVw
dHMuIDQgcnggcXVldWUocyksIDQgdHggcXVldWUocykKWyAgIDE4LjAyNTQzM10gaWdiIDAwMDA6
MDM6MDAuMDogdmdhYXJiOiBwY2lfbm90aWZ5ClsgICAxOC4wMjk0NjddIGlnYiAwMDAwOjAzOjAw
LjAgZW5wM3MwOiByZW5hbWVkIGZyb20gZXRoMApbICAgMTkuNjMyODMxXSBpOTE1IDAwMDA6MDA6
MDIuMDogdmdhYXJiOiBwY2lfbm90aWZ5ClsgICAxOS42MzI4NTFdIGk5MTUgMDAwMDowMDowMi4w
OiBydW50aW1lIElSUSBtYXBwaW5nIG5vdCBwcm92aWRlZCBieSBhcmNoClsgICAxOS42NDYwMjhd
IGk5MTUgMDAwMDowMDowMi4wOiBbZHJtXSBGb3VuZCB2YWxsZXl2aWV3IChkZXZpY2UgSUQgMGYz
MSkgaW50ZWdyYXRlZCBkaXNwbGF5IHZlcnNpb24gNy4wMCBzdGVwcGluZyBOL0EKWyAgIDE5LjY0
Nzc3OF0gaTkxNSAwMDAwOjAwOjAyLjA6IHZnYWFyYjogZGVhY3RpdmF0ZSB2Z2EgY29uc29sZQpb
ICAgMjAuNzk1Nzk0XSBBQ1BJOiBcX1NCXy5QQ0kwLkdGWDA6IEFDUEk6IEVycm9yIGF0dGFjaGlu
ZyBkZXZpY2UgZGF0YQpbICAgMjAuODIyOTY3XSBBQ1BJOiBcX1NCXy5QQ0kwLkdGWDA6IEFDUEk6
IEVycm9yIGF0dGFjaGluZyBkZXZpY2UgZGF0YQpbICAgMjAuODQ5NzE5XSBBQ1BJOiBcX1NCXy5Q
Q0kwLkdGWDA6IEFDUEk6IEVycm9yIGF0dGFjaGluZyBkZXZpY2UgZGF0YQpbICAgMjAuODc2MzI1
XSBBQ1BJOiBcX1NCXy5QQ0kwLkdGWDA6IEFDUEk6IEVycm9yIGF0dGFjaGluZyBkZXZpY2UgZGF0
YQpbICAgMjAuOTAzMzA2XSBBQ1BJOiBcX1NCXy5QQ0kwLkdGWDA6IEFDUEk6IEVycm9yIGF0dGFj
aGluZyBkZXZpY2UgZGF0YQpbICAgMjAuOTAzNjcwXSBpOTE1IDAwMDA6MDA6MDIuMDogdmdhYXJi
OiBWR0EgZGVjb2RlcyBjaGFuZ2VkOiBvbGRkZWNvZGVzPWlvK21lbSxkZWNvZGVzPWlvK21lbTpv
d25zPWlvK21lbQpbICAgMjAuOTAzNjc5XSBpOTE1IDAwMDA6MDA6MDIuMDogdmdhYXJiOiBkZWNv
ZGluZyBjb3VudCBub3cgaXM6IDEKWyAgIDIwLjkwMzY4NV0gaTkxNSAwMDAwOjAwOjAyLjA6IHZn
YWFyYjogX192Z2FfdHJ5Z2V0OiAxClsgICAyMC45MDM2ODldIGk5MTUgMDAwMDowMDowMi4wOiB2
Z2FhcmI6IF9fdmdhX3RyeWdldDogb3duczogMwpbICAgMjAuOTAzNjk2XSBpOTE1IDAwMDA6MDA6
MDIuMDogdmdhYXJiOiBfX3ZnYV9wdXQKWyAgIDIwLjkwOTk3OV0gbHBjX2ljaCAwMDAwOjAwOjFm
LjA6IHZnYWFyYjogcGNpX25vdGlmeQpbICAgMjAuOTA5OTk3XSBscGNfaWNoIDAwMDA6MDA6MWYu
MDogcnVudGltZSBJUlEgbWFwcGluZyBub3QgcHJvdmlkZWQgYnkgYXJjaApbICAgMjAuOTI5OTcz
XSBscGNfaWNoIDAwMDA6MDA6MWYuMDogdmdhYXJiOiBwY2lfbm90aWZ5ClsgICAyMC45NDgxMjJd
IEVESUQgaGFzIGNvcnJ1cHQgaGVhZGVyClsgICAyMC45NDgxMzVdIAlbMDBdIEJBRCAgNjUgZTcg
ZGEgYzQgZmYgMzYgODUgOWEgNjMgMDUgNjEgODggZjcgZTEgMWMgZWUKWyAgIDIwLjk0ODE0MF0g
CVswMF0gQkFEICBhMyBiZCAyMSBlYiA2ZiAzYSA0YyBhYyAwZSA5OSAzOCBhOCAxNyAwOSBjMiA0
NQpbICAgMjAuOTQ4MTQ0XSAJWzAwXSBCQUQgIDg0IDA2IGZlIDVjIDFlIDliIGE0IDMzIDYxIDAz
IDc2IDE4IDVlIDhjIDNmIGY2ClsgICAyMC45NDgxNDddIAlbMDBdIEJBRCAgYzcgNWIgMGUgZTMg
OTIgYTIgZTYgYzQgNjYgMDYgY2UgNmEgZTggYWUgYWEgYjcKWyAgIDIwLjk0ODE1MF0gCVswMF0g
QkFEICA0ZCAwMyAzZCBjZSA5ZCA4ZiBkNSBjYSA4NiBiMyBjYSAxMyA5MiAwYiAxNCBiYQpbICAg
MjAuOTQ4MTU0XSAJWzAwXSBCQUQgIGU4IGFkIGI2IGJlIDJlIDhhIDhiIGZjIGY4IDc2IDE5IDRl
IDc5IDBhIDU4IDY0ClsgICAyMC45NDgxNTddIAlbMDBdIEJBRCAgYmEgOTkgMDMgODIgZTggMTkg
NGMgN2IgMzEgYmYgNzEgZDIgYTAgOWYgNzcgNGMKWyAgIDIwLjk0ODE2MF0gCVswMF0gQkFEICA3
NyAyZSBmOSBmOCAyNiAxYyBjYSA2OSAxZiAyZiBhZCBjYiA4MyAxYSA5OCBhMwpbICAgMjEuMDU4
Mzg1XSBpODAxX3NtYnVzIDAwMDA6MDA6MWYuMzogdmdhYXJiOiBwY2lfbm90aWZ5ClsgICAyMS4w
NTg0NTFdIGk4MDFfc21idXMgMDAwMDowMDoxZi4zOiBydW50aW1lIElSUSBtYXBwaW5nIG5vdCBw
cm92aWRlZCBieSBhcmNoClsgICAyMS4wNjMwMzRdIGk4MDFfc21idXMgMDAwMDowMDoxZi4zOiBT
UEQgV3JpdGUgRGlzYWJsZSBpcyBzZXQKWyAgIDIxLjA2MzEwMl0gaTgwMV9zbWJ1cyAwMDAwOjAw
OjFmLjM6IFNNQnVzIHVzaW5nIFBDSSBpbnRlcnJ1cHQKWyAgIDIxLjA2Mzg0MV0gaTgwMV9zbWJ1
cyAwMDAwOjAwOjFmLjM6IEJJT1MgaXMgYWNjZXNzaW5nIFNNQnVzIHJlZ2lzdGVycwpbICAgMjEu
MDYzODUxXSBpODAxX3NtYnVzIDAwMDA6MDA6MWYuMzogRHJpdmVyIFNNQnVzIHJlZ2lzdGVyIGFj
Y2VzcyBpbmhpYml0ZWQKWyAgIDIxLjExNDYxNV0gQUNQSTogRGV2aWNlIFtJU1AwXSBzdGF0dXMg
WzAwMDAwMDAwXQpbICAgMjEuMTE0NzU5XSBbZHJtXSBJbml0aWFsaXplZCBpOTE1IDEuNi4wIGZv
ciAwMDAwOjAwOjAyLjAgb24gbWlub3IgMApbICAgMjEuMTE1MzI1XSBBQ1BJOiBEZXZpY2UgW0hf
RUNdIHN0YXR1cyBbMDAwMDAwMDBdClsgICAyMS4xMTUzNjVdIEFDUEk6IERldmljZSBbQkFUMF0g
c3RhdHVzIFswMDAwMDAwMF0KWyAgIDIxLjExNTk2Nl0gQUNQSTogRGV2aWNlIFtCQVQxXSBzdGF0
dXMgWzAwMDAwMDAwXQpbICAgMjEuMTE2NDgxXSBBQ1BJOiBEZXZpY2UgW0JBVDJdIHN0YXR1cyBb
MDAwMDAwMDBdClsgICAyMS4xMTY4MTFdIEFDUEk6IERldmljZSBbV1BDTl0gc3RhdHVzIFswMDAw
MDAwMF0KWyAgIDIxLjExNzA2MF0gQUNQSTogRGV2aWNlIFtVQVI1XSBzdGF0dXMgWzAwMDAwMDAw
XQpbICAgMjEuMTE3Njk0XSBBQ1BJOiBEZXZpY2UgW1VBUjhdIHN0YXR1cyBbMDAwMDAwMDBdClsg
ICAyMS4xMjAwNjBdIEFDUEk6IERldmljZSBbTFBURV0gc3RhdHVzIFswMDAwMDAwMF0KWyAgIDIx
LjEyMzQ3Ml0gQUNQSTogRGV2aWNlIFtQUzJLXSBzdGF0dXMgWzAwMDAwMDAwXQpbICAgMjEuMTI4
MTgyXSBBQ1BJOiBEZXZpY2UgW1BTMk1dIHN0YXR1cyBbMDAwMDAwMDBdClsgICAyMS4xMjkwMjNd
IEFDUEk6IERldmljZSBbU1NQSV0gc3RhdHVzIFswMDAwMDAwMF0KWyAgIDIxLjEyOTI0OF0gQUNQ
STogRGV2aWNlIFtTR1BJXSBzdGF0dXMgWzAwMDAwMDAwXQpbICAgMjEuMTI5MzczXSBBQ1BJOiBE
ZXZpY2UgW1NIV01dIHN0YXR1cyBbMDAwMDAwMDBdClsgICAyMS4xMjk0MDldIEFDUEk6IERldmlj
ZSBbU0NQSV0gc3RhdHVzIFswMDAwMDAwMF0KWyAgIDIxLjEzMTMyOF0gQUNQSTogRGV2aWNlIFtV
QVIxXSBzdGF0dXMgWzAwMDAwMDAwXQpbICAgMjEuMTMzOTA1XSBBQ1BJOiBEZXZpY2UgW1VBUjJd
IHN0YXR1cyBbMDAwMDAwMDBdClsgICAyMS4xMzkxNTZdIEFDUEk6IHZpZGVvOiBWaWRlbyBEZXZp
Y2UgW0dGWDBdIChtdWx0aS1oZWFkOiB5ZXMgIHJvbTogbm8gIHBvc3Q6IG5vKQpbICAgMjEuMTQw
NTIyXSBpbnB1dDogVmlkZW8gQnVzIGFzIC9kZXZpY2VzL0xOWFNZU1RNOjAwL0xOWFNZQlVTOjAw
L1BOUDBBMDg6MDAvTE5YVklERU86MDAvaW5wdXQvaW5wdXQ0ClsgICAyMS4xNDE1NzNdIEFDUEk6
IERyaXZlciBbdmlkZW9dIHN1Y2Nlc3NmdWxseSBib3VuZCB0byBkZXZpY2UgW0dGWDBdClsgICAy
MS4xNDE1ODRdIEFDUEk6IEZvdW5kIGRyaXZlciBbdmlkZW9dIGZvciBkZXZpY2UgW0dGWDBdClsg
ICAyMS4xNjAwMThdIGZiY29uOiBpOTE1ZHJtZmIgKGZiMCkgaXMgcHJpbWFyeSBkZXZpY2UKWyAg
IDIxLjE2MDAyN10gZmJjb246IERlZmVycmluZyBjb25zb2xlIHRha2Utb3ZlcgpbICAgMjEuMTYw
MDM1XSBpOTE1IDAwMDA6MDA6MDIuMDogW2RybV0gZmIwOiBpOTE1ZHJtZmIgZnJhbWUgYnVmZmVy
IGRldmljZQpbICAgMjEuMTgxNjkzXSBpOTE1IDAwMDA6MDA6MDIuMDogdmdhYXJiOiBwY2lfbm90
aWZ5ClsgICAyMi43NzY1MDBdIEFDUEk6IERldmljZSBbQkFUMl0gc3RhdHVzIFswMDAwMDAwMF0K
WyAgIDIyLjc3Njg5M10gQUNQSTogRGV2aWNlIFtFSEMxXSBzdGF0dXMgWzAwMDAwMDAwXQpbICAg
MjIuNzc2OTA4XSBBQ1BJOiBEZXZpY2UgW0hVQk5dIHN0YXR1cyBbMDAwMDAwMGZdClsgICAyMi43
NzY5MjJdIEFDUEk6IERldmljZSBbUFIwMV0gc3RhdHVzIFswMDAwMDAwZl0KWyAgIDIyLjc3Njkz
M10gQUNQSTogRGV2aWNlIFtQUjExXSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgMjIuNzc2OTUxXSBB
Q1BJOiBEZXZpY2UgW1BSMTJdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAyMi43Nzc2NTldIEFDUEk6
IERldmljZSBbUFIxM10gc3RhdHVzIFswMDAwMDAwZl0KWyAgIDIyLjc3ODA2Nl0gQUNQSTogRGV2
aWNlIFtQUjE0XSBzdGF0dXMgWzAwMDAwMDBmXQpbICAgMjIuNzc4NDczXSBBQ1BJOiBEZXZpY2Ug
W1BSMTVdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAyMi43Nzg4ODFdIEFDUEk6IERldmljZSBbUFIx
Nl0gc3RhdHVzIFswMDAwMDAwZl0KWyAgIDIyLjc3OTI4M10gQUNQSTogRGV2aWNlIFtQUjE3XSBz
dGF0dXMgWzAwMDAwMDBmXQpbICAgMjIuNzc5Njg4XSBBQ1BJOiBEZXZpY2UgW1BSMThdIHN0YXR1
cyBbMDAwMDAwMGZdClsgICAyMi43ODg5NjVdIEFDUEk6IERldmljZSBbRU00MV0gc3RhdHVzIFsw
MDAwMDAwMF0KWyAgIDIyLjc4OTQ2N10gQUNQSTogRGV2aWNlIFtDQVJEXSBzdGF0dXMgWzAwMDAw
MDBmXQpbICAgMjIuNzkxNDU4XSBBQ1BJOiBEZXZpY2UgW09URzFdIHN0YXR1cyBbMDAwMDAwMDBd
ClsgICAyMi43OTUwNTNdIEFDUEk6IERldmljZSBbTFBFQV0gc3RhdHVzIFswMDAwMDAwMF0KWyAg
IDIyLjc5NjU4NV0gQUNQSTogRGV2aWNlIFtMUEEyXSBzdGF0dXMgWzAwMDAwMDAwXQpbICAgMjIu
Nzk2NzY0XSBBQ1BJOiBEZXZpY2UgW0FETUFdIHN0YXR1cyBbMDAwMDAwMGZdClsgICAyMi43OTg5
OTRdIEFDUEk6IERldmljZSBbR1BFRF0gc3RhdHVzIFswMDAwMDAwMF0KWyAgIDIyLjc5OTgxNF0g
QUNQSTogRGV2aWNlIFtQSU5EXSBzdGF0dXMgWzAwMDAwMDAwXQpbICAgMjIuODAwMzA5XSBpODAx
X3NtYnVzIDAwMDA6MDA6MWYuMzogdmdhYXJiOiBwY2lfbm90aWZ5ClsgICAyMy45ODU2OTVdIHJh
aWQ2OiBzc2UyeDQgICBnZW4oKSAgNDc3NCBNQi9zClsgICAyNC4wNTM2ODFdIHJhaWQ2OiBzc2Uy
eDIgICBnZW4oKSAgNDU2MiBNQi9zClsgICAyNC4xMjE2NjVdIHJhaWQ2OiBzc2UyeDEgICBnZW4o
KSAgMzQyMiBNQi9zClsgICAyNC4xMjE2NzJdIHJhaWQ2OiB1c2luZyBhbGdvcml0aG0gc3NlMng0
IGdlbigpIDQ3NzQgTUIvcwpbICAgMjQuMTg5Njc1XSByYWlkNjogLi4uLiB4b3IoKSAxMzkwIE1C
L3MsIHJtdyBlbmFibGVkClsgICAyNC4xODk2ODFdIHJhaWQ2OiB1c2luZyBzc3NlM3gyIHJlY292
ZXJ5IGFsZ29yaXRobQpbICAgMjQuMTkzNTk3XSB4b3I6IG1lYXN1cmluZyBzb2Z0d2FyZSBjaGVj
a3N1bSBzcGVlZApbICAgMjQuMTk0MDQxXSAgICBwcmVmZXRjaDY0LXNzZSAgOiAgNzU2MSBNQi9z
ZWMKWyAgIDI0LjE5NDUzMF0gICAgZ2VuZXJpY19zc2UgICAgIDogIDY3OTggTUIvc2VjClsgICAy
NC4xOTQ1MzRdIHhvcjogdXNpbmcgZnVuY3Rpb246IHByZWZldGNoNjQtc3NlICg3NTYxIE1CL3Nl
YykKWyAgIDI0LjE5ODkwM10gYXN5bmNfdHg6IGFwaSBpbml0aWFsaXplZCAoYXN5bmMpClsgICAy
NS4xOTU0NzJdIEJ0cmZzIGxvYWRlZCwgem9uZWQ9eWVzLCBmc3Zlcml0eT15ZXMKWyAgIDI1LjQx
OTU4MV0gZmJjb246IFRha2luZyBvdmVyIGNvbnNvbGUKWyAgIDI1LjQyOTk0OF0gRVhUNC1mcyAo
ZG0tMCk6IG1vdW50ZWQgZmlsZXN5c3RlbSA0OGE5ZGQ5MS1kMDBiLTQ3YmYtOGY3Yi05NzU4YmFm
NzlkODMgcm8gd2l0aCBvcmRlcmVkIGRhdGEgbW9kZS4gUXVvdGEgbW9kZTogbm9uZS4KWyAgIDI1
LjQzMDM3OV0gQ29uc29sZTogc3dpdGNoaW5nIHRvIGNvbG91ciBmcmFtZSBidWZmZXIgZGV2aWNl
IDEyOHg0OApbICAgMjUuOTg1NzAwXSBzeXN0ZW1kWzFdOiBJbnNlcnRlZCBtb2R1bGUgJ2F1dG9m
czQnClsgICAyNi4wNTEwNzZdIHN5c3RlbWRbMV06IHN5c3RlbWQgMjQ1LjQtNHVidW50dTMuMjIg
cnVubmluZyBpbiBzeXN0ZW0gbW9kZS4gKCtQQU0gK0FVRElUICtTRUxJTlVYICtJTUEgK0FQUEFS
TU9SICtTTUFDSyArU1lTVklOSVQgK1VUTVAgK0xJQkNSWVBUU0VUVVAgK0dDUllQVCArR05VVExT
ICtBQ0wgK1haICtMWjQgK1NFQ0NPTVAgK0JMS0lEICtFTEZVVElMUyArS01PRCArSUROMiAtSURO
ICtQQ1JFMiBkZWZhdWx0LWhpZXJhcmNoeT1oeWJyaWQpClsgICAyNi4wNTE0ODVdIHN5c3RlbWRb
MV06IERldGVjdGVkIGFyY2hpdGVjdHVyZSB4ODYtNjQuClsgICAyNi4wODk2NDNdIHN5c3RlbWRb
MV06IFNldCBob3N0bmFtZSB0byA8YnR0ZXN0Pi4KWyAgIDI2Ljc2NjE5Nl0gc3lzdGVtZFsxXTog
Q3JlYXRlZCBzbGljZSBzeXN0ZW0tbW9kcHJvYmUuc2xpY2UuClsgICAyNi43Njc0MjZdIHN5c3Rl
bWRbMV06IENyZWF0ZWQgc2xpY2Ugc3lzdGVtLXN5c3RlbWRceDJkZnNjay5zbGljZS4KWyAgIDI2
Ljc2ODM0NV0gc3lzdGVtZFsxXTogQ3JlYXRlZCBzbGljZSBVc2VyIGFuZCBTZXNzaW9uIFNsaWNl
LgpbICAgMjYuNzY4NDk0XSBzeXN0ZW1kWzFdOiBTdGFydGVkIG50cC1zeXN0ZW1kLW5ldGlmLnBh
dGguClsgICAyNi43Njg2OTRdIHN5c3RlbWRbMV06IFN0YXJ0ZWQgRm9yd2FyZCBQYXNzd29yZCBS
ZXF1ZXN0cyB0byBXYWxsIERpcmVjdG9yeSBXYXRjaC4KWyAgIDI2Ljc2OTQzOV0gc3lzdGVtZFsx
XTogU2V0IHVwIGF1dG9tb3VudCBBcmJpdHJhcnkgRXhlY3V0YWJsZSBGaWxlIEZvcm1hdHMgRmls
ZSBTeXN0ZW0gQXV0b21vdW50IFBvaW50LgpbICAgMjYuNzY5NjgwXSBzeXN0ZW1kWzFdOiBSZWFj
aGVkIHRhcmdldCBVc2VyIGFuZCBHcm91cCBOYW1lIExvb2t1cHMuClsgICAyNi43Njk3NDZdIHN5
c3RlbWRbMV06IFJlYWNoZWQgdGFyZ2V0IFNsaWNlcy4KWyAgIDI2Ljc2OTc5M10gc3lzdGVtZFsx
XTogUmVhY2hlZCB0YXJnZXQgTW91bnRpbmcgc25hcHMuClsgICAyNi43Njk4NjNdIHN5c3RlbWRb
MV06IFJlYWNoZWQgdGFyZ2V0IFN5c3RlbSBUaW1lIFNldC4KWyAgIDI2Ljc3MDEyNF0gc3lzdGVt
ZFsxXTogTGlzdGVuaW5nIG9uIERldmljZS1tYXBwZXIgZXZlbnQgZGFlbW9uIEZJRk9zLgpbICAg
MjYuNzcwNDc4XSBzeXN0ZW1kWzFdOiBMaXN0ZW5pbmcgb24gTFZNMiBwb2xsIGRhZW1vbiBzb2Nr
ZXQuClsgICAyNi43NzA2OTVdIHN5c3RlbWRbMV06IExpc3RlbmluZyBvbiBtdWx0aXBhdGhkIGNv
bnRyb2wgc29ja2V0LgpbICAgMjYuNzcxMDA4XSBzeXN0ZW1kWzFdOiBMaXN0ZW5pbmcgb24gU3lz
bG9nIFNvY2tldC4KWyAgIDI2Ljc3MTMyOV0gc3lzdGVtZFsxXTogTGlzdGVuaW5nIG9uIGZzY2sg
dG8gZnNja2QgY29tbXVuaWNhdGlvbiBTb2NrZXQuClsgICAyNi43NzE1MDNdIHN5c3RlbWRbMV06
IExpc3RlbmluZyBvbiBpbml0Y3RsIENvbXBhdGliaWxpdHkgTmFtZWQgUGlwZS4KWyAgIDI2Ljc3
MjE1MF0gc3lzdGVtZFsxXTogTGlzdGVuaW5nIG9uIEpvdXJuYWwgQXVkaXQgU29ja2V0LgpbICAg
MjYuNzcyNDg2XSBzeXN0ZW1kWzFdOiBMaXN0ZW5pbmcgb24gSm91cm5hbCBTb2NrZXQgKC9kZXYv
bG9nKS4KWyAgIDI2Ljc3MjkxMl0gc3lzdGVtZFsxXTogTGlzdGVuaW5nIG9uIEpvdXJuYWwgU29j
a2V0LgpbICAgMjYuNzczNDg0XSBzeXN0ZW1kWzFdOiBMaXN0ZW5pbmcgb24gTmV0d29yayBTZXJ2
aWNlIE5ldGxpbmsgU29ja2V0LgpbICAgMjYuNzczODU3XSBzeXN0ZW1kWzFdOiBMaXN0ZW5pbmcg
b24gdWRldiBDb250cm9sIFNvY2tldC4KWyAgIDI2Ljc3NDA5M10gc3lzdGVtZFsxXTogTGlzdGVu
aW5nIG9uIHVkZXYgS2VybmVsIFNvY2tldC4KWyAgIDI2LjgxNzk0MF0gc3lzdGVtZFsxXTogTW91
bnRpbmcgSHVnZSBQYWdlcyBGaWxlIFN5c3RlbS4uLgpbICAgMjYuODIxNzI1XSBzeXN0ZW1kWzFd
OiBNb3VudGluZyBQT1NJWCBNZXNzYWdlIFF1ZXVlIEZpbGUgU3lzdGVtLi4uClsgICAyNi44MjYx
MjVdIHN5c3RlbWRbMV06IE1vdW50aW5nIEtlcm5lbCBEZWJ1ZyBGaWxlIFN5c3RlbS4uLgpbICAg
MjYuODMwMjE1XSBzeXN0ZW1kWzFdOiBNb3VudGluZyBLZXJuZWwgVHJhY2UgRmlsZSBTeXN0ZW0u
Li4KWyAgIDI2LjgzNjY0NF0gc3lzdGVtZFsxXTogU3RhcnRpbmcgSm91cm5hbCBTZXJ2aWNlLi4u
ClsgICAyNi44NDA4NTFdIHN5c3RlbWRbMV06IFN0YXJ0aW5nIFNldCB0aGUgY29uc29sZSBrZXli
b2FyZCBsYXlvdXQuLi4KWyAgIDI2Ljg0NDg5NF0gc3lzdGVtZFsxXTogU3RhcnRpbmcgQ3JlYXRl
IGxpc3Qgb2Ygc3RhdGljIGRldmljZSBub2RlcyBmb3IgdGhlIGN1cnJlbnQga2VybmVsLi4uClsg
ICAyNi44NTAyNTJdIHN5c3RlbWRbMV06IFN0YXJ0aW5nIE1vbml0b3Jpbmcgb2YgTFZNMiBtaXJy
b3JzLCBzbmFwc2hvdHMgZXRjLiB1c2luZyBkbWV2ZW50ZCBvciBwcm9ncmVzcyBwb2xsaW5nLi4u
ClsgICAyNi44NTQyNjRdIHN5c3RlbWRbMV06IFN0YXJ0aW5nIExvYWQgS2VybmVsIE1vZHVsZSBj
aHJvbWVvc19wc3RvcmUuLi4KWyAgIDI2Ljg1NDQxMl0gc3lzdGVtZFsxXTogQ29uZGl0aW9uIGNo
ZWNrIHJlc3VsdGVkIGluIExvYWQgS2VybmVsIE1vZHVsZSBkcm0gYmVpbmcgc2tpcHBlZC4KWyAg
IDI2Ljg1ODIxNl0gc3lzdGVtZFsxXTogU3RhcnRpbmcgTG9hZCBLZXJuZWwgTW9kdWxlIGVmaV9w
c3RvcmUuLi4KWyAgIDI2Ljg2NzE5NV0gc3lzdGVtZFsxXTogU3RhcnRpbmcgTG9hZCBLZXJuZWwg
TW9kdWxlIHBzdG9yZV9ibGsuLi4KWyAgIDI2Ljg3MTk3MF0gc3lzdGVtZFsxXTogU3RhcnRpbmcg
TG9hZCBLZXJuZWwgTW9kdWxlIHBzdG9yZV96b25lLi4uClsgICAyNi44NzU5NzBdIHN5c3RlbWRb
MV06IFN0YXJ0aW5nIExvYWQgS2VybmVsIE1vZHVsZSByYW1vb3BzLi4uClsgICAyNi44NzYyMTRd
IHN5c3RlbWRbMV06IENvbmRpdGlvbiBjaGVjayByZXN1bHRlZCBpbiBPcGVuVlN3aXRjaCBjb25m
aWd1cmF0aW9uIGZvciBjbGVhbnVwIGJlaW5nIHNraXBwZWQuClsgICAyNi44Nzc2NjhdIHN5c3Rl
bWRbMV06IENvbmRpdGlvbiBjaGVjayByZXN1bHRlZCBpbiBTZXQgVXAgQWRkaXRpb25hbCBCaW5h
cnkgRm9ybWF0cyBiZWluZyBza2lwcGVkLgpbICAgMjYuODc3ODMwXSBzeXN0ZW1kWzFdOiBDb25k
aXRpb24gY2hlY2sgcmVzdWx0ZWQgaW4gRmlsZSBTeXN0ZW0gQ2hlY2sgb24gUm9vdCBEZXZpY2Ug
YmVpbmcgc2tpcHBlZC4KWyAgIDI2Ljg4NjE1MV0gc3lzdGVtZFsxXTogU3RhcnRpbmcgTG9hZCBL
ZXJuZWwgTW9kdWxlcy4uLgpbICAgMjYuODkwMDU1XSBzeXN0ZW1kWzFdOiBTdGFydGluZyBSZW1v
dW50IFJvb3QgYW5kIEtlcm5lbCBGaWxlIFN5c3RlbXMuLi4KWyAgIDI2Ljg5NzkxN10gc3lzdGVt
ZFsxXTogU3RhcnRpbmcgdWRldiBDb2xkcGx1ZyBhbGwgRGV2aWNlcy4uLgpbICAgMjYuOTA5OTc4
XSBzeXN0ZW1kWzFdOiBTdGFydGluZyBVbmNvbXBsaWNhdGVkIGZpcmV3YWxsLi4uClsgICAyNi45
MTY4NThdIHN5c3RlbWRbMV06IE1vdW50ZWQgSHVnZSBQYWdlcyBGaWxlIFN5c3RlbS4KWyAgIDI2
LjkxNzM5OF0gc3lzdGVtZFsxXTogTW91bnRlZCBQT1NJWCBNZXNzYWdlIFF1ZXVlIEZpbGUgU3lz
dGVtLgpbICAgMjYuOTE3ODQ2XSBzeXN0ZW1kWzFdOiBNb3VudGVkIEtlcm5lbCBEZWJ1ZyBGaWxl
IFN5c3RlbS4KWyAgIDI2LjkxODI5N10gc3lzdGVtZFsxXTogTW91bnRlZCBLZXJuZWwgVHJhY2Ug
RmlsZSBTeXN0ZW0uClsgICAyNi45MjAzMDJdIHN5c3RlbWRbMV06IEZpbmlzaGVkIENyZWF0ZSBs
aXN0IG9mIHN0YXRpYyBkZXZpY2Ugbm9kZXMgZm9yIHRoZSBjdXJyZW50IGtlcm5lbC4KWyAgIDI2
LjkyMTY2NF0gc3lzdGVtZFsxXTogbW9kcHJvYmVAcHN0b3JlX2Jsay5zZXJ2aWNlOiBTdWNjZWVk
ZWQuClsgICAyNi45MjI1MzJdIHN5c3RlbWRbMV06IEZpbmlzaGVkIExvYWQgS2VybmVsIE1vZHVs
ZSBwc3RvcmVfYmxrLgpbICAgMjYuOTIzNjAwXSBzeXN0ZW1kWzFdOiBtb2Rwcm9iZUBwc3RvcmVf
em9uZS5zZXJ2aWNlOiBTdWNjZWVkZWQuClsgICAyNi45MjQ0MTRdIHN5c3RlbWRbMV06IEZpbmlz
aGVkIExvYWQgS2VybmVsIE1vZHVsZSBwc3RvcmVfem9uZS4KWyAgIDI2LjkyNjUxNF0gc3lzdGVt
ZFsxXTogRmluaXNoZWQgVW5jb21wbGljYXRlZCBmaXJld2FsbC4KWyAgIDI2LjkzODYxM10gc3lz
dGVtZFsxXTogbW9kcHJvYmVAZWZpX3BzdG9yZS5zZXJ2aWNlOiBTdWNjZWVkZWQuClsgICAyNi45
Mzk0NjZdIHN5c3RlbWRbMV06IEZpbmlzaGVkIExvYWQgS2VybmVsIE1vZHVsZSBlZmlfcHN0b3Jl
LgpbICAgMjYuOTQxNjI4XSBzeXN0ZW1kWzFdOiBGaW5pc2hlZCBMb2FkIEtlcm5lbCBNb2R1bGVz
LgpbICAgMjYuOTU3MjUxXSBFWFQ0LWZzIChkbS0wKTogcmUtbW91bnRlZCA0OGE5ZGQ5MS1kMDBi
LTQ3YmYtOGY3Yi05NzU4YmFmNzlkODMgci93LiBRdW90YSBtb2RlOiBub25lLgpbICAgMjYuOTc3
NTgwXSBzeXN0ZW1kWzFdOiBNb3VudGluZyBGVVNFIENvbnRyb2wgRmlsZSBTeXN0ZW0uLi4KWyAg
IDI2Ljk4NDM3NF0gc3lzdGVtZFsxXTogTW91bnRpbmcgS2VybmVsIENvbmZpZ3VyYXRpb24gRmls
ZSBTeXN0ZW0uLi4KWyAgIDI2Ljk5MjQwOF0gc3lzdGVtZFsxXTogU3RhcnRpbmcgQXBwbHkgS2Vy
bmVsIFZhcmlhYmxlcy4uLgpbICAgMjcuMDAwNDMyXSBzeXN0ZW1kWzFdOiBtb2Rwcm9iZUByYW1v
b3BzLnNlcnZpY2U6IFN1Y2NlZWRlZC4KWyAgIDI3LjAwMTQwNl0gc3lzdGVtZFsxXTogRmluaXNo
ZWQgTG9hZCBLZXJuZWwgTW9kdWxlIHJhbW9vcHMuClsgICAyNy4wMDM3NzddIHN5c3RlbWRbMV06
IEZpbmlzaGVkIE1vbml0b3Jpbmcgb2YgTFZNMiBtaXJyb3JzLCBzbmFwc2hvdHMgZXRjLiB1c2lu
ZyBkbWV2ZW50ZCBvciBwcm9ncmVzcyBwb2xsaW5nLgpbICAgMjcuMDA0NzcwXSBzeXN0ZW1kWzFd
OiBtb2Rwcm9iZUBjaHJvbWVvc19wc3RvcmUuc2VydmljZTogU3VjY2VlZGVkLgpbICAgMjcuMDA1
ODg3XSBzeXN0ZW1kWzFdOiBGaW5pc2hlZCBMb2FkIEtlcm5lbCBNb2R1bGUgY2hyb21lb3NfcHN0
b3JlLgpbICAgMjcuMDA3OTUyXSBzeXN0ZW1kWzFdOiBGaW5pc2hlZCBSZW1vdW50IFJvb3QgYW5k
IEtlcm5lbCBGaWxlIFN5c3RlbXMuClsgICAyNy4wMTE0MTBdIHN5c3RlbWRbMV06IE1vdW50ZWQg
RlVTRSBDb250cm9sIEZpbGUgU3lzdGVtLgpbICAgMjcuMDExOTcxXSBzeXN0ZW1kWzFdOiBNb3Vu
dGVkIEtlcm5lbCBDb25maWd1cmF0aW9uIEZpbGUgU3lzdGVtLgpbICAgMjcuMDE0OTg1XSBzeXN0
ZW1kWzFdOiBDb25kaXRpb24gY2hlY2sgcmVzdWx0ZWQgaW4gUmVidWlsZCBIYXJkd2FyZSBEYXRh
YmFzZSBiZWluZyBza2lwcGVkLgpbICAgMjcuMDE5NjQ5XSBzeXN0ZW1kWzFdOiBTdGFydGluZyBD
cmVhdGUgU3lzdGVtIFVzZXJzLi4uClsgICAyNy4wNDYzOThdIHN5c3RlbWRbMV06IEZpbmlzaGVk
IEFwcGx5IEtlcm5lbCBWYXJpYWJsZXMuClsgICAyNy4wNjAyMzldIHN5c3RlbWRbMV06IEZpbmlz
aGVkIENyZWF0ZSBTeXN0ZW0gVXNlcnMuClsgICAyNy4wNzgwODBdIHN5c3RlbWRbMV06IFN0YXJ0
aW5nIENyZWF0ZSBTdGF0aWMgRGV2aWNlIE5vZGVzIGluIC9kZXYuLi4KWyAgIDI3LjExMjg0Nl0g
c3lzdGVtZFsxXTogRmluaXNoZWQgQ3JlYXRlIFN0YXRpYyBEZXZpY2UgTm9kZXMgaW4gL2Rldi4K
WyAgIDI3LjExODI3OV0gc3lzdGVtZFsxXTogU3RhcnRpbmcgdWRldiBLZXJuZWwgRGV2aWNlIE1h
bmFnZXIuLi4KWyAgIDI3LjIwMjMwM10gc3lzdGVtZFsxXTogRmluaXNoZWQgU2V0IHRoZSBjb25z
b2xlIGtleWJvYXJkIGxheW91dC4KWyAgIDI3LjIxOTY1OV0gc3lzdGVtZFsxXTogU3RhcnRlZCBK
b3VybmFsIFNlcnZpY2UuClsgICAyOS4yMjA1MTBdIG1laV90eGUgMDAwMDowMDoxYS4wOiB2Z2Fh
cmI6IHBjaV9ub3RpZnkKWyAgIDI5LjIyMDUzMF0gbWVpX3R4ZSAwMDAwOjAwOjFhLjA6IHJ1bnRp
bWUgSVJRIG1hcHBpbmcgbm90IHByb3ZpZGVkIGJ5IGFyY2gKWyAgIDI5LjI1ODg5M10gbWVpX3R4
ZSAwMDAwOjAwOjFhLjA6IHZnYWFyYjogcGNpX25vdGlmeQpbICAgMjkuMjcyNDQyXSBjZGNfYWNt
IDEtMzoxLjA6IHR0eUFDTTA6IFVTQiBBQ00gZGV2aWNlClsgICAyOS4yNzI1MzBdIHVzYmNvcmU6
IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBkcml2ZXIgY2RjX2FjbQpbICAgMjkuMjcyNTM2XSBj
ZGNfYWNtOiBVU0IgQWJzdHJhY3QgQ29udHJvbCBNb2RlbCBkcml2ZXIgZm9yIFVTQiBtb2RlbXMg
YW5kIElTRE4gYWRhcHRlcnMKWyAgIDMxLjI0ODQwMF0gaW50ZWxfcmFwbF9jb21tb246IEZvdW5k
IFJBUEwgZG9tYWluIHBhY2thZ2UKWyAgIDMxLjI0ODQxN10gaW50ZWxfcmFwbF9jb21tb246IEZv
dW5kIFJBUEwgZG9tYWluIGNvcmUKWyAgIDMxLjM4MTYwNF0gQWRkaW5nIDUyNDI4NzZrIHN3YXAg
b24gL2Rldi9tYXBwZXIvdmcwMC1zd2Fwdm9sLiAgUHJpb3JpdHk6LTIgZXh0ZW50czoxIGFjcm9z
czo1MjQyODc2ayBTUwpbICAgMzUuOTQ4ODEzXSBhbHVhOiBkZXZpY2UgaGFuZGxlciByZWdpc3Rl
cmVkClsgICAzNS45NTQ0MTNdIGVtYzogZGV2aWNlIGhhbmRsZXIgcmVnaXN0ZXJlZApbICAgMzUu
OTU5OTE3XSByZGFjOiBkZXZpY2UgaGFuZGxlciByZWdpc3RlcmVkClsgICAzNi4xODcwNjVdIEVY
VDQtZnMgKHNkYTIpOiBtb3VudGVkIGZpbGVzeXN0ZW0gZWUyOGFiMGMtODE1Zi00OTY5LTgwNTct
YmZiZjZlZDdmYzBhIHIvdyB3aXRoIG9yZGVyZWQgZGF0YSBtb2RlLiBRdW90YSBtb2RlOiBub25l
LgpbICAgMzYuMTg3MjkzXSBFWFQ0LWZzIChkbS0xKTogbW91bnRlZCBmaWxlc3lzdGVtIDM1NDkw
YjdmLTQ4OGMtNDQyYS1iOGU0LTViYjkwZGNmMmEyYSByL3cgd2l0aCBvcmRlcmVkIGRhdGEgbW9k
ZS4gUXVvdGEgbW9kZTogbm9uZS4KWyAgIDM2LjI0NTY4NF0gbG9vcDA6IGRldGVjdGVkIGNhcGFj
aXR5IGNoYW5nZSBmcm9tIDAgdG8gMTMwNDQ4ClsgICAzNi4yNjU3ODddIGxvb3AxOiBkZXRlY3Rl
ZCBjYXBhY2l0eSBjaGFuZ2UgZnJvbSAwIHRvIDEzMDU1MgpbICAgMzYuMjY2MDgwXSBsb29wMjog
ZGV0ZWN0ZWQgY2FwYWNpdHkgY2hhbmdlIGZyb20gMCB0byAxODgwNzIKWyAgIDM2LjI2NjM2NF0g
bG9vcDM6IGRldGVjdGVkIGNhcGFjaXR5IGNoYW5nZSBmcm9tIDAgdG8gMTg4MTc2ClsgICAzNi4y
ODU3NTRdIGxvb3A0OiBkZXRlY3RlZCBjYXBhY2l0eSBjaGFuZ2UgZnJvbSAwIHRvIDkxMDA4Clsg
ICAzNi4yODYwMzJdIHN5c3RlbWQtam91cm5hbGRbMzg4XTogUmVjZWl2ZWQgY2xpZW50IHJlcXVl
c3QgdG8gZmx1c2ggcnVudGltZSBqb3VybmFsLgpbICAgMzYuMjg2MzMwXSBsb29wNTogZGV0ZWN0
ZWQgY2FwYWNpdHkgY2hhbmdlIGZyb20gMCB0byA5MTAyNApbICAgMzYuNzg4NTI4XSBhdWRpdDog
dHlwZT0xNDAwIGF1ZGl0KDE3NDEyNzgyNTkuNTU1OjIpOiBhcHBhcm1vcj0iU1RBVFVTIiBvcGVy
YXRpb249InByb2ZpbGVfbG9hZCIgcHJvZmlsZT0idW5jb25maW5lZCIgbmFtZT0iL3Vzci9iaW4v
bWFuIiBwaWQ9NjY0IGNvbW09ImFwcGFybW9yX3BhcnNlciIKWyAgIDM2Ljc4ODU1Ml0gYXVkaXQ6
IHR5cGU9MTQwMCBhdWRpdCgxNzQxMjc4MjU5LjU1OTozKTogYXBwYXJtb3I9IlNUQVRVUyIgb3Bl
cmF0aW9uPSJwcm9maWxlX2xvYWQiIHByb2ZpbGU9InVuY29uZmluZWQiIG5hbWU9Im1hbl9maWx0
ZXIiIHBpZD02NjQgY29tbT0iYXBwYXJtb3JfcGFyc2VyIgpbICAgMzYuNzg4NTY0XSBhdWRpdDog
dHlwZT0xNDAwIGF1ZGl0KDE3NDEyNzgyNTkuNTU5OjQpOiBhcHBhcm1vcj0iU1RBVFVTIiBvcGVy
YXRpb249InByb2ZpbGVfbG9hZCIgcHJvZmlsZT0idW5jb25maW5lZCIgbmFtZT0ibWFuX2dyb2Zm
IiBwaWQ9NjY0IGNvbW09ImFwcGFybW9yX3BhcnNlciIKWyAgIDM2Ljk1ODA3MF0gYXVkaXQ6IHR5
cGU9MTQwMCBhdWRpdCgxNzQxMjc4MjU5LjczMTo1KTogYXBwYXJtb3I9IlNUQVRVUyIgb3BlcmF0
aW9uPSJwcm9maWxlX2xvYWQiIHByb2ZpbGU9InVuY29uZmluZWQiIG5hbWU9Ii91c3Ivc2Jpbi9u
dHBkIiBwaWQ9NjY1IGNvbW09ImFwcGFybW9yX3BhcnNlciIKWyAgIDM2Ljk5Mzc5OF0gYXVkaXQ6
IHR5cGU9MTQwMCBhdWRpdCgxNzQxMjc4MjU5Ljc2Nzo2KTogYXBwYXJtb3I9IlNUQVRVUyIgb3Bl
cmF0aW9uPSJwcm9maWxlX2xvYWQiIHByb2ZpbGU9InVuY29uZmluZWQiIG5hbWU9ImxzYl9yZWxl
YXNlIiBwaWQ9NjY4IGNvbW09ImFwcGFybW9yX3BhcnNlciIKWyAgIDM3LjE1MzIzOF0gYXVkaXQ6
IHR5cGU9MTQwMCBhdWRpdCgxNzQxMjc4MjU5LjkyNzo3KTogYXBwYXJtb3I9IlNUQVRVUyIgb3Bl
cmF0aW9uPSJwcm9maWxlX2xvYWQiIHByb2ZpbGU9InVuY29uZmluZWQiIG5hbWU9Ii91c3Ivc2Jp
bi90Y3BkdW1wIiBwaWQ9NjY3IGNvbW09ImFwcGFybW9yX3BhcnNlciIKWyAgIDM3LjE5MDQ3N10g
YXVkaXQ6IHR5cGU9MTQwMCBhdWRpdCgxNzQxMjc4MjU5Ljk2Mzo4KTogYXBwYXJtb3I9IlNUQVRV
UyIgb3BlcmF0aW9uPSJwcm9maWxlX2xvYWQiIHByb2ZpbGU9InVuY29uZmluZWQiIG5hbWU9Im52
aWRpYV9tb2Rwcm9iZSIgcGlkPTY3MCBjb21tPSJhcHBhcm1vcl9wYXJzZXIiClsgICAzNy4xOTIx
MjRdIGF1ZGl0OiB0eXBlPTE0MDAgYXVkaXQoMTc0MTI3ODI1OS45NjM6OSk6IGFwcGFybW9yPSJT
VEFUVVMiIG9wZXJhdGlvbj0icHJvZmlsZV9sb2FkIiBwcm9maWxlPSJ1bmNvbmZpbmVkIiBuYW1l
PSJudmlkaWFfbW9kcHJvYmUvL2ttb2QiIHBpZD02NzAgY29tbT0iYXBwYXJtb3JfcGFyc2VyIgpb
ICAgMzcuMjc3OTE1XSBhdWRpdDogdHlwZT0xNDAwIGF1ZGl0KDE3NDEyNzgyNjAuMDUxOjEwKTog
YXBwYXJtb3I9IlNUQVRVUyIgb3BlcmF0aW9uPSJwcm9maWxlX2xvYWQiIHByb2ZpbGU9InVuY29u
ZmluZWQiIG5hbWU9Ii91c3IvbGliL05ldHdvcmtNYW5hZ2VyL25tLWRoY3AtY2xpZW50LmFjdGlv
biIgcGlkPTY2NiBjb21tPSJhcHBhcm1vcl9wYXJzZXIiClsgICAzNy4yNzk4NDBdIGF1ZGl0OiB0
eXBlPTE0MDAgYXVkaXQoMTc0MTI3ODI2MC4wNTE6MTEpOiBhcHBhcm1vcj0iU1RBVFVTIiBvcGVy
YXRpb249InByb2ZpbGVfbG9hZCIgcHJvZmlsZT0idW5jb25maW5lZCIgbmFtZT0iL3Vzci9saWIv
TmV0d29ya01hbmFnZXIvbm0tZGhjcC1oZWxwZXIiIHBpZD02NjYgY29tbT0iYXBwYXJtb3JfcGFy
c2VyIgpbICAgNDIuMDY4MDg4XSBrYXVkaXRkX3ByaW50a19za2I6IDIwIGNhbGxiYWNrcyBzdXBw
cmVzc2VkClsgICA0Mi4wNjgwOThdIGF1ZGl0OiB0eXBlPTE0MDAgYXVkaXQoMTc0MTI3ODI2NC44
Mzk6MzIpOiBhcHBhcm1vcj0iU1RBVFVTIiBvcGVyYXRpb249InByb2ZpbGVfbG9hZCIgcHJvZmls
ZT0idW5jb25maW5lZCIgbmFtZT0ic25hcC5seGQubWlncmF0ZSIgcGlkPTcxMiBjb21tPSJhcHBh
cm1vcl9wYXJzZXIiClsgICA0NC43MzAwMjhdIGlnYiAwMDAwOjAzOjAwLjAgZW5wM3MwOiBpZ2I6
IGVucDNzMCBOSUMgTGluayBpcyBVcCAxMDAwIE1icHMgRnVsbCBEdXBsZXgsIEZsb3cgQ29udHJv
bDogUlgKWyAgIDUyLjY5OTUwMV0gYXVkaXQ6IHR5cGU9MTQwMCBhdWRpdCgxNzQxMjc4Mjc1LjQ3
MTozMyk6IGFwcGFybW9yPSJERU5JRUQiIG9wZXJhdGlvbj0ib3BlbiIgY2xhc3M9ImZpbGUiIHBy
b2ZpbGU9Ii91c3Ivc2Jpbi9udHBkIiBuYW1lPSIvc25hcC9iaW4vIiBwaWQ9Nzc5IGNvbW09Im50
cGQiIHJlcXVlc3RlZF9tYXNrPSJyIiBkZW5pZWRfbWFzaz0iciIgZnN1aWQ9MCBvdWlkPTAKWyAg
IDU1LjAwMjYyNF0gYXVkaXQ6IHR5cGU9MTQwMCBhdWRpdCgxNzQxMjc4Mjc3Ljc3NTozNCk6IGFw
cGFybW9yPSJTVEFUVVMiIG9wZXJhdGlvbj0icHJvZmlsZV9sb2FkIiBwcm9maWxlPSJ1bmNvbmZp
bmVkIiBuYW1lPSJkb2NrZXItZGVmYXVsdCIgcGlkPTkyMiBjb21tPSJhcHBhcm1vcl9wYXJzZXIi
ClsgICA1NS4xOTM2NDhdIGV2bTogb3ZlcmxheSBub3Qgc3VwcG9ydGVkClsgICA1NS43OTA5OTBd
IGJyaWRnZTogZmlsdGVyaW5nIHZpYSBhcnAvaXAvaXA2dGFibGVzIGlzIG5vIGxvbmdlciBhdmFp
bGFibGUgYnkgZGVmYXVsdC4gVXBkYXRlIHlvdXIgc2NyaXB0cyB0byBsb2FkIGJyX25ldGZpbHRl
ciBpZiB5b3UgbmVlZCB0aGlzLgpbICAgNTUuODAwMjc5XSBCcmlkZ2UgZmlyZXdhbGxpbmcgcmVn
aXN0ZXJlZApbICAgNTUuOTc2NTUxXSBsb29wNjogZGV0ZWN0ZWQgY2FwYWNpdHkgY2hhbmdlIGZy
b20gMCB0byA4ClsgICA1Ni4xMTU5NTBdIEluaXRpYWxpemluZyBYRlJNIG5ldGxpbmsgc29ja2V0
ClsgICA1Ni41MTUyMDNdIGF1ZGl0OiB0eXBlPTE0MDAgYXVkaXQoMTc0MTI3ODI3OS4yODc6MzUp
OiBhcHBhcm1vcj0iU1RBVFVTIiBvcGVyYXRpb249InByb2ZpbGVfcmVwbGFjZSIgcHJvZmlsZT0i
dW5jb25maW5lZCIgbmFtZT0iL3NuYXAvc25hcGQvMjM3NzEvdXNyL2xpYi9zbmFwZC9zbmFwLWNv
bmZpbmUiIHBpZD0xMTQ4IGNvbW09ImFwcGFybW9yX3BhcnNlciIKWyAgIDU2LjUzMzU1NF0gYXVk
aXQ6IHR5cGU9MTQwMCBhdWRpdCgxNzQxMjc4Mjc5LjMwNzozNik6IGFwcGFybW9yPSJTVEFUVVMi
IG9wZXJhdGlvbj0icHJvZmlsZV9yZXBsYWNlIiBwcm9maWxlPSJ1bmNvbmZpbmVkIiBuYW1lPSIv
c25hcC9zbmFwZC8yMzc3MS91c3IvbGliL3NuYXBkL3NuYXAtY29uZmluZS8vbW91bnQtbmFtZXNw
YWNlLWNhcHR1cmUtaGVscGVyIiBwaWQ9MTE0OCBjb21tPSJhcHBhcm1vcl9wYXJzZXIiClsgICA1
Ni41NTA1NzddIGF1ZGl0OiB0eXBlPTE0MDAgYXVkaXQoMTc0MTI3ODI3OS4zMjM6MzcpOiBhcHBh
cm1vcj0iU1RBVFVTIiBvcGVyYXRpb249InByb2ZpbGVfcmVwbGFjZSIgaW5mbz0ic2FtZSBhcyBj
dXJyZW50IHByb2ZpbGUsIHNraXBwaW5nIiBwcm9maWxlPSJ1bmNvbmZpbmVkIiBuYW1lPSJzbmFw
LXVwZGF0ZS1ucy5seGQiIHBpZD0xMTYxIGNvbW09ImFwcGFybW9yX3BhcnNlciIKWyAgIDU2LjU1
ODU3MV0gYXVkaXQ6IHR5cGU9MTQwMCBhdWRpdCgxNzQxMjc4Mjc5LjMzMTozOCk6IGFwcGFybW9y
PSJTVEFUVVMiIG9wZXJhdGlvbj0icHJvZmlsZV9yZXBsYWNlIiBpbmZvPSJzYW1lIGFzIGN1cnJl
bnQgcHJvZmlsZSwgc2tpcHBpbmciIHByb2ZpbGU9InVuY29uZmluZWQiIG5hbWU9InNuYXAubHhk
LmFjdGl2YXRlIiBwaWQ9MTE2MiBjb21tPSJhcHBhcm1vcl9wYXJzZXIiClsgICA1Ni41NjY2MDVd
IGF1ZGl0OiB0eXBlPTE0MDAgYXVkaXQoMTc0MTI3ODI3OS4zMzk6MzkpOiBhcHBhcm1vcj0iU1RB
VFVTIiBvcGVyYXRpb249InByb2ZpbGVfcmVwbGFjZSIgaW5mbz0ic2FtZSBhcyBjdXJyZW50IHBy
b2ZpbGUsIHNraXBwaW5nIiBwcm9maWxlPSJ1bmNvbmZpbmVkIiBuYW1lPSJzbmFwLmx4ZC5iZW5j
aG1hcmsiIHBpZD0xMTY1IGNvbW09ImFwcGFybW9yX3BhcnNlciIKWyAgIDU2LjU3NTA1MV0gYXVk
aXQ6IHR5cGU9MTQwMCBhdWRpdCgxNzQxMjc4Mjc5LjM0Nzo0MCk6IGFwcGFybW9yPSJTVEFUVVMi
IG9wZXJhdGlvbj0icHJvZmlsZV9yZXBsYWNlIiBpbmZvPSJzYW1lIGFzIGN1cnJlbnQgcHJvZmls
ZSwgc2tpcHBpbmciIHByb2ZpbGU9InVuY29uZmluZWQiIG5hbWU9InNuYXAubHhkLmJ1Z2luZm8i
IHBpZD0xMTY4IGNvbW09ImFwcGFybW9yX3BhcnNlciIKWyAgIDU2LjU4MjQ1OF0gYXVkaXQ6IHR5
cGU9MTQwMCBhdWRpdCgxNzQxMjc4Mjc5LjM1NTo0MSk6IGFwcGFybW9yPSJTVEFUVVMiIG9wZXJh
dGlvbj0icHJvZmlsZV9yZXBsYWNlIiBpbmZvPSJzYW1lIGFzIGN1cnJlbnQgcHJvZmlsZSwgc2tp
cHBpbmciIHByb2ZpbGU9InVuY29uZmluZWQiIG5hbWU9InNuYXAubHhkLmNoZWNrLWtlcm5lbCIg
cGlkPTExNzAgY29tbT0iYXBwYXJtb3JfcGFyc2VyIgpbICAgNTYuNTk1MzgzXSBhdWRpdDogdHlw
ZT0xNDAwIGF1ZGl0KDE3NDEyNzgyNzkuMzY3OjQyKTogYXBwYXJtb3I9IlNUQVRVUyIgb3BlcmF0
aW9uPSJwcm9maWxlX3JlcGxhY2UiIGluZm89InNhbWUgYXMgY3VycmVudCBwcm9maWxlLCBza2lw
cGluZyIgcHJvZmlsZT0idW5jb25maW5lZCIgbmFtZT0ic25hcC5seGQuZGFlbW9uIiBwaWQ9MTE3
MyBjb21tPSJhcHBhcm1vcl9wYXJzZXIiClsgNjE3My45NzE3MzZdIHBlcmY6IGludGVycnVwdCB0
b29rIHRvbyBsb25nICgyODU2ID4gMjUwMCksIGxvd2VyaW5nIGtlcm5lbC5wZXJmX2V2ZW50X21h
eF9zYW1wbGVfcmF0ZSB0byA3MDAwMApbIDk2MDcuNjA1ODU5XSBwZXJmOiBpbnRlcnJ1cHQgdG9v
ayB0b28gbG9uZyAoMzU5NCA+IDM1NzApLCBsb3dlcmluZyBrZXJuZWwucGVyZl9ldmVudF9tYXhf
c2FtcGxlX3JhdGUgdG8gNTU1MDAKWzE0NTM4LjY4NzI2NF0gcGVyZjogaW50ZXJydXB0IHRvb2sg
dG9vIGxvbmcgKDQ0OTkgPiA0NDkyKSwgbG93ZXJpbmcga2VybmVsLnBlcmZfZXZlbnRfbWF4X3Nh
bXBsZV9yYXRlIHRvIDQ0MjUwClsyNDU2Mi43NTY4ODNdIHBlcmY6IGludGVycnVwdCB0b29rIHRv
byBsb25nICg1NjMxID4gNTYyMyksIGxvd2VyaW5nIGtlcm5lbC5wZXJmX2V2ZW50X21heF9zYW1w
bGVfcmF0ZSB0byAzNTUwMApbNDA4NTkuOTY3MDkxXSBwZXJmOiBpbnRlcnJ1cHQgdG9vayB0b28g
bG9uZyAoNzIzOCA+IDcwMzgpLCBsb3dlcmluZyBrZXJuZWwucGVyZl9ldmVudF9tYXhfc2FtcGxl
X3JhdGUgdG8gMjc1MDAKWzEzNzE4NS44NzUxNjZdIHBlcmY6IGludGVycnVwdCB0b29rIHRvbyBs
b25nICg5NDA3ID4gOTA0NyksIGxvd2VyaW5nIGtlcm5lbC5wZXJmX2V2ZW50X21heF9zYW1wbGVf
cmF0ZSB0byAyMTI1MApbMjYwMjI4LjYwODk4Ml0gVVNFUiBQQ0kgUkVBRDogcmV0PTAsIGJ1cz0w
MSBkZXY9MDAgZnVuYz0wIHBvcz0weDAwIGxlbj00IGRhdGE9MHhmZmZmZmZmZgpbMjYwMjI4LjYw
OTY1N10gVVNFUiBQQ0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0weDA0
IGxlbj00IGRhdGE9MHhmZmZmZmZmZgpbMjYwMjI4LjYwOTY2N10gVVNFUiBQQ0kgUkVBRDogcmV0
PTAsIGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0weDA4IGxlbj00IGRhdGE9MHhmZmZmZmZmZgpb
MjYwMjI4LjYwOTY3M10gVVNFUiBQQ0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9MDAgZnVuYz0w
IHBvcz0weDBjIGxlbj00IGRhdGE9MHhmZmZmZmZmZgpbMjYwMjI4LjYwOTY3OV0gVVNFUiBQQ0kg
UkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0weDEwIGxlbj00IGRhdGE9MHhm
ZmZmZmZmZgpbMjYwMjI4LjYwOTY4NV0gVVNFUiBQQ0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9
MDAgZnVuYz0wIHBvcz0weDE0IGxlbj00IGRhdGE9MHhmZmZmZmZmZgpbMjYwMjI4LjYwOTY5MV0g
VVNFUiBQQ0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0weDE4IGxlbj00
IGRhdGE9MHhmZmZmZmZmZgpbMjYwMjI4LjYwOTY5Nl0gVVNFUiBQQ0kgUkVBRDogcmV0PTAsIGJ1
cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0weDFjIGxlbj00IGRhdGE9MHhmZmZmZmZmZgpbMjYwMjI4
LjYwOTcwMl0gVVNFUiBQQ0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0w
eDIwIGxlbj00IGRhdGE9MHhmZmZmZmZmZgpbMjYwMjI4LjYwOTcwOF0gVVNFUiBQQ0kgUkVBRDog
cmV0PTAsIGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0weDI0IGxlbj00IGRhdGE9MHhmZmZmZmZm
ZgpbMjYwMjI4LjYwOTcxM10gVVNFUiBQQ0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9MDAgZnVu
Yz0wIHBvcz0weDI4IGxlbj00IGRhdGE9MHhmZmZmZmZmZgpbMjYwMjI4LjYwOTcxOV0gVVNFUiBQ
Q0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0weDJjIGxlbj00IGRhdGE9
MHhmZmZmZmZmZgpbMjYwMjI4LjYwOTcyNV0gVVNFUiBQQ0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBk
ZXY9MDAgZnVuYz0wIHBvcz0weDMwIGxlbj00IGRhdGE9MHhmZmZmZmZmZgpbMjYwMjI4LjYwOTcz
MF0gVVNFUiBQQ0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0weDM0IGxl
bj00IGRhdGE9MHhmZmZmZmZmZgpbMjYwMjI4LjYwOTczNl0gVVNFUiBQQ0kgUkVBRDogcmV0PTAs
IGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0weDM4IGxlbj00IGRhdGE9MHhmZmZmZmZmZgpbMjYw
MjI4LjYwOTc0MV0gVVNFUiBQQ0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBv
cz0weDNjIGxlbj00IGRhdGE9MHhmZmZmZmZmZgpbMjYwMjI4LjY0MDM0Nl0gVVNFUiBQQ0kgUkVB
RDogcmV0PTAsIGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0weDQwIGxlbj00IGRhdGE9MHgzNDgw
MQpbMjYwMjI4LjY0MDM2M10gVVNFUiBQQ0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9MDAgZnVu
Yz0wIHBvcz0weDQ0IGxlbj00IGRhdGE9MHg4ClsyNjAyMjguNjQwMzcxXSBVU0VSIFBDSSBSRUFE
OiByZXQ9MCwgYnVzPTAxIGRldj0wMCBmdW5jPTAgcG9zPTB4NDggbGVuPTQgZGF0YT0weDYwMDUK
WzI2MDIyOC42NDAzNzddIFVTRVIgUENJIFJFQUQ6IHJldD0wLCBidXM9MDEgZGV2PTAwIGZ1bmM9
MCBwb3M9MHg0YyBsZW49NCBkYXRhPTB4MApbMjYwMjI4LjY0MDM4NF0gVVNFUiBQQ0kgUkVBRDog
cmV0PTAsIGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0weDUwIGxlbj00IGRhdGE9MHgwClsyNjAy
MjguNjQwMzkxXSBVU0VSIFBDSSBSRUFEOiByZXQ9MCwgYnVzPTAxIGRldj0wMCBmdW5jPTAgcG9z
PTB4NTQgbGVuPTQgZGF0YT0weDAKWzI2MDIyOC42NDAzOTddIFVTRVIgUENJIFJFQUQ6IHJldD0w
LCBidXM9MDEgZGV2PTAwIGZ1bmM9MCBwb3M9MHg1OCBsZW49NCBkYXRhPTB4MApbMjYwMjI4LjY0
MDQwNF0gVVNFUiBQQ0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0weDVj
IGxlbj00IGRhdGE9MHgwClsyNjAyMjguNjQwNDEwXSBVU0VSIFBDSSBSRUFEOiByZXQ9MCwgYnVz
PTAxIGRldj0wMCBmdW5jPTAgcG9zPTB4NjAgbGVuPTQgZGF0YT0weDIwMDEwClsyNjAyMjguNjQw
NDE3XSBVU0VSIFBDSSBSRUFEOiByZXQ9MCwgYnVzPTAxIGRldj0wMCBmdW5jPTAgcG9zPTB4NjQg
bGVuPTQgZGF0YT0weDhmYzIKWzI2MDIyOC42NDA0MjNdIFVTRVIgUENJIFJFQUQ6IHJldD0wLCBi
dXM9MDEgZGV2PTAwIGZ1bmM9MCBwb3M9MHg2OCBsZW49NCBkYXRhPTB4MjgxMApbMjYwMjI4LjY0
MDQzMF0gVVNFUiBQQ0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0weDZj
IGxlbj00IGRhdGE9MHgzZjQyMQpbMjYwMjI4LjY0MDQzN10gVVNFUiBQQ0kgUkVBRDogcmV0PTAs
IGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0weDcwIGxlbj00IGRhdGE9MHgyMTAwMDAKWzI2MDIy
OC42NDA0NDNdIFVTRVIgUENJIFJFQUQ6IHJldD0wLCBidXM9MDEgZGV2PTAwIGZ1bmM9MCBwb3M9
MHg3NCBsZW49NCBkYXRhPTB4MApbMjYwMjI4LjY0MDQ1MF0gVVNFUiBQQ0kgUkVBRDogcmV0PTAs
IGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0weDc4IGxlbj00IGRhdGE9MHgwClsyNjAyMjguNjQw
NDU3XSBVU0VSIFBDSSBSRUFEOiByZXQ9MCwgYnVzPTAxIGRldj0wMCBmdW5jPTAgcG9zPTB4N2Mg
bGVuPTQgZGF0YT0weDAKWzI2MDIyOC42NDA0NjNdIFVTRVIgUENJIFJFQUQ6IHJldD0wLCBidXM9
MDEgZGV2PTAwIGZ1bmM9MCBwb3M9MHg4MCBsZW49NCBkYXRhPTB4MApbMjYwMjI4LjY0MDQ3MF0g
VVNFUiBQQ0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0weDg0IGxlbj00
IGRhdGE9MHgyClsyNjAyMjguNjQwNDc2XSBVU0VSIFBDSSBSRUFEOiByZXQ9MCwgYnVzPTAxIGRl
dj0wMCBmdW5jPTAgcG9zPTB4ODggbGVuPTQgZGF0YT0weDAKWzI2MDIyOC42NDA0ODNdIFVTRVIg
UENJIFJFQUQ6IHJldD0wLCBidXM9MDEgZGV2PTAwIGZ1bmM9MCBwb3M9MHg4YyBsZW49NCBkYXRh
PTB4MApbMjYwMjI4LjY0MDQ4OV0gVVNFUiBQQ0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9MDAg
ZnVuYz0wIHBvcz0weDkwIGxlbj00IGRhdGE9MHgxMDAyMApbMjYwMjI4LjY0MDQ5Nl0gVVNFUiBQ
Q0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0weDk0IGxlbj00IGRhdGE9
MHgwClsyNjAyMjguNjQwNTAyXSBVU0VSIFBDSSBSRUFEOiByZXQ9MCwgYnVzPTAxIGRldj0wMCBm
dW5jPTAgcG9zPTB4OTggbGVuPTQgZGF0YT0weDAKWzI2MDIyOC42NDA1MDldIFVTRVIgUENJIFJF
QUQ6IHJldD0wLCBidXM9MDEgZGV2PTAwIGZ1bmM9MCBwb3M9MHg5YyBsZW49NCBkYXRhPTB4MApb
MjYwMjI4LjY0MDUxNV0gVVNFUiBQQ0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9MDAgZnVuYz0w
IHBvcz0weGEwIGxlbj00IGRhdGE9MHgwClsyNjAyMjguNjQwNTIyXSBVU0VSIFBDSSBSRUFEOiBy
ZXQ9MCwgYnVzPTAxIGRldj0wMCBmdW5jPTAgcG9zPTB4YTQgbGVuPTQgZGF0YT0weDAKWzI2MDIy
OC42NDA1MjhdIFVTRVIgUENJIFJFQUQ6IHJldD0wLCBidXM9MDEgZGV2PTAwIGZ1bmM9MCBwb3M9
MHhhOCBsZW49NCBkYXRhPTB4MApbMjYwMjI4LjY0MDUzNV0gVVNFUiBQQ0kgUkVBRDogcmV0PTAs
IGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0weGFjIGxlbj00IGRhdGE9MHgwClsyNjAyMjguNjQw
NTQxXSBVU0VSIFBDSSBSRUFEOiByZXQ9MCwgYnVzPTAxIGRldj0wMCBmdW5jPTAgcG9zPTB4YjAg
bGVuPTQgZGF0YT0weDAKWzI2MDIyOC42NDA1NDhdIFVTRVIgUENJIFJFQUQ6IHJldD0wLCBidXM9
MDEgZGV2PTAwIGZ1bmM9MCBwb3M9MHhiNCBsZW49NCBkYXRhPTB4MApbMjYwMjI4LjY0MDU1NV0g
VVNFUiBQQ0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0weGI4IGxlbj00
IGRhdGE9MHgwClsyNjAyMjguNjQwNTYxXSBVU0VSIFBDSSBSRUFEOiByZXQ9MCwgYnVzPTAxIGRl
dj0wMCBmdW5jPTAgcG9zPTB4YmMgbGVuPTQgZGF0YT0weDAKWzI2MDIyOC42NDA1NjhdIFVTRVIg
UENJIFJFQUQ6IHJldD0wLCBidXM9MDEgZGV2PTAwIGZ1bmM9MCBwb3M9MHhjMCBsZW49NCBkYXRh
PTB4MApbMjYwMjI4LjY0MDU3NF0gVVNFUiBQQ0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9MDAg
ZnVuYz0wIHBvcz0weGM0IGxlbj00IGRhdGE9MHgwClsyNjAyMjguNjQwNTgxXSBVU0VSIFBDSSBS
RUFEOiByZXQ9MCwgYnVzPTAxIGRldj0wMCBmdW5jPTAgcG9zPTB4YzggbGVuPTQgZGF0YT0weDAK
WzI2MDIyOC42NDA1ODddIFVTRVIgUENJIFJFQUQ6IHJldD0wLCBidXM9MDEgZGV2PTAwIGZ1bmM9
MCBwb3M9MHhjYyBsZW49NCBkYXRhPTB4MApbMjYwMjI4LjY0MDU5NF0gVVNFUiBQQ0kgUkVBRDog
cmV0PTAsIGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0weGQwIGxlbj00IGRhdGE9MHgwClsyNjAy
MjguNjQwNjAwXSBVU0VSIFBDSSBSRUFEOiByZXQ9MCwgYnVzPTAxIGRldj0wMCBmdW5jPTAgcG9z
PTB4ZDQgbGVuPTQgZGF0YT0weDAKWzI2MDIyOC42NDA2MDddIFVTRVIgUENJIFJFQUQ6IHJldD0w
LCBidXM9MDEgZGV2PTAwIGZ1bmM9MCBwb3M9MHhkOCBsZW49NCBkYXRhPTB4MApbMjYwMjI4LjY0
MDYxNF0gVVNFUiBQQ0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0weGRj
IGxlbj00IGRhdGE9MHgwClsyNjAyMjguNjQwNjIwXSBVU0VSIFBDSSBSRUFEOiByZXQ9MCwgYnVz
PTAxIGRldj0wMCBmdW5jPTAgcG9zPTB4ZTAgbGVuPTQgZGF0YT0weDAKWzI2MDIyOC42NDA2Mjdd
IFVTRVIgUENJIFJFQUQ6IHJldD0wLCBidXM9MDEgZGV2PTAwIGZ1bmM9MCBwb3M9MHhlNCBsZW49
NCBkYXRhPTB4MApbMjYwMjI4LjY0MDYzM10gVVNFUiBQQ0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBk
ZXY9MDAgZnVuYz0wIHBvcz0weGU4IGxlbj00IGRhdGE9MHgwClsyNjAyMjguNjQwNjM5XSBVU0VS
IFBDSSBSRUFEOiByZXQ9MCwgYnVzPTAxIGRldj0wMCBmdW5jPTAgcG9zPTB4ZWMgbGVuPTQgZGF0
YT0weDAKWzI2MDIyOC42NDA2NDZdIFVTRVIgUENJIFJFQUQ6IHJldD0wLCBidXM9MDEgZGV2PTAw
IGZ1bmM9MCBwb3M9MHhmMCBsZW49NCBkYXRhPTB4MApbMjYwMjI4LjY0MDY1M10gVVNFUiBQQ0kg
UkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0weGY0IGxlbj00IGRhdGE9MHgw
ClsyNjAyMjguNjQwNjU5XSBVU0VSIFBDSSBSRUFEOiByZXQ9MCwgYnVzPTAxIGRldj0wMCBmdW5j
PTAgcG9zPTB4ZjggbGVuPTQgZGF0YT0weDAKWzI2MDIyOC42NDA2NjZdIFVTRVIgUENJIFJFQUQ6
IHJldD0wLCBidXM9MDEgZGV2PTAwIGZ1bmM9MCBwb3M9MHhmYyBsZW49NCBkYXRhPTB4MApbMjYw
MjI4LjcxMTg2MF0gQUNQSTogXF9TQl8uUENJMC5SUDAxOiBBQ1BJOiBBQ1BJX05PVElGWV9CVVNf
Q0hFQ0sgZXZlbnQKWzI2MDIyOC43MTE5MDJdIEFDUEk6IFxfU0JfLlBDSTAuUlAwMTogQUNQSTog
T1NMOiBTY2hlZHVsaW5nIGhvdHBsdWcgZXZlbnQgMCBmb3IgZGVmZXJyZWQgaGFuZGxpbmcKWzI2
MDIyOC43MTIwMDRdIEFDUEk6IFxfU0JfLlBDSTAuUlAwMTogYWNwaXBocF9nbHVlOiBCcmlkZ2Ug
YWNxdWlyZWQgaW4gaG90cGx1Z19ldmVudCgpClsyNjAyMjguNzEyMDMyXSBBQ1BJOiBcX1NCXy5Q
Q0kwLlJQMDE6IGFjcGlwaHBfZ2x1ZTogQnVzIGNoZWNrIGluIGhvdHBsdWdfZXZlbnQoKQpbMjYw
MjI4LjcxMjA1M10gQUNQSTogXF9TQl8uUENJMC5SUDAxOiBhY3BpcGhwX2dsdWU6IENoZWNraW5n
IGJyaWRnZSBpbiBob3RwbHVnX2V2ZW50KCkKWzI2MDIyOC43MTIwOTZdIEFDUEk6IFxfU0JfLlBD
STAuUlAwMTogYWNwaXBocF9nbHVlOiBjYWxsaW5nIGVhcmx5X2R1bXBfcGNpX2RldmljZSgpIGJl
Zm9yZSBlbmFibGVfc2xvdCgpIGluIGFjcGlwaHBfY2hlY2tfYnJpZGdlKCkKWzI2MDIyOC43MTIx
MjFdIHBjaWVwb3J0IDAwMDA6MDA6MWMuMDogY29uZmlnIHNwYWNlOgpbMjYwMjI4LjcxMjIxN10g
MDAwMDAwMDA6IDg2IDgwIDQ4IDBmIDA3IDA0IDEwIDAwIDExIDAwIDA0IDA2IDEwIDAwIDgxIDAw
ClsyNjAyMjguNzEyMjMyXSAwMDAwMDAxMDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDEg
MDEgMDAgMTAgMTAgMDAgMjAKWzI2MDIyOC43MTIyNDZdIDAwMDAwMDIwOiA0MCBiMCA3MCBiMCBm
MSBmZiAwMSAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMApbMjYwMjI4LjcxMjI1OF0gMDAwMDAw
MzA6IDAwIDAwIDAwIDAwIDQwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDBiIDAxIDEyIDAwClsyNjAy
MjguNzEyMjcwXSAwMDAwMDA0MDogMTAgODAgNDIgMDEgMDAgODAgMDAgMDAgMDAgMDAgMTEgMDAg
MjIgNGMgMzEgMDEKWzI2MDIyOC43MTIyODJdIDAwMDAwMDUwOiAwMCAwYyAyMSAzMCA2MCAwMCAw
NCAwMCAwMCAwMCA0MCAwMSAwMCAwMCAwMCAwMApbMjYwMjI4LjcxMjI5NF0gMDAwMDAwNjA6IDAw
IDAwIDAwIDAwIDE2IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwClsyNjAyMjguNzEy
MzA2XSAwMDAwMDA3MDogMDEgMDAgMDEgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAKWzI2MDIyOC43MTIzMThdIDAwMDAwMDgwOiAwNSA5MCAwMSAwMCAwMCAyMCBlMCBmZSAy
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMApbMjYwMjI4LjcxMjMzMF0gMDAwMDAwOTA6IDBkIGEwIDAw
IDAwIDg2IDgwIDQ4IDBmIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwClsyNjAyMjguNzEyMzQyXSAw
MDAwMDBhMDogMDEgMDAgMDMgYzggMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAK
WzI2MDIyOC43MTIzNTRdIDAwMDAwMGIwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMApbMjYwMjI4LjcxMjM2Nl0gMDAwMDAwYzA6IDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwClsyNjAyMjguNzEyMzc4XSAwMDAwMDBk
MDogMDAgYzAgMDAgMDAgNDIgMDggMDAgMDAgMDAgODAgMTEgYzkgMDAgMDAgMDAgMDAKWzI2MDIy
OC43MTIzOTBdIDAwMDAwMGUwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwNCAwMCAwMCAwMCAw
MCAwMCAwMCAwMApbMjYwMjI4LjcxMjQwMl0gMDAwMDAwZjA6IDUwIDAwIDAwIDAwIGMwIDAwIDAw
IDAwIDFhIDBmIDEzIDAxIDAwIDQwIDAwIDAxClsyNjAyMjguNzEyNDIwXSBBQ1BJOiBcX1NCXy5Q
Q0kwLlJQMDE6IGFjcGlwaHBfZ2x1ZTogRW5hYmxpbmcgc2xvdCBpbiBhY3BpcGhwX2NoZWNrX2Jy
aWRnZSgpClsyNjAyMjguNzEyNDgxXSBBQ1BJOiBEZXZpY2UgW1BYU1hdIHN0YXR1cyBbMDAwMDAw
MGZdClsyNjAyMjguNzEyNTMyXSBBQ1BJOiBEZXZpY2UgW0QwMTVdIHN0YXR1cyBbMDAwMDAwMGZd
ClsyNjAyMjguNzEyNTk4XSBBQ1BJOiBcX1NCXy5QQ0kwLlJQMDE6IGFjcGlwaHBfZ2x1ZTogY2Fs
bGluZyBlYXJseV9kdW1wX3BjaV9kZXZpY2UoKSBhZnRlciBlbmFibGVfc2xvdCgpIGluIGFjcGlw
aHBfY2hlY2tfYnJpZGdlKCkKWzI2MDIyOC43MTI2MjRdIHBjaWVwb3J0IDAwMDA6MDA6MWMuMDog
Y29uZmlnIHNwYWNlOgpbMjYwMjI4LjcxMjcxOF0gMDAwMDAwMDA6IDg2IDgwIDQ4IDBmIDA3IDA0
IDEwIDAwIDExIDAwIDA0IDA2IDEwIDAwIDgxIDAwClsyNjAyMjguNzEyNzMzXSAwMDAwMDAxMDog
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDEgMDEgMDAgMTAgMTAgMDAgMjAKWzI2MDIyOC43
MTI3NDZdIDAwMDAwMDIwOiA0MCBiMCA3MCBiMCBmMSBmZiAwMSAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMApbMjYwMjI4LjcxMjc1OF0gMDAwMDAwMzA6IDAwIDAwIDAwIDAwIDQwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDBiIDAxIDEyIDAwClsyNjAyMjguNzEyNzcwXSAwMDAwMDA0MDogMTAgODAg
NDIgMDEgMDAgODAgMDAgMDAgMDAgMDAgMTEgMDAgMjIgNGMgMzEgMDEKWzI2MDIyOC43MTI3ODJd
IDAwMDAwMDUwOiAwMCAwYyAyMSAzMCA2MCAwMCAwNCAwMCAwMCAwMCA0MCAwMSAwMCAwMCAwMCAw
MApbMjYwMjI4LjcxMjc5NF0gMDAwMDAwNjA6IDAwIDAwIDAwIDAwIDE2IDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwClsyNjAyMjguNzEyODA2XSAwMDAwMDA3MDogMDEgMDAgMDEgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAKWzI2MDIyOC43MTI4MThdIDAwMDAw
MDgwOiAwNSA5MCAwMSAwMCAwMCAyMCBlMCBmZSAyMCAwMCAwMCAwMCAwMCAwMCAwMCAwMApbMjYw
MjI4LjcxMjgzMF0gMDAwMDAwOTA6IDBkIGEwIDAwIDAwIDg2IDgwIDQ4IDBmIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwClsyNjAyMjguNzEyODQxXSAwMDAwMDBhMDogMDEgMDAgMDMgYzggMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAKWzI2MDIyOC43MTI4NTRdIDAwMDAwMGIwOiAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMApbMjYwMjI4Ljcx
Mjg2NV0gMDAwMDAwYzA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwClsyNjAyMjguNzEyODc3XSAwMDAwMDBkMDogMDAgYzAgMDAgMDAgNDIgMDggMDAgMDAg
MDAgODAgMTEgYzkgMDAgMDAgMDAgMDAKWzI2MDIyOC43MTI4OTBdIDAwMDAwMGUwOiAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwNCAwMCAwMCAwMCAwMCAwMCAwMCAwMApbMjYwMjI4LjcxMjkwMl0g
MDAwMDAwZjA6IDUwIDAwIDAwIDAwIGMwIDAwIDAwIDAwIDFhIDBmIDEzIDAxIDAwIDQwIDAwIDAx
ClsyNjAyMjguNzEyOTIwXSBBQ1BJOiBcX1NCXy5QQ0kwLlJQMDE6IGFjcGlwaHBfZ2x1ZTogY2Fs
bGluZyBlYXJseV9kdW1wX3BjaV9kZXZpY2UoKSBhZnRlciBwbV9ydW50aW1lX3B1dCgpIGluIGFj
cGlwaHBfY2hlY2tfYnJpZGdlKCkKWzI2MDIyOC43MTI5MzldIHBjaWVwb3J0IDAwMDA6MDA6MWMu
MDogY29uZmlnIHNwYWNlOgpbMjYwMjI4LjcxMzAzMF0gMDAwMDAwMDA6IDg2IDgwIDQ4IDBmIDA3
IDA0IDEwIDAwIDExIDAwIDA0IDA2IDEwIDAwIDgxIDAwClsyNjAyMjguNzEzMDQ0XSAwMDAwMDAx
MDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDEgMDEgMDAgMTAgMTAgMDAgMjAKWzI2MDIy
OC43MTMwNTZdIDAwMDAwMDIwOiA0MCBiMCA3MCBiMCBmMSBmZiAwMSAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMApbMjYwMjI4LjcxMzA2OV0gMDAwMDAwMzA6IDAwIDAwIDAwIDAwIDQwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDBiIDAxIDEyIDAwClsyNjAyMjguNzEzMDgxXSAwMDAwMDA0MDogMTAg
ODAgNDIgMDEgMDAgODAgMDAgMDAgMDAgMDAgMTEgMDAgMjIgNGMgMzEgMDEKWzI2MDIyOC43MTMw
OTNdIDAwMDAwMDUwOiAwMCAwYyAyMSAzMCA2MCAwMCAwNCAwMCAwMCAwMCA0MCAwMSAwMCAwMCAw
MCAwMApbMjYwMjI4LjcxMzEwNV0gMDAwMDAwNjA6IDAwIDAwIDAwIDAwIDE2IDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwClsyNjAyMjguNzEzMTE3XSAwMDAwMDA3MDogMDEgMDAgMDEg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAKWzI2MDIyOC43MTMxMjldIDAw
MDAwMDgwOiAwNSA5MCAwMSAwMCAwMCAyMCBlMCBmZSAyMCAwMCAwMCAwMCAwMCAwMCAwMCAwMApb
MjYwMjI4LjcxMzE0MV0gMDAwMDAwOTA6IDBkIGEwIDAwIDAwIDg2IDgwIDQ4IDBmIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwClsyNjAyMjguNzEzMTUzXSAwMDAwMDBhMDogMDEgMDAgMDMgYzggMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAKWzI2MDIyOC43MTMxNjVdIDAwMDAwMGIw
OiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMApbMjYwMjI4
LjcxMzE3N10gMDAwMDAwYzA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwClsyNjAyMjguNzEzMTg5XSAwMDAwMDBkMDogMDAgYzAgMDAgMDAgNDIgMDggMDAg
MDAgMDAgODAgMTEgYzkgMDAgMDAgMDAgMDAKWzI2MDIyOC43MTMyMDFdIDAwMDAwMGUwOiAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwNCAwMCAwMCAwMCAwMCAwMCAwMCAwMApbMjYwMjI4LjcxMzIx
M10gMDAwMDAwZjA6IDUwIDAwIDAwIDAwIGMwIDAwIDAwIDAwIDFhIDBmIDEzIDAxIDAwIDQwIDAw
IDAxClsyNjAyMjguNzEzMjMxXSBBQ1BJOiBcX1NCXy5QQ0kwLlJQMDE6IGFjcGlwaHBfZ2x1ZTog
Y2FsbGluZyBlYXJseV9kdW1wX3BjaV9kZXZpY2UoKSBiZWZvcmUgcHV0X2JyaWRnZSgpIGluIGhv
dHBsdWdfZXZlbnQoKQpbMjYwMjI4LjcxMzI1MF0gcGNpZXBvcnQgMDAwMDowMDoxYy4wOiBjb25m
aWcgc3BhY2U6ClsyNjAyMjguNzEzMzQwXSAwMDAwMDAwMDogODYgODAgNDggMGYgMDcgMDQgMTAg
MDAgMTEgMDAgMDQgMDYgMTAgMDAgODEgMDAKWzI2MDIyOC43MTMzNTRdIDAwMDAwMDEwOiAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMSAwMSAwMCAxMCAxMCAwMCAyMApbMjYwMjI4LjcxMzM2
Nl0gMDAwMDAwMjA6IDQwIGIwIDcwIGIwIGYxIGZmIDAxIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwClsyNjAyMjguNzEzMzc4XSAwMDAwMDAzMDogMDAgMDAgMDAgMDAgNDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMGIgMDEgMTIgMDAKWzI2MDIyOC43MTMzOTBdIDAwMDAwMDQwOiAxMCA4MCA0MiAw
MSAwMCA4MCAwMCAwMCAwMCAwMCAxMSAwMCAyMiA0YyAzMSAwMQpbMjYwMjI4LjcxMzQwMl0gMDAw
MDAwNTA6IDAwIDBjIDIxIDMwIDYwIDAwIDA0IDAwIDAwIDAwIDQwIDAxIDAwIDAwIDAwIDAwClsy
NjAyMjguNzEzNDE0XSAwMDAwMDA2MDogMDAgMDAgMDAgMDAgMTYgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAKWzI2MDIyOC43MTM0MjZdIDAwMDAwMDcwOiAwMSAwMCAwMSAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMApbMjYwMjI4LjcxMzQzOF0gMDAwMDAwODA6
IDA1IDkwIDAxIDAwIDAwIDIwIGUwIGZlIDIwIDAwIDAwIDAwIDAwIDAwIDAwIDAwClsyNjAyMjgu
NzEzNDUwXSAwMDAwMDA5MDogMGQgYTAgMDAgMDAgODYgODAgNDggMGYgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAKWzI2MDIyOC43MTM0NjJdIDAwMDAwMGEwOiAwMSAwMCAwMyBjOCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMApbMjYwMjI4LjcxMzQ3NF0gMDAwMDAwYjA6IDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwClsyNjAyMjguNzEzNDg2
XSAwMDAwMDBjMDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAKWzI2MDIyOC43MTM0OThdIDAwMDAwMGQwOiAwMCBjMCAwMCAwMCA0MiAwOCAwMCAwMCAwMCA4
MCAxMSBjOSAwMCAwMCAwMCAwMApbMjYwMjI4LjcxMzUxMF0gMDAwMDAwZTA6IDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDA0IDAwIDAwIDAwIDAwIDAwIDAwIDAwClsyNjAyMjguNzEzNTIyXSAwMDAw
MDBmMDogNTAgMDAgMDAgMDAgYzAgMDAgMDAgMDAgMWEgMGYgMTMgMDEgMDAgNDAgMDAgMDEKWzI2
MDIyOC43MTM1MzhdIEFDUEk6IFxfU0JfLlBDSTAuUlAwMTogYWNwaXBocF9nbHVlOiBSZWxlYXNp
bmcgYnJpZGdlIGluIGhvdHBsdWdfZXZlbnQoKQpbMjYwMjI4LjcxMzU1N10gQUNQSTogXF9TQl8u
UENJMC5SUDAxOiBhY3BpcGhwX2dsdWU6IGNhbGxpbmcgZWFybHlfZHVtcF9wY2lfZGV2aWNlKCkg
YWZ0ZXIgcHV0X2JyaWRnZSgpIGluIGhvdHBsdWdfZXZlbnQoKQpbMjYwMjI4LjcxMzU3NV0gcGNp
ZXBvcnQgMDAwMDowMDoxYy4wOiBjb25maWcgc3BhY2U6ClsyNjAyMjguNzEzNjY2XSAwMDAwMDAw
MDogODYgODAgNDggMGYgMDcgMDQgMTAgMDAgMTEgMDAgMDQgMDYgMTAgMDAgODEgMDAKWzI2MDIy
OC43MTM2NzldIDAwMDAwMDEwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMSAwMSAwMCAx
MCAxMCAwMCAyMApbMjYwMjI4LjcxMzY5Ml0gMDAwMDAwMjA6IDQwIGIwIDcwIGIwIGYxIGZmIDAx
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwClsyNjAyMjguNzEzNzA0XSAwMDAwMDAzMDogMDAg
MDAgMDAgMDAgNDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMGIgMDEgMTIgMDAKWzI2MDIyOC43MTM3
MTZdIDAwMDAwMDQwOiAxMCA4MCA0MiAwMSAwMCA4MCAwMCAwMCAwMCAwMCAxMSAwMCAyMiA0YyAz
MSAwMQpbMjYwMjI4LjcxMzcyOF0gMDAwMDAwNTA6IDAwIDBjIDIxIDMwIDYwIDAwIDA0IDAwIDAw
IDAwIDQwIDAxIDAwIDAwIDAwIDAwClsyNjAyMjguNzEzNzQwXSAwMDAwMDA2MDogMDAgMDAgMDAg
MDAgMTYgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAKWzI2MDIyOC43MTM3NTJdIDAw
MDAwMDcwOiAwMSAwMCAwMSAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMApb
MjYwMjI4LjcxMzc2NF0gMDAwMDAwODA6IDA1IDkwIDAxIDAwIDAwIDIwIGUwIGZlIDIwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwClsyNjAyMjguNzEzNzc2XSAwMDAwMDA5MDogMGQgYTAgMDAgMDAgODYg
ODAgNDggMGYgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAKWzI2MDIyOC43MTM3ODhdIDAwMDAwMGEw
OiAwMSAwMCAwMyBjOCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMApbMjYwMjI4
LjcxMzgwMF0gMDAwMDAwYjA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwClsyNjAyMjguNzEzODEyXSAwMDAwMDBjMDogMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAKWzI2MDIyOC43MTM4MjRdIDAwMDAwMGQwOiAwMCBj
MCAwMCAwMCA0MiAwOCAwMCAwMCAwMCA4MCAxMSBjOSAwMCAwMCAwMCAwMApbMjYwMjI4LjcxMzgz
Nl0gMDAwMDAwZTA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDA0IDAwIDAwIDAwIDAwIDAwIDAw
IDAwClsyNjAyMjguNzEzODQ4XSAwMDAwMDBmMDogNTAgMDAgMDAgMDAgYzAgMDAgMDAgMDAgMWEg
MGYgMTMgMDEgMDAgNDAgMDAgMDEKWzI2MDQyNy43MTU4NzhdIFVTRVIgUENJIFJFQUQ6IHJldD0w
LCBidXM9MDEgZGV2PTAwIGZ1bmM9MCBwb3M9MHgwMCBsZW49NCBkYXRhPTB4NTU1NTE1NTYKWzI2
MDQyNy43MTU4OTRdIFVTRVIgUENJIFJFQUQ6IHJldD0wLCBidXM9MDEgZGV2PTAwIGZ1bmM9MCBw
b3M9MHgwNCBsZW49NCBkYXRhPTB4MTAwMDAwClsyNjA0MjcuNzE1OTAxXSBVU0VSIFBDSSBSRUFE
OiByZXQ9MCwgYnVzPTAxIGRldj0wMCBmdW5jPTAgcG9zPTB4MDggbGVuPTQgZGF0YT0weDUwMDAw
MDAKWzI2MDQyNy43MTU5MDhdIFVTRVIgUENJIFJFQUQ6IHJldD0wLCBidXM9MDEgZGV2PTAwIGZ1
bmM9MCBwb3M9MHgwYyBsZW49NCBkYXRhPTB4MApbMjYwNDI3LjcxNTkxNV0gVVNFUiBQQ0kgUkVB
RDogcmV0PTAsIGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0weDEwIGxlbj00IGRhdGE9MHgwClsy
NjA0MjcuNzE1OTIxXSBVU0VSIFBDSSBSRUFEOiByZXQ9MCwgYnVzPTAxIGRldj0wMCBmdW5jPTAg
cG9zPTB4MTQgbGVuPTQgZGF0YT0weDAKWzI2MDQyNy43MTU5MjhdIFVTRVIgUENJIFJFQUQ6IHJl
dD0wLCBidXM9MDEgZGV2PTAwIGZ1bmM9MCBwb3M9MHgxOCBsZW49NCBkYXRhPTB4MApbMjYwNDI3
LjcxNTkzNV0gVVNFUiBQQ0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0w
eDFjIGxlbj00IGRhdGE9MHgwClsyNjA0MjcuNzE1OTQxXSBVU0VSIFBDSSBSRUFEOiByZXQ9MCwg
YnVzPTAxIGRldj0wMCBmdW5jPTAgcG9zPTB4MjAgbGVuPTQgZGF0YT0weDAKWzI2MDQyNy43MTU5
NDhdIFVTRVIgUENJIFJFQUQ6IHJldD0wLCBidXM9MDEgZGV2PTAwIGZ1bmM9MCBwb3M9MHgyNCBs
ZW49NCBkYXRhPTB4MApbMjYwNDI3LjcxNTk1NF0gVVNFUiBQQ0kgUkVBRDogcmV0PTAsIGJ1cz0w
MSBkZXY9MDAgZnVuYz0wIHBvcz0weDI4IGxlbj00IGRhdGE9MHgwClsyNjA0MjcuNzE1OTYxXSBV
U0VSIFBDSSBSRUFEOiByZXQ9MCwgYnVzPTAxIGRldj0wMCBmdW5jPTAgcG9zPTB4MmMgbGVuPTQg
ZGF0YT0weDQwMDAKWzI2MDQyNy43MTU5NjddIFVTRVIgUENJIFJFQUQ6IHJldD0wLCBidXM9MDEg
ZGV2PTAwIGZ1bmM9MCBwb3M9MHgzMCBsZW49NCBkYXRhPTB4MApbMjYwNDI3LjcxNTk3NF0gVVNF
UiBQQ0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0weDM0IGxlbj00IGRh
dGE9MHg0MApbMjYwNDI3LjcxNTk4MF0gVVNFUiBQQ0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9
MDAgZnVuYz0wIHBvcz0weDM4IGxlbj00IGRhdGE9MHgwClsyNjA0MjcuNzE1OTg3XSBVU0VSIFBD
SSBSRUFEOiByZXQ9MCwgYnVzPTAxIGRldj0wMCBmdW5jPTAgcG9zPTB4M2MgbGVuPTQgZGF0YT0w
eDFmZgpbMjYwNDI3Ljc0MTQxN10gVVNFUiBQQ0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9MDAg
ZnVuYz0wIHBvcz0weDQwIGxlbj00IGRhdGE9MHgzNDgwMQpbMjYwNDI3Ljc0MTQzNV0gVVNFUiBQ
Q0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0weDQ0IGxlbj00IGRhdGE9
MHg4ClsyNjA0MjcuNzQxNDQzXSBVU0VSIFBDSSBSRUFEOiByZXQ9MCwgYnVzPTAxIGRldj0wMCBm
dW5jPTAgcG9zPTB4NDggbGVuPTQgZGF0YT0weDYwMDUKWzI2MDQyNy43NDE0NDldIFVTRVIgUENJ
IFJFQUQ6IHJldD0wLCBidXM9MDEgZGV2PTAwIGZ1bmM9MCBwb3M9MHg0YyBsZW49NCBkYXRhPTB4
MApbMjYwNDI3Ljc0MTQ1Nl0gVVNFUiBQQ0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9MDAgZnVu
Yz0wIHBvcz0weDUwIGxlbj00IGRhdGE9MHgwClsyNjA0MjcuNzQxNDYzXSBVU0VSIFBDSSBSRUFE
OiByZXQ9MCwgYnVzPTAxIGRldj0wMCBmdW5jPTAgcG9zPTB4NTQgbGVuPTQgZGF0YT0weDAKWzI2
MDQyNy43NDE0NjldIFVTRVIgUENJIFJFQUQ6IHJldD0wLCBidXM9MDEgZGV2PTAwIGZ1bmM9MCBw
b3M9MHg1OCBsZW49NCBkYXRhPTB4MApbMjYwNDI3Ljc0MTQ3Nl0gVVNFUiBQQ0kgUkVBRDogcmV0
PTAsIGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0weDVjIGxlbj00IGRhdGE9MHgwClsyNjA0Mjcu
NzQxNDg3XSBVU0VSIFBDSSBSRUFEOiByZXQ9MCwgYnVzPTAxIGRldj0wMCBmdW5jPTAgcG9zPTB4
NjAgbGVuPTQgZGF0YT0weDIwMDEwClsyNjA0MjcuNzQxNDk0XSBVU0VSIFBDSSBSRUFEOiByZXQ9
MCwgYnVzPTAxIGRldj0wMCBmdW5jPTAgcG9zPTB4NjQgbGVuPTQgZGF0YT0weDhmYzIKWzI2MDQy
Ny43NDE1MDFdIFVTRVIgUENJIFJFQUQ6IHJldD0wLCBidXM9MDEgZGV2PTAwIGZ1bmM9MCBwb3M9
MHg2OCBsZW49NCBkYXRhPTB4MjgxMApbMjYwNDI3Ljc0MTUwOF0gVVNFUiBQQ0kgUkVBRDogcmV0
PTAsIGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0weDZjIGxlbj00IGRhdGE9MHgzZjQyMQpbMjYw
NDI3Ljc0MTUxNF0gVVNFUiBQQ0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBv
cz0weDcwIGxlbj00IGRhdGE9MHgyMTAwMDAKWzI2MDQyNy43NDE1MjFdIFVTRVIgUENJIFJFQUQ6
IHJldD0wLCBidXM9MDEgZGV2PTAwIGZ1bmM9MCBwb3M9MHg3NCBsZW49NCBkYXRhPTB4MApbMjYw
NDI3Ljc0MTUyOF0gVVNFUiBQQ0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBv
cz0weDc4IGxlbj00IGRhdGE9MHgwClsyNjA0MjcuNzQxNTM0XSBVU0VSIFBDSSBSRUFEOiByZXQ9
MCwgYnVzPTAxIGRldj0wMCBmdW5jPTAgcG9zPTB4N2MgbGVuPTQgZGF0YT0weDAKWzI2MDQyNy43
NDE1NDFdIFVTRVIgUENJIFJFQUQ6IHJldD0wLCBidXM9MDEgZGV2PTAwIGZ1bmM9MCBwb3M9MHg4
MCBsZW49NCBkYXRhPTB4MApbMjYwNDI3Ljc0MTU0OF0gVVNFUiBQQ0kgUkVBRDogcmV0PTAsIGJ1
cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0weDg0IGxlbj00IGRhdGE9MHgyClsyNjA0MjcuNzQxNTU0
XSBVU0VSIFBDSSBSRUFEOiByZXQ9MCwgYnVzPTAxIGRldj0wMCBmdW5jPTAgcG9zPTB4ODggbGVu
PTQgZGF0YT0weDAKWzI2MDQyNy43NDE1NjFdIFVTRVIgUENJIFJFQUQ6IHJldD0wLCBidXM9MDEg
ZGV2PTAwIGZ1bmM9MCBwb3M9MHg4YyBsZW49NCBkYXRhPTB4MApbMjYwNDI3Ljc0MTU2N10gVVNF
UiBQQ0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0weDkwIGxlbj00IGRh
dGE9MHgxMDAyMApbMjYwNDI3Ljc0MTU3NF0gVVNFUiBQQ0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBk
ZXY9MDAgZnVuYz0wIHBvcz0weDk0IGxlbj00IGRhdGE9MHgwClsyNjA0MjcuNzQxNTgxXSBVU0VS
IFBDSSBSRUFEOiByZXQ9MCwgYnVzPTAxIGRldj0wMCBmdW5jPTAgcG9zPTB4OTggbGVuPTQgZGF0
YT0weDAKWzI2MDQyNy43NDE1ODddIFVTRVIgUENJIFJFQUQ6IHJldD0wLCBidXM9MDEgZGV2PTAw
IGZ1bmM9MCBwb3M9MHg5YyBsZW49NCBkYXRhPTB4MApbMjYwNDI3Ljc0MTU5NF0gVVNFUiBQQ0kg
UkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0weGEwIGxlbj00IGRhdGE9MHgw
ClsyNjA0MjcuNzQxNjAwXSBVU0VSIFBDSSBSRUFEOiByZXQ9MCwgYnVzPTAxIGRldj0wMCBmdW5j
PTAgcG9zPTB4YTQgbGVuPTQgZGF0YT0weDAKWzI2MDQyNy43NDE2MDddIFVTRVIgUENJIFJFQUQ6
IHJldD0wLCBidXM9MDEgZGV2PTAwIGZ1bmM9MCBwb3M9MHhhOCBsZW49NCBkYXRhPTB4MApbMjYw
NDI3Ljc0MTYxM10gVVNFUiBQQ0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBv
cz0weGFjIGxlbj00IGRhdGE9MHgwClsyNjA0MjcuNzQxNjIwXSBVU0VSIFBDSSBSRUFEOiByZXQ9
MCwgYnVzPTAxIGRldj0wMCBmdW5jPTAgcG9zPTB4YjAgbGVuPTQgZGF0YT0weDAKWzI2MDQyNy43
NDE2MjZdIFVTRVIgUENJIFJFQUQ6IHJldD0wLCBidXM9MDEgZGV2PTAwIGZ1bmM9MCBwb3M9MHhi
NCBsZW49NCBkYXRhPTB4MApbMjYwNDI3Ljc0MTYzM10gVVNFUiBQQ0kgUkVBRDogcmV0PTAsIGJ1
cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0weGI4IGxlbj00IGRhdGE9MHgwClsyNjA0MjcuNzQxNjQw
XSBVU0VSIFBDSSBSRUFEOiByZXQ9MCwgYnVzPTAxIGRldj0wMCBmdW5jPTAgcG9zPTB4YmMgbGVu
PTQgZGF0YT0weDAKWzI2MDQyNy43NDE2NDZdIFVTRVIgUENJIFJFQUQ6IHJldD0wLCBidXM9MDEg
ZGV2PTAwIGZ1bmM9MCBwb3M9MHhjMCBsZW49NCBkYXRhPTB4MApbMjYwNDI3Ljc0MTY1M10gVVNF
UiBQQ0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0weGM0IGxlbj00IGRh
dGE9MHgwClsyNjA0MjcuNzQxNjU5XSBVU0VSIFBDSSBSRUFEOiByZXQ9MCwgYnVzPTAxIGRldj0w
MCBmdW5jPTAgcG9zPTB4YzggbGVuPTQgZGF0YT0weDAKWzI2MDQyNy43NDE2NjZdIFVTRVIgUENJ
IFJFQUQ6IHJldD0wLCBidXM9MDEgZGV2PTAwIGZ1bmM9MCBwb3M9MHhjYyBsZW49NCBkYXRhPTB4
MApbMjYwNDI3Ljc0MTY3Ml0gVVNFUiBQQ0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9MDAgZnVu
Yz0wIHBvcz0weGQwIGxlbj00IGRhdGE9MHgwClsyNjA0MjcuNzQxNjc5XSBVU0VSIFBDSSBSRUFE
OiByZXQ9MCwgYnVzPTAxIGRldj0wMCBmdW5jPTAgcG9zPTB4ZDQgbGVuPTQgZGF0YT0weDAKWzI2
MDQyNy43NDE2ODVdIFVTRVIgUENJIFJFQUQ6IHJldD0wLCBidXM9MDEgZGV2PTAwIGZ1bmM9MCBw
b3M9MHhkOCBsZW49NCBkYXRhPTB4MApbMjYwNDI3Ljc0MTY5Ml0gVVNFUiBQQ0kgUkVBRDogcmV0
PTAsIGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0weGRjIGxlbj00IGRhdGE9MHgwClsyNjA0Mjcu
NzQxNjk4XSBVU0VSIFBDSSBSRUFEOiByZXQ9MCwgYnVzPTAxIGRldj0wMCBmdW5jPTAgcG9zPTB4
ZTAgbGVuPTQgZGF0YT0weDAKWzI2MDQyNy43NDE3MDVdIFVTRVIgUENJIFJFQUQ6IHJldD0wLCBi
dXM9MDEgZGV2PTAwIGZ1bmM9MCBwb3M9MHhlNCBsZW49NCBkYXRhPTB4MApbMjYwNDI3Ljc0MTcx
MV0gVVNFUiBQQ0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9MDAgZnVuYz0wIHBvcz0weGU4IGxl
bj00IGRhdGE9MHgwClsyNjA0MjcuNzQxNzE4XSBVU0VSIFBDSSBSRUFEOiByZXQ9MCwgYnVzPTAx
IGRldj0wMCBmdW5jPTAgcG9zPTB4ZWMgbGVuPTQgZGF0YT0weDAKWzI2MDQyNy43NDE3MjRdIFVT
RVIgUENJIFJFQUQ6IHJldD0wLCBidXM9MDEgZGV2PTAwIGZ1bmM9MCBwb3M9MHhmMCBsZW49NCBk
YXRhPTB4MApbMjYwNDI3Ljc0MTczMV0gVVNFUiBQQ0kgUkVBRDogcmV0PTAsIGJ1cz0wMSBkZXY9
MDAgZnVuYz0wIHBvcz0weGY0IGxlbj00IGRhdGE9MHgwClsyNjA0MjcuNzQxNzM3XSBVU0VSIFBD
SSBSRUFEOiByZXQ9MCwgYnVzPTAxIGRldj0wMCBmdW5jPTAgcG9zPTB4ZjggbGVuPTQgZGF0YT0w
eDAKWzI2MDQyNy43NDE3NDRdIFVTRVIgUENJIFJFQUQ6IHJldD0wLCBidXM9MDEgZGV2PTAwIGZ1
bmM9MCBwb3M9MHhmYyBsZW49NCBkYXRhPTB4MAoK
--0000000000003f4e67062ffb336d
Content-Type: application/octet-stream; 
	name="0003-added-early_dump_pci_device-through-the-acpiphp-path.patch"
Content-Disposition: attachment; 
	filename="0003-added-early_dump_pci_device-through-the-acpiphp-path.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m82z1c2g1>
X-Attachment-Id: f_m82z1c2g1

RnJvbSA5ZTdkMzIzNTY1YmYyODZhZDM0Njc5ODI3NzlhZmIyZDg0NmI3ODg1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOYXZlZW4gS3VtYXIgUGFybmEgPG5hdmVlbmt1bWFyLnBhcm5h
QGdtYWlsLmNvbT4KRGF0ZTogV2VkLCA1IE1hciAyMDI1IDE1OjE5OjQxICswNTMwClN1YmplY3Q6
IFtQQVRDSCAzLzNdIGFkZGVkIGVhcmx5X2R1bXBfcGNpX2RldmljZSgpIHRocm91Z2ggdGhlIGFj
cGlwaHAgcGF0aAoKLS0tCiBkcml2ZXJzL3BjaS9hY2Nlc3MuYyAgICAgICAgICAgICAgIHwgMjQg
KysrKysrKysrKysrKysrKysrKysrKy0tCiBkcml2ZXJzL3BjaS9ob3RwbHVnL2FjcGlwaHBfZ2x1
ZS5jIHwgMTUgKysrKysrKysrKysrKystCiBkcml2ZXJzL3BjaS9wcm9iZS5jICAgICAgICAgICAg
ICAgIHwgIDIgKy0KIGluY2x1ZGUvbGludXgvcGNpLmggICAgICAgICAgICAgICAgfCAgMiArKwog
NCBmaWxlcyBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcGNpL2FjY2Vzcy5jIGIvZHJpdmVycy9wY2kvYWNjZXNzLmMKaW5kZXgg
OTlkNDdkODRmLi42YWExZDY4YmMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGNpL2FjY2Vzcy5jCisr
KyBiL2RyaXZlcnMvcGNpL2FjY2Vzcy5jCkBAIC01MiwxMCArNTIsMTIgQEAgaW50IG5vaW5saW5l
IHBjaV9idXNfcmVhZF9jb25maWdfIyNzaXplIFwKIAlwY2lfdW5sb2NrX2NvbmZpZyhmbGFncyk7
CQkJCQlcCiAJCQkJCQkJCQlcCiAJLyogTG9nIGFsbCByZWFkcyBmb3IgZGV2aWNlIDAxOjAwLjAg
Ki8JCQkJCQkJCVwKKwkvKgogCWlmIChidXMtPm51bWJlciA9PSAxICYmIFBDSV9TTE9UKGRldmZu
KSA9PSAwICYmIFBDSV9GVU5DKGRldmZuKSA9PSAwKSB7CQkJCVwKLQkJcHJfaW5mbygiUENJIFJF
QUQ6IHJlcz0lZCwgYnVzPSUwMnggZGV2PSUwMnggZnVuYz0leCBwb3M9MHglMDJ4IGxlbj0lZCBk
YXRhPTB4JXhcbiIsCVwKKwkJcHJfaW5mbygiS0VSTkVMIFBDSSBSRUFEOiByZXM9JWQsIGJ1cz0l
MDJ4IGRldj0lMDJ4IGZ1bmM9JXggcG9zPTB4JTAyeCBsZW49JWQgZGF0YT0weCV4XG4iLAlcCiAJ
CQlyZXMsIGJ1cy0+bnVtYmVyLCBQQ0lfU0xPVChkZXZmbiksIFBDSV9GVU5DKGRldmZuKSwgcG9z
LCBsZW4sIGRhdGEpOwkJXAogCX0JCQkJCQkJCQkJCQlcCisJKi8KIAkJCQkJCQkJCVwKIAlyZXR1
cm4gcmVzOwkJCQkJCQlcCiB9CkBAIC03NSwxMCArNzcsMTIgQEAgaW50IG5vaW5saW5lIHBjaV9i
dXNfd3JpdGVfY29uZmlnXyMjc2l6ZSBcCiAJcGNpX3VubG9ja19jb25maWcoZmxhZ3MpOwkJCQkJ
XAogCQkJCQkJCQkJXAogCS8qIExvZyBhbGwgd3JpdGVzIGZvciBkZXZpY2UgMDE6MDAuMCAqLwkJ
CQkJCQkJXAorCS8qCiAJaWYgKGJ1cy0+bnVtYmVyID09IDEgJiYgUENJX1NMT1QoZGV2Zm4pID09
IDAgJiYgUENJX0ZVTkMoZGV2Zm4pID09IDApIHsJCQkJXAotCQlwcl9pbmZvKCJQQ0kgV1JJVEU6
IHJlcz0lZCwgYnVzPSUwMnggZGV2PSUwMnggZnVuYz0leCBwb3M9MHglMDJ4IGxlbj0lZCB2YWx1
ZT0weCV4XG4iLAlcCisJCXByX2luZm8oIktFUk5FTCBQQ0kgV1JJVEU6IHJlcz0lZCwgYnVzPSUw
MnggZGV2PSUwMnggZnVuYz0leCBwb3M9MHglMDJ4IGxlbj0lZCB2YWx1ZT0weCV4XG4iLAlcCiAJ
CQlyZXMsIGJ1cy0+bnVtYmVyLCBQQ0lfU0xPVChkZXZmbiksIFBDSV9GVU5DKGRldmZuKSwgcG9z
LCBsZW4sIHZhbHVlKTsJCVwKIAl9CQkJCQkJCQkJCQkJXAorCSovCiAJCQkJCQkJCQlcCiAJcmV0
dXJuIHJlczsJCQkJCQkJXAogfQpAQCAtMjU3LDYgKzI2MSwxNCBAQCBpbnQgcGNpX3VzZXJfcmVh
ZF9jb25maWdfIyNzaXplCQkJCQkJXAogCWVsc2UJCQkJCQkJCVwKIAkJKnZhbCA9ICh0eXBlKWRh
dGE7CQkJCQlcCiAJCQkJCQkJCQlcCisgICAgICAgIC8qIExvZyBhbGwgdXNlci1zcGFjZSByZWFk
cyBmb3IgZGV2aWNlIDAxOjAwLjAgKi8gICAgICAgICAgICAgICBcCisgICAgICAgIGlmIChkZXYt
PmJ1cy0+bnVtYmVyID09IDEgJiYgUENJX1NMT1QoZGV2LT5kZXZmbikgPT0gMCAmJiAgICAgICBc
CisgICAgICAgICAgICBQQ0lfRlVOQyhkZXYtPmRldmZuKSA9PSAwKSB7ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBcCisgICAgICAgICAgICAgICAgcHJfaW5mbygiVVNFUiBQQ0kgUkVB
RDogcmV0PSVkLCBidXM9JTAyeCBkZXY9JTAyeCBmdW5jPSV4IHBvcz0weCUwMnggbGVuPSVkIGRh
dGE9MHgleFxuIiwgIFwKKyAgICAgICAgICAgICAgICAgICAgICAgIHJldCwgZGV2LT5idXMtPm51
bWJlciwgUENJX1NMT1QoZGV2LT5kZXZmbiksICAgIFwKKyAgICAgICAgICAgICAgICAgICAgICAg
IFBDSV9GVU5DKGRldi0+ZGV2Zm4pLCBwb3MsIHNpemVvZih0eXBlKSwgZGF0YSk7IFwKKyAgICAg
ICAgfSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKIAlyZXR1cm4gcGNpYmlvc19lcnJfdG9fZXJy
bm8ocmV0KTsJCQkJXAogfQkJCQkJCQkJCVwKIEVYUE9SVF9TWU1CT0xfR1BMKHBjaV91c2VyX3Jl
YWRfY29uZmlnXyMjc2l6ZSk7CkBAIC0yNzgsNiArMjkwLDE0IEBAIGludCBwY2lfdXNlcl93cml0
ZV9jb25maWdfIyNzaXplCQkJCQlcCiAJCQkJICAgcG9zLCBzaXplb2YodHlwZSksIHZhbCk7CQlc
CiAJcmF3X3NwaW5fdW5sb2NrX2lycSgmcGNpX2xvY2spOwkJCQkJXAogCQkJCQkJCQkJXAorICAg
ICAgICAvKiBMb2cgYWxsIHVzZXItc3BhY2Ugd3JpdGVzIGZvciBkZXZpY2UgMDE6MDAuMCAqLyAg
ICAgICAgICAgICAgXAorICAgICAgICBpZiAoZGV2LT5idXMtPm51bWJlciA9PSAxICYmIFBDSV9T
TE9UKGRldi0+ZGV2Zm4pID09IDAgJiYgICAgICAgXAorICAgICAgICAgICAgUENJX0ZVTkMoZGV2
LT5kZXZmbikgPT0gMCkgeyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAorICAgICAg
ICAgICAgICAgIHByX2luZm8oIlVTRVIgUENJIFdSSVRFOiByZXQ9JWQsIGJ1cz0lMDJ4IGRldj0l
MDJ4IGZ1bmM9JXggcG9zPTB4JTAyeCBsZW49JWQgdmFsdWU9MHgleFxuIiwgIFwKKyAgICAgICAg
ICAgICAgICAgICAgICAgIHJldCwgZGV2LT5idXMtPm51bWJlciwgUENJX1NMT1QoZGV2LT5kZXZm
biksICAgIFwKKyAgICAgICAgICAgICAgICAgICAgICAgIFBDSV9GVU5DKGRldi0+ZGV2Zm4pLCBw
b3MsIHNpemVvZih0eXBlKSwgdmFsKTsgIFwKKyAgICAgICAgfSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFwKIAlyZXR1cm4gcGNpYmlvc19lcnJfdG9fZXJybm8ocmV0KTsJCQkJXAogfQkJCQkJCQkJ
CVwKIEVYUE9SVF9TWU1CT0xfR1BMKHBjaV91c2VyX3dyaXRlX2NvbmZpZ18jI3NpemUpOwpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9wY2kvaG90cGx1Zy9hY3BpcGhwX2dsdWUuYyBiL2RyaXZlcnMvcGNp
L2hvdHBsdWcvYWNwaXBocF9nbHVlLmMKaW5kZXggYjZhNTdmMTAxLi5lOTE4ZjY5NjMgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvcGNpL2hvdHBsdWcvYWNwaXBocF9nbHVlLmMKKysrIGIvZHJpdmVycy9w
Y2kvaG90cGx1Zy9hY3BpcGhwX2dsdWUuYwpAQCAtNzIxLDE3ICs3MjEsMjYgQEAgc3RhdGljIHZv
aWQgYWNwaXBocF9jaGVja19icmlkZ2Uoc3RydWN0IGFjcGlwaHBfYnJpZGdlICpicmlkZ2UpCiAJ
CQkJaWYgKFBDSV9TTE9UKGRldi0+ZGV2Zm4pID09IHNsb3QtPmRldmljZSkKIAkJCQkJdHJpbV9z
dGFsZV9kZXZpY2VzKGRldik7CiAKKwkJCWFjcGlfaGFuZGxlX2RlYnVnKGhhbmRsZSwgImNhbGxp
bmcgZWFybHlfZHVtcF9wY2lfZGV2aWNlKCkgYmVmb3JlIGVuYWJsZV9zbG90KCkgaW4gJXMoKVxu
IiwgX19mdW5jX18pOworCQkJZWFybHlfZHVtcF9wY2lfZGV2aWNlKGJyaWRnZS0+cGNpX2Rldik7
CiAJCQkvKiBjb25maWd1cmUgYWxsIGZ1bmN0aW9ucyAqLwogICAgICAgICAgICAgICAgICAgICAg
ICAgYWNwaV9oYW5kbGVfZGVidWcoaGFuZGxlLCAiRW5hYmxpbmcgc2xvdCBpbiAlcygpXG4iLCBf
X2Z1bmNfXyk7CiAJCQllbmFibGVfc2xvdChzbG90LCB0cnVlKTsKKwkJCWFjcGlfaGFuZGxlX2Rl
YnVnKGhhbmRsZSwgImNhbGxpbmcgZWFybHlfZHVtcF9wY2lfZGV2aWNlKCkgYWZ0ZXIgZW5hYmxl
X3Nsb3QoKSBpbiAlcygpXG4iLCBfX2Z1bmNfXyk7CisJCQllYXJseV9kdW1wX3BjaV9kZXZpY2Uo
YnJpZGdlLT5wY2lfZGV2KTsKIAkJfSBlbHNlIHsKICAgICAgICAgICAgICAgICAgICAgICAgIGFj
cGlfaGFuZGxlX2RlYnVnKGhhbmRsZSwgIlNsb3QgaGFzIGFuIGludmFsaWQgZGV2aWNlIHN0YXR1
cywgZGlzYWJsaW5nIGluICVzKClcbiIsIF9fZnVuY19fKTsKIAkJCWRpc2FibGVfc2xvdChzbG90
KTsKKwkJCWFjcGlfaGFuZGxlX2RlYnVnKGhhbmRsZSwgImNhbGxpbmcgZWFybHlfZHVtcF9wY2lf
ZGV2aWNlKCkgYWZ0ZXIgZGlzYWJsZV9zbG90KCkgaW4gJXMoKVxuIiwgX19mdW5jX18pOworCQkJ
ZWFybHlfZHVtcF9wY2lfZGV2aWNlKGJyaWRnZS0+cGNpX2Rldik7CiAJCX0KIAl9CiAKLQlpZiAo
YnJpZGdlLT5wY2lfZGV2KQorCWlmIChicmlkZ2UtPnBjaV9kZXYpIHsKIAkJcG1fcnVudGltZV9w
dXQoJmJyaWRnZS0+cGNpX2Rldi0+ZGV2KTsKKwkJYWNwaV9oYW5kbGVfZGVidWcoaGFuZGxlLCAi
Y2FsbGluZyBlYXJseV9kdW1wX3BjaV9kZXZpY2UoKSBhZnRlciBwbV9ydW50aW1lX3B1dCgpIGlu
ICVzKClcbiIsIF9fZnVuY19fKTsKKwkJZWFybHlfZHVtcF9wY2lfZGV2aWNlKGJyaWRnZS0+cGNp
X2Rldik7CisJfQogfQogCiAvKgpAQCAtODQ1LDggKzg1NCwxMiBAQCBzdGF0aWMgdm9pZCBob3Rw
bHVnX2V2ZW50KHUzMiB0eXBlLCBzdHJ1Y3QgYWNwaXBocF9jb250ZXh0ICpjb250ZXh0KQogCiAJ
cGNpX3VubG9ja19yZXNjYW5fcmVtb3ZlKCk7CiAJaWYgKGJyaWRnZSkgeworCQlhY3BpX2hhbmRs
ZV9kZWJ1ZyhoYW5kbGUsICJjYWxsaW5nIGVhcmx5X2R1bXBfcGNpX2RldmljZSgpIGJlZm9yZSBw
dXRfYnJpZGdlKCkgaW4gJXMoKVxuIiwgX19mdW5jX18pOworCQllYXJseV9kdW1wX3BjaV9kZXZp
Y2UoYnJpZGdlLT5wY2lfZGV2KTsKIAkJYWNwaV9oYW5kbGVfZGVidWcoaGFuZGxlLCAiUmVsZWFz
aW5nIGJyaWRnZSBpbiAlcygpXG4iLCBfX2Z1bmNfXyk7CiAJCXB1dF9icmlkZ2UoYnJpZGdlKTsK
KwkJYWNwaV9oYW5kbGVfZGVidWcoaGFuZGxlLCAiY2FsbGluZyBlYXJseV9kdW1wX3BjaV9kZXZp
Y2UoKSBhZnRlciBwdXRfYnJpZGdlKCkgaW4gJXMoKVxuIiwgX19mdW5jX18pOworCQllYXJseV9k
dW1wX3BjaV9kZXZpY2UoYnJpZGdlLT5wY2lfZGV2KTsKIAl9CiB9CiAKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcGNpL3Byb2JlLmMgYi9kcml2ZXJzL3BjaS9wcm9iZS5jCmluZGV4IDJlODFhYjBmNS4u
YTQ4M2Q3YzdhIDEwMDY0NAotLS0gYS9kcml2ZXJzL3BjaS9wcm9iZS5jCisrKyBiL2RyaXZlcnMv
cGNpL3Byb2JlLmMKQEAgLTE4NTIsNyArMTg1Miw3IEBAIHN0YXRpYyBpbnQgcGNpX2ludHhfbWFz
a19icm9rZW4oc3RydWN0IHBjaV9kZXYgKmRldikKIAlyZXR1cm4gMDsKIH0KIAotc3RhdGljIHZv
aWQgZWFybHlfZHVtcF9wY2lfZGV2aWNlKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQordm9pZCBlYXJs
eV9kdW1wX3BjaV9kZXZpY2Uoc3RydWN0IHBjaV9kZXYgKnBkZXYpCiB7CiAJdTMyIHZhbHVlWzI1
NiAvIDRdOwogCWludCBpOwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9wY2kuaCBiL2luY2x1
ZGUvbGludXgvcGNpLmgKaW5kZXggZGI5YjQ3Y2UzLi5kZTRhY2U3MTQgMTAwNjQ0Ci0tLSBhL2lu
Y2x1ZGUvbGludXgvcGNpLmgKKysrIGIvaW5jbHVkZS9saW51eC9wY2kuaApAQCAtMjcxMiw0ICsy
NzEyLDYgQEAgdm9pZCBwY2lfdWV2ZW50X2VycyhzdHJ1Y3QgcGNpX2RldiAqcGRldiwgZW51bSAg
cGNpX2Vyc19yZXN1bHQgZXJyX3R5cGUpOwogCVdBUk5fT05DRShjb25kaXRpb24sICIlcyAlczog
IiBmbXQsIFwKIAkJICBkZXZfZHJpdmVyX3N0cmluZygmKHBkZXYpLT5kZXYpLCBwY2lfbmFtZShw
ZGV2KSwgIyNhcmcpCiAKK3ZvaWQgZWFybHlfZHVtcF9wY2lfZGV2aWNlKHN0cnVjdCBwY2lfZGV2
ICpwZGV2KTsKKwogI2VuZGlmIC8qIExJTlVYX1BDSV9IICovCi0tIAoyLjI1LjEKCg==
--0000000000003f4e67062ffb336d--

