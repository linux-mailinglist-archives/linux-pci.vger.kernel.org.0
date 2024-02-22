Return-Path: <linux-pci+bounces-3849-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B516E85F0CD
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 06:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D8ACB211E8
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 05:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356C8C8FF;
	Thu, 22 Feb 2024 05:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGnnCNS3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042B379D0;
	Thu, 22 Feb 2024 05:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708578954; cv=none; b=mDHOMDzhByNL+EdShCRFyXBl7WFlHUHto3B2TQ8v4nI2QKgvtYGW/QJQO9xUrJCgoq0Hgza+x2cTMi4B9PIIZwa2EbCR7U1AHnZltjOF+5ufYr9CJSF32K536frGD+8flv+rTtbB5Nx6nTo6a+wunQEYtJoUIA0+ikPIJiQ3b5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708578954; c=relaxed/simple;
	bh=dg6U0qZ25gCXqk858bopVDGf9rfG4vTej3zkDRCwC/A=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=ixRvkR/MbjBfR5hhEt9pd6R5H9jIASzWRmLJk1E5DS5n5PVv2oTe28fPIhUKbTPCZD0Bce/Ve1GK9JFXM5d+ZWonDutqg8vA6+38ciYJKG/E62yPRBJGPloZqhUceLStSyzYBvza7k5oS9sMNnlrPIuL7bBXWKftIg1MPKS2M5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGnnCNS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68856C43394;
	Thu, 22 Feb 2024 05:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708578953;
	bh=dg6U0qZ25gCXqk858bopVDGf9rfG4vTej3zkDRCwC/A=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=DGnnCNS3dCWCww6KW4/YC2drMrIeD2TAd1rimsesAR6Ob/19ZnT5ixKc1cQHB9Qy7
	 fXH85WEUzIV0Woyp0FMnjbnrXK5wKj63Mq6Rxq0mlWpUROMCPN3WCCQiCKYIxoqbUh
	 5mLDu9G0PP6yft/8+o536pVosutxWvUC88CGQRQ4D6skE0UAD+vW0qKdbdpS6rkWQw
	 l9xPGaz9X9k/1p8DS46OFWiisASpSxyUClzoa9mD2zlVNgD7pxgrss6hr/R6Gd8g2+
	 39u0PKD0dS736pGeiLrf4ltFc3rShrJ7J5zI78OY+z979LHsz+pIEx4tgUotW37jDo
	 15BR+fssXPyow==
Message-ID: <610d7c44517bfe3b218a6d057a08ac7a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240220084046.23786-2-shradha.t@samsung.com>
References: <20240220084046.23786-1-shradha.t@samsung.com> <CGME20240220084120epcas5p1e8980539667c3d9da20f49fc645d8f4c@epcas5p1.samsung.com> <20240220084046.23786-2-shradha.t@samsung.com>
Subject: Re: [PATCH v6 1/2] clk: Provide managed helper to get and enable bulk clocks
From: Stephen Boyd <sboyd@kernel.org>
Cc: mturquette@baylibre.com, jingoohan1@gmail.com, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com, krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, linux@armlinux.org.uk, m.szyprowski@samsung.com, manivannan.sadhasivam@linaro.org, pankaj.dubey@samsung.com, gost.dev@samsung.com, Shradha Todi <shradha.t@samsung.com>
To: Shradha Todi <shradha.t@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Date: Wed, 21 Feb 2024 21:15:51 -0800
User-Agent: alot/0.10

Quoting Shradha Todi (2024-02-20 00:40:45)
> Provide a managed devm_clk_bulk* wrapper to get and enable all
> bulk clocks in order to simplify drivers that keeps all clocks
> enabled for the time of driver operation.
>=20
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---

Applied to clk-next

