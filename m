Return-Path: <linux-pci+bounces-23455-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E444FA5CD21
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 19:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818A9189CAC0
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 18:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55772627E8;
	Tue, 11 Mar 2025 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xg4xb2F8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7635E25C6F5;
	Tue, 11 Mar 2025 18:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741716294; cv=none; b=XDxCnd9ZjW2e0xhxFv0VFx7pIhT1UkHgI3oAjcJF7PpzdzGdCiCc2kjenh6zKvhPofoWNaZSk8rERYfibG5T+riKisHIjnH8yrwyp123OhBbPnegmY0fNct86WgbM/FwjX6N9oF8bsjieAK2nNABlY9CA0k4zHmqHS1cq8WbNaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741716294; c=relaxed/simple;
	bh=ao9VVErmusKlUeF8bmkvKCYwmVUhLwKDH37LFnvWUrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G0JxCyzY9AJBWFEVxEQ8iM6DAl4l/AV+BSvtPEognfzWosNxBzK/9Uq3vgLnT3WJ1Lk5naYdxP0vJLnswTSU/YwOom5IrXSTFc0bjussOOyAlZemMHC+v8/9MDbADxkHl5quTA/vcG4/y7/vAzayDp8omHdxvTvvBF6ajWIvkso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xg4xb2F8; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30bee1cb370so51304281fa.1;
        Tue, 11 Mar 2025 11:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741716290; x=1742321090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wQjQuBzff93gVoR0Iaggg/NXUQBflDGee7LBdPCxx0=;
        b=Xg4xb2F80xIUpmHZqF+w7ieuhyPPBdmZQTKZqEToBhn7dWkn9IGTz79L2rxYVAZ5cy
         VF/8mTs5HWcq4sFiI40/f0GvybHk6wkIL2R8959pOEPWnI5hcxBWmhRCZ+Cb+FYEsRLL
         XJqz9iOqyfcSsqcDCC9Ut85QoNU4RbnHO2dI4LwaHfTV/jpQe2vlN0WuuihuKpPfyJU8
         3q9vkpoEHPYUdq0emOXdORjwbhq02/55kI2AYkb3O4S64kynCQ7XfFw/IhKea2mpVykr
         uj+hgXyzuXbGKNZQPPfxdUcB+U6lO+nBRi01RLJfCTjG2YPl2YNthRwYy1Wwtebdauol
         5WPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741716290; x=1742321090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5wQjQuBzff93gVoR0Iaggg/NXUQBflDGee7LBdPCxx0=;
        b=JbU/aqKEe84bhovGrzvtMGaGIMMdhvNOs0jmLPZ5lsAeNQAGMtoJBv9X+q8/1tLYbf
         rzRBf6W18Zfmw/H5AyrV4Om+GgeZ0kHgAqSZcXThaSxwf+BYKfXzfbpwF/Xv/9PR5upL
         Wm61xT6BD6T4LTjZO6sZJ0S/HO19rWnigHn4q2YNKoMZaMxrUMnBAphW1FG0BFA4hFPH
         oawe1oYqZCezSRoPpBQUVWc2z5KuOsMCRQcU8TJZv4ofRbY7iUzwZaWr6E0eJfxE3cA7
         wVaY66ATopxDv/gpsrhR+Ga57aAu+1DimMnNFrUe3uV2MG7pZir93lU37BEZ/r6XrZfo
         RLsA==
X-Forwarded-Encrypted: i=1; AJvYcCVUAUfN0Y1ytzKcS9asn6MeU8GTDt/USraMWdgl7SEOdbaBNoDitHPYG+p3FUTUYLQwzOV2VlcVTutg8IqD@vger.kernel.org, AJvYcCVxpy7V3A1Uu6KRQJUXApHcw/suSp4v//2MJNMbRrlxQa6B9MTOBAO9Sw4FsrbHP9CYzwMwlQxbGsiP@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3qtMcHRiX+d7BfvVRgxmpMzN0JtYxk5hFDLLBjFBHnETR5BFO
	aI7flyVFzLyDmqDGvSwIeVv7o1wo9pzMmhu8qVpAxn/SUdp64Un6w5KEBPa7Npw0ZEM4ooajWGh
	bgtloij4mVbRnl44wi43I29Wx3+Df124=
