Return-Path: <linux-pci+bounces-22081-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B43BA40782
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 11:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823BA4249EF
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 10:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5B72080D5;
	Sat, 22 Feb 2025 10:40:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FEF206F19;
	Sat, 22 Feb 2025 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740220826; cv=none; b=A9CJUQgdwrEN+Yf3VsTU09626qExYqY9zsHqUdlcSJiFjciq+iR4E+hhklOwUvikQ1uGw71GotCDGS+JIfsIlhHw0H0ahOI9x6RsXaj6UQD+P7FM+IEoXeOqr0quPrIXrhcsxqEKkQoQTW6XgUfHsQf7nAavNP+KBxkINog+t5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740220826; c=relaxed/simple;
	bh=N//dkoX4bhGiFbUQguTT+b2mJ+HuL4EQQoQfCLnyP6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/BjG4BbnK8Hvd1ZBWXkIhjMvPkxCpA50Q6rBsrjoroDVgfT82g42XJKEWnQeDgAjqmSOrGyfLbtzrAkHkinVT4AY7vi8Pf11KCMmVFw/TvqZ50WtINNiiWx9i7l2NL7L/S0dZLJMYvuzsmPs3ySftcl7Ig0r6GEcOlBOWeGGIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D057C4CEE2;
	Sat, 22 Feb 2025 10:40:25 +0000 (UTC)
Date: Sat, 22 Feb 2025 11:40:22 +0100
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mrinmay Sarkar <quic_msarkar@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/8] dt-bindings: PCI: qcom-ep: consolidate DMA vs
 non-DMA usecases
Message-ID: <20250222-sexy-jasmine-lorikeet-3fe8db@krzk-bin>
References: <20250221-sar2130p-pci-v3-0-61a0fdfb75b4@linaro.org>
 <20250221-sar2130p-pci-v3-4-61a0fdfb75b4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250221-sar2130p-pci-v3-4-61a0fdfb75b4@linaro.org>

On Fri, Feb 21, 2025 at 05:52:02PM +0200, Dmitry Baryshkov wrote:
> On Qualcomm platforms here are two major kinds of PCIe EP controllers:
> ones which use eDMA and IOMMU and the ones which do not (like SDX55 /
> SDX65). It doesn't make sense to c&p similar properties all over the
> place. Merge these two usecases into a single conditional clause.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 68 +++++++++++-----------
>  1 file changed, 35 insertions(+), 33 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> index d22022ff2760c5aa84d31e3c719dd4b63adbb4cf..2c1918ca30dcfa8decea684ff6bfe11c602bbc7e 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> @@ -131,6 +131,7 @@ required:
>  
>  allOf:
>    - $ref: pci-ep.yaml#
> +
>    - if:
>        properties:
>          compatible:
> @@ -140,9 +141,43 @@ allOf:
>      then:
>        properties:
>          reg:
> +          minItems: 6

That's not really necessary - minItems: 6 is in the top level. It
doesn't hurt, though.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


