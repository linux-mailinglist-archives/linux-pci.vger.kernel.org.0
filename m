Return-Path: <linux-pci+bounces-39430-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD0FC0E009
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 14:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED9B318880BA
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 13:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FDE28727B;
	Mon, 27 Oct 2025 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihRsIql2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEDE21C9EA;
	Mon, 27 Oct 2025 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571548; cv=none; b=BC8rF8WWq5+mvt2go/9Z5+huFywzjpmZNkMqlCgUmCBCTU63hw/l2TDy8Q+/ZbPKeaXf54Cd+mTHRckJ+O4+3jI+uiGNjMfiNTe9cC0dQPvJIsr1ZRBeMGBP0Q09A5j/Dzv65pcngi8DRCJcuQpqi6lk2wiI7xlkUt4asxY1itE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571548; c=relaxed/simple;
	bh=zNGpOEoYqx7xy5cROnhdp1a4nB6KZU1eGaURTKMN9ME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHyn4w1cmIhhpu2CIDkdbiHqmJ3AZ9CIyH+ynNlV0wjMlT3NmPCi0a7adOJAro/2NOcpCHTI2Ku8iAD14zbYT1UEnAjp3aXaelZOEOfPsCHgxSgrDChptt2bGaK1kkJZcPRfADaRPUYl4K3LWy+a7feoj5dCJ9F9dbhYE5OeLfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihRsIql2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735D4C4CEF1;
	Mon, 27 Oct 2025 13:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761571547;
	bh=zNGpOEoYqx7xy5cROnhdp1a4nB6KZU1eGaURTKMN9ME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ihRsIql2mINFsL666nVwdasscR0qhrmzn7orDsLo4NkORvVAozkZweHJ2dTrgAOrq
	 OuVH8alQ4Aqs6rBDcnJ8SZwrHeIl05V5xyja45x3YdzIJssQ4usT/CtGFI6p2wx2/4
	 3U3B+Rv86/nd/Hdnb1/gTsWKcgZk+elgPAM+KZezXaSmVxD8w1RBloWwYjp2dY5yxr
	 SW2qBemry5Nv/TWLV5GNerxZVeg5VBNNaNnyTc2hutKctEEFoP+S2Ss7ePftZqhCmG
	 Ub+J1osOQfVOZ/gOSKPSmHtF3hmNeb2gtuAo/m3m1yFEULeitbyduwncDwfqOc3VqJ
	 8GbNj/GhG3Rjg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vDNEM-0000000004y-3FQc;
	Mon, 27 Oct 2025 14:25:50 +0100
Date: Mon, 27 Oct 2025 14:25:50 +0100
From: Johan Hovold <johan@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Frank Li <Frank.li@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>,
	Rob Herring <robh@kernel.org>,
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
Message-ID: <aP9y3nK0FlgINa0o@hovoldconsulting.com>
References: <20251024210514.1365996-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024210514.1365996-1-helgaas@kernel.org>

On Fri, Oct 24, 2025 at 04:04:57PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> This reverts commit a729c16646198872e345bf6c48dbe540ad8a9753.
> 
> Prior to a729c1664619 ("PCI: qcom: Remove custom ASPM enablement code"),
> the qcom controller driver enabled ASPM, including L0s, L1, and L1 PM
> Substates, for all devices powered on at the time the controller driver
> enumerates them.
> 
> ASPM was *not* enabled for devices powered on later by pwrctrl (unless the
> kernel was built with PCIEASPM_POWERSAVE or PCIEASPM_POWER_SUPERSAVE, or
> the user enabled ASPM via module parameter or sysfs).
> 
> After f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for
> devicetree platforms"), the PCI core enabled all ASPM states for all
> devices whether powered on initially or by pwrctrl, so a729c1664619 was
> unnecessary and reverted.
> 
> But f3ac2ff14834 was too aggressive and broke platforms that didn't support
> CLKREQ# or required device-specific configuration for L1 Substates, so
> df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree platforms")
> enabled only L0s and L1.
> 
> On Qualcomm platforms, this left L1 Substates disabled, which was a
> regression.  Revert a729c1664619 so L1 Substates will be enabled on devices
> that are initially powered on.  Devices powered on by pwrctrl will be
> addressed later.
> 
> Fixes: df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree platforms")
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

This indeed re-enables L1SS for the X13s NVMe:

Reported-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/lkml/aPuXZlaawFmmsLmX@hovoldconsulting.com/
Tested-by: Johan Hovold <johan@kernel.org>

Johan

