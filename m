Return-Path: <linux-pci+bounces-9207-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8877915745
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 21:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9117F1F219AE
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 19:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CBB1A01C0;
	Mon, 24 Jun 2024 19:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wa7gIXEA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DB51A00D6;
	Mon, 24 Jun 2024 19:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719257940; cv=none; b=LgFmQFP3GMvj4fJ1sfBLzUyp3H7rMKL3H6OtJe69vZ7RfP7ofX/VDTguYRtnZXkPR8DmCv39JMerfyeMBoXlq3H2kZWrhM9Z7AJFxbM5i7QcboDqJpwczK9Czzh9/SrtRzGOcTgem6NPw3uwVgtNZXYrR3Qo3ZkRvvfrHAxVxwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719257940; c=relaxed/simple;
	bh=fIpxGxErBMjwvYV2I4WkYrRQiLydJH1phwFbI+ji4G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9IIL99EjB1v33HM/LRqmX8TCLXf3LUQuQ8d5zZYV5ClwFKuQ70m7UiMUdPUln6/WxUGdevUXN8U8OHpb9f4ATjwV71K8WMPS9qkLgPMmYRS61oIKRL1z14hsOU6Rr036Xw66yN4a/L+Y+ftGMNeKi9Wtq5RXBQRP4X53142iZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wa7gIXEA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47B1C2BBFC;
	Mon, 24 Jun 2024 19:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719257940;
	bh=fIpxGxErBMjwvYV2I4WkYrRQiLydJH1phwFbI+ji4G0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wa7gIXEAi/WfFBiYP6sYL4YJ9C7vmuVsgWLzu3PkrQLSdAg91ODgzJzQMxrcw5HYk
	 JzSDEo+2Bv0UqHHrHBWtWyeGe2qfcFTwc2LUxCF6EF1OH7UwmSvzQicSZAPTscPNUc
	 FPkItYLIyozBc78h0aBRh0MgGCOCw/N3Wtz5LvqUYdTD/5bC/Ioy/Pw/K3Mn9bsiH6
	 GWKYv8reakThPKtlxjrYLodKDrID5eBSkxKIfeZmKHyWmIzFS8t4KTc5wLoe5qlLD0
	 3ViKxv2KAKpH9PUBInb2mHCcWdOkuv84/vTJiiAPFG8vaky6wzYII/JKg/k6n79nRz
	 lU7w1NIFA8KXg==
Date: Mon, 24 Jun 2024 13:38:58 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: daire.mcnamara@microchip.com
Cc: linux-kernel@vger.kernel.org, conor.dooley@microchip.com, kw@linux.com,
	krzk+dt@kernel.org, devicetree@vger.kernel.org,
	lpieralisi@kernel.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, conor+dt@kernel.org,
	linux-riscv@lists.infradead.org, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v4 3/3] dt-bindings: PCI: microchip,pcie-host: allow
 dma-noncoherent
Message-ID: <171925793172.267714.8378615377109046130.robh@kernel.org>
References: <20240621112915.3434402-1-daire.mcnamara@microchip.com>
 <20240621112915.3434402-4-daire.mcnamara@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621112915.3434402-4-daire.mcnamara@microchip.com>


On Fri, 21 Jun 2024 12:29:15 +0100, daire.mcnamara@microchip.com wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> PolarFire SoC may be configured in a way that requires non-coherent DMA
> handling. On RISC-V, buses are coherent by default & the dma-noncoherent
> property is required to denote buses or devices that are non-coherent.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> ---
>  Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


