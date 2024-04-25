Return-Path: <linux-pci+bounces-6668-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B158B259E
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 17:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F1928351C
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 15:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C524114B098;
	Thu, 25 Apr 2024 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g++mn+dY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1461CF8A;
	Thu, 25 Apr 2024 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714060171; cv=none; b=tqff6NZNg0lJlTN4aHNqtMQzWVn2a2GvaY5nQZq+F8iXHPX0Lb4/ccic6/PG/rjycA6bAdkMfNNHiej52gMMiAa4pxsQVyqk8qrZcQNSxGBqJwWYIKUpOqOWxAgylK3adBV1tcc3+z7sfTw0vdKZsXgPIb/v7KgWa3JY3SYzjSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714060171; c=relaxed/simple;
	bh=5YBMbBgmJq7CbTxFHE0N9JXI6gpr/AGXcaI74d6pkxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMzRRNHx2hvmJ0K5d27Bf7Ycsdg7Et4PvM5/Uv3bTrORU+Jo7q9hgiQMXeVhn69dxN5pJgUrdObt8FmV5ocpbZpVf/3atHKd9/OuvWtHWpx6bT0HdxYyufZaP9qdHqq/W1wScpJRJ9jh4wFKB6Rdt2/wTjk5bLGk65M/PYDHueo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g++mn+dY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365C7C113CC;
	Thu, 25 Apr 2024 15:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714060170;
	bh=5YBMbBgmJq7CbTxFHE0N9JXI6gpr/AGXcaI74d6pkxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g++mn+dYfTbUVEDSLMzG4azF7CrCj+5myw18jIjhJzBWGNv5oyvChIhV2Lp/VebHa
	 ahptCo6Nt3L2GlW7OuXlkzkVHXjHmtf62xX2xBErYu9dbj7dbc9UY2uXAu5XyVcR5D
	 t12IfN+g8uUPiHyMmQyeWKnSyfYc4pZ52BFAAHfs3lxzaj2jy2j08ARmNM0fk+S8wB
	 tnCedI8hs7byei1z8DwszsIiayc3AuodHn5D3k8pguGNi+xYXdf7Ue2YhvJUw2f21c
	 E78iKaHd2ntNwHIa7/R0GDwDDd/EOK6l9wSgL6rsK1KAvWGMZl86hLh+ouOb1WA9zi
	 v20W42zf7zlIA==
Date: Thu, 25 Apr 2024 10:49:28 -0500
From: Rob Herring <robh@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 01/12] dt-bindings: PCI: snps,dw-pcie-ep: Add vendor
 specific reg-name
Message-ID: <20240425154928.GA2600809-robh@kernel.org>
References: <20240424-rockchip-pcie-ep-v1-v1-0-b1a02ddad650@kernel.org>
 <20240424-rockchip-pcie-ep-v1-v1-1-b1a02ddad650@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424-rockchip-pcie-ep-v1-v1-1-b1a02ddad650@kernel.org>

On Wed, Apr 24, 2024 at 05:16:19PM +0200, Niklas Cassel wrote:
> Considering that some drivers (e.g. pcie-dw-rockchip.c) already use the
> reg-name "apb" for the device tree binding in Root Complex mode
> (snps,dw-pcie.yaml), it doesn't make sense that those drivers should use a
> different reg-name when running in Endpoint mode (snps,dw-pcie-ep.yaml).
> 
> Therefore, since "apb" is already defined in snps,dw-pcie.yaml, add it
> also for snps,dw-pcie-ep.yaml.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> index bbdb01d22848..00dec01f1f73 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> @@ -100,7 +100,7 @@ properties:
>              for new bindings.
>            oneOf:
>              - description: See native 'elbi/app' CSR region for details.
> -              enum: [ link, appl ]
> +              enum: [ apb, link, appl ]

This section is for existing bindings. IOW, don't use or add to them 
for new users. New users should "See native 'elbi/app' CSR region".

Rob

