Return-Path: <linux-pci+bounces-30904-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F30FAEB2D7
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 11:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88E961885D2E
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 09:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FE2293C5B;
	Fri, 27 Jun 2025 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEQnAo8m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21822271464;
	Fri, 27 Jun 2025 09:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751016431; cv=none; b=cpkVUg9W/SKmhPu7bT1SAPb81yBhR8njfVyBDoRflX/bFB6R5FaV0w2iBBGOGl31NZOUmwfbvrm0eqYKEeaESWqp19ccnqYvpIMwmSCyepr59nulZ6lxTeiCpSRre3QCl0R8Bu+lXsXxNLRiZOL3G7mAGG2rxQLQpXoCcybeX+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751016431; c=relaxed/simple;
	bh=9Ao2DPZ5WH1AH59KqUG8CMXG1VAzP6Js/sjGtfxOmd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQzn6VE2j2pNpDLYQjd/xM4EMhKqqSI/1GlE9kupdrb7jlBF3lUe8h3wvNSJuxNlVR/xDbeXwRjVKUzwuyvLPfCk/Zg6LzX7Mw+tzm7pgkZQ8sNdIwCXSkPxqH9jY6pMQXoibhA71FkvSRWqN2irwe/QO9KFiTx8EBsJJk8uMQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEQnAo8m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D9CC4CEE3;
	Fri, 27 Jun 2025 09:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751016429;
	bh=9Ao2DPZ5WH1AH59KqUG8CMXG1VAzP6Js/sjGtfxOmd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bEQnAo8m0otz0/uF05lagMkPplo1RIXinU9bo4tRu9ozLnBLODPx7vvqdk5/1kGaH
	 9+ucSrGzQq7iGQnzk3TN+bz11fA9bf7BZAOu7xXhKOV5kbid4aJ/F44DOXe5BrwYMw
	 7EKt7oeVPFwbfWZ33WL7mNurS3D2Y/5liaoKkdGL8PqMAbctzDZgS3jzUX9gufikgj
	 IM8jZsMe9fJQyUpHjpzmDQmld/iOFkUaTvIu5zEaZZZ83M373//1xo0AkDNu5iLcSX
	 p4lVM3IbKVH91aedgRJUdeCquqNaBioSIqjprjpWUSmslbv/qxWAcVgcppG/fjxQEC
	 C3Gq1HBQPaHXw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uV5MT-000000000BF-2wGi;
	Fri, 27 Jun 2025 11:27:09 +0200
Date: Fri, 27 Jun 2025 11:27:09 +0200
From: Johan Hovold <johan@kernel.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
	mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
	kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
	kw@linux.com, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	qiang.yu@oss.qualcomm.com, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com
Subject: Re: [PATCH v3 1/4] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Update pcie phy bindings
Message-ID: <aF5j7VqX5oU11cWe@hovoldconsulting.com>
References: <20250625090048.624399-1-quic_ziyuzhan@quicinc.com>
 <20250625090048.624399-2-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625090048.624399-2-quic_ziyuzhan@quicinc.com>

On Wed, Jun 25, 2025 at 05:00:45PM +0800, Ziyue Zhang wrote:
> The gcc_aux_clk is required by the PCIe controller but not by the PCIe
> PHY. In PCIe PHY, the source of aux_clk used in low-power mode should
> be gcc_phy_aux_clk. Hence, remove gcc_aux_clk and replace it with
> gcc_phy_aux_clk.
> 
> Removed the phy_aux clock from the PCIe PHY binding as it is no longer
> used by any instance.

Please add the Fixes tags I mentioned earlier which identifies the
commits that added the bogus clock.

> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---
>  .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml           | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> index 2c6c9296e4c0..57b16444eb0e 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> @@ -54,7 +54,7 @@ properties:
>  
>    clocks:
>      minItems: 5
> -    maxItems: 7
> +    maxItems: 6

You remove the last user of the bogus clock (qcs8300) in a separate
series so you should keep it until then.

>    clock-names:
>      minItems: 5
> @@ -65,7 +65,6 @@ properties:
>        - enum: [rchng, refgen]
>        - const: pipe
>        - const: pipediv2
> -      - const: phy_aux
>  
>    power-domains:
>      maxItems: 1
> @@ -176,6 +175,8 @@ allOf:
>            contains:
>              enum:
>                - qcom,qcs615-qmp-gen3x1-pcie-phy
> +              - qcom,sa8775p-qmp-gen4x2-pcie-phy
> +              - qcom,sa8775p-qmp-gen4x4-pcie-phy
>                - qcom,sc8280xp-qmp-gen3x1-pcie-phy
>                - qcom,sc8280xp-qmp-gen3x2-pcie-phy
>                - qcom,sc8280xp-qmp-gen3x4-pcie-phy
> @@ -197,8 +198,6 @@ allOf:
>            contains:
>              enum:
>                - qcom,qcs8300-qmp-gen4x2-pcie-phy

                   ^

> -              - qcom,sa8775p-qmp-gen4x2-pcie-phy
> -              - qcom,sa8775p-qmp-gen4x4-pcie-phy

Johan

