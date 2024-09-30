Return-Path: <linux-pci+bounces-13663-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056C298ACEF
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 21:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DF4D1C2181C
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 19:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA2F199E82;
	Mon, 30 Sep 2024 19:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mg60oNe9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3781991B2
	for <linux-pci@vger.kernel.org>; Mon, 30 Sep 2024 19:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727724517; cv=none; b=mnUP2njWIQRF5Z0bdpuXkEIDuLewnFUuN/GUEoxDExYQ4mA6m9A1Hg8kdU1fsRL5x6FrAvF7JhKv/QeUZhHXFoExKOqPs1+/TU5xun9m1F18TxOnd2vN3GpAhPLvJN5/5d3fM3+EYCiR1Dc8Pnx9rx0vPk6y1JhrTm+NAQhc2ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727724517; c=relaxed/simple;
	bh=RKaSnfGXLWXkgN2e2BEQlsDhwpxN4RmAU+ak848zlG8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KXm9MzeRgE+H0OMO/3V+nd/llbXskb4oZr9n0nwZ0N/MBEUogmQ3AZkBNX9hb6oldj3zvK56QslWlzt6nqPjSRrzB7NZjPB6r2lz4raYG6k4hBXQzr3XEd8pCWlOyVbG6U9X+1G6gSBXZmRqJnDwTenMdE3oddFl/uVNmdWdm58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mg60oNe9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755FDC4CEC7;
	Mon, 30 Sep 2024 19:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727724516;
	bh=RKaSnfGXLWXkgN2e2BEQlsDhwpxN4RmAU+ak848zlG8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mg60oNe9/Hgq++f9vgXrai1wlWtjbPNOW4dvqoT+TFxn3AL3sMX8XbDyfH5/bk7q7
	 eQg+o6nXSHYpMvNQdE16a3/2gL1MeJ0KN9ozGDuisDzvFXfEP0OCyf8zqfVtF/3P3q
	 ywmNnw8WZmVh6EqDquzdCtpgLcB+LQnjZ3JxTIDul6xpcfjB66KZhLRgsB/6zQrwgd
	 RPRftGlRnMntt4CckubTHhQg+j7aY0KnlfxLBlytpygMnSoZxQsUxSEYUMuIqPC28m
	 JyKAAk5+2l8QyMlabqLB3VneiYLTt7Y2W2h2x4uA96kfGEBcAE/0ugyklEKMm9kP3A
	 WnDpAc0DG0qQw==
Date: Mon, 30 Sep 2024 14:28:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Maverickk 78 <maverickk1778@gmail.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: pcie hotplug driver probe is not getting called
Message-ID: <20240930192834.GA187120@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALfBBTsmKYf5FT-pxLfM-C1EgdrKKhQU43OhMDBz2ZPtKcxaLQ@mail.gmail.com>

On Sun, Sep 29, 2024 at 07:29:32PM +0530, Maverickk 78 wrote:
> Hi Bjorn,
> 
> I have a switch connecting to the Host bridge, one of the downstream
> port(02:1.0) on the switch has the slot enabled.
> 
> Appended pcie_ports=native along with pciehp.pciehp_force=1
> pciehp.pciehp_debug=1  to the cmdline and I see the driver creating symlink
> to sysfs device node.
> 
> Does this mean pciehp can handle the hotplug events? asking this because
> none of the functions in pciehp_core listed in ftrace?

From the dmesg log you attached:

  [    0.000000] DMI: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g155821a-20210629_105355-sharpie 04/01/2014
  [    0.000000] Hypervisor detected: KVM
  [    0.408755] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-6.11.0+ root=UUID=f563804b-1b93-4921-90e1-4114c8111e8f ro modprobe.blacklist=mpt3sas ftrace=function_graph ftrace_graph_filter=*pcie* pciehp.pciehp_force=1 pciehp.pciehp_debug=1 pcie_ports=native quite splash crashkernel=512M-:192M vt.handoff=7
  [    1.640055] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
  [    1.736168] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug LTR DPC]
  [    1.738096] acpi PNP0A08:00: _OSC: OS now controls [SHPCHotplug PME AER PCIeCapability]
  [    9.885390] pcieport 0000:02:01.0: pciehp: Slot #0 AttnBtn+ PwrCtrl+ MRL+ AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock- NoCompl- IbPresDis- LLActRep+

I assume this kernel is running as a KVM guest.  The firmware _OSC
says the platform (QEMU) doesn't support native PCIe hotplug, so
host->native_pcie_hotplug will be false.  But of course
"pcie_ports=native" would set pcie_ports_native, so the portdrv
get_port_device_capability() will set PCIE_PORT_SERVICE_HP, which
allows pciehp to bind to 02:01.0.

The "pcieport 0000:02:01.0: pciehp: Slot #0" line shows that
pciehp_probe() was called.

I don't know whether QEMU supports PCIe hotplug interrupts though.

When do you expect pciehp to do something?  Are you hotplugging a
physical device that is passed through to this guest?

Bjorn

