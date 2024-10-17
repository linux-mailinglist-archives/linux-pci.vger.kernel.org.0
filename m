Return-Path: <linux-pci+bounces-14801-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE409A26D7
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 17:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 708541C22D54
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 15:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021761DED62;
	Thu, 17 Oct 2024 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7ytg1AJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BC41DED5D;
	Thu, 17 Oct 2024 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179338; cv=none; b=lzSI9hYDEcaIzomfI3A2jXo96uUknLbVEqkxL9V5RuPqO2DS9MRESzPSDwy9u514KJQy/YmyWw6D1P7C5ch5ass193AzDmC4Hwl6HpVUvDeFNdnY6HViet5Yg0rM3aSZG0rfQghXVF2nBUK5MSGmmK2LwDbNmSYfNR5Sw7s+abI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179338; c=relaxed/simple;
	bh=GxocGuKcbIGEx2OEDqTOLN6rngMeEtVz4a6NJzfq1zw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iTF6YZqqixbr93gbNvXwndI2r8e7o7HnIE3oO1TAO353z7eTezhs/T0O1y7KZV01TGfj5yVfd7EYaUNmYh0ZXqFT+jZSH8VDPZCmKVvWax4TUfDujNyNUo48ctpCYLF/c38d4xKofdpj6QgKHNMstaGYSyAq5H3Lg2dcmvx5rF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7ytg1AJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01E2C4CEC3;
	Thu, 17 Oct 2024 15:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729179338;
	bh=GxocGuKcbIGEx2OEDqTOLN6rngMeEtVz4a6NJzfq1zw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=R7ytg1AJbSnPVZF2ZcZEVXHNMWMEfKwvN8d6+gfd7wR7ziY2c2yGF/LxUb4L4JmQa
	 5904WhymBCu6C23yZzVOoCv3o3SE1w0ElTkQ1Lz9UASoAICWcIQhM/kk4LLEFHAFPG
	 vLTAFOo5KZf0X2keITbpuvxthhF8E3xFsH7sOulhLimsnLd8B00jFLw38zd3m/AxPq
	 4uJcsx08NQXUYmgp1gcFmlw/u2A7+XVo5HPomNNrfwlfT4bYWWhDpNcZG90HS2fD61
	 9QvozZ1Kil1SikiJCcJxDq6DcJNccP68+Wim02jJ9U5at1e+3vt9o0ws8dCBk5A5Cb
	 JH501nUIk6flA==
From: Vinod Koul <vkoul@kernel.org>
To: manivannan.sadhasivam@linaro.org, kishon@kernel.org, robh@kernel.org, 
 andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
 abel.vesa@linaro.org, quic_msarkar@quicinc.com, quic_devipriy@quicinc.com, 
 Qiang Yu <quic_qianyu@quicinc.com>
Cc: dmitry.baryshkov@linaro.org, kw@linux.com, lpieralisi@kernel.org, 
 neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-clk@vger.kernel.org, johan+linaro@kernel.org
In-Reply-To: <20241017030412.265000-1-quic_qianyu@quicinc.com>
References: <20241017030412.265000-1-quic_qianyu@quicinc.com>
Subject: Re: (subset) [PATCH v7 0/7] Add support for PCIe3 on x1e80100
Message-Id: <172917933229.288841.5057372838921207960.b4-ty@kernel.org>
Date: Thu, 17 Oct 2024 21:05:32 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 16 Oct 2024 20:04:05 -0700, Qiang Yu wrote:
> This series add support for PCIe3 on x1e80100.
> 
> PCIe3 needs additional set of clocks, regulators and new set of PCIe QMP
> PHY configuration compare other PCIe instances on x1e80100. Hence add
> required resource configuration and usage for PCIe3.
> 
> v6->v7:
> 1. Add Acked-by and Reviewed-by tags
> 2. Use 70574511f3f ("PCI: qcom: Add support for SC8280XP") in Fixes tag
> 3. Keep minItem of interrupt as 8 in buindings
> 4. Reword commit msg
> 5. Remove [PATCH v6 5/8] clk: qcom: gcc-x1e80100: Fix halt_check for
>    pipediv2 clocks as it was applied
> 6. Link to v6: https://lore.kernel.org/linux-pci/20241011104142.1181773-1-quic_qianyu@quicinc.com/
> 
> [...]

Applied, thanks!

[1/7] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the X1E80100 QMP PCIe PHY Gen4 x8
      commit: 26fb23ce35e2d2233f810069ab11210851acbf54
[4/7] phy: qcom: qmp: Add phy register and clk setting for x1e80100 PCIe3
      commit: e961ec81a39bc57119f165cf2e994fc29637fd97

Best regards,
-- 
~Vinod



