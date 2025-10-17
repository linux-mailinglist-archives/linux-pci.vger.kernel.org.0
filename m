Return-Path: <linux-pci+bounces-38415-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9FDBE6369
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 05:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2499A4246EB
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 03:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF8816A395;
	Fri, 17 Oct 2025 03:37:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B520C7263B;
	Fri, 17 Oct 2025 03:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760672226; cv=none; b=skk7dgOjMJaZTShRXLZamF3mdDjEVHu16YHywbBxhE2ul9buzBZBO80wjhWSVTsjKRo4ZxwNGnfQbZiioEltmyiHjv+BVdxf0GbD34GMtM3+QbN/DBbcQWl0+CoaLwneyDW8K0vlw0uoMnMza3wHcZcLh6dV7fi/Z2qAlxgVQjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760672226; c=relaxed/simple;
	bh=pCsBOF/3F7DNY1FroursBiT3zb9h499/ii7jYF4WMOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qstJzQnJ9M5T04ZNxiW1SU2S+FM7vc0Ly9FueVqHSlmuVEyAPpbNTcMIBfLWpJzP5rDzUUihoS3bmTyUowgF/8OhFWhNJWPlvxIUpYfFybnJYs3sz+ZsqSwoA7kUpUUci9D4xNyqkZswpdsviRdNvCdkgxXc5tzgXmAFwFe6VGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F092C4CEE7;
	Fri, 17 Oct 2025 03:36:54 +0000 (UTC)
Date: Fri, 17 Oct 2025 09:06:48 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, 
	Niklas Cassel <cassel@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	"David E. Box" <david.e.box@linux.intel.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Chia-Lin Kao <acelan.kao@canonical.com>, Dragan Simic <dsimic@manjaro.org>, 
	linux-rockchip@lists.infradead.org, regressions@lists.linux.dev, FUKAUMI Naoki <naoki@radxa.com>
Subject: Re: [PATCH v2 1/2] PCI/ASPM: Override the ASPM and Clock PM states
 set by BIOS for devicetree platforms
Message-ID: <hwueivbm2taxwb2iowkvblzvdv2xqnsapx6lenv56vuz7ye6do@fugjdkoyk5gy>
References: <7df0bf91-8ab1-4e76-83fa-841a4059c634@rock-chips.com>
 <20251015233054.GA961172@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251015233054.GA961172@bhelgaas>

On Wed, Oct 15, 2025 at 06:30:54PM -0500, Bjorn Helgaas wrote:
> On Wed, Oct 15, 2025 at 09:00:41PM +0800, Shawn Lin wrote:
> > ...
> 
> > For now, this is a acceptable option if default ASPM policy enable
> > L1ss w/o checking if the HW could supports it... But how about
> > adding supports-clkreq stuff to upstream host driver directly? That
> > would help folks enable L1ss if the HW is ready and they just need
> > adding property to the DT.
> > ...
> 
> > The L1ss support is quite strict and need several steps to check, so we
> > didn't add supports-clkreq for them unless the HW is ready to go...
> > 
> > For adding supports of L1ss,
> > [1] the HW should support CLKREQ#, expecially for PCIe3.0 case on Rockchip
> > SoCs , since both  CLKREQ# of RC and EP should connect to the
> > 100MHz crystal generator's enable pin, as L1.2 need to disable refclk as
> > well. If the enable pin is high active, the HW even need a invertor....
> > 
> > [2] define proper clkreq iomux to pinctrl of pcie node
> > [3] make sure the devices work fine with L1ss.(It's hard to check the slot
> > case with random devices in the wild )
> > [4] add supports-clkreq to the DT and enable
> > CONFIG_PCIEASPM_POWER_SUPERSAVE
> 
> I don't understand the details of the supports-clkreq issue.
> 
> If we need to add supports-clkreq to devicetree, I want to understand
> why we need it there when we don't seem to need it for ACPI systems.
> 
> Generally the OS relies on what the hardware advertises, e.g., in Link
> Capabilities and the L1 PM Substates Capability, and what is available
> from firmware, e.g., the ACPI _DSM for Latency Tolerance Reporting.
> 
> On the ACPI side, I don't think we get any specific information about
> CLKREQ#.  Can somebody explain why we do need it on the devicetree
> side?
> 

I think there is a disconnect between enabling L1ss CAP and CLKREQ#
availability.. When L1ss CAP is enabled for the Root Port in the hardware, there
is no guarantee that CLKREQ# is also available. If CLKREQ# is not available,
then if L1ss is enabled by the OS, it is not possible to exit the L1ss states
(assuming that L1ss is entered due to CLKREQ# in deassert (default) state).

Yes, there seems to be no standard way to know CLKREQ# presence in ACPI, but
in devicetree, we have this 'supports-clkreq' property to tell the OS that
CLKREQ# is available in the platform. But unfortunately, this property is not
widely used by the devicetrees out there. So we cannot use it in generic
pci/aspm.c driver.

We can certainly rely on the BIOS to enable L1ss as the fw developers would
have the knowledge of the CLKREQ# availability. But BIOS is not a thing on
mobile and embedded platforms where L1ss would come handy.

What I would suggest is, the host controller drivers (mostly for devicetree
platforms) should enable L1ss CAP for the Root Port only if they know that
CLKREQ# is available. They can either rely on the 'supports-clkreq' property or
some platform specific knowledge (for instance, on all Qcom platforms, we
certainly know that CLKREQ# is available, but we don't set the DT property).

Then in the generic pci/aspm.c driver, we can just enable L1ss for all devices
if the CAP is set, which we do currently.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

