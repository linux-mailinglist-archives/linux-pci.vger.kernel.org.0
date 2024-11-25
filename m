Return-Path: <linux-pci+bounces-17296-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 238D29D8EB7
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 23:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31885B227F0
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 22:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7631CDFA7;
	Mon, 25 Nov 2024 22:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="RaKQKYJ0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F961BBBD4
	for <linux-pci@vger.kernel.org>; Mon, 25 Nov 2024 22:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732574813; cv=none; b=ZcxPZ8PONTltSODkq9/yqixIMPQXXK8rRFYD1yczZ/PbYp6e6iOOtwPnR8vUXlLR8gr12F4Uuux+DfU1DxdN9tw9k+k1VuY+B9DdYuf3KSxQyM7fvRwYj7xCX70J1ywE7S5Id7Unamec7RrcwCQ1Jx7APC2rtCdOVGAbgYRIc1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732574813; c=relaxed/simple;
	bh=OubevgRiMWB/iwt325cGbtu9oU9hZnkDkZtn6akmH4o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=GLY4C3HuBwZbRY9b5BEImHaPP1V7V9X72gvHwbmXDxkTBCw0BU5vCfxlOOBDYk+phltTZj8MZ1p27n4NntE5bu38zIY1dY4RiNJn4D4ITbaPqutBveTKcid/ldGi9TAG1p83wFEyGXIRfpi2sWkcWZ2itSgeWkf9Z4yYqQ+4wPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=RaKQKYJ0; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B301B3F84B
	for <linux-pci@vger.kernel.org>; Mon, 25 Nov 2024 22:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1732574801;
	bh=OubevgRiMWB/iwt325cGbtu9oU9hZnkDkZtn6akmH4o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
	b=RaKQKYJ0jLc2s13bRy/egIAE2ZzMB83h+qfZfIiHMU7y/4/mCAyR5zTje6v8VVB2j
	 JPDZfhSu55OlBaKKCT0Oazq+sT5pJQX4EyOaVfhJi6esawTPrvyFzugJI9Sb7F4jdq
	 lpaiYlmLlvohHCMbo2UkkSuwQycCz13frELhfUtJW+FvsGd3Y88gufjK3f3MywWR6F
	 Y2qimeXXku2X8pCek87FKRIwvu/9hHCbYnfsArJfSSbvlhXnwhnfsKAOKEL2joZn7E
	 vN8Hcvpc+32BWt1hMyIeWSf76+Hb53Tad9y70acFuMRDQj/4blBnu1BqhM6jKTE/5e
	 rRKmnbbxRb63w==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5d00b88beb1so5069332a12.3
        for <linux-pci@vger.kernel.org>; Mon, 25 Nov 2024 14:46:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732574801; x=1733179601;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OubevgRiMWB/iwt325cGbtu9oU9hZnkDkZtn6akmH4o=;
        b=nT/vGLTPFIVnouB+yr2Sis8BaCEwAPIqLeOIC+tZThsJ0LamRxrUv9x7T7zg6qt5U0
         PswO/LVf9UiWNHdU6QhvAj9k3m/h962M8LM6vnb2KHxYhq/ujuB/gqdfANakkibZTwD6
         8d8EWPvKeYrkBq9zKf/HoC0zAEw/hNQ5RsHNiecT6Ji/dVy17jlVsXQ2f4RQPHNvKRo0
         E9K4u8fv13tyTNhf0Buf6NjPKUSEMl0THbwp1CBkCLlLKc3KI6QTCXPTqEefrUN8+A0p
         euLRbavcNFNlVLp8o0gW6+PIcgncetAIjpk4eyp3OjlqTnzj6TsazTrVeXtvve8Ih4Ye
         uO4g==
