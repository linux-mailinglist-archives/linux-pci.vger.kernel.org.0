Return-Path: <linux-pci+bounces-24632-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2538A6EB51
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 09:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63C8F16C38E
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 08:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7531531E8;
	Tue, 25 Mar 2025 08:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLa7zgvd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD091EB5B;
	Tue, 25 Mar 2025 08:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742890658; cv=none; b=hD38/+hD9NC42CzakoOPUr4EQFG4M00TGsHYSu7PxfADJFzsqcLZfEY3TIxckKZJSMGz4QlGzXg2NT/6xtGmG37OmXl0apoBK/EpflWx4ckbcPdk0pUjZg5GsIByGGxQ/0ZPY5m/nREAH+G5ToaJE5EZZfyaGTFF89cfvsv52YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742890658; c=relaxed/simple;
	bh=gKNHMvunsf0QCn4x1vQ3ox9/4PDJk+WGGmXX91GKMJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdR7GR6wy5xkUH1/tyHhyGo6ZyQJgM7Vgy3BVWi2sra0O1gxZELyp3bsVOGf8BubWtPHGXfvz9iAgvMv5sL6o7/vU2Pc7WCRSKPlvwsmdmx/j6ChN1+ci9r3mUNwMLGhDAAQo59UAomEU3hIimqF7jRydheabPQjPNOLlBM8IiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLa7zgvd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D9AC4CEE4;
	Tue, 25 Mar 2025 08:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742890658;
	bh=gKNHMvunsf0QCn4x1vQ3ox9/4PDJk+WGGmXX91GKMJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RLa7zgvdSkMAFnp6pUvDe4zheddMlB3KScxqFwwHiqWiudTbwjalyl06DC+N0gO09
	 KfRHtq2kXTyWdGKfDakdnxoWv/n/Yv8QRG1nkay8Mx2Tlkor0wux1/Y6Ur4Psm6Ves
	 ZIh0DPL6tMZEsF1I+9DB70P5e+Ok/+PExt7iypFYv8e/z1ivFYYtHNvyYN59K7kVZ3
	 HaAWuYlvtwtoCI08taIJjbsERK6msit7L4nZ30SuS8eONBm14wd+eiFSw56ka6Ik2z
	 iOriMlNYQ7TOxD4FtDQ6U88woxQ8D/TRdAfLIjb1S7w30NW/fjCP0JqUbwaFQeLYeS
	 2H7GPA9hHE+WA==
Date: Tue, 25 Mar 2025 09:17:35 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Rob Herring <robh@kernel.org>, Thippeswamy Havalige <thippeswamy.havalige@amd.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: PCI: xilinx-pcie: Add reset-gpios
 for PERST#
Message-ID: <20250325-victorious-silky-firefly-2a3cec@krzk-bin>
References: <20250325071832.21229-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.7424060c-f116-40af-8bb3-d789f371b07a@emailsignatures365.codetwo.com>
 <20250325071832.21229-2-mike.looijmans@topic.nl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250325071832.21229-2-mike.looijmans@topic.nl>

On Tue, Mar 25, 2025 at 08:18:26AM +0100, Mike Looijmans wrote:
> Introduce optional `reset-gpios` property to enable GPIO-based control
> of the PCIe root port PERST# signal, as described in pci.txt.

Drop pci.txt, we don't use TXT bindings anymore.

> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> 
> Changes in v2:
> Add binding for reset-gpios

So what was in v1? Empty patch?


> 
>  .../devicetree/bindings/pci/xlnx,axi-pcie-host.yaml          | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/xlnx,axi-pcie-host.yaml b/Documentation/devicetree/bindings/pci/xlnx,axi-pcie-host.yaml
> index fb87b960a250..2b0fabdd5e16 100644
> --- a/Documentation/devicetree/bindings/pci/xlnx,axi-pcie-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/xlnx,axi-pcie-host.yaml
> @@ -28,6 +28,9 @@ properties:
>            ranges for the PCI memory regions (I/O space region is not
>            supported by hardware)
>  
> +  reset-gpios:
> +    maxItems: 1

Why do you need it? It's already there, in PCI schemas, isn't it?

Why is this patch needed?

Best regards,
Krzysztof


