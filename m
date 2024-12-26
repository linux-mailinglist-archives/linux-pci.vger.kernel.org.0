Return-Path: <linux-pci+bounces-19048-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FF49FC6FF
	for <lists+linux-pci@lfdr.de>; Thu, 26 Dec 2024 01:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79D0E1628AB
	for <lists+linux-pci@lfdr.de>; Thu, 26 Dec 2024 00:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D370D2F5E;
	Thu, 26 Dec 2024 00:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Ae7hN19M"
X-Original-To: linux-pci@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172B7139E;
	Thu, 26 Dec 2024 00:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735173624; cv=none; b=L0gwfsFz0YQZHqOaXW2veYoyBNUNQEC05wRkigw9CxyjyVTXwELYYZGUn4futxHUypsVqXXcHE/bsAqRpszl3kdztydEseYZVaQnLz7Cwaf1Kvo9rQMtwF2kv1G/xT1dyt4yXAYTGDa3/B96mtAIoLgGeSp66dlpT7pSfls5R0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735173624; c=relaxed/simple;
	bh=AzDxw0Pt0r18i3mHjlJExSa+J4GJabojNRlJk6/AEak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YUf8y6w3/0KpYsAnBYqGMBclVlCVgM8yhEtADMTvlmqtxvEj6Gs+a6A55E1Zl4gkIMPveRzKeUYeZsbNPFNV0LnamTw9LsWjnr0pgt/GWjSytDHrE42oEjxWyVbR/BOI2bSSFPrU2m6QjVI0sWBxCfjfVLbb6L1NGqyn9vG7onc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Ae7hN19M; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=u5llZW6P5VgqZyIbwE1Z+fO4Sf3FHIOkUoaY/KJnbH0=; b=Ae7hN19MSfO6dTUXPovA5cYOZq
	9MIc8rqO6cHgeSvlIMy30s9SAN+gxmLlLc+poD6UgHXt4SnDx3YDBZJgIlPHoqhsyK2H4bb+U4Ktq
	gWnZ+Vq2tCZkeSX+skuFExbd0WQPMPJfSHVND/k/bE4AEj+Kmu5kt7D1J71ThUmSO6zbyrcupkqec
	m1hzzJdjCQlJABCweRe5k41N3Wuo2jpm0SWMYlb/3qjq3V++j0h0+S3trnpYYLDkyJtgeHj/hWOIp
	kFD/Jrlfe1gEz0UjaeiiJFS3BplOJWiI7Jm2NCpMkogQYG7ICVfNwFfDv9OA85EEWJhNmQZmpUKvt
	zIP729Pg==;
Received: from i53875a54.versanet.de ([83.135.90.84] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tQbvI-0004PD-Ex; Thu, 26 Dec 2024 01:40:20 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org,
 Kever Yang <kever.yang@rock-chips.com>, Simon Xue <xxm@rock-chips.com>,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Krzysztof =?utf-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 devicetree@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Subject:
 Re: [PATCH v2 01/17] dt-bindings: PCI: dwc: rockchip: Add rk3562 support
Date: Thu, 26 Dec 2024 01:40:19 +0100
Message-ID: <3522017.aeNJFYEL58@phil>
In-Reply-To: <20241224094920.3821861-2-kever.yang@rock-chips.com>
References:
 <20241224094920.3821861-1-kever.yang@rock-chips.com>
 <20241224094920.3821861-2-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 24. Dezember 2024, 10:49:04 CET schrieb Kever Yang:
> rk3562 is using the same controller as rk3568.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
> 
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> index 9a464731fa4a..dce6d68865c7 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> @@ -26,6 +26,7 @@ properties:
>        - const: rockchip,rk3568-pcie
>        - items:
>            - enum:
> +              - rockchip,rk3562-pcie
>                - rockchip,rk3576-pcie
>                - rockchip,rk3588-pcie
>            - const: rockchip,rk3568-pcie
> 





