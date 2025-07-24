Return-Path: <linux-pci+bounces-32866-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A30B0FFF3
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 07:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB3D617A511
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 05:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965DE1C5496;
	Thu, 24 Jul 2025 05:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNedDR55"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EE0C2E0;
	Thu, 24 Jul 2025 05:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753335016; cv=none; b=rUlOWB8x3td+cSUMnBf97TvKUau56xNaSUsXYJf3AfimQJ8kyosRMvpk1kh1nNHXIC/m/vbu/qIBYov6NpEalm6vh75glRekjsULjKl4TUE0r02cqvUXknpRJkkDRr4dWgCG9OahmWGvqd802xSPsAfBxAEKbWe7ReHl4oJw32E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753335016; c=relaxed/simple;
	bh=ISXdQZ3kB+W0hUweuwCNwLolV+g7Yo//dJ0hlqxAC0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnACjC1FCjsRUYTcA8TcYcxg/nBjeEjqrUbebY6S1idCByCuGwJwwsXOH5YnfMwr6pUIowyQkGhQI/tpae2jDAALqK5KQRVNGuzCl7zKtNHC8n4cNb6lM654NYCDLgitkRjsPjEPIsfy1bJqqoZTDe9n9hmatyYkU5BddFGL3KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNedDR55; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3469FC4CEED;
	Thu, 24 Jul 2025 05:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753335016;
	bh=ISXdQZ3kB+W0hUweuwCNwLolV+g7Yo//dJ0hlqxAC0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sNedDR55x4+Sp5CqV3RRfyuKADcZPDY7YyZPtWIuQOH60C+zNPuSm9viRmif/bLfo
	 NsFm4J4q+ZZcM9ZED/jxSstX2X4Pgyv1k17y8+SM0XQuoBQr6vY3rqk4lEM3fxAa1u
	 ABhBaDpL96ZIPtJTWvkU9dp2YpVIQMGOwH9XuG46TgW7pZtZ4v+HULgkZqpEWmo8kQ
	 Qfev9GG7It4NBGZznP7FJzLkwtD7zgyTAqAcbUtx3SabjvqTYj0qaMOgTij7WJYbYd
	 Vt8/nLOyO6jeeDlbxuedgbMbzDO4Xj9XmOG2BbyxhnqoKrchC9IKqliIAiQd/MY5Xo
	 ct2H4wCgyMG6w==
Date: Thu, 24 Jul 2025 11:00:05 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bjorn Helgaas <bhelgaas@google.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v6 0/4] PCI: Add support for resetting the Root Ports in
 a platform specific way
Message-ID: <tujurux64if24z7w7h6wjxhrnh4owkgiv33u2fftp7zr5ucv2m@2ijo5ok5jhfk>
References: <20250715-pci-port-reset-v6-0-6f9cce94e7bb@oss.qualcomm.com>
 <aHoh1XfhR8EB_5yY@ryzen>
 <aHokdhpJUhSZ5FSp@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aHokdhpJUhSZ5FSp@ryzen>

On Fri, Jul 18, 2025 at 12:39:50PM GMT, Niklas Cassel wrote:
> On Fri, Jul 18, 2025 at 12:28:44PM +0200, Niklas Cassel wrote:
> > On Tue, Jul 15, 2025 at 07:51:03PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > 2) Testing link down reset:
> > 
> > selftests before link down reset:
> > # FAILED: 14 / 16 tests passed.
> > 
> > ## On EP side:
> > # echo 0 > /sys/kernel/config/pci_ep/controllers/a40000000.pcie-ep/start && \
> >   sleep 0.1 && echo 1 > /sys/kernel/config/pci_ep/controllers/a40000000.pcie-ep/start
> > 
> > 
> > [  111.137162] rockchip-dw-pcie a40000000.pcie: PCIE_CLIENT_INTR_STATUS_MISC: 0x4
> > [  111.137881] rockchip-dw-pcie a40000000.pcie: LTSSM_STATUS: 0x0
> > [  111.138432] rockchip-dw-pcie a40000000.pcie: hot reset or link-down reset
> > [  111.139067] pcieport 0000:00:00.0: Recovering Root Port due to Link Down
> > [  111.139686] pci-endpoint-test 0000:01:00.0: AER: can't recover (no error_detected callback)
> > [  111.255407] rockchip-dw-pcie a40000000.pcie: PCIe Gen.3 x4 link up
> > [  111.256019] rockchip-dw-pcie a40000000.pcie: Root Port reset completed
> > [  111.383401] pcieport 0000:00:00.0: Root Port has been reset
> > [  111.384060] pcieport 0000:00:00.0: AER: device recovery failed
> > [  111.384582] rockchip-dw-pcie a40000000.pcie: PCIE_CLIENT_INTR_STATUS_MISC: 0x3
> > [  111.385218] rockchip-dw-pcie a40000000.pcie: LTSSM_STATUS: 0x230011
> > [  111.385771] rockchip-dw-pcie a40000000.pcie: Received Link up event. Starting enumeration!
> > [  111.390866] pcieport 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> > [  111.391650] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> > 
> > Basically all tests timeout
> > # FAILED: 1 / 16 tests passed.
> > 
> > Which is the same as before this patch series.
> 
> The above was with CONFIG_PCIEAER=y
> 

This is kind of expected since the pci_endpoint_test driver doesn't have the AER
err_handlers defined.

> Wilfred suggested that I tried without this config set.
> 
> However, doing so, I got the exact same result:
> # FAILED: 1 / 16 tests passed.
> 

Interesting. Could you please share the dmesg log like above.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

