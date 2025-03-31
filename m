Return-Path: <linux-pci+bounces-24998-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA71A76144
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 10:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2E818893CA
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 08:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0E71D5AD4;
	Mon, 31 Mar 2025 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYO4k9nl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6431D514B;
	Mon, 31 Mar 2025 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743409195; cv=none; b=oDBF/SvFXJUHN5B/s6ubRpWzcwdPJE7hLLw4SrEzJn0wvA2+LOigc0yMD4Gi94Z8mPdW9i0eCEQ+Ri2lN0bbt66OLPboyqG+BNMT94hg70DKYQOMM5MUOL7odDnG2FX5rdqQ8py9/WrclzBQxu+lq0UWEju/dq3oBMQqOlb26is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743409195; c=relaxed/simple;
	bh=k7k2/pOIGDeCvNTJE50TOMWYK9qKx/YV3St05Kv63+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+MstOL5XK9LvB/xl2ngc9X19s4P/AInYcMv/Fkd0LZaAkzowewwZfK5RTj488JtJv8q+Ryi8suD1jho5xmDPdtFeK8o5U0HcwGN59sZlIDiYZs9x6TONvQAD1gRwH4pwC/+30rWkofQE/XnqJUFjw0vO+Qw9hAHEvnsZe0u8Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYO4k9nl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD33C4CEEA;
	Mon, 31 Mar 2025 08:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743409194;
	bh=k7k2/pOIGDeCvNTJE50TOMWYK9qKx/YV3St05Kv63+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rYO4k9nl6kCuo8SfsJnxldb3o7ezS9EXsXYjzd6R6CRm6jcHAZxImU+QpOBbehMA4
	 isxoEzsCa3wEGkacepZzACOq/aJHwzhbtp1gIhT8UkU+/TgB90ZCy9TBiJ99oavGAZ
	 o72V3uNSP7BVSKmmzrv4PxXCYiK65kjmbh8xqBqfkPuokbGnYs3Bm5R+ubOyy5Xh00
	 1x6bLWCjFBZHN3JppQunNl5kVBttaPS/9Dy/uc6UHncor+a+HdFrx56C4x9RmBvqRZ
	 F/jWucXhyBgfSfQOT5ryNylz5NSVdLXgajOz9pDC1SQEMyvZcmRns0K16hT7o7oXR2
	 DInck3dgP766g==
Date: Mon, 31 Mar 2025 10:19:51 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Aradhya Bhatia <a-bhatia1@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Heiko Stuebner <heiko@sntech.de>, Junhao Xie <bigfoot@classfun.cn>, 
	Kever Yang <kever.yang@rock-chips.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: PCI: rcar-gen4-pci-host: Document
 optional aux clock
Message-ID: <20250331-excellent-nautilus-of-apotheosis-fbd30a@krzk-bin>
References: <20250330195715.332106-1-marek.vasut+renesas@mailbox.org>
 <20250330195715.332106-2-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250330195715.332106-2-marek.vasut+renesas@mailbox.org>

On Sun, Mar 30, 2025 at 09:56:09PM +0200, Marek Vasut wrote:
> diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> index bb3f843c59d91..5e2624d4c62c7 100644
> --- a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> @@ -46,12 +46,14 @@ properties:
>        - const: app
>  
>    clocks:
> -    maxItems: 2
> +    minItems: 2
> +    maxItems: 3
>  
>    clock-names:

missing minItems: 2

(xxx and xxx-names are always synced in dimensions)

I understand that clock is optional? Your diagram in commit msg suggests
that clock is there always.

Best regards,
Krzysztof


