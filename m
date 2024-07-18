Return-Path: <linux-pci+bounces-10535-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 828959370EF
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 01:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC9C0B22000
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 23:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D0E146A64;
	Thu, 18 Jul 2024 23:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSnR4HKU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8DC146A60;
	Thu, 18 Jul 2024 23:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721343831; cv=none; b=rBmzfeZNhBK70G4rECjrEToUtW2KfWS2GFMKq6Z7wOvMkUZja8TnaG9HPG4OrQskY0fkbbpmrbxM1kVOv2AKCa9+Em7SkmKKGKGMmnetZowZq5obeQVCVx4lISJR+YQ2qQYDSYuIGbRC8kCYMCY8gWegvMCrRL+juy4qr694mlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721343831; c=relaxed/simple;
	bh=Jf2kDNED6Tr0S0iK4RToS1Yqyo2BDO2KGz6xiv5xhvk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=p2WYrbCbrR1mkNC+hdQckaxFbfo9gm2wdMULvtsBt2XanAxlVQkrmdjt3S9aCdYSo6jt0PJDWx7nuUmKS4rf0UIehjE7/rICyUXXE5sxSd/aQqLUeJ0x6HLvTy/jot8XLbaxKq0D3pKpIA1knsUY8Kx3oo+/hMKcISwDzdtMaKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSnR4HKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5F0C4AF0F;
	Thu, 18 Jul 2024 23:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721343830;
	bh=Jf2kDNED6Tr0S0iK4RToS1Yqyo2BDO2KGz6xiv5xhvk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rSnR4HKUACHvBrwOgQYDXPMxzUxEMb3Hzgwuy8/8xhL9xRYRndjuZ8JFzDdKAuAOB
	 /+v4/rl2ptrj/CEwWwrFvXGsF2xFkHxGovkv0COAi8D+7yC9typx3JtB9iuZyIwAui
	 yfYqGNqH+JaN6G900wsClCKmi49OGZiQ6G+XhPCEl8madl2MuU+t7bH4tKai0lRlc3
	 fCYdv1ZOA4eFQdS3HuV+dGQKv5mNGwRZw9LyM2DJOekh0vXq3ZuFy0RJpB6uGOdcBb
	 ZsYVw7oRkl32/OyS2abO381wXV8TBi6aq9kNjXB1YNImAdYOSRpPVWR6yBY/xbZ7Au
	 0NjJiHzixovDQ==
Date: Thu, 18 Jul 2024 18:03:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Huacai Chen <chenhuacai@gmail.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, loongarch@lists.linux.dev,
	linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org,
	Sheng Wu <wusheng@loongson.cn>
Subject: Re: [PATCH] PCI: loongson: Add LS7A MSI enablement quirk
Message-ID: <20240718230348.GA570741@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H678eySqhLr8cYhCsrJqm1acFcRAFJY_dQOpEHkRLVAGQ@mail.gmail.com>

