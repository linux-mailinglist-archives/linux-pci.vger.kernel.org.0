Return-Path: <linux-pci+bounces-12208-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FD195F604
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 18:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D1B1F22639
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 16:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEA4186619;
	Mon, 26 Aug 2024 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzA1AV4E"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958F53399B;
	Mon, 26 Aug 2024 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724688361; cv=none; b=gNoP1RcZv6GuZZaBlbg2eXAgzrfd5zccR0MNfhWkLru+tvExGNntIYnl6cU53e8eDHDXtV/1fwA0fY+lsNoiZZleUK/FwWeASal6tC9tkkPp+PXvMTX3txXMdbnlpDYBxppQYEcxNjJymPAlbNLLC205xMLk/z4v4IIiRJ3h/dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724688361; c=relaxed/simple;
	bh=rHgsDp8NHOjUYGG5EOYCAoOlRp3YElv2cslA4XhFKGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfQgVald0Vcn/vWUSQKUtDEU2BscOo70//NIJ1VMcICqb328kJ7xiR9DlUzeDCkWhlj2O1FZWGkUl+DKaNMIdxYR6sjn79uDKgvbAjZ1L48fsq2ZrzGJfWX2u2UkIDzaKZao0OhAGC3I76Vm84Wzwbrx2QSk3EAv6+LOQFZ6Y8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzA1AV4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8951C51431;
	Mon, 26 Aug 2024 16:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724688361;
	bh=rHgsDp8NHOjUYGG5EOYCAoOlRp3YElv2cslA4XhFKGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KzA1AV4EqP5pJbJHjAnB2UxiRjwG60CKlCMAsX7xeW2GE4/cgLhW4tXcz0Q8+xHaE
	 FOhLCMsDUgI3BYSBkTRYB/GNB8nG90ssbKKuUMQxEIWmQhxyE3tra4lVKEhrDA7hz5
	 tZ1cOdsyG+FkwbLa2ttvurosymay93MpdEggVjYw+olEJKalPkNZ1tnx03DUF3UAE8
	 ae5W/PN+7Dg8Czq7We8s2z83mAySVrbNckQSKxy4NXv220kWmG+WLfqY5I3hO3SDkY
	 lVUE2fgomLHjDvGcJ69AmNUHCRiGCKVw2Bo6ShUpGQAEusKiTtRUu2sWY/4MiNJXGQ
	 To+AIzvmNj6AA==
Date: Mon, 26 Aug 2024 11:05:58 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 1/1] dt-bindings: PCI: layerscape-pci: Fix property
 'fsl,pcie-scfg' type
Message-ID: <172468828846.439237.5196709203960217370.robh@kernel.org>
References: <20240701221612.2112668-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701221612.2112668-1-Frank.Li@nxp.com>


On Mon, 01 Jul 2024 18:16:12 -0400, Frank Li wrote:
> fsl,pcie-scfg actually need an argument when there are more than one PCIe
> instances. Change it to phandle-array and use items to describe each field
> means.
> 
> Fix below warning.
> 
> arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: pcie@3400000: fsl,pcie-scfg:0: [22, 0] is too long
>         from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie.yaml#
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change form v2 to v3
> - remove minItems because all dts use one argument.
> Change from v1 to v2
> - update commit message.
> ---
>  .../devicetree/bindings/pci/fsl,layerscape-pcie.yaml       | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

It's been 2 months and no response to multiple pings, so I applied it.

Rob

