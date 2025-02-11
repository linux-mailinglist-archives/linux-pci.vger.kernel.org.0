Return-Path: <linux-pci+bounces-21235-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4455DA31859
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 23:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0850161A7C
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 22:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0D3268C7B;
	Tue, 11 Feb 2025 22:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="IACazbVJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="urQjZ87Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AB9268FC4;
	Tue, 11 Feb 2025 22:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739311225; cv=none; b=r4h2kZyjmP9eKGg4cnJwYBKYbrbDIMy08mi5AiCntDKBQoSqYltdhrQUnSAWnVOnbONk9MsPwcHT78eMVl0xP5KcTuetcU8pKjAYPuNcTTXvF7D0aokA9XOcFgx7zFwVIf4EGUt69xPduaNn4b+PtUbRdPNknya+WkRBi1wA/Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739311225; c=relaxed/simple;
	bh=lW3UwyDr2I/ENsb8Jco5YCmUTbiZO2iEDsoALXd/HCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRG9vSs67AyAIhGbFGA5djftXd966CPSwD1w1ROdztpenY3s3AtwICtckATkTZHunlUIbMyK23/VuoLI/JL5txDLODHOwdObj4UAucr/X8ADZG9NyCh3nTxs6vwZqemIr4bQpChbGz4tg80+cPJHlZTAv/gveZEmucJFD9CkMJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=IACazbVJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=urQjZ87Q; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 90CFC2540108;
	Tue, 11 Feb 2025 17:00:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 11 Feb 2025 17:00:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739311222; x=1739397622; bh=xDuUeB511X
	EsJ9aYOfz6uSdSV2r8Wn7+ToSuq8Neosk=; b=IACazbVJOr+/0SV8BsMXSE+z01
	lCpbKPtnxbDGVGxGRE3QS2Xy8meAwFT+JKkkmce4PswzzLsvVMEiAne+5DxO0TOA
	fwmrBCuzcF4d6btWxTILkOaTZkPqWczwubjy40swu5Hd+oNXUv/jjPzyrzAE4XDa
	gUATO6Lk4FD/21bo33w9LV/EAZAyG5sE1hSP7fppZwUd1umnbKSjnqSxBWeRMnaJ
	EZV2G3NV3sg2MqCw5BpuWi4n5HWBMMGTCZdod9l7OzgS6GZiXhcr7zYDUM82+yQ7
	ROvpJqv87czY5o0Qwr7yU320T9zZHJAsoVy7uoKO7+FgC7t05BtQfjCo4LWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739311222; x=1739397622; bh=xDuUeB511XEsJ9aYOfz6uSdSV2r8Wn7+ToS
	uq8Neosk=; b=urQjZ87Q+1ik9N9K4932mTz4AwnK7D7SP6E6m3yHL0A8u8kYJGO
	qUbLopmtZxzNBeOT3yQMd48Xcggg1WLyFOD7+oFN5+VFFuC3IAEEzPQH1UMO0b55
	6F11nzlF7JEa7Aco73pNDKGylePOHEKTsfXWf+Mlbmd5kpkOae7I1V1+r/NzR6B9
	ZDU2RxuzQd21hubzEJqNHgemVd+2MDeK4dWGTTZS6svVQHm6IYGPDruvbiuNBYNk
	zQL6xkDy9G1GNFUs9iGBX2itPB7jhBoD7NTnWJTHS1WJ0c3WyrAeqFI5BEPVHdph
	wihIF3TdLehwwvjtWNBeAS4ziHlf/DQtBzg==
X-ME-Sender: <xms:dcirZ24nFMi7PqRO0O11AaBDIx7DDsJoixzFGp3tFsgpWEL6i-Ws6Q>
    <xme:dcirZ_65X1EpZVynSs0tHoZEUAMNUU_LHtCTSo2eXrczMT3M68gaVKfl52raHls7i
    F_mggY4qZ_tpp3gpdw>
X-ME-Received: <xmr:dcirZ1e9ZFgBmCMFGosNnvbA--_D5nrTVS9iC95eeOZoVkFdJFn6TS9J5iJ15U7T-rYIzC1kWW4OSwBQ-9KBqON4kMvKwMpp0Oc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegvddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdej
    necuhfhrohhmpeflrghnnhgvucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqne
    cuggftrfgrthhtvghrnhepgfdvffevleegudejfeefheehkeehleehfefgjefffeetudeg
    tefhuedufeehfeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhesjhgrnhhnrghurdhnvghtpdhnsggprhgtphhtthhopeelpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegrlhihshhsrgesrhhoshgvnhiifigvihhgrdhiohdprhgtphhtthhopehl
    phhivghrrghlihhsiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhifsehlihhnuh
    igrdgtohhmpdhrtghpthhtohepmhgrnhhivhgrnhhnrghnrdhsrgguhhgrshhivhgrmhes
    lhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhi
    nhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:dcirZzI0GGjQ4J6wInV6X-5tJrPBC7D13yptVE6PkG3hvnNJ03z8Ug>
    <xmx:dcirZ6LpjsflYJ3c2aYevprO4vUuRwWRCtkad4rM2ZnktWVYr2FMYw>
    <xmx:dcirZ0yi_7uAVY85f9LmDeb6CYQH0QAEWQIoE_fBgEgnmFa6UjyaSA>
    <xmx:dcirZ-LzVbDLYCONsCA1qXje9Fa_n813Nr162mOs5BMfkX1HR-FzWA>
    <xmx:dsirZ3XFSiL0kdNevTWXDfmOU42Zc9Yr5vVe_Pk3Beg13lztpUT9igB1>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Feb 2025 17:00:21 -0500 (EST)
