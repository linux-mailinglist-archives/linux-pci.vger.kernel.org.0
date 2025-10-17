Return-Path: <linux-pci+bounces-38497-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67472BEABEA
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 18:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8373296672C
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 16:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F36B28466F;
	Fri, 17 Oct 2025 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+8YGTUm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D6228312E;
	Fri, 17 Oct 2025 16:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718372; cv=none; b=l6dm5AYZVIESHhfCDfwnOk7vkqPG/NKYVdw8KXbOo4+OhMu5qhm/JbGNAzAgcegxGZXcGwkfnJIZoO/HqMsPwIFzVBG7fedbNUnSgxC7rN2LFT29wWVsRRSL/WPvclTi4FW1nw+L5SiIZ7ChY6yxuCiUf8Lisapd+V5oI6w5pAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718372; c=relaxed/simple;
	bh=oDHMy3vr+9Qtf5+BxB/LWUM1G0y5BBEx2S+OAkVam68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgjHKgnA6qYSFXpn2q3Fr6ao+8AFdgdUo9/SWj1X0XLsF4I3ncBVBECkZKu18SiBbP/0UcLAIAHlWlss0PT00ymmHTI0rY4rMou96gXf2Nd70orlewFWQ/rp5Q2TFpkVfyoYDtqRqIUrURxnA+rc899aCArGWI6CB95IrNULEJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+8YGTUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12DDC4CEE7;
	Fri, 17 Oct 2025 16:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760718371;
	bh=oDHMy3vr+9Qtf5+BxB/LWUM1G0y5BBEx2S+OAkVam68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L+8YGTUm5DRRj+PSEOr+b+35C/DdzCkNLCoKTghG4WwSDNg6LWVop/Ebxmmd4xOyr
	 yA9ryLKuB6UzANJSoc/YTxel2IgtGwklt1M7GDQ+Dyaun2QQlfgfekSyOEfD8BgkKA
	 0cbMHOAXnh3faqniTspYQ39jYxjWkL3rARpLy0livogtsRdbnMoNcEUq5/YWeO0GAB
	 ZBgaoEOT1d37lXNejE+0xH/d6F7C+dBtJIM8u1UGPzFmLgWB0p+6LB2R2zd1Uu11q0
	 +qv2HDSlIwe8zyuNVkUAa7WPK12eTDIIcL77VfhOf1lpQcAkt+99At0kta4jN2WBq0
	 yK7502pHdSDGQ==
Date: Fri, 17 Oct 2025 18:26:04 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, Damien Le Moal <dlemoal@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>, FUKAUMI Naoki <naoki@radxa.com>,
	Diederik de Haas <diederik@cknow-tech.com>, stable@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] PCI: dw-rockchip: Disable L1 substates
Message-ID: <aPJuHCuA2QempRui@ryzen>
References: <20251016090422.451982-2-cassel@kernel.org>
 <20251016172504.GA991252@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016172504.GA991252@bhelgaas>

On Thu, Oct 16, 2025 at 12:25:04PM -0500, Bjorn Helgaas wrote:
> On Thu, Oct 16, 2025 at 11:04:22AM +0200, Niklas Cassel wrote:
> > The L1 substates support requires additional steps to work, see e.g.
> > section '11.6.6.4 L1 Substate' in the RK3588 TRM V1.0.
> > 
> > These steps are currently missing from the driver.
> 
> Can we outline here specifically what is missing?

Sure.

> 
> > While this has always been a problem when using e.g.
> > CONFIG_PCIEASPM_POWER_SUPERSAVE=y, the problem became more apparent after
> > commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for
> > devicetree platforms"), which enabled ASPM also for
> > CONFIG_PCIEASPM_DEFAULT=y.
> 
> Should also be able to trigger this problem regardless of
> CONFIG_PCIEASPM_* by using /sys/bus/pci/devices/.../link/l1_2_aspm.
> 
> > Disable L1 substates until proper support is added.
> 
> I would word this more like "prevent advertising L1 Substates support"
> since we're not actually *disabling* anything here.

Sure.

> 
> If the RK3588 TRM is publicly available, a URL here would be helpful.

I couldn't find it on any official rockchip or radxa URL.


Will submit a v3 that fixes your comments.


Kind regards,
Niklas

