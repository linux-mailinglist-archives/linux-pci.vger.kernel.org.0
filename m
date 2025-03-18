Return-Path: <linux-pci+bounces-24047-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AECA675EE
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 15:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0219C3AB987
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 14:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6098920DD51;
	Tue, 18 Mar 2025 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkolOkZo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90D720DD7A;
	Tue, 18 Mar 2025 14:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306892; cv=none; b=eur5qSi4f+dtVS1KWUn+HzIVgyidD6LvMuWmLjkqPt+b+eZaFFfYOJV/uWn54oUdKPX6i6JJxUJDZThRwWnvztbZetYSGLVTNmzoeD9LGEOrv5bCu3xM+9PYwz1MfKZx1GNu+vtb13jmLBVItdzPJ9Lb1cpPtHj2qssbIchx47g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306892; c=relaxed/simple;
	bh=Pzd//H9sO/4/wlYvLErerov9HHnC2/oZLmUN1589i4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gxcWxY06VE90t06bJgjXgYsEEDamRMuFqaXExOli1OzHR44bU4TlTbinZLw1whCBIi4AJZqPrVesaZp1ZqDyOi83Eljy8g3m0sNQbvmwVKf3LfJrXVa7+ZhPAzQ6VPTX4cCfyNeGaUEiJRY2L/5woqgusKKL7a/rlykSC7CLodQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkolOkZo; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30bf1d48843so53987281fa.2;
        Tue, 18 Mar 2025 07:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742306888; x=1742911688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jBT6lMYNg2RGWOYGi1e9+7/iwEhWMtY+8QlAnQP2JQ=;
        b=kkolOkZoZr7oXnjBEhNqjkytLDoLYs7PG5NZRHOdIG2cupx46dn6HxvUCT5ZqEYmDs
         iEFeFVcPRTWeBN6utztNoy8NMtCFPZ2k6lCBf+ReBWDFyO0drWM7dIEs/zf265Xd9WD6
         iZfe2YY46t4oyP2BxR2s562IRIp0X8jTGG7v1lV5Iu7U2Knuixu0wjS4EPVIjWPYSzNe
         U9zB3CclpLhQ0HDmO0Ez1cd0EwTqtoJvZ4jxJBUjr2B+264rVfJN66KVW2aZ5FRSoOgQ
         3SaNIDJ4oHB6MTz/FryUavIHEu97WjGWEUTRx25iaAjG+QnlYZ+BMbrPVe8eRh9j7pR+
         R6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742306888; x=1742911688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+jBT6lMYNg2RGWOYGi1e9+7/iwEhWMtY+8QlAnQP2JQ=;
        b=CbeQXyMyAh9uSx+mSLSYCB5Hp8Tnv8MlJ+YQR2hIrjEt/q+U5tEfQRIfy1mR/xwWHO
         5O90kth0ueXK9b+grb2m4zgV6/og3uEwB4bUsrE434N4WpwWyuSu1FBMsZXQBSMDLeef
         cGaJHBm3tQIft1tUz/RI+8kU/YQIVHD1wKLjaTO7MDVyuzYa3+OvxEZfDG++V4ThDMg5
         5cSEVPCnFYTJjPJlVpbw1hNzqYNQXE0/xlbfzx0eGCwE3/siBYa7l+LEbbm6sNMR1NFN
         PahP0hwlG6PPLockXklbwIvOH8YKfzb8/dUfB6VFp+Ed4o6GDtdm51n83wXlN9hg/XnZ
         maow==
X-Forwarded-Encrypted: i=1; AJvYcCXtBkc4Pq6+39bJsldSFEH4Cyeh0OY+40X6iiIubyZjwxpHB6drtdr1YTyW52ToTWXFyrfjV2MMyec+/hX7@vger.kernel.org, AJvYcCXxpD9T6nSYO3mZ4V/QFsEv/rN4z69S6EgnaBVPJp/Y3xR6m1De84NWRnBtrDBFenOH0mKjQEqNSfCL@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzo+kdFphYp1jUaqa2DSbDWiaMMyfVYo6LBCUtO/jgs20G1uyk
	C0YUv72L1mzN3SEoi5EXF8sJDvNTQ3Nllk//ACTvjrxCPKp1J8VMpdrUg8bJdjBX9ORa9wQghUh
	VoK7KntLiXV/e1mlte52qJQLp1PG6vnQ=
