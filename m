Return-Path: <linux-pci+bounces-5271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 602B888ED6B
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 19:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19CAE2A8C07
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 18:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC9F152188;
	Wed, 27 Mar 2024 17:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXRuPs6t"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF4D14D70F;
	Wed, 27 Mar 2024 17:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711562174; cv=none; b=Rr6sgYiw5wiMMB5cfxejC5v3uj/O5ybm3DFwQp15zPnAC1GmZHOVqJev+xDhxVCsMdJU5OwVCJ0tYTbsma9VEXYRoAyqLCJxxuWexvTgvnwJRgZvvLST16svbLFNVu4jfHcR+zkVLHFhA63/Hc75QGuYShHnJC3prw1El13kvEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711562174; c=relaxed/simple;
	bh=CARL3VpskHXs1C8+zISBJy2R8u90IIDk7xSKp4/PB1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZo9Jdtkg5oh40RgGtct0IwkH5GUQvtVhK5XZcDd3ONvXpDKHLVvrtd6GIjvLjDPXE81apRFtlftPoooiKjZcRpWf/7/UbqoWcsj9FmXifpKNRnvkvKDu1OrFR7MZCu+BP62bWbqAXJqxAB8hJVRDQBX8Ov4SysZT7OnsXNXsZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXRuPs6t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25EE3C433F1;
	Wed, 27 Mar 2024 17:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711562174;
	bh=CARL3VpskHXs1C8+zISBJy2R8u90IIDk7xSKp4/PB1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gXRuPs6t0bSxHm22O6CNo4Kkp5D2JX3AjcxLSZ3kXyhEyi2UIsEmVFRTOhvpPRJ/7
	 fMifnYGT6ixKL6DBXsG0U2PJ4Hj/UO2OOa6DPA/PcFsWKaBhGl4HhWXjcG+X7IoWiy
	 yug3xt4/SqtnFsyzeJ3wM20n2mmj3ShbaIXs56YW/VaunkK2S6kfEsIpfgnvPI11zf
	 cgDJm1UrhuC0xNgmZeSTTXCEGUKKMjMOhHY4B/Hjc6muQYzGM8/xNViTMW/aoikhZX
	 liRX9UQur/rgHgHbECqiz232O331J34x5ppTuEgZ2oJmQq+0LNCQV+24WViVoJdyCm
	 9ySP9hnevpMLg==
Date: Wed, 27 Mar 2024 12:56:12 -0500
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Daire McNamara <daire.mcnamara@microchip.com>,
	linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Jamie Gibbons <jamie.gibbons@microchip.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v1 1/5] dt-bindings: riscv: microchip: document
 beaglev-fire
Message-ID: <171156217116.3705201.6521563645353809470.robh@kernel.org>
References: <20240327-parkway-dodgy-f0fe1fa20892@spud>
 <20240327-camper-brownnose-6392076d8699@spud>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327-camper-brownnose-6392076d8699@spud>


On Wed, 27 Mar 2024 12:24:36 +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The BeagleV Fire is a BeagleBone Black form-factor board with a
> PolarFire SoC.
> 
> Link: https://www.beagleboard.org/boards/beaglev-fire
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/riscv/microchip.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


