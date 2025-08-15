Return-Path: <linux-pci+bounces-34101-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6735B27C6F
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 11:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DA4F1CC4DF6
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 09:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6F225F995;
	Fri, 15 Aug 2025 09:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCUydPaS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8C3248891;
	Fri, 15 Aug 2025 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248869; cv=none; b=pv2/f0r0YRRHFm8fDOzQSdQfQsvTbE/pye8LyqrnUQP/vjSWWFprMjiYpWdxLWM2agEOVD0GZgUunEDLumL6HQftbsciupY66UEwZa5cl0SkC02HPZ/SUXLEyvctke6Zd2a7ZjUwqOn2xJBVdZmD9yymbHy+0uAnsSpuYdyOZ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248869; c=relaxed/simple;
	bh=99xoqnVTE+5vEX0JBLvhsXhVQgcPMAYXND8yARERRQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YrIJw7Vu0mwSf28UfWshA3yWsh04TimZr/R2iEAylXguGetv2IIcFtl6mAbA+dzHccrqKt7dXjGvNHQvGeGOC7TZsRWKZjQt1fFNUHCaQSvrphIBUeLzBdNK0m8/T5UKjyDV3x4CEAUwNFSzRaMAXl/HeavzMXCc6d4gYccQFKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCUydPaS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9562CC4CEEB;
	Fri, 15 Aug 2025 09:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755248868;
	bh=99xoqnVTE+5vEX0JBLvhsXhVQgcPMAYXND8yARERRQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hCUydPaS4CL2g3ZuiCxjRYNo4suGGZo/3UjPaacLUxD1omL+fIDSwIfBfobZcheqU
	 haxhg6ctciTH1Qx4vtPKJjwB82S5dr3w7YX5qWiIR9VX34XCTCS1b8+M5+QI2HPDN5
	 L+iY/Aawf8965lNHCXfNz2yDNl+7FHBsotvI0rPRLoadnxBXrvTk7DqIp5G1fLKnIR
	 0G3n6W3pdQluol7T0GEzkTe1hfW0I+6IuGbp7k0Z22VrEqWHWMJd7DsO89pq8nPE5r
	 gkxqgdBf+LAe2FlFTv/PtTsFCQIzWfbh/ZycAHI3v2v1Q3QORKE4OexEf8teUi28sf
	 sU8Q5bHzk1/nA==
Date: Fri, 15 Aug 2025 11:07:42 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v6 0/4] PCI: Add support for resetting the Root Ports in
 a platform specific way
Message-ID: <aJ743hJw-T9y3waX@ryzen>
References: <20250715-pci-port-reset-v6-0-6f9cce94e7bb@oss.qualcomm.com>
 <aHoh1XfhR8EB_5yY@ryzen>
 <aHokdhpJUhSZ5FSp@ryzen>
 <tujurux64if24z7w7h6wjxhrnh4owkgiv33u2fftp7zr5ucv2m@2ijo5ok5jhfk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tujurux64if24z7w7h6wjxhrnh4owkgiv33u2fftp7zr5ucv2m@2ijo5ok5jhfk>

Hello Mani,

Sorry for the delayed reply.
I just came back from vacation.

On Thu, Jul 24, 2025 at 11:00:05AM +0530, Manivannan Sadhasivam wrote:
> On Fri, Jul 18, 2025 at 12:39:50PM GMT, Niklas Cassel wrote:
> > On Fri, Jul 18, 2025 at 12:28:44PM +0200, Niklas Cassel wrote:
> > > On Tue, Jul 15, 2025 at 07:51:03PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > 2) Testing link down reset:
> > > 
> > > selftests before link down reset:
> > > # FAILED: 14 / 16 tests passed.
> > > 
> > > ## On EP side:
> > > # echo 0 > /sys/kernel/config/pci_ep/controllers/a40000000.pcie-ep/start && \
> > >   sleep 0.1 && echo 1 > /sys/kernel/config/pci_ep/controllers/a40000000.pcie-ep/start
> > > 
> > > 
> > > [  111.137162] rockchip-dw-pcie a40000000.pcie: PCIE_CLIENT_INTR_STATUS_MISC: 0x4
> > > [  111.137881] rockchip-dw-pcie a40000000.pcie: LTSSM_STATUS: 0x0
> > > [  111.138432] rockchip-dw-pcie a40000000.pcie: hot reset or link-down reset
> > > [  111.139067] pcieport 0000:00:00.0: Recovering Root Port due to Link Down
> > > [  111.139686] pci-endpoint-test 0000:01:00.0: AER: can't recover (no error_detected callback)
> > > [  111.255407] rockchip-dw-pcie a40000000.pcie: PCIe Gen.3 x4 link up
> > > [  111.256019] rockchip-dw-pcie a40000000.pcie: Root Port reset completed
> > > [  111.383401] pcieport 0000:00:00.0: Root Port has been reset
> > > [  111.384060] pcieport 0000:00:00.0: AER: device recovery failed
> > > [  111.384582] rockchip-dw-pcie a40000000.pcie: PCIE_CLIENT_INTR_STATUS_MISC: 0x3
> > > [  111.385218] rockchip-dw-pcie a40000000.pcie: LTSSM_STATUS: 0x230011
> > > [  111.385771] rockchip-dw-pcie a40000000.pcie: Received Link up event. Starting enumeration!
> > > [  111.390866] pcieport 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> > > [  111.391650] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> > > 
> > > Basically all tests timeout
> > > # FAILED: 1 / 16 tests passed.
> > > 
> > > Which is the same as before this patch series.
> > 
> > The above was with CONFIG_PCIEAER=y
> > 
> 
> This is kind of expected since the pci_endpoint_test driver doesn't have the AER
> err_handlers defined.

I see.
Would be nice if we could add them then, so that we can verify that this
series is working as intended.


> 
> > Wilfred suggested that I tried without this config set.
> > 
> > However, doing so, I got the exact same result:
> > # FAILED: 1 / 16 tests passed.
> > 
> 
> Interesting. Could you please share the dmesg log like above.

It is looking exactly like the dmesg above

[   86.820059] rockchip-dw-pcie a40000000.pcie: PCIE_CLIENT_INTR_STATUS_MISC: 0x4
[   86.820791] rockchip-dw-pcie a40000000.pcie: LTSSM_STATUS: 0x0
[   86.821344] rockchip-dw-pcie a40000000.pcie: hot reset or link-down reset
[   86.821978] pcieport 0000:00:00.0: Recovering Root Port due to Link Down
[   87.040551] rockchip-dw-pcie a40000000.pcie: PCIe Gen.3 x4 link up
[   87.041138] rockchip-dw-pcie a40000000.pcie: Root Port reset completed
[   87.168378] pcieport 0000:00:00.0: Root Port has been reset
[   87.168882] rockchip-dw-pcie a40000000.pcie: PCIE_CLIENT_INTR_STATUS_MISC: 0x3
[   87.169519] rockchip-dw-pcie a40000000.pcie: LTSSM_STATUS: 0x230011
[   87.272463] rockchip-dw-pcie a40000000.pcie: Received Link up event. Starting enumeration!
[   87.277552] pcieport 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   87.278314] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01

except that we don't get the:
> [  111.139686] pci-endpoint-test 0000:01:00.0: AER: can't recover (no error_detected callback)
> [  111.384060] pcieport 0000:00:00.0: AER: device recovery failed

prints.


Kind regards,
Niklas

