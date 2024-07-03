Return-Path: <linux-pci+bounces-9687-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868C392521A
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 06:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9C291C232F0
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 04:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD10512FB16;
	Wed,  3 Jul 2024 04:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHxvaJlI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C4161FE1;
	Wed,  3 Jul 2024 04:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719980430; cv=none; b=VyoVyF3n35ojHJ0dbeE8rwhfGjAY50M7N/RGbijaAPWYRi2My+aEf44QplO0fvtWexvZ7SHgXJpVAaCTQES1ljwM1tqZVi3/7JeEm4qQsWkU56Xfp5n3IRLP7AhQi94rBGALFkvXWVzg1gAVNUEbKjC9U6sQSjy8jNc5r/oQe24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719980430; c=relaxed/simple;
	bh=Cxg67S+/b4PFpqD8c8jDsQk7LHaaGLk2W+TlIyPL5KA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P13t/XiuxiLnVQA1yajhS90c7jmBgpgCq5Bs2t6KozRMrEVY4sxtTdQJKEFY8ji6Xm7HvoAO3fRLLPgzl05WH2PxC9w0bIAT2i03UyVqqfEN8IV6hJ+M7jWYosbUxfWLm3M69s4Sp01aRs6NhT4jH7T3bfC7bV35jJnpm5HA0Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHxvaJlI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D42F9C4AF10;
	Wed,  3 Jul 2024 04:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719980429;
	bh=Cxg67S+/b4PFpqD8c8jDsQk7LHaaGLk2W+TlIyPL5KA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cHxvaJlIRTeIEa5yxQbgJRndGUYihRVgVhEjwwd0BmcxEKGvhwTuUhe4kOSC/0Zns
	 EEF3V5+lYu5qldErNDgWMl1McUQVjNs8W/j/DKDtR4Q80pz9RHzOcDy4KRwTVjL9wa
	 77YeEaVeCA0mBr8iPmJJGE6+4f7GL0RHfeSS9xscpsLKjEIyqTqJkgVmDkKn4h3SBT
	 i0eMZKAi8e2+OOwCXTYTNNPmt6wmHID+6PXE0VoxqfHdQm8KnEU/Ml4gRYKaut8elu
	 jkFBzpGnoOLr8//pE0zPeRU4T6CAsxs3jiDBmGaHxGmTQK+D0voIqP3B9mDvUo2foU
	 WQ3YkURFBJ12Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD173C41677;
	Wed,  3 Jul 2024 04:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/47] arm64: qcom: dts: add QCS9100 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171998042970.21654.12559535993133117436.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jul 2024 04:20:29 +0000
References: <20240703025850.2172008-1-quic_tengfan@quicinc.com>
In-Reply-To: <20240703025850.2172008-1-quic_tengfan@quicinc.com>
To: Tengfei Fan <quic_tengfan@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, djakov@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, jassisinghbrar@gmail.com,
 herbert@gondor.apana.org.au, davem@davemloft.net,
 manivannan.sadhasivam@linaro.org, will@kernel.org, joro@8bytes.org,
 conor@kernel.org, tglx@linutronix.de, amitk@kernel.org,
 thara.gopinath@gmail.com, linus.walleij@linaro.org, wim@linux-watchdog.org,
 linux@roeck-us.net, rafael@kernel.org, viresh.kumar@linaro.org,
 vkoul@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, robimarko@gmail.com, quic_gurus@quicinc.com,
 bartosz.golaszewski@linaro.org, kishon@kernel.org, quic_wcheng@quicinc.com,
 alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
 agross@kernel.org, gregkh@linuxfoundation.org, quic_tdas@quicinc.com,
 robin.murphy@arm.com, daniel.lezcano@linaro.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, quic_rjendra@quicinc.com, ulf.hansson@linaro.org,
 quic_sibis@quicinc.com, otto.pflueger@abscue.de, quic_rohiagar@quicinc.com,
 luca@z3ntu.xyz, neil.armstrong@linaro.org, abel.vesa@linaro.org,
 bhupesh.sharma@linaro.org, alexandre.torgue@foss.st.com,
 peppe.cavallaro@st.com, joabreu@synopsys.com, netdev@vger.kernel.org,
 lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
 ahalaney@redhat.com, krzysztof.kozlowski@linaro.org,
 u.kleine-koenig@pengutronix.de, dmitry.baryshkov@linaro.org,
 quic_cang@quicinc.com, danila@jiaxyga.com, quic_nitirawa@quicinc.com,
 mantas@8devices.com, athierry@redhat.com, quic_kbajaj@quicinc.com,
 quic_bjorande@quicinc.com, quic_msarkar@quicinc.com,
 quic_devipriy@quicinc.com, quic_tsoni@quicinc.com, quic_rgottimu@quicinc.com,
 quic_shashim@quicinc.com, quic_kaushalk@quicinc.com,
 quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com,
 srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, kernel@quicinc.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 3 Jul 2024 10:58:03 +0800 you wrote:
