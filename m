Return-Path: <linux-pci+bounces-40575-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46685C3FC61
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 12:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05C3E3BA287
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 11:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE742836B1;
	Fri,  7 Nov 2025 11:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tf2n5etW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6B11DA55;
	Fri,  7 Nov 2025 11:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762515934; cv=none; b=f9XFRjZKb5Y4PtXPhN0jXIWR9PoqJN58DTqBTUj+3tQ4FFgdVVnKI4nPc3aR79CthIPlYmySVHV3/u8ugT0B2lncrw96Sn8KdBp4cwYTQQUngJ7YgBA8tVLc2ZrEUtDHQvix0ybWk8+DtOdaKLIy8/P6ik86KJTsh5D8HhuiCCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762515934; c=relaxed/simple;
	bh=izDt0p7345JaRE7QPi4vAH1RGCVddKUk9lJ7ECKLP2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0g2c64Y11xqnXQUw3LiVpI+QvNcb+zqSb+q/NB52meLCfbN8ML0jjw50PwwlBmxfbU6PAfS5zGVCPukOsBJiR/NrigB0C2kCOLYO4VPmNLKwTtBZN47+QGxD2XQyRLS+AjKz+00Rydxflh7wfKo5fL1MtyDOgJgwhHwiPNRvmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tf2n5etW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0458BC116B1;
	Fri,  7 Nov 2025 11:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762515934;
	bh=izDt0p7345JaRE7QPi4vAH1RGCVddKUk9lJ7ECKLP2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tf2n5etWb7ZB0uyhL9KX1WJMrI8iz3X4UloiD5SaZevZEsHmX7vZvHJQq/7lFiOMs
	 LZ4x0F1xojYcPEztReGlpQ+Ann+bdqm2sZ/i1gsKyDRMuPRgEb6Q27o4t6OidiE15C
	 7DJpoN9uMT9pUhPOgYtrzFul37DZ2eonLqS9tjUKp0x+T4p3eQtb6o8fGUwJKGVQFE
	 vGByKDBpHCaPlM4vgtADSGOjrkhjoim/kNMU6XzVcwgO1a7a+OUcJeifNDK9jg5MXy
	 wAW/viwcwEIeKFa7DzJa9fnSGuVrq/wCwqZyJCllt1rs/MT+i1jqsosqlAU1Uce4+e
	 RuYY0XlZnWWbQ==
Date: Fri, 7 Nov 2025 17:15:14 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org, 
	kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com, 
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v14 1/5] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Update pcie phy bindings for qcs8300
Message-ID: <q3naavmyhk3ksvrtdvt7jmfwfvf666souckek356tfp3olqsxl@t65dsp5hxoeu>
References: <20251024095609.48096-1-ziyue.zhang@oss.qualcomm.com>
 <20251024095609.48096-2-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251024095609.48096-2-ziyue.zhang@oss.qualcomm.com>

On Fri, Oct 24, 2025 at 05:56:05PM +0800, Ziyue Zhang wrote:
> The gcc_aux_clk is not required by the PCIe PHY on qcs8300 and is not
> specified in the device tree node. Hence, move the qcs8300 phy
> compatibility entry into the list of PHYs that require six clocks.
> 
> Removed the phy_aux clock from the PCIe PHY binding as it is no longer
> used by any instance.
> 
> Fixes: e46e59b77a9e ("dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the QCS8300 QMP PCIe PHY Gen4 x2")
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml         | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> index 119b4ff36dbd..d94d08752cec 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> @@ -55,7 +55,7 @@ properties:
>  
>    clocks:
>      minItems: 5
> -    maxItems: 7
> +    maxItems: 6
>  
>    clock-names:
>      minItems: 5
> @@ -66,7 +66,6 @@ properties:
>        - enum: [rchng, refgen]
>        - const: pipe
>        - const: pipediv2
> -      - const: phy_aux
>  
>    power-domains:
>      maxItems: 1
> @@ -178,6 +177,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - qcom,qcs8300-qmp-gen4x2-pcie-phy
>                - qcom,sa8775p-qmp-gen4x2-pcie-phy
>                - qcom,sa8775p-qmp-gen4x4-pcie-phy
>                - qcom,sc8280xp-qmp-gen3x1-pcie-phy
> @@ -195,19 +195,6 @@ allOf:
>          clock-names:
>            minItems: 6
>  
> -  - if:
> -      properties:
> -        compatible:
> -          contains:
> -            enum:
> -              - qcom,qcs8300-qmp-gen4x2-pcie-phy
> -    then:
> -      properties:
> -        clocks:
> -          minItems: 7
> -        clock-names:
> -          minItems: 7
> -
>    - if:
>        properties:
>          compatible:
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

