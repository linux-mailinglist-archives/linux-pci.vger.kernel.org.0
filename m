Return-Path: <linux-pci+bounces-16590-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4ADA9C6067
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 19:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DAF71F24157
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 18:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21A7216DF6;
	Tue, 12 Nov 2024 18:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOe0pd7p"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4402216A21;
	Tue, 12 Nov 2024 18:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731436091; cv=none; b=GamotZtjBl/lmvy98hpZsa/RbT0jy42VZn416bEziUef7dMGpOKmQf2bYbX0IHStXImr3lU4pVgmYu1Xu71NQxk1tbb8skCSBG559jgOQpo6uuM/6uqEBnXT4jOxra7zOMI7cKqOHuzFipHl6+Er9v84UemnP6JR3NTGI9YWCVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731436091; c=relaxed/simple;
	bh=H2jCUzYK5IZCoCe/12Ednn9tkBc4SKBxPTgIjXecd/k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sz5BnXexIMlKVALFhpdU1GMjGlR5MYfhXAPeH/jlECywx/QXOTZxFMetC8EzFbJpxzCQ2abmj3TWulxfLnTiZVrxnilZD9a4ztdrwo4pA+DSENENOifS7YiFdjDJCg8Pe9L0oAMkkPWoHnCdtNB1j8RHKBqPXRUomjSV+h2C4jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOe0pd7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11ED6C4CECD;
	Tue, 12 Nov 2024 18:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731436091;
	bh=H2jCUzYK5IZCoCe/12Ednn9tkBc4SKBxPTgIjXecd/k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EOe0pd7p2tFGaOY09OQHqQtAl685Kj8521XyjL8ay5Qpu+Ruwqyp6IaIFzzD/o78m
	 KhHkQhpmzmggVJtXTD5qUUHJdyE/9jKD7MaJunItfnHMoZRC0HDvvc0h1utVopw7Kb
	 9XsPEcvllavigmZ1drRaAGjK12HlPvUkGXXiFEecGm3+TseuNhFCWGycRMfOQftGKI
	 SRecpQDkcLc1zOw8bUvVpOZDF8ReNwh716GlysliyDd77w7/v+tyQNb/fk/IWlGUPe
	 xx2fbzF00ZVaNwHXHN7BNFbSsMNkIII/7kWfywEn9pbxIJd4htSdangQ+lXbfU4vsX
	 Nx5lm4/oyDdFw==
Date: Tue, 12 Nov 2024 12:28:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, p.zabel@pengutronix.de,
	cassel@kernel.org, quic_schintav@quicinc.com,
	fabrice.gasnier@foss.st.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: PCI: Add STM32MP25 PCIe root complex
 bindings
Message-ID: <20241112182809.GA1853254@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112161925.999196-2-christian.bruel@foss.st.com>

On Tue, Nov 12, 2024 at 05:19:21PM +0100, Christian Bruel wrote:
> Document the bindings for STM32MP25 PCIe Controller configured in
> root complex mode.
> Supports 4 legacy interrupts and MSI interrupts from the ARM
> GICv2m controller.
> 
> Allow tuning to change payload (default 128B) thanks to the
> st,max-payload-size entry.
> Can also limit the Maximum Read Request Size on downstream devices to the
> minimum possible value between 128B and 256B.
> 
> STM32 PCIE may be in a power domain which is the case for the STM32MP25
> based boards.
> Supports wake# from wake-gpios

> +  st,limit-mrrs:
> +    description: If present limit downstream MRRS to 256B
> +    type: boolean
> +
> +  st,max-payload-size:
> +    description: Maximum Payload size to use
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [128, 256]
> +    default: 128

MRRS and MPS are not specific to this device.  Not sure why you need
them, but if you do need them, I think they should be generic.

