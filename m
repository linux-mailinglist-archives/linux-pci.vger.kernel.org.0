Return-Path: <linux-pci+bounces-25691-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC34DA866B5
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 21:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3AB24A4464
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 19:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D24B281364;
	Fri, 11 Apr 2025 19:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkG5LWNH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F302280CFD;
	Fri, 11 Apr 2025 19:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744401372; cv=none; b=HvXDkkvzOU8sbBKaqGG+35FaMbsD8UIkbkAb5S7khKo3EU2olSqk3mNV4f/QPtzNNLhuRcxdhAqMNUd8W67Yp2f5e0yh8KYlEL4wsz5n/dg/xQlLskvToURXtI1d+Qhi45NpmSvvtfJIzBbZxr6JDgNk9MFvJ1qCx5frwRRDa9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744401372; c=relaxed/simple;
	bh=YYAiW0Mv4zJyPouWJZFa+MX5kzRMh1yCPjI3lCBMmT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y41vPMLYIVTIMu60k6MSD5u+7iNlqidwlbLwTQ5hHC7fLF/DTSERVD2teJEWFAm8lyycRtJDMlZCxvEpkxDPRQD9Bm+T6i0s+971l+Hm7RSWnNLCLhF/aOCxEmzx+KSUM8XoE+wUfg6bb4A9EOt74XcoikOJ2gp4HR7hRnUJyBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkG5LWNH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F183DC4CEF0;
	Fri, 11 Apr 2025 19:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744401372;
	bh=YYAiW0Mv4zJyPouWJZFa+MX5kzRMh1yCPjI3lCBMmT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mkG5LWNHe3ZxW8Ppq2uHQLcq2DhkirLCQKnFqO6RQGrwyBCAq1VLHdHh0Qb+UBYaI
	 fzSqodGOAnwO+kqwWESolidzwRyxl7WTLYdBuuM6mNmfB/3GyQdUq36rFtkbCqij2H
	 xDYbYGY6GeV4DdzVMSaJG2Q/GAD3lIq8fbKcLwINTdYNCu3Tuep4PQXZBQxd/GVOlS
	 Z+INUr6NZndFk9pFrk4XTwmCHmpxSEprJFiytLre8/me8ETMVhh7JwzltLd5SxKx63
	 tPdI104+lTg9doTzhPJex58a0aM1e/h2jqdP4cDERyMJPfuan9X1ch/IcrjNBktuds
	 XMshNtW48S4Zg==
Date: Fri, 11 Apr 2025 14:56:10 -0500
From: Rob Herring <robh@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Manikandan K Pillai <mpillai@cadence.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: pci: cadence: Extend compatible for
 new RP configuration
Message-ID: <20250411195610.GA3781976-robh@kernel.org>
References: <20250411103656.2740517-1-hans.zhang@cixtech.com>
 <20250411103656.2740517-2-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411103656.2740517-2-hans.zhang@cixtech.com>

On Fri, Apr 11, 2025 at 06:36:51PM +0800, hans.zhang@cixtech.com wrote:
> From: Manikandan K Pillai <mpillai@cadence.com>
> 
> Document the compatible property for HPA (High Performance Architecture)
> PCIe controller RP configuration.
> 
> Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
> ---
>  .../devicetree/bindings/pci/cdns,cdns-pcie-host.yaml        | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
> index a8190d9b100f..83a33c4c008f 100644
> --- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
> @@ -7,14 +7,16 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Cadence PCIe host controller
>  
>  maintainers:
> -  - Tom Joseph <tjoseph@cadence.com>

Why removing? What about all the other Cadence PCIe files?

> +  - Manikandan K Pillai <mpillai@cadence.com>
>  
>  allOf:
>    - $ref: cdns-pcie-host.yaml#
>  
>  properties:
>    compatible:
> -    const: cdns,cdns-pcie-host
> +    enum:
> +      - cdns,cdns-pcie-host
> +      - cdns,cdns-pcie-hpa-host
>  
>    reg:
>      maxItems: 2
> -- 
> 2.47.1
> 

