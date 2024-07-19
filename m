Return-Path: <linux-pci+bounces-10538-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5A69373FB
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 08:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AF751C20AB6
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 06:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F34037703;
	Fri, 19 Jul 2024 06:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbBseCqV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A661B86E7;
	Fri, 19 Jul 2024 06:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721370226; cv=none; b=Dy9kr0Mo0kOvtGph/XtDRm689zWWv2y37qgcZl56Gash790RQiBq0yUnHkSBSLN3PhXApIy2+odmy5Q+mOUDpPp9+QrGIeEl0QhxcTDp/odhz53Ax7dDUPBkAzEqxHJChbA18mLDHUMfc1UITjWMV5gW0eTgaHnRtJGDv+j7198=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721370226; c=relaxed/simple;
	bh=Vt4mIRkn8xc9CmlhcrNUhRtAmdsPN12lwNVEnTVROjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OVoxR67RfpHTxEsmhJl67NPY8VK+rcOKzSgzxn/zy5pQXYTJ/Z8jZjXN776+UPS31l6UlvbyZ0lN0DtrgLH812qs08qgMx13dE9yZGZni0FfZaAGzBpTyYEFK8J4+fpYsdGhhzxoCEgUSXRcdMve6DORD3qv5kh2b091BikADqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbBseCqV; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eeb2d60efbso24561681fa.1;
        Thu, 18 Jul 2024 23:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721370222; x=1721975022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=427LWVWLeZhkBwKLb51oPsGE5tn2zlb2p54ZRNRxztk=;
        b=nbBseCqVyKq2cYlBUwbSnXJ2vk/3KSQ/Rhg93z3b3Fdwk+XwkktS3OeUlEbQByFspg
         Ksy6rqLVp3BtcNlOeBNvE+yAyZDBJO8Co0HdzgGz+aW9O/P1ntWD5/sj5svkO6CVdUYl
         YS6h52NhL18ayuWDWQGTpi+HxDHCZ9nvRsChFTbIGPYAG6UFuhJHZkqM757vrfl/5OxY
         xhTp6wr/lbxUqqS88INKvdq3MEeJSrvkmQ56Fq0FQjvvIyC2PEi3RH/OV22DmCQ3TYv3
         PJErbC9KdQ6irWpbekI/jjccwp9sY4alxWiJmo4u9t4/ezrCHvcKJrWPQ062LgfQjlkD
         tJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721370222; x=1721975022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=427LWVWLeZhkBwKLb51oPsGE5tn2zlb2p54ZRNRxztk=;
        b=sy5IKtZJVnkDnbBpY2eIfQ7jzjHC2XDpOzSqVYKIuDv+6wjiflKLj51Usza+oAmLXB
         u2rMb9jJg1BwsvOUH2WJWtuURmABsBkoAN1lo+8q2ECM8erfEk3E8DyJOtOK5Pd2Zxd3
         kgyj20hIeUH8Rs/FhFHPiyGBBufIeP1ChpeilD6LbDlp+AihWVi0bTWSv4/7Buf3StJV
         9BAS6R+HjU6KxDoEF3sVZhH5P6H2z/uT2+A5uKbVnuhQ5kFxMANARtUmcd54Uv1RH4Mb
         Gv7OpzGUAYjhtW9fGvLPQzH5zqkJxpt72umd0H2I55FMEw0fvh7WpVu89ftBrST9GTBP
         z2ag==
X-Forwarded-Encrypted: i=1; AJvYcCWhqZOP8iftTzJ6zk5bTXvbvm6XRT+FBNxSJc/Z02nXpc+U7KWHkEymTvCxpN5QpTZQvkJphLXk9Jja4BUilSWE2S9rwvjajGhOxxmRVcm3AKXaEjdMHPqvCzDHpUnqeMxh
X-Gm-Message-State: AOJu0YykLxvy9NktI4hcLt3zxYC3WHPq0C82IrCYdi6ViesDo6T5By2V
	8xUlpcL+Hcqo6pDCoZapv+Ywsgtcv9sopv2vKjLYDC4rtuTPMIAy8rSKOVGkBr3XQdF5eonJkzB
	5Dvy63tHni1j5zcZznuI/C2MkyVk=
