Return-Path: <linux-pci+bounces-20272-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336A4A19F7C
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 08:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF94F3AF260
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 07:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90ABC2010F2;
	Thu, 23 Jan 2025 07:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqiibJS2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9431C5D5F;
	Thu, 23 Jan 2025 07:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737619113; cv=none; b=QeqFQ99DQiJ7f87Os+H5T40uc7nypZeqLo3s4XaoFLdEMbajKUZsZRaM50u/fBUKUOpk0mZZydfJ29WVYxq9mi9ylsN46wKRhb2ICGyaAOA02/kLWUWm53eSKa8VQXpsLrAg0Fh8c/3BSaiP76P4xPHJrrlHjLBXzuI3FzqRrXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737619113; c=relaxed/simple;
	bh=vRVpTTzm2HBffJ77o4hXyb5EpuW+31OmOBfJ3t9pLnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHXATZFRc0XumbbQgnbjenog2gD7GYcHGxuMe5YTbed2YEAYZh9IJBC+WzaoSJQOwejZgJAN7e7dbBCOXZMVmyE+rQfmwogRN8WlnEKk2myjpnHux4DoUpT8idbId4Vqw/4Kik9036N+Th3DIqnkssFb8T452QGJc1GErjOdVJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqiibJS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA38C4CEE0;
	Thu, 23 Jan 2025 07:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737619112;
	bh=vRVpTTzm2HBffJ77o4hXyb5EpuW+31OmOBfJ3t9pLnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RqiibJS2JWQVpGfikZv1qrYNfL0ZaDHd3xqQQ8tmRGnXLa91v8g5PcmmP2cnfDzky
	 704SMxZSGBgCfLpbqkJSmK9Fp+/XN+UrnZUa08ngFIh15plxOMvPh35CsfqsTdA/fh
	 K26OuDipKw6eoVJCl2fZOwowsohfhUsgsyjNi3vFEfbSDAHgxDGskiZpR+qArUZTWa
	 SmRUBMFdetFYzsMNQdz6obF3JFh1UT55mKBFQ4jhGv0/7JW70yq9qp8Mp40cvS1ivJ
	 kGQ9xvLEjtCgZJA6MrPHvIs0RoeAlOvDMRdj33tqvLmp5xNC4RRMrpAeOIMK5n70H9
	 gCCNtDEx+TWYQ==
Date: Thu, 23 Jan 2025 08:58:29 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	p.zabel@pengutronix.de, dmitry.baryshkov@linaro.org, quic_nsekar@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v7 5/7] dt-bindings: PCI: qcom: Document the IPQ5332 PCIe
 controller
Message-ID: <20250123-red-unicorn-of-piety-3c7de5@krzk-bin>
References: <20250122063411.3503097-1-quic_varada@quicinc.com>
 <20250122063411.3503097-6-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250122063411.3503097-6-quic_varada@quicinc.com>

On Wed, Jan 22, 2025 at 12:04:09PM +0530, Varadarajan Narayanan wrote:
> Document the PCIe controller on IPQ5332 platform. IPQ5332 will
> use IPQ9574 as the fall back compatible.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v7: Moved ipq9574 related changes to a separate patch
>     Add 'global' interrupt
> 
> v6: Commit message update only. Add info regarding the moving of
>     ipq9574 from 5 "reg" definition to 5 or 6 reg definition.
> 
> v5: Re-arrange 5332 and 9574 compatibles to handle fallback usage in dts
> 
> v4: * v3 reused ipq9574 bindings for ipq5332. Instead add one for ipq5332
>     * DTS uses ipq9574 compatible as fallback. Hence move ipq9574 to be able
>       to use the 'reg' section for both ipq5332 and ipq9574. Else, dtbs_check
>       and dt_binding_check flag errors.
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml          | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 413c6b76c26c..ead97286fd41 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -34,6 +34,10 @@ properties:
>        - items:
>            - const: qcom,pcie-msm8998
>            - const: qcom,pcie-msm8996
> +      - items:
> +          - enum:
> +              - qcom,pcie-ipq5332
> +          - const: qcom,pcie-ipq9574

Repeated many times on reviews to qcom: don't add to the end of the
lists. In case of multiple items, these are ordered by fallback, so this
goes next to other ipq entry... wait, that's already qcom,pcie-ipq9574,
so why are you duplicating?

On what tree are you working?

Best regards,
Krzysztof


