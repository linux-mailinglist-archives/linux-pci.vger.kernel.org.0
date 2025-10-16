Return-Path: <linux-pci+bounces-38346-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F15BE314F
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 13:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 420BF1A63984
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 11:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B3331D74C;
	Thu, 16 Oct 2025 11:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jYTunffu"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B555D31D732;
	Thu, 16 Oct 2025 11:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614176; cv=none; b=toOEII9SlRv2yjeUBFzT04rnq2PH5+RrfiJbQxLrIYep0LKUXWlPYvEprwJsA7IYzKA79shrBZVZ0pDBKxS1Tgi1Ph+HyttPo/gua06ICMeJctWgRUyLUUUA0xrolp/BPnbvUaOnZs9gGhcPhyZDglqsvTh5nnFC8DM4ukDCXQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614176; c=relaxed/simple;
	bh=6X8f+TKvlFE7+7iIebOd6vOulDFaK7Hq5QdhSQt2pOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PtJmp6wXYnmeGanZDl5Qra4oXm52Q/WePEK81WleuoA/r++FP6tqqyAGnOJi7sb9mz1Vq7JHwRDOKWTIZQTFW3Ueso/ue6aETLhHRSgCqAYNBrffHZfHeza5sOg/lm/kApQLyxBXBsl9EDm23QoheI2ql97rtDTNokbohYV610E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jYTunffu; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760614173;
	bh=6X8f+TKvlFE7+7iIebOd6vOulDFaK7Hq5QdhSQt2pOk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jYTunffuBN8ebxn+J0J1kc1YN1sbssCSZYgjcGOrNO2n1UMVW6LfsKWkyyq0RAUrB
	 GLJG4OrIr0Sfcy+LmV8GJUk+PcEFSp6AampSQ6c+uHyH+elNjyePFNXn+Mm7b5AcAN
	 wbVAiuGYfqYf5GRwhTm50x8bOtwU9u2SmHglYu+GhS/FvCvcs8w52zzO/kmqiYjQWQ
	 bv+YPb7X7S8N40trUe/UrYbdaoXnYgx0qcGCa4bMI7nKyahcDO5gXlLousMhu/oYIl
	 OWhJyIBRJSz948YcvSasAukvogji8BA5b5tGCcq0T02oOZYVIyNy1r5QStgmaeMuFt
	 htkyu7PlpsOwA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C413D17E3673;
	Thu, 16 Oct 2025 13:29:31 +0200 (CEST)
Message-ID: <ce2edd72-f9fe-4c27-b873-f06dc28e348b@collabora.com>
Date: Thu, 16 Oct 2025 13:29:31 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] dt-bindings: mfd: syscon: Add mt7981-topmisc
To: Sjoerd Simons <sjoerd@collabora.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang
 <jianjun.wang@mediatek.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Lee Jones <lee@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-phy@lists.infradead.org, netdev@vger.kernel.org,
 Daniel Golle <daniel@makrotopia.org>, Bryan Hinton <bryan@bryanhinton.com>
References: <20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com>
 <20251016-openwrt-one-network-v1-4-de259719b6f2@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251016-openwrt-one-network-v1-4-de259719b6f2@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/10/25 12:08, Sjoerd Simons ha scritto:
> This hardware block amongst other things includes a multiplexer for a
> high-speed Combo-Phy. This binding allows exposing the multiplexer
> 
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



