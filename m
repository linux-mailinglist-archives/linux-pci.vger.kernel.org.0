Return-Path: <linux-pci+bounces-40619-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B14AC42C5E
	for <lists+linux-pci@lfdr.de>; Sat, 08 Nov 2025 12:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DBEA188C977
	for <lists+linux-pci@lfdr.de>; Sat,  8 Nov 2025 12:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517C92E040E;
	Sat,  8 Nov 2025 11:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8EzCDoc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA0B134AB;
	Sat,  8 Nov 2025 11:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762603193; cv=none; b=ptMdD3OEONSVHNV3RtG2AURsJZl13gCNxnh6a1sh72NV4tq4n9ikcRHpVs5O6fXcZAiYlnksvV1R61xTsnufLEUAZwbdZTvL296Y4YMGnmKyhZAR3iwZsWCvaX+DSOe9+QgwA2hpYpjIpMVQYKAzm2Whyaa+4Wqvz67JeGSc0SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762603193; c=relaxed/simple;
	bh=zifuSYbrSRqU3MWoa3DZjrPt60rFa2uX47b60iGOZM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNY9bEwihIJnXjnc7K4vu6z8U0vb1VS//KAFNotKlG5/AO3ZUVu3ElK7zY7KHdbRNVHQD/keG5lARDda7Bb4TjTYIRdLIsK8r1C4oiphHJ290hP3mwBydv5PIxHXBFtnZ9Q9Rwnc8YSIGIdgnyQxn3y5NW7YdNVU2CWLKMseGiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8EzCDoc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622BCC4CEF7;
	Sat,  8 Nov 2025 11:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762603193;
	bh=zifuSYbrSRqU3MWoa3DZjrPt60rFa2uX47b60iGOZM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E8EzCDocbhseVA2outwAgOHzNxe8UAYJ5JYW1/7Z3vm0/Q/MWiSe2ugYCP2JZYX/7
	 zSdITqWi0PqAd82WHax/FBD95+NrtgCzLpKk09yUiPXfZ/GlVCDRL0g34/MsS0mSys
	 psr/1Y+GfxZM5zir+xTV0RX1K2r62VtqNBDcjkZ6kXneAVQwVne2gCut+ASPywpgMP
	 +2JVAF3mO0q2ksPQyQOmWvx8H4qtBiDc0GMh3xou9VA13cNgfbp8+B1aZfb1dWms/j
	 wgUdVgFeiYeSRQ44kc8zltwmnDUrh5XTe/dPCnyenSUQZ8KYlSey0XkUW9B2zuGMQW
	 Kc1qD5d1oCIFQ==
Date: Sat, 8 Nov 2025 12:59:50 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Abraham I <kishon@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: qcom: Enforce check for PHY,
 PERST# properties
Message-ID: <20251108-toad-of-hypothetical-opportunity-ebfa74@kuoka>
References: <20251106-pci-binding-v2-0-bebe9345fc4b@oss.qualcomm.com>
 <20251106-pci-binding-v2-1-bebe9345fc4b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251106-pci-binding-v2-1-bebe9345fc4b@oss.qualcomm.com>

On Thu, Nov 06, 2025 at 04:57:16PM +0530, Manivannan Sadhasivam wrote:
> Currently, the binding supports specifying the required PHY, PERST#
> properties in two ways:
> 
> 1. Controller node (deprecated)
> 	- phys
> 	- perst-gpios
> 
> 2. Root Port node
> 	- phys
> 	- reset-gpios
> 
> But there is no check to make sure that the both variants are not mixed.
> For instance, if the Controller node specifies 'phys', 'reset-gpios',

Schema already does not allow it, unless I missed which schema defines
reset-gpios in controller node.

> or if the Root Port node specifies 'phys', 'perst-gpios', then the driver
> will fail as reported. Hence, enforce the check in the binding to catch
> these issues.

I do not see such check.

> 
> It is also possible that DTs could have 'phys' property in Controller node
> and 'reset-gpios' properties in the Root Port node. It will also be a
> problem, but it is not possible to catch these cross-node issues in the
> binding.

... so this commit changes nothing?

The commit actually does change, but something completely different than
you write here, so entire commit msg is describing entirely different
cast. What you achieve here is to require perst-gpios, if controller
node defined phys. Unfortunately your commit msg does not explain why
perst-gpios are now required...

> 
> Reported-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Closes: https://lore.kernel.org/linux-pci/8f2e0631-6c59-4298-b36e-060708970ced@oss.qualcomm.com
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

That's too many tags. Either someone reported you bug or someone
suggested you to do something, not both (and proposing solution is not
suggesting a commit since you already knew you need to make the commit
because of bug...)


> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-common.yaml        | 16 ++++++++++++++++
>  .../devicetree/bindings/pci/qcom,pcie-sc8180x.yaml       |  3 +++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
> index ab2509ec1c4b40ac91a93033d1bab1b12c39362f..d56c0dc2ae4d3944294ca50cab708915c9f60ea8 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
> @@ -111,6 +111,14 @@ patternProperties:
>        phys:
>          maxItems: 1
>  
> +    oneOf:
> +      - required:
> +          - phys
> +          - reset-gpios
> +      - properties:
> +          phys: false
> +          reset-gpios: false
> +
>      unevaluatedProperties: false
>  
>  required:
> @@ -129,6 +137,14 @@ anyOf:
>    - required:
>        - msi-map
>  
> +oneOf:
> +  - required:
> +      - phys
> +      - perst-gpios
> +  - properties:
> +      phys: false
> +      perst-gpios: false
> +
>  allOf:
>    - $ref: /schemas/pci/pci-host-bridge.yaml#
>  
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml
> index 34a4d7b2c8459aeb615736f54c1971014adb205f..17abc7f7b7e9d71777380ddbfe90288e6187a827 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml
> @@ -77,6 +77,7 @@ unevaluatedProperties: false
>  examples:
>    - |
>      #include <dt-bindings/clock/qcom,gcc-sc8180x.h>
> +    #include <dt-bindings/gpio/gpio.h>
>      #include <dt-bindings/interconnect/qcom,sc8180x.h>
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>  
> @@ -164,5 +165,7 @@ examples:
>  
>              resets = <&gcc GCC_PCIE_0_BCR>;
>              reset-names = "pci";
> +
> +            perst-gpios = <&tlmm 175 GPIO_ACTIVE_LOW>;
>          };
>      };
> 
> -- 
> 2.48.1
> 

