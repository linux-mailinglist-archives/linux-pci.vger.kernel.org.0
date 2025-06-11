Return-Path: <linux-pci+bounces-29463-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E58CEAD5B73
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 18:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DBB316677F
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 16:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B611DED53;
	Wed, 11 Jun 2025 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkMsjG4u"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0349C1DF73C
	for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657932; cv=none; b=MTDiLkkAXQMaF8y8YTDnSCHDpmqAE8566c7xJRKktt/OCUm8iFbFjVLBT6QmAIMN9Utuuj/3tGglDFsFHp6awZ2hhsxESYNx/1JVqInuJ67yqqZrytdvug+zF5Tq/11Rj4CbkMSkb/As9lc5vzvvlpDg9ic4ZQcgST8HhVIp9e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657932; c=relaxed/simple;
	bh=7wmqiPsvxGfeCH4f6WeqvHm88EnfiCdsUSXBOJXnB9U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rktvfw9R07IGcdd+/L2yXpQHNdAnx6MsRcSSNCfetKUjlWwHXP/+NrpcCBdJuL61AbevmsJ4IxqIP9D9CUSYid1SWmJjOZ0Q2xXZAs2CkPfwrrnhDzdu/KKOPapj3FQZyhqAulHKtGBVuV2NfUteFslyOWMgb307Iqy8zJy/V5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CkMsjG4u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749657929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UOTzSx3hSNNW9qYVbicslBj/vCuzGZpIcZF1g4ZeIbo=;
	b=CkMsjG4uDEU+hrxu7zeZeoHD8eO78SsSyJIvjRvnljp988HzEjcytrAXleTey+6emV0S86
	hYLBvjiioyohJMKMofsEpU6T8aSN+2gQJM956AjJnTjLUPezyRHzZRDcUwTmrIlPK/16J6
	mD6ns/6JYMgTxfFtif52PWETvSJCmLg=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-VRpG8AIQMsSA13HwGXyUxg-1; Wed, 11 Jun 2025 12:05:27 -0400
X-MC-Unique: VRpG8AIQMsSA13HwGXyUxg-1
X-Mimecast-MFC-AGG-ID: VRpG8AIQMsSA13HwGXyUxg_1749657926
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-86cfa305eb6so716439f.0
        for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 09:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749657926; x=1750262726;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UOTzSx3hSNNW9qYVbicslBj/vCuzGZpIcZF1g4ZeIbo=;
        b=mkVokGCkhXNnbgJEeaZefSYfBbZoDIMG/yNgVrqCBaF7CO8ZW4pWLLhDFANc7D/FU8
         UmUUilhrFUv5Yxeih4dwEizvsFdn+j2gQiuhxTJBj7YnrNsgwxfJs0+GDzJZaQ3pRnkH
         dxHaQ37iBx715jiVYX4kvemvhKwj7fVb6NfCLiE4vGGeguNRrUf79aobeNedJoOUmeoD
         PgmNkiXvwkAqycuECB1LdZx23fQMide/8KW0eh84n4bqBqmlIPvuWiVBrotmPQgAx0Fx
         kN73L8UrWtNtH1w8jlrUNlIDM8P7TNi83F3hFUS949zscySkZ0ofx/kfKufgR5w+I2bg
         ss6g==
X-Forwarded-Encrypted: i=1; AJvYcCVLd0hEC5+wKyLZsGNMvqe4bxT8bWLJkGP9+CFIugasxXjXKw8T8HRWDL+trpuxf9tpLjzwr4P76JU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh/yqtheAk9BM0ms8uM/k4f9sNe8bN8JhfSBOtcTnZVWb7Yvby
	yYzfJwtPY9JJpyIW7JbGV6yUbn+OUUIJN4RdLPT64+96NxICblCMXsknGxdQs2lxhee/I22cTFm
	ZOGQz0uKbzaJDCiCZia3Y9yT0GflQZhXGK4mkNaoXzP1Pii7hCxK+4Hw3UZaTfQ==
X-Gm-Gg: ASbGncu4nXSXY6xlkUEluRvvAx7KFI7S0FtoaQFHcLx5edH8eS4QmA2rtLirCJGVioS
	FPmVO6LJY5meNAUW2wJL4iPcDhhdasvw4k2k7F99tgvCPU5DdpJlAVvHsC/WGA6IyzonqHhuOhO
	fvICvrtUdUxoyYn6xr8aPHrsz/xFI4hKTuOgNOVI9X+xc+D/iLTJyb1OotnAEPtHkGCYoCF+6B6
	FYkk12K+w3JUXfqLeCI3f+VzuVynN7zqCx6tkYmc2B7Hsg7yPc+o+xh+vCrzSJ7N/UCtooaUy3Q
	Wq663HHA8kwr5/ejOupSzDglRA==
