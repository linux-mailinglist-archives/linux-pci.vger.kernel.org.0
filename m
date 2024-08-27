Return-Path: <linux-pci+bounces-12270-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AB2960903
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 13:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FFDA1C22D9B
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 11:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2591A3BAF;
	Tue, 27 Aug 2024 11:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEa86cr4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DB71A38FB;
	Tue, 27 Aug 2024 11:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724758702; cv=none; b=tBW0b1Aw4lJnYQg0lp1oGsiBnVn59YGF8DRU/J7l/ZWqwBsEjELB+jaiPFgTcr7wuYp07nhF4xB0Fp+Y0o50Xv2BayNEtqpldeZi7RS4wsRvt8f24GQdi9wkR9iV22R9M0ZtU18IqGvVSGUfbN0t9wNZNeGhigvwJd/o4IAv6ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724758702; c=relaxed/simple;
	bh=JnETTFa10NtVd06M4aAL6DnRaetukRJe67YPV6Lua3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMafvvXglfHY1A0V67aepadBJc0dykVcwU2fGXOY9L+/1ZWb8A6qEBZWqGVDtweC3DPeNRJJ2/t0pena4+s0+TWb4v6QVw6iI8RPnkCAI+yFtqIKUC1W8lewkzro7n03uwK1ZBwCZxVkIYCQbO+/P4xymnfYiZcU3m9xUW7M/1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEa86cr4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFEB9C90396;
	Tue, 27 Aug 2024 11:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724758701;
	bh=JnETTFa10NtVd06M4aAL6DnRaetukRJe67YPV6Lua3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pEa86cr4QB5nCj8VLlIdR4fz9rilBPyOxsg5B62kdePkZZbZhXd79wCYz5AZ08cS5
	 i+KzCrXePmMfZMDoDd/mw4kOm7dgiiPXu9WrmoYJqdEmknmVPRGvk/JdVssoVrfAfF
	 MkITjXikRoBmX57A6HT2QD9vAubBEG3mVON0E+qCYwpjl06Kx3l3IG94DZfIHMDn4K
	 0LGrjvcvHxq0x3Lx4U2wa18tRmKjtxxvFxdX2eleGYH8ZH2MJFoR/POqOYwTgJdvMi
	 jsmKe5vX87TxLaA3h9D2OTl68wxhMa8u1biOY4/8X30aLEDbiv9sN8Rku/F3yvCkN9
	 D/xvhQ5hkLURQ==
Date: Tue, 27 Aug 2024 13:38:17 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, kishon@kernel.org, 
	robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, abel.vesa@linaro.org, 
	quic_msarkar@quicinc.com, quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org, 
	kw@linux.com, lpieralisi@kernel.org, neil.armstrong@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 3/8] phy: qcom: qmp: Add phy register and clk setting for
 x1e80100 PCIe3
Message-ID: <3rwkr4tqyki7umt75bgy6wcs2whchw2vb5ckrkqffaizxm3ssp@glkarq76vl4f>
References: <20240827063631.3932971-1-quic_qianyu@quicinc.com>
 <20240827063631.3932971-4-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240827063631.3932971-4-quic_qianyu@quicinc.com>

On Mon, Aug 26, 2024 at 11:36:26PM -0700, Qiang Yu wrote:
>  	if (cfg->tbls.ln_shrd)
>  		qmp->ln_shrd = base + offs->ln_shrd;
>  
> @@ -4424,6 +4641,9 @@ static const struct of_device_id qmp_pcie_of_match_table[] = {
>  	}, {
>  		.compatible = "qcom,x1e80100-qmp-gen4x2-pcie-phy",
>  		.data = &x1e80100_qmp_gen4x2_pciephy_cfg,
> +	}, {
> +		.compatible = "qcom,x1e80100-qmp-gen4x8-pcie-phy",

Undocumented compatible or your patch order is wrong.

> +		.data = &x1e80100_qmp_gen4x8_pciephy_cfg,
>  	},

Best regards,
Krzysztof


