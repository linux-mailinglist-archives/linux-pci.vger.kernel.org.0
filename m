Return-Path: <linux-pci+bounces-14588-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BDF99FAA1
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 23:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6391F2282C
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 21:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1803621E3C8;
	Tue, 15 Oct 2024 21:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psqEJMF+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33E921E3BF;
	Tue, 15 Oct 2024 21:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729029380; cv=none; b=gNTuTt03DiIrznNFeAT0FMtDqr9vDXoqanurWfSiQ3GSyduJ7KWOZNBzXuw3jojHNA+W++wrPFqoE6VyGYM4S35jMRtyE/uvi/RBIoAqhtrHh2AsU0Ffr9orj6nBmg8GHp1u9IrHy+d7Llhp+b4Ti6HUZmXhE6o5+3gn9Dzlayw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729029380; c=relaxed/simple;
	bh=FEqerJBuQ58gg8O693l9lf/6FSUknQEcXmuLQP0+nbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gb5Gzl+v+mCJCKJHa7ZZS4amxdIPrzKnZyDc0c767Sprjist9RfS9tx+MYHvpvwazUA9wpkNKD1F5Tbhb6RAss7yWUFZ/hFbX9A5aMcAH2iXt5iZ+C3uBK+z+eFqC+FM1XhwOQDsU2UFfqPIdDJWbkDjmDeGjw4NXLJHzmsl2z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psqEJMF+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E157C4CEC6;
	Tue, 15 Oct 2024 21:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729029379;
	bh=FEqerJBuQ58gg8O693l9lf/6FSUknQEcXmuLQP0+nbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=psqEJMF+ByIlDNMNGy+4xfUymKgJSCwWV8Y324pbWj1xeZ0HwjPP7Zj4vamk1z6X6
	 C4kcxXiVfspAvha8eVgxh5zi5LpFgHOuH1u3c72WsF4yHc3kkvDecD8zzb4N92eJER
	 7JxlA+bWyo81Ol2M2NVwdnod7KV+L2S4S9RN++FZRyB7jkr1iebhztDZmTxarLjzCc
	 K7mmpvQFh0kLFfzZQTj0N/QzIsjowPpNQzeH1+exZAK7OhZdMW9vqQ+2ftRbATRBCc
	 morkRV/n3KjTvRZZWnBgRnL1n01Od4gcS8/7O3Vuy6riWkqS6YQdJQVuB2qRbUdJdx
	 GGUthdkUuoMkQ==
Date: Tue, 15 Oct 2024 16:56:18 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: imx@lists.linux.dev, edumazet@google.com, Frank.Li@nxp.com,
	conor+dt@kernel.org, kuba@kernel.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, claudiu.manoil@nxp.com,
	christophe.leroy@csgroup.eu, xiaoning.wang@nxp.com,
	krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
	vladimir.oltean@nxp.com, davem@davemloft.net, horms@kernel.org,
	netdev@vger.kernel.org, linux@armlinux.org.uk,
	devicetree@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v2 net-next 01/13] dt-bindings: net: add compatible
 string for i.MX95 EMDIO
Message-ID: <172902935285.2022343.10056149639875783222.robh@kernel.org>
References: <20241015125841.1075560-1-wei.fang@nxp.com>
 <20241015125841.1075560-2-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015125841.1075560-2-wei.fang@nxp.com>


On Tue, 15 Oct 2024 20:58:29 +0800, Wei Fang wrote:
> The EMDIO of i.MX95 has been upgraded to revision 4.1, and the vendor
> ID and device ID have also changed, so add the new compatible strings
> for i.MX95 EMDIO.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> v2 changes: remove "nxp,netc-emdio" compatible string.
> ---
>  .../devicetree/bindings/net/fsl,enetc-mdio.yaml       | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


