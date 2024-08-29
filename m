Return-Path: <linux-pci+bounces-12405-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCDB963B04
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 08:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C0A2833F9
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 06:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CC915AD9B;
	Thu, 29 Aug 2024 06:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hx56u18J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA20D15A843;
	Thu, 29 Aug 2024 06:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724911787; cv=none; b=pPubkcnbl4LXy+slEmrTlq+arwNPjCZQ560ID2dmmXV2N0KmTSAhD5hg0DED35hKUw1wcDkdodhIzmDAnpASypyrjCRIwu+m11S05iCVeyXq/eQWwvq3lvOoBeik24BSvkQ2uzmhYu9WCjJ6+kcAjgRlOgQfqbrEAKWcbp79v78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724911787; c=relaxed/simple;
	bh=YvzmcJOMW0Q4wrzRgAo47ep0PUJTe2q7WQpVHCgImTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aoIByRRvVQEJy0K2bEa8Sf9+n1cY27swUm+u4jwiOG+XWrYvVILzfFv0ps0Ic0MV3Fx61ueWYOLelSKH2UoqCteMTtkkR4HpnOTshYPmbCfsOI7Cq9eTLm2VONAt++a7cr1nq1lPrGJcWRd/w4N+u0oSfsLURRgY0gQDCwDikRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hx56u18J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1743AC4CEC1;
	Thu, 29 Aug 2024 06:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724911786;
	bh=YvzmcJOMW0Q4wrzRgAo47ep0PUJTe2q7WQpVHCgImTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hx56u18Jygjlgeop61/q1htd3jPQj5D294hatsTZwHP86tk63QoBwlVR52bSuvx1G
	 QUGbDK7ULtDUzm/45L3ALb0H7MSHsYL+2PcP1ldj0CWh/t18yX+X4yJ/VVxi6Vy2An
	 u6G8KDGzk4nU9U1rpqn7PXgeiGlNspo/7YVPHIuOJ65rmxCrWUFDAh2mYW3GxsaC7P
	 KEae8dEX4NjMT9UA45zQszv36wQiTkS0t9TXtRNkAlWZyTHFTdIPycS0N37/fCZHxM
	 EuXM9QySJG8vMRqh/20pd4YjVmOi8FeM2SEF79X76rPwtgZ1PVXSDjZf6p+Hk1qc2G
	 AYLPBJbdyhIlg==
Date: Thu, 29 Aug 2024 08:09:42 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Bao Cheng Su <baocheng.su@siemens.com>, 
	Hua Qian Li <huaqian.li@siemens.com>, Diogo Ivo <diogo.ivo@siemens.com>
Subject: Re: [PATCH v3 1/7] dt-bindings: soc: ti: Add AM65 peripheral
 virtualization unit
Message-ID: <6ceabv6xf4obh3zc7b3cpm24b7fnzlfxwulwkn2trcwgvhqfit@3wccgolzipiv>
References: <cover.1724868080.git.jan.kiszka@siemens.com>
 <ccbbc49b00b64e857c35a24466ca237d9a0c7da3.1724868080.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ccbbc49b00b64e857c35a24466ca237d9a0c7da3.1724868080.git.jan.kiszka@siemens.com>

On Wed, Aug 28, 2024 at 08:01:14PM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> The PVU allows to define a limited set of mappings for incoming DMA
> requests to the system memory. It is not a real IOMMU, thus hooked up
> under the TI SoC bindings.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


