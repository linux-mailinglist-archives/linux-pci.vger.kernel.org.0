Return-Path: <linux-pci+bounces-36696-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E60B920E8
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 17:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907062A2159
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 15:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C712E0B71;
	Mon, 22 Sep 2025 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3/hIOqU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EAB27B516;
	Mon, 22 Sep 2025 15:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556256; cv=none; b=aq8SN9/IfxTHkXbF7F9Cm6TEj7aDj/DH7HuIO+s3v6s46RCkR3piNvp2rtwXkA7tWltz2ra3lhNeW907JtO8J1q9vIWCa5f9iYwrKw+MsAwGg1CMxovLkUY3pZLBSby7P0IM96YjdlqF8mRTGjCFAbZiFrW94WUba0pfNIIj8rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556256; c=relaxed/simple;
	bh=vbMWpitNm5DxTqLLDH+qpPPtWqFkWWec0kTvC3CnpIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXC6fftUHdZsQ7e4C8sJYkkrwOxA/I3iLNs9dYDFsdSpkH4yU9//Pt67ycvlWJSyeDxt3TYhZ2dYCb//1IRrs4h8uYxNWqmy7zLrrJDPyJBY3JvaQV8FIZLu+6K7wQ0YF6wPvKg621wct3HIfj//TANRXUJnE3VL+FxxqvOcJ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3/hIOqU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E990C4CEF0;
	Mon, 22 Sep 2025 15:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758556255;
	bh=vbMWpitNm5DxTqLLDH+qpPPtWqFkWWec0kTvC3CnpIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g3/hIOqUGt7lMUrCdD6KiF2I0jx9XcFlOlEkom9VEIoyZlauSSBxyIAauJWW6meE9
	 CtB/Jy8U8SKffhmKvaLp2hc2TQKqT1EOkWr5EyPwDIzAXyb7gP0n83QvuLvz78sHFE
	 XhL91XDLSF4+JnnKPKi8E5s7KO0ayFhjSFSXqX3n7v8VQADUM7K8Lo4IzqoP4WyDTR
	 zW3dUiUUdQq60f2+U16QPNRp+Gpr5mCZ1rc8Yc8iyosATMNsojw6RJYnEaptLBJyIj
	 6ENvvD4G3x25o+b3tWndQlEh80qPVfoqyQFj6NT9hB7BBx9C6h8MYpXD9OjWmO2sg4
	 3xnTgNRwUcmxw==
Date: Mon, 22 Sep 2025 10:50:54 -0500
From: Rob Herring <robh@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, bhelgaas@google.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] dt-bindings: pci-imx6: Add external reference
 clock mode support
Message-ID: <20250922155054.GA38670-robh@kernel.org>
References: <20250915035348.3252353-1-hongxing.zhu@nxp.com>
 <20250915035348.3252353-3-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915035348.3252353-3-hongxing.zhu@nxp.com>

On Mon, Sep 15, 2025 at 11:53:47AM +0800, Richard Zhu wrote:
> On i.MX, PCIe has two reference clock inputs: one from the internal PLL
> and one from an external clock source. Only one needs to be used,
> depending on the board design. Add the external reference clock source
> for reference clock.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index ca5f2970f217..6be45abe6e52 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -219,7 +219,12 @@ allOf:
>              - const: pcie_bus
>              - const: pcie_phy
>              - const: pcie_aux
> -            - const: ref
> +            - description: PCIe reference clock.
> +              oneOf:
> +                - description: The controller has two reference clock
> +                    inputs, internal system PLL and external clock
> +                    source. Only one needs to be used.
> +                  enum: [ref, extref]

This seems wrong to me. There's still only 1 ref input to the PCIe 
block. If you had 10 possible choices for the ref clock source, would 
you add 10 clock names here? No!

Can't you detect what the parent clock is for the 'ref' clock? and 
configure the GPR register appropriately. Or that mux should be modeled 
as a clock provider.

Rob