X-Gm-Gg: ASbGncs6LFsKI4kqEUwhqt0/Zzd9L7Xn4+KEsnEKzfUqjgbX/zfgEd5Yv/DjwaUP8KW
	/AYbnZCED5c1bsOdh/caFyw87wAcBZU4w4pK68Mk1qVcUPE7d2zmDGByihwz3fVPhpPdDME+VvG
	sfxAAX60adpUz+PzS5p8vHe0W5BmIX0rGjzTx0gw==
X-Google-Smtp-Source: AGHT+IEi5jUAAcLUFHPY3yZ6wV0kfSPnCT8ep0wLet6hjL9UfE/hD97kp5RxyIBSGO497V3td12HJXBDuwFhwSQH1fo=
X-Received: by 2002:a2e:b013:0:b0:30c:7a7:e85a with SMTP id
 38308e7fff4ca-30c07a7e91emr35525891fa.21.1741716290023; Tue, 11 Mar 2025
 11:04:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMciSVVhdRjfVYZGg+0Yo6EV4P80No3kLxCL8+LyVjwywiWxYg@mail.gmail.com>
 <20250304210122.GA257363@bhelgaas> <CAMciSVWfLVRQB4afDe=6e=n_j7+4DX-tvDpeEx6QUkvBym+7GQ@mail.gmail.com>
 <CAMciSVV317JUzxoL1yO_rC_=p8hJUsfBK5UpxDFYNjjaw0ePcQ@mail.gmail.com>
In-Reply-To: <CAMciSVV317JUzxoL1yO_rC_=p8hJUsfBK5UpxDFYNjjaw0ePcQ@mail.gmail.com>
From: Naveen Kumar P <naveenkumar.parna@gmail.com>
Date: Tue, 11 Mar 2025 23:34:37 +0530
X-Gm-Features: AQ5f1Jpekz5x6phJmHnvWi4LI9FmO-VTXqj96G1U2EQifqJ6aOcu7Iym8Pqotc0
Message-ID: <CAMciSVV6Sk3Hs0oeS5FtB8jMCoet5FZ-R6T=XmQ4=BN=LR4xHA@mail.gmail.com>
Subject: Re: PCI: hotplug_event: PCIe PLDA Device BAR Reset
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernelnewbies <kernelnewbies@kernelnewbies.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 4:53=E2=80=AFPM Naveen Kumar P
<naveenkumar.parna@gmail.com> wrote:
>
> On Wed, Mar 5, 2025 at 4:14=E2=80=AFAM Naveen Kumar P
> <naveenkumar.parna@gmail.com> wrote:
> >
> > On Wed, Mar 5, 2025 at 2:31=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.or=
g> wrote:
> > >
> > > On Tue, Mar 04, 2025 at 10:19:07PM +0530, Naveen Kumar P wrote:
> > > > On Tue, Mar 4, 2025 at 1:35=E2=80=AFPM Naveen Kumar P
> > > > <naveenkumar.parna@gmail.com> wrote:
> > > > ...
> > >
> > > > For this test run, I removed all three parameters (pcie_aspm=3Doff,
> > > > pci=3Dnomsi, and pcie_ports=3Don) and booted with the following ker=
nel
> > > > command line arguments:
> > > >
> > > > cat /proc/cmdline
> > > > BOOT_IMAGE=3D/vmlinuz-6.13.0+ root=3D/dev/mapper/vg00-rootvol ro qu=
iet
> > > > "dyndbg=3Dfile drivers/pci/* +p; file drivers/acpi/bus.c +p; file
> > > > drivers/acpi/osl.c +p"
> > > >
> > > > This time, the issue occurred earlier, at 22998 seconds. Below is t=
he
> > > > relevant dmesg log during the ACPI_NOTIFY_BUS_CHECK event. The
> > > > complete log is attached (dmesg_march4th_log.txt).
> > > >
> > > > [22998.536705] ACPI: \_SB_.PCI0.RP01: ACPI: ACPI_NOTIFY_BUS_CHECK e=
vent
> > > > [22998.536753] ACPI: \_SB_.PCI0.RP01: ACPI: OSL: Scheduling hotplug
> > > > event 0 for deferred handling
> > > > [22998.536934] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bridge acquired=
 in
