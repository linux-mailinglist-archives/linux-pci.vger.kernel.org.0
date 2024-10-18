Return-Path: <linux-pci+bounces-14882-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FE69A4672
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 21:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA745B23760
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 19:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD10A204083;
	Fri, 18 Oct 2024 19:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aU90RmA2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76412188733;
	Fri, 18 Oct 2024 19:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729278212; cv=none; b=Qk7NEpOaF47ZlZL5ttZ0p3gvuDRd9RLG8mSLeFqc982inT7+RwC8kkZnweyLRsQoU9y8duf0+15hWUroCx4Py9aMigUhLoSYNSX0G3f2i5z8BaAj/PW8uYmjgG2aGhEfLj79qVOankgZon8xHKFqa3gj61FFLRDGS8k/+aLq4NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729278212; c=relaxed/simple;
	bh=wwxkrXeUFvfcE/cTHwhzsmHDNbS8UoTSLlf3lhIJw8c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=j6f5mSj8uUy+qsUOPH9WscV1fMV2GaJbjytMdYKZ9CXL9fl6utcgQK+HMF0o7nNMOrQDmBoZwtDmB55BzS9CExN9z7xT3YPXtGZz843FEilT94jHsIEa2SDrw+NQNjpVYPIOugZm4TTQu2+MHe5fWCQgf5akZ6/xM3srIZN9b0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aU90RmA2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DED6C4CEC3;
	Fri, 18 Oct 2024 19:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729278212;
	bh=wwxkrXeUFvfcE/cTHwhzsmHDNbS8UoTSLlf3lhIJw8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aU90RmA275lZmmTZLkJsAtP3CcfFEbOc84pILLx6gNAz8hyqipyjPk1GH2ENeiZ3B
	 KzJXDlGkspwazitVeYWT88VYv0BIkvS56TditbD+gqjmTbhheVhpEWl2YEx62Jb2vR
	 uya28HFx3D7IsStvIWxNd22P9u5l4N09abnHHX0NxU/yD8L5q69j3jBFCKh9iZMIAd
	 3xZREh+OfadYgsKJuRFcyA4YNfyYR++Tt6q+dz0EsmguoGrFDMIvNonKlru7pAt25n
	 wjD01M1UgTx0l5ZjqGeeEqC6yxwUcB6sQUcNmSzNYDR16o/CLJcM9KIGfKLvQOiV76
	 seMGzRIGb1Pkg==
Date: Fri, 18 Oct 2024 14:03:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] RFC: dt bindings: Add property "brcm,gen3-eq-presets"
Message-ID: <20241018190330.GA757230@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018182247.41130-2-james.quinlan@broadcom.com>

On Fri, Oct 18, 2024 at 02:22:45PM -0400, Jim Quinlan wrote:
> Support configuration of the GEN3 preset equalization settings, aka the
> Lane Equalization Control Register(s) of the Secondary PCI Express
> Extended Capability.  These registers are of type HwInit/RsvdP and
> typically set by FW.  In our case they are set by our RC host bridge
> driver using internal registers.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  .../devicetree/bindings/pci/brcm,stb-pcie.yaml       | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> index 0925c520195a..f965ad57f32f 100644
> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> @@ -104,6 +104,18 @@ properties:
>      minItems: 1
>      maxItems: 3
>  
> +  brcm,gen3-eq-presets:
> +    description: |
> +      A u16 array giving the GEN3 equilization presets, one for each lane.
> +      These values are destined for the 16bit registers known as the
> +      Lane Equalization Control Register(s) of the Secondary PCI Express
> +      Extended Capability.  In the array, lane 0 is first term, lane 1 next,
> +      etc. The contents of the entries reflect what is necessary for
> +      the current board and SoC, and the details of each preset are
> +      described in Section 7.27.4 of the PCI base spec, Revision 3.0.

s/equilization/equalization/

The spec citation ("PCI base spec r3.0") isn't quite right since
Conventional PCI doesn't have lanes.  These registers *are* defined in
PCIe r3.0, sec 7.27.4, but that's 14 years old.  It would be more
helpful to use a current spec version like PCIe r6.2, sec 7.7.3.4.

Since there's nothing about these registers that is brcm-specific
(other than the fact that they are typically set by firmware on
non-brcm platforms), it would be nice if we could give it a non-brcm
name.

Similarly, I think it would be nice to drop "gen3" from the name (and
the description).  The registers *were* added in PCIe r3.0, which also
added the 8 GT/s rate, and the description in PCIe r6.2, sec 7.7.3.4
does mention 8.0 GT/s specifically, but sec 4.2.4 says equalization
applies to "8.0 GT/s and higher data rates," so it's definitely not
limited to gen3.

Bjorn

