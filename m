Return-Path: <linux-pci+bounces-39417-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90852C0D614
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 13:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D7C2425BF0
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 11:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEE72FE07B;
	Mon, 27 Oct 2025 11:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtcmtNAw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A088B2EF64C;
	Mon, 27 Oct 2025 11:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565907; cv=none; b=l7LnC5UEzIYiFz9e4Lj7b5F+HllN6Wvq7d7YwLlQa+yMOEcVZ5GJZqgMyPbY/Is6Jui877bDK63sK7JwStKM3m9/YNVyLe0nChO7QLS61q/l7qOUeCx+YYED9m3wzPbJgrHSkkwVTke7npv8LMBy7yEoN3EqqEJ2wrPeZEJHo1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565907; c=relaxed/simple;
	bh=fVlqESagcacb+xwYcCepLg1dl8NdeGd/ef9wAhmszuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlRf2WmW/MUEnioJcPlWg97WKwM5CitnTHbP3Z12z1Srk7NSlCS0F/3HF1N5klkmFZTh8spEN2H0lgQ0O39PVuyURk/Xl84wL1On/7urgkazT0JF9NiwWkI6bklX0fe6fQn0cMuReVNZqGtC3u50gqgj+sZFce25mZhKu9o2NNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtcmtNAw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1673BC4CEF1;
	Mon, 27 Oct 2025 11:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761565907;
	bh=fVlqESagcacb+xwYcCepLg1dl8NdeGd/ef9wAhmszuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KtcmtNAwRor5AzebaF1lyQq4Y2hLUEDr1PtoNt7FZ5rIR9fhu6qLdL0Yr5FlYXKz3
	 NxEFJinKGC4skZedHv2TK85bO7bbPlFOPR+OyK2LI9S+8CeQ4EYXfaE62zWm9G1yP5
	 FxjztNVmutARaidTzSeKWOB+eM+BPKoPJBn7GmF4CsQ5sA1ZNlUVqxsjJgSMUibEp4
	 +Y9nns+Do/3Mrlcm/faYtGN/GB0LMO5M15NoZ4oG5TJasBrP45huOosHTgFWXOqAxb
	 f0YiIrAaIhnL/0qqrQGooWIzOAXqvX4f5RELfEvjkFEiWNAChmecGIZhSrE7CJRUES
	 XKlnb1JmgFsLQ==
Date: Mon, 27 Oct 2025 17:21:30 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Frank Li <Frank.li@nxp.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Rob Herring <robh@kernel.org>, 
	"David E . Box" <david.e.box@linux.intel.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Chia-Lin Kao <acelan.kao@canonical.com>, Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
	Han Jingoo <jingoohan1@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] Revert "PCI: qcom: Remove custom ASPM enablement code"
Message-ID: <5y3mxvvkwc2svsm5lt6okytkkw6u7yzfy4i5dgn3fs5v7s4i6i@qv2tvlxotom6>
References: <rc4ydm2c3c4gqipaorr2ndrlwufay3ocfc2rq7llskkg7npe6x@53eztxy5v3gt>
 <20251026193754.GA1432729@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251026193754.GA1432729@bhelgaas>

On Sun, Oct 26, 2025 at 02:37:54PM -0500, Bjorn Helgaas wrote:
> On Sun, Oct 26, 2025 at 08:58:29PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Oct 24, 2025 at 04:04:57PM -0500, Bjorn Helgaas wrote:
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > 
> > > This reverts commit a729c16646198872e345bf6c48dbe540ad8a9753.
> > > 
> > > Prior to a729c1664619 ("PCI: qcom: Remove custom ASPM enablement code"),
> > > the qcom controller driver enabled ASPM, including L0s, L1, and L1 PM
> > > Substates, for all devices powered on at the time the controller driver
> > > enumerates them.
> > > 
> > > ASPM was *not* enabled for devices powered on later by pwrctrl (unless the
> > > kernel was built with PCIEASPM_POWERSAVE or PCIEASPM_POWER_SUPERSAVE, or
> > > the user enabled ASPM via module parameter or sysfs).
> > > 
> > > After f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for
> > > devicetree platforms"), the PCI core enabled all ASPM states for all
> > > devices whether powered on initially or by pwrctrl, so a729c1664619 was
> > > unnecessary and reverted.
> > > 
> > > But f3ac2ff14834 was too aggressive and broke platforms that didn't support
> > > CLKREQ# or required device-specific configuration for L1 Substates, so
> > > df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree platforms")
> > > enabled only L0s and L1.
> > > 
> > > On Qualcomm platforms, this left L1 Substates disabled, which was a
> > > regression.  Revert a729c1664619 so L1 Substates will be enabled on devices
> > > that are initially powered on.  Devices powered on by pwrctrl will be
> > > addressed later.
> > 
> > Can we rather have platform specific APIs [1] to enable ASPM states
> > instead of just re-introducing this half-baked solution? (yes, I
> > introduced it, but it is still imperfect).
> 
> I intend this (reverting "PCI: qcom: Remove custom ASPM enablement
> code") for v6.18 to avoid regressing Qualcomm: v6.17 enabled L1 PM
> Substates, and v6.18-rc3 does not.
> 
> Adding pci_host_set_default_pcie_link_state() with [1] (along with a
> follow-up qcom patch using it) is another possible way to enable L1 PM
> Substates, but I think the revert is the safest post-merge window
> regression fix.
> 

I'm fine with the revert as a stopgap solution.

> I have some heartburn about both the revert and the
> pci_host_set_default_pcie_link_state() approach because they apply to
> the entire hierarchy under a qcom or VMD root port, potentially
> including add-in cards with switches.  CLKREQ# (and possibly more) is
> required to enable L1SS, and I don't know if we can assume it's
> supported on add-in links.
> 

I don't think we can assume, but at the same time, I don't think we will ever be
able to come up with a logical way to enable L1ss on all devices. But if we
leave the decision to the host controller drivers, they can at least guarantee
that the CLKREQ# and other requirements are satisfied from the host perspective
for L1ss. Then, if any device exhibit erratic behavior, we will for sure know
that the device is at fault and we can quirk them.

> > I think we have learned by hard way that enabling ASPM by default
> > can have catastrophic effects for reasons we do not certainly know.
> > So how about having this platform specific API that enables
> > individual platforms to enable the ASPM states?
> 
> As far as I know, it's L1SS that has catastrophic effects.  I haven't
> seen anything for L0s or L1.
> 

As Johan mentioned, we did see a near-catastrophic effect with enabling L0s on
some Qcom SoCs and we disabled the L0s CAP for them.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