> > > > hotplug_event()
> > > > [22998.536972] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bus check in ho=
tplug_event()
> > > > [22998.537002] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Checking bridge=
 in
> > > > hotplug_event()
> > > > [22998.537024] PCI READ: res=3D0, bus=3D01 dev=3D00 func=3D0 pos=3D=
0x00 len=3D4
> > > > data=3D0x55551556
> > > > [22998.537066] PCI READ: res=3D0, bus=3D01 dev=3D00 func=3D0 pos=3D=
0x00 len=3D4
> > > > data=3D0x55551556
> > >
> > > Fine again.
> > >
> > > > [22998.537094] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Enabling slot i=
n
> > > > acpiphp_check_bridge()
> > > > [22998.537155] ACPI: Device [PXSX] status [0000000f]
> > > > [22998.537206] ACPI: Device [D015] status [0000000f]
> > > > [22998.537276] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Releasing bridg=
e
> > > > in hotplug_event()
> > > >
> > > > sudo lspci -xxx -s 01:00.0 | grep 10:
> > > > 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > >
> > > Obviously a problem.  Can you start including the whole
> > > "lspci -x -s 01:00.0" output?  Obviously the Vendor ID reads above
> > > worked fine.  I *assume* it's still fine here, and only the BARs are
> > > zeroed out?
> > I've captured the complete lspci output from the last run, and it is as=
 follows:
