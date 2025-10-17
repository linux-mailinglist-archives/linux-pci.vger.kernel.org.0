Return-Path: <linux-pci+bounces-38467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F5BBE8AC8
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 14:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72F0E1AA4B0C
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 12:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD26330319;
	Fri, 17 Oct 2025 12:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1VFMaR/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C0E30F7F9;
	Fri, 17 Oct 2025 12:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760705684; cv=none; b=QsJA9A/mrNeDfvw1aV+4bcZMIC0qLO1z8BKAjzJUA27pbRE7eYiF2OPbkXSbq5t7wwZ+VsDxnl8iwie+S3XUb0xNjCECJUao4SwLX13KrIsSre5LuG7/gIqtEKdzIg11s2Lvk3dPOMImh3RdjGKfxepmP281DUCvuBbu5OciMEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760705684; c=relaxed/simple;
	bh=WMQfRMdx/qFxNnz6YmoK3Yn93CiWmg6XVE+1bvAh2C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdsW72wtndHo6xCrtoJxOarmNIqZou8ODRCmIIfGQWh1Up6CMBrUcscUMHmKA63nwMorQRjZydLxW3DjLFlHJSyRy99d2BQxQ8bFX1U45UPEf68cBQORwZmirxaE6O3PZAaKiEUI0q1C2Ee5dRSKeSqKHeYvRLUlohPXzzzL9j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1VFMaR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E07F9C4CEE7;
	Fri, 17 Oct 2025 12:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760705683;
	bh=WMQfRMdx/qFxNnz6YmoK3Yn93CiWmg6XVE+1bvAh2C8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G1VFMaR/4+vtfYQ6WM7TpLKufhOSn3xFowv4cdgiMzkOj/Wew+88dznKeuz0RNlqW
	 29mUISKm94e7llYScJq3Efd3l9VsOnKTzjL/o9BQ2zRiqFKAk4sOkrSLcVt6HLR47S
	 J1drTLP3eF53fISrO5Xr44zY5LQQN6sBJO5Yo1eiKbOvlrrxyxS98cC8vw6abRH9mr
	 xFhJdFV20XnJCFAKeEdWMwxBISY1BlwNKEVS9thvvv0eDaMm2mAE0yzaaZ6MT2n4In
	 5UaXNtPi5hi3P56k9ARJqhEVOoKRztvIssZQTHUsH5ECZhsZKM8Afb0RNVLMWJQbO0
	 1+q2Xb05jtpyg==
Date: Fri, 17 Oct 2025 18:24:26 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	"David E. Box" <david.e.box@linux.intel.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Chia-Lin Kao <acelan.kao@canonical.com>, Dragan Simic <dsimic@manjaro.org>, 
	linux-rockchip@lists.infradead.org, regressions@lists.linux.dev, FUKAUMI Naoki <naoki@radxa.com>
Subject: Re: [PATCH v2 1/2] PCI/ASPM: Override the ASPM and Clock PM states
 set by BIOS for devicetree platforms
Message-ID: <4pm5tizc2c4c75h23izalhysuljnlfzpxuawhzezmnnqic2tdf@l2rcj24rmru3>
References: <7df0bf91-8ab1-4e76-83fa-841a4059c634@rock-chips.com>
 <20251015233054.GA961172@bhelgaas>
 <hwueivbm2taxwb2iowkvblzvdv2xqnsapx6lenv56vuz7ye6do@fugjdkoyk5gy>
 <0dd51970-a7ac-4500-b96f-d1e328e7a3b2@rock-chips.com>
 <22owgu6qb34bh47cevupnwnvwwfhtn4lwfav6fuxfydaiujw6y@oeh3q2u4wo2h>
 <e53bd057-0bdc-4f40-acff-eba904b0a728@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e53bd057-0bdc-4f40-acff-eba904b0a728@rock-chips.com>

