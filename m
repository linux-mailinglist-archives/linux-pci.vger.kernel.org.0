Return-Path: <linux-pci+bounces-10805-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C0693C9C8
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 22:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C273B21038
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 20:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49E913C661;
	Thu, 25 Jul 2024 20:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+S4necl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E5646522;
	Thu, 25 Jul 2024 20:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721940223; cv=none; b=WjZgiZqGdXSQP6xrZZo8iWdw+qw5WRudMN9ULXx63RoCaAU/UXL+CWRTeRcz4jpfLlWlgdx3vj2ANuILagZQdpkg9Hobs0pkEIsWrgfcy9pPRoMF721bD3Il45GG+o06oJTgdK+X/WPc5t/0571tu5PTjrzw687Hs4Q72Zp2+Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721940223; c=relaxed/simple;
	bh=PheuDERKJnugU8Ztha0lFkJDmsZb03WuJNNHt+R+zx8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TCZrHnVHcursuVnkr/0qX/Pf/Mlhdhc1cJHd0h577mHce0LzZ8y2uyV308s9WAeneyq5L0p1h9rApsuXzpMX1mBeKvo64D7aIjuZOFnwtLaCPkjMEl31baRuE0k7Ogb1ijCNOwhZW1fsQbme/pKgmbz+QGn0gsZjR4wzUmITSpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+S4necl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2541FC116B1;
	Thu, 25 Jul 2024 20:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721940223;
	bh=PheuDERKJnugU8Ztha0lFkJDmsZb03WuJNNHt+R+zx8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=C+S4neclishfSM5QkP5VqCuP7cyQBhqw4nUvoi+uOyDr3TmjIOl37LaR/w09cOnwh
	 u3yG1GvVG+v86AdfpY+oS8Zzv2dYj6L8QibthYevJfjJhGwIl9EHFG5GuLCnxruHkQ
	 41t/PPUI60T3rTmDEjRKU08axt6hcjvtYRQNDXNBdENEvlmt64sz+g8r6+yeao58V8
	 c03BaSWrYyQYC63pxG2kJ/RlBflsu2hswYx7nnHHV2YPCeyrQSf0GCwIuZK+I5uB4v
	 ZSQAV1IgC8IBVc/LY3dr+uN6CPIpqLnxGjb4wBabrp9JPypzuJZvy17BbCZz4PZ4LJ
	 99DsyYIBi5IkA==
Date: Thu, 25 Jul 2024 15:43:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, l.stach@pengutronix.de,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, imx@lists.linux.dev
Subject: Re: [PATCH v3 0/4] Add dbi2 and atu for i.MX8M PCIe EP
Message-ID: <20240725204341.GA858380@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1721892916-5782-1-git-send-email-hongxing.zhu@nxp.com>

On Thu, Jul 25, 2024 at 03:35:12PM +0800, Richard Zhu wrote:
> v3 changes:
> - Refine the commit descriptions.
> 
> v2 changes:
> Thanks for Conor's comments.
> - Place the new added properties at the end.
> 
> Ideally, dbi2 and atu base addresses should be fetched from DT.
> Add dbi2 and atu base addresses for i.MX8M PCIe EP here.
> 
> [PATCH v3 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and "atu"
> [PATCH v3 2/4] dts: arm64: imx8mq: Add dbi2 and atu reg for i.MX8MQ
> [PATCH v3 3/4] dts: arm64: imx8mp: Add dbi2 and atu reg for i.MX8MP
> [PATCH v3 4/4] dts: arm64: imx8mm: Add dbi2 and atu reg for i.MX8MM
> 
> Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml | 13 +++++++++----
> arch/arm64/boot/dts/freescale/imx8mm.dtsi                    |  8 +++++---
> arch/arm64/boot/dts/freescale/imx8mp.dtsi                    |  7 +++++--
> arch/arm64/boot/dts/freescale/imx8mq.dtsi                    |  8 +++++---
> 4 files changed, 24 insertions(+), 12 deletions(-)

For all the patches in this series, can you please:

  - Separate paragraphs with blank lines so we know where they end.

  - Wrap commit log to fill 75 columns.