Date: Tue, 11 Feb 2025 23:00:19 +0100
From: Janne Grunau <j@jannau.net>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: apple: Add depends on PAGE_SIZE_16KB
Message-ID: <20250211220019.GC810942@robin.jannau.net>
References: <20250211-pci-16k-v1-1-7fc7b34327f2@rosenzweig.io>
 <20250211183859.GA51030@bhelgaas>
 <20250211195601.GB810942@robin.jannau.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250211195601.GB810942@robin.jannau.net>

On Tue, Feb 11, 2025 at 08:56:04PM +0100, Janne Grunau wrote:
> On Tue, Feb 11, 2025 at 12:38:59PM -0600, Bjorn Helgaas wrote:
> > On Tue, Feb 11, 2025 at 01:03:52PM -0500, Alyssa Rosenzweig wrote:
> > > From: Janne Grunau <j@jannau.net>
> > > 
> > > The iommu on Apple's M1 and M2 supports only a page size of 16kB and is
> > > mandatory for PCIe devices. Mismatched page sizes will render devices
> > > useless due to non-working DMA. While the iommu prints a warning in this
> > > scenario, it seems a common and hard to debug problem, so prevent it at
> > > build-time.
> > 
> > Can we include a sample iommu warning here to help people debug this
> > problem?
> 
> I don't remember and it might have changed in the meantime due to iommu
> subsystem changes. What currently happens is that
> apple_dart_attach_dev_identity() fails with -EINVAL. I can't say whether
> that results in a failure to probe now. I'll test and report back.

Using a kernel with 4K page size It results now in following warning per
PCI device:

| ------------[ cut here ]------------
| WARNING: CPU: 7 PID: 260 at drivers/iommu/iommu.c:2979 iommu_setup_default_domain+0x348/0x590
| Modules linked in: sm4_ce_gcm(-) tg3(+) nvme_apple(+) apple_sart nvme_core snd_soc_apple_mca clk_apple_nco snd_pcm_dmaengine apple_admac i2c_pasemi_platform apple_dart apple_soc_cpufreq i2c_pasemi_core
| CPU: 7 UID: 0 PID: 260 Comm: systemd-udevd Not tainted 6.14.0-rc1+ #asahi-dev
| Hardware name: Apple Mac mini (M1, 2020) (DT)
| pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
| pc : iommu_setup_default_domain+0x348/0x590
| lr : iommu_setup_default_domain+0x340/0x590
| sp : ffffffc082c3b6b0
| x29: ffffffc082c3b6b0 x28: 0000000000000000 x27: ffffffc082c3bcc0
| x26: ffffffc082c3bbc0 x25: ffffffc0817d12f8 x24: ffffffc0816bf6c4
| x23: 0000000000000000 x22: ffffff80301d5400 x21: ffffff80301d5448
| x20: ffffffc079a332b8 x19: 00000000ffffffea x18: 0000000000000000
| x17: 00000000007bb020 x16: 0000000000000020 x15: 0000000000000004
| x14: 0000000000000002 x13: 0000000000000001 x12: 0000000000000000
| x11: 0000000000000000 x10: 0000000000082630 x9 : ffffffc0808e7ad4
| x8 : 0101010101010101 x7 : 0000000000000000 x6 : 0304000af2f9adf2
| x5 : ffffff803030a480 x4 : ffffff81dfb29d40 x3 : 0000000000000001
| x2 : ffffffc079a2d408 x1 : ffffff80266f60c8 x0 : 00000000ffffffea
| Call trace:
|  iommu_setup_default_domain+0x348/0x590 (P)
|  __iommu_probe_device+0x340/0x3f8
|  iommu_probe_device+0x3c/0x88
|  of_iommu_configure+0xa8/0x258
|  of_dma_configure_id+0x114/0x2a0
|  pci_dma_configure+0x5c/0xc0
|  really_probe+0x7c/0x3a0
|  __driver_probe_device+0x84/0x160
|  driver_probe_device+0x44/0x130
|  __driver_attach+0xcc/0x208
|  bus_for_each_dev+0x90/0x100
|  driver_attach+0x2c/0x40
|  bus_add_driver+0x118/0x250
|  driver_register+0x70/0x140
|  __pci_register_driver+0x4c/0x60
|  tg3_driver_init+0x30/0xff8 [tg3]
|  do_one_initcall+0x60/0x2a0
|  do_init_module+0x5c/0x228
|  load_module+0x1aec/0x20d8
|  init_module_from_file+0x90/0xe0
|  __arm64_sys_finit_module+0x274/0x380
|  invoke_syscall.constprop.0+0x58/0xf0
|  do_el0_svc+0x48/0xe8
|  el0_svc+0x34/0x148
|  el0t_64_sync_handler+0x10c/0x140
|  el0t_64_sync+0x198/0x1a0
| ---[ end trace 0000000000000000 ]---

In addition the ethernet device for the connected tg3 does not exists
and PCIe xhci_hcd spews following errors:

| xhci_hcd 0000:02:00.0: Abort failed to stop command ring: -110
| xhci_hcd 0000:02:00.0: xHCI host controller not responding, assume dead
| xhci_hcd 0000:02:00.0: HC died; cleaning up
| xhci_hcd 0000:02:00.0: Error while assigning device slot ID: Command Aborted
| xhci_hcd 0000:02:00.0: Max number of devices this xHCI host supports is 32.
| usb usb1-port1: couldn't allocate usb_device
| usb usb2-port1: couldn't allocate usb_device

This is much less sutle than I remember up to the point that I'm not
sure if this change is still needed.

Silently disabled CONFIG_* due to missing dependencies aren't nice either.

Janne

