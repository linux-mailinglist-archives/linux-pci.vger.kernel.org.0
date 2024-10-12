Return-Path: <linux-pci+bounces-14359-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EEE99B115
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 07:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD232847B5
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 05:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CF512D760;
	Sat, 12 Oct 2024 05:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fe9T5oMg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41972BB09
	for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 05:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728711408; cv=none; b=WEkIOMEcyi6i++drifNfKtUZNSrdCOLpTRP7XUc2RpxKfjfLyP67OhXe8EHC+AZsHsFIcQYvUgYwQQw1YNqN2C2+U2DAB8QjndkYdt9hT4+q6dFEAsWuiberPqmyGFXq9qhQbO97wB8tPtHaa4+Ynl3pLOPKHH4Wcrs+G1hh2Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728711408; c=relaxed/simple;
	bh=id6bl7x2+/RADHJgpgSgWPIftbgTDqmwOH9HR9CntpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDR4JVbh9MtJ3fNkojAkj5yqEhUzsEErbEORcflMrxGT1IOmt1tKZBERuXUM5a+tHvn2lXDXH1hhV6xnr2SX5SQXWawbdJHtyHDAJcH/VKFSWO2H/QTPuILGkDDV1JIFBUDvmNYf33gMP7jmhYK94KQW7zI2Zmg/PNEcpGZp3TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fe9T5oMg; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e188185365so2201781a91.1
        for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2024 22:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728711406; x=1729316206; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MjQuIV6kj3VfwRWddXnrTlmwecAWDBUJYA1PrNxHudo=;
        b=Fe9T5oMg4fjcyqgrGozD/NgYo8G4IIuNAJnZeWpGTeWI5nCPy0IDjuNomWDTPC/ynt
         3/E9WmqGi8I40NyC0C0znvyW+F3betQRryykUfvz36TiW5ou9zP9RdaUhPyoQ6PkvAeG
         cC1MguNIwZv375x6cShNNep2nHrMZlJmspz1NPTRJDJHXDNLaRYggmG+O/60z0u0xeTP
         msPU8UMwb19VrEkfLY7zT0KlIuLC1/g1PEsH26w72+Cn4sOFeFPd1kdoZ2xs1R5LwK0Z
         xZwxLhjNz8xMFMlpVFFUFcYJuPKNpXkshh74rF8mLs35ANGAEZvnIv2x+Qql4+4vIovr
         jfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728711406; x=1729316206;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MjQuIV6kj3VfwRWddXnrTlmwecAWDBUJYA1PrNxHudo=;
        b=nJFFtyrnu2jhWvcpmq7R0/WS/RGSjZayh6FJsXowWMH7CNOD/O60W1LlrdewLFUMNJ
         h7vkS2CONtUzxBoCKpg5um7npki4E9fMy6wMKVSEH5xQQqKNOBK3RgSPu8XU803100cg
         Hww8TRRxgMZH/MJkJpp5Ae53+QjwEOcbxJiwHd/QiXk/h6TIN3hFz6UKGdByqlT48eo0
         aaAskHF7M21nJRYFe4nwfxMbt1F2cO4hMsrHihBYqacGnq9IYFPaFN0pTV81mTj9qvLM
         XncXi4m1KCSU1M8N+O1uVfOxI9JxTt08rLKsfbRtJihayWjaAFbL0A03aGWD5AYObajf
         AlUg==
X-Forwarded-Encrypted: i=1; AJvYcCWu+B4mni0SM2lJLt9PATpn3/Ch8o+S62MopFPTCQ6g0CaZwz9MEE0d27ety0KvIiP60Wd69Mj3YIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUSJTrm1XtwEc3ESBv9nDwIrRiowVmzhxS4e2Z96c1YoyQGIch
	TDkkpZhTYv2uB5yn2CEuG9/U2tEw2yaF6aFWpqVn0EqRyi870ljqElMeocn/wg==
X-Google-Smtp-Source: AGHT+IHqiyyz1xhjY6vqhIqY84FxPaW6G2o/VAwjL/1LFjW/xaek+9WCg+PZY5ymNnouaWkyvQGCag==
X-Received: by 2002:a17:90b:893:b0:2e0:a47a:5eb0 with SMTP id 98e67ed59e1d1-2e2f0da8051mr5652417a91.38.1728711406131;
        Fri, 11 Oct 2024 22:36:46 -0700 (PDT)
Received: from thinkpad ([220.158.156.122])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a36417afsm6683894a91.0.2024.10.11.22.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 22:36:45 -0700 (PDT)
Date: Sat, 12 Oct 2024 11:06:37 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
	andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	abel.vesa@linaro.org, quic_msarkar@quicinc.com,
	quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org,
	kw@linux.com, lpieralisi@kernel.org, neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 7/8] PCI: qcom: Fix the cfg for X1E80100 SoC
Message-ID: <20241012053637.cu2eyle6d7gbqsth@thinkpad>
References: <20241011104142.1181773-1-quic_qianyu@quicinc.com>
 <20241011104142.1181773-8-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241011104142.1181773-8-quic_qianyu@quicinc.com>

On Fri, Oct 11, 2024 at 03:41:41AM -0700, Qiang Yu wrote:
> Currently, the cfg_1_9_0 which is being used for X1E80100 has config_sid
> callback in its ops and doesn't disable ASPM L0s. However, as same as
> SC8280X, PCIe controllers on X1E80100 are connected to SMMUv3 and it is

"...connected to SMMUv3, hence doesn't need config_sid() callback"

> recommended to disable ASPM L0s. Hence reuse cfg_sc8280xp for X1E80100.

"...and hardware team has recommended to disable L0s as it is broken in the
controller."

> 
> Fixes: 6d0c39324c5f ("PCI: qcom: Add X1E80100 PCIe support")
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

We need to backport this patch to stable to fix the L0s handling. But we don't
need the previous patch as even without that cfg_sc8280xp disables L0s.

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 468bd4242e61..c533e6024ba2 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1847,7 +1847,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },
> -	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_1_9_0 },
> +	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_sc8280xp },
>  	{ }
>  };
>  
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

