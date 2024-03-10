Return-Path: <linux-pci+bounces-4705-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C107987770E
	for <lists+linux-pci@lfdr.de>; Sun, 10 Mar 2024 14:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 579BA1F21349
	for <lists+linux-pci@lfdr.de>; Sun, 10 Mar 2024 13:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DC92C6B2;
	Sun, 10 Mar 2024 13:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqfW/h3S"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD25F18AE4;
	Sun, 10 Mar 2024 13:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710077369; cv=none; b=MfXbvzhPmi9Q9PSmzGjnLZE2x2FeyJmhooPeINanj/exVPlK2eRIrPwUZEs17tNcE5cKSDKyVWDBo5Cp1pKpHTYvp8hOkKMjbvCaKiC1XBdDIEdQsWnK+oPch+FL4TPITrOMGEAACWRcHrFQHKAQM1FeoFqxxTsqc40704C5Pxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710077369; c=relaxed/simple;
	bh=gfkP8LYRyawwp9+kWHGhd2GZEQ3SoFQ4y8eKVamILuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjtri1jG5NBc4nMXxw3LscoHxUKg+zjOnGwMHa206Snz6LQFxyORijoqa7Cl0/D8XuD8GzqASHIz0Hq3vOG7rRGUm2C3hgtrLjvCYDS09QbK9yVmqHGYtt1Vn+pzmZve6cm1e6SwMelbbcS28/4UMOETBuNTYIcdYZMGfBhdKaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqfW/h3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD694C433F1;
	Sun, 10 Mar 2024 13:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710077368;
	bh=gfkP8LYRyawwp9+kWHGhd2GZEQ3SoFQ4y8eKVamILuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RqfW/h3S87jj7+W0+B9RcHkHeLPMG/GXlWRzgASmC2b8EWoY7lueJu1mlC+YIbp3H
	 fdtydgo6WXrq37R2CEaQMUhqH/yH2E3zP8RbNWRVgYkybKx5d1ztSLMM6nr6pzYOPT
	 +eCV80EPFkgM35jQ+KctNZ6YUI6GBHW6Rva3JsOmSaQGx4obn2rtHl4c54iT/b78CA
	 n+UPO0swXukzZ2bmFJPHQqdDq8bfZyuD/f2v0dtDGFG7l7EKX9Uf+T3ito+2AADnKc
	 Fx4o6ls2xSbKE6YG3b779HPh+rgb4L9Jl61IIB4VeY9L/D/eLdqUh9y3mtvuAq9Q8a
	 Vz/xvIwAtBPRA==
Date: Sun, 10 Mar 2024 18:59:15 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Praveenkumar I <quic_ipkumar@quicinc.com>
Cc: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	vkoul@kernel.org, kishon@kernel.org, mani@kernel.org,
	quic_nsekar@quicinc.com, quic_srichara@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	quic_varada@quicinc.com, quic_devipriy@quicinc.com,
	quic_kathirav@quicinc.com, quic_anusha@quicinc.com
Subject: Re: [PATCH 00/10] Add PCIe support for Qualcomm IPQ5332
Message-ID: <20240310132915.GE3390@thinkpad>
References: <20231214062847.2215542-1-quic_ipkumar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231214062847.2215542-1-quic_ipkumar@quicinc.com>

On Thu, Dec 14, 2023 at 11:58:37AM +0530, Praveenkumar I wrote:
> Patch series adds support for enabling the PCIe controller and
> UNIPHY found on Qualcomm IPQ5332 platform. PCIe0 is Gen3 X1 and
> PCIe1 is Gen3 X2 are added.
> 
> UNIPHY changes depends on
> https://lore.kernel.org/all/20231003120846.28626-1-quic_nsekar@quicinc.com/
> PCIe driver change depends on
> https://lore.kernel.org/all/20230519090219.15925-1-quic_devipriy@quicinc.com/
> 

Any plan on this series and the dependencies?

- Mani

> Praveenkumar I (10):
>   dt-bindings: clock: Add separate clocks for PCIe and USB for Combo PHY
>   clk: qcom: ipq5332: Add separate clocks for PCIe and USB for Combo PHY
>   arm64: dts: qcom: ipq5332: Add separate entry for USB pipe clock
>   phy: qcom: Add support for Pipe clock rate from device data
>   dt-bindings: phy: qcom,uniphy-pcie: Add ipq5332 bindings
>   phy: qcom: ipq5332: Add support for g3x1 and g3x2 PCIe PHYs
>   dt-bindings: PCI: qcom: Add IPQ5332 SoC
>   pci: qcom: Add support for IPQ5332
>   arm64: dts: qcom: ipq5332: Add PCIe related nodes
>   arm64: dts: qcom: ipq5332: Enable PCIe phys and controllers
> 
>  .../bindings/clock/qcom,ipq5332-gcc.yaml      |   6 +-
>  .../devicetree/bindings/pci/qcom,pcie.yaml    |  36 ++++
>  .../bindings/phy/qcom,uniphy-pcie-28lp.yaml   |  65 +++++-
>  arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts   |  74 +++++++
>  arch/arm64/boot/dts/qcom/ipq5332.dtsi         | 188 +++++++++++++++++-
>  drivers/clk/qcom/gcc-ipq5332.c                |   7 +-
>  drivers/pci/controller/dwc/pcie-qcom.c        |   1 +
>  .../phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c  |  49 ++++-
>  8 files changed, 412 insertions(+), 14 deletions(-)
> 
> -- 
> 2.34.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

