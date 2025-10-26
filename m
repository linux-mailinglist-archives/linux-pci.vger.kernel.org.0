Return-Path: <linux-pci+bounces-39336-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB04C0AC52
	for <lists+linux-pci@lfdr.de>; Sun, 26 Oct 2025 16:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCB304E2867
	for <lists+linux-pci@lfdr.de>; Sun, 26 Oct 2025 15:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A98204F99;
	Sun, 26 Oct 2025 15:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pT5Q0xKc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A751C862D;
	Sun, 26 Oct 2025 15:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761492525; cv=none; b=fJ5sRTa93++NUk1WhVfCj83c28OAdh41bs0UUv9FfUH3sBshyy1G1UQZJUu4iUlttfruAFe7DWcHa38nzt1q5Q5pFXa+/ljL89dCieI36I/CrvElFSgR9AeOfhys7V5pVU3+18/jgPuxzLsKB445i51pBJER4uGGCW+DAmbj4EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761492525; c=relaxed/simple;
	bh=cXg5Y6Gys/l7bw4sXdeP7KS4qm3JZg918Svq6350p9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ceJM9732u/cV5uRxErfgqhkkr5Os4PmuUZX31q3Z3t4iSHj71LAI+TAQI5FbbR49bZ3PTIlXntVc6sHkD5a9Oqihh6wsN96q8KweJ+dur6ZCMhKCngrx5gBACEqPTeqpT4PTbcdKKq4VsXdFaX8Kb+tmP2tuNxC95QlcjIpK7oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pT5Q0xKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E8CC4CEE7;
	Sun, 26 Oct 2025 15:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761492525;
	bh=cXg5Y6Gys/l7bw4sXdeP7KS4qm3JZg918Svq6350p9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pT5Q0xKcBBvJO58gDOdtfD9FYYoXPytBMzulKe+Dv7KA+9WvobXxkHdvYA/4NHInu
	 gjvFFsJ7AXqHZTuQtLwzNHA6yGbC73tTbeEy+gj37QNRsem+eLBcP841cr+/cjVfcI
	 39ctiZUAaBd21lKYzqmfiGuusKP8V0oyjBy7HxvKDmkQfdij+oBQEi0RJXYNpwaQaM
	 YJSL2V8KbCve6EJf3aBUbE74BV0Li6KUAbJ0jzllT4V47o3ZGYnmWT7bjGBiRpdFtG
	 y4OTVmkIG0iG6/YKDpiI9mdcyDp0YZ4IuLQCVm3jaRoAiFzz07MJECinTx1yucJ6Wg
	 mHjUcx1qA7hTQ==
Date: Sun, 26 Oct 2025 20:58:29 +0530
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
Message-ID: <rc4ydm2c3c4gqipaorr2ndrlwufay3ocfc2rq7llskkg7npe6x@53eztxy5v3gt>
References: <20251024210514.1365996-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

Can we rather have platform specific APIs [1] to enable ASPM states instead of just
re-introducing this half-baked solution? (yes, I introduced it, but it is still
imprefect).

I think we have learned by hard way that enabling ASPM by default can have
catastrophic effects for reasons we do not certainly know. So how about having
this platform specific API that enables individual platforms to enable the ASPM
states?

Sure, relying on the 'supports-clkreq' DT property will work for some platforms,
but this property is not widely used by all DT platforms (except Nvidia). For
instance, all our Qcom platforms support all ASPM states (except some known
platforms that do not support L0s due to incorrect PHY register settings) and we
do not set 'supports-clkreq' in DT. We can add them now, but old DTs which users
do not update will still suffer.

And we do not have a solution for VMD yet. So IMO, it is best to leave the ASPM
enablement to host controller drivers if they have the knowledge about it.

- Mani

[1] https://lore.kernel.org/linux-pci/20250825203542.3502368-1-david.e.box@linux.intel.com/

-- 
மணிவண்ணன் சதாசிவம்