X-Gm-Gg: ASbGncuVPJVvcURz6mRQxeItKPhbNRrJMD1BcaTfMlb7/ObE2twp7KaRFmwOJ/9uGOU
	eVTGA35Y7Z+jO6KnNeuv+sihIPnV2o84Mv2xek2BAOMLYN4pq7TRbXIatTi3rmmfKj4TkY3oQoo
	O//XhRcKRLePqHUEllshK5/W1NnMHZfv65DUU=
X-Google-Smtp-Source: AGHT+IHUHSCdeSOdbFSw2xW/DKdjsHDW9JwGv4lqR2naHIS3i9JmQPKpLP3cPp7fPsI3jbH4G5HHx4KMt3z0h+BiXNg=
X-Received: by 2002:a05:6512:3f07:b0:545:c89:2bc9 with SMTP id
 2adb3069b0e04-549c39aaac3mr9536528e87.43.1742306887079; Tue, 18 Mar 2025
 07:08:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMciSVVhdRjfVYZGg+0Yo6EV4P80No3kLxCL8+LyVjwywiWxYg@mail.gmail.com>
 <20250304210122.GA257363@bhelgaas> <CAMciSVWfLVRQB4afDe=6e=n_j7+4DX-tvDpeEx6QUkvBym+7GQ@mail.gmail.com>
 <CAMciSVV317JUzxoL1yO_rC_=p8hJUsfBK5UpxDFYNjjaw0ePcQ@mail.gmail.com> <CAMciSVV6Sk3Hs0oeS5FtB8jMCoet5FZ-R6T=XmQ4=BN=LR4xHA@mail.gmail.com>
In-Reply-To: <CAMciSVV6Sk3Hs0oeS5FtB8jMCoet5FZ-R6T=XmQ4=BN=LR4xHA@mail.gmail.com>
From: Naveen Kumar P <naveenkumar.parna@gmail.com>
Date: Tue, 18 Mar 2025 19:37:53 +0530
X-Gm-Features: AQ5f1JozqLRtmYTO3BJ-CzLCczZh_kz7E8aP15Qt3Sv0uKYQTJlJmlOE0ARm0xs
Message-ID: <CAMciSVXAJwN9q_HVYfrCNH7k_+HXvp4NWn6w=dCrrw2C-_BHRg@mail.gmail.com>
Subject: Re: PCI: hotplug_event: PCIe PLDA Device BAR Reset
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernelnewbies <kernelnewbies@kernelnewbies.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Following up on the PCI BAR0 reset issue, I have collected more data
and performed additional debugging steps. Below are the key
observations and queries:

Observations:
1. The issue occurs randomly after a few days of system uptime.
2. When the issue occurs, reading the PCI configuration space (lspci
-xxx -s 01:00.0) sometimes returns all 0xffs from offset 0x00 to 0x3F
or the entire config space.
$ sudo lspci -xxx -s 01:00.0
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

$ uptime
 11:29:59 up 3 days, 14:39,  1 user,  load average: 0.75, 0.57, 0.47

3. After this, subsequent reads restore non-0xff values, but BAR0 gets
reset to zero.
$ sudo lspci -xxx -s 01:00.0
01:00.0 RAM memory: PLDA Device 5555
00: 56 15 55 55 00 00 10 00 00 00 00 05 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 40 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00
40: 01 48 03 00 08 00 00 00 05 60 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 02 00 c2 8f 00 00 10 28 01 00 21 f4 03 00
70: 00 00 21 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00
90: 20 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


Debugging Steps Taken:
Used ftrace to track relevant PCI, hotplug, and BIOS-related function calls=
:

echo function > current_tracer
echo '*pci* *hotplug* *bios*' > set_ftrace_filter

Captured a 19MB trace file, so sharing the full trace isn't feasible.

