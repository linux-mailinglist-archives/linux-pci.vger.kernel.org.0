Return-Path: <linux-pci+bounces-39494-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8994CC12F9C
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 06:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04F6A4FA41B
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 05:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D412C17B6;
	Tue, 28 Oct 2025 05:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNXrOlJL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A552C17A8;
	Tue, 28 Oct 2025 05:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761629622; cv=none; b=sNTQZBVyaRUInC/70D+lRP/mJXIyGHAelG2n9TDL6rlsHdVA/oJgGFlw3VoEIIboQJr5rxJkWVZoByA/kOW632SEPbnnEY2Yz9Rm9ikhUC/jyRQk9nOdxcALtQx34JjQXCTKfNMndUtFYUx24OKyyRa2cn8yfkDa12ZFyHEhQ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761629622; c=relaxed/simple;
	bh=J1THBNPJwyRDVbWlqTQQL8lsHDatXz1imt9XImDpFxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsVXYLBnea62KF/oYFrBModkfVlUoSvOZUkC23R6EqnLqZUb4RszcyV0JbtCinICobrz/ipL3CfT2G8flO7JLWHvP6+o84GBempnX9eroiRkF1OdoQ/w7+sbWiUA/nrZokWQtRDz6S3BKxyxKrngb0SdBZySV+eP9bA5VbgEw3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNXrOlJL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE09C4CEE7;
	Tue, 28 Oct 2025 05:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761629621;
	bh=J1THBNPJwyRDVbWlqTQQL8lsHDatXz1imt9XImDpFxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KNXrOlJL3ORZ4LyNPAbMj5RN6s46786LfV09Spav2lf6B1n+5TLy2v356wB2IdIQr
	 IgCVhn/moawjgEPcRZOP3SpF7n1vFT0oTc7++GCiGpWOfQcalMpLjYncsJIvw2UwzM
	 B+/fjSVn0thaIeZnN8PMCzLBj62/+70Zvue/eH2nBUCXVT0DeESb2qeQv4qHEf533r
	 GaAsjq+nM1qqACJgsEfaedRn1OT/Kehn4hRsWVvCKwfQ1gEN2QL30vcr4OsaymLxrA
	 QxDcnqo2hnZPpdP75xfgtnNEl9sSB4vQ5/mBBxfdGgAPIuu/wYy6V3VpCz2U5dLC0t
	 O5GvSkZoyoQcQ==
Date: Tue, 28 Oct 2025 11:03:28 +0530
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
Message-ID: <qfrffijnf37qkdgvbsbfpzm3dsud7q3fvzrm33lzj7hwttqw3g@coah4xzo7zbs>
References: <5y3mxvvkwc2svsm5lt6okytkkw6u7yzfy4i5dgn3fs5v7s4i6i@qv2tvlxotom6>
 <20251027230703.GA1485546@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251027230703.GA1485546@bhelgaas>

On Mon, Oct 27, 2025 at 06:07:03PM -0500, Bjorn Helgaas wrote:
> On Mon, Oct 27, 2025 at 05:21:30PM +0530, Manivannan Sadhasivam wrote:
> > On Sun, Oct 26, 2025 at 02:37:54PM -0500, Bjorn Helgaas wrote:
> > > On Sun, Oct 26, 2025 at 08:58:29PM +0530, Manivannan Sadhasivam wrote:
> > > > On Fri, Oct 24, 2025 at 04:04:57PM -0500, Bjorn Helgaas wrote:
> > > > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > > > 
> > > > > This reverts commit a729c16646198872e345bf6c48dbe540ad8a9753.
> > > > > 
> > > > > Prior to a729c1664619 ("PCI: qcom: Remove custom ASPM enablement code"),
> > > > > the qcom controller driver enabled ASPM, including L0s, L1, and L1 PM
> > > > > Substates, for all devices powered on at the time the controller driver
> > > > > enumerates them.
> > > > > 
> > > > > ASPM was *not* enabled for devices powered on later by pwrctrl (unless the
> > > > > kernel was built with PCIEASPM_POWERSAVE or PCIEASPM_POWER_SUPERSAVE, or
> > > > > the user enabled ASPM via module parameter or sysfs).
> > > > > 
> > > > > After f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for
> > > > > devicetree platforms"), the PCI core enabled all ASPM states for all
> > > > > devices whether powered on initially or by pwrctrl, so a729c1664619 was
> > > > > unnecessary and reverted.
> > > > > 
> > > > > But f3ac2ff14834 was too aggressive and broke platforms that didn't support
> > > > > CLKREQ# or required device-specific configuration for L1 Substates, so
> > > > > df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree platforms")
> > > > > enabled only L0s and L1.
> > > > > 
> > > > > On Qualcomm platforms, this left L1 Substates disabled, which was a
> > > > > regression.  Revert a729c1664619 so L1 Substates will be enabled on devices
> > > > > that are initially powered on.  Devices powered on by pwrctrl will be
> > > > > addressed later.
> > ...
> 
> > > I have some heartburn about both the revert and the
> > > pci_host_set_default_pcie_link_state() approach because they apply to
> > > the entire hierarchy under a qcom or VMD root port, potentially
> > > including add-in cards with switches.  CLKREQ# (and possibly more) is
> > > required to enable L1SS, and I don't know if we can assume it's
> > > supported on add-in links.
> > 
> > I don't think we can assume, but at the same time, I don't think we
> > will ever be able to come up with a logical way to enable L1ss on
> > all devices. But if we leave the decision to the host controller
> > drivers, they can at least guarantee that the CLKREQ# and other
> > requirements are satisfied from the host perspective for L1ss. Then,
> > if any device exhibit erratic behavior, we will for sure know that
> > the device is at fault and we can quirk them.
> 
> If we can figure out that an endpoint is defective, a quirk is great.
> But the issue might be something in the path, e.g., some connector in
> the path leading to the endpoint doesn't include CLKREQ#, and we can't
> quirk the endpoint then.
> 

I got your concern, in this case, we can have board specific quirks for those
with broken connectors and such. Let's say if the SoC supports CLKREQ#, but one
of the downstream connectors of a switch connected to the Root Port doesn't,
then we can have a quirk based on the board compatible and the switch combo.
It is implied that the person who is designing the board is aware of this issue
and they can add the quirk by themselves (without affecting users).

> To me it sounds like the mainline kernel should be safe and only
> enable L1SS when it has a clear signal that it is safe, either via
> devicetree, ACPI, or L1SS configuration inherited from firmware.  I
> don't want a future of telling users to boot with "pcie_aspm=off" if
> a device doesn't work.
> 

It is a trade-off. I completely agree that we do not want to break users, but at
the same time, the kernel should provide optimum power savings by default also
(if it has the knowledge).

The SoCs targetting embedded/laptop usecases want to make use of L1ss to prevent
draining battery too fast. Currently, on Qcom platforms, we are asking our users
to enable ASPM through Kconfig/cmdline to make sure their laptop battery last
long. And we cannot ask distros to enable these for users as distros would only
use a common kernel/config for all platforms they support. So the burden
essentially lies on the user. All this could've been fixed if the BIOS enabled
L1ss, but it doesn't unfortunately.

Also, it is not possible to rely on DT/ACPI or other platform description to
tell the OS about CLKREQ# routing for all the devices in the topology. They can
give the information about Root Ports and other devices attached to the board in
the enclosure, but not about the devices that will get attached to the open slot
dynamically.

Also, for a discoverable bus like PCI, DT do not necessarily describe all
devices unless they requires some special handling like power sequencing.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

