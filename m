Return-Path: <linux-pci+bounces-29954-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 073E5ADD7C4
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 18:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3561F7A8377
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 16:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4ED2EA72C;
	Tue, 17 Jun 2025 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCq/D8Vl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA962FA642;
	Tue, 17 Jun 2025 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178744; cv=none; b=dDQVGTFEy+F2OjlNO/q4QxFLnvwJSYVVZ22olJmHuhdFa628RApHwwQ2VLD0aOPTfPh3AksZH3PgW3C2o+FAjSnk7UycYrWJvlmqu6BJhb6S7nQOaTN+cbD/nwUEoUJTwOdsGrBFxg3sYHn0CpkkakHpVWVOUJG8TM1PXTHhl9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178744; c=relaxed/simple;
	bh=eOuj0um5s9Ht12TDusUThSaJpwRfZcw9YesjbP8lFYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4AcNiSbVtbKc7yrE9Bwan6BWCwF3Wxmas7QYyIUrHn0jYGt99H7WJbNeiJOd+XO0GeQ4ATWd+g1DHEO6l49Dox2BawRgbDuYTEZ9fkJD1xjq/nycVehRunx6c91sKyo4/RyGXYyIgvDh0968/kLMojzd6SptGr7jdDa92xggBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCq/D8Vl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850F7C4CEE3;
	Tue, 17 Jun 2025 16:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750178744;
	bh=eOuj0um5s9Ht12TDusUThSaJpwRfZcw9YesjbP8lFYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nCq/D8VlWTpBu2CPANOsbvbUXzRlauRrRrhvKXNMQbHx7oHcptA015u354mZ6eAnA
	 IJEhHIeHXRFhY3vrpAl/gYAOFJ1bldN85pVnT5eXTQ7U98Q8wvOCKTEqjQy37EP977
	 pts6wF7kM8qNH3e/bnltf4Z7sHQOwdtIN3R8lHt4WshYujrGYN5Tig4Yp2cvCkWO2J
	 n9MbQ/m4F7WGE+/Yfzva3ueY3bMljqBao0lFuLJPinE0EXHygyIydpXre1sbng4+Mr
	 pZrFEkqkEdIryNU/rODBTULBho6M4VVUFIZR3A4gC89guav1pHTiI1lrt4QdjqQk0U
	 bgXU9NvIASv3w==
Date: Tue, 17 Jun 2025 22:15:36 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	krzk+dt@kernel.org, manivannan.sadhasivam@linaro.org, conor+dt@kernel.org, 
	robh@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: Extend max-link-speed to
 support PCIe Gen5/Gen6
Message-ID: <q5ltnilbdhfxwh6ucjnm3wichrmu5wyjsx6eheiazqypveu3sm@euuvpjwu77h4>
References: <20250529021026.475861-1-18255117159@163.com>
 <20250529021026.475861-2-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250529021026.475861-2-18255117159@163.com>

On Thu, May 29, 2025 at 10:10:24AM +0800, Hans Zhang wrote:
> Update the device tree binding documentation for PCI to include
> PCIe Gen5 and Gen6 support in the `max-link-speed` property.
> The original documentation limited the value to 1~4 (Gen1~Gen4),
> but the kernel now supports up to Gen6. This change ensures the
> documentation aligns with the actual code implementation.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  dtschema/schemas/pci/pci-bus-common.yaml | 2 +-

As Rob commented in v1, this file lives in dtschema project. So update it there:
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/pci-bus-common.yaml

- Mani

>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/dtschema/schemas/pci/pci-bus-common.yaml b/dtschema/schemas/pci/pci-bus-common.yaml
> index ca97a00..413ef05 100644
> --- a/dtschema/schemas/pci/pci-bus-common.yaml
> +++ b/dtschema/schemas/pci/pci-bus-common.yaml
> @@ -121,7 +121,7 @@ properties:
>        unnecessary operation for unsupported link speed, for instance, trying to
>        do training for unsupported link speed, etc.
>      $ref: /schemas/types.yaml#/definitions/uint32
> -    enum: [ 1, 2, 3, 4 ]
> +    enum: [ 1, 2, 3, 4, 5, 6 ]
>  
>    num-lanes:
>      description: The number of PCIe lanes
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