X-Received: by 2002:a05:6602:6014:b0:875:9e30:c7db with SMTP id ca18e2360f4ac-875bc517116mr141141339f.4.1749657926418;
        Wed, 11 Jun 2025 09:05:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWthR/cqEpKFTBkDmPTXiCl5jV+NKEZWEqCTysLuWW1Llf9gUeFIONlY160WVMHcjQbqIxvQ==
X-Received: by 2002:a05:6602:6014:b0:875:9e30:c7db with SMTP id ca18e2360f4ac-875bc517116mr141138239f.4.1749657925823;
        Wed, 11 Jun 2025 09:05:25 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5012aaf7b15sm438881173.144.2025.06.11.09.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 09:05:24 -0700 (PDT)
Date: Wed, 11 Jun 2025 10:05:23 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: nicolas.dichtel@6wind.com, Bjorn Helgaas <helgaas@kernel.org>,
 mario.limonciello@amd.com, bhelgaas@google.com, rafael.j.wysocki@intel.com,
 huang.ying.caritas@gmail.com, stern@rowland.harvard.edu,
 linux-pci@vger.kernel.org, Olivier MATZ <olivier.matz@6wind.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v2] PCI: Explicitly put devices into D0 when
 initializing
Message-ID: <20250611100523.5b5bb99b.alex.williamson@redhat.com>
In-Reply-To: <f81db934-5109-4e6e-aebb-7b874f98329f@kernel.org>
References: <20250505230632.GA1007257@bhelgaas>
	<3d09359f-6e38-4e48-9d4e-6bc203c49e61@6wind.com>
	<f81db934-5109-4e6e-aebb-7b874f98329f@kernel.org>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Jun 2025 07:56:21 -0700
Mario Limonciello <superm1@kernel.org> wrote:

