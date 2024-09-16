Return-Path: <linux-pci+bounces-13235-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B76F97A511
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 17:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD0D1C22119
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 15:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C9A158DBA;
	Mon, 16 Sep 2024 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKH7k+VI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B65158D92;
	Mon, 16 Sep 2024 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726499731; cv=none; b=kqjlMwCTlAhw3JMTVHHvk8FjZbna36OYCHuVThmDUcoKEc8cRmVqKfb3i6SqwvbHRk6H9nqcNMSD406XGi+C67VsiSWrfI+DargqTUYMVYBh1s8TNQJTYmeXEuq7p7nzTYvtF12PkeGvLFIsebjzdpnl277irTX8mBh2EBEM9ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726499731; c=relaxed/simple;
	bh=4TdVLpYx1lgwkyzc41haI4RdxMTF/JxI6OjO9YWCj4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5iLfnXSBfe9hCJ/DZ8xcOq8my6YvHid8ynhG8bSS0bcEmrVG/kdGqfzpyGNFZcx8ZrbYJLp/TH4mUStRvIgBfH0DyVVAtT6L+8GtQbFXHCBp++lb2K3ZwxDuuzkS7HZ39wLpsuTVMsT9tFbDLfipCbZJ7z8pfRm5eowOeZzz5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKH7k+VI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46491C4CEC5;
	Mon, 16 Sep 2024 15:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726499730;
	bh=4TdVLpYx1lgwkyzc41haI4RdxMTF/JxI6OjO9YWCj4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BKH7k+VIZBrm4oujHkgnsLvErv4jKlX1g9fiHCjAQozfXepJ3pO9n26T0sM/A2uZz
	 ILLjs2hxjdvJmzeq7STTjBoZhpOi3EfgEANWfMrp+ssL9dIJs5YJa8xUUNL8GIZYkB
	 2wSBUUXLIimH7kKmSyqgmcCH8b+d42FBlxZ+m0ZJH+54t94z2IC1Sen+Nf87ikCEV8
	 azPRH7KtcUiCzwgkFpqUSPyJNuu2jU1wEeYs8xRm4hmQopFhp1LfWJ2R7VtwSBNZOa
	 UFGLWIwzSVYcYvt9BpTU2m95J7OQlazC1xbJE5vIKFBl4l9KCYY4gvHJSucQWiu+vB
	 tH4dqXogfCkQA==
Date: Mon, 16 Sep 2024 17:15:27 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, kishon@kernel.org, 
	robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, abel.vesa@linaro.org, 
	quic_msarkar@quicinc.com, quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org, 
	kw@linux.com, lpieralisi@kernel.org, neil.armstrong@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Document the X1E80100 QMP PCIe PHY Gen4 x8
Message-ID: <lrcridndulcurod7tc5z76tmfhcf5uqumkw7cijsqicmad2rim@blyor66wt4e4>
References: <20240913083724.1217691-1-quic_qianyu@quicinc.com>
 <20240913083724.1217691-2-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240913083724.1217691-2-quic_qianyu@quicinc.com>

On Fri, Sep 13, 2024 at 01:37:20AM -0700, Qiang Yu wrote:
> PCIe 3rd instance of X1E80100 support Gen 4x8 which needs different 8 lane
> capable QMP PCIe PHY. Document Gen 4x8 PHY as separate module.

And this is really different hardware? Not just different number of lanes? We discussed it, but I don't see the explanation in commit msg.

> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
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

Hm, why 4x4 is not here?

Best regards,
Krzysztof


