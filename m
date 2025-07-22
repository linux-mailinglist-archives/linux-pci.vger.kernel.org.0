Return-Path: <linux-pci+bounces-32727-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD9BB0DA14
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 14:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C0D1547112
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 12:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2762DEA88;
	Tue, 22 Jul 2025 12:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDEg+MM6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07191288528;
	Tue, 22 Jul 2025 12:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753188519; cv=none; b=aAcbgAqlWL4PbKt4Tke3u0GWga5Eap9q9O3JwD5jVfhYxs8VHTNLt7J57NpS4eh+3crL8+9txvFDfc7Of0wn/W4NSs4X8fttPcxOO06QECJlI2vc4mo06J2uPzZ2AQMFG4NVS1lbUsisVyUZBUccPGpvoccWnu8aMhfAs0Uv2Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753188519; c=relaxed/simple;
	bh=Ywpj9KtSP+ovMY56xhAFq1DkwH1i/O2u+uNgff666K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9ZDrCvlsf3UftuYYSnnxJDAYHq2C3ap6rn0SindRcgjxQcnz1JK5KyddHvpT6W8J2/lYu7ZvhXC5CKTcstnBYNnacoSYz7Pg83hMb+T+nqM6HH0nv1dND9uVPRQG2OlbphgobSsa7+Y019RQp6V1y9nwVT8X1L6ys670ZXjCLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDEg+MM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BA3C4CEEB;
	Tue, 22 Jul 2025 12:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753188518;
	bh=Ywpj9KtSP+ovMY56xhAFq1DkwH1i/O2u+uNgff666K0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SDEg+MM6VDeLUdKeW5uBLBWR3OtMYDKzWlV9uvXMvgYTLpA0NAAwGHD+kDPZE+6eJ
	 nDH04FbpKs6PRBNHnlJYvJ9N9bXO/GJ4esbXgXaN2fB25rxNblCuQgPau4cinVAjxS
	 aPmjAj7z71rtPlQSRp2UUpXzeFF1ZeiJb2vjlIBM5GfiXhR+xCW9ZtLY+VTkmw/XxQ
	 b0gczj+ZscvHmmRv8FnixTLCEobQKZm/aR3Okeg9jzu85jfXQ2f0Q7grKTAP4KnXiI
	 pf8qOr0vIT9haHAil3ZbV3VYFYsDKMPUkgTIaflPVUTagbCo4bqAe0d0itbZYa3bUg
	 yZjVx51MzoW0w==
Date: Tue, 22 Jul 2025 18:18:34 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
	mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, johan+linaro@kernel.org, kishon@kernel.org,
	neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v8 1/5] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Update pcie phy bindings for qcs8300
Message-ID: <aH-Ioi5WO6gA_7WY@vaman>
References: <20250714081529.3847385-1-ziyue.zhang@oss.qualcomm.com>
 <20250714081529.3847385-2-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714081529.3847385-2-ziyue.zhang@oss.qualcomm.com>

On 14-07-25, 16:15, Ziyue Zhang wrote:
> The gcc_aux_clk is not required by the PCIe PHY on qcs8300 and is not
> specified in the device tree node. Hence, move the qcs8300 phy
> compatibility entry into the list of PHYs that require six clocks.
> 
> Fixes: e46e59b77a9e ("dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the QCS8300 QMP PCIe PHY Gen4 x2")
> Fixes: Fixes: fd2d4e4c1986 ("dt-bindings: phy: qcom,qmp: Add sa8775p QMP PCIe PHY")

Pls fix the two 'Fixes'

Please run checkpatch, that would catch these

Also this needs rebase on phy/next

> 
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml     | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> index 2c6c9296e4c0..1d4815056bc2 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> @@ -176,6 +176,7 @@ allOf:
>            contains:
>              enum:
>                - qcom,qcs615-qmp-gen3x1-pcie-phy
> +              - qcom,qcs8300-qmp-gen4x2-pcie-phy
>                - qcom,sc8280xp-qmp-gen3x1-pcie-phy
>                - qcom,sc8280xp-qmp-gen3x2-pcie-phy
>                - qcom,sc8280xp-qmp-gen3x4-pcie-phy
> @@ -196,7 +197,6 @@ allOf:
>          compatible:
>            contains:
>              enum:
> -              - qcom,qcs8300-qmp-gen4x2-pcie-phy
>                - qcom,sa8775p-qmp-gen4x2-pcie-phy
>                - qcom,sa8775p-qmp-gen4x4-pcie-phy
>      then:
> -- 
> 2.34.1

-- 
~Vinod

