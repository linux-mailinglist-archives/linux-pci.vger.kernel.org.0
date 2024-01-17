Return-Path: <linux-pci+bounces-2240-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D1F82FE19
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 01:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FDDF1C241F6
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 00:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4866980C;
	Wed, 17 Jan 2024 00:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyOck0fn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A99810E9
	for <linux-pci@vger.kernel.org>; Wed, 17 Jan 2024 00:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705452576; cv=none; b=YZ/VBVaYM5C3QknNLd9vLZcS9N+yIV6dibHMmzGiPpa/dHqIuhSGT4PUhJpCFQ/WRya5DdPlt8TMOylo/qNagiiSLLaAAomcquNvrvGL2Zrq4hkubLuQbcRnww1qmo5f4a3Gi1IMmUp5O6bx0NiUO34aje7ZM1MY76Ju9mNZ84U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705452576; c=relaxed/simple;
	bh=1x5T5mmc94btZOWMyoysNeaHQy0JfDbFrWai4qMiwck=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=tAkfBiPACTNr452GEVRajv0x9/O8c+niqjD8pT8vtOzb/fj5fKVmWkGepsdKdoyjXYJdFnrDcnv1/+Zbmmu1o+zzDYvqqIU/XdiFA9fmfoIr4RRSB7Z7GrCffBoJ24po6zyD0aC8Wsdyfls04xR+EM0RBcLC7T3FAd47YlsCwEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyOck0fn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EEF9C433C7;
	Wed, 17 Jan 2024 00:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705452575;
	bh=1x5T5mmc94btZOWMyoysNeaHQy0JfDbFrWai4qMiwck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OyOck0fnhcLmjQgzt7LKH/hemnRmrW4YdXEUwziO39yIT7BHpubEsqsn8RCHG/wbq
	 XD0GLj6aSR6iASbDenkj/RgaDjCw/sOSIQrS4x3kejGvuTYkVUQHQutZ0jQfwkunJW
	 zqF46mr8wK8zB4rh6S+fNvZNTl7xRSMVZ5oauWMTPT/L5gut7wrjOVDQQfVYRXk6VA
	 BqY4NIyEqhimwKHnot+GG8XbaqHSWFnCBNwUVMSQMvLIZIrp5Ca4Uul9Pgo4DDSj1/
	 OxmKQi5MLcDU0y8n2feSyHHU9DZapozhd0jaw+HzMKu5ptQA7tyjzm6C4/9biT1PSE
	 NYwQxkY7sruhQ==
Date: Tue, 16 Jan 2024 18:49:33 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: linux-pci@vger.kernel.org, samruddh.dhope@intel.com,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v2] PCI: vmd: Enable Hotplug based on BIOS setting on VMD
 rootports
Message-ID: <20240117004933.GA108810@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cf8a41181e07ec15dbc95e42c527b6429db8c50.camel@linux.intel.com>

On Tue, Jan 16, 2024 at 01:37:32PM -0700, Nirmal Patel wrote:
> On Fri, 2024-01-12 at 16:55 -0600, Bjorn Helgaas wrote:
> ...

> > Maybe it will help if we can make the
> > situation more concrete.  I'm basing this on the logs at
> > https://bugzilla.kernel.org/show_bug.cgi?id=215027.  I assume the
> > 10000:e0:06.0 Root Port and the 10000:e1:00.0 NVMe device are both
> > passed through to the guest.  I'm sure I got lots wrong here, so
> > please correct me :)
> > 
> >   Host OS sees:
> > 
> >     PNP0A08 host bridge to 0000 [bus 00-ff]
> >       _OSC applies to domain 0000
> >       OS owns [PCIeHotplug SHPCHotplug PME PCIeCapability LTR] in
> > domain 0000
> >     vmd 0000:00:0e.0: PCI host bridge to domain 10000 [bus e0-ff]
> >       no _OSC applies in domain 10000;
> >       host OS owns all PCIe features in domain 10000
> >     pci 10000:e0:06.0: [8086:464d]             # VMD root port
> >     pci 10000:e0:06.0: PCI bridge to [bus e1]
> >     pci 10000:e0:06.0: SltCap: HotPlug+        # Hotplug Capable
> >     pci 10000:e1:00.0: [144d:a80a]             # nvme
> > 
> >   Guest OS sees:
> > 
> >     PNP0A03 host bridge to 0000 [bus 00-ff]
> >       _OSC applies to domain 0000
> >       platform owns [PCIeHotplug ...]          # _OSC doesn't grant
> > to OS
> >     pci 0000:e0:06.0: [8086:464d]              # VMD root port
> >     pci 0000:e0:06.0: PCI bridge to [bus e1]
> >     pci 0000:e0:06.0: SltCap: HotPlug+         # Hotplug Capable
> >     pci 0000:e1:00.0: [144d:a80a]             # nvme
> > 
> > So the guest OS sees that the VMD Root Port supports hotplug, but
> > it can't use it because it was not granted ownership of the
> > feature?
>
> You are correct about _OSC not granting access in Guest.

I was assuming the VMD Endpoint itself was not visible in the guest
and the VMD Root Ports appeared in domain 0000 described by the guest
PNP0A03.  The PNP0A03 _OSC would then apply to the VMD Root Ports.
But my assumption appears to be wrong:

> This is what I see on my setup.
> 
>   Host OS:
> 
>     ACPI: PCI Root Bridge [PC11] (domain 0000 [bus e2-fa])
>     acpi PNP0A08:0b: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
>     acpi PNP0A08:0b: _OSC: platform does not support [SHPCHotplug AER DPC]
>     acpi PNP0A08:0b: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
>     PCI host bridge to bus 0000:e2
> 
>     vmd 0000:e2:00.5: PCI host bridge to bus 10007:00
>     vmd 0000:e2:00.5: Bound to PCI domain 10007
> 
>   Guest OS:
> 
>     ACPI: PCI Root Bridge [PC0G] (domain 0000 [bus 03])
>     acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
>     acpi PNP0A08:01: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME AER LTR DPC]
>     acpi PNP0A08:01: _OSC: OS now controls [PCIeCapability]
> 
>     vmd 0000:03:00.0: Bound to PCI domain 10000
> 
>     SltCap: PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-

Your example above suggests that the guest has a PNP0A08 device for
domain 0000, with an _OSC, the guest sees the VMD Endpoint at
0000:03:00.0, and the VMD Root Ports and devices below them are in
domain 10000.  Right?

If we decide the _OSC that covers the VMD Endpoint does *not* apply to
the domain below the VMD bridge, the guest has no _OSC for domain
10000, so the guest OS should default to owning all the PCIe features
in that domain.

Bjorn