few lines of the dmesg log, where it returned "all ones" from config
space is mentioned below:
[311972.545818] USER PCI READ: ret=3D0, bus=3D01 dev=3D00 func=3D0 pos=3D0x=
00
len=3D4 data=3D0xffffffff
[311972.564790] USER PCI READ: ret=3D0, bus=3D01 dev=3D00 func=3D0 pos=3D0x=
04
len=3D4 data=3D0xffffffff
[311972.564826] USER PCI READ: ret=3D0, bus=3D01 dev=3D00 func=3D0 pos=3D0x=
08
len=3D4 data=3D0xffffffff
[311972.564840] USER PCI READ: ret=3D0, bus=3D01 dev=3D00 func=3D0 pos=3D0x=
0c
len=3D4 data=3D0xffffffff
[311972.564848] USER PCI READ: ret=3D0, bus=3D01 dev=3D00 func=3D0 pos=3D0x=
10
len=3D4 data=3D0xffffffff
[311972.564856] USER PCI READ: ret=3D0, bus=3D01 dev=3D00 func=3D0 pos=3D0x=
14
len=3D4 data=3D0xffffffff


the corresponding function tracer log is mentioned below:
   node_exporter-1484    [000] ..... 311972.543102:
acpi_ex_pci_config_space_handler <-acpi_ev_address_space_dispatch
   node_exporter-1484    [000] ..... 311972.543104:
acpi_os_read_pci_configuration <-acpi_ex_pci_config_space_handler
   node_exporter-1484    [000] ..... 311972.543104: raw_pci_read
<-acpi_os_read_pci_configuration
   node_exporter-1484    [000] ..... 311972.543105: pci_conf1_read
<-raw_pci_read
           lspci-242643  [001] ..... 311972.557702:
pci_resource_to_user <-resource_show
           lspci-242643  [001] ..... 311972.557707:
pci_resource_to_user <-resource_show
           lspci-242643  [001] ..... 311972.557708:
pci_resource_to_user <-resource_show
           lspci-242643  [001] ..... 311972.557710:
pci_resource_to_user <-resource_show
           lspci-242643  [001] ..... 311972.557711:
pci_resource_to_user <-resource_show
           lspci-242643  [001] ..... 311972.557712:
pci_resource_to_user <-resource_show
           lspci-242643  [001] ..... 311972.557712:
pci_resource_to_user <-resource_show
           lspci-242643  [001] ..... 311972.557713:
pci_resource_to_user <-resource_show
           lspci-242643  [001] ..... 311972.557714:
pci_resource_to_user <-resource_show


Questions & Next Steps:
1. Device Inaccessibility:
When reading all 0xffs from config space, does this indicate the
device is reset or powered down?
Shouldn't the kernel receive a hotplug event or error notification in this =
case?

2. ftrace Analysis:
Are there any additional function filters I should apply to
set_ftrace_filter to capture relevant events?
Any specific function calls in the trace file that I should focus on
for debugging?

Any recommended PCIe registers to check?
Let me know your thoughts and any additional suggestions.

On Tue, Mar 11, 2025 at 11:34=E2=80=AFPM Naveen Kumar P
<naveenkumar.parna@gmail.com> wrote:
>
> On Mon, Mar 10, 2025 at 4:53=E2=80=AFPM Naveen Kumar P
> <naveenkumar.parna@gmail.com> wrote:
> >
> > On Wed, Mar 5, 2025 at 4:14=E2=80=AFAM Naveen Kumar P
> > <naveenkumar.parna@gmail.com> wrote:
> > >
> > > On Wed, Mar 5, 2025 at 2:31=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.=
org> wrote:
> > > >
> > > > On Tue, Mar 04, 2025 at 10:19:07PM +0530, Naveen Kumar P wrote:
> > > > > On Tue, Mar 4, 2025 at 1:35=E2=80=AFPM Naveen Kumar P
> > > > > <naveenkumar.parna@gmail.com> wrote:
> > > > > ...
> > > >
> > > > > For this test run, I removed all three parameters (pcie_aspm=3Dof=
f,
> > > > > pci=3Dnomsi, and pcie_ports=3Don) and booted with the following k=
ernel
> > > > > command line arguments:
> > > > >
> > > > > cat /proc/cmdline
> > > > > BOOT_IMAGE=3D/vmlinuz-6.13.0+ root=3D/dev/mapper/vg00-rootvol ro =
quiet
> > > > > "dyndbg=3Dfile drivers/pci/* +p; file drivers/acpi/bus.c +p; file
> > > > > drivers/acpi/osl.c +p"
> > > > >
> > > > > This time, the issue occurred earlier, at 22998 seconds. Below is=
 the
> > > > > relevant dmesg log during the ACPI_NOTIFY_BUS_CHECK event. The
> > > > > complete log is attached (dmesg_march4th_log.txt).
> > > > >
> > > > > [22998.536705] ACPI: \_SB_.PCI0.RP01: ACPI: ACPI_NOTIFY_BUS_CHECK=
 event
