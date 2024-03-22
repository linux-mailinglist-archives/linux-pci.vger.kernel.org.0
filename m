Return-Path: <linux-pci+bounces-5010-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C55887088
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 17:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8561F241A2
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 16:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395FE5820D;
	Fri, 22 Mar 2024 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srrNW3NJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097A25820C;
	Fri, 22 Mar 2024 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123838; cv=none; b=dWBNRNGFXuIDkASoSFX/XVTVAcnqfkLJ84X27LbbF2q48fFJ3KCd9q8Dh0yyi0eY0BvbrrapdYCucXoa6LzIIvghbFTosGOgfp3RhJ14q6D9B/ZLUpGGATUkhA33sTqzbcrcddiE4z94k8+bX5r5zjJxxxJNcmv2Gr+4n/GbRlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123838; c=relaxed/simple;
	bh=JoSFEolLXCBXv+vKZOe9Vw6+myyFGlxuio2JgUbS600=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e29wUfHqTSqg+na5FRUjmejx/IK4lNntL1HPrytGiK3n0/OmVxIjBDOYrcouj4RNFpO2+lupFv2pUEHsWLJpznn1EAsqT154k8RyVnQhN3dfm5G7S0Q0zU5zYPGM8DbdoAFm4t35V6luLANUDE+9kzD8aB73gtohhSqnbCoQVNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srrNW3NJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E2FC433F1;
	Fri, 22 Mar 2024 16:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711123837;
	bh=JoSFEolLXCBXv+vKZOe9Vw6+myyFGlxuio2JgUbS600=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=srrNW3NJI//G7KulUkxk0eLjgKOaFMqQadxF9OcYUI49g93tqIwy92qZX9ZuUyZcP
	 an8LdGNd6X+G/VkxpfuUSpPPFmxI587PJi9WTRZj/IR+79DJWefS3dia6SXKmR4zIg
	 Peh9OkcOj4gDJ2MbWgUhMl/3T/3fvsrz2h9Y2O7OHTLa0yHIL3GfeeZnB+2EsXTY4A
	 O+hg1qIKNnkeZekhJR477jqjHNFwdn1rRvCQnCPMpQNIPFi6WP9b66RmbHW+TghiD0
	 qsJLB3RjlG3DyU/N+7peK4xPuU1Yyqd8IRLlfvcStUgy/9YyiJb30RkUU+3E75Pvcv
	 DRssZEse9TVNw==
Date: Fri, 22 Mar 2024 17:10:31 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 07/11] PCI: dwc: ep: Add a generic dw_pcie_ep_linkdown()
 API to handle Link Down event
Message-ID: <Zf2td2CJtaOwAj-x@ryzen>
References: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
 <20240314-pci-epf-rework-v1-7-6134e6c1d491@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314-pci-epf-rework-v1-7-6134e6c1d491@linaro.org>

On Thu, Mar 14, 2024 at 08:53:46PM +0530, Manivannan Sadhasivam wrote:
> As per the PCIe base spec r5.0, section 5.2, Link Down event can happen
> under any of the following circumstances:
> 
> 1. Fundamental/Hot reset
> 2. Link disable transmission by upstream component
> 3. Moving from L2/L3 to L0
> 
> In those cases, Link Down causes some non-sticky DWC registers to loose the
> state (like REBAR, etc...). So the drivers need to reinitialize them to
> function properly once the link comes back again.
> 
> This is not a problem for drivers supporting PERST# IRQ, since they can
> reinitialize the registers in the PERST# IRQ callback. But for the drivers
> not supporting PERST#, there is no way they can reinitialize the registers
> other than relying on Link Down IRQ received when the link goes down. So
> let's add a DWC generic API dw_pcie_ep_linkdown() that reinitializes the
> non-sticky registers and also notifies the EPF drivers about link going
> down.
> 
> This API can also be used by the drivers supporting PERST# to handle the
> scenario (2) mentioned above.
> 
> NOTE: For the sake of code organization, move the dw_pcie_ep_linkup()
> definition just above dw_pcie_ep_linkdown().
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>

