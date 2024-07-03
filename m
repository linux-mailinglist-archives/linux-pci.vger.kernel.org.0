Return-Path: <linux-pci+bounces-9757-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D279F926899
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 20:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 701AEB2401E
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 18:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F49A1891B6;
	Wed,  3 Jul 2024 18:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQ7eo1Ak"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F04217A5B0;
	Wed,  3 Jul 2024 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720032597; cv=none; b=WE22ywmJmHRtS6u/MFaxb+9nO+2vFc7NhL8o/LpFMpzUKOKrWOJD9w0uM0GjMwZMS7Y8kQaPlF7AdFRcZHJ0xTMAg1HmG1jTH21c98pMFBgn18EDfNCEBm1ck8Hdrn0H0s8rk2NgKsC1fsVpt9PLOZHFrlDoCwF3PshI5WHxgd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720032597; c=relaxed/simple;
	bh=tL3e/ur6/KMkg7mh3t7r3ZIFeZQ4xi5Q34S/7FlZ2qA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SLq2w25GpHpJBUellizhaTjqXXk76DXYVeBiRdvDL7I8h7/vRs3pjJ1J40oIPwxA/uls4pJOVx7u1tzsLEceO+TuGQgjyA1/QA+yKbeX5uuaueX724HZHO5boF25b4Bkxs49NUb2f8Y7/MrgRLdac44sLslW72RIbiIdV51tqBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQ7eo1Ak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B6EC2BD10;
	Wed,  3 Jul 2024 18:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720032596;
	bh=tL3e/ur6/KMkg7mh3t7r3ZIFeZQ4xi5Q34S/7FlZ2qA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SQ7eo1AkC8LjRWberzbfTrXdEmn8AVAPTH1nI5h830+ubxo1C5MaKmEtPRy9gsG1o
	 M8aW67LDGZEnsrCM4Q/GRKRYn+r39JIjjMUn4+wwhQ4mb+Nyw7/6h4NQGIjateXcmW
	 XAfTSrhx2kUyLwJweon5gGjsH9sMGD6YpKO/TIf9EwzO/u3UL14SYAuIKAMoMlbYkK
	 bxKEJlfNCtFdikjht8PVx57e+Ez2TZA0kY1xDB4xr5o96jrOLhYPq5oX8riaz0aLMe
	 pQxRIT/WAYj12CgJvmnxQibErDTaKj3syhCujN4MjJ27ACtbE6kpJopp6TU3GIN89Q
	 vkEmm7DBvS+3g==
Date: Wed, 3 Jul 2024 11:49:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: patchwork-bot+netdevbpf@kernel.org
Cc: Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, djakov@kernel.org, mturquette@baylibre.com,
 sboyd@kernel.org, jassisinghbrar@gmail.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, manivannan.sadhasivam@linaro.org, will@kernel.org,
 joro@8bytes.org, conor@kernel.org, tglx@linutronix.de, amitk@kernel.org,
 thara.gopinath@gmail.com, linus.walleij@linaro.org, wim@linux-watchdog.org,
 linux@roeck-us.net, rafael@kernel.org, viresh.kumar@linaro.org,
 vkoul@kernel.org, edumazet@google.com, pabeni@redhat.com,
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
 quic_devipriy@quicinc.com, quic_tsoni@quicinc.com,
 quic_rgottimu@quicinc.com, quic_shashim@quicinc.com,
 quic_kaushalk@quicinc.com, quic_tingweiz@quicinc.com,
 quic_aiquny@quicinc.com, srinivas.kandagatla@linaro.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-crypto@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 kernel@quicinc.com
Subject: Re: [PATCH 00/47] arm64: qcom: dts: add QCS9100 support
Message-ID: <20240703114952.6013f05e@kernel.org>
In-Reply-To: <171998042970.21654.12559535993133117436.git-patchwork-notify@kernel.org>
References: <20240703025850.2172008-1-quic_tengfan@quicinc.com>
	<171998042970.21654.12559535993133117436.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 03 Jul 2024 04:20:29 +0000 patchwork-bot+netdevbpf@kernel.org
wrote:
> This series was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:

> Here is the summary with links:
>   - [01/47] dt-bindings: arm: qcom: Document QCS9100 SoC and RIDE board
>     (no matching commit)
>   - [02/47] arm64: dts: qcom: qcs9100: Introduce QCS9100 SoC dtsi
>     (no matching commit)
>   - [03/47] arm64: dts: qcom: qcs9100: Introduce QCS9100 PMIC dtsi
>     https://git.kernel.org/netdev/net-next/c/df18948d331e

This is some bug / false positive in the bot, to be clear.
Commit df18948d331e is ("Merge branch 'device-memory-tcp'").
No idea how it got from that to DTS.

