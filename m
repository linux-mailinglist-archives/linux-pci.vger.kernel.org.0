Return-Path: <linux-pci+bounces-19210-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B91A00684
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 10:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B84B7A1736
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 09:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A80E1C5F3C;
	Fri,  3 Jan 2025 09:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POvx8f3x"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D59418A950;
	Fri,  3 Jan 2025 09:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735895457; cv=none; b=maSoMkODOxj4/FkHM+cgqtj62FTfvAZ1Ash1gmuNKsvnbIzWm7nhL58ER+NZBKOaxBRXwzsi6VuYmLQqAsCION9A3RRiVoTgh5Nblv0TYkcApVc+jZuAl/n1Njxi2F3fzADBoIvDPsAIRtuSHdSSLRAE/rJIytnxZJxlCOJQcNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735895457; c=relaxed/simple;
	bh=g4yapdXI+l0EgvPcvBnHQ+oGbw0TIJA2mVOnFMmAxL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRZanrsJqB14yCtDGeZRl6cCSmhHefyPwVI5Xpxg/irOwLrXDv7cGCywUGIZqQZvKKizXTkWArvn1jgSzZZe8hOfdDz1cOk3UQNkfKQNM66fISj9AKSJZdXOvpwR7bVH3L8vrI/mbu1yPCK0VqnG9o0vfH0ehrh4MqbPhq/eUds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POvx8f3x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733F8C4CECE;
	Fri,  3 Jan 2025 09:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735895457;
	bh=g4yapdXI+l0EgvPcvBnHQ+oGbw0TIJA2mVOnFMmAxL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=POvx8f3xZItDhKn/eWkorSk5VxsPGdhFkStm07SKBO1ZFtBowKehMtVeUbpr96zhl
	 Wn7M8ABJeIYND0JJ7+acCuiqplpILMU9rLSMuaa2JXCt4z32u3EBEb0JQUax8f6e44
	 MSDRxSBegPG0V2D1M8AHBay+N9a/kaXw8uSi5znNLI1pbobpLVCe5UKRtp3I9mIG6s
	 eniJtKy26EetRbVpnto75BWoKs0x3X+zR2HhoWvqr3z2QFgGw2RbHuqqJWGNPtGdTj
	 A0fqozMcFDOjkkbLJfgRpH34ATxvAFpvPJVbnLKKikPfn5vubgqQAhFZ0Py8hHpcpU
	 u7r1XX4KBAM+w==
Date: Fri, 3 Jan 2025 10:10:53 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jianjun Wang <jianjun.wang@mediatek.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Ryder Lee <ryder.lee@mediatek.com>, linux-pci@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Xavier Chang <Xavier.Chang@mediatek.com>
Subject: Re: [PATCH 1/5] dt-bindings: PCI: mediatek-gen3: Add MT8196 support
Message-ID: <ndj6j2mmylipr7mxg42f3lcwgx55cvcjnuuofmlk6n6t5uz5pr@bxugolyfublc>
References: <20250103060035.30688-1-jianjun.wang@mediatek.com>
 <20250103060035.30688-2-jianjun.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250103060035.30688-2-jianjun.wang@mediatek.com>

On Fri, Jan 03, 2025 at 02:00:11PM +0800, Jianjun Wang wrote:
> +        clock-names:
> +          items:
> +            - const: pl_250m
> +            - const: tl_26m
> +            - const: peri_26m
> +            - const: peri_mem
> +            - const: ahb_apb
> +            - const: low_power
> +
> +        resets:
> +          minItems: 1
> +          maxItems: 2
> +
> +        reset-names:
> +          minItems: 1
> +          maxItems: 2

Why resets are flexible?

Best regards,
Krzysztof


