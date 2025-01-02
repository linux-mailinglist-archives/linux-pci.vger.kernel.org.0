Return-Path: <linux-pci+bounces-19185-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC474A00047
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 21:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E6CD7A1FEB
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 20:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABD21A2543;
	Thu,  2 Jan 2025 20:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="usUcKBxZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5F81991A4;
	Thu,  2 Jan 2025 20:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735851409; cv=none; b=LI0V7nK8dYDaaLHC+5RWlbYOsvGhNY1wvn0VPBt9AgpuXZaWTX6cPB4aDdtbdbEBcr0Xf0bBhrtP0WhxSRziJBIDsejNlDZjFXl+2Jn/cYPhbGLU5Q9PFUIMHgxBSgWNOidNPk9uLBm4FBgKrUnmTiMNQiHUAMq8WV1sddwLKYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735851409; c=relaxed/simple;
	bh=ji3BhuMiKT5tbtN9s2wyOCpnJmotWM9qJXBuodpEYXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3/FLC1FLPT2mPoqleJh+7YXaeIiZ4EZkFWz1yYkpRQFw+u+DXtWMOdv1aVwVxte1gP3Ucv/vpIYKW79YMfD+ZqTQYkHIiM3WVxe749h6kJJSQjDGTrKZrPtTgpmdJB1hg9bhKKScSYq9t/6VE0SQKyAQogE6Xxg/+u+aMXJv8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=usUcKBxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4ABC4CED0;
	Thu,  2 Jan 2025 20:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735851409;
	bh=ji3BhuMiKT5tbtN9s2wyOCpnJmotWM9qJXBuodpEYXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=usUcKBxZFO2Rb8mxXnav4tPdhDRfCS69CI9YcXFPbuRERXJATuwIfEf9Imqsm2J0r
	 2dcUyEHkpeET5XMbTx3wFEdx0FLGtULkdPO+d9dkFgO0lwdW+RSOZ076Unkqu6ybHY
	 k27z5gbOp/iTRc4B7p9O4BQc0gqLhnT26nVRtXiAewWkrQD9ZsaJ5HwvB8POR+oEcU
	 q9F4/8BByBkg2Uyv6aAXAoNmCRNa5lUHA8JvjQzGHfWBXStpDe5TLze8O/vCnJU8L2
	 PDdpW4rakxnhitKKE7dUnefvlgVQJpr68WH9L6VGJod344VHj7jSgVQiuUyv/P8uZQ
	 5dRteHVfZfRxQ==
Date: Thu, 2 Jan 2025 14:56:47 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, devicetree@vger.kernel.org,
	bharat.kumar.gogada@amd.com, jingoohan1@gmail.com,
	michal.simek@amd.com, conor+dt@kernel.org, krzk+dt@kernel.org,
	linux-pci@vger.kernel.org, kw@linux.com, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] dt-bindings: PCI: amd-mdb: Add AMD Versal2 MDB
 PCIe Root Port Bridge
Message-ID: <173585140656.554296.13076997282582601219.robh@kernel.org>
References: <20241226060043.18280-1-thippeswamy.havalige@amd.com>
 <20241226060043.18280-3-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241226060043.18280-3-thippeswamy.havalige@amd.com>


On Thu, 26 Dec 2024 11:30:42 +0530, Thippeswamy Havalige wrote:
> Add AMD Versal2 MDB (Multimedia DMA Bridge) PCIe Root Port Bridge.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> ---
> Changes in v2:
> -------------
> - Modify patch subject.
> - Add pcie host bridge reference.
> - Modify filename as per compatible string.
> - Remove standard PCI properties.
> - Modify interrupt controller description.
> - Indentation
> 
> Changes in v3:
> -------------
> - Modified SLCR to lower case.
> - Add dwc schemas.
> - Remove common properties.
> - Move additionalProperties below properties.
> - Remove ranges property from required properties.
> - Drop blank line.
> - Modify pci@ to pcie@
> 
> Changes in v4:
> -------------
> - None.
> 
> Changes in v5:
> -------------
> - None.
> Changes in v6:
> --------------
> - Reduce dbi size to 4k.
> - update register name to slcr.
> ---
>  .../bindings/pci/amd,versal2-mdb-host.yaml         | 121 +++++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


