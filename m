Return-Path: <linux-pci+bounces-20055-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB792A14E13
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 12:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253041889E97
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 11:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5C41F9F61;
	Fri, 17 Jan 2025 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ce8fz37p"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752CF1D5CE0;
	Fri, 17 Jan 2025 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737111632; cv=none; b=OsVbFdEYhupA6D3uxkwYtX2ta+vP2w+c38QuXPQ250kWBMSv4sBfTWtNyXvOxapYn1w2FwVQXZO/OTHwrJWNbOfGbAK46Yp4SqK4Yu6mxNADR2pBeAisSdfYY7yeVJaWSHSmMLMlx3R420zNonf7sWJ1a39JOd2x+CVZuXskHTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737111632; c=relaxed/simple;
	bh=vTQWVenncOu0byGPfgs/rhAj7iiznjI2FJ93MNmTcbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icoVtrGPdhRyx9zFOt8NUaWgrMSDxmgRwscilc9fTil9rRDcMgn+Iu2N01ogoGpDHXqj08rp6vrnFcVzi2AyU2HpiXsADtOiZcyHwgu844qbVYRUjYTGhNK0H0uyiGmFh05KLYM2OjVIfSe8jM6v5F696k5/rfSjkwWbLkx/E7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ce8fz37p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E58C4CEDD;
	Fri, 17 Jan 2025 11:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737111632;
	bh=vTQWVenncOu0byGPfgs/rhAj7iiznjI2FJ93MNmTcbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ce8fz37pPDP5gDINIBCUOuKjCl205rRiGqED6Pfg5wEGmsWhDn2lffBdaV2lawUel
	 rxRcOoc9hjikyzet4hyiS+/UxCABYTJo+yuveYvt46WuuOp1MHxaZThtUmf0na89Pn
	 gumePF/7azZyuU17N9wbVRMAqDDeQkhftLWdxp1sRMVOvZKj9UrfU87CjGhyPr1Vak
	 StgzXQgi0OlwyDzeYBorKZwgfrKnhbg47nLEM73d4zYYHzXrdTAd7eZpdhK7c8EwtW
	 7rOhLwi1wIgQ/4urjz1cDdVjJt4pdu7oxA6CAa/fsFQ8SIHHstVBBGyY89m4fSqVvk
	 ZX2TXdGaoxu3g==
Date: Fri, 17 Jan 2025 12:00:25 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org,
	Simon Xue <xxm@rock-chips.com>, Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 1/2] dt-bindings: PCI: dw: rockchip: Add rk3576 support
Message-ID: <Z4o4SazNBV6aLdxg@ryzen>
References: <20250117032742.2990779-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117032742.2990779-1-kever.yang@rock-chips.com>

On Fri, Jan 17, 2025 at 11:27:41AM +0800, Kever Yang wrote:
> rk3576 is using dwc controller, with msi interrupt directly to gic instead
> of to gic its, so
> - no its support is required and the 'msi-map' is not need anymore,
> - a new 'msi' interrupt is needed.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
> Changes in v5:
> - Add constraints per device for interrupt-names due to the interrupt is
> different from rk3588.
> 
> Changes in v4:
> - Fix wrong indentation in dt_binding_check report by Rob
> 
> Changes in v3:
> - Fix dtb check broken on rk3588
> - Update commit message
> 
> Changes in v2:
> - remove required 'msi-map'
> - add interrupt name 'msi'
> 
>  .../bindings/pci/rockchip-dw-pcie-common.yaml | 53 +++++++++++++++----
>  .../bindings/pci/rockchip-dw-pcie.yaml        |  4 +-
>  2 files changed, 44 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
> index cc9adfc7611c..eef108037184 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
> @@ -40,6 +40,7 @@ properties:
>  
>    interrupts:
>      minItems: 5
> +    maxItems: 9
>      items:
>        - description:
>            Combined system interrupt, which is used to signal the following
> @@ -64,6 +65,10 @@ properties:
>            interrupts - aer_rc_err, aer_rc_err_msi, rx_cpl_timeout,
>            tx_cpl_timeout, cor_err_sent, nf_err_sent, f_err_sent, cor_err_rx,
>            nf_err_rx, f_err_rx, radm_qoverflow
> +      - description:
> +          Combinded MSI line interrupt, which is to support MSI interrupts
> +          output to GIC controller via GIC SPI interrupt instead of GIC its
> +          interrupt.

If you are talking about GIC interrupt translation service here,
then I think you should:
s/GIC its/GIC ITS/


Kind regards,
Niklas