> > > > > [22998.536753] ACPI: \_SB_.PCI0.RP01: ACPI: OSL: Scheduling hotpl=
ug
> > > > > event 0 for deferred handling
> > > > > [22998.536934] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bridge acquir=
ed in
> > > > > hotplug_event()
> > > > > [22998.536972] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bus check in =
hotplug_event()
> > > > > [22998.537002] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Checking brid=
ge in
> > > > > hotplug_event()
> > > > > [22998.537024] PCI READ: res=3D0, bus=3D01 dev=3D00 func=3D0 pos=
=3D0x00 len=3D4
> > > > > data=3D0x55551556
> > > > > [22998.537066] PCI READ: res=3D0, bus=3D01 dev=3D00 func=3D0 pos=
=3D0x00 len=3D4
> > > > > data=3D0x55551556
> > > >
> > > > Fine again.
> > > >
> > > > > [22998.537094] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Enabling slot=
 in
> > > > > acpiphp_check_bridge()
> > > > > [22998.537155] ACPI: Device [PXSX] status [0000000f]
> > > > > [22998.537206] ACPI: Device [D015] status [0000000f]
> > > > > [22998.537276] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Releasing bri=
dge
> > > > > in hotplug_event()
> > > > >
> > > > > sudo lspci -xxx -s 01:00.0 | grep 10:
> > > > > 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > >
> > > > Obviously a problem.  Can you start including the whole
> > > > "lspci -x -s 01:00.0" output?  Obviously the Vendor ID reads above
> > > > worked fine.  I *assume* it's still fine here, and only the BARs ar=
e
> > > > zeroed out?
> > > I've captured the complete lspci output from the last run, and it is =
as follows:
> > >
> > > $sudo lspci -xxx -s 01:00.0
> > > 01:00.0 RAM memory: PLDA Device 5555
> > > 00: 56 15 55 55 00 00 10 00 00 00 00 05 00 00 00 00
> > > 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 40 00 00
> > > 30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00
> > > 40: 01 48 03 00 08 00 00 00 05 60 00 00 00 00 00 00
> > > 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 60: 10 00 02 00 c2 8f 00 00 10 28 00 00 21 f4 03 00
> > > 70: 00 00 21 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 80: 00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00
> > > 90: 20 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > >
> > > I've also observed some inconsistencies in the behavior. In previous
> > > runs, the first invocation of lspci showed all FF's, and then the nex=
t
> > > run resulted in a PCI BAR reset, as mentioned below.
> > >
> > > Previous runs - first invocation of lspci output :
> > > --------------------------------------------------
> > > $sudo lspci -xxx -s 01:00.0
> > > 01:00.0 RAM memory: PLDA Device 5555 (rev ff)
> > > 00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > >
> > > Previous runs - second invocation of lspci output :
> > > --------------------------------------------------
> > > $sudo lspci -xxx -s 01:00.0
> > > 01:00.0 RAM memory: PLDA Device 5555
> > > 00: 56 15 55 55 00 00 10 00 00 00 00 05 00 00 00 00
> > > 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 40 00 00
> > > 30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00
> > > 40: 01 48 03 00 08 00 00 00 05 60 00 00 00 00 00 00
> > > 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 60: 10 00 02 00 c2 8f 00 00 10 28 00 00 21 f4 03 00
> > > 70: 00 00 21 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 80: 00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00
> > > 90: 20 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > >
> > > However this time, the first run didn't show all FF's but instead
> > > directly resulted in a PCI BAR reset.
> > >
> > >
> > > >
> > > > I assume you saw no new dmesg logs about config accesses to the dev=
ice
> > > > before the lspci.  If you instrumented the user config accessors
> > > > (pci_user_read_config_*(), also in access.c), you should see those
> > > > accesses.
> > > i will try this and update you with the results soon.
> > > >
> > > > You could sprinkle some calls to early_dump_pci_device() through th=
e
> > > > acpiphp path.  Turn off the kernel config access tracing when you d=
o
> > > > this so it doesn't clutter things up.
> > I instrumented the user config accessors (pci_user_read_config_*())
> > and added calls to early_dump_pci_device() in the ACPIPHP path. The
> > corresponding patch
> > (0003-added-early_dump_pci_device-through-the-acpiphp-path.patch) is
> > attached for reference.
> >
> > After rebuilding the kernel with these changes, I rebooted the system
> > and monitored the ACPI_NOTIFY_BUS_CHECK event in dmesg, but it did not
> > appear initially. After waiting for three days, I manually ran lspci,
> > which resulted in all 0xFFs in the PCI config space from 0x00 to 0x3F
> > as shown below:
> > $ sudo lspci -xxx -s 01:00.0
> > 01:00.0 RAM memory: PLDA Device 5555 (rev ff)
> > 00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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
> >
> > The corresponding dmesg log confirms this:
> >
> > [260228.608982] USER PCI READ: ret=3D0, bus=3D01 dev=3D00 func=3D0 pos=
=3D0x00
> > len=3D4 data=3D0xffffffff
> > ...
> > [260228.609741] USER PCI READ: ret=3D0, bus=3D01 dev=3D00 func=3D0 pos=
=3D0x3c
> > len=3D4 data=3D0xffffffff
> > [260228.640346] USER PCI READ: ret=3D0, bus=3D01 dev=3D00 func=3D0 pos=
=3D0x40
> > len=3D4 data=3D0x34801
> > ..
> > [260228.640666] USER PCI READ: ret=3D0, bus=3D01 dev=3D00 func=3D0 pos=
=3D0xfc
> > len=3D4 data=3D0x0
> >
> >
> > However, after completing this command, the ACPI_NOTIFY_BUS_CHECK
> > event was triggered. At this point, the early_dump_pci_device() output
> > reflected the correct values in the PCI config space (0x00 to 0x3F),
> > except for BAR0 (offset 0x10), which had been reset to 0x0:
> >
> > [260228.711860] ACPI: \_SB_.PCI0.RP01: ACPI: ACPI_NOTIFY_BUS_CHECK even=
t
> > [260228.711902] ACPI: \_SB_.PCI0.RP01: ACPI: OSL: Scheduling hotplug
> > event 0 for deferred handling
> > [260228.712004] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bridge acquired
> > in hotplug_event()
> > [260228.712032] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bus check in
> > hotplug_event()
> > [260228.712053] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Checking bridge
> > in hotplug_event()
> > [260228.712096] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: calling
> > early_dump_pci_device() before enable_slot() in acpiphp_check_bridge()
> > [260228.712121] pcieport 0000:00:1c.0: config space:
> > [260228.712217] 00000000: 86 80 48 0f 07 04 10 00 11 00 04 06 10 00 81 =
00
> > [260228.712232] 00000010: 00 00 00 00 00 00 00 00 00 01 01 00 10 10 00 =
20
> > [260228.712246] 00000020: 40 b0 70 b0 f1 ff 01 00 00 00 00 00 00 00 00 =
00
> > [260228.712258] 00000030: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 12 =
00
> > [260228.712270] 00000040: 10 80 42 01 00 80 00 00 00 00 11 00 22 4c 31 =
01
> > [260228.712282] 00000050: 00 0c 21 30 60 00 04 00 00 00 40 01 00 00 00 =
00
> > [260228.712294] 00000060: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 =
00
> > [260228.712306] 00000070: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 =
00
> > [260228.712318] 00000080: 05 90 01 00 00 20 e0 fe 20 00 00 00 00 00 00 =
00
> > [260228.712330] 00000090: 0d a0 00 00 86 80 48 0f 00 00 00 00 00 00 00 =
00
> > [260228.712342] 000000a0: 01 00 03 c8 00 00 00 00 00 00 00 00 00 00 00 =
00
> > [260228.712354] 000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00
> > [260228.712366] 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00
> > [260228.712378] 000000d0: 00 c0 00 00 42 08 00 00 00 80 11 c9 00 00 00 =
00
> > [260228.712390] 000000e0: 00 00 00 00 00 00 00 00 04 00 00 00 00 00 00 =
00
> > [260228.712402] 000000f0: 50 00 00 00 c0 00 00 00 1a 0f 13 01 00 40 00 =
01
> > [260228.712420] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Enabling slot in
> > acpiphp_check_bridge()
> >
> >
> > A second lspci command confirmed that BAR0 remained 0x00, aligning
> > with the early_dump_pci_device() output:
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
> > While I can now reliably reproduce the issue, I still don=E2=80=99t hav=
e
> > clarity on why BAR0 is being reset to zero?
> >
> > I would like to summarize my observations as follows. Based on my
> > testing, I have noticed that the PCI BAR0 address (offset 0x10) gets
> > reset to zero under the following scenarios:
> >
> > 1. Spontaneous ACPI BUS CHECK Event
> > After booting the system, at an unpredictable time, an
> > ACPI_NOTIFY_BUS_CHECK event appears in the dmesg log.
> > Running lspci -xxx -s 01:00.0 after this event shows that BAR0 (offset
> > 0x10) is reset to zero.
> >
> > 2. ACPI BUS CHECK Event Triggered After lspci Shows All 0xFF=E2=80=99s =
(Full
> > Config Space)
> > I waited for the ACPI_NOTIFY_BUS_CHECK event, but it did not appear in
> > the dmesg log.
> > Running lspci -xxx -s 01:00.0 at this stage resulted in all 0xFF's in
> > the PCI configuration space from offset 0x00 to 0xFF.
> > Immediately after this, the ACPI_NOTIFY_BUS_CHECK event appeared in dme=
sg.
> > After this event, running lspci again showed correct values in the PCI
> > configuration space, except BAR0 (offset 0x10) was still reset to
> > zero.
> >
> > 3. ACPI BUS CHECK Event Triggered After lspci Shows Partial 0xFF=E2=80=
=99s
> > (First 64 Bytes - as observed in this dmesg log)
> > This scenario is similar to the second one.
> > Running lspci -xxx -s 01:00.0 resulted in all 0xFF's from offset 0x00
> > to 0x3F instead of the entire config space.
> > The ACPI_NOTIFY_BUS_CHECK event then appeared, and lspci showed
> > correct values except for BAR0 (offset 0x10), which was reset to zero.
> >
> >
> > Why does reading the PCI configuration space with lspci sometimes
> > return 0xFF's for the first 64 bytes (offset 0x00 to 0x3F) and other
> > times for the entire 256-byte space (offset 0x00 to 0xFF)?
> >
> > Does the kernel provide any debug messages or hooks that can help
> > determine why the PCI config space reads all 0xFF's before the ACPI
> > BUS CHECK event?
> >
> > Should I add any additional instrumentation in the kernel (e.g.,
> > deeper tracing in access.c, ACPI hotplug path, or PCIe port handling)
> > to gather more information on why BAR0 is being reset?
> >
> > I have attached the patch
> > 0003-added-early_dump_pci_device-through-the-acpiphp-path.patch and
> > the full dmesg log for reference.
> >
> > Looking forward to your thoughts.
> >
> > > >
> > > > What is this device?  Is it a shipping product?  Do you have good
> > > The PCIe device in question is a Xilinx FPGA endpoint, which is
> > > flashed with RTL code to expose several host interfaces to the system
> > > via the PCIe link.
> > >
> > > > confidence that the hardware is working correctly?  I guess you sai=
d
> > > > it works correctly on a different machine with an older kernel.  I
> > > > would swap the cards between machines in case one card is broken.
> The issue occurs randomly after a few days of system uptime,
> post-boot, during runtime.
> The same PCIe card is currently working fine on another machine
> running Ubuntu 16.04 with kernel 4.4.0-66-generic. However, the
> affected machine is running Ubuntu 20.04 with a newly built latest
> kernel. Full testing on the older kernel is still on hold, as we are
> currently focusing on recent kernels.
> Apart from kernel differences, the BIOS versions are also different on
> these systems.
> Given that the issue happens at runtime and not during initialization,
> could BIOS influence this behavior after boot?
>
> BAR Register Differences & Configuration Source:
> ------------------------------------------------------------------
> The BASE_ADDRESS_0 register differs between the two machines:
> Ubuntu 20.04 (buggy system): 0xb0400000
> Ubuntu 16.04 (working system): 0xd0400000
>
> I would like to understand who determines this value:
> Is it set by BIOS, firmware, or the Linux kernel PCI driver?
> Could you provide a reference to the source code where the BAR
> registers are assigned and mapped?
>
> Earlier, CONFIG_PCI_DEBUG was not set. I have now enabled it and
> started the kernel build. Are there any other important CONFIG debug
> options that need to be enabled for debugging this?
>
> > > >
> > > > You could try bisecting between the working kernel and the broken o=
ne.
> > > > It's kind of painful since it takes so long to reproduce the proble=
m.
> > > >
> > > > Bjorn

