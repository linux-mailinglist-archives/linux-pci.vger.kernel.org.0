Return-Path: <linux-pci+bounces-41986-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BE3C82813
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 22:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CEE70342F19
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 21:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1945C2F363B;
	Mon, 24 Nov 2025 21:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNAG9tPd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E423323F431;
	Mon, 24 Nov 2025 21:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764019145; cv=none; b=jQ8AnonSLvoMVJ8J8w/ebQYEqQijjU6+n9Mp8LF0ZuA0nnHjLDaZt0HwKzWOjdFCjRH8NoEGHvQZDwedF4tgt3AybvW/Uj7Edso1YqfiP1j9TSAPIxbcvvn2p3dfV93CKs9rzB5PYDPvytX88V0SCMrG9MlbmgzPPt1l8xfq090=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764019145; c=relaxed/simple;
	bh=DiDxFX94NXXIUzvxcS2+Fvuf/2KCTsklF/QbVLxONjU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lTDRHIGIRwszk4ZaeKCzsg29wfoGyrXK2SolszGMqCy/JbpLp05LOiGFOnjkm7plTZJaPo98ohoET27gLHID95mNfqyJV9psyZF2cKn7HiyuPhpk2ms30Yi4Bz7/yg/1PDQynGsFIz9pT7/wx74GdrtxUs/7D0TNj6DGMIvzOdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNAG9tPd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA9AC4CEFB;
	Mon, 24 Nov 2025 21:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764019144;
	bh=DiDxFX94NXXIUzvxcS2+Fvuf/2KCTsklF/QbVLxONjU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DNAG9tPd/4nqTFtv4FYVdApqANdOMIrVWr3lJDe2sCqX42/Zeq4glUcUMsPhjiD+Q
	 t2m7XFOTFBJhBOnUXsp47g2HExxgWWc/M14S26V+yUlO67lCX508xmAuCm2EQWMZw2
	 A9g6zO4z1WS9mllO+NiBHFuu7ogogLgoi+xlWZDuE4PeOTvPRBLrlW+QIX+D4AnHiu
	 ExwSSAnfYbD2Et6LgjBwH1OESwSoyPlL+5t+B8e6G+n+xmDrNVq0ILqfngMEvVR86r
	 a9TEkRX0ihIQi0Sja/eRtaJCbzbtDFER07VnFSBlrlpyMt1OtS6hK1uMjACv6wF2FN
	 5QMXNSJwunAtg==
Date: Mon, 24 Nov 2025 15:19:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	Kever Yang <kever.yang@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, Damien Le Moal <dlemoal@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>, FUKAUMI Naoki <naoki@radxa.com>,
	Diederik de Haas <diederik@cknow-tech.com>,
	Richard Zhu <hongxing.zhu@nxp.com>, Frank Li <Frank.li@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Conor Dooley <conor@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Hans Zhang <hans.zhang@cixtech.com>, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@pengutronix.de,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/4] PCI: dwc: Advertise L1 PM Substates only if
 driver requests it
Message-ID: <20251124211903.GA2712341@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wja7vxtg7bqq2udepl5r3mvgg5swvuqtuzk6cnimgcbw2aegqs@hru6yzg4xx3o>

On Thu, Nov 20, 2025 at 01:10:56PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Nov 18, 2025 at 03:42:15PM -0600, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > L1 PM Substates require the CLKREQ# signal and may also require
> > device-specific support.  If CLKREQ# is not supported or driver support is
> > lacking, enabling L1.1 or L1.2 may cause errors when accessing devices,
> > e.g.,
> > 
> >   nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0x10
> > 
> > If the kernel is built with CONFIG_PCIEASPM_POWER_SUPERSAVE=y or users
> > enable L1.x via sysfs, users may trip over these errors even if L1
> > Substates haven't been enabled by firmware or the driver.
> > 
> > To prevent such errors, disable advertising the L1 PM Substates unless the
> > driver sets "dw_pcie.l1ss_support" to indicate that it knows CLKREQ# is
> > present and any device-specific configuration has been done.
> 
> Going by this reasoning, why can't we enable L1 PM Substates for
> these platforms by default?

I think we can, in a separate series.  I don't have time to deal with
this before the v6.19 merge window, but you can certainly do that.

Bjorn

