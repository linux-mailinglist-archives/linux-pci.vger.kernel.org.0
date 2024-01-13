Return-Path: <linux-pci+bounces-2133-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A56182C8E2
	for <lists+linux-pci@lfdr.de>; Sat, 13 Jan 2024 02:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 975431C20F9A
	for <lists+linux-pci@lfdr.de>; Sat, 13 Jan 2024 01:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6993618623;
	Sat, 13 Jan 2024 01:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZ0QOeWf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4507715EA6;
	Sat, 13 Jan 2024 01:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C24C433F1;
	Sat, 13 Jan 2024 01:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705110317;
	bh=DxZsLmyA+1sUvE1Z4U11K/YS97w9VOdx+PTvM4XU75M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KZ0QOeWfGn3Jr0c1lfBR5vr7csr92mBGDsDu9qaQyCIFJv4bhUDIDMslc59cfr9fM
	 Cjpk1cN+OkUBqAGsLnlou7/4RIFhYzC/dr4aEoJTJuOsIJjqi7vv8NlmKlwrNderj7
	 wWmjWiHx/Ws2CnOBg1FHYKno8WdhiRflVrscGc0MCsOfs8MIXZD4inuHzmyWHtuqTo
	 g5QAeIhLAY4V6oOmyJswoYq8RFYLNngxNw76ohYHQm2J01TTWvKTr3A4PZjSMw9Voq
	 nVCg5bjAoYTxrJsgAR0QXaq2qF8aRMS6h1wPGbWZtnolaTpepnxZ1aWwQ1dPGic56+
	 kcWtdpVDS3bhg==
Date: Fri, 12 Jan 2024 19:45:15 -0600
From: Rob Herring <robh@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, bhelgaas@google.com, kw@linux.com,
	devicetree@vger.kernel.org, srk@ti.com, conor+dt@kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org,
	linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [RFC PATCH] dt-bindings: PCI: ti,j721e-pci-host: Add device-id
 for TI's J784S4 SoC
Message-ID: <170511031475.3817032.5482957589582376350.robh@kernel.org>
References: <20240108050735.512445-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108050735.512445-1-s-vadapalli@ti.com>


On Mon, 08 Jan 2024 10:37:35 +0530, Siddharth Vadapalli wrote:
> Add the device-id of 0xb012 for the PCIe controller on the J784S4 SoC as
> described in the CTRL_MMR_PCI_DEVICE_ID register's PCI_DEVICE_ID_DEVICE_ID
> field. The Register descriptions and the Technical Reference Manual for
> J784S4 SoC can be found at: https://www.ti.com/lit/zip/spruj52
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> This patch is based on linux-next tagged next-20240105.
> 
> Regards,
> Siddharth.
> 
>  Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


