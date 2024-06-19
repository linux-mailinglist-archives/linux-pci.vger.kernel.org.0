Return-Path: <linux-pci+bounces-8972-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7712C90E95D
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 13:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A6C11C22DC7
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 11:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D4813B583;
	Wed, 19 Jun 2024 11:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Du+dh5j3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D01C13A263;
	Wed, 19 Jun 2024 11:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718796330; cv=none; b=tclf3A4Sfu2h0yImarDDynnRNahRqgWXLETEQh6HwCk+BHG9GY7qTA6fL9TXCjQky15VuYx4r5Qfm6wzGqO1JnPhle0Xn4FSOUCnZW4A/UxprrEgrhZNxdqO3PoyNfQs7Y0NKcXADL7uHM2kNPFs9Z2SIfVLwI2HP8s63ROoYqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718796330; c=relaxed/simple;
	bh=wzgwyeFbIPVmN/m2LlPsgW89UGP112++2zLlQoa6br0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SYef2zjdyKcavrR8ShSqjW/HYcZwy3GUzXSJpbpuNe/V1Xf+LPFBVQzF/kiidF4Vyn7k67cZON6kqDrhUWzFGNeaixRUKqL7GBW7AOwhdW0CfJ7+bHBgtWSF9+Ukg6sraHExOO8xAmLvmwgVRsogfadykuWKArMVKrX7ctZ1bxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Du+dh5j3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BDFC4AF53;
	Wed, 19 Jun 2024 11:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718796329;
	bh=wzgwyeFbIPVmN/m2LlPsgW89UGP112++2zLlQoa6br0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Du+dh5j3HHzpa9yey8zGx6MNBhRSP5yQXWuWgd8fZ+2wjMfn2vfuZQWDvD6mfzdDE
	 ALVAAyypHvZYwZ7gQLIbC6J2/lDVDvJDeXsXPtcoshRW+qweIlKecxXE+xXw1latK0
	 295u5iSD3QMCimGrhNLiv7f2uBLI/v0yKTZxlMS2mDfY2XsuKPrWFz/lrKGNnw2/fy
	 OZvO4Q0gC+SetiNpSZ6ZN1vcJ9u8CRoSpaGcKqJJWIfIWAJlXkTRxzn/Dy8jeW38ee
	 90nqDKny33ACfjWnYETbC+ZOw9mtfcELCdxvaLuYHAXfRzbVQOHsIXmGOzLsGvuq3b
	 lRykQ6JA79PhQ==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org,
	Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Jamie Gibbons <jamie.gibbons@microchip.com>,
	Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	=?utf-8?q?Daire_McNamara_=3Cdaire=2Emcnamara=40microchip=2Ecom=3E=2C_Jam?=@web.codeaurora.org,
	=?utf-8?q?ie_Gibbons_=3Cjamie=2Egibbons=40microchip=2Ecom=3E=2C_Valentina_F?=@web.codeaurora.org,
	=?utf-8?q?ernandez_=3Cvalentina=2Efernandezalanis=40microchip=2Ecom=3E=2C_L?=@web.codeaurora.org,
	=?utf-8?q?inus_Walleij_=3Clinus=2Ewalleij=40linaro=2Eorg=3E=2C_Bartosz_Gola?=@web.codeaurora.org,
	=?utf-8?q?szewski_=3Cbrgl=40bgdev=2Epl=3E=2C_Rob_Herring_=3Crobh=40kernel?=@web.codeaurora.org,
	=?utf-8?q?=2Eorg=3E=2C_Krzysztof_Kozlowski_=3Ckrzysztof=2Ekozlowski+dt=40li?=@web.codeaurora.org,
	=?utf-8?q?naro=2Eorg=3E=2C_Lorenzo_Pieralisi_=3Clpieralisi=40kernel=2Eorg?=@web.codeaurora.org,
	=?utf-8?q?=3E=2C_Krzysztof_Wilczy=C5=84ski_=3Ckw=40linux=2Ecom=3E=2C_Bjorn_?=@web.codeaurora.org,
	=?utf-8?q?Helgaas_=3Cbhelgaas=40google=2Ecom=3E=2C_linux-gpio=40vger=2Ekern?=@web.codeaurora.org,
	=?utf-8?q?el=2Eorg=2C_devicetree=40vger=2Ekernel=2Eorg=2C_linux-kernel=40vg?=@web.codeaurora.org,
	=?utf-8?q?er=2Ekernel=2Eorg=2C_linux-pci=40vger=2Ekernel=2Eorg?=@web.codeaurora.org
Subject: Re: (subset) [PATCH v1 0/5] BeagleV Fire support
Date: Wed, 19 Jun 2024 12:24:48 +0100
Message-ID: <20240619-tightly-stuffed-a91e32ae9fc3@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240327-parkway-dodgy-f0fe1fa20892@spud>
References: <20240327-parkway-dodgy-f0fe1fa20892@spud>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=693; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=W31/LXvbm3p0gQHN+AHn/iS7bX0lEsjhbAHyFzbXYq0=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGlFBxh8f6/zXfjC9NGcM4ltLn98vHsktk+Z/fxqdsDvr bOvnM6b3lHKwiDGwSArpsiSeLuvRWr9H5cdzj1vYeawMoEMYeDiFICJfAxhZDga2nAq+VdN38M/ d2wvNudvOpjAbmnDcl+8d6Z2N5OBdx3DP+3M/hvHV+4K+s9a98Ofad+XBEtuwxk72msy7u6t2Li 7lREA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Wed, 27 Mar 2024 12:24:35 +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Yo,
> 
> Wee series adding support for the BeagleV Fire. I've had a dts sitting
> locally for this for over a year for testing Auto Update and I meant to
> submit something to mainline once the board got announced publicly, but
> only got around to that now.
> 
> [...]

Applied to riscv-dt-for-next, thanks!

[1/5] dt-bindings: riscv: microchip: document beaglev-fire
      https://git.kernel.org/conor/c/76ed031dc750
[5/5] riscv: dts: microchip: add an initial devicetree for the BeagleV Fire
      https://git.kernel.org/conor/c/9e2569c28589

I've applied this with the incorrect PCIe root port node removed.

Cheers,
Conor.