On Fri, Oct 17, 2025 at 08:19:11PM +0800, Shawn Lin wrote:
> 在 2025/10/17 星期五 18:04, Manivannan Sadhasivam 写道:
> > On Fri, Oct 17, 2025 at 05:47:44PM +0800, Shawn Lin wrote:
> > > Hi Mani and Bjorn
> > > 
> > > 在 2025/10/17 星期五 11:36, Manivannan Sadhasivam 写道:
> > > > On Wed, Oct 15, 2025 at 06:30:54PM -0500, Bjorn Helgaas wrote:
> > > > > On Wed, Oct 15, 2025 at 09:00:41PM +0800, Shawn Lin wrote:
> > > > > > ...
> > > > > 
> > > > > > For now, this is a acceptable option if default ASPM policy enable
> > > > > > L1ss w/o checking if the HW could supports it... But how about
> > > > > > adding supports-clkreq stuff to upstream host driver directly? That
> > > > > > would help folks enable L1ss if the HW is ready and they just need
> > > > > > adding property to the DT.
> > > > > > ...
> > > > > 
> > > > > > The L1ss support is quite strict and need several steps to check, so we
> > > > > > didn't add supports-clkreq for them unless the HW is ready to go...
> > > > > > 
> > > > > > For adding supports of L1ss,
> > > > > > [1] the HW should support CLKREQ#, expecially for PCIe3.0 case on Rockchip
> > > > > > SoCs , since both  CLKREQ# of RC and EP should connect to the
> > > > > > 100MHz crystal generator's enable pin, as L1.2 need to disable refclk as
> > > > > > well. If the enable pin is high active, the HW even need a invertor....
> > > > > > 
> > > > > > [2] define proper clkreq iomux to pinctrl of pcie node
> > > > > > [3] make sure the devices work fine with L1ss.(It's hard to check the slot
> > > > > > case with random devices in the wild )
> > > > > > [4] add supports-clkreq to the DT and enable
> > > > > > CONFIG_PCIEASPM_POWER_SUPERSAVE
> > > > > 
> > > > > I don't understand the details of the supports-clkreq issue.
> > > > > 
> > > > > If we need to add supports-clkreq to devicetree, I want to understand
> > > > > why we need it there when we don't seem to need it for ACPI systems.
> > > > > 
> > > > > Generally the OS relies on what the hardware advertises, e.g., in Link
> > > > > Capabilities and the L1 PM Substates Capability, and what is available
> > > > > from firmware, e.g., the ACPI _DSM for Latency Tolerance Reporting.
> > > > > 
> > > > > On the ACPI side, I don't think we get any specific information about
> > > > > CLKREQ#.  Can somebody explain why we do need it on the devicetree
> > > > > side?
> > > > > 
> > > > 
> > > > I think there is a disconnect between enabling L1ss CAP and CLKREQ#
> > > > availability.. When L1ss CAP is enabled for the Root Port in the hardware, there
> > > > is no guarantee that CLKREQ# is also available. If CLKREQ# is not available,
> > > > then if L1ss is enabled by the OS, it is not possible to exit the L1ss states
> > > > (assuming that L1ss is entered due to CLKREQ# in deassert (default) state).
> > > > 
> > > > Yes, there seems to be no standard way to know CLKREQ# presence in ACPI, but
> > > > in devicetree, we have this 'supports-clkreq' property to tell the OS that
> > > > CLKREQ# is available in the platform. But unfortunately, this property is not
> > > > widely used by the devicetrees out there. So we cannot use it in generic
> > > > pci/aspm.c driver.
> > > > 
> > > > We can certainly rely on the BIOS to enable L1ss as the fw developers would
> > > > have the knowledge of the CLKREQ# availability. But BIOS is not a thing on
> > > > mobile and embedded platforms where L1ss would come handy.
> > > > 
> > > > What I would suggest is, the host controller drivers (mostly for devicetree
> > > > platforms) should enable L1ss CAP for the Root Port only if they know that
> > > > CLKREQ# is available. They can either rely on the 'supports-clkreq' property or
> > > > some platform specific knowledge (for instance, on all Qcom platforms, we
> > > > certainly know that CLKREQ# is available, but we don't set the DT property).
> > > 
> > > While we're on the topic of ASPM, may I ask a silly question?
> > > I saw the ASPM would only be configured once the function driver calling
> > > pci_enable_device. So if the modular driver hasn't been insmoded, the
> > > link will be in L0 even though there is no transcation on-going. What is
> > > the intention behind it?
> > > 
> > 
> > I don't see where ASPM is configured during pci_enable_device(). It is currently
> > configured for all devices during pci_scan_slot().
> 
> This is the dump_stack() where I observed. If I compile NVMe driver as a
> module and never insmod it, the link is always in L0, namely ASPM
> Disabled.
> 

I guess this comment answers your question:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pcie/aspm.c?h=v6.18-rc1#n1179

But with the recent ASPM change, the ASPM settings for DT platforms will be
applied before pci_enable_device(). Also, the comment is somewhat outdated as we
generally do not want PCI client drivers to enable/disable ASPM nowadays. They
can however do it under specific circumstances.

- Mani

> [    0.747508] pci 0000:01:00.0: ASPM: DT platform, enabling L0s-up L0s-dw
> L1 ASPM-L1.1 ASPM-L1.2 PCI-PM-L1.1 PCI-PM-L1.2
> [    0.748509] pci 0000:01:00.0: ASPM: DT platform, enabling ClockPM
> [    0.749145] pci 0000:01:00.0: BAR 0 [mem 0xf0200000-0xf0203fff 64bit]:
> assigned
> [    0.750430] nvme nvme0: pci function 0000:01:00.0
> [    0.750850] CPU: 7 UID: 0 PID: 120 Comm: kworker/u32:7 Not tainted
> 6.18.0-rc1-00019-gb00f931c2b43-dirty #19 PREEMPT
> [    0.750854] Hardware name: Rockchip RK3588 EVB1 V10 Board (DT)
> [    0.750856] Workqueue: async async_run_entry_fn
> [    0.750863] Call trace:
> [    0.750864]  show_stack+0x18/0x24 (C)
> [    0.750869]  dump_stack_lvl+0x40/0x84
> [    0.750873]  dump_stack+0x18/0x24
> [    0.750876]  pcie_config_aspm_link+0x40/0x2dc
> [    0.750882]  pcie_aspm_powersave_config_link+0x68/0x104
> [    0.750885]  do_pci_enable_device+0x80/0x170
> [    0.750890]  pci_enable_device_flags+0x1b8/0x220
> [    0.750894]  pci_enable_device_mem+0x14/0x20
> [    0.750898]  nvme_pci_enable+0x3c/0x66c
> [    0.750904]  nvme_probe+0x5f8/0x7d4
> [    0.750908]  pci_device_probe+0x1dc/0x2ac
> [    0.750912]  really_probe+0x138/0x2d8
> [    0.750915]  __driver_probe_device+0xa0/0x128
> [    0.750918]  driver_probe_device+0x3c/0x1f8
> [    0.750921]  __device_attach_driver+0x118/0x140
> [    0.750924]  bus_for_each_drv+0xf4/0x14c
> [    0.750927]  __device_attach_async_helper+0x78/0xd0
> [    0.750930]  async_run_entry_fn+0x24/0xdc
> [    0.750933]  process_scheduled_works+0x194/0x2c4
> [    0.750937]  worker_thread+0x28c/0x394
> [    0.750939]  kthread+0x1bc/0x200
> [    0.750943]  ret_from_fork+0x10/0x20
> [    0.750947] pcie_config_aspm_link 989
> [    0.753436] ehci-platform fc800000.usb: USB 2.0 started, EHCI 1.00
> [    0.753620] pcie_config_aspm_link 997 state 0x7c
> [    0.754204] hub 4-0:1.0: USB hub found
> [    0.754279] pcie_config_aspm_link 1004 state 0x7c
> [    0.754281] pcie_config_aspm_link 1008
> [    0.754741] hub 4-0:1.0: 1 port detected
> [    0.755153] nvme 0000:01:00.0: enabling device (0000 -> 0002)
> [    0.769741] hub 1-0:1.0: USB hub found
> [    0.770084] hub 1-0:1.0: 1 port detected
> [    0.801662] hub 3-0:1.0: USB hub found
> [    0.802007] hub 3-0:1.0: 1 port detected
> [    0.806393] nvme nvme0: D3 entry latency set to 10 seconds
> [    0.810188] nvme nvme0: 8/0/0 default/read/poll queues
> 
> 
> > 
> > - Mani
> > 
> 

-- 
மணிவண்ணன் சதாசிவம்

