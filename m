Return-Path: <linux-pci+bounces-19074-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AD09FD1D2
	for <lists+linux-pci@lfdr.de>; Fri, 27 Dec 2024 09:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6118E160C53
	for <lists+linux-pci@lfdr.de>; Fri, 27 Dec 2024 08:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EB314AD3D;
	Fri, 27 Dec 2024 08:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GylMH3EE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35228615A;
	Fri, 27 Dec 2024 08:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735286864; cv=none; b=Re2w8iW+SF3I+F2Lam1T9XUsUeZ4/fG4GgSI4p6XZF8LqeIYl6sRFivFPGrqZHgaPou9HDZwg+tEclQfky5/d86sUTbAHUL/KJN4JLAoKhbSflijmfpEmbTEeSN4kheRbAAf2ITuNjPouq7jpImQM9jlgboshIS2+UlkCyysVjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735286864; c=relaxed/simple;
	bh=5uGD9JmhENJUTkkXUjo38hUph4jreLFDJYh6d6nEc8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRAmbSc52cnj6JwMrLaB9+iw6Pyi6H/aK6rzRv8mOj/3Ma80uoJJP3+VWp4D252EDrPrfwl6Ea3dltK98PtvFjlR4rKeWAIJjxcGhvC+D7B5Al/aoTlajwKaZ3pcVoI8BOoPKHxCs2kXfygloJ97X9Dhu0Tp57cvZKbUS+rt2ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GylMH3EE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90E7C4CED0;
	Fri, 27 Dec 2024 08:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735286864;
	bh=5uGD9JmhENJUTkkXUjo38hUph4jreLFDJYh6d6nEc8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GylMH3EEdyFZf724uJ+cFisgFv0FpCcKvY5S3bXf0j99JHvDppz65cMy0hIuKKqSf
	 7IQxwUi7aJChSXR+RGF+ycR1Vrt7F1F+WRyiFCh1uqziaZnsKCPy25AlV7kCldI+m/
	 QwzmDi5mnigCZMc2/kenDQWCfhu8PbSCpVvvycgqWtktKWkF826VCHNuyocT6uWsHO
	 ljVxnhU07nOg080txQMtP6OhDIolA43PO3QKSaWJwMKLj5TXUvWTR1RAK01X1W3jHm
	 3KB2dlNBUQsRZyZ7chIkEjzWVETk/D2qOHp0B/zq4rPsMCmvFfXqkjze2qbTzo60n/
	 qcR2aYPhumPOA==
Date: Fri, 27 Dec 2024 09:07:41 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	p.zabel@pengutronix.de, dmitry.baryshkov@linaro.org, quic_nsekar@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v4 3/5] dt-bindings: PCI: qcom: Document the IPQ5332 PCIe
 controller
Message-ID: <lbyvf7rwsr5j67nu42d4vemuzamfalvjyx6xebwjhwwce5gy7e@tclayb7gb6x6>
References: <20241226102432.3193366-1-quic_varada@quicinc.com>
 <20241226102432.3193366-4-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241226102432.3193366-4-quic_varada@quicinc.com>

On Thu, Dec 26, 2024 at 03:54:30PM +0530, Varadarajan Narayanan wrote:
> Document the PCIe controller on IPQ5332 platform.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v4: * v3 reused ipq9574 bindings for ipq5332. Instead add one for ipq5332
>     * DTS uses ipq9574 compatible as fallback. Hence move ipq9574 to be able
>       to use the 'reg' section for both ipq5332 and ipq9574. Else, dtbs_check
>       and dt_binding_check flag errors.
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index bd87f6b49d68..ac920e435c73 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -21,6 +21,7 @@ properties:
>            - qcom,pcie-apq8064
>            - qcom,pcie-apq8084
>            - qcom,pcie-ipq4019
> +          - qcom,pcie-ipq5332
>            - qcom,pcie-ipq6018
>            - qcom,pcie-ipq8064
>            - qcom,pcie-ipq8064-v2
> @@ -165,7 +166,6 @@ allOf:
>              enum:
>                - qcom,pcie-ipq6018
>                - qcom,pcie-ipq8074-gen3
> -              - qcom,pcie-ipq9574


I don't see how this is related to ipq5332 and nothing in commit msg
even mentions this.

>      then:
>        properties:
>          reg:
> @@ -206,6 +206,8 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - qcom,pcie-ipq5332
> +              - qcom,pcie-ipq9574


Best regards,
Krzysztof


