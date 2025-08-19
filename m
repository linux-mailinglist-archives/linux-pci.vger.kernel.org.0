Return-Path: <linux-pci+bounces-34263-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9275B2BC22
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 10:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C35FD6235C5
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 08:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6178D315775;
	Tue, 19 Aug 2025 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJ7QZoRY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB87315763;
	Tue, 19 Aug 2025 08:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755593156; cv=none; b=Z9taY280lJ8ABw4vsC6pdWYjWs5ZBptp36cYqmpE7so9hKuaXRjCoRTUZ58yvQnLdccy3FtdtdqtO1/LtJ7VrC6F6aCkJw+yRcS3JquENtil79GH2phEYS3QFKjnXFEfmMu8Ql4jusGRCRy/l7aI02XmV0ZQPqbbBD2yQIfqjvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755593156; c=relaxed/simple;
	bh=GPOYK31qtoIEKqYJTIvUmVftyya/G7B893eokpWAOLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfWJBB/rLOEU6FSMbb2ihKzgaJ7BUvI8SoeOdSOYSx6yIq/Wea9uNym60NGAb4LYcLfH/kJN5nIchnbFVPwWhxtDaPhdHaxDuZY/72qQAdOyinE8xDnx5tRt3ra34f7VtfZz2n+sYB7cGNURKKiFf0dY9UxDTAKSPE0ngn7uG1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJ7QZoRY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9847DC116B1;
	Tue, 19 Aug 2025 08:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755593155;
	bh=GPOYK31qtoIEKqYJTIvUmVftyya/G7B893eokpWAOLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MJ7QZoRY+YfkgplaAKdBhgdnZ1mgxJVxtoeFh9f3bYPMFNOfzgh8l6gbK7MtCpkeG
	 Wr/LnrFaJ3P8ksQcW5/C0LcSxTjm/wAP4AsSQ3Hv4wzc168nDosYbTwdqQZcNiGoA8
	 cQpuQVLv0XukgdDeaAjpr6tf4lZEzRuMa/D0BnEJ09qoT1xJD0roVHgXNBp6JNz3aV
	 D23fJfH3JFwey5lsuExBf5/qMJpnJEQzR1RXuvks/4KdgcdZgRHyyO9E+ABU4N/Ij2
	 /wjiCT8oH6+mHA+s3DlErVhfAAwh8gWqcRwwoDXnYhik+0QhPMhOlTaPE80daWJE4P
	 lwPcZq08bSBiQ==
Date: Tue, 19 Aug 2025 14:15:44 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: PCI: dwc: Add vaux regulator
Message-ID: <qnbwtgsl23we56tzdt2bih644uqrojwssa7d73a3s7hpsfc3v2@4653fhoitmpz>
References: <20250819071630.1813134-1-hongxing.zhu@nxp.com>
 <20250819071630.1813134-2-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250819071630.1813134-2-hongxing.zhu@nxp.com>

On Tue, Aug 19, 2025 at 03:16:29PM GMT, Richard Zhu wrote:
> Refer to PCIe CEM r6.0, sec 2.3 WAKE# Signal, WAKE# signal is only
> asserted by the Add-in Card when all its functions are in D3Cold state
> and at least one of its functions is enabled for wakeup generation.
> 
> The 3.3V auxiliary power (+3.3Vaux) must be present and used for wakeup
> process. Since the main power supply would be gated off to let Add-in
> Card to be in D3Cold, add the vaux and keep it enabled to power up WAKE#
> circuit for the entire PCIe controller lifecycle when WAKE# is supported.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../devicetree/bindings/pci/snps,dw-pcie-common.yaml        | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> index 34594972d8dbe..5283f51388584 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> @@ -262,6 +262,12 @@ properties:
>  
>    dma-coherent: true
>  
> +  vaux-supply:
> +    description: Should specify the regulator in charge of power source
> +      of the WAKE# generation on the PCIe connector. When the WAKE# is
> +      enabled, this regualor would be always on and used to power up
> +      WAKE# circuit.

3.3Vaux supply is already documented in the dtschema:
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/pci-bus-common.yaml#L179

So you should use that instead.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

