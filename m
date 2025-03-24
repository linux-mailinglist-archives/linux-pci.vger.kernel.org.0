Return-Path: <linux-pci+bounces-24544-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1087A6DFF5
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 17:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17253170AD0
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 16:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC9C263C88;
	Mon, 24 Mar 2025 16:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEHhlF1+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC60F25F96B;
	Mon, 24 Mar 2025 16:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834386; cv=none; b=NCTiEpbeH+3tU/v7DxgexyI0iU3UDG/Hu+yF8vKj0xc4d10OgXF26h6mrAt2Y+5zfmUU1w3PB9D2Sx0Kz87Hi8nvKGIqhaACeJF0TrJ8R4zMWUokGYZY8JqsJ2qk1/eXfmtdCoiOIBdnV3fRb0qGz4LydzV2YCivQR5cW7dI3Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834386; c=relaxed/simple;
	bh=PkU41z1npHU361mFlL7uOSF2RgIZLrl2UcM2T4+kpTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiCZS3qE1DP3i3Cs+gAM9EAdoX8sM14297RFmmhIQdqhlK1iQ7FrAL4BvDMOL2FCz7rDJd/dS+ZC8dhPH4/Ky8ZjldIg3inyZPsevEicZ28xFhs5MTxC0Qk2Sgi8Pvn+BB3JygVNaFJ86s3qOp251fg27Y7xAgr/Urv4P/SIOzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEHhlF1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E47C4CEEA;
	Mon, 24 Mar 2025 16:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742834386;
	bh=PkU41z1npHU361mFlL7uOSF2RgIZLrl2UcM2T4+kpTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oEHhlF1+KjBN6VZ6R3OqvS0W9SotslDejwxbnt+zH6pZ52NTWTnx8QHhx2U3/sSQj
	 r1L5bzp3hFx/6tas4BM1CRZd4gG8XtLw6FAvI97qvhxxIrAOnm6TBCxoTD72UEhIlI
	 /MH6y0jOcYGdSfIDefC1dr+lrlZBj4drPIUsSAp01jTMFuMA/ZzqxhWWI8q9A60XhJ
	 LvK4la4O0nq3ISKlqXpV4OB08co+9tzQgliYleonJWD2tT+ZHCcXxExGJFvt895/zg
	 nB49fbHtc9TtnR5zrMzOlhjip2lFVTFRPpTw5PVzi8FP2LunktYpBJ+jQrmMX8QSBj
	 GclopDQUx+69g==
Date: Mon, 24 Mar 2025 11:39:45 -0500
From: Rob Herring <robh@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_mrana@quicinc.com
Subject: Re: [PATCH 1/3] dt-bindings: PCI: qcom: Move phy, wake & reset
 gpio's to root port
Message-ID: <20250324163945.GA304502-robh@kernel.org>
References: <20250322-perst-v1-0-e5e4da74a204@oss.qualcomm.com>
 <20250322-perst-v1-1-e5e4da74a204@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250322-perst-v1-1-e5e4da74a204@oss.qualcomm.com>

On Sat, Mar 22, 2025 at 08:30:43AM +0530, Krishna Chaitanya Chundru wrote:
> Move the phy, phy-names, wake-gpio's to the pcie root port node instead of
> the bridge node, as agreed upon in multiple places one instance is[1].

You aren't really moving them except in the example. This is an ABI 
break for sc7280. Is anyone going to care?

You need to deprecate the properties in the old location.

> Update the qcom,pcie-common.yaml to include the phy, phy-names, and
> wake-gpios properties in the root port node. There is already reset-gpio
> defined for PERST# in pci-bus-common.yaml, start using that property
> instead of perst-gpio.
> 
> For backward compatibility, do not remove any existing properties in the
> bridge node.
> 
> [1] https://lore.kernel.org/linux-pci/20241211192014.GA3302752@bhelgaas/
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-common.yaml  | 22 ++++++++++++++++++++++
>  .../devicetree/bindings/pci/qcom,pcie-sc7280.yaml  | 18 ++++++++++++++----
>  2 files changed, 36 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
> index 0480c58f7d99..258c21c01c72 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
> @@ -85,6 +85,28 @@ properties:
>    opp-table:
>      type: object
>  
> +patternProperties:
> +  "^pcie@":
> +    type: object
> +    $ref: /schemas/pci/pci-pci-bridge.yaml#
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +      phys:
> +        maxItems: 1
> +
> +      phy-names:
> +        items:
> +          - const: pciephy

Just drop phy-names in the new location. It's pointless especially when 
foo-names is just "${module}foo".

> +
> +      wake-gpios:
> +        description: GPIO controlled connection to WAKE# signal
> +        maxItems: 1
> +
> +    unevaluatedProperties: false
> +
>  required:
>    - reg
>    - reg-names

