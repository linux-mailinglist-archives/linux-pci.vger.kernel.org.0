Return-Path: <linux-pci+bounces-5273-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC81D88EDD7
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 19:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0AF0B2C20E
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 18:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B00C152DE5;
	Wed, 27 Mar 2024 17:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msWePaHd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBE513AA4F;
	Wed, 27 Mar 2024 17:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711562253; cv=none; b=EYyqMcJOu+WEV/+y9TxNThsdH+pOnMtBBU2a42FyNZErOyfbCW1tXyEDIMl5WSlF0WzsWycCf8HTZRfIL0OhOIn6ToQ8CRzx+tFpuVZcp98RhBdqE0nu+tiHjXDzC4r2b8DDw+4NqtPS8o5X7oxhINoeMlTzVS01d+reKY3QKf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711562253; c=relaxed/simple;
	bh=AlaqdPkks2T8kN3/XZCb1mzjIR6gKPmZMmB62NcvVGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQLn/MONWAU9wdd/Ksy+u7HLjvvTLvC6h0Z8sBewFD3wVPNByLAjYT0NF3StWE7TPC3Z02XYAA1KerCGJ59APJnW6N+me1Pq5yQv1zRFa6ipP65CFX0kly9hH6zcjjyvdZ20cmnkUdpqm0rYjnRrZ7tOVt+aBihxsp7Ce9vBV/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msWePaHd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57813C433C7;
	Wed, 27 Mar 2024 17:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711562252;
	bh=AlaqdPkks2T8kN3/XZCb1mzjIR6gKPmZMmB62NcvVGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=msWePaHd45WWSJoItV1wa5g5P8rLteY6n27odI4pjYb1E8Ru5fv01kMwFf8bG9Nlc
	 q6fTwx/Uj03xlPJ2PsOoPHrInspsC5FXDpeRGfHAJnbYxCB6z8XxkDJwC2FJVbgZe2
	 80GM2BZ+8cUClG+HWasgzYWN1rR05Dk/5qRzUIh0Q2c+vnfCSvhEkTOSvC92y1to0t
	 BVZPd73DtPLmgK51qe7J8vIECdorCQxQe+fKeracEuncB2SrddW1zayrMUrrMLnE3D
	 lmoluO91BwEUqF0JMCtxshY4NdrP+YTClN8bqXF22MGLjSejXIgdnvD3i5uoMS9pE3
	 Oeujp1xFRyBhg==
Date: Wed, 27 Mar 2024 12:57:30 -0500
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-gpio@vger.kernel.org,
	Jamie Gibbons <jamie.gibbons@microchip.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH v1 3/5] dt-bindings: gpio: mpfs: allow gpio-line-names
Message-ID: <171156224981.3706851.349408739787363074.robh@kernel.org>
References: <20240327-parkway-dodgy-f0fe1fa20892@spud>
 <20240327-overrate-overuse-1e32abccd001@spud>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327-overrate-overuse-1e32abccd001@spud>


On Wed, 27 Mar 2024 12:24:38 +0000, Conor Dooley wrote:
> From: Jamie Gibbons <jamie.gibbons@microchip.com>
> 
> The BeagleV Fire devicetree will make use of gpio-line-names, allow it
> in the binding.
> 
> Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


