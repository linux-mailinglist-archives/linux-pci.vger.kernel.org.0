Return-Path: <linux-pci+bounces-38731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC38BF0CEB
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 13:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8939B3B1F4A
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 11:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEF8264617;
	Mon, 20 Oct 2025 11:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="K3QH8yK4"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5965E16A956;
	Mon, 20 Oct 2025 11:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760959431; cv=none; b=qgLunWMpXcEchItShSj/0pvIFWCIj0yhvExT+2V6e693DgEtS4sQXVwcFT2U3Ktml6tfa8EzuucUHSJeC/iPt8lxiSH/qxxlGE6WAbWpvxNFjdwsNpQOrwPIjDYXliE4CfCF7wx2ISPU85l9qzS772pE+9tXwoMECnvVLVqGVxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760959431; c=relaxed/simple;
	bh=w6wBWLki2XIvs2oBWydKFD3OGmGR/riqqF+ZppMwnEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dKeDbJas7okydpqT+3GyoQ8AMKlBVgpYvEDMb6pyd6KFycSXyfPOcS98/ZJx9OqIAxfa6WpdGPOM5HMZEzR6akTJ6Of9ia6mGOrrM4K6Wr6LuXZtEC4I4BJMpbNmnkB9dX709/mzz8x4PDdeCRosLQQTvCRmXOKBKmEKnsQcpWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=K3QH8yK4; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760959427;
	bh=w6wBWLki2XIvs2oBWydKFD3OGmGR/riqqF+ZppMwnEk=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=K3QH8yK4CEEZ/MSEEGQHJwb6X87Nc/goxw1hXt14U7wNfwqwIdy7XX3iZQzRE7DiY
	 BH0OxR6/vzSx29X+lGcqkvNblqc4+jJlBPNzPKafTI3MDq+JrmvH7facRLWOqC04OM
	 RvC/jJmVhrIQP9sNW0/R7TEm2GeWyzymO30QZWcE5tGcGflV+qbMI52t2PEX9KGSRG
	 uJDRdCqlmcRRzf58j0lQLSx+rnkcF+X91DSYmNYb3zfeUeODZHKi+5wsqwj1sRYmEL
	 l5L7yE7RXL1xlROPvyLkikA+W8dwkmr0KeCRw+QxGfyMSxYkouciCPHibtHkmJ00Ws
	 AfncBTEzkDMfw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8802A17E04DA;
	Mon, 20 Oct 2025 13:23:46 +0200 (CEST)
Message-ID: <98f8d06a-b470-42ca-880f-e0007abb28dc@collabora.com>
Date: Mon, 20 Oct 2025 13:23:46 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] PCI: mediatek: Add support for Airoha AN7583 SoC
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
 <20251020111121.31779-6-ansuelsmth@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251020111121.31779-6-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/10/25 13:11, Christian Marangi ha scritto:
> Add support for the second PCIe Root Complex present on Airoha AN7583
> SoC.
> 
> This is based on the Mediatek Gen1/2 PCIe driver and similar to Gen3
> also require workaround for the reset signals.
> 
> Introduce a new quirk to skip having to reset signals and also introduce
> some additional logic to configure the PBUS registers required for
> Airoha SoC.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