On Thu, Jul 18, 2024 at 09:01:17PM +0800, Huacai Chen wrote:
> On Thu, Jul 11, 2024 at 3:48 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Jul 10, 2024 at 11:04:24AM +0800, Huacai Chen wrote:
> > > On Wed, Jul 10, 2024 at 5:24 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > >
> > > > On Wed, Jun 12, 2024 at 02:53:15PM +0800, Huacai Chen wrote:
> > > > > LS7A chipset can be used as a downstream bridge which connected to a
> > > > > high-level host bridge. In this case DEV_LS7A_PCIE_PORT5 is used as the
> > > > > upward port. We should always enable MSI caps of this port, otherwise
> > > > > downstream devices cannot use MSI.
> > > >
> > > > Can you clarify this topology a bit?  Since DEV_LS7A_PCIE_PORT5
> > > > apparently has a class of PCI_CLASS_BRIDGE_HOST, I guess that in PCIe
> > > > terms, it is basically a PCI host bridge (Root Complex, if you prefer)
> > > > that is materialized as a PCI Endpoint?
> > >
> > > Now most of the existing LoongArch CPUs don't have an integrated PCIe
> > > RC, instead they have HyperTransport controllers. But the latest CPU
> > > (Loongson-3C6000) has an integrated PCIe RC and removed
> > > HyperTransport.
> > >
> > > LS7A bridge can work together with both old (HT) CPUs and new (PCIe)
> > > CPUs. If it is connected to an old CPU, its upstream port is a HT
> > > port, and DEV_LS7A_PCIE_PORT5 works as a normal downstream PCIe port.
> > > If it is connected to a new CPU, DEV_LS7A_PCIE_PORT5 works as an
> > > upstream port (the class code becomes PCI_CLASS_BRIDGE_HOST) and the
> > > HT port is idle.
> >
> > What does lspci look like for both the old HT and the new PCIe CPUs?
> When LS7A connect to HT,
> 
> 00:00.0 Host bridge: Loongson Technology LLC Hyper Transport Bridge Controller
> 00:00.1 Host bridge: Loongson Technology LLC Hyper Transport Bridge
> Controller (rev 01)
> 00:00.2 Host bridge: Loongson Technology LLC Device 7a20 (rev 01)
> 00:00.3 Host bridge: Loongson Technology LLC Device 7a30
> 00:03.0 Ethernet controller: Loongson Technology LLC Device 7a13
> 00:04.0 USB controller: Loongson Technology LLC OHCI USB Controller (rev 02)
> 00:04.1 USB controller: Loongson Technology LLC EHCI USB Controller (rev 02)
> 00:05.0 USB controller: Loongson Technology LLC OHCI USB Controller (rev 02)
> 00:05.1 USB controller: Loongson Technology LLC EHCI USB Controller (rev 02)
> 00:07.0 Audio device: Loongson Technology LLC HDA (High Definition
> Audio) Controller
> 00:08.0 SATA controller: Loongson Technology LLC Device 7a18
> 00:09.0 PCI bridge: Loongson Technology LLC Device 7a49
> 00:0d.0 PCI bridge: Loongson Technology LLC Device 7a49
> 00:0f.0 PCI bridge: Loongson Technology LLC Device 7a69
> 00:10.0 PCI bridge: Loongson Technology LLC Device 7a59
> 00:13.0 PCI bridge: Loongson Technology LLC Device 7a59
> 00:16.0 System peripheral: Loongson Technology LLC Device 7a1b
> 00:19.0 USB controller: Loongson Technology LLC Device 7a34
> 02:00.0 Non-Volatile memory controller: Shenzhen Longsys Electronics
> Co., Ltd. SM2263EN/SM2263XT-based OEM NVME SSD (DRAM-less) (rev 03)
> 04:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> [AMD/ATI] Oland [Radeon HD 8570 / R5 430 OEM / R7 240/340 / Radeon 520
> OEM] (rev 87)
> 04:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI]
> Oland/Hainan/Cape Verde/Pitcairn HDMI Audio [Radeon HD 7000 Series]
> 
> -[0000:00]-+-00.0  0014:7a00
>            +-00.1  0014:7a10
>            +-00.2  0014:7a20
>            +-00.3  0014:7a30
>            +-03.0  0014:7a13
>            +-04.0  0014:7a24
>            +-04.1  0014:7a14
>            +-05.0  0014:7a24
>            +-05.1  0014:7a14
>            +-07.0  0014:7a07
>            +-08.0  0014:7a18
>            +-09.0-[01]--
>            +-0d.0-[02]----00.0  1d97:2263
>            +-0f.0-[03]--
>            +-10.0-[04]--+-00.0  1002:6611
>            |            \-00.1  1002:aab0
>            +-13.0-[05]--
>            +-16.0  0014:7a1b
>            \-19.0  0014:7a34
> 
> DEV_LS7A_PCIE_PORT5 is 00:13.0

In this case, the DEV_LS7A_PCIE_PORT5 at 00:13.0 is a Header Type 1
(PCI-to-PCI bridge).  I assume it has a PCIe Capability that
identifies it as Root Port, and the secondary bus 05 is probably a
PCIe Link leading to a slot.

I found "lspci -v" output similar to this at
https://linux-hardware.org/?probe=ad154077da&log=lspci_all

