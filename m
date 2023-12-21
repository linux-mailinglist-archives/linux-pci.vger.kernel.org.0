Return-Path: <linux-pci+bounces-1274-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C80581C12D
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 23:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA786288839
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 22:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DBC77F1C;
	Thu, 21 Dec 2023 22:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOh7j1HX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C460D539E0;
	Thu, 21 Dec 2023 22:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7542C433C8;
	Thu, 21 Dec 2023 22:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703199035;
	bh=SJ1TWp7q6EuBVLbtKtyWSA/CE+Ydd1K2upUokazHOso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KOh7j1HXC7k9Krle913R+N1TigqFWR7cAzSNnJOLsFbHawjsFNg8jf70zKCt7lv3j
	 XseosK5YZ12JkaqONqxhACiNQo1H7LyBYakwgTafmgv9lha8wU6mP7U1DTRZfQhkXa
	 eB9sQ8t+nw3ZL4CKs6YYXwjRoYbOcovo2h7QcmP+tzCyun7GymQ2S9eAOaxwvgOXTz
	 t6fwQtfMTuXDyDCGpoP1GQh7m59rWiOzhdeX19QULhJY9WxHIzuZseOK9wuiqu8xCW
	 zA+UDk31Z7JLIdde/q8paPlOIj8gNtqwOlFXSa80SvNQEU8KeK00kpUzdlTvaOLN5f
	 GX9dAuMtbPhOw==
Received: (nullmailer pid 232194 invoked by uid 1000);
	Thu, 21 Dec 2023 22:50:33 -0000
Date: Thu, 21 Dec 2023 16:50:33 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: manivannan.sadhasivam@linaro.org, bhelgaas@google.com, conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com, helgaas@kernel.org, hongxing.zhu@nxp.com, imx@lists.linux.dev, kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org, kw@linux.com, l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, lpieralisi@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v5 10/16] dt-bindings: imx6q-pcie: remove reg and reg-name
Message-ID: <20231221225033.GA228866-robh@kernel.org>
References: <20231220213615.1561528-1-Frank.Li@nxp.com>
 <20231220213615.1561528-11-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220213615.1561528-11-Frank.Li@nxp.com>

On Wed, Dec 20, 2023 at 04:36:09PM -0500, Frank Li wrote:
> snps,dw-pcie.yaml already have reg and reg-name information. Needn't
> duplciate here.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v4 to v5
>     - add Rob's Acked

Err, that was intended for patch 9, not this one. This patch should be 
dropped.

>     Change from v1 to v4:
>     - new patch at v4
> 
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml        | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index 81bbb8728f0f9..f20d4f0e3cb6c 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -30,16 +30,6 @@ properties:
>        - fsl,imx8mm-pcie
>        - fsl,imx8mp-pcie
>  
> -  reg:
> -    items:
> -      - description: Data Bus Interface (DBI) registers.
> -      - description: PCIe configuration space region.
> -
> -  reg-names:
> -    items:
> -      - const: dbi
> -      - const: config
> -
>    clocks:
>      minItems: 3
>      items:
> -- 
> 2.34.1
> 

