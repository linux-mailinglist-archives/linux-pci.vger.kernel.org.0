Return-Path: <linux-pci+bounces-43593-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 296A9CD98C8
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 15:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ED29304A8E9
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 14:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC20B2F2910;
	Tue, 23 Dec 2025 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIyj+UG9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD04A21FF35;
	Tue, 23 Dec 2025 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766498740; cv=none; b=X1Fc/lmKV0NwhPnMRjHjBCiiNA/kWTWwdROsKj56vulpK/T7vnUBdAxQlnpM+/7eyYlS/6ZaRDz++2t8JXQYKSDtIK+cnyJl0t9tlbMEkBzX+MbhsiK+vHsWqYASAkdELHzwXGr0BphELP1kgD3oDw6aqc1i5XlQabnDzMyGk5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766498740; c=relaxed/simple;
	bh=h5Kw6v7fUpU3SyasuJlXbrAXSL3afi1irgw9bEV79UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdpbxYdk/XIVlDog5qmhT8XUIHSXQxw0D+44ixuUnaCrsDBGmCJnQRng25gnIWTkbfq+cklAr0jDmhmnx8f/dhqfPaZ+5NOssukIokdpFLgnqljBimHXmblrEbqJ+3jbR/EAMxm7I5MGQMM8pmciQKCfKazR75wVjoZtB5BPtHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIyj+UG9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE21C113D0;
	Tue, 23 Dec 2025 14:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766498740;
	bh=h5Kw6v7fUpU3SyasuJlXbrAXSL3afi1irgw9bEV79UU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TIyj+UG9nlqQWSXJ/hPmdoGAq0NYIsbVT/3WxHBK+NHCgJANJnmJwsF+Fe99vseag
	 k1KpUM+BfOcv3UtlWM1NA2PPdHV9V8000ldEbajF9Y2JAMkCyFZSwWV+4V5WzAG+6a
	 JMn9MfHuT9MVC8lQ9VVD1RAVEaYl8CUe2J74F9IsX2NCPQc3y0NIuZniCzqA5KwSHd
	 6W3NTyb/p2ENVZt0Sw3bh3AyezDsueyDt0AT86zzUCQfovGnbidRJKEBFdf/TvfEuc
	 SrdK/lNBKC2jHW212h01zE9MItkO+rkmpgjFfU+Kx9ejAhj/PMy4Vno5kxsiPzEYJE
	 b43G0CkCkPaAA==
Date: Tue, 23 Dec 2025 19:35:32 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Bartosz Golaszewski <brgl@kernel.org>, linux-pci@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
	Brian Norris <briannorris@chromium.org>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>, 
	Chen-Yu Tsai <wenst@chromium.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 0/5] PCI/pwrctrl: Major rework to integrate pwrctrl
 devices with controller drivers
Message-ID: <n2vboqjh45bwhs3czpey3alxwi7msohir7m3lk45mecouddwew@byi2emazszqq>
References: <20251216-pci-pwrctrl-rework-v2-0-745a563b9be6@oss.qualcomm.com>
 <39e025bd-50f4-407d-8fd4-e254dbed46b2@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39e025bd-50f4-407d-8fd4-e254dbed46b2@linux.dev>

