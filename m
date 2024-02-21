Return-Path: <linux-pci+bounces-3813-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBB785D606
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 11:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2827328357C
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 10:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA743A1C1;
	Wed, 21 Feb 2024 10:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYsFWyE/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B413DB8C;
	Wed, 21 Feb 2024 10:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708512576; cv=none; b=o8qMdGpomAuHCeWw7wvq7hsbz25YUPaDHdHI+N8CX8G65KRifHq4cLD9/xTR83QIlnOi6cMQfGPdCZr5U7eXLtyVQoOggVAQ+NEkf56tYvHGGdDRRiNkDdzNgnIoHDsQdv+EQ1Te7IwaIppVoGYXIje+o2zlQmVt0PZzDSEHiFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708512576; c=relaxed/simple;
	bh=arxOax1Fal/10bdeaxUbFAhv0i0ETEjU7HQwbaIn75g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqVKbwCtgFtz/g+2yFKPkGri/StPjoJDqe7qf3j4GEyeg5dyff0K0wF1fxTNjpoGcQEaDP6xT8sX8zhyBazHmKwdnVRTJtCNDi8dh4QxVe48zhaNbL1kUz8ptECqTx2EFNHuJVuQ6Qr6MZaKGebskU/gaSnktehrk2AviwRFmMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYsFWyE/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89CD3C43390;
	Wed, 21 Feb 2024 10:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708512575;
	bh=arxOax1Fal/10bdeaxUbFAhv0i0ETEjU7HQwbaIn75g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OYsFWyE/axhIQyem8BlEb5Ux6m0afNO6l13t/w6dbXBZgrmIJqP9sVdkEdmxr4B0U
	 avzMjmA1I49P+Bpx3W+kUjbSUdRo5iZG79GKt9wN6PZ9D7g44BTG1tVu6lBMGqgP/g
	 r/cup2peMrEjBECspg5qHvQNbViQ7EgesHMR39ONcLFExoMUsZ65ZeLAAnVpbcVUSh
	 ZOysjfBS4YmYCkGJalQnzgDnxLlJ88OjTB4ub9w9NYCEBG45erbSvQJ/r7pvNj/s5+
	 qbYMLvcrR++Ytd5md6atdT0c903u1FXjCbl8tymwS1+dI3205R2la9I4XhlGFgBL7G
	 M8abO1W7lgXsw==
Date: Wed, 21 Feb 2024 11:49:27 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: bhelgaas@google.com, cassel@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, festevam@gmail.com, helgaas@kernel.org,
	hongxing.zhu@nxp.com, imx@lists.linux.dev, kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v11 07/14] dt-bindings: imx6q-pcie: Clean up
 irrationality clocks check
Message-ID: <ZdXVN17SogJG1RgZ@lpieralisi>
References: <20240220161924.3871774-1-Frank.Li@nxp.com>
 <20240220161924.3871774-8-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220161924.3871774-8-Frank.Li@nxp.com>

Irrationality ? I think you mean "duplicate" or "redundant" ?

Lorenzo

On Tue, Feb 20, 2024 at 11:19:17AM -0500, Frank Li wrote:
> The bindings referencing this file already define these constraints for
> each of the variants, so the if not: then: is redundant.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v7 to v8
>     - add Manivannan Sadhasiva's Ack tag
>     Change from v6 to v7
>     - rewrite git commit message by using simple words
>     Change from v5 to v6
>     - rewrite git commit message and explain why remove it safely.
>     - Add Rob's Ack
>     Change from v1 to v4
>     - new patch at v4
> 
>  .../bindings/pci/fsl,imx6q-pcie-common.yaml      | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
> index d91b639ae7ae7..0c50487a3866d 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
> @@ -150,22 +150,6 @@ allOf:
>              - {}
>              - const: pcie_phy
>              - const: pcie_aux
> -  - if:
> -      properties:
> -        compatible:
> -          not:
> -            contains:
> -              enum:
> -                - fsl,imx6sx-pcie
> -                - fsl,imx8mq-pcie
> -                - fsl,imx6sx-pcie-ep
> -                - fsl,imx8mq-pcie-ep
> -    then:
> -      properties:
> -        clocks:
> -          maxItems: 3
> -        clock-names:
> -          maxItems: 3
>  
>    - if:
>        properties:
> -- 
> 2.34.1
> 

