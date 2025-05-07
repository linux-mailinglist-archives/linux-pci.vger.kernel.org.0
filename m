Return-Path: <linux-pci+bounces-27321-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C008EAAD4DC
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 07:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23781B68310
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 05:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35211DED54;
	Wed,  7 May 2025 05:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1fDJt9K"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7162A1DE3A7;
	Wed,  7 May 2025 05:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746594641; cv=none; b=EVHW+5UdrQax4WodrY59fI0H25Wy9dYaTGRYgydg414TpmHgjAfjZeY23Onw81ksdva4BOeXTLSnLFisr2f5RTZSZHnahixxx9mnNrn95IduS8mTXVyzkra1BB83n23TRFrubOcZ8fpkZ0htCUDYmMQGpF+Rr1UVbvAE3iVTaM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746594641; c=relaxed/simple;
	bh=5odRdJ07Ml5qMHbEG+4H2PSjFC+LdSsdnp8qj5VA8iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Whlqs0SGtxcyy3RLG9VfZczfYv4pahMM5jCRqxNxqwvjq9iFBFcmTzi/EV+rrvdS1LKZuCEbM7svBfjxW/R9oE+97mX2CcwA7QZ/GnAWHchjBdFxLtOpuZsyfwnsNt1e4Q6DaASK3R9aPBuXxmRcgX9rvn2b6piFZ3j93IhoqIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1fDJt9K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DDDC4CEE7;
	Wed,  7 May 2025 05:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746594641;
	bh=5odRdJ07Ml5qMHbEG+4H2PSjFC+LdSsdnp8qj5VA8iM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s1fDJt9KXmnMjjA3kCrhLyAbyBiLxxPl2n1Dk1pYjTwCBi7uJcP6a9g0UzWmF50Je
	 XLMHY0z/uABoi8qi4t/cjCEGgs77oaZrx5sbpYa5EfPq4hxoKpTCaP5Fj2aW8dP11Q
	 O4rek0pVViM+UpbRYX2KmCrlkKivmOsfb59K8mB92Tmtnxrxxz+L6Im54FdjOp1K0g
	 eF2C1aSyt+7mGoC9SiebPCiO9dJGcjimJxkXyJyxV1VWo+C1u00ehI2z2q6Gr8Sspb
	 yJQXIY8M6zTwOrzwhTjuVdyQoiyxQ0MO9psmC+yPu7jje/hInKfQGG+nS4aiX+z5xz
	 Z8ThWFBWNAGIw==
Date: Wed, 7 May 2025 07:10:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, dmitry.baryshkov@linaro.org, 
	neil.armstrong@linaro.org, abel.vesa@linaro.org, manivannan.sadhasivam@linaro.org, 
	lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com, andersson@kernel.org, 
	konradybcio@kernel.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	quic_qianyu@quicinc.com, quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v5 2/6] dt-bindings: PCI: qcom,pcie-sa8775p: document
 qcs8300
Message-ID: <20250507-quixotic-handsome-wallaby-4560e3@kuoka>
References: <20250507031019.4080541-1-quic_ziyuzhan@quicinc.com>
 <20250507031019.4080541-3-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250507031019.4080541-3-quic_ziyuzhan@quicinc.com>

On Wed, May 07, 2025 at 11:10:15AM GMT, Ziyue Zhang wrote:
> Add compatible for qcs8300 platform, with sa8775p as the fallback.
> 
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---
>  .../bindings/pci/qcom,pcie-sa8775p.yaml       | 26 ++++++++++++++-----
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
> index efde49d1bef8..154bb60be402 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
> @@ -16,7 +16,12 @@ description:
>  
>  properties:
>    compatible:
> -    const: qcom,pcie-sa8775p
> +    oneOf:
> +      - const: qcom,pcie-sa8775p
> +      - items:
> +          - enum:
> +              - qcom,pcie-qcs8300
> +          - const: qcom,pcie-sa8775p
>  
>    reg:
>      minItems: 6
> @@ -45,7 +50,7 @@ properties:
>  
>    interrupts:
>      minItems: 8
> -    maxItems: 8
> +    maxItems: 9

I don't understand why this is flexible for sa8775p. I assume this
wasn't tested or finished, just like your previous patch suggested.

Please send complete bindings once you finish them or explain what
exactly changed in the meantime.

Best regards,
Krzysztof


