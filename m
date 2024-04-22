Return-Path: <linux-pci+bounces-6545-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FFD8AD897
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 01:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 684A8B244E2
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 23:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116D21A38EA;
	Mon, 22 Apr 2024 22:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d5lJ08Xp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAF81BED72
	for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2024 22:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713826703; cv=none; b=DNSCAndb/3VKNEGZ4pCg3mHsZ33mpxTZaBaMT4kmkzJDyUKFBTcyqE8P58f/6zVFbuVcSbOOEyy5sHsWVJyVWzWoycT6bSAmOGeHD3MU6X/Xsu9fEmnOJNVfXt4wvSWoRM6VUEGXvFG7w1uWHvjSTKgV2ryrTPeAP01umJm2PGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713826703; c=relaxed/simple;
	bh=thOoIj8H0LNVaMm+8xqbhoPN1/fKkLQssvNM5xvvzCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qGtGr2IZJqzEDfWUhUPYk6XnhvS15dSNZ/dt0tPKf5oEaWr6MI2U1D5gGTPS/NB1cx3Cz/Zoln0GCBj4cw+Dt5FmBlFGWdYyz5yfD445dH3nktVMePzVOITlpQxFMGx59sstpGJTCvqiJXquOODYkFh8kepXI2lc0lj0Ml7j6xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d5lJ08Xp; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516d2b9cd69so6052226e87.2
        for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2024 15:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713826699; x=1714431499; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CGGnNleS6pq8ROfMjbtk13lB1tYV2wW+fjvh+BoINVM=;
        b=d5lJ08Xpr0SkTGHTL1qmpgJfmDeGFBTPgGWiuqHg/w8wb8DSV1/8WgQHeMVm9yNnwG
         K5E2GfZvIkSgn+WSd7U8fBkeNQHd/VmI241ffclockxN5zo1ML3wvtm82B6Jj5Erougt
         NFlD4Mebm+Re6/fC29UBY+tINbc2MnKOtI1X/MIe+gMsAKGswoOPZb8bRXDDuPgNmnJB
         +7Oz8MIyWgVOpbu+YVwfUaKZKxkgr3DEkYMAXeGNIKrQe3pNgc+F8a1WvnadxoIItvpW
         mo8SWWGsq6GcX3Q6nk8pMfjMadXFKgx7+7I0V0rCdK3/g+DMD52Ssg1MQ6BDyZpBHAKN
         ITog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713826699; x=1714431499;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CGGnNleS6pq8ROfMjbtk13lB1tYV2wW+fjvh+BoINVM=;
        b=bEwJnzOZMO59dkEyC5diRSR/KH/RS3s+QjG4F3NKsmVHrKfyf/XZsFeVbkSDx+pHjv
         0qS0TeGf3X0FMCc1eB+d/pQl3GOdXUNHHaBb+GFnaUszfbXfv1inBpYHSBRDQXpR8FAM
         virzjU4YIzXzIE0FwDswnpoJojIGCR65aWYt5bU3aXlW31u/mTDHluOFzIizuJ2yl9Ep
         tRtJA7nWsiyYYbUyPPx0x+oSO8ICf8oodU0aYDxGuahlxJtcPaYY6eXHHCbSDq44kYPE
         2gWnCk9EsheBFpnIKgqYdyJB4EQ6/Gr+8Gw/Q7XVJ213tYh7RKfPiuz7xAEu1HRM14FI
         emOQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7qnMn82VREx8punF5qUBURyfKJej/Mo1zU51mRKoBBEU/VXwuVnRmYf5DiJw7Q/wGIVWRqXgaZ9VqtmmYdKeUbrnLBaF0mUo6
X-Gm-Message-State: AOJu0YyrsMyNSKhURairN6ygSGzmxP7S4lY5p3AiDk90InqUMDSKqxFi
	oKm06sSzTPieqV5lJdJKhREu8+YX4GSM8Qni0KftisCG23svdeJIu3LkHG/YLFk=
X-Google-Smtp-Source: AGHT+IE3JW5i0TZ/iw0u6mb9hzFt2DO7Qxo8mdGCoGs95SLJhdave1LdDOaJnsu2juzz/HsQwMOSnQ==
X-Received: by 2002:ac2:455c:0:b0:51a:f362:ab2a with SMTP id j28-20020ac2455c000000b0051af362ab2amr4280647lfm.59.1713826699464;
        Mon, 22 Apr 2024 15:58:19 -0700 (PDT)
Received: from [172.30.204.103] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id f13-20020a056512360d00b0051ad4552454sm1217213lfs.148.2024.04.22.15.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 15:58:19 -0700 (PDT)
Message-ID: <02ae9e6b-b652-433e-b36d-e6106d4fbcd1@linaro.org>
Date: Tue, 23 Apr 2024 00:58:14 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] PCI: qcom: Add rx margining settings for 16GT/s
To: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>,
 agross@kernel.org, andersson@kernel.org, mani@kernel.org
