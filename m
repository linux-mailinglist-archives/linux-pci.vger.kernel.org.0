Return-Path: <linux-pci+bounces-13683-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 151AD98BC9A
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 14:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E7BBB22FC1
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 12:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D2F1BF7EE;
	Tue,  1 Oct 2024 12:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrNuH80l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712D219D09C
	for <linux-pci@vger.kernel.org>; Tue,  1 Oct 2024 12:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727786896; cv=none; b=o0MiLERG4Tqd3+965iXWkS+sgng9Js7u/jXmPNoRg48ueNS8sOnWjPzze6qCQrjklTKPWPp487J63DRqSVtd/FbqRxoMHnmDumpE1kZy73Bbe4P2f+52dmXQC1AFnlIIcifXcXmwAO+t5UN1XYJ5NzAEXIhPUYurqFzh47feqgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727786896; c=relaxed/simple;
	bh=QbfCjGBgL+Tz7Xmij0negfb9Vl9HikFUyM8FyOe8cpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9OUD2zAKyqc2mv5ByfH1BD01fqr3jzojI+u5k9Kvzm/+dOutCzvJ6mGBm/WI+AXpRgDg7yDyEpip2EitUpOnGR0Hsz64nff9m2kTIUSZpsv8TiXmuLPTPN0FcDS41IrDbCRmEZqalzpQ12dm1h5tPal5syp+QImpLOUUbx3B6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrNuH80l; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e129c01b04so43479657b3.1
        for <linux-pci@vger.kernel.org>; Tue, 01 Oct 2024 05:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727786894; x=1728391694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bhmE4u80M/7fzmhPrDRPuKuoEzudcSypNCPhbvh5qw=;
        b=MrNuH80lg4ztMQ8qPGcqcyFEuYcb7/D70gMktf8wBDQwPx0OuAzmyC9QebCsYJSw+7
         KsS/nlHzpDmIzsUGQXVgfJ0/OgkIIxo64HY8dyRT9M2/Dc16s5VERhYQxyI5HFs8f1Zg
         BwFvmmhUbxBaOMgRKFwS1JDvF9r+HHxVgC5TSqswwV+14pn5i9OQr1hAYiYebpU8trj1
         QMcPa8RSVigg0G65LviQjhF+WrgZL3EoQguvo3LMVghcHhXLddGtDKWF9dUNJ8JJ0BVL
         FsMCHM4Uc4ueQ7xo0ZYUeRdjeHMj1qHmgrpK9RKAGjcijBeS5nxrGlwaALgzuO9kS537
         fFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727786894; x=1728391694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bhmE4u80M/7fzmhPrDRPuKuoEzudcSypNCPhbvh5qw=;
        b=KC5acSeh6VluyWKuFT6lYVfWLdF2qTrZ6XiDDf8AEOxjqs9M0rAlqFS4LuziABviDQ
         bDfK5plj64gxFvfW5Kbzl2wngx74u55/NoOwe/6wdWpKkbUxM71EaAL+TSkWChhAYru4
         T1F2dohNi0dBnulRpCfwJ63ZbUha+zDPAzqOptldKUwRmuK0FfEAlJan7knyhsRAxlHr
         AXJH9jrh6S3qLQuskzEEFiH19uNUmLOm+pKBPbyk7YrXjXSFarMYVclGpSvlHzwiqcRD
         22+84KsiAC6FUeMfMqhLxhmBHStJIcfogaGXLML3fYaRn0gqs/YTeBLSosq6pCvDIYIq
         /FIA==
X-Gm-Message-State: AOJu0YxLi0uHaRI/nfPfmf1dvRdBuddwfFke8VqdeycDE5nzjbJJGiJu
	46vIaoMXBhOOhOVb1QeJa9BNIE5YI7QXge4og9J9iqWhIjG5Fy0aZpt+IEueEi+Nj28BQr6oRJW
	5GSlunuY25/+mUOdZo3JdCsvV9tAmigmC5zA=