> On 6/11/2025 7:14 AM, Nicolas Dichtel wrote:
> > Le 06/05/2025 =C3=A0 01:06, Bjorn Helgaas a =C3=A9crit=C2=A0: =20
> >> On Wed, Apr 23, 2025 at 11:31:32PM -0500, Mario Limonciello wrote: =20
> >>> From: Mario Limonciello <mario.limonciello@amd.com>
> >>>
> >>> AMD BIOS team has root caused an issue that NVME storage failed to co=
me
> >>> back from suspend to a lack of a call to _REG when NVME device was pr=
obed.
> >>>
> >>> commit 112a7f9c8edbf ("PCI/ACPI: Call _REG when transitioning D-state=
s")
> >>> added support for calling _REG when transitioning D-states, but this =
only
> >>> works if the device actually "transitions" D-states.
> >>>
> >>> commit 967577b062417 ("PCI/PM: Keep runtime PM enabled for unbound PCI
> >>> devices") added support for runtime PM on PCI devices, but never actu=
ally
> >>> 'explicitly' sets the device to D0.
> >>>
> >>> To make sure that devices are in D0 and that platform methods such as
> >>> _REG are called, explicitly set all devices into D0 during initializa=
tion.
> >>>
> >>> Fixes: 967577b062417 ("PCI/PM: Keep runtime PM enabled for unbound PC=
I devices")
> >>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com> =20
> >>
> >> Applied to pci/pm for v6.16, thanks!
> >> =20
> >=20
> > I've a regression after this commit.
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D4d4c10f763d7
> >=20
> > I've started a QEMU with "-cpu host" on an AMD (AMD Ryzen 5 3600 6-Core
> > Processor) machine + virtio-net interfaces. When I try to start a testp=
md (a
> > DPDK app), it cannot find the virtio port. The ioctl VFIO_GROUP_GET_DEV=
ICE_FD fails.
> >=20
> > To reproduce the issue:
> > qemu-system-x86_64 --enable-kvm -m 5G -cpu host \
> > 	-smp sockets=3D1,cores=3D2,threads=3D2 \
> > 	-snapshot -vga none -display none -nographic \
> > 	-drive if=3Dnone,file=3D/opt/vm/ubuntu-24.04-with-linux-net.qcow2,id=
=3Dhda \
> > 	-device virtio-blk,drive=3Dhda \
> > 	-device virtio-net,netdev=3Deth0,addr=3D03 -netdev user,id=3Deth0 \
> > 	-device virtio-net,netdev=3Deth1,addr=3D04 -netdev socket,id=3Deth1,mc=
ast=3D230.0.0.1:1234
> >=20
> > git clone git://dpdk.org/dpdk
> > cd dpdk/
> > meson build-static --werror --default-library=3Dstatic --debug
> > ninja -C build-static
> > echo 3 > /proc/sys/vm/drop_caches
> > echo 256 > /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr=
_hugepages
> > modprobe vfio-pci
> > lspci
> > python3 ./usertools/dpdk-devbind.py --noiommu-mode -b vfio-pci 0000:00:=
04.0
> > ./build-static/app/dpdk-testpmd -l 1,2 --socket-mem 512,0 -a 0000:00:04=
.0 -- -i
> >=20
> > Here is the output:
> > EAL: Detected CPU lcores: 4
> > EAL: Detected NUMA nodes: 1
> > EAL: Detected static linkage of DPDK
> > EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
> > EAL: Selected IOVA mode 'PA'
> > EAL: VFIO support initialized
> > EAL: Using IOMMU type 8 (No-IOMMU)
> > EAL: Getting a vfio_dev_fd for 0000:00:04.0 failed
> > PCI_BUS: Cannot get offset of region 0.
> > PCI_BUS: fail to disable req notifier.
> > PCI_BUS: fail to disable req notifier.
> > VIRTIO_INIT: eth_virtio_pci_init(): Failed to init PCI device
> > PCI_BUS: Requested device 0000:00:04.0 cannot be used
> > EAL: Bus (pci) probe failed.
> > testpmd: No probed ethernet devices
> > Interactive-mode selected
> > testpmd: create a new mbuf pool <mb_pool_0>: n=3D155456, size=3D2176, s=
ocket=3D0
> > testpmd: preferred mempool ops selected: ring_mp_mc
> > Done =20
> > testpmd> =20
> >  =20
> > =3D> the problem starts at the line "Getting a vfio_dev_fd for 0000:00:=
04.0 failed" =20
> > https://git.dpdk.org/dpdk/tree/lib/eal/linux/eal_vfio.c#n966
> >=20
> > FWIW, here is the output when it starts correctly:
> > EAL: Detected CPU lcores: 4
> > EAL: Detected NUMA nodes: 1
> > EAL: Detected static linkage of DPDK
> > EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
> > EAL: Selected IOVA mode 'PA'
> > EAL: VFIO support initialized
> > EAL: Using IOMMU type 8 (No-IOMMU)
> > Interactive-mode selected
> > Warning: NUMA should be configured manually by using --port-numa-config=
 and
> > --ring-numa-config parameters along with --numa.
> > testpmd: create a new mbuf pool <mb_pool_0>: n=3D155456, size=3D2176, s=
ocket=3D0
> > testpmd: preferred mempool ops selected: ring_mp_mc
> >=20
> > Warning! port-topology=3Dpaired and odd forward ports number, the last =
port will
> > pair with itself.
> >=20
> > Configuring Port 0 (socket 0)
> > EAL: Error disabling MSI-X interrupts for fd 277
> > Port 0: DE:ED:01:E0:1B:75
> > Checking link statuses...
> > Done =20
> > testpmd> =20
> >=20
> > Any help would be appreciated.
> >=20
> > Regards,
> > Nicolas =20
>=20
> +AlexW
>=20
> Thanks for the report and especially for the repro steps.  This sounds=20
> just like the one reported for the QAT regression also in this thread.
>=20
> https://lore.kernel.org/linux-pci/aEmS+OQL7IbjdwKs@gcabiddu-mobl.ger.corp=
.intel.com/T/#m7e8929d6421690dc8bd6dc639d86c2b4db27cbc4
>=20
> I'm traveling this week, but as your report doesn't have a dependency on=
=20
> QAT hardware I will try to reproduce next week to understand what's=20
> going on.
>=20
> Alex - if you have any ideas please let me know.

Note that this instantiation of the virtio-net device creates it as a
non-PCIe device, where QEMU only seems to create a PM capability when
the device is exposed as PCIe.  Therefore this could also be a
manifestation that we've made pm_runtime initialization dependent on
the device having a PM capability.  Thanks,

Alex


