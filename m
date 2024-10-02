Return-Path: <linux-pci+bounces-13728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 135E398E42A
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 22:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59371F21F1C
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 20:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4432F2141CF;
	Wed,  2 Oct 2024 20:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuKfeoFJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091828F40;
	Wed,  2 Oct 2024 20:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727901071; cv=none; b=rfd41+iQWB/E/bGo3ID6COGGCzFD1EQmCFHUltCfsLw7CLy1impdp8pKUwRbMDWGvvuZOQ1T1Nk/4qCLFl9oPMxkezTI7hi3swSBw1AtxrjbHv9msmimBPWSwagWUjH0llbYpBj10YC/LZqVlXgAXTlshDsSiBMAheX5+srQJcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727901071; c=relaxed/simple;
	bh=crEUxguLyR8AxI8M3uc/7Ka3HwunEDmQE3TgZ3H+zT4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cCIIw/+4h1gKxpVYahue1sCZbFJeCNgMKPxhhDG0o30+dI0efqBFqtcKkVvSlE+3s1ClgeU7hldgVBYyvUJ2dquTA+o4RPkBJ4ogIdckgWOfohQItT889W30S6lSzBv8ZrxF9qzRquooPv1ettwkAGjS1jkUvk2F6CwD65giyf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuKfeoFJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E57C4CEC2;
	Wed,  2 Oct 2024 20:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727901070;
	bh=crEUxguLyR8AxI8M3uc/7Ka3HwunEDmQE3TgZ3H+zT4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NuKfeoFJedXgQUO3OI7kIvcObLYRqOR3loCgKn1xH3ELmkN3DEREbyHepZjdEc/b5
	 jpEv70VMhCuNxk8OegQfRgznzFDGWy7Z56FxwHz2i6chk53/UJyStYU2+SVRjhlkhJ
	 BA7+XaKhT5SQfkhPHLnbcQG33K1ck0bYtDfMGaOZgeo9c37RY5QOy2OmtvXg3Nn6M+
	 V9syNYBbl6G+aRvCNPsaZuIf1r174ZVTf1WVM/MjIUocQFNUqGKqI3C1YOwiHAUCMq
	 JxyZ5w6RdTfAZVTU3EuWLPEodR6hD4Tvnflb2u+1FljQs2lXb4SO/pjcQVWWlrcqPF
	 I9UcoOw0P37sQ==
Date: Wed, 2 Oct 2024 15:31:08 -0500
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
Message-ID: <20241002203108.GA269428@bhelgaas>
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

This patch only applied to pci/dt-bindings with Krzysztof K's
reviewed-by for v6.13, thank you!

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

