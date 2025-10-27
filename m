Return-Path: <linux-pci+bounces-39476-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E8CC11EEF
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 00:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B67FB4EA1BB
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 23:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A649430CD81;
	Mon, 27 Oct 2025 23:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSEvrJ1w"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ACF30AAA9;
	Mon, 27 Oct 2025 23:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761606425; cv=none; b=t3Oys4gIF6oH77rIOV3MJYSKyLdjBUsoFpHQgHunTtArMzkwp2+v333ojSSpp1+AUhKU/0+GplxWU/y+stiy6Vo9M1ICAU8NMck2RP4um2TURIJSpeaW54LzQN8DHRCq2N09RNOLRglKY27vG2IrOGMz94Yag54Zj0b59Y2h2pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761606425; c=relaxed/simple;
	bh=5gOHO/e0ndSafRIOzlPO0K8k5ePcPqe4KtN2yzyOw8U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kveSen+jY9/YLT4uCn5ktAZ5/JaaZjIfmBZmG8/tod/owbyFjWhTYgWftJWUOeSWGEeo1K3nqT1VYDiiUuyyVtIF1hi9eiCNCT2Fv40bgE/3o2VpIx2QaV5gqJlg65WfTJ4w4uoiAcTKtmxEJTdSMIN10wyKhSfLg2MnBOkQNQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSEvrJ1w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7164C4CEF1;
	Mon, 27 Oct 2025 23:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761606424;
	bh=5gOHO/e0ndSafRIOzlPO0K8k5ePcPqe4KtN2yzyOw8U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dSEvrJ1wkFFGe5bnUGkbIYfE86etfhigNy/f6BF1PB43bMI8qg7ocqY6Ho1AFr40A
	 T4OGkX5mH6Myq4NWS/xnoPtU+5LqqdAijz736A/dBxNVLVQ/HlCYR2kNKDmJYI+LHT
	 uAF/yviv/Il00GdxGkCaUuPxxlWhb27pQrjdb2wkJp1W4m+R4d0W8luHlEk6iBz3Z8
	 wyKlPqpAtWYWrSmVUkNaPmeIAY93tXfCRT5AlPgAzjk8Xif54uYoTaKUxzQXFhQWXe
	 6iczFEIcx9hfOTutKEM4ZOJr0QWZBaCVXr48z3uw5i6lgOXa8Dq6eBNG+9M3ZJiJM9
	 rrdaXGerla/IQ==
Date: Mon, 27 Oct 2025 18:07:03 -0500
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
Message-ID: <20251027230703.GA1485546@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5y3mxvvkwc2svsm5lt6okytkkw6u7yzfy4i5dgn3fs5v7s4i6i@qv2tvlxotom6>

On Mon, Oct 27, 2025 at 05:21:30PM +0530, Manivannan Sadhasivam wrote:
> On Sun, Oct 26, 2025 at 02:37:54PM -0500, Bjorn Helgaas wrote:
> > On Sun, Oct 26, 2025 at 08:58:29PM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, Oct 24, 2025 at 04:04:57PM -0500, Bjorn Helgaas wrote:
> > > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > > 
> > > > This reverts commit a729c16646198872e345bf6c48dbe540ad8a9753.
> > > > 
> > > > Prior to a729c1664619 ("PCI: qcom: Remove custom ASPM enablement code"),
> > > > the qcom controller driver enabled ASPM, including L0s, L1, and L1 PM
> > > > Substates, for all devices powered on at the time the controller driver
> > > > enumerates them.
> > > > 
> > > > ASPM was *not* enabled for devices powered on later by pwrctrl (unless the
> > > > kernel was built with PCIEASPM_POWERSAVE or PCIEASPM_POWER_SUPERSAVE, or
> > > > the user enabled ASPM via module parameter or sysfs).
> > > > 
> > > > After f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for
> > > > devicetree platforms"), the PCI core enabled all ASPM states for all
> > > > devices whether powered on initially or by pwrctrl, so a729c1664619 was
> > > > unnecessary and reverted.
> > > > 
> > > > But f3ac2ff14834 was too aggressive and broke platforms that didn't support
> > > > CLKREQ# or required device-specific configuration for L1 Substates, so
> > > > df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree platforms")
> > > > enabled only L0s and L1.
> > > > 
> > > > On Qualcomm platforms, this left L1 Substates disabled, which was a
> > > > regression.  Revert a729c1664619 so L1 Substates will be enabled on devices
> > > > that are initially powered on.  Devices powered on by pwrctrl will be
> > > > addressed later.
> ...

> > I have some heartburn about both the revert and the
> > pci_host_set_default_pcie_link_state() approach because they apply to
> > the entire hierarchy under a qcom or VMD root port, potentially
> > including add-in cards with switches.  CLKREQ# (and possibly more) is
> > required to enable L1SS, and I don't know if we can assume it's
> > supported on add-in links.
> 
> I don't think we can assume, but at the same time, I don't think we
> will ever be able to come up with a logical way to enable L1ss on
> all devices. But if we leave the decision to the host controller
> drivers, they can at least guarantee that the CLKREQ# and other
> requirements are satisfied from the host perspective for L1ss. Then,
> if any device exhibit erratic behavior, we will for sure know that
> the device is at fault and we can quirk them.

If we can figure out that an endpoint is defective, a quirk is great.
But the issue might be something in the path, e.g., some connector in
the path leading to the endpoint doesn't include CLKREQ#, and we can't
quirk the endpoint then.

To me it sounds like the mainline kernel should be safe and only
enable L1SS when it has a clear signal that it is safe, either via
devicetree, ACPI, or L1SS configuration inherited from firmware.  I
don't want a future of telling users to boot with "pcie_aspm=off" if
a device doesn't work.

Enabling L1SS *without* such a clear signal feels like something
downstream kernels might have to do when they know more about the
topology.

Bjorn

