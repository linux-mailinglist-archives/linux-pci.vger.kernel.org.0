Return-Path: <linux-pci+bounces-11558-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E599694D6FD
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 21:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7551F231FE
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 19:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD82915ECC3;
	Fri,  9 Aug 2024 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IT/3DQFG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFAF14D29B;
	Fri,  9 Aug 2024 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723230381; cv=none; b=V6uJrWneSjFOrqmM+7srCTWiD4VR/4edzUbyE5poGy9oyjUgxWD6g66i1MYlDzAJd+ZMo4xuqCCParEF3n4AL/LZx3FVm59DPN0guPwIoHTso3r2KbPL3LcRA6K8Nqz2rrNXmtPlCm+KxnQ/mg3NbTsFRmoqi5e5ShQC0a1LSdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723230381; c=relaxed/simple;
	bh=u34Xd5rz4JWanX5zVdA6gtjHYqcgdi9xC5E30BaCsAY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UAOPEqtn3YHmPO6pGLmjcwBrOURjGzqwJ03q36GVfVCWDG8Hu4xH6tq1olLcB6w4hb++bZhVGMUPDc4dtBLxTENh8YSwmfq+S/Hg1iHaGUnH6r7vokNC4sdYiBVom/7s+GjIE2aM19O880trbZ+IJWblKhAEcf6JY3LRtIls1y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IT/3DQFG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A92C32782;
	Fri,  9 Aug 2024 19:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723230381;
	bh=u34Xd5rz4JWanX5zVdA6gtjHYqcgdi9xC5E30BaCsAY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IT/3DQFGDQ8SVxZaUY9e6nFJ2+iyjayjEKDu0s+jObgn5SICq7pFm6MLMrPQjhf/D
	 UZAautMAmpXEcEvWn95POQrgsQjROAmHBaGhP0PDVTkXsZTa0arr98g7nzHHh12ZaR
	 E8naemEdZqiYSdrndo1jeMEAJvoeMHfZLhatP9THP1awIZDvJBZua018u9d1WGOYA3
	 Om8m54pRk8d4Nd0RImnWrNKtrAz9I0nNCnF4WX9xJ9GsTZMfEn3vaHAw1hXfq0wNMK
	 JPPn2fXLlXjbLBDjqRSUXinnAGF+FXRr3j0e68S4ICJdFY9+NvRywjIxp4ImGffGiu
	 7+ebQXNRKQOAg==
Date: Fri, 9 Aug 2024 14:06:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:PCI DRIVER FOR GENERIC OF HOSTS" <linux-pci@vger.kernel.org>,
	"moderated list:PCI DRIVER FOR GENERIC OF HOSTS" <linux-arm-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: PCI: host-generic-pci: Drop minItems
 and maxItems of ranges
Message-ID: <20240809190619.GA206533@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704164019.611454-1-Frank.Li@nxp.com>

On Thu, Jul 04, 2024 at 12:40:19PM -0400, Frank Li wrote:
> The ranges description states that "at least one non-prefetchable memory
> and one or both of prefetchable memory and IO space may also be provided."
> 
> However, it should not limit the maximum number of ranges to 3.
> 
> Freescale LS1028 and iMX95 use more than 3 ranges because the space splits
> some discontinuous prefetchable and non-prefetchable segments.
> 
> Drop minItems and maxItems. The number of entries will be limited to 32
> in pci-bus-common.yaml in dtschema, which should be sufficient.
> 
> Fix the below CHECK_DTBS warning.
> arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb: pcie@1f0000000: ranges: [[2181038080, 1, 4160749568, 1, 4160749568, 0, 1441792], [3254779904, 1, 4162191360, 1, 4162191360, 0, 458752], [2181038080, 1, 4162650112, 1, 4162650112, 0, 131072], [3254779904, 1, 4162781184, 1, 4162781184, 0, 131072], [2181038080, 1, 4162912256, 1, 4162912256, 0, 131072], [3254779904, 1, 4163043328, 1, 4163043328, 0, 131072], [2181038080, 1, 4227858432, 1, 4227858432, 0, 4194304]] is too long
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied with Rob's Reviewed-by to pci/dt-bindings for v6.12, thanks!

> ---
> Change from v1 to v2
> - Rework commit message
> - drop minItems and maxItems according to Rob's comments.
> ---
>  Documentation/devicetree/bindings/pci/host-generic-pci.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
> index 3484e0b4b412e..3be1fff411f8d 100644
> --- a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
> +++ b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
> @@ -102,8 +102,6 @@ properties:
>        As described in IEEE Std 1275-1994, but must provide at least a
>        definition of non-prefetchable memory. One or both of prefetchable Memory
>        and IO Space may also be provided.
> -    minItems: 1
> -    maxItems: 3
>  
>    dma-coherent: true
>    iommu-map: true
> -- 
> 2.34.1
> 

