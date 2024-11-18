Return-Path: <linux-pci+bounces-17023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D55C9D09C4
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 07:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4985E1F21D6A
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 06:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AEA14A09F;
	Mon, 18 Nov 2024 06:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FUlAA7eq"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B05714901B;
	Mon, 18 Nov 2024 06:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731912548; cv=none; b=n1V/ShwclmhLMXVqdbfB1UK/o25CE1FJbEYbxW/8XibexDPNizq1ddXv8WvRLH8ZPJlx+RWukaNQN2hqxmHXEw1M1HrKQccnsCZd8+9D56UHSdtcqRQagNyo2aq8qBpIjYyFFS6pA9M4fpyLGQwbHkO0xv3X5GZ4AEd1KNYnh5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731912548; c=relaxed/simple;
	bh=kwiYyBq946ppy7DeH0DRr1qHz4dCl8Tkb0n0W/MvIUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d8+gq1jUuMlpHzVaaJ+0kFG8Hd1y2GO4hpr2ffQOto5DgJb3NHA6XQrVk+wno/pUV1MhCHG+xtwUQlqTjBpKyGEUEM+EdfcUgwTV4LDxttyKV3R3H7s0Kr5e4/e1wbF37s/0VIodTidMv1l37REPLkbaAILwjHsGIXJ07P495IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FUlAA7eq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1731912545;
	bh=kwiYyBq946ppy7DeH0DRr1qHz4dCl8Tkb0n0W/MvIUs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FUlAA7eqM5cT1kjfn/sNiSVvKvM5eipu1mOf826vsD4IYsjHnPIAnlTrkNZQs8Ut4
	 SHbD3yZpZWDsazF8ATy7+c/J8o9paPXyvBZOKtIvzMx9Dqh2eik973yt59J6VPOQwx
	 PTivSo1T/fIHKVwxmBjhiMOiCZeQIW3QtO96sHTQIpNaRhoofOYE1u5Xu/u6q4GVK5
	 kaxgfww0diUZO0Llk18uNX18mAX5r8IJ9DNcwXB6niL6YLr2DYS62LH6bdTojSDNpB
	 537clpYQWpkruxopzItKVhWkIqNhGE/aJm9QrOSrsPxlqPwOyl+QPfr0Gc1WrRwhd2
	 HLwXMeCjqy76Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DC1DA17E124B;
	Mon, 18 Nov 2024 07:49:04 +0100 (CET)
Message-ID: <30da4271-f249-4e92-9d22-a4491b7c8618@collabora.com>
Date: Mon, 18 Nov 2024 07:49:04 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] PCI: mediatek-gen3: Add reset delay in
 mtk_pcie_en7581_power_up()
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
 <20241116-pcie-en7581-fixes-v3-5-f7add3afc27e@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241116-pcie-en7581-fixes-v3-5-f7add3afc27e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/11/24 09:18, Lorenzo Bianconi ha scritto:
> Airoha EN7581 has a hw bug asserting/releasing PCIE_PE_RSTB signal
> causing occasional PCIe link down issues. In order to overcome the
> problem, PCIe block is reset using REG_PCI_CONTROL (0x88) and
> REG_RESET_CONTROL (0x834) registers available in the clock module
> running clk_bulk_prepare_enable in mtk_pcie_en7581_power_up().
> In order to make the code more readable, move the wait for the time
> needed to complete the PCIe reset from en7581_pci_enable() to
> mtk_pcie_en7581_power_up().
> Reduce reset timeout from 250ms to PCIE_T_PVPERL_MS (100ms).
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