> When LS7A connect to PCIe,
> 
> 00:00.0 Host bridge: Loongson Technology LLC Device 7a59
> 00:03.0 Ethernet controller: Loongson Technology LLC Device 7a13
> 00:04.0 USB controller: Loongson Technology LLC OHCI USB Controller (rev 02)
> 00:04.1 USB controller: Loongson Technology LLC EHCI USB Controller (rev 02)
> 00:05.0 USB controller: Loongson Technology LLC OHCI USB Controller (rev 02)
> 00:05.1 USB controller: Loongson Technology LLC EHCI USB Controller (rev 02)
> 00:06.0 Multimedia video controller: Loongson Technology LLC Device
> 7a25 (rev 01)
> 00:06.1 VGA compatible controller: Loongson Technology LLC Device 7a36 (rev 02)
> 00:06.2 Audio device: Loongson Technology LLC Device 7a37
> 00:07.0 Audio device: Loongson Technology LLC HDA (High Definition
> Audio) Controller
> 00:08.0 SATA controller: Loongson Technology LLC Device 7a18
> 00:09.0 PCI bridge: Loongson Technology LLC Device 7a49
> 00:0a.0 PCI bridge: Loongson Technology LLC Device 7a39
> 00:0b.0 PCI bridge: Loongson Technology LLC Device 7a39
> 00:0c.0 PCI bridge: Loongson Technology LLC Device 7a39
> 00:0d.0 PCI bridge: Loongson Technology LLC Device 7a49
> 00:0f.0 PCI bridge: Loongson Technology LLC Device 7a69
> 00:10.0 PCI bridge: Loongson Technology LLC Device 7a59
> 00:16.0 System peripheral: Loongson Technology LLC Device 7a1b
> 00:17.0 ISA bridge: Loongson Technology LLC LPC Controller (rev 01)
> 00:19.0 USB controller: Loongson Technology LLC Device 7a34
> 00:1c.0 PCI bridge: Loongson Technology LLC Device 3c09
> 00:1d.0 IOMMU: Loongson Technology LLC Device 3c0f
> 00:1e.0 PCI bridge: Loongson Technology LLC Device 3c09
> 02:00.0 Ethernet controller: Device 1f0a:6801 (rev 01)
> 08:00.0 PCI bridge: Loongson Technology LLC Device 3c19
> 08:01.0 PCI bridge: Loongson Technology LLC Device 3c29
> 08:02.0 PCI bridge: Loongson Technology LLC Device 3c29
> 0c:00.0 PCI bridge: Loongson Technology LLC Device 3c19
> 0c:01.0 PCI bridge: Loongson Technology LLC Device 3c19
> 0c:04.0 IOMMU: Loongson Technology LLC Device 3c0f
> 
> -[0000:00]-+-00.0  0014:7a59
>            +-03.0  0014:7a13
>            +-04.0  0014:7a24
>            +-04.1  0014:7a14
>            +-05.0  0014:7a24
>            +-05.1  0014:7a14
>            +-06.0  0014:7a25
>            +-06.1  0014:7a36
>            +-06.2  0014:7a37
>            +-07.0  0014:7a07
>            +-08.0  0014:7a18
>            +-09.0-[01]--
>            +-0a.0-[02]----00.0  1f0a:6801
>            +-0b.0-[03]--
>            +-0c.0-[04]--
>            +-0d.0-[05]--
>            +-0f.0-[06]--
>            +-10.0-[07]--
>            +-16.0  0014:7a1b
>            +-17.0  0014:7a0c
>            +-19.0  0014:7a34
>            +-1c.0-[08-0b]--+-00.0-[09]--
>            |               +-01.0-[0a]--
>            |               \-02.0-[0b]--
>            +-1d.0  0014:3c0f
>            \-1e.0-[0c-0e]--+-00.0-[0d]--
>                            +-01.0-[0e]--
>                            \-04.0  0014:3c0f
> 
> DEV_LS7A_PCIE_PORT5 becomes 00:00.0

In this case, the DEV_LS7A_PCIE_PORT5 at 00:00.0 looks like a Header
Type 0 device (not a bridge), and the bus 00 it is on is not a normal
PCIe Link.  Since it doesn't connect to a PCIe Link, 00:00.0 might not
have a PCIe Capability at all, or it could be an RCiEP.  Or it's
possible it has a PCIe Capability left over from the old model that
says it's a Root Port, although this would potentially confuse an OS.

The other bridges (00:09.0, 00:0a.0, etc) are probably PCIe Root
Ports, which are logically part of the Root Complex, so the Root
Complex would be implemented partly in the new CPU and partly in the
LS7A.

The connection between the new CPU and the LS7A might be electrically
similar to PCIe, but it's not part of a PCIe hierarchy that Linux
sees.  That connection would have to be managed in some non-PCI way,
the same as all PCI host bridges, i.e., by firmware, ACPI, or a Linux
native host bridge driver like pci-loongson.c.

Here's the current commit log:

  The LS7A chipset can be used as a downstream bridge that connects to
  a high-level host bridge, and in such case the DEV_LS7A_PCIE_PORT5
  is used as the upstream port.

  Thus, always enable MSI caps of this port, otherwise downstream
  devices cannot use MSI.

In this configuration, DEV_LS7A_PCIE_PORT5 is not a PCI-to-PCI bridge
itself.  It might be some sort of downstream end of a connection from
the CPU, but that's not really relevant here.  And DEV_LS7A_PCIE_PORT5
doesn't have any devices directly downstream from it.

I think something like this would be clearer:

  The LS7A chipset can be used as part of a PCIe Root Complex with
  Loongson-3C6000 and similar CPUs.  In this case, DEV_LS7A_PCIE_PORT5
  has a PCI_CLASS_BRIDGE_HOST class code, and it is a Type 0 Function
  whose config space provides access to Root Complex registers.

  The DEV_LS7A_PCIE_PORT5 has an MSI Capability, and its MSI Enable
  bit must be set before other devices below the Root Complex can use
  MSI.  This is not the standard PCI behavior of MSI Enable, so the
  normal PCI MSI code does not set it.

  Set the DEV_LS7A_PCIE_PORT5 MSI Enable bit via a quirk so other
  devices below the Root Complex can use MSI.

What do you think?

