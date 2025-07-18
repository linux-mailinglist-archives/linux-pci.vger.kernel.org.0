Return-Path: <linux-pci+bounces-32523-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 421B6B0A0CD
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 12:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C68231C42BED
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 10:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A80229DB7F;
	Fri, 18 Jul 2025 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPlrFQBt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3F9198A2F;
	Fri, 18 Jul 2025 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752835197; cv=none; b=gPmiGg6xZaWx2b9pJbsu6kHGD5FvsRs3ITF8b/QUVWpWhxUr0gddADlzy752LVySrV8lmiB/+CNMOX07re9hBfgbYAvf5bxJgG9TmUyzy4hScaiwkebRlEIGb01t5eA0zPWxipDfP5Ra/w4jU3d7rvhBTRoxHP32yG0x+b4qqlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752835197; c=relaxed/simple;
	bh=J3EdFx6SeghEC/3QrFs16mdw3ziovg04wubMBc5qbUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IO7uBRlIOX5+Sy7vZJ7ojmlePILZYHYxuhtFhWAk9SDmrUlcmhXSoXW+ejCzRglDIv/2UiNRTcQsOarzcD9h3gk4sj1k85jKod1yqM0VQ+xoYDT7uviEcF1tNC+WzzT0e1k4YIPnNYKqgub2iNI/AVNB9KENfZtoQuNwRgYYFY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPlrFQBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161EFC4CEF0;
	Fri, 18 Jul 2025 10:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752835197;
	bh=J3EdFx6SeghEC/3QrFs16mdw3ziovg04wubMBc5qbUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IPlrFQBtvUlZfA7a+pVin1pFTP7wye2etea45L0KxgzvuN5VA5/XYu1MyW3Xtw9BX
	 cXL2kXR7CiYeUQP0DsONWFLp7zbJ9zl7KUXlq5LI945F+NGunAFWedcpd57Nt4nS+B
	 DO/r/Cx19XXM7KfS03jieyFoNUBzNpU8bbxrw2L511QVxGAr98ZXWB2uYjftwZ5dnD
	 4YDpEFwUNh03TE5Ar8Vq6XqGAlWb5aflWRTH/TOH7rLvuWOPgTv+CLF6liQVsvP2ah
	 yveNKo3QRKnzR2f/ScmBsawG2qE80GXNLSf3orq5fHbG8Mrq+dAmRyfBuGAtgXeiOq
	 s1uZKCsgGIvXg==
Date: Fri, 18 Jul 2025 12:39:50 +0200
From: Niklas Cassel <cassel@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
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
Message-ID: <aHokdhpJUhSZ5FSp@ryzen>
References: <20250715-pci-port-reset-v6-0-6f9cce94e7bb@oss.qualcomm.com>
 <aHoh1XfhR8EB_5yY@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHoh1XfhR8EB_5yY@ryzen>

On Fri, Jul 18, 2025 at 12:28:44PM +0200, Niklas Cassel wrote:
> On Tue, Jul 15, 2025 at 07:51:03PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> 2) Testing link down reset:
> 
> selftests before link down reset:
> # FAILED: 14 / 16 tests passed.
> 
> ## On EP side:
> # echo 0 > /sys/kernel/config/pci_ep/controllers/a40000000.pcie-ep/start && \
>   sleep 0.1 && echo 1 > /sys/kernel/config/pci_ep/controllers/a40000000.pcie-ep/start
> 
> 
> [  111.137162] rockchip-dw-pcie a40000000.pcie: PCIE_CLIENT_INTR_STATUS_MISC: 0x4
> [  111.137881] rockchip-dw-pcie a40000000.pcie: LTSSM_STATUS: 0x0
> [  111.138432] rockchip-dw-pcie a40000000.pcie: hot reset or link-down reset
> [  111.139067] pcieport 0000:00:00.0: Recovering Root Port due to Link Down
> [  111.139686] pci-endpoint-test 0000:01:00.0: AER: can't recover (no error_detected callback)
> [  111.255407] rockchip-dw-pcie a40000000.pcie: PCIe Gen.3 x4 link up
> [  111.256019] rockchip-dw-pcie a40000000.pcie: Root Port reset completed
> [  111.383401] pcieport 0000:00:00.0: Root Port has been reset
> [  111.384060] pcieport 0000:00:00.0: AER: device recovery failed
> [  111.384582] rockchip-dw-pcie a40000000.pcie: PCIE_CLIENT_INTR_STATUS_MISC: 0x3
> [  111.385218] rockchip-dw-pcie a40000000.pcie: LTSSM_STATUS: 0x230011
> [  111.385771] rockchip-dw-pcie a40000000.pcie: Received Link up event. Starting enumeration!
> [  111.390866] pcieport 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> [  111.391650] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> 
> Basically all tests timeout
> # FAILED: 1 / 16 tests passed.
> 
> Which is the same as before this patch series.

The above was with CONFIG_PCIEAER=y

Wilfred suggested that I tried without this config set.

However, doing so, I got the exact same result:
# FAILED: 1 / 16 tests passed.


For the record, the test that passes is not actually passing either,
it is the BAR4 test, which is skipped, since BAR4 is reserved on rock5b:
ok 5 pci_ep_bar.BAR4.BAR_TEST # SKIP BAR is disabled


Kind regards,
Niklas

