Return-Path: <linux-pci+bounces-36843-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E9CB98F10
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 10:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C26C73B715E
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 08:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F276283FE9;
	Wed, 24 Sep 2025 08:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BoycKNLx"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AA6289E0B;
	Wed, 24 Sep 2025 08:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758703259; cv=none; b=PBA++Dgi5sZwPKkdvlKXJ+yx2a6goW14Ijgy2e/mXpcofLD+WnlgJufH2wpQV3tawiB7cammw65lE3Pkd6TxH3xm6SOetDYD5XcbCGzknr+srEGG/rBF+I9j/hXu8UwfJ5CsE4DAlVzMLzJdksUJUNFcElyXef1AgYgjImX54so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758703259; c=relaxed/simple;
	bh=gXC0TIrjtt2H2hnirLrmLxXWil8GQdYIzvmwDbexWv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U2Rv5ssqu+/wekkh0q0WNkoObJd4ZTz86bGoOJet8RZM2olGiY8yg9B9BHJP1lHDJidMSuf55Bz0/OmcZACSz0oKYUt9D0GbCAfnSAoObQK78sB21DMbJkLNQdYeXTfhbwUZuE1Zp0HVSJ8Op2qd8ZMIk3DuUBuq6ufx+IzmjEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BoycKNLx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758703255;
	bh=gXC0TIrjtt2H2hnirLrmLxXWil8GQdYIzvmwDbexWv4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=BoycKNLxBpKS7o7K2G6u08bk0AR1/6FDaoLq4ouUHT8QbBwgx4d26LmjoT/bO82g0
	 1Rch6X9SMSIdwBFJKcI2pBeuWgqhXojAyS5e6e0Evon/rc4tB07sIfIxp8IAo1FXs6
	 H2aQVi/TMEbFnx+Lkb9jsFKCngH4iEUNFV5Rr/DlJKGoRBGyYe45j6IjcX6ieC3W1M
	 0kNgKzPTkqpuNiEIHERnXlPLBNI/0uczTtIxRM4iDytO0urEBQe71zqlUSBDCgIRdE
	 pWpQtV46syHtpRg5o43gP2l37ISIhLYQOMeT/m/IKXuXefmJqYdQ1KfXY71hY+qlbN
	 AQsLsPZAepXTg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 14BD517E0237;
	Wed, 24 Sep 2025 10:40:55 +0200 (CEST)
Message-ID: <d2b9fae6-eb73-4484-9048-67c0c8507171@collabora.com>
Date: Wed, 24 Sep 2025 10:40:54 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI: mediatek-gen3: add support for Airoha AN7583
 SoC
To: Christian Marangi <ansuelsmth@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang
 <jianjun.wang@mediatek.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, upstream@airoha.com
References: <20250923190711.23304-1-ansuelsmth@gmail.com>
 <20250923190711.23304-2-ansuelsmth@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250923190711.23304-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/09/25 21:07, Christian Marangi ha scritto:
> Add support for Airoha AN7583 SoC that implement the same logic of
> Airoha EN7581 with the only difference that only 1 PCIe line is
> supported (for GEN3).
> 
> A dedicated compatible is defined with the pdata struct with the 1 reset
> line.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



