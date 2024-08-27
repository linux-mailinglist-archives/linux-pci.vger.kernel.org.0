Return-Path: <linux-pci+bounces-12268-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD009608D6
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 13:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7F911F239C6
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 11:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD1819FA7A;
	Tue, 27 Aug 2024 11:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7vwb1MM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28029139580;
	Tue, 27 Aug 2024 11:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724758595; cv=none; b=EVquZUUTRjaOJEVRB6IVXchYWG8On+9FnTEA/uGD3L1hkAbW7o/ZTkh5ZARZEnUIb1e4B95WcvUZ3cQ4IhStKTSZb3Xu0PegCZ8Rfhz0ztMjtCUkaqczZNmez0WQVIn7jI0gQ7ofq2Auu8FY+yfD0o9Sd9gb+b1JXc6NjEuGzak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724758595; c=relaxed/simple;
	bh=UcW3FlwqzuyJC9hCJ1ksNC75o+2Abm/hr0EArMLVnD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A27E7zLlYU7sUTO6wf9TA7vM5GuxUPC2zgx+vOSMTaBvz9tbXTallfRJqYfDElz5Khtzt9CzbL+CXWY7F3oMdlbgPpKxpJ6Z4NPQ/1dE4X3LrvFQtYJXedOredaKOFSUIRdiM9l0lTMRHExEasOsqjyE03Z9qFg8RO2wiB2F8G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7vwb1MM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE09FC4FF6D;
	Tue, 27 Aug 2024 11:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724758594;
	bh=UcW3FlwqzuyJC9hCJ1ksNC75o+2Abm/hr0EArMLVnD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u7vwb1MMrQL1AC5qXHbki5GkSPFBcZxhTD/qXN7Is7Ck+79QFUzmvB8EmwEjnKB11
	 J0bnPk5haVavHQaqxta0wkp0As1SYqmiahukScVyh75RL6P92Kk5Lt801TeYqd5t0f
	 RSFNvqAmSXybFLkcIyUz21Ax6ZrKOnsolRf8yo6JD7AUsj29RnIcDQwrddkQf8NlxR
	 fn5ViQ7ntWiynZbWCR7f9yPJSmETgD2NMI6mtodjWGZpqRXuxhEXRu8eAk8KuU685l
	 k+/Xf3PGHPcQIovoE4G4324FEkigDbr6R3JNQVGQMYJugMm1Ukn3Itv0s9RGQnNnQ6
	 NwOmBnc295sXw==
Date: Tue, 27 Aug 2024 13:36:30 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, kishon@kernel.org, 
	robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, abel.vesa@linaro.org, 
	quic_msarkar@quicinc.com, quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org, 
	kw@linux.com, lpieralisi@kernel.org, neil.armstrong@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 5/8] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Document the X1E80100 QMP PCIe PHY Gen4 x8
Message-ID: <jqzbpgqrbazf3rbdhag56rks74r2h3sjm6mr3tp7v2hb6pxamy@qhksqzsygttt>
References: <20240827063631.3932971-1-quic_qianyu@quicinc.com>
 <20240827063631.3932971-6-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240827063631.3932971-6-quic_qianyu@quicinc.com>

On Mon, Aug 26, 2024 at 11:36:28PM -0700, Qiang Yu wrote:
> PCIe 3rd instance of X1E80100 support Gen 4x8 which needs different 8 lane
> capable QMP PCIe PHY. Document Gen 4x8 PHY as separate module.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
>  .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml        | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> index 03dbd02cf9e7..e122657490b1 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> @@ -40,6 +40,7 @@ properties:
>        - qcom,sm8650-qmp-gen4x2-pcie-phy
>        - qcom,x1e80100-qmp-gen3x2-pcie-phy
>        - qcom,x1e80100-qmp-gen4x2-pcie-phy
> +      - qcom,x1e80100-qmp-gen4x8-pcie-phy
>  
>    reg:
>      minItems: 1
> @@ -47,7 +48,7 @@ properties:
>  
>    clocks:
>      minItems: 5
> -    maxItems: 7
> +    maxItems: 8
>  
>    clock-names:
>      minItems: 5
> @@ -59,6 +60,7 @@ properties:
>        - const: pipe
>        - const: pipediv2
>        - const: phy_aux
> +      - const: clkref_en

That sounds like enabling clock ref, not the reference clock.

>  
>    power-domains:
>      maxItems: 1
> @@ -190,6 +192,19 @@ allOf:
>          clock-names:
>            minItems: 7

You need to now constrain other cases. Missing maxItems.

Best regards,
Krzysztof


