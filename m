Return-Path: <linux-pci+bounces-32516-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C181B0A034
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 11:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1EC1C20F5F
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 09:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58A929B23D;
	Fri, 18 Jul 2025 09:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzVlDQP7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBD01EEA55;
	Fri, 18 Jul 2025 09:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752832695; cv=none; b=Fatcg6z9K2DFGGFvQCBeHxGg5KZjEhYPRbiE/OUoe0n729fevWqmHE6u7Zsmok3pbXtmFNBvPB+bIpCSIN04WTA895BPM4JFPlcWxIvjtXAhCqtzxk2q2VvF/d7hEDfSa06E7ncaeud5OofhjemRl6uB+Psk9TL0f9WOkLSEVZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752832695; c=relaxed/simple;
	bh=NfmOqmeSOcfW01whIDBlzmIOyiOsJC5Q+mnMOm68vwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zw8O9UitaTRTsmpcBJ++vS7QN6zo6si/SKHIwZW1FKWQsxrRykUtG1Z8p3pnVMmNKWbiqa4yFiGhwXDDLpujyQcc8rHlSkvfDfpgWT8ycfLKPB074/W4QJEuXHG2W9Z+/UhMvDAzKHRh0ndGVX1dXy0WCsPuS9+1U9egTglLsE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzVlDQP7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060F0C4CEEB;
	Fri, 18 Jul 2025 09:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752832695;
	bh=NfmOqmeSOcfW01whIDBlzmIOyiOsJC5Q+mnMOm68vwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AzVlDQP7xThkbAW4ildT7244pG9paEzEfTrI4Sdg9INXObFp8/Xfdeyrcj6ifANnw
	 2NualuVxLRj7B4r5qspIrEqHXA2lpxurZnDJROTK9c+TlqFcbdpi6m2E81awemqhd+
	 WYovK3CueWFy0WpxcH/lxIcZj7FGTNajWj0Z7hrnRSeDuu22LKj4QbLSMDuuKPFX7f
	 SPP3CFCd/2ehB6IT+663pFuYychzE5Gbnza8J4OOsFpWJ66MHUwVnMMMZZkp9r62DQ
	 gN2Xxszm9eAlTX2XPRjlSp+ZztCX3SVVh/h++Hb7bgTFArCFtn98Xq3PfNXuPcFPvz
	 lUX2vCmMdy06g==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uchqw-000000007n3-1HHC;
	Fri, 18 Jul 2025 11:58:07 +0200
Date: Fri, 18 Jul 2025 11:58:06 +0200
From: Johan Hovold <johan@kernel.org>
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
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
Subject: Re: [PATCH v5 1/4] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Update pcie phy bindings
Message-ID: <aHoarsqbnsBGtwni@hovoldconsulting.com>
References: <20250718081718.390790-1-ziyue.zhang@oss.qualcomm.com>
 <20250718081718.390790-2-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718081718.390790-2-ziyue.zhang@oss.qualcomm.com>

On Fri, Jul 18, 2025 at 04:17:15PM +0800, Ziyue Zhang wrote:
> The gcc_aux_clk is required by the PCIe controller but not by the PCIe
> PHY. In PCIe PHY, the source of aux_clk used in low-power mode should
> be gcc_phy_aux_clk. Hence, remove gcc_aux_clk and replace it with
> gcc_phy_aux_clk.
 
> Removed the phy_aux clock from the PCIe PHY binding as it is no longer
> used by any instance.

This paragraph no longer applies to this patch (but to the qcs8300 one
that removes the clock).

> Fixes: fd2d4e4c1986 ("dt-bindings: phy: qcom,qmp: Add sa8775p QMP PCIe PHY")
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>

> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> @@ -176,6 +176,8 @@ allOf:
>            contains:
>              enum:
>                - qcom,qcs615-qmp-gen3x1-pcie-phy
> +              - qcom,sa8775p-qmp-gen4x2-pcie-phy
> +              - qcom,sa8775p-qmp-gen4x4-pcie-phy
>                - qcom,sc8280xp-qmp-gen3x1-pcie-phy
>                - qcom,sc8280xp-qmp-gen3x2-pcie-phy
>                - qcom,sc8280xp-qmp-gen3x4-pcie-phy
> @@ -197,8 +199,6 @@ allOf:
>            contains:
>              enum:
>                - qcom,qcs8300-qmp-gen4x2-pcie-phy
> -              - qcom,sa8775p-qmp-gen4x2-pcie-phy
> -              - qcom,sa8775p-qmp-gen4x4-pcie-phy
>      then:
>        properties:
>          clocks:

Johan

