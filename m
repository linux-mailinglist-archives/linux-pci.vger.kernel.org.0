Return-Path: <linux-pci+bounces-41653-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9412CC6FE53
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 17:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7FDD0364588
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 15:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E10234107C;
	Wed, 19 Nov 2025 15:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/iaFsAP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6EE2E8B81;
	Wed, 19 Nov 2025 15:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567253; cv=none; b=DpVrNGWvLtlQv+5TWphhkwmUbN28R5aQLX7wB5B6PcVSSxSGYubwrXbK+8TIdw8Ls4IVTXT/NMJGkfheFP4ZNAQvv/pcrX0MztFEbrEen2XDxnN2ZZ7oQ/wgRgidk+pNw+sujNfIsxsUYF9U7NPX8lIPkuv5HHqHX5+np/8r+nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567253; c=relaxed/simple;
	bh=vicgZe2Av/U4KqK6bau+u9mHI2W4ZvV0ci7Vd1xAaJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPMTnS8UpxDNYkU3w6xA2PT5QJR1P2yp+KcH+NPvYE8YZBDvL1uTsSGci4mLnoSMyYGQRRNOaZL+ls8/XBjHc0MeDcJtVgy7w/DRrTXbfU0+aPg80nu8fAWIj49+zVnxHr7le4GyzHMJJLzLwQbLu3UOC60xYLUv2fO2oCvpPv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/iaFsAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B901DC4AF4D;
	Wed, 19 Nov 2025 15:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763567252;
	bh=vicgZe2Av/U4KqK6bau+u9mHI2W4ZvV0ci7Vd1xAaJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m/iaFsAPw27Vo7KL+xOhpzChl9HwgPS91l9ZE9SkAkJCY2UaBQjQUzZhvNSIU0aTR
	 mjUaPeN+1DpNB9Eu/vA1eUJYgT/Pfoz+V8332karyPbvh9E4dsexBeWKPFw55pyc5w
	 HOGrzUy9f5ifz0axsOzC6LhDxNWcDYaObz3ObyauHXxPC+VgMvQ70Q1eU9tbDf32hH
	 WGrz9JsHF69HhZs+dekb6hrSb9slrHLfcIHBv4S1HO+h5iw9cAoF4bPD8b5OP2vbtO
	 SRL79BsrKKpcZJXfElkS5n7zaxeL8O3UTaUS7UCPqvj9+IRbu++GiYLfOBTOWVIqKP
	 yj4TrAxEVZH9Q==
Date: Wed, 19 Nov 2025 21:17:18 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	linux-pci@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PCI: stm32: Fix LTSSM EP race with start link.
Message-ID: <k72rxq2j5hbpotgmshwau6tvvem3jnldahxxgg54qoxjs7jaxb@bgh4cgs5j25h>
References: <20251118212818.GA2591668@bhelgaas>
 <7053f336-59c9-47cc-ac97-eb2f0916ac4f@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7053f336-59c9-47cc-ac97-eb2f0916ac4f@foss.st.com>

On Wed, Nov 19, 2025 at 04:13:47PM +0100, Christian Bruel wrote:
> 
> 
> On 11/18/25 22:28, Bjorn Helgaas wrote:
> > [+cc Lukas in case I got the pciehp part wrong]
> > 
> 
> > 
> > To back up here, I'm trying to understand the race.
> > 
> > IIUC the relevant events are link training and register init.  In the
> > current stm32 EP driver, link training can start when the EP userspace
> > writes to the 'start' configfs file.  And the register init happens
> > when stm32_pcie_ep_perst_irq_thread() calls
> > dw_pcie_ep_init_registers().
> > 
> > So I guess the problem is when the EP userspace enables the LTSSM
> > before the host deasserts PERST#?  And the link train may complete
> > before stm32_pcie_ep_perst_irq_thread() runs?
> 
> The sequence also violated the spec (4.0, Section 6.6.1 "Conventional
> Reset"), because it allowed the endpoint to enter the Detect state before
> PERST# is deasserted
> 
> > 
> > And the fix here is to delay enabling the EP LTSSM until after
> > stm32_pcie_perst_deassert() calls dw_pcie_ep_init_registers()?
> > 
> 
> > 
> > I think we would prefer if the host would enumerate the endpoint
> > whenever the endpoint becomes ready, even if that is after the host's
> > initial enumeration, but I guess that's only possible if the host is
> > notified when the link comes up.
> > 
> > The main mechanism for that is hotplug, i.e., pciehp handles presence
> > detect and link layer state changed events, both of which are managed
> > by the PCIe Slot register set.  Those registers are optional and may
> > not be implemented, e.g., if a Root Port is connected to a
> > system-integrated device.
> > 
> > But if they *are* implemented, I hope that pciehp makes it so no user
> > intervention on the host side is required.
> > 
> 
> 
> I suppose that hotplug cannot be implemented without some kind of presence
> detection signal from the EP (PRSNT#, ...) ? For now we have no
> implementation to support this (from gpio or other).
> 

Most of the non-PC/Server platforms do not have hot pluggable connectors. So the
lack of PRSNT# signal is very common.

> However, using a PC host, I observe that when I resume the host from PCIe
> autosuspend, for example, with 'lspci', PERST# is deasserted, and the stm32
> PCIe EP device is correctly enumerated without a manual rescan. So thanks to
> power management, a device can be enumerated asynchronously but when
> requested, not when ready.
> 

I would assume that any host will deassert PERST# during boot itself, and keep
the LTSSM in Link.Detect. But if the link is not detected, a host *may* assert
PERST#. And during resume, it will try the same sequence and if your device is
connected, it will get enumerated.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