X-Gm-Message-State: AOJu0Ywb+/iW0EZto4/PQ+Y1nEeFnHqiSf3LSNmhxFRlPOEK5EhF44SR
	+m24t14oVqOJc+c73jXL1CqH60ZBtcGkmoT6aLF3bS8mcO2T0sUNqIVCA2j/fTYfwG4JwtaYLpm
	B4tszYotee3UVbioDfN6sE5rvJCCyPeJbfJQr+jnVxRrTYhoF/C3m7TDlQ92stxgRqwE3jtBviG
	77oIf/bfGhakfBCKdN3W4m6ssRNpA8AoBph6kUVoc0KO/8R4ZX2+N+QiSQhDo=
X-Gm-Gg: ASbGnctHc4VYyMZOs743e/Ayuzkd5k6LtguTkcBefwLtJiKt3LbAkaKeKoUvDSoNW95
	lSSKHmUj3YZ3ZO0MevLU3hl9JBoojXg==
X-Received: by 2002:a05:6402:502:b0:5d0:214b:9343 with SMTP id 4fb4d7f45d1cf-5d0214b962amr10779536a12.4.1732574800708;
        Mon, 25 Nov 2024 14:46:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1yz3LUTxqiGF6oosTIiTaCvDanaBSSbzg0RwyfHzWNbPl+WWAElMeYEwToOrnqD6mDl5R4tkbomWwHnEclno=
X-Received: by 2002:a05:6402:502:b0:5d0:214b:9343 with SMTP id
 4fb4d7f45d1cf-5d0214b962amr10779521a12.4.1732574800317; Mon, 25 Nov 2024
 14:46:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Mon, 25 Nov 2024 16:46:29 -0600
Message-ID: <CAHTA-uYp07FgM6T1OZQKqAdSA5JrZo0ReNEyZgQZub4mDRrV5w@mail.gmail.com>
Subject: drivers/pci: (and/or KVM): Slow PCI initialization during VM boot
 with passthrough of large BAR Nvidia GPUs on DGX H100
To: linux-pci@vger.kernel.org, kvm@vger.kernel.org, 
	Alex Williamson <alex.williamson@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I've been working on a bug regarding slow PCI initialization and BAR
