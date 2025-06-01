Return-Path: <linux-pci+bounces-28774-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3316AC9DF1
	for <lists+linux-pci@lfdr.de>; Sun,  1 Jun 2025 09:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFF997A7BF9
	for <lists+linux-pci@lfdr.de>; Sun,  1 Jun 2025 07:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E62B158545;
	Sun,  1 Jun 2025 07:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xXC/rtIA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FC917A305
	for <linux-pci@vger.kernel.org>; Sun,  1 Jun 2025 07:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748761541; cv=none; b=js66zBtkFdzrZCYxgkGSID3gZJ0LNooJ1z49TYo1JGbtEERfrpcX4nr1wcruvPuWrcIIHQq+QvBeQbaTyw/lnz78RwfDy1jUY4mv7wlsHc1yr82HKqE4UjQBOy2FeOjC/by0Tm6DDMf2IWXzALpoG52S0F2cMfepElXuzadePw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748761541; c=relaxed/simple;
	bh=b5TBNVn7AFtnC8283/oMyrwCoOBsBN6iBn6q0WoWmzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJwbB13DHHIVSpF2K9iBGHKo5ptCy/ds593L0FBTRKvMt5QOKJ4RTN5DSqYiIa6JRMjAiUNZ3j/frZaTl4XTgh2daqP9N1Pl9+QMFS2jCLvz7ZAqHqIRZMjQ5wURTromh0R+MIQyvB783ZnvTuQrFc+A/+3p/3HcIjGBXGRNEgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xXC/rtIA; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2301ac32320so30755025ad.1
        for <linux-pci@vger.kernel.org>; Sun, 01 Jun 2025 00:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748761538; x=1749366338; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tP4cIEQvwMPVrEztoI29giGwTzVH1fjQVhB02Bph62w=;
        b=xXC/rtIA7ES0SNr01OfeoDa4mrx4CJVRZCsLMsuKiB2bEBAGMfihLTScGL0CAsbmLl
         fMRhvcTiGXA3FjfD0bds7iBfe5DuJ8l80jLiHPXtIdDAwNu2twC1ke+OTKH6EDjHXcj4
         wanmh85FyEOzfq+aN/SHrar+maZ8pq9RRW37kkaglM2ESKFNeOgM8ikD5hp8q3JkyJoP
         nb4Obn5BVQu8apvvClkpNo7rJ9+exasY8ZVjRcj6w1c37E5b/ZgVdc8XXLkRb26ps9Bm
         uSLMY1Q1piTTGAGhXzVVyLKNbTbFUPYeXZnSXMN3RLDKf3uz5Eg9OOZb2peRD37zQMrV
         uI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748761538; x=1749366338;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tP4cIEQvwMPVrEztoI29giGwTzVH1fjQVhB02Bph62w=;
        b=TzbTP8AKDUlFIjaS5RsMpRmSHN9eCm25uuduZxPGDuHHFwk7DYD3cpsIuuG4pG+tLY
         OSWmfUWuygklcDN1XC/dY55aeTZMRdJ8FFF6hEFqXLn4BExGXPPcW1gM6UVgpr1auShe
         P0ES6PJKULvvp+Xq409jk0WwE8Dfyl6qJGMlKnDOnH15svmbEaHQs55gxyGlCN7iWWhg
         G/TPGOpusF89XoCib1+IK8vA2LexWxuSDdaTy4lkvF9Viu9KRjT+2XEb154nx80oBOB7
         IybjDezPJdRw9StIp4oaJtmH3JOKL76Cb29PCjMezD2CNFYub+1C4A8W6QMx7fOZSvhj
         gBSw==
X-Forwarded-Encrypted: i=1; AJvYcCVPQKVQGfU/H5zBhfw1LHvzOJazeT9qKc4eCU58auEpMBetNONULFrvFLWnjjCQvN7TovhBAip/lBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyez2nMkpdIn0TEEaLZTGIl9/yDJV3QTUkjLZMODkhjA8gt8hol
	ROvLQO4OlErA+4kjesAHn/lt5mzwuxfnjlpHOWwxJ52uN+8l7QWRWObBH+npMAmjwQ==
X-Gm-Gg: ASbGncvQwC0TC5HUb4rtdHQz1RDu7oRZaAu/SLn11EQtg6tNQsK2FjQsNRKCjryajWx
	oQi3uV2LK1cP+iEU7J57HZSa5S/bpIAKD5prVhlMhRTOgGEtk1gZfjLye36EUZ4NzsSG0gQFSNy
	keC9ZdzZZr2AMUj+kCfd5aoFl8FfqB+d16LYrkB3k+zLZnLSfygbuu68OKKRNezURoDnTWdhVQw
	ozOG5YjtbBZ2H5kTPG2zfLPL7VDOQWC4PJmopu3PFPo38a74BdGDefgXguqIg0rywEJSXr+u0V8
	rr7eLuIjGnQOUDcYI+2D40L45T+2LEXmcerPiLALNpQOuC9q1yWE73y3ltussTk=
X-Google-Smtp-Source: AGHT+IE247uLd/iBzphkxeKxftAlRKgNkFf6A4iG4K2SNJInbQbWVZdn+4gqUSzoyj78p796a0CT5w==
X-Received: by 2002:a17:902:74c6:b0:234:a44c:18d with SMTP id d9443c01a7336-235290e435emr124157195ad.22.1748761538281;
        Sun, 01 Jun 2025 00:05:38 -0700 (PDT)
Received: from thinkpad ([120.56.205.120])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf47edsm51491055ad.161.2025.06.01.00.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 00:05:37 -0700 (PDT)
Date: Sun, 1 Jun 2025 12:35:31 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH v3 3/3] arm64: qcom: sc7280: Move phy, perst to root port
 node
Message-ID: <r4mtndc6tww6eqfumensnsrnk6j6dw5nljgmiz2azzg2evuoy6@hog3twb22euq>
References: <20250419-perst-v3-0-1afec3c4ea62@oss.qualcomm.com>
 <20250419-perst-v3-3-1afec3c4ea62@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250419-perst-v3-3-1afec3c4ea62@oss.qualcomm.com>

On Sat, Apr 19, 2025 at 10:49:26AM +0530, Krishna Chaitanya Chundru wrote:
> There are many places we agreed to move the wake and perst gpio's
> and phy etc to the pcie root port node instead of bridge node[1].

Same comment as binding patch applies here.

> 
> So move the phy, phy-names, wake-gpio's in the root port.

You are not moving any 'wake-gpios' property.

> There is already reset-gpio defined for PERST# in pci-bus-common.yaml,
> start using that property instead of perst-gpio.
> 
> [1] https://lore.kernel.org/linux-pci/20241211192014.GA3302752@bhelgaas/
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts   | 5 ++++-
>  arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 5 ++++-
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi       | 5 ++++-
>  arch/arm64/boot/dts/qcom/sc7280.dtsi           | 6 ++----
>  4 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 7a36c90ad4ec8b52f30b22b1621404857d6ef336..3dd58986ad5da0f898537a51715bb5d0fecbe100 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -709,8 +709,11 @@ &mdss_edp_phy {
>  	status = "okay";
>  };
>  
> +&pcie1_port0 {
> +	reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> +};
> +
>  &pcie1 {
> -	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
>  
>  	pinctrl-0 = <&pcie1_reset_n>, <&pcie1_wake_n>;
>  	pinctrl-names = "default";

What about the pinctrl properties? They should also be moved.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

