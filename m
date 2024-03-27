Return-Path: <linux-pci+bounces-5274-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD7A88ED7A
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 19:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BC321F3578B
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 18:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF73814F124;
	Wed, 27 Mar 2024 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sg3uPchw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C5B13AA4F;
	Wed, 27 Mar 2024 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711562275; cv=none; b=s4ygUtIoWUpJGKsDHF1nlb39LpXbcYfYXy5qR2TBt7CCWmzyE0twglJz2k/skKLIrxCjQH7cJKc0vhmamjN2xrETiV2+6Mpv2qnd0P2VexOyvc9BbJ5sDvg7I4b3uCwIrL4tVE6NadJ3UAj1kFR/FqIPPxhYWnJDhf8FN3+PeFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711562275; c=relaxed/simple;
	bh=wqbcn0ikIUK4mt6Aj/w6cUv86+OQtHDq6oRZyBl/18g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ig0Yqiem4bVJPuAR00LTyKqnbc9tFfOSaUlYFAi4j8Mg6ziHCxuH2D6yYskXnKUqpvVqtkG83XLF+DAwHVEn/qQKTrnx7OtBzi6iTgKAo0BmmjnUG58arNh317yuqdJfrkdh4QOxsImp7nbbrb6tbZjLdUh/4KwBR5FP3wfEZ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sg3uPchw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D69C433F1;
	Wed, 27 Mar 2024 17:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711562275;
	bh=wqbcn0ikIUK4mt6Aj/w6cUv86+OQtHDq6oRZyBl/18g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sg3uPchwAu0+XJyWLp74NaDVzYwP6Sha7kCsSnDpZvlc5y6mC59Vny+RkbE/5BDSf
	 yutWspT+aHvxerOkWmdV/ixX0gfY1ufGfl7VPyH1LhKCzyAkckw0U/3h4vpSjjoixV
	 Eyhy4pGLj/KTKDSlP5Ki9XQNiiU+LBWC6p96cBFILnikm5ZgcT3uUGsZzwTU21ZN0P
	 d+zzh3AYV1ber4npKkBcCu9HCUzBqc0JZG/52tOxAqSaYZ10ubM63l6WPcxtitBpRX
	 ytuuj0AsUAYFYbCEaagi0I0RfX1q5PEdqXg7IIq+leov9QAM6btvK1SKOxVaKAlXb4
	 0nr+u2bdHoMsw==
Date: Wed, 27 Mar 2024 12:57:53 -0500
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Jamie Gibbons <jamie.gibbons@microchip.com>,
	linux-pci@vger.kernel.org,
	Daire McNamara <daire.mcnamara@microchip.com>,
	linux-gpio@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Valentina Fernandez <valentina.fernandezalanis@microchip.com>
Subject: Re: [PATCH v1 4/5] dt-bindings: PCI: microchip: increase number of
 items in ranges property
Message-ID: <171156227276.3707387.1415790916639704737.robh@kernel.org>
References: <20240327-parkway-dodgy-f0fe1fa20892@spud>
 <20240327-debunk-perky-f5514ca332be@spud>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327-debunk-perky-f5514ca332be@spud>


On Wed, 27 Mar 2024 12:24:39 +0000, Conor Dooley wrote:
> From: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
> 
> Increase the number of items in the ranges property to allow up to 3
> ranges. For example a prefetchable range, a non-prefetchable range
> and an IO range, depending on configuration.
> 
> Signed-off-by: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


