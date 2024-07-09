Return-Path: <linux-pci+bounces-10012-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2550992C17C
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 19:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD6C028C232
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 17:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740E71B86EA;
	Tue,  9 Jul 2024 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrtNg0e5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE551B86DF;
	Tue,  9 Jul 2024 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542513; cv=none; b=n8iJbZuT5CWLfhbEsyLyuUUmtzHLyh8PV8dd+EQbJrjG8GwYSAQf/qBWgqK1zqbforWVzfU1e7XBQVQ8WKKh8Vf+TdzvWPeVI/lemeiaUHIXIH/QG8x8fb6bVPWwIcelV4k2w83P2T+58ncbREtiwYX2QndRcPSn91rTWDimjI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542513; c=relaxed/simple;
	bh=/+HvX5/xtHvn/bEfdYlCgHR+lAncL/K5jrixqscpp10=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HPyl4E80VManjLykd/vUCzVWH/V2cMnU6ag1IyEUFZ2h6nafADAeyz66i8t4WpNKBmHcOqPOQ7SpDzpa4DYNf6GHdqEvVooXG5TyiLfqwZ1VXlcF2fv/lCJnABxBzBkTkEsrOloI0WSw8buihagKYuFoqZhfCnVfFUEivMuwSw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrtNg0e5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46D8C3277B;
	Tue,  9 Jul 2024 16:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542513;
	bh=/+HvX5/xtHvn/bEfdYlCgHR+lAncL/K5jrixqscpp10=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lrtNg0e5bPXVenbGg27DTq/XxOgDuDfpgzxX43jNsaGzRr12Lb4vf2HJBaRcDFf38
	 sI27HoRG+jFakbHYcI5No/UaPVBUphaJV31oxP639xEfy4V92ZMQ0F7si0JXs1TcC6
	 xEzLSXMinAnmQp0cQDGR3oesP00gYH5hbmw940cHRh4dnQ0NTl0UrIQmt2v8OisgAM
	 q063u4MRSE23FafaP40fFN/RwvoExEZ+mq1k2VAZG0OxTLGyH6+sgIGGHxSPvpyMh/
	 wmt0vMpalsWw6qJ/LW7j824tPCdCAf7iPRnIw/AbuaNWAt1wVGQX0IBV3pI7qzLgeS
	 DI/N0il7NnwXg==
Date: Tue, 9 Jul 2024 11:28:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tengfei Fan <quic_tengfan@quicinc.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@quicinc.com,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: qcom-ep: Add support for
 QCS9100 SoC
Message-ID: <20240709162831.GA176079@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709-add_qcs9100_pcie_ep_compatible-v2-1-217742eac32b@quicinc.com>

On Tue, Jul 09, 2024 at 10:53:43PM +0800, Tengfei Fan wrote:
> Add devicetree bindings support for QCS9100 SoC. It has DMA register
> space and dma interrupt to support HDMA.

s/dma/DMA/ above for consistency.

Add blank line here if this is a paragraph break.

> QCS9100 is drived from SA8775p. Currently, both the QCS9100 and SA8775p
> platform use non-SCMI resource. In the future, the SA8775p platform will
> move to use SCMI resources and it will have new sa8775p-related device
> tree. Consequently, introduce "qcom,qcs9100-pcie-ep" to describe non-SCMI
> based PCIe.

s/drived/derived/

This patch doesn't add anything related to SCMI, so this paragraph
seems like a distraction.

The first paragraph seems a bit of a distraction too, since the patch
doesn't say anything about DMA register space or interrupt.

> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> index 46802f7d9482..8012663e7efc 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> @@ -13,6 +13,7 @@ properties:
>    compatible:
>      oneOf:
>        - enum:
> +          - qcom,qcs9100-pcie-ep
>            - qcom,sa8775p-pcie-ep
>            - qcom,sdx55-pcie-ep
>            - qcom,sm8450-pcie-ep
> @@ -203,6 +204,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - qcom,qcs9100-pcie-ep
>                - qcom,sa8775p-pcie-ep
>      then:
>        properties:
> 
> -- 
> 2.25.1
> 

