Return-Path: <linux-pci+bounces-23422-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 536B2A5BF9B
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 12:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D560189A3C0
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 11:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1C52405F9;
	Tue, 11 Mar 2025 11:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onwm2Mwl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F39C1D514E;
	Tue, 11 Mar 2025 11:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741693620; cv=none; b=WlNsfPl6ECm9f4rKBZeYQzzglu9tm3+jwoqIvQ4CyB+pLnPjUJImYDdVnQI15zELqWsHmZ9jHQTctVb1cSWgZ42cN4cvJvDtz+ZleUy50AhiCVRa/8ynnTik6DGjphaM9PPapjycKr4x5+uR+jtk8qEMkQ97ETZiT9ABOXeupAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741693620; c=relaxed/simple;
	bh=/WYDs73Nm1lb/GTeRLCUHgCKaixHsBgVcb+f13tuZ6g=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t4Hb/h+ZToSgwtp6+L07PCG8+yDr3kK/BDtQpV4z67JrOFXBs27IZ8Grrthr6UcIcGbmSCwVapdlCigA8c75lllfHxxLzEHoh9wFVq5gDNXhj7kAmqC3N8Xmu6w6j2X+xvxFprrm//uNxJDWSsiaDxL/emIDcpZdnxBAbt5dZVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onwm2Mwl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C368CC4CEE9;
	Tue, 11 Mar 2025 11:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741693619;
	bh=/WYDs73Nm1lb/GTeRLCUHgCKaixHsBgVcb+f13tuZ6g=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=onwm2MwlnqeJgtZJd3NdhDoXu8Lz8tXY5d6n9aeq3UyWSGx3qH/u6OfBkrUcdXTgK
	 38j94IriQR1emZT5Ouc2dFRGIgFhAFJIYTNxvcF1xeRCIUqpnFMVmcEnqG/vs5zigG
	 ++2QAq1jOSfaOf/fYDxhQAkKPxm1AxmhROmYrdimYjj1tzM86YO81eayu3XkYqY7rc
	 pwtF2LcNAixeNvQ95Aky13e65ZL5ggMatdvS1vxpwUOlpEo1XIth6yAm1Q88Oj3Qug
	 paJugIGzVftncZc0rxild65Sdkwt8b+MSDkBjHLKvo+A3Qi4xVaB6wX5p1drvCYCjg
	 MAmQrBm3kjRWw==
From: Vinod Koul <vkoul@kernel.org>
To: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
 manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, kishon@kernel.org, andersson@kernel.org, 
 konradybcio@kernel.org, p.zabel@pengutronix.de, quic_nsekar@quicinc.com, 
 dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 Varadarajan Narayanan <quic_varada@quicinc.com>
In-Reply-To: <20250220094251.230936-1-quic_varada@quicinc.com>
References: <20250220094251.230936-1-quic_varada@quicinc.com>
Subject: Re: (subset) [PATCH v11 0/7] Add PCIe support for Qualcomm IPQ5332
Message-Id: <174169361442.507381.5728010780608923977.b4-ty@kernel.org>
Date: Tue, 11 Mar 2025 12:46:54 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 20 Feb 2025 15:12:44 +0530, Varadarajan Narayanan wrote:
> Patch series adds support for enabling the PCIe controller and
> UNIPHY found on Qualcomm IPQ5332 platform. PCIe0 is Gen3 X1 and
> PCIe1 is Gen3 X2 are added.
> 
> This series combines [1] and [2]. [1] introduces IPQ5018 PCIe
> support and [2] depends on [1] to introduce IPQ5332 PCIe support.
> Since the community was interested in [2] (please see [3]), tried
> to revive IPQ5332's PCIe support with v2 of this patch series.
> 
> [...]

Applied, thanks!

[1/7] dt-bindings: phy: qcom,uniphy-pcie: Document PCIe uniphy
      commit: a2e934885c82912caf3f72b9511ef626f3619e3d
[2/7] phy: qcom: Introduce PCIe UNIPHY 28LP driver
      commit: 74badb8b0b146668cc6c03eb58e2a814f9463d02

Best regards,
-- 
~Vinod



