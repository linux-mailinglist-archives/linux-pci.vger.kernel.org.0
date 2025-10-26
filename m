Return-Path: <linux-pci+bounces-39347-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7DDC0B145
	for <lists+linux-pci@lfdr.de>; Sun, 26 Oct 2025 20:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254F3189EF2A
	for <lists+linux-pci@lfdr.de>; Sun, 26 Oct 2025 19:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204222153E7;
	Sun, 26 Oct 2025 19:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KncyBaB7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1B676026;
	Sun, 26 Oct 2025 19:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761507477; cv=none; b=uPNuxZCS90sD7awaSW+VfujEpM0bRJ3/Vl05RUO+StQgOwBhO9ufHrp85txlbMQGanr0ESL5dqwmqRK82AccREEBmwbzKHZABXqgPnBxaJA8oZmu3CwSMFJH+kcZNO3ld1RQGYni1SxnME7Wch4pZuendaQXPYQ3KaVm9MSeH5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761507477; c=relaxed/simple;
	bh=+ciTEVmI0wG+8ArlT4ieOrUCVVyPlrehDfttcyUWrag=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=F1NpUKAjr1WjlATv9J9BKmpux2T/9cLAqzfSLaJ2c7N953sQZnL/vBq5YvBMe/xRlVNPk15nXorhMoEoNQ3i0HNXVuOrZFDfNYfBUpN16nZlHbMtCVGcnU0lveY0OIQ8IO656Fwi+Zq+7G1wbry5D6/dzcOeB1hYmV/pdXqcMZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KncyBaB7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4407DC4CEE7;
	Sun, 26 Oct 2025 19:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761507476;
	bh=+ciTEVmI0wG+8ArlT4ieOrUCVVyPlrehDfttcyUWrag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KncyBaB7f5JeHlN3t4HKyPKcq7dAVdNXsA5J4x7l75KKnNht9QnxvjED0cU10jLzo
	 sA3WdH1o7ptStyKpjRX0yaN8yW4zeKVVqB9kV2foOHixvyyiWkRRDp1vrz498ylUXx
	 VCJEcVLb8M77qgvmIandj8Qt7GjvYNgLqMNfQsiSvXR09qx2PcaA3vKWmszEiDBsE2
	 hQiFjhjJ3aqcOofRVmA5Ll61v5CUl++iYWAvSgzH4yTU8xmBpESYYESfe5i+snzIyP
	 CMti162/9y2fRXUx40P2fEKSK7AkXwv+zGHf7M4lx+gAhrZt5T49XcENB5EVPVXnPY
	 pv4qM3SgrquZQ==
Date: Sun, 26 Oct 2025 14:37:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Johan Hovold <johan@kernel.org>, Frank Li <Frank.li@nxp.com>,
	Shawn Lin <shawn.lin@rock-chips.com>, Rob Herring <robh@kernel.org>,
	"David E . Box" <david.e.box@linux.intel.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Chia-Lin Kao <acelan.kao@canonical.com>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Han Jingoo <jingoohan1@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] Revert "PCI: qcom: Remove custom ASPM enablement code"
Message-ID: <20251026193754.GA1432729@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rc4ydm2c3c4gqipaorr2ndrlwufay3ocfc2rq7llskkg7npe6x@53eztxy5v3gt>

On Sun, Oct 26, 2025 at 08:58:29PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Oct 24, 2025 at 04:04:57PM -0500, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > This reverts commit a729c16646198872e345bf6c48dbe540ad8a9753.
> > 
> > Prior to a729c1664619 ("PCI: qcom: Remove custom ASPM enablement code"),
> > the qcom controller driver enabled ASPM, including L0s, L1, and L1 PM
> > Substates, for all devices powered on at the time the controller driver
> > enumerates them.
> > 
> > ASPM was *not* enabled for devices powered on later by pwrctrl (unless the
> > kernel was built with PCIEASPM_POWERSAVE or PCIEASPM_POWER_SUPERSAVE, or
> > the user enabled ASPM via module parameter or sysfs).
> > 
> > After f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for
> > devicetree platforms"), the PCI core enabled all ASPM states for all
> > devices whether powered on initially or by pwrctrl, so a729c1664619 was
> > unnecessary and reverted.
> > 
> > But f3ac2ff14834 was too aggressive and broke platforms that didn't support
> > CLKREQ# or required device-specific configuration for L1 Substates, so
> > df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree platforms")
> > enabled only L0s and L1.
> > 
> > On Qualcomm platforms, this left L1 Substates disabled, which was a
> > regression.  Revert a729c1664619 so L1 Substates will be enabled on devices
> > that are initially powered on.  Devices powered on by pwrctrl will be
> > addressed later.
> 
> Can we rather have platform specific APIs [1] to enable ASPM states
> instead of just re-introducing this half-baked solution? (yes, I
> introduced it, but it is still imperfect).

I intend this (reverting "PCI: qcom: Remove custom ASPM enablement
code") for v6.18 to avoid regressing Qualcomm: v6.17 enabled L1 PM
Substates, and v6.18-rc3 does not.

Adding pci_host_set_default_pcie_link_state() with [1] (along with a
follow-up qcom patch using it) is another possible way to enable L1 PM
Substates, but I think the revert is the safest post-merge window
regression fix.

I have some heartburn about both the revert and the
pci_host_set_default_pcie_link_state() approach because they apply to
the entire hierarchy under a qcom or VMD root port, potentially
including add-in cards with switches.  CLKREQ# (and possibly more) is
required to enable L1SS, and I don't know if we can assume it's
supported on add-in links.

> I think we have learned by hard way that enabling ASPM by default
> can have catastrophic effects for reasons we do not certainly know.
> So how about having this platform specific API that enables
> individual platforms to enable the ASPM states?

As far as I know, it's L1SS that has catastrophic effects.  I haven't
seen anything for L0s or L1.

> [1]
> https://lore.kernel.org/linux-pci/20250825203542.3502368-1-david.e.box@linux.intel.com/

