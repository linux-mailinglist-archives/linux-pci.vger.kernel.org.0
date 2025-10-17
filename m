Return-Path: <linux-pci+bounces-38442-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59723BE7F05
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 12:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50AA1A6187B
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 10:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB2530C62A;
	Fri, 17 Oct 2025 10:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pn/pxqk9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5449130B525;
	Fri, 17 Oct 2025 10:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695508; cv=none; b=be2Qf6zXGWY9D33ei4LfBFWojGVKm+sdglNREuoSIrgaa0kZ93xkmV5FEgdLf73oQ+WkAu85GqWlcR6diBXrpZYj4fRAgx+1/NjSBSnDrZnOEXtMeO37GlfYKMjD/Ve3Hajuwk1ubpwA1WqVBLydvcAsA3dZpK+h6wv2VOqwxtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695508; c=relaxed/simple;
	bh=d27FnODMUOTQgewcjbJxNy4ZOjzPLw8pcBAW8xniqKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eir44Q1brq21tKZT+7T2Q4sipfxebNGWK1qHcMI62Sx6IBC9puRBsNOdfQheIywggw3jom+5swpqDWdXjQ0V9ou6d7J/ydv78+wMOBZvQ6fMMdgD7wOEtuv2Z3ftUvWupMebWi6otEALZiVL7U8Taw9NeH2eUj+S8nSrpHk0TMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pn/pxqk9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8282C4CEE7;
	Fri, 17 Oct 2025 10:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760695507;
	bh=d27FnODMUOTQgewcjbJxNy4ZOjzPLw8pcBAW8xniqKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pn/pxqk9AqSC3QFrOOd7LLwBp4ePoZ1T9yh86VDVXBsW5Gq3/wIsU5yXbDIGM7GVq
	 PvQIRqzMmxMVWIIS3ZO+YbNMqsw9rISbkqG46JqUszkWEKOdS4DIDs66v6UqK12K+7
	 KlxyuhRHYpmifcmbMVwfH6iEHPSt84mkXY7LpM0vaYK21qfN3iMTt1ESP3D/iI9Qua
	 WpEZLRAotG6oXakdDm7fvqYsWsIW5khfRfpSsxd+rZEZNeqpfyiK+WRawf0ye65MZw
	 Snf9HP2LbS18RSzM4svYqEw3jqH8qu/Q24iOhCCZOp+YYA7MHF3F7aC/TBnaXiHIs4
	 6xSMhDBRFkATw==
Date: Fri, 17 Oct 2025 15:34:51 +0530
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
Message-ID: <22owgu6qb34bh47cevupnwnvwwfhtn4lwfav6fuxfydaiujw6y@oeh3q2u4wo2h>
References: <7df0bf91-8ab1-4e76-83fa-841a4059c634@rock-chips.com>
 <20251015233054.GA961172@bhelgaas>
 <hwueivbm2taxwb2iowkvblzvdv2xqnsapx6lenv56vuz7ye6do@fugjdkoyk5gy>
 <0dd51970-a7ac-4500-b96f-d1e328e7a3b2@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0dd51970-a7ac-4500-b96f-d1e328e7a3b2@rock-chips.com>

On Fri, Oct 17, 2025 at 05:47:44PM +0800, Shawn Lin wrote:
> Hi Mani and Bjorn
> 
> 在 2025/10/17 星期五 11:36, Manivannan Sadhasivam 写道:
> > On Wed, Oct 15, 2025 at 06:30:54PM -0500, Bjorn Helgaas wrote:
> > > On Wed, Oct 15, 2025 at 09:00:41PM +0800, Shawn Lin wrote:
> > > > ...
> > > 
> > > > For now, this is a acceptable option if default ASPM policy enable
> > > > L1ss w/o checking if the HW could supports it... But how about
> > > > adding supports-clkreq stuff to upstream host driver directly? That
> > > > would help folks enable L1ss if the HW is ready and they just need
> > > > adding property to the DT.
> > > > ...
> > > 
> > > > The L1ss support is quite strict and need several steps to check, so we
> > > > didn't add supports-clkreq for them unless the HW is ready to go...
> > > > 
> > > > For adding supports of L1ss,
> > > > [1] the HW should support CLKREQ#, expecially for PCIe3.0 case on Rockchip
> > > > SoCs , since both  CLKREQ# of RC and EP should connect to the
> > > > 100MHz crystal generator's enable pin, as L1.2 need to disable refclk as
> > > > well. If the enable pin is high active, the HW even need a invertor....
> > > > 
> > > > [2] define proper clkreq iomux to pinctrl of pcie node
> > > > [3] make sure the devices work fine with L1ss.(It's hard to check the slot
> > > > case with random devices in the wild )
> > > > [4] add supports-clkreq to the DT and enable
> > > > CONFIG_PCIEASPM_POWER_SUPERSAVE
> > > 
> > > I don't understand the details of the supports-clkreq issue.
> > > 
> > > If we need to add supports-clkreq to devicetree, I want to understand
> > > why we need it there when we don't seem to need it for ACPI systems.
> > > 
> > > Generally the OS relies on what the hardware advertises, e.g., in Link
> > > Capabilities and the L1 PM Substates Capability, and what is available
> > > from firmware, e.g., the ACPI _DSM for Latency Tolerance Reporting.
> > > 
> > > On the ACPI side, I don't think we get any specific information about
> > > CLKREQ#.  Can somebody explain why we do need it on the devicetree
> > > side?
> > > 
> > 
> > I think there is a disconnect between enabling L1ss CAP and CLKREQ#
> > availability.. When L1ss CAP is enabled for the Root Port in the hardware, there
> > is no guarantee that CLKREQ# is also available. If CLKREQ# is not available,
> > then if L1ss is enabled by the OS, it is not possible to exit the L1ss states
> > (assuming that L1ss is entered due to CLKREQ# in deassert (default) state).
> > 
> > Yes, there seems to be no standard way to know CLKREQ# presence in ACPI, but
> > in devicetree, we have this 'supports-clkreq' property to tell the OS that
> > CLKREQ# is available in the platform. But unfortunately, this property is not
> > widely used by the devicetrees out there. So we cannot use it in generic
> > pci/aspm.c driver.
> > 
> > We can certainly rely on the BIOS to enable L1ss as the fw developers would
> > have the knowledge of the CLKREQ# availability. But BIOS is not a thing on
> > mobile and embedded platforms where L1ss would come handy.
> > 
> > What I would suggest is, the host controller drivers (mostly for devicetree
> > platforms) should enable L1ss CAP for the Root Port only if they know that
> > CLKREQ# is available. They can either rely on the 'supports-clkreq' property or
> > some platform specific knowledge (for instance, on all Qcom platforms, we
> > certainly know that CLKREQ# is available, but we don't set the DT property).
> 
> While we're on the topic of ASPM, may I ask a silly question?
> I saw the ASPM would only be configured once the function driver calling
> pci_enable_device. So if the modular driver hasn't been insmoded, the
> link will be in L0 even though there is no transcation on-going. What is
> the intention behind it?
> 

I don't see where ASPM is configured during pci_enable_device(). It is currently
configured for all devices during pci_scan_slot().

- Mani

-- 
மணிவண்ணன் சதாசிவம்