Cc: quic_msarkar@quicinc.com, quic_kraravin@quicinc.com,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Jingoo Han <jingoohan1@gmail.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Serge Semin <fancer.lancer@gmail.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Conor Dooley <conor.dooley@microchip.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20240419001013.28788-1-quic_schintav@quicinc.com>
 <20240419001013.28788-4-quic_schintav@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240419001013.28788-4-quic_schintav@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/19/24 02:09, Shashank Babu Chinta Venkata wrote:
> Add rx lane margining settings for 16GT/s(GEN 4) data rate. These
> settings improve link stability while operating at high date rates
> and helps to improve signal quality.
> 
> Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
> ---
>   drivers/pci/controller/dwc/pcie-designware.h  | 18 ++++++++++++++
>   drivers/pci/controller/dwc/pcie-qcom-common.c | 24 +++++++++++++++++++
>   drivers/pci/controller/dwc/pcie-qcom-common.h |  1 +
>   drivers/pci/controller/dwc/pcie-qcom-ep.c     |  4 +++-
>   drivers/pci/controller/dwc/pcie-qcom.c        |  4 +++-
>   5 files changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index ad771bb52d29..e8c48855143f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -203,6 +203,24 @@
>   
>   #define PCIE_PL_CHK_REG_ERR_ADDR			0xB28
>   
> +/*
> + * GEN4 lane margining register definitions
> + */
> +#define GEN4_LANE_MARGINING_1_OFF		0xb80
> +#define MARGINING_MAX_VOLTAGE_OFFSET(n)		FIELD_PREP(GENMASK(29, 24), n)
> +#define MARGINING_NUM_VOLTAGE_STEPS(n)		FIELD_PREP(GENMASK(22, 16), n)
> +#define MARGINING_MAX_TIMING_OFFSET(n)		FIELD_PREP(GENMASK(13, 8), n)
> +#define MARGINING_NUM_TIMING_STEPS(n)		FIELD_PREP(GENMASK(5, 0), n)
> +
> +#define GEN4_LANE_MARGINING_2_OFF		0xb84
> +#define MARGINING_IND_ERROR_SAMPLER(n)		FIELD_PREP(BIT(28), n)
> +#define MARGINING_SAMPLE_REPORTING_METHOD(n)	FIELD_PREP(BIT(27), n)
> +#define MARGINING_IND_LEFT_RIGHT_TIMING(n)	FIELD_PREP(BIT(26), n)
> +#define MARGINING_IND_UP_DOWN_VOLTAGE(n)	FIELD_PREP(BIT(25), n)
> +#define MARGINING_VOLTAGE_SUPPORTED(n)		FIELD_PREP(BIT(24), n)
> +#define MARGINING_MAXLANES(n)			FIELD_PREP(GENMASK(20, 16), n)
> +#define MARGINING_SAMPLE_RATE_TIMING(n)		FIELD_PREP(GENMASK(13, 8), n)
> +#define MARGINING_SAMPLE_RATE_VOLTAGE(n)	FIELD_PREP(GENMASK(5, 0), n)

That's a.. rather unusual.. use of FIELD_/GENMASK.. Usually, the fields are
defined with GENMASK and then referenced through FIELD_xyz(BITFIELD_NAME, val)

That said, I'm not entirely against this if Mani is ok with it

>   /*
>    * iATU Unroll-specific register definitions
>    * From 4.80 core version the address translation will be made by unroll
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.c b/drivers/pci/controller/dwc/pcie-qcom-common.c
> index a6f3eb4c3ee6..3279314ae78c 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-common.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
> @@ -46,6 +46,30 @@ void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci)
>   }
>   EXPORT_SYMBOL_GPL(qcom_pcie_common_set_16gt_eq_settings);
>   
> +void qcom_pcie_common_set_16gt_rx_margining_settings(struct dw_pcie *pci)
> +{
> +	u32 reg;
> +
> +	reg = dw_pcie_readl_dbi(pci, GEN4_LANE_MARGINING_1_OFF);
> +	reg = MARGINING_MAX_VOLTAGE_OFFSET(0x24) |
> +		MARGINING_NUM_VOLTAGE_STEPS(0x78) |
> +		MARGINING_MAX_TIMING_OFFSET(0x32) |
> +		MARGINING_NUM_TIMING_STEPS(0x10);
> +	dw_pcie_writel_dbi(pci, GEN4_LANE_MARGINING_1_OFF, reg);

Since this is DW-common, why is this inside the qcom driver?

Konrad

