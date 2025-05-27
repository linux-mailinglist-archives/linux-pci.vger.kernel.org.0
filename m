Return-Path: <linux-pci+bounces-28475-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF779AC5ADB
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 21:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D37C3BC5CE
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 19:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF0828A1CF;
	Tue, 27 May 2025 19:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpVL6ZsQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9752494D8;
	Tue, 27 May 2025 19:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748374587; cv=none; b=Gm9GwBJe2RfOgiiK5vYpxsv3as+q/kDesEgkXc8mxK0VuAN3Zxp6+6wgW+6xiZA2RJAjBeDTLg8FDmOXGskUcQ+2C2nVYVAjHkVJW8IJ076Gty82EhThxQmDx9hG+ZAOAcshq/13IsByKnZDdniYPsiehX4B2lS/WIDtGU91i/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748374587; c=relaxed/simple;
	bh=K7DhF+cgr7QSuqJfpbPflo3ff+oOa+1XtFxnJVMoXIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmzSNgVJwOM63HQKiwyT1DNsLF/LT1jMCxa6FwOV3xDGA86Vq+5hKGReN/E8joHy4YU5qmcNWI4niVArYvpYDjABdN6zK4CcHZcGHzPvsxhHuHbBPheFQg1eftVe9e7jKbRVzisRBA+OCCFulwUAcS4YGzHgPDetDwmSIuqeAtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpVL6ZsQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9901C4CEE9;
	Tue, 27 May 2025 19:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748374586;
	bh=K7DhF+cgr7QSuqJfpbPflo3ff+oOa+1XtFxnJVMoXIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YpVL6ZsQaIBbdH7ezady5e1W6NIOBhqdbekqAAxG47r0xlGN4CoFAWQ68cRbp46nz
	 9DCGxRqgbWohMM8QZEdxfqGrWqF8pnohFMs/hFdEhDtlc4aNR/9c2sEcIstonvhn30
	 5Wa9dFoc81OxmW4/xY+ZYmStpJtPXDOySqt1cbxO7nqIAkt7ZwiYm5oim6ell1i/de
	 f8SbL7+mJjJLWrYsETxaLfJiwfYCCHUkmUnRRscRPTwDxPO8ZQpTIS4Eeu3mx4ya8t
	 DkWtToypVXYYDYoOM4hlZNgW25SI/v0pQbVtBhY0APWkXDqRGa3l7NfcCBQm+97net
	 TF5Iq/1FyxpBg==
Date: Tue, 27 May 2025 14:36:25 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: kw@linux.com, krzk+dt@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, lpieralisi@kernel.org,
	bhelgaas@google.com, manivannan.sadhasivam@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: PCI: pci-ep: Extend max-link-speed to
 PCIe Gen5/Gen6
Message-ID: <174837457636.1106584.5849030626221512750.robh@kernel.org>
References: <20250519160448.209461-1-18255117159@163.com>
 <20250519160448.209461-3-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519160448.209461-3-18255117159@163.com>


On Tue, 20 May 2025 00:04:47 +0800, Hans Zhang wrote:
> Update the PCI Endpoint (EP) device tree binding documentation to
> include PCIe Gen5 and Gen6 support for the `max-link-speed` property.
> Similar to the Host Controller binding, the original EP binding
> limited this value to 1~4 (Gen1~Gen4). With current SOCs requiring
> Gen5/Gen6 support (e.g., Synopsys/Cadence IP), this change aligns
> the EP binding with the kernel's PCIe 6.0 capabilities.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  Documentation/devicetree/bindings/pci/pci-ep.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


