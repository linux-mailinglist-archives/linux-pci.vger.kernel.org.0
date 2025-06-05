Return-Path: <linux-pci+bounces-29059-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8726ACF98F
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 00:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490883AF56F
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 22:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F7927FB1E;
	Thu,  5 Jun 2025 22:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBWIQJ9Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20F317548;
	Thu,  5 Jun 2025 22:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749161591; cv=none; b=SGByqheaefbEH+O4Zn/kVbxJcSlI/tvyG/fyAa+9JA921DjvRlspY2ZBYy5F268HM/nnzbh/z9doRTCbBM3+I4c8MeCbtx+6OygcLEMbMvNOAH9DdPeLWOH+eN6zm0tqlLl9GMblmnM/6urToL9CuUeDZb1jSWPce8Pz9KF3F1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749161591; c=relaxed/simple;
	bh=BLfA4ZAVbtNmh+Wd7A/4kqT3/Wp/5XmJ0077S+Wl6Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=siO+jERNixEXVxug5c50BLqkFQhwLOJ4HFPxGlhd0W1sd2np+VW9KVnRAmiZ/pwpxdrCjqv5xErUs2I/BR2ozhT7esBQUQpxNzNAFNgqnLUxCffjgQuKDSsTcWVGG7hSc7Bq7rK5iIIXsoWPrdG1fN9gBHpnHvvnxFZa281iIfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBWIQJ9Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E845EC4CEE7;
	Thu,  5 Jun 2025 22:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749161591;
	bh=BLfA4ZAVbtNmh+Wd7A/4kqT3/Wp/5XmJ0077S+Wl6Uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JBWIQJ9QhBXQmamEEFJUAvjxOnHvxneQRcEYEpoBNI1H553B5myDsXEI4gWfpaNia
	 /HecHxWS+MrSqUXmngyI4NHxzDJxDzuJkpJrEGlXp0kUtmImsD44mBjhdArwuQZDzS
	 tp4CxQWsylneH02xA7bhDNe6imKa5AkSbl+waWJaHHqEZ1nLfjMUaEtg/xVRXSq5Q7
	 L0CUU/4LvfROVZlmQaK44sjOHikKhd7dVOcKe03ZW4lz6ETWFVkWpJlyfEkei5GW3K
	 E+YOtGwX/Wy/hrzo+aW89OBT9SAW+xQyG+HrVNWJZsMAYHuvFmh7L/cGxh/hZzic/p
	 Xsm1ojDqrfAyQ==
Date: Thu, 5 Jun 2025 17:13:08 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: conor+dt@kernel.org, geert+renesas@glider.be,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	mturquette@baylibre.com, lpieralisi@kernel.org,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
	magnus.damm@gmail.com, john.madieu.xa@bp.renesas.com,
	linux-pci@vger.kernel.org, kw@linux.com, bhelgaas@google.com,
	krzk+dt@kernel.org, devicetree@vger.kernel.org,
	manivannan.sadhasivam@linaro.org, sboyd@kernel.org
Subject: Re: [PATCH v2 3/8] dt-bindings: PCI: renesas,r9a08g045s33-pcie: Add
 documentation for the PCIe IP on Renesas RZ/G3S
Message-ID: <174916158571.3344975.11147858201870776077.robh@kernel.org>
References: <20250530111917.1495023-1-claudiu.beznea.uj@bp.renesas.com>
 <20250530111917.1495023-4-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530111917.1495023-4-claudiu.beznea.uj@bp.renesas.com>


On Fri, 30 May 2025 14:19:12 +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The PCIe IP available on the Renesas RZ/G3S complies with the PCI Express
> Base Specification 4.0. It is designed for root complex applications and
> features a single-lane (x1) implementation. Add documentation for it.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 
> Changes in v2:
> - update the interrupt names by dropping "int" and "rc" string; due
>   to this the patch description was adjusted
> - added "interrupt-controller" and made it mandatory
> - s/clkl1pm/pm/g
> - dropped the legacy-interrupt-controller node; with this the gic
>   interrupt controller node was dropped as well as it is not needed
>   anymore
> - updated interrupt-map in example and added interrupt-controller
> - added clock-names as required property as the pm clock is not
>   handled though PM domains; this will allow the driver to have
>   the option to request the pm clock by its name when implementation
>   will be adjusted to used the pm clock
> - adjusted the size of dma-ranges to reflect the usage on
>   SMARC module board
> - moved "renesas,sysc" at the end of the node in example to align
>   with dts coding style
> 
>  .../pci/renesas,r9a08g045s33-pcie.yaml        | 202 ++++++++++++++++++
>  1 file changed, 202 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/renesas,r9a08g045s33-pcie.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


