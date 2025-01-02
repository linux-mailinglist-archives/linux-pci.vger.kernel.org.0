Return-Path: <linux-pci+bounces-19184-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACB9A00043
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 21:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30FD73A2C7A
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 20:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC361A2543;
	Thu,  2 Jan 2025 20:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lO9VSnjS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5EF1C36;
	Thu,  2 Jan 2025 20:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735851375; cv=none; b=NAc/Sd6fvWZQ7nJYW/j2tLDrikGeMQwI1lG6oqx2p+Op1Vx0+HCMvuIXEuw/UIFvvDt61qeuHk648/CWI4EO5615QtLjjWV8Szk/ppTBcSDhPoB5F2H1zb/UBZlBZtsyD3DZeujS8diLXUUXo/fNBNzc/FpgtSH7Y4bEjLO++Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735851375; c=relaxed/simple;
	bh=JgHcU1sNfX0APkiO1gLUk5iiEZ2pCN6hxj1Nb/jUskc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0hr8p9p4U8P1CpSFwnohZJkh32cU6SXOmHqi1yr67B9T/nfyDI1h7STZiaO6B9LnMWnqk6eIyX9rgdRW5h70jS4rK93zLJUHnXEN0gGrIeA0A9gvKvB+yZh1wpZa9yLodTwykpu3wvlEqDy7QGBJ1ckXCxYTYXxVqpKy4nItQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lO9VSnjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F77C4CED0;
	Thu,  2 Jan 2025 20:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735851374;
	bh=JgHcU1sNfX0APkiO1gLUk5iiEZ2pCN6hxj1Nb/jUskc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lO9VSnjSN7cfhCfC1G1EZVYetp3TILdbucV6JqOCF7tAP2r52USaMD8HSl5FyAgis
	 NDqYqdXsg5YaGv7kyB94aMeVWTI1fN9OdBlPuD+CV7Syd06gPziuA6Yta2bMjUjck5
	 La1vWE0ukQkv74pFHYIKBLhBvitpru72u2v16AYvhB7TMUmvx32QFnVymC/ehvv1m2
	 7gIrBXs/XvXQDLamaUmoscppIzqnYFyRfP5l5nVbaY03v/ZI9oAt5Ml3Dxk4k8/Q6n
	 57ltBknusHcIuAtJQJwn6XWKr/wxrPQ7+FG2h1k4jvq104t6y485E4xnjR0n0idmXb
	 4Uuw263I6sfzg==
Date: Thu, 2 Jan 2025 14:56:12 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: lpieralisi@kernel.org, devicetree@vger.kernel.org, jingoohan1@gmail.com,
	michal.simek@amd.com, kw@linux.com, bharat.kumar.gogada@amd.com,
	krzk+dt@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
	linux-pci@vger.kernel.org, manivannan.sadhasivam@linaro.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: PCI: dwc: Add AMD Versal2 mdb slcr
 support
Message-ID: <173585137139.553410.5097538568077551781.robh@kernel.org>
References: <20241226060043.18280-1-thippeswamy.havalige@amd.com>
 <20241226060043.18280-2-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241226060043.18280-2-thippeswamy.havalige@amd.com>


On Thu, 26 Dec 2024 11:30:41 +0530, Thippeswamy Havalige wrote:
> Add support for mdb slcr aperture that is only supported for AMD Versal2
> devices.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> ---
> Changes in v3:
> -------------
> - Introduced below changes in dwc yaml schema.
> Changes in v5:
> -------------
> - Modify mdb_pcie_slcr as constant.
> Changes in v6:
> -------------
> -Modify slcr constant
> ---
>  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


