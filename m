Return-Path: <linux-pci+bounces-1864-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D57D7827D8A
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 04:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7589DB233CA
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 03:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB78E4698;
	Tue,  9 Jan 2024 03:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXADbiya"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A735E2575D;
	Tue,  9 Jan 2024 03:49:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E57FC433F1;
	Tue,  9 Jan 2024 03:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704772194;
	bh=rahJBlD6WKCnL7cz/47HayRSqAAM+zBHOL83nb/2+0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cXADbiyaO/IrZRpiIPE/9Wio7oQ4ImFbFhONLDiODb/FhvXfBbWh2yW6TDsRE5TZH
	 YRhx5B/AGjAIIKht0p0eYMGXtYpLkOk+1ifkAa9LTww2irVTfCW6InHCJIe4NbirGn
	 Jcz+HJnBVPZYVQ6pb9JYrgrKCvTuRKA2f+nNVJSznqH3ZqG+jOZiB+9iOVmJd/t8GA
	 i0LljqEJEIeCGSqsYsYxr+VbcNAyI7V2T92tmJNBAMrATwcmCqZDz89Vl1vd1hZVue
	 PZAo2kUMRdzR7CDPeC3qD0hWZkO9pdiP5YDCOL7Yu4TZKkkB3XzCbgsArUSoiRYceF
	 yXwTsP/oCYpSw==
Received: (nullmailer pid 2607265 invoked by uid 1000);
	Tue, 09 Jan 2024 03:49:52 -0000
Date: Mon, 8 Jan 2024 20:49:52 -0700
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: s.hauer@pengutronix.de, hongxing.zhu@nxp.com, helgaas@kernel.org, manivannan.sadhasivam@linaro.org, shawnguo@kernel.org, kw@linux.com, linux-imx@nxp.com, krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org, imx@lists.linux.dev, krzysztof.kozlowski@linaro.org, bhelgaas@google.com, conor+dt@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de, linux-pci@vger.kernel.org, festevam@gmail.com, lpieralisi@kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v7 04/16] dt-bindings: imx6q-pcie: Add linux,pci-domain
 as required for iMX8MQ
Message-ID: <170477219183.2607205.10766546617113088833.robh@kernel.org>
References: <20231227182727.1747435-1-Frank.Li@nxp.com>
 <20231227182727.1747435-5-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227182727.1747435-5-Frank.Li@nxp.com>


On Wed, 27 Dec 2023 13:27:15 -0500, Frank Li wrote:
> iMX8MQ have two pci controllers. Adds "linux,pci-domain" as required
> proptery for iMX8MQ to indicate pci controller index.
> 
> This adjustment paves the way for eliminating the hardcoded check on the
> base register for acquiring the controller_id.
> 
> 	...
> 	if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> 		imx6_pcie->controller_id = 1;
> 	...
> 
> The controller_id is crucial and utilized for certain register bit
> positions. It must align precisely with the controller index in the SoC.
> An auto-incremented ID don't fit this case. The DTS or fuse configurations
> may deactivate specific PCI controllers.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v5 to v6
>     - rework commit message to explain why need required and why auto increase
>     id not work
> 
>     Change from v4 to v5
>     - new patch at v5
> 
>  .../bindings/pci/fsl,imx6q-pcie-common.yaml           | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


