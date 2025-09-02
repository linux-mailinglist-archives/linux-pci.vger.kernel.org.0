Return-Path: <linux-pci+bounces-35340-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5EAB40F06
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 23:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D503B089E
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 21:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72C93093A5;
	Tue,  2 Sep 2025 21:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxnXewTT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65EC2E8B92;
	Tue,  2 Sep 2025 21:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756847270; cv=none; b=kuBl5g3lCs0pQwjvHBMD+GkKVW0mCWVeXnUzb5uOQCH3ddMERYw1Q5VeVq8S3DD6ZrPkKcJqbYcPJlbXP6HcuDeRG3ml8k5CAKGcCNQ5wBjVzyGN8wCRcYwTrcGabD+2yaw0y/ZoMK5Xk36JHARj3E8dRO7Ztfc74IywzvMFGH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756847270; c=relaxed/simple;
	bh=9luCV5wJ7yhlC3yg/FU3fC2wBmgdOhCw1dNsvVhR9Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGZ89mjST8QgrWHzzvbbpYiDhspPGpBYT2wUw4KlRyHXo3bPhII36QzLFiNtnE6V7g/8ah3ocfymhe1r/ea8F55+LbdThv8fM4iwMR6frGcuTg3WhLhLH+VDxNGW7XNzLlT0D733QJSZyE1c3YCirEMRFBQ2AGWFc2KSbP8UPSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxnXewTT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7E9C4CEED;
	Tue,  2 Sep 2025 21:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756847270;
	bh=9luCV5wJ7yhlC3yg/FU3fC2wBmgdOhCw1dNsvVhR9Gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JxnXewTTWw6LCguvMQAYfSS+fRbXyCatwmElT4fUFOzGF9/BkV1YqpVOHxT39Zudo
	 WaQV5PYFVZk9ZEs82zoBxj0Cj82h3+QEKCineK7pc2x4k/WzfPeNazBLRPoUv+EmXH
	 aWzxTAcZ1mR67eAFwippzDSsDhT3ylhGLa8naxoD22lYW/xW9hWt1i4p6l5tulTvZS
	 ugBXu9ZYIBH04U+RSzsJNFz/m7L01NueVWKbq+8Um5eDhtvJlBRAWEScWr8QYgkCfR
	 LTu161GIoOH+wtN06Tn0z1zoYEqWEXjwRHTflkCH5c3oAaSz7GtYZ5ukXvVpBVXuXd
	 wsYCz+LwBo3/w==
Date: Tue, 2 Sep 2025 16:07:49 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org, joel@jms.id.au,
	linux-aspeed@lists.ozlabs.org, conor+dt@kernel.org,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	krzk+dt@kernel.org, mani@kernel.org, kishon@kernel.org,
	lpieralisi@kernel.org, openbmc@lists.ozlabs.org,
	p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
	kwilczynski@kernel.org, vkoul@kernel.org, linus.walleij@linaro.org,
	andrew@codeconstruct.com.au, linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 02/10] dt-bindings: phy: aspeed: Add ASPEED PCIe PHY
Message-ID: <175684726867.1179507.1325689582067833868.robh@kernel.org>
References: <20250901055922.1553550-1-jacky_chou@aspeedtech.com>
 <20250901055922.1553550-3-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901055922.1553550-3-jacky_chou@aspeedtech.com>


On Mon, 01 Sep 2025 13:59:14 +0800, Jacky Chou wrote:
> Introduce device-binding for ASPEED AST2600/2700 PCIe PHY.
> The PCIe PHY is used for PCIe RC to configure as RC mode.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  .../bindings/phy/aspeed,ast2600-pcie-phy.yaml | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/aspeed,ast2600-pcie-phy.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


