Return-Path: <linux-pci+bounces-17737-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D145E9E53F7
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 12:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CAC82822D9
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 11:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C7F1F131A;
	Thu,  5 Dec 2024 11:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="YvjMYEIV"
X-Original-To: linux-pci@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AE780BF8;
	Thu,  5 Dec 2024 11:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733398248; cv=none; b=il6bVVf1wwEbaFlwGrXoZtPLRJSvyB8hXXaLZfhxD7LtF4hKyeieG2dyiEb6kSAeq+WqRJhCbMfGl+kbmsYvltfY2HUnGsDPo9WJOOCPk7hGYEYQw5Eq4cpi/O1gKqbdIwDQvYwuu7NfjhP+RVWL3Pjb5PDBzHcJqSKHRUUbPEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733398248; c=relaxed/simple;
	bh=oVVdmh+elcjiFD4mVpLgMvfvNcG39ola2Ka1hHc3iUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s3fXZl30yKDvKsfMH69zgE2GCItcBWuh6QAN9qR9LciW9kHkfnHiE1bAMoahGu7Gkxvdexnty8jFqFPmmt6dxbXtA37DPR/of610yemX6VLPu1wSzsOx/9nU3RJUKsBnu4ekAPp4K6WQh2MDiMCm8vVAB2+pCO/SYeERWvT7H3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=YvjMYEIV; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bdsA3tpj1205+oRa1MPd5D6szg1T6A4Ap44HnR6cFe8=; b=YvjMYEIV2blJiDgrBxOgD4Jz3k
	zotERM0QMsg0WxDERATtIRFTnz6V/DSFyBCY62tXU7KnpVVcZRXYq2H1ZJ7xPk5koG5NAEhNpihrd
	AsS9tEoDCZ3SXywxaGVM1+E10xiGr6Nfv4lj+yQArNzHXEmpgLaCzafoaqb6gzpmx6xnxa23xL95S
	XXKEyK9UVkz2Xp3Ukc5/KMJbOz7Nf6Oi+AHr1PjMr/ELH5IC2OsVbD0mr4oJY2CtjTrlDC0+spCiz
	2RJR4yxBzTljLn5u2LlUc5iauommu0tIWMUCgIU7tnCnCEQ97/BcjA0G3LC/X8+pcp5mluFEqSJYd
	aju7IggA==;
Received: from i5e86190f.versanet.de ([94.134.25.15] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tJA44-0003Zj-Lv; Thu, 05 Dec 2024 12:30:36 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org,
 Kever Yang <kever.yang@rock-chips.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Krzysztof =?utf-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
 Simon Xue <xxm@rock-chips.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: PCI: dwc: rockchip: Add rk3576 support
Date: Thu, 05 Dec 2024 12:30:35 +0100
Message-ID: <49528886.MN2xkq1pzW@diego>
In-Reply-To: <20241205103623.878181-2-kever.yang@rock-chips.com>
References:
 <20241205103623.878181-1-kever.yang@rock-chips.com>
 <20241205103623.878181-2-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 5. Dezember 2024, 11:36:18 CET schrieb Kever Yang:
> rk3576 is using the same controller as rk3568.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
> 
>  Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> index 550d8a684af3..5328ccad7130 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> @@ -26,6 +26,7 @@ properties:
>        - const: rockchip,rk3568-pcie
>        - items:
>            - enum:
> +              - rockchip,rk3576-pcie
>                - rockchip,rk3588-pcie
>            - const: rockchip,rk3568-pcie
>  
> 





