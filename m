Return-Path: <linux-pci+bounces-9784-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAA2927199
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 10:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84547B21297
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 08:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA7E1A3BAE;
	Thu,  4 Jul 2024 08:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="wQzwXGsY"
X-Original-To: linux-pci@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6111A0AE1;
	Thu,  4 Jul 2024 08:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720081427; cv=none; b=SmAeQoLFuBdchyLeF5nVIyb9Q2S+xk2SEmqHY7yc+TZ8ftT11m6ssyx/pXwq6ZyAOfT4B2swM4C2537WikHCGMpjVn7F0n/5OtYPQLqgotf8FBKspg9dtu7eHcsmje+NHKLqeORKYEVDt9jj4OPugink8ozEomhZdbhnWG1tqdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720081427; c=relaxed/simple;
	bh=esn5rcvEb3vNv/CngWyv8T7Sc4+TxLPVDrRzXw12GD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nWopjjE1owD4MokM24rAzy6J64z6naeZOPhylRoHMk2gXREnEpQizLe7VezkTkvlZ/BLvS0KDxJCWllOPBI5mC3uWA7+Y51pSAlem2hXeYD1XOwCPSbTRv5n0CeSCxAqkUtgYtZHtNAG3QZLC+hZ1AMV0oH1Q/gai18HIGNaE78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=wQzwXGsY; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720081423;
	bh=esn5rcvEb3vNv/CngWyv8T7Sc4+TxLPVDrRzXw12GD0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=wQzwXGsYKsDAeR+5zdRKqJFfOZ1j08lGsYYbpNc4+PmBucADurA1et4EaDLqcHCW8
	 gyk8yAf5nNYyj2DVvcb447GCIdesTFC1kp0Lan59RGR+fHV026WFK375cPaPzN67mx
	 P0jFACM+wiwsiK+OG8/RZax1r0xlsZ4Igv0syUPS6x6rQBjDhmV3IgfdzVy/b+yE6U
	 mSBUy/1LnGArEh9m3rQ3WsUP/1/10bR31lwgxS+3gho/e43/u70YOKWzp/zH3w3swQ
	 iaftYYJYzpvt1p0l6xR7A6uTTHeKM5BRQWqmv9/aM7rNDBRa7u9axQtKITfIV7h9+P
	 fCGpLiIDLgE1w==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A9445378216A;
	Thu,  4 Jul 2024 08:23:42 +0000 (UTC)
Message-ID: <90342fc9-19ed-4976-8125-f8fccc8d4970@collabora.com>
Date: Thu, 4 Jul 2024 10:23:42 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] dt-bindings: PCI: mediatek-gen3: add support for
 Airoha EN7581
To: Lorenzo Bianconi <lorenzo@kernel.org>, linux-pci@vger.kernel.org
Cc: ryder.lee@mediatek.com, jianjun.wang@mediatek.com, lpieralisi@kernel.org,
 kw@linux.com, robh@kernel.org, bhelgaas@google.com,
 linux-mediatek@lists.infradead.org, lorenzo.bianconi83@gmail.com,
 linux-arm-kernel@lists.infradead.org, krzysztof.kozlowski+dt@linaro.org,
 devicetree@vger.kernel.org, nbd@nbd.name, dd@embedd.com, upstream@airoha.com
References: <cover.1720022580.git.lorenzo@kernel.org>
 <138d65a140c3dcf2a6aefecc33ba6ba3ca300a23.1720022580.git.lorenzo@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <138d65a140c3dcf2a6aefecc33ba6ba3ca300a23.1720022580.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 03/07/24 18:12, Lorenzo Bianconi ha scritto:
> Introduce Airoha EN7581 entry in mediatek-gen3 PCIe controller binding
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


