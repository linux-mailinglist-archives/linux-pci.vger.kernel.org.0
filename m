Return-Path: <linux-pci+bounces-40203-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BB109C30FC6
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 13:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 66B2734D39F
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 12:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97291CD15;
	Tue,  4 Nov 2025 12:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNaXCyHm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15217E0E4;
	Tue,  4 Nov 2025 12:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762259435; cv=none; b=ZLyq68oRivF4n+2fqpTu9ZrdKUuVfPR201u/qXW7TpTfBth24MS5ggzMLpdwY7gyWmIpHQCOrl+RZRXqiMYrXpFUAf0QUnjAAbFEsS+RiW1MHVRBiEexQTWyWudz/LQvazzKD8IQeBYBomFp9Wfxly1C621e3lRWLMYV52bO4Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762259435; c=relaxed/simple;
	bh=FSpG5YsbzDPakXOv7zcHt6Bb8WRjzWGwnycLNiPNIws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eg8dzZxVimsvSi7ZYUmAHgS/CBv6GnvgibMqpgAdLV5YNIJ7PaG+QQQ9sJUrpXmV8MupxQm73r4CNE00v6FnwQbRLRYWrDKkHYJ3ehFGDlFIFaMChGI5+vBVZVeDbCMDDHS4nr0APRbVKC8T91GFTr6W9CpN9fwZvJGHIJ/BmB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNaXCyHm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB33C4CEF7;
	Tue,  4 Nov 2025 12:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762259435;
	bh=FSpG5YsbzDPakXOv7zcHt6Bb8WRjzWGwnycLNiPNIws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fNaXCyHmH2JWtxXKdCRrOaKgCy6dFh9Tf8n9Pz4ygElOxC42vTsmmQLq2WOYqVDf3
	 I09YelFRLWNEihcMjgnwpphg6vjCR+vhwxYZJYU7IVSeB/sDkponxhJL9t7acnsGEJ
	 UZm3rusrz7hj9+nE3dORF531A4gqGnZkyV6HrXn10qC1Gq1BEn4ZYaTUFgmkJRgLPc
	 ROKurA28vLp4yqqifk/345Pbj2NKVLi5B+xNAQNkzuoXFKVuoskw90P31nO7p9N+s7
	 sku/hjVKyVt35LVarrN9ElmDsLdwcHd0/MOLiefy2+rgXkjtfc5f0n+n1LVbdlsX06
	 T2y7oUZS6kSGQ==
Date: Tue, 4 Nov 2025 13:30:28 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Message-ID: <aQnx5KZSQuBniEv-@ryzen>
References: <20251017164558.GA1034609@bhelgaas>
 <54FD6159-AE45-432B-8F0E-4654721D16A6@kernel.org>
 <aaug44bngs5amid7un4plotcjpbc6ym44cztnhet7z44ybywgc@apzhg6enhxgy>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaug44bngs5amid7un4plotcjpbc6ym44cztnhet7z44ybywgc@apzhg6enhxgy>

Hello Mani,

On Tue, Oct 21, 2025 at 08:02:01AM +0530, Manivannan Sadhasivam wrote:
> On Sat, Oct 18, 2025 at 07:07:35AM +0200, Niklas Cassel wrote:
> > On 17 October 2025 18:45:58 CEST, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > 
> > (snip)
> > 
> > >> 
> > >> Thus, prevent advertising L1 Substates support until proper driver support
> > >> is added.
> > >
> > >I think Mani is planning a change so we don't try to enable L1
> > >Substates by default, which should avoid the regression even without a
> > >patch like this.
> > 
> > Sounds good, I suggested the same:
> > https://lore.kernel.org/linux-pci/aO9tWjgHnkATroNa@ryzen/
> > 
> > 
> > >
> > >That will still leave the existing CONFIG_PCIEASPM_POWER_SUPERSAVE=y
> > >and sysfs l1_1_aspm problems.
> > 
> > Indeed, which is why I think that this patch is v6.18 material.
> > 
> 
> Not strictly a 6.18 material as the Kconfig/sysfs/cmdline issues existed even
> before we enabled the ASPM states by default in v6.18-rc1.

I don't agree that "strictly 6.18 material" means "only fixes for bugs
introduced in the 6.18 merge window".

Normally, for a strict bug fix, the fix is merged during the current
kernel release cycle (rather than waiting for the next merge window),
even if the bug was introduced in an earlier kernel version.

E.g. a fix for a bug introduced during the 6.17 release cycle is
definitely 6.18 material, IMO.

Sure, if the bug is extremely old, that probably means that it is okay
to wait until the next merge window.

In this case, the Fixes tag is a commit first introduced in kernel v5.15,
released Sun Oct 31 13:53:10 2021.

Having that said, I'm perfectly fine with delaying.


Kind regards,
Niklas

