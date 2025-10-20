Return-Path: <linux-pci+bounces-38732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4C7BF0CF6
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 13:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 864B54F32D1
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 11:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FE72F616C;
	Mon, 20 Oct 2025 11:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KsUyhwSr"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4156F260590;
	Mon, 20 Oct 2025 11:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760959432; cv=none; b=WRJmiDH/9fzuME45srPMEURruAKC7gYtz/WQ1WnIeod/8QZtqFcaUL1jPqwCkThyNHMEzM+LINLUQ8uGkWQY0+rSy0QG8BRldPoCqElpQKtPvccyCo2LaWA4ZU4HCoucXWGWKTxfBa3dSpUZZQxBVBGg+1oai3HkhEOWAZe/6oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760959432; c=relaxed/simple;
	bh=QOHxraMMUDUqY8P1wrbdeEWqc7uw2P8s5b/XHtGwd8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n2+55QJXrmWFnPBHM2NG+pU91NAZRq5L/cxRAo36zt2VdP+8lo6658VLePOv3l5qWNDgbiNS7s7V2ox4nGHDKnoENqCCIw0RbVA5iwRud/q+c00t3VZPaQpwsSGL4KT74PoG6mcZKF5P6oaASyt0z+cvPv/SKWTty6SSbGGeoKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KsUyhwSr; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760959428;
	bh=QOHxraMMUDUqY8P1wrbdeEWqc7uw2P8s5b/XHtGwd8w=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=KsUyhwSrBs2+uTcq53JLnq14VjXCk23QSbKX/UY6x2PTfp+a0K1yNJszUSeEU0f0Z
	 ocWiWKumJ92kT9oYpcEgkmtrxmCya+jD1OH3p0Z9OpWFUFcyOE03Rn6eeC4j7Ekefu
	 MNgCveLRuu3unT2HHUo5iuoqmbCwnuZaPA/mPE7YYrx7MpWggOIJWi1skRh2HoWGgY
	 0ry+/90alDjcDCd9iPL7LEg+HXaauKflRWaV24kE9BkUw8jZjPhsuWvhmpLSz9y3LR
	 ghOnjtYo8wk+8LeKuABUcZUwebm8bgcYEHAm/irD2kF5BROrhLYEPN7NT/CcX6HWfZ
	 fFm50HTx8Avdg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B483C17E0C54;
	Mon, 20 Oct 2025 13:23:47 +0200 (CEST)
Message-ID: <a1f62af5-b755-4fc6-a3d0-983dbf53dd30@collabora.com>
Date: Mon, 20 Oct 2025 13:23:46 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] PCI: mediatek: Use generic MACRO for TPVPERL delay
To: Christian Marangi <ansuelsmth@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang
 <jianjun.wang@mediatek.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 upstream@airoha.com
References: <20251020111121.31779-1-ansuelsmth@gmail.com>
 <20251020111121.31779-5-ansuelsmth@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251020111121.31779-5-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/10/25 13:11, Christian Marangi ha scritto:
> Use the generic PCIe MACRO for TPVPERL delay to wait for clock and power
> stabilization after PERST# Signal instead of the raw value of 100 ms.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


