Return-Path: <linux-pci+bounces-17732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CF99E518E
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 10:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1609B281C2B
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 09:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8D71D5176;
	Thu,  5 Dec 2024 09:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEywny6v"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCD318FC70;
	Thu,  5 Dec 2024 09:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391655; cv=none; b=tY6TTKgxQlUJ5vcAGSPP7YGgo2zGW9aNUPtGGSnJJiNJGJKdxmvpAx833/sPz3XosLMKTBMeb0tNe2wA0Jj1HQDiu6iGUb1YtiyqJh0KpZsSyUgK5yyJeYUhvNIU5kH2x6t59h/o6S8Vc70r5JOcMo7AzA4Vw1If3BJotMaMROY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391655; c=relaxed/simple;
	bh=5ROpg4tyy9Zr0FNDj5tkTa7O3Ob1JCqoHg4b4OHAoKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ak0/b72p3rPDMcMUR06X6ujNCPiRyZ+X0oTY4xTHOn0Nnrt7/1Yu7lyPtnVGtfgma3MAloF1Lf5zUyPz6PMKMiP9QFRqy9j7JZ6LhkhIxVSP7qnK7fY2ckpjdaqXCW74GHBAYJJvxerlNsZCe/gFqndq9hG8hcv+1nW9cfd9NmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEywny6v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031DCC4CED6;
	Thu,  5 Dec 2024 09:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733391654;
	bh=5ROpg4tyy9Zr0FNDj5tkTa7O3Ob1JCqoHg4b4OHAoKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HEywny6vCtZ6O1yZ4OB5Q4IVM5/WAOz7K5EkjdMhzMQx+gojGyCEgks+w+tYxQ9K4
	 1q4JfnW//05XU3N+gYiYckdpxisa96txECEuQXgA96a55lv0QEyqdeZrE3eHui/Rbl
	 Zv0SfxxayRKEcjKS/C+wMK8GKNMTxf6TIgZHI/8W1XdfkDw05DQjfFO5t+lzZhYVNU
	 t8inZMOZDP1wzkY75Lxv0b4rCQi6x4vMcPkKiLKNQdvksZx7yTMwoQ0Zj5S8Tx40BF
	 amJMJX/YA/RiTQaeAAgtALig+wDHF2EoZ+7Sh6hKYOT9Y5tKt/XpBHsi0ZEcb64OUs
	 fWse9Xj0hNSog==
Date: Thu, 5 Dec 2024 10:40:52 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	p.zabel@pengutronix.de, quic_nsekar@quicinc.com, dmitry.baryshkov@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	Praveenkumar I <quic_ipkumar@quicinc.com>
Subject: Re: [PATCH v2 3/6] dt-bindings: PCI: qcom: Add IPQ5332 SoC
Message-ID: <zgu3ygylkuayheq5lampite7dpli2sxsbgaa2cgwcshmm2sax4@6uprsoldacof>
References: <20241204113329.3195627-1-quic_varada@quicinc.com>
 <20241204113329.3195627-4-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241204113329.3195627-4-quic_varada@quicinc.com>

On Wed, Dec 04, 2024 at 05:03:26PM +0530, Varadarajan Narayanan wrote:
> From: Praveenkumar I <quic_ipkumar@quicinc.com>
> 
> Add support for the PCIe controller on the Qualcomm
> IPQ5332 SoC to the bindings.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v2: Use ipq9574 clock & reset details instead of a new one for ipq5332
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index bd87f6b49d68..a7c5d0ce7de8 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -21,6 +21,7 @@ properties:
>            - qcom,pcie-apq8064
>            - qcom,pcie-apq8084
>            - qcom,pcie-ipq4019
> +          - qcom,pcie-ipq5332

Looks like qcom,pcie-ipq6018 to me. Don't grow ID table in your driver
needlessly, but use proper fallbacks.

Best regards,
Krzysztof