> Introduce support for the QCS9100 SoC device tree (DTSI) and the
> QCS9100 RIDE board DTS. The QCS9100 is a variant of the SA8775p.
> While the QCS9100 platform is still in the early design stage, the
> QCS9100 RIDE board is identical to the SA8775p RIDE board, except it
> mounts the QCS9100 SoC instead of the SA8775p SoC.
> 
> The QCS9100 SoC DTSI was directly renamed from the SA8775p SoC DTSI. In
> the upcoming weeks, Nikunj Kela will develop a new device tree related
> to SA8775p, specifically supporting the SCMI resource firmware solution
> for the SA8775p platform. If you're already familiar with the
> background, feel free to skip part[2], which provides a detailed
> explanation.
> 
> [...]

Here is the summary with links:
  - [01/47] dt-bindings: arm: qcom: Document QCS9100 SoC and RIDE board
    (no matching commit)
  - [02/47] arm64: dts: qcom: qcs9100: Introduce QCS9100 SoC dtsi
    (no matching commit)
  - [03/47] arm64: dts: qcom: qcs9100: Introduce QCS9100 PMIC dtsi
    https://git.kernel.org/netdev/net-next/c/df18948d331e
  - [04/47] arm64: dts: qcom: qcs9100: Add QCS9100 RIDE board dts
    (no matching commit)
  - [05/47] dt-bindings: firmware: qcom,scm: document SCM on QCS9100 SoC
    (no matching commit)
  - [06/47] dt-bindings: interconnect: qcom: document the interconnect compatibles for QCS9100
    (no matching commit)
  - [07/47] dt-bindings: clock: document QCS9100 GCC compatible
    (no matching commit)
  - [08/47] dt-bindings: mailbox: qcom-ipcc: Document the QCS9100 IPCC
    (no matching commit)
  - [09/47] dt-bindings: phy: Add QMP UFS PHY comptible for QCS9100
    (no matching commit)
  - [10/47] dt-bindings: crypto: ice: Document QCS9100 inline crypto engine
    (no matching commit)
  - [11/47] dt-bindings: crypto: qcom,prng: document QCS9100
    (no matching commit)
  - [12/47] dt-bindings: phy: qcom,usb-snps-femto-v2: Add bindings for QCS9100
    (no matching commit)
  - [13/47] dt-bindings: ufs: qcom: document QCS9100 UFS
    (no matching commit)
  - [14/47] dt-bindings: phy: qcom,qmp-usb: Add QCS9100 USB3 PHY
    (no matching commit)
  - [15/47] dt-bindings: usb: dwc3: Add QCS9100 compatible
    (no matching commit)
  - [16/47] dt-bindings: clock: qcom: describe the GPUCC clock for QCS9100
    (no matching commit)
  - [17/47] dt-bindings: arm-smmu: Document QCS9100 GPU SMMU
    (no matching commit)
  - [18/47] dt-bindings: phy: describe the Qualcomm SGMII PHY for QCS9100
    (no matching commit)
  - [19/47] dt-bindings: cache: qcom,llcc: Add QCS9100 description
    (no matching commit)
  - [20/47] dt-bindings: interrupt-controller: qcom,pdc: document pdc on QCS9100
    (no matching commit)
  - [21/47] dt-bindings: thermal: qcom-tsens: document the QCS9100 Temperature Sensor
    (no matching commit)
  - [22/47] dt-bindings: soc: qcom,aoss-qmp: Document the QCS9100 AOSS channel
    (no matching commit)
  - [23/47] dt-bindings: pinctrl: add qcs9100-tlmm compatible
    (no matching commit)
  - [24/47] dt-bindings: soc: qcom: add qcom,qcs9100-imem compatible
    (no matching commit)
  - [25/47] dt-bindings: watchdog: qcom-wdt: document QCS9100
    (no matching commit)
  - [26/47] dt-bindings: clock: qcom-rpmhcc: Add RPMHCC bindings for QCS9100
    (no matching commit)
  - [27/47] dt-bindings: cpufreq: cpufreq-qcom-hw: Add QCS9100 compatibles
    (no matching commit)
  - [28/47] dt-bindings: power: qcom,rpmpd: document the QCS9100 RPMh Power Domains
    (no matching commit)
  - [29/47] dt-bindings: net: qcom,ethqos: add description for qcs9100
    (no matching commit)
  - [30/47] dt-bindings: PCI: Document compatible for QCS9100
    (no matching commit)
  - [31/47] dt-bindings: PCI: qcom-ep: Add support for QCS9100 SoC
    (no matching commit)
  - [32/47] dt-bindings: phy: qcom,qmp: Add qcs9100 QMP PCIe PHY
    (no matching commit)
  - [33/47] interconnect: qcom: add driver support for qcs9100
    (no matching commit)
  - [34/47] clk: qcom: add the GCC driver support for QCS9100
    (no matching commit)
  - [35/47] phy: qcom-qmp-ufs: Add QCS9100 support
    (no matching commit)
  - [36/47] phy: qcpm-qmp-usb: Add support for QCS9100
    (no matching commit)
  - [37/47] clk: qcom: add the GPUCC driver support for QCS9100
    (no matching commit)
  - [38/47] phy: qcom: add the SGMII SerDes PHY driver support
    (no matching commit)
  - [39/47] soc: qcom: llcc: Add llcc configuration support for the QCS9100 platform
    (no matching commit)
  - [40/47] pinctrl: qcom: add the tlmm driver support for qcs9100 platform
    (no matching commit)
  - [41/47] clk: qcom: rpmh: Add support for QCS9100 rpmh clocks
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



