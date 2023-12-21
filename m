Return-Path: <linux-pci+bounces-1275-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B28681C139
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 23:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C971F25DB5
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 22:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FD478E81;
	Thu, 21 Dec 2023 22:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNLxSN+7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BAC78E64;
	Thu, 21 Dec 2023 22:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F25C433C8;
	Thu, 21 Dec 2023 22:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703199141;
	bh=2Fl8vOhQ64Y7+GgI7caXKohE+Cft0TcjWAivLqeuiFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XNLxSN+70e8qMK73Id71VXLGuAaG3NTghRPhaZpVfAD2rF/O45r/AQ3iqsrWqacAE
	 U4eipX3qpFy7P8RiHpK8b9sL+ue0nyzfspB9FI1EA+iR0szp/pHUzZagySvSzQ5qLF
	 EyHNw/jWoYr6RCBT2PWpHfj68Vyts84fRPDcdCGnL3u/1SErtA5td8dmoalY9/qjHL
	 XEnxuVi5SZBgpyXT4cpbEeqgJ+qvDbAYZVOGdOypLMfZUME8fXP9deNNZLT4vY3VIO
	 NGVNEr3+aYhQ+ScrV5rhEIyI/G549Zx1GnmhyCH6Q+tdLNMIgrYdIc9xkshr7Yy9rG
	 Rwpzdwx520EZQ==
Received: (nullmailer pid 234434 invoked by uid 1000);
	Thu, 21 Dec 2023 22:52:18 -0000
Date: Thu, 21 Dec 2023 16:52:18 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: manivannan.sadhasivam@linaro.org, bhelgaas@google.com, conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com, helgaas@kernel.org, hongxing.zhu@nxp.com, imx@lists.linux.dev, kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org, kw@linux.com, l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, lpieralisi@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v5 11/16] dt-bindings: imx6q-pcie: Add imx95 pcie
 compatible string
Message-ID: <20231221225218.GA232422-robh@kernel.org>
References: <20231220213615.1561528-1-Frank.Li@nxp.com>
 <20231220213615.1561528-12-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220213615.1561528-12-Frank.Li@nxp.com>

On Wed, Dec 20, 2023 at 04:36:10PM -0500, Frank Li wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> Add i.MX95 PCIe "fsl,imx95-pcie" compatible string.
> Add "atu" and "app" to reg-names.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
> 
> Notes:
>     Change from v2 to v3
>     - Remove krzy's ACK tag
>     - Add condition check for imx95, which required more reg-names then old
>     platform, so need Krzy review again,
>     
>     Change from v1 to v2
>     - add Krzy's ACK tag
> 
>  .../bindings/pci/fsl,imx6q-pcie-common.yaml    |  1 +
>  .../bindings/pci/fsl,imx6q-pcie.yaml           | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
> index a284a27c5e873..1b63089ff0aee 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
> @@ -207,6 +207,7 @@ allOf:
>                  - fsl,imx6sx-pcie
>                  - fsl,imx6q-pcie
>                  - fsl,imx6qp-pcie
> +                - fsl,imx95-pcie
>                  - fsl,imx6sx-pcie-ep
>                  - fsl,imx6q-pcie-ep
>                  - fsl,imx6qp-pcie-ep
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index f20d4f0e3cb6c..8633c622bd178 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -29,6 +29,7 @@ properties:
>        - fsl,imx8mq-pcie
>        - fsl,imx8mm-pcie
>        - fsl,imx8mp-pcie
> +      - fsl,imx95-pcie
>  
>    clocks:
>      minItems: 3
> @@ -80,6 +81,22 @@ required:
>  allOf:
>    - $ref: /schemas/pci/snps,dw-pcie.yaml#
>    - $ref: /schemas/pci/fsl,imx6q-pcie-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - fsl,imx95-pcie
> +    then:
> +      properties:
> +        reg:
> +          minItems: 4
> +        reg-names:
> +          items:
> +            - const: dbi
> +            - const: atu
> +            - const: app
> +            - const: config

Add new entries to the end. Originally, you had dbi and config. Add ata 
and app on the end.

> +
>    - if:
>        properties:
>          compatible:
> @@ -101,6 +118,7 @@ allOf:
>          compatible:
>            enum:
>              - fsl,imx8mq-pcie
> +            - fsl,imx95-pcie
>      then:
>        properties:
>          clocks:
> -- 
> 2.34.1
> 

