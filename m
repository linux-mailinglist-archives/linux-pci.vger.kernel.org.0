Return-Path: <linux-pci+bounces-37188-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A328BBA8D66
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 12:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2C63C234A
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 10:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004EC2FAC0C;
	Mon, 29 Sep 2025 10:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iQa7GANJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E702A29E110;
	Mon, 29 Sep 2025 10:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759140742; cv=none; b=a+f9GP48JnpoPkwq+ja+kHoTpxAsAA8AL8qhuPJPZKqsBtRNkOwm2+pg2T1FaES2Ywz2Ra/fn7yRj2fCtcDSFAiCh35KDURzzvbo2dgMw2p00+Vp9zzNlwN/Dnnllp8OpjmaBPZx8Im1HPEIFMDEvxwOwnrcBs9T7uK1cgfX+4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759140742; c=relaxed/simple;
	bh=blyUVP/L7aV6tYV54t02hLhWyL0FwdsLZ5jlMROWX78=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bDlK3X7Rm7D7bpqOTq1g4z0yFsmd5og9vUFGs4aFSVNZRH9+LDjTWofLLE463OkHRuF66hlRHFeH3Lkr9Mq/niq1vvTCHktd+vEV7KIjDLNam2HJUHE5RrMibFb6INcsGY++k5mtchy8mdOLKvh5FutlebswTPBf1vBFVzRG54Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iQa7GANJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759140739;
	bh=blyUVP/L7aV6tYV54t02hLhWyL0FwdsLZ5jlMROWX78=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=iQa7GANJ7eWc7Lvjeez0qCr/Z0sZ0hmu5S/3ErjNfDYEqUGfuqajPhlFjxHQLNbEQ
	 o6V4aMv17COS0Vh0mIuUOrVrROD9Dgk6pJXF1wZPoQfUrgXeMfRPcU+/RZaf/bJUZV
	 UAQ3OOj/HUywAIk3OwvrZuXWdQosJ5djzFKVEWuB1uzLZ5CnG5isWP6D2RVYMvoGcZ
	 xAfIV4+TN5mHAIC+7acdhL4ou4O4IrWWyGdILsqfTNfG5VUymwmVNoTzz+cSu3jv1t
	 4LZm4jf+FPQ/eHR0bFHrBRMI0W/wK4Px0HaYAiktvxrD3CRouEO/qKJKBVijukqNAh
	 bZx0ATNJCRKaQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7C45C17E0125;
	Mon, 29 Sep 2025 12:12:18 +0200 (CEST)
Message-ID: <2ae6bf56-54d2-48c7-a6e9-d378d41f40df@collabora.com>
Date: Mon, 29 Sep 2025 12:12:18 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] PCI: mediatek: add support for Airoha AN7583 SoC
To: Christian Marangi <ansuelsmth@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang
 <jianjun.wang@mediatek.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-pci@vger.kernel.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 upstream@airoha.com
References: <20250925162332.9794-1-ansuelsmth@gmail.com>
 <20250925162332.9794-5-ansuelsmth@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250925162332.9794-5-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/09/25 18:23, Christian Marangi ha scritto:
> Add support for the second PCIe line present on Airoha AN7583 SoC.
> 
> This is based on the Mediatek Gen1/2 PCIe driver and similar to Gen3
> also require workaround for the reset signals.
> 
> Introduce a new bool to skip having to reset signals and also introduce
> some additional logic to configure the PBUS registers required for
> Airoha SoC.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



