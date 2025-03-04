Return-Path: <linux-pci+bounces-22915-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E952A4F0A8
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 23:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E17797A59A7
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 22:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBF71FCFDA;
	Tue,  4 Mar 2025 22:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnAdYKiC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53031F03D7;
	Tue,  4 Mar 2025 22:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741128273; cv=none; b=QkbipCwKl4osvTEeZMkhh134B8mB+bkvHwZGgDRQf5d4OPTK87BiuuoS64LLgmpDBpWMOMRvFXE83Chrsdefsxfp976cyVeYbq/7vRpLB45u8Xexv6QnP3YQwrvSh7+HlF433KdZ49lZLWWrOeYrdLEMrk/VIujasYG7pWxyBdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741128273; c=relaxed/simple;
	bh=F/9DH7uWGDO/HD/KbWKguA1zAwHyMxUry8XIOH1EtlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kzRs9neE09phAagH8gV0+tzQKeiNtq9Uoxh857FGTQv+3aNqK9taumIUqlU86SleDAyOFj7HhouxenS7aU7LHoi+gFkzeT4CRuaEwIcgudL+K/ruRpW5UbFHyYHCYoIToYukohOPcUYforpC7/ABEV3Gmi77osbgCOQa94dE4i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QnAdYKiC; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5495c1e1b63so3907097e87.0;
        Tue, 04 Mar 2025 14:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741128270; x=1741733070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjfzsJXjEdHdDLn8saPwRokeD+P/o6e7bsxOBSgDpI0=;
        b=QnAdYKiClm4KYQKp4u16Ohjfn5G8TnXfnb60CaDaQPpWokE2UmtQH4s3f7CEw/G92C
         MnWdbeA/HTmtyCfrh/Lb0yKant/IrKcl041Pg2f0WGMvaY00OH+OQGCR2hgtccOh20zm
         fySRxzBWX2k4WTppilUkW2lJONJ1wrEnTrzU6KwktYJ/Ks3InOU/OUKWvX3Sngj4eigq
         j5kF+31iRA9SpYP07RinQZk+YvV9kJ9hI/PxySWIr7oAVM/TpkFug/DTjLokDYqx4vms
         o0R0KJY62a/CtBL6bcbXBAq0CN7XE7kGcnF493ZCU7JJn4drusuacgln0VuaiPfTZj2/
         zOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741128270; x=1741733070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QjfzsJXjEdHdDLn8saPwRokeD+P/o6e7bsxOBSgDpI0=;
        b=cwOCSWV7pTkqx1bQNu+JiBWfOJBEYRcw9K6ntETjHJbCWogAQHjvUuW3QdcmjfPM2h
         cTVzEQNr1tuJXlLW3N5OYgqt82Dfx6Oeyu2RjQBhMg0YnWbXLFJ46kcehTs4fONXCLRs
         uYuDzMdDFnMulUD2It7dCFvPbHiUhZLAHxFtLAoLPpE/kFF8SrS8mUMUGnU9SWbe1szS
         MpWu0974DPj6FWlHXtQqSHmC4BIaGQ3Y/xgT8lxqlhcyXh0syMHI9kp4vkGG2Uz9Xx4A
         HhHeLIJT3SIX+VLr41gylLkbVpOSTOiqAiJQ30a8CHlgv3p9MfkZ0BKu4U7WdDVu5YU+
         uzWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwHCZTS2DQQVZM5W+GQjHBxvMmv1IIahADulQ7SSqcQHUu/R0CAvFSBKFKeWIxYnTaqYjplVl6fppRqLcG@vger.kernel.org, AJvYcCW/rAgFK2U+QQhyh424la/X8M1PnxOOyouiT0uSW97jOI6ELueNUEIzSQef2rF7fijiHV8r3wz4nuhf@vger.kernel.org
X-Gm-Message-State: AOJu0YzLyQU3vqsY+0S2vW3Ibs9BIw0Rg417GSCiNqcfqqj5NzTdO8Wn
	5QyM1bbMSnQTn5uARZAknwkuEBeUx3hD2CXSgct5SgMR6RmgBakRCo7vHqxf2QgqKt+3aMZzIBE
	hefC+tRnWv6+o/kelV1FQx1HE4YXa4+Kp2g==
X-Gm-Gg: ASbGncvR9JxlzkHfFKx8PPjS2WtnUl5EN7QOcAln5AwcHszzrSG28kTYbj6OlTJaNtF
	0WyJe0Gsh+jf23L0h3bZLkqmDts3Id+pejxD+MTx5337VoQyDvZNwvQaOWmO0CXjeyNpjIH7Os0
	zIJLbO1DnE+KNSCoJK6UM61RGycQ==
X-Google-Smtp-Source: AGHT+IHUIS6zDuZG3/UeO1cLf5IoD3svMz+rUjmC3iMtkkhPFukzgU/LaiL8rhgiwaNCfjhTy4fGHVDUEkxKbE4RXy0=
X-Received: by 2002:a05:6512:ba3:b0:549:38eb:d694 with SMTP id
 2adb3069b0e04-5497d3460d1mr273537e87.26.1741128269531; Tue, 04 Mar 2025
 14:44:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMciSVVhdRjfVYZGg+0Yo6EV4P80No3kLxCL8+LyVjwywiWxYg@mail.gmail.com>
 <20250304210122.GA257363@bhelgaas>
