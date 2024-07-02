Return-Path: <linux-pci+bounces-9597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F729243C7
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 18:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99BC21F2759B
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 16:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009B31BD4FD;
	Tue,  2 Jul 2024 16:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLGyJEH1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C357C14293;
	Tue,  2 Jul 2024 16:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719938633; cv=none; b=HrpXX9gKjjjKNEb9UwbZFXTgaP0jsKPt9INFwD5zmvHg0T47KDB6VaU/wJHBPcztHwg9nY0+t5Q/Evsp7BnrV7hipVzJ8epgwBG/zCqWE641POBlSER2wiDXFaJX5i1tCE1081I8kpOSBfkiaOHJuKoypcPnzGIiRXMM3hSmEnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719938633; c=relaxed/simple;
	bh=//GomSYzOrge1gnmNadrT9G0k2ZttW4yn36f5CsKAvw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qTnN1S13T7L4bkqtf8QyGD2shc6Y4Emczet/FQPscH10HLvlf1hZ18uey1PxrXgvy6Yeax8XVilLTy4D52WsOmGwFCRGBpeO+uBfemYNwZec9arOdBB3CYi8hgYpWFZSln7uRb3U0qj6CeIvbWr9NM9DEbmaJT2owOSpKBQOQ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLGyJEH1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00DDC116B1;
	Tue,  2 Jul 2024 16:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719938633;
	bh=//GomSYzOrge1gnmNadrT9G0k2ZttW4yn36f5CsKAvw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YLGyJEH1LgNy6sNeJsd97YWjI/5MyhTsyhwh7HT/hiY7+q82ntuMSUg7ofh7T2hCJ
	 Xb/N/k3HzlS4jPEqFx2O93JfRBPUcirTia52XvGg68hzysVwr2EnofpHKRPnjzpXYk
	 4o96rBgNY/Sdo6wKBEcSKaiXU3hPSSuc74ziVWRSqTz4k7tcrJeZxs3uZ89YE3n5Ot
	 f4leie9vwnk3dY779JyP6401FZF+cVsVwLRei1teTvidDRPZGZKE6bQ3qsfEHG/FyH
	 Gfzf+7s9xYItiXql3UjuQcI6quBu5Y+lnD+iNK0OrbKOMJJxhwUsRklz6xZ2uPh91m
	 185xgwU+0TMxw==
Date: Tue, 2 Jul 2024 11:43:50 -0500
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
Subject: Re: [PATCH 1/1] dt-bindings: PCI: host-generic-pci: Increase
 maxItems to 8 of ranges
Message-ID: <20240702164350.GA24498@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702153702.3827386-1-Frank.Li@nxp.com>

On Tue, Jul 02, 2024 at 11:37:02AM -0400, Frank Li wrote:
> IEEE Std 1275-1994 is Inactive-Withdrawn Standard according to
> https://standards.ieee.org/ieee/1275/1932/.

I'm not quite sure what the connection is?  Is the sentence below a
quote from the spec above?  Perhaps include the section number it came
from?

> "require at least one non-prefetchable memory and One or both of
> prefetchable Memory and IO Space may also be provided". But it does not
> limit maximum ranges number is 3.

"But IEEE Std 1275-1994 does not limit maximum ranges to 3"?

> Inscrease maximum to 8 because freescale ls1028 and iMX95 use more than
> 3 ranges.

s/Inscrease/Increase/

> Fix below CHECK_DTBS warning.
> arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb: pcie@1f0000000: ranges: [[2181038080, 1, 4160749568, 1, 4160749568, 0, 1441792], [3254779904, 1, 4162191360, 1, 4162191360, 0, 458752], [2181038080, 1, 4162650112, 1, 4162650112, 0, 131072], [3254779904, 1, 4162781184, 1, 4162781184, 0, 131072], [2181038080, 1, 4162912256, 1, 4162912256, 0, 131072], [3254779904, 1, 4163043328, 1, 4163043328, 0, 131072], [2181038080, 1, 4227858432, 1, 4227858432, 0, 4194304]] is too long
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/host-generic-pci.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
> index 3484e0b4b412e..506eed7f6c63d 100644
> --- a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
> +++ b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
> @@ -103,7 +103,7 @@ properties:
>        definition of non-prefetchable memory. One or both of prefetchable Memory
>        and IO Space may also be provided.
>      minItems: 1
> -    maxItems: 3
> +    maxItems: 8
>  
>    dma-coherent: true
>    iommu-map: true
> -- 
> 2.34.1
> 