X-Google-Smtp-Source: AGHT+IH5txtRBRZ3wRQoNhcn6wucKzbpc0F8FBggv57SHHFI5M4lMOxeVuTL7ydZcEacDT9MRatW0Bg5jGpm5hzfNOs=
X-Received: by 2002:a2e:99d2:0:b0:2ee:8ce9:5ad2 with SMTP id
 38308e7fff4ca-2ef05c9f9a4mr28529601fa.23.1721370221236; Thu, 18 Jul 2024
 23:23:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAhV-H678eySqhLr8cYhCsrJqm1acFcRAFJY_dQOpEHkRLVAGQ@mail.gmail.com>
 <20240718230348.GA570741@bhelgaas>
In-Reply-To: <20240718230348.GA570741@bhelgaas>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Fri, 19 Jul 2024 14:23:28 +0800
Message-ID: <CAAhV-H4Pr6hE3_KiHT8hUkbaTooN9irt7yQGfBvzdyvwkN12OA@mail.gmail.com>
Subject: Re: [PATCH] PCI: loongson: Add LS7A MSI enablement quirk
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, loongarch@lists.linux.dev, linux-pci@vger.kernel.org, 
	Jianmin Lv <lvjianmin@loongson.cn>, Xuefeng Li <lixuefeng@loongson.cn>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org, 
	Sheng Wu <wusheng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 7:03=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Thu, Jul 18, 2024 at 09:01:17PM +0800, Huacai Chen wrote:
> > On Thu, Jul 11, 2024 at 3:48=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:
> > > On Wed, Jul 10, 2024 at 11:04:24AM +0800, Huacai Chen wrote:
> > > > On Wed, Jul 10, 2024 at 5:24=E2=80=AFAM Bjorn Helgaas <helgaas@kern=
el.org> wrote:
> > > > >
> > > > > On Wed, Jun 12, 2024 at 02:53:15PM +0800, Huacai Chen wrote:
> > > > > > LS7A chipset can be used as a downstream bridge which connected=
 to a
