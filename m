Return-Path: <linux-pci+bounces-20662-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC19EA25FAD
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 17:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC4B07A12DF
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 16:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B93D20A5FE;
	Mon,  3 Feb 2025 16:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BoHQLHD8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7573209F59
	for <linux-pci@vger.kernel.org>; Mon,  3 Feb 2025 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738599412; cv=none; b=pkHrLtdJy1hufS+C/CZ5tjdhCqgr7Q8JhyWsi1pX0wbrHxt/FjDjDdcgf979yvCpuLx37xkCeBCVk5voOHf6YsML1bhW0c5yhPyjy7HsxmiD62SO/zWdCoc4NeUMyjWsZFA3bRgQucRB4Kz+onCv7m2V8cVFIVK4gJGxmmAqqww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738599412; c=relaxed/simple;
	bh=erhTwVPsLXivFVXTanoN6EQD7Qcx9B1QNR5p4w1Yt44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e20L5mqM/rhCwoK1lRZ2KKkAcGPmPBT4Pj4ZIOiQyNlzdzNRlXukJkdNxFbSyl3KKSsCtDB09E8BboNhNtTraRuyAyfGUW3+hdvA3lfE97Z8oZSGacP/ePhy5usnRx31fE2P0ZpXh6HpTlSZhl5b3iY7R5R5c4tU6m9a9yNJckw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BoHQLHD8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21c2f1b610dso106077975ad.0
        for <linux-pci@vger.kernel.org>; Mon, 03 Feb 2025 08:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738599410; x=1739204210; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6flYFTaf2FZxbVF3ZCOxc2I7HjIzsuP1MXEjy7hroyk=;
        b=BoHQLHD83QOQu+7YB5jQPWX/hL19er1lQJt0rbfOdPzGLItwYAu1qUrk9ay8H0EfmL
         q0m7xMGH80Za4m8M5zgZlE4BA8vHUHfLF2q6QKoL/SAYmK/uextByv5PIeIMakUrLM/f
         x6SgxzTW3Bw4ovSTctyz+a4/tkoNBAlpKLEBiPNpZhfu2FNU24oePZFXKjYf1sUUkVZ3
         lL6Grj30pm/oxPxA5VGoo68IC08OAkiw3MxV4OCXinSidMeQpb/sosBMPPx1l/+hrruc
         8h1E1+nlUwq0NcEKobuWCm7s7te4KfM7Q+ZnB2uvoIq5FGS+2DH0NlTQtLpZly2OY+JI
         Ivhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738599410; x=1739204210;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6flYFTaf2FZxbVF3ZCOxc2I7HjIzsuP1MXEjy7hroyk=;
        b=Xx+9hAahHuaCeKfQYPPhM5Dc1b3ysL15k6rDU0e4QFTPyJRPLL8+6rGua154Ws6WIr
         HPVxFaqm7HpB8/CyOOpEz6B1FEOD7LGSMJEThNMXyq1kwK0Y+FqI/7l4pDCD1gLzKpWG
         YxVn3R1jz5tsJWhy58g8bnFyh4//Js4n3TJFNngMivxqzXXoEq0pFNY/+V0VSBPFQO6C
         ANbsnXdGQL2eeWRQqjr0uibIUiwUrB9Cp01MtCEyGHNCHRUHxgg6pqEMIqE6ttYvakxs
         YEP8ZFO/KBR7r84YzuZLkYyegkH3dAtQ+/MeWsfZuMzR1VhgqI690rVgwVJJaZreGrUi
         LbZw==
X-Forwarded-Encrypted: i=1; AJvYcCWCso0+h/763ADNw6R666apVFi5qK2ZWFk8D0AD7i+sMeNLNM/hOk4GS3L3QlKMCnMrXp0cJT08PLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwr0xjs7zNhPxjjRPBp/iXVM55ZYihg22XIfq0vVYWuQG/lPTo
	MN6LgnEFpVmVM3P1PEx4CynUuQWMaWCgJ9PAZns0M3xYaGo0WRNTAHvt48GlXw==
X-Gm-Gg: ASbGnctOLERq0lQpjlDy2xYqidwwRf2Zo7q7WE8amI7SgLZkYVXn82K4j228LV0Nxq8
	IxRO/Z6PmkV/HNyizib0fkrC1og9XxTkEIUocY4SObS681EAWTbqrBVm20084tFy1rhkmVf9LR/
	rDihAQj1bYoyUR1sqKlArMYQNalgQ0ZXLV5pajyKWOtA+duCm/4LPjnLvMOBAPkPJH9mhKqil/1
	9yfA6oWGmNO7lMYhxxnhR3Dnrzt4WoglZ6iGFnnTmzJ5XIc48KDQptstAnTFWPX4raO3PDaon/+
	mx0XVx7zLubZc4ipaexiZ6sMOw==
X-Google-Smtp-Source: AGHT+IFVZMlh6cYlSlFoHEwxzXAOuYn28wRS6kTbfChhspc03x0TeQyb4e1aNIvAKSJnT3jHJ38A8A==
X-Received: by 2002:a17:902:d48a:b0:216:4064:53ad with SMTP id d9443c01a7336-21dd7de20f8mr385506735ad.48.1738599410161;
        Mon, 03 Feb 2025 08:16:50 -0800 (PST)
Received: from thinkpad ([120.60.129.34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acec0479887sm8145679a12.52.2025.02.03.08.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 08:16:49 -0800 (PST)
Date: Mon, 3 Feb 2025 21:46:43 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, p.zabel@pengutronix.de,
	dmitry.baryshkov@linaro.org, quic_nsekar@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org
Subject: Re: [PATCH v7 3/7] dt-bindings: PCI: qcom: Use sdx55 reg description
 for ipq9574
Message-ID: <20250203161643.n2dmu6yg6rb5lp6u@thinkpad>
References: <20250122063411.3503097-1-quic_varada@quicinc.com>
 <20250122063411.3503097-4-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250122063411.3503097-4-quic_varada@quicinc.com>

On Wed, Jan 22, 2025 at 12:04:07PM +0530, Varadarajan Narayanan wrote:
> All DT entries except "reg" is similar between ipq5332 and
> ipq9574. ipq9574 has 5 registers while ipq5332 has 6. MHI is the
> additional (i.e. sixth entry). Since this matches with the
> sdx55's "reg" definition which allows for 5 or 6 registers,
> combine ipq9574 with sdx55.
> 
> This change is to prepare ipq9574 to be used as ipq5332's
> fallback compatible.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index bd87f6b49d68..413c6b76c26c 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -165,7 +165,6 @@ allOf:
>              enum:
>                - qcom,pcie-ipq6018
>                - qcom,pcie-ipq8074-gen3
> -              - qcom,pcie-ipq9574
>      then:
>        properties:
>          reg:
> @@ -206,6 +205,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - qcom,pcie-ipq9574
>                - qcom,pcie-sdx55
>      then:
>        properties:
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

