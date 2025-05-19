Return-Path: <linux-pci+bounces-27953-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1449ABBB0D
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 12:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEBCA3A15F6
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 10:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750E62741CB;
	Mon, 19 May 2025 10:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrjkC4jL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E50192D97;
	Mon, 19 May 2025 10:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747650379; cv=none; b=VKpdPmp9/XlDk6UDwUSz5wakevjspK9Q+MyMBkZjRYq/TucpHFM6S/yTuvO7eTo7bueM0THmQ1tP5f2Pbm8Odd6eEFbMInXU+zHk7IxgTQNgSdx4aIhH9wg5e+BUlIfJ0HP+iuITZvFggJkDbJrsa7h6VQZl6wWtAq8I/nbTt7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747650379; c=relaxed/simple;
	bh=5XJLyhON1/d4lmJMf9H9JBAk4IO2dMXjKblgm7tDsTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhPIRaYQi1bXSWfTAZcViZvNCL48/PGnMlmK3BdRhs34PgYiG/SFnSAk9KPfy00RgArIfTE8GGVqs2t9iRFl2zg9MB65RCweJbLsWtzWiPFyn6SR+shSZ+Ngre9Uysbj0mtDFfHstU9CkUC3Am3URyZif1rUAXx26nNhDODYmmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrjkC4jL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFABC4CEE4;
	Mon, 19 May 2025 10:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747650378;
	bh=5XJLyhON1/d4lmJMf9H9JBAk4IO2dMXjKblgm7tDsTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KrjkC4jLTEY09WWU7DbzFbDKsTf2vfsoiurlW5GQpA8lW4wZieMbyz7hD7GG57Ouy
	 FT0QqD/khdk8QANA1o0+lVGWCtYc+rc8oyd+PXp97gH/TV/KekOaHbYHSB/Ql5+M/A
	 iHVLigXMebahcMwzzFjuZtCphn8LGYGRz/QyAy+lD1DdyvWviU0XDcq+EWIhRQ8Sx7
	 yv+lfSgA/4muDApTzX80TY5szCFmeRBiK2K/UauuCdkEWiL1epEkohwvtdKjTfifLq
	 owiMqiUdxVPmninjhfHEcl81mRnWRbfvVOYMprLW4RgAjvSEHOGNgTfW6Yx/K5yzxl
	 O+TI5tbEZOZTQ==
Date: Mon, 19 May 2025 12:26:12 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.or, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, manivannan.sadhasivam@linaro.org,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, alim.akhtar@samsung.com, vkoul@kernel.org,
	kishon@kernel.org, arnd@arndb.de, m.szyprowski@samsung.com,
	jh80.chung@samsung.com
Subject: Re: [PATCH 09/10] PCI: exynos: Add support for Tesla FSD SoC
Message-ID: <aCsHRJL3vP17FzZo@ryzen>
References: <20250518193152.63476-1-shradha.t@samsung.com>
 <CGME20250518193300epcas5p17e954bb18de9169d65e00501b1dcd046@epcas5p1.samsung.com>
 <20250518193152.63476-10-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250518193152.63476-10-shradha.t@samsung.com>

On Mon, May 19, 2025 at 01:01:51AM +0530, Shradha Todi wrote:
> Add host and endpoint controller driver support for FSD SoC.
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---

(snip)

> +static int fsd_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> +				 unsigned int type, u16 interrupt_num)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +
> +	switch (type) {
> +	case PCI_IRQ_INTX:
> +	case PCI_IRQ_MSIX:
> +		dev_err(pci->dev, "EP does not support legacy IRQs\n");

Here you will print the same message for both INTX and MSIX.
Perhaps MSIX should have a separate print?

In fact, perhaps you want to call dw_pcie_ep_raise_intx_irq()
for case PCI_IRQ_INTX, since that function already has an error print.


Kind regards,
Niklas

