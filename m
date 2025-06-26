Return-Path: <linux-pci+bounces-30874-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9911AEAA94
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 01:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45EF14E4025
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 23:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01366221F39;
	Thu, 26 Jun 2025 23:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFNpmjA+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AD121CA08;
	Thu, 26 Jun 2025 23:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750980447; cv=none; b=bJp7/wylJjDfQyrNqtHx2T2DEKe1tAeVFNT6Xpe8n3M5xYDwfYuHn+s4/00CaI2I+LciD58h8rQ57lfxg9PMk+D/fEY+1qTj3UPgJINEuQC7o8dvYyWzpvHdLQZRnXj7pveKNcUhrCq5F2GhfDINrV7iGr077aiBvYXds5t79S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750980447; c=relaxed/simple;
	bh=GZeKfwcYIyYg2KRmewirfLTJlDky13ZS4q2GKR7Nsg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuI96YRZ2fA6aHXVt3PVnOjZTv5uWWOkGtYe3AwiCFOx4o28sxNJ82vsANTrE3dEZjqAFOTPnouaeCeHTDy1b360/YKw0idtZONNFhzUfrKbXzLShuc+Y3FtYMPjFTCk+Yvb3oapDwXmTLKnsM/dNDkn2VhSzBq5uXeO31lDF7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFNpmjA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28831C4CEEB;
	Thu, 26 Jun 2025 23:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750980447;
	bh=GZeKfwcYIyYg2KRmewirfLTJlDky13ZS4q2GKR7Nsg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fFNpmjA+64G/MZTnpAnPkqVrWDdMoagKyYZZ1ic8KscmIGnwnLJjFaJQt1I7OB84a
	 6LM/H8hIpoqw7EtsenAfgl7qMsp0mhTjv1BoCV6e/QWu0HKI1rv1Dvrj29dTgyfkmL
	 KVWfwD4NPCJ7WAESfk5xr3U/vTHTqFaoPLyd+M4SmEtp4kqNN7NFuRQW927dyn85XQ
	 6whnwdpJL94d9qcZ/VjlCF7oi2pcJkhcftvL1kUPfQNk595GXRO8ZcxWWtdTJO8keN
	 VtHRJYxW3hSxyXRSlIEXLegn1FflU2WYdzaa95Zh1E7wb8P4h1cVVRBY+McTdRr0vy
	 Ib2/++YtyNruA==
Date: Thu, 26 Jun 2025 16:27:26 -0700
From: Vinod Koul <vkoul@kernel.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
	mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, johan+linaro@kernel.org, kishon@kernel.org,
	neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v7 1/5] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Update pcie phy bindings for qcs8300
Message-ID: <aF3XXpEwTcp3JnPt@vaman>
References: <20250625092539.762075-1-quic_ziyuzhan@quicinc.com>
 <20250625092539.762075-2-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625092539.762075-2-quic_ziyuzhan@quicinc.com>

On 25-06-25, 17:25, Ziyue Zhang wrote:
> The gcc_aux_clk is not required by the PCIe PHY on qcs8300 and is not
> specified in the device tree node. Hence, move the qcs8300 phy
> compatibility entry into the list of PHYs that require six clocks.
> 
> As no compatible need the entry which require seven clocks, delete it.

This fails for me on phy/next, can you please rebase
> 
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> index 57b16444eb0e..10c03831f9e7 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> @@ -175,6 +175,7 @@ allOf:
>            contains:
>              enum:
>                - qcom,qcs615-qmp-gen3x1-pcie-phy
> +              - qcom,qcs8300-qmp-gen4x2-pcie-phy
>                - qcom,sa8775p-qmp-gen4x2-pcie-phy
>                - qcom,sa8775p-qmp-gen4x4-pcie-phy
>                - qcom,sc8280xp-qmp-gen3x1-pcie-phy
> @@ -192,19 +193,6 @@ allOf:
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

-- 
~Vinod

