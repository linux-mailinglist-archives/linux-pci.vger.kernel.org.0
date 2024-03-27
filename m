Return-Path: <linux-pci+bounces-5272-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F4F88ED73
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 19:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD47D1F21193
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 18:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C6014D29E;
	Wed, 27 Mar 2024 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAfN+w34"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA63614C5A7;
	Wed, 27 Mar 2024 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711562238; cv=none; b=M6WoqWmywsQ6bwIJR0OhDKtm/wBg+RXWoM6AOXl8AeqEpE1/oym3CjqJK+JpOjO75aR0yZUCQ6iVBeenf60+fTfpvkuDYaGombHZaBnEHjWVryXBYJU0ycsqh62LTPafkX+5mUfKw4zzG7Zx0gLXYCklVFVoyI4NRc5xiL/sHfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711562238; c=relaxed/simple;
	bh=egDvY//d5uLWhDbId3Gj3GOZ8P3e61TVzkK5mB8057g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBdff0vGDUVmAgwP+nS6xb0Cq/aL0GEeXOGuPB8p1x+OydLMcSFkQreHEv1qKKMTmQLOGab5AzbttWfU1pTuhUGrXbFFL237uw5Qdnodj/813YgH45Zp/zoEBI03DuZzogFcBup4zilSClqFx2nhxrzMVU/kXwtjP0rncb7120E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAfN+w34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9FDC433C7;
	Wed, 27 Mar 2024 17:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711562238;
	bh=egDvY//d5uLWhDbId3Gj3GOZ8P3e61TVzkK5mB8057g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BAfN+w34ooSEjlr4N4tMnNyxMFrF5/EpcTE51vjwBxcJD9GsqkRp2+W4EshY7MA/S
	 18j+uu/6prCgQ7zs4DC5M8z3bzuY9iXqbW/8pmsPlvjJsuceHOGUZCzYCTsPe9vI2y
	 PMCa4M5fz9m8QHRx5DLSndnwNM4TOGfq+Jno80JtG01E4BrBaSWCukrsaVXnIeMfIE
	 nwylsW0V8w5F55dm80yPxA5GYO1LCqFLjCc9u+j5UjzcaxsPwGiX+ehhKt6PjtQIKK
	 7Z38n7hrivQB9t/nytn7BepjyEeWYpbAedcYlvHYO3WJ/HO/BjCgEcbQaDwgzv4k0S
	 Ex99/ChM42h8A==
Date: Wed, 27 Mar 2024 12:57:16 -0500
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Jamie Gibbons <jamie.gibbons@microchip.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-pci@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-gpio@vger.kernel.org,
	Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
	linux-riscv@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 2/5] dt-bindings: gpio: mpfs: add coreGPIO support
Message-ID: <171156223562.3706464.15520740960365102234.robh@kernel.org>
References: <20240327-parkway-dodgy-f0fe1fa20892@spud>
 <20240327-procurer-rascal-33bca7d5d14b@spud>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327-procurer-rascal-33bca7d5d14b@spud>


On Wed, 27 Mar 2024 12:24:37 +0000, Conor Dooley wrote:
> From: Jamie Gibbons <jamie.gibbons@microchip.com>
> 
> The GPIO controllers on PolarFire SoC were based on the "soft" IP
> CoreGPIO, but the inp/outp registers are at different offsets. Add
> compatible to allow for support of both sets of offsets. The soft
> core will not always have interrupts wired up, so only enforce them for
> the "hard" core on PolarFire SoC.
> 
> Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/gpio/microchip,mpfs-gpio.yaml       | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


