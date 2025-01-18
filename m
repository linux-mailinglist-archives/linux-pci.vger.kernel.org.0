Return-Path: <linux-pci+bounces-20095-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFCCA15DDB
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jan 2025 16:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 032D73A600F
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jan 2025 15:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D0719CC33;
	Sat, 18 Jan 2025 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClB7zK/6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC441422A8;
	Sat, 18 Jan 2025 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737215875; cv=none; b=Vc7aZsuUfcjgHyL2+2r3Jeb9OrSE71Z0LoYlLwaElwvWhVrBLW/MXiVJXpT/GMJ59GfItbpsCYjy2ZHRUuicPINYY5L48zDeR18V7yPHAaKezljYnNefsO8wiGBZbJwOpjFcMmzK1cz/5tB7zHgj0GQzO6wgfNjuWTW/7ploiKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737215875; c=relaxed/simple;
	bh=4ytK8SbKL809jw9xNqlRWkFifpu1ya8ZAlMac3qmV78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijC7kRCY4eWvig38HLkwCSNjqOOppBxqOKFuaqpNUHBvHacqCkaH8slYYJFRLuq147wUw6YHsx3MAPsznbNeqUJDYnB4H70L9FC0cOpEj4CcxO/zaMdloTpuAV8SDa81Pgw6jrXBfN2NQ6YczmMo+VWBjJft+cOn9NCq8uFL+gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClB7zK/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BA1C4CED1;
	Sat, 18 Jan 2025 15:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737215875;
	bh=4ytK8SbKL809jw9xNqlRWkFifpu1ya8ZAlMac3qmV78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ClB7zK/6vDCgsqk05W7936O/L3vfJb8BPrLGIPQD1qKAfhKbVvMxP/V5HtdADgz6K
	 lV9wINjVJkqL1dOda3R+RooYCmmULpiacrl/pRU7S7CK20DgAcoak9WqOxvTPDlJts
	 fA9RaCDmQaKw0ldtKzs0LZVpMr9Qb0jms8MJgbQgS7FCSevr3o+QR2XbLZvYazNpBn
	 99r2rV+m7NsajzGiuvhnZjanpVY6BwmK4ixAQZoEs6TQy3NLiesw6X9CtnkalceQ4c
	 lss0mEMz75naor3b3WlWOLh5BoPbREk9U8la3VWvI7o1D33CDVa24U7SgVl3NLqbtF
	 pl50ISnZffTtQ==
Date: Sat, 18 Jan 2025 16:57:52 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang <jianjun.wang@mediatek.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: airoha: Add the pbus-csr node for
 EN7581 SoC
Message-ID: <20250118-sturgeon-of-incredible-endeavor-73a815@krzk-bin>
References: <20250115-en7581-pcie-pbus-csr-v1-0-40d8fcb9360f@kernel.org>
 <20250115-en7581-pcie-pbus-csr-v1-1-40d8fcb9360f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250115-en7581-pcie-pbus-csr-v1-1-40d8fcb9360f@kernel.org>

On Wed, Jan 15, 2025 at 06:32:30PM +0100, Lorenzo Bianconi wrote:
> This patch adds the pbus-csr document bindings for EN7581 SoC.

Please do not use "This commit/patch/change", but imperative mood. See
longer explanation here:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> The airoha pbus-csr block provides a configuration interface for the
> PBUS controller used to detect if a given address is on PCIE0, PCIE1 or
> PCIE2.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../bindings/arm/airoha,en7581-pbus-csr.yaml       | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/airoha,en7581-pbus-csr.yaml b/Documentation/devicetree/bindings/arm/airoha,en7581-pbus-csr.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..80b237e195cd3607645efe3fda1eb6152134481c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/airoha,en7581-pbus-csr.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/airoha,en7581-pbus-csr.yaml#

arm is only top level bindings and ARM stuff. This is soc.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha Pbus CSR Controller for EN7581 SoC
> +
> +maintainers:
> +  - Lorenzo Bianconi <lorenzo@kernel.org>
> +
> +description:
> +  The airoha pbus-csr block provides a configuration interface for the PBUS
> +  controller used to detect if a given address is on PCIE0, PCIE1 or PCIE2.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - airoha,en7581-pbus-csr

Does not fit standard syscon bindings?

Best regards,
Krzysztof


