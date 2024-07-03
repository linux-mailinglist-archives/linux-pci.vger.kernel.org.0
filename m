Return-Path: <linux-pci+bounces-9690-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A34925270
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 06:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3741F26E00
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 04:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D57F38FA3;
	Wed,  3 Jul 2024 04:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+hv0vca"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F6B2E646;
	Wed,  3 Jul 2024 04:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719981537; cv=none; b=pZ+OKe6S0et5ekahCPMpCHNQM6Xj54oGbktKLOZFIbJ70tWBM2s96HpKE4j+W3Ffk4lGCociGzgZIKvtXE/EsZxnfCt51MAqt8Z3ZI6YqeV9pZjBlDNI5vmXneaFVc+cUlNxPqhSja9VcFH8ePiZKEmLNmRFaTAEoBCU2zIIpok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719981537; c=relaxed/simple;
	bh=W1kROEg3Fjkby7km6ea2XB5zUQBCta+iGVmjqDJNcd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZqPUtFLZLcDvSPhlBsWsB7B8aq8z+yUddbX0sc9IqlFyHIPn9eRohJDaWH+wyqvn2Y7pnOa+GP7g6OGwpdbTWkSrLgbI5cDbqW8ql9okxlTCFPHJ0iuQo2u8002k2UtKd29I+NApJAkYBegpUe1QWmyUP8Fc6LWsmxOMdovMr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+hv0vca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD393C32781;
	Wed,  3 Jul 2024 04:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719981536;
	bh=W1kROEg3Fjkby7km6ea2XB5zUQBCta+iGVmjqDJNcd4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H+hv0vcaiq0XC7+jQ4SkBP6tLioSIe3HKWUbXaOlUbiaFuBk9DLPO6VtNaanYUvzQ
	 Ev/nx7GDK0z1YI39SPHe5GZWGxN+hkg9cwmbiWCwdESQw03d1YG767i52fPG/rVnuK
	 UOb1ndi1WGV82b3WM/a5qdpRt3Fb63aRJ2Htb59BTCAqbDCrjlgPQnzyc26BfvChNf
	 TwFz7y9MCugmzjF5lnkT4ZELHLonzS58O1pg7wcml6uL942bgU0iRWtcikgy03fsKi
	 KLp8csgIQfcYyKnwjYthjPSFP1QW16hZutMWuBsN+BZQPLf9kUUNuratI9rp68f9O6
	 ZFOZuNIoRcFng==
Message-ID: <665f6c8c-4f43-4d20-90e9-9e037a942066@kernel.org>
Date: Wed, 3 Jul 2024 06:38:24 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/47] dt-bindings: arm: qcom: Document QCS9100 SoC and
 RIDE board
To: Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, djakov@kernel.org, mturquette@baylibre.com,
 sboyd@kernel.org, jassisinghbrar@gmail.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, manivannan.sadhasivam@linaro.org, will@kernel.org,
 joro@8bytes.org, conor@kernel.org, tglx@linutronix.de, amitk@kernel.org,
 thara.gopinath@gmail.com, linus.walleij@linaro.org, wim@linux-watchdog.org,
 linux@roeck-us.net, rafael@kernel.org, viresh.kumar@linaro.org,
 vkoul@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com
Cc: robimarko@gmail.com, quic_gurus@quicinc.com,
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
References: <20240703025850.2172008-1-quic_tengfan@quicinc.com>
 <20240703025850.2172008-2-quic_tengfan@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240703025850.2172008-2-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/07/2024 04:58, Tengfei Fan wrote:
> Document the QCS9100 SoC and RIDE board.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index ec1c10a12470..f06543f96026 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -45,6 +45,7 @@ description: |
>          qcs8550
>          qcm2290
>          qcm6490
> +        qcs9100
>          qdu1000
>          qrb2210
>          qrb4210
> @@ -894,7 +895,9 @@ properties:
>  
>        - items:
>            - enum:
> +              - qcom,qcs9100-ride
>                - qcom,sa8775p-ride
> +          - const: qcom,qcs9100

This changes existing compatible for sa8775p without any explanation in
commit msg.

Best regards,
Krzysztof


