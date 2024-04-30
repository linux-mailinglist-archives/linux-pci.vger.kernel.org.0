Return-Path: <linux-pci+bounces-6864-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C4E8B6F8F
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 12:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574C41C2143A
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 10:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA5EFC02;
	Tue, 30 Apr 2024 10:22:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E0113D268
	for <linux-pci@vger.kernel.org>; Tue, 30 Apr 2024 10:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714472566; cv=none; b=B7GdOC0iL4yDQcMnIO+aIpobtfuB11NywMPBo4q33tJp+2XySlS7L8Frf4U9HxU1drAYw7VbUvXDEG4KIeJnBgmUM24vOybb/HsFtdeiHPiOaWBSWQq6KC0WkN7hOHrUf+ij/gS4wGN6jlJniE63wdjG1tq85aUMIDyIB1MkWnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714472566; c=relaxed/simple;
	bh=krf2c1GkUobPI6NrzHHAPV2pd3geJngPoEGsQX9XiYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Drw+WUsQLj6iIEmGloBVzsuleRda5coKGP3Cwvik0kvgVnk1FRAkiKWa1gWwaxShhmt172OrWwZ1QbaqaeDGNx11HT14xOT9N8VV3aGzz+UpzRBdXB1jGweOYMoooJCmUlfPq+OBUgqmu0rbkZlhSWT45ddTXGNrdK+6TUSePKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 738D7339
	for <linux-pci@vger.kernel.org>; Tue, 30 Apr 2024 03:23:11 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BE72B3F73F
	for <linux-pci@vger.kernel.org>; Tue, 30 Apr 2024 03:22:44 -0700 (PDT)
Date: Tue, 30 Apr 2024 11:22:29 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: will@kernel.org, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	sudeep.holla@arm.com, joro@8bytes.org, robin.murphy@arm.com,
	nicolinc@nvidia.com, ketanp@nvidia.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: PCI: generic: Add ats-supported property
Message-ID: <ZjDGZdkTDmlVcUGf@e110455-lin.cambridge.arm.com>
References: <20240429113938.192706-2-jean-philippe@linaro.org>
 <20240429113938.192706-3-jean-philippe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240429113938.192706-3-jean-philippe@linaro.org>

On Mon, Apr 29, 2024 at 12:39:37PM +0100, Jean-Philippe Brucker wrote:
> Add a way for firmware to tell the OS that ATS is supported by the PCI
> root complex. An endpoint with ATS enabled may send Translation Requests
> and Translated Memory Requests, which look just like Normal Memory
> Requests with a non-zero AT field. So a root controller that ignores the
> AT field may simply forward the request to the IOMMU as a Normal Memory
> Request, which could end badly. In any case, the endpoint will be
> unusable.
> 
> The ats-supported property allows the OS to only enable ATS in endpoints
> if the root controller can handle ATS requests. Only add the property to
> pcie-host-ecam-generic for the moment. For non-generic root controllers,
> availability of ATS can be inferred from the compatible string.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

> ---
> From a while ago: https://lore.kernel.org/all/20200219222454.GA16221@bogus/
> ---
>  Documentation/devicetree/bindings/pci/host-generic-pci.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
> index d25423aa71674..94d4a4914a483 100644
> --- a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
> +++ b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
> @@ -110,6 +110,12 @@ properties:
>    iommu-map-mask: true
>    msi-parent: true
>  
> +  ats-supported:
> +    description:
> +      Indicates that a PCIe host controller supports ATS, and can handle Memory
> +      Requests with Address Type (AT).
> +    type: boolean
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.44.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

