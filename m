Return-Path: <linux-pci+bounces-2130-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1A582C766
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 23:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE551F248FE
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 22:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D48182B9;
	Fri, 12 Jan 2024 22:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xNh8lrph"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE225182A9
	for <linux-pci@vger.kernel.org>; Fri, 12 Jan 2024 22:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a298accc440so861805766b.1
        for <linux-pci@vger.kernel.org>; Fri, 12 Jan 2024 14:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705099501; x=1705704301; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5+Yt8N0vLR3BWDealxvKrDyIpQpUSEu3d8Yxm5uh+ww=;
        b=xNh8lrphPW0XrDkvXtAPJERPaVFQYLkERJf6FZMkQD3LZ6XrF5+mXQOCKSpbZzkGVg
         +sl3/i8kSqOz15Qfk3TStsvYzaxEuwufcwxPcoJ+cnmilb7dNkrq/SEaWe0KEjvRgD5q
         OGKouoDt2IV2MFaZnAHeEmdLJyt9mRW06n8fTj/Hg1HsMUfKFyuy4EL+O0s9F24SbRYy
         g6TCfzeC5k+fJyGkgKQbsUb3ba2D7r75NQXQmvJMtZ6KOQeuoJfY9NjgwMuzePBsAm/j
         IHOcYYdLhovU7TN3YWdkEVm1kk7PlqmCiWWyROqdE0r0wh6M8OvGYC37xnLpV3xPiDb8
         76Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705099501; x=1705704301;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+Yt8N0vLR3BWDealxvKrDyIpQpUSEu3d8Yxm5uh+ww=;
        b=hwymhpLWFz6sa2bXeTornVHjGXQAOhD3tTxzofzdFHtggKiFb9lpAq5GU97o/JsPPu
         D9qQlrFevPPbemVHkoarRF7x+T7h5xFHgkgqBhw1Gj1xJlL2SFcae/NMu7ksVuxd/N6t
         iy2KLG+CUWMJnH0vJAPTmHgTiFLud7fISBI979Qcj0a7AX0b0Z+dgnYkF4k7TN1v7FXH
         C82/DFjp4xs+FRhtNJeqlaXD+ey+39uOOkhoSGaoxVRdPZnEEthQvmMZGNiRffGKaSTE
         P8pf1TH+GD5RqM/oXM7NXvTXIu1nETwrU8IyxRf/NBmL04fb4piEBTv7DqN2sPldlfX9
         b/ag==
X-Gm-Message-State: AOJu0YxSKV3AF8XEkWxOlCJuE6KlHhdpX1iociN4kM3S7wlBNB4e0eeM
	XBASPAIzcb4mv4nqd9/zodjmRR9lrSbWjw==
X-Google-Smtp-Source: AGHT+IHsxytgP5d+Op5yk1COIvhtctxmIA5NVUcm0Qp+yPfyaXqjp1C+H1DLkpMuIW4haoYo2lqawg==
X-Received: by 2002:a17:907:c70c:b0:a28:a8cb:3185 with SMTP id ty12-20020a170907c70c00b00a28a8cb3185mr1180597ejc.69.1705099500991;
        Fri, 12 Jan 2024 14:45:00 -0800 (PST)
Received: from [192.168.174.25] (178235179017.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.17])
        by smtp.gmail.com with ESMTPSA id u3-20020a1709064ac300b00a269b4692a9sm2223723ejt.84.2024.01.12.14.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 14:45:00 -0800 (PST)
Message-ID: <d7bb676c-f881-4be0-aff2-da50c9fa7eda@linaro.org>
Date: Fri, 12 Jan 2024 23:44:57 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] PCI: qcom: Add OPP support to scale performance
 state of power domain
Content-Language: en-US
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Johan Hovold <johan+linaro@kernel.org>,
 Brian Masney <bmasney@redhat.com>, Georgi Djakov <djakov@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, vireshk@kernel.org,
 quic_vbadigan@quicinc.com, quic_skananth@quicinc.com,
 quic_nitegupt@quicinc.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com>
 <20240112-opp_support-v6-6-77bbf7d0cc37@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240112-opp_support-v6-6-77bbf7d0cc37@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.01.2024 15:22, Krishna chaitanya chundru wrote:
> QCOM Resource Power Manager-hardened (RPMh) is a hardware block which
> maintains hardware state of a regulator by performing max aggregation of
> the requests made by all of the processors.
> 
> PCIe controller can operate on different RPMh performance state of power
> domain based up on the speed of the link. And this performance state varies
> from target to target.
> 
> It is manadate to scale the performance state based up on the PCIe speed
> link operates so that SoC can run under optimum power conditions.
> 
> Add Operating Performance Points(OPP) support to vote for RPMh state based
> upon GEN speed link is operating.
> 
> OPP can handle ICC bw voting also, so move icc bw voting through opp
> framework if opp entries are present.
> 
> In PCIe certain gen speeds like GEN1x2 & GEN2X1 or GEN3x2 & GEN4x1 use
> same icc bw and has frequency, so use frequency based search to reduce
> number of entries in the opp table.
> 
> Don't initialize icc if opp is supported.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---

[...]

>  
> -static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
> +static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)

Or simply.. qcom_pcie_opp_update :) Especially with Dmitry's
suggestions

>  {
>  	struct dw_pcie *pci = pcie->pci;
> -	u32 offset, status;
> +	u32 offset, status, freq;
> +	struct dev_pm_opp *opp;
>  	int speed, width;
>  	int ret;
>  
> -	if (!pcie->icc_mem)
> -		return;
> -
>  	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>  	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
>  
> @@ -1424,11 +1424,42 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
>  	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
>  	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
>  
> -	ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
> -	if (ret) {
> -		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> -			ret);
> +	if (pcie->opp_supported) {
> +		switch (speed) {
> +		case 1:
> +			freq = 2500000;
> +			break;
> +		case 2:
> +			freq = 5000000;
> +			break;
> +		case 3:
> +			freq = 8000000;
> +			break;
> +		default:
> +			WARN_ON_ONCE(1);
> +			fallthrough;
> +		case 4:
> +			freq = 16000000;
> +			break;
> +		}
Might as well add gen5 and 6 rates of 3200.. and 6400.. since they're
hard-in-stone in the spec by now, AFAIK

Konrad

