Return-Path: <linux-pci+bounces-23477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D5BA5D7E7
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 09:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 963543A39DA
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 08:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058A2230BFB;
	Wed, 12 Mar 2025 08:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c88Tynug"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E112309AA;
	Wed, 12 Mar 2025 08:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741767082; cv=none; b=W2PH+DWl81wqHjEBH2ShGT3u4AnfzEi5zaq+r26jXGSu6C6woPG8cnyKwYuLh2+4fzjYSaBr2rbtunXG/f0h/KtK9BWp3V2A4yIsViI7YRywMrj7YUYdgkiX/pbwx8tpOVkHhJDOJMp9WVqzTQSSOgCXPq3sBSxOYlFuDb79Fu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741767082; c=relaxed/simple;
	bh=d0Luv00eOwF4pCo4R9zwkFMKjuOCPFsKc/aV56dU+Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fl1gVq+AxOJL2Q2JHgWYr6Hb2xb4fp9ZIxBEMSOXfMOC9By/G05C7RSl4W36toFGWfCeZL/05irgg+CWgwAun9C5as09IP3PXAbRC8XVknmEwyy7iSFfLHqk1gJYPXka5lYwIKGVR+CdSvEFOzmEhC/gegqvuK6WQqTAX30AIkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c88Tynug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E1EC4CEE3;
	Wed, 12 Mar 2025 08:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741767082;
	bh=d0Luv00eOwF4pCo4R9zwkFMKjuOCPFsKc/aV56dU+Xk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c88TynugszjyEah7y9kRUh37Hp8q+bLLG4Hx2s3DZPttwUO1xAWa/D3CJposk+jae
	 017WnxgNy6ddLxZ+AvcRXsjwVq97Cztj0jKuMhSQrftlwcQVB3JV/Q+PaVzQywf1c5
	 JumnebaCky8RX6N5rB5//GyyI3G0/1AXvQLzXbo4Otk8Qh6OOhWPdhiKgiJT4g7geO
	 BNN8sfY3sVk30qDU+jQ2eOjhE0Ke7oOOP2kHqyKzF55YhWpGag58aSNUWpUbRIAD6k
	 II/44ArIFOIVmi9jQ7QUo31QuxuqYy1JKFGUDxaUqFVlcZxvOAiCo7ENtdLFPQz06m
	 8KxE78JGI+43Q==
Date: Wed, 12 Mar 2025 08:11:17 +0000
From: Lee Jones <lee@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: soc: airoha: Add the pbus-csr node for
 EN7581 SoC
Message-ID: <20250312081117.GJ8350@google.com>
References: <20250311-en7581-pbus_csr-binding-v2-1-1fc5b5e482e3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250311-en7581-pbus_csr-binding-v2-1-1fc5b5e482e3@kernel.org>

dt-bindings: mfd: syscon: Add the pbus-csr node for Airoha EN7581 SoC

> Introduce pbus-csr document bindings in syscon.yaml for EN7581 SoC.
> The airoha pbus-csr block provides a configuration interface for the PBUS
> controller used to detect if a given address is accessible on PCIe
> controller.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes in v2:
> - Move EN7581 pbus-csr binding in syscon.yaml
> - Link to v1: https://lore.kernel.org/r/20250308-en7581-pbus_csr-binding-v1-1-999bdc0e0e74@kernel.org
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index 4d67ff26d445050cab2ca2fd8b49f734a93b8766..7639350e7ede40c8934f41f854ff219354fb3e5b 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -27,6 +27,7 @@ select:
>      compatible:
>        contains:
>          enum:
> +          - airoha,en7581-pbus-csr
>            - al,alpine-sysfabric-service
>            - allwinner,sun8i-a83t-system-controller
>            - allwinner,sun8i-h3-system-controller
> @@ -126,6 +127,7 @@ properties:
>    compatible:
>      items:
>        - enum:
> +          - airoha,en7581-pbus-csr
>            - al,alpine-sysfabric-service
>            - allwinner,sun8i-a83t-system-controller
>            - allwinner,sun8i-h3-system-controller
> 
> ---
> base-commit: d71fc910c58ed85a2ad5143502030bff73fc2088
> change-id: 20250308-en7581-pbus_csr-binding-974e1b40fb36
> 
> Best regards,
> -- 
> Lorenzo Bianconi <lorenzo@kernel.org>
> 

-- 
Lee Jones [李琼斯]

