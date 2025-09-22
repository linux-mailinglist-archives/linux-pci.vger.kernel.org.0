Return-Path: <linux-pci+bounces-36705-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A3BB924E3
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 18:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FA61188B4D0
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 16:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947383115AD;
	Mon, 22 Sep 2025 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgRpaLe9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6491330CDA6;
	Mon, 22 Sep 2025 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758559848; cv=none; b=ThIvZ9EJ+Lg/XrwHIrCFehpJtK1LA1UAYW34pyqr48loaZsXhlJyc3qAgG4QOdHLau2TcpfVHRi/KcFefsNv+bz4sjWffo2AHYV/NVeuVN+OYYmDQexPd3mhAQ1GHz5Es1ssG5wI3YO9++Wr4efHUJP/zAYxfKM9hg23l8sN5f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758559848; c=relaxed/simple;
	bh=SmYHS6MJbi0vRw6qB/2BTayFi9UqFpognQacTg5pVXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAwpqaA0F125/dw5uDlUq5GTanaC1O+xHhcKy3G5LBfGXwt02Dkz8qbEjB8mvqMima2ez+ySB1hLm8X0Ah5RhUs7wOdP6cS1OVv3rn7NUyXM29Lub42zoDQKGO5pt4YxJdIeUYkmPQARLDK8GvEmHMEr8uGNgzvu/yuHDL75Zxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgRpaLe9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97B2C4CEF0;
	Mon, 22 Sep 2025 16:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758559848;
	bh=SmYHS6MJbi0vRw6qB/2BTayFi9UqFpognQacTg5pVXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JgRpaLe9mPRAsaZBexDSLcYyDGflu/cGHmjb5A9woWtWBlZh8F+Y5dWKZcg7Z4z0i
	 HtICrPn/KFhQzRUKM108f42vF4MgHew/4egR5ogSg81mN/p4u4TKOVl54Zl3aXz0t1
	 ggStJsUqvvbf0cVxY612FdiDDuN2pJcbXZ1tgNrEoQ5AhUrdCzatcgF/e/Dtvilh4q
	 PkhvkyYOEGn1hxon29vLtkRZNnuYG/dRHVy/HLewwRhbvdl0L6RZMfeI/Mxc5/A2C+
	 KVasxB4FpAIaSBIVys8eBlJVfEyGlJeMrr/JJfyLieBk3hyCck6PGHCPPWwsZfeZ9L
	 hcxxm1LYYEsxQ==
Date: Mon, 22 Sep 2025 11:50:47 -0500
From: Rob Herring <robh@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, bhelgaas@google.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: PCI: dwc: Add one more reference
 clock
Message-ID: <20250922165047.GA436960-robh@kernel.org>
References: <20250917045238.1048484-1-hongxing.zhu@nxp.com>
 <20250917045238.1048484-2-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917045238.1048484-2-hongxing.zhu@nxp.com>

On Wed, Sep 17, 2025 at 12:52:36PM +0800, Richard Zhu wrote:
> Add one more reference clock "extref" for a reference clock that comes
> from external crystal oscillator.

See what I just commented on v5.

> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/pci/snps,dw-pcie-common.yaml        | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> index 34594972d8db..0134a759185e 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> @@ -105,6 +105,12 @@ properties:
>              define it with this name (for instance pipe, core and aux can
>              be connected to a single source of the periodic signal).
>            const: ref
> +        - description:
> +            Some dwc wrappers (like i.MX95 PCIes) have two reference clock
> +            inputs, one from an internal PLL, the other from an off-chip crystal
> +            oscillator. If present, 'extref' refers to a reference clock from
> +            an external oscillator.
> +          const: extref
>          - description:
>              Clock for the PHY registers interface. Originally this is
>              a PHY-viewport-based interface, but some platform may have
> -- 
> 2.37.1
> 

