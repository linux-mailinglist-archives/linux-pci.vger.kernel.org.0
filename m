Return-Path: <linux-pci+bounces-31771-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFBBAFEA29
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 15:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2546644F1B
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 13:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4316A2E49A4;
	Wed,  9 Jul 2025 13:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daa2njfv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C152D3EFF;
	Wed,  9 Jul 2025 13:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067492; cv=none; b=hZ5wiULS4OaRIyAnKI2vc/L6ZfeUXwpN+p22zfnrjCNsFtHWAmjoz5ot31aBiFwn7X75WMsfmH2oCfAcxBIh4ctzSww/bRT8mvbPb5iOzSRb9oTzrDl5EEsOU+587XTZ5kYgmX7Vp+4fikqHZcf8vU/3I90v3x5xjnjHTV1XoEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067492; c=relaxed/simple;
	bh=WCdeg512n7u0cYs8soM74LBJQEoLwV928d5GHL9redY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rk3lr8uHGZWiflXzINiACRVG2h3Ac6xRmUJDKqXX/0mgaA/DquLRQR96UJDjuZpH15hbbtTQQ2PrSmIrVw2E6MSzrg8kVJFpPXdiSjCzbk0iLzrO2kvb7a1Ar2nhcMahsg+ek5hJvA+e4eE7ywviCpAl44GAVRO6x4ti/rFjxxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daa2njfv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69982C4CEEF;
	Wed,  9 Jul 2025 13:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752067491;
	bh=WCdeg512n7u0cYs8soM74LBJQEoLwV928d5GHL9redY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=daa2njfv+WZNVqfEWPj7nNEdKg0R9rUe8W+gAG9pzoDGWAyQ3uD6ME3saw+esFTdf
	 Rt3Gp7miu7zq71+O8mKdojUijnJ0fe82W+0Um9afNSvZulMKuqzwhmH+GyyS8S7ZFv
	 9an8Fz5OzWMeSQQ9S84xPde5eK4HUNerE9GD43X1sbhl86eTzMq+eKInNJM3jekOi0
	 WIk6f14cRbB/FhF8IwzwbTzMyy/7NYpYPNQglLTE80eYucCI+aiiePL9aQAN6a8VEU
	 PHKJ1mfcwRO3TxqetXiP/6qg6YXIQu+8l63T24yi8N/NDIklzDPvhUiTRIA353VXwJ
	 QQoip09fhKSwQ==
Date: Wed, 9 Jul 2025 08:24:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Claudiu <claudiu.beznea@tuxon.dev>, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	catalin.marinas@arm.com, will@kernel.org, mturquette@baylibre.com,
	sboyd@kernel.org, p.zabel@pengutronix.de, lizhi.hou@amd.com,
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v3 4/9] dt-bindings: PCI: renesas,r9a08g045s33-pcie: Add
 documentation for the PCIe IP on Renesas RZ/G3S
Message-ID: <20250709132449.GA2193594@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f3863b5-eb7c-494e-951c-feb257bbaecf@kernel.org>

On Wed, Jul 09, 2025 at 08:47:05AM +0200, Krzysztof Kozlowski wrote:
> On 08/07/2025 18:34, Bjorn Helgaas wrote:
> > On Fri, Jul 04, 2025 at 07:14:04PM +0300, Claudiu wrote:
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> The PCIe IP available on the Renesas RZ/G3S complies with the PCI Express
> >> Base Specification 4.0. It is designed for root complex applications and
> >> features a single-lane (x1) implementation. Add documentation for it.
> > 
> >> +++ b/Documentation/devicetree/bindings/pci/renesas,r9a08g045s33-pcie.yaml
> > 
> > The "r9a08g045s33" in the filename seems oddly specific.  Does it
> > leave room for descendants of the current chip that will inevitably be
> > added in the future?  Most bindings are named with a fairly generic
> > family name, e.g., "fsl,layerscape", "hisilicon,kirin", "intel,
> > keembay", "samsung,exynos", etc.
> > 
> 
> Bindings should be named by compatible, not in a generic way, so name is
> correct. It can always grow with new compatibles even if name matches
> old one, it's not a problem.

Ok, thanks!

I guess that means I'm casting shade on the "r9a08g045s33" compatible.
I suppose it means something to somebody.

Bjorn