In-Reply-To: <20250304210122.GA257363@bhelgaas>
From: Naveen Kumar P <naveenkumar.parna@gmail.com>
Date: Wed, 5 Mar 2025 04:14:17 +0530
X-Gm-Features: AQ5f1Jpv3qLmys9v8RVQC1CrHVftrM-7QS581zgloj5wh5uQLSAL9xQEj5AxASA
Message-ID: <CAMciSVWfLVRQB4afDe=6e=n_j7+4DX-tvDpeEx6QUkvBym+7GQ@mail.gmail.com>
Subject: Re: PCI: hotplug_event: PCIe PLDA Device BAR Reset
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernelnewbies <kernelnewbies@kernelnewbies.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 2:31=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Tue, Mar 04, 2025 at 10:19:07PM +0530, Naveen Kumar P wrote:
> > On Tue, Mar 4, 2025 at 1:35=E2=80=AFPM Naveen Kumar P
> > <naveenkumar.parna@gmail.com> wrote:
> > ...
>
> > For this test run, I removed all three parameters (pcie_aspm=3Doff,
> > pci=3Dnomsi, and pcie_ports=3Don) and booted with the following kernel
> > command line arguments:
> >
> > cat /proc/cmdline
> > BOOT_IMAGE=3D/vmlinuz-6.13.0+ root=3D/dev/mapper/vg00-rootvol ro quiet
> > "dyndbg=3Dfile drivers/pci/* +p; file drivers/acpi/bus.c +p; file
> > drivers/acpi/osl.c +p"
> >
> > This time, the issue occurred earlier, at 22998 seconds. Below is the
> > relevant dmesg log during the ACPI_NOTIFY_BUS_CHECK event. The
> > complete log is attached (dmesg_march4th_log.txt).
> >
> > [22998.536705] ACPI: \_SB_.PCI0.RP01: ACPI: ACPI_NOTIFY_BUS_CHECK event
> > [22998.536753] ACPI: \_SB_.PCI0.RP01: ACPI: OSL: Scheduling hotplug
> > event 0 for deferred handling
> > [22998.536934] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bridge acquired in
> > hotplug_event()
> > [22998.536972] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bus check in hotplu=
g_event()
> > [22998.537002] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Checking bridge in
> > hotplug_event()
> > [22998.537024] PCI READ: res=3D0, bus=3D01 dev=3D00 func=3D0 pos=3D0x00=
 len=3D4
> > data=3D0x55551556
> > [22998.537066] PCI READ: res=3D0, bus=3D01 dev=3D00 func=3D0 pos=3D0x00=
 len=3D4
> > data=3D0x55551556
>
> Fine again.
>
> > [22998.537094] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Enabling slot in
> > acpiphp_check_bridge()
> > [22998.537155] ACPI: Device [PXSX] status [0000000f]
> > [22998.537206] ACPI: Device [D015] status [0000000f]
> > [22998.537276] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Releasing bridge
> > in hotplug_event()
> >
> > sudo lspci -xxx -s 01:00.0 | grep 10:
> > 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
> Obviously a problem.  Can you start including the whole
> "lspci -x -s 01:00.0" output?  Obviously the Vendor ID reads above
> worked fine.  I *assume* it's still fine here, and only the BARs are
> zeroed out?
I've captured the complete lspci output from the last run, and it is as fol=
lows:

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

I've also observed some inconsistencies in the behavior. In previous
runs, the first invocation of lspci showed all FF's, and then the next
run resulted in a PCI BAR reset, as mentioned below.

Previous runs - first invocation of lspci output :
--------------------------------------------------
$sudo lspci -xxx -s 01:00.0
01:00.0 RAM memory: PLDA Device 5555 (rev ff)
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

Previous runs - second invocation of lspci output :
--------------------------------------------------
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

However this time, the first run didn't show all FF's but instead
directly resulted in a PCI BAR reset.


>
> I assume you saw no new dmesg logs about config accesses to the device
> before the lspci.  If you instrumented the user config accessors
> (pci_user_read_config_*(), also in access.c), you should see those
> accesses.
i will try this and update you with the results soon.
>
> You could sprinkle some calls to early_dump_pci_device() through the
> acpiphp path.  Turn off the kernel config access tracing when you do
> this so it doesn't clutter things up.
>
> What is this device?  Is it a shipping product?  Do you have good
The PCIe device in question is a Xilinx FPGA endpoint, which is
flashed with RTL code to expose several host interfaces to the system
via the PCIe link.

> confidence that the hardware is working correctly?  I guess you said
> it works correctly on a different machine with an older kernel.  I
> would swap the cards between machines in case one card is broken.
>
> You could try bisecting between the working kernel and the broken one.
> It's kind of painful since it takes so long to reproduce the problem.
>
> Bjorn

