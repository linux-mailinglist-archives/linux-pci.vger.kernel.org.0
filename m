Return-Path: <linux-pci+bounces-34030-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37281B25E7C
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 10:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3D027A99CC
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 08:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235A52E719A;
	Thu, 14 Aug 2025 08:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmDFlGeu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4F62E610E;
	Thu, 14 Aug 2025 08:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755159220; cv=none; b=Xkf9U+0qzx61G+/to5D77jnL105R3MIHyXVte37Xvq5v6wfrYy228CwIy07qke0qpDC1XhPcBANPuioA/rcc7FF9X6pIK33hKFalws4bZwBAYVO+6fk9mTIOi9//tgFJLsiEHZp8jwRDIh1QOfxh6ayPY014r3UYFiGue4TNrbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755159220; c=relaxed/simple;
	bh=2D1OOFtNbdpnycHdnojgPyCPrVecspF1AWE0YpTc5Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEDkaHYk4AlLhNu108pBEHi0RUIa5OhusOZQ0wGgdm46ycWj2t4Z9YnxE7psVB36PAmUlO4TCoCMWfY4xRb+xRaSapCglJMfhNZulI5JGvxjAMPGmrJiI8J2GGTR241+lfErNrxvdAYM8TxjsQl6K3xB9/4Sbn4D30TdTwgVmiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmDFlGeu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC14C4CEF4;
	Thu, 14 Aug 2025 08:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755159218;
	bh=2D1OOFtNbdpnycHdnojgPyCPrVecspF1AWE0YpTc5Ms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UmDFlGeuPH1XfHlUH4Z3k2aCt3AaRHbvrNWNEngpXoKELe0G7p8j9wn597XTJ6iRN
	 L3uQCWlFV7V11dHkYcctJnDXVUiM/pnqLIpHn5b6459R2ZpjsJfxczmbkz0dyiIr6k
	 lRmDayR2Z4PLhL5m8hChhnNuaQ2eJT6crOpObWEpHB59dqLxSjv7imEUReeqZk4Z3Z
	 vWNlmem+zPdfiStTM7Gsgo9euIJOjnoSjYx9dEXDLUFQ84fUlCDU8TYPkepLsnbB0n
	 VYJJgnTxtFcVsbm1BqiBT7BQtfg9fASWovDCmdB+MXojxqkC+WjgOCGfrg4DLdXPZD
	 4qmMis49DPJYQ==
Date: Thu, 14 Aug 2025 10:13:35 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com, krzk+dt@kernel.org, 
	conor+dt@kernel.org, alim.akhtar@samsung.com, vkoul@kernel.org, kishon@kernel.org, 
	arnd@arndb.de, m.szyprowski@samsung.com, jh80.chung@samsung.com, 
	pankaj.dubey@samsung.com
Subject: Re: [PATCH v3 08/12] dt-bindings: phy: Add PCIe PHY support for FSD
 SoC
Message-ID: <20250814-refreshing-watchful-lemming-4feb03@kuoka>
References: <20250811154638.95732-1-shradha.t@samsung.com>
 <CGME20250811154729epcas5p456ddb0d1ba34b992204f54724b57a401@epcas5p4.samsung.com>
 <20250811154638.95732-9-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250811154638.95732-9-shradha.t@samsung.com>

On Mon, Aug 11, 2025 at 09:16:34PM +0530, Shradha Todi wrote:
> Since Tesla FSD SoC uses Samsung PCIe PHY, add support in
> exynos PCIe PHY bindings.
> 
> In Tesla FSD SoC, the two PHY instances, although having identical
> hardware design and register maps, are placed in different locations
> (Placement and routing) inside the SoC and have distinct
> PHY-to-Controller topologies. (One instance is connected to two PCIe
> controllers, while the other is connected to only one). As a result,
> they experience different analog environments, including varying
> channel losses and noise profiles.
> 
> Since these PHYs lack internal adaptation mechanisms and f/w based
> tuning, manual register programming is required for analog tuning.
> To ensure optimal signal integrity, it is essential to use different
> register values for each PHY instance, despite their identical hardware
> design. This is because the same register values may not be suitable
> for both instances due to their differing environments and topologies.

Would be nice if above (or most of it) would be reflected in binding
description. Please do so and:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


