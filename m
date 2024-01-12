Return-Path: <linux-pci+bounces-2107-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B826E82C1E8
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 15:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695141F239BD
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 14:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08575FEEA;
	Fri, 12 Jan 2024 14:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XECdFivI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CD842A85;
	Fri, 12 Jan 2024 14:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FDEC433C7;
	Fri, 12 Jan 2024 14:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705070003;
	bh=JQFb0RwgqiOgAMfJwRMmXuTQbRDzY81oEPCIHnqCcqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XECdFivIpDVFW8d+q1cmUj0ydJ04m25sDXk08JNeJU9TSTa+XzAfMKH3SZIOeywQg
	 4aqirrDf11dWd0P7Un0TmdFh9UgFGd+se/YhlLdw2i6EFN+ZqbzUUmC8gd+tViFnSs
	 rJOHj8FRnqenuK9S2LGHVpS2Dr2HVNXE3U1Bbt89TSi6aTTuTyL3E283fecMbHdcyS
	 Tm3tGHDglm8Dm+BKGjiEm03m7a+85u/yoB8pUaeKGTnaY9EkBT71dZAZ6lvduX6HqE
	 DdDkCIVOlEd+oU6y/M4YdFspRKI98xxWM4F1t462Y8dTP4oFqXdf6jJU26l16G8ZvZ
	 bvjQMuzu7vevg==
Date: Fri, 12 Jan 2024 08:33:20 -0600
From: Rob Herring <robh@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	will@kernel.org, frowand.list@gmail.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, treding@nvidia.com,
	jonathanh@nvidia.com, kthota@nvidia.com, mmaddireddy@nvidia.com,
	sagar.tv@gmail.com
Subject: Re: [PATCH V2 1/2] dt-bindings: Add PCIe "preserve-boot-config"
 property
Message-ID: <20240112143320.GA3143039-robh@kernel.org>
References: <20240110030725.710547-1-vidyas@nvidia.com>
 <20240110030725.710547-2-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110030725.710547-2-vidyas@nvidia.com>

On Wed, Jan 10, 2024 at 08:37:24AM +0530, Vidya Sagar wrote:
> The existing "linux,pci-probe-only" property applies at a system level
> and it is not possible to selectively convey individual host bridge's
> requirement w.r.t preserving the boot configuration done by the platform
> firmware to the kernel. "preserve-boot-config" addresses that concern
> and can be used to preserve the boot configuration for host bridges
> selectivey.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V2:
> * None
> 
>  Documentation/devicetree/bindings/pci/pci.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
> index 6a8f2874a24d..0a5ff998cbe8 100644
> --- a/Documentation/devicetree/bindings/pci/pci.txt
> +++ b/Documentation/devicetree/bindings/pci/pci.txt
> @@ -32,6 +32,10 @@ driver implementation may support the following properties:
>     root port to downstream device and host bridge drivers can do programming
>     which depends on CLKREQ signal existence. For example, programming root port
>     not to advertise ASPM L1 Sub-States support if there is no CLKREQ signal.
> +- preserve-boot-config:
> +   If present this property specifies that this host bridge is already
> +   configured by the platform firmware and the OS doesn't need to reconfigure
> +   it again.

Anything new must be a schema.

Don't create something new to workaround the problem. Extend the 
existing support. For this, make "linux,pci-probe-only" allowed in host 
bridge nodes. Yeah, there's the issue that this property sets a global 
flag, but I'd imagine the PCI maintainers would agree that some flags 
should/could be per bus.

Rob

