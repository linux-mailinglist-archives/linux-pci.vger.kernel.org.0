Return-Path: <linux-pci+bounces-20115-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F6BA161A5
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 13:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C57D81885EA7
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 12:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6A71990C4;
	Sun, 19 Jan 2025 12:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FAM9M0Ad"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ADA19D07A
	for <linux-pci@vger.kernel.org>; Sun, 19 Jan 2025 12:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737289916; cv=none; b=ArrAPzuKKpLyHwhygtiGYPVEUejOyLIVhceNX3cLWeby9HGv8Ut37O5xPmylUubl2UiAzK+z+mGEDnFm5HIl/VR8rq4TiqNHt2LA1BkJocz3t+M3rE5H7W4AHaXIsv7FlDO/SVHc5vB+RqMo0cpG6aQH4cC0kuvH2lxCc2xuH8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737289916; c=relaxed/simple;
	bh=b8I3+yxb+holxrODNel2OCMwStoOQEV9Nsh5TTlNYJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5yPJtj0ExQvUlw2q4Mwmiun1wkJnnxnGNWpU+Ck+KaOlH74gJEIdvTuJqdlQStZ0b6G+H8795oLW5KDJ+L4ao9naC1Pf0fGUCyePYJeMUOmOk5BZpEK4NV90JCCarfIDkAgVNarKJOt7kmcn8cAfCZ4LL+SdLb5YDqaxxT1fqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FAM9M0Ad; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21669fd5c7cso63516735ad.3
        for <linux-pci@vger.kernel.org>; Sun, 19 Jan 2025 04:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737289910; x=1737894710; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TXDDGdiqxvAdCVCeKQbgEvCD/6x4huy3wzcrmw4YbuM=;
        b=FAM9M0AdVovvHoWh7qe5bghrtqOM9E7EGLMhddrF/HtKyUnb0MBtXu4Dmq2i2fm04q
         Ta2PB3mr/SAlTR0kZDYHS+JEC6MlOr/uQlg4mo713E9c9lvw+lX2A/cCalQt/DJ9smBD
         yvTNMYxZxN5e/GfC7URUxjJ3c8Ujy3s2H2siKSyt9+/go48CQz7a4IkRaTUFoF6TFHy0
         a5QFTU64wtZALtgBdviwjpRYb2vCNMgrjT0hT+hgqEHxyCN4KX09ck4SBAFCPQdXL3bg
         zAiha1bpKd+PjKU+7+ECqBXEKv295JKNAPvC9Z0vfbU9vj1yslgfWY8jDr2YmeGtSOcH
         dPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737289910; x=1737894710;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TXDDGdiqxvAdCVCeKQbgEvCD/6x4huy3wzcrmw4YbuM=;
        b=Ya47svHSOV1SoCHuyUjiBEENG0LJ3rZQaNbYi/NaQF2T3nQ0ARmR9E65nY9L5LG8FF
         CJQAszefq4X+lr7GKpzCtNp79ZMJ1U6HUw7FPQYeOlt1aA5UVJ/mBTJUHSPNWLm2yYYR
         8uTSkXIIRZqk6xGRCHvuvKHsJAIe/Sp2ze5EQzfXbqnH8S84H4i1oUQjsU3Qsxc+VVzP
         lt3nOeSXfaPBFS/QwQyVV+feZSwZQ+HM2AL7kUQrLqorVr9XChOc6L3BMOuZSxWGEIAB
         R06cNqiC+mwFDatZcFEOACR5wZxktPj4+ahUbuEAWpNG9AUdlEIigra4k++fwvX58sxt
         5q2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXK4K1r8sZPrnyDIwA2fLAyz8/V7eUF6vbK7ynL3YEyzolRid/Pga57Et3+/+NRhlPIf03jGu1KQ5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1T81E2jxPhx3p/Jq9SOyBJhihy2a0lo8SwcfqJCbBGFckJZsp
	V+gzlkZ5WZ0diW3HmnaCMHLxkcox3M0ESPOLGheE43xKlLA6Fu6lT63nbh7KVw==
X-Gm-Gg: ASbGnctnNMEv8mPq8fxystxGGofFC3UjZSrdJv+zddcYWmDpfh0/vIZ4fMmmP7WDtH0
	Kaxj34v3wr3cAqV3tFnY+n8Mpz/1JTBZbkUjVuCQx3YNvG3cQQ0t1Rrha8dJcxGPbc2b3Z0hMAk
	Z4qzS8jX8BBHSS89QIDtgT6e5il8c7KoXGZQKZQXG8ptDrFSWcLJCOwulf4gM5cZHmYwyLSEvFg
	47Xa0WwNR4IRvzT6f7jpkQ7XiC02qdgYUaTol1H0JJ7B1j3GYts2e0SLpKiRVTm1cuQowALGgob
	jI4sgQ==
X-Google-Smtp-Source: AGHT+IESj9hipVsk75yPanv+gXMBaSyDflVAD0+JtKGBpZQwquLiubg2YgW1L86GqvarrBofrNmP9A==
X-Received: by 2002:a17:902:e952:b0:216:760c:3879 with SMTP id d9443c01a7336-21c355f03cfmr136590925ad.46.1737289910652;
        Sun, 19 Jan 2025 04:31:50 -0800 (PST)
Received: from thinkpad ([120.56.195.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2ceb9d97sm43621115ad.95.2025.01.19.04.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 04:31:50 -0800 (PST)
Date: Sun, 19 Jan 2025 18:01:45 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_srichara@quicinc.com, quic_varada@quicinc.com
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: qcom: Document the IPQ5424 PCIe
 controller
Message-ID: <20250119123145.qzpv65gifayyve66@thinkpad>
References: <20250115064747.3302912-1-quic_mmanikan@quicinc.com>
 <20250115064747.3302912-2-quic_mmanikan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250115064747.3302912-2-quic_mmanikan@quicinc.com>

On Wed, Jan 15, 2025 at 12:17:45PM +0530, Manikanta Mylavarapu wrote:
> Document the PCIe controller on the IPQ5424 platform using the
> IPQ9574 bindings as a fallback, since the PCIe on the IPQ5424
> is similar to IPQ9574.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> Changes in V2:
> 	- Pick up R-b tag 
> 
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index bd87f6b49d68..7235d6554cfb 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -31,6 +31,10 @@ properties:
>            - qcom,pcie-qcs404
>            - qcom,pcie-sdm845
>            - qcom,pcie-sdx55
> +      - items:
> +          - enum:
> +              - qcom,pcie-ipq5424
> +          - const: qcom,pcie-ipq9574
>        - items:
>            - const: qcom,pcie-msm8998
>            - const: qcom,pcie-msm8996
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