On Fri, Dec 19, 2025 at 12:19:36PM -0500, Sean Anderson wrote:
> Hi,
> 
> I have a few comments on the overall architecture. I did some work to
> add PERST as well (sent as replies to this message).
> 
> On 12/16/25 07:51, Manivannan Sadhasivam wrote:
> > Hi,
> > 
> > This series provides a major rework for the PCI power control (pwrctrl)
> > framework to enable the pwrctrl devices to be controlled by the PCI controller
> > drivers.
> > 
> > Problem Statement
> > =================
> > 
> > Currently, the pwrctrl framework faces two major issues:
> > 
> > 1. Missing PERST# integration
> > 2. Inability to properly handle bus extenders such as PCIe switch devices
> > 
> > First issue arises from the disconnect between the PCI controller drivers and
> > pwrctrl framework. At present, the pwrctrl framework just operates on its own
> > with the help of the PCI core. The pwrctrl devices are created by the PCI core
> > during initial bus scan and the pwrctrl drivers once bind, just power on the
> > PCI devices during their probe(). This design conflicts with the PCI Express
> > Card Electromechanical Specification requirements for PERST# timing. The reason
> > is, PERST# signals are mostly handled by the controller drivers and often
> > deasserted even before the pwrctrl drivers probe. According to the spec, PERST#
> > should be deasserted only after power and reference clock to the device are
> > stable, within predefined timing parameters.
> > 
> > The second issue stems from the PCI bus scan completing before pwrctrl drivers
> > probe. This poses a significant problem for PCI bus extenders like switches
> > because the PCI core allocates upstream bridge resources during the initial
> > scan. If the upstream bridge is not hotplug capable, resources are allocated
> > only for the number of downstream buses detected at scan time, which might be
> > just one if the switch was not powered and enumerated at that time. Later, when
> > the pwrctrl driver powers on and enumerates the switch, enumeration fails due to
> > insufficient upstream bridge resources.
> >
> >
> > Proposal
> > ========
> > 
> > This series addresses both issues by introducing new individual APIs for pwrctrl
> > device creation, destruction, power on, and power off operations.
> 
> I wrote my own PCI power sequencing subsystem last year but didn't get
> around to upstreaming it before the current subsystem was merged. This
> approach (individual APIs for each power sequence) was how I did it. But
> I think the approach to do everything in probe is rather elegant, since
> it integrates with the existing device model and we don't need to modify
> existing drivers.
> 
> To contrast, in U-Boot the second issue doesn't apply because driver
> probing happens synchronously and config space accesses are done after
> devices get probed. So you have something like
> 
> host bridge probe()
> pci_scan_child_bus()
>    discover root port
>    root port probe()
>       initialize slot resources (power supplies, clocks, etc.)
>    allocate root port BARs
>    discover root port children
> 
> I guess your approach is the only way to do it in Linux given the
> asynchronous nature of driver binding. What is the overhead for hotplug
> switches like? Maybe it makes sense to just treat all switches as
> hotplug capable when PCI power sequencing is enabled?
> 

Pwrctrl doesn't care if the underlying bridge is hotplug capable or not. It just
handles the power control for the device if it happens to have resource
dependency in DT. For example, if the PCIe switch requires pwrctrl and the
corresponding DT node has the resources described, pwrctrl framework will just
turn ON the switch. Then during PCI bus scan, PCI core will enumerate the switch
and check whether the downstream ports are hotplug capable or not and handles
the bus resource accordingly.

> > Controller
> > drivers are expected to invoke these APIs during their probe(), remove(),
> > suspend(), and resume() operations. This integration allows better coordination
> > between controller drivers and the pwrctrl framework, enabling enhanced features
> > such as D3Cold support.
> 
> How does PERST work? The only reference I can find to GPIOs in this
> series is in the first patch. Is every driver supposed to add support
> for PERST and then call these new functions?

Yes. We can come up with some generic controller specific APIs later to reduce
duplication, especially if GPIO is used for PERST#. But that's currently not in
scope for this series.

> Shouldn't this be handled
> by the power sequencing driver, especially as there are timing
> requirements for the other resources referenced to PERST? IMO if we are
> going to touch each driver, it would be much better to consolidate
> things by removing the ad-hoc PERST support.
> 

It is not that straightforward. Initially, my goal was to abstract pwrctrl away
from controller drivers, but then that didn't scale. Because, each controller
drivers have different requirement, some may use GPIO for PERST# and some use
MMIO. Also, some drivers do more work during the PERST# deassert, like checking
for Link up as in drivers/pci/controller/pci-tegra.c.

For sure, it would be doable to rework those drivers for pwrctrl, but that is
not practically possible and requires platform maintainer support. So to make
the pwrctrl adoption easier, I went with the explicit APIs that the drivers can
call from relevant places.

> > The original design aimed to avoid modifying controller drivers for pwrctrl
> > integration. However, this approach lacked scalability because different
> > controllers have varying requirements for when devices should be powered on. For
> > example, controller drivers require devices to be powered on early for
> > successful PHY initialization.
> 
> Is this the case for qcom? The device I tested (nwl) was perfectly
> happy to have the PCI device show up some time after the host bridge
> got probed.
> 

Not for Qcom, but some platforms do LTSSM during phy_init(), so they will fail
if the device is not powered ON at that time.

The challenge with the pwrctrl framework is that, it has to work across all
platforms and with the existing drivers without major rework. The initial design
worked for Qcom (somewhat), but I couldn't get it to scale across other
platforms.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