assignment times for Nvidia GPUs passed-through to VMs on our DGX H100
that I originally believed to be an issue in OVMF, but upon further
investigation, I'm now suspecting that it may be an issue somewhere in
the kernel. (Here is the original edk2 mailing list thread, with extra
context: https://edk2.groups.io/g/devel/topic/109651206) [0]


When running the 6.12 kernel on a DGX H100 host with 4 GPUs passed
through using CPU passthrough and this virt-install command[1], VMs
using the latest OVMF version will take around 2 minutes for the guest
kernel to boot and initialize PCI devices/BARs for the GPUs.
Originally, I was investigating this as an issue in OVMF, because GPU
initialization takes much less time when our host is running an OVMF
version with this patch[2] removed (which only calculates the MMIO
window size differently). Without that patch, the guest kernel does
boot quickly, but we can only use the Nvidia GPUs within the guest if
`pci=3Dnocrs pci=3Drealloc` are set in the guest (evidently since the MMIO
windows advertised by OVMF to the kernel without this patch are
incorrect). So, the OVMF patch being present does evidently result in
correct MMIO windows and prevent us from needing those kernel options,
but the VM boot time is much slower.


In discussing this, another contributor reported slow PCIe/BAR
initialization times for large BAR Nvidia GPUs in Linux when using VMs
with SeaBIOS as well. This, combined with me not seeing any slowness
when these GPUs are initialized on the host, and the fact that this
slowness only happens when CPU passthrough is used, are leading me to
suspect that this may actually be a problem somewhere in the KVM or
vfio-pci stack. I did also attempt manually setting different MMIO
window sizes using the X-PciMmio64Mb OVMF/QEMU knob, and it seems that
any MMIO window size large enough to accommodate all GPU memory
regions does result in this slower initialization time (but also a
valid mapping).


I did some profiling of the guest kernel during boot, and I've
identified that it seems like the most time is spent in this
pci_write_config_word() call in __pci_read_base() of
drivers/pci/probe.c.[3] Each of those pci_write_config_word() calls
takes about 2 seconds, but it adds up to a significant chunk of the
initialization time since __pci_read_base() is executed somewhere
between 20-40 times in my VM boot.


As a point of comparison, I measured the time it took to hot-unplug
and re-plug these GPUs after the VM booted, and observed much more
reasonable times (under 5s for each GPU to re-initialize its memory
regions). I've also been trying to get this hotplugging working in VMs
where the GPUs aren't initially attached at boot, but in any such
configuration, the memory regions for the PCI slots that the GPUs get
attached to during hotplug are too small for the full 128GB these GPUs
require (and I have yet to figure out a way to fix that. More details
on that in [0]).


I'm wondering if any other users of Nvidia GPUs or other large BAR
GPUs in VMs with GPU and CPU passthrough have reported similar
slowness during boot, and if anyone has any insight. If you also
suspect this might be a kernel issue, and if there is anything I can
provide to help identify the root causes in that case, please let me
know.

[0] https://edk2.groups.io/g/devel/topic/109651206

[1]
virt-install --name 4gpu-vm-2 --vcpus vcpus=3D16,maxvcpus=3D16 --memory
943616 --numatune 0,mode=3Dstrict --iothreads
1,iothreadids.iothread0.id=3D1 --cputune
emulatorpin.cpuset=3D55,167,iothreadpin0.iothread=3D1,iothreadpin0.cpuset=
=3D54,166,vcpupin0.vcpu=3D0,vcpupin0.cpuset=3D16,vcpupin1.vcpu=3D1,vcpupin1=
.cpuset=3D128,vcpupin2.vcpu=3D2,vcpupin2.cpuset=3D17,vcpupin3.vcpu=3D3,vcpu=
pin3.cpuset=3D129,vcpupin4.vcpu=3D4,vcpupin4.cpuset=3D18,vcpupin5.vcpu=3D5,=
vcpupin5.cpuset=3D130,vcpupin6.vcpu=3D6,vcpupin6.cpuset=3D19,vcpupin7.vcpu=
=3D7,vcpupin7.cpuset=3D131,vcpupin8.vcpu=3D8,vcpupin8.cpuset=3D20,vcpupin9.=
vcpu=3D9,vcpupin9.cpuset=3D132,vcpupin10.vcpu=3D10,vcpupin10.cpuset=3D21,vc=
pupin11.vcpu=3D11,vcpupin11.cpuset=3D133,vcpupin12.vcpu=3D12,vcpupin12.cpus=
et=3D22,vcpupin13.vcpu=3D13,vcpupin13.cpuset=3D134,vcpupin14.vcpu=3D14,vcpu=
pin14.cpuset=3D23,vcpupin15.vcpu=3D15,vcpupin15.cpuset=3D135
--os-variant ubuntu22.04 --graphics none --noautoconsole --boot
loader=3D/usr/share/OVMF/OVMF_CODE_4M.fd,loader_ro=3Dyes,loader_type=3Dpfla=
sh
--console pty,target_type=3Dserial --network network:default --network
network:private-net --import --disk
path=3D/var/lib/libvirt/images/4gpu-vm-2.qcow2,format=3Dqcow2,driver.queues=
=3D16,driver.iothread=3D1
--host-device 1b:00.0,address.type=3Dpci --host-device
61:00.0,address.type=3Dpci --host-device c3:00.0,address.type=3Dpci
--host-device df:00.0,address.type=3Dpci

[2] https://github.com/tianocore/edk2/commit/ecb778d0ac62560aa172786ba19521=
f27bc3f650

[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/pci/probe.c?h=3Dv6.12#n251

Thanks,
--=20
Mitchell Augustin
Software Engineer - Ubuntu Partner Engineering

