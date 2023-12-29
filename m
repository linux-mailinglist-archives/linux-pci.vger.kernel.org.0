Return-Path: <linux-pci+bounces-1558-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 006FA8200D4
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 18:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935521F22250
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 17:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B423812B7E;
	Fri, 29 Dec 2023 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTd/7iEe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A10112B72;
	Fri, 29 Dec 2023 17:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E78FC433C8;
	Fri, 29 Dec 2023 17:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703870969;
	bh=XbxclmQyipdavrwbYUYM8UDPBBktnT4V9RWeUQBnLvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DTd/7iEehsoBpqox1tu88K8oj8kQ6+VEqwJVEnGYVJjzE8W4jx5cWDYPhdtUMhlz9
	 n7qw1tlD6xsopTJYyvFD7Z6Cn5MilknG+w9SIjnTHMAEMhchGmclQO2LgXnDqIVBAb
	 BdYXr086Onj0YmAhYtInzVVYRpSNVJ/7IfF8RgWYMbiQa7xPK52nHLREpyOLs7Etco
	 Y889OdjrHofLekMj314ZbCjDObF/leXcQTiI/HC9fiPswC+pTKxlle0TAZ3e5dA4S/
	 6uKebtF9aqFi9LD0ba6PKy7iiAa8VPQThMh5V/O7AneTru1NaxOiaehuauQ85k5/3r
	 skwJIkIz773Lg==
Date: Fri, 29 Dec 2023 22:59:14 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: David Heidelberg <david@ixit.cz>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: PCI: qcom: delimit number of iommu-map
 entries
Message-ID: <20231229172914.GE9098@thinkpad>
References: <20231229153310.206764-1-david@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231229153310.206764-1-david@ixit.cz>

On Fri, Dec 29, 2023 at 04:32:58PM +0100, David Heidelberg wrote:
> The code or specific SoC doesn't seem to limit the number of iommu-map entries.
> 
> Fixes: 1a24edc38dbf ("dt-bindings: PCI: qcom: Add SM8550 compatible")

NACK. There is a limitation in the SoCs but that limitation differs.

- Mani

> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v2: added Fixes tag
> 
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index eadba38171e1..c6111278162f 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -61,8 +61,7 @@ properties:
>      minItems: 1
>      maxItems: 8
>  
> -  iommu-map:
> -    maxItems: 2
> +  iommu-map: true
>  
>    # Common definitions for clocks, clock-names and reset.
>    # Platform constraints are described later.
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

