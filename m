Return-Path: <linux-pci+bounces-676-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5460B80A11C
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 11:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8168B20B93
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 10:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEA2171C3;
	Fri,  8 Dec 2023 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eD4Fc59d"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E853B19BBF;
	Fri,  8 Dec 2023 10:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF51C433C8;
	Fri,  8 Dec 2023 10:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702031683;
	bh=3pZgEJRxT1FI/bA6lGO5jGck7die4pp5hNpMdbV10qI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eD4Fc59dBMH9+k0tKVg2OdsrGLMAEnnzVrR63ff7Eo1pb5VStpCROIqUvTb8Dca/o
	 b1nKcDuBKzbvjCreJx1VVgyB+SIsU2bMRFp8et7nXmQKF5FmOm38+/FR6qVLhE8CJp
	 mdonPbssL1BmW6perPgzh0qt0o2UdVXV/h2G6tuTYz7i9RwgJ1efsD18fv1wNo60o1
	 qzJTKm20QM6m2b89ZAdP9TnQrFgau0Ikw0f+wu48DSomf2nRf1oO1BR5zD3kouo0MA
	 Wa/aZkqL7wLuRd5qoNptVUVidiRAc36soc6U0cDbTAWE2J8Vgfi7fMVKwixtQ9Wm9O
	 tA8XX7P8hncnA==
Date: Fri, 8 Dec 2023 16:04:27 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: qcom: Correct reset-names property
Message-ID: <20231208103427.GA15552@thinkpad>
References: <20231111142006.51883-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231111142006.51883-1-krzysztof.kozlowski@linaro.org>

On Sat, Nov 11, 2023 at 03:20:06PM +0100, Krzysztof Kozlowski wrote:
> There is no "resets-names" property, but "reset-names".
> 
> Fixes: 075a9d55932e ("dt-bindings: PCI: qcom: Convert to YAML")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index eadba38171e1..8bfae8eb79a3 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -88,7 +88,7 @@ properties:
>      minItems: 1
>      maxItems: 12
>  
> -  resets-names:
> +  reset-names:
>      minItems: 1
>      maxItems: 12
>  
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

