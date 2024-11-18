Return-Path: <linux-pci+bounces-17022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CB59D09C6
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 07:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE60CB21A88
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 06:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65874689;
	Mon, 18 Nov 2024 06:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YsX5+12M"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60B213E02A;
	Mon, 18 Nov 2024 06:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731912547; cv=none; b=AUQfA2ttdUg77rKkocT6/9dg1qJwdQ3Yo0S+7mtWVNsRf3qfcPEIwaD/uyEBLMJY9uOnzRxOR9FGPdZ9DAVcOkPl3jCxR6jPDjn3CwkODThilYSf+YbYeU+x+SluqduEtLO38+q87ua5JMR6bqlg314utRohdd2aXqQiKEwEIGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731912547; c=relaxed/simple;
	bh=5f3+0N5E+t/8bl6EgkA4h6pAYo4sfXjYtUc+GcRng1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jfGM6mTO7tqPhS4FzB3L4+dir9YzUeqdTvG52gqeQyzMkOQJxHmEuF5dzFJExmTbI6OwqAtiIt5Dcs/0+lVnJfb35vW1HzCDKq/vmuB1QZ/NzBuySqy4T4awCBkVkVl4Mg3V5dx5QIAzdv9pIRmrXmPw41MHSPOb3agnN9oKppk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YsX5+12M; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1731912544;
	bh=5f3+0N5E+t/8bl6EgkA4h6pAYo4sfXjYtUc+GcRng1c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YsX5+12M8t2YkPPLP2hKDGbJ9/svYkafagAIYe+LMmnbciqvJ7cK5jAc+J81QxsZr
	 PYDGiVIzHGGBr74L6QFR+cLf5nBqZdJkFNvUQz3ThlKrUle/T4+TJ7ozyEbPSCNsYC
	 E0kLDM30e4QQpkOXibqG6VWPGZLx8H1+lX2nNAHaO6YQX3s2um15Dkg8vRD4rdnl9W
	 O9tFKC2IK3fp8mOla7mD8EJYh9KYO+0YJoSMIHDqrRzkZipXOPVI/L26KSqFdEJC3Y
	 7T6SFY4efhs8dm2gAxjjmpLU9hjV2eHQ58P0QrvOAscedQG2wpAGqV2b6dHQGn3Qjt
	 Krk8fiOcI1fHw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B68C317E1247;
	Mon, 18 Nov 2024 07:49:03 +0100 (CET)
Message-ID: <3c6e250e-8c53-4f2a-a902-0350bca47b8e@collabora.com>
Date: Mon, 18 Nov 2024 07:49:03 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] PCI: mediatek-gen3: rely on
 clk_bulk_prepare_enable() in mtk_pcie_en7581_power_up()
To: Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee
 <ryder.lee@mediatek.com>, Jianjun Wang <jianjun.wang@mediatek.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
References: <20241116-pcie-en7581-fixes-v3-0-f7add3afc27e@kernel.org>
 <20241116-pcie-en7581-fixes-v3-2-f7add3afc27e@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241116-pcie-en7581-fixes-v3-2-f7add3afc27e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/11/24 09:18, Lorenzo Bianconi ha scritto:
> Replace clk_bulk_prepare() and clk_bulk_enable() with
> clk_bulk_prepare_enable() in mtk_pcie_en7581_power_up() routine.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



