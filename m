Return-Path: <linux-pci+bounces-34342-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5796CB2D4C6
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 09:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14F6D1C40619
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 07:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F03E2D3ED3;
	Wed, 20 Aug 2025 07:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUFrXy35"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D78EAD7;
	Wed, 20 Aug 2025 07:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755674640; cv=none; b=OEk6j0bPIYqYoQknsH4WLdbXIt1nwIP6DElVGsf+xvA9pqD/NsQx7ohOl/a++yEmqOOHwuM7S4lXZBbZebSUfCOURUa0An0Ncspfg0JBfXT2d8h8kwav/pxIcKf4ybaRNasrGbJMwkRbNCQZ+KuoMt14WlXfUL/u3yVJFHmkzk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755674640; c=relaxed/simple;
	bh=sT4U1XmZfH9P7OH1pmLpJvEWn3qCYgy4cEt5uI2cVx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POlVsfAI3nUMsVY6CzjrS5g4IOWcuKw3ucJdQEryI6aZyipsnf9x4PfKKvRSunj5MIDig2jRRa6EyuFF2bh7/XjilibY4pu7ETuu7lFxB4Kc75WwgS0MpNNpW+1KkuMOLx6W3Flft+ZcJjie6/AEkPQQyzEMStE8J9R5Gq3cKH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pUFrXy35; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EEABC4CEEB;
	Wed, 20 Aug 2025 07:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755674638;
	bh=sT4U1XmZfH9P7OH1pmLpJvEWn3qCYgy4cEt5uI2cVx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pUFrXy35c1Su73hdxBEJWHBuyqfzxvlCKHisAV/OkdOsPAimdpaBbI+45LjfpsVdN
	 0+3nHAQOm0URZjYjyqoXUWtXwwh5ZpT1/yACTCalY8iAHl7pim6nP6JdqBwqzBG/xa
	 brIuVyG6SR44JaaNXpDAtUwDjTmJE5dPfufoH7M3nABRAWMA9FzUSqzadEKRNgOdqF
	 rU0Cd4u5OmrlW6i/hoqbV9f6eagFc8pzYGN2JB8TpIPrU/d2dlACtCjMcNYO0ryNTE
	 7UcY46sWdDblSDsW44mqTPFSnKET0/YoXgvmPj8mh4S1ZUYKpVNDvcAj/yYGBXuU7/
	 z9NxERHO8qCQQ==
Date: Wed, 20 Aug 2025 09:23:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, mpillai@cadence.com, fugang.duan@cixtech.com, 
	guoyin.chen@cixtech.com, peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 10/15] dt-bindings: PCI: Add CIX Sky1 PCIe Root
 Complex bindings
Message-ID: <20250820-acoustic-tomato-salamander-bfe740@kuoka>
References: <20250819115239.4170604-1-hans.zhang@cixtech.com>
 <20250819115239.4170604-11-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250819115239.4170604-11-hans.zhang@cixtech.com>

On Tue, Aug 19, 2025 at 07:52:34PM +0800, hans.zhang@cixtech.com wrote:
> From: Hans Zhang <hans.zhang@cixtech.com>
> 
> Document the bindings for CIX Sky1 PCIe Controller configured in
> root complex mode with five root port.
> 
> Supports 4 INTx, MSI and MSI-x interrupts from the ARM GICv3 controller.
> 
> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
> ---
> Changes for v8:
> - Fixed the error issue of DT binding. (Rob and Krzysztof)
> - The rcsu register is split into two parts: rcsu_strap and rcsu_status.
> ---
>  .../bindings/pci/cix,sky1-pcie-host.yaml      | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


