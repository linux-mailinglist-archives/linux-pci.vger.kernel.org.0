Return-Path: <linux-pci+bounces-44645-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 145DFD1A5AD
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 17:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DA993055715
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 16:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A343101CE;
	Tue, 13 Jan 2026 16:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOvOZOLk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0A930FC08;
	Tue, 13 Jan 2026 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768322280; cv=none; b=WZRscCw3grBjU64GWmBiQbljWHriz2cXzqyZgnMce7B1+fPJfKB2n0c0sKj9pZ0ov3sF90cXj8LjJZHbAm3Fj/vOGGhUCZunLVTRjAFDQj7vYYX58KeN7Vl6AON6GKkREbplWj2AThgkoJzqgkqGzef/QjgmyeEqX8fGLbSaiIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768322280; c=relaxed/simple;
	bh=waBlxOEVBKC2lAPWIlT19JK2tiXFYS2bj0TZqRtFJk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzrcrcVyfdIhrc2+o0ppkYF4rnQRryyqnvolXzzS4yzKzNIZxJQRDdY0lJS4tq8j9xnhXO56mtdZWzlHVnCO8+tLCE9pUarPywUVhok6TNEQNP7OYl+CFxhiz+IZLf1bWaaJB7AkYs9KSzWyeVhyrmQ+ef+IThWK0RiwZypw+aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOvOZOLk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9412EC19422;
	Tue, 13 Jan 2026 16:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768322279;
	bh=waBlxOEVBKC2lAPWIlT19JK2tiXFYS2bj0TZqRtFJk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oOvOZOLkm1zlHmHjr8cJoFKcpicEo0RgIvTaahRG694IG30RGJiNyMBhAcV7nJRR3
	 mlXl63yDowExc+w/f6Hnau9V2+8fsyyAhoin8qfCyM92VrKDeX22oHfarCg5yjxgUQ
	 ywZbc9axNUbY491ID1/iIp6kaPtA0z72Fsi9mXxmZGg89fTe+JH9EXsWfysU0eIuEi
	 7nZT1DdL9ivfpvFKZ9DHT0ztqNeT5LluaFiYLyE7ktDkOsyXaCD4DQCKbRMKh8vdD6
	 Y++KNmRJZcHz3y7OlnbYIPDguW/xbxb/ejZTKPFKEdNkac7i5NKfn8GeMJQpkMl+2R
	 Vr1eeinhS6nSQ==
Date: Tue, 13 Jan 2026 10:37:58 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	devicetree@vger.kernel.org, linux-ide@vger.kernel.org,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pm@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v5 1/5] dt-bindings: ata: sata: Document the graph port
Message-ID: <176832227818.3917225.8091775807499906423.robh@kernel.org>
References: <20260107-pci-m2-v5-0-8173d8a72641@oss.qualcomm.com>
 <20260107-pci-m2-v5-1-8173d8a72641@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107-pci-m2-v5-1-8173d8a72641@oss.qualcomm.com>


On Wed, 07 Jan 2026 19:41:23 +0530, Manivannan Sadhasivam wrote:
> An external connector like M.2 could expose the SATA interface to the
> plugin cards. So add the graph port to establish link between the SATA Port
> and the connector node.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/ata/sata-common.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


