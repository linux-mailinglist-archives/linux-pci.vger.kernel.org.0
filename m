Return-Path: <linux-pci+bounces-23778-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B57A61B3E
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 21:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A543F420B97
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 20:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15611204C32;
	Fri, 14 Mar 2025 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vG43qzsB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E741FDA9C
	for <linux-pci@vger.kernel.org>; Fri, 14 Mar 2025 19:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741982392; cv=none; b=Q8tdF8mQgUZV2UfPVcdsacSPpqcGfo4GPVHR4pRQEexz3QCGvfONhQV+dKsOoh6AukSrE1ZqHT03XniuDLeUQnwTnGnTFh8Pnfk8g2t9OVA44oIoEoZc4/VZ6kSzoeMGUdqAElh8hGJnKQkqcL9BlW4Rc4M4IssG1W0iUJfScqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741982392; c=relaxed/simple;
	bh=UGWT3ec3Ir8uU5CvoVR7Fbk4i4rmDS/jpVjfDWB7oLA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EF8bgJJakBzWw4pQVKm1v8GkqM0FLBBlUdXQWa83C+lfrw4JePns552FPmEGzfkF0njibogfbCCrK7Du/TPRqw+mbdU/9sNtMVT/URGPOm9z6z8VSfC+ql+rbaFm7xv8zmNnayVN8+srKb4OOWKHZ4wGOpDLiwIJ34Z/02O/2d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vG43qzsB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44152C4CEE3;
	Fri, 14 Mar 2025 19:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741982391;
	bh=UGWT3ec3Ir8uU5CvoVR7Fbk4i4rmDS/jpVjfDWB7oLA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=vG43qzsB6BGDDkID9J2QIybvRDFow6tZzKK5SPZtcXk76FTDtzjBj7UAm5175rJgH
	 o323kHWLJy3eXGnnZI3lYEbkDF9IGZyhpeWM5j3Xm4ckJ+0LHwzqmbW+z7qd7Kvpdc
	 iU7V4Wwj6rIZEXXwem0F7cN1IniVxPfedk7FwJ3TYXZ99Y+Ikbkj5JZvOENKc6I0p3
	 nCZzKfmaalFAhzd57q27LRE16BEcXBnBtCsCts+6wUt+ZZxi8E16vCMBm+ONqzPVcb
	 nFx4ykGTGeEfUYNmCmRnFV0gu4LmOaBNecMyZ1/cnn+/Vpnkm1FgsoqoTBMEBwcmqd
	 3QxBB50fxvZaA==
Date: Fri, 14 Mar 2025 14:59:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Huacai Chen <chenhuacai@gmail.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH] PCI: loongson: Add quirk for OHCI device rev 0x02
Message-ID: <20250314195949.GA792185@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121114225.2727684-1-chenhuacai@loongson.cn>

On Tue, Jan 21, 2025 at 07:42:25PM +0800, Huacai Chen wrote:
> The OHCI controller (rev 0x02) under LS7A PCI host has a hardware flaw.
> MMIO register with offset 0x60/0x64 is treated as legacy PS2-compatible
> keyboard/mouse interface, which confuse the OHCI controller. Since OHCI
> only use a 4KB BAR resource indeed, the LS7A OHCI controller's 32KB BAR
> is wrapped around (the second 4KB BAR space is the same as the first 4KB
> internally). So we can add an 4KB offset (0x1000) to the BAR resource as
> a workaround.

It looks like usb_hcd_pci_probe() only uses BAR 0 in the OHCI case, so
I assume this OHCI controller has a single 32KB BAR?

And you're saying that in that BAR, the 0x1000-0x1fff offsets are
aliases of the 0x0000-0x0fff area?

And this causes some kind of problem because the OCHI driver looks at
offsets 0x60 and 0x64 into the BAR and sees something it doesn't like?

And this quirk adds 0x1000 to the BAR start, so the OHCI driver looks
at offsets 0x1060 and 0x1064 of the original BAR, and that somehow
avoids a problem?  Even though those are aliases of 0x0060 and 0x0064
of the original BAR?

> +static void loongson_ohci_quirk(struct pci_dev *dev)
> +{
> +	if (dev->revision == 0x2)
> +		dev->resource[0].start += 0x1000;

What does this do to the iomem_resource tree?  IIUC, dev->resource[0]
no longer correctly describes the PCI address space consumed by the
device.  

If the BAR is actually programmed with [mem 0x20000000-0x20007fff],
the device responds to PCI accesses in that range.  Now you update
resource[0] so it describes the space [mem 0x20001000-0x20008fff].  So
the kernel *thinks* the space at [mem 0x20000000-0x20000fff] is free
and available for something else, which is not true, and that the
device responds at [mem 0x0x20008000-0x20008fff], which is also not
true.

I think the resource has already been put into the iomem_resource tree
by the time the final fixups are run, so this also may corrupt the
sorting of the tree.

This just doesn't look safe to me.

> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_LS7A_OHCI, loongson_ohci_quirk);