X-Google-Smtp-Source: AGHT+IEwcGZLgqSPMhn1eo0k/LB/gppNgBaMoUkgsughHFW/B+lrJX1DOO7zeKKoO4GRO+/acWUes/TCs4nY6DOIdsY=
X-Received: by 2002:a05:690c:f92:b0:6e2:1742:590d with SMTP id
 00721157ae682-6e2474e15famr120388047b3.3.1727786894277; Tue, 01 Oct 2024
 05:48:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALfBBTsmKYf5FT-pxLfM-C1EgdrKKhQU43OhMDBz2ZPtKcxaLQ@mail.gmail.com>
 <20240930192834.GA187120@bhelgaas>
In-Reply-To: <20240930192834.GA187120@bhelgaas>
From: Maverickk 78 <maverickk1778@gmail.com>
Date: Tue, 1 Oct 2024 18:18:03 +0530
Message-ID: <CALfBBTv3_4_x3aXfoDgQ93LCAbfC-2djnfwbHS+hqmOff8+8+g@mail.gmail.com>
Subject: Re: pcie hotplug driver probe is not getting called
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

Yes, it's a virtual x86 Qemu environment with rtl simulated pcie gen6
switch hooked to the host controller.

The simulation environment is 3rd party and my guess is it's a
passthrough(guessing) .

I can confirm that msi is received to the Qemu host because the USP
port has f0, f1, f2, f3, f4 and f4 is an scsi end point function and
interrupts are used for command/response.

I enabled a few more debugs, now I can see more information from
pciehp dumped into the kernel log.

Thanks for the details, I was not aware that _OSC flags need to be
built by firmware to enable native PCIe hotplug.

On Tue, 1 Oct 2024 at 00:58, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Sun, Sep 29, 2024 at 07:29:32PM +0530, Maverickk 78 wrote:
> > Hi Bjorn,
> >
> > I have a switch connecting to the Host bridge, one of the downstream
> > port(02:1.0) on the switch has the slot enabled.
> >
> > Appended pcie_ports=3Dnative along with pciehp.pciehp_force=3D1
> > pciehp.pciehp_debug=3D1  to the cmdline and I see the driver creating s=
ymlink
> > to sysfs device node.
> >
> > Does this mean pciehp can handle the hotplug events? asking this becaus=
e
> > none of the functions in pciehp_core listed in ftrace?
>
> From the dmesg log you attached:
>
>   [    0.000000] DMI: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.=
0-0-g155821a-20210629_105355-sharpie 04/01/2014
>   [    0.000000] Hypervisor detected: KVM
>   [    0.408755] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-6.11.0+ =
root=3DUUID=3Df563804b-1b93-4921-90e1-4114c8111e8f ro modprobe.blacklist=3D=
mpt3sas ftrace=3Dfunction_graph ftrace_graph_filter=3D*pcie* pciehp.pciehp_=
force=3D1 pciehp.pciehp_debug=3D1 pcie_ports=3Dnative quite splash crashker=
nel=3D512M-:192M vt.handoff=3D7
>   [    1.640055] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.=
5
>   [    1.736168] acpi PNP0A08:00: _OSC: platform does not support [PCIeHo=
tplug LTR DPC]
>   [    1.738096] acpi PNP0A08:00: _OSC: OS now controls [SHPCHotplug PME =
AER PCIeCapability]
>   [    9.885390] pcieport 0000:02:01.0: pciehp: Slot #0 AttnBtn+ PwrCtrl+=
 MRL+ AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock- NoCompl- IbPresDis- LL=
ActRep+
>
> I assume this kernel is running as a KVM guest.  The firmware _OSC
> says the platform (QEMU) doesn't support native PCIe hotplug, so
> host->native_pcie_hotplug will be false.  But of course
> "pcie_ports=3Dnative" would set pcie_ports_native, so the portdrv
> get_port_device_capability() will set PCIE_PORT_SERVICE_HP, which
> allows pciehp to bind to 02:01.0.
>
> The "pcieport 0000:02:01.0: pciehp: Slot #0" line shows that
> pciehp_probe() was called.
>
> I don't know whether QEMU supports PCIe hotplug interrupts though.
>
> When do you expect pciehp to do something?  Are you hotplugging a
> physical device that is passed through to this guest?
>
> Bjorn