> >
> > $sudo lspci -xxx -s 01:00.0
> > 01:00.0 RAM memory: PLDA Device 5555
> > 00: 56 15 55 55 00 00 10 00 00 00 00 05 00 00 00 00
> > 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 40 00 00
> > 30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00
> > 40: 01 48 03 00 08 00 00 00 05 60 00 00 00 00 00 00
> > 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 60: 10 00 02 00 c2 8f 00 00 10 28 00 00 21 f4 03 00
> > 70: 00 00 21 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 80: 00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00
> > 90: 20 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
> > a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >
> > I've also observed some inconsistencies in the behavior. In previous
> > runs, the first invocation of lspci showed all FF's, and then the next
> > run resulted in a PCI BAR reset, as mentioned below.
> >
> > Previous runs - first invocation of lspci output :
> > --------------------------------------------------
> > $sudo lspci -xxx -s 01:00.0
> > 01:00.0 RAM memory: PLDA Device 5555 (rev ff)
> > 00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >
> > Previous runs - second invocation of lspci output :
> > --------------------------------------------------
> > $sudo lspci -xxx -s 01:00.0
> > 01:00.0 RAM memory: PLDA Device 5555
> > 00: 56 15 55 55 00 00 10 00 00 00 00 05 00 00 00 00
> > 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 40 00 00
> > 30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00
> > 40: 01 48 03 00 08 00 00 00 05 60 00 00 00 00 00 00
> > 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 60: 10 00 02 00 c2 8f 00 00 10 28 00 00 21 f4 03 00
> > 70: 00 00 21 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 80: 00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00
> > 90: 20 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
> > a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >
> > However this time, the first run didn't show all FF's but instead
> > directly resulted in a PCI BAR reset.
> >
> >
> > >
> > > I assume you saw no new dmesg logs about config accesses to the devic=
e
> > > before the lspci.  If you instrumented the user config accessors
> > > (pci_user_read_config_*(), also in access.c), you should see those
> > > accesses.
> > i will try this and update you with the results soon.
> > >
> > > You could sprinkle some calls to early_dump_pci_device() through the
> > > acpiphp path.  Turn off the kernel config access tracing when you do
> > > this so it doesn't clutter things up.
> I instrumented the user config accessors (pci_user_read_config_*())
> and added calls to early_dump_pci_device() in the ACPIPHP path. The
> corresponding patch
> (0003-added-early_dump_pci_device-through-the-acpiphp-path.patch) is
> attached for reference.
>
> After rebuilding the kernel with these changes, I rebooted the system
> and monitored the ACPI_NOTIFY_BUS_CHECK event in dmesg, but it did not
> appear initially. After waiting for three days, I manually ran lspci,
> which resulted in all 0xFFs in the PCI config space from 0x00 to 0x3F
> as shown below:
> $ sudo lspci -xxx -s 01:00.0
> 01:00.0 RAM memory: PLDA Device 5555 (rev ff)
> 00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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
>
> The corresponding dmesg log confirms this:
>
> [260228.608982] USER PCI READ: ret=3D0, bus=3D01 dev=3D00 func=3D0 pos=3D=
0x00
> len=3D4 data=3D0xffffffff
> ...
> [260228.609741] USER PCI READ: ret=3D0, bus=3D01 dev=3D00 func=3D0 pos=3D=
0x3c
> len=3D4 data=3D0xffffffff
> [260228.640346] USER PCI READ: ret=3D0, bus=3D01 dev=3D00 func=3D0 pos=3D=
0x40
> len=3D4 data=3D0x34801
> ..
> [260228.640666] USER PCI READ: ret=3D0, bus=3D01 dev=3D00 func=3D0 pos=3D=
0xfc
> len=3D4 data=3D0x0
>
>
> However, after completing this command, the ACPI_NOTIFY_BUS_CHECK
> event was triggered. At this point, the early_dump_pci_device() output
> reflected the correct values in the PCI config space (0x00 to 0x3F),
> except for BAR0 (offset 0x10), which had been reset to 0x0:
>
> [260228.711860] ACPI: \_SB_.PCI0.RP01: ACPI: ACPI_NOTIFY_BUS_CHECK event
> [260228.711902] ACPI: \_SB_.PCI0.RP01: ACPI: OSL: Scheduling hotplug
> event 0 for deferred handling
> [260228.712004] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bridge acquired
> in hotplug_event()
> [260228.712032] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bus check in
> hotplug_event()
> [260228.712053] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Checking bridge
> in hotplug_event()
> [260228.712096] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: calling
> early_dump_pci_device() before enable_slot() in acpiphp_check_bridge()
> [260228.712121] pcieport 0000:00:1c.0: config space:
> [260228.712217] 00000000: 86 80 48 0f 07 04 10 00 11 00 04 06 10 00 81 00
> [260228.712232] 00000010: 00 00 00 00 00 00 00 00 00 01 01 00 10 10 00 20
> [260228.712246] 00000020: 40 b0 70 b0 f1 ff 01 00 00 00 00 00 00 00 00 00
> [260228.712258] 00000030: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 12 00
> [260228.712270] 00000040: 10 80 42 01 00 80 00 00 00 00 11 00 22 4c 31 01
> [260228.712282] 00000050: 00 0c 21 30 60 00 04 00 00 00 40 01 00 00 00 00
> [260228.712294] 00000060: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
> [260228.712306] 00000070: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
> [260228.712318] 00000080: 05 90 01 00 00 20 e0 fe 20 00 00 00 00 00 00 00
> [260228.712330] 00000090: 0d a0 00 00 86 80 48 0f 00 00 00 00 00 00 00 00
> [260228.712342] 000000a0: 01 00 03 c8 00 00 00 00 00 00 00 00 00 00 00 00
> [260228.712354] 000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [260228.712366] 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [260228.712378] 000000d0: 00 c0 00 00 42 08 00 00 00 80 11 c9 00 00 00 00
> [260228.712390] 000000e0: 00 00 00 00 00 00 00 00 04 00 00 00 00 00 00 00
> [260228.712402] 000000f0: 50 00 00 00 c0 00 00 00 1a 0f 13 01 00 40 00 01
> [260228.712420] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Enabling slot in
> acpiphp_check_bridge()
>
>
> A second lspci command confirmed that BAR0 remained 0x00, aligning
> with the early_dump_pci_device() output:
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
> While I can now reliably reproduce the issue, I still don=E2=80=99t have
> clarity on why BAR0 is being reset to zero?
>
> I would like to summarize my observations as follows. Based on my
> testing, I have noticed that the PCI BAR0 address (offset 0x10) gets
> reset to zero under the following scenarios:
>
> 1. Spontaneous ACPI BUS CHECK Event
> After booting the system, at an unpredictable time, an
> ACPI_NOTIFY_BUS_CHECK event appears in the dmesg log.
> Running lspci -xxx -s 01:00.0 after this event shows that BAR0 (offset
> 0x10) is reset to zero.
>
> 2. ACPI BUS CHECK Event Triggered After lspci Shows All 0xFF=E2=80=99s (F=
ull
> Config Space)
> I waited for the ACPI_NOTIFY_BUS_CHECK event, but it did not appear in
> the dmesg log.
> Running lspci -xxx -s 01:00.0 at this stage resulted in all 0xFF's in
> the PCI configuration space from offset 0x00 to 0xFF.
> Immediately after this, the ACPI_NOTIFY_BUS_CHECK event appeared in dmesg=
.
> After this event, running lspci again showed correct values in the PCI
> configuration space, except BAR0 (offset 0x10) was still reset to
> zero.
>
> 3. ACPI BUS CHECK Event Triggered After lspci Shows Partial 0xFF=E2=80=99=
s
> (First 64 Bytes - as observed in this dmesg log)
> This scenario is similar to the second one.
> Running lspci -xxx -s 01:00.0 resulted in all 0xFF's from offset 0x00
> to 0x3F instead of the entire config space.
> The ACPI_NOTIFY_BUS_CHECK event then appeared, and lspci showed
> correct values except for BAR0 (offset 0x10), which was reset to zero.
>
>
> Why does reading the PCI configuration space with lspci sometimes
> return 0xFF's for the first 64 bytes (offset 0x00 to 0x3F) and other
> times for the entire 256-byte space (offset 0x00 to 0xFF)?
>
> Does the kernel provide any debug messages or hooks that can help
> determine why the PCI config space reads all 0xFF's before the ACPI
> BUS CHECK event?
>
> Should I add any additional instrumentation in the kernel (e.g.,
> deeper tracing in access.c, ACPI hotplug path, or PCIe port handling)
> to gather more information on why BAR0 is being reset?
>
> I have attached the patch
> 0003-added-early_dump_pci_device-through-the-acpiphp-path.patch and
> the full dmesg log for reference.
>
> Looking forward to your thoughts.
>
> > >
> > > What is this device?  Is it a shipping product?  Do you have good
> > The PCIe device in question is a Xilinx FPGA endpoint, which is
> > flashed with RTL code to expose several host interfaces to the system
> > via the PCIe link.
> >
> > > confidence that the hardware is working correctly?  I guess you said
> > > it works correctly on a different machine with an older kernel.  I
> > > would swap the cards between machines in case one card is broken.
The issue occurs randomly after a few days of system uptime,
post-boot, during runtime.
The same PCIe card is currently working fine on another machine
running Ubuntu 16.04 with kernel 4.4.0-66-generic. However, the
affected machine is running Ubuntu 20.04 with a newly built latest
kernel. Full testing on the older kernel is still on hold, as we are
currently focusing on recent kernels.
Apart from kernel differences, the BIOS versions are also different on
these systems.
Given that the issue happens at runtime and not during initialization,
could BIOS influence this behavior after boot?

BAR Register Differences & Configuration Source:
------------------------------------------------------------------
The BASE_ADDRESS_0 register differs between the two machines:
Ubuntu 20.04 (buggy system): 0xb0400000
Ubuntu 16.04 (working system): 0xd0400000

I would like to understand who determines this value:
Is it set by BIOS, firmware, or the Linux kernel PCI driver?
Could you provide a reference to the source code where the BAR
registers are assigned and mapped?

Earlier, CONFIG_PCI_DEBUG was not set. I have now enabled it and
started the kernel build. Are there any other important CONFIG debug
options that need to be enabled for debugging this?

> > >
> > > You could try bisecting between the working kernel and the broken one=
.
> > > It's kind of painful since it takes so long to reproduce the problem.
> > >
> > > Bjorn

