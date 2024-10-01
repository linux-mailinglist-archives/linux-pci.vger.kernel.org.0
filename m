Return-Path: <linux-pci+bounces-13697-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD7398C653
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 21:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8A87282FF9
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 19:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B451CDA11;
	Tue,  1 Oct 2024 19:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8JllB+F"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA5119D894;
	Tue,  1 Oct 2024 19:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727812408; cv=none; b=Sfi2QnLk/3mIY774q1hXqgA2N0Q3jzok3Z0C4ZYyFfyzU1uzLxdnN+uZDp/Ze/nJAEjuER9uJJariaK6bulkpeN/tjUXTqeOb2ckgJXMQjOmWrR/dNS+ihKDKSZK450SROMSW9VBUAWmjefPrWkBsOP6hrWw4fev5zuS+2jz2eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727812408; c=relaxed/simple;
	bh=NFLRv70GcTrBbDEnGdZ7KPaDTsv4dzfmExIxAvDu74s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LZsWuCLyAzxNhhX67Avg8d+2b2prIqDqWx4mM3FYGu+zRfSP8dMeS36lxczF5AaJoWY1QlHVzBonYH/+FO5KnZhs4J9PQtEgSfx5reYfRtVFK8KS/50FaP+oQ1aOG23UuUa74CWOjfqMjafmrq86GBdkbx3pUT9Myf0qqIOKp/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8JllB+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6217FC4CEC6;
	Tue,  1 Oct 2024 19:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727812407;
	bh=NFLRv70GcTrBbDEnGdZ7KPaDTsv4dzfmExIxAvDu74s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=b8JllB+FwCHpvRqMibjOaQLSYeg2RtfTiASOqUg1Kue7A1En1PAwde9qglggZjnQi
	 2u2dp3lhAbJL0EF9fKOJz235EukjTume/uFNB2Me8Wnc0kksuPUUY1ZNT8IgJl0qEu
	 XySROYY5RSRQiSwv6vFyucgNHgPnIplRBYXOfaTyIIXWumEULmBS9KF4LjBXFIMR/x
	 ew0h74wXowKXbO1Zh6kxViXZjlpsyIKUx9avnCfhI5hOEJltX1xkFGV1SodyWzBzEb
	 xYb8p8ZehcbO7QavsMzWIv/qIQ6PdwB90WBtXW13t4Sc8a0XJnd72JLXMmx7e6SwZf
	 kUTokuBrQoj5A==
Date: Tue, 1 Oct 2024 14:53:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Fei Shao <fshao@chromium.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: PCI: mediatek-gen3: Allow exact number
 of clocks only
Message-ID: <20241001195325.GA222000@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925110044.3678055-3-fshao@chromium.org>

On Wed, Sep 25, 2024 at 06:57:46PM +0800, Fei Shao wrote:
> In MediaTek PCIe gen3 bindings, "clocks" accepts a range of 1-6 clocks
> across all SoCs. But in practice, each SoC requires a particular number
> of clocks as defined in "clock-names", and the length of "clocks" and
> "clock-names" can be inconsistent with current bindings.
> 
> For example:
> - MT8188, MT8192 and MT8195 all require 6 clocks, while the bindings
>   accept 4-6 clocks.
> - MT7986 requires 4 clocks, while the bindings accept 4-6 clocks.
> 
> Update minItems and maxItems properties for individual SoCs as needed to
> only accept the correct number of clocks.
> 
> Fixes: c6abd0eadec6 ("dt-bindings: PCI: mediatek-gen3: Add support for Airoha EN7581")
> Signed-off-by: Fei Shao <fshao@chromium.org>

It looks like most changes to this file have been merged via the PCI
tree.  I don't see dependencies on this in the rest of the series, so
I'm happy to take this via PCI if it makes sense.  Or if you prefer
that this be merged with the rest of the series, that's fine and you
can add my:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Let me know if I should pick this one up.

> ---
> 
>  .../devicetree/bindings/pci/mediatek-pcie-gen3.yaml          | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> index 898c1be2d6a4..f05aab2b1add 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -149,7 +149,7 @@ allOf:
>      then:
>        properties:
>          clocks:
> -          minItems: 4
> +          minItems: 6
>  
>          clock-names:
>            items:
> @@ -178,7 +178,7 @@ allOf:
>      then:
>        properties:
>          clocks:
> -          minItems: 4
> +          minItems: 6
>  
>          clock-names:
>            items:
> @@ -207,6 +207,7 @@ allOf:
>        properties:
>          clocks:
>            minItems: 4
> +          maxItems: 4
>  
>          clock-names:
>            items:
> -- 
> 2.46.0.792.g87dc391469-goog
> 