> > > > > > high-level host bridge. In this case DEV_LS7A_PCIE_PORT5 is use=
d as the
> > > > > > upward port. We should always enable MSI caps of this port, oth=
erwise
> > > > > > downstream devices cannot use MSI.
> > > > >
> > > > > Can you clarify this topology a bit?  Since DEV_LS7A_PCIE_PORT5
> > > > > apparently has a class of PCI_CLASS_BRIDGE_HOST, I guess that in =
PCIe
> > > > > terms, it is basically a PCI host bridge (Root Complex, if you pr=
efer)
> > > > > that is materialized as a PCI Endpoint?
> > > >
> > > > Now most of the existing LoongArch CPUs don't have an integrated PC=
Ie
> > > > RC, instead they have HyperTransport controllers. But the latest CP=
U
> > > > (Loongson-3C6000) has an integrated PCIe RC and removed
> > > > HyperTransport.
> > > >
> > > > LS7A bridge can work together with both old (HT) CPUs and new (PCIe=
)
> > > > CPUs. If it is connected to an old CPU, its upstream port is a HT
> > > > port, and DEV_LS7A_PCIE_PORT5 works as a normal downstream PCIe por=
t.
> > > > If it is connected to a new CPU, DEV_LS7A_PCIE_PORT5 works as an
> > > > upstream port (the class code becomes PCI_CLASS_BRIDGE_HOST) and th=
e
> > > > HT port is idle.
> > >
> > > What does lspci look like for both the old HT and the new PCIe CPUs?
> > When LS7A connect to HT,
> >
> > 00:00.0 Host bridge: Loongson Technology LLC Hyper Transport Bridge Con=
troller
> > 00:00.1 Host bridge: Loongson Technology LLC Hyper Transport Bridge
> > Controller (rev 01)
> > 00:00.2 Host bridge: Loongson Technology LLC Device 7a20 (rev 01)
> > 00:00.3 Host bridge: Loongson Technology LLC Device 7a30
> > 00:03.0 Ethernet controller: Loongson Technology LLC Device 7a13
> > 00:04.0 USB controller: Loongson Technology LLC OHCI USB Controller (re=
v 02)
> > 00:04.1 USB controller: Loongson Technology LLC EHCI USB Controller (re=
v 02)
> > 00:05.0 USB controller: Loongson Technology LLC OHCI USB Controller (re=
v 02)
> > 00:05.1 USB controller: Loongson Technology LLC EHCI USB Controller (re=
v 02)
> > 00:07.0 Audio device: Loongson Technology LLC HDA (High Definition
> > Audio) Controller
> > 00:08.0 SATA controller: Loongson Technology LLC Device 7a18
> > 00:09.0 PCI bridge: Loongson Technology LLC Device 7a49
> > 00:0d.0 PCI bridge: Loongson Technology LLC Device 7a49
> > 00:0f.0 PCI bridge: Loongson Technology LLC Device 7a69
> > 00:10.0 PCI bridge: Loongson Technology LLC Device 7a59
> > 00:13.0 PCI bridge: Loongson Technology LLC Device 7a59
> > 00:16.0 System peripheral: Loongson Technology LLC Device 7a1b
> > 00:19.0 USB controller: Loongson Technology LLC Device 7a34
> > 02:00.0 Non-Volatile memory controller: Shenzhen Longsys Electronics
> > Co., Ltd. SM2263EN/SM2263XT-based OEM NVME SSD (DRAM-less) (rev 03)
> > 04:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> > [AMD/ATI] Oland [Radeon HD 8570 / R5 430 OEM / R7 240/340 / Radeon 520
> > OEM] (rev 87)
> > 04:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI]
> > Oland/Hainan/Cape Verde/Pitcairn HDMI Audio [Radeon HD 7000 Series]
> >
> > -[0000:00]-+-00.0  0014:7a00
> >            +-00.1  0014:7a10
> >            +-00.2  0014:7a20
> >            +-00.3  0014:7a30
> >            +-03.0  0014:7a13
> >            +-04.0  0014:7a24
> >            +-04.1  0014:7a14
> >            +-05.0  0014:7a24
> >            +-05.1  0014:7a14
> >            +-07.0  0014:7a07
> >            +-08.0  0014:7a18
> >            +-09.0-[01]--
> >            +-0d.0-[02]----00.0  1d97:2263
> >            +-0f.0-[03]--
> >            +-10.0-[04]--+-00.0  1002:6611
> >            |            \-00.1  1002:aab0
> >            +-13.0-[05]--
> >            +-16.0  0014:7a1b
> >            \-19.0  0014:7a34
> >
> > DEV_LS7A_PCIE_PORT5 is 00:13.0
>
> In this case, the DEV_LS7A_PCIE_PORT5 at 00:13.0 is a Header Type 1
> (PCI-to-PCI bridge).  I assume it has a PCIe Capability that
> identifies it as Root Port, and the secondary bus 05 is probably a
> PCIe Link leading to a slot.
>
> I found "lspci -v" output similar to this at
> https://linux-hardware.org/?probe=3Dad154077da&log=3Dlspci_all
>
> > When LS7A connect to PCIe,
> >
> > 00:00.0 Host bridge: Loongson Technology LLC Device 7a59
> > 00:03.0 Ethernet controller: Loongson Technology LLC Device 7a13
> > 00:04.0 USB controller: Loongson Technology LLC OHCI USB Controller (re=
v 02)
> > 00:04.1 USB controller: Loongson Technology LLC EHCI USB Controller (re=
v 02)
> > 00:05.0 USB controller: Loongson Technology LLC OHCI USB Controller (re=
v 02)
> > 00:05.1 USB controller: Loongson Technology LLC EHCI USB Controller (re=
v 02)
> > 00:06.0 Multimedia video controller: Loongson Technology LLC Device
> > 7a25 (rev 01)
> > 00:06.1 VGA compatible controller: Loongson Technology LLC Device 7a36 =
(rev 02)
> > 00:06.2 Audio device: Loongson Technology LLC Device 7a37
> > 00:07.0 Audio device: Loongson Technology LLC HDA (High Definition
> > Audio) Controller
> > 00:08.0 SATA controller: Loongson Technology LLC Device 7a18
> > 00:09.0 PCI bridge: Loongson Technology LLC Device 7a49
> > 00:0a.0 PCI bridge: Loongson Technology LLC Device 7a39
> > 00:0b.0 PCI bridge: Loongson Technology LLC Device 7a39
> > 00:0c.0 PCI bridge: Loongson Technology LLC Device 7a39
> > 00:0d.0 PCI bridge: Loongson Technology LLC Device 7a49
> > 00:0f.0 PCI bridge: Loongson Technology LLC Device 7a69
> > 00:10.0 PCI bridge: Loongson Technology LLC Device 7a59
> > 00:16.0 System peripheral: Loongson Technology LLC Device 7a1b
> > 00:17.0 ISA bridge: Loongson Technology LLC LPC Controller (rev 01)
> > 00:19.0 USB controller: Loongson Technology LLC Device 7a34
> > 00:1c.0 PCI bridge: Loongson Technology LLC Device 3c09
> > 00:1d.0 IOMMU: Loongson Technology LLC Device 3c0f
> > 00:1e.0 PCI bridge: Loongson Technology LLC Device 3c09
> > 02:00.0 Ethernet controller: Device 1f0a:6801 (rev 01)
> > 08:00.0 PCI bridge: Loongson Technology LLC Device 3c19
> > 08:01.0 PCI bridge: Loongson Technology LLC Device 3c29
> > 08:02.0 PCI bridge: Loongson Technology LLC Device 3c29
> > 0c:00.0 PCI bridge: Loongson Technology LLC Device 3c19
> > 0c:01.0 PCI bridge: Loongson Technology LLC Device 3c19
> > 0c:04.0 IOMMU: Loongson Technology LLC Device 3c0f
> >
> > -[0000:00]-+-00.0  0014:7a59
> >            +-03.0  0014:7a13
> >            +-04.0  0014:7a24
> >            +-04.1  0014:7a14
> >            +-05.0  0014:7a24
> >            +-05.1  0014:7a14
> >            +-06.0  0014:7a25
> >            +-06.1  0014:7a36
> >            +-06.2  0014:7a37
> >            +-07.0  0014:7a07
> >            +-08.0  0014:7a18
> >            +-09.0-[01]--
> >            +-0a.0-[02]----00.0  1f0a:6801
> >            +-0b.0-[03]--
> >            +-0c.0-[04]--
> >            +-0d.0-[05]--
> >            +-0f.0-[06]--
> >            +-10.0-[07]--
> >            +-16.0  0014:7a1b
> >            +-17.0  0014:7a0c
> >            +-19.0  0014:7a34
> >            +-1c.0-[08-0b]--+-00.0-[09]--
> >            |               +-01.0-[0a]--
> >            |               \-02.0-[0b]--
> >            +-1d.0  0014:3c0f
> >            \-1e.0-[0c-0e]--+-00.0-[0d]--
> >                            +-01.0-[0e]--
> >                            \-04.0  0014:3c0f
> >
> > DEV_LS7A_PCIE_PORT5 becomes 00:00.0
>
> In this case, the DEV_LS7A_PCIE_PORT5 at 00:00.0 looks like a Header
> Type 0 device (not a bridge), and the bus 00 it is on is not a normal
> PCIe Link.  Since it doesn't connect to a PCIe Link, 00:00.0 might not
> have a PCIe Capability at all, or it could be an RCiEP.  Or it's
> possible it has a PCIe Capability left over from the old model that
> says it's a Root Port, although this would potentially confuse an OS.
>
> The other bridges (00:09.0, 00:0a.0, etc) are probably PCIe Root
> Ports, which are logically part of the Root Complex, so the Root
> Complex would be implemented partly in the new CPU and partly in the
> LS7A.
>
> The connection between the new CPU and the LS7A might be electrically
> similar to PCIe, but it's not part of a PCIe hierarchy that Linux
> sees.  That connection would have to be managed in some non-PCI way,
> the same as all PCI host bridges, i.e., by firmware, ACPI, or a Linux
> native host bridge driver like pci-loongson.c.
>
> Here's the current commit log:
>
>   The LS7A chipset can be used as a downstream bridge that connects to
>   a high-level host bridge, and in such case the DEV_LS7A_PCIE_PORT5
>   is used as the upstream port.
>
>   Thus, always enable MSI caps of this port, otherwise downstream
>   devices cannot use MSI.
>
> In this configuration, DEV_LS7A_PCIE_PORT5 is not a PCI-to-PCI bridge
> itself.  It might be some sort of downstream end of a connection from
> the CPU, but that's not really relevant here.  And DEV_LS7A_PCIE_PORT5
> doesn't have any devices directly downstream from it.
>
> I think something like this would be clearer:
>
>   The LS7A chipset can be used as part of a PCIe Root Complex with
>   Loongson-3C6000 and similar CPUs.  In this case, DEV_LS7A_PCIE_PORT5
>   has a PCI_CLASS_BRIDGE_HOST class code, and it is a Type 0 Function
>   whose config space provides access to Root Complex registers.
>
>   The DEV_LS7A_PCIE_PORT5 has an MSI Capability, and its MSI Enable
>   bit must be set before other devices below the Root Complex can use
>   MSI.  This is not the standard PCI behavior of MSI Enable, so the
>   normal PCI MSI code does not set it.
>
>   Set the DEV_LS7A_PCIE_PORT5 MSI Enable bit via a quirk so other
>   devices below the Root Complex can use MSI.
>
> What do you think?

Yes, that's more better.

Huacai

