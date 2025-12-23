Return-Path: <linux-pci+bounces-43610-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BBFCDA1D7
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 18:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41C673023523
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 17:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B4D2D192B;
	Tue, 23 Dec 2025 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UiZ1WPaC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F34199920;
	Tue, 23 Dec 2025 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766511198; cv=none; b=fLIuw7cDfripbCdHn6sdISFKOVx2PGQJOEpVtcQnWVSn5y7yo3lF1Vrzb7xSSTrRT+lkJ9SKNXWiafsSg1GjHQQ4nrbt0nOQpATKdkIBuq2ATnP4XAMlKIDS0o+9gXF/izsNcRIXvyAdVYjQYMy0yT0si4f9Y4Uv+HWuPyswfyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766511198; c=relaxed/simple;
	bh=fqs90y23G3zBmdexi2Bi6AeJAn0M8WA0UXmpnEz5lNI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DZoQUq8pdE47kCnGXu9ikYRGwuRMZpT7ZywNKa2XXHSWBIiXDIlLcH2pSWCgFCDDDp/toGg3h+dh/zbqfVV833Ii7AU9NT83Y3hwfgpNw+4VIS3oc1HXSgMh16/xPz1GRHyWP+2BF9tmx99dGVJ7WgMtdaF+bPej/C/JBI0ITpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UiZ1WPaC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5A6C113D0;
	Tue, 23 Dec 2025 17:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766511197;
	bh=fqs90y23G3zBmdexi2Bi6AeJAn0M8WA0UXmpnEz5lNI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UiZ1WPaC6hQN2uQS6MIcVlUB36Vkf7SB+xCnROUg1wcSCBCsGscVPRaVwmAWeRav/
	 KTFo5hbzjAjnhLf+rNsWmCyVYSCPDv9Nz46cTj+bqXavafgpNz9gvPP5bc5TnqSc2h
	 2zcvoweleVnGliSxPBOB44q81UyC7/0Jgr22CVM9dz1BOumI8BuUtS3nWr4CXUB/nX
	 DxIXsBKtMwaFgkwKBsA3cxhCmOoI1aTsPnPxoonAHZlI2HAGgX4HMPpEtLOmqbsleP
	 CMVpVf1p1O4Pr9Z/I3wf2ERfcIOoADsyQMhx/NTkrFotjdILCAbJp0kWN3oixKFJuI
	 WjCOpeR7KtNvg==
From: Vinod Koul <vkoul@kernel.org>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com, 
 mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org, 
 bhelgaas@google.com, johan+linaro@kernel.org, kishon@kernel.org, 
 neil.armstrong@linaro.org, abel.vesa@linaro.org, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com, 
 quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
In-Reply-To: <20250625092539.762075-1-quic_ziyuzhan@quicinc.com>
References: <20250625092539.762075-1-quic_ziyuzhan@quicinc.com>
Subject: Re: (subset) [PATCH v7 0/5] pci: qcom: Add QCS8300 PCIe support
Message-Id: <176651119188.749296.18284396701674542359.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 23:03:11 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 25 Jun 2025 17:25:34 +0800, Ziyue Zhang wrote:
> This series depend on the sa8775p gcc_aux_clock and link_down reset change
> https://lore.kernel.org/all/20250529035416.4159963-1-quic_ziyuzhan@quicinc.com/
> 
> This series adds document, phy, configs support for PCIe in QCS8300.
> It also adds 'link_down' reset for sa8775p.
> 
> Have follwing changes:
> 	- Add dedicated schema for the PCIe controllers found on QCS8300.
> 	- Add compatible for qcs8300 platform.
> 	- Add configurations in devicetree for PCIe0, including registers, clocks, interrupts and phy setting sequence.
> 	- Add configurations in devicetree for PCIe1, including registers, clocks, interrupts and phy setting sequence.
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings for qcs8300
      commit: 393e132efcc5e3fc4ef2bd9bbed2a096096c9359

Best regards,
-- 
~Vinod



