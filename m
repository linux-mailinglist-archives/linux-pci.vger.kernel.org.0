Return-Path: <linux-pci+bounces-36860-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F01F2B9A249
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 16:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40A9322473
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 14:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04442066F7;
	Wed, 24 Sep 2025 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJllzpq4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF15CA6F;
	Wed, 24 Sep 2025 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758722638; cv=none; b=un/b1sqEu9MjAx9Wu/14LJZt/dgmyYiL3yluFbsMgW39ZYLajMQEn5s8MqMxWWRgxKHbNoKlepLbVxAqDVsFQo7QQ6ZodhiEX9+5Am4cM0Wyk0nSLaHhhUYhqDZjPIHRZpLA13O9SGkTpnZJreGqk1tPUZwmvnfULgbEFJzkklk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758722638; c=relaxed/simple;
	bh=uM6uSHTCjPtmI3Vzh1PPevWg0rMMV9zNEDAVmqFGGZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUMauiMPnJMB+hpVRM/jXBTVSSeozhMysG5ZQohx1VUfT5v3HK7koWBxrRGtZk0k3f0xNmqy8ga0cAR1Xi+XGzV6Iwv6TdFBDiuUWBMUlVPoZZCGj0AsQppVBl/wN8zPmNreV4NpBUbrhxWCjNc0nG4mq0RyT5lQ59wl+YhpOas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJllzpq4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01256C4CEF0;
	Wed, 24 Sep 2025 14:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758722638;
	bh=uM6uSHTCjPtmI3Vzh1PPevWg0rMMV9zNEDAVmqFGGZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sJllzpq4tR6nKD3tdPKsC7Asro+AUPMGKQItIJNnFv3n8cxUL9XcM+EFV2RrItwhY
	 3nXj3OuDrF8+yWvyozb58DKmtJ47vJ4hqAUVcnIvZWfB35VE2WU4yEGXk/g9JPJHjv
	 4Rq1uZKXZve+G4awVv9ynerQnOaynp6X7wB/BBKyFhqUgn8Mou+UkEFmrW1GKjUbC3
	 vSgjyjb8V3QWi7hZ7LdxQbaL1BCRI41uZV/hMwBqR1sD/PpCUDs/0NCQ+zYAkynP9F
	 anjcYsFg8AbwWAWHb37Vaa/hysBAeX+YhWgH7FZrpvpBKfo43hGbKv4Rc8cEoar9LP
	 vo5h90Y2c7ADg==
Date: Wed, 24 Sep 2025 09:03:47 -0500
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH v2 1/4] dt-bindings: clock: mediatek: Fix wrong
 compatible list for hifsys YAML
Message-ID: <20250924140347.GA1556090-robh@kernel.org>
References: <20250923201244.952-1-ansuelsmth@gmail.com>
 <20250923201244.952-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923201244.952-2-ansuelsmth@gmail.com>

On Tue, Sep 23, 2025 at 10:12:29PM +0200, Christian Marangi wrote:
> While converting the hifsys to YAML schema, the "syscon" compatible was
> dropped for the mt7623 and the mt2701 compatible.

Is "syscon" really needed? AFAICT, the clock and reset drivers don't 
need it.

> 
> Add back the compatible to mute DTBs warning on "make dtbs_check" and
> reflect real state of the .dtsi.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml
> index 9e7c725093aa..aa3345ea8283 100644
> --- a/Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml
> +++ b/Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml
> @@ -16,13 +16,15 @@ maintainers:
>  properties:
>    compatible:
>      oneOf:
> -      - enum:
> -          - mediatek,mt2701-hifsys
> -          - mediatek,mt7622-hifsys
> +      - items:
> +          - const: mediatek,mt2701-hifsys
> +          - const: syscon
> +      - const: mediatek,mt7622-hifsys
>        - items:
>            - enum:
>                - mediatek,mt7623-hifsys
>            - const: mediatek,mt2701-hifsys
> +          - const: syscon
>  
>    reg:
>      maxItems: 1
> -- 
> 2.51.0
> 

