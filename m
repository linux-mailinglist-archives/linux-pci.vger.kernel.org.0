Return-Path: <linux-pci+bounces-40907-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67283C4E092
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 14:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A93613A5F41
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 13:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772DE3AA186;
	Tue, 11 Nov 2025 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdguOn6Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F076324712;
	Tue, 11 Nov 2025 13:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762866522; cv=none; b=SBMAlgv18zf6jX7ux6ExVbHM/+cB/3DJe05kl7BxAmOIKP393CQnEhH9oXaQD2JN/g3x/T6oINak277ql1O9oR+lsTJ3ieH+Vjo9E1KNGVPFoFcWHpW9asxr1+1nLFnmQIvzVP0rP191qm4/0HkVTExaJbu6msCtLmlh5kAID8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762866522; c=relaxed/simple;
	bh=Tp3gcQQfBfQNBKzN1UdG/86ORq+6tXRnDDKFCyIy/yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=teV/O3SQPY2q+ovxgBBW/ytMHn/tgy//sPBK98OQYOtwqwo0REP07r9QbVNl/nqXdCBkLachmV4mDeO6KF7yQgnomgT+5RBz+08dZm7gJl6viNzlZS5bhahSoR+nukoliGKvxv3P1rq304A7PPgZHpcwrwZuOH/AcYSSpmr4Cqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdguOn6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472EEC4CEF5;
	Tue, 11 Nov 2025 13:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762866521;
	bh=Tp3gcQQfBfQNBKzN1UdG/86ORq+6tXRnDDKFCyIy/yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PdguOn6Y7p97pcSKlNYot9c318d1xeoVX3dwqWe1LwmAhshP0bklXid1uKvEInbx8
	 1YkndRyAxdqAN4NWHZ48ym2kJRChMwL9Y+AFSHEuJBuzcE9vRxDG+VRn4iOBxtsKdh
	 oks49Sr2HlbGukTFbLZlS79tfCraRAcPKYr2dsmZcQ67QfC4nXnEOrm5x8y3pyE1Ia
	 ynPY25osmuzJ/6INIRdQPU5Tnaq3ZpzrxxG2FkjclBgOrIkkPsyO8bMWHRlkEVtM1H
	 M0tpid4lJqOvYmCbAZ1zIUaPsfR9Jd9hLA1xTvu+Ubjkf8Vww3xBVdKv7y1xWMVGCb
	 l16WnzpsTgGzQ==
Date: Tue, 11 Nov 2025 14:08:36 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
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
Subject: Re: [PATCH v3] PCI: dw-rockchip: Prevent advertising L1 Substates
 support
Message-ID: <aRM1VOodnSpaob3P@ryzen>
References: <20251017163252.598812-2-cassel@kernel.org>
 <176101411705.9573.17573145190800888773.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176101411705.9573.17573145190800888773.b4-ty@kernel.org>

Hello Mani,

On Tue, Oct 21, 2025 at 08:05:17AM +0530, Manivannan Sadhasivam wrote:
> 
> On Fri, 17 Oct 2025 18:32:53 +0200, Niklas Cassel wrote:
> > The L1 substates support requires additional steps to work, namely:
> > -Proper handling of the CLKREQ# sideband signal. (It is mostly handled by
> >  hardware, but software still needs to set the clkreq fields in the
> >  PCIE_CLIENT_POWER_CON register to match the hardware implementation.)
> > -Program the frequency of the aux clock into the
> >  DSP_PCIE_PL_AUX_CLK_FREQ_OFF register. (During L1 substates the core_clk
> >  is turned off and the aux_clk is used instead.)
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] PCI: dw-rockchip: Prevent advertising L1 Substates support
>       commit: 40331c63e7901a2cc75ce6b5d24d50601efb833d

Last update in this thread was "Applied, thanks!"

and the patch was applied to pci/controller/dw-rockchip

since then it seems to have been demoted to pci/controller/dw-rockchip-pend

I'm simply curious, what is the plan for this patch?

I know that Shawn was working on a series that adds support for L1ss for
this driver, but it seems to have stagnated, so it seems far from certain
that it will be ready in time to make it for the v6.19 merge window.

Right now, pci/next branch seems to merge pci/controller/dw-rockchip rather
than pci/controller/dw-rockchip-pend.

If the L1ss does not make it in time, then this patch will not have had any
time in linux-next, which might not make Linus happy.


Kind regards,
Niklas

