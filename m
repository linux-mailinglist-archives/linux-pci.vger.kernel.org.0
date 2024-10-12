Return-Path: <linux-pci+bounces-14353-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6284399B0C2
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 06:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 076951F230F5
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 04:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A6222083;
	Sat, 12 Oct 2024 04:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eRWsNrf1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2E27E76D
	for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 04:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728706469; cv=none; b=cConX9j89fOtH/E/KUpNuJve4hUJ06yUOX51OH4RVNMC/KCMa0VNXB0oGSC3yjipcsT0p7T+CVwKTAqyOQ7TB/aPtufUuNmC+TuDccmKUZ/FGARyOw+TWqx7lulmFKvEN7f2iApjta8Bo0WEDH44kpB/Kh6LBU0OarQlzWbY4T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728706469; c=relaxed/simple;
	bh=SuTMPHuKCPfjSdaSBGFmOzbjda4a5abih9KxQ1+GEnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTJU6Uko6Bc/vLM1JT1u1e+cTJGG+7dtzAjrnWXVyKNXvXQ/JWIcn62ohxsn416In6wxS1q1NHwB8mNiXdsGMybT68kChr98mFLng/OliVaTSbdsz+5y4eFBJeSn2mIkn/ygZGBsMoQ14OSTe3zPpng1WyqjNzTrbOkI/ueBP8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eRWsNrf1; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c71603217so25312175ad.3
        for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2024 21:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728706467; x=1729311267; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RJqJylDUeKhlaDFX6bqWWTyQxNxM099zR8Q/xSAgz7I=;
        b=eRWsNrf1emWuZQoNuj4A8ALElGTFmiBk3FPBwfxicVn364myMvC3qXOYTdQDlp34Vq
         o77BfUbxTQCqjjJpvp+RfL/Zpbxfgq0442uE5PEdTMH+CXeBVWMeu5TKcvtj1Z2RPk9R
         JbaW9fraV96i8KzvfA9Wlt/T8oi8KZKaMqLfJhFwBPN5qNjzqHRMN2rGyPg+eBauHQEh
         mDNwpdYPtwqtEh40YE68WgSoK1I8a61aPzCcjGTAIfWecXkj7Y6ee0tH1ZQmUfsNKVjE
         wovUQD2GpQYmCKIoj7wBxqGErRke+VoIYXCgYeyANe9gpzxSatVL+WBuOaZKgNlL13vT
         rIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728706467; x=1729311267;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJqJylDUeKhlaDFX6bqWWTyQxNxM099zR8Q/xSAgz7I=;
        b=q8EC84pMcneNS0UjSBqrUPoI0NLFJ/FRm1VdsNzwy7saLYW9E2nyMtHdlTrlqiUIhF
         j1vUwstpyn/krVAcuhonYlUxEi3DFZBp19XRkXNHf2MqFgz5CWxIoBvuWvujaqUZrWHi
         EEhzmk+mE3XvX177JjzS8VaMhuB3e29XHp52C1Glv6KRvztdiiI4YiIWFoDxU9OTmkWs
         +cEnR2wwcmc9ucFYWAtzImEeD8B+oNCl2CkEE6TMszxicc4PMoPVZYjU2HQmmFJdjL3k
         yXCZoFtBQhX11+QJC2+kb7p5YIJeS5kxASk8Dig2j1UC1QgZmf2tBPhk6VMZl88R3rpb
         9AHg==
X-Forwarded-Encrypted: i=1; AJvYcCVVJ9/PHLYHq5T5l/emOubPCJ0hs6V+0n8Bd3GSvOqJMVpm6dX3yHxg6C+cpkGYyPguY7wKZIzwBBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAFKj3YwpRZB+jPCOx2rg+2rhz07u5GuafOY8nfmPQU86sNWA+
	IJIJF14T8Qwmt66jlPEdTsFaShsncwNIz0VkXM1bp5aDjcyiRXLIWJJRrvlGnQ==
X-Google-Smtp-Source: AGHT+IG+BMnbXVlgycfAEQ8uJvs3Se6DUQ9wtZpS90iXCykE8vg47B3NvxzG9M8NmLIkK1/Q56WHaA==
X-Received: by 2002:a17:902:e5ca:b0:20c:8839:c515 with SMTP id d9443c01a7336-20ca16c5a89mr72940785ad.56.1728706467277;
        Fri, 11 Oct 2024 21:14:27 -0700 (PDT)
Received: from thinkpad ([36.255.17.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bad991csm30855765ad.55.2024.10.11.21.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 21:14:26 -0700 (PDT)
Date: Sat, 12 Oct 2024 09:44:20 +0530
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
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v6 1/8] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Document the X1E80100 QMP PCIe PHY Gen4 x8
Message-ID: <20241012041420.uwcnzmdcm6kcjho5@thinkpad>
References: <20241011104142.1181773-1-quic_qianyu@quicinc.com>
 <20241011104142.1181773-2-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241011104142.1181773-2-quic_qianyu@quicinc.com>

On Fri, Oct 11, 2024 at 03:41:35AM -0700, Qiang Yu wrote:
> PCIe 3rd instance of X1E80100 supports Gen 4 x8 which needs different
> 8 lane capable QMP PCIe PHY with hardware revision v6.30. Document Gen
> 4 x8 PHY as separate module.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml    | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> index dcf4fa55fbba..680ec3113c2b 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> @@ -41,6 +41,7 @@ properties:
>        - qcom,x1e80100-qmp-gen3x2-pcie-phy
>        - qcom,x1e80100-qmp-gen4x2-pcie-phy
>        - qcom,x1e80100-qmp-gen4x4-pcie-phy
> +      - qcom,x1e80100-qmp-gen4x8-pcie-phy
>  
>    reg:
>      minItems: 1
> @@ -172,6 +173,7 @@ allOf:
>                - qcom,sc8280xp-qmp-gen3x2-pcie-phy
>                - qcom,sc8280xp-qmp-gen3x4-pcie-phy
>                - qcom,x1e80100-qmp-gen4x4-pcie-phy
> +              - qcom,x1e80100-qmp-gen4x8-pcie-phy
>      then:
>        properties:
>          clocks:
> @@ -201,6 +203,7 @@ allOf:
>                - qcom,sm8550-qmp-gen4x2-pcie-phy
>                - qcom,sm8650-qmp-gen4x2-pcie-phy
>                - qcom,x1e80100-qmp-gen4x2-pcie-phy
> +              - qcom,x1e80100-qmp-gen4x8-pcie-phy
>      then:
>        properties:
>          resets:
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

